Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0A7CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 09:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4402980C73;
	Wed,  7 Oct 2026 09:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7xoeJhXSpf7y; Wed,  7 Oct 2026 09:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1CD9880C98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791366777;
	b=mJg1rEaMLgvjGnnVqyCZbBQVZWboXfeC7vje7wJf+GBnW2HoXEDSHVqR7FTSLvm6tfmy
	 irkMa/ubA4F/Vn9E4Xlr173j0kmehGmqhfyIsRivbrqK+hcCUFYS9DIAugDxPUs1RpL4c
	 Ux5c6tyXQYBiFX1Y7Lgp7yottE1U+IMsS61l3O4ZzXPSqTLLeezl4H0nVIbKqf0tKlR2Q
	 wq8Fim3WyYKIOgEeQD4E7DL6l7i7FMhLquR5RXLYeHesDXR/IXbFUpJqQGoy7ORS5EVx7
	 YHe6pUFGziR7nV55b4MnXBdBYciWozbjaliIQUqheFhJcx+97Y7L4AGdaZGhGQXzH1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791366777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xllg9pbfBi4RWpuarWjnKYrrrU6T46b5oHPiyNqjtUM=;
	b=iO3VsedaJw4U6GDb+066oHxn240ilXZNozBqIsUYDJ8rRZCeUXGI1GAoIMtnEbvoE9Rx
	 Beq6YVpiLzHEltsVHNu60XVce6fJy0icD202FaK0A8U02hz6RXh3hPG6dDqNgVFy9TQCS
	 GrPpjutVLIDhg/g0Zr2we0I0tyr2IKpB5ueUZ0+wo5j6plIdj5jJuMjIGeC14+KLYxlG2
	 dwfA79JQ0qE/afm1AdyxCOummj8q7ptq6SlQV5ou0z0tKsrDRxSzsMf83m4RFa3NBmdMZ
	 +KRo5YSlGh6LF9Z4Uq1zsXpjaC9nKp//rm02QDVT8E8Z8DqpU7pJMziinA40YQcdXIA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791366777;
	bh=xllg9pbfBi4RWpuarWjnKYrrrU6T46b5oHPiyNqjtUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=smI0Fq3msAqTCgIdSs73lXepNw7FpLag1wZFpFd7MS/LTnFQsVuVtjiWCyDe8qqby
	 4K9YAWNUOWrH9WDV3CjsJ5POx6hEZ7c6fVZTLRe3oQnLa/jqNUjm/++Hp1AjM4t9nx
	 eH9RzM3xWEyOHNyUmuHckTzZRNqJ/JeMnvKOV6iT63I622ZXyZOUCnHELDmSCPfgt/
	 vIedAPstVLtbDUkqWM4hyGpoU2qFPT4s6a5bBW+YP6oUeOca9s1YFciqmYsYabugSt
	 Tx88N9ausbmFsnNHaTuwa+2wtx0vYpvk+MI+hLnnaxTAKEURm5trT7RBfXkHhfk1FD
	 bXCRRSRcxz3Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CD9880C98;
	Wed,  7 Oct 2026 09:52:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA30D22B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 907FF4069C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kz2KKyKwIfxx for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 09:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 904B140670
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791366736;
 b=nYUN4Y2Bf6A4tYB9r6IQ3gZCFLdn0UB4qArncLwAWuFPhy6aGDDL1liqL0uU/ygpolYK
 EJ0qEKzlPZoxRpMGtSsOdvu+rMrF9Wqxn9omVvZdWBHXOA+9uARI5XL5sKCGF9hmjpIS6
 BpLurcQ+zVSCxD8VJomAZTcBZwKJQd4mSnWV501ax9TARUyVIfqFaDraz+uOvj0mzRFL0
 D564a7JimWc8jvovvHefbXy7ZdXNNPgrKfvpKPxiMoumYaweftdXTewKLUTt15Z8y6MEp
 TrO4wYBDV6Ye9jYe/eenX0OmG4S+PYpPXs3RmUdALogjtvrkB3tB+keyMk4TrQNlTCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791366736;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=xllg9pbfBi4RWpuarWjnKYrrrU6T46b5oHPiyNqjtUM=;
 b=BnsMA8EVrvBPRY4v8Zf0rGRnYeWS0Mg1uI8W+3GagDAcOCVkfenSQ/wNfbXYqNJkVdwH
 pe3G7vLSwxAZh+sQUaamDgid4B3ODr1ghETet706H9yQCh2gz69bxOvs5dyo37TbMHtIo
 x0P4CXZpsarAXNKu5bjsYMa/zkT6OyZBm5oB0zfyja6dIuyQdwPN1/PXm21JXoBla28Yl
 /gUkGTw/3L4a3yLutrSvD+K2xj2FSD6UfzU6M5Id0NjRqWpSUKOOoXi/+bposg9Q6gmDl
 642r5ukjcPFJQlSpouY7sDIHwSZsfZUxIBFVXoNvQmc1FA5016b2GeGZfJyUq0O3/+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=VLZu9XcL; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=VLZu9XcL
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 904B140670
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791366705;
 bh=xllg9pbfBi4RWpuarWjnKYrrrU6T46b5oHPiyNqjtUM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VLZu9XcLOxH+FkFnOQeFvq6WpKo6prXyp/FbOURl9XYNpNZs2cxoyhyH4si7QHSmg
 q2rW6IOiYPMqYz3ZfuBq8MB/IVcoCnZwqalKFfZVDhJCcikzFuW3sVLzHXt69nBWPF
 Y56vJOLNxC7Aq4qjvgvfJovZRFP3xjJQ5edFMtTIkj60kn9hVylNh8mvXjBiQUQ+mt
 4LfAEG+nx9bdAa5x8Y8Tf4oOzCWxOiizyzvmbe/WIsoX8bNKMtwQZHkfENK7aomTTz
 6kDAdriFnXKSdN24r7MDYNqr4LH9KmT78QqShcpWBfHaLgLSA2dzFqiSqL73+J59Uj
 2ncPLMKq5jaMQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3DF2EB22001A;
 Wed,  7 Oct 2026 11:51:43 +0200 (CEST)
