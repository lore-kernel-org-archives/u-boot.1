Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF71CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0775A83AAD;
	Sat, 11 Oct 2025 20:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ooFx+0KA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F1183E11; Sat, 11 Oct 2025 11:13:36 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A25E83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD1/kizGd11EW8kmtQ0T0+o5HQP9n7aNZx4B9q7ESYaKqQDllRABXDBsW3w3VDY0lc8DlaO+WXraaVWnPgArp19auW2WtXG0PJ95d72X1zdxPv5gfriFIN1wQi8pQgQS8YWwZ7Ng5z9j4GwVuGHDZo24Konash0Z+fdUV3HwiHpZlq3dkLnHVF3HyaUa/jTSbNfAfETg2WB1+pmsJZXZiL/E1qRtwTO8zZ1hptjSx8UGglff9TyVUdCsPEWzsAUMxTK8ZUlAaTEWdL/iOJZ53mNFTBRStnHe6IsnMDeIgm/MWUcmM01aYhzEmVRIpkSQJ8ezRfJIMd30DymRdkJJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDyX/zZCbWg9p2ogqNxi043zT0ItK46TLhSHN5zLhN8=;
 b=Ncjel7gLQHYHF47Mj8Xbtov3WJNyhICpYSW9o1Rqnwx4bqHk/uM/9aZwstVF6Obj5ske/z9xMqBqhAMXR7/gQSgaJyNN4UlWP/hsvFy3s2u2EulvHFHmysRWYVuwSOwnCs7FdzKRLBqeRUImr/O9MYfYv1Xiah6Cz1jlYB6mH0T3ksKB9AmAW/LDBpXMTnjcbXSjWQAh3Cc2fD+OXbgqv4wGOhO+LsuP/5tyRa0wtHPgPPomBjNXG2ZLaHKwPeovTQcpiDNiC6HukQopsCIEeQAkZQatITfsVgqwwRzoL2bi6GSqhTMS1AgA1YPe0rK3yFrYdzY0Mzf4+hEVDbD1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDyX/zZCbWg9p2ogqNxi043zT0ItK46TLhSHN5zLhN8=;
 b=ooFx+0KAgZ4OcktjSXktv2LfYQPX9Xpcg8mGm7Al14lXIgRK25AEn2r0JrTcfDPeJNz/fxBaCXq4cp07XBldm/rymezADlHr+KG8mqcp911WJQTQInHorjWbOTpSb0ZUgYdEEiu82Z27uCPQqgIlMblTactsx92mK/biC/PPKEYUwlQlSQIodhF4GKaKwpljP2t5Mi1ZK9lVvqsUM8AGg5pWtyVISAwANHaeAmcxL6QXt7C7C4Kh4Ibd8uUBxISmPwDlKfLWMvXEBfuo4YG+OwCfaUeBOtmNk9GzWGCJOi1+ebVNiS1p5bb8eiI750QxpO/lAVgy8mMMsgVUg3GPGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:13:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:13:32 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 00/10] Enable USB and ENETC on i.MX943 EVK
