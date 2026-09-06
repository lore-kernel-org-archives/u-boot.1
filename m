Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F9DC79F8C
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 07:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DE5180E27;
	Sun,  6 Sep 2026 07:08:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YFGewyxN4T6; Sun,  6 Sep 2026 07:08:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 78BB980E3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788678534;
	b=CbaB56AQumWDzUTErTIw7edXDlf4BM8XRNImLaCGAJDwRDBSPrBBJxejdj+YJx5o3VfY
	 g9mjWClHQiQOwJMyQrHG4+qvkShk0y6Oo6+/dtHqZoJXsRzpmCeesdFg1MyorERYpw9bA
	 21CDYMVfnQcxTUPmDVK3w6S4+WI4mNPnC5bBz7uG5kqTZbsgDq5Tb7nXFT0PE8QX7cITV
	 DlIbJPza8+LD04asfJs9ETbGawX0WJVvFziMTW6qv6wLDUDMsSyQj0lYLX7M49cfNOl1m
	 rmlHqXzrxJqRk2apF7lalmoDvh/Ftn8UBOSIr2dSUzqzI2zI+oQF9aR+eHWdPEwNBbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788678534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pXwWY6mx9kwmCbcmrz1aj2gGVRANdmVVBrfRA+lutZI=;
	b=ZWemtIzIg23Zepu9qyLQtvnSWLXxeG5QmjcfUz8NPa/wqGuDHjLMyy3jFOR6lUnxzpnl
	 N6g3yDNOEBHI5bFdXEHZNNzVjR1yzmXBDnsEXtRhQAPUVJ6BRG4F3LEHG77TwmLrzv5AB
	 e2wBItb6mSr+mw5fgqqPeBgjvI1ARUqacRPZ64MwLmGcZokTbrVdDgJvJPK8wPYQ1VjFk
	 nlxQySXn9+nAYbF7IdCsGyVzqk5scQELXL1fvOcFhPQ4bl1qcvksPCQUISmn4/ZdGokFu
	 RXbDUVIcrSSFYSaMO42dSbA8FNqHSlUI7QyB8LHXt38raPWiMlaQK9YnAjoawSmVBGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788678534;
	bh=pXwWY6mx9kwmCbcmrz1aj2gGVRANdmVVBrfRA+lutZI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bvgMvu6ltxFGjXv9MGNeDpqsU2Ipt+yCaTQdn9fyZm5uKuCVZ71pBwx1jZPc8h+bN
	 R1fLkvp+xOMPu0bLGAzbGmvcHPBIXQLLtpSnEYcMgudAq8we9Fp3X4vqCMzwWeXeXx
	 8cyoe0uaNzAaAFY89D1N4pirqCT2tSEt0JiUzlfYKQaiIpK8lBaxZxd6v3XY5mtfSF
	 g/C6wWVqks+FLM+PSmVURtaruhSEKRkyU/pBIhhyCHN5CB0ICEDID3lXSW0bCFmbu0
	 CSMut43SHYPN2V0LuNqmKT0lBysZXjjJV5t/YaKsQ/qPjDlkkxtBBO/b6t0DuKwww2
	 JnXrNMfvQjbgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78BB980E3E;
	Sun,  6 Sep 2026 07:08:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A25FE34E
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93CB060614
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wGqzaGEiRnqk for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 04:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A778360609
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788670307;
 b=eiVmGVWlsG0VSxKn0sQ0pzYlkkpWUJ51Byw1KXrYQ9cMSlt8E0/HYq/YGerNfpeAPro1
 bPVqbLEq4BFtekwxRY/RAD3m/P8MDzADVcTkQkPqoxL9dTKnfiEwI697/UNiU9czgWXBb
 9wi+1JebRsRJX10O4efLdGomF903AyWACm3ORWW7OEEdNDKpsU72/Ox9khrml9R13lJoW
 7VxgOAtFzsQCUMREudK8ArP9OzRCXAgJJLYJ0r+DwTQ+J/4NB14RfYTEvHMeoO8ibmpvi
 9DSR78AcHNXRC7g/zBF6kObQyJJcdFWeQ7rbVL6dxxWBsqH5Jl+amaBizLxFBw8siYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788670307;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=pXwWY6mx9kwmCbcmrz1aj2gGVRANdmVVBrfRA+lutZI=;
 b=oa2JUoUICr2vUSgGWK5tHQnh5aSXuJjsEupjX/qI0RAsHGJCXI+Uy6bCj2b29zLYhxrN
 aDA2GZq/EmL/+nG6Q8rOueSfAOwJ/5fusWZHHGfjbMOGGGcacJyxpmigU55LhBYUMBSj0
 2xS4VpxYHKS4fqTbNXZGo1im+U0XaLxCFPE3OMuAEvgolTqFlXWOs0m7/dzXrqiY310Sp
 lEkj5dwyV9OLNYQ8QSSmCyGymqx9k4RMw67UsGmCOTBdJ93rzBHcGt0L5xFN0t98A+2SF
 hl9UpS4/BaCk+bwTNa8jPLbEjQ3X6hR35bgsetJxyQEX66QXsB7wQywlm2+yq+8LTyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=lemG8BL4; 
 arc=none smtp.remote-ip=220.197.31.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.3;
 helo=m16.mail.163.com; envelope-from=hppiscas@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=lemG8BL4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A778360609
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pX
 wWY6mx9kwmCbcmrz1aj2gGVRANdmVVBrfRA+lutZI=; b=lemG8BL4QwuC7OhtVW
 SBkJAMmvbOO+GVAe/ZJxOMqKjc3/1mv3qnEx33Q6pMV/JVjcatsggNZGOpCAC2WM
 Ikk8v71MxrycLPh7myD6bGn9W9GHjrKBnzeIgEbvruqA/PP44R3bYzA+mi4gh2Ef
 Kwguv+OT6JVKbL1ysp/jUZyvc=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wA3AM6v8JxqpBbeAw--.7728S2; 
 Sun, 06 Sep 2026 12:48:49 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <hppiscas@163.com>, Chris Morgan <macromorgan@hotmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] board: anbernic: Fix the RG-DS Kconfig target guard
