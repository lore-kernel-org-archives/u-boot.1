Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D8DC47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3619A87A77;
	Mon,  8 Jan 2024 01:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fo8IyM95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A07487A3E; Mon,  8 Jan 2024 01:16:18 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54EE887A37
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42989a3c333so9353941cf.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672973; x=1705277773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fNW+bYfTKz6wHYIk8ncieiE/7XuYfpvHGwxDXXPbmAA=;
 b=Fo8IyM95NzCra2We7vU6SBnLRyq8lAUguVEzHJv4BmPDvgmhNWJ5IeTMc/f8zmxmYN
 ofW3BEvLvqaE5YcwIi7kB4UxZIZRVYHgUs/KwuKWMgZUp0zZjD5HSty4kLp++z1Qvnz+
 YtnzYlFwIazqjOzS1i5x+nI8HH0ENc9jBkqCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672973; x=1705277773;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fNW+bYfTKz6wHYIk8ncieiE/7XuYfpvHGwxDXXPbmAA=;
 b=FqkPOrj7kcn91n3GaD/GOiM23/kHVPvy+kLTLvdJ+ai9D1tnhgwnTPjjpTHuc7vwJg
 KL/QohCtJsZUu/tyCRj+U8TAeFfvhzHT49bjrhid0BZJvg8G78Mq1vl/9iTu4290HEpm
 pWo0mks1O00JokSTSzfKsssR6Wh0moNYkph1EYrWVOCD45PiwXlyqTZEpSoVy5Re44tq
 ToR1KQlFHKh3k+8BqKrRpkFsV9v55DBV89I4wXh4oCoNRH31LVRPh2uvXmjY0mtN7HDL
 qaWDRqhvR1spXwH4F+9P3c6rzS4/mKazXdZKSxbBAohA+3GWlgmJ7wTEEib3av02YVA7
 fSLg==
X-Gm-Message-State: AOJu0Yy7Hgm5C+8vs8DAnA255o/WmQdl8uSk8HeSgH2A8LVFSkl8VdUg
 dmdRC8Z5syq5UIcqkGBuZ2C+9V3FmUpbo1rXkSAnZv21M74e
X-Google-Smtp-Source: AGHT+IFm+3Nvjy2imAuReoS6DoxnnndcEVZOBvp7XWz7jmpO57qKRsCF3lElDNxs6MlOpZEDfBPc4tplVa3YjNZtoDI=
X-Received: by 2002:a05:6214:252d:b0:67f:adaf:4353 with SMTP id
 gg13-20020a056214252d00b0067fadaf4353mr4535795qvb.92.1704672973342; Sun, 07
 Jan 2024 16:16:13 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:12 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231231152555.464874-7-sjg@chromium.org>
References: <20231231152555.464874-7-sjg@chromium.org>
 <20231231152555.464874-1-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:12 -0600
X-Google-Sender-Auth: mgECQcWj8pjBdZkvejZ5uIBcCaQ
Message-ID: <CAFLszTjE0yt4jFBYqTj4=bmp2562f02n_WahKtJuxtX7+5bRVg@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] efi: Use the correct GUID for the SMBIOS table
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

EFI does not use the 'anchor string' to determine the SMBIOS table
version, instead preferring to have two separate GUIDs. Use the correct
one, depending on the table version.

Call unmap_system() to balance to the use of map_sysmem()

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)

Changes in v2:
- Add a note about why unmap_system() is called

 include/efi_api.h           |  4 ++++
 lib/efi_loader/efi_smbios.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

Applied to u-boot-dm/next, thanks!
