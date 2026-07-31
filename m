Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19364C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D1F340E4C;
	Fri, 31 Jul 2026 00:37:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIcYFcCXw3X8; Fri, 31 Jul 2026 00:37:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC50B40E44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785458279;
	bh=5OadzG/b2E95NCslzzXdxAexgJdWgqAwa6B6gXI8WsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aLIcsvCkOheRLnLexa2P5aN5vnJ/7KBiAHjiHQ42MwFSKa8ta7M3/MkQ8N01wECZj
	 q1a8RC92Uj7+tWDF5OJYe2aL+PsZVuu0eHy60BWzA+2dEGYvsJYtcLuf8L3juJbQZt
	 mo3gDrx4BNNcD/eR8H/hciKIdtAx96IAHLjGalHu+gIetnpJOdRmjeoehRCNCyt0r5
	 IacewSE0B97msATwVMdzhXvSIQuY7Mkax9PKOCR7iyo1QNdSOYlSnj17cDXzLg6zpn
	 +CuqniqfCloL/NZI4pLfxjqc1d2RIOzPphoX5rHlg4OlzdYTjMe2NLS6jDJWeHrnI5
	 clIQh6qzPlDAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC50B40E44;
	Fri, 31 Jul 2026 00:37:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D373927C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4F5C80F09
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:37:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DrmJSNGeIO08 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:37:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 09B4D80C6A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09B4D80C6A
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09B4D80C6A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:37:56 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b0231a3e86so388388e87.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785458275; cv=none;
 d=google.com; s=arc-20260327;
 b=ghretRDoIPpYOVK/Zxw5wajIolYZ9C4jyZqRbplNeD+NZ3S2h4dSyZUGSWHqGH4CAL
 Ned0aU3BJYGiqxHoGgLEiVQCWmmidC1kEgJVy38KCfW1gCFswKfpDbYxZ5sZZpbj3e6a
 37Fcsa2Xc58vYYdRhLa4+xtSdDU6t6Tnk5CHsRrAhAVEY+TPdGJcyzVE8Gk7HnvLFAxI
 iSiTkEK3Mg+9m3PSYXOSKNHXPk8h9+xtMaeWrIIOnNM7NxqBaBCLBVh2oBuIPQ/3HLxd
 Bn8wgoDn3sXmcD3Z4uzo/Cn8TCEnJJpGf5Ip88XCpp+2b3ql0saAjcnYXZFU505ujmCQ
 FaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5OadzG/b2E95NCslzzXdxAexgJdWgqAwa6B6gXI8WsE=;
 fh=CNXu/X2zu5f27qgwGth4UJPoEVIXf/50S0Yx27PFF48=;
 b=hIjEWOd5xTguBKp6US49W40kvj+Ae6oqls1diK77HyTY6FNpi1g6sU7CP92jR2IEg7
 S+cZQb5KqYbwVK6pAhXhQpe01o9WCNNi3WrpSyo6F/Y+X2REAXPtpCTFX22Bbg6LotPG
 yws4yasgic3YnSfSKxeqs5PUTsAI09Q04z+sUn+5wgvk6rnBbV0LSa/+D2W/TNXLgAxB
 /VHS1SICnWW8nLsQbVS+T3GgwQKk6TZbL5Yjdc+IvYUndHuZKNmZA1MnYjGAl6Y7pJxX
 d6qJK4unl4vFgD/A9qI5mQKd8giYtpaxo5ptw/6344tTCoD2cn4a6fW5VhbePi0bu3zj
 FpAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785458275; x=1786063075;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5OadzG/b2E95NCslzzXdxAexgJdWgqAwa6B6gXI8WsE=;
 b=PWZsBqFO+HzZpqq8geTIg5Kf+oQppMqWUQX8jUg8rbedDfjdJeXf4szwiH4SwFIEpn
 xYDdEo05tyBTHPuGRRAIW8v73AZFr7Tpa/86Ac/4KEdwkoQn0qfPpH5RzyZV8ftRUO36
 xaDZgzdoS3Vv4PoMtsrDERNsumxiIQXlGydtJXbC6CM8z9z5LoMQ57VIq/nuuaPX8vqj
 HH7Idb8zAOLX7feEyM+pYUCB5X1W2iqEiMoL4nasCcCtPJ+p+2IVbTAmy/BO6gvngdgq
 aFQ/N+lkckM3c+Ei695RsJpljgXRJD1alMwac8nHZ+wDqEOKe7jg9gm5ze5ukKr3ILTO
 n4Xg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8W43lVKHtlqregQOOJlzMD3UO99d8V48AaWcuTKsiMS5ULGBx4ZtxG3/ptkICQctarSFJdso=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwGrG4kULvVlaGv/9wLf94wgzVst6biu90tGMyYPqg/ivL60aIk
 qcY9H3whmPASxOxNLunVLGQdWiiXGbZG77RdlR6q6HUpbQYU6kkiY/gwgCE/gpiFqdoiUZTyTBW
 2C9rb/XxUqF64lMMdFu57xmNoi+eJ97sS65Cx
