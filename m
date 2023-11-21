Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D48C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE3787169;
	Tue, 21 Nov 2023 21:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qGQggzs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9B58759C; Tue, 21 Nov 2023 21:48:03 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D9F87169
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c83d37a492so75119141fa.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700599679; x=1701204479; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rj1d4G9+vLBCMes76VCqynXi0UqN+mP0wv7vj3HrfYE=;
 b=qGQggzs0Rpwl5+hm/K1eEKopNCJudxUQvREBo8tQ07jBilozCILLxdcWr7sqRyt8H4
 I5Jb6TLGeXSYnowuvtuy2UOFzfqjWOmpqVmhx99zBGQF5uDdpujTwa2SW4s5hxk2iVsU
 vDqwze9Orr4cU5QiP/GMLgr6C3yjnG/ThtQZZHw18PBMdDp8EN9Dbt/vAvrQWCVuNFIz
 d5DsjMwoGSSAfSV3d7ywXcpKV1Y5Ddg/QHcVkxpcEsc+5+3zNFAnO8Tj3/pqYMU89wJ7
 5jBefLyO8vASo9s9cuPhRQyi/zHxyYYD2Xk9LJ6LA9gzB+NqwwYyctHr7UtVaPfA5OZ7
 0FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700599679; x=1701204479;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rj1d4G9+vLBCMes76VCqynXi0UqN+mP0wv7vj3HrfYE=;
 b=ewyMmzSWBAjzYHaIaQgbzm5y9weZJWYfScvsIZRBsMhQ7TkbpxWcanzIZ3y88G76AG
 Jf9N0110/3ojp0U8kuUPiEONanU7xzYjHBY/+MwLrYzxnz6gknTCjyk1qJp7LLq5GH0e
 jB9y/oKSCLgpraw3pDT2vmXJjjjzrbzM/LlQOtMoM4FAD0P9lz5qEQvvr5k7GD1ogLK5
 7EXgZ3DHBWbuzjIX7ETeOz6rGM93onFSsU7qln6uGTfLfPDSJWn5bQGqW1f71pkc4bMM
 EfXFfv7tj8THeFxiHNyArpB2lguyOR/p29Nv8+YsEL2gzPT4M7awxuADmb2hdOqRXV1r
 rtXg==
X-Gm-Message-State: AOJu0Yw34qZ5LprZxxpsAFtinWx6Wq6LWoShTHXPoPCStNfD57QngR14
 cXD9tbsjhwHY5cP2Mz9/QCF49A==
X-Google-Smtp-Source: AGHT+IGVqmyJrWmDK0+iNNnjrNI6S4HYIysUcRKnJZgAFjierJ5lNMtm5k2CY9lm6J9/K4w7q+20Rw==
X-Received: by 2002:a2e:7405:0:b0:2c5:1a89:41c0 with SMTP id
 p5-20020a2e7405000000b002c51a8941c0mr209882ljc.23.1700599679102; 
 Tue, 21 Nov 2023 12:47:59 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 ay36-20020a05600c1e2400b0040b2ad85784sm2880931wmb.3.2023.11.21.12.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 12:47:58 -0800 (PST)
Message-ID: <f00fd401-6fc1-4d60-a4e1-f8d7f0e0da72@linaro.org>
Date: Tue, 21 Nov 2023 20:47:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/21] mach-snapdragon: dynamic load addresses
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-14-9492198e0c15@linaro.org>
 <20231121192442.GF2513409@bill-the-cat>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231121192442.GF2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 21/11/2023 19:24, Tom Rini wrote:
> On Tue, Nov 21, 2023 at 05:09:37PM +0000, Caleb Connolly wrote:
> 
>> Heavily inspired by Apple board code. Use the LMB allocator to configure
>> load addresses at runtime, and implement a lookup table for selecting a
>> devicetree.
>>
>> As some Qualcomm RBx boards have different RAM capacities and base
>> addresses, it isn't possible to hardcode these regions.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> [snip]
>> +#define KERNEL_COMP_SIZE	SZ_32M
>> +#define SZ_96M			(SZ_64M + SZ_32M)
>> +
>> +#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
>> +
>> +/* Stolen from arch/arm/mach-apple/board.c */
>> +int board_late_init(void)
>> +{
>> +	struct lmb lmb;
>> +	u32 status = 0;
>> +
>> +	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
>> +
>> +	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
>> +	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_96M));
>> +	status |= env_set_hex("loadaddr", addr_alloc(&lmb, SZ_64M));
>> +	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
>> +	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_96M));
>> +	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
>> +	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
>> +	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
>> +	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
> 
> First, with 1G total, we should I think be fine using SZ_128M and not
> needing to add SZ_96M. Second, having worked on
> https://patchwork.ozlabs.org/project/uboot/patch/20231119144338.630138-2-sjg@chromium.org/
> a bit I think your sizes are a bit funny. We're looking at where to
> decompress the provided Image file to and so 32M is too small. My
> generic v6.6 Image is 40MB. One of those "would be nice" things to see
> now that I've kicked things around a little was if all of our boot$foo
> decompression logic just asked the lmb to give us a new region of
> max-feasible-size for a Linux kernel (or we make it a choice between 64
> or 128MB max supported kernel image). And further looking at the code
> and matching it up with the function docs, it's even funkier than I had
> thought, sigh.

To your first point, yeah it looks like I can get away with 128M
uncompressed, it definitely feels a bit safer heh

To be honest, most of my testing has been booting via bootflow/bootefi
-> systemd-boot which I assume will be using the EFI allocator to load
everything. I still have a lot of local patches to push upstream,
otherwise I'd definitely be interested in finding a cleaner / more
generic solution here.
> 
> And to try and be clear, the second is an ask, but the first is a change
> request, those sizes are too small and inconsistent with supporting a
> large uncompressed kernel.
> 

-- 
// Caleb (they/them)
