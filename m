Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6947BC52D6F
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 13:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9268288CB0;
	Mon, 19 Aug 2024 15:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="fz1OPyKs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10410889E1; Mon, 19 Aug 2024 04:06:27 +0200 (CEST)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D23588327
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 04:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JianfengA.Zhu@sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J1069j024216;
 Mon, 19 Aug 2024 02:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=S1; bh=QClnPCKA3Gr7Pl5P79MdT1WjdpE+e
 d4xPDQExuQ7HkI=; b=fz1OPyKs7tselztQefi2i2MJkjI22b6BY6NbGjw/j1cC/
 JUZ2OMKNIov0UDlM7ERHsJQM2s/M/n97VKiiu+5PsBTYFgsJLWz8SkUTw/vez7I0
 tVi3c0729Xgoe29PkY0Qjlkpu8FbIYHzqNekmKKYfOtGjLGf2fcGTG3eGKZFDwI3
 8YToEYp2009XR+uVGJqbdgXZcJ+0bhQTYFz7DmBbV1dyISFk/g2h6KEyDCDwrN/2
 TEZAKaEMxZJlr7D2no4gCUjJzz6bDnlh2RU/i7wdYpsivAcaboKIJ8Yie7CGcE6n
 Cij8t4XkZckBLIWvoosZhUwNnzrR+Xy/eP1a6C9zA==
Received: from apc01-psa-obe.outbound.protection.outlook.com
 (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 412mps15ph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2024 02:06:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toYGTtTr+dJkwCrxAetIVGCqwjBb2YvygQDiv8+BhuO0K55fv2H/96Nq2mt1Wcy9daEM7kE7F77EBXKRJcQ33HghSxBPTWellyB/y2n7+T21xAIQVFejgHiRn6DDSUkmCT+Csy3qoNdgeSUsE9XDOkVXHfZ483uRViivhVhfO1Eha+/8D3cM5YPx5zTOSJvVXRPCMlB+4uHgr/p8JKz2+vB7kc3BDRmZPqzjDHiAs48pWuQ5jfbvbvZFN0sh5I7mzDr7BtoPh7iOSt6i8Tt1Q/DWPAbP9mR8MALGcWJY10jmb8Zg9oErtOy1msY5l91x21192UAY3iUxgqHH3F+6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QClnPCKA3Gr7Pl5P79MdT1WjdpE+ed4xPDQExuQ7HkI=;
 b=heIi9C36B6pyBH0bQXUAQvMsLcoJN2PLXf6+Qi9IJ3usB4WBaxcRsEhVxmO80zPGRVnervGjKga63l3cXpBUgoMzSAwbPtepfMkIUWtP4ZDpHL0MV7migYTiWW2OfxQQcDSgXMsrtmE+p5ywqzhR9pRPo/h8m0S3l6x71k7aoZsQjtrgFszA4BcnRGA4p3CJ3Myd++ymbP07o14dgoDP/f8AIn83VGzFXaJ95Vk+9EOZnINZaYyoz9Q0592bNx41MxgoSQbHA5Hfb0tEuSFaCxw6cQSPZl3ZZ6h9oXwJZ3XYe28MqGkMJWFzfFOb2ezGBP0Mj58eYGR/V2fNxBATIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com (2603:1096:604:283::6)
 by SEZPR04MB6095.apcprd04.prod.outlook.com (2603:1096:101:99::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 02:05:48 +0000
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd]) by OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd%6]) with mapi id 15.20.7875.018; Mon, 19 Aug 2024
 02:05:48 +0000
From: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>
To: "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "marex@denx.de"
 <marex@denx.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>, "u-boot-qcom@groups.io"
 <u-boot-qcom@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: usb: ehci: Fix db410c usb reset not working