Message-ID: <8c5a2602-f68d-4104-81c6-0bf1418d7ec2@freeshell.de>
Date: Wed, 7 Oct 2026 02:51:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] configs: spacemit: Add K3 default configuration
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
 <20261007-00-basic-spacemit-k3-v4-3-c44d09937088@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-3-c44d09937088@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10/6/26 22:11, Yixun Lan wrote:
> Add the default configuration for SpacemiT K3 boards, using the
> Pico-ITX device tree as the default.
> 
> Configure U-Boot to run in RISC-V supervisor mode and enable the
> platform clock, reset, GPIO, pinctrl, I2C, PMIC and regulator drivers.
> Also configure the memory layout, debug UART and basic filesystem
> commands required to boot on the platform.
> 
> Reviewed-by: E Shattow <e@freeshell.de>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  configs/spacemit_k3_defconfig | 51 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
> new file mode 100644
> index 00000000000..a6d1f35a93e
> --- /dev/null
> +++ b/configs/spacemit_k3_defconfig
> @@ -0,0 +1,51 @@
> +CONFIG_RISCV=y
> +CONFIG_SYS_MALLOC_LEN=0x1000000
> +CONFIG_SYS_MALLOC_F_LEN=0x80000
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
> +CONFIG_SYS_BOOTM_LEN=0xa000000
> +CONFIG_SYS_LOAD_ADDR=0x102000000
> +CONFIG_DEBUG_UART_BASE=0xd4017000
> +CONFIG_DEBUG_UART_CLOCK=14700000
> +CONFIG_TARGET_SPACEMIT_K3=y
> +CONFIG_ARCH_RV64I=y
> +CONFIG_CMODEL_MEDANY=y
> +CONFIG_RISCV_SMODE=y
> +CONFIG_RISCV_ISA_ZICBOM=y
> +CONFIG_STACK_SIZE=0x100000
> +CONFIG_FIT=y
> +CONFIG_SUPPORT_RAW_INITRD=y
> +CONFIG_SYS_CBSIZE=256
> +CONFIG_SYS_PBSIZE=276
> +# CONFIG_BOARD_INIT is not set
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
> +CONFIG_SYSCON=y
> +CONFIG_CLK_SPACEMIT=y
> +CONFIG_CLK_SPACEMIT_K3=y
> +CONFIG_SPACEMIT_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_SPACEMIT_K1=y
> +CONFIG_MISC=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_SPACEMIT_K1=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_SPACEMIT_P1=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_SPACEMIT_P1=y
> +CONFIG_DEBUG_UART_NS16550=y
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_SYS_NS16550=y
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_TIMER_EARLY=y
> 

On condition of patch dependencies applied as outlined in the cover
letter to provide PINCTRL_SPACEMIT_K1 SPACEMIT_GPIO (implied
RESET_SPACEMIT_K3) CLK_SPACEMIT_K3 ; With that,

Reviewed-by: E Shattow <e@freeshell.de>
