Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A6AD11708
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 07:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C62988EEB;
	Fri, 25 Oct 2024 09:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ceCIj8g9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C81A88EEB; Fri, 25 Oct 2024 09:10:49 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE08388FBA
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 09:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymp+x53lEj19rFkKDZDS412mU+tgiLnF10HHWNDrwO1j+eLSMpqb8WJQtpWQuC3hpOvIO7U1/ADGEiRjeWxvZ4NbXW+k5ts/g3oErNHFio3M/sI78D8Ifb9TtOYry7QrMFidHLhkOsXpfjhdIjupZdjB7qlU5Kkf1lOuDe7WjShoOGxEPZrn80aJRoWrt18zEuvTZjAQmwv3Uo6Jx7Oel5BjUzm1YnRRl5kaymBCUtBCO11LPKSEOY5A3gWkg0irzC/aFJS9ViF9yS36Cr1Fqqxnid7bEZccwJtd/pUvdTaBqgqjBScUgrkCHaah7FVMC2xSqB+j+HB7kqjCOFaT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f76SBQzQIjWy/3aoLLNsM3/8Y4NrvIss1d0BnBkU2lo=;
 b=TdIW2XxiFNFeD21vbdYt025tBrVC7CuwqvOkuXfl9z6WblpmAG4ONHioAYPkPvbNt4+/XJPq9p2owPBpdqsVUGgoiy+2IEiQPj35UVHaFnNYfATBZ/Arr68bw06ig/zYeu4CSwSYbUTBFBvPYlXy/wHkAvuhifDiJkAd9+n9K/vuONTnFxY+00m8MpQWXO31BxDqWdvO31qKXUV+Ck+730cF/QNtTRkyLZiOqDYG8yNQRvC2RLGH7pdDWh9Ajy8o7auP5HttJ+3MHnwfY/In3rzQw2XoO3fCyKntsuvmD9LA+1jBFr4N4vh1ZQACi4SUzvIktvjwACYTN5EHzVeRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f76SBQzQIjWy/3aoLLNsM3/8Y4NrvIss1d0BnBkU2lo=;
 b=ceCIj8g9aAMipSFjnp3N/fk08o+IkZNa2TxTH7GDDroX5JPQqXD2bS6P08PD0QRFV0+Iv8FQNEeg0NYHiXjooMMkGixG70UcqY3npQp+KDqkSDFNSbIlFld3ZTMiAJqN7miOxXE/SYqDmAT8sBu1H7Vl4SUVlQKstmyFbtPlohM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB6516.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:84::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 07:10:35 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.007; Fri, 25 Oct 2024
 07:10:34 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,  Heiko Schocher <hs@denx.de>,  Fabio Estevam
 <festevam@denx.de>,  Tom Rini <trini@konsulko.com>,  Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
