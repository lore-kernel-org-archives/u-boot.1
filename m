Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18205C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A324586A2B;
	Tue, 15 Aug 2023 00:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TjfW83Li";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C0086A1C; Tue, 15 Aug 2023 00:43:50 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A90869D2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d43930354bcso3486945276.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053026; x=1692657826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G4ahJJmCf2rFVUkiWZuKJbCF4Sy6pt9IbCUVWmC3AbM=;
 b=TjfW83LiOiNfNi/nkFGgjLdVlb5W91ulKKV2lS1dHYO+mB7il481+Cy+qillkVGgb1
 6Twp4obgOlt0a7Re7l7WfbGaN2aXe5vZUyXtIGOQG5f0X+ktLLLg6RMiRgkyiq/xx/V+
 8V/Jl3dicq94X3hlwDfKrntYcvhINW4C/edjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G4ahJJmCf2rFVUkiWZuKJbCF4Sy6pt9IbCUVWmC3AbM=;
 b=ENfY4/bVGYlb5JAVXL6Ed7YG/xpiHT2nNySdB7hPZ+NewqO3At/l22MRDCdecNTLVK
 W1Z2sycB7ds/HABt/+1Ei/m/hDmRCm3HuLD+ZhVUWgD4+axuczbZVIpzl8ePtIZAiXYr
 dT4KGsvoJjR4DwvYXRw462KU2O/4mkbOjWCUx/QhfPCstdbJAUyBuPoGBjh39BMCyh4J
 M4M5IUPJZelu2ZPBctwH3tfRU/ebyrN+MHWHgR6/Mapr4HOLy35uTDnl5PfGmJeURHrM
 O8LrAfXvJPfwe2R8c4gO91n8S3g5zQgpjfDr84+r+MWZvC783GVlwrNOTUutmp35dGxl
 uonQ==
X-Gm-Message-State: AOJu0Yxe963ZCXlfmi9RQUqFxIYSkE8y0WM7gBVqZrWA/EQviYXTkJEh
 7wI0XLROzrj8BfC2y6agfT9KUlSb9oyw2R+CWPtmqA==
X-Google-Smtp-Source: AGHT+IFx3jT5fkbiZTnOILsIuH8v1Z171k1d4E/gvEYTxud7ljfMChXtkVn5pGcaPUN5W36WeR5HK6/Ab9F6AeQ02p4=
X-Received: by 2002:a25:9191:0:b0:d16:231e:e1e8 with SMTP id
 w17-20020a259191000000b00d16231ee1e8mr8823041ybl.0.1692053026617; Mon, 14 Aug
 2023 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230813234845.591216-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230813234845.591216-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:43:00 -0600
Message-ID: <CAPnjgZ2f1YK0kX-gPn-Nqa8H2CXH2b1AfGnaU8-_bi1t+9Xc5A@mail.gmail.com>
Subject: Re: [PATCH] disk: dos: Infer MBR partition sector size from
 underlying drive sector size
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
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

On Sun, 13 Aug 2023 at 17:49, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Block devices with 4k sectors imply the MBR sectors are also 4k instead
> of regular 512B. Avoid hard-coding the 512B sector size and isntead read
> the current block device sector size from it, and if the sector size is
> larger than 512B, use the block device sector size.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  disk/part_dos.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
