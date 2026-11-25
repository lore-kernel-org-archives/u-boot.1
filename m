Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EA606A33B
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W2NlrQ6O;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tjRGgMsh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AAEB4059B;
	Wed, 25 Nov 2026 13:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CzaBxUjJbdHn; Wed, 25 Nov 2026 13:18:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B980240812
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795612695;
	b=MM9+EvCOVxZgtydW38uALasy920T+mcKvhF7K29taqlaUdxcckWkp2mQYIUIN5oHww6M
	 eWjlP3MnD32ZyisaPvQIyPKuw4ZStQknOwru8iTKUavUNZR4q9xj5NQzW5LNDxttzTSxi
	 6t0Ii6PhcfjPFDEaNgXAxdiVuaP0uKKttOawDZYMHwF+L3tb5UM9tlPtY8laxq2fYWi03
	 YFlHjHkl9j2xfCL3pzLZLWAXJVGSy8NwGQ+jx55AwsJye8VFjTL42QiAGMmqTcyRCy3yd
	 +/wUHrqxVziBPywlLDDrGnqvCAbZowkEqqlKvx11Exy3TAeDqotCOefURLZHLGvnZgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795612695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EJ6/6P8JFrSsAQW9qIHu9MBfejhzjAhDoiowQosfmkE=;
	b=Le0QxRfKepk/MCTeUeKB/IuPK/GfHZxcQKFkRrlIX664ZIoJOiZYgq2DbMKIfE1i8XtC
	 Yu/f6YBtFIBBRRFGeSlPbMeUoh1mfF1NrDIhWRnfCWGtEM4rjr/5GL1j1SBcA7EzEuhpZ
	 2EWh6M9z71ihmISjEG5XifWl74GtcWg1AJx7M2hqv4azOYlwyqhae+Q6mSPW0heRBlYU+
	 MyB1jo8XjVCpUFsoSni4RS0YtATd+aJmONPohfXIuVCzc4KdLAVC2nV74qNjC75r7/3jh
	 a5Gox2+UINMdPLYb4gfZwr39yIwe2xrTWLlXOYmgVZk1HoNmh0aAAkNSj4NiDTvxGQA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tjRGgMsh;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795612695;
	bh=EJ6/6P8JFrSsAQW9qIHu9MBfejhzjAhDoiowQosfmkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W2NlrQ6Og6Ee7a0RGimldj9s0MMKzH1IwSzoAH8gdImWdv7eBuan+BznDCFeeSy1K
	 +aKZvtjtGMaxy+SN5gMy5FvdAOU5G5bgDge9qODti3J7QqCOk65AA1ptagGpnuRl7e
	 YJ7HYFeMGk9rCyR8leFBqmdnnOtVBVa9rielM5l/wOL+pJsZ0x26O9yTnXwePtNY+r
	 FCBU1leKwtGAog5cjNsAb8rKjL2wsPfSmcmIBv3G+1Q+Tr9fq3S/UQQP3gmvAI5N3R
	 NF+DzLeuahgkHV+dxlVOx/HiDh0ifkDspmR8/qKcnPKPoL8hcXJy9fbFdFgYL1Y0UL
	 +wAcaNMqALvlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B980240812;
	Wed, 25 Nov 2026 13:18:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CFF6325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1EF59405B7
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iDI9_EuwmZ89 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:13:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 293A9405B6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com;
 envelope-from=ssunkkan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tjRGgMsh
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 293A9405B6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:13:41 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so2611241b3a.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605221; x=1796210021;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EJ6/6P8JFrSsAQW9qIHu9MBfejhzjAhDoiowQosfmkE=;
 b=tjRGgMshcYsD2SPKYmqlzBhq3AZO9U+Zl4AtBLkI7Q2VsQAydC23mXBIvW4+JPplp4
 MSxFkJBft21TZ13xgHxQAHg4x7T2vjD1Q7xSR/vrQ4ilwr9ba4Ie3fjab9YWX6cxO4fW
 uF3eO03Dff+HBz18FRocF9CLaaXktESUNdPqpjG20rIscNE6a1wPB6gQ8NTEWRu5kJtv
 7bwbzD9PxSSL+hoLe1pfSf8px81ypG+kx6klm+eLpwBmKTpoq+gU/LXGIQMtLZPj/bSS
 IpKLofs+N4Vx+r/nR2Ovt0sM2FR7tcRwJBfPRXXXDrjKbAAoDGyHaTdzChls7mmBpm5M
 oN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605221; x=1796210021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EJ6/6P8JFrSsAQW9qIHu9MBfejhzjAhDoiowQosfmkE=;
 b=loqMlfgT1RDep8Ana+1UtMMSDmJ+AkIO3SxM135qSCz6fEWLSwXMsTr9GF5naoikB7
 y74gHp1cRITSyFrb5Ut55qdlX1B6bOrD7CSTBxunj72BeTTbUCbbznYIrxbWhf8tAYUV
 UR9BbC1LUIs4ZkIN0ZhkZQAGNy6L08gpAVhlFaK9wshCJMqlsA2419R6Oeb26W5oIc3Y
 z8MRffxKb730ykiMmUUulLhd6LiigX5n0CS0NiB7v/pNv+YuRUtFCqbpR/EVSZJcmMk5
 mEAWG0qv0zzSG8+xvL/vtdHT++0ki7GokSYCuBsDsdjragziE5GuOQHnbBxLSzA/b8jc
 gqnA==
