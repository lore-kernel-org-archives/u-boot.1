Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B570CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 07:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EA081D6A;
	Thu,  2 Oct 2025 09:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YAzKabYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5DF80107; Thu,  2 Oct 2025 09:14:09 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56DD8328F
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 09:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdpC9Vdn8f+q+q9nLeg8DYdLy0yKvKIOC6LQKUnnOsDNK9fT6SMyBUDNPloFJPg5SBKIVTxCwyt2ZdcGDkndhVXLlGzSn/fYVkSFKmQD1o5vzaDxI/lzPGLTfQlCzgG8v4CgAL5VuO5zriXa1anLJHaelRLNs0J9NlPIUbQ2cNCRry8sMCKr4VXeAOISrOQSnUTUeOA43HOikJPYce0barsStdpeJZTT5Jg1ouGLIUHJtXpYJej9UsOUADIfzGPmiZluM7qzq8zZWdOIpGqoqEQDsl1OspUhnCZgzC2mDMsW53tDOPmxN8i6/mJZIpE2V7UlWbj7DjQqnxac2gPtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP6MiGsb1P6E5sfgGxx74C9BoCtTcGYdBnvQjBsHPtI=;
 b=DDFmYEXIpduqVawr1Ih7oqoFIIRID0J35BeGyuS1rEMmXkXjmdvfEHbJoB46T4AD8MimEAefqKb/sW/k6JBKbaJ03uhSi2YhRAzQ0g0l2U11nmTghbhrMVoEfVR4hxPt11yQmIM298ZkidkHOyVi7TxtEYbSBBjOv+9BwvGbD46/PMgx+Y7HYrD6dQIJ4z41zpHJJa9mAuhbLQxJEWLEz/tX8nLdmJd+6F46sJAwqXFLcs34soIpzx3R+PlAuRhv602Id8K5Fv8z5bSh0E/gH1ImRt1biOW/XoMh8OX9MwhceUDMaFVIgszdJqmZpaWOeyexKIBQ9Gex1noXl7J+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP6MiGsb1P6E5sfgGxx74C9BoCtTcGYdBnvQjBsHPtI=;
 b=YAzKabYlTbYytOz+2bdwFsFVymbf1NgxZ57QDFuxoCjTNBBs4Eb7gjZcinps2CyyM9nmOVB/38KZEa7fgRDJ6cALMataubBCF+L7Uw+5bsSKNjVYhWhHX1Cws7J0qmz3JRX3i1CBgYqrLStI6V06WBcssIZhVQ+ktISUVDfgjcGlVbguG2WwDsq36Qu4TgebFL+A+517Wufp9pPWFh0CSJMzbkUUyB3PL9fSiIhdkVkzL3ys4lXOx3Vn5rQI4SfrWzIkBbG3kdQzb1hzyFbS5nBajXBXTvp8QYn66xtZvSFNE07GhIeqQFzAZcJnDSCS0WJA5dsFa1fGQAXbw98Jtg==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by DU4P195MB3203.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:624::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:14:00 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:14:00 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Andreas Pretzsch <apr@cn-eng.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] bootstd: rauc: extend and fix doc to reflect real flow
Thread-Topic: [PATCH 2/2] bootstd: rauc: extend and fix doc to reflect real
 flow
Thread-Index: AQHcMypVi9Yca4Sve0Oguno5K/JfZ7SucesA
Date: Thu, 2 Oct 2025 07:14:00 +0000
Message-ID: <b7171fdc7f1e7a2564208d8d7abd9c72598ebb1d.camel@phytec.de>
References: <20251001232259.3599563-1-apr@cn-eng.de>
 <20251001232259.3599563-3-apr@cn-eng.de>
