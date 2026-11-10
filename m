Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29CF606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CD42E/Wj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y/O419J5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 842B080E03;
	Tue, 10 Nov 2026 02:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8i-lUUnKIJ8; Tue, 10 Nov 2026 02:13:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0A0A80D84
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794276789;
	b=C7nlvybCF/jIWsnPRr2UaQLHCSFdaU4PyiinmcpZm9TXyDjhpHEeOwTvk7JM7UHLYm4z
	 RtqU1vB+/BdeuAkz4oyfcOv6lVsu4aqjby0AX8ZiY6HsEwqwMf4mCc739qObG62ExWvlc
	 NMf4xveskWnFMAMuN49dtSruyQHHNYF6353U9GZSIHEtT7D4i/djuu6Gqwgfle7wtpz0V
	 yOTB7Dx0KMuhxRHWP9Nzdp4xoYRglUTZw2oEDKBqHKtRw/HOMQp/6ODxlMpOdtjZ34RD5
	 DaKi1MbCRd7gCMEEuAoy1XFT/d2yJ8Kzw3VaHF/2rkTqIqSV/o2m3UDGgv/AtIkIkBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794276789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Vk7OBSiauM7TxGUYfMU5+DHMBJD16dhLUgcsd1daLw8=;
	b=sxRyJb95vqsJ9uWMr5/wbP1g/1DnNJHrtj6rnnIAvPG233bNU/nsJB2Ho8wJxAPlpR7p
	 QwsyX4F5eJUvOwO3ndbSEhvdqyTrecvTDkuP/nmgUYkhxVQkci2iEQmsCTos0epc5M/6g
	 PiK0xBMnbPuOXSZLERfiA7m7+sHyN9nevODl7PUvHxtKKTJt24oVlRtz+Majr9U+9nJby
	 S3PZBeIybpYmEHj5hr14kullhr5zc3kyQ/jv7eLN9WVhTiUui9X1M65Gkzfn/rTEUtXim
	 XdOR/UZUYCx1y+5Uz+WuULhrjW1vo3WDVdvIOAhSFrgKkmIUxc+Xyu9s93aIgq/ry2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y/O419J5";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794276788;
	bh=Vk7OBSiauM7TxGUYfMU5+DHMBJD16dhLUgcsd1daLw8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CD42E/WjRxLZHMHSB4WQPhr0uwfU4w5cNDhgjihiko7SS/ITg5WjJdLSN9cZryebp
	 d2bciWo4MwFyzZ3BTmjqMBdYZ/XFTexWZRx02HegRuWfZ6LPdk2NUAS3CQr7R6uOh3
	 B+xFx5iPrPG5p2MZYY9cYAdHFEWTyUmIOV+jQlUdxUYT7Gv8Ek/QBepAialOCW5VVg
	 +MGzUbycwZrqplPVKDXceIgeGJiO5/3LdxerkfYh5RFtNARo5CfJSKfr5so90sZU1f
	 n8Nl6GOXqnpfKUYcc3fmVEytAz033NBNwACYCznZxCm/xn3GjFr2D19+/xLumI67jG
	 blskU2KzIY+4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0A0A80D84;
	Tue, 10 Nov 2026 02:13:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 880054B8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D9DD80F80
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObIUmUP1SvnE for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 01:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ADE1080F28
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=prasanth.padarthi10@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=y/O419J5
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADE1080F28
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:00:08 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so2661976c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 17:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794272407; x=1794877207;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vk7OBSiauM7TxGUYfMU5+DHMBJD16dhLUgcsd1daLw8=;
 b=y/O419J5BiHnLFNXQJQv953GpeckyygoUhhaZm+Btsnl5MA1qOIAXhlorqGIWvoU3U
 RxAK0Bk75ccmGSAlXBHxSv9dOeAtxYBdQqE8b1i+uvAtzrNlIiL1um8QJh3pg0aAPRcs
 BTZOnrSKbkmZld6nWkb4nEBeWwutAShTddzuL5xKh24pKadYgdOQa59UhS/yPyro0aWO
 N1is2sXEpn84fhUrbxlmHnT/ELOmR5HP1WICh8kochY4JtajiCLdarmZiOZTRymTYgwe
 o6WwPin/cq11nTFUCVOugaU0k4b7QuGoXSOYS7XLvEmZUVUYZk9sVgq6i46Wf029qV0v
 0uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794272407; x=1794877207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vk7OBSiauM7TxGUYfMU5+DHMBJD16dhLUgcsd1daLw8=;
 b=zjbhGAe4YFIDu2EHOhXF7ozPoAQZ+EFIRVGM4kybhmb+cG8zSFxzkzSYnC8Bj9wGsX
 mXS5E9AuBM72+zP5fi3tImDrpPt+6NWlABWBwiBzS+LSVZbcYqIbroZrA0FlBOyQPVh9
 1TIah5utwXiJ9wdkdVbQuwzjsZEOKri3WEgB9Waid8BfKS/kZz8YEwv0oaultioKLFPR
 uekmI0xicUFpP8qaa/Nm+IFq2KXjz6giOJdI0CjDEZdmhrGYuZLWbhVQXb9bToAhDJwn
 7UxlJqNCGOKoWpQ21VaDRV3JQGB3rbVh1bSxhW93SSYbvUieYi7IbZwVdTI3rdrX5J1O
 COJg==
X-Gm-Message-State: APuU4Z/oIg7IY0XNJSp4oIp4qDB0f2GUxlFxPtCO9Q8vL+C9Ae2PGr2N
 GEhZuHT5HZWqlI7G0nwL7HUxbJh5CwnsCpWAP9W+zSrg3PFhqQv4FEazB5Ynws4b
