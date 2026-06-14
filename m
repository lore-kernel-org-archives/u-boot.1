Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5909CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B708E84105;
	Sun, 14 Jun 2026 14:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H/MpGz5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C417384704; Sun, 14 Jun 2026 14:55:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD82F83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68e5f7c1131so4064676a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781441698; cv=none;
 d=google.com; s=arc-20240605;
 b=CjZCo57dKDC+sTttwQ0jwUz2ulITfZZn/G0IVyjzXmxaQK7RS8neNri563DtP1rSW1
 HVQ5+k4ewYAWvSD4Jf7k93YT2ltxHd287gwukUboSkYjltVa+/vRyhuJ/uUCDcXLHo0+
 rsXiz463FzAHqpr1wg9Z9c1BERjgPy5uDgYZZ11RCWg374BlanWKxpI9azR9/9/oCuZ5
 W7V/R8qjwsMkaHmDFRVxK1jMEb/Y3SucDWVtNaq4Zyn1NGl7BsNtxRiCkVCeGHvaeE5/
 z6a9YhaCUSHbn+tBjLb7L9bQwxIaJkryR9jYDaLZStNtYXDQ8ZqQW+WquosLVUxiTCWt
 b4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rlBPI6SXY9jIgfY3udfuwOPYxO9uVwgPGi2oRvB28Ww=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=dJsdf+dNXlaNFy9lyQB4vGaLc3vWXiJgwgbejh8s1GmkYMs3//0+4f+NxJdCxm26C5
 6euaWdE6Apd3byzEdbFQutzfBB7yCKIZQCNohTM6nSptSsDWu8xvFUz62cf7hWqUvhTI
 QP152cGO7n5owEs/A4XQM3v13jgUhARYkFW4eIAEguumXhjGKoWlKKB0rl+GbW6t+RRf
 7tZ0zxhr9IMBnz4lNr+jWLSabs0vbaSs5qFRx6X71UiHK8mEusHUnahX8aJHIw+JkgGC
 VzwoF5OJ8aIIXMJJ1SKiWiGShOo93g4xExfEs9LNN015VmyfGGCeVwUZ28ozNljo8Q3S
 GLxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781441698; x=1782046498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rlBPI6SXY9jIgfY3udfuwOPYxO9uVwgPGi2oRvB28Ww=;
 b=H/MpGz5yfFsgufPvzaX2eT+/WxjrFFxPQ1DiLgw2yRsiEQTRb8nT8DodvUxmgWazBa
 cHTEKU0ElNfL+Fmh7ZUUiIEEbxOxak5M5dPtW6HLpJCueL2G6rScn6klmtxX946Wt9eM
 pd5SVeoBhDTiPhnGiPFY+zz/yfGBoFaX0pwf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781441698; x=1782046498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlBPI6SXY9jIgfY3udfuwOPYxO9uVwgPGi2oRvB28Ww=;
 b=Kbx+tIQCe68sLu+hxULtjxuExXDbGanJpVk30k40Zjm3aBrRKGTWDr26FoyGZRbb0N
 3Z+rZu2lCOAr8UZRov8J4CqYUM3FzqXLN9QhJhVXzKXmfpLF47QO2OYDmyJlxdchoy3r
 gT4zMy6aKT3j0Y9cy5TgtymUtWxhI94t5QRpfUun3cHj0niG7KVrA3spBxiVhDz2OiOf
 hnjD4oTOb0TxuiL0a5TZq4rTX4/a12Rh5f8t+Ecg4l0AN1DtgneLDCUsXu6gLo29+sEs
 VdQmywzTR5z/iLCeq6B82Ws4kjo38NfXnCku9Fd152inWVAeoulIEYg2v20i5oASJN4z
 a8MA==
X-Gm-Message-State: AOJu0YwazNwauMCPwGsJuokTIIXcaqOrd/HrpOfGKgSyRuns6VHZ729g
 +uF9dxwx2RBCnglY3jQCWyLZpN8jJuEC+9FenudOShJaX4OfELCZJtOLwvvORsRdzoFq6rmBoTp
 2lkC0c/IVdlOf0wwG7/V2ocgeCEF6XE4lBXDNoIsC
X-Gm-Gg: Acq92OEEX8yvCklHkuJ2uHXIavzQ1WHICugmCp7Jew0LSI1kveT19HbYQDKqU9u0NlK
 jP5Rih8F+J+dCpEjIJYVRNOLRPaLYPalZ4PHRgCjV5JJtLKCVDJ3aSm7k7e0SjmuMtn4zkJWXrf
 P8WiWtVSM439D4TRtl/XcjNgFfzNP8A4jtSe+6ar2KP8PWKyO88dkm2WvSW31ZRB3cx2GmKCKQT
 BTdi+iBWw4GRhiBwRFrltjyRUJYEJG1toqL5TqHbN6d79eb5sLsVNwBgl6PF7VWV3YJFxDbPc3S
 mGaTvMzKCLHe/KfF
X-Received: by 2002:a05:6402:1589:b0:691:ad86:ac51 with SMTP id
 4fb4d7f45d1cf-69378a2f745mr4218147a12.20.1781441698119; Sun, 14 Jun 2026
 05:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260611014843.3735672-1-dmukhin@ford.com>
 <20260611014843.3735672-2-dmukhin@ford.com>
In-Reply-To: <20260611014843.3735672-2-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:54:46 -0600
X-Gm-Features: AVVi8Ce3Hkwh75TuthryW54bc0A5hcbkzvmI9RU4HUlCGJ8tXdYD9dbLUvSXRis
Message-ID: <CAFLszTjt=1aSyS38_BVZS-GuivrWvDOv=MRu=_gnYQrx9NMmSg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] bootdev: fix typos
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

On 2026-06-11T01:48:41, None <dmukhin@ford.com> wrote:
> bootdev: fix typos
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> include/bootdev.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
