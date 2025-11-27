Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B077DCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 09:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E1284332;
	Thu, 27 Nov 2025 10:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kGIqA63c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B31C84358; Thu, 27 Nov 2025 10:48:39 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4EC8432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 10:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ps0hR8KeEnrTzrPLbyT9htc13yxsnY1z3fWdTeQojaB/j+1rqP+UlvswWIqpZGlbaPH7WAT+5fK/7Ul68vcamZqJX7DO6GAlshleSSB05AfCPvFRe5KR1SfIOQ5hOLZ7IosPTRkEtqooss98BmkOrAU9EWFN6U/BUfaAJrYMxdAGX5yhx5nAstABP4h8lXFPS6S5y9/ppjhNYDi5RLef1rBmyyU60OIaTzV1+X0JCav1hyAW7uE/SUKCtKUQFPauViTXNI/oe/MAXnJRt8etYRfSnh3D+DwljZv9VptOHfn27JXzBjE9rSfyp21iIifwvOTfEznGamX7BGNBK0sRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAVGqmQfARO5ALeTIB2hDfZhfFfRWn/DSwnFxprHOsc=;
 b=ckX7UOAybEbRp0r3sGQAKKJ1/OiYdF2c4J6RGycNu29Q/XCg3EWyr3badzaAkvWS8M1ACBcAfOUSir5ZAwau23a6UUYN96lT13zllsY/Uj5klgHyklLGYyEbHqym2V5Zfwh1EKsCaSyY6utHY7/9/4TMBI1z8If+YlihGKnquABhAIccJtq1jliuc/971uyKKil7OznVRhxVBPV6lxNmaoU6W0hk6mV2f2Ll6QqOas7z5RTVxCWiJYeiYH2mUfd0AT5k63jPrwkFAGSCPLOluibIwCtnMCE+JyV7C5VE1TOH4ALr0WW+FlsBDNm3WxqWZ8SEQ6dwvkWWjGuFeo/s5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAVGqmQfARO5ALeTIB2hDfZhfFfRWn/DSwnFxprHOsc=;
 b=kGIqA63cuB27t+6wyQv8+zhBY4tXnt65Kl0hKdnwx8Gq0bHVADW0vWOChD7/3S+/o5d3WIWZQV5zUrWIWAjuYiHNn8XwENN0s4hp3Wqo5LgX/rZcP1rCiB5XAVUyyqOUY2E3uJ7hWRx/w+y+BT1tDoCz9cYVG1p6os3ZeC+msLcYhZDs+m5Ro8J+C9TMKdIOX490oi68h4fqO6cgagD0emVvWjNVRVQgv8Qqe6MXSUWxDtLPIYuc/XLIINEW9JkhUXaQCpDScGAqEV7zXX2yekGpMdPri4ZK4MInlfaoFmZE6G9pdbNt7l93rYIb/uMG3pweZIfDG3N5THqt9DnMzQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10726.eurprd04.prod.outlook.com (2603:10a6:150:20f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 09:48:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 09:48:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "marex@denx.de" <marex@denx.de>, "tien.fong.chee@altera.com"
 <tien.fong.chee@altera.com>, "balsundar.ponnusamy@altera.com"
 <balsundar.ponnusamy@altera.com>
Subject: RE: [PATCH 1/8] mmc: sdhci-cadence: Add reset control support
Thread-Topic: [PATCH 1/8] mmc: sdhci-cadence: Add reset control support
Thread-Index: AQHcUmi/YMVypl/CekGucechG7kxbrT37jEAgAPJcoCACJkfAIAB+j6AgAAVnKA=
Date: Thu, 27 Nov 2025 09:48:33 +0000
Message-ID: <PAXPR04MB8459B3E517FE7375521DC49E88DFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-2-tanmay.kathpalia@altera.com>
 <aRv_hIwxZshKJQI1@nxa18884-linux>
 <3668b44b-9525-4bad-8d24-de10311a4df3@altera.com>
 <aSZjLjm7saoeQYBs@nxa18884-linux.ap.freescale.net>
 <77c022a6-0751-468a-aeb0-9d028ad1fd70@altera.com>
In-Reply-To: <77c022a6-0751-468a-aeb0-9d028ad1fd70@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10726:EE_
x-ms-office365-filtering-correlation-id: 3c564960-8f88-4c47-2d55-08de2d9a2119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RThPU0Z4Szh1REtJaTBtN3VsMFRhc1ljSzBib0lYZXdIK1lpVEJjZUFldS9a?=
 =?utf-8?B?azcvaXlLclhxS1A0ZUNwZjA2Q0FBWUlLYkZ2UDFhOVRLWFZDd2lUc2xoTTFj?=
 =?utf-8?B?T2haQm9LTnV1SElIVDc4WmYwazYvVkZSUUo0NWhNUlVQSWpkRWdkc3BldUU0?=
 =?utf-8?B?T1hIS0g1OHdiMWhPNFpXYnVOVi9wb1dKenpVaGw0Y0o0enh0QTFBem0vK1o5?=
 =?utf-8?B?THRRTVRJWGFXRzhlVm90WGhlejhZR1FTSGR6SkNRMFVrQ0lET0VFQTRzbTZh?=
 =?utf-8?B?S25vWSttT1BrUmEwKy8waUFTb0NpTlR0ZlZEQWw1V3NDRE5EWWR0UzFoZ1JS?=
 =?utf-8?B?Y0NPSWt0TDVlbitGcTBnUmR1dVp2MHJEbmlVL0pRS3JTeGd1MFNaQnp0OUdX?=
 =?utf-8?B?Z0txM3ZzN3dRczl6SXlmMGU0SDVPOGp4ZzVZVnZKRnBSYnE1dm8zR3puU29N?=
 =?utf-8?B?VmxNcTdSZGNLVUd4dUpsRXZiQ0tMK0NIZUpSKzRGUnpmQUI4cWU1dU42TmRS?=
 =?utf-8?B?VHE1bExNSCtxa1dxKzU5QmRUNEljMEFyK3pISXRZaGxnQko5VUNFbjFQSlY0?=
 =?utf-8?B?ZnpXRktCcC9DSENiUE1LTUdoSmZMUjNXUm9BQ2F0WElmZFBSaXVWL09TOGln?=
 =?utf-8?B?MEJ2c0NPRWZ2Uklqa2dyaUtwcTZCWjRqOFd6aC9IZkJnQklYVFRaZE8zeDlD?=
 =?utf-8?B?b204ek5ldHdORDVsbE1KdlZwWTNsMm5KMW1OVjhONVlucGFNOG1meUNrd2ds?=
 =?utf-8?B?ZE9wQUpHQlpWODVCQTV1bGh4aElQaFM0M1RCcmtWcHo2dm9KQk85Ym5GYkph?=
 =?utf-8?B?cDd6eFlIb1hQQWFVRnRVbjdkU3l6dFp3b0I3aU90MzhFRFpnQ3U3QmE2eStE?=
 =?utf-8?B?dVBZVFJOSTJ1Q1NiVjRSN2NqSncwTXpHZlZwbXFPdE9KTDhiVWxMYkV4czRo?=
 =?utf-8?B?bFRQK2ZLUldOeFcvSTdvSUp2N0R0eDFXQjQ5bWR1ZFZ3SkxYT0txUlluVmQ2?=
 =?utf-8?B?QmpXc3YvSkUwNGtKUStkTnRKRHhUOVBsWFJhWEQvMklheGluYW5NNXEzZEZi?=
 =?utf-8?B?YkIxVWcrV0lMN1psMGkzY3hrK3ZYeUdCTHBHL3Exb3JiVHB2TnBtUHV1K0pk?=
 =?utf-8?B?Q21JRUFUdHI0VkV4Qm4zTldJRkxUVWhRcGQ2NktKcERnSWJ4a3Nya05MOXI2?=
 =?utf-8?B?d1I1UnpRdDdydWhjdnBCL3IrbjFSWUlBbjkyR1lIRHJ3OCs5QjRLeU5yRE9J?=
 =?utf-8?B?UjYwTHNrMWVORW9ZVytVc3BTcnlaOFhaZERwMDZlK0lSeFdvVkludyt6QzZZ?=
 =?utf-8?B?Z2hxWDlKVDF6VVd2Rk1sR1BETGY2cFFjMXExZmVvN2JUL0FkVkFvc0ZJam1l?=
 =?utf-8?B?Qjh0RU5sbnFEajZQbXdnMEpCd3kyaTY5dlBGOFQ5R2xzWlpxaXE4UmNhT2ti?=
 =?utf-8?B?WDVZVjBXVHRaZGlzZzhYL3c0cGUyeTBtck9waFJjc2piWW5vVk83WUxzWUVv?=
 =?utf-8?B?WFArczMrMXpsRHQ0bzRkNzBUYTN5QU5iMWNjZVZkSmRsWXJLYktDSmxhcGY3?=
 =?utf-8?B?WjlteXNMbTlDREY4cEhrUHNLQjRpRkM5N0JDZCtpOVMrem5BQnFzbW5jd1Q4?=
 =?utf-8?B?WkM0amdvZmRKRXcwZmZBeDgwbitWWTFPUWN6WVhic0hlZnYyd1lNeHBTTU5O?=
 =?utf-8?B?N2NIci8zZjJTUXRPY1VERGlxdVF1MCtBYkl3ZXhpN3ZBSnFKMjJUeVo2OE43?=
 =?utf-8?B?SVNrb0M4Ty9KaGpxVUtsZTg0NlNiSVBaV0VLZlMvVmoyLytHTExudUVmS09F?=
 =?utf-8?B?RytsN1VjaS9Eb3FVWDNveC96WWlqZDZrQ0dDVDhYQkcwVHFTQ1M1M0QzS2tF?=
 =?utf-8?B?QlAxRTRDYi9OSWRIK0RLNElkWUh0TEUrOFpBTy9RNDFPTG9zZnFya1hEN0xI?=
 =?utf-8?B?SSs5eVZxRCtCOFR3d1oyMTRaRUlpZDhzbmR6Q0FYSzlBM1ZBZlE5WGxpR1A3?=
 =?utf-8?B?d1YwMXlXcjh6Zi9SYWtCZ0VmSzVEdEJqK0JrQmVBWE1USVZ6WkhyUTdQUUhI?=
 =?utf-8?Q?uHGWQs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDNtWlBWSUxTa3d3bVc0S2RXMk1sVUVoQXgyaEVTc2MxYTlESmxXUGNiK3hQ?=
 =?utf-8?B?azhzTlNQelFYSVVOdHBrbk56dDZFaDk5cVVWUDhMRG5RMXVISEdoK0FiTzIx?=
 =?utf-8?B?cVY2c1ZZTWZzbE00bEp6V2xXNlNleFJBbXJBQnVxNlk0NmdEdnNDQzhNVlkv?=
 =?utf-8?B?QlpSL1pjZDZHTzVqeE1zaG9vOTZ3cmQzSWlVWjBlUTFVNkE5ZnNSdmloamI0?=
 =?utf-8?B?cDdpcEt6My8xNDg2Zm5qN092QUtiUGN2M1R1ZU1BeEU4emdORTBrbUk4dnh3?=
 =?utf-8?B?SWRvRVYzakxqczRiSHNjeEdvQzNEMmRFOURWSEdMSUpIRFN1RjJrL29mdmtp?=
 =?utf-8?B?VmRPazJRWnEzcXZzWmtBTFFYZ2xyTk0zeUwzMnBNbHZYNzRwM3JqUFVxNERs?=
 =?utf-8?B?MjhCSUhtMHJ3SmE5QndLTXc5dUd2dXBIN3RJVXByaUVqZytRaXowVlRtcEg5?=
 =?utf-8?B?SWhBcmhSTWJ5ZW43OXRXbHZzdGxNbTdUR1pJQ3Y1a2tBekZDUWNwdk1xcDE5?=
 =?utf-8?B?amR3WmU2RTFjaXZ1ZkpTNmlaNUF4TndDZHdoYng4amNidDZqVGQ1cG1jMHNq?=
 =?utf-8?B?dW5kVTJLYTgzbnRuWlNSM3VoemYreCs3czhaSFZuM0RST0JpZnhvVkNXVVlX?=
 =?utf-8?B?cFlzSWgxa3VYVkZhbE1qTFd0a2dRRGhnWFMrUTZucStrZlBXM0lVOVUvbjFt?=
 =?utf-8?B?RlhuTk5MMWtacCtvUEQ0d09mWGkza1UzVHRIWHhyR2VwR0pkSFNMRnY0b0pS?=
 =?utf-8?B?L1JyWXRhNW5TNnMvRjFUSzdqVFdvN0FuRndOVjE2dzUyVnNkUFpnNzA1MWkw?=
 =?utf-8?B?NmZpaENCaXdCRU9jbG1sQnJ5TFBXL21vRmRKbW43MXFvSzROUjJ3ckFXekdP?=
 =?utf-8?B?d2hwVHI0UWpYejFKbXVoZTFuWVBCaXBlblVqUzdSNWQxdjlva2t3UEhKU29V?=
 =?utf-8?B?WUE5S0MxbFhwUHBjcG9aSC9NSmxxOEZYaGRFV3FsRXV0M21MQ1UveW5FeHRh?=
 =?utf-8?B?SW5LcmgrOVBaSFU0R2NMcG1mNDkxOGVDREVDWVdBVVhjL2thZE5obmp0OGVz?=
 =?utf-8?B?cE9xZE5UYjRVeVhvd3FSdDNRMzByUlFnS0ZKR0piQ0dORVh5bG1saTdNMEtm?=
 =?utf-8?B?enlQV0JNcUo3NkZlaUY4MGNPc2dpaXZUeVh5NzFCSWZ3OGM3ZXVnZ2VkbHAy?=
 =?utf-8?B?ejAzeTM3TEdybmhFRG1sMU12WSswbUJiaUdGL0svMjBzQkhTOUQxakdxV2p6?=
 =?utf-8?B?UE0xMGFmR2FySTZTRTBlSG5PeFJyazY5aW9GT3V2c21UblEzZ0h0SWRrZjlm?=
 =?utf-8?B?R0kxdUV0VDhmcUxIb0hXQzhteElNS1V4YkdBVGpma2FJRG42Ty9LOGlOZzZY?=
 =?utf-8?B?S2tPdnIzUmw0RjVLREpkM3ZJbmxHbWZuckUyd3F6RlMwTURaSHpBNU85OG5z?=
 =?utf-8?B?S2hiQ2hlUmR2Mm8rU0lYcjgrREJDK2J1ZHR5U2dFcEF2T1FBOFdPZ1N5dEVI?=
 =?utf-8?B?b1V3eE9SOFhwRVViaWJ0QngvaTVHYUlLUElLbm4zLzM3RThiNDc5THozQW80?=
 =?utf-8?B?NXRuRFo3blV2eVBLNkZ3V2RyTTUrZm5YZVpjVkdEbVRpVXY1bmFKS2t3dVo2?=
 =?utf-8?B?Uk9oQU5YU3A1cXdPSFhobDRibGpxY0RyUXZkNUlFQVBwRjNYZ1VSRkZNeTNt?=
 =?utf-8?B?OWQ5NTZURFk2UEU2d2RkK2VOV1lCOTRUOHFCWVN1WGtQQjBVUEZIMXBRMUt2?=
 =?utf-8?B?Yjl0bHpVK2lwQktITFRIWUJpZTduVEt6TEFHcnZIbE1pWEpyeGduS25tdDRG?=
 =?utf-8?B?SEFFdGIzdGIySkkrejEyNFQ1TUN1bStESHBDWnR4S1ZCT3M0dS94M3RLa0Va?=
 =?utf-8?B?eVN6ZjRySldiRDUwSnBiYkd3UUFnb3Y5YWE4ejRRN3lwbFp5bFppaWRYcEN5?=
 =?utf-8?B?Z0dBMjh1TkFyWVFMTll6R1FrVkZSOGJobSszcDlrdjZBUGMwZStHbWk4SVpo?=
 =?utf-8?B?ZXlJOUgxQ2JZWFVIYUxSaWYwdjNaNE9WblBRSldSRzF1WDlLdmxOUkFhOEYr?=
 =?utf-8?B?a3dKK2xUeDJHZEVKVlh5aUJoM1NYL1FIeDdVZ3h4ME5zdG40bE1zZURwblo4?=
 =?utf-8?Q?FJm4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c564960-8f88-4c47-2d55-08de2d9a2119
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 09:48:33.6119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/NyzAzzKBIK2VoL5qfS2huqCDiO3OPdAH/Qpk4AwziKSRDLXAAwS+nEzgw83iOedK4rYtZE9EVEOuW7JsxugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10726
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvOF0gbW1jOiBzZGhjaS1jYWRlbmNlOiBBZGQgcmVzZXQg
Y29udHJvbA0KPiBzdXBwb3J0DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLCBQZW5n
Lg0KPiANCj4gT24gMTEvMjYvMjAyNSA3OjQ3IEFNLCBQZW5nIEZhbiB3cm90ZToNCj4gPiBPbiBU
aHUsIE5vdiAyMCwgMjAyNSBhdCAwODoyOToxMVBNICswNTMwLCBUYW5tYXkgS2F0aHBhbGlhDQo+
IHdyb3RlOg0KPiA+PiBUaGFua3MgZm9yIHlvdXIgY29tbWVudCwgUGVuZy4NCj4gPj4NCj4gPj4g
T24gMTEvMTgvMjAyNSAxMDozOSBBTSwgUGVuZyBGYW4gd3JvdGU6DQo+ID4+PiBPbiBNb24sIE5v
diAxMCwgMjAyNSBhdCAwOTozNzozMEFNIC0wODAwLCBUYW5tYXkgS2F0aHBhbGlhDQo+IHdyb3Rl
Og0KPiA+Pj4+IEFkZCByZXNldCBjb250cm9sIGZ1bmN0aW9uYWxpdHkgdG8gdGhlIFNESENJIENh
ZGVuY2UgZHJpdmVyIHRvDQo+ID4+Pj4gcHJvcGVybHkgaGFuZGxlIGhhcmR3YXJlIHJlc2V0IHNl
cXVlbmNlcyBkdXJpbmcgcHJvYmUuIFRoaXMNCj4gZW5zdXJlcw0KPiA+Pj4+IHRoZSBjb250cm9s
bGVyIGlzIGluIGEga25vd24gc3RhdGUgYmVmb3JlIGluaXRpYWxpemF0aW9uLg0KPiA+Pj4+DQo+
ID4+Pj4gU2lnbmVkLW9mZi1ieTogVGFubWF5IEthdGhwYWxpYSA8dGFubWF5LmthdGhwYWxpYUBh
bHRlcmEuY29tPg0KPiA+Pj4+IFJldmlld2VkLWJ5OiBCYWxzdW5kYXIgUG9ubnVzYW15DQo+IDxi
YWxzdW5kYXIucG9ubnVzYW15QGFsdGVyYS5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4gZHJpdmVy
cy9tbWMvc2RoY2ktY2FkZW5jZS5jIHwgOCArKysrKysrKw0KPiA+Pj4+IDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCj4gPj4+Pg0KPiA+Pj4gLi4uLg0KPiA+Pj4+DQo+ID4+Pj4gQEAg
LTIyNSw2ICsyMjcsMTIgQEAgc3RhdGljIGludCBzZGhjaV9jZG5zX3Byb2JlKHN0cnVjdA0KPiB1
ZGV2aWNlICpkZXYpDQo+ID4+Pj4gCWlmICghcGxhdC0+aHJzX2FkZHIpDQo+ID4+Pj4gCQlyZXR1
cm4gLUVOT01FTTsNCj4gPj4+Pg0KPiA+Pj4+ICsJcmV0ID0gcmVzZXRfZ2V0X2J1bGsoZGV2LCAm
cmVzZXRfYnVsayk7DQo+ID4+Pg0KPiA+Pj4gU2hvdWxkIHRoaXMgYmUgb3B0aW9uYWw/IFNvbWUg
aW4gdHJlZSBwbGF0Zm9ybXMgbWF5IG5vdCBoYXZlIHRoZQ0KPiA+Pj4gcmVzZXQgc3VwcG9ydGVk
Lg0KPiA+Pj4NCj4gPj4NCj4gPj4gWWVzLCB5b3UncmUgcmlnaHQtc29tZSBpbi10cmVlIHBsYXRm
b3JtcyBtYXkgbm90IGhhdmUgcmVzZXQgc3VwcG9ydC4NCj4gPj4gSW4gdGhvc2UgY2FzZXMsIHRo
ZSBjb2RlIHdpbGwgcHJpbnQgYSB3YXJuaW5nIG1lc3NhZ2UgKCJDYW4ndCBnZXQNCj4gPj4gcmVz
ZXQiKSBhbmQgY29udGludWUgdGhlIHByb2JlIHByb2Nlc3MuDQo+ID4+IElmIHlvdSBwcmVmZXIs
IEkgY2FuIHJlbW92ZSB0aGUgd2FybmluZyBhbmQgbGV0IHRoZSBmdW5jdGlvbiBmYWlsDQo+ID4+
IHNpbGVudGx5IGluc3RlYWQsIG9yIGlzIHRoZXJlIGFueSBvdGhlciB3YXkgeW91IHdvdWxkIHN1
Z2dlc3QgdG8NCj4gbWFrZSB0aGlzIG9wdGlvbmFsPw0KPiA+DQo+ID4gZGV2bV9yZXNldF9idWxr
X2dldF9vcHRpb25hbCgpIG1heSBoZWxwLg0KPiA+DQo+ID4gUmVnYXJkcw0KPiA+IFBlbmcNCj4g
Pg0KPiANCj4gSSBsb29rZWQgaW50byBkZXZtX3Jlc2V0X2J1bGtfZ2V0X29wdGlvbmFsKCksIGFu
ZCBJIHNlZSB0aGF0IGl0DQo+IGR5bmFtaWNhbGx5IGFsbG9jYXRlcyB0aGUgc3RydWN0IHJlc2V0
X2N0bF9idWxrIGFuZCBhZGRzIGl0IHRvIHRoZQ0KPiBkZXZpY2UgcmVzb3VyY2VzIGxpc3QgaWYg
Q09ORklHX0RFVlJFUyBpcyBlbmFibGVkLiBIb3dldmVyLCBpZg0KPiBDT05GSUdfREVWUkVTIGlz
IG5vdCBlbmFibGVkLCB3ZSBuZWVkIHRvIG1hbnVhbGx5IGZyZWUgdGhlIG1lbW9yeQ0KPiB1c2lu
Zw0KPiByZXNldF9yZWxlYXNlX2J1bGsoKSBpbiB0aGUgZHJpdmVyJ3MgcmVtb3ZlIGZ1bmN0aW9u
LiBUaGlzIG1lYW5zIHdlDQo+IHdvdWxkIG5lZWQgdG8gc3RvcmUgYSBwb2ludGVyIHRvIHN0cnVj
dCByZXNldF9jdGxfYnVsayBpbiB0aGUgZHJpdmVyJ3MNCj4gcHJpdmF0ZSBkYXRhLCB3aGljaCB3
b3VsZCByZXF1aXJlIGFkZGl0aW9uYWwgY2hhbmdlcyB0byB0aGUgc2RoY2ktDQo+IGNhZGVuY2Ug
ZHJpdmVyIChzaW5jZSBpdCBjdXJyZW50bHkgdXNlcyB0aGUgZ2VuZXJpYyBzdHJ1Y3Qgc2RoY2lf
aG9zdA0KPiB3aXRoIC5wcml2X2F1dG8gPSBzaXplb2Yoc3RydWN0IHNkaGNpX2hvc3QpKS4NCj4g
DQo+IExldCBtZSBrbm93IGlmIHlvdeKAmXJlIG9rYXkgd2l0aCB0aGlzIGFwcHJvYWNoLCBhcyBp
dCB3b3VsZCByZXF1aXJlDQo+IG90aGVyIGNoYW5nZXMgaW4gdGhlIGRyaXZlciwgb3IgaWYgeW91
IGhhdmUgYW55IGZ1cnRoZXINCj4gcmVjb21tZW5kYXRpb25zLg0KPiBBbHRlcm5hdGl2ZWx5LCBJ
IGNhbiBzaW1wbGlmeSB0aGUgaW1wbGVtZW50YXRpb24gYXMgc2hvd24gYmVsb3c6DQo+IA0KPiBy
ZXQgPSByZXNldF9nZXRfYnVsayhkZXYsICZyZXNldF9idWxrKTsNCj4gaWYgKCFyZXQpDQo+IAly
ZXNldF9kZWFzc2VydF9idWxrKCZyZXNldF9idWxrKTsNCg0KRm9yIGJldHRlciwgYW4gb3B0aW9u
YWwgQVBJIGlzIHByZWZlcnJlZCwgc2luY2Ugbm9uLWRldnJlcyBBUEkNCmlzIG5vdCB0aGVyZSwg
SSBhbSBmaW5lIHdpdGggeW91ciBhYm92ZSBjaGFuZ2VzLg0KDQpSZWdhcmRzDQpQZW5nLg0KDQo+
IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBwcmVmZXJlbmNlLg0KPiANCj4gUmVnYXJkcywN
Cj4gVGFubWF5DQo+IA0KPiA+Pg0KPiA+Pj4gUmVnYXJkcw0KPiA+Pj4gUGVuZw0KPiA+Pg0KPiA+
Pg0KDQo=
