Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE79BCCF2E7
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 11:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A9780B98;
	Mon, 19 Jan 2026 12:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VXeYtqmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C9BE8313B; Mon, 19 Jan 2026 12:24:17 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F75800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2UDlImzF8kNmE+yvDuVB60H9B7Q9gTxn7MJyUa8hm4Wa5W/OiKwB3ft8Wh/oIGKfpNMTWz3IyB+ljL7cIRJPbb1OoEAjoJfH4fzCKUjOOqh7TyyGaS9s/qQ4iYlidxq0vy8D5sucDRkFchiAybBNXpXkahXVm23zaCaxOyYmtwjn+3T7Q29YX/TS6aHU6Ckpnh/ygShQh2/pm+rFeNMfNL9m5ZINBuxGcZ5DY9KWU3bCVFDeVDFPL75TR9kdFds+omwMqNAbSqL37pPgJVcXXl4GFuOtlFn2Z7KqcHD7YIGkJj9GWlBlrx2tQq+cARrsMambBRS74OWk/BTkaVy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hss8ZwAb4+xkvHlQxTBw8BhRKtzJlJjobDL/EoJlngA=;
 b=wiNA5MIQleYl1chHENlqZ+Ncn1lgQXtqTiCQ3pgCya59iEReLFfhdUVONZ4JU+yoQRHYi+RpUQUkhoZpYigN3e7d9AhLgFn/x0nQUdoxguyMyrzWv6wh94Q9SAdSYZU6wOLnjsLlyoA71Jdx5z55Qp8AMEveUFvNAf3AHWPr8WErSsyuQNLZf11BPOJqt9GDY+OYZtBLV8gaglKjKLk3FmxyEo13dRJOTYjwMOqohFDnZH+wrhwIH0oWTvleoPmUwsm/Ys773qtb8FyMf2VYXoBp9wjWESKXIGdE4kwtPilNmMlVT9F8s+iYBQi163rFt34W1YHeN4wH3VLrtV20HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hss8ZwAb4+xkvHlQxTBw8BhRKtzJlJjobDL/EoJlngA=;
 b=VXeYtqmx4CRLl4MksdjYv3+QLubO34fvqs+Hk1iw9bvacOlLGRZp6ogxEofMgVHeNnzL0eUmqlIv0f8Sz2Ah5mNrl2H/PZpyzGPqTJ7ozte+nhyouWUqweQtvgyGgkSFybLUnmo9bpWc4I/hkp7oqzxQPrrgVBKg35lh6USsfcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 11:24:12 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 11:24:12 +0000
