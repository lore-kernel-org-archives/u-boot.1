Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE7FD30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA978922F;
	Fri, 18 Oct 2024 17:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PQMSEBzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CABC89221; Fri, 18 Oct 2024 17:03:16 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9D3891B2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2c6bc4840so1670614a91.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263784; x=1729868584; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vqysxZdmUldYCyegD/FU4SMRf84heSbBciYg44GrRsw=;
 b=PQMSEBzph1Hg4g4dfuvg3buweK/jUL/WhtedsC4sh53qLj+EpsNLDLoEkOPNmhkgNt
 bIewbk9HFfJT/Ob6fuONbTynnPVzFGmvTDXbOIgwbjxIrMBhquTk1C+IDmFa4anYMgis
 9iPQqDXwHKZNn7cHkgFwl0n5D0rlEdB/2C5uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263784; x=1729868584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vqysxZdmUldYCyegD/FU4SMRf84heSbBciYg44GrRsw=;
 b=cZ2YyW8ifgB1za8/f/OkkHovZGc3QQHPaKE06Pbx9qS3lJl3NyT6zMrzRRwFSNCEP1
 G1FVdFb5YsKkQdqPbNtyci/Vq2/wIH6d+3WR3dLFsCizQEUnshn9IAeb88rUMGegV1ox
 h8nQHckb2x1uXIp3oxV3CnYZSmlbd/eSh/aVuML/tXKThKvXvfTX62rPtZba/Ph6qkSM
 NWJCnA0p83fpOPbbCXzjbhExMBvfyxjzYEpIdGkc+RXJ9YsOalFGnJgfb4YKoJnuB8NJ
 ehXiaEzfcewhjTswWj1GZ/rHIfnxA+GlYekszLS9i5JBgn88ikKpA10tvmhezxZiDNH3
 aq5g==
X-Gm-Message-State: AOJu0YzTNtI2r41ezPXCodeskJnRHa78xWOQLArv9n2uGuKm0qRP09Zg
 iZ561heZK7tq88HghWt7p1riDBUQLkhZChIxpXE81m43tXyXfJihkpQkYYsscI8ug2GrDxr4yEq
 pXrknFJbGB2N1soCkPEavbUeOdyvXw/uXjU9Z
X-Google-Smtp-Source: AGHT+IG8OsuV2sG+XqHr/I+zzlOiZDVllObMHy8YBB4USZ2JzW2d1Zs+L7EXWffHVYbcwSPiEJ8EAI4KOdgRyrJrhSE=
X-Received: by 2002:a17:90a:4e0f:b0:2e2:e530:508d with SMTP id
 98e67ed59e1d1-2e56172bbaemr3315371a91.19.1729263783844; Fri, 18 Oct 2024
 08:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241018083806.30679-1-weijie.gao@mediatek.com>
In-Reply-To: <20241018083806.30679-1-weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 09:02:50 -0600
Message-ID: <CAFLszThr2dusigg9R_3ytoGXybzV6sjChDp+40L+K_Qeo=rNdw@mail.gmail.com>
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Daniel Golle <daniel@makrotopia.org>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Weijie,

On Fri, 18 Oct 2024 at 02:38, Weijie Gao <weijie.gao@mediatek.com> wrote:
>
> It's observed that the bootmenu on a serial console sometimes
> incorrectly quitted with superfluous characters filled to command
> line input:
>
> >  *** U-Boot Boot Menu ***
> >
> >      1. Startup system (Default)
> >      2. Upgrade firmware
> >      3. Upgrade ATF BL2
> >      4. Upgrade ATF FIP
> >      5. Load image
> >      0. U-Boot console
> >
> >
> >  Press UP/DOWN to move, ENTER to select, ESC to quit
> >MT7988> [B
>
> Analysis shows it was caused by the wrong logic of bootmenu_loop:
>
> At first the bootmenu_loop received the first ESC char correctly.
>
> However, during the second call to bootmenu_loop, there's no data
> in the UART Rx FIFO. Due to the low baudrate, the second char of
> the down array key sequence hasn't be fully received.
>
> But bootmenu_loop just did a mdelay(10), and then treated it as a
> single ESC key press event. It didn't even try tstc() again after
> the 10ms timeout.
>
> This patch fixes this issue by letting bootmenu_loop check tstc()
> twice.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  common/menu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/common/menu.c b/common/menu.c
> index 5fd705039fc..bd2ac3e0ed9 100644
> --- a/common/menu.c
> +++ b/common/menu.c
> @@ -566,7 +566,7 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
>                                 struct cli_ch_state *cch)
>  {
>         enum bootmenu_key key;
> -       int c;
> +       int c, errchar = 0;
>         int choice;
>
>         c = cli_ch_process(cch, 0);
> @@ -574,7 +574,8 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
>                 while (!c && !tstc()) {
>                         schedule();
>                         mdelay(10);
> -                       c = cli_ch_process(cch, -ETIMEDOUT);
> +                       c = cli_ch_process(cch, errchar);
> +                       errchar = -ETIMEDOUT;
>                 }
>                 if (!c) {
>                         c = getchar();
> --
> 2.34.1
>

This looks reasonable from a first glance, but please can you rebase
on -master ?

Regards,
Simon
