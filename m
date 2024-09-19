Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9093CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F2E891F0;
	Thu, 19 Sep 2024 16:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mMbhsZNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CEA8891F7; Thu, 19 Sep 2024 16:10:37 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53EE6891F3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d8b679d7f2so778666a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755032; x=1727359832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/DXHYyu3KDq+jraG7qLkvVUQKVV/fTQEvyd/0BZMo4=;
 b=mMbhsZNQJ8cGrJC+CjupJP3xoPfGgSbOR9UEgpRGmJAu2UmHgE1I76g1eJ2TYjX+qY
 /4zsGorCYkKaJ8/AdJrb+s4VdqcCCS+slMUmVc2iW9uBg537Ply/3VCjxzfJqaeJUm23
 ZTsIzaMmF6cpmRBheZRNMgkRB8rEjoJsp8eaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755032; x=1727359832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/DXHYyu3KDq+jraG7qLkvVUQKVV/fTQEvyd/0BZMo4=;
 b=jtzWOc5rg+R/VBIDtnCw1Dlokrup+Y+aJzSCPmGU52ZxJluH5pMIyg4oJ3N2Oe6Cx/
 bNqneMIrgdAARotCi7FbSrh488EOROJcVYK1Tqv2ngcoSvPQ1G5Arb2TX1BK5V5zGH1Z
 vOaxJcd1HyibBzeY9KeH4gf+9c9XYMRpoLzzR0ahu3rpnxFk+RSn5Ak0NxA2in9iAk7o
 dOCzZLf3GtdYCCn5+XxCq7vuFY+KhLKfN7liXzQMzdcPxrs4X2yU7uRimHSe7foXBLPE
 L333VCAMz4XWsel9XQDU4erQqt1oKXW6fbrjyBGZI5xRO1dVyba3OxvJMcmnLOP9Cx09
 2Z6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+3AmO9v0G67ZsJUsW0zMvZxxb9Z6jxnOwdRMiS6+08YiyeZqDJ/1UY4BZNAoJM5p2slgW9zs=@lists.denx.de
X-Gm-Message-State: AOJu0YxdOdVewooeEfRLbAjOtCFREmKtIOjmeZLM6BLxf5DT+Z0vLE0w
 WtADMZIIv7v3ULMWTz88ey60UzZv52PllsdvMjdzZUB9UXOA0R/Y4W9J7W8Xpvnlg5UD60HuIEt
 lKzW56pFrYquSvYT36OxE7iFC3jS+WF0hCwi4
X-Google-Smtp-Source: AGHT+IFpMUmBsCeQWd9FJT3kiiNZTf81DBNt87TdZ74oP91HlQpFf9LObflLL3KCHsdrdfih8k3Yx6XeSjYmIYuwpE8=
X-Received: by 2002:a17:90a:8a13:b0:2c9:7ebd:b957 with SMTP id
 98e67ed59e1d1-2db9ff9064bmr31466551a91.11.1726755031911; Thu, 19 Sep 2024
 07:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240918215408.21385-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918215408.21385-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:16 +0200
Message-ID: <CAFLszTiNRxixe0Xzu+zi5PuxL1abu6kUbb7JF7NFS+xRiDfpFw@mail.gmail.com>
Subject: Re: [PATCH 1/1] sandbox: fix OS function descriptions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Sean Anderson <seanga2@gmail.com>
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

On Wed, 18 Sept 2024 at 23:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Add missing function names.
> * Align names used in descriptions with function names.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/os.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
