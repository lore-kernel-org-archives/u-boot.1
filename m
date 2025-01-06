Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E05E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 06:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B47558056D;
	Mon,  6 Jan 2025 07:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R7jSBTQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C0DE801DE; Mon,  6 Jan 2025 07:17:41 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0EA803DC
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 07:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQftktok/l/Qrnq1qhplaz7Fl/ZJtbKRLEoQI8nOURhUKhVGmsuC7+Cqa/2Vfpz+/9a0xGn0xOBGOrIsx3zW+Wp/IDmO5Q+eJiYQO8KsGG4qCj3n8HCAYcusE1ZPsxxQrEytXd1fgbqVCYLtVMm0xKfEH76I5GeF9NMqw77PQ5fQGnoqmHo2qiGOjGMZaCRnOuI0hjeM2wUPl1N05FRJciL+ptSLNv04cdoFl/7Nb1mweQxuHzXDWdPyRCrE1A87tmVES6js/cufgLiJYH9nKfoXoVr4wGvDFGzzTkaxq4KeZbi+RMO8aM6u16eRr9xaqHkNjbBSobC9cplxY+FTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI7Hvv3VnPAnDOUVpBLkAr60VOT0EcvU0itddeQDkro=;
 b=TFjNxNxmBLrK+Ak+HtWxFxNDmrYqV0FKJZxulyiQUJgNTG+qDRGeBKUrH8L+8zV73WmlicMVsGP84gOnDfQujv+I/m9nGezIlO+O8i2dk1rdzBOXiglKXnu4+cd6VX2UCvvNZdHJS5aEAes+HNeZetYZYxs4ZWrnIxqup7N1nLChox2sGf141nyeFkEpcQJjxGRTVr9/1AGCw37RN0hI63RBBNxeDQw/a6seXQJvPJKEgHCFoznu9H3siIbA0FhvxtsX7WIs/QRtVZKPgZdoircwmblqUx2YmHZpLVPidb830vNGkaYQj5RkbpJRwoS0YVG/UeDNP7CuYSAoUUf9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI7Hvv3VnPAnDOUVpBLkAr60VOT0EcvU0itddeQDkro=;
 b=R7jSBTQTlFfi2SgKcEBRLYMNn6DbOf2HhW1T9cfRhW4s4qWl/tLv1FyYjmUVABzHd4uKmtD766MIByJHvIZqqGz2Ct/tcSlKAqts+ZHABGgr7KlkD1WPE0j2PoSimqBMRnsIrQzHW28z6FtGuJnf3kUPPwEhl5rzsJFJcWI/6WqD3lLbuOBXaVAGtDlocmWvI6deOTjrOlSLFsfowzHEhbg7G+twvwwV0fuifdt30+ipvnAdsp0TkBt0Oo008h8PlS6noLCwA/HiQ10A35N1FzJkQZLveLI+x9OmXlLi+LbCNvZsmOJZnDjNOH0KiIRQ92kYFv9zFEaVlmqSx1Vzkw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 06:17:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 06:17:32 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAyLzE3XSBmaXJtd2FyZTog?=
 =?utf-8?Q?scmi:_smt:_Interrupt_communication_enable?=
Thread-Topic: [EXT] Re: [PATCH v3 02/17] firmware: scmi: smt: Interrupt
 communication enable
Thread-Index: AQHbXasjFNU2xPM51EuHJGhVQiV3ULMIrgKAgACODYA=
Date: Mon, 6 Jan 2025 06:17:32 +0000
Message-ID: <PAXPR04MB964475AEF1CB007B5949088CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
 <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
