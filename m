Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED08606A339
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=idV5UKZC;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j5hjPFN3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B173C80CB9;
	Wed, 25 Nov 2026 18:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2vEZnnTY9zG; Wed, 25 Nov 2026 18:12:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16E6580DF7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630368;
	b=av0C+IBlIrTh9Uo/ZAzMuiiKYpLrmEpghAtx0Tjacni6gipO+UN4xuwOfF6eSbys9vEX
	 uwTR8hdJC73gwSWICnV9Psor1KaQC7AK4H03fk8rJ+s2VgN1oNshbGNwzn0n71t0P4+SH
	 oEpkhrwuaiRoVw2Jd7ywnNyzp0rCoGuxxosRAvoludQEXps7ZM5NahXNsfGp4sIJiaocq
	 C/fe+672LDahfrce+7pRM3bafI//tvWq1zrq5XfWuH2REiaKY3Jr784bP2GlE9pc0P5Pu
	 dl2v1L6B+7ueQp75kx2T/KiXm4U+jb12L2cCWMRpyppobt3DT6MpBRnpPGjr7Rpl0eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2YKWEz0MAzHFVKMOl3XQ/Gzc08tRuYM+nHG8EOvJi+U=;
	b=KgtHwQe/dlBwgCRNyPp/4LtOJCIdOFG+wGrZjD3Qkd/3WHqqUOSZd6xVmelw+j6Su44m
	 qS5L37P0GHLotN4bonb83RzUXFj1vwsBCbPB28zHI8z3t/MVK8vB9+hudHK39HgKxQ767
	 ba8+9FolITecOWEWWG6BjN58ss2pr+XKGvINyoy1iQ5oqcRPGxkSzSGlpSQZtLcNTfjnG
	 uyo2zWG3OZwq7jwdQWRySO9DpwleGZ2Tz39UKcZaGV0DePpNUCmG37mxepsD07FW8fCmU
	 oazOgg1Eeg+Is7YWB6QCKdXgYyu03NeHHT7XsGd+0YRWavFnpSytgaF5VK1IHelDmEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630368;
	bh=2YKWEz0MAzHFVKMOl3XQ/Gzc08tRuYM+nHG8EOvJi+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=idV5UKZC8e4t8Hnw1khV0Z9JTv97xGtQ7YQA7o4X5g3EezSoQsjUB/AgbbpmofJ90
	 bToMjDKV7ykbpoWISbvC7II31KjyK6ZCeiIVNVnrSHMxtdtU8d8lULP/Zk1t9I22vK
	 BSI/lYaJjZNWGOSO2EOnVaVRoSOZrXE3hp6ugk3zUsQV4j+GogkGnVZuCn4dUxWZdM
	 pe9JVPSrnvZYlcIalihqd77ozSUPICq01MJEU37Ybvs0F4M28XTu3kpEQvwxXk0E0o
	 8460n08ceBvZuWsuEwMQZfcCjkJ4exm/YTqynb+2WJ2CugFqVzy8j1searb8RS3iE/
	 8/Hq5102ZGGzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16E6580DF7;
	Wed, 25 Nov 2026 18:12:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCFC543
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A34C6400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gHIw9ugrmX2J for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 18:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8E83240050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=j5hjPFN3
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E83240050
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:12:45 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3ae85add4ceso43327601fa.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795630363; x=1796235163;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2YKWEz0MAzHFVKMOl3XQ/Gzc08tRuYM+nHG8EOvJi+U=;
 b=j5hjPFN3SHGKv/dnOYYvfsO0kgAPUoKVpQj6WZkgzcjVbmiXWZPgbtEA/zhIVB/6a8
 Wf++b0sdEoYCsHzB0zZEDFSxNoqUj+NEa7BGM9jwt7cgVOxk2kHko8PxSX3NJ6XPnMYP
 NoaEttV+t799u/Qhsv8zAHI+vNO7kXA43bVAYPXhrPe4ah+f96LHXLBpkv/43AhAMWnB
 h+ojKioqLhw1PKVud6K8+cmT1HX+t7DanX0pHmd+RPlY4gubNeJb1284QRHWcM3FLhxE
 TfxQkyvpMCyl33/B6Z6+InRZGH5bbZo6kGDPpxLmCXUZw7Anq2RyLM6gBZ/N86F1bW3H
 ayrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795630363; x=1796235163;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2YKWEz0MAzHFVKMOl3XQ/Gzc08tRuYM+nHG8EOvJi+U=;
 b=0RCqLj0wNRUa4jxwucIbiXHgpNUXAN78P/w9Mxt0CPyJE4IhA4cY41I2i5/qXskttz
 Aq/VNF1AwmhgcuNdXCzn6VrUXutuUn0C5AdMA0Ib0rW6CEgESZTBLoxeujtcZIadsoFG
 LLp5OvlvWiJvhTSikg9jJXGsgvc+pG0bJllZ0mn2+BvSS/+1592+ZUagKz3uPixr/GJU
 cCfCRPm35oFMBBKRYTGXtfJyngZ4sUx2eHmgQtXepvxhaUbGh8Xr0j0auwcDCC3KPjQt
 aicQPYmrA+JEE2iGuiPEYs3nQCr7gxczSEhfnUbf0CXTIA0IDjBRf32NCJ5s0EhRKSUj
 CCBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFDEXnsocQ+/9rAu0VxUu3WLv3wvTUwGxQhfHh9ESp6x8HGKN6n57pXytZX3Zmcjgie3YpNB5w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9OVHGO9E8MSQNGztlECC0bHFbQPYoQjCi+1QnrvQEDZBoVFt6Y
 kbf3ikMBGtj7DRl5dFXVqzkN2sPxGQt5uCYmSvDpE9u1cUh8T1me1CMikjtTvZW2h/EKJsj+pOD
 maVHKMBBnRCMIA6PJcD3qVN3dPv2JDRI=
