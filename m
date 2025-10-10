Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB40BCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9081584047;
	Fri, 10 Oct 2025 21:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mvYcmCup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102F48433B; Fri, 10 Oct 2025 21:23:28 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB2083F8E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-35bdcaf79e7so1694802fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124205; x=1760729005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4QzzB9d/6oz2Wf0cdSnASDLkG3DrD4RNj8qllmqzck=;
 b=mvYcmCupffnZJ9vp7GQK9StUdxRaQ/xt7tReq7+DIyiE2T3ZHNCgxTBbW50dwsHRbJ
 TvkfDFnrKfbPVmnthUMkMo5WBEqWKS5JSy+tL3+yf1TbyVlqhtqm1UbJvWjE7zqFU904
 B3J6p8ee7aeRWnY6zAh34NVTVMUP6LK3pUOqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124205; x=1760729005;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4QzzB9d/6oz2Wf0cdSnASDLkG3DrD4RNj8qllmqzck=;
 b=FqlobEBfybVoAS7gjPeX/GgzNXYu7ICITKkY+gYsxwn3mze3ria/GdJMjKTn7M+rlo
 6bEjKl+jFDIM1uV4wB3/Z+m8IsfDw3P9oQPE0mZz79G6PKkvgEQKoQ6IrfaUlX0zKwfa
 mT07hKItdvLDcblRNzeI9mny9xi7omG7cMyTb/BwXnf1oHzW7kn5cYsQv2OsKHiVpTyw
 GjWwpthJ5v3JB+ylnP51PGiSywDG4ZGDArFtmTwoqq2JSfCilIbng6LkjGL8uf2noCPD
 fLW56EUhwEMABDeYjfFlbLk3Sl3wyQAD09r0ryhW1imCGw7+2fK5LglkKtFSwt6QOEs3
 gB6A==
X-Gm-Message-State: AOJu0Yy+gni6x/ZDlMTsN5VY1weQG6wwhNyxD7xiSNrcjRkD5VrHc0er
 h+oJZicv7ZR7GtQt2PphGvHS9j3sh3XUocpnosHZoK5OHJKwvhDKAvOBOKZns7ksCos=
X-Gm-Gg: ASbGnctqjUusUGCYcohloxt3slkPdLeaGhMfWaEbIbk9r96WLkh0/N9TfMjUZBE0kxq
 EMnjq/+caEB+pYSWWDbdWaqujQOp+ZNbtWwTdyVFH7ZfL85ezwlkfAQBFT5jQooNvECCHXaTvCb
 Bv6PftJlHgW4s4dbLv6yUZzMNYSCmx3vD+UaMwKk93cPpqymUX84ZNaj+Ak3XhxKBVeUMZB1vlX
 hU6e03XH+Bsx04FGK+8ugXPgWIOqBO8YEgZiWcp1Y5zNnqhghUuZ50VelafcVE+XhO3dO8DUo4j
 7hmLOKyaYqy5YspkBf2+cQFbzbxh4L2s10W5Bpnlx+9/N8LcTTxZ1Jy+R4F4pgMDzrmNMiH009I
 N22QBGQXXH4WhiQTYowJm+170yQ/nsTlOKCM10OHw9KPiNIVX0sAxMPwGKzkj4LL+Stv1Ez/B7z
 NhP0M=
X-Google-Smtp-Source: AGHT+IGDcqrKRk2dpx2e2rcvTaE8rRSplMrLhZ1qk1jh63ULCtxSbJTJKR6xQXmi4pLXIt17peZ1Yg==
X-Received: by 2002:a05:6871:6a0:b0:30b:efe2:c1b6 with SMTP id
 586e51a60fabf-3c0f81e9c9fmr6647005fac.24.1760124204641; 
 Fri, 10 Oct 2025 12:23:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com
In-Reply-To: <cover.1759218200.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1759218200.git.matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH 0/2] am65-cpsw-nuss phy_interface_t fixup for fixed TX
 delay
Message-Id: <176012420381.1180358.12293445850993917376.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 30 Sep 2025 10:05:09 +0200, Matthias Schiffer wrote:

> Following a discussion on the LKML [1], there has been a clarification
> of the correct use of the rgmii(/-rxid/-txid/-it) phy-modes [2] - namely,
> that they don't describe the interface at the MAC or PHY boundary, but
> whether the PCB traces add delays or not (where it is
> implementation-defined whether the delays are added on the MAC or PHY
> side in the latter case).
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] net: mdio-uclass: introduce dm_eth_phy_connect_interface()
      commit: 8db554dcbb2374a2dea130af56d781732070beb7
[2/2] net: ethernet: ti: am65-cpsw: fix up PHY mode for fixed RGMII TX delay
      commit: 4b10bcfdef9cb544ca80988fe36d307a622bcd21
-- 
Tom


