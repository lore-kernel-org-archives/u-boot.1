Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73226606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RyxdzgH1;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=M3ldTqet
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED155407E3;
	Mon, 26 Oct 2026 17:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZ_vqSyHYqzy; Mon, 26 Oct 2026 17:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00A10406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793036087;
	b=XZ/yvuIOnrolRyl+lc2AfEZmhlcsOCoFVPOAkauB37jQBamU6JGy1R5dqDYUCNjACVCa
	 tnhaAU5JZ+oWJmp7kEmB9thWzsOgp8b7wRgT5vN0Mn6qvJTE1JOK6Xad7dDcR/TbvL98B
	 xJHI+igAMAPsT6NFhGkb7HhjXzgRc0ZeL6YOrLTVc/QtQetY7rs29ToYmov9e2Wr0TNpZ
	 zDjRBNDTP4U0gadVcW1WWmmQpTMpO021aSSxLQY/yfYBjrgQcmzP6+IkRczz8pPsqnBqm
	 B3yxMdimN9dAYjJHuhx6ud90ZLREd28DserIHORARq46Z5R2lgU3KqphQy4umZv4g4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=knOgKO+QkHgolHKypXhALgOWq6LS/FHl6UkvVlhlzWQ=;
	b=hq1l8x+IN5IXhWrpjDFkolMTVUd+fU0wIBgUYv0Z+tfND6mkf35bbe5E2hm/akODHSD1
	 oIQG5Dn6bqs7bcPQNWKhhPx+M/Z0uNhpyYVssTk5sPeekKjTkcu3/VfxcK96Rner+USix
	 QmNMhRrM89P2CBCaVDei1cKKnxdk5eimX13te80ImIEqRMgMCuFmJwcmxJy6b21SFZt/v
	 tCPlS6ttF1jYXzTL7Cpl44QnG7V/Di3T1YU3QtBBv6TRCFKG8RHybjcU+p+KSJDACLLcE
	 L1UF0oSRRVcxRXdeG2zaYUCvi7MzpiQ6FX61nmDcyqpLwQa3EUbJZw6yOtVC4wCWC4g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036087;
	bh=knOgKO+QkHgolHKypXhALgOWq6LS/FHl6UkvVlhlzWQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RyxdzgH1/ZmvNHGzD9w/SVpoeuTfIUlmJqbNLBqpvcMFEuJW5rjjJZEJyD2nNKw2L
	 2Ca0nTK/2/XM5mlUiHfF0JIu2ue6h+yNcVB40CrNVPdlU2cntqHxyQgUM9HuWyNf8f
	 I6pR5LuP4qRRZoesnwCdSBOH3JWS6LlMJ3d2L1Yy/dR8WDY6sbqNdwNm/dvZhqVPn5
	 j8zdef1qMkpJftKGtXIIcp8MJ4UhpR8ux7S1Wqdp8L2Cd1ZgGoUsoRdOcVb9qcbndn
	 xR0W5hAGqcUmG+l47DAEaySELce7XEu3IypkGWDkEu3imETpshFdr6AYuKyvJ//lGU
	 4lV/Z94wZ5oBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00A10406C4;
	Mon, 26 Oct 2026 17:34:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A1D13A7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3094D80DDB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:41:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KRIDKv4-FkmX for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:41:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1796C80DCE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793029299;
 b=EbQhs4rSblWIc2tGLIZVaazmPdzTVKcp7FV0KluAGUbMF5SOZP18p5GZwdSTRh9fkm7A
 EVTDUOo7dfiKnV2Oq9mtUBcg5MbRsAz+FVFU5wutUvNO7Uq0Pf28fI7TyjOzwTtT23CQP
 +TtEWV5BlmPpNwZEcIjrjrJOuEK3TQn/w0oMEwk7GaSmrYXyeAggDpvW6JvSafEKsHDXj
 mMvTsv7QngW++O8RljQKESxpu6q/TYt+W/+PxfSKtosSOPymT651pUmMFcO2nfGZtNce8
 QJSLqN43geoj/7oB7HTA8XGuYfMkczgQvDGA6cDQG+bnMtXKhNN2aiZyj9aJIifLt/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793029299;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=knOgKO+QkHgolHKypXhALgOWq6LS/FHl6UkvVlhlzWQ=;
 b=NkAhL6g7t0g754ZKSr/MyQ0H5oMwsjXyJyVN1CR1GePvaHJ8zSVAY1Z9sQh4DA8H6AxI
 8ppwlOAiljKQWWR9ry+JZiV9gFQ4Y/Ebz8p0DWj2xs+dhc3JmAD1mX5WiUYdfIhS3tQKH
 0nie7k8gNsUwUowv2RBMEIKurkN1eBtmhPxA01AJrluCT7Qm3rAmtlktyLdErB4pRcM3M
 /K2ZHcbwzvMadQAqs9TkTf2z931WJcyKM8BIsz3lek78jQjOV73inZKsQCMZ7n+zfaJBD
 S66qoIr+Qv1RGhRRDStO96FZ4jn7qVGi2z2/ZtovJkMtuVUfAVFEd0mXQBs1xmFOwKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=M3ldTqet; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=roberhu001@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=M3ldTqet
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1796C80DCE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id; bh=knOgKO+QkHgolHK
 ypXhALgOWq6LS/FHl6UkvVlhlzWQ=; b=M3ldTqetkWM1JI32ZPjV3nvA0cEoWoR
 9OuirPND6X3UTYzqnVZM08GKzabh2jxqo+MfkgwDC7Qj1198M2B69YcMVajPZNCa
 6zSalxzHxfAwzJkE/nE6ERaQD8aZDGOQJsWEZUzz4Ee/OgMa6AeQK176cM48HeSn
 WtH9BAyIJirs=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgCnn6X6c99q3RLgCA--.14756S2;
 Mon, 26 Oct 2026 23:38:36 +0800 (CST)
