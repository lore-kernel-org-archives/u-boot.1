Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04596CCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1577838FA;
	Mon, 13 Oct 2025 09:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YOykn8Nq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF1B8384E; Mon, 13 Oct 2025 09:00:00 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE9F8381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDr1Qjx4dxvn3HEgOUGh47OON/Ot8OTvu/DlWBdOvQwm3KYoGcVrufC4PkPe8IuTWgBhmMDWwN6iZtQTlf3nzEg8K3h+EQU/iUwBaWy15JPwx/rbDmKv6FmagaOPeDSO5ztqpcQJm/oTKVRaKmfPmHC6/VyJRk+WbWpah6sPPqpXC6D2+7sy4aBtARYYsL8cLdBnMm29j01j+pYUs1P4w5yEtSUygihryW/M+safz7+DLSHWsirY4sfI8YHm5Yp/FXyRJ3bTN15HEMQYceoMmdM5rgKdoEVxoAxA9fiNvaxt1EZryHJtCq7abwt+bgUHP80MdI2/wJdjno6kYf/lsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMKnJnsjLg+W3u8Ehu/GOT+mqsuVM7iGL4GIK9Mf09k=;
 b=tSq8N7JFSNCVBCim4n55Yj9SIlFAj6sHgN7A3Q+SaYBRNKrscmoAilf20gNSlc8Mi6XuZ+HzVgA5oh+SNsSdgCGk/NdhijqAEXwuRo+WL6yJFYwO6Hge3V5txhY+ah8whW5KMhh7Ztmn9vgiWlUziDglaL0BpukGfZFwT1Qs06m5bIZ6W5sdgIWFbsa2NXXdVYhxxhcrRlSrNmWy+k/7fQlLclYOS/qR70cqPakeWsapWQOJOusMpYtJXIxaKDb4kRdx5r++5Ebsmb76ffOc+1AderXCMsNY1M8aMun3Hv07cXl0pSIKAXELCXFRcEBAuJfuwVRh+xQoTsB2X+PpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMKnJnsjLg+W3u8Ehu/GOT+mqsuVM7iGL4GIK9Mf09k=;
 b=YOykn8NqxcqwuNe9ZRY3TGEtvlPjuuqlgQjhxXucbACx+X9qKBN06N+pSS9Bn/0c6ame/8FPTwOoPh6C0T6TgKtbP396Sq2dCvJ6DZZSE3Ap66UPLo9tnvIES3aehp7oLrlazViDqwZORntkEKBAXCR/G+vV1LrnGUH7ueRGghzqdN125pZGU1IhhwedgcqayCrq62Mt5l3+H6s9poTF1qtmULghTe8PVsTdaQVXtvD9XkcuKdnrTwUgJjys09fpgOet72vkrFlZ+syv4J/abrBsaG15AazCDlPm576sWgmzQWAV7m/ceBm/xrkhiG/CKe7dlDnhtOlmhUiYKoOzBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:59:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:59:56 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:45 +0800
