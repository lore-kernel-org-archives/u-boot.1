Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A9606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WfEnTVMR;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ji7bJ6Kr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 713FD80DA4;
	Wed, 25 Nov 2026 11:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypekqnJ4joqT; Wed, 25 Nov 2026 11:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FDDD80CAF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606264;
	b=RFAn5/bkGt9F0cza9EGlcUtacaVACc4Mc74xpQnplp5ZWRT1rajP6IBi6L6IiAQ2pLLG
	 tLiWXYod/6O0n32xNE8E3Z/tXv2Fgv/GaxxOxYn7RiaehCbi9f0e6dZlEMj+2m+m9yBng
	 UUwY0wEtwQWrI7mHEHhlZjt1+IabO+6qyR1Xsod7n2nI9vfCvwtYlH4mr3sRqxtksmsXK
	 dMR3cPk2juenBfuPo2cd/4xA/cwY+nT0794cHcBjV/IJhoImCi0Ninx6eXpcmTUiaucAj
	 0PmftNEKwYSyMvlrF2ffLV5u2S6ljQ9m3msD+LVI2AbDJQdsG8rLVvXfLXBwKDYIxAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GDJMmdx1gyE85HfgP4A1Z92frP74NIYO9D0JxLiK6OQ=;
	b=f4xvu21zg3d4ercT/341rDk8ifSDZWTwGvjwScaF+/W9sKlb3xCQPQD3l+b0KswpHsb0
	 rJ/ky9ytN1NBJegCRVzxY5ssJLLEzk8VYeV4YXBbmXDdeWNwGR9gfxDKAwiwW4TnfmJc3
	 6AAFqb41pReE48v5OMIK2zRVs5BSnsS6dFGTcjhky26GBft+j7LVURYbMTEBRYpOBl+qM
	 v+SuD6QJ1v04x60UeD7o06j+3SxbzYpEDsUsCQx6KTHUuJvNih1s1MmYZfJeO85OvHHAP
	 H0EFCc9lk84wR32pQFE+Fqyzf1cq8W0Dxk3cPMvNh/0ue+RD6R+kPXo9qGGfTiMG7zA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ji7bJ6Kr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795606264;
	bh=GDJMmdx1gyE85HfgP4A1Z92frP74NIYO9D0JxLiK6OQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WfEnTVMR2cEwe9VO5ZrpzSn0DvF/bd1K/bK9yNxd8VHuTiUqX0m0R75PVjDRlewyN
	 nyMI8VWATXQOaMePBYsXxnKGOQ2YX3tPzVfQdrs6XDhE3sKXlDWARRVLrzGWcFmRYC
	 XL/RC9Acu2BeA+Be+PDdiBgv1oURBa9mVP6TcT2kLwjxKOuoN5zcilIi+/TUgkuomo
	 lGblZIzt/P5Efc+xzIhv94aK5fKuO6tfXetLABaApGu8HwBYT7ooCTZDOhvT/In/cg
	 c585rKCCUWhAW9A6aoMESZo0r9Exy2gQqX2GDN/ZlNUp4bmcJiMGHJmXpKyleFsLLq
	 ct9tt41H3v+yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FDDD80CAF;
	Wed, 25 Nov 2026 11:31:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46C6432D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CC0180CA8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CkDqsTjeLHY9 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51C94807F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ji7bJ6Kr
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51C94807F8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:54 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so28018715e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795606253; x=1796211053;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GDJMmdx1gyE85HfgP4A1Z92frP74NIYO9D0JxLiK6OQ=;
 b=Ji7bJ6KryH0B/v2Qr1ZoteiiiD+DPJ6LJIXD2NpjneJdpDhB3tmVIaZ1uCQFZRyHhY
 fX59/LQjonubxvGM9UDxuqR/vPa0vK86LyTV1kkO8EBYMsp5H7q22SAp98tjtUI183Si
 rFeVdAMcZ1nPON4HOvECcfRZ+pmo5UKIu1zs5fQp/WIDx3TP7j+uDZaEvE10D0CNIuij
 odJHt4Xc1sqC2tXjqHVTIwXoOud2PnI56PkxJR7UmoBABQPM/0NtVv6SsyrpU6B7axBN
 YxvwzHohcP9ehYrLTpxCm24W7IpTq9GZZlgPoBkKrGa+WlQ59qfasQBznlO7TvLlDCna
 72qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606253; x=1796211053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GDJMmdx1gyE85HfgP4A1Z92frP74NIYO9D0JxLiK6OQ=;
 b=aQaAHmjuvx3tGjV1wLMSv2onhZI9CWZ6stXWrHDou5iQgUxV3BdC+oZsx5FivV4IlS
 Yy7RUHYjsTHg06ocbEpOoPyoxbKdb1nHvTc6f6W07yoq3rhjBmaWTUgl9jVoLvXEF5bh
 0emyer7agLebX1mrQ6lh6wDL/+kXmkgUkfDmDw+MGjMKWCbcMfTyEhrTcow2YiN19AMF
 5onNUfn6aCSFb6R9lh8R/Qa+8UZmWU01lpyiVxYNFuMZKVaipHBuIF/OxZgV70GpyQRz
 FiUvwTA2VgKTGWydZvaY67tC/wWrHnxtwu0+8KBCFkzOoIhTTsEOMuL2nr2WvgudkA51
 C+Ew==
