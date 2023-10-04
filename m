Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD2FE7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7118765E;
	Wed,  4 Oct 2023 19:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dkd96Ld5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E528764D; Wed,  4 Oct 2023 19:58:50 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7A98762E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so25129266b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442323; x=1697047123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qp81b1vGmqJlUZWM1d89sGb/9HP0KyzR+aHQ9UBM6+U=;
 b=Dkd96Ld5Pp+tDVpP+3kjKdEc6hZnj5Nb3nrmZJUKJRjrq1v4BNvtm5J3BK0Kd2UVop
 xnjaXSYzLEFHWEIOBlTLKfK4mxkmkI4z93hH603QbW96p9cbvrcbScEmcKjGuhZcVxYW
 aesBxHvWP5Ip9ZqnRMZmnZLy3LF1UQKOwYeWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442323; x=1697047123;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qp81b1vGmqJlUZWM1d89sGb/9HP0KyzR+aHQ9UBM6+U=;
 b=pT1eAKQZ4smoaYSAh3VlZPSQgu1SHsBFxT7QrlkKub0+H5t9M1YjHfmpDiovnBagts
 AUvtjrKwkDpVe8JSs3PPDIaDRBJloPXQnlBX6VXbmYCioYoCe/YAWt5p6r5QcGE2IXWO
 kKJd7XuiigEh9hSsl3X7oNhBe6DNPj20ZL8IXXfePkCTE2NzDu7t2y2B6mk2pVlGD7R5
 Al9Y7XpBoQxZ2bGNMbGfyJrBggkzp4D97vJwglh1BLGh1QBuTcTbuOZXSdcgF97xep83
 xMQ3wvJVDqylOrtYxtBaZGx+oN5UbXU6SpbO5JGy29eDTwffYOPjLdh0RI8ydBc2hFyM
 nIcQ==
X-Gm-Message-State: AOJu0Yw2A0eSVMjbxzNSzqEOnlvSG/YJywn6ZBzLLjiJvPrNotfLTsLv
 T8D/LMxHCqQd/zJV6QDrqngfqdUIGAckoITTz8cvTg==
X-Google-Smtp-Source: AGHT+IEBGm19MUidVn5rlAj0/gAMFmq2aUsZPNSr5MAJntzjnjnXORHxQQYO8lzBWUYvpezVvbOZsOp5juCyHBdBswM=
X-Received: by 2002:a17:906:3ca1:b0:9ae:6da8:1819 with SMTP id
 b1-20020a1709063ca100b009ae6da81819mr2797685ejh.48.1696442323291; Wed, 04 Oct
 2023 10:58:43 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:42 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-9-sjg@chromium.org>
References: <20230923194424.1739224-9-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:42 -0700
X-Google-Sender-Auth: bup2rN18RyPRKvxXRTv5thZ1HcU
Message-ID: <CAPnjgZ0820VO7vOVLeu=215Q8N6FtE2iZ7VWZnYjQwU1S4YK=A@mail.gmail.com>
Subject: Re: [PATCH v3 08/27] moveconfig: Correct some regular-expression
 strings
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

Use the 'r' prefix for these strings to avoid pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
