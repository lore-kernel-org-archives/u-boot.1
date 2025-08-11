Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0713C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 12:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF848329B;
	Mon, 11 Aug 2025 14:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L2AEpybl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50DB8832BC; Mon, 11 Aug 2025 14:53:12 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340E183291
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 14:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b3bcb168fd5so2764857a12.3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754916789; x=1755521589; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h5bTstWsz2Pe728tvNopTbYj2hFpAtJq2OXEm4lDO38=;
 b=L2AEpyblCJ5wNMr07nRH26Gz5xWlewSP15Cc43Jo9nnGDONmYKR69sKw1tChu8UstR
 4UKS2rsE/bmai/rgukdN2gNo4iBXpmPPedUDeuNWVQ329yR/YfOz7fx1bbypQjy2EyQJ
 9tZ96teork9BKzPHPd2gtXdo7m3xl5Q8oJ+OI0x210QCN5GBsN2uqErFtgxuEurH06Yp
 kDsTDfQMNjso+5w3jufozhkMG2zLbkFy7AAaBK9SSEbUmDZAISeCGp4ltRBsY0Oxnn3F
 VfspLT4opq6xe9Xf7JbJebxXXglzjgggIT/CDTMKK3R+yH5HH4sx61fXpKncP2nWFxzR
 jPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754916789; x=1755521589;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h5bTstWsz2Pe728tvNopTbYj2hFpAtJq2OXEm4lDO38=;
 b=khubkSb34MZkgz8VM+JvjeReb+hd2ASrX8nPm41FWqEKXCs52n/lwD494p+/0zsn+k
 MHqqut+4Moiz4lmS08eyTDk8ECYmntmkqt8ShDU5MKxJM3Q3IPIqscJceEq5PQnw84se
 2mnQeUXVtWBkbMBUWeR+7bHpddLhX8HeOLaWM/F8esOZDbsKqEa1vRUmV4+HNyleNLPF
 8Sdaq2hTXe5WiIFsckl9AYKKdQyhlYdOC/1sZuc+izaJpnoVxp4KSKffqvHikWpsle58
 bbkokY1G5Q+wuP+MNGecxSPZItOgM8ql+dpGMToI0Vi/dxaIVGYg6Y20j0b/u9KX6vBY
 O4aQ==
X-Gm-Message-State: AOJu0YxDQfSmgnoNiIn8oBc17BJ5YVSAXI+oc2Ma50XLimL75VZSoq85
 K1RO+dCywSuzHE2bpKi7CKfgKFEgHkRl9oHUpcEjpiYWfl7XBX+cVNni
X-Gm-Gg: ASbGnctz8W9YFx/Bdq8Kc6FQ5Mpf/ArbjDwJdyhCIFp9wxbFjshByyYdOwZCIH4NF7k
 tEnCB6FtfOmXRFvos/HVbDASydvxSuUOXTJmRBvjjFJSGTBlUAf3QdGQ466/+zU7fsD5POF2AVp
 AyottQbzTsWsyWOV765PGT05kemsKs9ToPK1KX/Jx92S0S+cORdWdkNJ6WosO/QwwMZ8Kj42fp4
 aJA/0vowTrIieQwRgN7DVao53rInRtjXG08ZPstRn9oeZBJ8sfr8pgf2gkE9yrv4E+OsM+E0O2A
 PcnMR35PZK6yOl+/h5DxRxrnJ45WzZPewUCQeOUoYKlltfbtO7eT/vuO6L2LiWlARdcd2ziiJuu
 GJ4OIlLCapkyVJ6QwSPSRqtZSPmQrot5ZaQ==
X-Google-Smtp-Source: AGHT+IHNRnwH3GpAUGRLZKvis9+w/NlnQlr7YHruyMhO6HO7pYAdf3u+et1uNUeqdWmajcgSOD8Ahw==
X-Received: by 2002:a17:902:e886:b0:240:84b:a11a with SMTP id
 d9443c01a7336-242c203d400mr202808285ad.17.1754916788489; 
 Mon, 11 Aug 2025 05:53:08 -0700 (PDT)
Received: from joaog-nb ([2804:14c:490:1191:2ce:dae9:57a1:9602])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6825sm274611105ad.30.2025.08.11.05.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 05:53:08 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:53:03 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] arm: imx: imx9: soc: Fix env location when booting from
 USB
Message-ID: <oegnemlwfr75bheyomko5dgl3n4xqejf4ce4mkqtvjfgblytn6@w6zrq4uw76fv>
References: <20250811-v2-fix-imx9-usb-boot-v1-1-95433f3db81d@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-v2-fix-imx9-usb-boot-v1-1-95433f3db81d@toradex.com>
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

Hello,

Sorry, this must be the v2. I will send again with correct subject.

Best Regards,
João Paulo Gonçaves
