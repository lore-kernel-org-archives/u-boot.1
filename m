Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C750C982D0
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 08:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DDC660658;
	Sun, 20 Sep 2026 08:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6s2Tw1ZLnPwf; Sun, 20 Sep 2026 08:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C89F60638
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789891955;
	b=AErm5QQA/8td+h4gMr40UK3pXYrWRZVAp5upknuYaOO31kwvV/M08XV7RwOPT1689zL+
	 EEIN5VlPl53cIRMHWg1OeDyAQdUI233DNujLABzo5iv/oJJRrh4MC5D9qAxSp3m8Vjr4M
	 axzGdUVXfJhCSkO42QdzWGYZL97gDiEGBLhNVv6boDlUCDyoU3J8SH0AaHV0KOAZjfVRW
	 ROm34Tdysz1CmuFMBaKKq6e8hwKrmaWXdnBEbrZ5lycJB/b6ymXyJef8yiQ/3SFafj6Xk
	 iBipVpf1PLHzntJ1xRru1yIJYmLrvvL0HUfkLIKEZkv9Wq8o4c+ZcpAHpUX1/Js89Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789891955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XDbziDXp1cSVsMR12kqyrjjprB/TYua5F8jIygNl9Z4=;
	b=kDN0BeX4CYmJg7I9nQg8fwQSJDlwi4tTtj5VqonVLg5gr7MggnZAsxG6V+BRLREwhMsg
	 QELLkvcXUv5D0tsFHtl3jqjFTIRsnDpWJsjCZCsxJOLokWLpM/99pa1Y+Bhta0ZJehJtl
	 veoOa9BNGIljFTkg4iwrQDDLdljTlkRMcylf4Hyhg1KQCsMWvN41IwiYxM17/WqwMbKrQ
	 flHk6vY1b2N6rNz+EPj0ZoDz89Ugr3SUqS/vr72vhFeXyBsRezlvn/QSP1rLcEUqgD9Yq
	 3FXqTCz9cxOrOqZQhD0oS2IrDe7nnLHz75CsSeSB7PsQNlVztyG0QFIltBKdH6QDOZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789891955;
	bh=XDbziDXp1cSVsMR12kqyrjjprB/TYua5F8jIygNl9Z4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X05GykfDltqLeocEl1Q5KdYA+Kz4CPr10G1bnbUT9rmKH9j4l9gP5Wl9DetG3zOph
	 /dqNAo2TW+liu50Hjj8vYAnpzG8RToeclq7qbUZ06WyXOhFBJ3W7XkH1z+auPkWJKd
	 RzoVn/ij/16ttpPU8T5RCwP0zKV9s/GzbmaF4Frye66bWPUhcqZSOCMq9U404YPTh3
	 IgOi8xj4h1mv6c8L6BCshavih0HijZd+3bg4c1r9DfTcGzwlfg7zOoF1RqA7klRnXQ
	 bBnLaWLqVlRUHZtsrvRvAhxJMgC9+mnMPrRSS15eHf38nLdvXgNl9cs/et4l7xiU5u
	 L0ZyXgeYDb2rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C89F60638;
	Sun, 20 Sep 2026 08:12:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 946DE12C
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 08:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A3AB80F76
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 08:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLQTwWAO_Yn0 for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 08:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 715C480F5D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789891952;
 b=MitBDUeC+4JQ0+3dZrp7B/cKios5oAP3VgNDzdQIElH9/Eqv8JmFetYq7Bp/JUTAUQYa
 V3tGmqooLCsr0wiKdDdiW8oR918g1utyk36ZrBgvS20wgwKgkyAE4XiBiZG23xvGYtbXZ
 rKhoILhe0ROyAjyLW/KsHhLl/wwuazhv2cjZtOnXVSapj/lxfsIJF8WH8i02tv3hjeF38
 4lEg9QvfzfiLtzO3OFUR8WifIeQO8M41g10kERvgS1GIvpkUVrG36Agd8IfH9+dz4HC9z
 c8T5CuNk+hGh2Dov7bKCyPyPiY1Cp6LYsm3chK2njtuWJwugu59iYLzaZ25FauvgOJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789891952;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=XDbziDXp1cSVsMR12kqyrjjprB/TYua5F8jIygNl9Z4=;
 b=TUlOg+msGWMllftsiw/kpYqemCELVSXfJN/kkYL4e4ro+SQ3D0TBfsi67pJ704C9ZHwT
 xCNgXjQt+olRRLinMHsy4skXdtduGQXwoqozD6h64LyQt4JjS0DIkOt8WwL+yphzewGJq
 2iMp4hl/ewy2KgxoZQTElVCIv/vFssuGjMMjK7Kj+dz3ixPYRknZGMkTZ+vmd39uQwljX
 ghB4JTXcQPJQjVHnXGDu3ZBuyZrLHV/xr45idDGgcNmysyePPLz727PZXoWSdf70q9ISh
 0cS7l9hGkb5qtHdGaFum+Ib8GxGhgLoER3DFrvLVCw4B/VEduQnmHZmVz8PADbLfZkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=c9ildn8u; 
 arc=none smtp.remote-ip=117.135.210.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.3;
 helo=m16.mail.163.com; envelope-from=qianqiang.liu@163.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=c9ildn8u
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 715C480F5D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 08:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=XD
 bziDXp1cSVsMR12kqyrjjprB/TYua5F8jIygNl9Z4=; b=c9ildn8uzrQXnBlbMS
 kbZH+t5iHAupV+9KRJ6barbc5qf1BvF42S9ueQkLea40Mqy4hwTPYqkP6D8yraO8
 Y+RT9MwUa8HNXEqTeBiHFRy4rSA8oZvMng+lSix8HJ3BUQQSMaI1BbbDRBAGtHkr
 EpWmNA+ZDVx4aRhDn5ZPzc6Mg=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wCHNn88la9qxe3jBg--.61151S2; 
 Sun, 20 Sep 2026 16:11:41 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: michael@amarulasolutions.com
