Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44676CDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6461589045;
	Thu, 19 Sep 2024 04:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PwmMho4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78BA88D4D; Thu, 19 Sep 2024 04:58:38 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0719D89023
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9euDnSxUR7mbh16chKqoIoOVRFeyCKHcQtTbjtDZkkkqj98kpdb3Z5aqvt9kV/nG1n+t4WihT1CkmSwQoStewKCI7b6v3kG7MxYrjN4BWbR5HQB3gQA9JLamtb4tfLgM6SmoM9jhxbnXkPBYAhGbOs71M/Qy8S4BFUN6tKgaiiNeeH3T8iccLsY80A8Y9iCanPQDpZQV7M/e+oP1Elup0Ce5hPOxob+JUWb8wugLNzy3UeqImzLHypeX6GO4dChnXvEcdhJeJFzm5G0Y8Gn7T0OFdy2Nzv8m2ej9IcxVsB4qtN8yOJQFwu5ibyWOsfE1ueco7n7xaz9/NpBPhJ9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rhph9MBTEgkBcy0Hvfgn5cngAjsQHA42IdHuY/goUYU=;
 b=ADZ6/i58pG4X7Qi/+FthKzMEZpmcXmC2GYOoxvQWzZ7Ux67NEPh3TjW+p3FKGQsMgSNI/oahKZhEuelc9r//qhNFWNoXN+ckuCrqfiax3BxqX9TWnOPX2Exz7uZZJCdjqlzTAnzBi8lPfwBSdMiFYBGEx/TEdDY4kecMI+e6TO7fqORStUPiQLwRDqbffrWnG4pHzsZFsk4FWQRbd8eZsf+ktqO3koD9RVXHEka2DrDV46uxOeYTALwicX03sOgH2NW6C1th1outKLqcWHUuKtx4AgkeRobIyxKo25Pl45O9qpJ3p4XE1LO7j73PU+ggKtYSW26YpSy26kDDFgZK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhph9MBTEgkBcy0Hvfgn5cngAjsQHA42IdHuY/goUYU=;
 b=PwmMho4dWiX70Wepf/jR4b72SIAXIX1iB2/uCXioz63PpZn3/vCqBUMBuO6jKLzvrVTuFc1tBL09Le1wo7uDzLdgpw7SpUb1jtv9kkMga6QdQDyXCVYW/o22+fubn7fk6Ai3sZkXS3p3UxhzpakbNXOKANsM6+kButxreoCLP3dmkJ6NoDoyZe8dYwAsVQ158PyN6wzeydT7Tuv0BhgS+Ywh5FxspnMBL/GGz49oH7CIm5mpH6zfUKVp1ApiS+jlCutD+lmrVTkNiLzjrCxgOK9NR73BFMlaBak0JjAYA++Gbw40f7WzO3SKKfwHw2Mwqc9Jd9dAunU7RCb2T5+QRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:30 +0800