In-Reply-To: <3fa7049d-4657-4cae-9ccf-fac1c62ce529@denx.de> (Marek Vasut's
 message of "Thu, 24 Oct 2024 16:07:29 +0200")
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3fa7049d-4657-4cae-9ccf-fac1c62ce529@denx.de>
Date: Fri, 25 Oct 2024 09:10:31 +0200
Message-ID: <87o738psig.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3187c8-b094-4984-50be-08dcf4c41e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6qDS1z94LjGAwosn/DaeED5BVbnpKhgfLZkEV6jnjaYQtTdt+bvVHn488r2w?=
 =?us-ascii?Q?pMDdTei11rbG3MPbYj/THDW3sP6JZfyxXiOBog5+8teBN5mRsVwfM5k4ia9V?=
 =?us-ascii?Q?TjvilmzECik8d15UopooFPIRFVFL65EwXiWK1Jg/wiLqz/NHg3cBST9trmMC?=
 =?us-ascii?Q?bsClb8aJjhrR+EyLCf7+F2P+Sdd944p6M3+OMXz6zEUtEOeFW9EafCTOWvlF?=
 =?us-ascii?Q?kNZM3+5nrZQ9ryP7JfibgMR4T0dY+BgYYfXYya+OaEhKfG43W4Bt3NTxWuA/?=
 =?us-ascii?Q?aPzHF1M2zXsERDkC64A02AN/7BdLACaPcjg/ehD5dpsOMUDH4YNuwg1d898V?=
 =?us-ascii?Q?obOdyT0XkXTMSdr9XAaghPRaEAlcFtpOg2Jz424ttElC6OW4YmvmPXV9JbHG?=
 =?us-ascii?Q?4QSgZDEunLQlaJpOaIPGOctOhHnkxUglNHSEMAldR+cxfI26FmKZk1RmIq0g?=
 =?us-ascii?Q?V1B44inVbvj0hro9StnXmYo3PFt8Ru15b8HPR5u3Zl9GyzouDP1PrASNMusi?=
 =?us-ascii?Q?xlFAx3GT397MlesLNaJ0lvsnY8iTu1Fkdo7zZjsTFAsLtgxGh194oUvLeqe/?=
 =?us-ascii?Q?Tr5rMB8MozJ9h2amFWl5FmTHjElRHHsb3ZdtZ/evU9dHYoF2++YiKBzY0FzC?=
 =?us-ascii?Q?nZ5xOJRR+iydbOj/7tfpVNfsh+zGuN69wHA/KbLbuZGQESU7YgNJ+DU8XSW7?=
 =?us-ascii?Q?IHGqRacPPGfIdcDmgUulOfn3HjKINWy/aRaB5n1bhhIgGOmxe6CEtpHbU7e2?=
 =?us-ascii?Q?W7YvDfNegz8CLYP1ixXQObyZY46+AvXJ+fHioDITFp6+6G04MyOy+7mLd035?=
 =?us-ascii?Q?mcWhdJjGnvbGq4WBZ3ms4++/P1nkj+N++zreppc3YmqxzS8XowrioUyDEFBM?=
 =?us-ascii?Q?8T6CV/NXGDNNzG51WviUezoWdz1gX7DMyVQIwIbA0Zw3OO3LG+SVQv1IGgTp?=
 =?us-ascii?Q?RpOVdazJNDjZgg74QOdgdCoDKAfkTATMfl2eB7olAnQBW/uHYPEakLD/VW0j?=
 =?us-ascii?Q?rQnArVzTtYDxdGYO5L2lG6/KV9uBkqBC3Xt5dsSG211YUiHnIo6xYdMlx8iP?=
 =?us-ascii?Q?rQhqhrDlw44v2HOMeSvBY6gFR5TeYoDlFO80+2DhxhUfzdhGZDNPta5bKIj9?=
 =?us-ascii?Q?yg/zRJbkJm5/h19bk5Yt02m+Brop9X27nQpU4z8XRTNwhDosIX5+jF3K8ctC?=
 =?us-ascii?Q?6S6Ovyd4IWbMmYr25zuscFbDgDU33VAX9M5z01RO3rYje4uXM00uO5g2t88x?=
 =?us-ascii?Q?W8Z09T0NLSPIDaA2Gia6atNhMOYZ8YZRLlRYUTlPhJUXhYR03MVPF9HYwju2?=
 =?us-ascii?Q?fijJER1uklUhUa3uHpd5d5D7ssM3pqfLNfKGU3PAiXHqj9r1aIJ14KUNSGoZ?=
 =?us-ascii?Q?F9cQIwk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yOSeB+Q8hhHucOXF8Hoc0Hti7EjtPmo+xxoiJKgjA6d02WVY9r+UYthRemK7?=
 =?us-ascii?Q?9/4iVnfnAuHi7Wx/k0bphyiOqa/gy85JAuYqHf85HDKttPt8UhV8DgJFZMkp?=
 =?us-ascii?Q?PPQHXvqDUQLa52hjIpbCi1ET0qb34Zzi5Z5lcyKKyvZpzklvshBcLT+nP9+0?=
 =?us-ascii?Q?QpVbLpiW0pwQIDQH5+7r+ZtwHjk4uGkrB6mI8Nt6TWUu2ehB44KrLt+o5cVZ?=
 =?us-ascii?Q?sT5uqisJGN+Ya+IWAcKHup8tpEIHZreUUTXW4ombP/0b7BB6SPKHUP4PcrWy?=
 =?us-ascii?Q?3vqHNQd5Pj+ojEm7QwsQwgd2ao9V3S9vaD7xJy0tEu9IMIbonrzddA/gA4HD?=
 =?us-ascii?Q?u1l6QmYFYqsQWUqyw8U5CFstdLW8rzigfnfvKXfzTdUKc9TXugAMsNa6BGLo?=
 =?us-ascii?Q?4qSagtxxblBa7xW8Ec/5c65FK7U5jj2M5yB9YweO6BvSVXMBKPp9cnoMDYh+?=
 =?us-ascii?Q?NpHsd8YrMi9GIhE85+CgQQn8wOxeBSCntW1x3xVxbycGTS41rC4xCiHhUTrb?=
 =?us-ascii?Q?Hn8627NSXt7BnZDTmYMOlLiaQ8HSqN5MOP1UbMsbKjkEXnh+WttQv/mkrwY9?=
 =?us-ascii?Q?XoBMs7Y+SiTqlGwVusVmqFDXlVREtcpEfCAVaTi+qzREwN5FjGBNfFHcLFW+?=
 =?us-ascii?Q?pL9oZRXfK6aiDnKTtwEKdaRfBfvdd9+cP4pvfQXH8u7vEk4BI8SjdCoKO0Rn?=
 =?us-ascii?Q?Fhm+Lg/PnoRZxgmwCCuprwjQp6XQzL7N7SLCsYF9jn0v0fy9WTs1VWy/dPaB?=
 =?us-ascii?Q?ddrHc0WB5PA2JV38p63Mkpl3rcM/k+MuSjDhMKftAljkQMnfIa87/oLmXOo0?=
 =?us-ascii?Q?PnvIQhiG2qsCcUgMp1c4i2cwff5rr8O+SIbrdWfM8lX7ZhhbRnClPK8McH2l?=
 =?us-ascii?Q?lpr7T/rez/klGY5lwiYtvCU1kNwsbLyDSv1fqGtTF9pbyMc//ZQp3ia1FpzH?=
 =?us-ascii?Q?VQjboqdZ5gvBhNV1kW7qu7ycFbbA3XUxE5NyIBix0F3WFf+t0nNeHS12FJaj?=
 =?us-ascii?Q?fquPQii+USzr6SxQSXpjjWdUE5gJibej0iYYgfKjF3ymWUWwtoVr6TjMJT3m?=
 =?us-ascii?Q?0GrkWGrG8P8u/LRqiECq4SyLoxRwkhl1mmvMHxLNcZb89HWksafmvr+ShrSD?=
 =?us-ascii?Q?lz493kVQppdVBIQEg1UXvsiwpZCpC2eVlMiW21zNBOiA3S3/GWYiFAk55emD?=
 =?us-ascii?Q?/hpCcUphvsVKIcu7VNAN4G09TyJo1/0YMg1A5NRMngQy+OMuAlZSfR9HQlQp?=
 =?us-ascii?Q?oLQK+mJY9p+Mv6bpKUp56emOsuWvRVchGcLQHByZpGxPIPJqciUtagpbkaj+?=
 =?us-ascii?Q?BCLX50UO9i44ll79ZCMhTVaQlPp9cMACtilUHpa9NH0/RXy4Y/S6TjvNEpar?=
 =?us-ascii?Q?FQoqe0KnzyYTD1gJCISwrAC462vF+01TXG1dPDIHDFyj0RQ0nyRyEkoPO2QE?=
 =?us-ascii?Q?uI9dRWuAbYEWvZ3/5rbX1YXwAixTJ0mKJ21rqCajCqI16i6hIPF7V+HUNuIm?=
 =?us-ascii?Q?+eY+yvMJV+9FRzn36jxLuW5LLSWgkunX7NAzx6GDOR/9SYmnp3y68ao6/rAL?=
 =?us-ascii?Q?8t4Ie4MppsfGl3b9ak9otsMC+YrbJwi7jzwIEgZUdUgCyiRMcCJjG3PmzmE7?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3187c8-b094-4984-50be-08dcf4c41e92
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 07:10:34.7399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+ey6X30OmYWtNvoY6h2nZ5NCQ42FoTOv7B5/wq9+SJOSIUqet7U14k6KQjGMx9PJLX/iHB5HHFyiunQpns8y2eDT+OCMQEnjqeCTJY7dVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6516
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

