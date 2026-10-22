Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F21606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=npccP93L;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PX7ZbE+h
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02BE281295;
	Thu, 22 Oct 2026 10:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QC6b8JbTxvym; Thu, 22 Oct 2026 10:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 39DD481287
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792664170;
	b=cZMfp2+z6g8jALqOw1Lvgycl/MQgVlC9/HhNcnB2UZJ7FK3vs07BKymQPeg+1A0aILMS
	 DZbOtSl6Q6orPojRsrPHXQqpATRMQiY4nK5znGNBJIjnOSHyW9d+7JenBR8tzxAY9MMPn
	 EIVl8A9e6hlqki1hAszAYdQ8PfdpzdiFMu1Tr3cx2GU9V4hg+euOaPD70J4kBqnnJu7g3
	 OWQd0pG1ppnklkPkogXnrED/ATpbevRejDx+RHPXpmk3wYehNwFrzz9kMI1nIXAoLU1l/
	 TVM23L62lXRQevQbyQ+1R2fD47GQiJdG3VZy/EFhbbRyZsix5VNPJrShtDKJbxxlUZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792664170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Zx25wAZ6MsIdpAg8yU0f64YLvO5Bdb4jb23KVisUbEs=;
	b=BRKNPHuIQE1wlPWAzN2xOxnr1vudmXIITQN/xkVBMfzzgVkzwsWxdei5kV2J9AMHTXkb
	 UzqzGDyPs43lOrD5xmL3kl6aBrLq91eMrNpbXd3145Jy/dCRzuW9zsIdaB95L2GQRZ9cn
	 vNjH5Q3qby9Gr6CtWci8GUqUNghaYmpLcGBYeNaDuBFRAz8MHOkCfXVvMxPN45DT2csct
	 3CsdNjlaDvh7IV6Huu8dtr5E6cqfwlbQgZs5lBHsr4NqK9vgRCupoR3pZTT2qL4JEJrwG
	 rZhkKzrE4vtLZeRJElV4P8R+xeUyBTkSq8kuPYck06X2TRJ+QxNT/byWH+NP3ETZL+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PX7ZbE+h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792664170;
	bh=Zx25wAZ6MsIdpAg8yU0f64YLvO5Bdb4jb23KVisUbEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=npccP93L3G6J4MGJZnYgrFMv4Iv6wB2V4Uy8zQyxNt63f2KetbKZLKpVGMAWHFSu/
	 8P6iyTxrrCAdRIohBYiInY3QaZk9bRl24mPxuniRm0PRCrhmVHOZq6Ounx/rDgbn+h
	 +6XjSHkNbvmfu30ukTfFIyWbuJ7Es966/zOHhOTB8wvJDzyMWFFJ+XSoXP9gq8T4dZ
	 0Q1Y8u+MSu4guaGVUoj/qvxehiX6qD9T/s6YK4MdNWr6KQT/oe4lWHeJhhySq2XkmD
	 YgRgCDNaqR0z/D1NzRjWlrLc3BYdUriysqygIjIkRyjSsoXaeyIAmZjfhFTihxjl4G
	 Omjldt3AGRNmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39DD481287;
	Thu, 22 Oct 2026 10:16:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F5FC1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2563481248
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ijg73FDTQRq9 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7C1B81226
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792664166;
 b=L1e3oU1zL3DWiRarnqmnPWqFkD4ZOrDrYMrdGhu1cKb0BrWhrmSX5Rx7v8cBTwAJUc3H
 HC/B3M6uczirCEWBCzMh32BeNVU/DtaYFkJp3hwtljPvw5AoHDSPgBuRrhmzdAFat8BvQ
 iirTtGWYd73jBmwz9CYgurEu9B3tshnh6kZPpFvVHQvVHaL+sRg/wpsdUhV+Khb++WU5O
 fDp5Njo54gfQbqQB0qbNkTHFQiGVxALihtvr6c7Z1PvODZ718dz4i2H7+dN0TTKjQgrZh
 z1IQ+x3DUvdnCWjIcRMVyUuD3J37akG1wXnPgHAGTCfyVaqG6b+orV+eLRJE1SkT5Fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792664166;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Zx25wAZ6MsIdpAg8yU0f64YLvO5Bdb4jb23KVisUbEs=;
 b=ZB87nsMfLuV5DkEkE9tENwrgcHJjrBnuzTCqixue/fHzQaQdI683/MWGMJwSIs/cUgjm
 nRr20uZKvF1pNFshcoNUpJotyrBbzYH0HGuxc5LXAzOuquWmcruklz9z9tpWl/m9DsA6t
 NNzxt9w3Uzq6DKAK2jvhRcSWFv2vqFchtDf+hhub3r/hdoY7MtxEQAo93n8KCryJMKFgY
 8CMmhAUk1U+bAZ9wx57s0AGLW2U6CZ0cwBUkkmPh68omhYTGOGB/7yt2E3ALYpQXoSY8g
 1UHJojxKfAnJUnW3U2DpoX3lelhWwV9Ix/pFna79QR5RhTZq8yHFhlhVs6OJ0Xh7GXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PX7ZbE+h; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PX7ZbE+h
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7C1B81226
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:05 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1084101f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792664163; x=1793268963;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zx25wAZ6MsIdpAg8yU0f64YLvO5Bdb4jb23KVisUbEs=;
 b=PX7ZbE+hjgGF4FoxZxxSqhdl3efXbmexGVds02q2t21iXsH8wdo+P6E7x+0LlBteKm
 gq+kXbZTYs63Ojb562hFBC117brn1UknZC9WNX+2GoldLdWhPMEs6AGQZezPDJPvjD17
 Rp/DRMuQIVQH6lVx0r/g2I1Dm2R57/Ra76TcLe+T/s+Qvo5TA2XtpJWVgleH92K7Wceg
 12xFCQvt83kVPfGUDfas3gWdScJsMO32dAfh7FgrrNz4d/jPmXiq2XcVPKUOJK6n2JPu
 Dp+N3qJ2M1Hb3EvbDBKy+Y0m1GFeS0H8asUJA/CaaIrMA6vOuZb1M1zcteBcLqu84hlp
 6M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664163; x=1793268963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zx25wAZ6MsIdpAg8yU0f64YLvO5Bdb4jb23KVisUbEs=;
 b=kKvvI9a2HuvCAn7LDbweC2RHw0kNCLEJBRox7RdRP8J/pLjisQaPT1vBoP7e1zqkU3
 +yeiu2vxK5FhYyCxCVo1rOf6AkzKEPoZg05UETNsYIe1/l0Bc+NWjtmPV80YyKdGRLho
 8tWJFsL4JluX7UZo8zGO5R0x6hD/e9UEIchTpToGHAQpho/NYGJN+VpSGHDzR616dg1C
 jlpTInv3uQ7sl0ho76JyR8/v+ZwEaTfzdR3L1lZ5//D5B9+bNehJjQkr4GpaXr0GJC6X
 Sk9Rc+Ug+HRCZ5gF0RvsRA/i0QNa3K8PE7+YEkXjjF0cipyztxTGP3T82TWHTv1Zf5IB
 PgMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8sMiDOPwzPeE5Rn/Tg3ixFGd9+80ioENNy8H9Y9yxns2Cnbk9muVY0NDZlmsRvP9fDwdGJ3E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK+VFEFbLuGDGUfPCgi9PRZEa5ouy7crqNXJsjHWa/u9jM7Ws9e
 1XDSNrAbh9TU/6srda17iO+d5YYcSfF1p5Vt5+SRuhTgwJsZymyobDEmkgzeIBdHjVE=
