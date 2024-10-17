Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D86BD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC18890C2;
	Fri, 18 Oct 2024 01:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BbsQM7YU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 476F889059; Fri, 18 Oct 2024 01:11:40 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2F48909E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso8163016d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206696; x=1729811496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8SmaijM7rBx1T5/mwfng2rd7HXr/P6Cq1wtz3EirfWo=;
 b=BbsQM7YUOBrWZ+TkL6lE7l19jkC+ZnUVEFtV/QwMgHbnwE7nUmyo3qPFsSDA+1Rla3
 ZA9RybKzzSrU5/csfwQggOiTLSPpXfKKCa1RBCZ7Ng7eWt5Mxj9/QuCM4rwioUJAVQar
 16fisu4jo663P+HR9l1UohNDFdWifka7P5p9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206696; x=1729811496;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8SmaijM7rBx1T5/mwfng2rd7HXr/P6Cq1wtz3EirfWo=;
 b=LuCFOh4fLPnAUSzWrinyO+e5uNcIS14xkvmJUQ0oUSOrRsN1AkcTzNT4I7gLAnhpHT
 JCBEfitCnOx4cvmYxUIAW5t6g9GttK3gxdPZ9yOZ0MVqbWfgn4niN3MBw9y+ZQoanHs9
 J4VQVSLj/JfhZz4pSZCpSfbi6cL4hiZzQ/qSfVdE4m4XM/hEB7aTeFna1V89qVax1bcr
 iyIS88FcfjImiA8iCp0AiPExmpMGhvGVkAJksHfooBh23vwXxKDQ9v639JQ72m8ff7zj
 u484OnDajmhH/S/V/YsoJ/AN3MGSpazl0E7DRWoqn0fDSiiH6y/Zj0drRgy0x94jFEa6
 gd2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFKXk8/B/BdAVfFVuRSPflPzAORZ4/r51It/Wgg5EPPLSmRcQkOPFSPKc+aJDk5e9pSj1igc0=@lists.denx.de
X-Gm-Message-State: AOJu0YwC0f3EQIlFIKQ3yBlPNrcvgeOV/RGkBBZYDhZGx9ddFFCv8aVn
 AEK4eKf4bk1SmiTDRDuR17OQNYKiPJ2UtKzHYHlDwRVm3TzG8GP3twOTKWb0xHovYNOkp0dBpRv
 f+eNfNw8eiwMOoZ7xkPIj/zgLKTr3SS6+DhmL
X-Google-Smtp-Source: AGHT+IFjfBQqQTOQeFxFx6PmnaSiFKpqbvUKgLy8Nly/427EZuJE6TXf9a7zGO4pfxJizy+OOLNtzHxVpvzJzgAKxGI=
X-Received: by 2002:a05:6214:3a01:b0:6cb:e860:eae6 with SMTP id
 6a1803df08f44-6cde14b8d46mr5006776d6.5.1729206695901; Thu, 17 Oct 2024
 16:11:35 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:35 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-10-sjg@chromium.org>
References: <20241014223212.2212442-10-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:35 -0700
X-Google-Sender-Auth: 1luA0mdQJr9LeVHNorO9n1PDLaE
Message-ID: <CAFLszThxR4wm9zKYEXzU5t+TU-86L+F6P9DUxBtqf2R12bj6hA@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] expo: Drop unneceesary calls to expo_str()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The scene_txt_str() function calls expo_str() so there is no need to
call it beforehand. Drop this unnecessary code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo_build.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

Applied to u-boot-dm, thanks!
