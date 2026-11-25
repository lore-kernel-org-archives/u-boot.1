Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4A606A33A
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KmxLrr72;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W2suBrW3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9504F608B5;
	Wed, 25 Nov 2026 13:18:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wI1eMh-fNj2u; Wed, 25 Nov 2026 13:18:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B56CB6088F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795612700;
	b=WHUCOUG1iRO2yqTcOE6GOw92BuSYTOjgcGnzk9Lo/F46W+MpLOk3xI9xEHVAQyFBmxIb
	 WeiAbrUWlb6WRPE2njIWnyJzAntB1HZjdXPlI2/iREUNYqlgCbLRTUm2zqI3GYBg5kuWG
	 xuwldJiPHBxZP/lil9kXI6xD6eByK83e/aQWsUqYQB4mwkbtVOXjVIQT6Fzmvv7Bn0Ckr
	 dQJubHR1wL2Rqk/s92AXcMBJNdl2echwGclhNJSKeo6FljAc6Cmn+3Y4K3Aj5+BAcTAN6
	 +qwmW9WlC4VDdpfrEt2C4iht/AkYgnONFIK04klpAC8yym7xRM3viWan01fpxAhzMtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795612700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ex/4z9cgJ2gxu/YT4JGrE7UNbfKFnxAi0fmwp+3hJyk=;
	b=mndXVewzgrhS7ZTwK4Pyv5vBqwYxFaTd/9XhZ8O+d/XpkvE+yMGzRmLVuvjGmdcxtBIJ
	 EFLYVtL5g7YqWGBCbj0LS1YOZInBdUFb10DTrjmeaCVoA03g1i+DkMduNmuNpHQuEjZ5z
	 +FbIsnrjYq1ASXHAioWPvnlkc/KUZmRIhf1g/HtrV95tEfcr3mw5MSy4S0/TfsHIk08Fo
	 g1uyJz+WThEZ2ckKATYXw11AjS/Z50yuLugfmq0qOx2aZS15sk++fs0XyOLUTVvLWR+Ux
	 AU9Qa9mEYwH48fCcmyAWlSY3RUn3AkSXLy0BgEKVnxCe6IiGmTaRfVey5IZVMagMTXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795612700;
	bh=ex/4z9cgJ2gxu/YT4JGrE7UNbfKFnxAi0fmwp+3hJyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KmxLrr727I1DmuWj9+M2LSoQeJw3LiChRZ/pCY+4+ZPHAzJb6AkwT3oD8Yi8L0b6Y
	 BYBrZsM0iJypgV/CGVcn9kl/pXaQJ6cM+cXKjscDUBgEu6LzNEWkrHojPuP0SLOAnO
	 Yt8WHZ80iJkEExzaJGuOIjnvY395XELjy3hYcP4qFdOpMesiDkXw/wrShlNOlwAa/+
	 p37YsDg7unHqa+Yuid7Xd1MKt/DDPlcMwTPooT4BG6v8AKHzYwWT4qSRb0vf43T7lp
	 hRb3YmspQCZpSKaWl6FnmuXw9/+gd2cpinbbXOplqMk6w8iMcp1O06lbhgS9lzunZC
	 qyYvOT/ZmfNKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B56CB6088F;
	Wed, 25 Nov 2026 13:18:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F34B371
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 609A880B08
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9_63GifqcdZt for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:23:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DFD780AED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=ssunkkan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=W2suBrW3
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DFD780AED
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:23:28 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cde84cb8803so1397213a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605807; x=1796210607;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ex/4z9cgJ2gxu/YT4JGrE7UNbfKFnxAi0fmwp+3hJyk=;
 b=W2suBrW3Io3H6/k58gICUig0tp60RdIFg4TWgEmSPzijj8PrlWAtcVsWapVaji2Tc1
 +1Q48ZeTo9/XfS9P4K4izWYBI0Kfon4jG17i6mk8yYD00di0Xzf5Jq71nOTKD60U7uQo
 OzgZmwKaY4S4coZY2/iYh6ebdjwN+bZ5qrtbhd4T1fKUTI+DJ3Z6Smb9l1OanSbzpkAu
 CFKdaaa+Ggwzam6zYLkFmiSznB2LnjYwJwIWhdkcWWEMrg5it7wBEnLfFAB6OXkX7kwx
 SYwR6nKZ4lc5kbqzYu5p0VZOPhq6dMLP1WfMJrQQLUSuCpZcnlfviWo3h0HtFz1cjyuq
 1N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605807; x=1796210607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ex/4z9cgJ2gxu/YT4JGrE7UNbfKFnxAi0fmwp+3hJyk=;
 b=cWNHBgmid9FqKXKk1GeMuwFdayuCw+vksLDFNdY6eklaqLhqTr6NrAGZRgv4oi2iL1
 kZ+HVhhwDUwF7MH7NcFzFt+EdBfnnqmiIfirJohLhZ0Fbtx9xiFwyjSPT1Vp/doAKUqB
 vNojDmMvWeSdOPFaaAGtSlfjwrZ/dq624YXBHEK4WOMG8xf8SHikgA1nZYCflvMgf9we
 cfBo5YQDkyQgq1FpjEQ/Qlsne0tH+RunB1TGXsLfKuIVmu+MWJjPMHFELkpDSokWMSfX
 Lz/fUeUxzYvuFx6asjX/wgxFBoKRjC1IAbnAjupQEyzE/PnDxyfUGsBvgb0URTw/vNhS
 QkUw==
