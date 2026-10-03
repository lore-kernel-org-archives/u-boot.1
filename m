Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0239CA5FE3
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 08:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BC3781183;
	Sat,  3 Oct 2026 08:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quiyM_XnNgbg; Sat,  3 Oct 2026 08:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D622811FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791014717;
	b=TLVtHobtzgUdM+tnaEkcEqWKAj4YLeX/g2TQLFau75lE7V1ieQ2ja8B17m3LRfeuNHBJ
	 gsf+w1+W+xnNZJ/zk1+zMtefUSSxgXivdHgZxmsdzDwO5nmN88CmO7qBTIg3atDeC+iHQ
	 ZYseDkejqN1/sBMX8lG3oK3iom0sZXSKAN1Y3XnpusHpKdd6ApZ7ePvLQuc+uAqxA+zJg
	 aiiSm7S8vF8rOPy3eqDmn0reMITyaGmKSgwZ0yahKwM5dv03EX4odvlvfe5i6uvF1I7QV
	 LI9ssCS4Zark55IjCEAgX7pG12Kp3qzwCuv++hESNav9aT4Mr+fK0d4fQGVTV1sDKnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791014717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sKG6aRxyhxjAv40swIFQKri6qqUMsTOZSkWuwwzsIyg=;
	b=cJ1e+l2vE8WL6l0xXNwh8UEy7ceWEePy+5gc+3zU/tEKHcMO8mpBk004YZW7HNMRPiFi
	 jA0I58w8ihfzwIcvn+OBo7FC5RqD3Qsbb5Ky7GxvUEGyc+ZoQuyLmGhKL2XsdpshlZVKG
	 sVWDauqJlEc0sJD+o2FS86g0mU7qbTo53PFke3rQ7d/i2yCF0EJ0AuHo4JNSZjEnpxu6b
	 t0n6gesnVlfV5wajTU7Xb2d4tGnPVQUpnFB7yKHNX0d+k9Ve8ZO3OrCjoDYLh3H6foBq1
	 WuNKCYVRlaWSgmpe2xibCcOqWje8xYPnCCi4lxAdvItyoz/BdICQp0cK0mT5WR28cww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=GR2lHgEQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791014717;
	bh=sKG6aRxyhxjAv40swIFQKri6qqUMsTOZSkWuwwzsIyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B735E7GUjNe7/5CwZPQuGANffO4PDHX+Oz7WO0j/gKIoQTtb8Gz7PLiQ2YvAkshEM
	 UBzUWpcY7bMMaB0af+8w84VuIi9CgNVeIQW8+a9+fesCkrbG6mer5LL4ywZhzOurwC
	 q/xsWn0Q18HPjuYJQY1YysElrHuQQ3qjidOqpAnQL2B7yf2Gf/Jc2PaXFAtjOOPvV9
	 aVrsrSPdyNQONm+CY0vJ/YcDt5kyKFsaKGr7hysBLCfKy1PDg1DRBGi3xfLItodYjm
	 ICW4Mj7S1/B6KOwXTVBpq4sjlqq+PzD6lrcQ7U6YRQ94uF1oOhUz9SJAC6dDpKezP5
	 3Z7GwV1en9SOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D622811FD;
	Sat,  3 Oct 2026 08:05:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DA1F34E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 08:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43A04811DA
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 08:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mh2sf-yFwYOR for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 08:05:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 583BE81183
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791014715;
 b=ME0sSIzgaN0HUNfg/dpEko6QJIzXI/cdqh0hl2PnMfLwasGrvmdPYc/S2XczG9+f5Ya9
 8P7Dosk58qmS3dXDehm3F4cTUxQlfSIwtYS17fhX5w8TOBbFD9IUti+opTGZEvF10Csee
 WuujTSNevJUGZGryo169zxe/QZQdkKZI2O9gUBcgmuITNuBugo8YvoRqpM6VNw3NT8HT/
 OS2MkcKUk00Fc+t/LMterm0xhHBbwixtbIuM0lK62XR9PHqbiRsHxXITKcGOFquDEx1O8
 a7WV+oIGvHrGv2ZW+QRh1kJiydqD8nLGOCW3jP/25IPfb5yOADw3EGUF0qcz1DPODVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791014715;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=sKG6aRxyhxjAv40swIFQKri6qqUMsTOZSkWuwwzsIyg=;
 b=ivSyRjLyAcF6p3GrEBt2vbEN+/HRWjYrVAGeyKA57Cxc/4ic9NoFKAqjclC28ZWCM6h6
 3aGbbhJbsN1Ill6g20Cpw6TZA1uYsIBghv7h0i1bi+ce/mLkDPaayoYcHy9jGmHikF7Yo
 smbO7J6VEVb3duVleJPv/RyPpPO0VKdWO6pr6oW6BSUqYqfw0+TIVK0VqWD/aRtMnxQbM
 jKTRUW2n8OLX2WxXy3e5fWgmoPuzHOX08lksPVD+jJ/46VX+Guid2w7RHCCHT1cwbv4Tq
 hGR6/JBAWcBpaFd1bxKtkveoOhaNvegq54ESKXT2Aj+KYdKzNmj32Bnb2mcuoo+wUew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=GR2lHgEQ; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=GR2lHgEQ
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 583BE81183
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791014680;
 bh=sKG6aRxyhxjAv40swIFQKri6qqUMsTOZSkWuwwzsIyg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GR2lHgEQiNDzsnekSMk6Ba7siwcIYpBimKaSDfKbx9guU/QczSHF902Bmz6EOA969
 e5SuLhXxe4/a6IfY68tJf3719h5vteYyRYs7hFZzjNIpsZvLZjy5OFjC5qHnJZjJ5l
 J21atc8dDF+lz6fl1perpnCiDR8DboyVRNp9RBkiRXXp9auNkveda7M2na6h+BsJf6
 ch0TxOYXs7k+XDxuFughE4UP0CUymweW67x8LTMjHhutDiwgSpTWMYCDVWzcs6ua9l
 BQmAdUbtLEtw9xjICG38lDFR9e4cBHatfbxijoIaiKZiOWQu6S8qF/tKf9zMsDl8Rk
 k5kv20Pcs03tg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 97CFAB2220EF;
 Sat,  3 Oct 2026 10:04:38 +0200 (CEST)
Message-ID: <24b5e145-6a15-4caa-9ab8-4df9ad8a3f52@freeshell.de>
Date: Sat, 3 Oct 2026 01:04:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] configs: spacemit: Add K3 default configuration
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
 <20261003-00-basic-spacemit-k3-v3-3-dea68cd1bd7d@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261003-00-basic-spacemit-k3-v3-3-dea68cd1bd7d@kernel.org>
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

On 10/2/26 17:34, Yixun Lan wrote:
> Add the default configuration for SpacemiT K3 boards, using the
> Pico-ITX device tree as the default.
> 
> Configure U-Boot to run in RISC-V supervisor mode and enable the
> platform clock, reset, GPIO, pinctrl, I2C, PMIC and regulator drivers.
> Also configure the memory layout, debug UART and basic filesystem
> commands required to boot on the platform.
> 
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

Looks good to me for initial support. The interaction of first 32MiB
range following 0x102000000 with vendor embedded controller firmware or
vendor opensbi or vendor u-boot SPL or possibly mainline opensbi is
something I don't understand properly, yet it does not prevent mainline
u-boot main payload hush shell operation. Attempting to have an answer
for all the moving parts of vendor firmware is too complex to expect for
the initial series, this is okay as-is.

Reviewed-by: E Shattow <e@freeshell.de>