Thread-Topic: usb: ehci: Fix db410c usb reset not working
Thread-Index: AQHa8doyfZyzV2yuBUCqkBKJjB90ZA==
Date: Mon, 19 Aug 2024 02:05:48 +0000
Message-ID: <OSQPR04MB77401D18913B397B768EC042908C2@OSQPR04MB7740.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR04MB7740:EE_|SEZPR04MB6095:EE_
x-ms-office365-filtering-correlation-id: 2e63d39c-9f40-4e19-8b83-08dcbff371c8
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?dHdHaVdTR1lhbEpJS2wrTXNpanZwS0JKYmk0L2IwT1p2dkhpUmFscnlrUWY1?=
 =?gb2312?B?ZTRQekw1QkkvUlBBWTliM3VuTFZiM0M3czFxdnhmcHlvL2Ira1JaWk5Weklr?=
 =?gb2312?B?T05MV01WcWJFUnlxMi9mbzEycE9nUFlHa2llNkpmcHJaa01OVkQ1MktwYzNz?=
 =?gb2312?B?K0syQlVzTjZ4cE1MSVQxYkJ1M3RFdzVTVkZ5QTBKZHFPaDhzbnh5aCsza0NY?=
 =?gb2312?B?cjIrdkR6RUhkdkhOQTBqcUdhNUNBLzA5Zkc5T2pGbktQK1ppSDdNNUZLZTRR?=
 =?gb2312?B?d0ZNZ0w1UFVjMjZLOUNVMVJtckdzT0ZKRS9XZUsyZllZZHZTdGFJUUFDazNk?=
 =?gb2312?B?Z1ZWVC9OLzQ1YnBEQ0dVZmd2S0VEdzkwRU1LcGVVV0hYem1XWHJtZk4vMkFK?=
 =?gb2312?B?QXBoWit4THFuSUpWU0s0VWFPV2NnTlU4Z2tlNElRcUZseXdIYWlLWUZmem5X?=
 =?gb2312?B?VWxjL3dXNWFKL1RRWlZuMjF1QlF1WnVTS0VHQWF0dmFTVGMxY1BOdzR2WHgw?=
 =?gb2312?B?UEZkNmlLL3lGTHhvbWVHT3Q3YWJNZ1FCaW9mNkJuWkFtcStTcGtJc0pFdWc0?=
 =?gb2312?B?dW5lK0RZUENRL2ZPNmRIa0dRNm1ZS2JzbS9BZ3drRk5JdjhrelpSN0FQSVY3?=
 =?gb2312?B?a3BHZWN3TTFCTi9kclhHWUFaeWFkSkpmNlZpdmRRU1AxblVWREQwbCs1algv?=
 =?gb2312?B?b3FnYkkraHorSjFvcjRxZE1vQkZPMEk3cW9Ub2k1ZGtRNHg4bTFVQmVlN0hu?=
 =?gb2312?B?YkFEZTJ6NkhHazNJTm1ualc2d3poNEU2aDh3SXhFM2h0RWRVVVRUN1RUcTl3?=
 =?gb2312?B?MjI0ZzEvZ0F0ZXgyZ3REN3o5a2o5MFRMRUcyanZteGxudkplY3NNT1ZleGtF?=
 =?gb2312?B?SUdYdE1ldjRIMk5XZXZSTWdyeWNWTnV2VTg4N2d2U2ZBTExNZjNZZHRtazRN?=
 =?gb2312?B?NWxaTTFaMWxOSmRzdDJ0TlRFaTMrQkxHK3NmNzIwbWhiUGhkd0RZaUZNR3Rk?=
 =?gb2312?B?WVgzWnNGdUdSWGNiZ1ZUU0tTS2RIWVNnQUErdXBGOGk0b0hqb3NhTGg2UXd6?=
 =?gb2312?B?VnFMaTZadVRGUEJXUGx0cUhKSHozV2Flc3VKM1JrelJnWENUcTBtczc1TnUy?=
 =?gb2312?B?Nk9KT0lRVmN0SWc1cC9WVEh6MEtGemVGbFp0Z01BVnJmY2FEM0trczI1VnJX?=
 =?gb2312?B?azdUaGMzZGhRNGRaa3ZMck9CYVhqMUd4THREK0NJaWpWQk45Um1selAzWmh5?=
 =?gb2312?B?S1RyZ081Y0F5Y2VaZU1ReWErNExXQzhSQmx5V29HbFdaVWIybzREcW8wbmRo?=
 =?gb2312?B?WGZpK1Q4a1pydklZaFh5dWd1Uys4NU1ka1pWSXFBU3BQQWx2WERhMnkxMEpw?=
 =?gb2312?B?ODE1OC9PZzNqY0ZMUm9KUkt4em5TZDg0RHc4QXJETWJlUFdwbXlJTkpJbm8w?=
 =?gb2312?B?ZDdETEJtUytmMmRpZGtvT3N4QjhyUDRwbm1zck43Zi9xN21Qak9EUVhzbWRD?=
 =?gb2312?B?cWl5VTlNRGdBYm9DbGprb0dkWjRaeUdaNnB3SU1TUTFqeUxKOGRHYWJKYXFk?=
 =?gb2312?B?ZEtqU0JmY3B3dFM4UFUzVGRFU1RGaWYzTXQvRUV5cUFmbnlYWTBZeEVVLy9X?=
 =?gb2312?B?bzhVN0F4ZzF2bkZZZnlDWlRZbi9sSk93MzNUYXJDVlhnUlM4YWljTTlJYXFy?=
 =?gb2312?B?c3BraU9hWitTZitUd2IxSVJZQWt6VEZub093UzZLN2xvQmZOK1lKd0VJUWdn?=
 =?gb2312?B?S3ZGNkEza3h3bERGNlc0bVd3cHhmVEZkYVRpN1htUUMrU0dWZEFPdUpxQnNS?=
 =?gb2312?B?MTFDOHlKSENNOGhBNThhUjJaVWRSd0lGdlVLNVFwRGNzK0xZdFd0cXpqVHFM?=
 =?gb2312?B?Z2J3b2hicnBWcWY1cURqV05kVExaQUM5RXllVUJIN3JFK0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSQPR04MB7740.apcprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L0huZ2J0NkRFazB2cVM3Zk1IV2NEVW5yZXFyMG1aaHdabHpYSmF4TmZ6OVBz?=
 =?gb2312?B?dnN1TGswWXpNYXJ6VDAvYWxrYTBESEJ1ZWhMT0MvaThkY0E5NEhqYWdsMUp1?=
 =?gb2312?B?bG9LdnlydTdnMTdWM3JYK0Fib2JnWGRmbUkzOTVBbmdidjRXSmRHRkhsTWhR?=
 =?gb2312?B?MDUvdjZ6TDQ4d0dQNjAzbXRhNGFoejUxR0J5aFlqRzE2STU0L2hObWhyR3dH?=
 =?gb2312?B?M1BDbkJTTTltWFFGejJZSzl2M2E5QS9rQzl1cFJJOGR0YUllcUJTalNqL0p1?=
 =?gb2312?B?cG1VV2pvb0Y2N011SXpFbWE0dDA2K1NWbnBUekNLWVB0RHJydEkvVm1iUWg5?=
 =?gb2312?B?d01ZQkZQNTA4RVdCamVPZ0pETFMydmhWcU9UeFhXS0crQXkxTUVsRmJML2hp?=
 =?gb2312?B?WXNvaWtWK0ZxdVdnMmNjcTEzWlV6RG1tSkFiMXBTOFRIUXdER3k0ekZrZmF1?=
 =?gb2312?B?dElNZDl1SDI5cm50MitoMGpKcitTWTA5aE1zWkdLQjJJOEU5Z29sM09JMmta?=
 =?gb2312?B?ZzJHMFdoNG1adUpoR0UzVVR1L1VBV0xsL01JNG5BYjFubWxUUEpxUEQxMDFz?=
 =?gb2312?B?R2RhZHpWMlpmVnVmVStNU2t1ZHdyN3VWNzRiVWlyeEJPNC9iVUdENnhsaFgy?=
 =?gb2312?B?NTAva1drRWVUZ2pWMzJ0a3lhamVoR0FrYmYranZFbVhFMDFjTnhLOW9qU1VF?=
 =?gb2312?B?TDEvcU5tNE00WEVLRmZETTRBU2EvS1VWSjZOak8rM2R4Y1N2LzJGeVlsQTdW?=
 =?gb2312?B?UCtBWWpmdXkwb2R3ckdyOG9RT1IvWkFqQ0FzbXdVZnNlRDVub0JJSCsrOVcy?=
 =?gb2312?B?K1lqOW9GRFlaNTgwN3RiVlhiY0lzSU9EaGdDQ3BDUkhJeTl0ZWlESXBneEhn?=
 =?gb2312?B?b3ZWTCtHQ094VTFIM29KTVhJdEdWRHFlN2Z6NFZtc29iN3RmUjc1eXoyS21E?=
 =?gb2312?B?WXRUUWRnMFlVSnNaWTlTL0ZOaWJnY1hPVnRuejgzR0tVMEljaFdIcHdBYlFG?=
 =?gb2312?B?U2ZDVFZTdlY0OVJYMzNtNGlDL3ZYTzc3VkZ2Q0l6dUEyNU9iYklVUXd0TUJ3?=
 =?gb2312?B?cjBDbkQyRlRLRFFiOXFOQU0vQUN1bkJ3WXFGbmtXWTd1NUVXZnJKazZQb2ZJ?=
 =?gb2312?B?d2RFUFlUdFYwSDEzWDMvS0QwSW5BYk5kMm8rN1lpWk1SdHovblpMNlhhUmkz?=
 =?gb2312?B?OHJ4bVhRVE5nMEwrb0x5OGlFdTBSbWNOTkI4QXRZMXhEK2RZRGVMUWdsY0M2?=
 =?gb2312?B?OHd6NkJ1S3YrSTRYRU9raThyTVhPcVZIVVpmaGVuakJJTTJQTkk5dCtIZDJl?=
 =?gb2312?B?OVRmNTBsMkdNcmJHZlVhajhWRTR3RVdpSXdGd3ZRTnJMbkI3bGVZYnhMbisr?=
 =?gb2312?B?eTJIR1F1aHQyVDBCN05UbG5xY01zVDJacTdvTTVrRHhpamF1Uk9Kb003Rm1V?=
 =?gb2312?B?S0lveStBMTFuZVVuQzhweFBwUWNvODFLOU1JVXBVWkhFN2VWcGlUZlJ2QmJ6?=
 =?gb2312?B?WmV3QmtTSGxyNGRrZnpSdkVwRUxndkhYYjg4d0pFcjdzYTBqRHU3T3lsYkVT?=
 =?gb2312?B?QTkxZEtjTWxoTXJMVjN4MDJ2TkhFOCtPTzdNVEtmd0F1NytVK1p3aHIzSWx1?=
 =?gb2312?B?YXdsa1V1MTJROGttbGlRbEJyVEpvcEFQYnpuellEd2pCbDZ0UUlQY0lhR0F1?=
 =?gb2312?B?MkFKcmVRZzJKaitNMXByZE1ESFpBY2lIa09sZks1S0I0MU5IOXhORGVsVk1C?=
 =?gb2312?B?UUZkbWRLTlQvNjdRdDhIZU03U2oyRGhaSlNhcDd1Q2JBRFJKVWJuMFZLRkhh?=
 =?gb2312?B?RkFDQVBLUDVJaGcwMG1xank0YzdIS29WWHQ1ak5pNTdvNE1lZGVUcGRzazFT?=
 =?gb2312?B?YmNuM01hSlRMSUZUcDAyNVFDSnRBQkMxZWZlcTFsWC9JOGpWRld6elZnOUo5?=
 =?gb2312?B?TlloalNDeUszd0tnTmN3cVhCeTJEN2pDRlFSdU9IRDRVK2RGL2w5THR2Tmxu?=
 =?gb2312?B?MGU4cUdmejNBVGdsaVB4bnNIdmdDUW1ld0N4YzRqalVYa3RlbnQ1RmJWKzhL?=
 =?gb2312?B?TnI3aStkUmhRNGhEdUFzQlZoS2tRcmdDRXIwVmZZM3FHZU5JcW44MEpnRTVB?=
 =?gb2312?B?YmxpQzB5R281U3hjRXZCbTFmOGtsVjBHUy9iUmRxRHJuSVFFU3N3cXlQL2Np?=
 =?gb2312?Q?UzAZW1DPXTGHK816cm2C678=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: esSD+pg4Gbn21WukfF0oeLXdqb//GmtaMMXgwgeJLhgjTFX9IRWPOKr9boPC0m4+MO9Nj6HGpdyn79IvsI5DK6lwctUaYhMIQcP0f60ptfdhEfh5/t32cbb0i2sljou6L7n4847fule9YkOpm6KGtaOJOFz4lzKFZrwIm/wJ/I+EJpLWlXWjxOPCyg8R7dqJRDsAEhwxlnR5srjzxAs+aQpfh/etBzj6kBozoZ518U8NE8uZr/wmPkVZvLTARVBj/7uMeRJBX+KZooLVqaNA8mV8wXBistXbUW7yOXZFEh8piK6GhsT34ucD0lpA5DgQGkODDmqhu0PYN734+MbLhWExMglpK3jEKOwC4BQytU/kgYYCKbxZldxNtvLgpTestZGCxJxKRnrmzVu6juxJGniewu2uKJEZYWQMlPDQoIkoZPkzBIR+DmhrMvtEKYjOlhnMGvFksQ5Vhc58jau3+sBBgvm2lrsCq6A1OB/Z7wYA0OiAzKbMwAXB0I08qIfxeKIJz+peHchJlh06V2GfZj5kKEXLv0/cuVAEFkVhc6HDENxMgH8vZSf2xoz8h7cw1cD1RS9nlWZeO2b4kMOtghLPpEurputphUzImH3VLQ5wEg8LP9Ud+jYU4Qa6eyA0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR04MB7740.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e63d39c-9f40-4e19-8b83-08dcbff371c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 02:05:48.6244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPciTAfrFT1OBRO06uHgsHGrUu54K2quf/rFQATKb4OF3DeUrjogl8i7kxIdA+ycKe54FsvjQesmZ/HOCVCUkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6095
