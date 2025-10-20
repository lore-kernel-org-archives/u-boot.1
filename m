Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B62CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 15:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B7782C84;
	Mon, 20 Oct 2025 17:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1v6ACn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24646831D6; Mon, 20 Oct 2025 17:20:46 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43568807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so4104794f8f.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760973644; x=1761578444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GteNF7tzIOEqgoF/L+YflncxNMHTrZdD5d8VsX6JS4E=;
 b=Y1v6ACn3UTBfGRsw6b53eISJRtNo9jWEsAj0qMkhVBxC85ZroeNZ6G917p05c9h6T3
 z1PGU6YuHcvWHLqvV5WQG3mN6rbbW19wXpClNBNsEABZQa4SUEIQBjTgsS+T2ffDZ8+/
 rMgEVU/8huFe4vS9ugRoDMXga3U9Gj0Ltgtm8LnJeP2S2FNAvCXVGNbClymhhlGIdGw7
 wOmKdfBAKU50xKs+1+Dg+5vVl+8EBsZDkVI9K0RSpl5MVYCsqS6cDiiN1xo9djsCyIsB
 N6KDP4V+rkzOIqM5KPZVNsSZxJ3dxaU5bDiBRPjOm28TPjqzCWDwXNAcZ2AFUoNCPv3y
 yVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760973644; x=1761578444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GteNF7tzIOEqgoF/L+YflncxNMHTrZdD5d8VsX6JS4E=;
 b=ww0Dwg4fXoYruFz3pc3doZvaMmfWZ4bAgMuoizxBLPr/Osnivtoev4ZRJVjXf6liBS
 CF92tAY2rE99DzkX5txmlFKVEC+bFF9jqXrpANqpZ7QZMIsLdzBS/Pf72f4eCg5QtEIv
 QmURsqJceYERUaYM4bhUnlp+cPYtZ6KolNS1eZv4d/2tRaYVHBGujD3iAyyqw0Ci++WW
 uPwLrIDKdE19JCrMjau06vUgC0H0zSWYOuUdWFKpxXVqWBoyww6bbxLPfEOs8VqQRKfs
 sMfjycYPYE1feJw3b5KP1kDMyWC2a+EjJxq9ZgrQK90mQkpQTSGLNMQyLG7bXoG8m3Q9
 Q5cw==
X-Gm-Message-State: AOJu0YyVLxLgVObX4jEGflhrNr9MzFuphpuRskEvSFScCHRpNnUJUKMU
 8ebxdQfcSgq2ieAD/2bNpR9Q5cAhr1fQ5SRPstpM4gEGEwvEXXtw62rKubYj0g==
X-Gm-Gg: ASbGncucf9Aaw8hKctvhijWFFe8XiXTsIoT2eDzDZnGj0M72RACUIh5mUkirrwqj9Ui
 kKn14Do37KTbB4EB88MHifEC9tSdn6lThhBfmPrZJ6E5FvFjWqPHUTXmH+HkitnDuj24L5NoAGt
 P51qSKPSAgmKfskmodYTPNw+yTsaMczKWltMpPP4O3TGL9kkqWKlSLOynn0SEJ2m0w3BIPjkihn
 oAc3mUfa9/Mt45o8smXVNXpsXh1p8ILKuXuRz3R8YOPOPuCWmOEQkwmA2mCwwGwkTPZWaJWkLjH
 ZwSjxNUKUIBf+ieUZt3c4YcqSM45ga6wj5t0OjlJl9nfzO2+JLV2V27QETY8ERT4nGQmjqdyH4K
 iXjMGZ4dCFseEJJR6ppbW1adLKquSq2GCEs06gjsvgoS19+PpaiRilZtetUJLz5H4MqZwvHeSvO
 fXvRHR7T8T8/3BKov1upHPZnLZ118rwPNdxUgqQwwMI0Z2DNnyEK6egkMYQAvgjA5/PacZ
X-Google-Smtp-Source: AGHT+IEFMj+0Aqv0uMo17I5lr1LLsfg0Pahecr509ibKNpJV31Ik//CmchiG9+H4Ll+VZU8YWaO9Ww==
X-Received: by 2002:a05:6000:40db:b0:427:8fe:435f with SMTP id
 ffacd0b85a97d-42708fe453cmr7286977f8f.57.1760973643606; 
 Mon, 20 Oct 2025 08:20:43 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net.
 [178.79.73.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a9a9sm16321753f8f.29.2025.10.20.08.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 08:20:43 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [PATCH] sunxi: a523: Re-use H6/H616 DRAM size detection method
Date: Mon, 20 Oct 2025 17:20:42 +0200
Message-ID: <2384364.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20251020142622.1849108-1-andre.przywara@arm.com>
References: <20251020142622.1849108-1-andre.przywara@arm.com>
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

Dne ponedeljek, 20. oktober 2025 ob 16:26:22 Srednjeevropski poletni =C4=8D=
as je Andre Przywara napisal(a):
> The H6 and H616 DRAM initialisation code recently gained a joint and
> improved size detection routine, which helped to avoid the occasional
> DRAM size misdetection.
>=20
> Use the same code for the A523 DRAM initialisation as well, which
> suffers from the same misdetection at times.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I was a bit perplexed why code size detection doesn't work right with
current master branch. This explains everything.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