Date: Sun,  6 Sep 2026 12:48:45 +0800
Message-ID: <20260906044845.27801-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3AM6v8JxqpBbeAw--.7728S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4fKF4kJFyrKF17ZF1xGrg_yoW8Jw4DpF
 4kZa18GF4ktas5t3yrXF97WFyYvrs5KrW3X3Wku348Arn8Aa4DZr9Ivw13KayUXrWkCF9r
 Z3yfC3WrCFWrXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8-BNUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7hMq8mqc8LOHfAAA3r
X-Mailman-Approved-At: Sun, 06 Sep 2026 07:08:42 +0000
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

The RG-DS target is named TARGET_ANBERNIC_RG_DS_RK3568, but the board
Kconfig tests the undefined TARGET_RG_DS_RK3568 symbol.  The board
specific defaults therefore never apply.

In particular, SYS_CONFIG_NAME falls back to rk3568_common instead of
selecting anbernic-rg-ds-rk3568.  This omits the board header which adds
the serial and video console settings.

Use the actual RG-DS target symbol.  Keep it distinct from the RGXX3
target as discussed during review of the original board support.

Fixes: 1998fe69f7e1 ("board: rockchip: add Anbernic RG-DS")
Link: https://lore.kernel.org/u-boot/3C0B9EB8-A40C-4EFF-9057-F4216ACE5665@rock-chips.com/
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Testing:
- Generated anbernic-rg-ds-rk3568_defconfig and verified that
  CONFIG_SYS_CONFIG_NAME selects anbernic-rg-ds-rk3568.

 board/anbernic/rg-ds_rk3568/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/anbernic/rg-ds_rk3568/Kconfig b/board/anbernic/rg-ds_rk3568/Kconfig
index 867694065..1d1043f8c 100644
--- a/board/anbernic/rg-ds_rk3568/Kconfig
+++ b/board/anbernic/rg-ds_rk3568/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_RG_DS_RK3568
+if TARGET_ANBERNIC_RG_DS_RK3568
 
 config SYS_BOARD
 	default "rg-ds_rk3568"

