Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A6606A335
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uHeRv70C;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=VUHFz0lJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8690860807;
	Sat,  7 Nov 2026 14:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQFNJGBy1dhV; Sat,  7 Nov 2026 14:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC6A7608D8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062026;
	b=I+QO4eQk2aWvgyRq6lM/pGZwUq1MMKgs7er9sWRnwnc8MaANfkRuJKCWPSqpfbHFOyd0
	 Y5iffJw1qbxD/sHnm1s87z1Wg4p6uJh/wcwjMkOfxzFp3AVCxdC6RspHjXMnSyFjFJwO1
	 FDEuRsPlEr5wfRGUrHldJmnjSZ8v7vDL255bR2XomQPmnSA0NPEllyXDgtjViGe1Ag1wZ
	 /27FoHBvoueXCQ2C9DnpeP9l0DIIk/8T6a7xAUjGDUEWURy/TQgTrbP2pwZ73MiTZP+SE
	 2m3fmZKBaaheT9ekGfxLBLWCaqLbC0kl8Sh9nW9KJ28XdRzp8JA1XPqgPIBFahtRR3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KHDQsUhXuSBpHIDG8NT4Bfpm10YsrSG2MsoErTJuXoI=;
	b=gi5o+P26f1CtrWDVYya+qMeKRuLQX/W5FBQzbZiXtedJQ4wgrnT47GfyXCuOzChhenJU
	 eromQXLAYPXLjDWZUQ5k0qRa9d6GhErenSX+jeUlS7F6KTUfYEkyv+42+QMJvncCAzJRp
	 Ri/GLyjPsH9pu8x3052rSAIN2Hd7/4OX/4yuDufePP5aSOiw2NCJvgQ/7SJ+NZP0K8tKh
	 Cc2LRiZuIb8CDNQXksg6qjrRqhFxKMSw3MsAeKDb4vR6D69883mo8q/2QrIi5kee9L7z8
	 CDRQxS2yrYuMsIMIbps+5Hqp++yk2nZnH4vDklXPkRUHmNebyhqNs0qozBBvtpnr3XQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062026;
	bh=KHDQsUhXuSBpHIDG8NT4Bfpm10YsrSG2MsoErTJuXoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uHeRv70C1pqHKU95EtWCf6Gb/+qIRWVMbs2U4wHN6kb6yfpCyqZlu6kigNXg9AP6L
	 f8/MCO1g31vL77MzyPsc1m4FD/y0QTUrF9WbROenWEz4WLUsmUwPi2HI9RisrZOohX
	 K0q3EzWQEtRdc1mc3gGhIr6+AGt6rXdOTv0d1PCTOIbUROksV8TD2SMgQrJb1vEcYl
	 FhIuSnbwemiY/AYUw0b2qpqH7jCm6aub8BNPYWtTlEzROe4yy6oGQ0OooHgp77JCty
	 Arjkkwyr/2xxpdgfs5+EFWljSprsSI+On08n0t/0YleQg2bJvR3dkrgLl/gbTkMjWB
	 F69aAgvyv/I+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC6A7608D8;
	Sat,  7 Nov 2026 14:33:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B46537D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 183D2815B2
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TY8-EFm1UIrT for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1FCF1814BF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=VUHFz0lJ
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FCF1814BF
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:27 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso14547145e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062006; x=1794666806;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KHDQsUhXuSBpHIDG8NT4Bfpm10YsrSG2MsoErTJuXoI=;
 b=VUHFz0lJhl/11MRj/Qhe0aXdlo811vx792xcV97nHpsbTuXfJjxnefdoOtabYgarU0
 4xdv3QHKK1qMgrZamcYtcDNxh7q0+L/uXutaEmGPLhbznDqEspErY48i1Hxg4gXeZdEM
 ETu07MpgXSnw7CLJilhvFQGq90123S5z2kaGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062006; x=1794666806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KHDQsUhXuSBpHIDG8NT4Bfpm10YsrSG2MsoErTJuXoI=;
 b=Zz5oh3RWcPDOKlVL3Wc5KDTnYZaSBkpadlmjQdzsDo9FbFlaoKl2UHU11UeKiApGbZ
 5PxI/YC+1jBdQIeE8kEn1qwgSMQF8TDfZJfl2KA+yOqTX97Z9jPMbo+j3HfDN5lTefb2
 WDMGMZpIINDo8TVHAlujjQm3VtaZTGRDqgVBcSyVx+jXVBbDZSy+dTLNusHbvkZxnZrC
 OgyLxaFNe/xpeNUNm4e2ybUOWXfViSQZxvQkT/1v+hB9PJ6ail3oII3+zaWdPoqrDKcw
 l6AUgkkoOAxTe/PWJdyQ6diDZ0tOsdpGVWKWKCMijeW52I+Fh9hfkq4eXaBpxdUTU18G
 sK4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5bmnk/sPWvhESLjYbg1KgAFWRzS2n6Gvak5vWmSoHizTKmeo3XEi1LYSr3WO8dZD5IOr+O6g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/+s1WMef8EJVmpEKQ33+n8hUdLJAx/MFlEAknrVfton47hD68B
 i1PAoV4vyW2pypo12A9Y9zWHzGEmUZ+U9wyyzQXixaMMXWWT46gaDuWycHgUteBjgA4=
