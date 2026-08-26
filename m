Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3141C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 14:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 873FC80AE3;
	Wed, 26 Aug 2026 14:00:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ScjzLbghO0A; Wed, 26 Aug 2026 14:00:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787752849;
	bh=orwbpiqthwFKMWOLxWiw+jNtEWmX6hWNN8iKDEsAzbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fAgyoaDT0kSfgtdNB2GrnqnwR6yIommZNCDJTKtbnUEsSPdwjU3gcE7PEXnm7uArC
	 mCoVVT7ZUSPxhyFrGi10HMG/yq8gwjCzwKIraikqJ0B+6qCa+m/rqCe5B5EmOWjerp
	 SoosufQkRHpxfr8MuQxL8Po4AKUIISz2F+yDuc55XBniMFo1UfkuvWSXg2hKE59ik9
	 sRMB5F7FCY/jF0xI0OpX8M7od30ZC7UJmt1cAmRJJv0ih5RrNil4sffBpAXBqEWzu2
	 uWyF+QQ/hsbzbqHHYjt13uRpa7QX6PY2wb9oROmgBAlO35XUABbX1t4eK32YAyXr1O
	 8RdiG6FJI3cog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF043809E7;
	Wed, 26 Aug 2026 14:00:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 99379396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F1AC40512
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GTh33hSl_pnK for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 14:00:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FRj91bfV
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B358140532
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:00:46 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66c7127a73dso1329819d50.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787752845; cv=none;
 d=google.com; s=arc-20260327;
 b=cpvtw8aQl6MjVv6lkBn/1/0RFMWEgwOXR+G33svYaGobkbSgm6NXOdF5sPszFimOAA
 fJzv3jq+PpM2hNO8nXxsB3WDdpHUjCmJ2B8qthaRIKXAf496CDn2yPxQ4jNgki1oGFwG
 mpnjzzrrqHMS1lAoxVZP4ACHEy34ZEKO3ZSnwUxowb1lKPJ0xXX0vYxge/rvNzn5Sgx/
 VkmuHBkJo3k1rM/HbdWYBzL2ziAixpDK1gyo90pq8RUYqNvatYKeEbvhCRcX/NIvzUmm
 esqXYAkMqOLEtu67I3EAkqwQhJEbQrMvlfffnxqVa4UcAyYNAZ/wIBQBn6JsHK6rEaEi
 mm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=orwbpiqthwFKMWOLxWiw+jNtEWmX6hWNN8iKDEsAzbY=;
 fh=3ud2E9D69tjVAySKG83SrK48vAZRyH9ejBQxVTxKn1g=;
 b=fZt8bxLzuMXDdQgF57q5rWiIk4w/tkDyrpbkuIoWhiS0cd+IoZWZCxRMp+u0GVQs7X
 2JnzheL3uGrd0awbJx1dz/Q6MbgtUqUBW00vG130OjeqLi5x8TO+nz2WAD8kPz7zLwxT
 VWLR7hSGwdxK47NL/A/K8x/DBY3YHqbnpNwPdoLogy05GTUyj8X+RaQ6wNLxrBjoQjlL
 TyjADj3tEZTJNSwH9avYWV/964sSoXJdGuVMCV5TuLTxAhSokQitvjTCHExrvlXz60vt
 zJ0YkwMAubgq3a3x96SOM2y7JbFfPfq4L4Mb1C0Ki9JzAwbvPadJsB2Bmq15FjILwVZ7
 nV7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787752845; x=1788357645;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=orwbpiqthwFKMWOLxWiw+jNtEWmX6hWNN8iKDEsAzbY=;
 b=FRj91bfV4FTCS6F7QKVJuWpY6otmWTRfu/luBRMllrZH44WcJTnvC2BU/Jb3esMH6s
 nQ/Ezxidwe0ah0SO2NDeiiqJXmFIQaunzBO5PpkTuK5DlzoknZfYAXd9VDNIO1SoibeG
 PJy/eqz2h87xDc17CzcRgvnOmhMTdRV7I5GMRxBnB5xiQIlPQggk2Vrwk9vAGMnXBubH
 J0q5TsFZ1N1xiqv4JArqB3Xw2jNqyMhi1PPFyEOK24QRYvyo1uN5+N+lVNmuEJp2aPLj
 ebAWyMikV7z0o8cAPDbdz6gudIvz9Z+5LRTa2+0CALq8kUvWg3N4OOi+I628D62ejOzd
 LVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787752845; x=1788357645;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=orwbpiqthwFKMWOLxWiw+jNtEWmX6hWNN8iKDEsAzbY=;
 b=LFBdTKDYqByz+agkVu6QpETdaWiIW6Qkfx8aIeOtpW9ND71ESsud/7leADYOJOnAFH
 uOqgikBnARqw6JM7Inu1jHOgXAbs/QLpzA5WIoyi019b4FssPnfhDXYnUaTTkLqqxIuQ
 zTY6kDYDxU2Kxnudtja3x/qRd9Fc9idSYJ3eB02t8fz5sAGCNuCj3GQo2tM/SFgxUgDV
 ihPQNTs32V4Kk9O5CuWlulGF2dTIz5E9vn+7UavcdHPYw00VymTRzR91MNpP5S9Kr53y
 2n/ZOXNEkpUsK1XSFb5P5g+6UTXt4tjDnUbViGPXgcg+CgbpAyYKnppssHDH+Vikw0p/
 H4IA==
