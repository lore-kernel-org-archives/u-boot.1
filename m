Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F23CA5FE6
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 20:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6E2A606C2;
	Sat,  3 Oct 2026 20:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eoYK5hu-A9Cv; Sat,  3 Oct 2026 20:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CC88E606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791058102;
	b=V4fxo3wMgmWZQA0SQWHbnOdegvKX74GKd+c2Kv9Mb5eVwjaKsIYXaNTjqM7hPwuXyVac
	 3VOTdj6mnEQJjJ/B7V5QaDR3KVsrp4l8RZ/S+0owl+RbJUkecbu6gW7rL2kM3VEHwktYR
	 MfU9r9frUPCYXbb5ET4lgvcW3cOM/6AuWzX28bmZ7QIqcFYh95k/s+6L5/Y7BPjpTeiD0
	 dnJHAUa3PgCTTeGl/Xeks5+hBbK7oL8vVHoaj+cpRvqnnXMPOXwpfeiinqpWQum65aXS/
	 yQN529ErCGcvRTEuiGzjh1HGVxV1Fh0n60wijfsPYbqMapXo5PEVL0/xMM9ReF/XPrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791058102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=090g8TqcHP3mxdn6BrDK+Wd2gdWzPXij6WUqZtM2AZU=;
	b=attYyz3r+HN+RHahOFutzjrJlSsOG0zYvZnM9guQqpE+XCHmgIRQ5zm6QMfm7lAfcmGl
	 dtLMq+wAxFNFFxwwooAqhB1V2P+TFYRQJA1kJwVzWhdCx7cEpc3BNa5pr28G8UtdhbfQW
	 VRHrwojIQ4C7J3vJl+OQY7zqhLrk1zP3AdhGx8CQV/XOAybcXFMOhYMoxz7zIAMf3z+Qt
	 7UVIE+84kQ8oXdFlEVtMW/L5naLXmw/5uyfDAcLLEwHK+Q2bkLTVr1fkFKFjx7A0Us+IF
	 TQiQPWZJ09o9LmHnbwPeU7rRdUDfbS2qgK4CCv2V2ixGcS9zwmRyYMkYI6/6a5adwFQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791058101;
	bh=090g8TqcHP3mxdn6BrDK+Wd2gdWzPXij6WUqZtM2AZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RDwmHOK8VdgE92eQccWdsF9ridOzhaTTKUHas/f4duxMZPUslsImpzTfgneo0UuQW
	 JZCIqx41pr8JeUsMz6LalTdZBwgSKzA1b0r9CAOFqc94+mSe0g29WkKq2dZgcLMNQH
	 mu6YN5vlpmAxe2U3akxIAFKBMWkiXj/KuEZYdU9n/iVQ2/0vjNxNIq8drfAqV2ZQQ3
	 T2KFheCzVx6kPUztYIPbGNp0X5LjzLGZ5dxQaNnDgLzwrGqPxDfu2evaIw11vHdkxS
	 vwctcYN0H7cWFJiwf2m0/ORedldKHrX7A6iLqXSgXruf+cfvhjOpa3rlny45w1woMv
	 vLg10Ghf7pqrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC88E606B0;
	Sat,  3 Oct 2026 20:08:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 21F41282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07D4A4007E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KkFSg7Cb3hg2 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 20:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0838B40064
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791058092;
 b=NxdWzkYoGrX5wcARpZ3zsH5fy1XoerUhmCIaCDD5lXc7PW55FkutIT/PU/2rPL6l8BNx
 FBw0aAgdsAvxXWXUy+9gamWqCnQXWjzRvL2GlFm8PiRcjrikWSBKQPfH0r/ACgjo+MOGC
 OePOEzum7BDzfklv5uCwFusr0NFBpAeOlRvuoEfBnKMy6r1Q2sqG5lhtzjlvwNkPx6FtE
 Ce/VK752Q9SyHxe4XVyhmS88x4Q20un5EW1icsdhvLUFhTu9+qd8urFKrifTjmqWS0Y7h
 UUEQMfVWuds3E7cIE4c7a2Rx4nzojteTugL6NIYbVfUy3vDkQn7yHwZqMJkC00yvrZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791058092;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=090g8TqcHP3mxdn6BrDK+Wd2gdWzPXij6WUqZtM2AZU=;
 b=N2rwpd/Kb798sySPv1Us3GPqBTtJVPkCO65isdRYCDIP5BN0k0UtvhgV4fJjKIX2ipuS
 ZzEQaJeP6SK8Bk1nMm0BZb6kftK1PwJj0TvT39yG5QWqACdUt0XWP42/GBtYqD7gbf8dT
 mlegQF915VwU9lh2xGqAt9gezPfogA4KkZWAE0XlITDN+/W38atX9g+BYSpkGX7r9yVnl
 CXMdneQlwlGgtT1vWEkk53SOawpQiBX8qdT0qoyr3JaJbKqldPSYo6DsRdQGS7nZ1xpEX
 MTC43ib7tD5j8euvmvn47pNHS8RtVVxItFTqDYkb1KQrxhY4VNsAy6gul5IGnk373Rw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.tenstorrent.com; 
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b="YRRP/HrO"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::e;
 helo=mail-yx2-x0e.google.com; envelope-from=asrinivasan@tenstorrent.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=YRRP/HrO
