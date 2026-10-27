Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40357606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lg4Wyrrb;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=IgdWWFBM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E3FB60752;
	Tue, 27 Oct 2026 09:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HpPoqdbopgWC; Tue, 27 Oct 2026 09:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 689F9606FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094025;
	b=owzsxlevF63fb4wmcA/QVOL+04DJBR5GYwvqe48oD+WEX4av/YHfpTl+IVWoyJD3Kt3z
	 wut92BiEq44NJqIO/SEf0rG/osqIUNrskFavtWvG9f6ApW1Nn3DNnESqovzYsnXHDxEio
	 XcLXzspzNbWbqsKmgGfrjolvzp1OvC6hGmiEYxRjDR2EyQENf16ciKEESEve0DMURR66x
	 Qo1gYO8LZhNwEUngIn/JP/vR33iGPdKLhEZLKOT+UhBQ0vo5+hFWYKsfVOJRGWwjTyPFo
	 L6DU1Ul+pkPZNrYjc1XQklIdwrwFd7g5CBhf2dOV3ytmYlIrxeamq/QJZr9502bI3Nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eVTHJJjWAZLNRcQ1UxhXkBevncBb3s1OE+D6LtWXD0c=;
	b=BLr9Irk/2aCbh+Q5XH5a12staheCMJRuWLXczNtLtSjHHUWaq9PmaRfXfkaAyNBLUc9N
	 vgxqhVgpZ6XfSYPbqJx3NH4xKLVp4Ulzfe0nRxYYVhcx4su1W2rzoPdrMsw+ZXLql34xo
	 x2tMVyePj/sIqibayDyfKiiKmNayHipuCIMMxYb+rgA4or+SXnGdsjNCKt2n/VLLo4wpX
	 GTzEexmeR+k0IQ4eq80SC+stAuLCHWBlJolzHHOkz6Q+Scsk41JO6vdpmD5WHAey2x6Y3
	 LKY3giGvPdjRZAxn7GfvAFtPUKjb8lgl+k7H4T22zJn8DpE9zZ42MUOT75Q2uxFy+NA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094025;
	bh=eVTHJJjWAZLNRcQ1UxhXkBevncBb3s1OE+D6LtWXD0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lg4Wyrrbb7ykcuMsqiKvsKThjrOeifxMznA7dSH/V1cVlmaJNKcvFUqvEMgf9N3Wh
	 aawDm4pS7oPnbQBFJY3+See3CtnoKeDe1PKGPbHM05J2UvNXG36FhXyGj+frldwVVT
	 gKsXhR108Z2zMfHKFidQfpnCgCRsfK0cn8YyQGG6jKRA42N+DBCZf1yT3JF7ft5i5n
	 ZDG2ZF89sMsLvWTVLmEAmr/3MkS0iQA3sYI1xzCR5hUyeZoI2Jd6T7Ldw66W55r+Rp
	 o6vqpVOm3m5HiEzfPVNPeMu8pJNss6hOtgKdS7qRYjFxjYTf6cRMtVGKDHDcS2ETn2
	 2VQGvAmdH62LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 689F9606FA;
	Tue, 27 Oct 2026 09:40:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82106279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73F5F80C0C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjSmwPiU33eQ for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A13380BDF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094018;
 b=Kpflcfe+gnwg8NZC8geLTB6GzWT6D8Kj9pD9dpg0l6mbW/n2CvMIz3G2+Svi3dIL1X+H
 SohoN3226BgGAuqTA4/Hosj8urfVzjCK4sEhLj+MNPrAoaMqY5NO1OBv0fdEnprBZEX/P
 /B5/pGKIwUSZAc9wKz6xqsTE7wYEHAVPvbs9+2Wk+8Gc0NSfy5dbPqN7DRRTJtA0Ihg09
 lKgUW7HfjgMJq6F/R/rho7Hc60X9EUxtnqDKhyC/7a59GYkCDcurCl7N+stUqC7HgJUZc
 ZSmlhqG0PHB5xsbvHSOwdDZIFI8H+hvOVjhm2fMyCpbqSNBX0I6OZvo/Rpy1tXRW/hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094018;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=eVTHJJjWAZLNRcQ1UxhXkBevncBb3s1OE+D6LtWXD0c=;
 b=lUgTzyu0GXZ4x1DTSiv0KWyYKYH3gMs7P0UDKAK/nVJwHgUMMfskZSZJiqMaAP+mfVW4
 DbrQudGosF48E1vjfi3Y/PFn3a5tNjomQjkvy7M6idlHZsKq7MspRU4ftvrIlA3kEoFaO
 N0CtV6XHnfuzRMVBhmzwm7BZQoA8JCDdT9LvHVEjelGwq4xM+wAijcSp4yv7hrxn6YciY
 fXtRqVHaPrnwFLDCfQXxfd8CNEodg1FkHI1BYptdbvuEQafbdmrM8H3K3YGCHFlWIMSPv
 wyLSMYKoDgUWFrDA2mRoTLhHQlnuMM+ex2GRE9XRfeUN7xuu9f2MPGu1x00BDh+CaYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=IgdWWFBM; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=IgdWWFBM
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A13380BDF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=eVTHJJjWAZLNRcQ1UxhXkBevncBb3s1OE+D6LtWXD0c=; b=IgdWWFBME+Ubstw7ydAH8BwF8f
 6qBoKsKmArlfG8IoQRRDbCUGbG9tsIJbLw2CuEJ1YI8YN5TN6SHIqz3VjKPMkuLw6BTnm3Y1VMgXy
 SjZe0SwghS7j0ospnoFHg6dXkCjP9Ywzq95gf5QNiv4t02Ptu0494OmNhg4vOHqJB9b6Z9iPk5xB+
 UlycgbR/iIEtsGRhl6O4VTqwltuMNvI3lKceGdiR+4FMXPkAb72weRWZq7TBiOnJCo3Vd4bvq70zT
 16VYCPmVKoJ0Oi+mXzGLlvkbvpe3DLak5EurQQvMJ5KJWQnfygLgY67hBjS6vQZpTKFcFVpCCsxIv
 MqN6FWCA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfD-0007Tu-10; Tue, 27 Oct 2026 10:40:15 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfD-00022y-1I; Tue, 27 Oct 2026 10:40:14 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 02/16] regulator: anatop: fix probe without vin-supply
Date: Tue, 27 Oct 2026 10:38:59 +0100
Message-ID: <1c2c96d0b94be66ca691754751df091d3f9fa321.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
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

device_get_supply_regulator() returns -ENOENT, not -ENODEV when no
supply exists. This fixes the probe on i.MX7D.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/regulator/anatop_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/anatop_regulator.c b/drivers/power/regulator/anatop_regulator.c
index 88570a1f624..68a320bd0f8 100644
--- a/drivers/power/regulator/anatop_regulator.c
+++ b/drivers/power/regulator/anatop_regulator.c
@@ -176,7 +176,7 @@ static int anatop_regulator_probe(struct udevice *dev)
 
 	ret = device_get_supply_regulator(dev, "vin-supply",
 					  &anatop_reg->supply);
-	if (ret != -ENODEV) {
+	if (ret != -ENOENT) {
 		if (ret)
 			return log_msg_ret("get vin-supply", ret);
 
-- 
2.55.0

