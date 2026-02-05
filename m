Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D54E91298
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A4D83B8F;
	Thu,  5 Feb 2026 16:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vPV4D4dm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE09983BC4; Thu,  5 Feb 2026 16:15:49 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D890A83AAD
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNpDN4brnbVGhoGF5T3tb7197xFeWL/ZYDY7+XQqvMRITpFOgEdMo+yjBm78jatMQl92CUHZ/6t6nenPJvS0TOCef2QRoj/2t6dQzXptFzOzEpi6hSHXH4jkYKzWErqAdZaJ5q2QqLmazUE5W0kJyXOI2kwj2/9B8HSnZHb6fKmMrNAgGbfa9LBNayuazNl/hLmoKZzWvs4fVRBLMD6FXb7dGLRG5kdJoRgQzij0tJ5EPyW0d1rSR5L4H3FPYAVa9X3JXJ32cbh/IbivdmM5lk41Zvzi3U4KlNI+fb+QfB0c8+AIvHFOfksRrGK5nOP0xS0WQ0Z68XzPXjjBSwVxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICh6CPXocpbDAnRQz/BcpuzkNKTNQOXzm/M1onIQn1I=;
 b=gzyTS0jVQp7J4f4sOIqLX5uupDNayqQAaOJSUVnOfq1FbzvN3nOcvZkgrviXpI7caY+0Cyom+MyPdZh9q4n2iL257KjtxnHnQ9TPtwD4tuRLoBun7rbri3xvKo+Lf7S8dtc6tfS9BEDwtp604CPZFTKt9QaTrkZ3oKjj9U9czrk/YaJrCkUSQEoB1KA9Ev0edie9vPiIorY60zqdqyHAKaHgvDAf28o8P9Stu/n4n+Q/LNJpAUdi2mu79U+13WXejATc9lKMgTXbTBZAr954N6TozvefRetycfiVMOjbOujLGHdvt3bk3fG69fKmHvYgFLBpR9LHvUMVjFHKTcCbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICh6CPXocpbDAnRQz/BcpuzkNKTNQOXzm/M1onIQn1I=;
 b=vPV4D4dmUqCqrmmZzeLAtVIUGy9IFbmNqjiMmva+tMMKK2IY3nyAUEq17+eFAls5buPgh3ADn2p2RkcUh20/l3IgFZiVIvHgYdH44WCKnFZi4eFuV2Dvgnx3f/vK0mdilXqvxNMI1erTN2/doHnBUdxfqz5pIIbYelbKGj3M7xr3ovia8B5wemei7CWimP5W1rk1tkZtBPVQLzcExPa/vpiTs5S+XRMe4MPmbOPx7do9gF3suZvlnIcU8FZc1Zv0YgltdVyJN5HUPCajYKgEmIYVaIw1aMAufnJo980nH5fBYnHZFyWhk43IdPZ48t578eoAZjYh0vel6WVnw4WnXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:15:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:15:43 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:11 +0800
