Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5F7C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 16:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3889060D7E;
	Fri, 25 Sep 2026 16:00:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5DixhpVW-B8w; Fri, 25 Sep 2026 16:00:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5F55260C09
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790352016;
	b=jq/GY/HJJXX9p8oIb2VMuEdCMduuFSbDvntoHYlKesHPXuKf3jG4B8sJ26bxr+jCO1vO
	 VGz7qYt40SzOBix7/SgqcD7g1YCpL5sMrdR08OprDYGJ6WFRgaZNPlNeJAexR8oc8twSm
	 KlwQz5LZr+URhNHSdiALZPwTs2+k4A7BQeC5UAfc+jNwFSSy6elqTn4sxTCyeubO15pja
	 OIlBR3ymy3gHz/HWnXahjNXPwVRUQ5aLelOWRyRTgXeudEl1gN2Umm+Y20XG9Mf4EeO3Z
	 xfnkKEH9XAAjlGku84KeUPKuY/sURi2G+zY83ugo5Hoe5EgzsVhLi3QRsxVLxvxZAPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790352016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UAYh+eQx0EcmIL8ze3hNR3K0bEXhura/0exDirvvSoc=;
	b=h9NAm6FFeQ7EZoZOsBAMA0LuFRvtJLMfolLQ7sD1t4feYFFQpVaNzFn6Lwn3sQd3A1zU
	 2j8Lx8FX2xNgfXCH7m0taKnl69Qzy2DMtrY142cQDt0SHQC6G7EFUNWUv/aapmpoUiyiR
	 85xR+bt3Ex4zlUd5/94k1RDgCIZaBkRil72EGsQyrGvYW4XiHXDcMm678KVbnk/whbO2u
	 /h73TooG1kdMRAyY5M8PiPI26moQ2DYHGzEsaX0UFe/NuSXYYGgZM1OtX+CXRgKxluyWe
	 jEHIysJYc3dY5LJfLQmld3EJt7DU7sE7S2Ogj6v/e0NANK/5WhSRxVsLKxKSoN0V9xA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790352016;
	bh=UAYh+eQx0EcmIL8ze3hNR3K0bEXhura/0exDirvvSoc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XL/cByLwMQ08E8gFmZ9b7KHOMhZ39/nLPaCuCPxeYux66RPtzrjIiWqrX1SxUYxUi
	 EZOj2uHj9RsTRcV5lUP31rf1TjoS1nIDWeq1PULi58ljEEG6qHNs5iy/pZFgpsyFTP
	 Ovm56kU/zxPCflM7otoZPDSsJrPBd7LmL0VVKG0dT2h9ij5mLSVVmARIL9sXyM0G8e
	 Olt7iLiSF4Dn6xLpqgba9dsVTETKucFNjedM4T413AgI4jjrKGNt6LmKoOB8JFSoVE
	 DWUNOui68nKa8Uxq4dgw5EhfNOVhhIQp0Dd61FZWrZgdzdIqRQD4wWNXJYMF5VpVr6
	 TS11cFpG4UZXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F55260C09;
	Fri, 25 Sep 2026 16:00:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5869B334
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49B8D812F2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nAmi03_WclM4 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 16:00:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 63AC7812EE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790352014;
 b=RZksyQNpm5JU52/H0O8SSXWFFU5vUpEnGyA7YMMaJeum9cl/dsVeHZWd6oFYI99DJ4Mv
 R+Dc1EK7LdKztzpLA/K0WKzpIV+mSGb49NswxVzkp9ro0pAcjSKXNMIQzRGT0O89e0oPp
 U2WRkaJl7VYzlD3b420y7sCla5CPrlSI7QLvEa2X4aSdHgvc+E+Dd2a4QLI8QK13wFd4U
 n2tNGe0IJK5yqCoVYPFdGNiy0sD7EZeMpTPgVZpcrQG5DgZYyWMnHjDtaA6drvPV6H4nT
 5SSGBaEchPq/DjLfea5Rt/tnT4bZ9fFl4mXFoVuKmPeVYarE1SsHYmNf5zc77foyvmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790352014;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=UAYh+eQx0EcmIL8ze3hNR3K0bEXhura/0exDirvvSoc=;
 b=i/OI97oC9LKj0tRkXHmNgkkk+GDG/014s5dXq4Cl9yWVz26gImTg6D9bIyttLhaV/yDW
 ceHxouE7vEEbNqwl51LTijywUAGrl0cApDUPUkmY57Wiu8Yqvrsop6ZriqpU9gQ2BXsEi
 I5tNdhZHuAmSUzc+HiEebtRf2U3HI+HEtLDikyeTUt9sXxOwHxJ9FZtaEq9Cd/BdwFye0
 BaWib6Htb+c1Mv7N3dU7xnqj3RlzKVVscdg+SVEvShBj8GY7Z+MUBS8TTzMyDrOLgvl3N
 71+yCNEfYgrIbtawzhzCctVx8nkIV1tk1CKyy60Idt8bWA2El6cCBf6tMRxTNg+j0eQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Jyj3r2k3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Jyj3r2k3
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63AC7812EE
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:11 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6d06a12d360so613558eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790352011; x=1790956811;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UAYh+eQx0EcmIL8ze3hNR3K0bEXhura/0exDirvvSoc=;
 b=Jyj3r2k3pNPCt9+yT+MGWoyqW7x9LX/Hr3ByReg04TzMIdoTqAdb+H6dGjTYnCm92U
 tjuAyc3Y0sPakUjTYH94w89M2uw1UCQG3wjJMTTgcHwqAt2iYO7FBt74R+Qp5a9EFHMW
 A7iRw3JG9QSMAYtytS+yETcfpNsDe9DrtyHgM/sNa8A/e9H5HotWg2uAWDvh/gx9d3xG
 Dwchi3aAVL3iPeV32zr/3/CTjeDjT5pM7gnuccARdXgqK0Oo92P6DFy0cRImW/lPSMRk
 VRT7aBnvX/smDJfOkN3t+osgUMCAbavnjedJcGr96gHakjc/hRbu7utzz5tIu711JIvK
 RdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352011; x=1790956811;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UAYh+eQx0EcmIL8ze3hNR3K0bEXhura/0exDirvvSoc=;
 b=Ros13tcmfN1ZRwAF2J01HuCMywzckctPiez7fUBnnmlBrDCA+n0RIHCvbZ2ipgfOz8
 KkrWWK63bzjRIOvrKrkbDEWyOIpk0mce8O+lcOu/4l+6Kqdzd3EXQlWWPDt7LoLgAACh
 9t+PGtTFMsIbzVA5g8J79Yhnl3Z06OYlDoJQX2CDhVeDQgiKpURSJd68P99F9yjjziJi
 Q4HZH7v9WvV9N1e+vW99MkDbgumrEmwdrylWZRnGvRFXGEfyyn89iCWu0W0QusefU+jH
 13p7YZjkshbkvk135l+PfGzuP+ZGuIfxS1saE9hiKJ/W741bAQMUOtefJHPBaO30rCja
 AlWA==
