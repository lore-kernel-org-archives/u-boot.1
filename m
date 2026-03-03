Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10052EDA682
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 15:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704D683F59;
	Tue,  3 Mar 2026 16:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Me2LR4YF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C84283F64; Tue,  3 Mar 2026 16:15:16 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0FBD83F4C
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 16:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0c83so10856102a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 07:15:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772550911; cv=none;
 d=google.com; s=arc-20240605;
 b=PUYp4smtgARckSYHe0+/R9IxcgF9z5Qdnl1BPjgtjL8oOO6Nqw+fpW1jYfs9tEMdBQ
 nUbid5ZtJltlSuApqdF0gV5920fteh/DuEWK1ew9Kjz/dCt3BSzKYi3DO3jIGPMVe7HY
 AfyVAUQjlBaHk7hToZ/29vhELCR+irXt4InGWKNbs3MWYs/lqJxPl8TXFdooZJe9CGk1
 ktBrSscYSH3VEBWO2Kbu6cvaS16R9MME3WKLEtFyj6880EH0leKDAXqhcbswgeagkl+d
 VK8f/2aK0kvk/IYa//J1C88hUesO8EP5MO9xF0eIHZaN8F4kC4qlovqlfdcXLNHGiUKt
 v/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Z5q/E8NI2bSEQF0ffp7qIVml8O8oRNOAUvnWW8OzM/Y=;
 fh=suDv5JrB4CVFgHBtx7YFFacwTDT4cJoVM85+3rtRrhk=;
 b=bMbu2s8be6wJebAS/oNPgTqIXQKmCpB+Qc9MqvZP7YvVa1mgD8q9A+qULzcbWkUQ7u
 vyHrieMNDxRQN7O4dF36y+RIqW/som3RPWscHGoK/daVznHm2vuLmPsYJUH7/JU35fOY
 gjdnHqtGjbWDjL4COhAKHWZenMvAXEzQqhvwHmNSoBKW+EVy6VkbWKyGZ3/oX9IQlE1M
 RL9QNuGSwVcnTu3fvCWJymKPat5WYQGij9nC0evhHIEsD8kCNdHEunmcZ8SirOYnnZqX
 EwEHZ2sTBoOEZjLYZ0IuhZ5HwXaR83o3fk0ofUXC8NXbBPj1ceoJPCHkR9PJZDgVM9Os
 M8jg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772550911; x=1773155711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z5q/E8NI2bSEQF0ffp7qIVml8O8oRNOAUvnWW8OzM/Y=;
 b=Me2LR4YFz8LZ8EcLIifFT2x+rMPEQn4ZeKFdWASJz/+EKZMaUxS11Nu+UZW4bioIR8
 hG7u+CmNS+e00Q8tx/dOqG4sIeHg3WxdPUQv8rINDCxxdu3hOCB1hhZenn1TU22o+8Br
 BYUl9LzESnvPLsBF09lvSqDVID7J+OfgGzXBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550911; x=1773155711;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5q/E8NI2bSEQF0ffp7qIVml8O8oRNOAUvnWW8OzM/Y=;
 b=F9Xlxf7vJgVEap6WqWPucoBtaJRzfOA4NgSTPuLpuLdcmE3Mg5lx1GlR/U+XvtScdr
 oHmDzrCsYTRbOXdOuvIf3+etyB60ygkuCRVzu/QO3cM5VcBEP5OHFhS94tda2SBsk54i
 vRix2O4eW+rXWBnDbCz8HQaGRmGM+OEFJ35sP+IfPSKBKHxn80Ubn96qgzYHoHYt46HN
 mxYw6iPmXZeqUaDl41Nw1OeFrlynQQwAAaZEKF2C68ecLfMPbhmmOYcZE0kK+IC2nSMJ
 BEL7XVF893n4a2tacLDD99F+bGs2ftZJZBtAqY0HoRsbvtNidjmlf/DIkqsSHmeeTi99
 UB/A==
X-Gm-Message-State: AOJu0YxNaKxBfZWhHyx/cdPPAsWB4olVi+61rS0jIva7nk3mNAKB0EQw
 AwqrmPDsVy9gjdfnSBJ+qgCfNKJq1ck21Tx9jo241TycvUAShBDabGBf+kKPK0lYNJnoJusQLQW
 FU+l9w2mjEZCSbKtZjjoBufuVzyhF5tRzxNSqhsq0O8dHPFHhUz8m5A==
X-Gm-Gg: ATEYQzxesBcka7y/e9hjMTjze+DLH19Xm1WyE4MNIJNZjI3wrwT+c9A/KQzIVKd4NDN
 xykJMF7UCf/fxVzMMQ4j6+IOcsg13JbfTbmzZfPsrjdWsdssxipU4WTR34UM/8BXmNqECVMqLlK
 0h+/2nI4Xn+LiNT3ACDEEvSCFJqkitY6qo4BqosCSg40pD/S9lENA2J2HjK+tBvMrDIxfRMFonT
 MRWb9xLKqXeMP5HTBtjBbbn3uxLemoFiN3GN3uCt2UvaiCz951uIEzpUWxlCYZWx7dgTIgYSPbF
 dZLCrA==
X-Received: by 2002:a05:6402:2111:b0:65f:71ed:7ab9 with SMTP id
 4fb4d7f45d1cf-65fddceee18mr9788602a12.22.1772550911313; Tue, 03 Mar 2026
 07:15:11 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Mar 2026 08:14:59 -0700
X-Gm-Features: AaiRm52Ouc9WXLJqFtBgzTSPJBVqkOxYqKFkL5xlVB0M9CLBT-EeuBFWJVXRGLo
Message-ID: <CAFLszTgrGjthPK8uxD0fErNfgaGYawiv6ojF42sakLj7oVejQg@mail.gmail.com>
Subject: Binman and blobs
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: U-Boot Custodians <u-boot-custodians@lists.denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neha Malcom Francis <n-francis@ti.com>
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

Hi,

At present binman handles finding/building tools needed to build images.

There is no equivalent mechanism for the firmware blobs themselves.
Users must manually obtain these and point binman at them.

This is quite painful at present. Each board requires some splunking,
reading vendor documentation, etc.

I believe we could create a similar setup for blobs, where they are
described in the image description (compatible string) and there is a
way to build them, download them, etc.

What do people think?

Regards,
Simon
