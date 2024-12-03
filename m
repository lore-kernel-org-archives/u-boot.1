Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A45E74ACB
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646B689699;
	Tue,  3 Dec 2024 20:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YEc/RQaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C416388E7B; Tue,  3 Dec 2024 20:39:34 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3C628967D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso240564666b.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254772; x=1733859572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J4mjJyQBkdkZ23my2lUzQYqqJLJMXtVaGw0+snEMkuA=;
 b=YEc/RQaHn9pJsnK28OMUUgDmVuBeGNtD6MNNPiaTS5T0UH1CmpVmqYnsAG2RAzVDOu
 F9K4Dk65eyhvMlloMt0g/DVy70UqrZbbif0VrqMP8I9eiNYT0TN2bjUP6yg8oNcRXvjT
 SxXjcxEKMN7AnoBwWD02vOnt+F0cbq/VVUbSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254772; x=1733859572;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4mjJyQBkdkZ23my2lUzQYqqJLJMXtVaGw0+snEMkuA=;
 b=SkfQ51bk/kElKZde8EoLeknUQphI8M/drfBe1fpjpHbSh/U8fOP96yLKhXa1yzo9wp
 Khus3g7XVx6YW5vVnz1RxdS8Bz0RtiXYNA6YGr0fAxOKfpzT3umAuMqw7+bo0KdsKRgt
 F1c4mnnrez4FfmsALdOjqxi2HvTins//CucXQEnDM5IyJ+qXPF3g/gv0hGy5PqH/XXIs
 uKQQb1uIU/I7VCbSJOcSq7BkzWPnp3sULeBM3KDDZkz1Aorq/J/Y7s68CqunAmabkmvd
 LaAOsP5+kz+r5ZASHO9UqzYQ2In0rY0XuJ4s9OGKZvIELCm1LI+TcIaGSuvRaWCPuRcE
 eFZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXam2qUgEv1BrKPJtPM2Br3IHSR7J6yyWlM6AsgYHiTOqlmHRGT0HxI/K+AdXYw25tgQNb2LDg=@lists.denx.de
X-Gm-Message-State: AOJu0YyvsR95AxIhGxfQQwg72/wIVBvz1J4rTKRp6DFty7Y8viOj4tYV
 7OyCRbhzLJoEG5ldhroHLtFFetZz+eDOZJo/7EdvQCynugj67r4rNRz9bCZeXtLZ4t+Oc0zbf6/
 C0dsc7gDiG0FXApjaKXc8kEwmr+GjTjQyqsk7
X-Gm-Gg: ASbGncvNBQcgYkMgYptIdk332v3sxp4bBFqre8O24AT6RfMw1QFrlz/f3ujfAmtNZKP
 wTHLrxinwjWELM0dICUanVjzpGxqrwsEo
X-Google-Smtp-Source: AGHT+IHhhHzmcDGOYtAdnGiDxoTrazTNkt22QtNHHZbTROnaC/aQ2hyPzEcLR4qo3LLbxjWeC4knCOtYr1FUXluJYL8=
X-Received: by 2002:a17:906:30ce:b0:a9a:10c9:f4b8 with SMTP id
 a640c23a62f3a-aa5f7f5acd6mr375067366b.61.1733254772274; Tue, 03 Dec 2024
 11:39:32 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:30 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-20-sjg@chromium.org>
References: <20241103003322.626036-20-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:30 +0000
X-Google-Sender-Auth: 2t8gcid2wUGFBL0jKfB7F0IgX0c
Message-ID: <CAFLszTjFG4Ss31hwYVEtxC+Fn5QzpWfrniH9b612NONdTJ6kDQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/25] common: Drop status-LED code in board_r
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_r.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

Applied to ci/master, thanks!
