Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB858606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LFoyJOVQ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pej13wS6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 973D960879;
	Tue,  3 Nov 2026 13:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7flB0jxoPKna; Tue,  3 Nov 2026 13:05:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9F2960822
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711126;
	b=pW/+yUZFbz7+Vzz3/FJUvbbWfOGTXiAajdxhTX7JJEgv0KZAujW3dsoUF8RnMzuH0UjE
	 lvYk4hjJ/XeoW29X/QGl7tGCQnSyVKhr1XGjbVrvpBcXQTnsrLyqkX1VSq56ufkxOejxk
	 enUHOPnNZhsyABEhPcy2N2Zs9k7reOz/fkOsezlz9NWqkcfZZM/VfFIJiRQdBzLw8LfzL
	 OqQnCYbnci8rj9xw1qPTwes2zkWpn3r9AIgeK94slHxX93voxQ5PUcnunzAuF5Ye+92hO
	 ghge5I+h2NeK1L/2YFVGi+bEH/hCzvUmE1jkaJ0CndCQs1G9jmlyEjos5sPOgZW4B7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wbT/z7rG2qQdZXW6gZA4uIP5/NpFFK9HAS1KlOdDfvU=;
	b=oaEL6UEVIN1sazhdp0SIcs9Qrm3XiCA/JRNtvcFMgV/O9dbJBk/O7/yvl6EZ7ixMZVPI
	 9L+McO4HsMefnQYE72Cxg+JZRrWjwTF67mumH0tfVzQ4/mai2xp4TidDEZqMVGeb1xckC
	 sfrXfqNBZb/msGt4auMQB/NIQ7lePfiC70pdpY3knuqQaYBlcVDsPFMwWofnPKv0VEHqh
	 pNx8zWSbg+GBQGp+TV3Wd8wBVtBw509I/4lhCg7RmnNTaVVCyu0GhYid7cmEg+3nicHer
	 LyZC7FBZdYEl1R8EZUcCobDlSveKj06n3Jg+y0GyCrg7JtQUWspNJaeOJB0sZDdqGVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711126;
	bh=wbT/z7rG2qQdZXW6gZA4uIP5/NpFFK9HAS1KlOdDfvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LFoyJOVQG+HwxKs0vGrmE2bBHpVJMLl7w0tGIcFDqB1+006ohc97JG8ZPv3ttEsTf
	 qORmnzEwDkOFcmvptiXhXjobde/dteyZ7pyfuv/bLsxvdQ3DL8zEoH+mSM/IavK8EL
	 XFfNhhATiduiUZoMvH/oF9eM/YzblTg66j/d5INFR+s+YxmVgr2SYGHIn/uE6sWGGT
	 ODwyphDdFuQnCvfFeMz2WYIL4QCwRBdCWxK4YZdj3JeQvNBbkqGq5afwtJkmiOCCoT
	 A7r31MxlESr1Xn1HFTavz/kapQwFHj+WYbHe96CfI6MtLmDOCoKTRerypEA9Yw0iHo
	 sh8sAXI6sbx4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9F2960822;
	Tue,  3 Nov 2026 13:05:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67031D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4BA7B405C9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ChdauY-SrUOq for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41950405A7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699933;
 b=YGShr7VoenLek/iK98mzKDBfRIaDBCILuZc/JiWlfb/otZ051Ioy2Msl6lHlcH6Io8NU
 c4KTUrrcjiNrZfdS4gSURA06O7LCr8IT9Y6SejX6WBIrP4C1bOE8IKHff01i+iqmiVwdS
 u4tmDKUHs8qAjNSwUE3ulQaHW7FlgWbxA9Mf9FxAxgn9MUBWkOVAneBc5Xb80jJJikvk7
 9KxTaeEbgv/EF5AUlGx3abtRsKu+AeaklwQ9hOGL+7qWnwYU3IP7QLTbWd6K8SDa4Taq8
 UKWqIf4mOcuZNZBtBqMlH/MrjNaQwNmCbTGZxDbWp9ogJHVHVS0Qo5Aqu2LbWr03kGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699933;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=wbT/z7rG2qQdZXW6gZA4uIP5/NpFFK9HAS1KlOdDfvU=;
 b=PueiJY/9ckvxnU0mtNliwkkbFIMXEsCgT+rMHhRKg11LVd1h6NMFVw1WKy1Rv4A3L65B
 JQGK2jdKUhgbNvAb4dCgwMUInMo+2uffJWGmtYjAXdTKS0qlzi6ffUh+tzdCK/C8asnCa
 fGURGjbW0bFRGQgw8vsPg+Sgll/5of7wdBgZlwQ3fFh88RkzWrhzvRB+5RhjtVL9+4NOX
 L/toGDrpqVX64+qr8qVIWuCWgDcKtfXir842BnOtsGIgL/pHXO834m3raKUoyNPUViO8j
 pWo1UrJFLIzWAvqp+pa/aD6DdvLRpgD2Uz3S0k7x8h/EgJyVcr3nbxWbnnWwvJ+LwEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pej13wS6; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pej13wS6
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41950405A7
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:52 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1941196f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699931; x=1794304731;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wbT/z7rG2qQdZXW6gZA4uIP5/NpFFK9HAS1KlOdDfvU=;
 b=pej13wS6yS/hgxVarX/GI8kLLZ+rCNaJI+xjP31MONK9DdntfTs6RuVNdweRz13tX+
 qbivbI7U3qkklXhA2Zf59RNq1bTa4r9chjNQvAf/kmp/pZcC9dodB+kFKc0z8U+K2ndc
 UMKX2zbr+D9rI1rJViZ2OuM6No+PDKvJV30B0VW/yCdnZm3BBrIUwIZMBy1JETC3+5wq
 kXAb88uRBpKv3tpVFRdzxX9FyXjCI48aJ4mbHPQCQR2jY2L1NkwaJIYwAVtQ85Y+QnRw
 lvSrzOZG8AKnhQ7TNfdveJ6a2MrZHIBYVHVk7hZkZ1lN4lI9+54PFr5erIHcgnDL5yb5
 U9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699931; x=1794304731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wbT/z7rG2qQdZXW6gZA4uIP5/NpFFK9HAS1KlOdDfvU=;
 b=E3y4yCJO/b/GXwhpkwGacI2xZkAuewxeuVOA0vQqQE1UclkA4tAQGhzE/aGpNnDTJx
 +RoY9dgPlqzkCrvm8eRHtPgrHnXT9q3wYgFKiLVLOkX6wy4piTC02kctKOZouI6rzmMV
 cWhd9csHWAdz/Q2YfJ3h0uYnFbMGo5fkMvjZ1VLTZHg8t4subFXjes4tP9yFTN6KXbIA
 aI2NUa9ptPlf5UwZnmdsw6PhWBbsTnlp51UdksUVsPbS86+dFinCuuYg9Gj6MHoH3Dzk
 ql3Z4KyYo/wmNVE3MsCkI/5K64andRuKZa/4O2Y/jdeb9FjySc8RD9Yy07IUicDmng8T
 mWIA==