Subject: [PATCH v1 05/12] imx: ele_ahab: Add i.MX952 support to
 display_life_cycle()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-5-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 638269b5-5ea4-490c-4552-08de64c96e06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWtnaTliaStHWE8yZzlIaCszdkE0QXhzNkZ3ZGFjN0VqdGJoZmVwK3ZHTkU0?=
 =?utf-8?B?N1JYdWthNUtSNzBpbHhiVnQweWZudUJyMUdBaHdTZjA5c0ltMEh3UE1KYStV?=
 =?utf-8?B?ck1KS1BJUTZVZmVPRUpNM3RFU0dpMEo0TDVEN2c1TkFUTnVhY1RMU1JVak8y?=
 =?utf-8?B?enNZdkJhYkFuZGlkaTZiMCtBZnlvTEJGaFdkV2FkSWRlWks4eVFuZEwxY1ZZ?=
 =?utf-8?B?Qm44QkdQZzZrWE5CZ3p0aVN5Y2ZBNW5qdFVZRExYdzRpaDRWcE9DakF1dENr?=
 =?utf-8?B?M3kzc2F4ZEg3UythUy85LzNKVEN3bjdlaEZHSmo1OU1iV2JRbTRhblhmOTYr?=
 =?utf-8?B?dHRzQ0JwZWtFR1lCV29mY2E2WUxra2dJSkFBUWUzejQ4REpMQnhrb3NWM3pa?=
 =?utf-8?B?dzJKeXFXUzcvbkxqWlUzSXhsQ0JTNHpIVjhTMjlVb01yc1RqYVpaM3NKZmtw?=
 =?utf-8?B?cTcvZnIvWCtXRlN6SnhubEFLd1ArOUpqWkZCeGZZR2lOREZyMVZlYTA1dDEw?=
 =?utf-8?B?Yk5waDAzUm1OY2k1cURSSThKK3FDSENMcHFQZGFDZlZTSW9NekNnb0tPeGRK?=
 =?utf-8?B?MzRaYjFmbVZDNkJvMEJCelhFemZnVExyeFo3bFlReXI2SlRGdmVKRWhrU3Yv?=
 =?utf-8?B?RUprSW9hNFpBWFlNbEdBSVczcGdyR2hBRUhTanBrNytCVEZ4MklkQVF2ZjF2?=
 =?utf-8?B?VE1Jdm56bU9EendrN004d0JPWVBZSkExeks0WW8rc1dCYURiRDJleDBtdGFU?=
 =?utf-8?B?VDg0dzFyQk9GVWREdjF0THFwVkZkd096L3hHSFJZNHkrR2ZUVUlXSTJneHJ2?=
 =?utf-8?B?QSs3YXB6ZXUrTDA4ZzhFWWxsbXY4cWdwNUlYZ0FNYlN4V0tIVExGbWRyY0ov?=
 =?utf-8?B?T1g2Y2RzZi9sa3VrZEYxZEF6MnU2VlZZZkZQeDV0cWo3alZuc3BsVnZBaWpI?=
 =?utf-8?B?YTNLYk1nYlJlRkFBTDArejJuRVZhUEIzOEdtczg1dVo1OVJXSC9JeWRENzhN?=
 =?utf-8?B?RjNDQTFQdHdjRzczZmlVNmsrOUlocDVFZjg1K0k2UmNmR002SURzR0draUEr?=
 =?utf-8?B?cWNVNkY2RUt5Vm1jMklPOWtUTWk2bWtPZXMybGJvUUlROS9MODdCWmlmTC9N?=
 =?utf-8?B?SWxmSjVVMStxTFh6amRSdzg5eUc2NWVnVzlqUGRZTG5PM0hzeEt5K1R3cUVK?=
 =?utf-8?B?U1VxUkd1T21Temc2TDRKY0tSeEFHamJ2ZmI1SGxITnFxV0x0TjFwbmZXS1Zy?=
 =?utf-8?B?UXB0RmYwdmd5OVdWZmdnekJzMG52d1JqczBSL1N1ZElndm8vVFIwS2ZUTEwz?=
 =?utf-8?B?WFlkektEdm1VUytDSHZLeU5JdmZjWjV5dTNrTkFtcCtRd0VKWG9ySFJuTUJp?=
 =?utf-8?B?bndySUw3NFNzZjhiTGxSTkRtaUw2bFlkcDBXd0c2ZVlrZU5haS9TVUFjb0M5?=
 =?utf-8?B?SEdiVHJZNFk0VS9DL2Rub2l1aDFNV2NTTi9Oa1N4YUhZRlFDQ1ZMRXBVWUtQ?=
 =?utf-8?B?SnhJQ3RvQzN0TWxlNGZwaGhjMzZGdTduZmFGLzVSSktnbm56NFdhLzVycnVa?=
 =?utf-8?B?MlhNUS9ZMEpZenZubFV5REpTWXo3VDRzRmtqZlRuSi9ZNG5KaWI1U3Y0TVc2?=
 =?utf-8?B?VnB2VDArd0NJRjhzK0pZdS8wR0tMNXFhTEQ4SFJVazdtZ1E4SmtoVXEzU2My?=
 =?utf-8?B?ekZGMC9PaGdWaDdGU2cvelg2U2VyU2lJMzVuUzgxTXdheURoNjd1cExETHRS?=
 =?utf-8?B?TTIyT3JGNjMwOWQ5T1lxRFA0NGFqSkVnTnlva1lpMU1WMWt5MjhqdXJtd2U3?=
 =?utf-8?B?WmxRMkRyRVcyQ2JNM09UOHU0MTJZU0RlK0trZUZFOXllankxa0UyaHcwc0Rh?=
 =?utf-8?B?Y2xTdFgxa0dTK3Qwa1pLV1BzUDJTMjhkMHc5c0taVEp2TUdCZkI3L2JDYUgy?=
 =?utf-8?B?ZTRZNTBDa3ptUC9mNkxxVE1LY2ZiWUxrclJHSXFjRVBxcnR2c3ZXaFdEQUV1?=
 =?utf-8?B?Q3RlVlBRTW1XMUdJMlpZMHFMTll0Njh5WWF5NXQxSEpUWTdyOE05cldGdm9s?=
 =?utf-8?B?eFJhT0pOM2VEU3hWV3VSUjVBeWFBcG5TdzY4cFZoL2xZbU4zSGpUWUlIMnVU?=
 =?utf-8?B?RzZOMTM4NFZPK1ZPYWJmMEtqOE9vN2hvRGZMVlEyMkZHSjJxdm50N2hrRGpK?=
 =?utf-8?Q?zvMKGH78p6xsNtxlv1WDlsc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9mekY5c2FubVRqclVIaXZza3ZqeWxGYWRSVG9XZHdUa2N5R0NzemNVa2JY?=
 =?utf-8?B?ejdEWmVKY05QNENqSTlDMW4zcHkxYkI0TytiTHFTcEVyMjMxWjNOTnZHMWE5?=
 =?utf-8?B?NmVDQVFZVDBFRmtKMjY2ckV0K3g5bndwRWZVYlVxZlNyanFyWDNpMWR4ajBI?=
 =?utf-8?B?ZDdLMlQveG5rcXJVWThlb2FmRzcxMFJ5dFJteGRxSUlJaTFEWEp2TFFVREN5?=
 =?utf-8?B?bWdDRVRhYUY5U1o3bXZZOS9FbldYZGp1ZFZBWDltSDgxNjlscmt6K2NKUGVC?=
 =?utf-8?B?WDBzVFIrV2FBb2o2a3ZQOEx6dFBINzFqZUJaVndWSndQZEZaMys5SEJiaDB5?=
 =?utf-8?B?Rzhtb0dud2NsUWJrMXZ3QXJBaE1XdUowdVFiOGRXOHF4MDRLcUs2TDhLcGU4?=
 =?utf-8?B?WEZ6S1k2RlRFb0t3b3o2Rkk3SnlZL2RoQ3JaTkxkeFpaVFg1aDBBWG9WejNt?=
 =?utf-8?B?bnp2R0Zic0N3UEswckcwRk8vVkdCTDRIRTNZOWRhT1J0d0k0QkFsSkZkdU4r?=
 =?utf-8?B?UUN3K3ViRWtBMDJ2TGpjU1dpTW9IOHUvcFpYMmEwUnY3b0ZaSXVsNE9zbUV3?=
 =?utf-8?B?amNrWmJSL1Y2SWhZYnBFaXlZTHJDYWUxMzZ3QVpkUXZGRE5KOEo4UmREZTRW?=
 =?utf-8?B?dTBMS3U2OE5CTlZkaFZzMHoweGxqSVlqRzJNcEhiODdjeHpEaml6OHNiNGM3?=
 =?utf-8?B?SktuM2QrajA5RHBGaTNEUFQ1L0ZnWnlMTW9yZGZsbVlYTkRRWXNqc3hyeHND?=
 =?utf-8?B?Q1FrVy96K3RUWHVQOVNEa2E0K3VCRHJ6VlE3U3pNSmlXN1IvVnNnQlNseDFM?=
 =?utf-8?B?bGNQTkR1NmVkblZqaldNcDRIUExlazdUakNYY3hKWTJRakN6STFPWGVBWThS?=
 =?utf-8?B?TmJKbHQyS2FINkt0Z3cyQVJOL3F2dnZ0Z0RHNy9YM0tqRm51VzJMejA2c0ZH?=
 =?utf-8?B?cnpwN050OTFXbXRsb0pQYmV3dzMzbk5DeFNWblZxcVBPcDNzNFJubUJ2Mmty?=
 =?utf-8?B?QkNJYUpiRlRWbE5MYTlwcWdabVVxNjZ0Wi90T0pObWo4anE4RThSRU1rQXJE?=
 =?utf-8?B?V3hubUN1Tkh6V3pWb0o2cGRIVFJTMGdaWDBxMFg4TktiY2lSR3dMWW1KVFl3?=
 =?utf-8?B?ZTJtT2lHSWVZdE92WHcvSVN6eGI3bENFczM1dlJrejhMdjc3Mlorc2F3L3Ay?=
 =?utf-8?B?MXA5MGdjY2xOaS9kWDFmZE90YmRaQ084RlAvbDMrbzZWdHlsazZsV21ueWx2?=
 =?utf-8?B?MjhaaDBRMWpZSXd6YzY4MUhZSjJuemljdWtDOGorbTlWcDVWQnF1Y1FWbjlh?=
 =?utf-8?B?ak5GV3NVOXVLbUJiUHdXL3N1SkxKUDQrYlJmUFZUeTZNLzZLcnFISytUcDdy?=
 =?utf-8?B?Ukt0YlRVd25KamJ6Q2lMbitjNnZsMERydmtZUTBjRXR4aE53c20zOFgvcko2?=
 =?utf-8?B?MmpYZW85RmZTaGoveTdtR1BIS1pXeG8vTzhRaXYyVTRBenM5TDdheEQxaW0w?=
 =?utf-8?B?TVlxbk9nYkNpbXhpeXZKRHV5bFhZeS9JTVZzN2Erd3Z1TVJhL2hYN2FPSG40?=
 =?utf-8?B?M3l4SW1YR1JwTXFqTlluUlB6SlF3U0FaUWZ5YXFQLzNITzQvU3V4Z0lneS95?=
 =?utf-8?B?VHFEdkNpMTZZOEpsd09vWVk5UzFIR241RUJFNndpK2hGalk2RlVvb2l0TnlT?=
 =?utf-8?B?RUZ5SXkxWG91TzlGMHRzUlhkRWl5c2pwRXdPVjNQa3BTanVoeGNJemYvTU1x?=
 =?utf-8?B?NzJRN3BKTXk3SmY5Uk1xU2JBUnBWc0tqeE5kb2Y0ZkV0dldOTnBjUXFMTStP?=
 =?utf-8?B?eE1JcVNFeW9TVEVuWjYxalFhN1h0QWxtTFdQd0NTaFNhalQ3VGhnbFI3cGhX?=
 =?utf-8?B?MElsU0RDNEtFZE5sK3RaTW5PbWNoaXdOQ1RGSWpkd3dNRjV6cVRkZmNlTmFF?=
 =?utf-8?B?NVZjV0p2OEdLMCt4SHdtMkNTZE1DTzJNOGlGb3FBQXpqdnNCUFFLWUUyOTZK?=
 =?utf-8?B?RDJoQy9FQWlBbGMvRzcrcHVCR3gyZ25PaFNHZGQ0eE9qM2FRM0dtY2hWdmlM?=
 =?utf-8?B?MG9nZnNjc1NYNTRydkxudUwyak44M2dMOWYxMGhhNnEyTFEvRUh6NDkzbnFr?=
 =?utf-8?B?SnV0OWszeEYxcXJZaFdvaVZ6cDkycjhQaDdQN0xwc3l1Z0RuNVJCN3FtSjl3?=
 =?utf-8?B?bEdvc3lsOHJZKy93WGNGTS8waGJOeFMxeHlEMnUrMXV0NWZOSVJNVHp1MTJT?=
 =?utf-8?B?R3lvSm8yQmlhemZTcmFVdWxzMitRUW5jQks1a0QvQU5qQ0R2QUc0ZFdySUFm?=
 =?utf-8?B?L2ZobTdmODZmeE5oSThFYUgxdGxwZ3ZCUEVaWitqR2FpeGpTYXlUdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638269b5-5ea4-490c-4552-08de64c96e06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:15:43.1972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lw4EcmpoZ6msFEay9CBe8jmASHylLu5D/jqCmKdbOL81502CsN/y4nr4cUZH8J+ZBtjIMZ7B9YD4DM4vDWd0LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

From: Alice Guo <alice.guo@nxp.com>

Extend display_life_cycle() to support i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 38e671e3935..73869aa5590 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -411,7 +411,7 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94)
+#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) || IS_ENABLED(CONFIG_IMX952)
 #define FSB_LC_OFFSET 0x414
 #define LC_OEM_OPEN 0x10
 static void display_life_cycle(u32 lc)

-- 
2.43.0