In-Reply-To: <20251001232259.3599563-3-apr@cn-eng.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|DU4P195MB3203:EE_
x-ms-office365-filtering-correlation-id: 71f56264-806b-4b55-c5c0-08de018342cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cXliZnNxcFJoK05ZUEd4TUVuMjlGcmE3Q2NxTTBTZ3NCYjdHelJkWjBuMTNq?=
 =?utf-8?B?aWNtM1F2aGk0aWRjVzBhY29VUERBa3JZQW54WkxTK3poQUkzTEgrVXVUQjk5?=
 =?utf-8?B?TnI5NEdGWDFnU1A3cnQ1OHBuTXRlNGtqVHFHK0xpb2ZNVjljZlZFb0pVODIz?=
 =?utf-8?B?clNHQ1dsamg2b0VTdFBrVVY3WkJNVjlURGlyZG1qWHE4NTRVR1FaQTVFTUlL?=
 =?utf-8?B?R0VJN2luZE84TEVWeWdkS1dsS1R0a1E0YVVONGR1VkJKQlRldVEvRENrcU80?=
 =?utf-8?B?SW1pQmpKTnk5ZjYwYXFSMmE0Y3NQNEM4RkFiYTlZMXEvSnl6ODVLNVhRYmx6?=
 =?utf-8?B?MVRENWFpL3Q0VGR6eHAvU2l6SGJwZnpFckgwUU95YTN6cFlpb3h0MnM3dnRW?=
 =?utf-8?B?TXlyWmpRQjBHLzJ0TUl2UGloWmNPb2k4YVNtbU5Nd3c0UitkZTFsMlVNN1Vi?=
 =?utf-8?B?eUlyMHVpbmVZUTNzdmhUc0ZuQW5oSHMrdmRaMEZQWFIvRUxvRmJGMFRpdTJM?=
 =?utf-8?B?RWF4eGFmQmNINkdUTUlUeXZ0bExBTUZFbUVHSm9Mc2lLV1owL2RaS1d2QW8z?=
 =?utf-8?B?Vll5R3E2SlEzWDR4MEVxYzhMczNHZDU1RGVtN2swYXcwVFpzSlRQM0NhVDln?=
 =?utf-8?B?TTdkTE4raVpTYlVSWUxoNkVieEowaXpiZW10UDRmMWJldGJJYVF3NGJnSmdI?=
 =?utf-8?B?TUpLdHYyVHFyOEpJWG1qcmpEeTdjdDh3ejVnTVpFM1BieUh1VjVhdzhMTzlY?=
 =?utf-8?B?ZmZkMDI5eVNaSDhZM0pIZk5iNXdaNDVFTGlIanlaZU84cUhFajFaSlJCdXh4?=
 =?utf-8?B?eTNQc3U5OVRDRDltWXZiQlFFUXJaclhKUHpsVVl4RTdtNHZCYXZMS1dNTUd6?=
 =?utf-8?B?S0pvQ094aWxJQXdqVURCZzlhUUxKb2o4Qk9oT0RRWGF5dlg4Vi9SNkpZQ2tt?=
 =?utf-8?B?ZzhDUUsxYks4SmVJeWdPdGwzZ0c1UjM5SmdDVnB5M1ZITnV6cHBmalFnUWZn?=
 =?utf-8?B?QU1Ed2VJTmpVTkMxL1NkeEk1anBpVXo0UzhZak9IL00rVUtKSDlyMk1MMGQy?=
 =?utf-8?B?OXdGVm01eVVJSXpjNXdTbHI1Mnk1RVBkdUhWeHdXQllTTmNMMzFneEM4S2l3?=
 =?utf-8?B?dldrTFF2a1dXTVBCRFVvU1YvbERBckpNaWhGZTlrM281VmhqZEtyanM4ZWJM?=
 =?utf-8?B?SHh0U041NWtWZkNPazlOVzkzejd0bFJudnNYTVMwcFRjeTBMUTlYZkRMS3lr?=
 =?utf-8?B?aHdRNHAxK0U3Q2xTUW1YLzZlNGE5anZqeFhLMmlrYU9IZzNTZ2Q5alJSMnMy?=
 =?utf-8?B?MnZsUkhxY3REUVhyY1ErUWZEK1ZHSmJoR2tUNlJaTVQyMVh0ZmRSUzZKSkJ3?=
 =?utf-8?B?QTQrMVNJM3R5bXo2T1AveWUxQjJFWlV4T3FYOFp1VXFzVGMrY2NnVzBib1M0?=
 =?utf-8?B?RWJET01CdkE1eUZLTkc2ZVV0ajJ4c2ZEK3d3NVRYUkRxMUYrOUJuL1VIWGpO?=
 =?utf-8?B?UnVTdDV5bWhhQXgrdzFNNVZYdVhpd3kxVjBDeXpVSjB5UFVOd1BOOUVta0xT?=
 =?utf-8?B?WVloTWtZRWNFaFNKekpSb1pvV0NUZkpvWGNZUXVTSlNJajJmSENsOTlnZWwy?=
 =?utf-8?B?ZFJ3MGI5MnBlYTBTZHJST0RvWENwU3VpTmpBcVhZZ2U5cGxYNkFiUXltalNn?=
 =?utf-8?B?d2dHWHZTdXViM3YwM1krb1k3ZFg5ai9yWUJiS3hyUmVYZWNOdkpPeDNONHl4?=
 =?utf-8?B?Ni9KWkt5ZUU1YUgxWlVGUnc1TVlzcUhMS3kzZTFnL242cU5zbWF5WVU1S05I?=
 =?utf-8?B?WjFqTmJZaTdSQ0hibHlVYTEvM2VCSjlaeW82QXVhUGNjblZvWVM4MlpTa3Zq?=
 =?utf-8?B?TU1LelIyR1JzRTZmdEtZbEZsY1Z6bXoyYmN6aW1QN2YxTkV6QXQzMFZqMUR6?=
 =?utf-8?B?OVlPT1gxeTlmRW83WURMMU9IWW9Tdk8yZlIrYS9tNzd0cVB6RExCRUZBVGM1?=
 =?utf-8?B?UjNlTVNlNThyaUlGVG56Mm9yc010RmdsQ0RaaW9SbHk0U0EwaUMyZDhRL1ZV?=
 =?utf-8?Q?oeR9jn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2hxak9oQmFPOHovL3FWbktnT1RtamxIN1Rrbk5YaXhjZG10bkN6aUZFV0ZL?=
 =?utf-8?B?cUx3YkNMVEZRcE9SbVBldzZOamtXbXlRaEs5QW5Rd3h1cE9VQVZsQkhwSi90?=
 =?utf-8?B?d3VQT012anlHbHdKQVA5bUxHeUVzN1ZmTlkvVjljVEQ0QjY0SDl1ejhsbnFM?=
 =?utf-8?B?Wm1GR01aMzU3S0xCYUtEZXBQbzhFd1ZtaE5ZaDhoSlB3RnlyRVlXL2pGSSt1?=
 =?utf-8?B?Tzc0NS9VdC94RE00bFhKVlhxaGtYbU02VmptWHdVblZVeVZxRmlvSisrcXBP?=
 =?utf-8?B?TS94VHBUQ0RZZDVUYmhVNGozeDdZVysvTXZVUHZBdFFSMkFkN2p1R0ZvL0VH?=
 =?utf-8?B?UmNlRlpTVldqV21lUzNUaWRrQ1lQNktQcko1SW8raHI2Z0lwaG5LRGxEaWtF?=
 =?utf-8?B?L0VTaVl3WmRrUXducjZEa0puR1pDeFliSHpJajZ5Q1NnZ1poWmVjcXU1b2V0?=
 =?utf-8?B?WkJseHFjRXFLUnV2ekdKOVBEZnl6UUpOeDVNTXFhTFMzaUdLOGpPWGloUWds?=
 =?utf-8?B?Y1RtV09OZUxSVnptVGVUMm1rSGRTZEg5SW4rUU14K2pGMFU5elhNaEtLbFBZ?=
 =?utf-8?B?SnUyTVh4dFgrZTc4ZGtoZ0ptM1ZJSmdBcUdYZGcxQXErdnl3Mnk2aEdOYUNz?=
 =?utf-8?B?N1VJVmd2UVppLzdkNDZCUDRjcVJWbHN3VktOMUMyaXlOdDhqVlZXM2J3MFRv?=
 =?utf-8?B?UFlLbURldEFKWDcxSG9MTGFNc0FoUkJtLzBBNjNKVjNYTEFIa2dQZFdoc09K?=
 =?utf-8?B?NlR5b3FPcE1nUjJSWHM0aStOWlZxc1FwZHdRR3NNdllMWEVuVDBzS3UvTlN1?=
 =?utf-8?B?eHFUNlhsZnB5K3k5QzlqL3BLNEp3Y05NbmtKQWc0czlzWjk3UXJoREJwV2sy?=
 =?utf-8?B?aVV6Qk9od2VqdFNONzUvaFVhUGVkWmE1aEZmK2ZMVm5pWmxVSkZCRnBVU0dk?=
 =?utf-8?B?SmFaRzR6eUJ4c1RDM3NuUi9STExSemZBUUJFYXBJUlpoMFVSYmZpSkJrem5B?=
 =?utf-8?B?ai85Y0NmK011WEU1TUhFQk9Pd3d3MGh4dnFwVmdITDZqUkdwWW5rMFdpYzNE?=
 =?utf-8?B?MWpkeTNQYVgxcitPdkd6aFd6eFhiR1VhUnV5YnVlS2NlQ1ZuZGp4UmtwVHYx?=
 =?utf-8?B?YjdkWmdFc3d0VkZNak54QWRRL0FLOVk4MWtaekR0NFh2M05lNVZKWmEza2Vt?=
 =?utf-8?B?M3h3V1dQazZIZ0w4Q0MvYXRnZTJVZXpzV2cvd3RoVUtZU01nQXQyRWcyeGUr?=
 =?utf-8?B?WjVUSkNLdGpseFcrZ1RvNXM5S1lsc21ac1N4LzhydlJSVmwyQ0xXY1FrZXZF?=
 =?utf-8?B?dEhzbHFYMmc3ZWlQS0txSzJNMGxxSU5HTTB3YzhLRmFXa2ZZVm1ONzE2dXJX?=
 =?utf-8?B?MzVtS1NLV1lEZ1p6d0EzTE9jQ2pLaUE2OGRXWGpTV1Z5U282Zmx2dG9QYnJT?=
 =?utf-8?B?OHZNVThBOGg0WTNTZmFEOXZmcXJqUklWNEQyTUdYNCswdXVPVU1JN0xXOHhM?=
 =?utf-8?B?bnFCSi9TbFNISm1vVStmQ05aRllrL2FLV3JXVWVUNjA1dTlTZUE4Sm56dXZi?=
 =?utf-8?B?YzlaM0VoMlpqc0xmZjJsSmtZSEMvL0JFV0x0NlNaSUlCUnpaaGgyWENMRlpX?=
 =?utf-8?B?akRCdVJLTTBTQXg1dnlVMStxWGZGMW8xOE9nbXJYZmloT2R0SFRwUVgvOTAw?=
 =?utf-8?B?N1g2VU9uRGtSUVc1NVBGL3dGNG45SFBSWVRveFVGUUtLaGtGMi96aC9CdEc3?=
 =?utf-8?B?MkhYZmlyZjRoVHFDeGRENkRFNm4wRFo5emtTNEhjTExmaXZQa3pvQzlhN1Ay?=
 =?utf-8?B?ZHNSZ0M0ank0MjJMd0xiemRlSGx2RjBRTW9jQktTNW1nR0dZemxIeis2NzdO?=
 =?utf-8?B?SkExd29uRlZqcTA5MU1UTU5MbG1sMnVGMDFWN1phSVV2alBhVU5KeC9MYzQy?=
 =?utf-8?B?WGxHQloxRWlwNExHbmlkcWJwcG9CSWpHa2dla0NtNHZwYk1YTzlVZ0oyRDk2?=
 =?utf-8?B?SldvREE2aEgyUEcxaDgxWkI4Z2FtRENMUDF0MXZPQmxaeC95dEM5THZXL0Ur?=
 =?utf-8?B?QXN4VHJYekloMGNEZ3pJY1YzSFlkaFR6SWNpRmoreFZ2L2tURHEyM280eGtZ?=
 =?utf-8?Q?ibiWOXduzkmYZqFe3U2os0Ban?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <240332A73535A040AF3105955B492732@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f56264-806b-4b55-c5c0-08de018342cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 07:14:00.5857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jlc5JtzZkxdibHGCDVwqqDhVm6PGltXG2i941jI2KN6mr1NZY32xX2bGyH4fLblW24uXNiKWosk9gDBU0Uzn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB3203
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

