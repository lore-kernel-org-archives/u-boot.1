Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE2BCD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE12836AC;
	Tue, 12 May 2026 19:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NOUFKaX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A9C83C51; Tue, 12 May 2026 19:37:52 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BEB580086
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so3703518f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778607470; x=1779212270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fv65w+KgckmCghJdMUx+fVMX+iVqK3WuiCAJupqCACA=;
 b=NOUFKaX8KsneQ5zRA8WjXZSwXrmTOxcQFZE+N4XP8uCBHCHV4OKl1gQi23lFdsOt2V
 GLIW9b/KZ6J4DlkjxJz6U2O6cG6t/0/um9ttVFgDtlxidPtgmYWQcWKzUo+YAUr7wnhx
 Hpf8Dfc4MOONgFW+wQT1Ft/Fc7rumIIqu4r+I4L8QbGXvc+iEdHZtwTDhkNQOLHmqoDM
 iixNaLh1vn3gfe6uD3SSqR/W28GFZOd3lvR6W+i/Ok3phvl2fnfcYJ7WWlScd4QYgpU3
 h/wsYq9tF5AJLmtxj3XGHzh6VfLa52pKSpwjliEHQzTKUjVpSEOMSptgdR5y7NhmKAky
 xuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778607470; x=1779212270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fv65w+KgckmCghJdMUx+fVMX+iVqK3WuiCAJupqCACA=;
 b=LVtNqIqsSbUk04RGlQ5JNPox36hyRcaduB6Wl5Z4m6CgSOsvqoskLbOqNbofXwFud7
 Aezun05P+GOCNme63fWCW8CI9DWx7JDHw1ezKYwNuvqHOSbCXvofRpXbMQCo/I3/F+rS
 vBkIMAN5e1sOi3JXyLNF8CVgckeLxjQ2B/NS3pErp6Ot3wpAUphTr88zuhWOfV4hZGAZ
 Q3KK05d9JjYPT8Jba9Ou3bMvnZEogsdgvCOfgAO3l67QHMkoWZ8JKEggX0cxNih3Xnxf
 fpEKHnhuDJFd+WSkiogGctMW8HC26IB+kxVXqccnfrFFAE6pkXeZ3KQjsBSR7K7VSqlU
 XNTQ==
X-Gm-Message-State: AOJu0Yy6Mfw9QXTGoTkVTsIIAAL1eaK65ry+1Q0yKNh0VopOZY7Vh91V
 EYtdrBf9mfX8uAyeRrVk32Ym8Sxk4lKy0Qj2GDzXeKMXTkph2eH0vsA/o7iynQ==
X-Gm-Gg: Acq92OHrZFGwynKr4PahI2s3ie7jXb6b5+lJ3evd6FyO2BZCQEecjQcwOgw1q896UID
 /VBexGOffdyZZItjj/m96UFDwZchC1KIfXzz3A59anaMGPJHwWCaD+YMKmbxMRXqoOwU44R+2ti
 WHC84kijP8V9nPmMpUwe/nNapow36jwIFonsrLSvkE8yOBJ852EE4u8qwAKyo7D7JOGpjtDr/f9
 jO8Wf50UKROwqmxPM1VKANIAStH0DAAZJvQaVuugJ/W5VBP3VDbPv4PugGqw0UFnAhTJwlnTIUP
 uSjp0dsYabHRFIDGTRW4X7kf+/htrJj4XzbYwwGttBsDqr7Bqqh2+S8XeSCTLUcW5ILHngIMg09
 wTPU4oOJ4OUzvCq9ynWWL7YVUm4tTJKQ74hy5XC/adrSDhwZYRD4l/8LoZr9SnivZJHJoQ0VdHL
 h1VAWMbCLocBvOVo5OeZai/YwX2rasHhSqksjju4+wNpC2mdZHd+pBCdZ1vRv/lYRalCFFt8kHt
 Xbk7yripUCy4ncE7A==
X-Received: by 2002:a05:6000:2311:b0:43d:6244:f8b with SMTP id
 ffacd0b85a97d-4546140ac8bmr30344745f8f.13.1778607470435; 
 Tue, 12 May 2026 10:37:50 -0700 (PDT)
Received: from jernej-laptop.localnet (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a66bfsm29913178f8f.4.2026.05.12.10.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:37:50 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Chen-Yu Tsai <wens@kernel.org>,
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/5] spi: sunxi: add support for A523 SPI controller
Date: Tue, 12 May 2026 19:37:49 +0200
Message-ID: <pLYemXh3Sp2-EQWOYmhnyw@gmail.com>
In-Reply-To: <20260511213713.15943-2-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
 <20260511213713.15943-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 11. maj 2026 ob 23:37:09 Srednjeevropski poletni =C4=8Das j=
e Andre Przywara napisal(a):
> The SPI controllers in the Allwinner A523/A527/T527 SoCs is very close
> to the one used in the R329 and D1 generation, definitely as far as our
> driver is concerned.
>=20
> Add the new compatible string, but use the existing config section from
> the previous SoC generation.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