X-Gm-Message-State: APuU4Z9KFL2FzvQp2+5vbanacub71Q8faFR+9YGjwngC/HXX1w0Kb6v8
 Sk8bX3B1JJY18VH+SPWxodKrLJgOs9z0q64+p04E3qO6+CdtM7eDzJ0PeWIDCtGn
X-Gm-Gg: AZFdTZde3ylxekygu4PZmRRkhI2mEMH8x/WtwV2j+Fskd9wIQKi1KA8wBzhuZpJsTFD
 UtW/QqqZl9qNODC0YotmQEAR/CgwQxkXp6ilqNmubo5xYEzuYc9fVimgFnstk+CCsIXrDdwqE02
 CuK7RMDlQSB72VrgYMa8dvxENWDnYe2PEUN/t8HWJXELb+Fjk5R78L5msKmzON92WeA0K0QLh1K
 x5cWwEs/XGWl+G9wuXSHhf3Wt8G/FvWovfPXMwzRJV8pYaT193zDOb+wQu1JDPgKvicmIZO537b
 +0OV7b39bn+t+R5rwo2Gl0RX4FNiMqtsRYq+5ZodKkCCDLie8jqvp5RtJjNTAv8jcaIUq34KVZm
 07vwhtY132lq6skxA5agjwh+OG8svsLj+sOP5co4VO+V6Qu27lbztu0pJR/5rI19IUaU58e+ybT
 RbdyE55Ha0AiaIK3H15WeNNxAkUMZP+tGhRH3bzxBgcLxGjJKYcYhW0qJh3KGKU+4rtZbHZiD6t
 wKg9xaEpRNLm9eH5Md1WjqFRXOdsb86Ac6GZjIGKen0/QtuFbxSeF+YjyUD9VJ8XV05f67kcINT
 n0ZX1+TLMh+GdjWf2Qh5z5E=
X-Received: by 2002:a17:90a:dfc6:b0:3b4:e929:f46a with SMTP id
 98e67ed59e1d1-3b4e929f529mr3450483a91.25.1795605807494; 
 Wed, 25 Nov 2026 03:23:27 -0800 (PST)
Received: from Sun ([240e:3a2:dcf:f2e0:899d:6e37:7d6d:4dce])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b704cfesm10135893a91.1.2026.11.25.03.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:23:27 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: vigneshr@ti.com, takahiro.kuwano@infineon.com, trini@konsulko.com,
 Jacky_guo@xmcwh.com, hs@nabladev.com, Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v3] mtd: spi-nor: Add support for XMC XM25QU01D
Date: Wed, 25 Nov 2026 19:23:20 +0800
Message-ID: <20261125112320.1912-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.4
In-Reply-To: <20261124114629.369-1-ssunkkan@gmail.com>
References: <20261124114629.369-1-ssunkkan@gmail.com>
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

Add support for XMC XM25QU01D SPI NOR flash.

Link: https://www.xmcwh.com/uploads/974/XM25QU01D_Ver1.0.pdf
Signed-off-by: Ssunk <ssunkkan@gmail.com>
Reviewed-by: Heiko Schocher <hs@nabladev.com>
---

Notes (patch-v3):
    Changes in v3:
    - Rebase onto the next branch.
    - Move the flash entry to xmc.c following the SPI NOR
      manufacturer driver refactoring.
    - Update the patch subject accordingly.
    
    Changes in v2:
    - Use the Link: tag instead of Datasheet:.
    - Add Reviewed-by from Heiko Schocher.
    
    Quad mode, including 4-byte Quad Page Program (34h), has been
    tested successfully on hardware. The updated datasheet provided
    by XMC confirms support for command 34h and will be made
    available on their website in a future update.

 drivers/mtd/spi/xmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/xmc.c b/drivers/mtd/spi/xmc.c
index dbf11a4c5d3..e060a533112 100644
--- a/drivers/mtd/spi/xmc.c
+++ b/drivers/mtd/spi/xmc.c
@@ -19,6 +19,7 @@ static const struct flash_info xmc_nor_parts[] = {
 	{ INFO("XM25QH512D", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU01D", 0x204121, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 };
 
 const struct spi_nor_manufacturer spi_nor_xmc = {
-- 
2.55.0.windows.4

