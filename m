Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CD1CF6AB9
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 09:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6FE83B87;
	Thu,  8 Jan 2026 10:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZDHTLIgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5233983B8A; Thu,  8 Jan 2026 10:57:35 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3525083A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+nDknzq7YCeOQs8uP4bbutRNFMfp6EQ2ZcMlu1DuXelcayWTtUtPChNGRIFg9qoY429nz+hic5OLSMzeDhoJ1RerS8oO3/a2NSQEOuQDUaAEc69IsMBtnP9226yFp8WQ7cWcEqaTlWEfebEG/Ow+gcV/4noK2LquZie7OBTInKhOC0GdFHq/kj4BngqF37UTIWK2DeYBhwwkRmnItiGBfy58QJ6F2ULe52aOgjjaB5LvsRP9+UlciA3Imf/vx9y+trVxRNNCvrrFi9SV9I8W+aYOyofuJWuZODkEsfh5+cb2cFjSe5uuqJclbB/sCxmzTJGlIaKlJ9+WxcnO0GIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/R/ZvVmHzDA+Ud9UhVu0TYH80AiFSegfmRUwGO9Pis=;
 b=cZfeMX/jWqNQCM6fRoR+djd4F/SWTZXapLZuQEEB21eZKCOiUAibWu7yuLvKYgHXRdkZlZ2CHDe490RMk+YnIdbCPecP/6ZC6z7YPibAQRLB87NB0DAtYdErLeMcNuBzA3kIiN0/4jasQjcJp/NPQwfgzqnKMFbB6QWAuLGMvoIqQutzYaw6UmJ8S2HYEU7IREQYVini9nLV1E9Tzu72NmwzEP3qQ9uSgMxz5ZRZMuhFDF9f8QE1Naij4w6WxIAOs9tU52sXM4SaecoWlUfFX/BPIAlo3+b5HFpUssvFisjkOvK2Zlm9F03eyRnyY61q+vXCyYGFImfxqKKdg5gvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/R/ZvVmHzDA+Ud9UhVu0TYH80AiFSegfmRUwGO9Pis=;
 b=ZDHTLIgUL3EyxijwWCDa7e3YRJn5wXOj7+/ooAfeyveHHyrL6YLP5DySSMwZGe7duzhwY9uET8yrFHpxMprIVFEb/oGUChhc9NyBurEtwNMpEeinIMBhe37jBB4Zmm3RmauE8NQIuuQfTCrVwFJ0BGvulPCeNbbfjBBllgjcnCPqQtbZ2y/JvkDtik3Cy65fBBIjR5VWGgWvt/jQOE1Vt2bIsbjYMllsPclDj6tZTjP3tJ679zvWUNX+aLo21FhDdz1+9wXGktuxT5UodLFwnEod1RspyERxFwJyORq+gI3SArJMbSj0sPF4AKZ/M4gpW/Ekch8pcNQBPfsetPWkUQ==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM0PR04MB7026.eurprd04.prod.outlook.com (2603:10a6:208:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:57:31 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:57:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Vitor Soares <ivitro@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "vitor.soares@toradex.com" <vitor.soares@toradex.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "tanmay.kathpalia@altera.com"
 <tanmay.kathpalia@altera.com>, "marex@denx.de" <marex@denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>,
 "balsundar.ponnusamy@altera.com" <balsundar.ponnusamy@altera.com>
Subject: RE: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
Thread-Topic: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
Thread-Index: AQHcgCuWoX4hFiy1iUWjZCIEUDR/MrVICdJw
Date: Thu, 8 Jan 2026 09:57:28 +0000
Message-ID: <DB9PR04MB846113BABEA38EC77A3734D48885A@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
In-Reply-To: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AM0PR04MB7026:EE_
x-ms-office365-filtering-correlation-id: cbe775a0-a41c-4c7e-931f-08de4e9c5584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Qy9aLzVqNXh0VTQ2V0ZiblFzZjRmVkhEbi82eUVsczRWdUxiN1VvUFZhL0Ey?=
 =?utf-8?B?ci96VENWVFBxT1RwamJoMGsrei9KOHZJNzc5enhJWWhWRWdSZEN4b1RycGFY?=
 =?utf-8?B?SDVjNVNtMmVUdlNOa3FWdUlGOWE3bnVuanpvL3VVSmw5MXN1eFo3dE9zS3FG?=
 =?utf-8?B?VFp6L1VZY29MQVRlOHUxTGk5QkhnMFdrSmdGSUQ3dlROSHVpeG5RM09vVk94?=
 =?utf-8?B?Z2s4cGFEd0JmK1ZXVHMxVG02L09zTDhMazFPNmtWZzF4WlZQNzRRb0Y0N0th?=
 =?utf-8?B?U0tpZ0tsbEpPbkVpTDNYMHQ3cFhHQmZoaGxubEQvT1ZOeEg5dlhZV1NZRlZO?=
 =?utf-8?B?RkkvOWhYSmFpd3VFZWh2SVk5eTRYWmgzc2tmV3BMQk1YRVlCUFlwb1BGS09a?=
 =?utf-8?B?Nkh6RlFScGJhMlFFRVJwRjJsY0p5SCtRSCsvRGVENWN0OXJFTW1sN1ozTzJa?=
 =?utf-8?B?R2JwRkZ2WGFmRjk4T1dPbWtweDlGQ2FNRFpUTmdQQk1OdFgxVXJROG4xMHh1?=
 =?utf-8?B?aWlNMk9HbzNqSWpIVDd1V3A3YXp3UklxT3pXSW4vY0t1aG81NzNER1pabXho?=
 =?utf-8?B?WFVncDVDS1lyTmZLdHJxbjM5QXdCT0hWWkh6ZFY3c2syWkIza0ZrYzJScjhB?=
 =?utf-8?B?cHpLRGtKbHBRd3loWGlXcWZqcHlCeGNtb05BdUEvajFaTVRDdEpFT0ZOb1Mz?=
 =?utf-8?B?NmUvblM3bzZlYmxZK3NqRTJOWjRTRVFnN1A2WUttMVNXMWZjMlFRV09MeU95?=
 =?utf-8?B?K2VKWkprVnFsVlB6bnRoeDlxRzdrYWFrUWRXdmtFcklrU1E3Q01jem5VWHFs?=
 =?utf-8?B?bjFJa3lBai92QW9RaENOeXZEYkZMWDZvaUs2a0VuaE0yQ0czOEZsVWpCbFd6?=
 =?utf-8?B?UzlDV09VbEZGN0RyalZSZDBpaThkSzlXZ0VhMlpMdjFYVzNBTDdDZDhIYTFQ?=
 =?utf-8?B?UmpQemFiTkFkaHp3c2kzMzFjb1p4ckI4ZU9JeTR3MVdyZUVnZUtJU2oyc1VC?=
 =?utf-8?B?QzNpQ2hnTXVKRWZrcUVtRUJNWGdFVlVvMUV2dXRCMVpSelFzS1p4eDNXNnVU?=
 =?utf-8?B?eDlLOTZXeUtwQnFQS1lYWlVyTm9VLzVPdHFBQ2dFWldDTkVSMm5NanhYUGRy?=
 =?utf-8?B?Vmp0cU95cWdzUytMOXZXWFV6NUFJb2pnK1lGemwzSzFiUmNqQ1RiRjRQUjF6?=
 =?utf-8?B?YXJpeEN1bndkMjRqc0Z3bmtJRGlqeGFyUUtpNmhoU1RBaWgwQkx2V1JXdTY1?=
 =?utf-8?B?ekRIMGVvT1NFS3BNQXMveVpBSXVNeEtjR0JXNTZmbUZaREQ3VldPcW51Qmp1?=
 =?utf-8?B?TEdBcUYxVzJOVzM0Zmx2TzJiUW5ZMTZ4T2RQVkcxSFFuS0JqcGhUZjRGaU9M?=
 =?utf-8?B?bTd6V3l5bmhvWWkyZXh3ejc0YUVWMjBXUWNwRkJ0ejdqTUdNZGxseGcvS0ZI?=
 =?utf-8?B?dFN4OXdjRkdsVXhZZE9HZ0JyS08wdms1Qzd0VXNkMEdlNFE3NWZGaC9xd0Zu?=
 =?utf-8?B?R3gzZDN1SUNXd05jdmt3eDVKRTBKSzU0L0x2ZGo1U2laUE1rWWNET1gvZ2tU?=
 =?utf-8?B?SmNZMFdRWjZwRHRQMHBYRDR1a1gxZmJCbFZoanBJUWgwcEM2ZzVzbFgyaTJt?=
 =?utf-8?B?MTdUY1Y5bTUzM0JtZWxEM1NNOFBRUDZIdUo3eU4rdGZlNFZ0U1VvaWUrM2pY?=
 =?utf-8?B?ZlhzVFpWZnZGbVdRZlRoTzBUSVo5SHlMQ3U4a1dzaVIyc3UwR2VIYUQrSTFa?=
 =?utf-8?B?Z1pSaWtnck91RHhBSVhyODdlNGpkVEV0dVpPTzYya3VoMjBvUVBaZGNHUm4v?=
 =?utf-8?B?T05qTDN3U0RjM2grd0laUytOcFREOFZjU3YyQm1VMmhzY0hzVkVVZUZsNVhq?=
 =?utf-8?B?a2lmMWxGa1Y0eExSQXJrSUg2aGNyeFRyTytINW9VeS90VzBYTVBDQUF4M3VB?=
 =?utf-8?B?b053bWh5TkYwWmpvOENEdlQ2Yno5a2g3NnpaN0N3SUhuNmdNVWVsa3laTFRL?=
 =?utf-8?B?MmtrUjNLcWNFSHJkYlF3RWdjVkRSbEdWcHdqZlJ0Z0VNVVZwcGZ0NHdmRkE2?=
 =?utf-8?Q?qyl16L?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWttbnpubitYamlDZEUvRVJmdEg4UnBPbGhURW15Z3oreTBhUWs3RmVrbUcr?=
 =?utf-8?B?blZoVUFIZUF0QTczczNZV0pPKzkyTlMrelVwaXFkdG9BODN3ekVmb3kzNFJs?=
 =?utf-8?B?Z3VrdlJ0SkZjOEpITGE2eXY0Q2hOOWx4cTlVamFpTStzTVRVNHpQNi84TkNX?=
 =?utf-8?B?anJjOFJ5d1pkRmtRcHk5MGZQSktQUTlZb2dtRnlyLzVtK2REbmtsVFY2T09U?=
 =?utf-8?B?cFFuZ1BkU3FvWXVrcUV3Q2hoUm1YNmNJTVpBUjFCb01qR0l3MVJtWU8rVzVZ?=
 =?utf-8?B?MmQwMWVrK3V1eHFGOEIxNkRDcWxJMmhZK0RQMVM0QUVZWDJtU3RQUDU2WE5C?=
 =?utf-8?B?UFVKN2svOVhtR2VONjJ4Y2RrSTVYUjREOEtiNjc2L2VQNmxsWU5tazBlcU5h?=
 =?utf-8?B?SE5XVnAxSEJCN29Fem1qdCtveDlaeGE4NWFwdEpXTHBvVjJ6MVU0WU42aFpp?=
 =?utf-8?B?elpVc2JDWm80YnpXTzVsKy9EZlE1eFRpM3ZmWUhwelhyK3VQa1YxMEsvRkQy?=
 =?utf-8?B?Mld5M3ZhU1dkOFhVM3E1NkE4NlB1NDRUTituM2pTejhua3NpRnpUcWRqeEN0?=
 =?utf-8?B?cEJDMERXL0hqWXBZaXBiWFNsSTVFR0M0OFo0VXg2bVBqT0hzSkNOTjVqemFq?=
 =?utf-8?B?UUNXbG9xd3VPNng4UTc1cytjcXFFR1ljMkVBdy8zc2VibXhVdUJTWXJ0d2Jz?=
 =?utf-8?B?WXRvVmhCc0dZaTg0UjA1UkdFaVZzQjF3eWdlOFZyem9RMDA1d0xWRmNMZ3ov?=
 =?utf-8?B?dlpGbHNhajNRUkNUWnVUcVNLTi8vZzk2ZldtMk1TYk5TOXZFM2paQUNOcDlV?=
 =?utf-8?B?NmNzaFQ3RGQzSjhGNy9SdGRNRHFCcFpHMzVhQTF2dFR3eU5tN0FuUWUydFVF?=
 =?utf-8?B?S0p6L1Fhb05xcmcyZkR3V3BhaXAwbzhMNW9sS1FEOS93Y2NEYzhTRDFXSTVB?=
 =?utf-8?B?MGxLWVNvcVZzVFB5T2dIcjd4M1FFc0J5TjEwTFpkQ1hpYVMxeW5MNXc0QWwz?=
 =?utf-8?B?UEdxUDJQbDU4UmRkaVRDOU1NRFFiVEx3S0cxMjA4RW0xd3pjVm0yTGVaZzBV?=
 =?utf-8?B?Wnp5cEp6QW1LWkltd0M3WTNLWmNXcStmMnlvWWZoTVhZSWYzSWcwY1lacGx5?=
 =?utf-8?B?cTVkUWlybkdPOFlRUUQyNlJrNVRlOHFkMnFpWnBCN0R2YlkrYWFEdlBhL0Nv?=
 =?utf-8?B?akdrQ0Nkb29GRmIyaDNrNUVKQWVnSzk3NHFCRWE0Tm9CS0pNWGozTGZpSjRs?=
 =?utf-8?B?SDcvSWpUM3J1V1pDOEROWHo4UzhhV2t1aHA3dEJQWng1SE82emRKRDdpSk9Z?=
 =?utf-8?B?eGJmWnd5QW1uSVRYSkl5aHVJUE5zczlwWHYyV05oRVV0bXNuQjZBcFZVTDV2?=
 =?utf-8?B?dG9kNTNwb3l3UGhTNEVDL3NWdUN0Ris2enJVV2hvYU1UdVlmamRROExuNFNI?=
 =?utf-8?B?dnZ0M09LdUEvVVlvNC8zaFhLVmxlUzBLeEIwZXIzVTE1QjRZdXgvNXBVeGp4?=
 =?utf-8?B?ZHYzL2J3MHF2NURpNjVzUDhpMzZxWjFHa0hHWFhHZjZBdXY4Uk9BM0sxM0Z3?=
 =?utf-8?B?aWRBT0FRbUx2bHlCVFZCUFdpWndvMlZWbEJES0NhY3RmdmFqNW5MSDEyU0FG?=
 =?utf-8?B?LzB3SHhGR1pUVExMQ2VZU0taOW1MV3AzaElDVE02c1ZCMkpXN2tSaWpyejFv?=
 =?utf-8?B?WmZNN2dPTWNhYkZzVEc4WTNFWHoyMVM3b1lqQk50L3JVOGEyOVozWTdTUVQw?=
 =?utf-8?B?RE45V2gvdHRMTld3czFLd3RaT1ptQjFvZnFXZThhNFJXUmpEeEJSNUJWaWsv?=
 =?utf-8?B?aFE1OGs3Qm9YaE1iZlFjSFBjek5ldVpHZkptRzFsalJmdlVZU2d3SkRNWUZj?=
 =?utf-8?B?cWFQOWh5Qy9IRVk5a3FhZmRGWHoxNCtaZTg2S3ZsM3F2WWYyTUJBOHJlcWdu?=
 =?utf-8?B?eTlISHVtN0Z0RG1DTVdLc21zSUxrZ3M3Ny95STBIbHE0OXJDQzFHMy9jV215?=
 =?utf-8?B?UTFNRFFSZUJROVlkN1dwNkg2cmpNdDhmL0s2RlhVY002TzYweWpMNzJ6RHNi?=
 =?utf-8?B?MEVIQWtOQWJYOGMxK3FUYTRzeCtBQ2M4SS9YczJ6Q202ZGhyUElXYXJQSElQ?=
 =?utf-8?B?M09yRlhqdkR1c2s0bFVLdkVFNUJmVUNrRUNMeTVvMGIrdlkwMVRteTduQ0ZM?=
 =?utf-8?B?MW94THJqejFpMnJ0Qk9GQ1FyVkI3dUkrYkU4ZStZQXViMVBkWnNXQnJ6WlE1?=
 =?utf-8?B?TVN4Q3l0QUkydlVZT1luRTcrY0FKemd2QjliMGoyTHJaNm5XaWxIQndlNEVU?=
 =?utf-8?Q?K+EjazICBeamberYoL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe775a0-a41c-4c7e-931f-08de4e9c5584
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 09:57:28.9331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vy8iC8OFTHWj7I2UL6JziTKpzkUcZILQW6mcHZWGGpxTLgqhNXMTm3vfed5PAPQd4SmIvm66ZmTP4JL9t/ukjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7026
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

SGkgVml0b3IsDQoNCj4gU3ViamVjdDogW1JFR1JFU1NJT05dIG1tYzogInVuYWJsZSB0byBzZWxl
Y3QgYSBtb2RlOiAtNSIgb24NCj4gaS5NWDhNL0FNNjIgcGxhdGZvcm1zDQo+IA0KPiBIaSwNCj4g
DQo+IFUtQm9vdCAyMDI2LjAxIGZhaWxzIHRvIGluaXRpYWxpemUgTU1DIGRldmljZXMgb24gbXVs
dGlwbGUgcGxhdGZvcm1zDQo+IHdpdGggInVuYWJsZSB0byBzZWxlY3QgYSBtb2RlOiAtNSIgZHVy
aW5nIG1tY19zZWxlY3RfbW9kZSgpLg0KPiANCj4gQWZmZWN0ZWQgcGxhdGZvcm1zOg0KPiAtIFZl
cmRpbiBpTVg4TSBNaW5pIChTUEwgYm9vdCBmYWlsdXJlIC0gY2Fubm90IGJvb3QgYXQgYWxsKQ0K
PiAtIFZlcmRpbiBpTVg4TSBQbHVzIChNTUMgaW5pdCBmYWlscyBpbiBVLUJvb3QgcHJvcGVyIC0g
Y2Fubm90IGJvb3QpDQo+IC0gU01BUkMgaU1YOE0gUGx1cyAoTU1DIGluaXQgZmFpbHMgaW4gVS1C
b290IHByb3BlcikNCj4gLSBWZXJkaW4gQU02MiAoYm9vdCBmYWlsdXJlLCBubyBvdXRwdXQpDQo+
IA0KPiBBbGwgcGxhdGZvcm1zIHVzZSBlTU1DIGFuZCB3b3JrZWQgY29ycmVjdGx5IHByaW9yIHRv
IHRoaXMgcmVncmVzc2lvbi4NCj4gDQo+IEJpc2VjdCByZXN1bHRzOg0KPiAtIExhc3Qga25vd24g
Z29vZCBjb21taXQ6IDIyODgxMGQwYmFjMw0KPiAtIEtub3duIGJhZCBjb21taXQ6IDM2YWVlYjU5
MWIwZA0KPiANCj4gQmV0d2VlbiB0aGVzZSBjb21taXRzLCBzZXZlcmFsIE1NQy1yZWxhdGVkIGNo
YW5nZXMgd2VyZSBtZXJnZWQuDQo+IFRoZXNlIHNlZW0gcGFydGljdWxhcmx5IHJlbGV2YW50Og0K
PiBjb21taXQgYWViYjUyM2EyMzgxICgibW1jOiBtbWMtdWNsYXNzOiBVc2UgbWF4LWZyZXF1ZW5j
eSBmcm9tDQo+IGRldmljZSB0cmVlIHdpdGggZGVmYXVsdCBoYW5kbGluZyIpIGNvbW1pdCAxZTQw
ZTQxOWFlYjIgKCJtbWM6DQo+IHNkaGNpLWNhZGVuY2U6IFVzZSBtYXgtZnJlcXVlbmN5IHByb3Bl
cnR5IGZyb20gZGV2aWNlDQo+IHRyZWUiKQ0KPiBjb21taXQgZmE3ZTgyMTI3ZmFkICgibW1jOiBz
ZGhjaS1jYWRlbmNlOiBTZXQgY29udHJvbGxlciBhbmQgUEhZDQo+IHNwZWVkIG1vZGVzIGZvciBT
RCBhbmQgZU1NQyBjYXJkcyIpDQoNClRoYW5rcyBmb3IgdGhlIHJlcG9ydC4gSSBtZWV0IHNhbWUg
aXNzdWUgb24gaS5NWDkzLCBjaGVja2luZy4uDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IENv
dWxkIHNvbWVvbmUgZmFtaWxpYXIgd2l0aCB0aGVzZSByZWNlbnQgY2hhbmdlcyBoZWxwIGlkZW50
aWZ5IHdoYXQNCj4gbWlnaHQgaGF2ZSBjaGFuZ2VkIGluIHRoZSBtb2RlIHNlbGVjdGlvbiBsb2dp
Yz8NCj4gDQo+ID09PSBFeGFtcGxlIGxvZ3MgPT09DQo+IA0KPiBWZXJkaW4gaU1YOE0gTWluaSAo
U1BMIGZhaWx1cmUpOg0KPiANCj4gVS1Cb290IFNQTCAyMDI2LjAxLTAuMC4wLWRldmVsK2dpdC41
M2MwZDViMzg3OTUgKEphbiAwNiAyMDI2IC0NCj4gMjA6NDQ6MjcgKzAwMDApDQo+IFdEVDogICBT
dGFydGVkIHdhdGNoZG9nQDMwMjgwMDAwIHdpdGggc2VydmljaW5nIGV2ZXJ5IDEwMDBtcw0KPiAo
NjBzIHRpbWVvdXQpDQo+IFNFQzA6ICBSTkcgaW5zdGFudGlhdGVkDQo+IFRyeWluZyB0byBib290
IGZyb20gTU1DMQ0KPiB1bmFibGUgdG8gc2VsZWN0IGEgbW9kZTogLTUNCj4gc3BsOiBtbWMgaW5p
dCBmYWlsZWQgd2l0aCBlcnJvcjogLTUyNA0KPiBFcnJvcjogLTUyNA0KPiBTUEw6IFVuc3VwcG9y
dGVkIEJvb3QgRGV2aWNlIQ0KPiBTUEw6IGZhaWxlZCB0byBib290IGZyb20gYWxsIGJvb3QgZGV2
aWNlcyAjIyMgRVJST1IgIyMjIFBsZWFzZSBSRVNFVA0KPiB0aGUgYm9hcmQgIyMjDQo+IA0KPiAt
LS0NCj4gDQo+IFZlcmRpbiBpTVg4TSBQbHVzIChVLUJvb3QgcHJvcGVyIGZhaWx1cmUpOg0KPiAN
Cj4gVS1Cb290IFNQTCAyMDI2LjAxLTAuMC4wLWRldmVsK2dpdC41M2MwZDViMzg3OTUgKEphbiAw
NiAyMDI2IC0NCj4gMjA6NDQ6MjcgKzAwMDApIEREUiBjb25maWd1cmVkIGFzIGR1YWwgcmFuaw0K
PiBXRFQ6ICAgU3RhcnRlZCB3YXRjaGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVyeSAx
MDAwbXMNCj4gKDYwcyB0aW1lb3V0KQ0KPiBTRUMwOiAgUk5HIGluc3RhbnRpYXRlZA0KPiBOb3Jt
YWwgQm9vdA0KPiBUcnlpbmcgdG8gYm9vdCBmcm9tIEJPT1RST00NCj4gQm9vdCBTdGFnZTogUHJp
bWFyeSBib290DQo+IEZpbmQgaW1nIGluZm8gMHg/LCBzaXplIDEyMDgxNTE1NTINCj4gTmVlZCBj
b250aW51ZSBkb3dubG9hZCAxMDI0DQo+IGxvYWRfc2ltcGxlX2ZpdDogU2tpcCBsb2FkICd0ZWUn
OiBpbWFnZSBzaXplIGlzIDAhDQo+IE5PVElDRTogIERvIG5vdCByZWxlYXNlIEpSMCB0byBOUyBh
cyBpdCBjYW4gYmUgdXNlZCBieSBIQUINCj4gTk9USUNFOiAgQkwzMTogdjIuMTIuMChyZWxlYXNl
KTpsZi02LjEyLjIwLTIuMC4wLWRpcnR5DQo+IE5PVElDRTogIEJMMzE6IEJ1aWx0IDogMDg6MTU6
MDcsIE1heSAgOSAyMDI1DQo+IA0KPiBVLUJvb3QgMjAyNi4wMS0wLjAuMC1kZXZlbCtnaXQuNTNj
MGQ1YjM4Nzk1IChKYW4gMDYgMjAyNiAtDQo+IDIwOjQ0OjI3ICswMDAwKQ0KPiANCj4gQ1BVOiAg
IE5YUCBpLk1YOE1QWzhdIFJldjEuMSBBNTMgYXQgMTIwMCBNSHoNCj4gQ1BVOiAgIEluZHVzdHJp
YWwgdGVtcGVyYXR1cmUgZ3JhZGUgKC00MEMgdG8gMTA1QykgYXQgMjNDDQo+IERSQU06ICA4IEdp
Qg0KPiBDb3JlOiAgMzA5IGRldmljZXMsIDMxIHVjbGFzc2VzLCBkZXZpY2V0cmVlOiBzZXBhcmF0
ZQ0KPiBXRFQ6ICAgU3RhcnRlZCB3YXRjaGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVy
eSAxMDAwbXMNCj4gKDYwcyB0aW1lb3V0KQ0KPiBNTUM6ICAgRlNMX1NESEM6IDEsIEZTTF9TREhD
OiAyDQo+IExvYWRpbmcgRW52aXJvbm1lbnQgZnJvbSBNTUMuLi4gdW5hYmxlIHRvIHNlbGVjdCBh
IG1vZGU6IC01DQo+IA0KPiBWZXJkaW4gaU1YOE1QICMgc2F2ZWVudg0KPiBTYXZpbmcgRW52aXJv
bm1lbnQgdG8gTU1DLi4uIHVuYWJsZSB0byBzZWxlY3QgYSBtb2RlOiAtNSBObyBibG9jaw0KPiBk
ZXZpY2UgRmFpbGVkICgxKQ0KPiANCj4gLS0tDQo+IA0KPiBTTUFSQyBpTVg4TSBQbHVzOg0KPiAN
Cj4gVS1Cb290IFNQTCAyMDI2LjAxLTAuMC4wLWRldmVsK2dpdC41M2MwZDViMzg3OTUgKEphbiAw
NiAyMDI2IC0NCj4gMjA6NDQ6MjcgKzAwMDApIFRyYWluaW5nIEZBSUxFRCBERFIgY29uZmlndXJl
ZCBhcyBzaW5nbGUgcmFuaw0KPiBTRUMwOiAgUk5HIGluc3RhbnRpYXRlZA0KPiBOb3JtYWwgQm9v
dA0KPiBUcnlpbmcgdG8gYm9vdCBmcm9tIEJPT1RST00NCj4gQm9vdCBTdGFnZTogUHJpbWFyeSBi
b290DQo+IEZpbmQgaW1nIGluZm8gMHg/LCBzaXplIDEyMDgxNTIwNjQNCj4gTmVlZCBjb250aW51
ZSBkb3dubG9hZCAxMDI0DQo+IGxvYWRfc2ltcGxlX2ZpdDogU2tpcCBsb2FkICd0ZWUnOiBpbWFn
ZSBzaXplIGlzIDAhDQo+IE5PVElDRTogIERvIG5vdCByZWxlYXNlIEpSMCB0byBOUyBhcyBpdCBj
YW4gYmUgdXNlZCBieSBIQUINCj4gTk9USUNFOiAgQkwzMTogdjIuMTIuMChyZWxlYXNlKTpsZi02
LjEyLjIwLTIuMC4wLWRpcnR5DQo+IE5PVElDRTogIEJMMzE6IEJ1aWx0IDogMDg6MTU6MDcsIE1h
eSAgOSAyMDI1DQo+IA0KPiBVLUJvb3QgMjAyNi4wMS0wLjAuMC1kZXZlbCtnaXQuNTNjMGQ1YjM4
Nzk1IChKYW4gMDYgMjAyNiAtDQo+IDIwOjQ0OjI3ICswMDAwKQ0KPiANCj4gQ1BVOiAgIE5YUCBp
Lk1YOE1QWzhdIFJldjEuMSBBNTMgYXQgMTIwMCBNSHoNCj4gQ1BVOiAgIEluZHVzdHJpYWwgdGVt
cGVyYXR1cmUgZ3JhZGUgKC00MEMgdG8gMTA1QykgYXQgMjNDDQo+IERSQU06ICA0IEdpQg0KPiBD
b3JlOiAgMzE3IGRldmljZXMsIDMyIHVjbGFzc2VzLCBkZXZpY2V0cmVlOiBzZXBhcmF0ZQ0KPiBX
RFQ6ICAgU3RhcnRlZCB3YXRjaGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVyeSAxMDAw
bXMNCj4gKDYwcyB0aW1lb3V0KQ0KPiBNTUM6ICAgRlNMX1NESEM6IDEsIEZTTF9TREhDOiAwDQo+
IExvYWRpbmcgRW52aXJvbm1lbnQgZnJvbSBNTUMuLi4gdW5hYmxlIHRvIHNlbGVjdCBhIG1vZGU6
IC01DQo+ICoqKiBXYXJuaW5nIC0gTm8gYmxvY2sgZGV2aWNlLCB1c2luZyBkZWZhdWx0IGVudmly
b25tZW50IHVuYWJsZSB0bw0KPiBzZWxlY3QgYSBtb2RlOiAtNSBNTUMgaW5pdCBmYWlsZWQNCj4g
LS0tDQo+IA0KPiBJJ20gYXZhaWxhYmxlIHRvIHRlc3QgcGF0Y2hlcyBvciBwcm92aWRlIGFkZGl0
aW9uYWwgZGVidWcgb3V0cHV0IGlmDQo+IG5lZWRlZC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
Vml0b3IgU29hcmVzDQo=