X-Gm-Message-State: AFuF++mEidHudmrcxoHGYKGHtA1XzvtMcXX+X7vr+lc8GnJaFd8ryD7A
 LfY1lJQOQW1zd1/bigrUzjuEaLDcrHxu0L3qBclUB01ATRM6x537LdQFMfGrVk0MExP/76wDZS0
 sFkMF
X-Gm-Gg: AYBFou0oZ3N7fSv1dKJH+BE6ekiMjhQzqhGf002ZfTOykB2lE3k85xAPYdJMY0Bo8+O
 gtuEWaoee+r7c7mseKBzvjZGcSszY2xVSxrYr/T1NC62Y7jflUSHFiW3/44vHyroheU+G+do8el
 bH9TdKE65+sxywcfrqiQZkTQZXMqv8x99XAAdgrJcCGhj1JcUln0Ai98ZO9GLIfTzrQ94PfX8y6
 ebWJHIfxwEzToG3DH9fZqtrse9N/HBZKGoXhWCuY5ibsoUefGwfJxkguYpT78gMyRRStb/mmfCy
 2yscIt/kNa0/GQOxfzn/63YiugBidtEqvgXiw+ovsWvRaXXXnORkFMJSSTgiSPyT90sFjPdiXp3
 9pMh7LieHPL9NL5eYrx2Xtr5hrTdHvyE+rIwHSzI7CSyRIovX+niR4aqABLB7Q9H+GIEGtPpUO4
 6AwC2s1YXQfmWEGTTQ7pUoB9waB5K6XECasKOQ/HMjDRrek40ZC7vL3j6tuIAPdLvhOoz7eno81
 Yw=