In-Reply-To: <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PAXPR04MB8576:EE_
x-ms-office365-filtering-correlation-id: 32ab694c-c265-4d3d-a4ce-08dd2e19ce52
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SWV1bXlFNUhMYXBUL1hYWE93cFhZMzhheCtNZ3BUTXhDc2ZlRkU2cVNuUzV2?=
 =?utf-8?B?eG0wOFhvQy8veHhXcnIydTh4UUNNTi81Q1A4UWt5ZFhpU2grWTRqY3ErT0NT?=
 =?utf-8?B?V2U5c3VEK3hLVmhOaTdNTWk4SEJDUGx2d3V3NnB3OWhldWF1WGpkOXJpR0pL?=
 =?utf-8?B?aE9OMzJoUTFNTFlYYnNuVFZINHZDSkg1UFlReU0wbHlsUktRMGtlbFRMN1Ny?=
 =?utf-8?B?QXdzekpNZVhIQWUzeWxLOTZOZ3JYRGxva25GOGFaZHBjbHdLY1N1Y3RQaHZn?=
 =?utf-8?B?Yll0Sm12aEl2SEpGTmtMT1BoTTUzcGZlNTBmRHFnSldTUENYYVpaTWZJSE1q?=
 =?utf-8?B?SzkyZU42UklkZXB4c3I0TUJTSWRXQzRJdnBWWDltY2wyMGxjOWlLSURqbkZZ?=
 =?utf-8?B?VHdWR2RIUE9SVjlOcEpjY2Y2dTJXclJsNTYrL2xGU3AvSmxSUWtsbndaYXpu?=
 =?utf-8?B?bzVUdnZQcmtYUSt0TS9GMzBPd3YzUUp6R1JiWElPVU9Gc3pKdlVmaFF5VGN3?=
 =?utf-8?B?NmJGVGptNDdZU3JrZndwcUpDNThWNEcvdjhPdWFEeHhRR1B1bldwdnQwNGRE?=
 =?utf-8?B?UDA0MW5BOTBTQks3LzlJWk5xNEd2ejhKWVA0UHRxdzhrQWswK1hBcDR5eGpN?=
 =?utf-8?B?U2hEMi8yUWNvQ3UzZEtLNVZrb3p5dkEyRW9WSUtXOUFmdHVjUEJPNDR5cE1q?=
 =?utf-8?B?SVYyY1J2WVFKNGgvM3B1eE9hZ3FsTEl1RWY2NXFlQnhyQmEyOE5iRCtPL09q?=
 =?utf-8?B?QUF3SThNMzZPM0c2VkQ2SldDakRqU1hleXkxS3FlakhTcHJUaVl0VzJ5elF5?=
 =?utf-8?B?Y1EwbWdnZ0IxREhjL0p0K0xjbzNBRi9NSHg4SVp4NEcxQU1WUEJlT2ZXL3h1?=
 =?utf-8?B?SXdLM1ZSUUEyb2w0TzJTL3FtZ2YvSEl2Y3QxVVUvRkFDQVVKTVFsUm8vTEYy?=
 =?utf-8?B?YlBUM1daeEozTkFmUkdDWnA0MkNBODFzWlNZdnlNSEY2WWR5WXhhdTAxZVBI?=
 =?utf-8?B?a1llMzh3dkJOV3RKdFl3N05UaGdhaDJkcCt3amVEZ0xwNW5pMmFTTVBNeHF1?=
 =?utf-8?B?c1BwTnkyRGI5UjhBSGprYy9YekFJaFlzekErM1MrazRLQXRCVGJ0K3B5KzFZ?=
 =?utf-8?B?bjAxcUwzQ0Y1MURTWStaY0dMRjRPMkprZ1RJVmxyZG04bzQySEdkVVFTdXox?=
 =?utf-8?B?dnlmOHoyUXdEVENVYUtaaFZidzI2bER1RlFna1FyRk5vRGNsc25RRC9ZT1E1?=
 =?utf-8?B?bWNTandNNXdVV2tmc2hjcUkwL3F1V09mWWJNRGVLSnl1dWdidFpIS2lLbUZO?=
 =?utf-8?B?dnNVM0o1N0pSNUVISVp4RS8vMkVoKzhrdis4OG5tdm9JNUlCZ3FkUUpLTUVs?=
 =?utf-8?B?NWptYVRiT1FVdm9xRHdSbU1oclRseDVGeE1CNi9uOG1zUEtoZGJ4azdaVXRR?=
 =?utf-8?B?SENiZ3kvekMyTHFNQzNVcDJWcjA2dFg3ZWhRV1l1Q2s5dU1BRndKejRmbmFB?=
 =?utf-8?B?Z3N0d2lLWXhQb1cwaVdmZHVES09xZjF1NEJtOGlxY2RDU3JyRThjaWN0d1BR?=
 =?utf-8?B?aHpLdzNLbTZUY1BndnpDTnFqWWpmeFFpelRFcVJQUWlKM1VVVG9JdDRkZFFq?=
 =?utf-8?B?VmlKUGJwdGo2UnJhL0lCSC9jb3U4ZVg5Sk9VVUtMOE0yRjZjcUc0czNzYnQz?=
 =?utf-8?B?YnZoclhGZXRqMkpVWHczK25Ib2xuWVNzQ2lWbklGSnNLaU1oZEg2V0FEam9y?=
 =?utf-8?B?TjRlOHd4SXRJWlc0VEhHV0loVXlmayt5QW1aK0ZlSWpKMFFSd0ljVG9RWnhk?=
 =?utf-8?B?a1cxUkVaMGc3c2U1bFRHaVhDRWI4b1JVTmFFbWxROWJDZ0ZjZzIvR0U5M3F2?=
 =?utf-8?B?TjJyN01oV1hQN2xrZ1p0ckNNZlIzaE5rU04xdkVHL0FUVkRHK3FjYStlUVJL?=
 =?utf-8?Q?2qwTG5onO/4a3g7i/cBNq+Vs+mpKqNaz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTQ1cjRMNXlGTm5xR0FIUjdNelkxckVrZnpJR05DdGZTdk5rbld1TkJyNE5p?=
 =?utf-8?B?VTJBTUpmcnowK3VoeFNIeitBRnZRU0MwVGdHRTZVeW5RS1Q4aUY0YVZxZ20x?=
 =?utf-8?B?aTFWeW5JODE5cVd1d1EyVCtuVTg4TzBlVjMwbWpoMlV3MEtLNm9jKzI5TUMw?=
 =?utf-8?B?NkxvQ1JoL1hzWXoyT1dOV0pVMlRKUVNBdVhJNVBqTkZnRzBTcndXRUluSE9I?=
 =?utf-8?B?eXVMcGNKeGo2SVljMnZQNTJZck45cGh0UGsrVnIvV0R6eVpDd0ZpenU2VFFN?=
 =?utf-8?B?ZnZRNE5tZEo1djR2SmtvaUZSdzRiajhoTWNCeGtBRVhGUlJHKzdFUk9zRk9p?=
 =?utf-8?B?YlplbGM1QjQwemZzOUQwbC9WZHRrWUVhZVJIZ1MxakpPcDhEYndQaTJqSEN5?=
 =?utf-8?B?alVlWGdVdUZjMGxaWkxSYmhzblBNdTI1MGNxK1RKeEd1ZjlCM2hBOWVVTVNF?=
 =?utf-8?B?Vlc0UGxUN2NOMm1xWml5UUNod1ZvdHJJZWNHYlluNTA3ZExSaWIxbHlYenl1?=
 =?utf-8?B?VEd2dTJocExGTGJqZ1ZXdDFJVVl3dG9ZUERQamdyZE05NGVGR2c4cEdVRElz?=
 =?utf-8?B?YW1RMWxQUHRCZEFHckVHZVhTNHFLeXY5aytVbllYN3VOaXlucnAzdElWbC84?=
 =?utf-8?B?QVFsRU1wWk1Ta20ydE1CMXZXZ3FYS1JKaHhLdlUwcnZHR0Q2YkMrWDFLTWRQ?=
 =?utf-8?B?NW5UbVVWRXBkVFFiUHlvSlVCVk1NdzBIYzhtaDVHUUZRSHM2dlpLaWYzdzdG?=
 =?utf-8?B?WHNwU3A5aHB2cGtZUmRJNVpvSXVBV2ZFUWE0MTJPVkxPbUZNSDZJc1NBNWtC?=
 =?utf-8?B?cXJVdTlqSndMV0xqYVVObFUvc1J4YnFBQnNBL3NVaWhjRjIrdFQrUU5VLzRr?=
 =?utf-8?B?ZFZxQ3dMU2c2bUJzZTN5c21PTGhrYXFqakoxUUVXM3pqNkJoODNvd002MVI5?=
 =?utf-8?B?ZVB3bDA5aXZaTG1Ybmt1dDI0RW5YSWlaT3F5NEdNYU9yMW9SdFJRWERCRnlQ?=
 =?utf-8?B?Qm5LaTM4REdVY1BvL2taczFGR25QOFRsaUJKM1pwN2JzQVFXU0c1NHJoVmZO?=
 =?utf-8?B?bHNYMW95QlRBMjZjbE5nc0tVMXl6UEQ5TVEzV3l3OTJmZ3VPQmM2ZFBFdFFv?=
 =?utf-8?B?V213QjFjZmlhNEZsUHNKSTNQNk5ydXRGN294TkJ4STQ4Yld2RythRkJiVTZQ?=
 =?utf-8?B?bTAwc2JZQmNyYzJkTzdnTk4yLzBsYk5hMTl6bEpVakJtRHVCYzFybTRpNnF1?=
 =?utf-8?B?eXBxd1JLOGpORjhoM3FGbkdmZmd4dndZVUNrT21zdHQ3SEIzVldVcUZScENS?=
 =?utf-8?B?ZU9nNHpURmVLMzk3TGFIQVNqU3JMZ1JTRDhOT3drZ0VUWjBLTkIxV0JvUWg0?=
 =?utf-8?B?U25ZbjhHWnBzUUxYaG5YTnIyeDQ4UHRiU3U0OC9DVEJTZDc3aDdldG5vQmpR?=
 =?utf-8?B?SWNMTnJtYk5MTERFT2xLdHZzQ0wxUWRzSU9uNWJEOThydXVVTjgwQ0ZpRDlh?=
 =?utf-8?B?SmFkWjlWdGpDRUh3RTFoSnF4TXltWG0rOWJwdnEzWGVjMDlQYS9UUlhjdVlk?=
 =?utf-8?B?dldwQnVISXA2UTkwemFiZ09ZTHZ3ekI4Zy9uOTE1T1lIeER2ZlV5SEJ1eEV1?=
 =?utf-8?B?ZFl6eWZQalB4Vmd3QTBHNzNKMDg0V2RlMEV2ZnA4K3dKTE9Fek5hdVpVSW1a?=
 =?utf-8?B?ZmZiemN1cUhQcXcxSytxbGtCT2kzNzM4Wi9WMmFab1hkVlBoT2VnK0RsbVAw?=
 =?utf-8?B?dkZpS2NqU3puVVU1VWJ3T0M5K3hRODFFUUVvMWtqY1I0NUZaRUNpeVNGWFVl?=
 =?utf-8?B?bVBMV2dVbHdtOGZhZUJteTZ5b1EzeGhNMmRmSkdDRUZlbTVOTDhITlQyMXp3?=
 =?utf-8?B?RTVnUFFBSXBKM1g1WUJRN2w4bFVEb2d6ci9RQWZzbkpIenVUV0V0Rks3cEhy?=
 =?utf-8?B?bWQ5RFZLc3A3MWxKdW9GSW1zUHEweExMVTlNdG0yTjdwMjJESVlPUnVwU3pa?=
 =?utf-8?B?R0RUc1FQbUZHbUkzV3lpVGhlTFlZNXVWNjJkeFRpYjJjdEsreHJVUjF4Skpp?=
 =?utf-8?B?eDR3aHYybGxsdDl0TkpJYXc0a3VpRVZtV2xpM2lmVEVHQTV1RWRHK1JtMkJM?=
 =?utf-8?Q?D4v3QrmYEKWu6XhD+1d/xMYW+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ab694c-c265-4d3d-a4ce-08dd2e19ce52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 06:17:32.6824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsXJhUOXe9ejWKHWq5pLFHru5uZzgzXP9VozxFhfcKB8eqphaTQkciaelzBSkKIjA4i2vRY1IYq+vpk5kkieJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576
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

