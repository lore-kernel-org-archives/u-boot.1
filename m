Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F4606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tUYcvKgk;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QopeHwWa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4024E40A92;
	Fri, 23 Oct 2026 22:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jzr-oCgu1wqQ; Fri, 23 Oct 2026 22:33:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4966B40A6A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792794800;
	b=Dtl8Z71iZ7X68fx16Xxa9N+tDNznFmoxi4IYMkZHAWDEAwtUaEg6SqmqP2pGKVVxmsVn
	 QqiPMHRyRNbD62+1698sdAuxlBmVcU5sNrp6M+7enQxQpO1P3p7FKKJycZIPqTjVohhV+
	 ejlfK51DcQacmwRgV/ViBgaKe/sHq4+TQS/lMca3DcbacsizWTTVL8rMfjL87pi3ZHF5G
	 OeL1m44/xVjFWXkr/JosodJ+EerfGJrjgfG2fAMZ8XsaL4UEnTvZ0Q98TA0w5XKYUWcen
	 fmzpGQF504ndmr7GVJRXXhRD6kVArbTEOxzgcKHpEMUndCfocBWcrE5kELOAvtyV+0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792794800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=n2b4YGCTqfWw0gfmmg8+MCHBaNrdVtW2J8L4m0ulfZE=;
	b=hmb1o2PglxpkOjx1K0Xt0Rp3HWEel6f1aFUxwFmL380goxb27kgWDo1HwKeX/QNjkDVF
	 viqAKZBaMho80HUpGKv2vOdxY8MYLYu5B3oDPN+tS4PogX80mld5J6GoCzcH8bzLVgwll
	 /V3sq9JZEPq3ol358fyq1jTfAVobnkCNv+wSYwxC1hNkc4deQm0bV8a0Q72g2onmRwZl8
	 /vqlVVE7J+cCAyHeuIbuH6mNP9IswNjOz6DqKWznbFchLpQSDSmwWJtX/uDfbhcQ2aQyn
	 mDU6CH2UYgmppFIxbS7jo6jLvik4tkMDpfOxsZUPA1bntpBPE0XOjgjynEs3hJGo4Ig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QopeHwWa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792794800;
	bh=n2b4YGCTqfWw0gfmmg8+MCHBaNrdVtW2J8L4m0ulfZE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tUYcvKgkcVlrSw7Rk3rW5ClhMQyO5SQG0N+91CFewP3EuZhadVic6N06QgWARlJf+
	 TQMpHxRrMtEDipieebsMkXsJN3ElXhffMprKn4Uw+b1FAePkMWTUM0U7tWwdo5rLXK
	 3Jy9m1PwWL6mbcXurXkRxShF+W+8u2KsEjhrjVeuxC0CR99Ty+ABrROJajdkL1uILG
	 NviSj8G9o17wPjnTmhSFwTEDGQhiTXTvPKCHi4DY5D5yT5vahwur3fDyDO2nxQ133K
	 Mn4dDMD8lrLCX/TreuJWo9JRHaSOvL8pSlpSaVfs2d3PvKRsKlcW5ynnTFGGPXkDAr
	 dDLabPNrOyg7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4966B40A6A;
	Fri, 23 Oct 2026 22:33:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FA3C371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D00940A6A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C489NEiypZTi for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3604640A51
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792794794;
 b=aD8pQYyBlnDialmRaWgOKjqwblByi+61s6GlZnUcTXc7HhQ9kmH4U957j/uSTjExbk2F
 m6pbeeMjWCcBpiaag607nNrBCPPrQQZJA7fNqK0wPCip+lIqkZ7kxfhfaqljCZgd3tjrD
 Qk4RKFs/kwfUnlcJ0glZr+Jy2buxgkqnwkyRgHR7d2sEJ0fNjh9Y8pXJbIKtWyj0OYL6N
 H/RkI3lRiw0lRFjs6aw1Jd+xltEoL1PTEN+OPaLBOqOERU6a1XvQAmdpsP2VATk8Y5yYf
 sUOuxc9q0YhV1fDigitY7+K7FYctUfs6TazkVikhDE2MeBVmRscQcOT1bZh4L2Vl0dQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792794794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=n2b4YGCTqfWw0gfmmg8+MCHBaNrdVtW2J8L4m0ulfZE=;
 b=JVVl6VjP1t+ypVE/N9DgaCEAsMtaRtO3mFwwLx/btAHqe/PICS1cJURv9H8gN1iSG//T
 p3SfgCIbE3AtT3O80ldc+BiMoEUDzgxNCWLDtHCsYCX86uZuRmBejn0DEntpApADqaERg
 vLI/1cs/PT65wuqh4W6ClDfNqHVZQFeQRsNO3OR051Yeyu2yBxWC2Ho5dL8QqYLMKQQJk
 aCDbFI5sFtDK0fWMOT7mQtADa1BTnmV6Lc0NHTgOiovIN2Ug+aeb3jOzpKGAvRS7yIFdW
 Z9r7SVebrcORuCrRg0ChlGuCUke8Jr+gI0ZVrGxDfVZ3pF/yb9Uiy8qtaREmHt1U18g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QopeHwWa; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QopeHwWa
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3604640A51
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:11 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-823e4047037so993290a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792794790; x=1793399590;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n2b4YGCTqfWw0gfmmg8+MCHBaNrdVtW2J8L4m0ulfZE=;
 b=QopeHwWasbJdAcYrwNWjS5zordx3h2Qk+wZcbq8N67xTCiDOsslpB2W9dVrubtOeO3
 9e2OrMN7PCkBU7vuRdfa3aNxzDHKG+DVIhobYDuYscrHsqV7MB5Ggb0c2jSWc90fCE7A
 lZ0Ku38bkonkD5ThgjA698mRB7GE4IySKPSJGPHCsUayZD7N89vB1+02/SCwgSG0DTCc
 DAg4enz2DJTlIrFuH3Xe+BtZBOzuKljBiak/Zv84FMGqTe+Mzx72i0UtN6dqXCnbE2TG
 lBlhx9opWrLJYKyjLNL2OdJfLMrLcJpa1Rt9ljyECwPIJ6bjzTnHc/GoOMXday9NJnEd
 995w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792794790; x=1793399590;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n2b4YGCTqfWw0gfmmg8+MCHBaNrdVtW2J8L4m0ulfZE=;
 b=gc+jaT0nVmyiM+R8ZKm2n1+CzH5UVGbcvu6BhJ7ZNGNMskx8XJFXaW2CBjByAdAVtQ
 FwOBPxPf74SYXMZQvIYOmX/1mn3ztHmkKewA2m12ieuOLt9l8mxkV7iOPdp0gjlQ/H09
 MEWBnNKWfQEzWeXrkCSngN9lyVI9loh+SyefkqkR1mvmekVVCviqxYRa6cbCsXKAWM62
 I8YEZ1Jr8UhpdZ8V1oLBP3NKCtWyJIfSVwrrHeSW5V6emvLxRU1Ejhh8eQulNQ+RFqdn
 4Hi+iGgOn8DC5cK4vTX6faMHOnlSY7TKYluklimHwKQn30nsS6XC8XNhv233O3JYX5HU
 XSxg==
