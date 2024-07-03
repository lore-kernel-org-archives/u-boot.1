Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB401C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98A98888D;
	Wed,  3 Jul 2024 15:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="cGYivHbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7580887BA; Wed,  3 Jul 2024 13:27:38 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 336BA887D5
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 13:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcyrF2ehkhGj5CHG0SvCrGvBnpK1bHjBqLvnL8eGnBbBQXzRO/0qaMI8M74Gtxiw+UMKMlERkW3DWy6KCgxHx3L8wMiLPdChwNKxk34g+fyMPunurccpmxgvoP5g7B/AR29KJNJ9/UW/RVOzWgd5yKLjUYE47oJeiDbwatPATKqZ3WE4bdDeMSJ5R7R6zyvShSwP9o/6eE+BnSgNa/SFpDFez6KxUR+H1fqdXuY6fakUSzXXT8iE18FLXCIWuGQdfmmJr3CwOoVWi4IA6oM10Mk/8yeWJvNeCKGaazi3Djj+zFzonUplbD3hWSeo4vOOqthlyFzVM/cNX4q5WF4a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obBVuWlEOh2LYQFtQQU1iJ5lRGwGSl8ECftqMm8XbY8=;
 b=ULjYKSvh4QVs28+evbiOc47//2hMnNx1OwQM6twbrjQX+6OXS17iM4G1dUZRbMd7RFUpUZUhvUkATplN/ncMfsdMIv7y6IJRERSmlPWu3p1fdcGlVdAPB3vBIiVto1urSmoV5gtPKFraaGS8F6oTpYpB9qY7XCVP7y1MoZ7vF3Xg/6y+oLVB5HHtGbMFT8rRSfpverFB7gbyjKM+8ODLDC7KCUEjaPzc/Nd6YgoQyoJVe2NvB8gXkF7gTe/wAmLGDE6tGn6/iv8mYgTS1mD0I3EeqEam9176EX50FHFf8qbDhisGEElcdOIybThDpPWjnKpI13xpyhGUkLf9Xd9xPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obBVuWlEOh2LYQFtQQU1iJ5lRGwGSl8ECftqMm8XbY8=;
 b=cGYivHbx6nH+8xLJ00jVd9a7tcoxaxGuog/thNQftt/b/si+vdsreL6CdCthbMxHtweQZ2ZE0y7JsgIbprw8G0a3dmLgvLWw8L6s3ob1RtMrxOBxzdbBPcHC6VNr9j5B9MNwI+gXfhv7Lyeq4qrptSTeYxE4rWWHwUS4XaCx/do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 11:27:33 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 11:27:33 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,  Doug Zobel <douglas.zobel@climate.com>,
 Marek Vasut <marex@denx.de>,  Christian Gmeiner
 <christian.gmeiner@gmail.com>,  Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,  u-boot@lists.denx.de,  Michael Polyntsov
 <michael.polyntsov@iopsys.eu>
