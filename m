Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB01CEBF92
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BA983C5E;
	Tue, 18 Nov 2025 09:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NebJwvG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE53E83C32; Tue, 18 Nov 2025 04:43:51 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A2E83B99
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 04:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhzxPpLS/qWPdFRRuTQvOenrNrTAMObTZsrkeAd7XMs32xMTrxXSMTq4CzIHy0gUcROYEjYvOEYJqq605lSuU5r1JLqBfYDdqUliH3c475Et3IrxQTGwIU1xhpfkXkZYskii//q6HuTNKGkwDOLb2n6iWwLHYO96+//1wHWB8lnIC+C0w076Aq/tb7dW4swWjJrcKZOguBYp8raZOh9w3DW/eGQjVg9AwnTzQALWmeB3erNciNI1X+1VRRIM7x9js/Aw3qw+hZvVlFluIzlssB6/aBfVrCjxASeNST/EtdRZdYUBIJCT8tlTI5M4sBWlEUKZbf21bIGZawee3Jq+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBTEDNX++SLgtdqG63JPtb+xevxQ1pmhYK9GschE5jE=;
 b=On8Kf2V2CoAmRr2qWCGhRt3rDaSbrnjHdzgU29kU+KH1vDVUD5IZFhLTzJeMja4DwP+CkCf/3Z2f/WtJqiJsD99EAmVsfVQDEZg7xTRHbvG1dw+hRIx9P7rqfgqCzEMYqspBOoJ6CHrxlo59hZOlbeH0lGzXTx1d1peeK1B7EAnW3ZKxz2MW1qt28Duxc8F6+RfTqjiS0FWXQjlDbbtNpsxU9u8jwuaydaGuXBVlZxJmoV1Wsgi8SRlv+fA56AmcF7Xap1eE9SNfrd30PWMnIwbHEPlp0u3byWAQrRD8U9UoMeAYO1b4ekQ++CnRtZgifcaM3Zfp9H9XE5Sev9dhrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBTEDNX++SLgtdqG63JPtb+xevxQ1pmhYK9GschE5jE=;
 b=NebJwvG6v97muFXgRKEqYwD974B8+BwiCG2UJvQGhNzJ+iYZcbmqh6t6EHVRgqZhQkKHcPogph8P2ebEA4A+/ljH8850y0HN2EWyn5tKe4xEMJgiyR7WSytlKWZZoWqOyaSHPqhxUVTTtyD+z/LjF1RpPgHsQQw751gtWQb4p0JGbvddTWzIDL0QKgGXObjo2l2ptQaNideURW8Smq8WHpoF9lubKPBO6KrT3tFXKXC+pPJxy1KrjmILx7i9cM0A4EdVtm7FaLzoqXyEHmW/v4zlDsKbHNccPEP7hI3OnLTZubcV9f1nfdALVl/YL4cGlk9mo3xVnswQLoGb6KR5FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8376.eurprd04.prod.outlook.com (2603:10a6:102:1bf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 03:43:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 03:43:46 +0000
Date: Tue, 18 Nov 2025 12:56:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Christoph Stoidner <C.Stoidner@phytec.de>
Cc: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: AW: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Message-ID: <aRv8gc0FNwulrsRm@nxa18884-linux>
References: <20251031145951.535376-1-c.stoidner@phytec.de>
 <PAXPR04MB84594BDB0690A1C0285F90A588C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <DB9P195MB1212DC55E27674A4194719C497CEA@DB9P195MB1212.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9P195MB1212DC55E27674A4194719C497CEA@DB9P195MB1212.EURP195.PROD.OUTLOOK.COM>
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc9be78-3d9f-4226-bfac-08de2654ac4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i5bmu2MY/knmpRwhptGbNkmdKc3n7+pMm7OsXrsRXeXmVEX4WS0wg4nhakjt?=
 =?us-ascii?Q?kzKbru/3h+EURsWmona9Ec0GNUmh5kAS3dVpV66oG8szEi3xiSdm1yUCpOhr?=
 =?us-ascii?Q?/QZ1IWLdg1D20SlstzKxvP7c8psZe0l36ERA0wV3QyvSpmTcsvmYalH230Fr?=
 =?us-ascii?Q?5teaH9JMM0d+OOMyiOScBjM7jxqnlIp/0SbF+kK0ePeLaMP8u51w49VpqWtp?=
 =?us-ascii?Q?apdyEKBEQR8TG0lUEOi0RxcEbY6D3zXU9hY2tROSkd+ti0OlG5FqaDE8RSNT?=
 =?us-ascii?Q?vYY8HIbv9jv4+Zt9TtqfNreR+t3BBNErct33WGA8hMbUs9kfDmGn/vbsi0Fm?=
 =?us-ascii?Q?3aPjuCFAbZIzogowkHRHlVRtUrnMgQhvLjMNDSSZXtiTYLrRQIddBLtF8QDQ?=
 =?us-ascii?Q?JEXp5XYWvx/x2HAgHGLVPDfGGbAkCPyftBhVaVRwLXTfI+IO667RNV1JFNWB?=
 =?us-ascii?Q?K2r1QX0AdC+UVGpsu2lkwPSVWDZdBn0YxxsO3Lhb6fUxMnm1D/woPPFZ8N0W?=
 =?us-ascii?Q?oiJlr0oGRgBE37koQQc1vdjoZT9gsgVmTW1UzahxZHWMAK38gZ8E60deJ/qA?=
 =?us-ascii?Q?9tjmJLxoMFVOTNoZ3iYbZbkCBXd+W85oerfU7M//U4KGzPePIxP0UaUEO2yS?=
 =?us-ascii?Q?Pq36nIN89D/sZJHs2fE5laHDceCW1VT0eB1WcbLGA1XFQSYofmxqvTe5Qd6j?=
 =?us-ascii?Q?EVnM2wR75w5L8nRh7yMJCCv+uxwTdqTe3LLUMCvjAGJlECDg+QDc+7ELWi0V?=
 =?us-ascii?Q?CSAtPqtiFED/cUioTkJ7YMXchDVBplVMqcvw5eenHbJM42zqs5grOyjn51QY?=
 =?us-ascii?Q?754cO39AVVEMviqjIP0ze8FuLuyV2/REM0Ql4Eo2Cx+QQTGwkjVyLAhCSJgi?=
 =?us-ascii?Q?etY7+WYEf50tswKWQQxQz86DDeDbV/5pmgVev0l70Q0GoH51ibG5Zc6DrSjG?=
 =?us-ascii?Q?X6uKJ57j04q5Rv0xwTvplOkYeLG1Gh2+zfTzI1igXs4X+INYVxlTbDCtZHkC?=
 =?us-ascii?Q?KlfyZkDYe+J4jqoWWOy5e4dpXcjAWyHXRk7q5kJRzrEBVKIFsmOdfXo+jONH?=
 =?us-ascii?Q?rMSW90q3XE5e9VvyTnmtqehNgUGrAeQIt1k00ogR09nbDYCqQZmpAn1Hs/Aj?=
 =?us-ascii?Q?LIlFMXFH9CiNrAJfMvqxFyDRqm+jipRvPuKTMcKLEuRyfwj9bbSlqnkVjSYv?=
 =?us-ascii?Q?kmipZXHUT4BvoECidd8e/tP0S3nzIsKHwd9j31/P2v26DZMeG4KLmNQJ50Iq?=
 =?us-ascii?Q?Potm76T1a+0klKNqEe6d46vxgvbrvjLyi3pNhG808wOsrsmZS1JIVRuhiUPY?=
 =?us-ascii?Q?GLJ6NWK88lMzvFs8AgQSbX6pgbFZlxufZHnV1flfVYcjBNSJsr/uDrS8SuYn?=
 =?us-ascii?Q?bjGBvKQkjBuFZ2KRbsr79JvHsp8ijTrh0mOrJcS9l81drOKlAZuhPHSb1JW3?=
 =?us-ascii?Q?zleINEpw2kqwBbfgmCgRulNLC2CmYVJ20CFBAgXj2x4z1oq4oTbWDPi2A9qN?=
 =?us-ascii?Q?hRksC5CJ749ItF5L3PzvcVSvK080Essltuo+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PiGP52ok6mSpCCMOW2zt0HGPTF6E0Dz1qCKncQxq6BC0gW0SExWWciNwSP1?=
 =?us-ascii?Q?yK8ehXXVeuqxdaekcX1ntezFXFmEC4xqaK2cJOeBqxoWAM5PcabC1Zab1ooc?=
 =?us-ascii?Q?bGzFClXyQc5Nbsz7etbaCZq8f8P9jVwbhiqgdnBMa9UAcJOo+XSSCIblzaZA?=
 =?us-ascii?Q?zYrUmHqZOrUCI1fcckpVlSt2q/3cE5ze7JmJVNytK/PssSQXUqfw1MNADJJJ?=
 =?us-ascii?Q?c+t6RmeKYzHyhtc93l2Uoq8zT/+EnR0gJw1zuFfdPYNV4ic7S8x80lyxkAGv?=
 =?us-ascii?Q?51coi2WqEvJ8jx0/Eb2gH5/szdi93LnOcisy6W2/9KNdEILUoBN9644l/KrA?=
 =?us-ascii?Q?BrWf306lnJbinTP4fsghsbGKcb+88GMAhWOtsf9+WjHo9oh6qeo/sjl0LPtF?=
 =?us-ascii?Q?BRtHfg7TgHri4PlYpX9XyyC/VGcTT7LIe0GHWLZ9cHFyPQnrXRebQgOf1/9/?=
 =?us-ascii?Q?wPSBLS2S1BeU4ywfipceqswc3uvS3MAaz2+ycSmpUDuotCkiNRTFT+bGS78R?=
 =?us-ascii?Q?QRC65bYkRmx2TcpCashR/F2ZFbE8wbpnIO5FNx+wFvGip5SE+wQ4aHxUdVne?=
 =?us-ascii?Q?EWi729TFSgPrXJoBaJJrcDnpquqrn1T6PSk8yoXQQm9xEXtOsGQIXUawk0lq?=
 =?us-ascii?Q?vVQyUIL/sRGjBpzCc32L2Vz7uQoAETtQU/ktogZx3l9rqiJCsr6ad4b8Yzh7?=
 =?us-ascii?Q?9r5p9OaZNyEiMHNngh5CO2FWMarJlLcZbslU3smboN+NmIjgt7Dvz8IxR8k5?=
 =?us-ascii?Q?O7reDIwkbcx7zj4B/b7dwHyC/mPUw46KvnCGDg1HT3VigCNNXZGQE7efnzkj?=
 =?us-ascii?Q?e7RF1EYncGCUdrgzuW7CVTk1a6k6SmFS3VRDQPb2CS7hd7wq64l4kk0HLlvB?=
 =?us-ascii?Q?OfIsH9hck/l9nflRWusfzxaSQy0bFw/NV4tkwFH9HL90uLn3UfNyi81lq0CP?=
 =?us-ascii?Q?uHdy3NykGZlWyCL4G9G+uZhlGzC1JxliawhrICJzAIeK67BFFNrTWHlz29Jv?=
 =?us-ascii?Q?rnzDYXQGC1uyOeAO+2DSRW4a3EeXp9yCcPN0Gy++ZuHzqCFfhSj71lFY2KEU?=
 =?us-ascii?Q?nmL/6JBiWLZ7MANaVz8nqoNNZMhYcsdvB5kl2wl7g4SkGDUK0ADMVjQ2rj5W?=
 =?us-ascii?Q?GpAJQuxNX2WWPxhRB4ozXxK36pq8c9rIsjVCQLAnDbqf0JHO706pKsjdh+Ad?=
 =?us-ascii?Q?l5bPJweCmOg1xlc50uB3WhRFRRNpxfDAYLBfqidzWjaFUm17jYveNCQPY5io?=
 =?us-ascii?Q?7DsvwJiuqZhKEJkDjuLgU/Ko+pePceAn2OUKP3nyQJflLrjdN3exXsLenJ2w?=
 =?us-ascii?Q?svDFV2ipZrldaEy3pltLho469WDaft2ee/3fbsqKfBbR37hn4grlMD+ld+Fp?=
 =?us-ascii?Q?PqLaRn1znyWDZylgCCOaQugJP4RxpOCUJyYUui0MIkJ/LP0FTwakS3LCOJ0o?=
 =?us-ascii?Q?/h6Zxg3SpA/661/SwHlNOk6uswAPVKxnr8NRLNofA/8v7Lo4Ik8ljhS1aY+v?=
 =?us-ascii?Q?st4OvAW2LNoZNaVr7sozWuhUdma7te8rAENSv8Wx4HMjmon5B4nil79jFLaZ?=
 =?us-ascii?Q?fM1HYuhX7s6i+N4GCpe7aILNEvikxyjqodDpxciM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc9be78-3d9f-4226-bfac-08de2654ac4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 03:43:46.8612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5pxXWCwjskqw7Zv9+k9rOtIWx5UmC4Qawh3QM0XYAMDAQTHKCPLbtwleYzSKMdPuaSroxscOMRb0TnJYyaSxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8376
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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

On Mon, Nov 10, 2025 at 08:46:39PM +0000, Christoph Stoidner wrote:
>Hi Peng, thanks for your feedback.
>
>> Hi Christoph
>> 
>> Thanks for your patch.
>> 
>> > Subject: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
>...
>> > +     udelay(2000);
>> 
>> Per spec,
>> From Figure 6-4: Power-up Diagram of Card
>> the 1ms is voltageSupply ramp up time, so I am thinking the fix
>> should be in your regulator side, saying startup-delay-us property
>> in your regulator node.
>
>True, this could also be handled via the regulator?s DTS properties, and
>some boards already do that. However, from my point of view, that?s not
>the right place for this particular delay.
>
>The SD specification distinguishes between two different delays
>(see Figure 6-5 ?Power-Up Diagram (Host)? in SD Spec 6.00, ?6.4.1):
>
>   1) "Power ramp up"
>   2) "Stable voltage delay"
>
>The first one (power ramp up) is regulator-specific and should indeed be
>covered by the regulator?s startup-delay-us property in the device tree.
>But this patch is about the second one - the "stable voltage delay".
>
>That delay is completely independent of any regulator/voltage-supply or
>board characteristics; it is a constant 1ms delay by the SD interface itself
>to ensure correct card initialization timing. 
>Decoupling it from the regulators would make board-code developers
>live easier, and can make U-Boot?s MMC initialization more robust across
>all boards.
>
>What do you think about that?

Sorry for late.
Thanks for explaining this, this is reasonable. I am thinking it might be better
if we add ios.post_power_delay_ms for your platform.

Regards
Peng

>
>Regards,
>Christoph
>
>> Thanks,
>> Peng.
>> 
>> > +     return ret;
>...
