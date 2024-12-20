Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674B0E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FED8021D;
	Fri, 20 Dec 2024 05:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FOMhem5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B698021A; Fri, 20 Dec 2024 05:05:40 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A095680087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so223450066b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667538; x=1735272338; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hAtXizmkuEHj3yMIqNcw6CNzNo8bCM2CyZAHDCGRRrg=;
 b=FOMhem5MQHE+uMxHBjRZ22vkfAS2t4zzcLYGdAhjvQitjRp/za6oh8R8Dn4nbHRZN+
 C0OSOCcuz1CBcQdHI/qPeqK9AnEr2sCBg9ODK/wpGYuxuI1iMskp7eo74tmRVOKQnwn3
 +u0ExsxpITZSBm8wP2rbhf9jCnL5MghrMBbVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667538; x=1735272338;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hAtXizmkuEHj3yMIqNcw6CNzNo8bCM2CyZAHDCGRRrg=;
 b=CH2IxA2IArwnzYLorH1AI3xMrS28/ymeMmp8JrOPjVfNE6u3semYft4mB9W6BQMSrm
 mJK20pDTfN7UQfBldN/9KhDbGupDCRPt7B8q9XEyV8RmVE+Rzbw2bCpgoN4fjNBPc3eR
 2SEIF+VxfeNqsQU/Z1rls8QCix+/yw2CUh2DJzHwSEQArTlwYY+bIlObc8nu68pDAoFG
 rD5MPjyhzc7cAFdftlyo/YngC9bCAvNCaElYXmWv/PTrEjsT6R2DfNku+h+b+da9tAAd
 rD8sop9sX8sRBVZYyw+7SmE4VhDVK/kc0DOWFuBFUdfQql0t6vCDelAzW0DafIHoP6Ye
 u6OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq7fRY+FnvDwL8E+3pDx7+46jB3fTdh3J+Tg8thmrcvV68w9RsqZos18snKrlj2gmNQHM8YKE=@lists.denx.de
X-Gm-Message-State: AOJu0YxsddA78EugH91f89OOfas0y7SjXYMuNX7EwUd1LggGfusZMGx8
 7TcYnmd3a4q0K2gGdGNYQTPKRJF/mda2ieXIKt1x3QAvdEgO8Dza6IWWSDxkxzD4lhEbsYJfk+G
 gQIDU2PvhGKYg6xrMgOoyoBVakDsWiYb+7eRkAd2fXhIQ9hE=
X-Gm-Gg: ASbGncsm8BuBTEvLs+hwOtPmzZxD/fbIU1UsX1FKJFUP4y+D+VOoMmXZMAifcvAtHPY
 tvj6FOq4BXVwED/p7CcnMH9LC+2Zh+r0X1C82LJc=
X-Google-Smtp-Source: AGHT+IGiJe2+jkQqkCF7mDo7hWzLF9PKvvamHbtQfZF+gjVXPSYNaFWJvNBWOUnAKvpc+t19tNAgzkI/EgYosOtrH4I=
X-Received: by 2002:a05:6402:210f:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d81de1c921mr2482831a12.32.1734667538113; Thu, 19 Dec 2024
 20:05:38 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:05:35 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-31-sjg@chromium.org>
References: <20241206023626.2456858-31-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:05:35 -0800
X-Google-Sender-Auth: _YlaWYV3YYWNNxtLHv5xQ5Hupjg
Message-ID: <CAFLszTh641qoB2YD2RqUO4b4eaEPzbtPdwWPJY011gW=ZrciCQ@mail.gmail.com>
Subject: Re: [PATCH v3 30/46] boot: Avoid using the cmdline in bootmeth_pxe
 and pxe cmd
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
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

Use the new netboot_run() function to avoid building a command line,
when running these network operations.

For the one board which uses lwip, it is not quite clear how to avoid
using the cmdline interface, so produce an error, for now. This can be
figured out later.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_pxe.c | 16 ++++++----------
 cmd/pxe.c           | 21 +++++++--------------
 2 files changed, 13 insertions(+), 24 deletions(-)

Applied to sjg/master, thanks!
