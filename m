Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3686ECAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 14:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94172809A5;
	Mon,  8 Sep 2025 16:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MrB9s2Le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CF782AE9; Mon,  8 Sep 2025 16:11:46 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C97B80077
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 16:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3df726ecff3so2295848f8f.3
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757340703; x=1757945503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8OjmRy1zdV1TcewZUm4b5+QVniQB8Uid6EOl4nKsOM=;
 b=MrB9s2LehGeo3vy5PLhdXcKxhogZq0etKdbmyS4FF+nc6fuwt1oMturji2zdNk4024
 sTJfxRoMHc/mEY0QH+kGI0TG/xZg5b8qwr/q7jz2mcmaFNGwfNFtCVeEaIvYD3LgOKRP
 djd5nCnPoj8q39TZoCf1D55S3nbbE9UpoAHGEynEwtEMbiQBcS4h80uCBXm480lAP5cK
 BpJxQk387Lw8JDS+t+8lSiO9zZQKl0PFtBAbADZAflcNj1h/rpL81ESY5v72oJxvmBv0
 vf5RGQzY+DA7nYX+O8gH5CCumozZC9a29XyGwMl0tLy9bYY8mxqa8hQmC8bEpm8EAfsL
 OVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757340703; x=1757945503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8OjmRy1zdV1TcewZUm4b5+QVniQB8Uid6EOl4nKsOM=;
 b=oABOghOqbAKusS6xdNDKoGZ4q+hL67DRqUw3/3Ro6pbIULrJH1dAvE4wgVnumAop+X
 QOtk4RYdtZI4WsCjgeuSxcLxH9fS5aO0bUiwiVD4SMuCN7LCK6HOIncxz6Lzo8E0s9xl
 zaGT1A+sVilPTJDSqn3pST7U2PKqDVfaG+iaIy1nY0XbcHJhtxcLdIm8eiegRbX6dXfY
 pWSwSjHuLEypg2pWy0pQ+sL3jAoZZIdd6ArE/Twi22mr9oBKyp9b+qyD60Z5txtfEPgK
 OaXu2DxG5qbAdNq5T5YpZhyxhwQRue7jgdwz+bjf4rNqQEIVtVrnNyx8nsAEwxFASsGH
 shyg==
X-Gm-Message-State: AOJu0Yyg2DxVomJWDjT7kd5KAMidkl65wCoq49Wpoy3c7tj93Y5/539h
 k8Fv6xVaBZZT/fdhcMKbCOwe4kYwrb8aLzUEeIzuSSS8Crj11w/hQ7Kh
X-Gm-Gg: ASbGncujA5Umdgwcqrh0bKgJvO3ITMHUdhCLavB4vXB+7wcnTd30iMLQ/txhOzYUbcP
 gMoI+SKqcl7UBHUzakRFk5LuEtvvhYfVKGVzsfIpPh6BCzi8jErH01gmas80oA+EWIRiJJFsJvb
 nbrikvXZuQ93XgnBGCbPBt29ktBJiZfxINgQ/u5dWlkILoOFNgv9Rp3zSDpDzUbFIyS28PBQrKR
 KNIGBNvXOG6PWaPktgvQ/XxbzkQNKj58TXaCHeq0NFxDVCq6XY0Vxzh5JERpX60xv6UHNxStxRr
 WNW1Mgafpmo0uJvOHgKHM22ohHbcXcRPPiYSeQHTVmkvFhWWZhUAbh5qtflxiqlL2tnCFcHSXAK
 hf4N9nHQrHUrYTqAJ424XZYqFTbOg2v27ypLI+PNMLuwrPDOjahFnCOLKM9fmEc0EvfGR71gdQY
 8=
X-Google-Smtp-Source: AGHT+IGWLz19Vl0+/eQms2Pj3llONuuT8W5neNk/5fI3E0hR9P0m01Pnim45kDUcIUT2hLRLIFiUUQ==
X-Received: by 2002:a05:6000:2c0d:b0:3e7:441e:c9e1 with SMTP id
 ffacd0b85a97d-3e7441ecde8mr3711285f8f.18.1757340702896; 
 Mon, 08 Sep 2025 07:11:42 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34494776sm41513743f8f.61.2025.09.08.07.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 07:11:42 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rudi Horn <dyn-git@rudi-horn.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] Fix detection of odd memory configurations on sunxi
Date: Mon, 08 Sep 2025 16:11:41 +0200
Message-ID: <2234613.irdbgypaU6@jernej-laptop>
In-Reply-To: <9c947490-a571-4b35-b3a9-66c8174a7490@rudi-horn.de>
References: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
 <1927944.tdWV9SEqCh@jernej-laptop>
 <9c947490-a571-4b35-b3a9-66c8174a7490@rudi-horn.de>
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

Dne sobota, 16. avgust 2025 ob 14:18:44 Srednjeevropski poletni =C4=8Das je=
 Rudi Horn napisal(a):
> Hi Jernej,
>=20
> thanks for the comments on the patch.
>=20
>  > I don't see a benefit for public function here, since it's unlikely=20
> to be > used anywhere else. Just mark it static. Compiler can optimize=20
> it better.
>=20
> My motivation for this was that the implementation relies on subtracting
> `sizeof(u32)` from the address. This is an implementation detail that rel=
ies
> on the internals of `mctl_mem_matches_base`, and so I wanted to place
> it in the same file as `mctl_mem_matches_base`, preventing it from being
> static. It will only be called twice, so I don't think optimization is=20
> too much
> of an issue. However I don't feel strongly on this if you would still pre=
fer
> it in the same file.
>=20
> Once this is resolved, I will submit another patch with all of the other
> comments addressed.

Ah, right. You can leave as it is.

Best regards,
Jernej

>=20
> Thanks,
> Rudi
>=20
>=20