X-Gm-Message-State: AFuF++kzOFdFJruWbx81Cwt9xwPAfMUrT8cZ2YVM/aF2qLtSeCPE5N4i
 F7O21Qdkv8rDmFAmoDAtg7AOK1uS1fG4QIZc5XGrEQZeK5Is99JtGsGaXMa8LgBPGBZIPkqR11j
 hPV+EqRCsJ+aiU61JAR0UJ5UdvU+kOpOn0bbYCj67RQ==
X-Gm-Gg: AR+sD10YMx4pWoVam4lDoNSrkdAOg76Xf+MMYBYCQ8U9/bv6EU1Zso8UXkv0Igb2ncs
 bLvF5SfJnHZthhyWTaQfPW+DFTD5neYsnhzClZ8NdLT4Sz4uJ/8v7VoN6DVXt/YYUtdlumu407M
 q0DTVjVhcFbtqUyZaT2j841IC9E3runwxwTzE90mKWBS14Acp34omfMc6a3CmY8fGvBFYByjJto
 B8AuSTl/CVv7Hbxp/w6KcmtY9oyVseIwGK+RCUwIc1Jq4iAF8y0S2FbCQ8mjYDhYHZe5gIMXzJx
 NrsR3HJpZ+gF/HVBjrS82VUKbR721pyIEX9wHtGVcGd4XBkDWrjwUgAT28a0p1sl1j7o1USzUGE
 4vnMnmP7HOmdTvtwEvP9JXjTHnS97Jgobm/FZgsvp7bcR3q+nJUoQLT7TjtviRUhZ9SF4yNCe4t
 d6eu9zEBQRZjWB7yTJnCGkY7Gpe8FdD+JKcWhndc7mxRMa9Ufdurm/FB05H88/OC9n+LF1lvmh7
 aipCePIK2cXS6Sb+SU/N4GhyjiX/Fj4Ozk+xcd3N/ouhSPPLzzRv6WxWFdwGDKQXNIViG3JYS4q
 LLLb4vfU2rt+F5k+19zWWrkdJF3WhBTDhoMi212xm9D45J7oIs+VcFQWlDy23fD4+B0vddZj/RV
 miOwDuh/kdi6/KGQyg/opQG6R4PhTkWhGhAM3ASfcl9I=
X-Received: by 2002:a05:690e:4458:b0:66d:1c44:a10f with SMTP id
 956f58d0204a3-66d2565ab6amr1878726d50.8.1787752844050; Wed, 26 Aug 2026
 07:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
In-Reply-To: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Aug 2026 17:00:07 +0300
X-Gm-Features: AcwNN1XWPJgYdhDleZqmZGu9xxo_QkrOSGDzcqt6a8ZoUPL6_fId3ofOzC9y3-M
Message-ID: <CAC_iWjJ3mB19pF=yH6U3TX7yzVPS=h8NjdPUV-i_M6tf2ShPhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] board: amd: versal2: move platform_id/platform_version
 to .data
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 26 Aug 2026 at 15:05, Michal Simek <michal.simek@amd.com> wrote:
>
> platform_id and platform_version are plain uninitialized statics,
> placing them in .bss. U-Boot's linker script overlays .bss at the
> same address as .rela.dyn (the relocation table), which is safe only
> if nothing writes to .bss before relocation completes.

Yes and we also need something the documentation explaining that since
it's hard to debug

>
> soc_detection() writes these variables during early board_init_f(),
> well before relocation, corrupting live .rela.dyn entries. When
> relocate_code() later reads the corrupted entry, it writes to an
> invalid, unaligned address. QEMU 8.x tolerated this silently, QEMU
> 10.x enforces alignment checks and traps it, causing U-Boot to hang
> right after printing "DRAM:  2 GiB", never reaching the console
> prompt.
>
> Move both variables to .data via __section(".data") so they no longer
> share an address with the relocation table.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Fixes: 40f5046c221a ("arm64: versal2: Add support for AMD Versal Gen 2")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  arch/arm/mach-versal2/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
> index d72f66f4fbac..19baa1331bdd 100644
> --- a/arch/arm/mach-versal2/cpu.c
> +++ b/arch/arm/mach-versal2/cpu.c
> @@ -241,7 +241,8 @@ void versal2_timer_setup(void)
>         debug("timer 0x%llx\n", get_ticks());
>  }
>
> -static u32 platform_id, platform_version;
> +static u32 platform_id __section(".data");
> +static u32 platform_version __section(".data");
>
>  char *soc_name_decode(void)
>  {
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> branch: xnext/data_section
>
> --
> 2.43.0
>
