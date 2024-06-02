Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525E7C25B76
	for <u-boot@archiver.kernel.org>; Sun,  2 Jun 2024 00:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED48880A5;
	Sun,  2 Jun 2024 02:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WhdnZm09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30405880F9; Sun,  2 Jun 2024 02:16:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F45988077
 for <U-Boot@lists.denx.de>; Sun,  2 Jun 2024 02:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717287402; x=1748823402;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Hw8msdlH8Y2qYoL0weBqEvJS2o6NgKKFamDDPj7+vwM=;
 b=WhdnZm09xFek7R4jEoTnqTZjxgGbwI8SXMNb3R9bTHWnZxY/urp5q3Nz
 uXFa6PZRqWnedGpzo5LqJWzLV+G7VZrYHJ/k+v494JIDO4tDN4oLDSVKH
 QCF3q81i8Ycx45zS4xG/pGs/KWQ+ABOHTTCsdXAilO+/dcAyBM6WSMPCl
 tRD+PglK9DK8hDpNmV1x7fshCHL5ZOa36nO9IRGjh/+qvKd85luKN+D1I
 Ft2N9S9Rj2ejLWEw446DBd+2sbUyasmVEAaE9OWq7Tk0IaSWAEuRNN5cA
 nzS9wvIc4c18+wAAUZ5davDais4DgwemhRA2uPLYn8IzYr81hgB9KZrXm Q==;
X-CSE-ConnectionGUID: F1kI6YtZSYyUjkMFRPGyWw==
X-CSE-MsgGUID: 69eKn+EkSSmoj9b/sLo1Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="13677226"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; d="scan'208";a="13677226"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2024 17:16:40 -0700
X-CSE-ConnectionGUID: 6SD4O9PdTWyJdcPmJ1Z5+A==
X-CSE-MsgGUID: ikFM7/RSTGin/rHjGWrB8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; d="scan'208";a="41599636"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Jun 2024 17:16:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 1 Jun 2024 17:16:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 1 Jun 2024 17:16:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 1 Jun 2024 17:16:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCOhSHjSZS6JvXR8XsXUP7iA6vwUhzODFo+PEaT7uXBUiESLV1UtOwvZlY9qdbdqyMyPbxa1QA5oHGnmSLYEgNkE/VniUNWdJSGryRqj/1Uov8CVjSQWeo+AFSwk9kV441Ark1JpVmlNoaeSVa+L0QnOqRuM2IVSMKCEu4dbgfUvTTIpjqNEsxtIYXqgJn1XAemKSP7xamv+U+gZXQ3sHDTyQEOrHgoHHhDGYgn3aE5SsS5MZeAcb/3nyfEl3WudW9nRoWKE7pDuCwuqrYBxKVNhd2Q+V5C8X2n1A/1ZNonr+CPnDcgdkSCDdVCJOBme7lfpb6W87nX6T9YBJnZl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hw8msdlH8Y2qYoL0weBqEvJS2o6NgKKFamDDPj7+vwM=;
 b=K4wxxcLltPAxaBKJjJucTyfLYmip8lKB+j+jNGphhozkSrlWn9wNdMGLYnaHLR7ag5eF0YXIYXnehzO5KDw2t1VtWOxT3oCGZYz/nHOXBCOVZUvM3MohAH3Hz66hJWHfEhvfIuo6OMDwYPq+ylHDcy8LjA+I2Md7dTKyKlhRsVhgxRZboW6KDDh3fH9UI+sDsMBxSJ5hpv3GnOKFnXr4aeX2hmhHqHuKShMiAtM3vfikZyvcpZDs/G4jzaTBNdLr7Jpweu8HL9BSFD4xBWdm/uEDZFWoE5+nLQXz3Ih1zuaIG/f5mYmUGFKem5VwNfKeiMFejLz7RNLuxB2neHmNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Sun, 2 Jun
 2024 00:16:38 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81%5]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 00:16:38 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: Jiaxun Yang <jiaxun.yang@flygoat.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0AAAJBKAAAAadUAAAv2KAADFJ5OAAGQbwwAAk4NdAAA1gcwAAEOFFiA=
Date: Sun, 2 Jun 2024 00:16:38 +0000
Message-ID: <DM4PR11MB5296624D138053E9457054B8E3FE2@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
 <20240527160708.GJ2568172@bill-the-cat>
 <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240531160258.GN3714513@bill-the-cat>
