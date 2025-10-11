Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856FBCCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6642D83A97;
	Sat, 11 Oct 2025 20:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZaGD0ML5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422CE83CF7; Sat, 11 Oct 2025 11:08:41 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6397D83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGSy0tsoF9nCWSplC3giZ7F/yoZmLKmWqviHihk7YxLneL6RdL75JzDeP3IIyV/wScv4d6mnkUaBtoTzNhVSPgXWRnPtAkrBfTr0RQF4eITPODIQi5GvGp6mX+r7Ek1t3wRbqrrWIvkknLFpqMxnAfwjBUcW9FZEXjzb0qXweS8pfjGfvI7lDR3qPPag5x8NOE6fS/WaXaKacosZzud/VBZaWRjR5JuNbRdY4xOxJ5lxSuZ/MAvJ/PTAMBQfe+llA1xO0I6wfys6YGfk9SptN0FoTYqzGRnOYgkksB/jPkDImNG/Hde0wr4ZA19kUxmKAt/PhC4r65E2BzVgnHg13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnY50a1M1a+qNf8/41z7eItKB8Lt5t+slkAwq4vNfdM=;
 b=iP4mTLErr/jyE4EBYTR2onFojmrfC3kPMUzWkw7V0EqM9/gXxcNfOEo0puxK/aDAWaKBHRD+CZ8dEzYzD2aKldw6L+rCYVrbif/ovXSiJY1FnqPlZyjpUH5Hg9GjFbd+mIDzGgi2vLngBhzuX5/pTAoD67zDcrOiIsik5uBvUVKM1LZoiXef2ym6/M73QpI0YE2g5BPhAxsXC12wDyGwSwnk8GeK49CL4aSmXSxok7cA6Pp++5TqOWHyLiPH60X6XiA3qn5dJ6rUFRX9oAQNDFnihETklrImdxDgotqSYcqoJCJXfrWRY9RYEmtZZwqHFn2pO8jD0GtN1Q0CRwFI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnY50a1M1a+qNf8/41z7eItKB8Lt5t+slkAwq4vNfdM=;
 b=ZaGD0ML5+Ao5R45RTLnUDoB3qD+7EUaJcP94nNJvQ1VGaDH5rMqP69aHMzeTctKyfhvpyvY5IfAD7G/7D+NW0jamNy1e5b3Zr2MjsD+4bw0WMGlALN8wqqKdeB7yDN+3Ul6rAm8P1nBczbax74cR16LWCd5s8bwoiaC2UYFfKGVp1u66msVF9PpPyrw96xByEcxOozP/Jc5hSKzxZkOfAqAN+3NCGY+Jd7R7a/W98cbZJMXYzYpb/kOClW4DSO61fhXXk5EwaHkqzYK9r2KbKYs1hHRn5M7WROnQEW1SG5QsSpkFcETrHdfIGnXnaM7zItYKkh2UX3Ak5rowqYGWBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:08:37 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:08:37 +0000
From: Alice Guo <alice.guo@nxp.com>
Date: Sat, 11 Oct 2025 17:07:49 +0800
Subject: [PATCH v2 02/10] arm: arch-imx9: Add USB2.0 and USB3.0 base
 address definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-2-313444548ab3@oss.nxp.com>