Date: Sat, 11 Oct 2025 17:12:48 +0800
Message-Id: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAf6mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3czcCksTY10Dc3NDg9QUs+Q0MwMloOKCotS0zAqwQdFKZUZKsbW
 1ACnVeq1cAAAA
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c3c21e-496d-494a-a3a6-08de08a672db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmQ2aVdMQ2IxanAvVzBHNitBZy96aXgzb2wwN2VqNGM2MGtNUU9XNURGMmVt?=
 =?utf-8?B?OVFiR3hzL0VmdHBxMTBoZFlTM3hrK3h1V2xhQnA5WThtQWUrS1FhRVR4a2Nv?=
 =?utf-8?B?eXgvWXFqcHMxV1BZdDBSZGorZG5IemdTb1JBVHpvbE44UmowQVN1dHpmUk1p?=
 =?utf-8?B?VEdZY1dGTkNuWDBKc0tBc1kzbkFzNmcyaElQc0pFTTNjQ3NUdTBBZS9wTXF0?=
 =?utf-8?B?VjJJOGNMcGZDOStVSlRNRlJDVTM4amsxTld4M0J3Wldvd0dLWGtyem5wd2du?=
 =?utf-8?B?Rm84YlBwTm1xM0cxNmVyMHdVM0JTczVBWll2ZDZ3SE1nbmNFTWJxM0R1U1Qv?=
 =?utf-8?B?RnpiUXRZV1ZCRFhCQXNIblNod0FwYWdINWdWODZ2ZTQ5REltaXNGWks3b0Z5?=
 =?utf-8?B?dU83WlNzSjlqL0RFUE9wRXpwdGRYQk91bVNwaDlmRkxwajNINEp0K3lVVTlr?=
 =?utf-8?B?U3AvVFVxM1UycWRoREExT1RKYkZnSGk5Q2NkU2FjNG9PdWZ5L25HNjZTY05w?=
 =?utf-8?B?Zi9FSzZMbmlHT3BXWFJNZU9kM3cvZmxadUNZajlKZVp1MTYxYmFUYTBRM0My?=
 =?utf-8?B?dzdLMURSbE1tTVNmejZPWmt2SzYrcWxiZUNpVlQxWlZDWGF4RURaNWtnSU02?=
 =?utf-8?B?QUtYd2JDK0VZRkJoZmFaanZVSDB4L3E3QnRxKzQydGZnUFN6VWJ3OE9pcXNS?=
 =?utf-8?B?R1Q5RnRubXRrM2dvWURGQk9IbWhvNnY4REtCOURwZFRrSExaK0hHMW9kcWJo?=
 =?utf-8?B?N1RpSXFHT1lQcDFJKzgwanhPYXdVUnU5VXVLMWhGNDRTcVY3bmYvNjVaUnk2?=
 =?utf-8?B?MEpjMXgrLzhBRWxsZTAxbmxyTHBoNUIvT0QvdGFrWjhSWHVrSVFCM1JxdHFl?=
 =?utf-8?B?N2U3VXZjSFdQTHJGd1NjSDZYRFhDY1ByTnhNMlBxbVErY2JXMWQzMTJvS1hB?=
 =?utf-8?B?UE9RaWM5Unhpd21QR0xneEtPWDRZak8wUGJhdnRNbHRyQlFDMkNuOEQ3UDlE?=
 =?utf-8?B?Mzg3d0dWVHZXdWswZFJkYTBaQmRPRzE5Nnd3Qms0Y3V3WEdoQkVXeTJyK212?=
 =?utf-8?B?SE41aGQydmxCVzg3Q3BPMUZadFVvL0xZMlBMOXRJZjZhdjRMQld3NlpJNmNX?=
 =?utf-8?B?RnV1SHhzbG1UeXhaWGVWZTdPVGJRam5wVllzWGNUdTBCSHh1eTdIT3JlQndm?=
 =?utf-8?B?c2hpZ1dvdER1UUR3SVN1L3llLzRVL0thVkdXKzJteFAxTk1zODBVN0FKT0E1?=
 =?utf-8?B?S3FmZ0kzY0JwdHVVTStTWkx0Z082RmN1bW9naUFVY2lsV0hzN2NkV3dKR1lm?=
 =?utf-8?B?VS9PWnFNYUxZY3kza2t3d1JiOUQ5czJ0bTRmT3l6ZkM5cGFuZ01McW5XTjlo?=
 =?utf-8?B?clMyUXB1dEpwQTVLbC9jekhEY1lObDhkUG1Ed3BVSE5PT1RLSWlyTlA5eXVr?=
 =?utf-8?B?a3J1RjlJZHJJeXJBZUp6TkRJd1JzVVpCa2RmUEVucDk1ODVmT3NRYlV6MGNM?=
 =?utf-8?B?YWJGdVMzbmZJWVRyYmJQcjZsUVNqNnFyVHl4bkNOV0R2VVJkTTZ3eXU2K0Qr?=
 =?utf-8?B?c2RoUmEzaDlwUFFoYThLcnpPRERMY0VNWkRVak9nckNlM1NwT0x4bW1UVkJ4?=
 =?utf-8?B?YXVOYmZITXFKZTRxSUx6TEozZ2ZFbllBWU1MTmVPKzRtTWF0ck5SSHErSXhK?=
 =?utf-8?B?V3QyeE03N3QvQmpScVVySDRtT3ZocXQrMmVUUUtsTGllNjlPNGF3T0kxV0cz?=
 =?utf-8?B?Qy9TblhMT2F2VENINFVjSjZVZlZWdzByNWwvZUpmUTVwNzZKclh4clBCa1Vr?=
 =?utf-8?B?RkdpQkw1RXJZbkRwZjVCRFJKb0pBd05iUGlRNzNDMENwMUhwWlFaZTJCUEVq?=
 =?utf-8?B?R0ZqOWxzdjhWa2NrY1VOQ1BkWThQY2lBMFA1Q08zSUVoUnA4ak93c2wrdExM?=
 =?utf-8?B?NmMzUVJxWGtPOGxmQ1BwNFZtdUIxN1Nwejl3WDFrdEFRb09Ddk1pNTJ2UUZt?=
 =?utf-8?B?bGhwRHVSVjRmemlKY3lHZlltbldWbWY0ZEpJVllWOHVLd3Y2Q0tFdU84VUlj?=
 =?utf-8?Q?ek180L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJBOXlwT2N3VGhkQXdtYm9jQnFZaklNNVpTVmNSdVpkdlBUa0QrejNaL0hq?=
 =?utf-8?B?U0pwdVFURVNzUVBiV1E4dVZic0JVS1RCMFRYMit4MjNMbEtIVE9zVithaVZF?=
 =?utf-8?B?N3NPdU5rNWQvTzAveUJVbjArb2QvS3RCeHJidGJMY1VyRXY4OTFBWCtYdzVQ?=
 =?utf-8?B?SU9iNHpOa1Z6c29OVkJYOE9hb2prOFFLSTlZUi9GcnhKdDNmaVQ1anV5b1J3?=
 =?utf-8?B?WmtpUTFxdTZ4eWFPWVhjZ3FhdjhwYmRpbzUyRzR5WFNZTjRIWDlEajhQL3M4?=
 =?utf-8?B?MUdJbFFWNCtjeVliN3lKWCsrUXhaQ0JQTjZ2bW1IZFNiL2VHMDFkR0dqRmR6?=
 =?utf-8?B?RGlyYUhZU1RoSFNXMkVZWXBCdGw1UkR6ZWhsS0prSi9XaVQvUUhOTEpYTkto?=
 =?utf-8?B?NUFET2FncXppVkhmazV6TUYvaHlKWkRWRXVMY2NkejVJRWo4MTc1bHBESkxP?=
 =?utf-8?B?R2w0LzRWUUlQSWg5TDJpMEk5R0JKT3BkZUtGMHVGaUtyN2VmV2VVWStYTldX?=
 =?utf-8?B?RnY3Q0VYQ1lDYmNnd0s0N2ovT0sxdXlxTkhDRkM4dVg3SHlLK3ZCd2tTajZm?=
 =?utf-8?B?bkhIdmlaS2E4Uzl4K1FIc0RWcEpWSG9XNTRnanJtZ3hYNDh3aWcrT3RWNkRx?=
 =?utf-8?B?ci94S1paRDA1ek8wbzloNUVGQ0IxUk95VWZESDZEWDIraEFEY1EyTHlMYndn?=
 =?utf-8?B?M2EvWmxqZnV3Sm9pR3BaRGNFWTIzMk0wazcwbFJWbzliSzJvbU5DZjVvQy93?=
 =?utf-8?B?WVUxekpnQ0U2R1BsS25MQkJIV3pUTUcwVUZnOGpZaEczVGs5dlFFVk9oM3VK?=
 =?utf-8?B?Kzk3UGlUaVovbGY2UGY0SFJpT2RhVUJWdnZ0dkZBWitFdFVPZ0xMWTYrWk5F?=
 =?utf-8?B?UFhlRXZYYmtOWkRTd3Q2VUlJOUNndml0UldRSkJWZ3YvN2xXTjFNWVZCcE0x?=
 =?utf-8?B?ZStlMURYM01GeDlUSWdSeCsrUTI4T3FYNVN2eU96S1lhanRmMVZHeHhTbFZa?=
 =?utf-8?B?YyttVlNsUmVpVEdudjAwenJaY0NMeGJueW5BZUV0VVF5SnZLRzFvRjdKOGZl?=
 =?utf-8?B?QUhCK1lIL0hDOWRCSGF6UXdDL0Zac3VGYkgrUU1vM3AzR08wUEpKeDRCS1VZ?=
 =?utf-8?B?Z3EwLy9vR1dHWGRTbmpPLytRUWdrUi9aalYrZXk5ekd4U3VwRy8vcHFtenFH?=
 =?utf-8?B?eUZYY2RETXM2THVJYUxBSGFKKytWbFFmbDlSemswWGFMUEU3R3lhVnZoa1p5?=
 =?utf-8?B?eFFoaHVWMGpVb29xUEJvSlM2SmpaYXEwanFSRmxhaFMwUURRVGJteDlMeUVB?=
 =?utf-8?B?QXpualZWNUxDR0t1eWk5bmdYelpKK1lvWVk2cWNlcGhFaEQ4SEtjZkNZcG56?=
 =?utf-8?B?bmUzbTRGYnROd1lFOTZBYmo3T0plVm4rM0NtZW1ZT2tEWXp5RThLWWV6emhy?=
 =?utf-8?B?SlRxNmFvYklvc3JrWHdQMEg5UHBQRm9wNXc2RlBKRzN5Z1BhNzBFZ2syRC84?=
 =?utf-8?B?SENpaDROdXgyZUJ2UWVUVjF3b3NQQVNBUzB0bWRKTlBVcVVIR1dlZFhWMEhJ?=
 =?utf-8?B?Zlh4K1VLYkw5blVFQlFIZGNmR2FXaGlpQUlLZnJvMzBxa29lR2FGdVdsbFY0?=
 =?utf-8?B?UkNoeDFra3h4Sy9zS2NzSDE4VWxyRW5tTitvWnY1WVBnWUY2VlRTUld0blJB?=
 =?utf-8?B?MjRwakJYWi84YVMyQWtKTGFHQWd1OHRPWWMyaWZhRlFiZGRSNEUwOXM3eTR2?=
 =?utf-8?B?RTNSZnAwRmwwY3JvQlNWa25yRXJiOXdLcDBzWkhGc3huamhScVRlWDRzVEJs?=
 =?utf-8?B?Vmlkbnl0MWoyVUVVRWpjOE02ZFNNYkQrUzJwazE5TTNRb0h0djB2M1hzZm5K?=
 =?utf-8?B?WW14TWhvZVkwV1dpR3ZWL20yTThFVjRXcGs2c1E3YVNNNGxmUkg3RXFUUnlG?=
 =?utf-8?B?amZMTTFTT1lwcVdueksvVjdNaEZPc0VxZWFQNzhXdDloWW1CVzFRNjdZVmZp?=
 =?utf-8?B?djkyNkFVT2tQRTlVZ1V5SGYvWmxsczIwVDd3U1EvYkgxV25ITFovd09FY21T?=
 =?utf-8?B?R1VWYUlOcldESitDUjR5RlU1NmRWVksrMEU2Q21TcU1mYVV2OEFDUW4vLytk?=
 =?utf-8?Q?LPBoW9NT1dD+tXQtXAKLYgLyW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c3c21e-496d-494a-a3a6-08de08a672db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:13:31.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFB7vz/uB5wdcUuw3xT+N3mQES2kpLYkO6PmqTRTdL7GTAbqdNcN8NGMWTPEmP/POlBKQkv8UHAOQa0DfW3Ykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

