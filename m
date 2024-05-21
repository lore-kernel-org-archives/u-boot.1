Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEF1C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477DA887BE;
	Tue, 21 May 2024 18:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ns2FvI2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EA38835A; Tue, 21 May 2024 18:55:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F33C887FA7
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 18:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716310513; x=1747846513;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PF7tYfiFLkwjrU8Eh9VkGrtlR1cMUOjD6Cw7Sq2s32s=;
 b=ns2FvI2vGa/Tvi+YkXQrSBtnlOGaSYjhjnXtYdAoPkXYP+Cms3FqeNRK
 taztzcekG7n9topP422s05O+IupbEjh6uKVpUgHVExbhiq4aw0p0xziMH
 KdIgQBmSnBNoVspJg47u7pDjl/P9PvxR4d/beXEq9kU0GK+okVj4oIkBA
 yLbJtSonKb3Iy2FN3BQq0G5lH7D7ycvp3khl2NmfBxcxQkn/VWGgzn4uq
 fun+8IjTKMCS+a0KIPINfJxuMer3c5oz04P2/2+3sN8NkrXnQWr6f6KM/
 eH5yTbl2rrxy1aVRcSdA99Ct11ESzr9r34dH8NQXXx34ImC+S8e38tqBy w==;
X-CSE-ConnectionGUID: K0zNaev7ROSCqm220pPk8g==
X-CSE-MsgGUID: ExtLJZ8YRw+cxR/MK7sP6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="30045682"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="30045682"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 09:55:04 -0700
X-CSE-ConnectionGUID: C8+bi3JaT8ycOQLqzNstCw==
X-CSE-MsgGUID: eWanCvvRQsmyzRZDjt0dzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="37814410"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 May 2024 09:55:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 09:55:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 09:55:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 09:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiEjkA8ckeWEy9+CVeArHBYhErfdg01mI6Ov5COcDpaFnsWm91k8b8r6/MKQAKZ2ZO1yoZDEt9rAvapNohVUUFgdfLADAgWctWCUe4Va44RMHGMSn1DtwkzShrk72vCKiQ712r6MkhjHXr9opcy9cD3LX/E00mOrIbbqlSZOVJPPy6wxZejDm0jRy5NARXyhQrteOjHDOLVDs30b3Yl5KNEB/agSrf0KGH7mChayA5C+S6+eOHXTt793rorR2pNLW/RZeM5Ha62S12PaM7caDt380eOEK4pTlAznL8sYfBw/ZyH1PX9yOMVrxTuSoqSREE6KB/SFkBuzit+UDJ76BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF7tYfiFLkwjrU8Eh9VkGrtlR1cMUOjD6Cw7Sq2s32s=;
 b=ayoH8EFhRGEaUOqyNd8gjadAfVbLda0P+hacI4aw7rsxupxFnkTBBCQagysT2ZupwQl8Riev6HWhGM35hv8BVaAyaP1dl8iSlzPFTDVXABRv6yCucONXNhMWST7ZnxslAmYlZQsi0mMUibvmHqP58N1yjYxWYDiofD9KKa4CM5Fc1QCYQ/tJJqiWzoL1sp84saYJXfw8Q42JQQZc7VZt1jgGC6JT1SkmreRbXRG+lRLV/DK2SJ3bdPROlr961RQnuvCxlDgozRKdoCtOtAOLV5i5k0x0zw7B+NZgLBQVyfoPvyP28AEN69ukxmiH5OFb0yJ1K2WJDTdsbOtQY9iasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 16:54:58 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:54:58 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0AAAJBKAAAAadUA=