X-Gm-Message-State: APuU4Z/qBnSpXwxxOFPUs/RIrjUbJgRKycBMyC/jISYFvw51VRDPtfiI
 SyoQNFubn/0yANX2RNWExYPVLWpOV8UzUDJRxt2GUXnXNSwSsMe6nVqY6YdIPaYu
X-Gm-Gg: AZFdTZeyHOZt7qA6m3Nz7wTG+CMrd8uoQqbcf68IePOEfio3RBUqXz0otVjUhxAdZX8
 wznt9GUbdUgJIKFs/2d99ZleurrbkdkEM6YLIjceO9WxFE+QDT/KURPJkgKHHAtIQMGFAFl0O8N
 wMj+JFP9qJaN4BhHuT74DKFtPUNmqIxxLfR5gvImpEMDHqzXZxViilbXXKl6spYF9T0/n8aR3Nx
 COX/xHCntRa/EpgxS8fF0ubFnCZnlkTUnxv+w8fhWHglJSZGXzIL2wEcg2FvJ7kUDOWME3wWewK
 zp1ywndtlrSIvQMdjippioS9pCvYyQ7Qw1cgelOWVAxRAcPFmdKFjjDR28VDKuKpxB6DB4onKnl
 PlsWH3R7W0/FQ4J9ADl8+L2hDaU9eKRoWcm4z3X0JHE38OPt6mEV6d0EbLUp7FaKm4FP7oCcxyP
 l7RCXyoDKSfbum4ThC6iZ3LswCHFiwL4JF7p21LjA4Ji7g+LxC1w6O080aitYVA1Q8qqcXDWPbU
 xQXJ90HlPa6fYXE5TDKDZPzfG4lCphnxKmsDHxl2PV3U8m3ua0Ey1bgeptZGTt9MnC61TGesD1D
 0ANq8qyUuZaRml6NLgtTYeg=
X-Received: by 2002:a05:6a00:2e2a:b0:891:e380:3d03 with SMTP id
 d2e1a72fcca58-8c7ddfaf314mr12818938b3a.28.1795605220523; 
 Wed, 25 Nov 2026 03:13:40 -0800 (PST)
Received: from Sun ([240e:3a2:dcf:f2e0:899d:6e37:7d6d:4dce])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8cb6640429fsm5841883b3a.38.2026.11.25.03.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:13:40 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: vigneshr@ti.com, takahiro.kuwano@infineon.com, trini@konsulko.com,
 vjardin@free.fr, Jacky_guo@xmcwh.com, hs@nabladev.com,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: Update XM25QU512C to XM25QU512D
Date: Wed, 25 Nov 2026 19:13:32 +0800
Message-ID: <20261125111332.1820-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.4
In-Reply-To: <20261124123624.471-1-ssunkkan@gmail.com>
References: <20261124123624.471-1-ssunkkan@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 13:18:12 +0000
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
    
    Changes in v2:
    - Rebase onto the next branch as requested by Tom Rini.
    - Update the flash name in xmc.c following the SPI NOR
      manufacturer driver refactoring.

 drivers/mtd/spi/xmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/xmc.c b/drivers/mtd/spi/xmc.c
index dbf11a4c5d3..ec98e3fb388 100644
--- a/drivers/mtd/spi/xmc.c
+++ b/drivers/mtd/spi/xmc.c
@@ -17,7 +17,7 @@ static const struct flash_info xmc_nor_parts[] = {
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH512D", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU512D", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 };
 
-- 
2.55.0.windows.4

