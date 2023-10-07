Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8E4E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8748A86F14;
	Sat,  7 Oct 2023 22:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZYC39h4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228F586DF4; Sat,  7 Oct 2023 22:38:22 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BCC86EDF
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a4c073cc06so37295687b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711097; x=1697315897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CjZdjCKzgotsPO/+H3AjW65ClIzbm2X0JOQcrNaGPPQ=;
 b=ZYC39h4WouPbR1Ie+AYoeSPL6IMaMXskc536QSbWEx/1+U3s7ozJabwQsV2+nl7D34
 7qy9hNd/t7JZoXmi9Z/gMc1+W7aJbj92EK9EgPUCAmPUUMkX9Q1SuiRoMnFLovCOgZco
 kVy35r48Xnj6/HeCkScQEIqHh5nC5N4FZmtTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711097; x=1697315897;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CjZdjCKzgotsPO/+H3AjW65ClIzbm2X0JOQcrNaGPPQ=;
 b=SX/43ThPSDO60Jd1ylIrnkerzFoCxA2QthJYjXdutdEy8Ctrg8Z4fZmTdtbjBYgPVW
 lPRACj5CtE1qF20rBAzMb+/zW0ANV6K+0GtzKcSK9tv0E87dbjLLvzzNE07sOsJ+NvST
 Xvs2w3uwMmwRWufiecdL48QvCJuvveAZr3XfhiwNjJD6Z5qppJGbrtulbuuawSX+EuZ3
 s/GLJY4MdS3cFrVZkgpWiORQUDCb3rnBHk4fPC6EKdXSdJz3e1sWtTG+NFMt77LZp6nE
 70/VRZ6jjro/9hqdoukoENASiQTUGD28Vit9iA7ilYiyzxx65rEasZGsCEHbcWSmh1hk
 cq5g==
X-Gm-Message-State: AOJu0YwTPSPEGVbuZFWDZCCOB6jWUDXVzs/BL74Gcyh9nYhW17ouzCt1
 eFdqXcFxX7zFnbgFVQrKUxGz3NMl4fVcs9YeTahARA==
X-Google-Smtp-Source: AGHT+IFpgzy3yttvHheEUz83WtYwax4Y7p/430qYbL26sqNX2fWA3FmHalIcg6vHiij9mQhaMjL0NSZR9+zznp09KhU=
X-Received: by 2002:a81:49d7:0:b0:59b:5255:4882 with SMTP id
 w206-20020a8149d7000000b0059b52554882mr4449911ywa.20.1696711096680; Sat, 07
 Oct 2023 13:38:16 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 15:38:09 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1PDDREkQwDA0p=EwOvH-SCs+Fh0+2WOF9MFXuu-tN3Vg@mail.gmail.com>
References: <CAPnjgZ1PDDREkQwDA0p=EwOvH-SCs+Fh0+2WOF9MFXuu-tN3Vg@mail.gmail.com>
 <20230923194424.1739224-4-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 15:38:09 -0500
X-Google-Sender-Auth: NfUet8VJMjTTPTUDNHZ74nMTnno
Message-ID: <CAPnjgZ1v4YTmkKwO1x79Dihqwbqfw8iRUGHwmK8ppyk22E83nA@mail.gmail.com>
Subject: Re: [PATCH v3 03/27] moveconfig: Correct ordering of asteval import
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

This should be after the standard imports. Move it to avoid a lot of
pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
