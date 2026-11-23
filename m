Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D37606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c7Pzvhr1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwslXICm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9B6B406E5;
	Mon, 23 Nov 2026 17:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kQadJi542DE0; Mon, 23 Nov 2026 17:41:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1C65406D6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795455674;
	b=cqiu8NkULpmwl9sX25JOWKEjClEnr4C04i+TgzsJTzv1PmyLdYBfamEs/6RpaDRz98nm
	 zdVyo7BckVYyIRwNrbFqrPMCpfr6P13wxWbrzDMe0wfBO21AKUifMoak0WWV+e0X692L0
	 sLglxmmPljAbSnJlQJBnQcTSS2rcgYsQKXQgP6hqGi+/uuCFK9XsTvlYl+M5HbU8E6hU1
	 Qwye7x4sHkJpFs1kdrtMIeAvpM2inO8HqMKct3lJtzGlp2GasL16gqCRVFwdjtqfkknnk
	 euwhEdT9hHZRPpdF6q7i/6rUZcwfd972ip30YqJhltUjQaM8zbKfC7idfSOPQzGT7Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795455674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bvwQhhHZYR+4MBMXGrjZFvNfOyWB7axEx23Uz7iaV6o=;
	b=oUrzpq95ewdXyTQjZRiMkk8XddeDUJSlDvqJb1MALBXu7xKM5xiuLVYJjfpnId4J0gLm
	 vEv/SUjUHIuM/HrZfDXvwmp64nz7H53EZen30a8senYkijE92fPUE4absUt/uadgErW5y
	 aJltnWaEAoNsV5PGof2YyKOeMmPOHXtD83arPmInrAi3hFfrPeqoOjmMbXLx12fVXzfih
	 v3OV/Mebm+HuGLOe8sSSNWEBCKmiHXBfugVd1AWHv+Zyt5NSw4K7siEHVC/MQA6A1nLn9
	 QauUCukNpmjJJqrqm3LxQMEsHL0DQCB6ra/wgBVtX3+8jLnXAN5TzWODzvYd86YAo0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795455674;
	bh=bvwQhhHZYR+4MBMXGrjZFvNfOyWB7axEx23Uz7iaV6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c7Pzvhr14q6zPHoV62Lgl9VCakSr9fX/mZSv8BjHg6g5RncCeAjAMgF5VlfD2rQHq
	 JvuKH75+XMhUYO6UL5ZT3ceFDHYC9/Y+6ZWTbtyQ3Dh6qqbBk8YA9rtr2S0/IAdav3
	 maUuLjTJfNoMLb1Df5IEUjQdlCHT83kwuKgUUdkdAsXvZfie5wAxNxXztGxC27fNyp
	 Yhj48A85Z5MQuJMo6IuB4wlg4fzCqrtGlxu0kt01NN0FRBAN5c764feiK3ODw2KTop
	 loaA+TWI7TRBN8aFWjk+9a0zmU88CX85hkZVU/A8YN5/tZdJ+j5cWWpkgIZLfP0vkJ
	 4gVgHE8dsAPVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1C65406D6;
	Mon, 23 Nov 2026 17:41:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C0F61759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A73AE400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u1ZmE32IsSDY for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 474BB40093
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=FwslXICm
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 474BB40093
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:41:09 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c515319dd89so408457066b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795455668; x=1796060468;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bvwQhhHZYR+4MBMXGrjZFvNfOyWB7axEx23Uz7iaV6o=;
 b=FwslXICmkMT8R8i5WYkD6GEEkHfsV2l2IHO1iT+oM+a3r8+EhI/ZM813lHO9Qqxll2
 pbhIcxlThARhGDdsQs7p5M4bYd0JZU7WztKB386Z/9ys5rAK2VwV3TAAbfzxmuYpQ/v5
 8ZlwGCiksVnzZD0i9KcyN636rm3Dwfea3O5SbCq2gQTiLCOfgUA2OlaH5wAph0Lw7GGe
 2FLk1u4Swg3RnVMNAcyhKU5xQ5GCnNoxWsfvbpJB/xJIzZfX4x0emCU79wVYoMi9hhXY
 CYwYNvMbwBbA/knibSz9YabqimtGavyp2MN6duhwlcgyz9I4aw25RiH3H8IakfH5xv4H
 Xktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455668; x=1796060468;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bvwQhhHZYR+4MBMXGrjZFvNfOyWB7axEx23Uz7iaV6o=;
 b=E1gjlvkLX8Bfg9lEcWI2LV8DtA8bwAmeMyULgSMxjsdNjbip6vUGjK0t6TpuWm37PI
 SyC7l1rduPKfr8LWZMzATjDJMO5vIhJMrmDo2EQtpYIQu9Opvk+FowXs0g7bmGOwYbC8
 mTQooRvVRA/jtFI7My5SsGXGwjJtB2DJPb0RWuWgVUtCMD64W5Tsu8ev3QMj5ZoULB2e
 jWmhkjTsCeRBTZXekmtHembydcY2I8lMe9RYTC3ThDV7RkUuQJ+RFbb4RBHlVTOOTsqY
 uyWD1CNGl15wLeP8n/IuvSchgsO2z1o1aMYqPawSkRytV/B5y08+NiUseEFPK+mPhHyh
 DqjA==