Message-ID: <60cb63ca-faa9-4a34-8d19-57c7b652ad83@cherry.de>
Date: Mon, 19 Jan 2026 12:24:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mtd: mtdpart: fix partitions searching
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
References: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119003606.748561-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260119003606.748561-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae4a0f8-86f6-4728-8f89-08de574d456c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzNNNUMxVUJvTjdVMDRPQ054YkpVdE9FZkVqcnJsUEdmZlY2T1VqRG1FWDN6?=
 =?utf-8?B?VkZDN082MzV5TXlhZjNWWWYyaGdhWkhBaU9TNmtIRVFBYUVHRDM5bVllbHlL?=
 =?utf-8?B?VXJmUWpXaktVQzNMeDJGQ3RubG0vQ0FrTlo2NXpkbElmVlk2dDFkTS9TeUdN?=
 =?utf-8?B?YjRrZzdKZURQaE9zeUw3UjdoRlNhaktZYmNFWWVKVTNTS1BOY1VydjMwY3Jp?=
 =?utf-8?B?aGltS1dvamRMbVA0ZDdoLzRySTdEVFpTdnlGK2V5djdYYXVtVVl1SzllaUNR?=
 =?utf-8?B?NGFBMkVqMkxVdUhoQVI2Z09za2tlSElvLy9iT2JBL011N282MWFqSzA2M3Rp?=
 =?utf-8?B?Y0dzbFVneHN1eU9QcU1Ebjhza2E1OXJ3clRyWFlSOXJoTTZNWEVJcmNsZGdj?=
 =?utf-8?B?WlpmenBlbUVta2M2WTZZL3BrOVN1M1NyTlhXM21wc2JQMWJhRkNPaVF3S1FL?=
 =?utf-8?B?ZDZpbjRta3QrdWsyalRobElkalVBQnZpMEVBUldrWXhsZEFPaEh0VnJsUEs4?=
 =?utf-8?B?T3hLbWpCck1OVW1ScmsrcSs4ZjY5MGlPL2FCNVJ5eWpnNjBTTjhwMnV2UzFE?=
 =?utf-8?B?Zy8zNGZrTkhpYm45ZGdSMVJjT1JOVUxKczlLMlp3WHh1aDZudllLOG5DK2dQ?=
 =?utf-8?B?Ynk4QVNNQlh1ZlRHb2FiZjlkZVRZUDJoNVphcUlFdEJIaHpUcHl4OG83S3VL?=
 =?utf-8?B?R3ZYWkVVTlB5RXZjOEZLYkJtdk1wTkxmU1A5TFJmRndrRzQ2aVZqNFAxcUtC?=
 =?utf-8?B?SjBQWVY4VGl1UnhESUpGc29sU0JWaHJvWVFobytKNkJlcU9SMjVzeDNET05a?=
 =?utf-8?B?aEUyU3l6MGpSUW8wMzQrekt4bWVJR0xidjU5cUhYWTZDSzk3cUQ5c2pMcXpo?=
 =?utf-8?B?RzI2d3RtSmlOcnpqZmpCRmdGSDRRWGpHTExZUndQcEYxUEkwdFVkUkZiMVpF?=
 =?utf-8?B?THBUTnc0S0xlMkdSZmVlWEt1REhRYWtMaUUvK01OR2hhME9DOFB6R2hGSS9L?=
 =?utf-8?B?b09HQVNzUjJLaklrU0RtTWJ4ZVE2ZnNWUTdjcUZrSmtuYmo0S1N1V09aOHg4?=
 =?utf-8?B?TWNXbFdldVNBOGZNdHBBZEJISUdUa0xPbTVEMVEwVUh0L21mdzF4djlqWi9H?=
 =?utf-8?B?OHFweEVRSEVuR1BBbXJybTZCZUYvcHJvakZXVlNtTm80QTU1NGs5M0xkanA1?=
 =?utf-8?B?RW95NXRJTE1OOGhDMzluNDFRaHJBSTlkS1pJSnlkV1ZUci8yMk5wdkZVellp?=
 =?utf-8?B?T0Rwa21YejRzRHlsV2hoNUdMVlJIQ1c4K3RkY0VMRTlMOURtSVFtMWhLQ2xm?=
 =?utf-8?B?OEdvWE5nMTZVL0lmRnB3N1VJNVhtWHJiYlBPRXpUTEdaWUV2cy9pQXhyWkJi?=
 =?utf-8?B?RWFFU0NCdTVPVnJGbDMxTTVjWkdGTlBremNpbTQvR3l2REhZRGMxWWlGMTNR?=
 =?utf-8?B?bXBvNjhObys5YkF6eU1kQW5XazRkd2hKR2tXcFZiNHJqQllwZlloanlsK0Np?=
 =?utf-8?B?aktMZHVtNUdubWx3eU15VHlRREtYR21PbkQ3eXl6WGJPVVJNSThxT1c2VzM1?=
 =?utf-8?B?Z0NQQzJLdTNBdDdTRmhMTjhScDYwUmdDc29oNVcxUjNsRVh1U3NWWjg2eXFx?=
 =?utf-8?B?bTcwN3dtWXUrUkNxdlRCTU9HUUhuVmJMRS9BeCtFMERsWVlMWHNvTnRBWG05?=
 =?utf-8?B?R3hSVEIzWTVNcmVYTmV6Y2xLdGpIcmJuckpwTVU3LzBTaUozdEVmdS83MlR2?=
 =?utf-8?B?eXd5K0tKczM4YURNbEVPRnlXSk5aSVVudVNBbnJVN1dLbEVlTnkrS1hrTkh1?=
 =?utf-8?B?a21ZVUZBZUp5RThjSnAvaFJzdEpTZzJieXBDM1RGb2FDLzlLNllFWHpOSHB2?=
 =?utf-8?B?YlNBZmlNTlpLY2FWYUR4OU02czFsN3FoNVlEdGdJL2tYSTIrWXVJaE1mc1Iv?=
 =?utf-8?B?YkJDQVJGWmt5cGY5R0xoTG9kMnlTTXd5TUtXQVVvcTJ5VTVETkkvSi9hT3pI?=
 =?utf-8?B?RDFtaVMrM3d5aFlnaHJtclI3UmpiN2NQY2JkbFAwYis0dE5jUjRWbFBEOTV6?=
 =?utf-8?B?dGJZNHBmSDB4ejhjODZSVlF1Myt2S2F3Q0d2aklQVFh1aWJLcDFmcWhjbXAv?=
 =?utf-8?B?eDhGK1h2cFRoN1NGUUcyeUZIRnQ2VktHV29zdk1zdWt4SllBOFhrWHJ6Zzd1?=
 =?utf-8?B?amc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHMwMmVoaUFENHIwVWplL1lCcVdmbzhzOGZZUW5teTdaWGl4VElHOWVCYTNU?=
 =?utf-8?B?SHdLOFozWkVVYndHcGY4TE1ObjFQNDhJOUl4c3djbkZqblRyZGZPck9GZnBZ?=
 =?utf-8?B?eHpBZ3pBVDNvN3pVTnM4SEtjRkdPVTc5UWRpWkxVSjAxd29kSlo0b2dBWUV3?=
 =?utf-8?B?ZjM3ZDV5MVUySFgxNWRobnd6dVdOWnFXRExXL1c2dUgwZmJ5bFEyZlFROHZk?=
 =?utf-8?B?bnpmVGQ2U2dGSGM3emtnbk0yL0tlZDVqN3diY3RMT1F4RjBQY2Y1a0lLNEV0?=
 =?utf-8?B?L0lqY1pxYkVxUDZPNWR5ZzlwQndtWURXeXpwY3R0Q2dxTnBCTWpnZHBhc084?=
 =?utf-8?B?eTVEa2llSFM3ckkzUnFnVkh4K2xGYkRHcVRIRVllWFBIOENjUHZ6T1l2L0Zm?=
 =?utf-8?B?Q1M1TzV6eVlieW5kUWxDcTR5b25qWjArMjdpSGw5UDNWWlM0T2dWbzNucC94?=
 =?utf-8?B?Y09CSmRwZ3ZZWkx0ZHJLVEVpdG0rZ0FUS2JsOUdaeFAxSGliOGJwbkpteFJC?=
 =?utf-8?B?ZHNGdXBWNnNpdUFzWkdFUnJSZVlVYXMzY0xYYmRQTTd3YkVnVFcyVG5XaHZl?=
 =?utf-8?B?V2VPOXJlNG5vcXJQdTkwUk1FbDIra0hsVE1rRDQ0a2doS3N3STllMVFqSERr?=
 =?utf-8?B?bzV1YzhmSWxkc3NtZHZoenAvM2JSZVRDQjRJUkpNZGZ5OVFWanI1TjFpRDZZ?=
 =?utf-8?B?V3lSMk96MVAyNGZpYzVxVVVpcG40T2NxeEpiUFNBcExwbHNvbTM0MUZDWW1h?=
 =?utf-8?B?bkZxaEQ2UDFPOGhOc0FZb1NwKzZjYW5LRkF4MnI3S0c4UnFDd0ZabXFFZWlW?=
 =?utf-8?B?bVVrWVFtRVV1d2JFQ1dBQm0wa3FKMmFKM25MR3ZCZGxSZmEreVZLNVpCaXlm?=
 =?utf-8?B?QlhjRE5mTTN5MUExU0t3dE4wTXpMc2pscXBjUFh0aVdzemNxSUZxZ1JsbDk1?=
 =?utf-8?B?U25IdlBRaE45RndLQkxac2hJQWlQM2ZrbG9NakQ5Y3creWNaN2xyWE5pbmlF?=
 =?utf-8?B?M1RSMjR6cThEanlTRmtHZTErMEJuYlU4YVYwTWlVbGlreFlKQmZjbnZvQnpm?=
 =?utf-8?B?Ti93SmRmdHZvajZ4cXZTZDhsRklKY0R3OWlIZ2NWVlJSd3JUTlVYaXM5Rkc5?=
 =?utf-8?B?QnM3Z2lnZDc4MGQyM3g5blVMcGRNM0ppWTlkQTZpajdGK3R0eUIxdEJOclJF?=
 =?utf-8?B?TElCNzdybzhSRkFsSW9CQWREMm9OWXVpUTZVMWF3YS9OQTBNdndFSTVPUHoz?=
 =?utf-8?B?K2ZvYm1KWHdmaDd1ZE9VUHFaQy9jWUY3UjlKWGJVNFI0YTNZWWdTMmIydTdq?=
 =?utf-8?B?Yk5XV1pXRWtXVVNEZDVFNEJVY1NIVXBqOXJvNjZaVGZTMnNmR2Y2R1NlaDlo?=
 =?utf-8?B?VFQ5YXovYkM2bzN2WFNKQ2NzZW5uQ0lwZnF1SXVyK2hPOG1Hc0xGQ2wxSmlo?=
 =?utf-8?B?SG9VZzF3T01jQkd5ci85VlJHTVBkQU82bDBwOEpjSno3VDdKYXE1UkRvSWRM?=
 =?utf-8?B?OWIzTy9hUTJOditBb1ZjL0VkTTZrZStnRzlhSjdwREk5SFBNYTJGeTA5YTly?=
 =?utf-8?B?SE50ZkRBRmcrQ0tseVNmaWhWUWlhRTVkNGdiQVR5UGFyUE5HdHB2MldOR0pl?=
 =?utf-8?B?SjJGUjk4M0ZMa1E5OTMwTDlRTDdjY2U3WXBZTFB4UG1EenBOL1pKQXZCTnU4?=
 =?utf-8?B?eDUveFBGdXRYVXY5S0pmWGhXM2ZxY0VXbHAzeVM4NzVHZmlVTUVqQjEyQ1Ew?=
 =?utf-8?B?WHhweVN2c1JOWFhsV0I0QTJ0VWNFZ3RxS3lUQ0JsK2tYekpjcGNpUnFpSm9T?=
 =?utf-8?B?dGk3Sko1OEJzY2VLRVZNSVhyZUdtWlZISXBZREtyQjgyZzdXTC8wdmhNRElF?=
 =?utf-8?B?dDN4YUVGZDV1blNJMmFwY0tMa0NHRTE4aGZJRElmamlKSDZhT1owaUd6U3Nv?=
 =?utf-8?B?OTFRbUdESUZ1b3hOQnRhRlhmRktBYWRDM2hZWFVOeEpTb0RiWVpGK3dWbEhH?=
 =?utf-8?B?T3E5OUNiOHdTbk81cVZESjZJb09KTTlFK1ZKa3FlcjEzMG5SV0IwVnNrVnFT?=
 =?utf-8?B?UVZwdXk3eUpHSU4zUnFlbWoyMFYrL3ZDelZUUUNpU3Y5ajhFYVZscTBvNHhH?=
 =?utf-8?B?TVg2ZVBKVGxlaVVGc085R0ZXcUg2USsxYk44VUx2RGFjU0tVQzdNUWIwaHNo?=
 =?utf-8?B?SnRiWWJMVnc3SFphRlNjeUd3Q09DMjJuK05BVVlEU0tTZnlVai9TMHJLYnBa?=
 =?utf-8?B?Q1UvbFY0U01hVFJUUWUwVzNFMUY5R1EzcitIc3lZTkRISEhnV2J3UTVrS3My?=
 =?utf-8?B?c3hEdVZUcW9acUhxMjcxVjYrV2gvNk40MnJTYk9NUXMvaTQ4d28zalIyZC9r?=
 =?utf-8?Q?SC9rajmtwn5qkcn2bO0Ini1vL5YQZz4voy4qv?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae4a0f8-86f6-4728-8f89-08de574d456c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:24:12.3081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0No68klDqz1TswHLhvn+NSocVxtNtD2qxIWg7k0Ot6yK2elkzJueJDcC0rPETunWhEg+0to7Tdl+pEgP3OSCGpI6p0cstXVHM+q5iKCKkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912
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

