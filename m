Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C54AC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 20:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47BD80AE0;
	Tue, 13 May 2025 22:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U6VHDUmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A83D81DD6; Tue, 13 May 2025 22:12:23 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26BC1800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 22:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30c416cdcc0so57945161fa.2
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747167140; x=1747771940; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHsvpSoZp+76PRb8fAwcggZ4e40AylcK9qXlHwmMslE=;
 b=U6VHDUmLJpnCVpBX84IlYHDk+lAYfy3cjpWPR7abVj5sSR1EdlSlCiYbCEx3zXdjes
 mwqqTf3ULUe6yfdqawpM8wEfjAhXzw84Rde0Vy0UFLUtqi6vEv4T/qT9ATKMHQ932Gqs
 3xeYmthjBsmPJMm8+BZwyx2Pqb1Xb9V6q1eOz5EcZawolgnVbKF7fQfQyOXtZJaPzBkp
 h6sQzAzsEc7e3NWmkitNkni6IrMcoyYNg8nJ6kVgjYRLApOe1k3CXZCScmxD8U89Tucl
 QCixBA1u0VgItG7kGACAdbhQTjG5dufyTbkkpLakufBH5lVjW4Md2zh6zKIuO8boFEps
 PUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747167140; x=1747771940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHsvpSoZp+76PRb8fAwcggZ4e40AylcK9qXlHwmMslE=;
 b=hR4a1Gu1eRXQ6slWjfBCVdwb6T3mWNqnHRADXbhnsP8w6GK4DVicKSx+lQ2MxxZ7NF
 EMDck4JHsq+hSniQtZqYgGHEDW4FXsW9rlfrCZEyWiQnid6bytrucY0/9g0P1ir7b3H+
 +jUUnyrEYGUiWin9bzLraVuH8032Z9hsHx3oYYjFGeqA0BkFUNpLmj/+HJLDrXQz74Zp
 jYhfXOQeUKrUIppE2yNNXor74Bb8+k/08F2g4a6424wjoEWaUkULOIMAIBqyhScsoctC
 nJM/t7TXI+cL87x8Ge6cKhVZn8dn3X2cE6Ayo/7r73xtZ2upZTflVZ9vKr/HlD2Rk3Nn
 GrgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJlRtD5dUi8ey+pkZdCyeqD+PlTdjmLFbMhLEs5jUwi4XeAsZMthbAdNs0ML8LVC8nck/1ACg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2ivK+nJWjAjDXj+otV4/XOGFGL4iUiJ12vrX51hoSEdiXzfiX
 shbfU4+mffE0Io+Riz+vgpYzboWuIO36+Vn0hPCH/pmuDgD10jzNEiubI7Bv2zW+plKfCwvbZ1i
 ftnSb2b4SrdHnzg4pkETXf/Ul8ZQ=
X-Gm-Gg: ASbGncvKkyGFAGwoDNkXXhgXxZG0bHfyHxcdm1wSj1Pp2NfpW/wDHZMUvrpTNd45t0m
 oPpdDEI8GEcGS32aBxzX5xocewc6+Mk2+vZm1zq622ipHVnW9mZAIn/OSALuv3dDfPYo4Lf3yG7
 H3nycqjkSie01X7a4ly6mLvMYPUhiBDA2bJY0uOIB79X9Xz77dejnMo5kTD7igomIAoCCnXvwnH
 gg=
X-Google-Smtp-Source: AGHT+IF/PEn2YKvce5/e0OkrskaxVNQ0Y+XbTT9suZSzlg1NQTCpzuTEyn3pVZ8n6UJOOI9epwcIPd/+u6t9lJcvFH4=
X-Received: by 2002:a05:651c:2126:b0:308:eb34:103a with SMTP id
 38308e7fff4ca-327ed1defdfmr2791181fa.28.1747167140099; Tue, 13 May 2025
 13:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250314181031.7978-1-swarren@wwwdotorg.org>
 <174683098829.770062.5183823135588651438.b4-ty@konsulko.com>
In-Reply-To: <174683098829.770062.5183823135588651438.b4-ty@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 May 2025 17:12:08 -0300
X-Gm-Features: AX0GCFsMYjdnvf18DBSqCfBM2wxhr3tvbvQ0C2UitQZdobWuvFPoOiCniMPP2Uk
Message-ID: <CAOMZO5A5SSCTTkawyenC9nOEGH_bmGwsBUsZ8tnG5dMAGiuEvw@mail.gmail.com>
Subject: Re: [PATCH] disable mail for swarren
To: Tom Rini <trini@konsulko.com>
Cc: No generic patch CC mail please <noreply@example.com>, twarren@nvidia.com,
 sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, May 9, 2025 at 7:50=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> Applied to u-boot/master, thanks!
>
> [1/1] disable mail for swarren
>       commit: e4e564e0d6f0f69dc0d8652aec6a04c4c6d9d44a

This was applied without the author's Signed-off-by tag.