X-Gm-Gg: AZFdTZeXt2pikUTTeF0KJw8/0wQWuZUo14AFddn6NGTDe+U42gipOMLfjV4BKoVX8KZ
 wHMyC21Weocv90FECVBVvg5rHLQTlutzfmkn04nKaASd9O6rjkDwzDIVZWXzHzf8OrEiifecsB9
 NsHa/Vvi0OFujMGxRjJEuGhdIB+SFZNw7xOAi1FIC03aYDV3u71RBCieZNxSSGvynFj6WY1uJOj
 hI/YkqpLsyjN+ssMrQyINMEUBZGTxBsZVklIRyZ5aCZKTXMBdEoyTHNRA2opby23QfrdNIPTYxl
 jKi47EBnfPE2SePxh4UwMjkC7mDLL1Q9n++WJOPMDPPvJc4ruesB+JjBckqZ9ZclzaMmb69DM31
 m7hctjh4b8CZ7GLLOpTtfxhYxTGGDP123IANzIbwrHPvCp8VFCI2YU6z6Bd8YwvTJ3+a9R9AygX
 82Oq/WYVegZ6YaFO1FKNhlg00LGQ==
X-Received: by 2002:a05:651c:a0ca:20b0:3ac:dda0:efdc with SMTP id
 38308e7fff4ca-3af935b15edmr16712361fa.16.1795630362617; Wed, 25 Nov 2026
 10:12:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
 <afa440adc4fd913db84f3f36e2fb0d9e2c3ba953.1794391398.git.nora.schiffer@ew.tq-group.com>
In-Reply-To: <afa440adc4fd913db84f3f36e2fb0d9e2c3ba953.1794391398.git.nora.schiffer@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Nov 2026 15:12:31 -0300
X-Gm-Features: Aa3M54rFBh0SvFgnyCTaFrgBEQmnZT0VMKzA2Fu1ZMeUT5bgMfvKyZ57SzB8dSI
Message-ID: <CAOMZO5BnAEnnKv2g9GEMKP85WKAMTpbr0rT=2qSn8uzb72Vn_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] power: domain: rename imx8m-power-domain to
 imx-gpcv2-power-domain
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Marek Vasut <marex@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nora,

On Wed, Nov 11, 2026 at 7:13=E2=80=AFAM Nora Schiffer
<nora.schiffer@ew.tq-group.com> wrote:

> --- a/configs/imx8m_data_modul.config
> +++ b/configs/imx8m_data_modul.config
> @@ -116,7 +116,7 @@ CONFIG_GPIO_HOG=3Dy
>  CONFIG_HASH_VERIFY=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_I2C_EEPROM=3Dy
> -CONFIG_IMX8M_POWER_DOMAIN=3Dy
> +CONFIG_IMX_GPCV2_POWER_DOMAIN=3Dy

I don't think renaming the Kconfig symbol adds any value.

Please keep the original name.

> +config IMX_GPCV2_POWER_DOMAIN
> +       bool "Enable i.MX8M power domain driver"
> +       depends on POWER_DOMAIN && ARCH_IMX8M
> +       select CLK
> +       help
> +         Enable support for manipulating NXP i.MX8M on-SoC power domains=
.

This help text is better indeed. I suggest only changing the help text.

> --- a/drivers/power/domain/imx8m-power-domain.c
> +++ b/drivers/power/domain/imx-gpcv2-power-domain.c
> @@ -137,7 +137,7 @@ struct imx_pgc_domain_data {
>         const struct imx_pgc_regs *pgc_regs;
>  };
>
> -struct imx8m_power_domain_plat {
> +struct imx_gpcv2_power_domain_plat {

Please keep all the original function/struct names in this file.
