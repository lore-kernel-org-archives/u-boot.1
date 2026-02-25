Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A16F55434
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA1783E96;
	Wed, 25 Feb 2026 01:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R6xXhGyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E44883E88; Wed, 25 Feb 2026 01:14:31 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11FE383E76
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3rxeyxZqIabV7BxpPOk9c6h4flhC0BGry2VH8zpsul7fqr7knVFtTIs6LlX7HxSBRR/rsF4UjMRJMcjd4vuLWO2T0XOtGryU8D9egDRVuuL1OgRCIdhXmKARJKoPC8XSpxfusFigVPbh2jfsXcM7n5Egg4nWsdGgeZueRWS6lifcVCf1Cdavi6K2bFLGV6Hfj+i3IBD5RkJf6Ab+ugVXtbdZ0Jp3pFD82hYYJnA1tf7GGZDnP6LprKpRIMP4FvCJwfHRf5lv0ZefluH/LsjTWclrkU/VB3WeewEHgyX0l56qTdH37JjoQPRwtE5Rzi9tq+TBFslsFuA2pGnUKWK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REuzbm9LA7Sw6tv8kCD0bb/zklgzqmbwsd1Ge6TVgd0=;
 b=xn8K650ZqjSc7v1z4ujlRaq3wVXfEE2idUfwglx1SJ+JeMLtJpRC46BCuJFVTMXbV5rVVPjNwImeBZWjxyxTBjuTII6CverJWHtCyhkbtnLSI5kd4u1zz7bo/b6eBHU39tKKC1NE+Lr7v0eewSRvG3OGiF50fkWw8Uclh+YQraRs0QXds1VH8sZxTbSHOt44AIEtvVm3QfGeesr1ZYnafiv4Bpl07/Le6YzgeE13o5NyUVTXrIt/TXX/jZYBXDUm4Nnf06+tHHoNoZ/j7csR5Act6fUA9j/juL6gPRHVh4rRXyA/V93Cm3lYCD3YKsWNWDOEGLhJe9+cH7FgEC3EXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REuzbm9LA7Sw6tv8kCD0bb/zklgzqmbwsd1Ge6TVgd0=;
 b=R6xXhGynB76EufxMlOsyQUwlylNscU4gs7JotkzyhEMKHZoWprPAvY8EEJDz0bL8B5QHlJZGg7xidVFZpwhyC7GG1rds8AS/+ahDUsae42KGq4BlJU12SMbVa8wxKin/kwVzBUb6S4NnD7C9zDcysUeXg+dG/nqhwT8ndZ4Act9yVyWu+mnvJtYoZyb+eb0ZmQMPhogwF8+ZFbei0tnIfzo8PqqsYLCyCF7Jh14nO86VAsr4ZlRUam9ZiZguwRjNGo4qqMncjzXvDpmqCyxT46PTkVqCcULmQ58p2OJZhnsSqQLoHQunJfArSlBxALGuBAPFdOZYdGL8XjQ/jnxQSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:30 +0800
