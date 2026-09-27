Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2B2C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F52081000;
	Sun, 27 Sep 2026 15:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rv_3tjf7hCUN; Sun, 27 Sep 2026 15:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4775980FF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521500;
	b=TOOsQAJ+mmY0/GXqW9Mbjf3EDz6UO34xkvXV8o5NxzVcEjFfD7LBzBZwYh2PfE7kVwkc
	 pHh+486TJ2b5UmverOOYQKLqd52EbYd2FSxTkbrE1yr0rtM4pr8jPsaE/biSIiJ7wNqf2
	 k6kEoX457OhsrMtDIUCxzTv/TdyWA+X2ZtRorXntnTOuuUUMoc5M/jPt3G5+nHvS2TClf
	 sooyvw5RIp54l7jpqNYkvZpgLBNr0Ls4oGtz9m980vvrL1c0X4SDZW2sqVvGUv1PIdaeC
	 bf+EBzAt8Zmll7EEQ9oJmbdXzK9IcsWju2V7RMyrc3noC1AdWyCZex8KABLQTajHxBQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AbNb7bjDc5Q+A89BfDWp2QtZUtAr2/7PUOKmxx7siOs=;
	b=hc0TDCLF1j2oEofMvop4A2yV9On+ZRF3aU58cj7WW52d0gCMs+Vd6U4zD9WAwe5UnGtU
	 apkAEEg+u60n9PqkyMbCUO6BQycglvoWsvphlKocrf5xmWM0anbK2+moUC/JAcowxdGE/
	 PKGNvO1Mn7rpq+6l/GeesShGRsM2ertsb+lovpq37TRBPjvW0o3NGts1+ULIDSMgK5sNO
	 AlzmtLP6N+DwX1gSSxaIK0fG9ZJn0/dd3pDlYJbxjO3HKMbEdhyISaYqWunJ55hwl+Zp4
	 dnnUG/d0YAzoCSOoubsxstqZ3AECU4596TpqP9Tn0erfc3rmRyfDjwy2YRlQxNWXNMw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521500;
	bh=AbNb7bjDc5Q+A89BfDWp2QtZUtAr2/7PUOKmxx7siOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xLF8sasdUCyONBBtZDVj8HH6rLG5xjJQjaTfAmPoX/V1CQkSoejGBTDVZxzz3uNsU
	 i8f0m9/qVGXigP8RbP0zMWD9FEoVouKJdxfA08a8UlNoKcG79jDqwd48D2gy/jGXN1
	 oJ3i03uwbN0HFKThYmQnOR79PcnArCjveo9mmvP33CkKQsU5aGcVRG5Rejs/TgnUKy
	 RrXgMiD3KgA0Y/DLGni72tWYXw6zQKBctgJ2bwbZHSCIZ1BCGv2ohHsivfy+gToNdX
	 b+yNra0+WFbV+qnCtQiSQDrRiclqpBLNjL6VLWch5fybwAKYR+Qy88IcYbH3mxGlnZ
	 0eDhub3uCR56g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4775980FF7;
	Sun, 27 Sep 2026 15:05:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E60F372
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBBB840599
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VYUIKanUHjxG for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9FDC240576
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521498;
 b=mcbt6yaTkPl+W6Bxwn/h+XC6h8s/Zutfs9IRLxfCLjJHfi0fgkrdT364Wn8o2WYmZyK6
 pqfwaXhsmagf+tQF8RepgcIzApLWrJbJDaTwudc06nyzQX2Eq0Aji+VSHLEnYZdSp5CPi
 Y93TBBg+Mwjb5uO+w0S8k4MofELAbd6s7OTKlKK93bOv0pFqV5nay9t0xtviTe/MkIjzV
 9C1l+WzvoHU3h0FFQUmMXuCcALKwZIJpz4VagkWc0BdHd5BByKKssfRmpthk5eOzDWeea
 fh+m8t3bj9Sb643GjlwZGLCQ/8LIw/jO+jETIUBa3u4u6WGVt9Fxz29sVysJfEUeEjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521498;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=AbNb7bjDc5Q+A89BfDWp2QtZUtAr2/7PUOKmxx7siOs=;
 b=fqGULJepP3+S5k+SHfLiN1MqHF4/AgoIQ847pWJla2kbsHw86CTFGfF34/huXlA1u/2j
 qIBrxKzCfGQjzlX7Xyfv9iYirw/QXzrx2T6UPP+PWK6CSrFCuIX1ZKlrSHZEouZJEXice
 0mIwnbjVxlzQzE3Vy07+283PUxFV63JKAoFJW8wzBMlG75dYQX4UweJ8pzxOsSRjB14nD
 OUxANsTC3quGo0BxdqviwNUCWFSs5Fg+xvMZL0ckSt7y8yyBefMVD5371Pl7lMCAx8ilD
 6YN4UIza55b/R3ffNJUTfZZHCqr0RF907hH1t0NfFxHmoRxrOT/xsgbMuY7SnECdlqQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MVBedSFy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MVBedSFy
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FDC240576
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:04:57 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae359e2c0so3313496a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521495; cv=none;
 d=google.com; s=arc-20260327;
 b=Wjdpi3vgohU+UauDHzssd4E3zMgZEWvVBskk/A6BZqpgFPK3zjstG8nOMT15wdb4h9
 MLRGJXPcvA5WKV8ujHaMu3kDnJHQDv2arCe/ssc6eAaAXXoXJ2n4At8a4rDUj+z9Dko0
 LD2G6lRG+hplg5ZYp7cEEisnEbtHaV0e90fZFc+uJ4oMu84uaRn7b0qmDmfsejlV/8KX
 LInf0Tv685943AWU+1cvif/t8KSeS0bw/MlH9U6PHz6ApbzImT3XMJ1TMp73avLZCoK3
 V7pvUN953b60REwF7MOmhFMLVL8771r/6pGcfvf32ZGxhXSRIwhk6jTxTRRFGCw4GVNY
 lt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AbNb7bjDc5Q+A89BfDWp2QtZUtAr2/7PUOKmxx7siOs=;
 fh=OV2Ygu2qJNQGqRpzAYglRlaU/N44w6Z7NOzYyCjjKvs=;
 b=BH2hbyZeYitEWYmbX9c2IsUnR1Sbnbu/3bC4ftrUb45Ne7ZmZUYMepxrtUmZXm8ABa
 ML3cI6t8cCkG7z520oKkR4MpjqQ3isAMMPU4bKWrTXe6fw7ZczljorbNx+VpH/uVN9BX
 mE7O14mCFzgab32ilDZHFwxhS9pFzcnA8l4RtSRkYTTWObPjs13RkpkjQLNHeorsib1l
 CJRMCV29hHbZSfI+t4IVVRBzIlrroboLDKqZLN1M7aBUnELDa5u9Bpoy/N+RpiCRcw7d
 lOdVkC/iUPwRN/bYjPhefP75edK4yOUmu/C3C665oMxbGP+tLSxFRXSLasw5ChtA3TxR
 TpqA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521495; x=1791126295;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AbNb7bjDc5Q+A89BfDWp2QtZUtAr2/7PUOKmxx7siOs=;
 b=MVBedSFyddqMJyBbC0HTNU35gVtg8jmmcIi4mvOYlC7jhonlKUb5Iw35iLmkufasS/
 aNgfpSOkWR7DvJ9Mh16wCk5xb8jrpO+zHqMR+PT7MeNulSyHZJArXR07JE74gcHikHpi
 PE/tS11wmF5KgWYEj/4GBEbCyCvuFW3dwqeR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521495; x=1791126295;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AbNb7bjDc5Q+A89BfDWp2QtZUtAr2/7PUOKmxx7siOs=;
 b=TTE419PiRhS5zApwwo7kfW5AlI7ET0UKibQ/JVr6Vylc7aKGqO/JOXAzUULGQI7MPb
 iRxBAgi4D6EaCVGPE1zBzPTuQj3GbJtaEAa1vyR11wLq9Fw73oH5HZQrbAJiZer7z+Kc
 BCn8XnTcOSU661d/eXOapTmOZvIxP9BsfwAeqB4j8Q7eSbsolXPyDI4R9XfyjRUUptMg
 SXVdORskJGahYlbIxFjJqRZjIEr65zNlR5qfvkkvl7DTaLvu9OXxHAdVthwN4MqB8ebC
 Cxxh29gVm6sog1Znr7x3aja/1vlE5NaRlfqugFTOwUSbD94xPIqB4as4khnlShnQ3IIr
 Tu3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgZA2Rr1lLWzBGz7rYRMeu+BcEj5MM9DeCFUCURgQKUkkHDhR7iUfvhwlhHbONh8n+8XR84aM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJsSy2bjJguqL6prQwH10bfMwqBa9Owz9PijDM42Em28Z6m3h4i
 KKh1iGuBB0UZyl5hTC/eQwbEdAIRKs7MQ+LOfxGd7o4V5xz0tfEP16WZinmN/Z1vpO48+U9b1Q0
 /jGSDjT+foYkU0TQSRes3S2JJlYN36baWJ+4MsJqu