From: Zunyi Hu <roberhu001@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>, Paul Kocialkowski <paulk@sys-base.io>,
 Johan Jonker <jbx6244@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Zunyi Hu <roberhu001@163.com>
Subject: [PATCH 0/1] sunxi: SPL SPI NAND boot for Allwinner V3s
Date: Mon, 26 Oct 2026 23:38:22 +0800
Message-Id: <20261026153823.31110-1-roberhu001@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: PygvCgCnn6X6c99q3RLgCA--.14756S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw15Ww4UJF1kGrWfJrWkWFg_yoW3ArXE9a
 s2y34kWr10vF9Y9FW29rZ8Jr9rKr48Wry8Ja4Utr9Iq3ySvw13Aas7t34xtr1UJ3yjgrZa
 yFy0yF10y34jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_a0PPUUUUU==
X-CM-SenderInfo: purev2tkxqiii6rwjhhfrp/xtbC6ByuSmrfc-zjBgAA3P
X-Mailman-Approved-At: Mon, 26 Oct 2026 17:34:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>


Hello,

This adds SPL support for booting U-Boot proper from SPI NAND on
Allwinner V3s. The BROM loads SPL from SPI NAND but still reports
BOOT_DEVICE_SPI, so the new loader is mutually exclusive with
SPL_SPI_SUNXI.

The change also avoids treating that boot path as SPI NOR for the
environment (prefer FAT when enabled).

Build-tested with LicheePi_Zero_defconfig and
CONFIG_SPL_SPINAND_SUNXI=y.

Thanks,
Zunyi Hu

Zunyi Hu (1):
  sunxi: spl: add SPI NAND boot support for V3s

 arch/arm/mach-sunxi/Kconfig             |  22 ++
 arch/arm/mach-sunxi/Makefile            |   1 +
 arch/arm/mach-sunxi/spl_spinand_sunxi.c | 449 ++++++++++++++++++++++++
 board/sunxi/board.c                     |   9 +
 4 files changed, 481 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/spl_spinand_sunxi.c

-- 
2.17.1