X-Proofpoint-ORIG-GUID: QicH9USZD569-Je8ACljlnnhxlrDIczO
X-Proofpoint-GUID: QicH9USZD569-Je8ACljlnnhxlrDIczO
X-Sony-Outbound-GUID: QicH9USZD569-Je8ACljlnnhxlrDIczO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-18_24,2024-08-16_01,2024-05-17_01
X-Mailman-Approved-At: Mon, 19 Aug 2024 15:54:55 +0200
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

dXNiIHJlc2V0IG5vdCB3b3JraW5nIGVycm9yIGxvZwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpkcmFnb25ib2FyZDQx
MGMgPT4gdXNiIHJlc2V0CnJlc2V0dGluZyBVU0IuLi4KQnVzIHVzYkA3OGQ5MDAwOiBQb3J0IG5v
dCBhdmFpbGFibGUuCmRyYWdvbmJvYXJkNDEwYyA9Pgo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKQWZ0ZXIgY29tbWl0
IGVkOGZiZDI4ODlmYyAoImR0czogbXNtODkxNjogcmVwbGFjZSB3aXRoIHVwc3RyZWFtIERUUyIp
Cm1zbTg5MTZfdXNicGh5IHdpbGwgYmUgZGVmaW5lZCBhcyBhIGNoaWxkIGRldmljZSBvZiB1c2JA
NzhkOTAwMC4gdXNiIHJlc2V0CndpbGwgZmlyc3QgY2FsbCB1c2Jfc3RvcCwgYW5kIG1zbTg5MTZf
dXNicGh5IGFzIGNoaWxkIGRldiB3aWxsIGJlIHVuYmluZAppbiB1c2Jfc3RvcCwgYW5kIHRoZXJl
IGlzIG5vIGJpbmQgb3BlcmF0aW9uIGluIGRvX3VzYl9zdGFydCBhZnRlcndhcmRzLCBzbwp0aGUg
bXNtODkxNl91c2JwaHkgdWNsYXNzIGNhbm5vdCBiZSBmb3VuZC4gVGhpcyBjYXVzZXMgZWhjaV9t
c20gcHJvYmUgdG8KZmFpbC4KCkRldGFpbGVkIGNhbGxpbmcgcHJvY2Vzcwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQp1
c2IgcmVzZXQ6CnwtPiB1c2Jfc3RvcCAoZHJpdmVycy91c2IvaG9zdC91c2ItdWNsYXNzLmMpCi58
LT4gZGV2aWNlX2ZpbmRfZmlyc3RfY2hpbGQKLiB8LT4gZGV2aWNlX3VuYmluZChyaCk7IDw9PSAo
dW5iaW5kIG1zbTg5MTZfdXNicGh5KQp8LT4gZG9fdXNiX3N0YXJ0CiB8LT4gdXNiX2luaXQgKGRy
aXZlcnMvdXNiL2hvc3QvdXNiLXVjbGFzcy5jKQogIHwtPiBkZXZpY2VfcHJvYmUoYnVzKTsKICAg
fC0+IGVoY2lfdXNiX3Byb2JlCiAgICB8LT4gZ2VuZXJpY19zZXR1cF9waHkgPD09IGVyciBjb3Vs
ZG4ndCBmaW5kIG1zbTg5MTZfdXNicGh5Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpGaXg6IHJlYmluZCB0aGUgbXNt
ODkxNl91c2JwaHkgZHJpdmVyIGR1cmluZyBlaGNpX3VzYl9wcm9iZSBpZiB0aGUKbXNtODkxNl91
c2JwaHkgdWNsYXNzIGhhcyBiZWVuIHJlbW92ZWQuCgpTaWduZWQtb2ZmLWJ5OiBKaWFuZmVuZyBa
aHUgPEppYW5mZW5nQS5aaHVAc29ueS5jb20+ClJldmlld2VkLWJ5OiBKYWNreSBDYW8gPEphY2t5
LkNhb0Bzb255LmNvbT4KUmV2aWV3ZWQtYnk6IFRveWFtYSwgWW9zaGloaXJvIDxZb3NoaWhpcm8u
VG95YW1hQHNvbnkuY29tPgotLS0KIGRyaXZlcnMvdXNiL2hvc3QvZWhjaS1tc20uYyB8IDcgKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2hvc3QvZWhjaS1tc20uYyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1tc20uYwppbmRl
eCBmZjMzNjA4MmUzLi43Y2IzYWUwODQ5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2Vo
Y2ktbXNtLmMKKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLW1zbS5jCkBAIC00Nyw2ICs0Nyw4
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZWhjaV9vcHMgbXNtX2VoY2lfb3BzID0gewogCS5pbml0
X2FmdGVyX3Jlc2V0ID0gbXNtX2luaXRfYWZ0ZXJfcmVzZXQKIH07CiAKK3N0YXRpYyBpbnQgZWhj
aV91c2Jfb2ZfYmluZChzdHJ1Y3QgdWRldmljZSAqZGV2KTsKKwogc3RhdGljIGludCBlaGNpX3Vz
Yl9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQogewogCXN0cnVjdCBtc21fZWhjaV9wcml2ICpw
ID0gZGV2X2dldF9wcml2KGRldik7CkBAIC01NCw2ICs1Niw3IEBAIHN0YXRpYyBpbnQgZWhjaV91
c2JfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikKIAlzdHJ1Y3QgdXNiX3BsYXQgKnBsYXQgPSBk
ZXZfZ2V0X3BsYXQoZGV2KTsKIAlzdHJ1Y3QgZWhjaV9oY2NyICpoY2NyOwogCXN0cnVjdCBlaGNp
X2hjb3IgKmhjb3I7CisJc3RydWN0IHVkZXZpY2UgKnBoeWRldjsKIAlpbnQgcmV0OwogCiAJcmV0
ID0gY2xrX2dldF9ieV9uYW1lKGRldiwgImNvcmUiLCAmcC0+Y29yZV9jbGspOwpAQCAtODAsNiAr
ODMsMTAgQEAgc3RhdGljIGludCBlaGNpX3VzYl9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQog
CWhjb3IgPSAoc3RydWN0IGVoY2lfaGNvciAqKSgocGh5c19hZGRyX3QpaGNjciArCiAJCQlIQ19M
RU5HVEgoZWhjaV9yZWFkbCgmKGhjY3IpLT5jcl9jYXBiYXNlKSkpOwogCisJcmV0ID0gdWNsYXNz
X2dldF9kZXZpY2VfYnlfbmFtZShVQ0xBU1NfUEhZLCAibXNtODkxNl91c2JwaHkiLCAmcGh5ZGV2
KTsKKwlpZiAocmV0KQorCQllaGNpX3VzYl9vZl9iaW5kKGRldik7CisKIAlyZXQgPSBnZW5lcmlj
X3NldHVwX3BoeShkZXYsICZwLT5waHksIDApOwogCWlmIChyZXQpCiAJCWdvdG8gY2xlYW51cF9p
ZmFjZTsKLS0gCjIuMjUuMQo=