X-Gm-Gg: AYBFou2b7TmXpgqwQNwx6D8rivBl9WDVV8sxSLFJYjQ2+diIiJ7HoCp0xE7cnd9Nt9s
 7l83xRK3P4sBAvwV73EQl5f8xGFvc+P9QoYUm3QZjU9ju5ncA2CzEzeIDMMFou0UBN5GOsbZyFP
 97sRQ4oPSfYXmyYJnCYuW9HxgvcUMsebhS9VGopLZT87jBt3tx90qGN7NYI0CIaZtkuOldHtSz+
 Xm5+LDT639ekBdzqm+49xUybMJu0VQuDdWdx0ycYPGUlYXBWn6Wx6HWplL511N3obplmDI11ND1
 D7fymWYBbyCPtQEuoNmbuGz6bVONqSqSoM8yNoq9ra15Vyy8xSku9JrBZ2zQTiuoHyesZFVEe2w
 9oNzrk8L6FXmv2UyH8VVDtDwSnyqSuU/a7rW79+6pGazljO+dr/33W5mf2M65afu8h8QGLp7c6D
 sVLDRvmDOIRmy+tc8xBaX/ztawldnfa5PbE2uhnRu65vYBA7N2LQ5q/PolRE0yJnVBvxglrCBsM
 fd11a6mZbCS1xzTgpn/1KS6eFI8lO/z2RAlPPl+OozjQDyDRxDPVx70GgwaxCxwn1QGgIZ4xbse
 CQ==
X-Received: by 2002:a05:6000:43c5:10b0:48b:174:eab1 with SMTP id
 ffacd0b85a97d-48e264cd791mr7839406f8f.36.1792664163492; 
 Thu, 22 Oct 2026 03:16:03 -0700 (PDT)
Received: from hermes.tailscale.baylibre.com
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583ffa8sm11693939f8f.51.2026.10.22.03.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:16:03 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: "Kumar, Udit" <u-kumar1@ti.com>,
 Richard GENOUD <richard.genoud@bootlin.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH 2/3] dm: core: Add SPL_DM_EVENT
Date: Thu, 22 Oct 2026 12:15:57 +0200
Message-ID: <20261022101558.2474326-2-msp@baylibre.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022101558.2474326-1-msp@baylibre.com>
References: <51c23f5b-9ca2-4ebe-8f3e-72d22e404617@ti.com>
 <20261022101558.2474326-1-msp@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an option to allow DM_EVENT in SPL.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/core/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index ae0c34667723..22b72d6b766c 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -117,6 +117,16 @@ config DM_EVENT
 	  register a 'spy' function that is called when the event occurs. Such
 	  subsystems must select this option.
 
+config SPL_DM_EVENT
+	bool
+	depends on SPL_DM
+	select SPL_EVENT
+	help
+	  This enables support for generating events related to driver model
+	  operations in SPL, such as probing or removing a device. Subsystems
+	  can register a 'spy' function that is called when the event occurs.
+	  Such subsystems must select this option.
+
 config SPL_DM_DEVICE_REMOVE
 	bool "Support device removal in SPL"
 	depends on SPL_DM
-- 
2.56.0

