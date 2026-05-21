Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07172CD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 23:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5BC846DE;
	Fri, 22 May 2026 01:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NV4OCtaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D83846FA; Fri, 22 May 2026 01:22:19 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56744846CF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67179ed133dso7900730a12.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779405737; cv=none;
 d=google.com; s=arc-20240605;
 b=iDaI2yreKRZErxvc9euK7531AfaeDdgw+FMS2U4IWeD3KMmA5YwdDlzPWdGj0teseO
 5DNxV6MRp3/hIAzbjyRRh3N0UfMZSTXWmbklOOKB6FZ2SO6r0qsSwkCddXmHJ+VRsDoW
 VCubs4nUWq2f/q7vKxR1+DoWaMNJR5cSXCAdYEdJlfinHl+rs8LxgUELl05sx4FwcnPk
 1kW23dkgVnd4TCjPOCbIB8HtEb1Pjbu0cBU/2bXa7Lna35CYzVYqWN7vBYjzhKtKESP0
 peXoxyu8FIyGf3TjBp5VzU+cZZHKSY/QZaVTGRZMQtxRQoIU5nfAPZhpAIHUghlWlciz
 YW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=6CxHAKWUR8fkLI6d8RPecqWVji6hF1bHGusPSu0zkuo=;
 fh=L7Fr6iiqXRCnJi6+JNICLd59Uai1EUYF2WC1zSW74+E=;
 b=R+5a9J8wf/8+bTyYGL74lN1OwOUyUIlXn0Q+ORdkr64PucHhs3pL5Lva812D7SB5WS
 cngQq+R1FRb8yYogGLkJn7UwAEllNG+QQ1UgQ5lQt72f8AE3eBSkEgac2y7oapxpDFAL
 6p3XgtNVWJ34dm8ei69uiLGHSDiYtzrfm7sQ17ApLpi5BaRnaMXP65Kmc1S7DLZg4eCA
 i4OW3GlT0MeEEe7L3SM9GXmetmj/lGmrrIP3lgdln2JVjQ1AclKHQoPaox4lztEiaz4M
 uZdH+lW+tH3afr5uMn0/MinhR7xJkXMvlXbKkju9n2QeU2Hyp2VilUJBNQgqIGAfuJES
 wNtw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779405737; x=1780010537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6CxHAKWUR8fkLI6d8RPecqWVji6hF1bHGusPSu0zkuo=;
 b=NV4OCtaKC0t13ra/w0Swoh4ot19mGg4pMfGsPze3Fw9g6pxemyGyAZxZnULV1uKaf2
 g76uzyTJxCz/B8WV5WAbkN4AoocgEJHVxwBv6/g98Qciidsp5RFoXTlSN47rI2eyXfMj
 Nty6zZVmyFQZEKdD5JlUzpcdwlSh3DSHzTe44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779405737; x=1780010537;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6CxHAKWUR8fkLI6d8RPecqWVji6hF1bHGusPSu0zkuo=;
 b=e7dpCHXZAHbSna4v1yPxl3kkqAJn/9f1ieFDii22wuII8KXw0b0mwAs8/EzyhhXrFT
 KFpKuufWu04d7077xPA4DCLOfQmPkQBDGlrVIf1GbVyOrx1KNxSPsW6FPKxYfx0ysDug
 5/qx8SW2eDiPrXNfIycgn5EfrfqXP48OYX/vmPZbQ3jzi5fpC7q6ZLJibMtQ00tnCAmZ
 1JdDeTxiPn1j+8f8y3nsNWl8WAJ6Z/Ef0Ky0JuJIjGRv29heCHo+E8aMcAYGZAvm/jEK
 C8WC4YDXcKvBu/v4G/cH4OH5BF3Ua/aKlCbHzI3tFic0NsSlN1z19haSlCwWuuW53GM8
 MStg==
X-Gm-Message-State: AOJu0YzwI9E1CYQeHaqjw9JHMN+FL1GtqE136OG/svEkwiY2AYLAR+f4
 zv7ADtxUKaaa49JWZ5WsEVp01AqztnZiwW4jV9gm6bgRF/fzpRcs764wXbcNf2EE7rdrwwjcG/o
 qCmeJStMvr3itWvN/iHbUz+Kgqk1AN7ZpBc+TbsuTEY1Pao73rJQhSQ==
X-Gm-Gg: Acq92OE/AOO+L+9LTDO968XMYDKIObhjVcn1AcZxh2KdVVuu8GFEVToCP42h+WAKhHD
 IJod7dsF07ZGYjmyP8ggp+7lwjgGxrA/EUQi1l8y236EYYjhdtoRbinFGj65cdX+qgs99DvT0an
 NueBI9ResPKXSC9Ecd/0sBw6ptg8Rww/N6rnOdA6jRubYlDwenlyML2txi1Qa/LTl36iZBXiLX+
 +eg2DAMWpoD/mfjIq67fUqrAy3jtZY8JsB0XzPH0tIH0Qi1Kopq1e05o8l5Fl20xuOXBPsd42a9
 T+oC6w==
X-Received: by 2002:a17:907:890b:b0:bd6:6b24:49d with SMTP id
 a640c23a62f3a-bdd2a5058f9mr69963666b.32.1779405736610; Thu, 21 May 2026
 16:22:16 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 17:22:05 -0600
X-Gm-Features: AVHnY4Ku3Fu_FTHVbCzeBC30hVPeQ2roIjqTZRbDz6Vli1uaq4B2rUbpwx4Y6hY
Message-ID: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
Subject: Friendlyelec NanoPi M5
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>
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

I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
mainline. I found the note about needing a workaround so have tried
kwiboo/rk3576 at

https://github.com/Kwiboo/u-boot-rockchip.git

I am building like this:

$ ROCKCHIP_TPL=~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736MHz_v1.09.bin
BL31=~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
nanopi-m5-rk3576
Image 'simple-bin' is missing optional external blobs but is still
functional: tee-os

/binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

Image 'simple-bin-spi' is missing optional external blobs but is still
functional: tee-os

/binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

$ dd if=/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=/dev/sda seek=64
18579+0 records in
18579+0 records out
9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s

I get no serial output at all booting from SD card. Is there a special
trick I am missing? I have confirmed that the Alpine Linux image works
OK.

Thanks,
Simon