Hi Mikhail,

On 1/19/26 1:36 AM, Mikhail Kshevetskiy wrote:
> mtdpart internally enumerate partitions starting from zero, but partition
> driver API enumerate partitions starting from 1. Just now mtdpart does
> not take this difference into account. This is wrong.
> 

This possibly will break a few boards which may be relying on the wrong 
offset being used. Since it was wrong (according to the doc in 
include/part.h which states the partition number 1 is the first), I 
guess it's "fine" to break those?

> Unnecessary debug message also was removed.
> 
> Fixes: c29a6daec184 ("disk: support MTD partitions")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   drivers/mtd/mtdpart.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 842d3e7274e..0bd4b3db022 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -1067,7 +1067,6 @@ static struct mtd_info *mtd_get_partition_by_index(struct mtd_info *mtd, int ind
>   		if (i++ == index)
>   			return part;
>   
> -	debug("Partition with idx=%d not found on MTD device %s\n", index, mtd->name);
>   	return NULL;
>   }
>   
> @@ -1082,9 +1081,11 @@ static int __maybe_unused part_get_info_mtd(struct blk_desc *dev_desc, int part_
>   		return -EINVAL;
>   	}
>   
> -	part = mtd_get_partition_by_index(master, part_idx);
> +	/* internal indexing starts from zero, but part_idx starts from 1 */
> +	part = mtd_get_partition_by_index(master, part_idx - 1);
>   	if (!part) {
> -		debug("Failed to find partition with idx=%d\n", part_idx);
> +		debug("Failed to find partition with idx=%d on MTD device %s\n",
> +		      part_idx - 1, master->name);

I think it'd make more sense to patch mtd_get_partition_by_index() to 
start with i = 1 instead of i = 0, because if we ever get another user 
of this function, then we don't need to go through the same trick that 
is implemented in this patch for part_get_info_mtd(). What do you think?

Cheers,
Quentin