X-Gm-Gg: AYBFou1DvA02rwKBzysNqUBdFu0pMeiq0AEv0IYeFGhSVuV6OQ37whOIV82rcq84paZ
 bMvKcI2j/6/ZvRcXAphCQ7f+SQ62TNvKvWzuRcQVmaoLEoifcUINib5W/Vci78nXMv4RMXAWniv
 boiDEWatuAvphh/Zq8tjtSWN9Lur0+7ItXTQCVFkcjoPnZw2lG82QQot25RvF+vCDT35/SFEfT0
 QQZAMIe+g6uk2xjMSYAAhYLnk2MdjMJlwOgApIpVcRQX01PzW3ue9przgqIW2U+6n7YdWfgLcEU
 mmF8FBfBT8M4NJDdHNeyLLVbVIZMnByJcbM6CAX4awY1KHw0qxuxdmz8tdwnnEf8
X-Received: by 2002:a05:6402:51c7:b0:6ac:77c2:c406 with SMTP id
 4fb4d7f45d1cf-6ac77c2d89cmr542062a12.27.1790521495172; Sun, 27 Sep 2026
 08:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105622.3446968D07@verein.lst.de>
In-Reply-To: <20260925105622.3446968D07@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:04:43 -0600
X-Gm-Features: AclHuK_V9iXom8D4sR-IzDV-8sjZXScE6Uf9wik9XG5RzyCVEEK5qCLbb1D_aCw
Message-ID: <CAFLszTgqKFyH+OXVTOPZz7Wby39W3AP=AcpUvv45E=Dyn5m7PQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] clk: add support for RPi5 RP1 chip clk
To: duwe@lst.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org
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

