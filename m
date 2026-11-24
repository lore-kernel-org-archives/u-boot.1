Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E4606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i3EiXEUK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MboCp+S+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B485740808;
	Tue, 24 Nov 2026 13:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p3pdiWsDFknT; Tue, 24 Nov 2026 13:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2F75407FE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526590;
	b=j0xon7X0vv7rc04QDpCZ//kEvKVO7p5yNDqenyKeWpVXTLyYW/xhOroUYV4V5XuAmpVx
	 YIsCpGeFEo0aAKlp2jyK62B3L/cX13gKSER2cIhdGQWfyU8haSyzj4o9BDpF2SFGSiKdd
	 gk5GL4lyw3IP93yuQl3mhcWqBTEITT7BpwWbTGKjnyJumhM24xErj4qLKPr9JcNa69L/7
	 XD6/CLTg6Alwgatxa1iCD3ZP+ed5Lii7RpVx2IUT5B2kdtSWL8Vh5WH4mbWTciadzbnFK
	 6JwApewoOsdaMoeRptNZE/jRRUk3A8gcc22XfzzzJCDVOQgqw/3v1dYt1FEJkn6RKAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6G+QgEY7EKsd5125FSAH5z365z+jpdGVFstUpMa97L8=;
	b=FsfYrOYe5PCCeYiWigsKX3CLudXPz4Kh6VEpCgvsCrvTbE/VPwz9G27FdhGqGQPq3S1N
	 K3Iw7QrhyJW8b9NoKOzTozfvYioXkyIb2l6dkA0/TX5ueyfHjVIy7g9ordk+YVsS64dfM
	 0Cbrgz922xbj96DaHEAJJvLiU8WcKRG+jhBJrWn7NaD/GU0o1z5gSH0tLkIsyNxKYP/bZ
	 RGhubIpdGyUx2myAea5a8PpWCo5NndFam0MCF+G6ZoQ4ZWsqMHnKxwJY2wgpPrRL1ARM/
	 +7B+CbALTC680x2N97BMa2e5J1/H+r6cSWvM2nb5XTsGhRNQSCuFufNv8DlDNd+cDzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526589;
	bh=6G+QgEY7EKsd5125FSAH5z365z+jpdGVFstUpMa97L8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i3EiXEUKRe/WqICnP48AIjqm/kMiTmfJFafq7m5JKERcNC9Yny+bbKyBmWSFnTeUH
	 ARyVpxq2Fp9nJhqsZdsGuTLTXT2PU29/udqGQb4pme1FUWKJ5JfHsfnlDGldVSZk4g
	 c+OcrB3gNpmeVx4uQ9UGESQmfWY15nX0GerbcuOsKOAwZRAzKIZFAKvvZ+ARqXINJz
	 Ew57yalZjram3w+0TcNFJJnoDyTppF9UGbZuPcPNSmCfo3iAopPfBnVFCtZ9MYuM6v
	 1VAP8oB+Bz3X2qexFEQ8wIVvDK9/sBk9PKS/pI+sCe+xbksXadF7FQJ1xGr9AymcSy
	 SUyBzg7K5jnZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2F75407FE;
	Tue, 24 Nov 2026 13:23:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E585D715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB5BD80FD8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JtGBic8XNeRp for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 12:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECF0980FC6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=ssunkkan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=MboCp+S+
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECF0980FC6
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:36:35 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8b67f25e6e1so2124902b3a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 04:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795523795; x=1796128595;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6G+QgEY7EKsd5125FSAH5z365z+jpdGVFstUpMa97L8=;
 b=MboCp+S+3OTGKch7/XoK/gm6FBTmi+r66lGn5tLdWiNYDKjFnaYBWCGkjQ/K5Pnv2P
 kHSj8jlsr9R6GAZLnXqfZBnmi2NT7aCmc5alzw4W9B8vpSRV+GR7rHjaDqrYKiEQt8TB
 7kXPHspR4/BUvc7+X+yB3oswVFOCdVN6tZTIW5UlOjSG38VY1MbQ5+/nM4rVnqMmdp8s
 ZZnkBNYEuRYNxf/WflaBEF9hD9svrsCHogc6IC+qoN5uKqg0i9RI++9zB/vq26ILYv0A
 Csw/9c+mSipfSIgsorpqX8qmbsju85Tp8rN0De3O99bKGWHS8DhKpIHRPwTh2tscP2Cn
 bnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795523795; x=1796128595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6G+QgEY7EKsd5125FSAH5z365z+jpdGVFstUpMa97L8=;
 b=viSVOwSyU6AmDr0j1U6tMkWMwCZICg36qmsZPebJhdq9kE/3MXDINmOE3Kzi40PEiG
 9urFXC0JirqXhUEVk2nom5crBkISzi6cg3iPdMUvPCIauvR4SIMdbn9B1indqqI6koJ1
 SpgHyOox0kdh3CUW79CkDY6tmw+xDWC3qRq8uErV80TuMG9571V9g1Ly5K/P8Ay9sTmQ
 VDMpmfTMnSsvYf9zLzwV4WnqGPDr9aonJCny40m56QHy6CsrIcJtJmqeNjniHrinPtaZ
 JtF7oZxRZTiwmHPuTAlqPqvYf94zUPRQsXV4ZGFgqocGAX+dm8Wd/NMMDy1B7PYlilfy
 X2Gw==
