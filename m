Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22803E95A6C
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E04F86EF4;
	Sat,  7 Oct 2023 22:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zz8g+ryq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C8A86EC6; Sat,  7 Oct 2023 22:38:16 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42A686DF4
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59e77e4f707so40448967b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711091; x=1697315891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IfDCWm+71HQgaxZSooI4g7H0OpsWald7vmkh4Gp/2VE=;
 b=Zz8g+ryql3eT1DPPEbp8Fgb6bEDxyDKpKzHBBTW9pQ7pCmRWVgklOoI3qHJ/wzRae0
 TZGJ9NdfV4lT2JO5w+FbAAGLU27vL+ksPzw/CYYd0YReYSrUQ8K0vvOsdmgMdKpeE2RE
 wSNdRZcH1dT+n1YSwfLolaz7ApEh2tyJVX+OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711091; x=1697315891;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IfDCWm+71HQgaxZSooI4g7H0OpsWald7vmkh4Gp/2VE=;
 b=N/oc/R4hGg6uR5qSipLEV/dqBHwzI9Z6uWSNL0GOaadHc/9Nrdh27KMn1gFnsksPYQ
 UlLZKPu+FIhZ9odwsuF/qy7ZYBjIT1DEF4M47r8HYSzVpia80rjWOXpkzQlgneXy1yZX
 IstKcKdMZPoo11siyGyLuO87PvqwmZznovjB7gQq3WLwj0uW2fBEkt4AOnbw1WLOAx8r
 uku7B3uiTPUwaS9svDwepVUWUoYW8+ZfmKhXxjZNzUg361mLjs7ZXh9X7J9ZbFElrG3I
 enVP94c2fO73lUphtks9lF4pPxZFQ5nQFf6inlplqsbcAbOOSd5q90o3IH8OCQDqOqcy
 KK0A==
X-Gm-Message-State: AOJu0Ywcd7ur094G0r82px1NzUX/PObmo3eJ5DgufJ5w2ccTVhB9llXa
 lPF9RcqJKrpfwvl6/DAzH5RZLs/pT32gomDUskvRFg==
X-Google-Smtp-Source: AGHT+IEpWx8u2G/3JcjulKovwDVZB9nMH3fhiqhJC9WL9UXDav/DH1faI3fKvddJDta2usM7WVH63Uhq4CdR8LUSR88=
X-Received: by 2002:a81:8351:0:b0:584:61df:45e8 with SMTP id
 t78-20020a818351000000b0058461df45e8mr12122322ywf.13.1696711090971; Sat, 07
 Oct 2023 13:38:10 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 15:38:05 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ3QgcBTw5ckef68MTzOspXYRST_ia1wz45enNtdoEaQvw@mail.gmail.com>
References: <CAPnjgZ3QgcBTw5ckef68MTzOspXYRST_ia1wz45enNtdoEaQvw@mail.gmail.com>
 <20230923194424.1739224-7-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 15:38:04 -0500
X-Google-Sender-Auth: 4jsiOtSO8u0pTeM8LE7wxxuAMgc
Message-ID: <CAPnjgZ3suLLVjK7z_WMefdOocZh8R+=YezO8N873P=RVEEFg_A@mail.gmail.com>
Subject: Re: [PATCH v3 06/27] moveconfig: Drop check_defconfig() and
 update_dotconfig()
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

These functions are not needed anymore. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 62 ++-------------------------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
