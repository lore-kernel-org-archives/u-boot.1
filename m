Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6781C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 04:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5D6817C4;
	Wed,  2 Apr 2025 06:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K0H1a+AC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F06E81ECD; Wed,  2 Apr 2025 06:37:32 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1747A80584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 06:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS9R57/tDiDXEswit5Vm725cp5tPx9s36kRRtTJ7zwYL/+DzagKZY6+SL4MZ34vVcy51WeyIjE1D9cicm3WkKepyGuxkZWPl+CCKR9IsYTOl+J/KubX2f2KGNELLc7lyVDt4qZeDOMYvpGbnmjvq3nymEucmeFqEs8ApMHUthOSbevKtpc1K7GAsEqI4rTeV6k/77O9DYdqq2DP0QHlRtSZDrvLYsnXzcpdllCqh4HGIa5LpVsZudwmTPOQhgwYRt29NO09fOy3npnE6RlL46J5RunHWX6y3i8Vh1/vrHKR4f5y4uNLcR2xtVMl8kFaRyIS6NDw9gJI65LrVd4ly8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4igx4myEt340QpaD2b12m5L+R4/8KgUMttfZ+JIU1A=;
 b=zLSbcvgqX4fKWNOSkD+1q5Qmo8MF50M4prKSBbafhqM0EleIVNHYdWBb5bxT3QDjjCmGl7OPtVo0XBkFUhK+gJnGTHWf1pNiNuj62QYKy5fJtf7/tpM2pHMPhbUYOgYbtfULhNce8yGBCiItzYDjSuKn/091y/Mj0Q0yD3idxOpI5DV/ViGMOG9ti4ZMzD7QiFZErgG2sIXyRB0SFM7zNha4Oo/MAw/LEmBsfshhMnNLN2S9n4x950Gj8vuwIE8pp54wMsuZ4lhJUvbBEqR5pNbVQ/Ka59/saNfoulGl+JBWKeXcVN+7byQW9wZXX2my10Euo7SLv1vPtHCdVa6bkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4igx4myEt340QpaD2b12m5L+R4/8KgUMttfZ+JIU1A=;
 b=K0H1a+ACI9gl6ROWgoP+D4qisVrZ5YU530It2CnGlkzXFtkZkmLItRV/uBs9ucMU0ZBYvXMcNrEOC9bsRPZGCGkwdAdHTk8MGsJEufJ4JCDNDq7wbcJvKGQ6OPm+XKEHaIvoQ6WVrBbo+mbcsdngVJCI7DSMBQSu2S166gMDVdRRN6ly0C9++zXqENj/wDl2vWEzticDnBLLi+Qor7MRfsTrU56WYoz5bpeQgstDAxnPN1yVnwL3x6mZnJ3/gFcoZJvWE9YRgzlFznXqwEfKC408KB6QvFc2XkNwlxVRMs7+NmB3tW1apOC7Cr4UA0nkHo1591qA3PgKDlc5xaY39A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10444.eurprd04.prod.outlook.com (2603:10a6:102:448::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 04:37:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 04:37:28 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogc3VwcG9ydCB0byBtYW5h?=
 =?gb2312?B?Z2UgU0NNSSBwcm90b2NvbCBkcml2ZXJzIHdpdGggYSBsaW5rZXItZ2VuZXRh?=
 =?gb2312?Q?ted_array?=
Thread-Topic: [PATCH] firmware: scmi: support to manage SCMI protocol drivers
 with a linker-genetated array
Thread-Index: AQHbo4i+l9AuMbKCAkKZjW7dwQY1urOPyo1g
Date: Wed, 2 Apr 2025 04:37:28 +0000
Message-ID: <PAXPR04MB9644939282B69AC2020F79BDE2AF2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250402043521.3908918-1-alice.guo@oss.nxp.com>
In-Reply-To: <20250402043521.3908918-1-alice.guo@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA1PR04MB10444:EE_
x-ms-office365-filtering-correlation-id: 152b7487-636b-4579-9658-08dd71a0131c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?gb2312?B?VURKWERFMTB0Z0NrcDNsRkFReGxBbU0rS3FYcWYySSs2SUFOVHZNNmRPVkVY?=
 =?gb2312?B?S1puazlNVitGamJoa3pXckpjS2Z6Q0xHbHQ3aHR0TXBoRi9vTk1lVEUzYUYx?=
 =?gb2312?B?djhKY0RVcjNRYjdnVm0vNGRwY1FVTG54aEVyT0gxQ1BwOG54TzNlSXd5Wndy?=
 =?gb2312?B?OXh3TnBkdGY3bldycDNmNSt6dTV5MS9oR1BJakhvUkZtaVA3eU9aTnFmKyty?=
 =?gb2312?B?cWw5YjZhSkdYWXNFeCtTdUx1ZnRHUEdZa000aklWeFJxcklhd2dYUFp3bGZi?=
 =?gb2312?B?Yy9veHNTK1VTQVRiK0VZaG1TcEJUUW9TdThRdEtOa0orZXB4eUhEeVRRdG1O?=
 =?gb2312?B?ZzBqZWFSSUhnVFp4TlVBYTNtazNJMFFpVVcwQldDbnpGYk1HV2tZYVB2emkz?=
 =?gb2312?B?MDh4V01Eb2hTTzVaWHlWelZPTmZtc0JqWEE1cGtOL0Y3NXNBZ0JSb0IvNmJX?=
 =?gb2312?B?ZWNzcElmWE1UbG9idm1NV3hsZlptU0E0bEllazZjVURDSldaZ3lKMGlGbXhz?=
 =?gb2312?B?cG5XUGVnUGZ1ZXRCOUJGN2czdVJrU0hEZVFMeXI4L09SeUhMeStvSEdoQ2JW?=
 =?gb2312?B?SE5CRTY0cU5qOVQ2OVEyeEdoSHV2dXpFUXgzMTV6em1xSmZ6V2JTc2VrVjVm?=
 =?gb2312?B?UjJEQjNVcGlTRi9pdjZ4amZiaGpuRTEvakRNY2JHeVFSdTNEeFM3N0N2eERq?=
 =?gb2312?B?OHhCUUVIWGFyR0ZKN2F6YVBUQVBmWHZrdU5mQWkrbGpGdW1aQ0RxWVE0WmRl?=
 =?gb2312?B?a3NWaUFTa0JtdXJ6aFZiWGhQSExIcjZVRjg4NWh4bkFQcU51bHUrVTZHcldh?=
 =?gb2312?B?YXhML2RLT1R4RmtXZEoxT2c4aDdtYll2ak5zSmVML0RhRmRtVDFmaXc1WWJw?=
 =?gb2312?B?LzBhUnhyays3TVZ4SVlOVUd6dE5iNkxzRTkzRlJyK2JwV0gvU2ZkYm16QkRw?=
 =?gb2312?B?ZkNTWTRqN1FBQWdQVVE4WmovdVk3b2pFLzJHUXF4STljVVVuaE03bzNlWDZz?=
 =?gb2312?B?VDhhSUM4YmtFbFdKWVJCeTJNbDRoOGI2R21LOEx6ck9kZXdoL2NDRlZyWUVP?=
 =?gb2312?B?bEdOYXBIRXV6NVFuVlVnWm5Kd29rQzBQTWdLNFI3UFZ2clZOQ1FSQ1pCNVBk?=
 =?gb2312?B?RTVpcWZOakZvRURhdFcrOHA0cjNKUHArN01FMWR0amFGREtNZjVjaWI2YTdr?=
 =?gb2312?B?d2FyeG5lNDU2NkVDcHlTUnVZek45eDlRMm9uNWh5bmQ5RlEyU0lCL1kwUi9F?=
 =?gb2312?B?VUJFR2FNTmNtSzZqdkxEMk4yTW5VTHRlTUkzYm96Vkc3bjlYVmMyTkRoNjRw?=
 =?gb2312?B?cDRjemNkcXNiLy9xTmkrUC9FbmdKMUZVWExlVmk2TERON0I5MjBKNTNsc0tG?=
 =?gb2312?B?Z3l0MTk4eTBseDFiemhxSWloc29DTTlrRVpVWmJvTVZKL296RE5BemFldmdm?=
 =?gb2312?B?czU2UGt3ZGtkR1pyeGI3b1JKMDFpL0FlMmR6RWZuR2JaWXZyQVFuZmVKeVhp?=
 =?gb2312?B?VmlSYjZkS3VHZzJuZGVpQUdjK1ZlV2RQdFhkT2lOWXF6R2dQOU9YcGpmcXdS?=
 =?gb2312?B?N1lwZjd6aXlrMHUxMzJEMCtBL08zU2Vpa3BFdTRtYlFBZGRtVkJsRUxQYjhy?=
 =?gb2312?B?eXo3WkMrVUZ0SUxaODdSYmFkNlBQYlRDYVFOL3ZmTlpSSU1sNFI1eDRrTTkr?=
 =?gb2312?B?Qjg2OTcyZEhSR01rUyszMUxqeGhiTHdUekZDbUxaSXFjcWJYMDJSRFF6Kytk?=
 =?gb2312?B?ckdaaWRiVXpYTForVFpHem9hc3cxbXhBTGM2eG5jSjZUcFBqTkJZRlNMR1RD?=
 =?gb2312?B?Nm9pYnhBTFJHSkkwTGRTUkJsZGw0aElNME84TUFTOWpIdjFxNnl3N0haL0h4?=
 =?gb2312?B?WEZyT0dMTVNmNDRnelRDa3owWnFzenFSd0ZtQWVsSzUzV2FqTXRyTEl4NzA4?=
 =?gb2312?Q?zg0pZPZd3p0GscJFND2GxYVQG447GDrx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UmxJNkxkTERFT1p3UjJZOGJLTllsNGZWaDRXU0NXdDFNazlRZU9odVVCMjVY?=
 =?gb2312?B?SUs0cW5lVnIvZjYyenFYZlk3aStYOTlNbEx0TjgyWVVYdnltemdqWVVSTWlU?=
 =?gb2312?B?VnhVU1VQRDQxME45VmhmWk4wdVFmUTF5VTQrQ21OdklzUjNpN3NBZjJqVTM1?=
 =?gb2312?B?MTY1WGkxZTJMV2htV2x6ZDFjdTFRL0RjVm1jUVp3bUxzM1FmdFp4bnpUYTU1?=
 =?gb2312?B?a1FvQ0tPZHdNRmdIV0RNMVdIejE0UVNWcDEvTXlKemZHNC9EbGROcjJCRXNG?=
 =?gb2312?B?SEZGa0RrbDBCT2JibFFLZml4eTlIbzBaTThLWHduK2MzRCtYM00vQnJCbDcy?=
 =?gb2312?B?L2ZDYktHblpBc0IxcEtpai9CNWhGOEFJZmRDZmZWKzdBTGFmZzdOTkxhcFo0?=
 =?gb2312?B?Mnp0OU9lT016SVptd3BmTEtRc2VXUXloU0o2d0VENGN4Z2YxNWJrTUVERE41?=
 =?gb2312?B?SlBiVS9uSyt3eXNyTXBQNG1wdlIwSnJaZlZmaGlvS080eUoyR1h1Smc5Qmcr?=
 =?gb2312?B?UElGNzVWdS8yaUNXbnA4dzFFS2xWdXRvK3k0WW43emdtNWl5T1pLVWduWldo?=
 =?gb2312?B?SVFXdU9PbSttTXpPRXZSbkRPMTZGYkNKL1ROdVlGY0JoQ2RDSG44RmtESThC?=
 =?gb2312?B?WXRXcVVWd0xydTRKOHVUQzVGQ2pGUm1JWWZYVWFwdUV6WXpGR3hnSkFtcXhU?=
 =?gb2312?B?WEdqL1NoQ2hGcCtpSE1PMjRVazFhSWZad3BNZGlBbWRleStUb3duVjdTZjhm?=
 =?gb2312?B?OXRtd1NYalpWN3B0b3U5K1FYRTRIc2NzT2xmMld3RG1OdGx2blk2aFhYaU5q?=
 =?gb2312?B?TkprU21pSDRVUWVMeFVvZTZSdk1ET2syeG1yTXlsTEZGZ0Q2cGZFU3ZieWNx?=
 =?gb2312?B?WHVOWFZVU2E5MGRSckF1SUpGbDJ4aXlRdzNnaC9xOU9ROXBkNEF6NkwyWFVB?=
 =?gb2312?B?Qk54UzRiQ1dqVG9vVjNtZzVFNU9jQWFjRW85TGhIMTVYbitDeWpQUkFrQkZL?=
 =?gb2312?B?Wm56Ynp5eFRNcVczT05ibGhUWElPWlA0N1Z3NWh5MmZhR1V4NmhvUlNERW9X?=
 =?gb2312?B?OUx5KzcyVjE0NVdVd294M0R1V01LL25uUytpQjJ4UkxOUDdhQmR4bm1OaDJW?=
 =?gb2312?B?ZHkwSS9QWVpoYlF1RGFscDlQSklTbXA5VEdqZFJKOWl2dUwySTZNVjYxZE9P?=
 =?gb2312?B?eEo5N0M0ZXN1cVJaTHFIL2pBT2lpUFRzQUZ1V1ZSdVZ2Qkd5SThlQjkyWEtQ?=
 =?gb2312?B?UFA2aklVdWZySzJyNVdLa0lrWW1GSEJlV1REY3k5YTBsS2ZPd3FNeGFIdWdL?=
 =?gb2312?B?ZVpnc3B3RWN5SjBJbHJOQUlLUW9TRUdnQUFQNVJEV3o4VVRsaUNqZzlRSlRG?=
 =?gb2312?B?cVhMbHdVNVlQc0hwQitzemE4dkFVUW9vQnNlQXVMNC9CWlB6Mjk3dlNEMldu?=
 =?gb2312?B?aDNHcEpVUWRUeUNEUjQyMTVLLzBQMmVXaFlDM3dHV0c0NmFWSGxuTXpDY2pi?=
 =?gb2312?B?UjVKeGlSNGRXNHFUUVNncThDOUdZWnV4aVdVdFMxbkpHbG1oVVo3bklENjBx?=
 =?gb2312?B?cUtXbE5EbWJLM1FLODJWdDcxODVXUTZLUktLNHRwWldiNElMakpOZ0d6YUIz?=
 =?gb2312?B?WkdqMWNNMzFjOUFRb2xWZC9XRDlwRGg3Z091OXFHM29KdURuSnFrQU41Njlr?=
 =?gb2312?B?aVFTV01ZRWRKWjYyYmFOWGFreTVvK3RycFIxRHl1MEEweTh4aXVzQzc0MmxU?=
 =?gb2312?B?Ui9UZE9tcitNZmIxcDhtUXllOGlpSjJRSmJRK2EwNTNaM1VCd3JOYi9xanVB?=
 =?gb2312?B?TEZFT0dzaWMyd2VRNXJMU005U25jR2ViYmhpTGRId1VuR1hUUHRwWWtnYnpQ?=
 =?gb2312?B?bG5WQ24wZEp2QnBEUllOVHdna1RrYmNkNDUrT21DSEtNdU9Ldm5GaUwvYng4?=
 =?gb2312?B?NEh3emRaSTQ0S25BSW9SQnZOWEY2V3dBMVhqM2JFWWpidHNaLzk3dUFUM1pV?=
 =?gb2312?B?bS9yWnRUamNhYW1VVWIvSXpvYXNCczZIcCthSGhYbGhDOHg3eVlRYzBvNXB2?=
 =?gb2312?B?ZW9MMStSd2dRWk8vTng2REZ0RWJIQ0F0d0x4cnpVcGM0V2pZR1hZNjBOaUkw?=
 =?gb2312?Q?W5p50RAS/54ZpKrVAUplIe4iR?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152b7487-636b-4579-9658-08dd71a0131c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 04:37:28.5302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZT8Nm8B9dGSeBVyh8alKjYjDrOr+0p8qMY1UrltBAozyph+Oq+GWUvf7B8M/h3hpiYQOB5Ombm4YYl0XGVYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10444
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

KyBNYXJlayBWYXN1dA0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IEFsaWNlIEd1
byAoT1NTKQ0KPiC3osvNyrG85DogMjAyNcTqNNTCMsjVIDEyOjM2DQo+IMrVvP7IyzogdHJpbmlA
a29uc3Vsa28uY29tOyBmZXN0ZXZhbUBnbWFpbC5jb20NCj4gs63LzTogdS1ib290QGxpc3RzLmRl
bnguZGUNCj4g1vfM4jogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogc3VwcG9ydCB0byBtYW5hZ2Ug
U0NNSSBwcm90b2NvbCBkcml2ZXJzIHdpdGggYQ0KPiBsaW5rZXItZ2VuZXRhdGVkIGFycmF5DQo+
IA0KPiBGcm9tOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiANCj4gVV9CT09UX1ND
TUlfUFJPVE9fRFJJVkVSIG1hY3JvIGlzIHVzZWQgdG8gYWRkIGEgU0NNSSBwcm90b2NvbCBkcml2
ZXIgdG8NCj4gc2NtaV9wcm90b19kcml2ZXIgbGlzdC4gc2NtaV9wcm90b19kcml2ZXJfZ2V0KCkg
ZnVuY3Rpb24gY2FuIGJlIHVzZWQgdG8gbWF0Y2ggYQ0KPiBTQ01JIHByb3RvY29sIGlkIGFuZCBp
dHMgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9Abnhw
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Zpcm13YXJlL3NjbWkvc2NtaV9hZ2VudC11Y2xhc3Mu
YyB8IDE2ICsrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvc2NtaV9hZ2VudC11Y2xhc3MuaCAg
ICAgICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMx
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3NjbWkv
c2NtaV9hZ2VudC11Y2xhc3MuYw0KPiBiL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zY21pX2FnZW50
LXVjbGFzcy5jDQo+IGluZGV4IGU2ZTQzYWU5MzZhLi5lYTc5Y2ZhMGNmMiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9maXJtd2FyZS9zY21pL3NjbWlfYWdlbnQtdWNsYXNzLmMNCj4gKysrIGIvZHJp
dmVycy9maXJtd2FyZS9zY21pL3NjbWlfYWdlbnQtdWNsYXNzLmMNCj4gQEAgLTM1Miw2ICszNTIs
MjIgQEAgc3RhdGljIGludCBzY21pX2ZpbGxfYmFzZV9pbmZvKHN0cnVjdCB1ZGV2aWNlICphZ2Vu
dCwNCj4gc3RydWN0IHVkZXZpY2UgKmRldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICtz
dGF0aWMgc3RydWN0IGRyaXZlciAqc2NtaV9wcm90b19kcml2ZXJfZ2V0KHVuc2lnbmVkIGludCBw
cm90b19pZCkgew0KPiArCXN0cnVjdCBzY21pX3Byb3RvX2RyaXZlciAqc3RhcnQsICplbnRyeTsN
Cj4gKwlpbnQgbl9lbnRzOw0KPiArDQo+ICsJc3RhcnQgPSBsbF9lbnRyeV9zdGFydChzdHJ1Y3Qg
c2NtaV9wcm90b19kcml2ZXIsIHNjbWlfcHJvdG9fZHJpdmVyKTsNCj4gKwluX2VudHMgPSBsbF9l
bnRyeV9jb3VudChzdHJ1Y3Qgc2NtaV9wcm90b19kcml2ZXIsIHNjbWlfcHJvdG9fZHJpdmVyKTsN
Cj4gKw0KPiArCWZvciAoZW50cnkgPSBzdGFydDsgZW50cnkgIT0gc3RhcnQgKyBuX2VudHM7IGVu
dHJ5KyspIHsNCj4gKwkJaWYgKGVudHJ5LT5tYXRjaC0+cHJvdG9faWQgPT0gcHJvdG9faWQpDQo+
ICsJCQlyZXR1cm4gZW50cnktPmRyaXZlcjsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gTlVMTDsN
Cj4gK30NCj4gKw0KPiAgLyoNCj4gICAqIFNDTUkgYWdlbnQgZGV2aWNlcyBiaW5kcyBkZXZpY2Vz
IG9mIHZhcmlvdXMgdWNsYXNzZXMgZGVwZW5kaW5nIG9uDQo+ICAgKiB0aGUgRkRUIGRlc2NyaXB0
aW9uLiBzY21pX2JpbmRfcHJvdG9jb2woKSBpcyBhIGdlbmVyaWMgYmluZCBzZXF1ZW5jZSBkaWZm
DQo+IC0tZ2l0IGEvaW5jbHVkZS9zY21pX2FnZW50LXVjbGFzcy5oIGIvaW5jbHVkZS9zY21pX2Fn
ZW50LXVjbGFzcy5oIGluZGV4DQo+IDMzZTBlMThjMzBkLi44NDJjNTY4NThhZiAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9zY21pX2FnZW50LXVjbGFzcy5oDQo+ICsrKyBiL2luY2x1ZGUvc2NtaV9h
Z2VudC11Y2xhc3MuaA0KPiBAQCAtMTE1LDQgKzExNSwxOSBAQCBzdHJ1Y3Qgc2NtaV9hZ2VudF9v
cHMgew0KPiAgCQkJICAgc3RydWN0IHNjbWlfbXNnICptc2cpOw0KPiAgfTsNCj4gDQo+ICtzdHJ1
Y3Qgc2NtaV9wcm90b19tYXRjaCB7DQo+ICsJdW5zaWduZWQgaW50IHByb3RvX2lkOw0KPiArfTsN
Cj4gKw0KPiArc3RydWN0IHNjbWlfcHJvdG9fZHJpdmVyIHsNCj4gKwlzdHJ1Y3QgZHJpdmVyICpk
cml2ZXI7DQo+ICsJY29uc3Qgc3RydWN0IHNjbWlfcHJvdG9fbWF0Y2ggKm1hdGNoOw0KPiArfTsN
Cj4gKw0KPiArI2RlZmluZSBVX0JPT1RfU0NNSV9QUk9UT19EUklWRVIoX19uYW1lLCBfX21hdGNo
KSBcDQo+ICsJbGxfZW50cnlfZGVjbGFyZShzdHJ1Y3Qgc2NtaV9wcm90b19kcml2ZXIsIF9fbmFt
ZSwgc2NtaV9wcm90b19kcml2ZXIpID0NCj4geyBcDQo+ICsJCS5kcml2ZXIgPSBsbHN5bShzdHJ1
Y3QgZHJpdmVyLCBfX25hbWUsIGRyaXZlciksIFwNCj4gKwkJLm1hdGNoID0gX19tYXRjaCwgXA0K
PiArCX0NCj4gKw0KPiAgI2VuZGlmIC8qIF9TQ01JX1RSQU5TUE9SVF9VQ0xBU1NfSCAqLw0KPiAt
LQ0KPiAyLjQzLjANCg0K