Subject: [PATCH v3 12/21] imx8m: soc: Drop disable_pmu_cpu_nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-12-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: ee01b2d3-0e9a-4aff-1973-08dcd856f403
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk5VVnJiNzRVVUxoVmZzUnRVSHlISHMvWm4wYUpZK1ZxdGZCSEZGR0d6Unp5?=
 =?utf-8?B?dUEyc3VZbWJvcXFJUTVrbEIxdUdjSC9JZnVKamQ2cTNOQnFwUDZtOU1QTVdM?=
 =?utf-8?B?NHRlR1NMa0V3UVFoTnRUMkNuempHMXVQTnlUNVVkdHFYWUkvcGI5eUkvbWFt?=
 =?utf-8?B?WVZ6dXMwNW55YkV6cWU4ekpMWVN1OVRySmVTelBGMzd5NHN2eUx6NUlybGtW?=
 =?utf-8?B?NDZFMDl3M2NDTDRtZS9hc0JvYVBBZFJEazlML1ZPbmcyNzJjQTN0UndvYUVa?=
 =?utf-8?B?cjhCcm0xb3NxSW8wL3ZyK3hsRmxvZTNBWDY3RjA1dUtOKzAwZnNwKzMzTEVZ?=
 =?utf-8?B?Yi95NWgvUG9zYVNjNTJQOHprNHhnWGpYRmRHRDBhQTFid1NmUy9GLzhUMWVs?=
 =?utf-8?B?dGJ2dXFHOFhSRnU3SFFXOEJ5K0lMVm81dDNWSjFvYW9aV3V6eG1EWEt0Z1E4?=
 =?utf-8?B?czBqQVo2TFp2UEJNV3RHaTdGZ3pNcHNoK3krSkIxc2FqdnNiVUFISDNWMnMx?=
 =?utf-8?B?MzYvQUx5TE9EVitUby8zSkt2ZzRVNWNVc3NobDdzQ25OeTNNTWl5QWhGNk1V?=
 =?utf-8?B?eGx4eFFBbzZsTHZyMFVOeFBjU2FRRVdkUFBRMld2ZWEyN0prZmxoOFZJczdn?=
 =?utf-8?B?aWYyenF1bG4wajBBM3RXR2FOOUEyc1NFaUxabXdnYzc2NDdIMG56Qy82NFk4?=
 =?utf-8?B?ckM1Vjd6OSs5ZThhcTlqWnBQbUR6QXhaZDc5dCtzc3U2MGJDZUloc3Njd2ww?=
 =?utf-8?B?NGNEV1RyTnJHSG5ackJFVHp6SWN4N2V2UEFYL0tKOGNadGNLN0Y1dEl5REt3?=
 =?utf-8?B?R21DbjdnQ2xCMUFOR3dMaWFKM2hvRVNCQjZzb1RvbXllM0l3QXZDTmNTSnFp?=
 =?utf-8?B?UXdUZ0tIUnowdDk4WVQ0QmEvZGxWK3FwUGZPdGdjN005NVFzMHBaWVF5S1Rs?=
 =?utf-8?B?aTNWWDJjNlRNcEI3RHpvRXd5L0xYSVEySEFQenZzOWJJVGZ1dG1Oak5hcHVk?=
 =?utf-8?B?YlZ5MVVNWHMvZ1BtZXExM1hQZGg2SDBQRWk4U1k3U2lpSGNuTHg2d1hUVGJC?=
 =?utf-8?B?UGpTdCtScE5Kem5QVGVoZGF1QUlpVi9IK25JaVBFTnlUYzhpVkNNRCtxTDA5?=
 =?utf-8?B?ckdlZSs1bHNRTVZxMlpiaEs1ODVvY0tvdnJzS25hVUtKYnpsd2Z6U2c1ZWZx?=
 =?utf-8?B?aEo1SEU0V21yWFMwa2Nralk2bjAwbm9jWkxqTkdqbDVJUGNpY2FjNW1TOEFz?=
 =?utf-8?B?TVpyUDExRFNISDFmT1ZJWlNjU3VCM2xIMW5CZ1R2WTJydW5PenVpRWFiOUg3?=
 =?utf-8?B?RnlqSkxXcTdsQ1lJQXBpVlVka3pLbllBUkMwS2pWWHdkbHpDRnZpcGwxdW5G?=
 =?utf-8?B?Y0ZsQVBRRXh2by9xb1FzV0oyNHdydGJ1cnE2Mjg3NldzbEg4WWlFQkc5RzRn?=
 =?utf-8?B?UXppVFBGUmo4dDdJYXNscmdENDFxK3EyNERIdUpnZUYrYTN5eHZyWnJST3Ni?=
 =?utf-8?B?TkdKQSt3WnRTSkNRUUxLOFFNZXlhT0taMStOS2VUTVptNmtIcHJFNmQ5VGtN?=
 =?utf-8?B?UDNCVFNUSUdLMUdjSnNkYk5yYUNTM1JNeHFpbjZLU3UrVTQvYS9GK0VrclF6?=
 =?utf-8?B?Zk1TbWM3SlhXaFFleWJNR3paY3E3TmhzczBmVGpWbTQrMk5TeVQ2dWRZUFZE?=
 =?utf-8?B?a1lLUXlIWVNrRWt0alNKRlM4ZTlPekV2UmFKRXVmYVA0UnRrYmlWK2xMN3hm?=
 =?utf-8?B?RFlUMk1ZaVVjVjdxWmMzNHlLVVNWZnduTVdITW12NlBmdXczMFRZbXlNdnIr?=
 =?utf-8?B?WW1OWndKNzFDSWc2UTUzZzVkaEdFRFdUK1hzcUtQMm9VT2JCbitPNXF2MExv?=
 =?utf-8?B?Smt3akFuUHFQbFJUZU5hL04wY1NiL0pXSGJ2U0pTYWtjVXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FRM0h6cldQU2FsSkxCMGxoMnZ4dXpMSEhLSDEzeWEvT3hvekdHeUZEQnpw?=
 =?utf-8?B?Q3c2cXA4Y1VBa1Q2cGlrcWtiaDB4MzJrNUZxU3o5LzRUZGJnaHZyN2k1a3pQ?=
 =?utf-8?B?dHFhRjk2TVdLMVBlUlNuVVh5LzRWY3hMdmJqcHRCb0h5aWprQ2hnb2VmaUdz?=
 =?utf-8?B?ZDVtVm1UZlV5S0tEdXdtUXVuL0NZRzJ0TVRBcmdGcWZRcWdJNGpQS3NPeWZK?=
 =?utf-8?B?dHFDWWx1SmlDdm1nOVJRMHQ2WFVsZEZNUE5MUEZLUGVkVWxsZm9naCtHZVVF?=
 =?utf-8?B?dEc1YkNUVGxGQWswL29MQlpWSTQrZG9rODh3NVUyYWZiTm5MMXlvbHd1dnhI?=
 =?utf-8?B?VElFemppRTFmR2lINldOVXhTakNkRE4zRnNONCtQWDl2bjlzdVB4Y0ZmYThW?=
 =?utf-8?B?K1JKY2d0WHp2d1FQR0V6RE1XSy8yUjhXTmRqM002T0tVWC9QVzB2Wkh4QkJv?=
 =?utf-8?B?dHJ4KzdQUVJyY0g1NjVrY3lXQTlrYzh0T1ZWbzVaS1JXajJKSjB1ZUMvSjJu?=
 =?utf-8?B?YWtiUGhQTDVIV3N3V0hpeE5Dalc5bHJkUmV0SG9aaGNva0lnL1VOdWZWUXZw?=
 =?utf-8?B?T3ltUWcwZUN3Um9QSm9wcS9RSzMxUE5PV3lSRkJsV3MvcTIxa3Y1cXFzcE91?=
 =?utf-8?B?ZnBjejBBNW5tR0oydmFheCtUYm5WWFp5TlQ5b3h0VFJ2QzZBUnNKZjg3U2Nu?=
 =?utf-8?B?K25ZZU51SW1yem8wbmoxRkRFRTM3c2xVMVdiakgrazhERHd5N3lVT1JsZGFI?=
 =?utf-8?B?MzRDV3Z6OE1NcHdjaFZxUDFDNy9JNEtGMDd0U0xRUHZzVnZSVlhnNjUzdDgy?=
 =?utf-8?B?YmFYSk1XMk1VNXcxK0hQMWVWS1Bta2RLdzIzWnY1OWIyWk9mMFZQTVJwSW15?=
 =?utf-8?B?bEVORXZmc1JmRTZaUDI0djNtOWdkeXZzUnZYYWE4VmNDZ0gvV1ROR1BZT2J2?=
 =?utf-8?B?QzNvZUZOSVVUMnFSMnNoenpLK3N4K3Z6TkE2SnN0UzUwaW5EV0JuZW93SmxU?=
 =?utf-8?B?aWROamRqM09JazB2S2QvTWszdGpOVGVDNStWdjYxVWxPZjM3eEVKRUwxdEVv?=
 =?utf-8?B?L1lBMjEvVkFseUNVVmJudFFhNVdUOXI5cXp5cE9xQ0IxZU1YNGdzd0dla0hV?=
 =?utf-8?B?eStWVGZBQy81djk4VDZxcnFIQTFRZVFYa2VEQkxBVHhabmRqd2hJU3hwTCti?=
 =?utf-8?B?UkhiaWtSZEdLZHI2QUo0emNzSUhpVUdMWllKNHpNamFnYWFCbUE0bHhpWlNL?=
 =?utf-8?B?TjBTNGJNdDd2cXB6aFZBaEl3L012MC8xNVlzTGRkQVBMd2lZczVvWXJpMjRS?=
 =?utf-8?B?OGNQU29iVVNzbnJYa09xNkEwTjBaNWFxSjJXZkg0YWFNWW1iZUYzK3AwTkpj?=
 =?utf-8?B?WG9UZWN4b1RvbDVtSUZLZ1RhT1BNTTNsdk5WQUxqN1BPd1QxdjVqSzNCOU14?=
 =?utf-8?B?VHZoTEIwWUsrenhyQUt2RTdUY3VRNDFNd2hLMmVTaDlDUDBCMkdiR2MvSGFh?=
 =?utf-8?B?RVpHeXhtS0F5b0k0Skp3b2JkQUtIVjh5ckI1Smw5eGFrNjJyNFBhTm9UcGdq?=
 =?utf-8?B?QzlreVF2ZmhucW5xTnlxanRITXVheGIzb0NyZDcxVFJEdFM1T1BTKzFDeWFY?=
 =?utf-8?B?QnB4aC9hcGNYYW9uS3Z4WjJRVThoVXRuSEJpbTRFTGV6WnFIa2NSbjhDTGdY?=
 =?utf-8?B?ZWVBZmRPbTNkT0ROYkUxdjJiVVJFY0hhK0ppeDhSUlk1TW5ENWkzYksxanZo?=
 =?utf-8?B?aEFDWUdzaC9zWjN3S04xallWSEcvajRUd0V1ZExoSzY4elZXTzJJbzgrNmdi?=
 =?utf-8?B?SVprQ2JWN1poS2EwS3FrNE5PU3B3MElSZ3I0TUNhdk05SFFIazhEVmpQMmMr?=
 =?utf-8?B?MTZHcWRuc0RsNUpaajd2akpIUUtGMVFXd3Iwc3pkUEpGYnB3Z1oyOHUxRThN?=
 =?utf-8?B?YW9tUS9sbkxHME53M1RVRWp2ak9jYjVXRVhiRkZabTd4VzhybFBvNHFVNEtR?=
 =?utf-8?B?MDVFL1lvcjNrRTRyclV0ak9xUUVwYWl6MnI1Q2dyOWJ3bFNSN2tteXh0WjA4?=
 =?utf-8?B?MCs4azF0U0xzOTdpVHpPYWFmb3NsMER1QmNxRkhqR3l6d0JncjI2bTBvRE5B?=
 =?utf-8?Q?4UA5TDpCn0QgoLFF/3BxPkZmD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee01b2d3-0e9a-4aff-1973-08dcd856f403
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:35.3390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxJZX1QXlTaaaDWVW2p1tNOUZT/4yplCHZZj4l/BRaocDwIv8zGhqZqJaGoDEQ0WyFDZ2EUl3mawGkmYKsMWLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

