Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4AAC5516F
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 05:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0341980D0F;
	Mon,  3 Aug 2026 05:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Bqyofr8FV9n; Mon,  3 Aug 2026 05:46:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 211E980CE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785735961;
	bh=ElTYkiGUO6aXjPhi4N65E0G6yYfpKYGK82KtuxIobFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ne3LFD1z7qMQOccb3akQrmlAJAHGv23xoDBrYZnEqfrQyLcc+isE7HOgY5hc1b3er
	 8UXwL1L/SR10J3llyyumIeQpcbHXhIjUbGx26yYRYv7tSY9Zps5Ua/ugrpxI9YBzGF
	 Dn9dcsJ1xLryCjibR/VhsE+Ir5ITdQa/yuFah1h9x42YJNn5oUwQOmcnu4Qf5zrGa2
	 rZBYJvmN7HD+szD8eto/qa5xV+WU2XUnpjiG3iHFgXW70hXhwl6X6Pr66AHgnPMWS9
	 iGOOAZZ2n1lmyU5tTcHPRhPDbL4LUHcEKigZ4qD+mgTntBn63lgRv7yjI+l27md4Uw
	 qAS+CnmXr854Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 211E980CE9;
	Mon,  3 Aug 2026 05:46:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 09263397
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 05:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2CC480CE9
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 05:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPEmU0BWDSlc for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 05:45:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 14D0A80CD2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14D0A80CD2
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14D0A80CD2
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 05:45:58 +0000 (UTC)
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66899fe9077so4136662d50.1
 for <u-boot@lists.u-boot-project.org>; Sun, 02 Aug 2026 22:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785735958; cv=none;
 d=google.com; s=arc-20260327;
 b=X3quIU5672ga8+1mDmfOZJ7I2Byv4ARijT8cdfJekIqSolV5cvsk+QBmpQQhYR4bSS
 Af44/O7NXvCMwaunsrNiQY04yg3WeM2AHtp5GDUhjqo5aFZU71k5o1soM8jsPjFN8nH/
 vlszgKOONSQ7NKfbk6XtU9aZk/HjbrwBbAHzaSkX3/Ps5nv81tFSk/u9eX80e5o6Rc+H
 j0OYuHd9oVzOcbns8a27wv9Xu8RX0YenQQ2Cj7D4EJ5Ey4W/d0eA2ps7Ck259J0o9aYq
 7mD8v45JCPdRmuInFDPngwq8tT3CQWUS+zlD7i9MnLeLfK/jYaUfYwDLYK9DPu9xseEP
 Xejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ElTYkiGUO6aXjPhi4N65E0G6yYfpKYGK82KtuxIobFs=;
 fh=uskDrwEsn91rgydCGx3xWxxJPw/88IL160Zea4Qi7g8=;
 b=e2ZomWi2xFa8pd6VmR2DVsCXiKPmM8vQTekVFAGxvqB+nNF1ddnmKnCaqNfACCr1JQ
 kege0xCjx+G7kUrXkz7AfSVQXbHQHZEr7+KyZ4/uFyXU66vnKN0ie0h2rRqdchfuVUHF
 YQ0oDkADblqe/pITdAejP2frursIc94mvNg/UvFGbw4dObmMCLHNeSJrRQd2U3m583GQ
 FQTD1A3XcBcTlGji5CcGgUY4rbqRK3LFHOsz7Ilyr6gyeRL8FOlwwmXKkpaA5TyevBtN
 dVoOKVga3g8i3wqPW7MDovwSEwXa2tDCHZEqQXyQslLWg02sKAQoLk3dL4SFhHQFSV3m
 LfUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785735958; x=1786340758;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ElTYkiGUO6aXjPhi4N65E0G6yYfpKYGK82KtuxIobFs=;
 b=P4zPreYWBK9yG4Ub1CPJ6ClVGg5+ROSpOqxfbKdEPWYGrH/FTLbuRryGx/V8APsCmG
 x1iwjNjKBGx5F0UrxxnFo3X7W9D6RMsu95g69MYW2aa3mdUHMfjo6LTMcp0ymw+f847G
 y8wlCgxqBzig0Tz5agZL/iId9cK2oUimYxgIfxXPFAz5SRQHp/BzbndgzQuNWgMk+ci+
 lP05p5lak9kFprWVfz1sftihm7eNlF/TGOPmnDsKlA8vvfiw9X4TgL27eQqPM4uM/k4H
 4aZLl1FNx8it7NBwP0XzMybG4kjII47vcf6/tfOZ9vzw7Wm2c8gzuVBvNIYQENMlD1Ys
 5i+g==
