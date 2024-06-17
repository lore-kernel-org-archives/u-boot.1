Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534C4C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C988D8811A;
	Mon, 17 Jun 2024 15:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GEmkuUyQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E6E882E8; Mon, 17 Jun 2024 15:53:38 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C2B88271
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-630daaec9c7so37538277b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718632415; x=1719237215; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=juHK81fIaChwdveUFGG2RjtPnZ4GgL0YcWOKufolXXg=;
 b=GEmkuUyQaMNBSu4ryg6WC1/y+AxauP0mLstDaONBXScaEybY67d6G3hXb2Gb8AiMQT
 6ZSJOi7HcuCpyaYyGpVLPaVxmsKnOCXdWlFlmwUwR9XEWFKWFHti6I7sv7SVUlX9922z
 3L1iLLeCziWklYGK7AzIY053rP31TbwU7XmBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632415; x=1719237215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=juHK81fIaChwdveUFGG2RjtPnZ4GgL0YcWOKufolXXg=;
 b=Z8Q6UQNhCTknIRQ3CNHEsnDAb0V0ef95iJ7zq7aRIreSkhggtYuoQExhjdlu53uJK8
 7AqcrCYcxGC84N1ZkCgInHXW2STlyvWpc4QZCZUhgvUDwHVPO9Ie1h72WawfRw0MJ0l4
 erAIJglxgTli1qNsMh0R1ns652iZeQy+F5/0ZVapTIjH+ZZmjUDPKfxEzs0e6j+k4QEF
 4kHXdkbMdHJ51PivnWM3OCff6KSHUtplo1R1cmNhfj6z/pmo8ag7p556F/WXefOIvNQI
 ancKDpAXhfh3UGIuvzbRu+RWcm/jap0zKhaBidjSXu4sFRLlGRiMH1YCmvMzlqlHoaZv
 zCLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs0D17PRNStlKz2fPBOKoTOqQ2JYuCLWIXQesz2aH5C542bC0gsLK9L3MTGPudYHsg9N74TSO+sVhUGV4sJZXXIlKRXg==
X-Gm-Message-State: AOJu0Yymtr+baCeJcpDpjVey5Mbp9Xz3m6GUzpUc6G+Pjyy+EDGWkZyY
 vbcWjmrRoxpKFWQR+R2Y8pjwiUbJZGcZXGgDxWT8GeesjWz/oYBDWKaAKjbDOB+jxPMZsWylq0T
 QEe+vN/FSLAF4Hx0suG0kZ8kiuYoV03Uf/8WA
X-Google-Smtp-Source: AGHT+IEI4supFU11jYUE6JPXQTCIxt0KlkFDGdBZE761R8xzBMVn60idpNFhP3UJG38YNET7tZbkCV/FLO15PqSRu4s=
X-Received: by 2002:a0d:e747:0:b0:62d:25:2a9b with SMTP id
 00721157ae682-63224ef2515mr81136807b3.52.1718632414622; 
 Mon, 17 Jun 2024 06:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240616085948.16692-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240616085948.16692-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Jun 2024 07:53:24 -0600
Message-ID: <CAFLszTh9Gj_xFgu6a_ErcG5JfLmB=xzq91oXBfuDzUzMoGRFqA@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: update requirements.txt
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 16 Jun 2024 at 02:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Update all required Python packages to current release.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/sphinx/requirements.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Does this fix / change anything? It is good to keep up-to-date to some
extent, but it will break documentation for existing checkouts, until
they refresh.

Regards,
SImon