On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:

> On 10/24/24 2:27 PM, Rasmus Villemoes wrote:
>> Loading flash.bin using uuu fails when flash.bin does not have the
>> right size.
>> When flash.bin is loaded from some storage medium (sd card/emmc),
>> SPL
>> just loads some random garbage bytes from beyond what has been
>> populated when flash.bin was written, but when loaded via uuu, SPL
>> hangs waiting for the host to send the expected number of bytes. Which
>> is (size of FIT image aligned to 0x1000)+CONFIG_CSF_SIZE. The
>> alignment to 0x1000 is already done and is necessary in all cases
>> because that's the exact expected location of the 32 byte IVT
>> header. But the IVT+CSF blob tacked onto the end must be a total of
>> CONFIG_CSF_SIZE.
>> This is exactly the same fix as 89f19f45d650, except that this time
>> around I don't know how to cleanly get CONFIG_CSF_SIZE.
>> Fixes: bc6beae7c55f (binman: Add nxp_imx8mcst etype for i.MX8M
>> flash.bin signing)
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>> ---
>> Heiko, can you check if this works for you?
>> And if somebody wants to pick this up and knows how to get at
>> CONFIG_
>> values, feel free to fix up and take authorship. But perhaps it's not
>> really configurable at all; imx8mimage.c has the value 0x2000
>> hard-coded, so I don't think anything good could ever come from
>> modifying CONFIG_CSF_SIZE. If so, the right fix is probably just to
>> make that knob non-settable.
>>   tools/binman/etype/nxp_imx8mcst.py | 2 ++
>>   1 file changed, 2 insertions(+)
>> diff --git a/tools/binman/etype/nxp_imx8mcst.py
>> b/tools/binman/etype/nxp_imx8mcst.py
>> index 8221517b0c4..9a1974cc522 100644
>> --- a/tools/binman/etype/nxp_imx8mcst.py
>> +++ b/tools/binman/etype/nxp_imx8mcst.py
>> @@ -137,6 +137,8 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>>           args = ['-i', cfg_fname, '-o', output_fname]
>>           if self.cst.run_cmd(*args) is not None:
>>               outdata = tools.read_file(output_fname)
>> +            # fixme: 0x2000 should be CONFIG_CSF_SIZE
>> +            outdata += tools.get_bytes(0, 0x2000 - 0x20 - len(outdata))
>>               return data + outdata
>>           else:
>>               # Bintool is missing; just use the input data as the output
>
> I have to admit, I never really figured out this binman stuff, but
> shouldn't the fix be also in tools/binman/etype/nxp_imx8mimage.py ?

