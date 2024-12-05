Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4DFE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BF989274;
	Thu,  5 Dec 2024 20:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bQTWAjs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033A58952C; Thu,  5 Dec 2024 20:56:02 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CCB8919B
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa530a94c0eso272808366b.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428559; x=1734033359; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eL1GdABSWTGSyMfJ7W+t9fPytwu6PVnzVT0n8TrlbDg=;
 b=bQTWAjs7AbL5X/5i0EOVAI8TrP38JivBYyiJ0Jf6c5GSGH4yVMhP9LE3oaPTMJ02B1
 wqlQuuMJ9bK/eQMKH6/YzCJaLvdO5GAOIBbgHN57oE8rON3VHd94ID39TyWSP1z2LTxR
 KIcl8EQpqicvQrQFasmyMo0NCvLynknOdSS84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428559; x=1734033359;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eL1GdABSWTGSyMfJ7W+t9fPytwu6PVnzVT0n8TrlbDg=;
 b=OHbtie+njNyECWsl7AV91U6f0/8VG6x30h9YMNHBOZNXWK3ZoehympcUc8UC+tK4ZW
 LIZKZKsklXqLvE+JXiJvQA8mMl4wvUbCxUrzo987mrNnovXME4353R/YupWJIK9FYFLT
 h22Z2GL4fcgWcPMoIDA02rd1zvD39IlrMDQnt/mMOw9iQ9pwoJ7HPniVcfZG/hJo9EWF
 nq2imrzkQ3ZyRDnNOoeze1lqAHgamY2FfkDZbpfFPmZIDE6KePvNdeulNQ624DeLzYf1
 af806qTb5L/id3vtrQ0S3bK6HO1iCgEkwx5gFfw5IZ5P3/UOpM6o56TTaRb77j2jG12k
 5u9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj4jeq5f4lduhgVB7A0IQWiFzBGzZiqzzDA6DPhkuZWGzfC1VaOoT412ch3x3pw80EdO+JVAs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy0DSaGCDSLTi1JUmTzm1p79+h/dGTartXKCaByzWQzMbvdk3C
 Usq3Li72M6ztmQV7Xe2pj4VXVKnU5pcObTl6YfGSEpd/aEnJt83bX2zrWIprYAj6GDvA/8/kC2u
 IajZX12uKQdcJ9xYbBuFFuSRP20EnDGmwqj2w
X-Gm-Gg: ASbGnctJuwEq/fWObYtp4UypK5CZaxiOabZD7iv56rMRLN+sL0MQKODaNNA7Rgt6yo8
 dAz/jyEMJRqTX9nq/QSqymqdxP2//eJZn
X-Google-Smtp-Source: AGHT+IHHVXuP8Odx7lkpWyMgjeEsic4sj4dRkCEQuN+hU7fc9W97lC+dFw1QoRfwqseDqHWR2X/XFWcZ80uvedXlwOA=
X-Received: by 2002:a17:906:cc9:b0:aa5:2817:cd34 with SMTP id
 a640c23a62f3a-aa63a266626mr10324666b.57.1733428559493; Thu, 05 Dec 2024
 11:55:59 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:56 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-9-sjg@chromium.org>
References: <20241115231926.211999-9-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:56 -0600
X-Google-Sender-Auth: i7nUflNRtuiz9VDk-4rSKL5rNfE
Message-ID: <CAFLszTj2Ksry2aznNRE9oX_t==AoKwFYPxhLRhK6ZA7UjGEkKg@mail.gmail.com>
Subject: Re: [PATCH v4 08/19] boot: pxe: Drop the duplicate comment on
 get_pxe_file()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, 
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

This function is exported, so document it in the header file. Drop the
duplicate comment in the C file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c | 10 ----------
 1 file changed, 10 deletions(-)

Applied to ci/master, thanks!