Received: from mail-yx2-x0e.google.com (mail-yx2-x0e.google.com
 [IPv6:2607:f8b0:4864:41::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0838B40064
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:11 +0000 (UTC)
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-6729ca45e37so406707d50.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791058090; x=1791662890;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=090g8TqcHP3mxdn6BrDK+Wd2gdWzPXij6WUqZtM2AZU=;
 b=YRRP/HrOTcjXs9VkrE3ZHXSiLx5dW5rGL+rRWQW+V1vZUUpNbGYCN1mz+2U+KE3DiP
 CPcXFMNiGFn8hBjXf0cheUusQBAJv8FxNXI5TLAogqZa8ftaVz8gkV8RlC7NKE9lyxXq
 ZaCAb84jHcg484Q/LoWmvb32iCNKg60RMURTGP7TGqqjxCp6EMj9WQDHCD+4kztX+yJM
 ry3hpGItRYadjTxtqITSedCsm7OFlm+ZPZ9xIAWqdQtnVyqddOVxbe53oAPAJrcIkHs/
 hr306j6v1GI8A3fLKh5b6yOP5WIJlB8r5u6WflFsM5v9Un9wI7Iv3+U/7lxgJycswlcq
 nQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791058090; x=1791662890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=090g8TqcHP3mxdn6BrDK+Wd2gdWzPXij6WUqZtM2AZU=;
 b=qzOeQZwDkRForw8PnSV687w3SEzFPb+s8PmS+z1+bNZOIreqH6vGJsrOfL7uOQmgOp
 cPB5ZGVHzeN4JHItWCBBiCDnvO3EHZtY7e8bFKKRbWUlSvZ2zsAAk+rR34VOXZzJwhdZ
 34g6GjGWqpB++46HBN2kBdK8QyFaTtw8JYMakz/qQk2Kv7THNXk3c3GkAdd216tIsjAY
 ehFpX1jJL5pdPPUqifiXXxWGNEN+15gYyuz0TIuT+QunvOPSkLj1IZHPkf+w99Irphdk
 Z1GcrSae/L88LUshkXLXjXNNmQZJmbi2N9BresfWoFhmTjpBSW4yP2ppaZyAihHA9cD8
 +b5A==
X-Gm-Message-State: AFq9FYKW/Q7+MxWNo6/Kwzb1q3W13j6zztXg0KUHHZNEyZM0PibGNtfQ
 RupR8B+rJC0+fXodXZs3l6ja00P5SbOgDk3likBVMuR4O/6KEnQTu5fx0zn0MQXZVKU=
X-Gm-Gg: AYBFou04dIvnnUY7AfKLzea05s0C4JwM7dcfqIUERCok9FMd7XH49nVw7ty8nNE6NFX
 A56d6z4hP+tinTm64V3nARp9Y4dYAfaEoRvf37jqcMhwClHXPOvBgSzjyWfbueYO7h6R8LTqHxf
 YHOa9N59XPrXWIOHjxm5GmP8RsxSWJcCgx6i4jzcP6u7YmeIt2UzNK7kYaZYdTY/7tLWVxzhIYe
 ZIxl5bINtuUMVQMETC6NgdAjchJ7LVwz0B3GfUtkxItK95vMayLAuVvhejII6BsQmEOneMZ7HHd
 15xBkyT9yPhjTplZMw5TveNqXhdimCBXN6W9Zy3cO9m8eyt2whUNnXKKgZZP9QUySL2n6q0Q1o7
 Sw56I6YS/dt1lcCIhpbC9bpsZ7c5SY0O9cHnUWbdR3yjqYbsmf6ee4/vMYLFmDLrG7YaRp+ZnZn
 Mt1hxKCuFfAMLIGoYqPWcEx4H2LwHDbxIyoepffvlMHWcZ+hfcgQ7WeOLql0fOCpW69MeqZ970h
 xd8N+7DlWSSxykDwrMT1P42Smp33BG/B5j7FFVMOVczXPU3AEViCAbfSiQBEzBr
X-Received: by 2002:a05:690e:1c08:b0:66f:c1bc:408f with SMTP id
 956f58d0204a3-677ac0a7950mr2690708d50.82.1791058090451; 
 Sat, 03 Oct 2026 13:08:10 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:e2e9:9d9a:5aeb:a046])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-677c16c243esm986048d50.0.2026.10.03.13.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 13:08:10 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 03 Oct 2026 15:07:59 -0500