X-Forwarded-Encrypted: i=1;
 AKwUvByDnjLfxKzonGbw4AjbO6oBRcJ+KGiF8KR1oeO66qX4+rMUFvUjFR0jPG9gDykB5iJDUO/8uAo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z83yyKcyOv8kHJ8dUapiQ+JpQ1PUWmf/BEDk/gFWhtyNf7tEhAJ
 NxDmlioZBSt6C5OwL1OGI5WNC7aycQXRqvrmdIsnO+xKi28Y71582D6IcK9Hz/gE09c=
X-Gm-Gg: AYBFou1+SWnIMnOFelfAgtsGl55rnpxwZEQv0tEsfqIXN6h4LmgMEkdA5sMukPmOimT
 JIkBlVAYI3zl2WiXyC5HtgOgVvOV9UJ22fTCP6h04+x/yrqyqS0DfeN80cLbEjhg3ibcWsBJqm0
 KZo0veiFb9RV1fweXM2iy+8dAs5/uxa6f1Sn6s4AHsYAU4eBavk1qToRoQO+ZKdpfroj6iCyMGZ
 iuGK7o2xpn7/bZe6e7vWikI7H9NKPOUmCu2omo/kxzOv7Okzczs4q0MbarVw4ghqt29WfrwcmL2
 kX00GZRNLujtKHgU+MbhzsD5OHenwsY+Pj5AGYeXlsPsMQ0KiWnfZikgAE4EkgtkQwdTsQSGejS
 3MjCBHkxdg+xeVyEHxbBED7VaQWSVj/aVUvQZpuiO5blP33er0r0DTbVgTbZBi5+4H5szFZq0vE
 Z16oVGG71vdCAzkCyq0IVk5Ixb+wzZZsxLlYhPGP85uoZ8MZ+gWmSviVuQaxSndtQnTSOkhRPf8
 esRJVkZCK1396qjxoWnZhvvl1lJYAUt6bIzi44DausVtZk9HzYk9Rxmq0E/+BkXq76ZxvW4LgZg
 wSdqVAbdAarcSUQJpNrMTTcDdg==
X-Received: by 2002:a05:6000:2009:b0:48f:bb68:4e61 with SMTP id
 ffacd0b85a97d-48fbb685039mr1502456f8f.9.1793699930849; 
 Tue, 03 Nov 2026 01:58:50 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm25832416f8f.55.2026.11.03.01.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:50 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:01 +0100