No, why? That logic is all about generating the imx-specific header in
front of SPL.bin, there's no CSF being generated. Or maybe mkimage tacks
on some dummy bytes, but then that's explicitly ignored by the signing
step, I think that's what the

            signbase -= 0x40
            signsize = struct.unpack('<I', data[24:28])[0] - signbase
            # Remove mkimage generated padding from the end of data
            data = data[:signsize]

is about, so the signing step generates a new IVT and a new (real) CSF
for the SPL. And none of that matters for the size of the final
flash.bin, because the FIT image is located far ahead at a fixed 0x58000
position.

> And ... shouldn't it somehow use SetImagePos() ?

Again, why? I'm padding a blob (in this case the CSF data) to a required
size before tacking it on. Exactly as the existing code does

            # Align fitImage to 4k
            signsize = tools.align(len(data), 0x1000)
            data += tools.get_bytes(0, signsize - len(data))

before writing out the (padded FIT image + 32 byte IVT) for cst to chew
on and generate the CSF data.

This is all about ensuring that the FIT+IVT+CSF blob has (exactly) the size
computed by board_spl_fit_size_align, which is

        size = ALIGN(size, 0x1000);
        size += CONFIG_CSF_SIZE;

The 0x1000 part is done in the existing code, I'm just making sure that
the data we append after that is exactly CONFIG_CSF_SIZE. The CSF blob
itself is what is originally in outdata, and because the IVT must be
included in the data which is signed, the IVT has already been appended
after the 0x1000 padded FIT image; that's why the computation of the
extra bytes ends up being a little complicated. [If we just appended a
full CONFIG_CSF_SIZE bytes, the board would boot, but then uuu would be
hanging while waiting to deliver the remaining part of the file, so the
size should match exactly.]

I also don't grok the binman stuff, but there's really no separate image
to set a "position" for, the csf blob (or ivt+csf blob) is not
represented as its own image in the binman description.

Rasmus
