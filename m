Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FDCD1036F
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 02:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6514884101;
	Wed, 26 Nov 2025 03:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TYYvqd9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074158416B; Wed, 26 Nov 2025 03:42:21 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87385840E6
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrnqK0FVaFg4P7qF227OKDdmtu3/FqDhLPOCwN8g94mTuR8TfAdKw/33M1KUbTSelcd1KBkiGmuUsGg1rFLmi5BAx/yNQ60jAyT4nK9DvmaIe1BcaGxXvXJv1u4b2rG24oc8dmBl75DXDR0sVXqfnp+0/xZgD/TjZQDkqkM74jPKzsfFNPrFcg7TQcKaWtLV4dqKiB01kOexCTvMvYdiAnEonjCaDZYRrjWsOoeyeeReirY04B0WN1h1+OVTTPMcoJGSiZ13sRFKxtXrOaLELRF1yUJwzV3kxpcaDULm6Xq0ghBDwVxEn5PneCED5kUpfIP2DacrHDOksXHF6ObZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpiG10qMIZm0e64irEeTdcNUy64TA3GT2pNaqEUt8uY=;
 b=vbfeaPiznll/pyyQ5JY4ZAfWpVRXHhTvej81hQ3NSJb++0CASINTeXg/OAWyBbjnHbTSWEEfjZ5Dd/g0B5xFsoCqxsaLvm3vQ+HxW9pSPTzwCUJ+uMp6UCrsA4PlF6WPfWVL2rQ7hOQ7oF6GZKjS8PbjVYn38jF/hzfh2d48kXPxEkRHALhDAba690c9+1szi/3VRWJGtC4p9iXwKvMUPD3B0zevVasbBeCEi0YisVNKMnSdhQ+7O4UGYNCByrcXbIsGHY7Qr02uTeVlrVRbZAf75IsugdOeN7eX7nOGby92rFA3S7fa1aUMEd6YZPjNAeNGJd3b5TYX4a/bo+a71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpiG10qMIZm0e64irEeTdcNUy64TA3GT2pNaqEUt8uY=;
 b=TYYvqd9I+hVYVlCoC1A1XAImbOFTzsfMIH+Db4ty0YkxKjsVmCgBCsYknh8DFNovbElvZDiYkGKxSf7A7CGg+D5C40yUjOYLtPrLrOOc57sD6GoVSyU8uqnRi/0u7J2XyS7aDshH0WHRc9Vdt3bAdLIB0+KqX0RriJye+4Z9EFAj3t46eC0gXZMBPtnD4fA4Y0jFjS6qDHv3zm+1T71gSObgTdD1VgLTPbrvD0kOK4Ca10BYXkPGeFNW8IEiawlaTXVfIfpU50o4b9XgBd7V1yk0Cuq6GYk4TwnsiKLd/CTZCyFYFbA+3y/HjOz6A8qgn+fkGbTQliCiWpF5pb6BhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS4PR04MB9289.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Wed, 26 Nov
 2025 02:42:15 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 02:42:15 +0000
