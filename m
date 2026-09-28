Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0334DCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49A9F80EB2;
	Mon, 28 Sep 2026 13:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9EeBU1t-4RUZ; Mon, 28 Sep 2026 13:42:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 75AF180CBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602923;
	b=hU0w3rQoM8b5I2nFjyZXsoCxMqYlGxg1YfDLxNypGZb85h/MMPw6lRaYZeVa+MbDDMML
	 mYXgJIhHHAim53kdHldaKHO3m2UMc5UAYmFko3FMH33TxK/GLbVmBeWJdTEwPKjYOYgnd
	 5grHUzi+W4MSe/qr4vCl6VWmI3ca8LjT6N25iQdI9beDuWXL16hJGMcvNLB6cN3hA6Qx5
	 fx79PPlCHGnbay3u5b7D3bPILpcIoh3+crrqaE1i4vaf6b7/zF2q577B4pKj1guVyO/C+
	 b1ARHllafUXIemLwhuWwKUZRTD+mGbHSHl7HwGqy1lHZ0HAI3jx5So4ZmTsXFlHjhKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s1Bj3kzor0T2/c+yDyMtuN7sYi9ZgNE8IA4ESUJwGT0=;
	b=TqkAtdKtsewnJw+KT8UY8z9mjRRR7rVtItl8MWCuzyrtomUn16l8s09+eeX9Htn9HreB
	 r/npzzbhlVIdHnuHjb1k1oM2jov/78MyJ0y4zN5omiWRj1lWH54FdW5Zt+NZ6mSZZCTWl
	 NLAoAs7q7cN37wztRjcVvvPGXSK+bS9j6Q8T+i+Qj2vI2Jr9kFCyBlM725IRYwavn0RYV
	 VhFQIsh3hbfI83vO7+zF15X9/HJu6joOAH5kmi1GVt7pXXAGqJjSFW9AiY7dEUpuxxm26
	 GykgQKkfQYRRPsQxJ5O75cPWo7nNn7HKWjMaYyNcrV25Hu98LWSFAb5NeeSrzkRabYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602923;
	bh=s1Bj3kzor0T2/c+yDyMtuN7sYi9ZgNE8IA4ESUJwGT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CemM4GfykVLSfeOoEbO0Q2s+Ande7pn/INsRogFTFbFYhoHChaWZTUvCJHli0ce3l
	 jwfkUIGegD6G1kody232ertwLeY3YMZA38guVf1//4flhyIQgHWJ97uUm6PuFXgn2D
	 WtRneCdX9znGJKQkeAdddTCngcd0FBH3PQ9RmvdSoevD/PRvoMcL3jAxXx1ds3cntK
	 Cc2x5uubu/NqBbm4IrIjguetj1+nyr9vKK0J5q4g84xquPmM+eFBW4kQ2JiJCXRAY+
	 rwwGtTIfBXEA/223A77BwblN8LRN6q2Ra5fpTk/4e1v/yiw37xlgyldg9vL+16up9p
	 tH3YXJbEYj6Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75AF180CBA;
	Mon, 28 Sep 2026 13:42:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D28B329
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33A86400E0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y9fqnnmf2i39 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 08:38:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3C9DE400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790584711;
 b=bT9XtHdx7AJtW+o3i0/0zRWAfAfYIkYziQeDhsF7GRzHkcINrnhemWTSUNwSkN+IdtuE
 qqUVSTTUxwVReJ1vUM1ZxlRD92StAkKdjiowUuaB/tS2O83csbzTmcN8O2YW58eHLpBrh
 kxFTHRi6Jjhlo1UlZ3Z+s8gL6vThLOQUHYvnbteWxTL7GChMXErawMxeJQokv3IoObkxR
 HhzH3XEuVUdcIsPpx29geN/RJwvldLHZgfVBy6tHCnoka/RdqsbQde+R0k+kQ4ERxm/4V
 VSErkCJUanp081GUlISkvpp//SwvlZpsFOOaGNszAJSJ3XqdNmx3AgepXQDBWz8e7Vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790584711;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=s1Bj3kzor0T2/c+yDyMtuN7sYi9ZgNE8IA4ESUJwGT0=;
 b=oovPLdT86uC4s2A8WAHLmkByzOYpkyZtgrwA40So1BbN2QIYDhdS1nNLE30fHB2JtKp0
 4J1Xmv3+FTH2yUL5mpRC2o6l0dN6Ku756GFS1V0PoF1pn+kKd5SFPbcreEEe34BTDbbnD
 hCofaz2cjFbOP6ISKGds9vSaKfqikX1STAWhxicMprwTJOkpJYHYhRQyZENrYo655Pd77
 6ubF/4lvH1/+J0hhQA0QesqEDmRSyqQ+1AN4Y6CAjJ2qSS7z4WUQkZDYh/mWSCTIzxY7G
 kUGqEbOXun1pHWz1M3bynIHLuGdvk3LsUQPkT9LRFQOUzpwlfN9KZn1l2gcwDyGODrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=K67+Imcx; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=K67+Imcx
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C9DE400AF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:30 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ff23af865so21010425e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790584709; x=1791189509;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s1Bj3kzor0T2/c+yDyMtuN7sYi9ZgNE8IA4ESUJwGT0=;
 b=K67+ImcxI9Dg1WQx6xD7VaAFEjr9mBKepZpdSRd1gHFED/fTVe4ev+MUpLQAja3Dh1
 6AM7iq/WUt1N0uV8K5VqE/OiuRIVb0wPWYu4LDAvKGyPBCZK3Jh8PGFICdKDcAIHnHQG
 l7EwqJBcPDfcVpVo0y0sH1FjfqT9ob73m44f4Y1Vdr2A+/3WiFG4zi3C5z1EIV1IpRNK
 ZZuQahcuCQX86IooSi4QZcW+sEGvMXFoOcqUlHNZpPjBgM29Psfv2E0mjkgZ0lKFHZdW
 3ASaV2Zgbmf8C8m3YPpsLfykt5OCpVa4ag6jkCfOCwJ6eXzWTBJhsDfDznHkXaexpYZ2
 x/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790584709; x=1791189509;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s1Bj3kzor0T2/c+yDyMtuN7sYi9ZgNE8IA4ESUJwGT0=;
 b=Ic2iBk/E+GeMhwEuUPCvQ05lTMrYK/jIFgc+dFkUT5jS3T/VqR3OW+oeA1JXsBEmvx
 D9F8A9oolRKP1no0bzBXaEyfUByAmpswJBElBv/rM76Jtf+up5rgF+OgbqCY42Gj1q8g
 GaYT2tPeiDCTWraeMwbxcA+T6duquauabJdOdo3HPL5K3Wbj+t7+Bxyfgk2hIj502jtO
 BSj3X2H6P7BcUn7N79r2N5erMk8sFQL2LtKfm0e18uCW2cipBemoOWeG4OIgZV+jX4YF
 D7V1j+Ev5WJ3LKF1/kkBkt0gWfMgKyhsZQZ1IA3CV3HXEaW2O5vgwaMyoh149QNDALKO
 GVgQ==