Subject: [PATCH 04/10] pinctrl: nxp: imx8mm: Support print pin muxing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-4-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c53a85-2a78-448e-3205-08de7402d695
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzM2RVhUR0hmWFk1MW8wY0FncUpyb2sxL0pnYWdUdjk5TW41cXZ6Z084NElZ?=
 =?utf-8?B?cUNlaWVVRFpCM3hNd045NG9jMVdydU9yV2lBNStra2hGOHFlNlpQbzRSYnVN?=
 =?utf-8?B?Ymo4NU5RZVJUZ09SY3dQUkZwakxWR0NPYTJBS25LTXRBZEZxdmFpZEtLZlZV?=
 =?utf-8?B?enlOck5xMWRvYndJMlpvbkd6K0xWSHVoYWpGc093UCt5RjdjVENwSXgwTTVT?=
 =?utf-8?B?cU0xb2ZoMUJ5MlVIUS9QYWRPaTk3cDFHWFowSzlSeFJEMkZqS1lDT3NUU1J0?=
 =?utf-8?B?NEt1cDBnaHNzL0NodmVzL1IxZ1ZML2JxYzhLckM2ZXcxZXloVmZVRy84S1VG?=
 =?utf-8?B?S1AycnNXS2FqeEh2TVNWTTgxV0trNGpYRlE3VEhEMG5DWW5abWhtSjJYcEdx?=
 =?utf-8?B?OGhLRHZ1NmdkWlQ2ekZFREZQTlFvNmJDS0d3eUhNK1dWS0k2R0xIWXptN3lX?=
 =?utf-8?B?RUJTNW53RWpxY2Q0Q3FZbk50N1R4QjlZc21GbWhSMFJMSDI1Szh4RFhvMFJG?=
 =?utf-8?B?VWw0U3g3ekFrN2ZGTnZ1OGdYUHQvUkNLVHA2anNRSExRYWxYNTk3dm40azYx?=
 =?utf-8?B?Rjl4SlFvcW1zQXJCd1piRXRIMGgxR09FMFNDYVpDMzZ0SHBMU3pmT3JJZWZt?=
 =?utf-8?B?bTdEZUlXUFo1ejZ3eGJqTlhmMnRBWTdmS0RaT0RYQUM0Ykhpclh2WTlZQmVx?=
 =?utf-8?B?SGl1T0crY0YySHlpMzFXcWRmbGlLa3NkQ0d6dXJHR0UyLzQ4ZE8yUUNuRG4y?=
 =?utf-8?B?aEZZRFRXcG1lU1liNW9jNHBldXdFSlhvOERQZmI1akVOV1dSYzlrU0xJM0Vw?=
 =?utf-8?B?by9jT2dlWUhSMWZSaENPYlpid2V0MHoycFVjQjhCUVFzSzhZenBtTVlIZ3Ex?=
 =?utf-8?B?ekRWYTJFby9pbzZmNElUNUhObHFRMFFESFBiOUdtOWI5M1FEK1pWelg4MFVs?=
 =?utf-8?B?T2JMVVp2UDMzd0pqM0R0VnQ1d0ZwVEJhVnFDUVp1OUUxeHQ5TDlYYnVGRHZr?=
 =?utf-8?B?S2FFbnB1eE9FR2FlajFnVXVBVmhDT0pDNXpLdzRZUE9sS0NDeHFrSnlXQU9w?=
 =?utf-8?B?SHZabTJ1dTBBUDl0RExNaEJySjdVclg0TGUwckxWSDR0VDk3K1lLampUcXpE?=
 =?utf-8?B?MFAwV0oyLy9LWkpmTnZXZE02N0gydEw3ME5YNjVXc1AvUjZNTDM4Tm5uRDM5?=
 =?utf-8?B?SkhKcmFqT3JjTVAwemJ4dTJBdWdib0FHTU5tR3M4NytTb1hYK0xXZHI1V2pr?=
 =?utf-8?B?bkVvODdjTnlLNTcrTGJzMG5hQVloNUVWZ1NRcDdRM1p2cmdMb1lKU1VkZ1d5?=
 =?utf-8?B?V0UzV0FtemVhSUx0RUhlRk1UOGJ6d1dIZURyaXFKR1p5YWw3U3NoLzBXR2Vj?=
 =?utf-8?B?WG02MlU5c0pxQWdqL3hMSTlwM1JtVFlUM0ZaaFhEdUVMMVArOHBBK0RTRXJn?=
 =?utf-8?B?Q05rN0RDbmNEc3pKdXliSmhrSFZEazNZWndHUGVsL0d3dnhVQXQ2ajNqT0lW?=
 =?utf-8?B?ZGxzV2pJK2hYSkpvUkpCZHBMTlBzQkR0WEJoQTlYOXNoQXhKdWxpeFBZZHIz?=
 =?utf-8?B?QXFzUTkzSkRsM1NMbVR2WVljOXJuRDlTeFRTV2orZTlwNzJ0aTJZYlNadTRS?=
 =?utf-8?B?TW1qTXdTVi9vZUU3bmxJdjl4aFpRaG9MbmhscEpCN1JtWXJ0MkJOZmFxZ3d1?=
 =?utf-8?B?ZXFPOHU3SWkzSDhMU3Y4MmFKbTYxQkJybjFwWnBSaDZwZUJjTEdrVFNQdkFq?=
 =?utf-8?B?UDBIczZ3OUJuS24rMGp4T2hheEo3TThNT1BycmkrQ0ZteXI5NUZmaEY2Rzlt?=
 =?utf-8?B?cGpMUXlyN3hjSWR0cVlXUlpJQjh5cnRYYkJwYkp4SjZXZllyZk1pK09sK1Vw?=
 =?utf-8?B?a3RDUUtyb2FhRUQrYi80dkhtZGRiVVdza0x5blhTTVVGZkNERndKd3pyUWRO?=
 =?utf-8?B?SVJDU3BYdGFJUE9ZZHpkOVBZZC9POVE0WnVFUy9HaUcreFo3ZnVaenk1a3dv?=
 =?utf-8?B?WjM2a2FFNE1ramkwbm52STBmOGRyOTVoQ3dyd3k3RTNJVkZVOVBaNXM4Z2RX?=
 =?utf-8?B?TEpLbEo3eXF2ZEVJRW1ZbHpDWjVqeTFzdWcwU1M2UFBKOUVPZHA2ZDJhSEd6?=
 =?utf-8?B?NkNvNjdrSmtFZy8rUkVxN0trZytaR3M2bEQ1OFRIakxzb1FUbVc2eU1nUFVi?=
 =?utf-8?Q?3Wv4Xa+BK8x+qyetv/ouaVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alN0T3FzdEpSMDRuU00xb3VmVUppR3gyWnZudEFaMVNDOGlETG42dG5qdmMw?=
 =?utf-8?B?RGhFRVB3QzJrcXZ2OEJXWFB2YnpoaDBIQ1FzUjRrSEZsYlBFM01nOVVyeFRG?=
 =?utf-8?B?dGd0aytXWGV3L1E0dTVabWlndmtnOWRpRGNFanJwWWQvbzJhbGxzRlc1czJC?=
 =?utf-8?B?L3pWSlEyTkFnZmI3eVVCc2FGZnUxby9NL1U2eUhwUXltSTkveHlOUlNLQjA0?=
 =?utf-8?B?eVVFeDZ3MHYzclZXd3lDRE5tckJUbllYaG56VzNlY0VJSTY1NzFkeXNiYmpv?=
 =?utf-8?B?VlhnQ1pFcDhyeEQzZGs2N1dXSlFmRTA0ZjJyNHd2ZDdCNlYzSnhjSnVjcjc5?=
 =?utf-8?B?OGhSd2JHZEl5QSsrS0hvWmhXT3hMRGszSDRQWWdjRWdFWnR3eEY2TDNmY0pL?=
 =?utf-8?B?amoweCt3MWkzWURlcTVyVGxqUjQ3M2IvaVNBZkxoTlJKdWoyaW0zbmc0dlBR?=
 =?utf-8?B?dktBWDRQaXVZQjFKWDJWYW9Vc28zamVXbkRMNGhhYVBwNlN5SEpCOFFrS003?=
 =?utf-8?B?eTkwelNnQ0tGcWU2WWhUdHR6OTh1akZwN2U4OHRTazhqaGh1RVR3ZFhLcXdW?=
 =?utf-8?B?LzlNdDZhV2xGaWE5ZDZFTVpyQldWdmRSTzY3R1d6bzhMb1hCemx3OGN5Q1pR?=
 =?utf-8?B?R0FvWTlQUHpiaFlVNlZxL3BlUWFxS3ZUWVZ2eXdubE1wREovWmRpSXNheDdW?=
 =?utf-8?B?SHZsRzBBQmNjZnBTbTJhR2tDbjZhNmdsMGN5YmF1SWoxQUN4Z1dvQytrTER0?=
 =?utf-8?B?dnZnSFpBNURJcnBGVzB5TUY3UzF3dUdFTk1PYjFYMmZVZCs4U2V2QzMzRElv?=
 =?utf-8?B?SENvYyswbTdIT3ZGN2ZGOWpBckRKNjlDNTlCVzlIcExSWDBPRVh5VCt4bVNI?=
 =?utf-8?B?RTRSZWkybGVTT2d5bGJFL2JNMlB0Y0pMNlJKSXIzaXBJRDJ1RFVIL0hwa2k5?=
 =?utf-8?B?QndkYmh0QVFlQzk0Si9ka09BK3pVOUhJNFhZZzNnVklKekQyYzFkVi9LNStp?=
 =?utf-8?B?MHF2OXZDVTJVckVHMGNiTFpzeHh6TjhseW94Qng0Y0hZU3ZrSVEzWFliUHlD?=
 =?utf-8?B?b1paYjNyTncrcFNRRnFnemMrSWgxQUVwRFVmdXZDU2tVb0RMVWRaM1grY09M?=
 =?utf-8?B?SFZaRGZ1VGFhTU5FbXhIcXhFajVDRWZONC8vaTdJZ1dseEZHbkpzZFo2SkZI?=
 =?utf-8?B?THdEVS9NQjUwQXVSMVl5bUtmaU41d3dwQW9TdXRmODRsNnlTNkpJMFp1Q3dT?=
 =?utf-8?B?TnFEV1dLSmczUEVHTGhUL3hycksxdWJLWUFUeE5jejYvRTVkbzV3Uk4yU3M0?=
 =?utf-8?B?eFRzQVZEZ2o4a055dFZJTXRrVlFkS0IzMXhkenNoMWhlZS9STDNpUHZFR0I4?=
 =?utf-8?B?Q2xmVFZyeVVZNTFIa0JTcEJYYUw2clIrVlRMNUlMS0RFQXhzQzFHRWVqMFd4?=
 =?utf-8?B?R0xZVk9keFV4NlFNckFqbjBRM3o0M1JsQWVqZ2VxKzFwSTF3TDBHcWpmVlg0?=
 =?utf-8?B?ZnVxZjNMS28wZ3ZYTk9hTnk5U3I3MGl0dURWK3ZSSlpwUUo2dndxQmNXTWYx?=
 =?utf-8?B?OXFhSkdkUkw5ZXo1d1JOMkVvdEUxRkl4ZVMxNk1jTmRNZ1dBVVhZWUwvSm5F?=
 =?utf-8?B?eHIwRUdiazdabTlCTEprQk4xS205aXpPV1c1Vk52T0JaVXYwWGdsaEVoajk0?=
 =?utf-8?B?R3ZzVnhWenQzcy96SjhoYnN6aFNMTjVHSmNtQ1ZkYjMvSFVnMG52dktCcTg4?=
 =?utf-8?B?MVlISUNVa0hsVDllaERoNTV0b3hhZmdoRWQ5TVFYWE1EZlVna0tFNnNkVmFm?=
 =?utf-8?B?YThhTDZaSmFEbC9CVUx2U3llMmtmdUsrdDM3TE5BcTFybzZ4d3MxaG5RZ25I?=
 =?utf-8?B?V1Z6emxINTgyWWxkd0NZQnZmdkxlODAwMWhEKytldStwbnVjQ2JxRVQ2MGVU?=
 =?utf-8?B?bVlYZ3hDUkN6cEpCZmdRZU0raVBKbDZweE92eGdTZG1RY3pHK2ZlMVRxdnJY?=
 =?utf-8?B?a3NVcDJLVUczZmR4cDBOQ3c0aThXK0I2cnVzbngydURpR2N0ZXY2cWtsRmVN?=
 =?utf-8?B?cUdWQytFajVhejJESkJDRDdpSWdMRTFlU2NERVRpU21jdS9PZG1yL0ExVEN4?=
 =?utf-8?B?eDBmU2EzRUxIMnRCUWxNLzQrM0ZjcFFwbGhSMjgwbHZJa0dpSDBNb3ZsWTl1?=
 =?utf-8?B?NFlQQkJvUmR4VDBWMUNXU3VyWUJiRUE5aGtNOEpockRFOElOalBocXVZQytz?=
 =?utf-8?B?c1Z5cThHbUpuZXhvZTlXbkUzSVFxbjIvVHhqWFhNcCtnNUVpMjFwZlNRZDNz?=
 =?utf-8?B?VXpNdTZsU2xmU3ZuVE43OW9rOHBPVTR5Ymd5dXZBUUZlaDduTWg3Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c53a85-2a78-448e-3205-08de7402d695
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:27.3263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgrR34lkHUX1ZHbUXffmVAiASqD3rXLoHF0ZqjRVrVRSb2Zord2EcOfi5TJ021B8WuMEgPkpDTCkDnfpA/yehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