Message-ID: <14953ab0-27c6-4afb-bc8f-2333b1945693@oss.nxp.com>
Date: Wed, 26 Nov 2025 10:42:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
From: Ye Li <ye.li@oss.nxp.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, uboot-imx@nxp.com, trini@konsulko.com,
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de,
 u-boot@schwermer.no, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Jacky Bai <ping.bai@nxp.com>
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
 <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
 <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
 <b6b82482-ec7d-4703-ad93-ccdd7a651b57@oss.nxp.com>
 <e9c56d66-b2b9-456c-856e-2ef01a009e16@gmail.com>
 <CAOf5uwktScqh0LrWTaz-MRA-tDoAVb9Mo8UhxDKz0dauO21QQg@mail.gmail.com>
 <92d98692-5fd7-456f-b831-0986e6d499a9@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <92d98692-5fd7-456f-b831-0986e6d499a9@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS4PR04MB9289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5da524-b5e2-4c0e-9209-08de2c95686b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUtWTnlsTDJxNFRZNGJJMlFGc0loL3NqcjBmLzlVTENlT1p2ZlJXTi9RZzd1?=
 =?utf-8?B?UDdSTS9mZDNVUk1sc3c1a0thek1uMTNqY1pLNm5BK3hVWjZWa09scTBXSTAx?=
 =?utf-8?B?eFBETTVVVVU4VEVCR2VCTXFVemt0VFl6K0IwbFUyS2lMYjFaREFacmQ5Z3hw?=
 =?utf-8?B?eHVUK2VEcjNnQ2xDMzlLUjhuZ1c5NW45eG5vY2k1S1l3TDA1UU8wdjluZ3h1?=
 =?utf-8?B?YWc2aHZNNE8wTWJydWhTdWU1cUFuZmo5ekJ2YkE4c25LdzlUVm1oZ2hUL3hO?=
 =?utf-8?B?Q2ZseFQ2a2JJTUNjZW05WkpobVRCWm9JOXh5WG91VXRxNkNDVjFwRjNGQXRm?=
 =?utf-8?B?VUkreXluQlBjeWMwWGs1Qk10aHFXUjltNFd6dndSZXl3dHc4QzlFMDlmc1ZD?=
 =?utf-8?B?RzVEQ3p1YnoraDhiRjh1T1ZJdkJ3TzhDZER4cGtDUEFxM2tlQXZDSDQ3QXVT?=
 =?utf-8?B?YTdUZWZBcVJOdlZtVW8ycklsSXd5bThsVER1cDM4TUxmMVhzMWVUZzY4SmFC?=
 =?utf-8?B?N25WN2ppeHd3YnRzMTNmajhVY0p5Y2NPNC9rSXdMMHY5bFh1L0FZamQ1eW5V?=
 =?utf-8?B?OHVUU3NFeEpqL2FKRW53am9SdEl5MTI3OENpRjRaNU1xeUttS1ZlUmFaQXQv?=
 =?utf-8?B?cmRtUjloOElsbzBXd0dlQnArSlBkSVJHVCt5bFk5bGlUdXd2cVZyR2syQzc2?=
 =?utf-8?B?TzhYSXdjSnVaL3g2dVBxS0FWcUVhbHUwVis5Yy84aEM4VGZyRFIza1hYV2hD?=
 =?utf-8?B?YVJIQXVoTkNpQk5TUUtHa0RwSGRNeTI4NWt0M25zR2ZvRFo4bFBHaSswYVVH?=
 =?utf-8?B?ajN6N2ZoaTYrQzF1b3o3L04zeUN6MU5SUGhucklnRGg3b0JVRVZoN0k3SVky?=
 =?utf-8?B?WldOY2s4aTVUUWoxZ0FRRThJcjlXOTJOaG9DR0IrMGRkMkxPSHlVRndjeFlr?=
 =?utf-8?B?ODdtM2dvUW9hek1xQWMwb28wTVRwYzRvTHl3dlZtSTE1UnJEY2EvSDFFcGJk?=
 =?utf-8?B?TlUzTUNnaGV2dXdpR2R3cytXN2NPUUJ6QmZ4RmdSR0lRRWtvNHB1SG5CYkpN?=
 =?utf-8?B?TWJhVlJtTHBNclkzQjVGK0pWaG5zRUNNeWhTRWNhTDdmK05NazdLTnJmdE5t?=
 =?utf-8?B?aVZDSC9pNkk1OXdMWkNTMDY4aCtMenNGeGVwY3BmdmMvUzN3bkdiN0F0M0JD?=
 =?utf-8?B?cmo3MEpJR3VWN2JISTYxWklKVCtjSVV3RmpZaWh5eGxqeWp1ZHo0eVZxQjgr?=
 =?utf-8?B?aDFSTnowdVhBQi9iZ0tQZmhIQmlEaWdsbWlLczRDOUdQYU5FR1RuaFNldTdV?=
 =?utf-8?B?RmhNTW5QbHIxU0hMSnRBQkI5MTNYVSs5UUZhRVE2d1p1QzczcHBlZWpnVk1z?=
 =?utf-8?B?cHk5ZHFhQmhxOTgyRkpORDBKU1BzZGJaOGUrZWNJdXZ3ODhpbzZWejBnVmdm?=
 =?utf-8?B?SUc2cW9pbnIrVFZqMzZSdXBzZTdEN2xmaGR3bFRJN3RaY0FqWFNRbUVmV3kz?=
 =?utf-8?B?aDF2aElZNEVQZUxNMEFGTlVEODEwRVFMbmtQcTJVWVJERHhnb3Q4Z0FJenpH?=
 =?utf-8?B?dHluSFVQZHBhR0w4cERqTGZEZWVEWnMraXRHNERqMlQyYm9XQ0dDSDRtL2ZE?=
 =?utf-8?B?MFBQeWxDZkxQUnYyNUxIWkVuek9lT0ZqOGZDVHdjWVlDYXBkc2ZrMEg2bjUv?=
 =?utf-8?B?NzZUUnREMERCR211elZIZ3M3Z2NsNXEwNGI1eDVxOS9JZW9WcVNNVmZTTE9V?=
 =?utf-8?B?NmZ5bnFrRjVhMkJ3L29oZHdBemVIVVlKMEdDMnE2L043WUVmSnNqc0x3SmFF?=
 =?utf-8?B?MFVhMlAxRHZvTUUxTjQ0cDJ1TnRkZ2lKT3ZZT2VQWFdlRXAxdTZyWnpHUmhM?=
 =?utf-8?B?RFJKRlFsdnBuNWF5OVI5eC9pY2M3aEd4WjhlN28vbkFMVmR2cjdLeEl0OWdz?=
 =?utf-8?B?eVRNd25WZ1h5M05tUFdRRnZHbDdQeFlaVFpiZVZXbWgxWlFCQTdLRlhkRDFQ?=
 =?utf-8?B?VlhRNmdBbmNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkVvSUxrT1l1RGtTbHp1RGFPZU9QR2xMVFpWUE5sT1lzYXJrWWc4aGpBbG14?=
 =?utf-8?B?SVdveTJNd2E2a0xsVm1LVWI4ZTV1ZmJ5L0cwOStjWW1HakZmVmNUUzRDN1Ur?=
 =?utf-8?B?Q0NxY24rMGY0V0dYakdyMHdlYXVmUVJGSGszblIrK1B5Q2lpc1ppVmZKOHdU?=
 =?utf-8?B?SU5BWERlUllvWS8zWFRHOTdkeFhKeDBMd21xazIrUmc0RTdXWDkxR2FRRU5U?=
 =?utf-8?B?OWkzSXZKRzkvRFRuRVZnekl1ZHE5YWJHWmU2RS9zc3Z5WldKdUMzYkNLWWla?=
 =?utf-8?B?TWczU01Cb1p0NmVoc0dPOG9Ca0I0TC95M1FjSk9kSDN6eVFIKzVrb2R1K0M2?=
 =?utf-8?B?czBQN1Jka1ZXUjRaelB2TnlzTllNaWhnSURCUmtlNGlIL1VQR1hxbUV5bVFV?=
 =?utf-8?B?V09aVXYyMlY2MEZJUkNYQmVUTUkvS3JrSHhGeXpzVU1nVFQ0aTFoaS9SZU1L?=
 =?utf-8?B?SkV1ejg0eTRlNGI1bVNIYjhENjdmK09GQkdmdVI5cURiWVNJSVhVN3d1ck1u?=
 =?utf-8?B?MllsNWhrcDYrc0J1UkU4YmpsdUg4Z0ltelJ5Yml3OXNyeUxucHBtYmNucGt3?=
 =?utf-8?B?eTR3QlVxbXh6ay9oU2piSnEzWVJlQUFnbzBEZ3RIWkJUbStWT2dZQlpkdkYy?=
 =?utf-8?B?dkJOVmtlSndmQm55RkRJeldrSjVBbytxL2dvSVQzRlFnOFgwRW0vYlRVTkRP?=
 =?utf-8?B?NEtUbUFmc2llRWUzdEUwTFY1S1NCLzZsRFZuZ1ExSi95YUVRaGhOU1c4L3Uy?=
 =?utf-8?B?ZWZ1UjZXYlJkWDFrN1lRK3luU3d6MTdiNkRrZTNQaDhsbDFrdTc5N3diWTBX?=
 =?utf-8?B?azBGSmtGbXFsbUpDRURsdVd1RmZrUFBhMVNnMENiTE9sdU5DaG5hanN0T251?=
 =?utf-8?B?WHJ5aUFsY2Uxcjd4SzhnbUhJN2FoeFNQTnAwaXd1NjZIeVhRK0ZBZkN6RHht?=
 =?utf-8?B?R1FNYk9yVXJlUGNoMXh5NVNTQlVyTEIxWHdwa3BIR0p3TmxlcSt3R29mK3VO?=
 =?utf-8?B?WUpPR3llTGYwTFhyYUhLdExoZDlwajN0MUVabDRZQWE3UG9iZGlRNDZNYUlI?=
 =?utf-8?B?UG5jR0x1M2NyS3hKMVoxa25XRk5xU2IwTHRnRVB6UWlaQ010aFVPaDJPVDd1?=
 =?utf-8?B?ajFpTmYxbjZ0L1VndUNnL2E5ZzNqOEhYQkRaZkhHdkJHcjVUYXRBWU8wT0Iy?=
 =?utf-8?B?RENmYi9IWitUVlAvdDlYa3ZNTGdod3VnNEtRQnFXa2U4ejhjQmFITXNJWkZW?=
 =?utf-8?B?dndZM3dLaktZUHdRbTlMcm1LQXRzdEZZMGhIelVQdmRMdlB4TDZjamNhTk83?=
 =?utf-8?B?UUd6eVM4bmFDV2FHdmVtc05Ub3NVQVJrYkRsZVFVYUFDeW1XRWYzWk1mWGtX?=
 =?utf-8?B?Sm9Kd3N2NENOaXJyYmF1aHMrSWtzcDdCT0dVTjcrbmlJUXBZYnBXTElWblFT?=
 =?utf-8?B?VmdZWjlLa2t5MmdlRU94Vkdod3ozZXV1WnZxQ1d2QWlmRHU2a3pYY042a2Ra?=
 =?utf-8?B?WDhuMjkzZG0zaVJIbGFmWjFKeXpYY1ljUFVSbHBTNENvMllFaDNGMXZ4bUM1?=
 =?utf-8?B?VG8vM0x3Mnh2aWdLQWlKcHFKNDNpeHZabHRJRkFHODI2dmFDYkZSZXhwZ0ND?=
 =?utf-8?B?ZVpxSTBzUjJsZ013V0FhWVp0Y0hwa2pQc0xlR3UzM2ExdlVPSkY5L2M0dE44?=
 =?utf-8?B?Vm53V0Q5RG84OEpxSW5BRDFaN1FwYlYrQ3djbHZYUjIyZlhsZ2RFWU5CbDJi?=
 =?utf-8?B?SGl3K0RDaGE4Z05ibjVRdVpDOWdvOU9KcTAvTFJmaGRmVUJDekZyb3dKb1Ja?=
 =?utf-8?B?NXpYd1BtYmt1T2Via25Ld0dzVnVoU0NmYktDbE55QVZzdUhCQ0pQZHZCa1RR?=
 =?utf-8?B?TXBseFFidkF6cDFoMDVscWpqcDRXaHFRWkRxL0x0dTZveVRwNGJoYUwxTTZz?=
 =?utf-8?B?dXE5NDdRL0NtNGFNR212WjZlNnlGM0xpSDVqMDBzUVFUSVRFUVE1bFRYdGlM?=
 =?utf-8?B?SEQ4VUZ0V2lVQWxqSi80a2p6K0s3Qk9sQ2x6a0R3TjdaMjNWSElHV0lWeGxY?=
 =?utf-8?B?OTdoQ1l0dzRXd2R5RmxETmp6RzA2aWlzcUhlMm5BUllVYWM0cHl1R0ZtUk40?=
 =?utf-8?Q?SpbbVL17bUykWesQKI4/P7+8W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5da524-b5e2-4c0e-9209-08de2c95686b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 02:42:15.1370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F78zEOHkFZTs/ZmYtVDVluBlqDkulvrkYiQu3p/k4EKWeSOM3aW4Q8FKf6noSU6V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9289
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