X-Gm-Gg: AYBFou0CXhGXV5N2AizG3dr5EhiCRQUUVcU73z8mDnWlE60VqyRW+yi5AaIIigQm6YF
 VbrhIm68NNzxF7XrKEg+Apm4KjW9iei4AnReS/4/r8CS78JeaJqD7KUey3mPbXkFOjAtMUp+UQg
 4kUquRQ4SXOck1HT/XBiUgaUNa4wlQ8cFcDwUblZSECQ2OKZj/jbU/jQGdq2Wg3yg6f6QuyAjCq
 I7HB4wcjK97Kp2p3nkoCWtoYtv+1n5ifnF6yvrsWpCQ+IIPu/B9hYIAskZllfpcyavoVwhjX6eL
 6sOF6CzSAgx+TVENwXB0+x+O3rLnyKo+zMWiTukr9ZRVY/IW1dlJK4lWlkFxW983aIDI5rFzwZ2
 //ZzCkb3pET77xiVGVhyhe0LHGMOQv/zFSptMivvPGOX9oZmfu2JRRUkaGVPZkt0w3/UU00K+3E
 VtVHG3ZWJoPRL11Pd+QJkBMKox68oVzmBsnxHqq5F3G0GgQ1LMD9PpBdu+3zWVVkwNlyzx8a4Cm
 wug5u1Zr2Cl/AunPES8Ciw9OI/hN+oiNJmpiLiBMgnnu/hFTCmYfMa4vdyLGPXTQ9RMrC6QbL+g
 /lzSAnKW5APo3Ff2Et+RZzg8gwMdpMFWCrCPouXkRYHH3FYa/rcrLtHMeB8uFzvUZM3pO8/8TCM
 yjHuKWDxFez1CLETHAyDVvZxpfVQlrzql9wmPj0Dx07pR8rVYzp2mHolbcnZB5Dz84EbdtEE03p
 oT2Ro8+BWoHcPHlHo+Vboq2XMG5g==
X-Received: by 2002:a05:600c:19d3:b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4b6de788973mr100363515e9.7.1794062005821; 
 Sat, 07 Nov 2026 06:33:25 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:25 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 20/35] clk: stm32: fix set_rate propagation for parent
 clocks
Date: Sat,  7 Nov 2026 15:32:10 +0100
Message-ID: <20261107143241.2236511-21-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Use the generic clk framework set_rate path in the STM32 RCC wrapper
so CLK_SET_RATE_PARENT can propagate rate changes to parent clocks
when the leaf clock does not implement set_rate directly.

This is the case of the STM32MP25 LTDC kernel clock, whose rate can't
be set otherwise:

  stm32_display display-controller@48010000: fail to set pixel clock 27000000 hz, ret=-38

Fixes: 901e0d95df3b ("clk: stm32: fix clock counter")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Take the original patch from the ST downstream tree, keeping
  Gabriel's authorship

 drivers/clk/stm32/clk-stm32-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index cd6bdee5412f..29d2f64e0c76 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -168,17 +168,16 @@ static ulong stm32_clk_get_rate(struct clk *clk)
 
 static ulong stm32_clk_set_rate(struct clk *clk, unsigned long clk_rate)
 {
-	const struct clk_ops *ops;
 	struct clk *c = NULL;
 
 	if (!clk->id || clk_get_by_id(clk->id, &c))
 		return -ENOENT;
 
-	ops = clk_dev_ops(c->dev);
-	if (!ops->set_rate)
-		return -ENOSYS;
-
-	return ops->set_rate(c, clk_rate);
+	/*
+	 * Let the clk framework handle CLK_SET_RATE_PARENT propagation for
+	 * gate clocks that do not implement set_rate directly.
+	 */
+	return clk_set_rate(c, clk_rate);
 }
 
 const struct clk_ops stm32_clk_ops = {
-- 
2.43.0

