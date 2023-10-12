Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBB3CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD17D86F12;
	Thu, 12 Oct 2023 05:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gXxxu/Gb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A42F86E5B; Thu, 12 Oct 2023 05:44:42 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE76B86E81
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7c08b7744so6693707b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OetAgtslLuubRItPP028B7dzBybba03zTGt7aL5+vMc=;
 b=gXxxu/Gbj/fLmHbcO7zJk0VPmo/P2pG1if4ANgGFlIYRu9WfrqZHoH1jP4y7asVqV0
 NfIHHZnNauZ4wYQAwGermjv7Kjr6IWdL+cvHqznoCoA+fR8bdbU5Nlp2N1zOgSnBbQyN
 /EGq+WFB6b4ZN7MZEoy9kTXr3SNPg3vFsCEd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OetAgtslLuubRItPP028B7dzBybba03zTGt7aL5+vMc=;
 b=sxlprFoLTTj/v2IMW8rnZ++dkxAF7I8KPUK+RyBzypHG+i+wzkl+p8l+tu+nvE76E9
 eZHgp9mf1oC1G4nQnaZcpDJW2Xo7YUlmhMN4McAgH0dN7Gagv4aumCPHQ6cJl1eNXKeR
 wVgcDdrNs5jSoA2GqyvQodPJzA/n4w5ulPYtAFrh4aEokDA2h3g8X06HEYZwXb/fs7Tw
 fk1gdiMa66+sRThC4pWOOrMrHUrU5sd5Qp2/0edEZ6TBAjwP8eV9KP28g0UUP20joQtP
 HgAggnHhoFjyQt78Y2mVFyg0lyA1hz7i366TQmLTBBdDU+bvvHGpMfKkMTnWZFDmmY8g
 LCNQ==
X-Gm-Message-State: AOJu0YxXpTXxGiH7qEVsDsB+kG+eN85xbia6vRZRMebddfsUqFD++MiC
 JMsWkAcvoT+1LSu3Z7C7snoIeFHvHpudTJl3mROlcg==
X-Google-Smtp-Source: AGHT+IHQgoReLdfxQss66TZBmXv5PzZsUC38B5F0yhEV6e2fMErdfHq2UhS3jbqapKHsLkvdq1DktBxMiM4VZfnrTCs=
X-Received: by 2002:a0d:db8f:0:b0:5a7:be1a:6c32 with SMTP id
 d137-20020a0ddb8f000000b005a7be1a6c32mr7435812ywe.24.1697082263672; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-5-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-5-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:37 -0700
Message-ID: <CAPnjgZ3LcUDaXeNKf7yOMckbZiq+mxeLtk_OA2SQAr4eq33pzQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cmd: ufs: Correct the help text
To: bmeng@tinylab.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 06:16, Bin Meng <bmeng@tinylab.org> wrote:
>
> Remove the additional space and use "sub-system" for consistency
> with other commands like "scsi" and "usb".
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
> (no changes since v1)
>
>  cmd/ufs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