In-Reply-To: <20240531160258.GN3714513@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|PH7PR11MB6032:EE_
x-ms-office365-filtering-correlation-id: 2ad21d1f-f234-4194-d099-08dc8299451a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?d1COnLyRIC6uKo8DA71lq1Tad/GqEwhblvML4ugdQevMNaADAjPCZE+W+oI7?=
 =?us-ascii?Q?hGr6bBY0IBhDg+wO7+hKz5wZ3fwTFEJmq0aicRrbcGR3eFsxet6QJMmI2Ig8?=
 =?us-ascii?Q?xZ5m0iXFufxCFISIK5yZTSRpHUPfJyuQheNnmNrmBl7ELAdIlQq/+HiCpcDl?=
 =?us-ascii?Q?od7hcoGegtEx8lcTk5zvlrYQQzBye/G1gG98vuUlktn/SvqPCkICpzPdswq1?=
 =?us-ascii?Q?s/Gcx9xA6INSyR7mWvuKTmbDst4AqKwcsinTlkep0i6JmUWS7JlB20G9joJg?=
 =?us-ascii?Q?ObpP14E8buK00KA9bEZ74ssxRUY9D+quOZ23vsGKXmqHKVPjLAm3rzFBF0g+?=
 =?us-ascii?Q?HBAxwZN7rIggVc29ReLmSzy2Jmv2M0jypgE4sUdEXl7k4MZy7g9qboJ5UHrq?=
 =?us-ascii?Q?enGndzl72m1Xs3RjVabOwQkZi9SKeDZj42HGspGr9n1OViCn6+CRVYnR68/D?=
 =?us-ascii?Q?HZdZ1QjlMgtAUT7v0Yh1GQXqkNT6c4fmY6aPJdQsqtPmC3bmlI2bE/n7dZ8n?=
 =?us-ascii?Q?Cue+ogNfDEdRMvSzuTwRHx3jPnopEHACTda+JK8+PTyDmaL5hSbLfszY7SOg?=
 =?us-ascii?Q?pJ3RxPcLCH12bys6p3ytNBlhSqPMRrK/cNXPiC16k38MmWr0hpfdDPtxIUpF?=
 =?us-ascii?Q?20ydTL5C9+/jzFrfPNxfL0zGmGfIKrMv6bI+PAveCCCOminy7Mwy5ajOITxY?=
 =?us-ascii?Q?kX/vSA7CWKMklAxH8sfkdg2HWYLNE3vXA11GDbKH6wZDxXLhp0zJ17yIZQzb?=
 =?us-ascii?Q?Elt0xzQU88zPsKUUpcZN7avtDwXAlRtxDIyZWyRVO8e/t7uIHESc4t2T2oSr?=
 =?us-ascii?Q?1MUg1UHc7oA/PR9RqZHbGHgBAyfo9ulcTn5465XNu7W0G2A4uOteHlpq97Z6?=
 =?us-ascii?Q?DmTFZ8ETfQt6VrT8F4bNtMA5O0a9QB2fj3yfF9XGjwlIzRRoEwMdNzXOob9/?=
 =?us-ascii?Q?TrVEr6RQGRInWQrV6G4qCKIdQ07kt4h4b7IJcKxgwqQyJOxrm50iXUa4GVq4?=
 =?us-ascii?Q?t99TGNiIrXjynI3MWBQbijYRSgomXC8U6TV38m6oxT6II11LJ438bXzcqfnt?=
 =?us-ascii?Q?VY8YHsU45IEvw4fb8ozHb7JY4gGx+qEwB+RjWzEdmIcMVGAYq7X0LAD3apYM?=
 =?us-ascii?Q?PSweNzzHvErJLIdVhT2Y5zxLSVJ+bUUJ6O+BR9zSBlATYRv8ItmXEve1WH6+?=
 =?us-ascii?Q?vT0nYbEWbm2bs9lL3i+C/duLKRxxc8PdTetRvAxFwjMImvwKrTQ8/17RcYid?=
 =?us-ascii?Q?kTT/oPiJT0LUa5Q34h3Dum2NLy/BkbjqpvYHYkXhXfBb+7JRzYLvLyVdyqgU?=
 =?us-ascii?Q?kXbbGDaV+gwm5gxu9KU84wqO+iiW0edqQ/D8CYHuUz0xHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6AAh15oNvxxpB+6kOS0gk4Y/wxzJWBqrnbXt+43A523W5Bkc77CFZYq/9ZEU?=
 =?us-ascii?Q?wtP7EOrx0g8etAAR3p/ym62Tn70WmDxgtbPW+K5LwPQY+xriMM1EGePKEb0J?=
 =?us-ascii?Q?lFQSYZnIr7l6yKa8GQALW/qOe9aV4rLf5/4dalFin35GGgDxj8Rwr9gp94S3?=
 =?us-ascii?Q?Q4oswL9MtX1T7pMhL+Q8YYNLZQiND4jTsXP87CznhKW59j/gP+bAZlnveYEk?=
 =?us-ascii?Q?5T9dANP8GE5XalBKxF8Op5/qIQqs/L808M/yDhXxPm5mY9NWP23D2bdNj7ro?=
 =?us-ascii?Q?/Ah/foJmnpQsgxdmmEcxUq5OdM96/Z0Qa+YYLqxvcIIbP1cE5AzWdwCATG1j?=
 =?us-ascii?Q?pygcKQ6ljJ2poRoYB10eoHxqQaXk7uV1HZEMerh4tGa0FuB3XGaF/cMmfomt?=
 =?us-ascii?Q?3u9PlvQXoZcpGFTN8VrfhOB0pJhfo9vJ1Fdd8S37V2qcTevtPJDMe6oHyx8z?=
 =?us-ascii?Q?MrV6vlZks0Epz7O++iVaW35TwVy+8t7g3OwK4dHg7SuIL0Fcc3RWilDYT6pQ?=
 =?us-ascii?Q?s+tj/wawZmBdLGXguY0mc3/x9CQc7QUZP/lKyxqbdv8vu2tnI734RKz3+ffh?=
 =?us-ascii?Q?0ttjZ+/CL8QfCJNc12q2SoV9bHDmNEASLeIxIBHGzKkXVy4ndR+GHx4MS6Mu?=
 =?us-ascii?Q?m6E8+6u+XH5nayEgxcoqjJFxLQsa1I1xrsd5Ck2WnRWkzJ6vmPhuiT0Lucb2?=
 =?us-ascii?Q?ELB1mTX1TSBe6I7qt2iS9nmtiwqtf3Wvb4dX3kQefo0v8WULrdECMao7Uu0j?=
 =?us-ascii?Q?451XEyeLIG8K3igBEYz9cZGMJiLGWlZedC9XNCJJyZpxdoEp+qcnhXuD57EG?=
 =?us-ascii?Q?KKlFgeld+pLGyHjhIfvgkbvzshxLeCh3W7uwskvk27FegMMAh6qL5JYhnxx4?=
 =?us-ascii?Q?LJQmo9aMIwBFK7qjGrDq/sXSNu5oQEU9eLeIjuHUYdQ3Fg3foICYgPRpmfhX?=
 =?us-ascii?Q?WQtc5hQfiwZ1mkA3zI3H+nitNIFKl+E6fj6vFBhSr00jKxnAk13DiXYwvXuD?=
 =?us-ascii?Q?l+1eQOEg6uayHBIUuUhaBLQk/q+4U2A8YcNczTBxHrtazjscC92KUuF5mr02?=
 =?us-ascii?Q?yuSv7+E9rYOQSsykfNfXe0gSr7iWIpwXd+qHYERCgXkI75HVIAxLLoM85PNW?=
 =?us-ascii?Q?HjWGpayV/E7I8wEbtbWhvVOuDTbERNPQo4zHGA5PJwMKhVvwzrFwFwmq5Q7l?=
 =?us-ascii?Q?g35SL5e3hbQTC7sWTBbUIB+L3ZwnJVxXDdWsXT71vQ5RRQlxhOTyUCg/kBFn?=
 =?us-ascii?Q?HMlQibDak9N7rUITdEYGbpxpa1KHezGMRd23SERoq3YndMq8jBG6lP//Y1NP?=
 =?us-ascii?Q?uJIuRdQcb5lcpRl5jn8N5D3BBMWIJZlaM5bOKXNa+Hez9sZTwaFjjiAihk62?=
 =?us-ascii?Q?fe45dyGMfTIZujMt05xGzxo0a48QACzrm+Gk62WUNlv769QgTYwFq/Ot4QDF?=
 =?us-ascii?Q?ULxWqEH44dCt4+NVo8vnpk47bp+8/ANSK6QPt+QB40lkE7pOCmjgF28Lz6ml?=
 =?us-ascii?Q?snOG2dgivW3TOhgZzhX8179AT4vdQWKv/YfCEcyDZZRCfF4IGpZEE//nMF/H?=
 =?us-ascii?Q?rfrq0X1cxkQQIfKimYDup29e1l1S6pjdRfaZmN+L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad21d1f-f234-4194-d099-08dc8299451a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2024 00:16:38.0569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5jci5+ekY4Vhrbc2G+n3vyyAxc5i7cZVmBr2G0N0h/XV5e04g0tXdk05oT94+Q7D67uBROJpXkKss9djstRCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-OriginatorOrg: intel.com
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Thanks Tom.

Can you suggest who is the existing owner of this code I could work with?

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Friday, May 31, 2024 12:03 PM
To: Brunham, Kalen <kalen.brunham@intel.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.glpk=
@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists.denx=
.de
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0

On Thu, May 30, 2024 at 02:53:17PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> What are next steps on this change?
>=20
> I'm committed to the idea of EFI apps opposed to examples/standalone.
> EFI currently requires block devices which is not enabled when only using=
 flash.
>=20
> Should config BLK be updated to include DM_SPI_FLASH?
> Should we explore how to remove BLK as a dependency for EFI_LOADER?

Yes, someone needs to explore how to cleanly make BLK optional for EFI_LOAD=
ER.

--
Tom
