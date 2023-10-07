Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2370E95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C9F986DDA;
	Sun,  8 Oct 2023 01:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g25GmG4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4A286EC9; Sun,  8 Oct 2023 01:12:08 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBEA186DAF
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59c215f2f4aso40848217b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720275; x=1697325075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qOMbSHLoMr4YUdWUVFf/eXatAl8y/tqc2o3Wh5KBe4s=;
 b=g25GmG4kz/QkJ9hKyaknS5IkVACNWolRkGm0MFvj25nGvCoDrHM027VzOjgc7YCVN4
 zKF/2vwoQL0aY/k2/F45Emgld3pttghvrW/FvANYJsOLEwM1aXvvf/BVw4Q2l8dOY7xq
 S3LOkdACbveP+I5fgbPzrN+jdGUY1T+6Nt678=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720275; x=1697325075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOMbSHLoMr4YUdWUVFf/eXatAl8y/tqc2o3Wh5KBe4s=;
 b=PGWnPdTwnA5Up22Bsq6WcgQdb0U7u5238aPf8vA70KlUp4ke36Q/6a5aWDdM+zELmX
 5Wo7CC95RwB7QZvZ7iR6gD5zaMt/+8rCZOjAF1ht2xsvXBlQIFvKInbAkjZLU6eORblc
 pSPfjKud4hHNP3VaOVfXkV5Fb8Jr2LYtwJmwTEpYDu3HDaDvNOxmb+M5xRZ+Svugp1pN
 5JELC+SJE33KTO9nPe9LTVH8hp2Gf6uQV5a1JBKea1FRHGY1Uy8q2YY0hVWiYIO5J9P/
 C+W4eD5kMP2ut29zf5hc0XJ362vRrLw6VcuPzntdmFHZVF0g8B/irTw1SLXzZc9JJ6W/
 208w==
X-Gm-Message-State: AOJu0YyEkSiVX+ypurRhQMfHD0HsfJQb48JGkeesNDeVvYweORXi2qVt
 Ty2B3nYggWkzfIowsk9reTnXdEQp0vaF3068AG2ENA==
X-Google-Smtp-Source: AGHT+IGVGYjemuoX3UwvFyVHwlDQeFXb/203fNxw2xXRxILo17mcYa6Aa40X5oxuEfgcHFyS4T7B/Hbk3eT62EXyE+Y=
X-Received: by 2002:a81:5251:0:b0:586:a170:7dbe with SMTP id
 g78-20020a815251000000b00586a1707dbemr12911574ywb.13.1696720275361; Sat, 07
 Oct 2023 16:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231007033429.25109-1-mibodhi@gmail.com>
In-Reply-To: <20231007033429.25109-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:10:03 -0600
Message-ID: <CAPnjgZ1axN6uRzpsfhbotpDe1nkavXzU=+NjFNY36D0TDTEmXg@mail.gmail.com>
Subject: Re: [RESEND PATCH] bootstd: sata: bootdev scanning for ahci sata with
 no drive attached
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Fri, 6 Oct 2023 at 21:34, Tony Dinh <mibodhi@gmail.com> wrote:
>
> It's normal to have no SATA drive attached to the controller, so return a
> successful status when there is no block device found after probing.
>
> Note: this patch depends on the previous patch
> https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-mibodhi@gmail.com/
>
> Resend the right patch.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  drivers/ata/sata.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