Subject: [PATCH v3 04/10] Add serial# for SPL SDP download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-4-293e79d4bc12@nxp.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 638201f4-d24f-4680-56e3-08de0a261dea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3lUSjBSV25qWDJ0RTlJc3RHTGI5RDBRd3dhWE1iSzhCendjOW5wWnl6My8v?=
 =?utf-8?B?NU9TdVJDNXlnbWxrRWxkL2E3L3ZPMzc4U0JlVkR1cmNvZHNKQ1lDRkxjNnlW?=
 =?utf-8?B?bFZsdkZ5dlZlOWNuaFhxY0ZKa0lLOHRiVWE0emVwdTR3TkxRckpPUGEyZ2J4?=
 =?utf-8?B?UzU1TVMvL2RmQmw1dTNlT0VvM0gvb2o0MTdqbXE5bFNsVXZWNERlK29DM2kr?=
 =?utf-8?B?aCtuZk5BbXNYdzFYUGhmejJkR0kzeTVFSmhyeUV3bDJDaEdvZi9YeWU4TXlu?=
 =?utf-8?B?U0tiZlVHVFUxcXpjZERQZ1VrZXVvRXFYVHNreVc2MGdjN0Y2OFdlYUtTQXNY?=
 =?utf-8?B?Q3dHdGcyNktzUmdTQm04MDJxWTVrK0VHeURmaGpuRVdqODVMRS9McDlPUndY?=
 =?utf-8?B?V0NXa2J4Qzk4VUJjWjJ3d2MrcUgvc3lwWmRkOE5maU5HamZGTTd0d3d6VFk1?=
 =?utf-8?B?U1cyaDRlWHYyQWV2eXJZWGt6bkx4ZHJyMDNpdWFrMTRESWZnREFpNFQwSFFl?=
 =?utf-8?B?ejY4K3VmVVVtNzhnMVR5Q0cvSGtoYXlvOE9ldTFZdFpOOTVGcnhtQmw3TzRo?=
 =?utf-8?B?bUJOVU45UVB0RVcrNFVtSXR4R1F1aUZOOHZ3VVlwU2pjVVlqU0IrUGg1ajIx?=
 =?utf-8?B?cm82TW05VVQvT3A0Mk40cStzZDk3L1ZkbkZRQXV5bk80ZzhLdXFRdEw3bEVS?=
 =?utf-8?B?UTJaWHBYaDhadjVJcjhWbFQ4Yk42eHF0blJTQkoraHhYWUxwT3k3WUtKeVN4?=
 =?utf-8?B?R0ZwRDZ2aFk3dytGZUZabFZBdVdZRTJUUlYwc1g0MzhKd0hGSndYb25SUUY5?=
 =?utf-8?B?ZkwzQ05Qd2hnbkovTS9NRkJDQ1pPYVdUaVR0UE84RUNRZWgzU2Y2eW1ZU3ZR?=
 =?utf-8?B?UFhTZWlaOE9xWEQ5QXYzUnlOZWFuM3oyMGFraXhpYSs2TFhOdmJUK0N0OFdG?=
 =?utf-8?B?K3g5bks0SXRweFhEM1RvL3pISlFqQVdsNVlkNUtOU1VTa2dJTjMwRnE4K0U5?=
 =?utf-8?B?SnRIN05sbTlqRmdVRWF2bzJQRmNYUGpUblJncGZ4R2dBd2d3U0V2WUhhaDNa?=
 =?utf-8?B?bmhjNzZGM25WVHh4YnpBSkJ3T0NMdm9ZQmNCNHYyUytMS1kwV2VOZ04zZzlY?=
 =?utf-8?B?VVVTT2oxTDNxU0liRmYzd2hsUXM3WUdTcnRYU3dqazY0SStsdFZ1TDYzRXli?=
 =?utf-8?B?NEdVNUpOVjhTMXRuY2ZSTklqVmRKQkUvS0RCR09rQmVrTlczYXcxMjZ6YmdS?=
 =?utf-8?B?c2FuRUkrNk5NTmlFOFhUQ2pWQTlYeUlHN2FJK2hRbTErT0dUbjhOazcxVHFv?=
 =?utf-8?B?eUEwN3RiOThBSkxHaFRxZndFN1ZPb1BnWkxhUW9lZCtLZ2xrMlRWNDdVVGcx?=
 =?utf-8?B?Yk8zNENlV3JnR2RCcFZrZnU0YjN1dXh4VmNNdURJeDhPU2JSU3gyNlJEWjZC?=
 =?utf-8?B?d0E0OVVFU1lINVBhNVpWVG5PUE5vMVVkcVZPV2o4VndGeFFIOEhaKzZFYjdV?=
 =?utf-8?B?TjFFZ2RmQWhSdnEzVVlHWUFTaVZKUzFIcUdFeWduYk8rUjJjR2RnL3QwZmY2?=
 =?utf-8?B?RzdMNU0wTFpnTXMvMmRndXZPODl1SkJQR29vSys4S2ttdEphNklGNDgxUFJa?=
 =?utf-8?B?YVRKaHJkS0treVFMd3pqYWNacU9paGhGcVlwOG1RdFc2TUcxR05wUFd0RWRl?=
 =?utf-8?B?bXY2aElNS2NDd0JKa3VUZFBOcVFtT0xFUGZ0eDFTbzROWDRoQkdLUnFkR0lW?=
 =?utf-8?B?TWhIM0tNZFBuZDRDZzBXVEI1TWpGK3lDVUhQcTVUcURGektwYy9tWTBkTG1q?=
 =?utf-8?B?TnUwcDY1NnVmd2pqTmpPTUhGTnpIRlhCYXp3aU9KYW9TMkgyUk5SeEwwUGxw?=
 =?utf-8?B?VStpbjNmdWxrdDNRamZvMDJhdTZTcW16QkxVU3hnTjI0ZzZXd1lRamJPOFNo?=
 =?utf-8?B?cXREMXJDTjJNWTB2TXpiZWx0aHI5OTZOMjlRbjdGYWpaeWdzWERHdW4vWXNq?=
 =?utf-8?B?LzBlV1FIcmcwMi9tMmRRSy9Oa2dIRG81WW9RbVBSaWlxOWY4UCt4T3VLSmxw?=
 =?utf-8?Q?Mb2I8I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJYdGhHN29uZ2RsZVgxYzFVSnNhQWNmL0dObldmV1NQZFF5UGJNcDZyU040?=
 =?utf-8?B?cUJ2bU5QY3k0MDZYZmw1Qkw3QndQcU45N05XdUdFbWhnaW9HaERXTldRWWwy?=
 =?utf-8?B?QVo3Q3NUQXBDeE5wZ2REYmg0SnVacEx2KytkKzRiYXBvenRHL1RiRUd4NjBo?=
 =?utf-8?B?bHYwdzc4Y3FtSzc0WkY0TzZiWXJGSlQzcXBJcHVzOThxWUxTUStORWNMOGdi?=
 =?utf-8?B?cm9NckdPbVEwQjU0b1M0UG5kbWJtbUsvL29yVWZYbTZ6SUxvMlN6UkU3ZFh6?=
 =?utf-8?B?M0ZzT1ZJUlZhTUJPSkhlNHNIR2JkbHNnWVh3ZU5qL1dNdituNzVXdVB3UXk2?=
 =?utf-8?B?YlYrLzB1eWZPcDV1bEd6c3AvaEpZRy8vOHBOUThjNnJDMzZLYUVPdmMzWGd3?=
 =?utf-8?B?RUswVmtHQTY2ZUZkYjBkZ3ZlM1JkWUE5L1VXdEd5aFNQNzlQdnR6T01YMmlo?=
 =?utf-8?B?bWJmTW83c2tHMlgwb2o2K3BySmxuVGxqU2lDenptQ3NjLys0bkRYcEl0czNC?=
 =?utf-8?B?QUs3aFlZOVg5RWZMSUx0OHRQQ3VqY0VnSVVzR2xVc1VCZEw5QmROSVRwZDhr?=
 =?utf-8?B?YmQ0MEhKT2FJTERGQXBiZW1aWll6U09FMmVnM0ZPaTM0S0tHeHpGcjJuSXRn?=
 =?utf-8?B?RjhqQ1U3NjVRcXp1K0tLdWVWN2p0RThIR21JTmN0L0pqaGVFNFlXU2NRMTlV?=
 =?utf-8?B?UWVZTTJhVDE3WU5jL0t0UVpmbjRKZ2F4ZWJFbzdHWDVQSWYxSlRjSzYzendB?=
 =?utf-8?B?VDM3VWNKL0UxdlB3Sm1YSm9KRlJJWHdsMXdETXBhVFp4K3hWZHpCSjJrbExw?=
 =?utf-8?B?b0s0YW1Na3ZzaXcxRDRmTFVQbGszcFJpUDU0a0pxZXEzRENoRExLTDJIeldN?=
 =?utf-8?B?YzArWGF5UDFxSlNuR3ovNUZiUWlXMFVzalIvbHlaVWEyazdlemVhaGdvbnN1?=
 =?utf-8?B?dTJQYkwyNElMSnJodk9WNXpSZGZiRU9SckVWWVNvd2pSb0Urb3pxc1lDeWtn?=
 =?utf-8?B?c21JWXVNL1daUTlZV3RscUhIcWZ2bk8wVGJVSDAveVdJQVVna0pSQ0FMV015?=
 =?utf-8?B?alFXS01wZEIxRVJCTzcycGc3UVlrYk1tOGVmSjJzQ2svSkQ1OWdHQk1NYWg5?=
 =?utf-8?B?UmgvNmVXOVRuYWMvMnNPOWhtZHZWclF2djVOUXZUcGdCMkphcEhXbzVTNzhB?=
 =?utf-8?B?eVUwdjNJY0s4dFpjYnU4QWRsRVNHVjVxZi95SXBlUGFiVEtOYU1DVjFVck9i?=
 =?utf-8?B?MURYa3dWcHIwbW55bjJaR0JaNWZUNE8zb2JYMUtBWHBNTVF6QmliWVJjemNt?=
 =?utf-8?B?SCtnRHljZmNZYklyT1B3UDBDUmU5bkE2VVRzbFNhZmc5aDhqRXplejN2UTdO?=
 =?utf-8?B?aUU0WURRbnBHcUpMWjZhS1ovY0wwLzNEM2hwSlk1aTdoaGZvMXNGRUw4bUty?=
 =?utf-8?B?c2NXc0IwY3FUSVBOYStrRCs5VysxL0g2S1VIUUlPRllZWnoyNW5xV01lbjV0?=
 =?utf-8?B?cVVzQjJEK2FLZVdyaGlCV1BQRDlRNy84WG9VTHhITnFHeGlNc01WQWp6ZzYx?=
 =?utf-8?B?TmVPemIvcjZUcmxDYWxiZFNnSnV6YnZSLzNLcTFqeW1waHZhbmo4dHZHN1Y4?=
 =?utf-8?B?N2hBUndUVW4yNVZQZDZ1dm1Yb0tsRUlEcnY0WGFiM3JCTS9kaFFIRTc3dlVX?=
 =?utf-8?B?S2RzMTJYUVFsVGxCUFhTZ3dGazNvZWw2V1lMSnk2aTVxR2E0NE1PeXVQblUv?=
 =?utf-8?B?NHlGU1pCOGZEdk1WUVBTakNtb0JoMVRncVBvdVNBOFZJUTh4UFdleVllNzNl?=
 =?utf-8?B?SVpqM25jbWRBQno5LzhQSnVXNVU3M0wrSEpENDZUbEFLVW13WUpnTnNLVElq?=
 =?utf-8?B?THBMak5XRTN1VkIxdU0rdWlTVmRyYnV1eEU3QUpMODhrbUVMZHRtQmVncjhX?=
 =?utf-8?B?aWFXUHZyekZpYzZrWWxjNDhoL3pqbFJjNzNLMktuamRydFNHZTBCUG1KdHBN?=
 =?utf-8?B?Z0c2QkJPMUl5cTYzM1JPdnFrQTlOZXpqVllSOEg5b2Y0anhSM0xBQzg5VUdM?=
 =?utf-8?B?RGY1S1JsSFJ6UDFtUmwvSU1xdVhxaUlXVC9JUmhrdHhLWk9EK1JwREdlVzRy?=
 =?utf-8?Q?kjdgjvFGJxdKmR5ABKNBUFnrF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638201f4-d24f-4680-56e3-08de0a261dea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:59:56.3566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbxw1twdJm7xJL18eKTCwq5Q5E4hIKnu8R1/q/ATJb5MIfx452pGGDLCIYiOSbmTITOPphFLuCxn/USW+uAU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

From: Frank Li <Frank.Li@nxp.com>

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...
[sudo] uuu -lsusb can list known devices with serial# informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/spl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 518d9cb1262..d4ede46b751 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -21,6 +21,8 @@
 #include <g_dnl.h>
 #include <linux/libfdt.h>
 #include <memalign.h>
+#include <asm/setup.h>
+#include <asm/bootm.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -184,6 +186,14 @@ u32 spl_boot_device(void)
 #ifdef CONFIG_SPL_USB_GADGET
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
 {
+#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
+	struct tag_serialnr serialnr;
+	char serial_string[0x21] = {0};
+
+	get_board_serial(&serialnr);
+	snprintf(serial_string, sizeof(serial_string), "%08x%08x", serialnr.high, serialnr.low);
+	g_dnl_set_serialnumber(serial_string);
+#endif
 	put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM + 0xfff, &dev->idProduct);
 
 	return 0;

-- 
2.43.0

