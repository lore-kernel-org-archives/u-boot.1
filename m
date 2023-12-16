Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24D3C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6288087CB7;
	Sat, 16 Dec 2023 19:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RzW4O4Bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AA287C3C; Sat, 16 Dec 2023 19:48:42 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA91887C7E
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso15601367b3.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VQj5a2BgNDbB5/bgw44dr3o3aX0R5V6IhmrGgsdNfx0=;
 b=RzW4O4BgRgAgIp6WUFoMVw9EvVVHc4q3WgLICkdw2qQv/ea4E6vaIJhdXqXKiO0UHm
 GaCPOaC2T9iOUblGICWYrgpGverKCcnX4Z7iuOPiMy58rNxhSzo3Sht8OGK2agTiJkp2
 TYZejPeX5R9hIPwQbGVieIbBlOhV2j8gGgfoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VQj5a2BgNDbB5/bgw44dr3o3aX0R5V6IhmrGgsdNfx0=;
 b=w55M/6mJYfXnlKH6F29H8NiBCIQIdSFV/pmws+ukge7qiOS4c59m6xayMQB0aArKub
 lfuvToKjAnX+zsKkNWWOWr9m3tem6IvKeNvn2T5SXPjbcOvyy2W9cME0rsZTNJdkSLGm
 qkN5S8bHtpSk3mrVPD9UZsXWNkoEykWUIN7ovcvvM3s+b4TZqEsJkDKL1MydOuqzA1J1
 nh6RaB5GCi9tsxIvQzLTb2E+s4CwC7fkJqG9/WHR2XRbzZwO9oBHwbJuPdWpze6h6b1P
 mLu34KML9KymiOc//0wcp4fmvTe1eFr+PcNkwWS+AfZEMDD2oA/hJp0SAjHKH2bZYTma
 AXYw==
X-Gm-Message-State: AOJu0Yx6lh9CcXT7eQpAfN5UiGJOQuwHbfF8NLIoOsOuQdUPzPRKHx/5
 wyfl6Jjvm9t9IARKOnbh5XBXVWARGamFLK6eadnHlQ==
X-Google-Smtp-Source: AGHT+IFMqN89pTaMpdHxuidrNhrGgizVFjWLKNAB69heMFG46+/gSpwQimCMaJQprh/36MPF2WzrstIkS1Cw+tG0h1Q=
X-Received: by 2002:a81:5b85:0:b0:5d7:3f4d:2e2f with SMTP id
 p127-20020a815b85000000b005d73f4d2e2fmr12218429ywb.14.1702752514154; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231215232604.260081-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215232604.260081-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:05 -0700
Message-ID: <CAPnjgZ0wDm2CdQ94=9w5Cn8Py5mcYPcm-txZbTp-YO1g+xL-0A@mail.gmail.com>
Subject: Re: [PATCH 1/1] binman: used-before-assignment in ftest.py
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
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

On Fri, 15 Dec 2023 at 16:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Pytest 7.4.3 complains if a variable is used in a finally clause without
> having been initialized before the try clause.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/binman/ftest.py | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
