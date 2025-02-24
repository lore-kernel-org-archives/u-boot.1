Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F27C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 01:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8288980207;
	Mon, 24 Feb 2025 02:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YERb8A4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537BF805C3; Mon, 24 Feb 2025 02:38:58 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B38E80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 02:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuaLo1QSniYjq8xX06qW6O2cLUH38trIB8HBS/06ly1n2jZm3EO+ZUJtL/k3C2NPyRx0UnTjRkW3VdYtZQj71u9EOIJf7hrbwSmI1BKKTUXSksvO3i7c7L5aDZQWiuL8HGDJ8JoX7/eFKnMMmQwx1LhFHCLy7UfUTUsnsRSNDBiZekgSzwfiNvipWENMtppWsCpLFv87TOtccjshdj8hhherKjNm6u8RJoBlT6nRLtupsSYv5tMVlVL7EZzPg7Wp3JzC0PfsUEk03ORPnWre0azAlNf3ldu+rJfTkVdq+y8tAxwPXLqpFqU2vKCIEPgcmyPveBAEDwr98peO4Etoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XBsT98zhCmFn9tTi32nLVwNZv5GOpDfvrGNRg8ZMFY=;
 b=UQWgXtJACGzxj/4FHJBEqyg5/rJz5cnW6dg6G34m7E8P/qNRKwa2uqw6iiMn2I72CVF5Lh+Ba03jKfYU+8pJViXl2b7oyfioP4QP04KgprnlgsH7JJ+AXdm9ASf1W+s/1gixHwH++5JI/NGTmP/vWS0m8L1DC0oMeaI6UlU92kRwmOb4vJ2WPOQdwNgdc3GPDarlqFWX0OhT30v1E02Vju0AKwK9Gr7x1qG0DRlTD4T3xkLmQ+WGbGilHoURDIj+6dy+Zf8wZYssqMBsCe8tbvsPnkT3aYhT3QxH581H8AG4Gv6L4MVIAn3qNKw9Lhn0vAFKHoJRfb/0Rp+vctkcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XBsT98zhCmFn9tTi32nLVwNZv5GOpDfvrGNRg8ZMFY=;
 b=YERb8A4GAtNIyWrgDVy3q2JrYfEUUWhti57DeRVVF6ICJ3hu1VbX+AAfoyzC31cvLxOuC/V3wF5/bYn166TZfF1Vwo7WHbA6yu7Sz4PbnJyYvjEwn0WRsQ5NEzfZ16Fs7JwJJYOYP9mPy6ZUANmctc72S7yum0UGQRBshL57d4A+wSvkxuTI40DdXv2aE6oVNL6SaJDSPS6mEk97XHVFGEFqSjG7mcLi2ZpS5/s95HP9rGBDvCEs8sQDSqpIB439jMFVJlHBXusI8ysOCKRFCnTxvEDv3ipQ7LUsxPTycks4mRAGyDDuzA5/RmGQuwVhshrnaz+vBZ/ICrp7ddc8Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8421.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 01:38:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Mon, 24 Feb 2025
 01:38:54 +0000
Date: Mon, 24 Feb 2025 10:45:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?Q?H_v4_04=2F20=5D_firmware?= =?utf-8?Q?=3A?= scmi: add pin control
 protocol support to SCMI agent