References: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f844c77-5dab-4ddf-6a57-08de08a5c36d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUh0bFNHeFhIUTRHUEJ2b1kya2laR1dyY21uK2lIcXpIV3ByTERpY01tTFJR?=
 =?utf-8?B?aWZKOXJvM2crWjdYQkFKOGpkdTcxQVlFc1lsN2U4b3AyQ3VwMlZQRTZZcGM2?=
 =?utf-8?B?VXNjRXlYWmIvb3JOL1UyckFha2pJOXZhbWQrUG5JRzVDWHRwUUtlc29IRmpU?=
 =?utf-8?B?ZG1sd0hwbXN0V3VYeEg5bEE0VFVFTXFRaHgvb1kwZHVVb3ZoS3hUTkIwT0E3?=
 =?utf-8?B?cmlYUVFOUDZyaWFnRkljclhZZGN0aERlMkMwbVFIRUFEYXF1Z2kwdVlsdmJ2?=
 =?utf-8?B?eHFoR3FCY08xZ1dsZ3ZIbUsyTERpWEZOZWtuSUFLSnhLaWo5TmhhT1Q3eFV3?=
 =?utf-8?B?QTExL3lEUmZuLzI3VlNBN1Z1a29oeGRzMS9wdmlFeEVvYjl1SkpxZE5jT1NU?=
 =?utf-8?B?MzNVbzNsdkpVbFE5blhpZjBzWng5Y0tiR3dRMXVMSkFCUVhCdDd1b2w1a3VR?=
 =?utf-8?B?bXFNR0V3Tkc0eVZnVkh5eGVLZzRYS0RRSUdPR3RKQnBQUlBUMmlxUWpiY24r?=
 =?utf-8?B?RlZsa0hyQUZMdm9rdnVhWEtTOUJBOFNwSG1tUnEyNUxodEQrNDR0SWFkQmU0?=
 =?utf-8?B?TFlBT3ZwRnFhY0J3UTV1dlZUTTVma0FUY2c3cERGUTZTVmdKTklkVjErWVI4?=
 =?utf-8?B?V0ZjMHRpbEZ5NGtVSGsrS3BWdnVKSk0rditqUmxUdVpEUWdtamcyTjFEemlY?=
 =?utf-8?B?SFZyZmlSR2I0THFRQjFkSTlYTzFSUmd2Z1o2cnhLenBrNXlIWUlKVDV0NmIr?=
 =?utf-8?B?cVUzTWx3Y3dnbm1tOE5IWldOVEZpVlVwU1Q3VTdPSHBmY0JrMmk3TGo3bWZ6?=
 =?utf-8?B?QldLMlpOYlZUd2ZtL0xlUWhMaUpLSlYxVm54S0ZtN0xmL2tFcjcvcTNYK1hW?=
 =?utf-8?B?R05pMkxaenBiek9aMEw5bUFEUk8zcWk4RFdwblZ2RDEwZi9LRXFDbEhpWWJC?=
 =?utf-8?B?S292aFZUMlJRSTUrU3lhVWR5MmIrVXNNLzdRSi9uWjdFNVpmUHdwTlNsWEFT?=
 =?utf-8?B?Z1hLQm96V3p1RmMzZlhKaXZPVFQwSCs2Y1liRjJpRGRsN2JwSFRXdWRxcUFr?=
 =?utf-8?B?UmFBYjltVFhVZ0VYTmV5eUM3RFBGNGxldzM4ZHd6akVwbWlRVnFIRTlWczUv?=
 =?utf-8?B?UGR6NGJYSmhWUm84NHoxamtFSm04dkIwcVVndGc0MS9wVU0wcnBRQVpVVCt5?=
 =?utf-8?B?eE8wUEV3cnB2VGFxdGd4YzhBWm42OVJCTVErd1J3ODlwYmJtTEZFQmlkejMw?=
 =?utf-8?B?U0ZBd1BEbFRBdGE2bXpySGpuVElRNUZMY3pMd2JmZnlmV1FkZElWeDhjMk9q?=
 =?utf-8?B?Wnk3VG9Nc1VvVWZvR2txUGc5Tmk5WDdpeEYrSE0xSUt6NGVaa0dtNlY2T0Fx?=
 =?utf-8?B?K3JPRDdwN2dlWnVpbUx4UStLeEJscktZNFZueXJML3ZwenBDUGhpT3BacnlI?=
 =?utf-8?B?NUUxb28yUEdHdkc4QjIxb3ZWOHVzVkdMYWkyRUFKNloyS1ZQeWlQY0ZTcktv?=
 =?utf-8?B?SFU5NlVDWnVLSDdvcVZVL2ZOd1p1OXoranozRk5ydWkrSXF6R3hhRkhITU9E?=
 =?utf-8?B?UmtJUzBGd2dJVTJ5cmlCMHRqQTNsQmFydWt2bXppb1pxbVlqRlZoN1JsZ25S?=
 =?utf-8?B?aEU1bDlML3ZiZzlvR2FqQlVMY203amk4cmxSVVF3U041SDFtVmZPOVlMbUZY?=
 =?utf-8?B?Tjd2Q2xWMXQ4eEs3VGVjWTB5bUw1ckRvQzNJdGJXSXFIU2ltbHNxNDNranAr?=
 =?utf-8?B?U3Vsc1EvYjBwRlBqUmpKQ2pBcDh1NDY2dUdEOWdNQWxDc1pRWjliOXQySWZa?=
 =?utf-8?B?NndMMUR4bzQxSjhGc3dldE5VS1JLYmFxNWtjQURnRWlPRXloTEhKa0FZeCtk?=
 =?utf-8?B?cVZ3amQ5SHVzUkZtSGV6R1pYaDZGTEU3WjVVUGNCNXNuaVlwQjlpUE94aWlH?=
 =?utf-8?B?b0E1VVVKTkJyUHd5VmZZQWJFN3JtT1pscHo1cVR4MHlZbHkrcWp3Zkd6cEkx?=
 =?utf-8?B?RXJrWjluU2FhZit1RWcrTHJ0eWVMMlpiUnNyMk0zeXJmZzB2RS9LR3huN3JQ?=
 =?utf-8?Q?naPyma?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklHRUJFZzd3VWczbURraTFGR1ZOakV0NUtlWEFPcFJCa3hzTmEwOHp0MmRD?=
 =?utf-8?B?OWJuWlgzR3VKdTAwU0ZZNzhQcVNDZUVJQVNKVVFBZHpjdVNJdjZvdFFEZUJy?=
 =?utf-8?B?QUNjUVhhTUF4SWdRYnc1aVdob2hWN0J1VUJjUUVZMmcvVmRPTVBrSWJXWDM3?=
 =?utf-8?B?MEtXeS9SZ0gyQ1R1UXpvTFVlOEZ4anU0MXdVUUhzb0MyYU41Q2VBVmt1QXB1?=
 =?utf-8?B?dHhUM3VzQUc5SWQ2YmVBY2MyT0JsQXBHQWNLTVFLdWVubUpkRGtCeXFYcHFq?=
 =?utf-8?B?Tjhjb0s5TnhmcTBHSUl5b0tBVGEyQUtnOHhDK2w0ODdxM2ZxTVdhcFFScVBM?=
 =?utf-8?B?YmVHUkh3YlVoM2hBNnhMdXkwdDhIU2QrY1g1Z1lRQmdBTGwyckJ5elpjamND?=
 =?utf-8?B?SXNPM2t4N0NsTkYwaXVzeTJJYVVDOUtkY0ZTanYzZ1M4cnkzRDVBSDU2eExy?=
 =?utf-8?B?TCtqOU8xcm9mejRkYzlTRW5CUGd4c3FJYjlneHFXN2tCM2MwQmR6SzgwbkN1?=
 =?utf-8?B?dGtCejZHUWRPeHRmcHhpK0kxT0k5Wm9zYWd3ZmFUblMxRjMrTHVqZkpvVE5y?=
 =?utf-8?B?U3JSZThJVHRhQXZuMUNUbGQ1ZnM3dUkrK3JGSnVPaURPSktEOXk1RFd3SWNZ?=
 =?utf-8?B?eXZLaGc5bjdlWWFTTFFCemR1aXZBUlUxSzJOb09OODN1aHdoNytEdWU3NjBs?=
 =?utf-8?B?T3NldDBHR3R2VCtFQ2JQSTNJV2VFdE9uSEUvWXlISzNEL3NDVllkWS9jYzBS?=
 =?utf-8?B?NGhCS0FvUk0wVVRuT3hIZ0ZJa1NJU2R3TVhTWjVGTDZucWpBN2FudTZ5YVRM?=
 =?utf-8?B?RjE3UlZRRm5jUkhxRVFrcTdmdUU2QVVEVnRmb1lRUjF0MmdTQTUvUyt5SnZJ?=
 =?utf-8?B?dWJMU2ZOYVNjbE5Vek44ZkVrQnc5SEVENi8zYTVDQWJnZTRvOHk5OUhiR091?=
 =?utf-8?B?OEE2eW5LalBubkJ5TmNuNkZRZWNrazZ1eC9sWlhoNFN4Vlh0NHFib2U2QVM4?=
 =?utf-8?B?eWw1MGg1ZzBMMldPd29FaTFJKzZCYUFCTnNNSzd3OUx1RkF1Z3Eyd3YvNmFZ?=
 =?utf-8?B?amJ5RnNCTUJlc1VVblJJOFpSVGFGUEVSYVBteTNYS2tBeGtaOG84OHU2TW5Z?=
 =?utf-8?B?eXgvUThTczcyME0xb2xKMFNPZWJFd2FCckVXRThGaW92V3VEMHJMbkluM0Q4?=
 =?utf-8?B?WWR2eVdEM0hSUzFPK3NvaUpaWW9hN1MxeVBVa0VYdlZMdFVGdU1XS0tGNWdT?=
 =?utf-8?B?M3NtVWxLV3hiSlZOK05wY0diSE5xOXpwUExGZFFqVnROUHdTc1VrYXJXS3lM?=
 =?utf-8?B?ZkVGQlAzL2kva2dmWDg5UHNqR1piM1llWjR3ZkFsVFJCWVhReGtDWS9Qd0k5?=
 =?utf-8?B?cmFDcHhZTHh5NnVhelU4RklNQ2RqcTFxb2V3S3Frc0FTZC9NNzhvOERjU3Uy?=
 =?utf-8?B?bkpKV0lBMVZ6NGNnRi9hTWNTZkMvY0pRTmw0M3hzSWdJc0xyMk4xc3kwMVU1?=
 =?utf-8?B?M1BoMGIvcDNkaWVURnBWVFNqL252U3FETTU0Q1ljOGlxbmNLdGtPQk9jVno3?=
 =?utf-8?B?dXVYVkdFbzRyT1U3dStSYTUva2M0R1FoRVNRN3ZQRDFwRzBMYVQ3cUhhVXJL?=
 =?utf-8?B?NzcrTW04N3RQTHVKNG01N1ZYT3dpS2pVV2NXREZ0RHZJWkFkbUwyd1Zabnds?=
 =?utf-8?B?RkcyYU02S2dDWmw4eUlxTmhWMGtBUU4rTUJkZDcrb3RUVHljMzI3RllmL0FF?=
 =?utf-8?B?RVVXU1R3bmVwamZPWllTZE0rNXVvZG42a1N2NjNxdnJITHFGYjRmMWFXS281?=
 =?utf-8?B?UE45ZDlBdnMyZ2hGalBJZWorZ2NtTnk4eTRxL2hNVHVEckszZmNWNXFDVi83?=
 =?utf-8?B?Z0YrVGVNRW5GMG43L2FleW9IbHB4SDR1c0hBVjAwSDRaSzNHWVNCdzlScnBx?=
 =?utf-8?B?RHlBQW8zUHZNUWlLYnF3elViSHRLZlUvRUttUGpxZTlTai9uZkIrUGowL1px?=
 =?utf-8?B?My92UENNSTBZeHorRWNXbzRDL1h1SHJZT0lUbUNQZ29CL2M1NEVIcWFKTDJv?=
 =?utf-8?B?OEpUdXZvdktCemZkMVFCTDJSZ1ZqMkFRNktHMEpnSmZLVWRtVk9iZStPeUQw?=
 =?utf-8?Q?/f9sR0H2WSzhbUMoTeaiZXMUt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f844c77-5dab-4ddf-6a57-08de08a5c36d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:08:37.6223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNgoIiGQXyJSMIU2fAC4J96ODzQuAaNmqQnm1h+rVpt1hITbYzjd1MYD4KXBt9AvY/L30uRIJZAJ5cs9G1kJyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

Add USB1_BASE_ADDR and USB2_BASE_ADDR for i.MX9 platform, and define
USB_BASE_ADDR as an alias to USB2_BASE_ADDR.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index e641ed299c0..2d084e5227a 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -39,6 +39,11 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#define USB1_BASE_ADDR         0x4c100000
+#define USB2_BASE_ADDR         0x4c200000
+
+#define USB_BASE_ADDR          USB2_BASE_ADDR
+
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
 #define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000

-- 
2.43.0

