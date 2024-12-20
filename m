Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA302E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808B0803F5;
	Fri, 20 Dec 2024 05:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DZxFD27j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6B9803E4; Fri, 20 Dec 2024 05:07:03 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2098036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a68480164so247169066b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667621; x=1735272421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v/aIH+nHi+t+ZOEtxnFrjUMCLVKlmpga9kMp+Hkzh0E=;
 b=DZxFD27j7EtYCAef23nqkbpKkrGBDRxWmy+joecD3rlUcxYG2NiEWZAixQhnlPX4uv
 eBL9vmf8Juy4lcUko75wAT6T8gEcu/5QZa7B2YaXVMrbWZu5G17HIgRQy95BgrTgk2yL
 B5eMshRDO1cB+TNRK6dVKATlXpdKiRucDxMq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667621; x=1735272421;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v/aIH+nHi+t+ZOEtxnFrjUMCLVKlmpga9kMp+Hkzh0E=;
 b=X5F0LaWKTmebIWI2h1Eq3+V7uNtZSACQpWt9N8iCtK9BA3raELHF8tPWEo8zFjhn0y
 SQtRlv4T6fBvyzw2MIgcDLxVnsx8LnF537tyiiPTOP4Ax0xd9WqeeZjJUfWQAjJPZkws
 N+y7sKkx9JYuARXdJaNG+rmrHTD+TGmLJDK+tg6YFEcbRFWpSthwggc1scxzUSinjbCD
 Mrh24iSr7xHxLfQbfIpYuopxe4KIXMq5HULkR2zkyIfMsnOE5nyCh3UDO0Bd681YgyTM
 sPGE4bdXsdr4u/qRJZqWLnA0ls79czhx6L0XR6XaoSyXCx1ouUyo3O1jpKXHFiL0uDKK
 vB3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW1RpligHbweOYDYO83mvVBYmzfQFCNAogPYNtwZ0FHYchU4wmGMNnWkZ7Nvi0UlUz429ZN1A=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+50YhAgnE82Rm/c+eX0YXw7T5AuDjnDlzIjArlnhOpqpeDpAW
 XSd4mJP2pq90KCQX7cKGD+qb0S7fqNkSrUcqyod7Hibak+Fu17xHP9qSM62bepebqGsIOmvriBE
 X9j22AceiFmlAS0SdWBtGZkjCcOqdtqZmWOlY
X-Gm-Gg: ASbGncsDfkRi9fUg/6vzvP4rocO0LMQxd2qqzdnqxVX2qE3vR4ERFtXHb93yOIX2wXv
 TU5kaLCw3sgq2QFYcXbHM1UsJMNeibbRmV3TmnnA=
X-Google-Smtp-Source: AGHT+IEha4H+9FWVlgFM0/nrtQM6pdC1cPSn2020BJ2XRypbVoIoXwT/J0L5iT+LO25fR/KutvCklomHQ1HQtlDzW4k=
X-Received: by 2002:a17:907:944c:b0:aac:61b:580a with SMTP id
 a640c23a62f3a-aac3443bfd6mr96284466b.61.1734667621284; Thu, 19 Dec 2024
 20:07:01 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:06:59 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-3-sjg@chromium.org>
References: <20241206023626.2456858-3-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:06:59 +0000
X-Google-Sender-Auth: wZVNlbh6zT4dSm1kCB5tadlq_8w
Message-ID: <CAFLszThqZW_ksDd70duHSnVGK8gC_b0U3ziajBHDy+hDFyYYuw@mail.gmail.com>
Subject: Re: [PATCH v3 02/46] x86: Rename zboot_run() to zboot_run_args()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Rename this function so we can (later) create a zboot_run() function
which looks the same as bootm_run()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 4 ++--
 boot/bootmeth_cros.c  | 6 +++---
 include/bootm.h       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

Applied to sjg/master, thanks!
