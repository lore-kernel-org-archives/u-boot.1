Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407BDC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BCD981273;
	Thu, 27 Mar 2025 15:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O/9XkME+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E96281951; Thu, 27 Mar 2025 11:06:40 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE6E8070C
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 11:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilyashpo@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f47ed1f40dso5616697b3.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743069996; x=1743674796; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=++r/KmHo/v1+80NbbWdRxrq50CCdAVsmATSh9XXcV/4=;
 b=O/9XkME+bV7EV+Xdp5HfJjub6Eq9wyQ4cfc4lTVXvoYIbtro7ROGZguzRbbIvrqF8t
 QPzZ+pQqjFdk0rP+sWJRGNYSiWmH+13+Zyndj06YWRnIyP7SAh6rO+DsvOMp/+hWGD4j
 M9A67uAe96MnXFTSVFZww5Ew9Cysl1gLDNhCBJYohdbFMNAQtP0HMam3CQVtkqxOXiXF
 xnKJk1JSzwL3iXwsBQdfpLitm9M/34G7mNG+czT0nENfP7DBYLZfR4N1tV5bIGX6mUtF
 fGLgyyLB8soyBHIsGfZ7hY61TBOjKLx5FvKxCl0rD0pruW6/acxd3vc8WnqrA4V6cYHP
 GKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743069996; x=1743674796;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=++r/KmHo/v1+80NbbWdRxrq50CCdAVsmATSh9XXcV/4=;
 b=cVUPd6EGQYoUBKHTh2+WCy5J/ZrDwndKiLp4DDqYrIAY7DlMaDAZ9dkSMZ0RwD6wEm
 1UrdL2xtTN1ys2Wif84KakKs0WOOWGtTojSOdeIIn8LeeXND+fmpvx8cp77ophQMPXos
 0rsYz2UcmssgHocADtFwpzhziX1kuLVa5smzuMtsCW18kWc+6UmBb613Q5hstvv1DWRI
 GsR0zExMYHPcOBx2sNDW6dGPDz29vrnyXQ05xbdYJQYdWp0yrdgwH7JV+Lc/wV2A1Fc/
 pDDn6Ptx+aUkSFBa4qBlxDymEykM4jWAh+An/LcgQMpgB/3ZCTRrs8dVS0T1lmoejzAr
 qEYA==
X-Gm-Message-State: AOJu0Yy7h5xiZNl7pXsUjeYdfjSZijB+ihGU0ujj5FPuiTpmdypZilu0
 Wczm3FcZxDrjiiKUjFTpsNhZbPKQAKKR7o5tlfIjV34gF/Gw0gRWPvE0gIF/LGonH7Rml0up1pF
 IS9dva2RQ4TX7RqwTOvaeqezfV8D19hcY
X-Gm-Gg: ASbGncv0UBUtJDy2w6rRNmqfYUk1UkfmJp9TCxu0lSsBoVaG21UnYKg9nzA0cv+MIX5
 60aswuYWzrwDLDWsfkIwSyjMsSOw93ao27QIftDa+D3q6szc5OzS0IUpc6IR4NjP10XGb6xb4GY
 lrPbcqNBM34d5nikUFa5TadCtxCHWDbQn3K2Q0PmI=
X-Google-Smtp-Source: AGHT+IEcvI9JiH80OnzgJVWTWr5xeoVi2ZpJW/yX5Dkl2PrY1gBoMTUXS8YKeo7UPOTUw5flVug7tcnn66Nwy+GEVkI=
X-Received: by 2002:a05:690c:6ac7:b0:6fb:b7b7:f1e5 with SMTP id
 00721157ae682-70224fb7efbmr35220637b3.14.1743069996320; Thu, 27 Mar 2025
 03:06:36 -0700 (PDT)
MIME-Version: 1.0
From: Ilya Shpoliansky <ilyashpo@gmail.com>
Date: Thu, 27 Mar 2025 12:06:25 +0200
X-Gm-Features: AQ5f1JruBX41vHIH_15_o7ILdxIH8Sfl4CeZ0OvV1hALXNMCR6XGDcZsv2Wjifc
Message-ID: <CAEKNh+D0sQCVHiTZgsFv4HX68H4P4xms63er7-BuCiPCWvTfxA@mail.gmail.com>
Subject: does spl in falcon mode support decompressing the linux kernel?
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 27 Mar 2025 15:07:52 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello community,

I'm doing a bring-up to a new SOC based on RISC-V and due to very strict
boot time constraints we decided to try out the falcon mode.
I'm using the latest 2025.01 version
I found a presentation from about 4 years ago that SPL in falcon doesn't
support kernel decompression

Does it support it now?

If not, is there any work in the community that is done to support it? Are
there any other alternatives?
If yes, is there any example?

Of course it's important to store the kernel in the flash in a compressed
form due to size constraints

thanks,
Ilya