X-Gm-Gg: AR+sD10bQ788H4fXPlnLH3fkcBT8MryBv2UyrTDqaGqtLpzwESE9Q2wJB0tlRJfQ7bI
 bA68V6Aj26PbT7Viq08Lgnz7Et1W2w9a285TNkjMzVmZ1W/wcoyL/kLHWesGzA6+gJaWPBR769x
 WBCrnqda2hxIiS13xKnoINEuRrtVw3tfmPdeDoazpB4/P3V1IBJfacXKNxx6tRJB+EGpDtvObLo
 y2B/XyjfjuPQsIoH2VE5C0tEcrfGI0vkVp0owwGMDIN3w+Ir4BmBxzuhfB4yv4jbee5n61fgToU
 4BkZ/+hQb0Bo0MKmJnBPZIkVOGBq/tmE2nUNNMJf40eIpORBKqgp3KyBw6grWte+kyhCnHqVMOu
 xjgB0lFFvjbCMk+xf2zwZoXZs0c2m0R3xazNGwTSwgC0=
X-Received: by 2002:a05:6512:1044:b0:5b1:543f:f5ca with SMTP id
 2adb3069b0e04-5b2e2002311mr12670e87.46.1785458274504; Thu, 30 Jul 2026
 17:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260722194638.1285159-1-festevam@gmail.com>
 <a49f6530d95c4ea1908efe23d16f8843@infineon.com>
In-Reply-To: <a49f6530d95c4ea1908efe23d16f8843@infineon.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Jul 2026 21:37:42 -0300
X-Gm-Features: AUfX_mwH2U1X_Ip53DeX7PGaDRkAjSPsFec8MUg4MUj-wxIQfgX-NbBq1-X72zM
Message-ID: <CAOMZO5AUHUEXvM+39N8oybY_W-+cRZAw0BDENGH1e6kB3PTbfw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
To: Takahiro.Kuwano@infineon.com
Cc: u-boot@0leil.net, trini@konsulko.com, sjg@chromium.org, 
 kever.yang@rock-chips.com, u-boot@lists.u-boot-project.org, 
 festevam@nabladev.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785458275; x=1786063075;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5OadzG/b2E95NCslzzXdxAexgJdWgqAwa6B6gXI8WsE=;
 b=e0TxcwuklNrLvpM3HuNq7dQjV8QMchlikh0FiUfof+XwpZgCM9fX9lD1DduVHIgE0J
 rwfL/VjmZw4yCnytfW2Rzhz/EN/3kyZyB7fd0MK2SJL5i85dEzkFa5qylTrHjfy6c5ng
 TGHszmmDTuYs0/+99J3UgZw4dipyxMV95LPqELMgKfnp2GKrvy+sT1h3sMHNR10hYLmI
 Xm/9N6Mg7pjiui9Z+u2anHgUo01ABiJTzNOj/O98A9Js9awxWKAQzPYrGRoEN0Xqwo2d
 ngm3o7aMelNKVWXPatU7bMHVkT9OPaARtZsFdqkenJArt9YcfH+HjkJc+alJX2FV6G6C
 JJDQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=e0Txcwuk
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Takahiro-san,

On Wed, Jul 29, 2026 at 5:59=E2=80=AFAM <Takahiro.Kuwano@infineon.com> wrot=
e:

> Per the datasheet, this chip supports Dual/Quad ops but for my reference,
> could you let me know if you tested 1-1-4 or 1-4-4 ops?

I checked the RK3399 SPI1 pin configuration. It only exposes CLK, CS,
TX/IO0, and RX/IO1; IO2 and IO3 are not muxed to the SPI controller.
Therefore, my test exercised 1-1-1 operations rather than either 1-1-4 or 1=
-4-4.

> Anyway,
> Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

Thanks for the review.
