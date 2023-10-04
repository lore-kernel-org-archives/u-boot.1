Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A4EE7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8224E8767F;
	Wed,  4 Oct 2023 19:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rg8L/2Ds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55967875BB; Wed,  4 Oct 2023 19:58:55 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B858764E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32483535e51so151010f8f.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442333; x=1697047133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MGgNq5qKgFVW2JZM1/+CSJnuYdCQTqq/nXOwjHVqDqw=;
 b=Rg8L/2DsTfpi73I+Amk+DtdQtwDOq3aw+m7ZafoC1EnIv8bJbro9yWaLT/s9z3Zsfb
 WkDBUQC/dUpZkuXJj9Ij9+qiWjc3SpUzpjAsvd/wolFehnqa4xkehhe3ZNjOfPQaVBb4
 sw96zQm9xuqhZfphB+u5RzEmwBfDzw44mgIsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442333; x=1697047133;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGgNq5qKgFVW2JZM1/+CSJnuYdCQTqq/nXOwjHVqDqw=;
 b=KryXvqzhD30r/CQz7dctmfc4NGhsXp1nH7xzPRpZTkmogSDN82JvLhDd9J1Rx/IvAa
 HATqxfAQG3be6DWPDBlaoV7h5ePhqLyRODSyInSaL/PWvDHZ/duHnF8J8cEAbQOMpeXG
 7APHqV39J2xjgw0s6QcB2v4n5R8XvNpbK+13Z7g4kjBnvoVUiescx0BrCh3IHd5GcMZz
 7qEb0vs1drbkMHmFef2uzVw6wSm1d8RFpDAOB8qcjpo9GOmL+aapKvyjnOF7iDOh3GmD
 TQ6JTc+WNkmw8EoHvJYwHYw0a1p+iajJu8kMSzzgv9wUX3tvPydKLjiN38QvrfzeO4y9
 vtZw==
X-Gm-Message-State: AOJu0YwF8yq0T3lC3gDFdJLDTg6ZygpnOVQ9WnNPiGmuIqsZIMCEATnT
 SETlTzeKTRMTkaBpfqm+duFu6OWDEHQpA2SDktvWTLDshd3dklyb0u0=
X-Google-Smtp-Source: AGHT+IH3mO/ebdS0n5OFpUA3CYIYRrIL+k6DHX/hkNUcb+L3PPMRJXvF2jDht5abI86DrWUlnuQB6cR/GNkAw4+uOYo=
X-Received: by 2002:a5d:448e:0:b0:314:1313:c3d6 with SMTP id
 j14-20020a5d448e000000b003141313c3d6mr2780877wrq.33.1696442332920; Wed, 04
 Oct 2023 10:58:52 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:52 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230920020558.1373955-2-sjg@chromium.org>
References: <20230920020558.1373955-2-sjg@chromium.org>
 <20230920020558.1373955-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:52 -0700
X-Google-Sender-Auth: _xZek_Cx5jMCKNtYTLIMewg1zJ4
Message-ID: <CAPnjgZ1Q3kOtYbs+beWe4YQzved6-e4iYfXTjDWsF24Qon-U6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dm: core: Adjust dump-sorting to get stats only when
 needed
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>, 
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

If we are not sorting the tree we don't need to get the stats. Adjust the
code to avoid the wasted time.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/dump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
