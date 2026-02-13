Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A387FEF48CA
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 04:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC3D183936;
	Fri, 13 Feb 2026 05:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hjsSC5oI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2245683936; Fri, 13 Feb 2026 02:50:58 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E8F82BF2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 02:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRONVMJw+PN5WvwztrCNo7fzfa0GmB7bN98QzXDb8ZTnYlLoNRxLHZZMapBoJrwEYrqpJ0fL2t0WkAH1vVB81NhCBBkbuMg6XCBGX2J/wxWrij65z8pXC6WMXqLTVdhTgMHeVOtPqi3uY9hyKBQjtEuFuculiKVw/skzr27v6X9QPQzpDrgTMuuPASjpLfA+DwKNaPnlLIFVOz7wB/cLOEbqN/HNCK/NQG86RJZ9GC7+eqISgK+V9ibrB4f/BrgKws9Jzil4E5ZJX45RkFT3MwdUphOMY+IxLhdFs7HwDGL1CSawKcZlSgwTq+UbGIBAvXdg+ty79n7gNg3+jP5XDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+NHJ7BeGM3YsE61QJaAURVTACPz7MZ1XcmR23OhEFc=;
 b=mL6TAli7pPsIiz4Mi0oZw3T+U97EKtw4KvgG5yxOdjFEIaaPxJ3xzK79DOea67DHkc9/GN62FsoZEJKW6Ke/g6hEguxHJDtTnq/78xIeFS/KbWUmDDoO+iIqluvzDyNTg2i/J2N/+SqbC9BUgq2rNf9yK4/mCMrhkO+tifcKyuV3FSye3TRfeGMLP5hUzwsgiqfqEHdYTp5pc+FGVvY3WTkOJ18LSpq8F+JkUhtYzYMHO3biGAnqJztRTVMpvaSHeNmIo2zdEgdnRH72Idj9Dfc8S688yC+dzqzvL6fb1pgpWtEDVOZ7/F+dOrEL+cGASOcsuWjHkHSAvQjT7E5bdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+NHJ7BeGM3YsE61QJaAURVTACPz7MZ1XcmR23OhEFc=;
 b=hjsSC5oI7aZ21m5Yn0lHaT/2mcSIDCJryt8AqkSFHl75MVESRKQTa3bOGiEKWNv1SI4NLOv3+faqctaZk1rIifpWWhYAnqqP+4ic4mG6NuI68kLknAYtWLGB9INT0E/2R0Pmt7qSPc20gS5H4X8yTHBgIPn1Wfo5tnTf7UuhyYbcbwuG3GUjDyEOemcB4Afonf9sgoZKuIci5BwpzBv8HpRPmVxgdwzS0gZo6bZY+btKxI9FRJcfqlW5bB5iNYVwqgp4ITxqQADm7vm/yy/lDwR3Lii8u+PKHUVRRxKL5/28eRM/BDZW4706//IdchYUn1mfgnQo17PspkkI1c9URg==
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by DUZPR04MB9847.eurprd04.prod.outlook.com (2603:10a6:10:4d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 01:50:52 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 01:50:52 +0000
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Joseph Guo <qijian.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@kernel.org>, Lei Xu <lei.xu@nxp.com>, Stefano Babic
 <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ji Luo <ji.luo@nxp.com>, Simon
 Glass <sjg@chromium.org>, Justin Jiang <justin.jiang@nxp.com>, "Joseph Guo
 (OSS)" <qijian.guo@oss.nxp.com>, Xinyu Chen <xinyu.chen@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, "tharvey@gateworks.com" <tharvey@gateworks.com>
Subject: RE: [PATCH v2 2/2] imx: Add FRDM-IMX95 initial support
Thread-Topic: [PATCH v2 2/2] imx: Add FRDM-IMX95 initial support
Thread-Index: AQHcnIsv5cowL4UxiEGKG3owqNwTPA==
Date: Fri, 13 Feb 2026 01:50:52 +0000
Message-ID: <MRWPR04MB121179EEDC897C778425DE1289461A@MRWPR04MB12117.eurprd04.prod.outlook.com>
References: <20260212-imx95_frdm-v2-0-9a535a506b95@nxp.com>
 <20260212-imx95_frdm-v2-2-9a535a506b95@nxp.com>
 <CAOMZO5BAe0JYvqdothTunajpbA37K5R7xG6GCOv2MdGK0ohdAQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BAe0JYvqdothTunajpbA37K5R7xG6GCOv2MdGK0ohdAQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12117:EE_|DUZPR04MB9847:EE_
x-ms-office365-filtering-correlation-id: 18d4b012-a783-4429-0298-08de6aa251df
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dDk1Q0VJbUhraW1ySFhMOGlkOW9EQXFTS2srNW9uUUthMWwvZVNFaWwvM3pl?=
 =?utf-8?B?VFpyS2F3cGlNc2xVZWpnc2xSS25lbFJwUEU4dHB6RzZGeXRxRURSWU1INzd0?=
 =?utf-8?B?U0c2VmJsTTVmbytoSytjZ3VCQkk5TlNGRmVUZjRMSG04QXlFWWVDdllaNU1I?=
 =?utf-8?B?MlBiRlhYRWJRZ0N1SnMvUU9YdUsrL280OTdrTmJCb1N3SStheEgvOGQrSkZN?=
 =?utf-8?B?ZTNaU1dTbHZSUkNaQ09CSlFSaE1lQnRVUU1xb2JxTXdKZVgxemJaaHlFMUsv?=
 =?utf-8?B?ZVJITGZtL0VDZGlyL1Y3eWUwTTZNSmlUS1IxMlMxS3RLTFk3emtpQWE1eGll?=
 =?utf-8?B?VWIrWTZaTjBwOG5PaDhPcGlNVitvQUxKRkZaa0hGSmxUVFZWazlFVko1ckRR?=
 =?utf-8?B?OEovZnh5cXp4SHBVWHdhTERlNWtCY0VqME10QVg5RHVqMnB3OVBtSEx5ZXpD?=
 =?utf-8?B?TkJ6Y2FMVzJuTzV2QnNqTjAxcWNaZFdxRk53MHlSMGpNVmI0MzJld0ZkNFpI?=
 =?utf-8?B?Ym5mVS81QWJzdGlkM3dKdWd1MitjU2RBR29NcktWM0I3UmkzRGtaa3NoSkJP?=
 =?utf-8?B?ZkdKWHRkUkVyNDQyZTRFbUhqblo2WmxQZEhmUitXOWFiOXFNNjBud2NydWxu?=
 =?utf-8?B?Rkhtci9UOGJUeVR0OERMdktXTlUxNmVPMk42bXZzRmRXTnVacWFjNnBFeXJv?=
 =?utf-8?B?eUlzaW55NjNZcklZUVN1bUkzNG4xT3FXeGVBMUEvN25wWDhvb1Z0VmN0dVVW?=
 =?utf-8?B?TUZYcGx4Z0IxclA5TG81ei9EZCtIbGl3SVdBYitHcTJMVW9RMzluTTlLak5H?=
 =?utf-8?B?NVFvTHkvVU0vZjlKWDBGcm5tSHgvbSt6L0M5UUd0RmRweWphaWRFZ09vNUE2?=
 =?utf-8?B?b2FxdXMzeUo5Y1p4U2xZMm5tU3FpT2Fla0FOOWhRQ3FXWUlTbWhUbEJtYWRm?=
 =?utf-8?B?dEd5UlV5RldyTzc2dkxlWjJpeUVsN0lDOEozRFhmY3R5WHJUTjRPd0ttTkZ0?=
 =?utf-8?B?QWdyVDdCTTVxTlpvekdaQ0g1a1V3TmRUcjJURlJwMVhCWmhxdU82Tkhzc1ho?=
 =?utf-8?B?ZXFYbVFna3E0ZXN4WWE5bHN1eDNGZ01rbDVuN2FROFphRU1mVC9vMUJJV2Nu?=
 =?utf-8?B?NzZlMnBxelgwU1oyK0hVZmxiR1FXMWRlRndmODZpOHBrNm5tUmRjYmNYWFoy?=
 =?utf-8?B?cTZzdlVCa3NDRVVWQkVlWWIxSUZzZWxoYitIOXpzTEM0VWxucit4V0MxR2ZG?=
 =?utf-8?B?c3BIY0MwV3FUdG9OckZ5Y2J6MEFWYXYyWWVqbmYxQUxrd2tDK3B0Q0UwRmZJ?=
 =?utf-8?B?MUREbnlULzUyd2s1OCtRaTdXdy9nMDNnbEppV056NEZqd3M4dVA2OGpVRnhB?=
 =?utf-8?B?ZUdIUTl3aEhLTkszaXhWV29td1AvZzFTamJpS21GOFlMN2V0WTZpdytwQVNC?=
 =?utf-8?B?MGNVOWZ4MHRKZUFRODZhcVBtN1l0cXpjU1Npbi9IRExFNWZ2aEg4MmE3NHZr?=
 =?utf-8?B?cG1jQ3IwNHJWaXFTbCtMQTQ2S1BvWlZCTUUrNjNTVis0VzZZYkRHYk1TbDVD?=
 =?utf-8?B?d3ZmV2duUXpHaGtONGdQTlJNOFFLajQvalV3a3U0bjFEU2lsV2xwMmxsa1lw?=
 =?utf-8?B?MzEwM2U4c1ZYRWo4Y1U3aUZRdmxpb01rVndGM24yQTc1YnlubEZieENweHl2?=
 =?utf-8?B?MXhwb0lmZmx0ZTZuU0FpdDdVZWNiTWxrTnRod2JMMWpTS3ZYOEROdjRkL0V0?=
 =?utf-8?B?eDk5RVRDWXNMV09pMTI5NTJPNGJNaE1CeWVCOEY5bE5RbXN1STc3dXFJZVdI?=
 =?utf-8?B?TnB0NWt0MEdiRDZaNzY3MUQ0YjltK3VNNlRoYnJIMXp5MmlXUlBBa0wrekR6?=
 =?utf-8?B?SUxkd2lHRTJ2cy9EaUY1UGZnNnV4UUwyNDJETk5CRUFXRURaZ2VqR2dkR3Ex?=
 =?utf-8?B?S1hQei9OeHFXUkhRekYyQVZFYW1tRUY3T0FUWE9Ld2szRFl3SHhlYVN1U1dt?=
 =?utf-8?B?SWpjOHAxTHl2WUppMklFSHc3VnM1Z0dyczI2S0ZVZm9EUlJzVEZIeTlWV2Fk?=
 =?utf-8?B?UmtnYlRUcWdmbUROMDRaOVNHYTRua09iWHVteXdEV2htZkRBSnZoRW0raUEv?=
 =?utf-8?B?dXhrSHJ6ejlMZ0s3ZzJBRUVvSFdSRDhhbFF2MU9OY05Zc2ZLdGRpdHFxNkRK?=
 =?utf-8?Q?sln4BREonFGqoCHZbkF0GTY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dElVemFwRWxRa2pCMFdZd0pZSmZwNW9IQ0JwM1krOXpmVmdjT1dJNkN0WEgv?=
 =?utf-8?B?RnNXMC83QW0xbk5uTytSNERjZExhT2ZMa3pUOTR3TkRxeUx1b2E0NmljejIw?=
 =?utf-8?B?NVYxTERPTVpjMkkrTmp6N0lQUUN2dHlGUmFFVzVuWVJheVFiS04ybGpUMjZa?=
 =?utf-8?B?YytPNVhOdVJLVVp1TnRxVll4S3plRHUzMFBaRk5sWENTZGRVT3R2bzlzNXJ2?=
 =?utf-8?B?LzhBanVMaUEveVo4eFNhanRZMTBGU1MyNjRrbVVRT3RCZllQWTVReWxoRDhy?=
 =?utf-8?B?SXhSZHg4QUo4Z0NFT0FvUllobXB0b21MMkQ0bzJKQUd0YTVzVmJxNjgxbXow?=
 =?utf-8?B?VTMvZlQ3akwzMmwvSFV4ckNlRWg0VUZicTF3cEkxRllodWpsbityMGtvNklJ?=
 =?utf-8?B?UStFMHF3TkxFcVpyREN3ZHlFZnplZy9XcUhveXJZa0daQWNZTlZ2NGpTd1lW?=
 =?utf-8?B?SkpXQktXUUZoZFhIOFNjOVlHaVJNTHpDUnFmWHo3bGh5c1M4OWwxaHIrVkgv?=
 =?utf-8?B?bWdrNUJ0MHN0cXlMK0gwNHoxN1RXbFBnVE5yVURndkVqQnp0TzJqdHZRMFdP?=
 =?utf-8?B?WTNyc1ZxOEZKRFl5Q0NFVTBXektoeFdpZyszY3pYL2tTZHFUc2s3Qlp0bnRJ?=
 =?utf-8?B?U0M2YjRiMlF1MzltSG1JZS9NZ3R0VXNWUVNjMFhwR2hRUU5HNHNqMEs1Vms1?=
 =?utf-8?B?amRRMi9heTNuOUZReGJLTFhTQm0zUnpDUUcvV3IrSTNJdlM0R0xQY013YUUw?=
 =?utf-8?B?RzBXcDNzamhqVyszTkgxUDkvUHV0WjA1OUdiV1p2WnFLU0NMSEU0V2t0L1Ft?=
 =?utf-8?B?dWZGVUhSdVoxT0Z2UkFDMFpuLzdaZlJUMnd0cFpVOW5LQ0FhL0NIQ203OFEr?=
 =?utf-8?B?TERXQjA2UjFWNTlCb2R6RE5neWdqOERaT2k3N05ZYU1Qc25CTmN4UHVzNGNK?=
 =?utf-8?B?Z01SQ0tOc3lhcHRGWjFOeHlacVhrcXJmalRyU3FjRUJsNXd0emFJbmw0OEtn?=
 =?utf-8?B?dEZocjg2SXNjQXo4RVRNWU5CTWV5U1dQUmFXMnNNN1ZJdjVRTm5TaVk5dW5G?=
 =?utf-8?B?cnFqb2hybW4wZHJUb3ZLWlFyTk5VRURYVlpLS0RmSHg3ZXNieHA0YlRuandJ?=
 =?utf-8?B?MzhwekhDei84ZDBobXkvb1VTN01DbDJzOVZGTS9QZ2NtVWxQeXdIT0dMZkZa?=
 =?utf-8?B?aittTVRZY1FmQkZuMnVXU2tFeFRhSk1zZ09jOFBYSHZhRVlJNW1MU2ZqTGhs?=
 =?utf-8?B?YWxyVmtsamJYWFpyZDluUnhOK0g5dXlvZ1VuOE81YnczREt5YlVwRnRVK1M4?=
 =?utf-8?B?eXprQ2JxNk5ZbTBPM2EvakdRVEdXY0lzOVVOaXpEeDVORjhEK1FxQW1mR1h4?=
 =?utf-8?B?NEoxUW54b1o2RnBwdk9nSjRlZjZKekdoSFJ5WmdrNU54a2Q1b0Vvcm01ckRW?=
 =?utf-8?B?UFlKYUFTNmYyMmUvNUtsNmluY3NEdFZ0Wmd3QWR2N0tpTGxqMEZpVjhuek9G?=
 =?utf-8?B?K1RjL0t3VU1uWjFxdzNMWlZTMHErN1dyZDRHS2x5aS91aGt2T1NXcFU0TlFj?=
 =?utf-8?B?eEdUSVFVa0FKUjIyejd5L3VRQkJuQm5reWhOZW1rQmd0d0NCWGhHeXl4T0pT?=
 =?utf-8?B?Rm1Vak9NRDB6dGpQU0NnRUdOMnlvbENVemFsNFBUZjRwaGZoazhwVjBFSlFP?=
 =?utf-8?B?MzZlWXQydEtldGIvdVhVZjlSbFQzTWZ0OFk5T0ZqQ21zaVprMDFhV2V3NlUv?=
 =?utf-8?B?WFJMRC9vQjJ6VEQyZFZEUUI3Q0VIU2loRGZKZnFqQ0RsN0lyQzhveDVHOTc5?=
 =?utf-8?B?U2ludjRoTklUbjZMd1FvM21tU3pVT0FZU0xaT1laWit1bjhsUlNJKy9JQ1Fh?=
 =?utf-8?B?TkMwa3B2ZjhpRFdZMlU4azZQWktTdUkxMWFvOTRFaTVTNjc2QTF3OThqN0NQ?=
 =?utf-8?B?WlpYLy9zMVRXRUFWSWxOdytXWEJPeUFrV0p6VGlzRUpoSG4vWXZoaGNJNVlD?=
 =?utf-8?B?ajdpYzE4cStFRW1EUkluSHh4QlB6NVhZWlRKaEpIc0xGUzNON204ZzhobDds?=
 =?utf-8?B?cjdYMUkrcjZBek44Zm9DWGpMMUhGK3VlZmN2NFgxb2dWdE1vaVlpdFFMalp6?=
 =?utf-8?B?Q0N1WVcydUkzWExlRmpwckpnemc4MkxVN0xYMFVWQVhaTUlhY3pad05qUFkz?=
 =?utf-8?B?bUxWV1FGSFRkRWt4VDRqd3MwNjM4eHlDb3NxcGZ0bWdkWnFMZmxoOWFldnFR?=
 =?utf-8?B?T1RDYnN5cTJjd3pBSjE2TWdlRXB3RmlWZ3kxQTY2MGpNSUFGL1kvUDVHZGdD?=
 =?utf-8?Q?x3lbZbDrqf7OxK/hmO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d4b012-a783-4429-0298-08de6aa251df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 01:50:52.3595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e806ufU3pOHFAQ/rTtXOj90AO3GGelleS39Tu8snkSFhmHarInEn2iPbDYjTAZPdmVBGcLrmGziBnNnEarbyjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9847
X-Mailman-Approved-At: Fri, 13 Feb 2026 05:57:19 +0100
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

PiANCj4gSGkgSm9zZXBoLA0KPiANCj4gT24gV2VkLCBGZWIgMTEsIDIwMjYgYXQgMTE6NDHigK9Q
TSBKb3NlcGggR3VvIDxxaWppYW4uZ3VvQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiArKysgYi9i
b2FyZC9ueHAvaW14OTVfZnJkbS9pbXg5NV9mcmRtLmMNCj4gPiBAQCAtMCwwICsxLDMxIEBADQo+
ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiA+ICsvKg0KPiA+ICsg
KiBDb3B5cmlnaHQgMjAyNSBOWFANCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8YXNt
L2dwaW8uaD4NCj4gPiArI2luY2x1ZGUgPGFzbS9hcmNoL2Nsb2NrLmg+DQo+ID4gKyNpbmNsdWRl
IDxhc20vbWFjaC1pbXgvc3lzX3Byb3RvLmg+DQo+ID4gKw0KPiA+ICtpbnQgYm9hcmRfZWFybHlf
aW5pdF9mKHZvaWQpDQo+ID4gK3sNCj4gPiArICAgICAgIC8qIFVBUlQxOiBBNTUsIFVBUlQyOiBN
MzMsIFVBUlQzOiBNNyAqLw0KPiA+ICsgICAgICAgaW5pdF91YXJ0X2NsaygwKTsNCj4gPiArDQo+
ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiANCj4gQ2FuJ3QgdGhlIGJvYXJkX2Vhcmx5
X2luaXRfZigpIGJlIHJlbW92ZWQ/DQo+IA0KPiBQZW5nIGhhcyByZWNlbnRseSBzZW50IGEgc2Vy
aWVzIHRoYXQgcmVtb3ZlcyBpdCBmcm9tIHNldmVyYWwgaXRlbXMuTVg4LzkNCj4gYm9hcmRzLg0K
PiANCj4gPiArY250cl9maWxlPW9zX2NudHJfc2lnbmVkLmJpbg0KPiA+ICtib290X2ZpdD1ubw0K
PiA+ICtmZHRmaWxlPUNPTkZJR19ERUZBVUxUX0ZEVF9GSUxFDQo+IA0KPiBQbGVhc2Ugc2VlIHRo
aXMgcGF0Y2ggZnJvbSBUb20gYW5kIGFkYXB0IGFjY29yZGluZ2x5Og0KPiANCj4gaHR0cHM6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIwMjYwMjExMjIxMTM1LjE3
Mzg5OA0KPiAxLTEtdHJpbmlAa29uc3Vsa28uY29tLw0KPiANCj4gPiArI2RlZmluZSBXRE9HX0JB
U0VfQUREUiAgICAgICAgICAgICAgICAgV0RHM19CQVNFX0FERFINCj4gDQo+IEluIGFub3RoZXIg
cGF0Y2gsIEkgYXNrZWQgQWxpY2UgdG8gcmV3b3JrIHRoZSB3YXRjaGRvZyBkcml2ZXIgdG8gcmV0
cmlldmUgdGhlDQo+IGJhc2UgYWRkcmVzcyBmcm9tIHRoZSBkZXZpY2V0cmVlLg0KPiANCj4gUGxl
YXNlIHdvcmsgd2l0aCBoZXIgYW5kIHJlbW92ZSBXRE9HX0JBU0VfQUREUiBpbiB2My4NCg0KSGkg
RmFiaW8sDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50LiBXaWxsIGFkZHJlc3MgdGhlbSBpbiB2
My4NCg0KUmVnYXJkcywNCkpvc2VwaA0K
