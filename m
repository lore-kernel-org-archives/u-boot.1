Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CF5EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784BA87026;
	Sun, 20 Aug 2023 23:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DJaM/74k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01BB586B7E; Sun, 20 Aug 2023 23:57:47 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6845086F67
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fe655796faso4088232e87.2
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568656; x=1693173456;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NsVxffB7VBhKtUNA7h6nJ5w3RqsvqsaNp9A/WswqJLk=;
 b=DJaM/74kxRSG9gzE9SiyaRAXJLcNv3rt/A9zDjAzd7TzDWZUXeosIcPR/XaMOG9wen
 LCWyBR7qKw4pF+XgNg2KP1UO3KqInSUtJk+KkfjCMlBY/zEuJ5XLd95wQOGPmT+hbtaX
 pjT0Qnc3PixQHpe37GFARn4qkC1qJmKroKI0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568656; x=1693173456;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NsVxffB7VBhKtUNA7h6nJ5w3RqsvqsaNp9A/WswqJLk=;
 b=NSU8QTnv6sZ8Hy8fkSkakExFhL2sGibbLotlptiCFGRF5uO3OLbh8cw6dm3xPyFJMo
 s5REGyLqsBTITRJvLV2mC7bw2Mr+bhYK7hUsW9f3oSEM9yI2mnPyENJDIB/AHWRlgokS
 Goho1rhCvnNwcXTGCUzuEv1wdFMgw/9RA+tCGMuBsLomca2bwLig3HPl+FbpO85jowL1
 XpfYoQ1sjpOOyRDcAAIVGOxjDXtTOxRNi0NZYR7HXEFhllausEIU8aCi83ywLGe++kqv
 UgZjcZutPYrJLghtCWUL0NM+KdbyuZ4S1NBoaFjo2CosgfqMruzGqemU1uHM8A07LbU7
 PkFQ==
X-Gm-Message-State: AOJu0YyEd7MLSz65veebWtLz/5VwTpk1xHo2u/8zXWu9/gmQQV4bNID7
 hz7zeEml5HGIPYVHBSmhIyYgNbwl3aLuaO0JnIW7TQ==
X-Google-Smtp-Source: AGHT+IG507Wsaq6f7NRrMe/bPKXKy/idcaIS+fU19eUVZ0drBtu0nc8jz9nvEP8xWmm/9iUvVYxQxWdHVjQxvIBPHJU=
X-Received: by 2002:a05:6512:b94:b0:4ff:8c0f:a745 with SMTP id
 b20-20020a0565120b9400b004ff8c0fa745mr4099937lfv.54.1692568656395; Sun, 20
 Aug 2023 14:57:36 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:35 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0gXL0npRfKW2BYLDEFJpS-VnHjH+iDkoLC4A6ii__OWA@mail.gmail.com>
References: <CAPnjgZ0gXL0npRfKW2BYLDEFJpS-VnHjH+iDkoLC4A6ii__OWA@mail.gmail.com>
 <20230813033209.486168-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:35 -0700
X-Google-Sender-Auth: wzDIgN2EsNK5OlOjnzqmWMh0WTk
Message-ID: <CAPnjgZ2ma+_p13ZjuUPKJ_R94rzWmNsh_M0sYyY_7FQEw2fy+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: dm: pinmux: Handle %pa in pinctrl-single mux
 output
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 12 Aug 2023 at 21:32, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The pinctrl-single driver uses %pa to print register value
> in its single_get_pin_muxing() output. Handle this properly
> in the test based on CONFIG_PHYS_64BIT .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/dm/pinmux.c | 92 +++++++++++++++++++++++++++---------------------
>  1 file changed, 51 insertions(+), 41 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
