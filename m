Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40525E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 17:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A54D1875E0;
	Wed,  4 Oct 2023 19:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Np9ZHP+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9A4875F4; Wed,  4 Oct 2023 19:58:30 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB21875D7
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso20309266b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442304; x=1697047104; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nqf8C2X42aNn3DDCN1HFqknbHL27pCFsoycNTCOJt4c=;
 b=Np9ZHP+yjNg3M9pBESAEmUCaNW27Lpi1IOMaJMVV31s7zqVL7IZcwBY9Xp30vXaGDp
 gynRntt5XO/Q2HzqYeKmrSgQVmqf3z9wqO9nRYdAbIKZqQjYcYSfW+j32Tfnv0l1L7yJ
 xqoTWsYVEdpmQic0OOhwjCW9tJzkRSPUhEJgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442304; x=1697047104;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nqf8C2X42aNn3DDCN1HFqknbHL27pCFsoycNTCOJt4c=;
 b=LfurKmILFnOT6EG/Kxgh7lT9ksGQx4MzNbRMFosChihnUY/Diq728R8EqGvkcRLK6D
 WQGVPRHrFNrYRbN3tDhiBBECwjhCOxbKIu/Ru4wpBUc6qFimE1hJIgMXcywopvpVXSNA
 o+VgRb6ERw59KgsH8xl3n7yYOrbyDIj58iHJ4md1d/cztDSdovTUUcSWFKkoU0xR9V0R
 U82qraOwAG6svtGHFCU6GSnyy841Oi7ZPqXN/bdtWW8qAHwXYcNlHNxImpq5mycc+nIT
 8zpPzimLC94hfE5vzgXAJ45+S3yo1rw9KwR0wE1JK4LOB/Ue1xV52xFq+afuDmsKOSws
 sTIw==
X-Gm-Message-State: AOJu0YzCr4RJdShvkgFvOw1XQAeAkg9Mhth1OTRY2eEDH3dPMU6LBkpl
 Xp3rWT1RLkmnKIdv3n2TV3WPcY5LSxp2LHB8aXQjIA==
X-Google-Smtp-Source: AGHT+IEbP1X1PbcfsiqvxLID+DhaGyo/nJeUQlBMfgdGAxaIUTShkiFekVbLQxlmgvQTpJ1NiCQdm9ghDWoUsVdYGvc=
X-Received: by 2002:a17:906:1c:b0:9b2:794d:62d3 with SMTP id
 28-20020a170906001c00b009b2794d62d3mr2873912eja.14.1696442304472; Wed, 04 Oct
 2023 10:58:24 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:18 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-27-sjg@chromium.org>
References: <20230923194424.1739224-27-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:18 -0700
X-Google-Sender-Auth: gMThKihO8FP8c2sKvHiqDK2uf6w
Message-ID: <CAPnjgZ0LJetkR4wJtK_bWrOVyzEYS4txEBtDOtkc46sNGU0HBw@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] qconfig: Rename the database file
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

Use qconfig.db as the new name, to reflect the tool's purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitignore       | 4 ++--
 tools/qconfig.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