X-Gm-Message-State: AOJu0Ywa9TFYB95/s24XjZsSGWYR2r8HPTv5kNQ0okOxkZMNkMFndx0k
 LVi30fbNi3H/7Xv+8thXG/xhTxZ/TZhjRRi5XI8WmywDUxPxL+X5yAs+YVNN55ozri2vsDXrX0i
 OXfPQwv/hyej/t9cI2AYaVNnXB4JIGRvU1vbT1phevTppr3X//pM3V1BxqQ==
X-Gm-Gg: AR+sD10j1++DfiALG29dgwr0VYXSQg++WYxayJfJUO9nm1tNL2/T2I53oY361mbw8Ur
 uk0yXflhcQsExmixv6nhI9YWmIQPMM8IphiyyJnMcHZwWZ0vl4TijJn4tFtVq253mBMKtAn38Dm
 YtTCuYlMH9BzJjRAtjnMEElf/PBBdTKje61s+7MKFQc+36tYIh8yM2olLyGNlAnITmk5EZWZzfk
 VkRhpZA+RlNiaMdJcC/iQo6hgWU3aGs2TI6iDftLWP29Cfhu6UiR56iKgQB8dmWieLBs/cST0qG
 6sygSWih95i31mZu+8XM972QuDK+aLCfVKUm6ossnSpx8zcnbGoqRYYXPxPJ6HBhAJhtAPpZMj9
 yJ0CmnWdO/2N1KcXLsn2tPtLEotljwwrV1c/2NXBh+Y6IQ887KKtkUrn+/ynWcgb2SU/Q8EHAt9
 VPBkE6alHzkxDZvFoVfduHKPp7qCKxmtMhn5C0DDHbNeyCeikjH8UAF/ZsEkEHKd4kW9rcsLr5l
 e+93xfwq2QZqJvinhTck93kcF77yUMzLm47au17EfHJtAoJJTckQrwEsk9UxSrrK4r6mnhug2RH
 z+VA9Zb2vPDElbB/i2eVjFA3Nxjzv7cM2Drvtlhtpmd4Bt5w0wmhrKT+i3+fHxQVOV0A5jK/T1i
 euEV9EiUyYUlusglULbfz9RHA36WB01FnKNakp2RuGy0=
X-Received: by 2002:a05:690e:4883:20b0:668:99c8:bf15 with SMTP id
 956f58d0204a3-6694efe61f4mr8093281d50.11.1785735957543; Sun, 02 Aug 2026
 22:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 08:45:21 +0300