X-Gm-Message-State: AFq9FYKdNDaF0Y0Hu05azPvWzAG4ZTvCBMoCSU2LVjYNpx3s/eXUnvzF
 AMJiAKu5/7mcXRCy0xK6/T1z2CJCXPfb51FglhfV50s9zPDp2mLd4OMsqXfDcYV4MLQ=
X-Gm-Gg: AYBFou2q3yl/w+8GlUrWAqS0bdZPAYxP3KCYCVAbPb7AbcKWO1XQcepdw2qij+55FMk
 ZlXp66SL0VkduK4AvzoFwPeiSOujBak8nXJME1QY8b7ZwNaED9QgY21YOkF09vRQHFIFNh5LxZM
 hEpfQFfkdgPlOV9wMlk5TZ3H0OuIhN8Z/+h08JYTJlSYIA2LHAQD+5QrkxauuJbqTRZ423ljs/b
 sUiy6zUTYJ0V8QfVZ57g7C3Rje7qVEyt3zjbdok9mJZg7K1GJYD0vAK+gUyKVATnxyKnPNTDgn0
 1NeQ2rGKp8/ikhNVa0kY2OKlYt0IQ5FvzEl821taazy2qz/XbE6OuMRaDVb8DYvWvWpM/oMalFM
 If0Z/SKMh9IOFY3QfJocm8FieRKIOssBWDHd0ucmDkhulbR+Y0++teBM7LsZEa9XW/n6AGbVfEG
 LnOS7aHWikIWDqFha/oL2HhySFcofGWOba59mi12gj+MoqHPUy1UQcN28ZDrKKwUlMP8PZOpS2d
 DRoV848o9TZh+3eoXY2/iac+QCs3Ddwk8o1ARerZ9nBuxFoKeEpaSscA2GF818YvK1EvrS4jV+g
 /jG0pw==
