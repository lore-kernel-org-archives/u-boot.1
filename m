Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B23CCD4F25
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E8B83E81;
	Tue, 12 May 2026 19:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ts3iYQPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846DD83EEF; Tue, 12 May 2026 19:40:21 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FAC18341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso65654705e9.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778607619; x=1779212419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knJpJ9VnlBSkSPAk7OAn0fgMKl1pyt4vtEsgbejeZLY=;
 b=Ts3iYQPRajAgJBH32SvldNTPScXJqDXreQZUwh5ejukRZc5OVnNhZTZAyxsGOIox0n
 K725Jz5fHAF1RcYAFD8pj3ZuKvwflTOCD95HQf4CmuodxwOiE+X149vhiq0wGbdBNB/b
 u3fTLoFPjALPKPYlJELlGX9KQYAdvXlwFGHxqrmKmsgy4zmtB0fWyDbf+yFzA+qQutvV
 LT84jdv5EPu4pZg85yq8SuQ3F2UtMiX4AYvhg9KvB1cpnSqicrzpmThLxMjTSMbIr8Fy
 ulOcI0JDZjPum68KnTUlmlipu1b27axpMcIIRqDKUF7eWU38aKiTiOM7DTAhXIKaZMjU
 0F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778607619; x=1779212419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=knJpJ9VnlBSkSPAk7OAn0fgMKl1pyt4vtEsgbejeZLY=;
 b=D4nDSPsKgHsPZCLne2GErGDxImW5LSIeHZ6eV/Ed7dJ0zxk1Pflk6QjGzWYz/zB7n6
 DyFydT51pT/bBip1ZJrIP+V/8eNNc/O+QSU3wEUfKqOI0IhBRil0PJgvdo+kCNH3B34z
 kGvqQPF+tW7xuFZTbZb5Uo9SekL+VjACwQRiFtERu727bxCmxLYiqE5Fgmu/uTvkEDo0
 tkX7rqKsqWDU5X8X1q0ay280g2YjHqsoIqVd8DgmUXGbTcgMnSU188p4iGfV/7dmDoIT
 8f/yYPMYs5YJbvTwRIHKWmgwLNm+o7P/fJf0Wchyxb3twFdPuzs2hDZ6pK/PbTaeBrYJ
 sBGA==
X-Gm-Message-State: AOJu0YyonUhTfNCY7am3d4AvoEp2k7ZyYvXYvxkmttXKpF9nrTTj17pW
 E4WanCSZGLK6sJ7aS1k7V5EbBDJfnoQu8NVyL4hrICw1qFhIYAgWGkf3hA9G0A==
X-Gm-Gg: Acq92OEvcahtnkp6jTTLpfJCOTfSTKq7+xv+DAQ8Dp3BRl0PbNy5PeZfOLuMgZDa3Hj
 bgzslAeV//HE58pGIqivmASjZsdYgRVTe1nt3JirC1LrXaQHl2+FmBkBtw9QoZ2Y69oJoElBMu/
 HaRcq6Mezc7BJlXhMW3fO+jN+mpM0DnQ3W/zoPeGdUrBomLLaZqY27dsjsVeqR+9Q3oboZocXYH
 WFIThMXTR5zfu66GdGF/KmnMPRU7Tu4wGiBGhrwPl1zvVkABDVsQ8POBmBki1kFoYA8J7L4L3XA
 VGOj5bHpObVzb4nNOFjmdUJqQy6lYvuCPQ+CTjbSqWAXJ1nnKfbBa6PejcEQfvYaoNPBipVSCzJ
 usznu/C0CXoWc2PN6v1I/l7ywzbBC3FcWyCj1i8WRduahAhfjPCaYPZt2lvLVSkANG6inPKLw99
 blWHZhP9NxOiMeXNK5FE8C3TGs5VemRxGIO88gcqbJ3H73XxxKvw69S9WD7t/fkEMP7dh6kzkLq
 scuawdu
X-Received: by 2002:a05:600c:a11b:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-48fc971efb4mr440475e9.3.1778607619049; 
 Tue, 12 May 2026 10:40:19 -0700 (PDT)
Received: from jernej-laptop.localnet (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d1f6dbsm12514895e9.6.2026.05.12.10.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:40:18 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Chen-Yu Tsai <wens@kernel.org>,
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/5] sunxi: configs: Radxa Cubie A5E: enable SPI
Date: Tue, 12 May 2026 19:40:17 +0200
Message-ID: <KHzalpykRXatGs1oStBoCg@gmail.com>
In-Reply-To: <20260511213713.15943-5-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
 <20260511213713.15943-5-andre.przywara@arm.com>
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

Dne ponedeljek, 11. maj 2026 ob 23:37:12 Srednjeevropski poletni =C4=8Das j=
e Andre Przywara napisal(a):
> The Radxa Cubie A5E ships with SPI NOR flash, so enable the SPI and
> flash drivers, also the SPL version, for SPI booting.
>=20
> Sync the defconfig file with the version from savedefconfig on the way.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


