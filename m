Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0828C79FB9
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 869FE60811;
	Wed,  9 Sep 2026 20:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QeotLWz3Yth1; Wed,  9 Sep 2026 20:45:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DD3326080F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986705;
	b=nd2JoRstCOPaXqvwfi1cKrkJTTz3clUYCGnTrJuuh1XtfZb84CnJs4xTHMM8oPfno+90
	 ia6xvxmqKVZGC+LRTCngnH7mSq2UL1RR8guIdaONRSCjwNal8Miug2sfm4W9C4CFIAD6I
	 +JOFL6Td/2vCUpdCm2Lu1r6N+tR1L3bvBplU5NPPC1s9ibjPxR7gTHrAMFUcT88xu3d/l
	 twZBQMhIhts4gS5lwasCX/CVgdK3F3Ag5XWegzrY+R/x87MSdQ1HH0ndtoYJnGKMKkGt9
	 4Q1eVVMYrw3lF6KIZCPDuBFDpEGKMerOLKtI8sfQhtrOVhI9m/BLJf4vyR1IVTCa7yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gwyok+C9HZJlWwC/88vrAswlZfpQZJ2Tc4nQDPXXfqM=;
	b=DMzi5BWbibjCePHAeDSMY9h6TTI0oACYD6jg+0I7umtZi3ql9xkYyxQv2/Ido+9k5Cw3
	 eyaF6e5Id6cixU2xKgfcQU4QZQcJRDF+1QHUJMIixqopoPUZHo9XYkraDJO/+AbXXar6n
	 ekOU5lnseREXAL85c5pU8eygvWRlcpoxCA5Ybili+U9JZB0eLoyhrXC+luH4m7zCcxa4V
	 /uyF81XLIDpNlTBeLOsQdnC6UikBmTsyfTKrFqgGMoKHo/giW0B0iVaRUvKPLfZ2GIVUY
	 PNGeeuvWhM7FihepoDUY3NA787qcDJeYViM1CZbld1PjU76V0qdBjG6JjhImVyOqHXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=U+fAdQ+y;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986705;
	bh=gwyok+C9HZJlWwC/88vrAswlZfpQZJ2Tc4nQDPXXfqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=loL9ysd2HhPEMeoQ7tKdONpo1qQjwu77ogu5c2Nq+IS1XRkwJ1/RJyuscNCSroC/w
	 YpgWpA3cg8kihuvGaolzQ7nRqQldlfr5MxCJhWFSdr5KySVfcc2Icv+O92Yit2pcEf
	 cHxdvnq5k6nOWaHXGvERNsd0fJ06gmZei0reP2HssHEv6dw+pQ+eI5VA25zdJjrnA6
	 5qxNYQZzio/T/+71JfgJ1c57Xjf1JWESoZXw7j0Ez8CdydQWUX2o0aPLiQqBOZSW7B
	 oJTJzqwP02kzI7AgGsnLFtnImRHyw1Q8x2vFTm998w5qEN0rc/4xMmx1HwcIBcqs6f
	 27lqcQgcekHaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD3326080F;
	Wed,  9 Sep 2026 20:45:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4599432
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9641860A4C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bmd7vLXiOd-S for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:20:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0CCD060847
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788981656;
 b=H/qJzPiYHBVAkpumhFDwf24ZItryMwtTwG81wIWXs6rUnowl1pn3kxki8p7Jw/fp5tZk
 o4R8EeDTpoLOMZ9FddxbfGkTSIMmUpyYCHtnaOnMxYejPQtwIKIm0d6V+2cjEXTRIJBZa
 aoPYjez6VMkELW7zdoPxgd4QGxWnxFcRsG9tQTFPyxpCi/PGWyl9HS+iRQYmUT00b37Va
 eIag6UNqN2XPFW5thQe0jqbMYval9j1THv5CtT0ErGGWUSXLGjGZpkpxIAqhS1iCgOMKJ
 /zXgWD9wpfS/El7gmGjagT1GCngNDL1vqjH7qIxc6NI4N6S5TxhoayZZh5VyHm6wTvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788981656;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=gwyok+C9HZJlWwC/88vrAswlZfpQZJ2Tc4nQDPXXfqM=;
 b=tDvxsl3RxtH3BZZl5QFrDE26RRixnMPStI8D1+Wgq+AjOFe1+vmb5hfPhxMeXWquSwpE
 CjJnGbhC61RC1IshnJU9a0c/mJC8NCbmRtjmWKN9H3USL0Z29SXGSBiEVXHedZ3rjsYP9
 UDMo12zwfXw8XsCf22MWGWXivWjjc2emj8P8NBxvi0qXi5ZnkuwsX0Ko7X0pPQi2h5VAb
 dcwQyXR+3zliokwYFI3zcO+f6KvxNCwTeRmhRe0CDBFRwBaxlOZ653ZHAS0BoJrvwr6gh
 I2Q/OrMm3sN3mC4EFgR9U17oKn9g2QdnraN1aMl2J07U+G5MYkwr2qq79qZ/Q2eRavQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=U+fAdQ+y; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
 header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default
 header.b=U+fAdQ+y
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CCD060847
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:54 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 36DBC20B7169;
 Wed,  9 Sep 2026 12:20:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36DBC20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788981613;
 bh=gwyok+C9HZJlWwC/88vrAswlZfpQZJ2Tc4nQDPXXfqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U+fAdQ+yols7Ouav2SW7Cj7igG+n3mnhxZ60t9RoCCUb4p5xBnmYfvc2A6qRTb0IZ
 5dIh+hYSeqMujOio222QllUajlq1Ucnm8EEiHfeY1/KpE5KlpiD8Eo5HbBmhlwznwF
 KAoQnZghjxCcgOxPj4rfVgwx1L6HGAR5SQLbbZFY=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH 2/2] board: xilinx: Make ft_board_setup() weak
Date: Wed,  9 Sep 2026 12:20:47 -0700
Message-ID: <20260909192047.217421-3-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 20:44:50 +0000
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
 board/xilinx/common/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 690991bb435..0e765cc81b4 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -695,7 +695,7 @@ int embedded_dtb_select(void)
 
 #ifdef CONFIG_OF_BOARD_SETUP
 #define MAX_RAND_SIZE 8
-int ft_board_setup(void *blob, struct bd_info *bd)
+int __weak ft_board_setup(void *blob, struct bd_info *bd)
 {
 	static const struct node_info nodes[] = {
 		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
-- 
2.49.0