Date: Tue, 21 May 2024 16:54:58 +0000
Message-ID: <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
In-Reply-To: <20240521164659.GZ2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|BN9PR11MB5225:EE_
x-ms-office365-filtering-correlation-id: 340135d8-255f-4bc2-b5a0-08dc79b6bf86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?WKjYn1SmOFQb9246rlZ3azawBUsBW8tbEl1SnuOWqQherGTV+zpgc7COUnz7?=
 =?us-ascii?Q?EWX4MqyrX2F94guLI3FL6nE/wLwFLd18a9vAOZ7SXxvHbXGlDZjGHZuKLbJw?=
 =?us-ascii?Q?s/ov4vfjWpU2q50SH4qiZ3jc9biUOvhOIiYpIXhPWjBCu9Zv4B1JDULbM7V2?=
 =?us-ascii?Q?7ODQ+t/Nv1YzuAKPDiHdb9cn8kSCo2WQOJ+IvedC+1/6BCcCMi4Z/Gl9bnAs?=
 =?us-ascii?Q?lcRKlWe8E2B33D0Q9j7iiu6/3Y+ZKZFUO33wQZptwGHWfgQo4uWlq8vNv7Wc?=
 =?us-ascii?Q?1/XC5HSep4jnJkMxvXIDXcC5lkOAKjKwSPKOEtXg4a6eJYXnExs+I4tdkLq4?=
 =?us-ascii?Q?ZGDoAEuctBeQ155m0DqrH70Z8183Sb5LdYeOKB7PwfvRoqPrK7/pur4LjB73?=
 =?us-ascii?Q?GdNyvc/apAstmorIuAPyD3yr+7C76qYCDtgjzqSmURmwGVsBfLFLwfoNO0eC?=
 =?us-ascii?Q?u6iIB2qsMnFAzPCaEn2U1VbPLpK6yfESXc3glOTiai24t1vklhxlN6cSh0Ss?=
 =?us-ascii?Q?1YY9dNkmTOUCqOjjk1QX654KRWm2xkZxhVBh8FaNSRuC6xUdkAen3OYU1G1k?=
 =?us-ascii?Q?N7x1Rc9C3UY6hAnvclW9AwwYNlsLRxtNqWiYhJoZCpfhC0fpe+x+D+BdoOvv?=
 =?us-ascii?Q?rLeoGXOzu0VhvKklfDFufrCnZ2syJk1cXSqa9A9/IUm2hyK6yqkLneicSRFt?=
 =?us-ascii?Q?gVz96t5e+1r1Hc1i3KgicIEhJAkxYYLlJvThU4jrmGKnKTdbMaKtwtsAHP3X?=
 =?us-ascii?Q?yEI2XMM0lqmkWvAKaS5Ou2z9ZOhFOzoTQhPoYLL7e+4RL82aNPvZWQLAXwEF?=
 =?us-ascii?Q?HDBda4/nEAP6Mns6I70g5USA0Iip24M2m/t5DCfm+RMq8MTDffaTccayer6a?=
 =?us-ascii?Q?pYvDoNBMHgt732vm7Sn4H40A1+lwgnrd6HiCR/8+XiLfY7VURLnTrD3Rhxb3?=
 =?us-ascii?Q?lNabAtUo5fHxv55bzQ1yJ+x/1MLq3hhurBhTUtb4ve5KKo0HCJ8jH0gMtxD4?=
 =?us-ascii?Q?/kmmR4kduEMNE1V6hcGrJ0MrXJ0tKpz2LpyULWctzUlEPjBsho6Hz2kkV4O5?=
 =?us-ascii?Q?PB/SUAEoZmeWAByDDHMSBAdOktI30nUqy5eFxn52VxPGgqA369tlJRBp3W+H?=
 =?us-ascii?Q?0vN89j0uCBkWKgS8GpfhYaypD/e1sywsD4ioQvjxMDYsnZZnCImIWnqKnI20?=
 =?us-ascii?Q?FUNqf3vCQkLSgNsJefPoNruzpdT2jXlRiC6TtteUVYXZgh5Tel1UTjVZAyR7?=
 =?us-ascii?Q?j6c8P3OU/OXVNXBglBYqUH8K4EWRlr3MBenoH6hY1T2oS1Tq+HeofbFdQe7i?=
 =?us-ascii?Q?8E2WXjNS/kAzXaJmtRNCEE57HrafSbak/88oeHpLARdo0g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SHT/xiYRxin33d0+ITf7OjfvQlbKZ0odz0fDxmDJ/UUZ8dVaP/VYNBoeREo9?=
 =?us-ascii?Q?YHZzkk1mgJGtSRKujXGlPP3KGXHht2wKJ+FJr0O+45m527/P2U2Vum4XvqoX?=
 =?us-ascii?Q?uORI2aFppz1etiADiotCnkrtwKpcq6/be43EHBByrYOAkh/Nj6fAj4ALYlCy?=
 =?us-ascii?Q?HqlntLwnqdgSqM/crVOULdgkq3d0xxwVftp/8fsXA/b37uTG6XG3EFqSLbnr?=
 =?us-ascii?Q?DmF3qijKtkqT1gCf28E6xycZ9j/vVD1OpJeqS0iJRW7D8hv2dKCfxiGRYbcd?=
 =?us-ascii?Q?5GVYg3A6ObKTNFPjH75UJSjDGwjVeOKDH6LXvw8FrdxDOAztzUHxM6UNcNn0?=
 =?us-ascii?Q?9eITk7rfq3EeFEvrWHyX7Ayk3joxxKj462IG9Zx/4DgVQAr4IC2fwZqLSUyf?=
 =?us-ascii?Q?zXW5emVkq/86FUXKWze8Vw5Ewadle5XxUjgmBrzocneyRFeaqz87bCKq9yRm?=
 =?us-ascii?Q?DMY/Nm0Ty60c2Q7qu9fkQZBQG9TM/uXK1gAoTAJhexW0+/6suf2ttGNph6KW?=
 =?us-ascii?Q?HL1kzZhcRBvdTdHADf0hsaWeYQwsXX4Qn4UmXugGWVFIYgtkAe0rsKj1rJvU?=
 =?us-ascii?Q?omlAb5YpMBHSVTo7LBB0ubXduTQ9pB5PgytMtk6Snn6pzkGqZjeuaAykKfD1?=
 =?us-ascii?Q?JKqYaIIASbPSpRFpxfZiNUcgOydYGCvakwN0I0HXdjrt/n4DFtafUYNRbZgz?=
 =?us-ascii?Q?JiMNvzwa9WlZh71tWalO+cyn0xaLYDk8dkmHqX+ZF6T11g12iEYMDhBybB4/?=
 =?us-ascii?Q?HIGfoUYmYLzbbWI6zhHiZn9RkzLPo0fNiYhOTev9gZrWxq6fde7FinMjorZj?=
 =?us-ascii?Q?cX/xb5fgPaD4mP1R4c2un33uFcVWWCV14TiSPcN6nFncqGQFqSoPIGjCqsQo?=
 =?us-ascii?Q?knBoo19y3mKbqrgvClNZcEVjfUM0/r3Z7UXSI9RK2X50a5szXY+E60pjcuDg?=
 =?us-ascii?Q?URZ86x6Em8e320Ss7ZRcFbRHfF+6cl9Y8EhTgScmmgeuwM8O61IFGrJgd7u9?=
 =?us-ascii?Q?hYzOH2qKs9h6bWDxsk44PDvW2KmPBqu8w62fBtWfcNWwSeMZ2KIbLQvC+JPB?=
 =?us-ascii?Q?RycOSWkTpgMtMvQ0lX1dDKbIUgS/EwOhohDx60jkif9VHik7iERXFmoARxvX?=
 =?us-ascii?Q?C7nmpnOvvY1PBeOxnfF0A5fQ3gICH4nMlbABdqjdAiyO4NSw9ML2zfwfjuEK?=
 =?us-ascii?Q?xkUjUtYDELFf6yGiHMDBs39BdNZHh81CiNFn/pqlKg9dXgNEE/kif31Z3UW6?=
 =?us-ascii?Q?0sqE9kfiy+wOHL8MVs/x1yqeFMDkbiaK/kBibZ5V+yLK17KPhKGVeZcpR2FA?=
 =?us-ascii?Q?kFfx5Komko3+9+mIhkrr0NCyJfZwugxop71MFAzjirXTgvxRJtznsgpg/SF1?=
 =?us-ascii?Q?f+8GLTYkWi6ckyPVWgEs2+bN6cIaKMUSH2y2PFcY/Jcx1dxQX+hrllhi5YX5?=
 =?us-ascii?Q?zT3xwTidXbPHVutxS1ah17+XpRcRGOgSNxllKtm4I9EwM397x69fe0wUS07V?=
 =?us-ascii?Q?GbN0PzKCoVjRqIV/Cm/qSIlnfW6VyLzCBFtKpygFYxdykm6yq5oPuCAIUhDA?=
 =?us-ascii?Q?gXcINcBv/TB1t9/ppRb0Pu7MNjVFzOVNcFPY5cnP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340135d8-255f-4bc2-b5a0-08dc79b6bf86
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 16:54:58.3968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MHGcyinY/n72WuScP+HK0YH3DE/pJ9bixuzQnMvLJDC6kwUwn70B8yhplF+DG4lzyjjyiXpPQS9bTcGHOIPaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
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