X-Gm-Message-State: APuU4Z+D/bmOufvbZIsd1PKC5QYO4oeB3EnpUKp1iVRKmSoNpndwNvGl
 pB4dIDAirBIBon83543UcFwO8S1Kg3LqxcjmWxAw37+uvrdtUVIC7M6vgqCCVVQUDUr8RVPb3St
 V1w6H
X-Gm-Gg: AZFdTZcsHUOO7L52mmC/H6uDvLGeNz3fSWfG2kZ8Zl24BKGfBu7USKcJp36N82D+fcl
 6ns07E8/gpUrIjaL0g/ZC0CtsiYhW0cAhBMcPs8DnIUrzhJj+ZpjhxIV/8KL+htNcelJk1GHoO5
 ZlIsESMUxNW/ggzhMfkUkExCACIGJuOQJYzzNMdxcmyMBH4+jYC31QdUT8t4alJ5QwvI8WmbSCT
 rC/c38d9t1nZ75iKo1ADL4DwnCwSgHHjDNaOxGlWyDyI5L3imelKDkzOHdzmYBq3vIqCElVWuV0
 uZi5qW6QZWCcPiraVbbkHrntJvEgWiasIfAR8n+JF3tpXkoGtVoUGfblAoR6AR3HP2jzB3ZJIcC
 rcRd/nlP0uDVsinTZuU/S5QkAV5Zj9BdVx7PuuOx4vFcP6l92ukwOSjjMwS6rceewyVhTqfR+6k
 ZRn6yXGw7w0BxRl6wbfncLj+G4oask2MMt7pJvxompMPgbreXtcUnLTqYWIQ0F90uNWRfhjxwNN
 wZPUMNQO6V1+3yWBOdGT5GZE6pbmuOL4Mitrw0JpnYGRMPmrAkoxe0o1rtL7SStW7lP3RZMyjd4
 lhvtWh9rKmsX+5+GnduW8Ks3lMrULh4xMit4Z6VaP0RVemzI89ys6GqPwQ0N4kQquu8iypvwYWy
 UBZjtcajzhz0D1hU+
X-Received: by 2002:a05:600c:820c:b0:4bb:6f6a:1976 with SMTP id
 5b1f17b1804b1-4bb887c2923mr324153525e9.2.1795606252978; 
 Wed, 25 Nov 2026 03:30:52 -0800 (PST)
Received: from [127.0.1.1]
 (2a02-842a-aa82-f701-cd04-e538-7ddd-cfa8.rev.sfr.net.
 [2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm39870905f8f.21.2026.11.25.03.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:30:52 -0800 (PST)
From: "Julien Panis (TI)" <jpanis@baylibre.com>
Date: Wed, 25 Nov 2026 12:30:32 +0100
Subject: [PATCH v3 5/7] board: ti: am43xx: Use aliases for USB controllers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-5-7f5c72c1116b@baylibre.com>
References: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
In-Reply-To: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 "Julien Panis (TI)" <jpanis@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Andrew F. Davis" <afd@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Nikita Kiryanov <nikita@compulab.co.il>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795606245; l=926;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=D4/JywcYQ79C37p/0NoOAMEbZ3t0W0q+6rgkoVn6qYk=;
 b=hCbdRMRwYyuxpIRhNltFuUGcU7Uclwk0mM9HYoqcbjx8kiHkqZNSThUNKnvgIhChOrNG5HSUG
 XFD9np5a+RSBiVNKhvb3bITGb8i1c3bU6Lrr8szb8PoIpGDUaDyykiT
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

The paths to the USB controllers are currently hard coded. These paths
don't exist in the upstream devicetrees. Use the usb aliases instead
which works now and if OF_UPSTREAM is enabled.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Julien Panis (TI) <jpanis@baylibre.com>
---
 board/ti/am43xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 42e2bef8151f..96d1b5b3b5d7 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -707,9 +707,9 @@ int board_late_init(void)
 #endif
 
 #if CONFIG_IS_ENABLED(DM_USB) && CONFIG_IS_ENABLED(OF_CONTROL)
-	if (device_okay("/ocp/omap_dwc3@48380000"))
+	if (device_okay("usb0"))
 		enable_usb_clocks(0);
-	if (device_okay("/ocp/omap_dwc3@483c0000"))
+	if (device_okay("usb1"))
 		enable_usb_clocks(1);
 #endif
 

-- 
2.43.0

