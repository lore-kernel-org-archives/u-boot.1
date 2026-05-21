Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2163CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 16:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AAA8482E;
	Thu, 21 May 2026 18:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ecVQHGbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8288F846FA; Thu, 21 May 2026 18:51:24 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0007844CF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8070C25A84;
 Thu, 21 May 2026 18:51:22 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kip3PJQDmdxa; Thu, 21 May 2026 18:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779382282; bh=3Q2TTv/mbyCw+Uv6iMfEuoXmFc4zhJZP4ldBTjTUA7M=;
 h=From:To:Cc:Subject:Date;
 b=ecVQHGbAH20dpEFxhtyADVE/jGPAika28/LsrRV1XFwAPkBUBWUYFGbCQQx+Tykop
 P3vgvg5mfZLXhgdnSo2hvtfYFYjo1uOfG+XqXS30GBZXy5nOm4zV7d8ThhMVB/DOUS
 Lm0RSSeRH2uMQJNdcXbwvYH0oT06j2LSSxwxyIqbHtJYX7TcP3olb48qko0nkDvD5y
 guvPk9RNYVgJ7s5mLgYTrfIzGlQo/Ah6VXe6dIeYC7TJWrC5h228fPVhexuxK0lzfG
 Tbof7pMyNunV+ypZt6zPDSHRfpfwA0i/2buHLUpj251cBFkhi6FFk2SArDhPxaRKTX
 m94N6UCfSZf1A==
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, trini@konsulko.com,
 Josh Law <josh2@disroot.org>
Subject: [PATCH 0/1] libavb: fix avb_replace() OOM handling
Date: Thu, 21 May 2026 16:51:21 +0000
Message-ID: <20260521165122.17475-1-josh2@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 18:58:03 +0200
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

Hi folks,

Since I am a new contributor, I would like to introduce myself first. I
am 15, I am from the UK, and I write C. I am interested in lib/, ARM
devices, and Android.

Enough of the introduction. Let's talk about the patch.

avb_replace() is documented to return NULL on OOM. It already did that
before any output was built, but if a later allocation failed after the
first replacement, it returned the partial buffer instead. The callers
only treat NULL as failure, so they could keep booting with truncated AVB
bootargs.

This patch frees the partial buffer and returns NULL. The existing
callers can then report OOM instead of accepting a shortened result.

Josh Law (1):
  libavb: fix avb_replace() OOM handling

 lib/libavb/avb_util.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.47.3