Add support for printing pin names and current mux configuration on i.MX8MM
when CMD_PINMUX is enabled by adding full pin descriptor table for i.MX8MM
pads.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx8m.c  |   2 +
 drivers/pinctrl/nxp/pinctrl-imx8mm.c | 310 +++++++++++++++++++++++++++++++++++
 2 files changed, 312 insertions(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index eb11edf3948..1ae2656b8c6 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -28,6 +28,8 @@ static const struct udevice_id imx8m_pinctrl_match[] = {
 #include "pinctrl-imx8mp.c"
 #elif IS_ENABLED(CONFIG_IMX8MN)
 #include "pinctrl-imx8mn.c"
+#elif IS_ENABLED(CONFIG_IMX8MM)
+#include "pinctrl-imx8mm.c"
 #endif
 
 static int imx8m_get_pins_count(struct udevice *dev)
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8mm.c b/drivers/pinctrl/nxp/pinctrl-imx8mm.c
new file mode 100644
index 00000000000..9aa2303b618
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx8mm.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "pinctrl-imx.h"
+
+enum imx8mm_pads {
+	RESERVE0 = 0,
+	RESERVE1 = 1,
+	RESERVE2 = 2,
+	RESERVE3 = 3,
+	RESERVE4 = 4,
+	RESERVE5 = 5,
+	RESERVE6 = 6,
+	RESERVE7 = 7,
+	RESERVE8 = 8,
+	RESERVE9 = 9,
+	GPIO1_IO00 = 10,
+	GPIO1_IO01 = 11,
+	GPIO1_IO02 = 12,
+	GPIO1_IO03 = 13,
+	GPIO1_IO04 = 14,
+	GPIO1_IO05 = 15,
+	GPIO1_IO06 = 16,
+	GPIO1_IO07 = 17,
+	GPIO1_IO08 = 18,
+	GPIO1_IO09 = 19,
+	GPIO1_IO10 = 20,
+	GPIO1_IO11 = 21,
+	GPIO1_IO12 = 22,
+	GPIO1_IO13 = 23,
+	GPIO1_IO14 = 24,
+	GPIO1_IO15 = 25,
+	ENET_MDC = 26,
+	ENET_MDIO = 27,
+	ENET_TD3 = 28,
+	ENET_TD2 = 29,
+	ENET_TD1 = 30,
+	ENET_TD0 = 31,
+	ENET_TX_CTL = 32,
+	ENET_TXC = 33,
+	ENET_RX_CTL = 34,
+	ENET_RXC = 35,
+	ENET_RD0 = 36,
+	ENET_RD1 = 37,
+	ENET_RD2 = 38,
+	ENET_RD3 = 39,
+	SD1_CLK = 40,
+	SD1_CMD = 41,
+	SD1_DATA0 = 42,
+	SD1_DATA1 = 43,
+	SD1_DATA2 = 44,
+	SD1_DATA3 = 45,
+	SD1_DATA4 = 46,
+	SD1_DATA5 = 47,
+	SD1_DATA6 = 48,
+	SD1_DATA7 = 49,
+	SD1_RESET_B = 50,
+	SD1_STROBE = 51,
+	SD2_CD_B = 52,
+	SD2_CLK = 53,
+	SD2_CMD = 54,
+	SD2_DATA0 = 55,
+	SD2_DATA1 = 56,
+	SD2_DATA2 = 57,
+	SD2_DATA3 = 58,
+	SD2_RESET_B = 59,
+	SD2_WP = 60,
+	NAND_ALE = 61,
+	NAND_CE0 = 62,
+	NAND_CE1 = 63,
+	NAND_CE2 = 64,
+	NAND_CE3 = 65,
+	NAND_CLE = 66,
+	NAND_DATA00 = 67,
+	NAND_DATA01 = 68,
+	NAND_DATA02 = 69,
+	NAND_DATA03 = 70,
+	NAND_DATA04 = 71,
+	NAND_DATA05 = 72,
+	NAND_DATA06 = 73,
+	NAND_DATA07 = 74,
+	NAND_DQS = 75,
+	NAND_RE_B = 76,
+	NAND_READY_B = 77,
+	NAND_WE_B = 78,
+	NAND_WP_B = 79,
+	SAI5_RXFS = 80,
+	SAI5_RXC = 81,
+	SAI5_RXD0 = 82,
+	SAI5_RXD1 = 83,
+	SAI5_RXD2 = 84,
+	SAI5_RXD3 = 85,
+	SAI5_MCLK = 86,
+	SAI1_RXFS = 87,
+	SAI1_RXC = 88,
+	SAI1_RXD0 = 89,
+	SAI1_RXD1 = 90,
+	SAI1_RXD2 = 91,
+	SAI1_RXD3 = 92,
+	SAI1_RXD4 = 93,
+	SAI1_RXD5 = 94,
+	SAI1_RXD6 = 95,
+	SAI1_RXD7 = 96,
+	SAI1_TXFS = 97,
+	SAI1_TXC = 98,
+	SAI1_TXD0 = 99,
+	SAI1_TXD1 = 100,
+	SAI1_TXD2 = 101,
+	SAI1_TXD3 = 102,
+	SAI1_TXD4 = 103,
+	SAI1_TXD5 = 104,
+	SAI1_TXD6 = 105,
+	SAI1_TXD7 = 106,
+	SAI1_MCLK = 107,
+	SAI2_RXFS = 108,
+	SAI2_RXC = 109,
+	SAI2_RXD0 = 110,
+	SAI2_TXFS = 111,
+	SAI2_TXC = 112,
+	SAI2_TXD0 = 113,
+	SAI2_MCLK = 114,
+	SAI3_RXFS = 115,
+	SAI3_RXC = 116,
+	SAI3_RXD = 117,
+	SAI3_TXFS = 118,
+	SAI3_TXC = 119,
+	SAI3_TXD = 120,
+	SAI3_MCLK = 121,
+	SPDIF_TX = 122,
+	SPDIF_RX = 123,
+	SPDIF_EXT_CLK = 124,
+	ECSPI1_SCLK = 125,
+	ECSPI1_MOSI = 126,
+	ECSPI1_MISO = 127,
+	ECSPI1_SS0 = 128,
+	ECSPI2_SCLK = 129,
+	ECSPI2_MOSI = 130,
+	ECSPI2_MISO = 131,
+	ECSPI2_SS0 = 132,
+	I2C1_SCL = 133,
+	I2C1_SDA = 134,
+	I2C2_SCL = 135,
+	I2C2_SDA = 136,
+	I2C3_SCL = 137,
+	I2C3_SDA = 138,
+	I2C4_SCL = 139,
+	I2C4_SDA = 140,
+	UART1_RXD = 141,
+	UART1_TXD = 142,
+	UART2_RXD = 143,
+	UART2_TXD = 144,
+	UART3_RXD = 145,
+	UART3_TXD = 146,
+	UART4_RXD = 147,
+	UART4_TXD = 148,
+};
+
+static const struct imx_pinctrl_pin_desc imx8m_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(RESERVE0),
+	IMX_PINCTRL_PIN(RESERVE1),
+	IMX_PINCTRL_PIN(RESERVE2),
+	IMX_PINCTRL_PIN(RESERVE3),
+	IMX_PINCTRL_PIN(RESERVE4),
+	IMX_PINCTRL_PIN(RESERVE5),
+	IMX_PINCTRL_PIN(RESERVE6),
+	IMX_PINCTRL_PIN(RESERVE7),
+	IMX_PINCTRL_PIN(RESERVE8),
+	IMX_PINCTRL_PIN(RESERVE9),
+	IMX_PINCTRL_PIN(GPIO1_IO00),
+	IMX_PINCTRL_PIN(GPIO1_IO01),
+	IMX_PINCTRL_PIN(GPIO1_IO02),
+	IMX_PINCTRL_PIN(GPIO1_IO03),
+	IMX_PINCTRL_PIN(GPIO1_IO04),
+	IMX_PINCTRL_PIN(GPIO1_IO05),
+	IMX_PINCTRL_PIN(GPIO1_IO06),
+	IMX_PINCTRL_PIN(GPIO1_IO07),
+	IMX_PINCTRL_PIN(GPIO1_IO08),
+	IMX_PINCTRL_PIN(GPIO1_IO09),
+	IMX_PINCTRL_PIN(GPIO1_IO10),
+	IMX_PINCTRL_PIN(GPIO1_IO11),
+	IMX_PINCTRL_PIN(GPIO1_IO12),
+	IMX_PINCTRL_PIN(GPIO1_IO13),
+	IMX_PINCTRL_PIN(GPIO1_IO14),
+	IMX_PINCTRL_PIN(GPIO1_IO15),
+	IMX_PINCTRL_PIN(ENET_MDC),
+	IMX_PINCTRL_PIN(ENET_MDIO),
+	IMX_PINCTRL_PIN(ENET_TD3),
+	IMX_PINCTRL_PIN(ENET_TD2),
+	IMX_PINCTRL_PIN(ENET_TD1),
+	IMX_PINCTRL_PIN(ENET_TD0),
+	IMX_PINCTRL_PIN(ENET_TX_CTL),
+	IMX_PINCTRL_PIN(ENET_TXC),
+	IMX_PINCTRL_PIN(ENET_RX_CTL),
+	IMX_PINCTRL_PIN(ENET_RXC),
+	IMX_PINCTRL_PIN(ENET_RD0),
+	IMX_PINCTRL_PIN(ENET_RD1),
+	IMX_PINCTRL_PIN(ENET_RD2),
+	IMX_PINCTRL_PIN(ENET_RD3),
+	IMX_PINCTRL_PIN(SD1_CLK),
+	IMX_PINCTRL_PIN(SD1_CMD),
+	IMX_PINCTRL_PIN(SD1_DATA0),
+	IMX_PINCTRL_PIN(SD1_DATA1),
+	IMX_PINCTRL_PIN(SD1_DATA2),
+	IMX_PINCTRL_PIN(SD1_DATA3),
+	IMX_PINCTRL_PIN(SD1_DATA4),
+	IMX_PINCTRL_PIN(SD1_DATA5),
+	IMX_PINCTRL_PIN(SD1_DATA6),
+	IMX_PINCTRL_PIN(SD1_DATA7),
+	IMX_PINCTRL_PIN(SD1_RESET_B),
+	IMX_PINCTRL_PIN(SD1_STROBE),
+	IMX_PINCTRL_PIN(SD2_CD_B),
+	IMX_PINCTRL_PIN(SD2_CLK),
+	IMX_PINCTRL_PIN(SD2_CMD),
+	IMX_PINCTRL_PIN(SD2_DATA0),
+	IMX_PINCTRL_PIN(SD2_DATA1),
+	IMX_PINCTRL_PIN(SD2_DATA2),
+	IMX_PINCTRL_PIN(SD2_DATA3),
+	IMX_PINCTRL_PIN(SD2_RESET_B),
+	IMX_PINCTRL_PIN(SD2_WP),
+	IMX_PINCTRL_PIN(NAND_ALE),
+	IMX_PINCTRL_PIN(NAND_CE0),
+	IMX_PINCTRL_PIN(NAND_CE1),
+	IMX_PINCTRL_PIN(NAND_CE2),
+	IMX_PINCTRL_PIN(NAND_CE3),
+	IMX_PINCTRL_PIN(NAND_CLE),
+	IMX_PINCTRL_PIN(NAND_DATA00),
+	IMX_PINCTRL_PIN(NAND_DATA01),
+	IMX_PINCTRL_PIN(NAND_DATA02),
+	IMX_PINCTRL_PIN(NAND_DATA03),
+	IMX_PINCTRL_PIN(NAND_DATA04),
+	IMX_PINCTRL_PIN(NAND_DATA05),
+	IMX_PINCTRL_PIN(NAND_DATA06),
+	IMX_PINCTRL_PIN(NAND_DATA07),
+	IMX_PINCTRL_PIN(NAND_DQS),
+	IMX_PINCTRL_PIN(NAND_RE_B),
+	IMX_PINCTRL_PIN(NAND_READY_B),
+	IMX_PINCTRL_PIN(NAND_WE_B),
+	IMX_PINCTRL_PIN(NAND_WP_B),
+	IMX_PINCTRL_PIN(SAI5_RXFS),
+	IMX_PINCTRL_PIN(SAI5_RXC),
+	IMX_PINCTRL_PIN(SAI5_RXD0),
+	IMX_PINCTRL_PIN(SAI5_RXD1),
+	IMX_PINCTRL_PIN(SAI5_RXD2),
+	IMX_PINCTRL_PIN(SAI5_RXD3),
+	IMX_PINCTRL_PIN(SAI5_MCLK),
+	IMX_PINCTRL_PIN(SAI1_RXFS),
+	IMX_PINCTRL_PIN(SAI1_RXC),
+	IMX_PINCTRL_PIN(SAI1_RXD0),
+	IMX_PINCTRL_PIN(SAI1_RXD1),
+	IMX_PINCTRL_PIN(SAI1_RXD2),
+	IMX_PINCTRL_PIN(SAI1_RXD3),
+	IMX_PINCTRL_PIN(SAI1_RXD4),
+	IMX_PINCTRL_PIN(SAI1_RXD5),
+	IMX_PINCTRL_PIN(SAI1_RXD6),
+	IMX_PINCTRL_PIN(SAI1_RXD7),
+	IMX_PINCTRL_PIN(SAI1_TXFS),
+	IMX_PINCTRL_PIN(SAI1_TXC),
+	IMX_PINCTRL_PIN(SAI1_TXD0),
+	IMX_PINCTRL_PIN(SAI1_TXD1),
+	IMX_PINCTRL_PIN(SAI1_TXD2),
+	IMX_PINCTRL_PIN(SAI1_TXD3),
+	IMX_PINCTRL_PIN(SAI1_TXD4),
+	IMX_PINCTRL_PIN(SAI1_TXD5),
+	IMX_PINCTRL_PIN(SAI1_TXD6),
+	IMX_PINCTRL_PIN(SAI1_TXD7),
+	IMX_PINCTRL_PIN(SAI1_MCLK),
+	IMX_PINCTRL_PIN(SAI2_RXFS),
+	IMX_PINCTRL_PIN(SAI2_RXC),
+	IMX_PINCTRL_PIN(SAI2_RXD0),
+	IMX_PINCTRL_PIN(SAI2_TXFS),
+	IMX_PINCTRL_PIN(SAI2_TXC),
+	IMX_PINCTRL_PIN(SAI2_TXD0),
+	IMX_PINCTRL_PIN(SAI2_MCLK),
+	IMX_PINCTRL_PIN(SAI3_RXFS),
+	IMX_PINCTRL_PIN(SAI3_RXC),
+	IMX_PINCTRL_PIN(SAI3_RXD),
+	IMX_PINCTRL_PIN(SAI3_TXFS),
+	IMX_PINCTRL_PIN(SAI3_TXC),
+	IMX_PINCTRL_PIN(SAI3_TXD),
+	IMX_PINCTRL_PIN(SAI3_MCLK),
+	IMX_PINCTRL_PIN(SPDIF_TX),
+	IMX_PINCTRL_PIN(SPDIF_RX),
+	IMX_PINCTRL_PIN(SPDIF_EXT_CLK),
+	IMX_PINCTRL_PIN(ECSPI1_SCLK),
+	IMX_PINCTRL_PIN(ECSPI1_MOSI),
+	IMX_PINCTRL_PIN(ECSPI1_MISO),
+	IMX_PINCTRL_PIN(ECSPI1_SS0),
+	IMX_PINCTRL_PIN(ECSPI2_SCLK),
+	IMX_PINCTRL_PIN(ECSPI2_MOSI),
+	IMX_PINCTRL_PIN(ECSPI2_MISO),
+	IMX_PINCTRL_PIN(ECSPI2_SS0),
+	IMX_PINCTRL_PIN(I2C1_SCL),
+	IMX_PINCTRL_PIN(I2C1_SDA),
+	IMX_PINCTRL_PIN(I2C2_SCL),
+	IMX_PINCTRL_PIN(I2C2_SDA),
+	IMX_PINCTRL_PIN(I2C3_SCL),
+	IMX_PINCTRL_PIN(I2C3_SDA),
+	IMX_PINCTRL_PIN(I2C4_SCL),
+	IMX_PINCTRL_PIN(I2C4_SDA),
+	IMX_PINCTRL_PIN(UART1_RXD),
+	IMX_PINCTRL_PIN(UART1_TXD),
+	IMX_PINCTRL_PIN(UART2_RXD),
+	IMX_PINCTRL_PIN(UART2_TXD),
+	IMX_PINCTRL_PIN(UART3_RXD),
+	IMX_PINCTRL_PIN(UART3_TXD),
+	IMX_PINCTRL_PIN(UART4_RXD),
+	IMX_PINCTRL_PIN(UART4_TXD),
+};

-- 
2.51.0