Message-ID: <20250224022831.GA9876@nxa18884-linux>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3c1bfa-1ade-45c2-e5fc-08dd5473ff50
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RS9EQ0ZTT0RkNFlOelJLQ09pcDJ1UHpOdVh3NXZUQVROOG83RnFyNjFyU1lY?=
 =?utf-8?B?RDZSSlYrMlZ5NldmZllyM0tVVkx1ajJaN1VCSnVCRnpQNm5jZzVkM3g4TWpa?=
 =?utf-8?B?Z0wwVTFUUUkraG5YVnVEOEVOUEcxSWFSWUM5Y3ZoZHdBbk9wYThzVkdaSlZp?=
 =?utf-8?B?Q1I2T2p3SkhjQ0tHcjNKampaVVRLa0hWcm4xbmZ6UDYvYTdmTko0azdFc0tW?=
 =?utf-8?B?OTNsSWxUU1I2b05NZDhQVHBmL3pkZ1FBbU02dW9RMWJXTkJkK09JTVdkUVRy?=
 =?utf-8?B?VTBtTDdKaHZ6aEdMVkJRRE04czhhNThhSUNnR2VmWkc3MDhqTW9zTXVWM0dw?=
 =?utf-8?B?MUlRWVdvR1M4WitSZHJGRWJibHB6WGFDcEpVS1E2WGo5Z3BVeGFlSnEvbjIx?=
 =?utf-8?B?eVlKT05jNDJ6M0t6SjFtZGgrM2t5Zm5PNG5KenZ2YUx0YUlWL2RKZ2sxSkZ4?=
 =?utf-8?B?ZHBJSDRmY05LSjhQeXpVTzFNQ1QxeUg1bDBUcGRCY0RiRVlaS2VFeWJHWTQ4?=
 =?utf-8?B?V1prcCtQNHZwMlNWZ1Q4bHFOKzB3Z3B3L0x4UmxSdUpmaWw4dHJNZXl5S0tn?=
 =?utf-8?B?Ny96WWlQSFpKOEkyU3FxbmhxNXBWNndicTBJUDVCdHJWd3oxNXFJV2RKOEtJ?=
 =?utf-8?B?cnhZbDFOVmNsZ3c1WE9jZVNHemdTRTc3Z0s4ZmM3MW55ZXA5bHorVXl3UlBC?=
 =?utf-8?B?WC9ySTRFeTg1WkhhL2w0eFRpU0VtVjJ2N3ViVTdLeEZjZmk2em13dG13NWRM?=
 =?utf-8?B?TURSQ0RTMC9leHRLREduZy9BcGk4QVg2NVN3QXlVaGhUUEVROGk1bzFQRGRZ?=
 =?utf-8?B?Qkk3OTRBd3ZSdHpMNDNGTHk2Yi81V3ltL3EycEtRTkd3bmw2OCtObW03QkE2?=
 =?utf-8?B?L3ZqemRwTTR6dFcrQXkxc210RjVlZ05hNm13WTVGektkWmJOV1BzRHhXNDhv?=
 =?utf-8?B?Z2c4K0JwcXp5WkdNZUdWSlczaU01cVR4NzdXTlROUEZVRDhYek5NNEY4djVi?=
 =?utf-8?B?bnJoZTBGRG9sYmNZVUtGOUxCS3dvTjFpdjZET0xZZzMySnlIV0QweSs5Y0Zi?=
 =?utf-8?B?dDFKUzhNTjR2NU9TM2oycktXT2VOeXlZY0FvTXJpcTNReWRxUDg4S1RUcytW?=
 =?utf-8?B?SzJuTC83ZWxUV1IxbE11ZW5jeGpFaDdVYWQ1eXUwM3lWWGczOFQ1S1R2STNC?=
 =?utf-8?B?UUhFSzV5WGRudXUyY2l6aVdicXBSY05sOERwc0tsdlRkSjllb1ozRWxzNGZE?=
 =?utf-8?B?UCtQaW9UdGxYenNEQk5XNS94MGJObFJKSTg1YjNnbUdqNUFsTzhXY0pPcUxw?=
 =?utf-8?B?bWVZVm9jcXFNK0E5NDRMakRhN29nS1F3MU1FV01jbk5oWnhTZ093TUI5TVEx?=
 =?utf-8?B?M1hoZG1EM1M3b24yV3FHVlRQN0xUK09iM2VOSFVHYU54N2JhS2RheDJHU1Ju?=
 =?utf-8?B?RGdvSnlxR0kyM1ZpUk0xZWdaeTNveE5HcGFxY1d6M0dmRHpRUVAvM0o2Q1Vi?=
 =?utf-8?B?eFRyR3hEeXJOT1pGc2RHOGVDaTJCVExSNHdHbFRXUG5ENkl0eWcwa1M1NzFy?=
 =?utf-8?B?dG5xYWR4WU8wNEFKKzhUOWdoTGxEbm11S1pBNnR1YXB0eldPL0xMYzJGaXc0?=
 =?utf-8?B?cWRwbEEvRWdOdlZzTUlxeTJldWdhekUzcExNR1pGOEtldGpkZ0JRb1Vzbkgz?=
 =?utf-8?B?U3VQU1VlZFp3UDVvY3VYU1VRd0tQRnBWRzZTdDBQTUlScGE0bmlYRHN4TWoz?=
 =?utf-8?B?VHpPMkcwek9MajY4Z0g4Q3lzM1B2UkFma2lVYjVEQ2hHOXlKcmtib29rRTI3?=
 =?utf-8?B?REU3RW5kZ2RvdE0zZlNPZ2Zaa05HLzdpNkhPb21Qclc4Z0lvdFhDWE5MMEt1?=
 =?utf-8?B?UFVMN0dxT3RUU1dQaGRYUTVaK1lzZzJTM1oySzZOeEI2N0tYZWdpUklwRXhK?=
 =?utf-8?Q?rUEZEh8twCMVjd+aprumSitcyPkWzHbr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkFzMy9LRitJN3hvWlRaZ0h0dVdpelA5VzlOazh5dnJld0tUSzBTMXBTaitp?=
 =?utf-8?B?dDJQT0lXTGNtemJPZi9hNFBhYTEyKyszVEpxVXdXanF1R29ZKy90QTg5b242?=
 =?utf-8?B?UW5UanpsWnN4WVJQS3ptWENSM1I1ankyZ2pja0lIRktjcHI4QVpVNkdNNXZS?=
 =?utf-8?B?Z0tVTWJpNTVkQStSeXNrckRYR2g2RVUrZW5FSUhEVHhSbnZWdWN2eUlLMWJI?=
 =?utf-8?B?UHJiSHhjdWRXQmpBbVhtVzcxYXhTanptQmltTllPUzBIRS85Wk5WWWpsZXBj?=
 =?utf-8?B?QXFPNjJOeTNTbXJFTjg2dmQzMG5pdCtEU0dlbWp4ek1DcFVaUFNERG8yRStm?=
 =?utf-8?B?Rm9UMGlzd0MrSjQxYzh1cXhHZ002NkNmMFNGNzZGdEgwR0Y1Sy80THkwUnY4?=
 =?utf-8?B?djczdUR4dEVyY2c3Szhzb3FWKzBpaWVrR1VmZVhjaWJLcW03dGZVblEvbzNp?=
 =?utf-8?B?N2F2cFRRRjRJY1cvVmw3WjRQbFhOUE5WYnlpZ0dRSEF2bTY0ZmJ2aks3V040?=
 =?utf-8?B?eW1HUGJRNFpkK0pUd2lxSWRScS9UcTJNL2JoSmExalUxMDQ4MUlPMER4UUx5?=
 =?utf-8?B?akNsM3hZRUw4UFYyRzd5V3ZkclZPczB6YW5KZU9LdUFLc2RLRE50cGZMRXpn?=
 =?utf-8?B?L3VkUHZQSnVMemVyck9Ra2ZEZzNOTnpFMk5PdmV1NjhTRGZqd0lKeGR5UTRt?=
 =?utf-8?B?VU00TDBIY3RIQTd1Wm5QbC9ocmNPaEFNZG5kZDRjWkRockhqN2sxbnFQN0hC?=
 =?utf-8?B?NXQ0THpwU0ltWlhVYzlDVXB1MUl3aThieDNGcmFMZzZJM2xZL2NqN0NKdWNr?=
 =?utf-8?B?a1VyaitQRDZUbUNrMHBoSmNOa2M2RkVxMGZrQzU5QW1CUFJES2lTb0FNZHRh?=
 =?utf-8?B?S1R5QU1WeG1HWW53c29zSHFOREpOM0VYajlXendpZUlaS2RHeTNTK2FWekpE?=
 =?utf-8?B?eHBLc2FhcEdySDNzWlFQbEJPdUg2blpoMDBEWHVUcWhrMElOYm9tU3JhTndT?=
 =?utf-8?B?U1VkbjhsQXlNcjJuUUo1SHkwY0NGTkdWdzlPVnluYTd1VUpFeVBMTFVwMkhL?=
 =?utf-8?B?aDBNSjJTUXlqMWxLTmVnazUvODJrQWcvNUdkTHpqcHZJL3hFZVNWb2RkQzV5?=
 =?utf-8?B?bTZzWm1hUS9wcHVGTnJtMDFZVGxFTmVTZUt5Z1hTalc1V3B2V2lsbDlNVGRP?=
 =?utf-8?B?UHp2NXROd2tzS3VwN01leUlJZmY5WXhQdjU2K1JSYkViQk01WHN5aG9Fc3NY?=
 =?utf-8?B?S0lZeERGK1Y3SGNXb1pHclowSXFvdmxWWjU2endYaHVvTm9GYXJybzJjd09Y?=
 =?utf-8?B?bk5vN1AwWGM4YnVLTHNEZ20vTG1WU1lWOEVSai9nTFhOMmhpbFBGNnR4UTl0?=
 =?utf-8?B?VW5UcGZlVWxWVDIrZzBnM2JZbHZiR2VDOWJTV0I5NmZQMTJIeTNycU1nS1pq?=
 =?utf-8?B?RjF5Tk5yWGMvbWdoM2ZyMEY0eVpNekVkWUl5R2pxekdpc2twOGoxUWltQk4w?=
 =?utf-8?B?T3ZpSEE1Y3JPNGJ3L1lFKzFKWDk5ei9YYkZtVTZlOG1ZZyt0aE95MzBCTUhF?=
 =?utf-8?B?V3cvS2VYY1V5OHhuSEh6SmtFd0d5ZTlPNjZ6Qmh1TzByWXo4Wm5HRnh0anlj?=
 =?utf-8?B?bG8rUzIwRlBUeXhFbXJEeUJNRWdFTHplQThoQlZSemtqYktVa3NTSi9UN09K?=
 =?utf-8?B?ei9xcGhVZjE5cWZtVE5Fc00rOExSYUpuKy80WGsyZFVYTjJDRW5hT0h4NnFU?=
 =?utf-8?B?MFRnZ0Rqa3B6Sm4zNXJUTjJmb2NNUUxTa0U4bWdYdjNuaUI3TFpJSVhnM0pP?=
 =?utf-8?B?NUJTM0ZKczVyZzIvNXV1dE0weVFldExvQXVGUGxpdEJVWEJtRGRlUEUxRDZB?=
 =?utf-8?B?bW5QRE90cmRLRVNXb1ZVUWluK2tEN3RxcjRDckFnQjYxTHd6QTBhUE13dHQx?=
 =?utf-8?B?Wlpadk8venh3UGFSZnZTZ1AwQkpkRkF3eWVxTEMyeXhWZk13MFVHUjk4SUQy?=
 =?utf-8?B?YzBBT0J3bk5EZ25XVjJ6MzBMa1lOQjFHTklPdkJHbHo2eGJqK2F1L1BNREh3?=
 =?utf-8?B?dHVQTFQwd0E5c2g5YkpoaVpObUV1Mi9vZDdOOFlCYXJOaWJPY2lwb0U5RS8y?=
 =?utf-8?Q?fobxZD8a/MlCw9ro70WQxIZSA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3c1bfa-1ade-45c2-e5fc-08dd5473ff50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 01:38:54.0026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 621iHCeOtI+7OKgdS2nCme7HIXyilYK+Rw8nZkhCKKO5hbAQwHEuVIlwnCQRhPRoAY98ziFwAYfBukoAACL/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8421
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