X-Gm-Features: AUfX_mywkNT-uR17QXz4rQu8NZPwnq--7gZ5X-oDo7k_8uBWol169byhO2dPZ4Q
Message-ID: <CAC_iWjL15ysDBon6OYfH0swA0K9V_LFj5zWsdZEafVKAdz9x+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] board_f: Add verbose DRAM layout print option
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Johan Jonker <jbx6244@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785735958; x=1786340758;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ElTYkiGUO6aXjPhi4N65E0G6yYfpKYGK82KtuxIobFs=;
 b=XBmlQR1NVOyGZPSZRxLhxAp6JhBElmg0Vjc41jfKoZxp3LigAQ/ClkW2htn6jEn0DD
 8Y6JsOwcgescBdh9YYLPwS01TB1Ni8fxnjZKmpoaUEOJDtIDadD8g7jZVBbelkbxfHRB
 nEn+eRN/Whztx3d/63lTU857S5dgQxjMKZZp8Nc0wH76oyWHAFKMOpim9S9Gy9xneA93
 Fi9wCFM4QTZ3AdlVRtQtRA4indq7jFnrsaqlhsKXc8oM5Z/xInN6bjcTX3lK2qnTs+SI
 fIGOioHbloAOOogCQjtbvdbM5JiSFzAK3/awFrSAyzPiZhZx9MsRkU13wyi+Y5BAKCA2
 qVnQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=XBmlQR1N
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 3 Aug 2026 at 00:35, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Make verbose DRAM layout print on boot configurable via newly introduced
> CONFIG_DISPLAY_DRAM_CONFIG_VERBOSE Kconfig option. This reuses existing
> DRAM layout debug print, but with additional rework to place the output
> at the end of DRAM size listing, print both bank start and end addresses,
> and skip empty banks. In case DEBUG is defined, the DRAM layout print is
> triggered unconditionally.
>
> The original debug print looked as follows, which puts the layout print
> between DRAM: size announcement (1) and duplicate DRAM: size print (2),
> does not skip empty banks (3), and does not print DRAM bank end (4).
>
> "
> Model: Renesas Ironhide board based on r8a78000
> DRAM:  <----------------------------------------------------------- (1)
> RAM Configuration:
> Bank #0: 1080000000 2 GiB
> Bank #1: 1200000000 4 GiB <---------------------------------------- (4)
> ...
> Bank #8: 40000000 2 GiB
> Bank #9: 0 0 Bytes <----------------------------------------------- (3)
> ...
> Bank #15: 0 0 Bytes
>
> DRAM:  2 GiB (total 32 GiB) <-------------------------------------- (2)
> Core:  68 devices, 26 uclasses, devicetree: separate
> "
>
> The new debug print and optionally verbose print looks as follows, the
> duplicate DRAM: prefix is removed (1), the layout is printed after the
> DRAM size print (3), the DRAM end address is printed (3) and there are
> no more empty banks printed (4):
>
> "
> Model: Renesas Ironhide board based on r8a78000
> DRAM:  2 GiB (total 32 GiB) <-------------------------------------- (1)
> RAM Configuration: <----------------------------------------------- (2)
> Bank #0: 0x1080000000 - 0x10ffffffff, 2 GiB <---------------------- (4)
> Bank #1: 0x1200000000 - 0x12ffffffff, 4 GiB
> Bank #2: 0x1400000000 - 0x14ffffffff, 4 GiB
> Bank #3: 0x1600000000 - 0x16ffffffff, 4 GiB
> Bank #4: 0x1800000000 - 0x18ffffffff, 4 GiB
> Bank #5: 0x1a00000000 - 0x1affffffff, 4 GiB
> Bank #6: 0x1c00000000 - 0x1cffffffff, 4 GiB
> Bank #7: 0x1e00000000 - 0x1effffffff, 4 GiB
> Bank #8: 0x40000000 - 0xbfffffff, 2 GiB <-------------------------- (3)
> Core:  68 devices, 26 uclasses, devicetree: separate
> "
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> Cc: Aristo Chen <aristo.chen@canonical.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  common/Kconfig   |  6 ++++++
>  common/board_f.c | 33 ++++++++++++++++++++++++---------
>  2 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/common/Kconfig b/common/Kconfig
> index 345be4b8ca1..869493c979d 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -615,6 +615,12 @@ config DISPLAY_BOARDINFO_LATE
>           the relocation phase. The board function checkboard() is called to do
>           this.
>
> +config DISPLAY_DRAM_CONFIG_VERBOSE
> +       bool "Display additional information about DRAM layout"
> +       help
> +         Display additional information about the board DRAM layout, including
> +         each bank start address, end address and size.
> +
>  menu "Start-up hooks"
>
>  config CYCLIC
> diff --git a/common/board_f.c b/common/board_f.c
> index 9efcd9499a9..f886774e82b 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -217,21 +217,34 @@ static int sizes_near(unsigned long long size1, unsigned long long size2)
>         return size1_scale == size2_scale && size1_val == size2_val;
>  }
>
> +static void show_dram_config_verbose(void)
> +{
> +       int i;
> +
> +#ifndef DEBUG
> +       if (!CONFIG_IS_ENABLED(DISPLAY_DRAM_CONFIG_VERBOSE))
> +               return;
> +#endif
> +
> +       printf("RAM Configuration:\n");
> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +               if (!gd->dram[i].size)
> +                       break;
> +
> +               printf("Bank #%d: 0x%llx - 0x%llx, ", i,
> +                      (unsigned long long)(gd->dram[i].start),
> +                      (unsigned long long)(gd->dram[i].start + gd->dram[i].size - 1));
> +               print_size(gd->dram[i].size, "\n");
> +       }
> +}
> +
>  static int show_dram_config(void)
>  {
>         unsigned long long size;
>         int i;
>
> -       debug("\nRAM Configuration:\n");
> -       for (i = size = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +       for (i = size = 0; i < CONFIG_NR_DRAM_BANKS; i++)
>                 size += gd->dram[i].size;
> -               debug("Bank #%d: %llx ", i,
> -                     (unsigned long long)(gd->dram[i].start));
> -#ifdef DEBUG
> -               print_size(gd->dram[i].size, "\n");
> -#endif
> -       }
> -       debug("\nDRAM:  ");
>
>         print_size(gd->ram_size, "");
>         if (!sizes_near(gd->ram_size, size)) {
> @@ -241,6 +254,8 @@ static int show_dram_config(void)
>         board_add_ram_info(0);
>         putc('\n');
>
> +       show_dram_config_verbose();
> +
>         return 0;
>  }
>
> --
> 2.53.0
>
