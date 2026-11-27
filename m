Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CC606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ETUs5uEO;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=SCBc4NAF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2322D81144;
	Sat, 28 Nov 2026 04:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6k7KNAOcb9dO; Sat, 28 Nov 2026 04:34:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1520A8112A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795840460;
	b=O7/NCB5WxkS13yoQLY+D8MqYojQtYOEXUA1RMrjkSjqgsl3V7LhOQvWe9LNNSM1MB9+c
	 Zr2DMYSNXeQO2N5q/JR5Lsj0t5sj2WYZW40FZumOq8ya76Y17Ux8vVbO8ceaR9uKUkaY/
	 0F661WLke0ByYQxms2YFnPDDn8K8A0iaTz6XfN33QdjQXfAim6iGs9PK9V5tJ9Xdwg2VU
	 Z1QbuTOgHN3bdmMiAIKxlUFvYDk2QXDOxjBfBrUtyrJnYePSodR8BOAj1Wa91Lp5goq4Z
	 +qvmm++NVBl0/NB62iU7fxv9msrmRgE6Dur9cnC75HkrCxfpnS1ek2brTmfUg6ltb4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795840460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LyJwHZ1XrEOi9icyhCe3vq4wyQTwfMBVIQqUmmK9HfM=;
	b=VGHxHRSvZrO8fKKTNoA887cltI9SFV1cpEKOPj+WmCLA5apj97wCNVyOPvwkiYcNAMeG
	 fm1ippHKJyDN9sMBVDWdyxrHQA9TJ3b3H1EgmQn2AmxaQh85U5/X/H05VyWLl6+4zR6lk
	 3FpHS5m2cJSgrtSEfXwxLDVxC0mo+OiCaNwVmlU8cfvN4ajHnQR8Y3E3LUPyZriY07wrg
	 41fNvSLWcpPmTi1TMmJegY7yMLdfM/ww25PTKQAlwr6S+oY5VnGrMyi6VNLQH8e+FSz8U
	 GV41ktjaxqGZ5gcgQQReEdRtvBD/MZ/rChblV5gdxc1larhHuynGlIyBfks6JaudJoQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795840460;
	bh=LyJwHZ1XrEOi9icyhCe3vq4wyQTwfMBVIQqUmmK9HfM=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ETUs5uEOw5+LsmsNOUiCkR1xD11aJnUSw01oPWTJAIV0XirApOkWQ6I+IvLL5QDOA
	 TwVsE2HxAo8s8yO00tweHkWVOJ0s6K9vhdsWeR/AC7WMR7Ert3A7X4Db5rctrUAtrJ
	 x/6gf5C5i3pjv3dsYljheiM3Hlga4jEgH6eVqR1MvSREUtBFnXlmeC+vne7ZcopZA0
	 w9rkKFyjgV5aBitvjOix2/Kov3C8CF+qV9lokmoxSlp4NKLW3hlpHuBFsyHVCPqzx5
	 RT+EVNXbsBe2oeTKXvpKtQiOGGEukQHnJCWS/IjEuEIWJL1BhuUHgdQhMKS8v94gdC
	 B8oKNbWNH8vBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1520A8112A;
	Sat, 28 Nov 2026 04:34:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 019C12BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB4BF60615
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUsDfTifupaI for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 23:23:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89E2160617
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.9.206.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.206.169;
 helo=mail-05.mail-europe.com; envelope-from=lee@jaeyeong.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=jaeyeong.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256
 header.s=protonmail2 header.b=SCBc4NAF
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89E2160617
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
 s=protonmail2; t=1795821779; x=1796080979;
 bh=LyJwHZ1XrEOi9icyhCe3vq4wyQTwfMBVIQqUmmK9HfM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=SCBc4NAFAXpDddpqjovf9CCwidQD/VD/tk+vbs1DLsjkoWxF+LhJ0axIlFwEewGrB
 AkkzRdHzo4W6CJw6s7qvXY8uiFFePsDfkvQ5Gayai17DHRFbFxDLPc4rHgp9f7jIcM
 5PO9d3JFr6YRweHJ2bchBtm810qSJY5uWQAIS6a8YL/8NyM/PbW7Z08CNLflTCtNaG
 3zkFX+NT+ree9EjDJWJ43eddco+wDd2wUNXYLEewlPiceGFpg7sb8U5gUXKvYkszQZ
 tu9nOAhMyrb7jIWxiBEPHsJeOgAK2GCj75sfWC7tViMVM0iK5Aq4acl1FVesb+t6Hx
 6Gn/0f+i72tgA==
Date: Fri, 27 Nov 2026 23:22:54 +0000
To: Christophe Leroy <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: u-boot@lists.u-boot-project.org, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] serial: mpc8xx: cap SMC receive buffer length
Message-ID: <179582176494.3807001.3645437772294577275.u-boot-v2@jaeyeong.cc>
In-Reply-To: <f917b336-db53-4bfa-9caf-11827755ff03@kernel.org>
References: <179024275173.70674.16356876476594066413@proton.me>
 <179579209485.3201180.9953622119991566579.u-boot@jaeyeong.cc>
 <f917b336-db53-4bfa-9caf-11827755ff03@kernel.org>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 4f41981b6e885e5144584ee3e50aa6220feedb47
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 28 Nov 2026 04:34:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MPC8xx serial object starts at DPRAM offset 0x800 while the SPI
receive descriptor starts at 0x840. The serial receive buffer begins
after two buffer descriptors and an index, and is followed by the
transmit byte.

Cap SYS_SMC_RXBUFLEN at 32 for all configurations. This keeps the
complete serial object below the SPI descriptor area without coupling
the serial configuration to the SPI driver. Document the constraint
next to the DPRAM layout.

Link: https://lore.kernel.org/u-boot/179024275173.70674.1635687647659406641=
3@proton.me/
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
Changes in v2:
- Cap SYS_SMC_RXBUFLEN at 32 regardless of whether SPI is enabled.
- Drop the static assertion and document the limit near CPM_SPI_BASE.

 arch/powerpc/include/asm/cpm_8xx.h | 1 +
 drivers/serial/Kconfig             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/cpm_8xx.h b/arch/powerpc/include/asm/=
cpm_8xx.h
index 98476cdf304..1bb44c9ab34 100644
--- a/arch/powerpc/include/asm/cpm_8xx.h
+++ b/arch/powerpc/include/asm/cpm_8xx.h
@@ -53,6 +53,7 @@
  */
 #define CPM_SERIAL_BASE=09=090x0800
 #define CPM_I2C_BASE=09=090x0820
+/* SYS_SMC_RXBUFLEN is limited so the serial buffer stays below this. */
 #define CPM_SPI_BASE=09=090x0840
 #define CPM_FEC_BASE=09=090x0860
 #define CPM_SERIAL2_BASE=090x08E0
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9ebc251d891..d4cf6f87c9e 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1201,6 +1201,7 @@ config SYS_SMC_RXBUFLEN
 =09int "Console Rx buffer length"
 =09depends on MPC8XX_CONS
 =09default 1
+=09range 1 32
 =09help
 =09  With CONFIG_SYS_SMC_RXBUFLEN it is possible to define
 =09  the maximum receive buffer length for the SMC.
--=20
2.43.0


