Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98514C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 14:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4EA87B5A;
	Tue, 31 Oct 2023 15:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k9J2xiRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E78487CE3; Tue, 31 Oct 2023 15:50:14 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C99887B83
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 15:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32db188e254so3919895f8f.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698763808; x=1699368608;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JLXvtLaV0S+2GRm7oQQByJbyTkHpDcGHnwP3f0x8+k=;
 b=k9J2xiRrQ3dutrcniSdwkJho329/+yJFBsXBmW+6Q5/lhx3MdZcf7zuSZsYwEwFbu+
 74hprSlXbN3Jn9+IuElv4wlT26iVCATYZ3x1mCopaZwRXvJ2E7otCzcUa2P2EZB+lT+f
 2fUJoPmUza+483J6+hc0a92UIHL/oplacN2//5FClb0TBXHar2troM6jjpsL8fOl2QUS
 J3ljsxaELYjGXuSq+OIJc3c7iZJe01vgODR8mBhUHs4/VdD2UcP+lQMaAMkRN2DlJy6l
 KzbE1SQpk2c/mxGwjb5kZKX6A0RRIrmTDPsQPis+pjG/ukeX39PGq/PD3ZiJe9fla5uj
 GTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763808; x=1699368608;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JLXvtLaV0S+2GRm7oQQByJbyTkHpDcGHnwP3f0x8+k=;
 b=BZUTlsCLv1TQRAvXL7+sNj62qEC/PJE8yovfq6Mz3kjWiGNlUkEabOG+t9DozgCctN
 PEeiHXDG4nhUgp7ur/8MT8RVHwGrm3MF5buZ53vBvZvdMLX+eNkI1tplapNDoA/gyFte
 ePOsrzs2UVg3jA6Srg+Zg2L2SJy2m9Me1Geqdn6bSLyYsNMY7UInWIgJoFey9LUGWSi+
 f6UVwFyEat+Hs4CV79FwYC9ylEA/Z5PMiDbeIWNcYJOV6Vkiw1Avu2EuLPgaPenZ7Xka
 PCfG2wfcADIqYsx1Y0LKXSmMKvpnadp+ujaUSuX9IdGpUYMggpnA+5RWUvaIUAuqJgjn
 BLoQ==
X-Gm-Message-State: AOJu0Yz8no3M1MM7MZ7S+SKK72OLW34+S0+mgEGEPu74xdeJ6Mk9BucQ
 k1qEPePkjIuirR6JxiHOHLoDMw==
X-Google-Smtp-Source: AGHT+IG/wsqRAOZMA1izp794W+cuUKnZelKh92VTn3GQQnvb77Z5D0Om1PODw6cJxy+VhLjCqLSyZg==
X-Received: by 2002:adf:e48a:0:b0:32d:95ef:9281 with SMTP id
 i10-20020adfe48a000000b0032d95ef9281mr11424397wrm.4.1698763808617; 
 Tue, 31 Oct 2023 07:50:08 -0700 (PDT)
Received: from [192.168.2.51] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 c12-20020adfed8c000000b0032dc74c093dsm1649571wro.103.2023.10.31.07.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:50:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>
Cc: lukma@denx.de
In-Reply-To: <20220620111354.448512-1-jh80.chung@samsung.com>
References: <CGME20220620111357epcas1p103474818319b5dc45260e043b4ffe3cc@epcas1p1.samsung.com>
 <20220620111354.448512-1-jh80.chung@samsung.com>
Subject: Re: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
Message-Id: <169876380794.37728.2863914527348419844.b4-ty@baylibre.com>
Date: Tue, 31 Oct 2023 15:50:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4-dev-6aa5d
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

On Mon, 20 Jun 2022 20:13:54 +0900, Jaehoon Chung wrote:
> Add CONFIG_DFU_NAME_MAX_SIZE to change the proper size.
> If name is longer than default size, it can do wrong behavior during updating
> image. So it need to change the proper maximum size.
> 
> This patch is proviced the solution to change value with configuration.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/de9b2e10f10996050a10998a0836abe2f9e425e3

--
Mattijs
