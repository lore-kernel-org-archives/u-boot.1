Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9F0C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE3B96069C;
	Mon,  3 Aug 2026 19:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y52gqWO_1ayG; Mon,  3 Aug 2026 19:01:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4442F60677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785783680;
	bh=MD4aDhme9CbKD1AlhPhUTaFMw8yJG8kPJzri97dWsqc=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=gEOD/GdQx+mPjOTr/nw5HaYF9JYVFf2uh86HvEMErtFEolet+w9j4Y4eKFDiFUdjU
	 X6isRay7zkF8swmJOx7DRqX8Eq9mGBuOqYy5IHmxxkPUILMyJ4b0RnmcvddtQ9XAGS
	 nyxAb5LE8ObM/o8tl83yInfudPAk+9AVHThuOkR6mkdrhBZoKiSphpH5+j9PCxDh0I
	 vcxLW8Of44fuklZK9mq0fT83ihc8cMh85YLXJ8KtczGbgAJi4tSgCFWOah1SqULFJG
	 emIpdrlHdD5xV/JsOPswjqPi2sB/5DNpiA/C45XMkU2jJxcudhUUdJKQmViLRitsP5
	 dMvInj1Nejb7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4442F60677;
	Mon,  3 Aug 2026 19:01:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7CD5282
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88187403E0
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yvEon01hwC5U for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:01:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 39C694052B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39C694052B
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39C694052B
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:16 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6aa9606ddadso2547259eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785783676; x=1786388476;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MD4aDhme9CbKD1AlhPhUTaFMw8yJG8kPJzri97dWsqc=;
 b=MnvHVVVzaT7NOrNGfYjYZSjOQyQ5sx10ow9WKkQHjnGloxfqfgjEn2Fp/T17XMJXWQ
 phvsqysn1Y0EEoIgcGTJ0tbWIjV9Xb63Ba023Gl0KXZuaB+uituGQa+71YS+NmM4rDU4
 lxN3SjDeoVVS5+aA8Kw0iImQDfw8v+sZcJpn/TzfW5YwPxSj9N58MQQaDY4NKqYA2NQa
 pnz4LpAVgXfclaNb4/8rNbDZlCuGbA1ysrBJhRK1JSI6xM5F4fX7gKTAsM9kQ1VYkjlK
 7BvlYfukCTdFZ3T0Co2AYRdVUdPouk/8l8g8jp4ut4Or2s6/e4IBONcf3XIVOdSf56to
 xNGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxI7z6sy1UH36TPNFwnwEfGuFqStT/1fBf4qFQG2qb2+GuefgFfn1xhRv0TOvK+cXmDXQKTzE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx54dN3ivsCTGgDd42gHx0jkbRsY1896sPRTlftkcyTeWyKrjtI
 fn0PDgMVL2z7ra1ZGKZBqSehyqPkA9cXn0jlWImpeKdO3Dnrxokd8JI/X//HedShFCQ=
X-Gm-Gg: AR+sD12AGr2FVlbwV13pQajFap4Y47kxhdlJYssHvgihrMBm5EDod93ERSpQ4jG1L2l
 YS3D9zxUIW7J6MkCEfYfwx/mbdECQqoKTPi5gA6NuvKixzvBhejxyJjrVD7VwF0M1R63+yemhM7
 gDdkD1Rne6ipeqtlG7Z09OqIAIr/ztv/g51KqmHumQV/TfHU8shByGjFzFzP6eH0NkyQpABB0b5
 UeimSEnwq36fyh4JtPiFxpfN7eJM5vz6v2xCIkofBRCyh3cr/vZaR4UbwwoJ/GfoqQKTxYCe4oC
 2fwBW8y5Hp0J84u1tbPS043+fV/omJ8pWKfxr3lQx+VtIhCJ/O/pzyATR4V0MbKLf+5JrzelDoJ
 QkpSJ8Zs4kDKidmwx9Xt3vvNYmV59LQK+Y0O8p9gfncvX6C/762Z5iEWezUGyoc5a4wXt+pQ9qU
 9HNdNVrQEiBztfp9vVyTeRnKZwjdAIBDIf/qcWCLg++3+zRuFLugoAm5YXcNn1TCYW8YrYsWXaY
 XN5bf8HbxyPgQqPa7RubjcbRshxDnx27iPQXYKaLb6P53fF
X-Received: by 2002:a05:6820:338d:10b0:6ac:b6c0:2c09 with SMTP id
 006d021491bc7-6ae43181047mr12516371eaf.1.1785783675483; 
 Mon, 03 Aug 2026 12:01:15 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae39db1c5bsm7034401eaf.5.2026.08.03.12.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 12:01:15 -0700 (PDT)
Subject: [PATCH 0/2] SPI/NOR Flash Fixes
Date: Mon, 03 Aug 2026 14:00:33 -0500
Message-Id: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHlcGoC/yXMyw5AMBCF4VdpZq1J3curiEgxGAuaDiIR765Yf
 jl/zgWMjpChFBc4PIhpXTzCQEA3mWVESb03RCrKlFaxZEvNQCeyTHWGQ1LkrVYGfG8dfoPPq/o
 37+2M3fYewH0/GQvu/W0AAAA=
X-Change-ID: 20260803-spi_fixes-586ef497b80a
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1785783676; x=1786388476;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MD4aDhme9CbKD1AlhPhUTaFMw8yJG8kPJzri97dWsqc=;
 b=NiJqNBeXsE2S2CFrRDZcFnfKUrjZgyO3lozQD3gFants0CvYKsWuz7JE+CD370RIjl
 xjxrOebfhZPW3tWoZ80i/ld9tAd8e8xBMV4Em3FhCcoxO1HTpe5lk5LPkF27aLOpP4ke
 1jiaHA66HGOvJWkItBwQHa7JpXWwf/U5RhpTs/Z2vbhjJpmNN5s+y26T9MdASDUcOO6l
 ETBsrEa5kP6yNMS0Lg7MIkkYDOkenz2wRpJTLbbrikd8RmdsAs3MJwtLn12T60uzwsdV
 Uv1vBo5nthkDwY2gC4xiNgAQB/1Fqh2jsZe+tQ+/w/Ni6l8sBsd4Fxuz3Cjzmzo/dkVa
 AdZA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=NiJqNBeX
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Anirudh Srinivasan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Adds a new Micron NOR Flash Device ID and a fix to the Designware SPI
driver to not try dual/quad/octal modes.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Anirudh Srinivasan (2):
      mtd: spi-nor-ids: Add variant of mt25qu256a chip
      spi: dw: Add supports_op function to reject unsupported transfer modes

 drivers/mtd/spi/spi-nor-ids.c |  2 ++
 drivers/spi/designware_spi.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)
---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260803-spi_fixes-586ef497b80a

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