Hi Tom,

Fundamentally I want to create standalone applications that can be used to =
help debug low-level HW issues. The advantage to doing this in U-Boot is to=
 leverage existing drivers and other facilities. I agree this is niche, but=
 is something I saw one of our power-users do recently and are looking to s=
hare with our customers. Unfortunately, the Makefiles today make this more =
difficult than it should be, hence the desire to change this. My current go=
al is to enable a user to use the stock (unpatched) u-boot to minimally cre=
ate a hello-world that they can execute following the existing examples/sta=
ndalone steps. =20

Are your plans to deprecate both API and Standalone?

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Tuesday, May 21, 2024 12:47 PM
To: Brunham, Kalen <kalen.brunham@intel.com>
Cc: U-Boot@lists.denx.de
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0

On Tue, May 21, 2024 at 04:44:54PM +0000, Brunham, Kalen wrote:

> I don't specifically need API, but today this is needed to enable=20
> creation of standalone applications which does work on our ARM64.
>=20
> If the concern is fixing this startup code, then I can come back with=20
> a change to the KConfig and Makefiles to enable compiling the=20
> hello_world standalone example for ARM64.

But still, why are you doing that? Removing the standalone API itself is on=
 my TODO list, so understanding why someone would be using that today rathe=
r than just making an EFI application would be helpful.

--
Tom
