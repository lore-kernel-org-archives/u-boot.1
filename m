Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4DBCD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F35846A3;
	Sat, 30 May 2026 00:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fqx5x/RO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C90846F8; Sat, 30 May 2026 00:03:24 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B3A84693
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bd0209f25c1so2162787166b.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780092202; cv=none;
 d=google.com; s=arc-20240605;
 b=UFsYJmPbj4ZXMGClzRZctJB6grlaW/DMz5kS8GHNjDvX8S+u0kjieyrfvdKvH2+797
 eTuF6/+UuoF1Tyc4Q6RyeeQPpafGe8r4+JT7OJ5B/3m3d0gfCsNykrAowy2VndvZoKGe
 myL03qJL5X+X/BxRvchWjNTwJQ4oyCMN3XSBiHwjEKpZ+wUcPPUgCjj76u2Yr/jzKBB7
 Td/Ij9Cc6gEHAm/zMzKxnvmB8xBOkrC2H1IvRSRnnA7lxKptp5nXAW1feRiBQ6djpn7l
 TgXtTLbM2eiZP6LKb4Zk1PrrjHNeWkNuLwZKwk6UR3dA42OlUnyHYGJfDHT7vpkTc45f
 qQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HMBiP7swf8WzTakdLOlg0gXnLwDm1FJej/TVcE++3MI=;
 fh=kaSEYqafdndL4Sx2LmJna1bIC6NGrJ+MBFNozaxD+Uw=;
 b=hquaDOJC8RMKwNiJU+BgJ5Ecz4MpzM2QzE+uEKalgNfj+s9tOmtTe2BMmZIW217Diy
 A1ixw1yoog6ghpcep0hrrd+EBs2dchfn2pNB20QOEUgigr9llBH0SLJpJhA/8s991LRT
 sWQ+9YB/03M1sjjO9Ae3ErM/r89S1j5OrqcFaaYn/EjP/L0qtA8uV0oJpH7rt3ARzwnd
 9VC5BMtWNHpmXfJIOB5XM6+N6nsSp5nlKogpnZvz/g9ET98Un01QLNtp2q0wgQqWkGME
 Em2ndjRcRqPDRcbwCoN0jqQ0ynxW7s4iDXulKit0v72lvFW0xWTObsftfmBF+4mHtCWx
 WKdQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780092202; x=1780697002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HMBiP7swf8WzTakdLOlg0gXnLwDm1FJej/TVcE++3MI=;
 b=Fqx5x/RONZ71LG7rZE0GNAC2+p7VzSEjR8cewoKgLW6SGdIXJPV00Yfy4KPmu17zEX
 D+Y6v0NEfDq4h7Vwclg197REoSZMDrJ1q3Nc6jmA8TbzhfmtqjevWgmrWQRQ8rrgOtTK
 ESQZWVdrca0D2o76g84NZV8ga31Tro64EKQ6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780092202; x=1780697002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMBiP7swf8WzTakdLOlg0gXnLwDm1FJej/TVcE++3MI=;
 b=DrcMBAbgJFlfIeSNWp9SeQudBV2hABmwRhNAEe67a1NxATaCnDoUKmYpszpIWQ/bIF
 mMee8svHU1D6oRCqC+vjtFTSXJU17+fxurW/08GP3x++Yd7vO66bBuUwgWhKwg9jbykO
 meIkW2oe8PmTliYaE9wXsxuuOLPWPb1pEh/+RSnDuxQ2H1z9p+qgs/0lTA8EblOUuJCi
 DU6sl2u55YdvtdlUcr+YT/1l6GkdoiFSxndHW8UjlsrLSkVmAqtv1MeXvl7r/Ahfh3vA
 HFSK1ArklOkmH80AUBuH/ORtbOAa67wE1yPkClgV74I6cOgkk9Jvk7f5Sykn9+MmwIm4
 fgPA==
X-Gm-Message-State: AOJu0YxHs/K5s+wuO1JRnhRkynqor4vtplpkKlt+m+CKl5WmGfhMkqnq
 GNXDsOxWbYoB3kWnc5FpP3ZQF5YGJj0X94ah/qqutEEx6cF7kz57x+mtgNuk912nq4TPu1Gpj+Q
 l1Vz6zXqThexESuVD1tseqcfXNzUVcHnyVan3/GSH
X-Gm-Gg: Acq92OHgGKjExM/Kza3WnSncD1XkzrgVepLJwpedZmZVN5RY7+D+Wma5L7aG/izrltS
 o83jNA7JHpue7vWQMIRbKg4GWgqPyCzganYuJShYKv80+GH/FlG8xU2MYGvE3pLu/FAX+RcFhOk
 PZEnsEU6+CNwjDEMXMYD5MSdZhPPr75B8mHAWD8C3jgkufvXlveCzg+GVBLk18SGU4JHirAzHgo
 jhs67PNpfEsSygU/ftFgDtIid/SgA6WergCAJrBS3B200Y8AwsFWpeW4cuCC+y3V9Vv2kYWNY1r
 F0BnHaoneGRLnRto8Ag=
X-Received: by 2002:a17:907:a2c8:b0:bda:916b:c87e with SMTP id
 a640c23a62f3a-beab01dcaf3mr84498466b.12.1780092201695; Fri, 29 May 2026
 15:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
 <20260529194621.1470583-2-rv@rasmusvillemoes.dk>
In-Reply-To: <20260529194621.1470583-2-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 17:02:51 -0500
X-Gm-Features: AVHnY4KGrCSWB9Nu9rumfw4gSp6RneGp1KujZFCVE_UbqoCiZ3ih-_nypm6XVPU
Message-ID: <CAFLszTgcRW_QOGRgvy8GfXzo8kPPg0QxSyq01SKeyd9gDa6aNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] image-fit.c: introduce CONTROL_DTB_AS_FIT config
 knob
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>
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

Hi Rasmus,

On 2026-05-29T19:46:18, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
>
> Having scripts embedded one way or the other in the U-Boot binary
> means they are automatically verified/trusted by whatever mechanism
> verifies U-Boot.
>
> Writing those scripts in the built-in environment leads to
> backslatitis and missing or wrong quoting and is generally not very
> readable or maintainable.
>
> Maintaining scripts in external files allows one
> to have both syntax highlighting and to some extent apply shellcheck
> on it (though U-Boot's shell is of course not quite POSIX sh, so some
> '#shellcheck disable' directives are needed). Getting those into the
> U-Boot binary is then a matter of having a suitable .dtsi file such as
>
> / {
>         images {
>                 default = 'boot';
>                 boot {
> [...]
>
> boot/Kconfig     | 13 +++++++++++++
>  boot/image-fit.c | 21 +++++++++++++++------
>  2 files changed, 28 insertions(+), 6 deletions(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1676,6 +1686,10 @@ int fit_check_format(const void *fit, ulong size)
> +     /* For the control DTB to act as a FIT image, we only require an /images node. */
> +     if (CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) && fit == gd_fdt_blob())
> +             return fit_check_images_node(fit);

Please wrap this comment to 80 columns

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
