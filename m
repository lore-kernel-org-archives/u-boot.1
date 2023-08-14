Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989A3C04A94
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F4E8697E;
	Tue, 15 Aug 2023 00:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P1mOeDVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0582C86A0E; Tue, 15 Aug 2023 00:44:06 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6AC86996
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d64f0c2bc95so4056136276.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053042; x=1692657842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2YNoY50tQL2GNJq+6Qbw9aXqXavS4OdPqh1s5z22sjc=;
 b=P1mOeDVBfbAfM8lmQEAkR1DKjgGugy/SJ8JkLGIq0/OQ0J+okw1mHdp8FSCi8T5cbI
 tXEBQHcTwUZzQGuXtaEbifq9rApmvYdHArowMRSgoYuVZLodS/1yiR2AM4LT0BzYCc+z
 /xwGEIvaaiKyxilEt7xZuMZXx2a9p786CBeFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053042; x=1692657842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2YNoY50tQL2GNJq+6Qbw9aXqXavS4OdPqh1s5z22sjc=;
 b=b2NSaYIdn2y0pe0aDeySqEnVD13VXm2mk9/p6otVI0oZ7YulTB588V6oq9HJg2+0HH
 sJwbSuKp06Zc1eOz+BR/+ycu7Y8M8FPNT7JLrkSaSJDwzE6yTBkXnZ7tgrPr7Avbh9WI
 /oJxV60yop5IAq6V7vik8q18F5tjBWEHTnNGoMMP+YYbKSXOFNTr3EU2MVd+hgMKBD8u
 OiTMQ/vZh85BUMjCDkfasJJRKxYpUrBZdxPwtHuDwzS7MlTrz8B/cNGJp3miHiRI8mOj
 xawEMXdSGFpUpitmHVAiFSEcczO4ojoZx96XrHE/BxDxyRr5rHloBjpd39ba7tZzZY9U
 Yrpw==
X-Gm-Message-State: AOJu0Yz0bNgcVPqqcmv23dylRjil1SxD8PNUHO6nf/in9SnIu3Dozdl+
 FEQ6MM+ql11cN99knZB15og+VtPRLV4wBtSfixCHbw==
X-Google-Smtp-Source: AGHT+IGbblbCbnfNq0MszgHeaEcxF96TxWoHjbHGHnkakCmSnqqTjBVhAuIJ0EZqHedRyOEyVtdFCBby/r+T/xeSjBg=
X-Received: by 2002:a25:77c9:0:b0:d3c:5c3e:c2a with SMTP id
 s192-20020a2577c9000000b00d3c5c3e0c2amr11787173ybc.24.1692053042165; Mon, 14
 Aug 2023 15:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230813234648.591083-8-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:42:57 -0600
Message-ID: <CAPnjgZ2GHvNE0q1-r8VqRJhAPy-EuOsMqkmDq9NPPiDfMBz6wQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] disk: Make blk_get_ops() internal to blk uclass
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glplk@gmx.de>, Joshua Watt <jpewhacker@gmail.com>, 
 Michal Suchanek <msuchanek@suse.de>, Tobias Waldekranz <tobias@waldekranz.com>
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

On Sun, 13 Aug 2023 at 17:47, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Move the macro into blk-uclass.c , since it is only used there.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glplk@gmx.de>
> Cc: Joshua Watt <jpewhacker@gmail.com>
> Cc: Michal Suchanek <msuchanek@suse.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  drivers/block/blk-uclass.c | 2 ++
>  include/blk.h              | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Unfortunately this does not stop people using the ops member directly.

For this series, I tried a patch myself [1] but I think I stuffed it
up. So I will let Takahiro-San figure it out. I would very much like
to see this clean-up go in.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230319192957.1084530-1-sjg@chromium.org/