X-Received: by 2002:a05:6820:4b13:b0:6cd:3fbd:1d70 with SMTP id
 006d021491bc7-6d441a8d4d5mr5627294eaf.90.1790352010854; 
 Fri, 25 Sep 2026 09:00:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ecea:a30a:390f:322b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e6211cedsm2469164a34.3.2026.09.25.09.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:00:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] clk: mediatek: propagate rate requests
Date: Fri, 25 Sep 2026 10:59:35 -0500
Message-Id: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyMT3eScbN3ckmzdgqL8gsT0xJJU3SIQYWxokJScbGhqnppmqgTUXFC
 UmpZZATY4OhbCLy5NykpNLgGZplRbCwDJ8IYqegAAAA==
X-Change-ID: 20260924-clk-mtk-propagate-rate-310bcc157ef5
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=UUHamYzZuCbOE2HA6q7WatG8uIYGAb6wGpR63qOkIHo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtppuOEPm7NtFGJCvMIJ8gTFYUwW+s4X7qEb89
 o3sod0bDvqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaraabhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1zYH/1UVtorfZO3mRv7a/hGa4X/urwgoZ7OVB652USY
 uMAPlX5hCFK+/y9KKOri60ghDVe1PP3tp+iDmW4ws7cuWzcQuL9gcqcitnTaR2IB2uyAlUTt0+h
 TLqWBGq5l0/KPv3u7MmYGjeBjQgKxBwSwZwOQzhMiu4T49fIHBrmL/8543rKL7w1J9h68nv04nG
 xFMG0oYRHjp1htXHlPowYNpK/2ViNqg6AnZ4IalmPS5XYcKF5zPhahyrLqx6nfoPQjua3ZU5Avl
 9fY8wYCH2Od2NrwurlBgNqxJvvV9Sp5h7VLtB5O6QTNAUEHJKOkjZ/47is8LskbGhMImjcaGW+Y
 HqMw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

We will need to be able to set the pixel clock rate for the eDP panel
on Genio 720, so as a prerequisite we need to implement a bit more of
the set_rate functionality for the clock tree. The way the eDP driver
will work is that it sets the PLL rate first, then sets the rate of a
gate clock to get it to select the correct parent, which is the PLL that
was just set to the exact rate that we need.

While implementing this, we noticed a few bugs in the existing code, so
we fix those first.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (3):
      clk: mediatek: don't truncate the requested PLL rate
      clk: mediatek: return the new rate from PLL set_rate
      clk: mediatek: select mux inputs by rate

 arch/arm/mach-mediatek/mt7629/init.c |   8 +-
 arch/arm/mach-mediatek/mt8516/init.c |   8 +-
 drivers/clk/mediatek/clk-mtk.c       | 283 ++++++++++++++++++++++++++++-------
 3 files changed, 237 insertions(+), 62 deletions(-)
---
base-commit: 28bd3cdbc5d75b2b0a5dba4bea4eafb578a16191
change-id: 20260924-clk-mtk-propagate-rate-310bcc157ef5

Best regards,
--  
David Lechner <dlechner@baylibre.com>