X-Received: by 2002:a05:6830:b12:b0:822:27d6:c2ae with SMTP id
 46e09a7af769-850fb078201mr728743a34.3.1792794790580; 
 Fri, 23 Oct 2026 15:33:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb0741c9sm696300a34.10.2026.10.23.15.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 15:33:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from the
 bloblist
Date: Fri, 23 Oct 2026 17:32:42 -0500
Message-Id: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Nj3dySbCC2MLSw1C1JS9RNSynRtTQxsjA2NjRPNks2UAJqLChKTcu
 sABsaHQvhF5cmZaUml4BMUqqtBQDs2UjvdgAAAA==
X-Change-ID: 20261013-mtk-mt8189-tfa-fdt-94283317c6c0
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=295K2gadr17Vg6gRghMTUXk4BbR4GQEuYIRm4FMd7Zw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2+CPjfT3mGOVFfLQ9h3s1KthSwyOdDGj9rh6a
 KxLMcyUUZaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatvgjxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGnkH/iCHVX3s80qIQ9p467vUZbVbDN09KadvfBhbFvW
 KcvfItWnbZ+xtREziZGVL3YzhL9v2KtmVFQ+n/KhNADuAB6Y7g5yAgaKPysCaGJOaXHMJOga0Ib
 I6Yg+jaq/OP6g7Iz2V/DqI2RqeX9Lce6Nka6rLwx/9bYil8RA6OT2amOqcDNbzfV0CxC8DkSYAW
 +rKQqjQTNWVGmgKHF1R1z/vZNRDZYG7eqPV69n2mFaPPFtc+3t8KrNzGdfxG5jX5TzzvumvkybZ
 ulM55EdO9VvzXgmcmrRniMk+osfxXOkrtoUL3pLlzfR4K6G6sTZljZo15CqtXnakzoQG7/uWoI0
 OxPs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
reserved for the DRAM controller depend on the DRAM fitted to the board.
The devicetree built into U-Boot can't describe them, but the boot stage
which initializes the DRAM has this information.

That boot stage can describe them with a devicetree overlay in a
Firmware Handoff transfer list: a memory node with the DRAM size and a
no-map reserved-memory node for each reserved region. U-Boot already
applies such overlays, but only when the transfer list also contains
the devicetree of U-Boot itself.

The first patch makes U-Boot apply the overlays to the devicetree it
found by other means as well, so that the earlier boot stage only has to
pass the DRAM information. The second patch enables bloblist support for
MT8189.

The first patch only changes behavior when a transfer list contains
overlays but no devicetree. As far as I can tell, no board does that
today.

Tested with TF-A BL2 passing the overlay on a Genio 720 EVK (8 GiB).
U-Boot reports the DRAM size from the overlay and its devicetree
contains the reserved regions. Without a transfer list, U-Boot uses its
devicetree as before.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      fdtdec: apply bloblist DT overlays to the built-in devicetree
      configs: mt8189: enable bloblist support

 configs/mt8189.config              |  1 +
 doc/develop/devicetree/control.rst |  5 ++++-
 lib/fdtdec.c                       | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)
---
base-commit: 283ed6f2477b02a74f1e39c1225bafa8332f8109
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git mediatek-staging
change-id: 20261013-mtk-mt8189-tfa-fdt-94283317c6c0

Best regards,
--  
David Lechner <dlechner@baylibre.com>