SGkgQW5kcmVhcywKCnR3byBzbWFsbCBuaXQtcGlja3MgYmVsb3cuLi4KCk9uIFRodSwgMjAyNS0x
MC0wMiBhdCAwMToyMiArMDIwMCwgQW5kcmVhcyBQcmV0enNjaCB3cm90ZToKPiBUaGUgZG9jdW1l
bnRhdGlvbiBvZiBib290bWV0aCByYXVjIGluIHNvbWUgYXNwZWN0cyBkb2VzIG5vdCByZWZsZWN0
Cj4gdGhlCj4gcmVhbCBwcm9ncmFtIGZsb3cuIFNwZWNpZmljYWxseSB0aGUgcmVzZXQgb2YgYm9v
dCB0cmllcyBpbiBjYXNlIG9mCj4gIm5vCj4gbW9yZSBzbG90cyBmb3VuZCIgaXMgaW5jb3JyZWN0
IChpdCB3b24ndCBjaGFuZ2UgQk9PVF9PUkRFUikuCj4gQWxzbyB0aGUgc2VhcmNoIHNlcXVlbmNl
IGZvciBib290IHNjcmlwdHMgd2FzIG1peGVkIGFuZCBpbmNvbXBsZXRlLgo+IEZpeCB0aGVzZSBw
b2ludHMgaW4gdGhlIGRvY3VtZW50YXRpb24uCj4gCj4gRXhwbGFpbiB0aGUgaW5pdGlhbCBzZXR1
cCBvZiBhbnkgbWlzc2luZyBCT09UX09SREVSIGFuZCBCT09UX3hfTEVGVAo+IGVudmlyb25tZW50
IHZhcmlhYmxlcywgYW5kIGluZm9ybSBhYm91dCBCT09UX3hfTEVGVCBkZWNyZW1lbnRpbmcuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBQcmV0enNjaCA8YXByQGNuLWVuZy5kZT4KPiAtLS0K
PiDCoGRvYy9kZXZlbG9wL2Jvb3RzdGQvcmF1Yy5yc3QgfCAxOSArKysrKysrKysrKysrLS0tLS0t
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZG9jL2RldmVsb3AvYm9vdHN0ZC9yYXVjLnJzdAo+IGIvZG9jL2RldmVs
b3AvYm9vdHN0ZC9yYXVjLnJzdAo+IGluZGV4IGIyNjYxZDE4ZGE0Li42NjhkMmExMzhhMyAxMDA2
NDQKPiAtLS0gYS9kb2MvZGV2ZWxvcC9ib290c3RkL3JhdWMucnN0Cj4gKysrIGIvZG9jL2RldmVs
b3AvYm9vdHN0ZC9yYXVjLnJzdAo+IEBAIC0yMSwxNCArMjEsMjEgQEAgd2l0aCB0aGUgbGVmdCBv
bmUgdHJpZWQgZmlyc3QuCj4gwqBUaGUgZGVmYXVsdCBudW1iZXIgb2YgYm9vdCB0cmllcyBvZiBl
YWNoIHNsb3QgaXMgc2V0IGJ5Cj4gwqBgYENPTkZJR19CT09UTUVUSF9SQVVDX0RFRkFVTFRfVFJJ
RVNgYC4KPiDCoAo+IC1JbiBjYXNlIG5vIHZhbGlkIHNsb3QgY2FuIGJlIGZvdW5kIGFuZC9vciBh
bGwgc2xvdHMgaGF2ZSB6ZXJvIHRyaWVzCj4gbGVmdCwgdGhlCj4gLWJvb3Qgb3JkZXIgYW5kIHNs
b3QgdHJpZXMgYXJlIHJlc2V0IHRvIHRoZWlyIGRlZmF1bHQgdmFsdWVzLCBpZgo+IC1gYENPTkZJ
R19CT09UTUVUSF9SQVVDX1JFU0VUX0FMTF9aRVJPX1RSSUVTYGAgaXMgZW5hYmxlZC4gVGhpcwo+
IHByZXZlbnRzIGEgc3lzdGVtCj4gLWZyb20gbG9ja2luZyB1cCBpbiB0aGUgYm9vdGxvYWRlciBh
bmQgdHJpZXMgYm9vdGluZyBhZ2FpbiBhZnRlciBhCj4gc3BlY2lmaWVkCj4gLW51bWJlciBvZiB0
cmllcy4KPiArSWYgYGBCT09UX09SREVSYGAgZG9lcyBub3QgZXhpc3QgaW4gZW52aXJvbm1lbnQs
IGl0IHdpbGwgYmUgY3JlYXRlZAo+IGFuZCBzZXQgdG8KPiArYGBDT05GSUdfQk9PVE1FVEhfUkFV
Q19CT09UX09SREVSYGAuwqAgSWYgYW55IGBgQk9PVF94X0xFRlRgYAo+IChgYEJPT1RfQV9MRUZU
YGAsCj4gK2BgQk9PVF9CX0xFRlRgYCkgZG9lcyBub3QgZXhpc3QgaW4gZW52aXJvbm1lbnQsIGl0
IHdpbGwgYmUgY3JlYXRlZAoKVXNlICJlLmcuIiBoZXJlLCBhcyB0aGUgc2xvdHMgbWF5IGJlIG5h
bWVkIGRpZmZlcmVudGx5IGFuZCB0aGlzIGlzIGp1c3QKYW4gZXhhbXBsZToKCiAgKGUuZy4gYGBC
T09UX0FfTEVGVGBgLCBgYEJPT1RfQl9MRUZUYGApCgo+IGFuZCBzZXQgdG8KPiArYGBDT05GSUdf
Qk9PVE1FVEhfUkFVQ19ERUZBVUxUX1RSSUVTYGAuCj4gKwo+ICtJZiBgYENPTkZJR19CT09UTUVU
SF9SQVVDX1JFU0VUX0FMTF9aRVJPX1RSSUVTYGAgaXMgZW5hYmxlZCwgYW5kIG5vCj4gdmFsaWQg
c2xvdAo+ICtpcyBmb3VuZCAoYWxsIHNsb3RzIGluIEJPT1RfT1JERVIgaGF2ZSBCT09UX3hfTEVG
VCBzZXQgdG8gMCksICphbGwqCgpVc2UgaW5saW5lIGxpdGVyYWwgZm9ybWF0dGluZyBoZXJlOgoK
ICAoYWxsIHNsb3RzIGluIGBgQk9PVF9PUkRFUmBgIGhhdmUgYGBCT09UX3hfTEVGVGBgIHNldCB0
byAwKQoKUmVnYXJkcywKTWFydGluCgo+IHNsb3QgdHJpZXMKPiArYXJlIHJlc2V0IHRvIHRoZWly
IGRlZmF1bHQgdmFsdWVzLsKgIFRoaXMgcHJldmVudHMgYSBzeXN0ZW0gZnJvbQo+IGxvY2tpbmcg
dXAgaW4KPiArdGhlIGJvb3Rsb2FkZXIgYW5kIHRyaWVzIGJvb3RpbmcgYWdhaW4gYWZ0ZXIgYSBz
cGVjaWZpZWQgbnVtYmVyIG9mCj4gdHJpZXMuCj4gKwo+ICtJZiBhIHZhbGlkIHNsb3QgaXMgZm91
bmQsIGl0cyBMRUZUIHZhbHVlIGluIGVudmlyb25tZW50IGlzCj4gZGVjcmVtZW50ZWQgYnkgMS4K
PiDCoAo+IMKgVGhlIGJvb3Qgc2NyaXB0IG11c3QgYmUgbG9jYXRlZCBpbiBlYWNoIGJvb3QgcGFy
dGl0aW9uLiBUaGUgYm9vdG1ldGgKPiBzZWFyY2hlcwo+IC1mb3IgImJvb3Quc2NyLnVpbWciIGZp
cnN0LCB0aGVuICJib290LnNjciIgaWYgbm90IGZvdW5kLgo+ICtmb3IgYGBib290LnNjcmBgIGZp
cnN0LCB0aGVuIGBgYm9vdC5zY3IudWltZ2BgIGlmIG5vdCBmb3VuZC4gSXQgd2lsbAo+IHNlYXJj
aCBpbgo+ICthbGwgZGlyZWN0b3JpZXMgb2YgdGhlIGJvb3RzdGQgbGlzdCBvZiBwcmVmaXhlcyAo
YGAiLyIsICIvYm9vdCJgYCBieQo+IGRlZmF1bHQpLgo+IMKgCj4gwqBXaGVuIHRoZSBib290Zmxv
dyBpcyBib290ZWQsIHRoZSBib290bWV0aCBzZXRzIHRoZXNlIGVudmlyb25tZW50Cj4gdmFyaWFi
bGVzOgo+IMKgCg==