PiBPbiAxLzMvMjUgNzo0NSBBTSwgQWxpY2UgR3VvIHdyb3RlOg0KPiA+IEZyb206IFZpb3JlbCBT
dW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+DQo+ID4NCj4gPiBXaGVuIGludGVycnVwdCBkcml2
ZW4gY29tbXVuaWNhdGlvbiBpcyBzdXBwb3J0ZWQNCj4gDQo+IFUtQm9vdCBkb2VzIG5vdCB1c2Ug
aW50ZXJydXB0cy4NCj4gDQo+ID4gLCB0aGUgdHJhbnNwb3J0IGFsbG93cw0KPiA+IHRoZSBjYWxs
ZXIgdG8gY2hvb3NlIGJldHdlZW4gaW50ZXJydXB0IGFuZCBwb2xsaW5nIGRyaXZlbg0KPiA+IGNv
bW11bmljYXRpb25zLiBUbyBtYWtlIHRoZSBjaG9pY2UsIHRoZSBjaGFubmVsIGZsYWdzIGFyZSB1
c2VkLiBpLk1YOTUNCj4gPiB1c2VzIGludGVycnVwdCBkcml2ZW4gY29tbXVuaWNhdGlvbiBzbyB0
aGF0IENoYW5uZWwgZmxhZ3Mgc2hvdWxkIGJlDQo+ID4gc2V0IHRvIDEuDQo+IA0KPiBIb3cgZG9l
cyB0aGlzIHdvcmsgaW4gVS1Cb290LCB3aGljaCBkb2VzIG5vdCB1c2UgaW50ZXJydXB0cyA/DQoN
CkhpIE1hcmVrLA0KDQpUaGUgY2xlYXJlciBleHBsYW5hdGlvbiB3aWxsIGJlIGFkZGVkIGluIHRo
ZSBjb21taXQgbG9nLg0KDQpUaGlzIGlzIGJhc2VkIG9uIEFybcKuIFN5c3RlbSBDb250cm9sIGFu
ZCBNYW5hZ2VtZW50IEludGVyZmFjZSBQbGF0Zm9ybSBEZXNpZ24gRG9jdW1lbnQgVmVyc2lvbiAz
LjIgKERvY3VtZW50IG51bWJlcjogREVOMDA1NkUpIDUuMS4yLiBXaGVuIEJpdFswXSBvZiBDaGFu
bmVsIGZsYWdzIGlzIDEsIHRoZSBTeXN0ZW0gTWFuYWdlciBydW5zIG9uIE0gY29yZSB3aWxsIHRy
aWdnZXIgZ2VuZXJhbC1wdXJwb3NlIGludGVycnVwdHMgdG8gQSBjb3JlLiBVLUJvb3QgcG9sbHMg
R2VuZXJhbC1wdXJwb3NlIFN0YXR1cyAoR1NSKSB1bnRpbCBHSVBuIGlzIHNldC4NCg0KPiA+ICsg
ICAgIC8qIENvbW1hbmQgc2hvdWxkIGNvbXBsZXRlIHZpYSBhbiBpbnRlcnJ1cHQgc28gdGhhdCBz
ZXQgQ2hhbm5lbCBmbGFncw0KPiB0byAxLiAqLw0KPiA+ICsgICAgIGlmIChJU19FTkFCTEVEKENP
TkZJR19JTVg5NSkpDQo+ID4gKyAgICAgICAgICAgICBzY21pX3NtdF9lbmFibGVfaW50cihzbXQs
IHRydWUpOw0KPiBUaGlzIFNvQyBzcGVjaWZpYyBzdHVmZiBzaG91bGRuJ3QgYmUgaW4gZ2VuZXJp
YyBjb2RlLg0KPiANCj4gQ2FuIHRoaXMgYmUgbW92ZWQgZWxzZXdoZXJlID8NCg0KV2lsbCBjaGFu
Z2UgaXQgaW4gdjQuDQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0K
