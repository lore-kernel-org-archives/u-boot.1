Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3191D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C1998931F;
	Thu, 31 Oct 2024 19:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jWz4K02q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2414589319; Thu, 31 Oct 2024 19:04:38 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C804588B8F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so983092a12.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397874; x=1731002674; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9qcvzcQOmUEROAo3HbPA5moBoCetXflug5sp4P8QLWs=;
 b=jWz4K02qEZmCZ/LpoWjIATWC9hr8vbQ7Gi+kuZMnvaaHSa8R22r4PxyZVJCFr2luPN
 rU8af6AGnU5QUYEquDQb7dglN43UAFHicCav9yIaEgyD7UnXx380NKxEvFvr0Mx64lyh
 21aT+j+mQG2uAGc+FMgUY26sb4UYOBMAu7n0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397874; x=1731002674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qcvzcQOmUEROAo3HbPA5moBoCetXflug5sp4P8QLWs=;
 b=l1VatACJZdRd8PYkQFH7UWcmpJJIx4BpzKNma0XDkORGcqjQ0DEIV2aKGegrO+E+wi
 hqskvhEixoaPLTBCJRRnCpsYCZVTeZZYUaPSlhFpD0HwQriLbZwHMcnRXeOirQZ4aQM+
 P7MBSZpSVqacuTsWfyH045xJ8bpsdbCfDEAA+RuKeWOyxy9MxRgASzII7sysDmHr+t3C
 mysgqu67UerO34CEKJGEJFk8n+I0e9MVONiAmSjwvPlPbSag7N5trhTV6ETW6rkt59il
 JVU2Anw8HleHA9cJSKpwoPI/3jdzl3wuzauC2Ca9XCnpuAfOVpUMtXGAgieb2E+rCFfA
 7y3w==
X-Gm-Message-State: AOJu0YzPhD7NI8ThVzDwvTnsO+4+2dIA+C9Z1NZVwfLm6VteOuxNiANT
 Mr8Ge627AREzMkkWSl6cTgRWHxDtp0YngtJ3iFnh4JglIRtlkH2Di4LCZnptC8yJqmK7E+7R4um
 UD7ukQlh+MfGdIfneF1qElFPtNsuoO+wTaBfa
X-Google-Smtp-Source: AGHT+IEb4pDc0ZuvvnzNSvSdrOW71AUKg7Jl+oj/ePk0idGJXGlXYPjMWii5V3H7Cz/FOfXIq9b0XXs9tYZYZoPkb38=
X-Received: by 2002:a17:90b:4a01:b0:2e2:bd7a:71ea with SMTP id
 98e67ed59e1d1-2e93c12931bmr4882706a91.8.1730397874370; Thu, 31 Oct 2024
 11:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
In-Reply-To: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:04:16 +0100
Message-ID: <CAFLszTiv1fVewz4qM5QgZOizgEFSHxASgW4de9jxsPMBuS8gKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] menu: fix the logic checking whether ESC key is
 pressed
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

On Tue, 29 Oct 2024 at 10:47, Weijie Gao <weijie.gao@mediatek.com> wrote:
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
> Tested-By: E Shattow <lucent@gmail.com>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  common/menu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/common/menu.c b/common/menu.c
> index 8cc9bf06d9c..48ab7f0f398 100644
> --- a/common/menu.c
> +++ b/common/menu.c
> @@ -525,14 +525,15 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
>                                 struct cli_ch_state *cch)
>  {
>         enum bootmenu_key key;
> -       int c;
> +       int c, errchar = 0;
>
>         c = cli_ch_process(cch, 0);
>         if (!c) {
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
> 2.45.2
>

Reviewed-by: Simon Glass <sjg@chromium.org>
