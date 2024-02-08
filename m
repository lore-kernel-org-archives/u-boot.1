Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581C4C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7BE87E36;
	Thu,  8 Feb 2024 15:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RDqt3UAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549B487E6A; Thu,  8 Feb 2024 15:33:07 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 413F187CFC
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5dc13b142ffso484062a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402783; x=1708007583; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6tiy2c2ROxD40kivnZSJOit5I71GMBCdi7YhP6ppqc=;
 b=RDqt3UAEPmr/66Kc/vH3gPfR6g58Bs1qfjTVY2eBIZlanNwkAFxu9RkyG43D5Zg1il
 /nHvJeCCVF5s9S1RAYGQUyEPvGcsTGDWecbLjXjlsvmwOMET6EPn/Dbjb913I4xzRzjd
 RRZbKqQta4UdtMVoq7Y3tDoRSMrxdfDXmgDxDdEfu6zgvcNwyGqDgvjuRbyY0rEWjP6C
 jw6xKx8Nt5qaZEg7+G5xue+21WJqHwN0xAXTqIGFyQUKN14Q2Zccp5gUKSaUut7p68yS
 twrgRqtW8chOKVKBDsHQAhMtjaw2ZcnspNIzRLGwIkwW2s1QRmNvANE/yYjlipXlUZ+B
 4d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402783; x=1708007583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6tiy2c2ROxD40kivnZSJOit5I71GMBCdi7YhP6ppqc=;
 b=V9NUBaU7M9blfsHp9LFiOsx1F0DBBwNJnJlC9/1WBb33dfnqvJvmgfFes14yRZyLHp
 QrVdoj/lhL0QrbLsAFLGUmjWqODmi0Ki7Ibpjkclbf44lmc03JmDdhlgAfOoQijwrffx
 aRbuhwsBWSKlv5ohMamtlislN+K5m2xzC85YSoXaXvg6Q1/7EvgoL7fl8qWJxHrhl9Kw
 99GQJsyV9Faq5g53kftH+q6xidSAC10zvHdWGbbkqV5TwIylopN42dF3G4UDofHAyiME
 spWTfCvYd7LgGPHe1pqER2LohavNxooNa7aM+7NLZQVSzfwHiDWsF4wx1ptHkH4cQ/T7
 rdkg==
X-Gm-Message-State: AOJu0YzLN+CiS+Py1KNm8XjRfO7qXIZNvBnUbAtzrJ3A5eBX+aeSBBIM
 f5Sblv86Xu/nPXeRCM5KZ4RgnhUu1J2ODccWm5DOFyfOWwZWfHT4F1Bbuc9ijki0AtlubQxW1fF
 UW+kWGG2C4D4J8K0sT9/lFgEtFIs=
X-Google-Smtp-Source: AGHT+IGaVbHK3iwnGvn4tQoBowWNfbzx9Mh2JQjqIVdVYim4wUs1+ZeYB5gQ4JzmDpWcNznf4vN/dL/e3Ju+d2VbCF8=
X-Received: by 2002:a17:90b:1d0c:b0:296:9c2a:e7da with SMTP id
 on12-20020a17090b1d0c00b002969c2ae7damr9168187pjb.2.1707402783586; Thu, 08
 Feb 2024 06:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20240131173204.100407-1-jpaulo.silvagoncalves@gmail.com>
In-Reply-To: <20240131173204.100407-1-jpaulo.silvagoncalves@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 11:32:52 -0300
Message-ID: <CAOMZO5Da3aY7o1QofHGckvMdPVicAhkiSp2t0FFAYU4oBcbo2Q@mail.gmail.com>
Subject: Re: [PATCH] toradex: tdx-cfg-block: add 0086 i.mx8m mini sku
To: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
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

On Wed, Jan 31, 2024 at 2:32=E2=80=AFPM Joao Paulo Goncalves
<jpaulo.silvagoncalves@gmail.com> wrote:
>
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>
> Add new product id 0086 Verdin iMX8M Mini DualLite 2GB IT.
>
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Applied, thanks.
