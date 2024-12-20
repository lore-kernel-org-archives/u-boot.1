Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130A5E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E27803E4;
	Fri, 20 Dec 2024 05:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kDZww2rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E47980362; Fri, 20 Dec 2024 05:05:21 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0A780087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa670ffe302so284282866b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667519; x=1735272319; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mH2IZD8smhxzb2ciza4HGACmEVcGNU4vv7fufMLqRaY=;
 b=kDZww2rnuUxqxSc+x8+GR87YKLdytjVgHmatVp0Dt2pTaXQKUTB6kl4dYBU2SVOqdd
 9zExEPMNSKZZ/P5KnTnrgjemB8o7oDn9lFg/HBHRmDucKji0SYzzC4/0BRS2RSkiYIDM
 P3pRHN2DUau2TdO+7RnsyXcwmR2930omS1gHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667519; x=1735272319;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mH2IZD8smhxzb2ciza4HGACmEVcGNU4vv7fufMLqRaY=;
 b=d7UrsY86/khqhAg4sneVWymA+4zdurelW7O3FTITR7AyksOVczwUYmCWUUXXAu3Jhs
 7ds4HVbN4vP31tbQrhEwUs+VwBaJFCpY+r1khM5kYCG0shJNAg+ewVvYBuxnqtZzJr0S
 jdNGZn2NUAy+AQySfc1NbB8dK+Xa3KXYcWwI7zHM2dbH0dFPZlMQNFAR8s28xiFWl274
 F+N5ybUEPBi8rHqDHgMYIohk/bsAviZtxiTxliKSdzrXX3Tk+SDdkeoGNWKY0D6yRXQ+
 kTRTZ0gdoHaHvXAFY/CsdjS4fKqg8AF/H9QZe7vsH4k8GR6eUYuWNNWNFkRsy5ZeLfGa
 xjLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGc7Ca0/R72TxYsCzu9MXd5b9MJLFZEZAsSIOAQtNyPWOQ+Ocn6iT/EeIwT0UuMAQUdOoUgBo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0uGUTXGzukPw+jFumzipIpK0m6BdSNijTqGz50WN5wnbaxjGD
 6Z+kVeQ2O9U8l2UGNfFbkPcf1NTlsii1HJMHuuyoKsW/uN1dot6JUGPo4obUcaazs7ifqed04dW
 ot2f8lxCiwM/Gp5cEJ3+kr7wBd3N8Z59gX4Di
X-Gm-Gg: ASbGnctLVSQRooV1dTnTcfZdLE+lkcuSsqZGq5FwX0aDM5JnjKpmxEsbjOcAE9HkUKx
 rsqLQYQrjs7EF3948OM5KTM/J7Tk1aFWj+Tu2vhw=
X-Google-Smtp-Source: AGHT+IG/Q8tTriS76zmRm39UWBsu9aEEFqQj7lOLtqxh8YvEWdT0LlJ0wt3KA+SHCDrWMj2gvQOBREAoYJ3s4AZTClg=
X-Received: by 2002:a17:907:60cc:b0:aab:736c:558 with SMTP id
 a640c23a62f3a-aac3368bd9amr93097766b.55.1734667518028; Thu, 19 Dec 2024
 20:05:18 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:05:17 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-38-sjg@chromium.org>
References: <20241206023626.2456858-38-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:05:16 -0800
X-Google-Sender-Auth: y24EJS2-CjrZ0KnYPOdoMy_aWug
Message-ID: <CAFLszThWH=xh9eefhrmok5GHU=pKwYHp+rzPOzORMRV-wB6-=A@mail.gmail.com>
Subject: Re: [PATCH v3 37/46] bootmeth: Refactor to put options in a common
 file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ion Agorria <ion@agorria.com>, Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
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

The fallback feature is implemented for extlinux but not for PXE. Move
the code into common files so we can keep both pieces in sync.

Tidy up the comment for set_property() while we are here, fixing the
return value and some missing hyphens.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Makefile            |  4 +--
 boot/bootmeth_extlinux.c | 74 --------------------------------------
 boot/ext_pxe_common.c    | 76 ++++++++++++++++++++++++++++++++++++++++
 include/bootmeth.h       |  8 ++---
 include/extlinux.h       | 29 +++++++++++++++
 5 files changed, 111 insertions(+), 80 deletions(-)
 create mode 100644 boot/ext_pxe_common.c

Applied to sjg/master, thanks!
