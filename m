Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8C0E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A31A187280;
	Mon,  2 Oct 2023 03:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lNaEARKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173D4871D0; Mon,  2 Oct 2023 03:22:49 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 342C087280
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so21198329a12.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209760; x=1696814560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oTnim1Yeob/geuunsxF9ONtFZrjNaU1qn1O7HEB+CcM=;
 b=lNaEARKuf7va02nnBqJ6gu1D1okHUQxh0pSEy/B3kRw4SDYQukmG7FZRNoNiIbt3sP
 tS24CUTHCy+SWNim+wN5xjtrLVRucZnpehgqrKg9ZTNK2Q4m1UcSmclnh3YaaUyZJtZK
 iqQhcaGk1ubBTibO2VzqEz8kktaZFBWxxtlRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209760; x=1696814560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oTnim1Yeob/geuunsxF9ONtFZrjNaU1qn1O7HEB+CcM=;
 b=pThpcNFg2CpiwjuVm61M4mPUl6mnnnbM1+jEb4eUwbKq5deb+X2uVoHNKArWDggNEc
 QOZ5JalFlFC9BYvBfneQcyqXenRfbeIPkEM2H5rJFkCBWG/UDWtxEiz5mN0m/GMusLQK
 WkiOPSRC2CsCZjplXQuSz/DnyKH02U/tBfireETUX4dOd97gEez6+NrYrgrpqp/JZkTl
 jHXXIdeWUtDCA+55iEZiOpgJRihcHs/gRzi0+y3QrNxxoiRzn7JiE/Qg5wB+RqHAbsNB
 oNtzf6+XGBxyNrc7W4cwaWhqwNPH+8p3FFX5YrJY687eXavR0n8PQLXeUp2iBZFiX6Sx
 6PJQ==
X-Gm-Message-State: AOJu0Ywrvfe2Is5Z0aqLLeZHXWQHQznvafS5xb1OkPIKzQH14CHpBHFq
 HdQIzcHwYIhzayi85qyvE0SuvOWD60ujZdVKaV3d/Q==
X-Google-Smtp-Source: AGHT+IF4wUaibukFLdttvS+TUlt/bvqKL8K0LYdb9PLs3rOYOQ1aN95G6ipp3/mcoxwEtEiZSDtYW1l6NKj7atyrlnE=
X-Received: by 2002:aa7:dcda:0:b0:52e:5b10:23ac with SMTP id
 w26-20020aa7dcda000000b0052e5b1023acmr9197398edu.36.1696209759645; Sun, 01
 Oct 2023 18:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-2-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-2-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:55 -0600
Message-ID: <CAPnjgZ3pPUo2EAk93Y6AOnY1moXM4ws8DEy906SPaAc5CisSeQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] blk: Use a macro for the typical block size
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Johan Jonker <jbx6244@gmail.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Tue, 26 Sept 2023 at 02:45, Bin Meng <bmeng@tinylab.org> wrote:
>
> Avoid using the magic number 512 directly.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  common/usb_storage.c     | 4 ++--
>  drivers/ata/dwc_ahsata.c | 3 ++-
>  drivers/ata/fsl_sata.c   | 3 ++-
>  drivers/ata/sata_mv.c    | 3 ++-
>  drivers/ata/sata_sil.c   | 3 ++-
>  drivers/block/blkmap.c   | 2 +-
>  drivers/block/host_dev.c | 2 +-
>  drivers/mmc/mmc-uclass.c | 2 +-
>  drivers/nvme/nvme.c      | 2 +-
>  include/blk.h            | 2 ++
>  10 files changed, 16 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