X-Gm-Gg: AYBFou0s5Tz2aDXjRASUOetour/1kbv5Ls/Y8j5pjShs1T7p/bDY0MqDkJjwXBnPfpU
 ibiiOk1+H4Movtw73s3oDcdUzTAw63K3Csm76bm1cA8ezPMjt6v5kA/V+bdWUn3a6yxAqch/E/z
 gWc3eFVhg0aQwSkXA0MAE7VirjyXP1a8d+b4iaNmPsRgnxGiiYuSICgK+3IWuff3A9RQEvVwiqx
 X3wE2oUYd9IWoCbUAZEs1wsyjBPOhf/jjd3DYuPTKfauSMFryjnCGmpYyg/ol6eL1WKU5QyXKpz
 2rOC0QJwGf7cgBu+jfFcZpbgRSS6ucQ8adMMUcZBloBVwmmo5dKR3OoL4fV7NGBAk85Z/y+6I2r
 FeoHOGA58QkfzTjAeKj9ozo719lN/CyZMKZngVS2DK2L4t4ny6Yh1Des9SSo/G/xTJ6SPdcH/bi
 w6Ubw4I2fWhJuWauta+DvYP8JqHdjaJmomd3vJSMa2a5iwHrUBHNJIjhJ6d8SQB8N3KU8CND/Ho
 YNX2eyVF/VMlQISIFYkEmg6hiCGNSP0PhE4otXovVRhHB5OOiulfvrZQw6d9cFv7P+3um9eGe8+
 FvgEO5i2ZKmp/9z70cPnv8uWdQ4TJGafBjC40QZ1n/7y6Ag=
X-Received: by 2002:a05:7022:3f0e:b0:1a3:dbb2:478a with SMTP id
 a92af1059eb24-1b3b600f2e9mr1623869c88.27.1794272406761; 
 Mon, 09 Nov 2026 17:00:06 -0800 (PST)
Received: from debian.prasanth ([103.183.205.43])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b4eef8sm2677126c88.16.2026.11.09.17.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 17:00:06 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 ilias.apalodimas@linaro.org, BMC-SW@aspeedtech.com, joel@jms.id.au,
 Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH] arm: aspeed: ast2600: Add B650D4U THRU handover
Date: Tue, 10 Nov 2026 06:29:30 +0530
Message-ID: <20261110005930.6659-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 02:13:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ASRock Rack B650D4U uses AST2600 GPIOP signals for
host power and reset control.

Add a board-specific initialization sequence to prepare
the THRU pin selections and release the relevant strap
overrides before handing control to the operating system.

The initialization is restricted to the B650D4U and
checks the resulting strap state.

Tested on ASRock Rack B650D4U with a custom OpenBMC image:
- U-Boot and OpenBMC boot successfully
- Software-initiated host power-on
- Physical power-button host power-on

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 arch/arm/mach-aspeed/ast2600/board_common.c | 55 +++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/mach-aspeed/ast2600/board_common.c b/arch/arm/mach-aspeed/ast2600/board_common.c
index 4c0b705ea88..3d8df6a9977 100644
--- a/arch/arm/mach-aspeed/ast2600/board_common.c
+++ b/arch/arm/mach-aspeed/ast2600/board_common.c
@@ -13,6 +13,8 @@
 #include <dm/uclass.h>
 #include <asm/arch/scu_ast2600.h>
 #include <asm/global_data.h>
+#include <dm/ofnode.h>
+
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -49,11 +51,64 @@ int dram_init(void)
 	return 0;
 }
 
+
+/*
+ * B650D4U-specific AST2600 THRU handover.
+ * Prepare the THRU pin selections before releasing the strap overrides.
+ */
+static int b650d4u_thru_init(void)
+{
+	const uintptr_t scu = 0x1e6e2000;
+	u32 strap2, strap3, local;
+
+	if (!ofnode_device_is_compatible(ofnode_root(),
+					 "asrock,b650d4u-bmc"))
+		return 0;
+
+	strap2 = readl(scu + 0x510);
+	strap3 = readl(scu + 0x51c);
+
+	if (!(strap2 & BIT(28)) &&
+	    ((strap2 & BIT(30)) || !(strap3 & BIT(9))))
+		return 0;
+
+	/* Prepare local THRU0, THRU1 and THRU2 selections. */
+	local = readl(scu + 0x4bc);
+	writel(local | GENMASK(29, 24), scu + 0x4bc);
+
+	local = readl(scu + 0x4bc);
+	if ((local & GENMASK(29, 24)) != GENMASK(29, 24))
+		return -EPERM;
+
+	if (!(strap2 & BIT(30)) && (strap3 & BIT(9))) {
+		local = readl(scu + 0x51c);
+		writel(local & ~BIT(9), scu + 0x51c);
+	}
+
+	if (strap2 & BIT(28))
+		writel(BIT(28), scu + 0x514);
+
+	strap2 = readl(scu + 0x510);
+	strap3 = readl(scu + 0x51c);
+
+	if ((strap2 & BIT(28)) ||
+	    (!(strap2 & BIT(30)) && (strap3 & BIT(9))))
+		return -EPERM;
+
+	return 0;
+}
+
 int board_init(void)
 {
 	int i = 0, rc;
 	struct udevice *dev;
 
+	rc = b650d4u_thru_init();
+	if (rc) {
+		printf("B650D4U: THRU handover failed: %d\n", rc);
+		return rc;
+	}
+
 	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
 
 	while (1) {
-- 
2.47.3

