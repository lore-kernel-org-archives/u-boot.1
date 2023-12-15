Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DFDC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48AC87496;
	Fri, 15 Dec 2023 19:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dhC9eCwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9388187C70; Fri, 15 Dec 2023 19:37:34 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6635A87C66
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-59067ccb090so704873eaf.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702665449; x=1703270249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Kwa6paPmFsBlPhm6EwbKqNCQY5ygWHQ6CuptkX4oHs=;
 b=dhC9eCwPUElNAeao6n4Mu1OL81NSNZUtfzl3EyNZT2khlmR0O603zXuoTBX5RwtcSS
 3dxMq1wKu6nORJN9XABdxKWAHoBYCUNh+BrqAikZ3rN+pc+5IRoe3D3yQ/R/z6VLL1z2
 KlnPWLMwSfueedz36LfA+OmiIin8P1k0723N1jG2jIDGm5ZS+XKL9iAK55vk1/y8VfOH
 J2rtC5/FLhNx6fFOmAobyUErPiumyjGKehQhKnaG3N2dDK3rTj31mD7b+JJy8aTL7dX3
 vtF/V6SfQ+6fALfxCdHS4+5Zt8dVq5p+44qlAoujxPQYGZl6z0qLuwLGZlndhA3O2B3o
 uC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702665449; x=1703270249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Kwa6paPmFsBlPhm6EwbKqNCQY5ygWHQ6CuptkX4oHs=;
 b=V9aqG8p6CrcA+9TC5mdPWt8ZNAl7Rzt6qp4dEoE5XkFy2c6C5wtfByFRtXD6VsEu8i
 BlBBufys+a843UZsr+eI5T0MZ6nshKYm2xlPTQEmyaHwTB16wi0vRieY9ZAdYgHu4mO0
 MC/iD+I+KK64Ey40LNoqY/PmgY0UosfW3c/s7x3FoSdu1SKH0fhI/ryXNoL7LwQzR0um
 ut/qKL4neNQgjtbiG8x5dvXiH1EMJd8ohWq7vAqr43gQvDZfVEX+ScD5KzVr5eT4qu9F
 Rsn8HTSFpend3Ny2by6gua8eCyPJREaUekSPLjdmzzMhGM13P7HPfC2UKAD5h4JDIDu3
 Gfbw==
X-Gm-Message-State: AOJu0Ywi9J6VvZxU/mX/ehkX/cATE7EiZnLBEzqSXDA2wigVbeD7vhsE
 Pz5eHiVcGrOphI+JWwKkeVU=
X-Google-Smtp-Source: AGHT+IF+QynmBSux7D/LhjAKdpWTj9jNGgeyPF4+r/UDxz550a8FsQZXNOJ4rMZC3NsW85ndi92gUg==
X-Received: by 2002:a05:6359:2e8f:b0:16e:43a1:6893 with SMTP id
 rp15-20020a0563592e8f00b0016e43a16893mr10032140rwb.5.1702665448957; 
 Fri, 15 Dec 2023 10:37:28 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 a3-20020a0ce903000000b0067f24bd0afasm116687qvo.101.2023.12.15.10.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 10:37:28 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: ivprusov@salutedevices.com,
	u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, prusovigor@gmail.com, sjg@chromium.org,
 kernel@salutedevices.com, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 0/2] Fix NULL dereference in clk_composite_set_rate()
Date: Fri, 15 Dec 2023 13:37:24 -0500
Message-Id: <170266540040.2383564.6799645412938383601.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231205232334.2931-1-ivprusov@salutedevices.com>
References: <20231205232334.2931-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 6 Dec 2023 02:23:32 +0300, Igor Prusov wrote:
> On sandbox it's possible to trigger NULL dereference when setting rate
> of a composite clock. It happens because sandbox composite divider does
> not implement set_rate() operation. This series adds NULL check and a
> test cases for clk_set_rate().
> 
> 
> Igor Prusov (2):
>   clk: Check that composite clock's div has set_rate()
>   dm: test: clk: Add test for ccf clk_set_rate()
> 
> [...]

Applied, thanks!

[1/2] clk: Check that composite clock's div has set_rate()
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/54d7da773062
[2/2] dm: test: clk: Add test for ccf clk_set_rate()
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/9e0250321a0d

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