X-Gm-Message-State: APuU4Z+edwZbqko+iLmSnPowDenWSl+AFGBHb21/KpNVyqDKeyil9o7L
 BNkkSOAB7iBqcLrbK7Sa+LPSF3dUHuSBfpZABHAZTVJ/StHpM2wg4fqQrl51e8iVngQ9xsIbUEB
 WlxOoLPujgY6QGaS7BwSQykFyDA3s8/w=
X-Gm-Gg: AZFdTZfuNwursvdSIRltvI3+rkpYy8qpv3LGQCz29f6DterOYlwr6O7OtX/j832tSmd
 lNG9drbCTApr+2eykDS0XFfjO6+pTIauS0xde/TJegTkVM+lDqwF1iyJJXYeKncPFC9ZGRp40XM
 fSrvJ5U/I8j+DRxZAV5z+bUY/RXWJN9qfynbtECR4HBFRsDhysk5fgQoS1HAhxyrOyt4qkge0O7
 4b9S+rIs5E5m+19snF7ymQa7dqiDBtLTN6JrIGFVsY12ompvnRvNeMQ2uaPpf0ylTYgetUJDkpF
 /o86vc22ymI7BtowKF98ZQhZfGIOgiK1rcm+LB76sTytMrf8shDPx8hKK5MF64qNxl6TfuoKBf7
 C+uy52Sti6ammu2WrUsA+ZCBixx7fVc6XvAm9
X-Received: by 2002:a17:906:b752:b0:c2d:be57:f73a with SMTP id
 a640c23a62f3a-c513a84d122mr688866666b.13.1795455667970; Mon, 23 Nov 2026
 09:41:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
 <20261117-rk-doc-follow-up-v1-4-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-4-2cc0910f9455@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 18:40:56 +0100
X-Gm-Features: Aa3M54qbBE0iLW-7fxg8b0THHnjngPsY954S3bMCCG89wOnAqLue-53laHPRExk
Message-ID: <CAC928HbSw9STMdrJhJ8-OFLNwMZ+coi1TYQ1nrzU5TRqAUWsow@mail.gmail.com>
Subject: Re: [PATCH next 04/10] doc: qnap: reword instructions
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>,
 Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mar 17 nov 2026 alle ore 10:26 Quentin Schulz ha scritto:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The ddrbin_tool is only run on the DDR init blob so mentioning the
> "maskrom-downloader" is incorrect and misleading.
>
> "maskrom downloader" is incorrect as MaskROM is the mode in which
> BootROM puts the SoC when no storage media is found to be bootable.
> Technically, it should be "loader mode", but let's simplify by simply
> stating "bootloader".
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/board/qnap/ts433.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

As the original text was not really clear, I would suggest that we use this
opportunity to reword it a little bit more. My suggestions follow.

>
> diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
> index 446c8ec8f2a8..d9f8e049d491 100644
> --- a/doc/board/qnap/ts433.rst
> +++ b/doc/board/qnap/ts433.rst
> @@ -9,8 +9,8 @@ Preparing the serial
>  --------------------
>
>  Qnap devices run their serial console with a 115200 baudrate. As the
> -binary DDR-init and maskrom-downloader expect a 1500000 rate, it is
> -necessary to adapt the binaries if their output is needed.
> +binary DDR-init configures the serial to 1500000 bauds by default, it is
> +necessary to adapt the binary if its output is needed.

  +default Rockchip ddr-init binary (used as external TPL) configures the
  +serial to 1500000 baud, it is necessary to adapt this binary if its
  +output is needed.

>
>  This can be done with a binary provided in the rkbin repository.
>  First the ddrbin_param.txt in the rkbin repo needs to be modified:

  -This can be done with a binary provided in the rkbin repository.
  -First the ddrbin_param.txt in the rkbin repo needs to be modified:
  +This can be done with the ddrbin_tool provided by Rockchip in its
  +`rkbin repository <https://github.com/rockchip-linux/rkbin>`_. First,
  +the ddrbin_param.txt in the rkbin repo needs to be modified as follows:

> @@ -31,8 +31,8 @@ First the ddrbin_param.txt in the rkbin repo needs to be modified:
>       sr_idle=
>       pd_idle=
>
> -And after that the ddrbin_tool binary can be used to modify apply this
> -modification and also a new maskrom downloader can be build:
> +And after that the ddrbin_tool binary can be used to apply this
> +modification and also a new bootloader to upload in MaskROM mode can be built:

  +After that, run the ddrbin_tool to apply this modification to the ddr-init
  +binary. Once the ddr-init binary has been updated, the boot_merger tool can
  +be run to generate an updated loader too, to be used with MaskROM mode:

>
>  .. code-block:: bash
>

And also next one, otherwise citing two different ddr-bin binaries seems they
have differente meaning/usage:

@@ -46,7 +49,7 @@ Building U-Boot

     $ export CROSS_COMPILE=aarch64-linux-gnu-
     $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.34.elf
-    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1056MHz_v1.13.bin
+    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin
     $ make qnap-ts433-rk3568_defconfig
     $ make



>
> --
> 2.56.1
>