Subject: [PATCH v2 5/5] bios_emulator: extend VGA I/O ports to include
 ports 0x3B4-0x3DA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-aspeed_vbios_fixes-v2-5-f8e593f024ab@oss.tenstorrent.com>
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
In-Reply-To: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

The IS_VGA_PORT macro currently doesn't cover the 0x3B4, 0x3B5 and 0x3BA
I/O ports. Reads/writes to this currently fall through to LOG_inpb/outb
which are unimplemented on non x86 architectures (which don't support
I/O ports).

Add these ports to the IS_VGA_PORT macro, and implement reads/writes to
these ports. 0x3B4 and 0x3B5 are mirrors of 0x3D4 and 0x3D5 that are
used in monochrome mode (bit 0 of 0x3C2 is not set). Implement these
with the same logic and env state as 0x3D4/0x3D5, but with the bit check
condition for 0x3C2 flipped. 0x3BA is a mirror of 0x3DA, so the
implementation for this falls back to the same logic as 0x3DA.

The extended range also covers the non-VGA ports 0x3B6-0x3B9 and
0x3BB-0x3BF (LPT1 on legacy PCs): reads return 0xff and writes are
dropped instead of reaching the real inb/outb path, which is harmless
from the VBIOS's perspective.

The write side handles 0x3B4/0x3B5 but not 0x3BA, consistent with the
existing lack of a 0x3DA write handler.

The Aspeed AST2600's VBIOS uses these I/O ports, and these changes are
needed for it's VBIOS to run.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 76a05e74f55..c06ed34c0af 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -248,8 +248,8 @@ void X86API BE_wrl(u32 addr, u32 val)
 
 #define IS_TIMER_PORT(port) (0x40 <= port && port <= 0x43)
 #define IS_CMOS_PORT(port)  (0x70 <= port && port <= 0x71)
-/*#define IS_VGA_PORT(port)   (_BE_env.emulateVGA && 0x3C0 <= port && port <= 0x3DA)*/
-#define IS_VGA_PORT(port)   (0x3C0 <= port && port <= 0x3DA)
+/*#define IS_VGA_PORT(port)   (_BE_env.emulateVGA && 0x3B4 <= port && port <= 0x3DA)*/
+#define IS_VGA_PORT(port)   (0x3B4 <= port && port <= 0x3DA)
 #define IS_PCI_PORT(port)   (0xCF8 <= port && port <= 0xCFF)
 #define IS_SPKR_PORT(port)  (port == 0x61)
 
@@ -270,6 +270,18 @@ static u8 VGA_inpb (const int port)
 
 	debug_io("vga_inb.%04X -> ", (u16) port);
 	switch (port) {
+	/*
+	 * 3B4 and 3B5 are mirrors of 3D4 and 3D5 that are used in
+	 * monochrome mode (i.e., bit 0 of 3C2 is not set)
+	 */
+	case 0x3B4:
+		if (!(_BE_env.emu3C2 & 0x1))
+			return _BE_env.emu3D4;
+		break;
+	case 0x3B5:
+		if (!(_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
+			return _BE_env.emu3D5[_BE_env.emu3D4];
+		break;
 	case 0x3C0:
 		/* 3C0 has funky characteristics because it can act as either
 		   a data register or index register depending on the state
@@ -321,6 +333,10 @@ static u8 VGA_inpb (const int port)
 		if ((_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
 			return _BE_env.emu3D5[_BE_env.emu3D4];
 		break;
+	/*
+	 * 3BA is a mirror of 3DA
+	 */
+	case 0x3BA:
 	case 0x3DA:
 		_BE_env.flipFlop3C0 = 0;
 		val = _BE_env.emu3DA;
@@ -343,6 +359,18 @@ to use.
 static void VGA_outpb (int port, u8 val)
 {
 	switch (port) {
+	/*
+	 * 3B4 and 3B5 are mirrors of 3D4 and 3D5 that are used in
+	 * monochrome mode (i.e., bit 0 of 3C2 is not set)
+	 */
+	case 0x3B4:
+		if (!(_BE_env.emu3C2 & 0x1))
+			_BE_env.emu3D4 = val;
+		break;
+	case 0x3B5:
+		if (!(_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
+			_BE_env.emu3D5[_BE_env.emu3D4] = val;
+		break;
 	case 0x3C0:
 		/* 3C0 has funky characteristics because it can act as either
 		   a data register or index register depending on the state

-- 
2.43.0