X-Gm-Message-State: AFuF++nL3BORmexkKBphJYfpHDoCvGw6RB+l849Y7IwXRosYodJSjuMR
 z8RMTAvpAGP/qxMKNrROJJveuMhfz5VDaGGsxIxXLzqb/kU5b3F7QBX4pq+jRNGDLP8Z/w==
X-Gm-Gg: AYBFou27ehEM2UqtV6TVdoaUeX53vnicYaWV0rnhCpo9fwYgS5geXsrr2pe2aJ5eNoZ
 ZRJlzEccepwbOLEUnxpZ0w/zgdELF7y3mGBDmVprork51iA+XQ9ldQmvM8rz/VHWxQNIgr+f8vJ
 49/xB9O1HGgkOaDWIZg/9vxoIFnNAuzhz9cW3La9XcGqH7WSfxrkx0W1teaVlbaQJrNC9eWWJAu
 OHv67gkyXu33GfB/WdDII6q29Cdsc7aXEdhDBE4yiIatxk+fr7tkVmI1fbKt3LtTrKjsWftv1rT
 hBdmvUdxMXwD3qj248qld6Dga1Oz5DjxvkiscDw45ajwoAKPw/3UTQi1gSe0LcfgyS7/0Rog6vG
 xx7Cj36Cw+a26sjtZXw8ios8bPpOFFjw3VuoRZQpd+YgCjrs5xON+QS37ISecMPfi613UtkQK8P
 GCGMPUiFjnY5QXb9/CSygmYhPkqLzB1gADxsH0LGni1BSxOcrBhPHFweav5tt03Ljxy8nzzPB1+
 Hsa/SjQZ+9viS74rMXZbVcZlVcHf0+SpKLwwYF10TEtuSD+FLklVUJDDsNrGbv0zfXOLdcS7K9V
 8wHgI3YEz5dEAo2eDKahF2/0N1gcpoKcUvu9IfQNKzfucKOeL5UnHJYjojXRACiVQDcixMhtFZh
 2z7+zKUXj6EwPOPppxJsObw==
