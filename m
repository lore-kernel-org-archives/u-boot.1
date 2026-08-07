Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17309C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE505812AB;
	Fri,  7 Aug 2026 14:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2BS3qpJ9IL15; Fri,  7 Aug 2026 14:18:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C11A68125A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786112293;
	bh=0Qw1G3CNHUnTyvxxA6FfC0Sw1MERbIAoUnjBp3cp8Mg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AUSFAea2vB+9zyXzIV1QS4CUeD0o6RlZDpS4ILy5sG7HdTzFFVxPWYtXgXTRRoyI9
	 uIJvVZ2XBdFhsfVT72q3KhXE3GUSUFsiRyk7JjWldnWB5EN28uZ/WNH8slVHBYN7M9
	 VYfTeC0J55uwLi5WG34b6BE7TLzwcAyOnujQiT67mvG2BPy/0EopTH9PoVqaLaItfC
	 WTKHyTbUYTHX/3iPyVLmIgRP2CuZScft65GY2oWC4m1tn2auqL9ZQNdOBorfR7dDV7
	 O1fNafi9sumQfXO4IgZY4uAx6Ld1fH+MCus0ZNZ07kE8IWgGY3pUqqWnZg5+9A+GB6
	 hfFmqJKZp9ghw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C11A68125A;
	Fri,  7 Aug 2026 14:18:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 696612F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FB09608E8
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id loodytvOv9BW for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:42:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5FD0D6070D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FD0D6070D
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FD0D6070D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:03 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so17222795e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102921; x=1786707721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Qw1G3CNHUnTyvxxA6FfC0Sw1MERbIAoUnjBp3cp8Mg=;
 b=ixEMjuEzOyObeV5NcFQymvIN2aMIXYkg7KvhzyQIj4pOHh5k3KF2mExx2HtnTg8vlR
 lSLa1JTHjq/r4GZvfbcQfldwdi5rvWXAuRmecEFja2ryoHWVYQSy+pce1pgkC7Dj8OoI
 VZfgZ/uKYfpRMQQP0xGdb/ednSIv48FVXJKqI+c9WKX5V3q727nLI8BRQVF6JM5At/QK
 xqfVMN5iQhUW8xSC0MO9iG4j8AolsjC2gO7bEqUacJ2YXmzeJvTrb8156qHfsXX0NqyJ
 xOcr9n5cWTp7zAMzb9PUhCIZO5DpujHinz+Jc/bStWgZwk51HQ9kf/QxXrGOcKOy5Asq
 exiQ==
X-Gm-Message-State: AOJu0YyNSDZ5QtJVxoqybUdfSWx54Su83jmgOxVZIAUcDPicrqvmqJzw
 a7c1nLoDTZZ9L6VzhNtDE2Ww8JCXAT34PqxTlzMzWtFIfylIpuxdNWEu
X-Gm-Gg: AR+sD13e29ZJq42YPQuk/dNA7vv4XmRewGqEpieR8hzqlDfvKMBksiqB5UNy7TK1juQ
 Em4KK+NVtUoojILRv4+F1W6wdweoC1EX2bs+MvVM/SF95yYnFOhFhDeOGq8Ape1Xr2I1XVxCXU8
 XYDO1k848kJKqV+W1jgZdwOQQ5SvsYVyQ+Y3cJF7autXUf2xilGoown2jkXH0d6Nug4de9+szJZ
 M9hCvJk9hP3TVCIi2mP4yhkD4tIJj4VYLI1EVOoJPPcsLgDfN9CmR142XFidUv8Meq+6KLa0MTP
 CApF8NQ62scCgmO1MrDbH/Cu5tr/hRusev+SxdmOlzQbS0Fcae+8GAD7kbohsUvsfS695eQbkwe
 BE1pWJvUH4NYK9Klw9vgyBMAXyUrNMx/1jAqgdZXQsSCsd5gj7DxQN8E124sYNtYNM9qwc7wdKp
 ydC5RJCLBULPlYJ2Pi2g33P80zRs+02k76fTPtJMc5eTtqs2mx29FPtQ==
X-Received: by 2002:a05:600c:4f49:b0:499:4892:e84e with SMTP id
 5b1f17b1804b1-4995e0d03a8mr43751785e9.11.1786102921269; 
 Fri, 07 Aug 2026 04:42:01 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c7b2898sm42085455e9.4.2026.08.07.04.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:42:00 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/3] board: toradex: *-imx95: add support for Quickboot
 autosave in SPL
Date: Fri,  7 Aug 2026 13:41:51 +0200
Message-ID: <20260807114200.271420-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 14:18:09 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786102921; x=1786707721;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Qw1G3CNHUnTyvxxA6FfC0Sw1MERbIAoUnjBp3cp8Mg=;
 b=Snv2tKtmdNM7MvInJF7x5qHvQBHi4O5mYy7Jam6HN7iON8hwU5DXJrasoxiOHQfLRe
 Py0p9M0cQEbLof2eSh2qqiWotXwmGQFUoXgNSfYNwELYNRnBEzJhljdKMX1/Je2aX8cj
 66hJ2J7Z1hN3+rPBsZZKjxb65a4mKKTLnU0PyOqy/6Qw8YT017cEqqxOMPcngG9ZNhKj
 FJxaGiZ97WR0MGlbi8FyNKT7lBAcyrYN8bQtYyOyKhWFfcVRzI8Hoh58WbpVQ2Di0nWv
 PKYC+h/HrG1g9/R9EfTEUgo+yRI4I0BJG8lxpyWVPlhAFM+Y1Q+t1HK4pB6Ldc8x8F/Z
 owfw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Snv2tKtm
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

Add support for Quickboot autosave in the SPL for the Aquila, Verdin, and
Smarc boards from Toradex. Quickboot itself is enabled by default.

Stefan Eichenberger (3):
  board: toradex: verdin-imx95: add SPL quick boot autosave support
  board: toradex: smarc-imx95: add SPL quick boot autosave support
  board: toradex: aquila-imx95: add SPL quick boot autosave support

 board/toradex/aquila-imx95/spl.c      | 4 ++++
 board/toradex/smarc-imx95/spl.c       | 4 ++++
 board/toradex/verdin-imx95/spl.c      | 4 ++++
 configs/aquila-imx95_defconfig        | 2 ++
 configs/toradex-smarc-imx95_defconfig | 2 ++
 configs/verdin-imx95_defconfig        | 2 ++
 6 files changed, 18 insertions(+)

-- 
2.55.0

