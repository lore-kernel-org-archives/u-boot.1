Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06024C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC588369D;
	Sat, 24 May 2025 07:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cT/RDprW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94AA5835D8; Sat, 24 May 2025 07:06:37 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4A2D83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-601f1914993so1007437a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063195; x=1748667995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R0bl5L/47ySLboVzP0mPAyrNzpnEdMUm9tLCUZnk2Yk=;
 b=cT/RDprW6F8AJft7EQ5jCE0/2kg/dsZd55QhwxMPtE5By/7esnqHjZrmfSHfrqqGBG
 64BsWV/9vmvr77Jbe9ROQJVBQF0lGFlcz1MANof2x4hR0o4R2u+B18Q71kYStSzenB+R
 bJusRk28yOV4lPr4cnn7mbljRAcs83Fsksvxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063195; x=1748667995;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0bl5L/47ySLboVzP0mPAyrNzpnEdMUm9tLCUZnk2Yk=;
 b=TbF0W8Ea4OVWhFop4TI47BAGyyuGixrTNdQoj4sXxOysppglQFmpdfrNQ27swcO3op
 9781KQuXObsD2cMkcx7E4VjhUhxpnrU3OyN8CAiPH15hHetRCTTJvR0kZ4yHPeejAbIt
 oSNtswn1xcMbPMXCedBPD4EKR5Zx/MfhgJEeGIg5PYgqc3VOljZUBNuS3fDAZdQiV04F
 xRsTzmr9QsrfFcir3vwRDGoTpphZFcJlpkcQWRXeML+SMRA+s0/q4mFEP7L0ckvs3cO/
 2saADXxXVOEQXR1AIDwDzTMSJ3720Ys8rWFdVcIcTonQynj4m72AmjhjM7n+eVheaY4s
 RoAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOMJyLzSb+yrwtg+OB80DT0rdZOnpRoBm5D+jIrSgtUfcztfIcRIfNxtCr8sC+AckD3CCHg90=@lists.denx.de
X-Gm-Message-State: AOJu0YwNe6JPQmbP5xrjk90fe9XP4vzXkXKsvjMfCfwkUbQj3JHhukWV
 5qSctm3wUMnTS1FvkalnCh7YeS3X/5Vhgnl2CrYF0GgPD0sjyA9jFtGMRyoR4sINnJq1sADE4Jd
 APEQFFlrs9wSLd4bCv4X60KC8Mfg+glkho+eb22Gu
X-Gm-Gg: ASbGnctXR3NTZjh9MkoShcEZRDL3KiH24b/NM4cDUsJlJx4nEwLFlgEjMR1HWDJVY+N
 sfUKGvm2YMvZpGTZKLvHK8f9faBfnqtD9xxll7drUKFeQkAEPqOhSxBeGZRGF9te3Wncn1OwjiB
 P8PGsGJS8aewKWDvNdvPJrzkUdqhVkl+g=
X-Google-Smtp-Source: AGHT+IFKRryXabQKYp2fGy9rejOI5kAUjAuoTIQF8W7p0lBWWGrhaU+fV0/EgBNIHTXkj4bonptYBSHlkqxPcZLhqy0=
X-Received: by 2002:a17:907:3e06:b0:ad5:27f5:7174 with SMTP id
 a640c23a62f3a-ad85adbbbf7mr146089966b.0.1748063195152; Fri, 23 May 2025
 22:06:35 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:33 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:33 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-5-sjg@chromium.org>
References: <20250510110535.1453745-5-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:33 -0500
X-Google-Sender-Auth: xnrKPckhIQ-_CS6_Hk2GaLsu9tQ
X-Gm-Features: AX0GCFu0qkyLaKl62ppHqPRXxJmZKj5eznb9dhzqitIa2Nk-w1tLdf5EgM81jCo
Message-ID: <CAFLszTjjaRua1xq=C=v7O62fq7qs==z=74T=+QivUi1wN54qGg@mail.gmail.com>
Subject: Re: [PATCH 04/25] patman: Use python3 with /usr/bin/env
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

If python2 is available then we must specify python3 here. Update the
test to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