X-Received: by 2002:a05:600c:6994:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-49fe66e6468mr197444055e9.20.1790584708408; 
 Mon, 28 Sep 2026 01:38:28 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-e9a2-82c8-47dc-7bbb.ipv6.o2.cz.
 [2a00:1028:c000:ddf:e9a2:82c8:47dc:7bbb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00179c729sm191700405e9.15.2026.09.28.01.38.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 01:38:27 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Priyanka Jain <priyanka.jain@nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>
Subject: [PATCH 2/3] powerpc: mpc85xx: Move alignment padding into
 __u_boot_list section
Date: Mon, 28 Sep 2026 10:38:19 +0200
Message-ID: <20260928083820.62352-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
References: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

The alignment of _end sits outside the last output section, so objcopy
does not put the padding into u-boot-nodtb.bin. Depending on the
toolchain and configuration, the appended device tree then starts
4 bytes before _end, while fdtdec_setup() looks for it at _end. An LTO
build of turris_1x_sdcard (with the LTO series for next) stopped with:

  No valid device tree binary found at 110f1488
  initcall_run_f(): initcall fdtdec_setup() failed

Pad inside the __u_boot_list section, the last one with content, as
commit 74f5e3ef30dd ("powerpc/mpc83xx: Move alignment padding into
__u_boot_list section") did for mpc83xx. Also drop the alignment right
before _end, which made the ASSERT on _end pass by construction.

Tested on CZ.NIC Turris 1.1.

Fixes: 87d3780ebc24 ("powerpc: Update linker scripts to ensure appended device tree is aligned")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Behún <kabel@kernel.org>
---
Tested from NOR on main together with "mtd: rawnand: fsl_elbc: Select
NAND_ECC_BCH" from the LTO series for next, without which U-Boot stops
at the NAND probe, and from NOR and SD card on next with the LTO series.
---
 arch/powerpc/cpu/mpc85xx/u-boot.lds | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc85xx/u-boot.lds b/arch/powerpc/cpu/mpc85xx/u-boot.lds
index 3c9959bef09..bedd2d47472 100644
--- a/arch/powerpc/cpu/mpc85xx/u-boot.lds
+++ b/arch/powerpc/cpu/mpc85xx/u-boot.lds
@@ -67,6 +67,7 @@ SECTIONS
   . = ALIGN(4);
   __u_boot_list : {
 	KEEP(*(SORT(__u_boot_list*)));
+	. = ALIGN(8);
   }
 
   . = .;
@@ -78,7 +79,6 @@ SECTIONS
   __init_begin = .;
   .text.init : { *(.text.init) }
   .data.init : { *(.data.init) }
-  . = ALIGN(8);
   __init_end = .;
   _end = .;
 
-- 
2.54.0 (Apple Git-157)