X-Gm-Message-State: APuU4Z8re9aeg7EZbZnP3IyWpMbVTjpvsEefIz28NpchIbZwfnpKXNw4
 3QQB5F0pDuTicvJq9BK/905nZVve9vN5tphvCEauGHeNy6Nltcg9yCsYuRc9YtA5
X-Gm-Gg: AZFdTZfL+MKVLTPf5SB8L1YYeH2Oga16ESMFLru928V/tfEsOVxV/EsuLxslRlDUU/B
 m8kr8e6Kch7ybTQ4Tc976vENO8Hjdu7bMFtbSoVSNYSok9rcwmzUZEa6HRy1cbQqKwU5P2nKhtM
 q9sQGgYRg7jRbRBNab27aQrGhHocN/7PLhF6b+GwQhPe5mxjTUNHjMfGwzpT1gUACfCYJhT2etC
 BUEqjo5rX7mXLG1I+6/i2udgPgLKD2DMsv6dgwBNHpaqAoYAJQFiOdPhU86PCzeoqoITEzrEvHS
 naevvnbQsOfUgq1CsiIRys9Fe4GC7ltz71uEK3b0xBo99mIpNALktZUv3aDf+Z681dSjztRYucC
 L8KgydUsA82hH6xnhA2591mkuzOjrEznMnr4OTP3fCldST+Ene8AOYdD1prylRHSv3/hwidv9W0
 bM7gv50VIeLpj6ghFtb8gX7o6ucbZzlSoQW+LH0qsG5VBJcygg3B08ttaOxh9WE2k3b0Se+AhfI
 V9d5G0OEsuP9HoiX2XZj9hjeLmkQMXPPSTbZrNSth7lit2Hg6yUyRhkAUyAbzi4wuPpvl4b1iby
 jsAfoOto8uyGw49229RWelc=
X-Received: by 2002:a05:6a21:3b8d:b0:3e2:13e9:fbdf with SMTP id
 adf61e73a8af0-4014d4587ddmr13749098637.35.1795523794342; 
 Tue, 24 Nov 2026 04:36:34 -0800 (PST)
Received: from Sun ([240e:3a2:dcf:f2e0:b166:f710:8cf3:4924])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e456a7sm7156091b3a.29.2026.11.24.04.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:36:33 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: vigneshr@ti.com, takahiro.kuwano@infineon.com, trini@konsulko.com,
 vjardin@free.fr, Jacky_guo@xmcwh.com, hs@nabladev.com,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi-nor: Update XM25QU512C to XM25QU512D
Date: Tue, 24 Nov 2026 20:36:24 +0800
Message-ID: <20261124123624.471-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.4
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
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

The XM25QU512C has been discontinued by XMC and replaced by
XM25QU512D. Both parts share the same JEDEC ID (0x204120)
and are compatible with the existing SPI NOR configuration.

Update the flash name to reflect the part currently in
production.

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---

Notes (patch-notes):
    Reference PCN document for the replacement:
    https://drive.google.com/file/d/1RR90EaWHKFVZMQrqLorMjc4brIkE0TM7/view?usp=sharing
    
    The latest XM25QU512D datasheet (Rev1.6, dated 2026/11/23)
    confirms support for 4-byte Quad Input Page Program (34h)
    on page 63 and in the SFDP 4-Byte Address Instruction Table
    on page 87.
    
    The datasheet currently available on XMC's website is an older
    revision. XMC will publish the updated revision in a future
    quarterly update.
    
    Current public datasheet:
    https://www.xmcwh.com/uploads/976/XM25QU512D_Ver1.0.pdf

 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index fce22300b61..509e880cf3a 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -682,7 +682,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH512D", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU512D", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XTX
-- 
2.55.0.windows.4