Hi Torsten,

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:
> clk: add support for RPi5 RP1 chip clk
>
> Add a driver for the clocks in RP1, starting with ETH_TSU.
> Derived from Linux drivers/clk/clk-rp1.c.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>
> configs/rpi_arm64_defconfig   |   2 +
>  drivers/clk/Kconfig           |   7 ++
>  drivers/clk/Makefile          |   1 +
>  drivers/clk/clk-rp1.c         | 280 ++++++++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clk/rp1.h |  56 +++++++++
>  5 files changed, 346 insertions(+)

Please expand the commit message to explain the motivation - which
downstream driver in this series needs the ETH_TSU clock and why the
other RP1 clocks are deliberately left as stubs. A one-line summary
and a "derived from Linux" line does not really tell reviewers what to
expect.

> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,280 @@
> +struct rp1_pll_core_data {
> +     const char *name;
> +     u32 cs_reg;
> +     u32 pwr_reg;
> +     u32 fbdiv_int_reg;
> +     u32 fbdiv_frac_reg;
> +     unsigned long flags;
> +     u32 fc0_src;
> +};

None of rp1_pll_core_data, rp1_pll_data, rp1_pll_ph_data,
rp1_pll_divider_data, rp1_pll_core, rp1_pll, rp1_pll_ph,
rp1_clk_change or rp1_clk_chg_tree[3] are referenced anywhere in the
driver. Please drop the dead scaffolding - a follow-up patch can add
these back when the corresponding clock support is actually
implemented.

> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,280 @@
> +struct rp1_clk_change {
> +     struct clk *hw;
> +     unsigned long new_rate;
> +};
> +
> +struct rp1_clk_change rp1_clk_chg_tree[3];

Non-static global - if this were needed it would need to be static,
but as noted above it is unused and should just be removed.

> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,280 @@
> +static ulong rp1_clock_set_rate(struct clk *hw, unsigned long rate)
> +{
> +     struct rp1_clockman *clockman = dev_get_priv(hw->dev);
> +     const struct rp1_clock_data *data = &rp1_data[hw->id];
> +     u32 div = rp1_clock_choose_div(rate, 0x2faf080, data);
> +
> +     if (hw->id != RP1_CLK_ETH_TSU)
> +             return 0;

Two problems - &rp1_data[hw->id] happens before the id check, and
rp1_data[] only has one initialised entry (index RP1_CLK_ETH_TSU =
29), so any other id is an out-of-bounds read. Please bounds-check
first, then bail out with -ENOTSUPP for unsupported clocks rather than
silently returning success.

Also, 0x2faf080 is 50 MHz, right? Please give it a #define with a
descriptive name, and ideally read the parent rate from the clock
framework rather than hard-coding it.

> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,280 @@
> +     if (hw->id != RP1_CLK_ETH_TSU)
> +             return 0;
> +
> +     WARN(rate > 4000000000ll, "rate is -ve (%d)\n", (int)rate);

Technically, rate is an unsigned long so it can never be negative -
the "rate is -ve" message and the cast to (int) are misleading. Please
fix the message or drop the WARN.

> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,280 @@
> +     clockman_write(clockman, data->div_int_reg, div >> CLK_DIV_FRAC_BITS);
> +     if (data->div_frac_reg)
> +             clockman_write(clockman, data->div_frac_reg, div << (32 - CLK_DIV_FRAC_BITS));
> +
> +     spin_unlock(&clockman->regs_lock);
> +
> +     return 0;
> +}

set_rate() should return the newly set rate on success, not 0 -
otherwise callers using clk_set_rate() to check what they got will be
confused. Please return the computed rate.

Regards,
Simon