Cc: dregan@broadcom.com, trini@konsulko.com, u-boot@lists.u-boot-project.org,
 Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] cmd: nand: add .part suffix to dump command and refactor
 parsing
Date: Sun, 20 Sep 2026 16:10:19 +0800
Message-ID: <20260920081019.87962-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHNn88la9qxe3jBg--.61151S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1UAw1xWrW3GF45Cry5XFb_yoW5Jry7p3
 93ua45tw4DGF1xZayak3WDZrs5JrZ2qr93Jr9Fq348AFn5tr1kXF18KFWSka4UWrW7Za45
 ZFs8Wa43Cw4DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinqXkUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/xtbC7x36ZWqvlT2O3QAA3T
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

Currently, the 'nand dump' command requires a raw hex offset. When
inspecting partition headers or magic numbers, users must manually
look up the physical offset via 'mtdparts' first. Furthermore, the
command's suffix parsing (.oob, .ecc) relies on exhaustive strcmp()
permutations, which is fragile and scales poorly when adding new flags.

This patch introduces the '.part' suffix (e.g., 'nand dump.part <part>'),
leveraging mtd_arg_off_size() to resolve the partition name to its
physical offset to dump its first page.

Additionally, the suffix parsing is refactored to use strstr(). This
cleanly eliminates the hardcoded strcmp() combinations and inherently
supports arbitrary ordering of suffixes (e.g., 'dump.part.oob',
'dump.ecc.part').

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 cmd/nand.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index b5678b0a008..051a14d7317 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -700,18 +700,24 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	if (strncmp(cmd, "dump", 4) == 0) {
-		int only_oob, ecc;
+		int only_oob, ecc, part;
 
 		if (argc < 3)
 			goto usage;
 
-		only_oob = !strcmp(&cmd[4], ".oob") || !strcmp(&cmd[4], ".ecc.oob") ||
-			!strcmp(&cmd[4], ".oob.ecc");
+		only_oob = (strstr(cmd, ".oob") != NULL);
+		ecc = (strstr(cmd, ".ecc") != NULL);
+		part = (strstr(cmd, ".part") != NULL);
 
-		ecc = !strcmp(&cmd[4], ".ecc") || !strcmp(&cmd[4], ".ecc.oob") ||
-			!strcmp(&cmd[4], ".oob.ecc");
+		if (part) {
+			if (mtd_arg_off_size(argc - 2, argv + 2, &dev, &off, &size,
+					     &maxsize, MTD_DEV_TYPE_NAND,
+					     mtd->size) != 0)
+				return 1;
+		} else {
+			off = (int)hextoul(argv[2], NULL);
+		}
 
-		off = (int)hextoul(argv[2], NULL);
 		ret = nand_dump(mtd, off, only_oob, ecc, repeat);
 
 		return ret == 0 ? 1 : 0;
@@ -1042,7 +1048,7 @@ U_BOOT_LONGHELP(nand,
 	"nand erase.part [clean] partition - erase entire mtd partition'\n"
 	"nand erase.chip [clean] - erase entire chip'\n"
 	"nand bad - show bad blocks\n"
-	"nand dump[.oob][.ecc] off - dump raw (default) or ecc corrected page at offset\n"
+	"nand dump[.oob][.ecc][.part] off|partition - dump raw (default) or ecc corrected page at offset or partition\n"
 #ifdef CONFIG_CMD_NAND_WATCH
 	"nand watch <off> <size> - check an area for bitflips\n"
 	"nand watch.part <part> - check a partition for bitflips\n"
-- 
2.55.0