Changes for v1:
 - Adding USB2 and USB3 device tree nodes with required PHY and
   regulator support.
 - Enabling ENETC1 and ENETC2.
 - Updating Kconfig and DTSI files to support these interfaces.

Changes for v2:
 - Resend patch series with updated To list.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (6):
      usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94, and i.MX95
      arm: arch-imx9: Add USB2.0 and USB3.0 base address definitions
      imx943_evk: Enable USB 2.0 controller host mode
      phy: imx8mq-usb: Add SPL support for i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
      imx943_evk: Add support for booting from USB SDP on USB3.0
      imx943_evk: Enable ENETC1 and ENETC2

Frank Li (1):
      Add serial# for SPL SDP download

Ye Li (3):
      usb: f_sdp: Update SDP driver to support PQC container
      net: fsl_enetc: Add i.MX94 support to NETC block control driver
      net: fsl_enetc_mdio: Add support for phy-supply property

 arch/arm/dts/imx943-evk-u-boot.dtsi       | 182 ++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi           | 234 +++++++++++++++++++++
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/spl.c                   |  10 +
 configs/imx943_evk_defconfig              |  30 +++
 drivers/net/Kconfig                       |   5 +-
 drivers/net/fsl_enetc_mdio.c              |  25 +++
 drivers/net/fsl_enetc_netc_blk_ctrl.c     | 338 +++++++++++++++++++++++++++++-
 drivers/phy/Kconfig                       |  14 +-
 drivers/phy/Makefile                      |   2 +-
 drivers/usb/gadget/f_sdp.c                |   2 +-
 drivers/usb/host/Kconfig                  |   6 +-
 12 files changed, 835 insertions(+), 18 deletions(-)
---
base-commit: 8c42f534d7e1956192ef8457fae884469f60ff13
change-id: 20251011-imx943-07710ed6cf60

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