Hi All,

On 11/19/2025 3:49 PM, Ye Li wrote:
> Hi Michael, Emanuele,
> 
> On 11/12/2025 6:07 PM, Michael Nazzareno Trimarchi wrote:
>> Hi all
>>
>> On Wed, Nov 12, 2025 at 10:57 AM Emanuele Ghidoli
>> <ghidoliemanuele@gmail.com> wrote:
>>>
>>>
>>>
>>> On 12/11/2025 09:16, Ye Li wrote:
>>>>
>>>>
>>>> On 11/11/2025 9:47 PM, Fabio Estevam wrote:
>>>>> Hi Emanuele,
>>>>>
>>>>> On Thu, Nov 6, 2025 at 7:22 AM Emanuele Ghidoli
>>>>> <ghidoliemanuele@gmail.com> wrote:
>>>>>
>>>>>> Hi Fabio, Ye,
>>>>>>
>>>>>> At Toradex we have been struggling since quite some time (back to 
>>>>>> 2018) with
>>>>>
>>>>> Does this problem only affect early i.MX6ULL silicon samples?
>>>> Hi Emanuele,
>>>>
>>>>      I have same question as Fabio. Are these samples are early? Do 
>>>> you know
>>>> the time of receiving these sample? And could you show the part 
>>>> number printed
>>>> on the chip.
>>> It could take a little to answer to the first two question. I can say 
>>> that the
>>> SoM I'm using to validate the patch was assembled in September 2021. 
>>> Let me
>>> know if this information are needed giving that I can report the 
>>> marking on
>>> the chip:
>>> MCIMX6Y2CVM08AB CTDQ2107 1N70S CHINA QGDQCTA
>>>
>>>
>>>>
>>>>>
>>>>>> the temperature readings and the thermal shutdown behavior on 
>>>>>> i.MX6ULL. The
>>>>>> issue we observed is that the thermal shutdown seems to trigger 
>>>>>> too early.
>>>>>>
>>>>>> I have investigated the history around this topic and verified 
>>>>>> some internal
>>>>>> notes in our bug tracker. With this revert applied, and on the 
>>>>>> devices we have
>>>>>> (all trimmed with value 0), the reported temperature increases by 
>>>>>> about 10 °C
>>>>>> compared to before the revert. The absolute accuracy of the 
>>>>>> readout is
>>>>>> questionable: for example, on a device kept at around 20 °C, the 
>>>>>> temperature
>>>>>> readout was ~19 °C before the revert, and ~31 °C after the revert.
>>>>>>
>>>>>> Consider that for devices with fuse value of 6, there is a -10 
>>>>>> degrees offset
>>>>>> after this revert (so, the other way around).
>>>>>>
>>>>>> I understand that for Sven this revert improves stability during 
>>>>>> large XZ
>>>>>> decompression in userspace for few devices, but for us it means 
>>>>>> that the
>>>>>> thermal shutdown happens roughly 10 °C earlier, which is a serious 
>>>>>> issue in
>>>>>> our case.
>>>>>>
>>>>>> I would kindly ask NXP to double-check how these devices were 
>>>>>> trimmed. My gut
>>>>>> feeling is that there might be an inconsistency, either the 
>>>>>> trimming scheme is
>>>>>> not backward-compatible (e.g. old and new devices behave 
>>>>>> differently, and the
>>>>>> code should cope, I don't know how, with this), or this patch must 
>>>>>> be reverted
>>>>>> (because introduces a regression).
>>>>>
>>>>> Peng/Ye Li,
>>>>>
>>>>> How does NXP suggest we handle this? Were the early i.MX6ULL parts
>>>>> incorrectly fused?
>>>> I need to discuss it internally, will feedback you later.
>>>>
>>>>>
>>>>> Can the fuse be read and dynamically adjusted?
>>>>>
>>>> The fuse is locked by MEM_TRIM_LOCK. Emanuele, can you help to read 
>>>> it by
>>>> "fuse read 0 0 1".
>>> Colibri iMX6ULL # fuse read 0 0 1
>>> Reading bank 0:
>>>
>>> Word 0x00000000: 00320003
>>> Colibri iMX6ULL # fuse read 1 0 1
>>> Reading bank 1:
>>>
>>> Word 0x00000000: 00000080
>>>
>>
>> As is clear this problem was the same we had some months ago, so we
>> are on the same page
>> with Emanuele
>>
>> Michael
>>
> 
> 
> Can you help to measure the VDD_ARM_CAP and VDD_SOC_CAP on your devices 
> with high temperature read issue, when REFTOP_VBGADJ is set to 3'b000 
> and 3'b110 respectively. Provide the measured voltage and target voltage.
> And please read the Unique ID fuse of this device by "fuse read 0 1 2".
> 
> 
> Best regards,
> Ye Li
> 

I have confirmed the REFTOP_TRIM fuse is always blank on iMX6ULL. 
Because the LDO output voltage has meet the iMX6ULL spec, the bandgap 
trim is not needed. For the REFTOP_VBGADJ register, NXP strongly 
suggests to use the value from REFTOP_TRIM fuse or keep it default 
3'b000. Because ATE test uses the default value, setting to other value 
like 3'b110 will reduce the LDO voltage, but may introduce unstable 
issue like what Sven reported on some parts.

For the temperature problem,
1. The temp sensor on iMX6ULL is not designed for temperature meter. It 
is mainly used for protection at high or low temperature. User can use 
it as reference, but there is no precision limited in datasheet.
2. All iMX6ULL parts have been temperature trimmed at 25°C on raw die 
and tested at high temperature 105 °C on final productions. From our 
factory data, there is no such big gap on 105 °C, the precision looks good.
3. Multiple factors like measurement method, calibration equation, 
ambient temperature and chip status have impact to the result. We 
suggest to use updated single point equation (already in uboot and 
kernel) and below method for board temperature measurement:
     a. Using flat thermocouple, better suited for adhering to the 
surface of the chip.
     b. Shut down board or enter SNVS mode and put the board in chamber 
heating 30 mins.
     c. Power on, SW print the Temp sensor value in early of uboot to 
reduce self-heating impact.
     d. Compare the thermocouple value and Temp sensor value.
More information could be found from 
https://www.nxp.com.cn/docs/en/application-note/AN5215.pdf

Best regards,
Ye Li

>>> Kind regards,
>>> Emanuele
>>>
>>>>
>>>> Best regards,
>>>> Ye Li
>>>>> Please advise, thanks.
>>>>
>>>
>>
>>
> 