On Fri, Feb 21, 2025 at 06:55:41PM +0100, Marek Vasut wrote:
>On 2/21/25 2:47 AM, Alice Guo (OSS) wrote:
>> > -----邮件原件-----
>> > 发件人: Marek Vasut <marex@denx.de>
>> > 发送时间: 2025年2月21日 6:35
>> > 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Tom Rini
>> > <trini@konsulko.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
>> > <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Lukasz
>> > Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Simon
>> > Glass <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> > 抄送: u-boot@lists.denx.de; tharvey@gateworks.com; Alice Guo
>> > <alice.guo@nxp.com>
>> > 主题: Re: 回复: [PATCH v4 04/20] firmware: scmi: add pin control protocol
>> > support to SCMI agent
>> > 
>> > On 2/18/25 12:53 PM, Alice Guo (OSS) wrote:
>> > 
>> > [...]
>> > 
>> > > > > @@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice
>> > *dev)
>> > > > >     				drv = DM_DRIVER_GET(scmi_voltage_domain);
>> > > > >     			}
>> > > > >     			break;
>> > > > > +		case SCMI_PROTOCOL_ID_PINCTRL:
>> > > > > +			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
>> > > > 
>> > > > Is this pinctrl protocol really imx specific ?
>> > > > 
>> > > > If not, this needs to use some other config option to gate access to it.
>> > > 
>> > > Currently, it is used for some product families of the i.MX9 series products.
>> > Is the protocol iMX specific or is it generic protocol ?
>> 
>> SCMI_PROTOCOL_ID_PINCTRL is not unique to iMX, but drivers/pinctrl/nxp/pinctrl-scmi.c (drv = DM_DRIVER_GET(scmi_pinctrl_imx)) is only for iMX.
>This patch is changing common code, it shouldn't be littered with
>vendor-specific ifdeffery or if(IS_ENABLED(...))ery . Can this be made fully
>generic, similar to e.g. regulator protocol ?

In Linux Kernel, there are two drivers, pinctrl-scmi.c and pinctrl-imx-scmi.c.
Both follows ARM SCMI 3.2, but pinctrl-imx-scmi has some special settings
to align with i.mx iomuxc array based settings, mux,input,pad and etc.

In gerneral, imx part could be merged with pinctrl-scmi.c but that will
make code not clean.

Regards,
Peng