Subject: [PATCH v10 15/24] arm: mach-k3: am62xx-lpm-common: Add
 lpm_resume_from_ddr
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-15-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4337; i=msp@baylibre.com;
 h=from:subject:message-id; bh=m2qN5sszPPe3Q9y//x9KeD4GkKJNW/z6F5CXqeBdYOU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXGwSL47Zuyj9fsHej9oL5a8NjJL/PL1mjHXPmEtMbc
 QfT6qSijlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZiIXzQjQ09aZmtyd8uD9sPT
 M0RM/re2L1dYbLlP/2Ri/SRnsW2fDRgZbvYdUWdV173+RNj+tI+JQOq7g89nHvqy6MmmW+e/3a/
 i4wAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
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

This is a common function that helps to resume from DDR. There are two
pointers which are fetched from DDR to resume, the TIFS context pointer
which points to the context in DDR. There is another pointer to the DM
loadaddr to jump back into DM.

During IO-only + DDR LPM resume the bootloader cannot read DDR yet, as
DDR holds protected sections such as TF-A and OP-TEE until TIFS restores
the secure context. Pass the physical address of the
tifs_context_save_address field inside the LPM meta data to
min_context_restore() instead of the value stored there, so that TIFS
reads the context address from DDR itself. The meta data structure is
only dereferenced after the context restore has succeeded. This matches
the TI-SCI ABI, which documents ctx_lo/ctx_hi as a physical pointer to
the address to use for context restore.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62xx-lpm-common.c | 68 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
 2 files changed, 69 insertions(+)

diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
index 54d86b0474df..009d05db4357 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.c
+++ b/arch/arm/mach-k3/am62xx-lpm-common.c
@@ -9,9 +9,13 @@
 #include <config.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/stddef.h>
+#include <vsprintf.h>
 #include <wait_bit.h>
 
 #include "am62xx-lpm-common.h"
+#include "common.h"
 
 /*
  * Shared WKUP_CTRL_MMR0 definitions used to remove IO isolation
@@ -121,3 +125,67 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
 		return wkup_ctrl_remove_can_io_isolation();
 	return 0;
 }
+
+#if IS_ENABLED(CONFIG_K3_IODDR)
+/*
+ * Restore TIFS context for LPM resume.
+ * @ctx_addr: DDR address pointing to the location containing the actual
+ *            TIFS context address. TIFS will read from this DDR location
+ *            to get the context address, so DDR must be accessible.
+ */
+static int lpm_restore_context(u64 ctx_addr)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	int ret;
+
+	ret = ti_sci->ops.lpm_ops.min_context_restore(ti_sci, ctx_addr);
+	if (ret)
+		printf("Failed to restore context from DDR %d\n", ret);
+
+	return ret;
+}
+
+struct lpm_meta_data {
+	u64 dm_jump_address;
+	u64 tifs_context_save_address;
+	u64 reserved[30];
+} __packed;
+
+void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
+{
+	struct lpm_meta_data lpm_data;
+	typedef void __noreturn (*image_entry_noargs_t)(void);
+	image_entry_noargs_t image_entry;
+	u64 tifs_ctx_addr_ptr = meta_data_addr +
+				offsetof(struct lpm_meta_data, tifs_context_save_address);
+	int ret;
+
+	/*
+	 * DDR not accessible yet - cannot dereference meta_data_addr.
+	 * Pass DDR pointer to TIFS for context restore using pointer arithmetic.
+	 */
+	ret = lpm_restore_context(tifs_ctx_addr_ptr);
+	if (ret)
+		panic("Failed to restore context via DDR pointer 0x%x%08x\n",
+		      (u32)(tifs_ctx_addr_ptr >> 32),
+		      (u32)tifs_ctx_addr_ptr);
+
+	/* Now it's safe to read from DDR after context restore */
+	lpm_data = *(struct lpm_meta_data *)(uintptr_t)meta_data_addr;
+
+	image_entry = (image_entry_noargs_t)(uintptr_t)lpm_data.dm_jump_address;
+	printf("Resuming from DDR, jumping to stored DM loadaddr 0x%x%08x, TIFS context restored from 0x%x%08x\n",
+	       (u32)(lpm_data.dm_jump_address >> 32),
+	       (u32)lpm_data.dm_jump_address,
+	       (u32)(lpm_data.tifs_context_save_address >> 32),
+	       (u32)lpm_data.tifs_context_save_address);
+
+	image_entry();
+}
+#else
+
+void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
+{
+	panic("No IO+DDR support");
+}
+#endif
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
index 2d110bcca0fc..d5793759da4a 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.h
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -13,5 +13,6 @@
 
 bool wkup_ctrl_is_lpm_exit(void);
 int wkup_ctrl_remove_can_io_isolation_if_set(void);
+void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.55.0

