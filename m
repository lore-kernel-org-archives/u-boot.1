Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8B7C88E7F
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 17:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35BAB60821;
	Wed, 16 Sep 2026 17:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbtMfmjb78_r; Wed, 16 Sep 2026 17:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2CD8360837
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789580183;
	b=IvsuQaPw2RgW1RMb2ADzwe0uxO4lI4MNJk0aBZDWp1FVwNgIFaNrpn+QkoykBfVVnO+s
	 WUVUNlppaUbPYnOIMlUOud0e8BnvUVbSnpG1GwEBQ12/DIki7taJQa5AZLugs5mvbAPrL
	 /CIo6mUIt5dyjBt7c6G+H+fi4pFEoeqQKbFGtEatH/0O5h4zyiwhWIqbh12jbKi5/d+N9
	 fJZUKMHnBnH2p7g2Ycex0YjtGbI30zvqKwBWcVOz4ilNvwggrCY1EUwTXzlx2bqRa+5t6
	 L40bfoCzRU5ITlrH04bPjrHZ9bR9xJBlpgsd6X9Ni6sQV0JvDZsj/ET0IMuVEChA4eQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789580183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9vkwSeVSufcI+s0qRqZPu5alGDbJBAOJs6jZDhb0B1k=;
	b=SWS9xMeVaGATApS7hPnIPx/8XjNyvFEJdCUIZcQrbfyBnUGHooblpBqg/3L++DFBtLj1
	 bJBVOd710Khv5SJjhiXvug0po2ucxg7/JKfRzo7JCG1dXweV1mWHz6nUUQUDXHBj2b7u7
	 0dUFBlLOynApGZA+a9pQyBPbINj3c9AhZzp2yd87DmCmsO6ShnE8kPPuJECJblpPVV03O
	 trTH3gjPPTama0UJH/hTLjIEHLl5P9OfvIg3dLCPjKNHTnqMTiprBAyR1SQR5gXFYfQoa
	 dz9BV4MTRNA8WDnvuciLYtPCMJdiy+BpZPRR5SJnRMtvy7AKoPA9LV9rg+aKRxXEjOA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789580183;
	bh=9vkwSeVSufcI+s0qRqZPu5alGDbJBAOJs6jZDhb0B1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W8aBJ4Cz2mzWzTqbjRF2pFfbUYUrAF9moxBf10MYXzWdrs53Dl4ILkS7CSAJYYrEA
	 l16jc7gJR7ctocorINFSoV3f9fvvNQ1R+MZaD92rlcbJCVknYs7TPuHO64ZvG38M4a
	 ZHg1scnMR5/X4ff4uHabJ27otnFBsO9NyCd2Zhy01OMfo/aP3nt6nFoPym+Xn0EsTH
	 8jS8+NKrhOklvxE3pZhMn0P0KKlpKLDJ7JWDAbwJHzgJFr5M0Ozuk0KhsvoZSXzNxi
	 xE2j+KB2a4QlR/BdJ4ZNDKYojwt2ME3F+vLWIYgSM1wwAmqrccVKRyLim4QwifDdnX
	 gYblOitpVcQXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CD8360837;
	Wed, 16 Sep 2026 17:36:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B91D67AD
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F03080DCF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VsK9E8nboTuM for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 17:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E084780970
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789580179;
 b=fpSsjrzf4kSMNX3WlAE8Pu9JDqGFmXKoksIszTIXRdXjijPZkB/p6aYaotwnAeN0PnQe
 XCM0e63JNmfmscYaK7oHS6KjEkTDjq8y3oO9EXiAhgzaLGEWZ81gyLWkP+g8FBtEqpeH6
 Be3K+qz5eD2peuGAniee0+HE/tDfP25CVATkwxlsKu2artngFZfTE4cykmZSgx/z0sxRl
 tVgZpV8VIdQUKx1M6sqGpFWTsutxg0W8Yu/JgtxR/OaQ23tF5TI4HVmR/8vRHcDQ0Ip8p
 XIustykHb4xil/XUJcS6eJl0JPQ8MPIIuBlDHonzTPXOj9ljQD1lcvUOLDydf6A+1Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789580179;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=9vkwSeVSufcI+s0qRqZPu5alGDbJBAOJs6jZDhb0B1k=;
 b=jnurDq3zyjuPEtuBZxNzwFdD1LH+9qeG/Qh59rYL90NvLe8ZDnh3f63osbhk4h5J77j/
 ZTogJseGlGVhtOcAh1SE85U9xDT/ZffQHCueBGG6FR71jIzBHuyBKBCHh4kD/JPzX3OH6
 ptEzenmbKSbxlTp0DXQmUbwcqoWWmLoGcMVDRG6tEkDiGu8Bg7IMqbeeplmz2L0+Y7uBE
 /DlrDNIL/EFeUxKUzggeOczJQO2UQu9QI1z6tGZYwiSy9sRjq3H6F7cWPGhOsy7xGfW4X
 ULYwQ1FDV/gYBcN7soRXtMBc9M21b0wEgUQdmA0JHnaXp5sEaAHU7UIsjU3AAbIWZSw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=s7DxC8pF; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=s7DxC8pF
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp1.osuosl.org (Postfix) with ESMTP id E084780970
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:18 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0252B20B716D;
 Wed, 16 Sep 2026 10:35:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0252B20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789580133;
 bh=9vkwSeVSufcI+s0qRqZPu5alGDbJBAOJs6jZDhb0B1k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s7DxC8pFrRClOeihOqIa7DWlwRSCH+hVP9652jlFi+Ldk+2NPmzIZ6/x7sh5lZmBa
 9A1++81qqM3AlzIXQkGq8qi0zzhNXW/kop/a80BF38u6I4hCWLgoABhr3nxYCbGhQf
 GwzFu1v//AxEG/xMT9Pv0HPsdVLBCugFGxq6rEm0=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Maarten Brock <Maarten.Brock@sttls.nl>, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH v2 2/2] board: xilinx: Make ft_board_setup() weak
Date: Wed, 16 Sep 2026 10:36:11 -0700
Message-ID: <20260916173611.29425-3-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260916173611.29425-1-sriramsriram@linux.microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260916173611.29425-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

board/xilinx/common/board.c is linked into every board that uses the
xilinx vendor common library, so the strong ft_board_setup() defined
here prevents an individual board from applying its own device tree
fixups: adding ft_board_setup() to the board file fails to link with
"multiple definition of ft_board_setup".

Mark it __weak, which is the mechanism this file already uses for its
other board hooks - board_name_decode(), board_detection(),
soc_detection() and board_rng_seed(). No other weak definition of
ft_board_setup() exists in the tree, so boards without an override keep
linking this implementation and symbol resolution stays unambiguous.

Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
---

Changes in v2:
- No change.

 board/xilinx/common/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 9ea5f46c9a8..497bbe09bc8 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -694,7 +694,7 @@ int embedded_dtb_select(void)
 
 #ifdef CONFIG_OF_BOARD_SETUP
 #define MAX_RAND_SIZE 8
-int ft_board_setup(void *blob, struct bd_info *bd)
+int __weak ft_board_setup(void *blob, struct bd_info *bd)
 {
 	static const struct node_info nodes[] = {
 		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
-- 
2.49.0

