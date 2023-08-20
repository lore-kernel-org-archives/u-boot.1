Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363E9EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E812286EB7;
	Sun, 20 Aug 2023 23:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MFbW6WhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4E586B7E; Sun, 20 Aug 2023 23:57:44 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 935F886ED6
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso3759581fa.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568661; x=1693173461;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kHf0fjYWOzXiTvb8yctBHzRg7SMbQAL+U17mmAhIskw=;
 b=MFbW6WhQ3ga8Np/20Z5hQf//XliJ16K+rUXGR193olP1kRTDWrs20BEDdFTVwMu4be
 QAEuYKqTWJg5zRZKH2ZUI9HiajIL3Dm8qBlXgq+pIVxd43Z9z++O5H0Cl3tRjLolC/Q6
 KPYFBqz6qzUMwKbEzXm5U3G6ZDWw9v1orXMws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568661; x=1693173461;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHf0fjYWOzXiTvb8yctBHzRg7SMbQAL+U17mmAhIskw=;
 b=a+tOwTgJNRXETlmK2ATuE3X1pvdsRxEpdFKcO2QfzgWX0ignhI37lNaBE9Fb9/oTls
 34sT1DJW/bGAWuy2cvjdE29PXm42iJiUWMkKEza1CvpegN+cQjak6oLBzkaPp+yFQ60Y
 KkjeY7qwoEdNgZUVtgyGlytVphWBHeUwBIk/dV5TaxGIIiAGuINx77gcxcC/LxYpYyQ3
 eydr/LYIwt+OiLupY+PR6OGhZiOHNetFUil9+aIzuFZ75QYEY4LgwCiQ3TcULkubIEF4
 0HOPC6APa94a8ymDHyl0K9mqCBRuQjKkzhtA3kC9pcteR7tregC2Yqc0stMqeis5VTnH
 vuKg==
X-Gm-Message-State: AOJu0YzR2E4FGZon8yjjgQQGYdYjdES19MVAkYjzp236cbVOBDfxsv7f
 H5Cj7k7jeyLuQJHdr1xXHOlhyfjfVrBccN8hBy0Aqw==
X-Google-Smtp-Source: AGHT+IFtcBikMecf5kXNmtKTkHiz1dcuOAczock5Ll89BdYe+iOXwUMv12ZN/LqIpg9C5kbCtl5oIJKcqcQ7u569R7I=
X-Received: by 2002:a05:6512:1047:b0:4ff:8aad:8c7b with SMTP id
 c7-20020a056512104700b004ff8aad8c7bmr4192179lfb.68.1692568660800; Sun, 20 Aug
 2023 14:57:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0oqCAHqiuPbfAME+r-tozCzTPMguO_JvThQVYQKnNF0w@mail.gmail.com>
References: <CAPnjgZ0oqCAHqiuPbfAME+r-tozCzTPMguO_JvThQVYQKnNF0w@mail.gmail.com>
 <20230813011754.339601-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:39 -0700
X-Google-Sender-Auth: QRy2VXL5WvJQSGk41w9lDVa5k3w
Message-ID: <CAPnjgZ1oX8T_QQX9H652RMZ=QOaW7t5DXTJ2PidDC5XXvO-uXA@mail.gmail.com>
Subject: Re: [PATCH] configs: sandbox64: Increase console record size to 0x6000
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mario Six <mario.six@gdsys.cc>
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

On Sat, 12 Aug 2023 at 19:18, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Increase the
> console record size. This fixes ut_bootstd_bootflow_cmd_scan_e .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
