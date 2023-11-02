Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5B2C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A3E8771C;
	Thu,  2 Nov 2023 23:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="acPPLQ4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9AF87716; Thu,  2 Nov 2023 23:49:14 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 608AF87467
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7b91faf40so17660717b3.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965348; x=1699570148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AbvrCpKUAMUn7JT54Ux55HPk44On26eoi3BEk8XqZiw=;
 b=acPPLQ4fbgwQoCgBCpIBH42AQIlPE1D30TAYoiKBRsPK4UDGJ6Uj7ylXMnvXDcCBZf
 MkOJjYJRHv8ZNnqVlrxTc7PWmkMow9WneUaelEJKu1JwwQDaco4WGh96q2jV/7yCQp4T
 O2YVCZRDkhIFTnZ4BbpMD+x1hYL3DEINZK35o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965348; x=1699570148;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbvrCpKUAMUn7JT54Ux55HPk44On26eoi3BEk8XqZiw=;
 b=FaF03v5iafeL0mH8CXL0YgnbpKbjJjbg14q06B80DrQs5jUBowkIsaybVKil5A6SHE
 TFKG87hSIw1a/k0kDGOETsbDwl8gdyER+ksMOf8lhTuSj7O8I0vxBg/6VddsMcnSU8+h
 tlhdEgqml0zMgiFtq7fEzDxI9YzW/nPP8TkRuUuEyDFu8745PVBDrsQ/YGZfgsqW0h1j
 D8TYuAYPO25GPMiQCdDrUEqvquAxXjA/0NLTunnnyFpRzlPgqkqhAymHI4GuEohOl6so
 kRBKk0wlTJIn9gCDDR/BIu9SD+D7DvpQPi04CRoUUdldgrlTheeI/bakHqlRX9B1+7hY
 uUfQ==
X-Gm-Message-State: AOJu0YzW8ToC/NJfbO3hREC/+4ljVakWNRNXEOHVZPKr4rnNAVlAK8ZL
 kPyvxToc1xukE7b/oqUmr51m4V2Y3qLUT+proMK25dE/hzbxU9J/VDg=
X-Google-Smtp-Source: AGHT+IGpi3XqQtGdKJfKA/drEUCWMn9AfjCH5o9ac5+fWi/6CKmwb6BLUQQoPQxGZlh9po3cpqHws8yLUBgZCdojtgg=
X-Received: by 2002:a0d:cb15:0:b0:59b:dbb7:5c74 with SMTP id
 n21-20020a0dcb15000000b0059bdbb75c74mr1045712ywd.32.1698965347862; Thu, 02
 Nov 2023 15:49:07 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:05 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231101171753.88754-1-sjg@chromium.org>
References: <20231101171753.88754-1-sjg@chromium.org>
Date: Thu, 2 Nov 2023 17:49:05 -0500
X-Google-Sender-Auth: gWd2oqT4aw7htPdnZ2O-eVV2Qy8
Message-ID: <CAPnjgZ2qrShdXjpVNmCVScU4qFLRNgP0GkJWUAcAE9wgr3SKsA@mail.gmail.com>
Subject: Re: [PATCH] u_boot_pylib: Ensure subprocess is closed down
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

It isn't clear why we need to have two different paths for closing down
the pipe. Unify them and use the Python to avoid this warning:

  subprocess.py:1127: ResourceWarning: subprocess 83531 is still running

Note that this code appears to originally have come from [1] and was
committed into the ChromeOS chromiumos/platform/crosutils repo in the
bin/cros_image_to_target.py file. The addition of the extra code path
came later, so that is chosen for the fixes tag.

[1] https://codereview.chromium.org/3391008

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: a10fd93cbc patman: Make command methods return a CommandResult
---

 tools/u_boot_pylib/command.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
