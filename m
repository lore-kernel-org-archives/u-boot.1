Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C6BCA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 03:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356BE81FEE;
	Thu, 21 Aug 2025 05:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RrLUKK4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3645982E37; Thu, 21 Aug 2025 05:37:40 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9FB81E13
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 05:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPQcBTMWDVDeTAfWGGjwZ0jEMBRTgkUSgdoEI4akEuRIEhx6SOQnOq+sNI+oo1lEYLpGdoqO8AzCdQNDKgsCYrHmYcPox1JAylchRgGr6FeRPkxJbPdgOUVDxNxZVpODPs97IvwGahMxICWcQFCD9BspybxNW1PMmW9lsDPQsA5C9RATjBb9PxDhEANPpqOMxaEfk2XDRJwiGwi2APrSgGU8HR2zOm/fuhOzCccF71p6rRdRG5GPPDr+8QYgPymb0uXA2Hvn8eXZlUZEXM86xKXy4WX0louf9WYlNkSD8cm/X8uZzqiJ6JtXUgOPLAQ+SdaRoJ1Y67eh2Ukx6FchXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv4dIEgiHromdqbkPl/Xve+x1JBfMZZsDucZm+BBoSM=;
 b=uE20pudEMN9LB6JHCnVmkC5JtIfBoy+IcqkCJmCMBzEiOktcfh6eLEvFbkl63j3UUNN5cwHpFZhzGeT0xSFgilVHoDhyQUrJQ6RPKyTlPAg2O66CCnOvU1vcAfCY/+BgSkoOVUBJX167hFcXpjbW2AYljkxqCPkheInQ4fbo/AKWWU/zSogG6nwzhRXhcW1SzZE27jvSM466si273zgYvp6KxbGAGbts1Mj6NiE533cx+zKepDo9Jrb0DINZGAAonlcKPx/UeUddV1FORGVp0fLSONQ5WoZ3CAP8PbDsCcrrvnvU9MmTiIpxK/EKKcAU9ZHvVCYAkbAVAC7vTLnR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv4dIEgiHromdqbkPl/Xve+x1JBfMZZsDucZm+BBoSM=;
 b=RrLUKK4iZls8T337pBBY9PRjLonkLtdQzQr2cfDd+aNgd4TqcPWvGvkxt4XYQIVsaGENOqeBRm6aYP4S6ZCAkYyUx0aL5fywWCFbK5cHsqx3bII4klhYyulYuETIBjaM19I9SVl5oAKWdHqd4ExaE9d94eSZZXfFQq6Qu6X5dSnKo7a1h6D+6eCe7N4D3C4pjqw+h68Z4HzKomqaZMm84syc5/8R+mg5Q+HGWToMHDgRQLiUiVQb+7JC/Q2cBj2U9lJ3TlYsWpoQvmtbpNdRJwXE8dE+ZKkh8k/Da0Mz9v0slg9H1gS9F1s5En57DauNcPqtVJkUL2Sx8mFwnh5sJA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB9109.eurprd04.prod.outlook.com (2603:10a6:20b:448::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Thu, 21 Aug
 2025 03:37:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 03:37:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Marek Vasut <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjMgMC8yXSBSZXN0b3JlIHN1cHBvcnQgZm9yIGku?=
 =?utf-8?Q?MX95_A0_silicon?=
Thread-Topic: [PATCH v3 0/2] Restore support for i.MX95 A0 silicon
Thread-Index: AQHcEcJJQMVD72oSNEWRDEA5eR7u0bRsR/+AgAAeQ+A=
Date: Thu, 21 Aug 2025 03:37:35 +0000
Message-ID: <PAXPR04MB96443502294D1C7F8D66A26FE232A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
 <CAJ+vNU0q4ogZuNSxCMNPwXq4-ojqi7ss8ABYip0Q-BfSkvaidA@mail.gmail.com>
In-Reply-To: <CAJ+vNU0q4ogZuNSxCMNPwXq4-ojqi7ss8ABYip0Q-BfSkvaidA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS8PR04MB9109:EE_
x-ms-office365-filtering-correlation-id: 6a9d55f5-3e9d-4181-8f68-08dde0641189
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dEJWVEhuS3JlMTRNZVRIRm1EZ1dJdGhvV2NBUThERm5DSnVqeThIdEJOQnpZ?=
 =?utf-8?B?SStkQW9WNk5mYzdBWXpremppVzhRRXE2NlNoVFJicUxxeDM5V2VlOTA3ZVVD?=
 =?utf-8?B?R1lrTXFCYU1zR2VxY1NreDhMZ0xrK3BCd1htcXVJYWUxWStxZnRQaFpvVC9o?=
 =?utf-8?B?OWNNSkhSSHdPTWZDMU5GUFgzdW9YRmMzejQvU0M5Z2Y5ZURncGVEeVhvUDZ5?=
 =?utf-8?B?bW5FVlI1cGg2cy9weW1udjUxVjR1eHJpRDM2ZWlPSEZITkV2UXk4MGQrOXZP?=
 =?utf-8?B?em1mRzBvN3JKYmNvNCtLK1NwSm5SU0NCRUVNOG9BL3JsODl0cHNpUmczS1Ra?=
 =?utf-8?B?RnJVNk9NR2FodVZMM2pEcWpVWmtCQ2YxMnpsVG1NUTF2V0h3Nm56Z2lPZkg0?=
 =?utf-8?B?bncrSUV5U09xQ00yMGtTSjBIcnNUNXN3M1VHemhydTdpdXpNano1QjNOS2Ry?=
 =?utf-8?B?ZDAza09OL0xpOENSMktqaEF2TWludFM0WDVvQVJFbHBqTVlOaXgrWUdBV3RZ?=
 =?utf-8?B?RFQrWmNuV1BDNVE0RUtJakVZMTRYMkN4VEtZSVF6YjZ3QUpXTjRsczlpdUc2?=
 =?utf-8?B?YTJ3L2o4K3dOQ21nSmwwQ1dkaXNaZlc3aDlFVzdSbnpIc1BRZ0hkcjhHbURw?=
 =?utf-8?B?K0FKd3ZtNjFQK3FrWTRhVUVNVUhEb0wzS1R1MG5xTFBVdFdUV2FFN2NjMkFo?=
 =?utf-8?B?UjlKWVMwSXNuRTE3dG00aFNUQWt2MXFZN3RhVTNSM2QwNStRYjVMMHJSdnlM?=
 =?utf-8?B?QmR3SXV1UEhHVXgvMVRHVVR5eUVKTjBsUmhoYVQrZDlLR0gxUmo4bG04dTEx?=
 =?utf-8?B?RGpzdlppN01LUFR1VE1IRHk3bWtyOVJjTm1UTE5RbFQyclFPOTF1SFErV0xY?=
 =?utf-8?B?R2VlUmxwRFBrZmp2V3I1WlZTVjB0U2dJV2FUWFhjL2Z0RnZLd0NBZGVwaERm?=
 =?utf-8?B?cHlVTTJMamkxdlNYbmNpZ3VoaDU4emY3bGwraWJDeU5meFM4R2pOSHMwNEh1?=
 =?utf-8?B?NENBZVpOOWxZZkZLS3lOOGNqQm9lLyswS29zalEwalROVEp3SlJqeFlhMjBr?=
 =?utf-8?B?QVZvbHhQaU0vOUhjcUpOQVB2clBadlEvYlVwNGZrOXZQL0UxVWlETXpzR3Vw?=
 =?utf-8?B?alBneTQrSzVsTnp2dnQ1RWdFRi84M2NReWFENlh2SWIreVNzMnNlQUdjVHVi?=
 =?utf-8?B?OHhhdWxMOGhkdVkyVXM1YVhjOVhvT1l5Zk51Vy9MaG5KcHNZWVJMWHlIbTR0?=
 =?utf-8?B?TmdjRm04U0UzWFZOYlFKVXF6OE5XYi8rWUFjSDJEdTJwQ2twcGZBQVhqcmpa?=
 =?utf-8?B?ZWx5NGVBaC9qb0NrSVQ2Vk5QWXprdnpIbGdRbU1TVDg1aGFyWWhOMHVoNmxM?=
 =?utf-8?B?Vk1nd2wvL0tNTzBTTDB3c1RTYjdDUmh5Sm45eEl3VExTUDVHNkVwYXFwQ3Nh?=
 =?utf-8?B?K2YzTUI4WUsrcEYxRURMdldkb2tTRXZyTXg2MWM0dmtPR3djTk92aEFHWFdp?=
 =?utf-8?B?aWdqVC93VEhRd2Job2JJZW15dGVBdmdOSjBNVWlVeGcwRWtrK2x0dS9MUmVq?=
 =?utf-8?B?cE1vRG1ZYmVKVFlSaFZ1aEgwLzF6NzFwN25CbXhUTTdHN1hzSzA5b096S0Vx?=
 =?utf-8?B?TklPK0hsMDRuN2ZMOU9CUk03QzNjMitpbmhDTzNUeVNyQUt4eDUvKzBiQ1pE?=
 =?utf-8?B?d1lKQmZMbHUwKzRxamEwb1Iyb1JSdThnTkl2VHE1d2VyU2U3aFlraGlVekxF?=
 =?utf-8?B?UWlyVDBoM1NYVnRvVXVHOHl2L0NNSGJjcEo5L2xrVWFPVFMyVkVXVUtzVUdO?=
 =?utf-8?B?YlIyRy9nWHNONmV5TGZhQWJKQnpIc1Y3Um52Nkg3M3pSKzZWdEpOOGJ0TGho?=
 =?utf-8?B?R2h4T29aaVM2MVQ1RGxLdzZvb2lGQ1VNYytjVEJpUk1vRi9nZGJseVh5WCti?=
 =?utf-8?B?c2tyY3ltb0ZlL3JIanBQWGs4b0hqVk5reDZIUnBYaWM4SlRCa1JCUEplU0Jy?=
 =?utf-8?B?L1Evak0yVmdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVFKWVdLMys3bFpEK1hiMno2WUZDK0pHYVhHVURKOU8xQjNkaEZjNDQvbEx4?=
 =?utf-8?B?dnNNV1ZRYmRNeUJPN1VjZEhEM3A4Q3UwYi9rZWVSa1diNjBLNGZmY1pxNEhI?=
 =?utf-8?B?RC9rMW14UXhydVJvK2ZKb0dFcHBjZElLNTAvMkJQWFVqZnUrbHRZb0tFWkNv?=
 =?utf-8?B?bVFtU29JN00wQWM0UWp1aUNGS2hHRk1GYW0rbzlZNjRKYWcxazBIU2NEcGhD?=
 =?utf-8?B?eDNYMXFGN1R4Uzc3VCsrV1U3Y0V0MHpQa2p2VklOeldHM0gwek1uTkxlNlBX?=
 =?utf-8?B?RDNvZkdEYWJMbEFITFQxTmk1S1NLV1JZa25xMVIzZTR4dFVuaFc1WEp1S2ZN?=
 =?utf-8?B?cG40b3NIN3VvNU1hTDZjMnFzZDF1ai9KTUtCcFVpeVBwc3MwQTBwVW4xTVhu?=
 =?utf-8?B?MWtFbitrZ3U3ajVuM3pMSE82VVpLcklFNHRiVmd3aHdmcGppaUlpRE9Gd1F5?=
 =?utf-8?B?RmF2WW1Pc3liMlVlVVBINkdjRDczR0w3TktLd1M1VDExSXhMQ20wOTV0TGFQ?=
 =?utf-8?B?L0g3Tnp6UGRSSjVyT3ROTEtxRUUxci9VWXI2VkZoU09NRnJkYW9FUEM3bEU3?=
 =?utf-8?B?TFRjUFFNMHdrbGFGQW1RSnBjeEFhNXBnNmtORkJsNElrTFRLTFFMd0hhQlF1?=
 =?utf-8?B?Skg3NUVMU08yM1V4MHNOVHl5SjhrcXFTTzRiWnB3bnhLUmlzcmowN3Y1aFBH?=
 =?utf-8?B?bk9TTEplZ2lnVW5IWTB1NTZNTTJyMmVVNHkwMU1STkMrR2hCaHdrSi9uL2hJ?=
 =?utf-8?B?NkdZZkdNazNTYy9Fam95eHZ4OXorK1hTVTVJQzVWdHlLcTI5UUo5Y2pLa1RW?=
 =?utf-8?B?Z0hvNTdmMU4rSmRvOG4rUDRiZHRkSkVIOGh2eDJlbjFDZDJrZ2N4akduZWRB?=
 =?utf-8?B?dG1wL2hwQlRDZDJVSENNdENwV3NTN0JOYjh2bjR2YzhzNy9xUWtBYzBnS2tF?=
 =?utf-8?B?YU9oODFkaUdLT2RabTdwd2t4UWxYMFpvVHY1YkxPR2VmanBSL1ZyRmdWWWdq?=
 =?utf-8?B?YjZaVjJ3bDEyRDB0TTVPeklGY25TazZEanZHUVI1bG5TdlMwbWJ5OWtpNzBC?=
 =?utf-8?B?d2p6TGlVeElXaTR3Tk1XTWcrSEo3UG5xcHBBazVLZ3pSK0N4OGJCU0R3Z01D?=
 =?utf-8?B?eWlBT2tNbkRxVGFzTTNlRHhjcHlJUlV1TkZqN0p0ZG1VQjFxbTFOUHVpSDUz?=
 =?utf-8?B?L29GWXN4RTZBR2VldkpleFBCcy9DNHlibmFsY2l6QVV2cGkxRnhldk1RRXZk?=
 =?utf-8?B?WnQ1d0RHYjJMZ2VWejU3aHF3TnRNdTJGaG9XUGZrOTlSSU4rSzNTZlk1ZGVK?=
 =?utf-8?B?K3JLNXRDaCtBM1U5Q0xDQkN4Q1ZCa3JhUGw0OVFUbUJMY3ZtQTdoUkY3ekpx?=
 =?utf-8?B?NE1iTng2b1RSYUFuUDE0MUhNektybjNFNjdFd0tRc2ZpWnEwa3dQaWx4MENv?=
 =?utf-8?B?YkNTdG9EUVQ4T2hIM0IxbnRPSStPdGdRdTBuSGg4THhSVTNuUDN5b2Rha24r?=
 =?utf-8?B?cTNPQlZRakZTMDc3WFUvZ0ZEQXBxR3Vmd2dJTi83UUtiNGlKQzBXMDJHY3U4?=
 =?utf-8?B?WWxHRTFxRUpqb29uaytVbFo1eVIyd1Z4QmdCUWFvZGY0Ynd6cVYzbDJTQkdn?=
 =?utf-8?B?VHRwRFQ4S3NianNwVlhmVlZXaXluYjZUTDZGZ0NlKzdPQ21SYmxmRTR5RE1P?=
 =?utf-8?B?THVhR3VUWTg2QTcwb0Y2Wmx5SnpUZkNRMk9jbnJ6TG1zNnBNZUQ5Y0hrRHBH?=
 =?utf-8?B?OTBGYm12UjhnL2RBNUJyVjI2OUYvNmI5N2VLVzAxSzRCRElmclQ2a0JkTWdL?=
 =?utf-8?B?TFFZVThVZll0Z25GY09BK2lHVTBqRTdoMThJWVQwMytUTWJwcGkvM3RsK0NV?=
 =?utf-8?B?dE1hWDhOYjZ3bmZ3bTR2bllNamtmdDlNektwZGEyKzZ4djBZb054akJDV0xo?=
 =?utf-8?B?OGE2a0NhWU8wWnE0OXYyWk1XMFBXcjJ4U2l1Tlo0UWp4VjV5eDU1RDMwNGZw?=
 =?utf-8?B?TDliUDQyODRSekpRbEFxMVZMT3V5eEw2cmM5Y1p4MWs2SHN0ZWZPZDBhTlZN?=
 =?utf-8?B?ZlVCZFZhcW1yM0l0YTAyRTFaQjdNbVF1T2d2bjJJSWxscVVuQjdwcVBPVzk2?=
 =?utf-8?Q?e50w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9d55f5-3e9d-4181-8f68-08dde0641189
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 03:37:35.1586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wG56SIkoOYBPD20fkWGoqATpXpZvMBj/+ircj3HgzSD/7GyZ5n6BdWygPuMcN9qv3Z0V1KIOZpEMjCFtOlnCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9109
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVGltIEhhcnZleSA8dGhhcnZl
eUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ45pyIMjHml6UgODo1Mg0K
PiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiDm
ioTpgIE6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBTaW1vbiBHbGFzcyA8c2pnQGNo
cm9taXVtLm9yZz47IEFscGVyDQo+IE5lYmkgWWFzYWsgPGFscGVybmViaXlhc2FrQGdtYWlsLmNv
bT47IFN0ZWZhbm8gQmFiaWMNCj4gPHNiYWJpY0BuYWJsYWRldi5jb20+OyBGYWJpbyBFc3RldmFt
IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29t
PjsgQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47IE1hcmVrIFZhc3V0DQo+IDxtYXJlay52
YXN1dEBtYWlsYm94Lm9yZz47IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBZZSBMaSA8eWUubGlAbnhw
LmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHYzIDAvMl0gUmVzdG9yZSBzdXBwb3J0IGZvciBp
Lk1YOTUgQTAgc2lsaWNvbg0KPiANCj4gT24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgNDowNeKAr0FN
IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+ICAtIHVwZGF0ZSB0aGUgYmlubWFuIGV0eXBlIHRvIGdl
bmVyYXRlIGEgY29uZmlndXJhdGlvbiBmaWxlIGFuZCBhIC5iaW4NCj4gPiAgICBmaWxlDQo+ID4g
IC0gdXBkYXRlIEdldCBhaGFiLWNvbnRhaW5lci5pbWcgaW4gaW14OTVfZXZrLnJzdA0KPiA+ICAt
IHJlbmFtZSBjb25maWdzL2lteDk1LmNvbmZpZyB0byBjb25maWdzL2lteDk1X2V2ay5jb25maWcN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gQWxpY2UgR3VvICgyKToNCj4gPiAgICAgICBiaW5tYW46IGFkZCBhIG5ldyBl
bnRyeSB0eXBlIHRvIHN1cHBvcnQgLmJpbiBmaWxlIGdlbmVyYXRpb24gZm9yIHRoZQ0KPiBpLk1Y
OTUgcGxhdGZvcm0NCj4gPiAgICAgICBpbXg5NV9ldms6IFJlc3RvcmUgc3VwcG9ydCBmb3IgaS5N
WDk1IEEwIHNpbGljb24NCj4gPg0KPiA+ICBNYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMyArLQ0KPiA+ICBhcmNoL2FybS9kdHMvaW14OTUtdS1ib290LmR0c2kg
ICAgICAgICAgICB8ICA0NCArKysrKysrLS0NCj4gPiAgYXJjaC9hcm0vbWFjaC1pbXgvTWFrZWZp
bGUgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9pbXg5L0tj
b25maWcgICAgICAgICAgICB8ICAgNSArLQ0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9pbXg5L3Nj
bWkvY29udGFpbmVyLmNmZyB8ICAxMSAtLS0NCj4gPiBhcmNoL2FybS9tYWNoLWlteC9pbXg5L3Nj
bWkvaW14aW1hZ2UuY2ZnICB8ICAxNiAtLS0tDQo+ID4gIGJvYXJkL2ZyZWVzY2FsZS9pbXg5NV9l
dmsvTUFJTlRBSU5FUlMgICAgIHwgICAxICsNCj4gPiAgY29uZmlncy9pbXg5NV8xOXgxOV9ldmtf
ZGVmY29uZmlnICAgICAgICAgfCAxNTMgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gIGNvbmZpZ3MvaW14OTVfYTBfMTl4MTlfZXZrX2RlZmNvbmZpZyAgICAgIHwgICAyICsNCj4g
PiAgY29uZmlncy9pbXg5NV9ldmsuY29uZmlnICAgICAgICAgICAgICAgICAgfCAxNTANCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZG9jL2JvYXJkL254cC9pbXg5NV9ldmsu
cnN0ICAgICAgICAgICAgICAgfCAgNDIgKysrKysrKy0NCj4gPiAgdG9vbHMvYmlubWFuL2VudHJp
ZXMucnN0ICAgICAgICAgICAgICAgICAgfCAgMTIgKysrDQo+ID4gIHRvb2xzL2Jpbm1hbi9ldHlw
ZS9ueHBfaW14OWltYWdlLnB5ICAgICAgIHwgIDg1ICsrKysrKysrKysrKysrKysrDQo+ID4gIDEz
IGZpbGVzIGNoYW5nZWQsIDMzOCBpbnNlcnRpb25zKCspLCAxOTEgZGVsZXRpb25zKC0pDQo+ID4g
LS0tDQo+ID4gYmFzZS1jb21taXQ6IDBjNTU4YmJhZDllNzU4MTgwOGIzNTgwOTFkMWZkOTc5Zjg2
MGU4YWMNCj4gPiBjaGFuZ2UtaWQ6IDIwMjUwODA5LWlteDk1LTEwYjViMThlMGFkNw0KPiA+DQo+
ID4gQmVzdCByZWdhcmRzLA0KPiA+IC0tDQo+ID4gQWxpY2UgR3VvIDxhbGljZS5ndW9Ab3NzLm54
cC5jb20+DQo+ID4NCj4gDQo+IEhpIEFsaWNlLA0KPiANCj4gSSBoYXZlIGEgYm9hcmQgd2l0aCBJ
TVg5NSBBMSBzaWxpY29uIC0gd2l0aCByZXNwZWN0IHRvIHRoaXMgZG9jdW1lbnRhdGlvbiBzaG91
bGQNCj4gdGhhdCBiZSBjb25zaWRlcmVkIEEwIHZzIEIwPyBBcmUgdGhlcmUgYW55IGlzc3VlcyB3
aXRoIEExIHRoYXQgd291bGQgbWFrZSB0aGUNCj4gb2VpL3NtL2F0Zi91Ym9vdCBub3QgY29tcGF0
aWJsZSBoZXJlPw0KPiANCj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhlIG9ubHkgcGFydCBvZiBi
b290IGZpcm13YXJlIHRoYXQgbmVlZHMgY29tcGlsZS10aW1lDQo+IGNvbmZpZ3VyYXRpb24gYmFz
ZWQgb24gc2lsaWNvbiByZXZpc2lvbiBpcyB0aGUgaW14LW9laSBhbmQgSSBvbmx5IHNlZSBzcGVj
aWFsDQo+IGhhbmRsaW5nIGZvciByPUEwLiBJZiBJIGJ1aWxkIHdpdGggYW55dGhpbmcgb3RoZXIg
dGhhbiByPUEwIHRoZSBPRUkgZG9lcyBub3QgcnVuDQo+IGZvciBtZSB3aGVyZWFzIGJ1aWxkaW5n
IHdpdGggcj1BMCB0aGUgT0VJJ3MgYXBwZWFyIHRvIHJ1biBmaW5lIHlldCBJIGRvbid0IHNlZW0N
Cj4gdG8gbWFrZSBpdCB0byBVLUJvb3QgU1BMLg0KPiANCg0KZmxhc2guYmluIGZvciBpLk1YOTUg
QTEgY2FuIGJlIGdlbmVyYXRlZCBpbiB0aGUgc2FtZSB3YXkgYXMgaS5NWDk1IEEwLiBDYW4gc20g
cnVuIHdvcmsgd2VsbD8gb2VpLW0zMy10Y20uYmluIGlzIHJlcXVpcmVkIGZvciBBMS4NCg0KQmVz
dCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCg==
