Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9E606A335
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yr5AzGjT;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=IwHMj+6+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83E6360881;
	Tue, 17 Nov 2026 13:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtlBiVEtABkj; Tue, 17 Nov 2026 13:09:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E07860873
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794920978;
	b=Z83WiEwpWCGJwD9GlJtP8WNCS2Z6gg97N1jtKFatbE4rP98ADrOtK9b4SDp+o4cD2voJ
	 djpM04/EYLpNVKqCZRoR7In3ESQyXO5F0JgEutMuEWSG5XQ9lYz6H8Rej9p19uxSXqEhY
	 hWYXtBtN/x496HefIrbR5WZb7B2LjMva+0YvqDmQetO3lVuPpPBnPfQ7nKkuuz37JscG/
	 cqSD/9NsBVMdhn0s4NMwUmpTKpOS7gPdmQx/+Lk18S2O32GnCiO0aI5TH4u7tWPIH6Bcg
	 vBE13hvnbhoZDosJj98xOguOD90U6wN97+HaADFV9wibm6VrX7rd1aRMXznEvA/bNig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CIstVDeSZ8C5PskBDUSG/R1uYUyxGkoyltY/Y4WDSRI=;
	b=cRDM+NwavyKc7lFFItnkwX8wF/TK2SOZS1z3jD7C2kDoYJF2BUobQlrRzJchAdtV0Vg4
	 p3QLxi+MgdXSsWgeLH93PEtK7iVXE0bZClWcUfoYtGtzO9HDZSaf6sphxq+XjFlRZw9w+
	 u/8G5gBZMvRg7bwne+6H38jKz9iYH28dgbe6OlCI8pxTLG3T2x5dJBh888ulRMIBPC0Pj
	 fAu3qCxIpw+YssdrQX9e/7yoyBndgS/O3kHQ5nmhgkhDRJnXlAsepYHNtSM7aHT8Yy5u7
	 AJBogYjHSqg90EhzkXnXL3F5whKF7bkH2G0l3g3MAzaBf6ojjYC2G/u/h5jbh8YOG0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794920978;
	bh=CIstVDeSZ8C5PskBDUSG/R1uYUyxGkoyltY/Y4WDSRI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Yr5AzGjTIJeTjyUrFQh2PLO8fZdGFMnKqscZ1krxaTkOpLfDZYGIoWW+sshR7svQ1
	 gktlCeXaHkmCG9817vw3Ig6OF+gNDCizbrAleE43eiYgsn/7qR2nQqNT8xB5EoyE2/
	 kbZsuDdwSCaCWTjIGfSEHpsjkoFciy7G0d45ciXkXpyoDRnTqyCajZ0TfU9EX6fYhF
	 F77seZs9Yj55qfO2qk3oSZb1N6UOst8XmKLytvzbfpdxLPtULDAHhh+tnHl4x9tujy
	 p8uutAotl1O1DzpU6+uKaDkyHdZS8+/eouo8JEdpcvsML7YisVdLhIsIGeyb5XX3aK
	 w5TD1e06mvoeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E07860873;
	Tue, 17 Nov 2026 13:09:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CD6149B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72E09400FF
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQPqgo29x0Rx for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 11B6D4008B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.125.25.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.10;
 helo=smtp-190a.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=IwHMj+6+
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [185.125.25.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11B6D4008B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:09:34 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTQ6z6G0NzCK9;
 Tue, 17 Nov 2026 14:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794920971;
 bh=CIstVDeSZ8C5PskBDUSG/R1uYUyxGkoyltY/Y4WDSRI=;
 h=From:Date:Subject:To:Cc:From;
 b=IwHMj+6+ZFfAIeetxTCmjq0EGstpS7ksFWvttfs9yX8a+zQ5cjenS2gx5w5/+AcD4
 UStW2T5EB4/lbSIOxReAbcXPBU1guiu2HqyMQ/1mVVhCJHRv59PmOUTtRwzXRD8C8M
 DtUMh7CYOY5kPyNJwcCe4kGHSa9mJE6oDxs4bXf4v+rd+9iGHqEWRaxjLF6nyOcIcf
 vlNg6e2xhDGjqVf1WDleizNgCqjgsojxs/WJDgE739E6y9JXsyJEw5Q+VeyleecgRu
 73SRLqPjXFRs7prLbznMpoXIRyI044BPrlzwPYZKhnrHF2A0+8LNp2EimDEwAQVDc/
 OPy+vOqExODdA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTQ6y0dtPzv2Y; Tue, 17 Nov 2026 14:09:29 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 14:09:16 +0100
Subject: [PATCH next] rockchip: sdram: expand types of DDR that can be
 supported
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-ddr-types-v1-1-0d00e87a0fc3@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCMBAF0KsMf92BpKEKuYq4qMmoUYhlJpVK6
 d2lun2Lt8JEixgirVB5Fyuviki+I6T7WG/CJSMSetcfvPdH1ifnrNw+kxi7IYfgZHQpCDrCpHI
 ty687ocrScP6rzZeHpLZP2LYvyhd6q3YAAAA=
X-Change-ID: 20261117-rk-ddr-types-05d330ea0c3e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Cunhao Lu <1579567540@qq.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Joseph from Rockchip confirmed[1] the values we can get from Rockchip's
blob from the OS register for specific DRAM types.

Add DDR2 and DDR5 to complete the list.

Add comment on where the values originate from for future reference (and
to hopefully hint that those really shouldn't be changed).

[1] https://lore.kernel.org/u-boot/501ace01-874b-4c61-b412-c297920c91a5@rock-chips.com/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/sdram.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
index 1c28d4aefb90..2e88febbcf28 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram.h
@@ -6,8 +6,10 @@
 #ifndef _ASM_ARCH_SDRAM_H
 #define _ASM_ARCH_SDRAM_H
 
+/* Written by Rockchip blob's/U-Boot's DDR init in [15:13] of some "OS" reg */
 enum {
 	DDR4 = 0,
+	DDR2 = 2,
 	DDR3 = 3,
 	LPDDR2 = 5,
 	LPDDR3 = 6,
@@ -15,6 +17,7 @@ enum {
 	LPDDR4X = 8,
 	LPDDR5 = 9,
 	LPDDR5X = 10,
+	DDR5 = 11,
 	UNUSED = 0xFF
 };
 

---
base-commit: 6201222134cd704b5717211fc917e2ca6263577a
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261117-rk-ddr-types-05d330ea0c3e

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