From: Peng Fan <peng.fan@nxp.com>

i.MX8M use PPI for PMU interrupts, there is no reason to update
interrupt-affinity for PMU even interrupt-affinity was wrongly added
to device tree before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/soc.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 986687e9ce4..3a582cb43b5 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1220,43 +1220,6 @@ static void disable_thermal_cpu_nodes(void *blob, u32 disabled_cores)
 	}
 }
 
-static void disable_pmu_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const pmu_path[] = {
-		"/pmu"
-	};
-
-	int nodeoff, cnt, i, ret, j;
-	u32 irq_affinity[4];
-
-	for (i = 0; i < ARRAY_SIZE(pmu_path); i++) {
-		nodeoff = fdt_path_offset(blob, pmu_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		cnt = fdtdec_get_int_array_count(blob, nodeoff, "interrupt-affinity",
-						 irq_affinity, 4);
-		if (cnt < 0)
-			continue;
-
-		if (cnt != 4)
-			printf("Warning: %s, interrupt-affinity count %d\n", pmu_path[i], cnt);
-
-		for (j = 0; j < cnt; j++)
-			irq_affinity[j] = cpu_to_fdt32(irq_affinity[j]);
-
-		ret = fdt_setprop(blob, nodeoff, "interrupt-affinity", &irq_affinity,
-				 sizeof(u32) * (4 - disabled_cores));
-		if (ret < 0) {
-			printf("Warning: %s, interrupt-affinity setprop failed %d\n",
-			       pmu_path[i], ret);
-			continue;
-		}
-
-		printf("Update node %s, interrupt-affinity prop\n", pmu_path[i]);
-	}
-}
-
 static int disable_cpu_nodes(void *blob, u32 disabled_cores)
 {
 	static const char * const nodes_path[] = {
@@ -1290,7 +1253,6 @@ static int disable_cpu_nodes(void *blob, u32 disabled_cores)
 	}
 
 	disable_thermal_cpu_nodes(blob, disabled_cores);
-	disable_pmu_cpu_nodes(blob, disabled_cores);
 
 	return 0;
 }

-- 
2.35.3