Subject: Re: [PATCH 1/2] led: Implement software led blinking
In-Reply-To: <20240703010131.1735100-2-mikhail.kshevetskiy@iopsys.eu> (Mikhail
 Kshevetskiy's message of "Wed, 3 Jul 2024 05:01:30 +0400")
References: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
 <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
 <20240703010131.1735100-2-mikhail.kshevetskiy@iopsys.eu>
Date: Wed, 03 Jul 2024 13:27:33 +0200
Message-ID: <87r0capvfe.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b3e8d2-3ebd-45f3-2197-08dc9b532221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e0j3nqEpeFX9OkaL8/CCaeCZCUhMRYDJJuunfKzoiSfsmNACBlgI/VGyK+Bx?=
 =?us-ascii?Q?NIg0gHH3qwKl4f+WxD4b182TQGCfsOxxkJLodbppDHRsmp/EebY1lZACpJnY?=
 =?us-ascii?Q?+cIKhtWJwtSHas+hsN6y965qaihToEcXATzubt/35olkelJsh5pYOPZSulj7?=
 =?us-ascii?Q?EvnUJgPuu69jvYwn00XXMnakHd20l38HP4r1NcI8D2LLBYHFTbE0lDd7vYPI?=
 =?us-ascii?Q?V9LJ5K9OvnW14pFJbwZbXlKQK7Z5cc65lSR3KvXUd/HzabwCGl2vuhlp+Mwu?=
 =?us-ascii?Q?SaF9kCFM8fLiIPoshiBthBs8xYBlDb1DUZfwpNXtP6TSZwKPK+Le+W96fnuq?=
 =?us-ascii?Q?teUpEb1GlQypoQy/Xvv8k4mCdY9cFh5r9XCIXNYoxSMsjW9PqiBmAS2TPMVg?=
 =?us-ascii?Q?htxTXVtnNihOcC6NlnwCHWhPV1VHGRlGPSYg+RusW7n9t692wbtdXWVUbkqL?=
 =?us-ascii?Q?P/Y4P9i/3bSEHGe1swO/79oJ0IOSXZXW30UEFkDLHRPpfE9b6zNQIBsSP+ZT?=
 =?us-ascii?Q?cHNn1oE7wA7yZSL0wbTpyI7CPb/bUHyytXNzptDC7n0Kqoiun/yB0yyJDfak?=
 =?us-ascii?Q?ZZ1t1MuahurO9DqI0NvS9mOllo2E/yx/3UtOTOCgs4w3WqLFuv4zSysPmvf/?=
 =?us-ascii?Q?YUlKvg2skZ++VxqRacdmrg+uqN+C9i9c3EWyI8Vt3zgub5B5Qcz1Wyemzmsm?=
 =?us-ascii?Q?91VE69xm59da+i5ITmb+gNkq8bdCjcBiF5fkUVF8YsK8NycRW8eoLOZ1pHCn?=
 =?us-ascii?Q?Ma3000jAaeRPeppVRUwIpI8vw9Yxs0r+K4fEDDheNifudLBVixkaKcW/17oE?=
 =?us-ascii?Q?eOaViHm8C7e2fkLRYl1UVmvFobh8Zjj47Z2lz2o/pnyrZAgLG+Qlkvs2tOib?=
 =?us-ascii?Q?z7wpCiR6/+ev8WhqmW9IBqbjWa8HWUFdTiQtl8eyHYcwKTVAbk+aKQo2uxwa?=
 =?us-ascii?Q?3WpQQQah8FM7gmMSYvj+Weg9xhbg2ySkAIEecbd0fW/3T2UaEtoH2KIVYyMm?=
 =?us-ascii?Q?V8fjw3nrtpDiP3NvT474QRoOrT/+/J4UghGxhcGKf2ewLG3pKPD4DUB4JedK?=
 =?us-ascii?Q?U55bHTYiEwYvd7x3bxLR0wLrgDucowTc/vgIKgWhRq/D002PhETBlYUwE45F?=
 =?us-ascii?Q?rrNekL3Sfl2BB9W9Bvd2O0YQuQ4zNqfljrRQtmDDH9jgnUA2ms59CFgf9nv0?=
 =?us-ascii?Q?EY9sKHf9KQWKnn6wqVppKtkn1GhSADdop+mM9shu6IpArWfXbe4hcKxkVYia?=
 =?us-ascii?Q?jxnSMEbSKJWRdeUE+NJy6OUVL7d+uWWjXJXjLn8NNNOoNNobOzbn58ASxJlg?=
 =?us-ascii?Q?9eosp5fD2MDbnq24vTonDk2QZxn4JrYiQL9L0oaY+ekcbtCi49csQ3wU2U+8?=
 =?us-ascii?Q?sXdrBGw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2q3P4v4PRBO9WPUhwLKjCkrZbJn8pI6a/Pdhu3jRIe/+E0Yc6nAWCM4GZC+?=
 =?us-ascii?Q?pgb/je61Vz7Py5vzMuaX/e1q3k4bT5P/UL7YwwUV9c8yXzkGuafO0IxqNcmK?=
 =?us-ascii?Q?/VGh+L+vfyO0Yw+wj3B6h2U1WJpPXGwuTqnqwfFCKlitUaAKq0Ovs/B1p/Kk?=
 =?us-ascii?Q?kZWbqIhPOd6q32qKJUuW7qlgaoJdHpH0CUe3tdeWVsVZlBIm6iODVcyhOUsQ?=
 =?us-ascii?Q?3S6L/ZwHqH0NmNwMlhMfS8NFPg2vXnfZjle5171BrgAJejd3hv6zbQnyRgVg?=
 =?us-ascii?Q?3Bu/WW9qHmHUQ3SbZPstrtwWUV1UzZ1Cn2f+YtVOJisuPHlZHup1clp9inK5?=
 =?us-ascii?Q?fOFGkJD0FxHUtwgVsoU2ifJl47wWpB3hpl+mzbU1csjtX/8kAW4Kpcnz5uqf?=
 =?us-ascii?Q?h/qBcmJHmlUmD1nOd/tC/xUsk1aOKmxmqpcdF0t0v7wPkAzn9khcSs7QWBa8?=
 =?us-ascii?Q?oTX6pHyzhfdldG9fLrnrWYYgLLWTesGvYZPU3XqBElBnPeqRgBxXrqHl89Y1?=
 =?us-ascii?Q?CzDf1NXMb/DKz5vBehKwmYsZF4PTdVxMv3vxDiwY3VmGaA7sSQy+OzTvn3xP?=
 =?us-ascii?Q?Fyr1gSKFmSZt7gEPgHQWIvN+Sh6rh6zSCGj6JE2IR2DjzLRhoRHVFIQ2Mirs?=
 =?us-ascii?Q?E1K0MSAjHkd090bS0zKahgc2E0AzYUxSyHuamAxmFu79KRFS+TrvjCkm2J6q?=
 =?us-ascii?Q?Njq4jCtaiTrA9W3ol5w5ESHoq8ALmBnaSYtJL0h+ETXKQMfBuEqultZSewue?=
 =?us-ascii?Q?jU24IYV8lmOoSnu/ILjdmW57m1My+nVjHUXgv/oeM/ugNjx8RYg4DyN2cXoG?=
 =?us-ascii?Q?GgWJXMw9y4WYNrzkJDW6Zk5bFb56964Zv0PpUTrD4C+WyfIPuzEPfjG7mvml?=
 =?us-ascii?Q?b0mD9rXbB0drQww4rLbep3VoU88o8hxTKyVXMxf/Fo3cPB1JxiDd8Qws70Zt?=
 =?us-ascii?Q?EFAnN/8SurWH1RZbUsrzWnxz5v8n26+p4B/peq/Jxx+MpyDf2fgyW5nkmHjN?=
 =?us-ascii?Q?ZA3sOCjwP2Ks2GbRWfVGKbJz2mZmxyUhMlH0xdPizKDG85/fKU8ePe9UQUeo?=
 =?us-ascii?Q?g78WtbvVnS/ETj+qFMvWvLi92ReNfwjQZgPxywmv0gmndhPTdsrXORBVEpJI?=
 =?us-ascii?Q?/iHyM4giA+iPjBTaiB3z2XW4OYH00AvM9XzkQ7NhyJ3t8F0SsuOXA8suZqmY?=
 =?us-ascii?Q?CWTA7NiEBJObAx/q0lH9M7WFDrvifIj36Z8iNkzx2DUarAMoGc9Vx92jiwaa?=
 =?us-ascii?Q?Xr314XS6gMaU9B8akkm9skSOyKCmod1Ne5ikE27w9E607y3xv+LEEb0fBHlu?=
 =?us-ascii?Q?f6oa4EZjV1F4UdRJEpfsqhOPxW9mEvTN8gyUo61T5CbhHHTWeiT5JJirsjAw?=
 =?us-ascii?Q?Nmd3hdyZcSmWGLt3jwXW/o3k4di4WaD5uO5eR+2gg81KnDUSXH/ibBzuRHI6?=
 =?us-ascii?Q?h45wgrZR0k/SX1jaDowQVjgWngL31f21/WPHXvsVjK1mJmfJLDUILWQMw0sR?=
 =?us-ascii?Q?jBSTjUDNIeYdfs+OTyZhG778qi6QxnxqyCWtPtD3IJd4IIqk4gkcQ2lKCA32?=
 =?us-ascii?Q?7w3KP378itApgJ66Owy0RFWvqKcSj6wmEvcmKLL1uInZQloSIO30UApP9S1Z?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b3e8d2-3ebd-45f3-2197-08dc9b532221
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:27:33.8133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56v/Qswm6c40wzaH2iZxXF3UCkr38A7H0D2dMBaoArEDFJ3WZ2l4GF+fMf81FwCYR3slvCXzcJ9SsgpELws5/sHXZurgtMp5dU7CJbzf6+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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

Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> writes:

> +
> +static int led_sw_set_period(struct udevice *dev, int period_ms)
> +{
> +	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +	struct cyclic_info *cyclic = uc_plat->cyclic;
> +	struct led_ops *ops = led_get_ops(dev);
> +	char cyclic_name[64];
> +	int half_period_us;
> +
> +	uc_plat->sw_blink_state = LED_SW_BLINK_ST_NONE;
> +	ops->set_state(dev, LEDST_OFF);
> +
> +	half_period_us = period_ms * 1000 / 2;
> +
> +	if (cyclic) {
> +		cyclic->delay_us = half_period_us;
> +		cyclic->start_time_us = timer_get_us();
> +	} else {
> +		snprintf(cyclic_name, sizeof(cyclic_name),
> +			 "led_sw_blink_%s", uc_plat->label);
> +
> +		cyclic = cyclic_register(led_sw_blink, half_period_us,
> +					 cyclic_name, dev);
> +		if (!cyclic) {
> +			log_err("Registering of blinking function for %s failed\n",
> +				uc_plat->label);
> +			return -ENOMEM;
> +		}
> +
> +		uc_plat->cyclic = cyclic;
> +	}

You need to be aware of the API change that is by now in master, see
https://lore.kernel.org/u-boot/20240521084652.1726460-1-rasmus.villemoes@prevas.dk/
and in particular commits 3a11eada38e and 008c4b3c3115. The latter
you'll find soon enough because this won't build.

The former is a bit more subtle and would silently break here (as
passing an auto array is no longer allowed) - consider whether you
really need the led_sw_blink_ to be part of the name, or if
uc_plat->label itself isn't descriptive enough.

Rasmus
