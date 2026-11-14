Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1921606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VFJHYskk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBziNz7Q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8788460653;
	Sat, 14 Nov 2026 12:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvozpT-zGRhb; Sat, 14 Nov 2026 12:49:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCFD060669
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794660580;
	b=PvvlrPhLs4sohAerKuHbME0YAG2zNpaQr7+VFWIlb/D6zepRLJrOeyg0xJRFGaPNKotW
	 UoYwqELyYYRwH/muFcCaXzTE0sNW2n5nCZvLkDG4yrkg1rFKs3PsgoZK0kXiMXpqdkPo4
	 sbWNaJe747BWuk8k1Oe5BxAVwNFe6kpJuOoMNVeAMoyDNfQ9RIx0NKaWhA7Wa3oGGtVqM
	 3H/OCP9tiSUfsB//RXbJ7o2ukPhDbIiwZKuWcsBqibRZiMn/noKJbrUYnWWNIE53oMtu+
	 5X4eN0cAYqRr3cT7KH10rI3L8ck6EOzWOxLRygq4lca5HxSZzeMz8lVpn1FP3GODcQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794660580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=56vEUyY9nKW56yysngA16qJfErVLJO3657a+cXZFLvU=;
	b=mRTXk+uSzPuyIi25NIHODi4JRSXviffA5q2ImxnclnR725PBQK/zsD4LiBm/Ay2CXq2c
	 ISrVKa7Dp+7PV/yExnEzbqKD5Qlf0k7Niljer0sH/DQsHIDy2aZ8EI4UCED4EycShk98p
	 /Oi5BJGq6Rw9/5PWAeBWUzRHT47EI3/6h2ikBXHH/pN2w8QNYMXKNm8YmaO1YUVuQrrPr
	 V0EKVNuH02YZkItqsNPGM6sPEZK7zrRqQBs9EKsGC7fu25VIO3R3etMu3xkEkm6flLafr
	 Z7Aak8OveTX89v2c0uMsO3g5Y+A9642YuwV1Sv/X0v3DSl8xYQu+jLHG44ORFsepy3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794660580;
	bh=56vEUyY9nKW56yysngA16qJfErVLJO3657a+cXZFLvU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=VFJHYskk4c7oY5ABQJ71U6RqeTfQWS8gqH5LYpK74asWEKbIS+YYGA2JoWb2fkIi4
	 eRYOUPNI07m0RNhspdxUtQCxjE3+LhJOkhI+V1ScuVS8w+r+Ko7fQDoks+Iqv8tee+
	 m6gN1/ebdKCnVE9X+G5WNeNpePUu9qLBEIG7ASxZZj9L0eiaBgKsaW5pa07WqRD9mI
	 LEeIkg0+Yo1pA61J4X0u3puGgHP0SSMtR66T44wdUky1dgbOuEOMseqM6QxzJBCrT0
	 yBGexRIBaFhDijt0xRPUPHtOV1+ZbVGWmGqD1g8rsgpYYUzs9Ej/BpD5E9p3urlQD3
	 hoUGx283Sr0OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCFD060669;
	Sat, 14 Nov 2026 12:49:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 004D228C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 07:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCD81817A9
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 07:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MeBsh16_K2cC for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 07:22:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 11609817A7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eBziNz7Q
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11609817A7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 07:22:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 314B160E01;
 Sat, 14 Nov 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 798651F000C4;
 Sat, 14 Nov 2026 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794640939;
 bh=56vEUyY9nKW56yysngA16qJfErVLJO3657a+cXZFLvU=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=eBziNz7Qqc1ueMWrykkDj+6p5eYN/1hzNQooazLTnRBhh38X01QkPyfjkK2jxgsMf
 CB54KBv41+o0nR3l60rouZ/kAkCI9110Ei/8GrLwEUVaX6SciFZFAx1ZI9lqfSImel
 jYl3dOLoRjjQCMmApbVZ2w0+bG9IT1bjKHOaLF9cOpBdt146XrcOSGGXM05JRnzr2i
 C7O8au+IrA6SVrlWB9ywXkLU72+fH5ppMp8ux3Mm/6SWt50/avAp/8p4Hx8tc8YMf6
 itH5/HxCEGzs9sDBBRz5g1Vt7U3BSTn6s2QEq7Q9m141Pvz1rS3KR1oDXj2ewCOigP
 lddhLXBRoA9Og==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CC45149CDE;
 Sat, 14 Nov 2026 07:22:18 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 07:22:19 +0000
Subject: [PATCH] sunxi: dram: h616: give the MAHB MBUS port priority
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-h616-mbus-mahb-priority-v1-1-8a65a2b60b35@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CQAxA0V8hXduE8piFv2JcMLQ6JeGRFoyG8
 O8OujyLe3dwMRWHa7GDyUtd5ymDLgX0qZuegsrZUJVVIKIGU6CAY9wcxy5FXExn0/WDNcdauCm
 5bRlyvZg89P073+5/+xYH6ddzB8fxBYYzkxt7AAAA
X-Change-ID: 20261114-h616-mbus-mahb-priority-3db3ed40d55d
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794640938; l=1601;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=TLUyXRDsAef9Ifu4GsEl1ERPm+wnlT5ZHDuMh+ikUtQ=;
 b=DBSe0s5EkFI7lS+8a8JA8XFhl4g7lzLnXH0Ld93T80y5k0GG1uKBn97BJZA6rLsb0CwyJgFNP
 ezymwSEtpCcBrAb+hYwsczqiVHiyEYejRcrgsAw2ckHbYi7+R4fmcBa
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 12:49:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

Problem: The EMAC reaches DRAM through MBUS port 2. With jumbo frames
larger than its 4 KiB TX FIFO, later portions of the frame have to
come from DRAM. Under CPU and video decoder load, the FIFO runs empty:
in MAC loopback at 1 Gbit/s, 6% of 8192-byte, 20% of 9014-byte and
about 70% of 13000-byte and larger frames underflowed.

Fix: Set the priority bit of port 2 (as is already done for port 25).
With the bit set, 0 of 4000 frames sized 60-16376 bytes underflowed,
against 1178 of 4000 without it.

Caveat: The setting applies to every master behind MAHB, not only the
EMAC.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 42a0550e015..e2a01a51a88 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -71,7 +71,7 @@ static void mctl_set_master_priority(void)
 
 	MBUS_CONF(0, false, HIGHEST, 0,  256,  128,  100);
 	MBUS_CONF(1, false,    HIGH, 0, 1536, 1400,  256);
-	MBUS_CONF(2, false, HIGHEST, 0,  512,  256,   96);
+	MBUS_CONF(2,  true, HIGHEST, 0,  512,  256,   96);
 	MBUS_CONF(3, false,    HIGH, 0,  256,  100,   80);
 	MBUS_CONF(4, false,    HIGH, 2, 8192, 5500, 5000);
 	MBUS_CONF(5, false,    HIGH, 2,  100,   64,   32);

---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261114-h616-mbus-mahb-priority-3db3ed40d55d

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


