Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981BDC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15C9280BFB;
	Mon, 24 Aug 2026 13:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Y2XIB5rALEV; Mon, 24 Aug 2026 13:46:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787579197;
	bh=Tw+VpWSdtJsZRYWZLgsKrfAtjiUuiTlgFiezbyD4hbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MyqNPErJRd9FFUaPBGAcJxYD6pRW9XuwkKZsylONYdl2HXb7ZRg3jPGaDMSPz9nBQ
	 IV+xoJC5cMN3tO6h6+4OhbCkm55ZRDp5Vr9vn2YaPYcwHj8GUm/AwLh1rgkrnR3/Kl
	 1XXVlvtRtH8RZzACobYZsGB8md5S8zlwgvYyajVTuepNIcxx40TbxFL+/Iae4w+EIt
	 6xqjPugUNMnXPIR31YqQZAiViW8s5E2+tlEs2tA9BKdjyoSz32ZXgySeHIYEhHF58x
	 qdqfkojKtwdoovJQcbDo4XGDVwzsTpl7VMhweze6Q6jns1uDrKXj8W0hPRZj7aiZbe
	 zjALOWLP/5CWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6D1180BB5;
	Mon, 24 Aug 2026 13:46:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FCF041A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9202A40050
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3y3-iL_E9QS for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:46:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tmDs/dRA
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DB4D40029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:46:32 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a157f90752so5894115a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787579191; x=1788183991;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tw+VpWSdtJsZRYWZLgsKrfAtjiUuiTlgFiezbyD4hbQ=;
 b=tmDs/dRABE60sCU2gy16RO54BEx4R4kDVd6aGdlLK+Snv/8CKZ9/QPZ/soVlsAKbKt
 8ggE3zFEAfXaXSqR8LTsEhrkoeEc+DI0UxFVr3RiLpSaTLf4hiAFZE+81ruUI9qPfcF2
 0cNiaQPV16SH1NyrlEDTnO0IUcHIpBho3ETXxEk9tSaZYVUUhPP3onqZlbrIid07QKme
 u8XEixEldsv7VXPesLvgyUxmhVBPyDeYdf0Sw24x5oA843LUHdsBxyQgz5F15Jt+1MOi
 gmYtc08zGG/6KiDAqHKDF4FJtGOse9LP0PsGiOZF/a0v/Njrz77pucBpcBPC3NhVpTsj
 O86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579191; x=1788183991;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tw+VpWSdtJsZRYWZLgsKrfAtjiUuiTlgFiezbyD4hbQ=;
 b=gtQkkepyTUaHrCky8gf+v+ML8zjjwVPnnOFTikjCSSM66Lo5EGxNC8Ie5WdmiZ3U7N
 a5GLZacQ1L2VC6dYh3E08SL0VET0ezoFzNQtOgRkdLVx/GWBLkgvDQUlRoKwvSWSTRzP
 kXjAzTQZGNZQfrWKK+PBCC+siPvGTagHjh4Xoievn2YQKE0rPrxVdl2+mjGYwF/KsKX2
 d/nM1PUnx2H/SOeuoQbIos+96FgvhID0bgrRJtH1CVBlYULnMA5FFxFwh5Z+OvYXFr7X
 35d0s+YLQX7KMH1CuvDyQ5s+JWMkY2MvnqivgXhpoX2nw3bdmNVQyxufTy/W3dbc6kbD
 MjmA==
X-Gm-Message-State: AFuF++kRswS97wQO30aBPimfiMHSGFjidSDeC7tLiFiy4MQWSuGuqXeP
 vcTQungon3RoTDMngU9F/dQjc27N3dnbzV2E1xMLFh2HRT/cO2blBRO7Ic+ZJo6RDN/Q0Qj/Wte
 PdC28hGg=
X-Gm-Gg: AR+sD11fsuVMLSlpsnXOVgIFds3dr9QLitSQn9UZ+lcgdkItxfaG2IPqyRwfh5N7SPO
 be5tpZCe/DEjlrMlFxW11UjASLl2lh9YeDHe5G8lilFGlUJu+xy6cAlPS7E0Ntsp67jX6nSfVHX
 +9x1wAE0iJC1m/v7ZG4ZjyVcAkoOjrefq2FuLSz9otB0pA1ZNdVoxDaDRNJAmRMc2uWG/FacK0a
 l8ZpfQPorD5jx9tZB6oIwCXamypdP9/j18skGFjuNm7urNrRyOKEe7MWrq+oxfTjg70wZEGFy0x
 zdRuV4KG4dGgBU0v1CZMnZupTai0VflQrRi/7nYaAlWfuMLwwZtq2hg5qs+9lk2eBZMLmU1U+V0
 MkduPqbI8p6h8iTg3lttiqjmOv1KlKZrqlId3bpXZ/lxPz0WdzyB3ii8YnTY0PLM3c2PfDEK9j+
 s9rFPPkWEOu2Zr7x6mKHUAKq8Np0L9s5B/mVNtpERINOxdRMyKUVg0i0HL/rsHUZhJ/SjCBOk=
X-Received: by 2002:a05:6402:24c8:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a42f172088mr22405992a12.5.1787579190873; 
 Mon, 24 Aug 2026 06:46:30 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:8b5e:6b33:b439:3e9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2da49bsm9876871a12.29.2026.08.24.06.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:46:30 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:46:28 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v5 09/13] configs: stemmy: Boot EFI from external SD card
Message-ID: <aoxLNKEigLO5EyP5@linaro.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-9-07ca794e2b94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-ux500-external-sdcard-v5-9-07ca794e2b94@kernel.org>
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

On Sun, Aug 23, 2026 at 10:39:28PM +0200, Linus Walleij wrote:
> Replace the fastboot-only command with standard bootflow scanning and
> enable the EFI loader so the removable SD card can provide the default
> ARM EFI executable. Filesystem probing is handled by the standard boot
> framework and does not require the FAT command.
> Skip global boot methods so EFI variables cannot redirect the scan to
> the internal eMMC.
> 
> Disable mkeficapsule because generating capsule tools is unrelated to
> running EFI payloads and adds a host GnuTLS build dependency.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks!

> ---
>  configs/stemmy_defconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
> index 631ccababf1c..b1a14ab38210 100644
> --- a/configs/stemmy_defconfig
> +++ b/configs/stemmy_defconfig
> @@ -14,10 +14,10 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
>  CONFIG_DEFAULT_DEVICE_TREE="ste-ux500-samsung-stemmy"
>  CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_SYS_LOAD_ADDR=0x100000
> -# CONFIG_EFI_LOADER is not set
> +CONFIG_BOOTSTD_FULL=y
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="run fastbootcmd"
> +CONFIG_BOOTCOMMAND="bootflow scan -lbG"
>  CONFIG_SYS_CBSIZE=256
>  CONFIG_SYS_PBSIZE=276
>  CONFIG_SYS_CONSOLE_INFO_QUIET=y
> @@ -43,3 +43,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x685d
>  CONFIG_VIDEO=y
>  CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_VIDEO_MCDE_SIMPLE=y
> +# CONFIG_TOOLS_MKEFICAPSULE is not set
> 
> -- 
> 2.55.0
> 
