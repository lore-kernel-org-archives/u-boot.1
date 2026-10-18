Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0810CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 04:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD09981253;
	Sun, 18 Oct 2026 04:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DweXjwjyI1U; Sun, 18 Oct 2026 04:24:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C10B812CB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792297456;
	b=KpNxW/tqZhuti8noAyA3NmmEDJ+0a0KJq5god6Fc0X8G0TrQz7Mr7b0HX8Q6VYyzchvM
	 q0Mi4I/HCLl3yYpe0r9zX9QjqW/xRb1pPxwwDPtZuav/I6cmZecta0rB2UoL8Rl/S0iN+
	 Ot3lfE+Y6Bj9fYh9iHejNLl0RtRjMcxDYNMo/M9SVaxBTUhR1VdilbkWg41zMfo77Zqf+
	 akolqACAicOWPJr2JC2IWIuoXxhZ6F19+ORy/Z8x2ck90fHAmboFYIY2cXad8bU/Oab12
	 deUqopE+Vw1qBFE5BIHJsI1+sHkY3wafobRT3WQfrnhx7hKScm5r1ElqBuhtkRymhEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792297456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OsUgCYNdJ20pGGyDlPAnL+OpJi3lIY4rgPeQDTiskFM=;
	b=Vf84sVWGR9caG6lJkJYQNXtsAwYR3CidxvZx4Kaguuls5I9IVhgq0HiTsYe7CGazdbCq
	 AX6iXOw8pcHUVpLWqdeYvrUR4Q8/Xr9cTsmSEBcFchxDBoa2eD30zHT/4MOexAjEZ3Bxk
	 vB+oBlyg4HzBSOi53DXt/1mWfzsSEUuEWG0eAzBS7/HI2mQyicf9IMKsTPqLrUPKCpvOY
	 rmHFJyMEXjRqEnpKJjP7fxTdfH1AJCwk8PYRRJf6lz0q7nl0IRHjdV81tvWP5x/veHyQ7
	 nnmy31ReebZhvOClx92ZE693MXRw47SVTbrJKcYnkYjKnBNWbAXVHsa+FV2Rf50ZLWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=ZfCGUmEw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792297456;
	bh=OsUgCYNdJ20pGGyDlPAnL+OpJi3lIY4rgPeQDTiskFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jk8fRaJ9n6v7W9kIHRzhD22GHpaiUm9i0MIOaQr+rqB4g7pMfrCWLEG6ta1Y2hf+t
	 Od6vam9s/beSTamv9Su+DnSpgXWzVmmCsKDqq9opaRVd5Vbtjm3qmC+R2vRzAlbq5U
	 NihDot19GrULi44QeNo7JEyU5S4WPpovvJ85q+FzGfwKau2qUiAboqA6oQZYbb1Ji0
	 uTPnvKZ3Wj1u51dqkouV1e5wxiVMRvwIpTZMpriQ4JBSxaESpUNWfyhSwzu0ma/el8
	 6DmRc6ssjsi39CnUKf4P9PrSJ/8D44XpPJPchZKA42gAXBD/tc/LEgiuqBLaiTwqkP
	 RSHOF4lcsPgEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C10B812CB;
	Sun, 18 Oct 2026 04:24:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B629423F
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B76280C33
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 04BQ1lSAPk6G for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 04:24:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3CF680BB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b130"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792297445;
 b=fkprCJnV7OtejMziQGi8CRvTLZG8Cv9uJHhPGnT6OC01xTqK7Bh0+RVAySbulGwquLDx
 rBDd8UexoQrk6azZ6aOi3Znol7rF76ivVIbR4CjmktFnIrO17Ir6aiQHppAZXJ3XvdErY
 WJKxMSlMO7EOgr2uyutMGpgJwBSm+Baw/849Nswv0o0cpM6ZgJRZ+RMWTzKTvzcfeMWP8
 nT39VfglFvjVD1nZ5a1TfQceowPPjx5AF/qL1B9p6eb5lLJ9cVGhb1FZZM3Lb3oTUX3Os
 rL5wGqcc11XM5IJtCjxSZNARN587WBuPSO/0VUptPq5hZqfiAyesP0IGolWLDo376/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792297445;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=OsUgCYNdJ20pGGyDlPAnL+OpJi3lIY4rgPeQDTiskFM=;
 b=hwvWxiw+eZYicr1ZbLFLlkquiBdx6Fj8P54WskapqTacF9TPib8CgYhs7W0XCHHlfuAg
 1aAnbPuSRaFqGfeCkir5vsmMNskTEpgho2OFTaK8rHEb1g74Gu1ke+KWMrfzSk7jQ5DXP
 MpNH4vydSzT9wfHr0dm+PL8cEe5U2UR8yYXq11Ge622vK3obJpXt45FDKUiou40DAlmcC
 Otxqr0e8rAYCuavCnzx3Gxi/gQnmbsRGF5Y5STwWjKfsXaAXAH5M73oYA9J/H0TUwZTEl
 eXPPy1mCvNjM+QGdmDl1YPOJHg+J8QLp1XbocpXhZktMoTX/X+vo3VdxizxxQYvgRYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=ZfCGUmEw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=ZfCGUmEw
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3CF680BB2
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:05 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-679a420b96eso1071224d50.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 21:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792297444; x=1792902244;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OsUgCYNdJ20pGGyDlPAnL+OpJi3lIY4rgPeQDTiskFM=;
 b=ZfCGUmEwhzHCUVDoJkM4LTdCSB3NUosttOgLPMXejr6D+S/ShkhCS0nS3AOEqTa3xU
 NUqF7qjhge0QW2iR5Xa+wS8kvqoZtWdRkw5cuxu4GpuI7NXLuW+T166FONxHFtBqx0nS
 LuLU6GMVWLuFBneXP+GW+Rk+bmPm8vhD7hw9S9AsPKLiSlxpVkTL4kHrwYm/dei/iy61
 BOEIqyqtC1S5TnbyHPih7JtVwY4lxtZDonMaH8857WJpDnW+kvJNYsH1oTSVTwUUJBC8
 nEOmKY5V22WpyP5d/bQqjpVmsC45XmYI3pd2EZx5VxfCygCrE3WGVVWNsR+ZQma0BvPw
 twNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792297444; x=1792902244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OsUgCYNdJ20pGGyDlPAnL+OpJi3lIY4rgPeQDTiskFM=;
 b=V9GQan/509qyV5mbQfEOsVKtQ+ylzRoJORv/44UOncPcWLgldVtA7ueQT20j+dqZts
 urapOHBqS7qrRw2MKV7BIOHRYz/9VbN754RaewUarzg4kcSxgV6oQ0MQC2x6RTwfofyS
 G6EwUUcVObY7APrbChdiWKGqf+89YbFxouFnSOR/eIHGmMXx3mkw0/c5kXOl45Gl9dbI
 4NGCKHODWti/3o13ISlwdPLWKhTa/9s1iG4C2q+Fqqt96n+W/WwEbXMyTJS4NwJPkt2q
 jgZkqzuDw0kaOuN2S1EOA8YiRoBql/f3oqyUtPdtJsu/kTpRNY13DenHeuePORZpKG2n
 XVTg==
X-Gm-Message-State: AFq9FYInLobTalJcN/o0pOX0qmfBW3+10cwuHXA3b2POo9B+HpD4k3Xr
 maaOQ4Ef6L34lZaEqo5yccpEXDt3c9FiCrTVIJQw9D2NzrXcMbQX/PQuaBgRkWpbRzk=
X-Gm-Gg: AYBFou1LRVGFOEx78NVlbXpOVSlrv4E4KcqaFywUMJQmRqCg1RQ+cPkaQ//iKGDSTtK
 3so9WDUj3MEpuLTorcIV8GxCkLAJt7irHD4H/gDzbbZI1tPvQtSQHNUZGoXPGJULVbNwvSeGjSL
 RPQ6K1PNEWqjXPaD5i4ZSyuCibjzkNQEO2eRdvztq+MMNCPPlvxhn2e2IRcurpP5vYWoZ0nN3N2
 2g2Mtkarx75pbgT1/g6RfRc4Ho93yBvhF8JeGWnm0N0gg7js5IiDa7/XIqmssk79iC8Wx56Pj9V
 N0OVyB4IyCS1xkD18Hhiz7TA5YiV6AaaUtVEtUerwlfaO0Ipi7xldaJSm8KC5Xa1/S663wVAalW
 6TSAUV3bn/l+SjnANc+H8EY6EAxhiD1UlMiaPp+EjOlcpDAbU0WdaSPQnrlz7ZgHYxzdLjyXuR/
 z+zKGjgWb1VJu24s6EFhnoA+RNebDHUaBqNBMTv//FLFRpG1IciNRrWPptSGilPwqX+wdvhZbqA
 d79Dmsxnso+wsCQ4WYNLnQng65TPal11YGQbx9ZIRqqgJJJAQNd7tB26gSfQ+v2
X-Received: by 2002:a05:690e:4506:20b0:675:61ed:ae79 with SMTP id
 956f58d0204a3-679ca92c9d7mr768328d50.40.1792297444311; 
 Sat, 17 Oct 2026 21:24:04 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:4b47:590f:51dd:a46d])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-679b1f0e01fsm2838791d50.20.2026.10.17.21.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 21:24:04 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 17 Oct 2026 23:23:50 -0500
Subject: [PATCH v3 5/5] bios_emulator: extend VGA I/O ports to include
 ports 0x3B4-0x3DA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-aspeed_vbios_fixes-v3-5-961124989594@oss.tenstorrent.com>
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
In-Reply-To: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
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
used in monochrome mode (bit 0 of 0x3C2 is not set), and 0x3BA is a
mirror of 0x3DA in monochrome mode.

A vga_port_active() helper is added to check the current mode so that
the monochrome ports share the same logic and env state as the colour
ports. Reads to 0x3BA/0x3DA also use this helper, so the 0x3C0 address
flip-flop is reset and the 0x3DA status bits are toggled only when the
accessed port is decoded in the current mode. This also means 0x3DA no
longer decodes in monochrome mode, which matches real hardware.

The extended range also covers the non-VGA ports 0x3B6-0x3B9 and
0x3BB-0x3BF (LPT1 on legacy PCs): reads return 0xff and writes are
dropped instead of reaching the real inb/outb path, which is harmless
from the VBIOS's perspective.

While these changes are needed for the Aspeed AST2600 VBIOS to run,
these VGA ports are part of the general VGA spec and might be useful for
other VBIOSes.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 50 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 76a05e74f55..5c440c6792e 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -248,11 +248,27 @@ void X86API BE_wrl(u32 addr, u32 val)
 
 #define IS_TIMER_PORT(port) (0x40 <= port && port <= 0x43)
 #define IS_CMOS_PORT(port)  (0x70 <= port && port <= 0x71)
-/*#define IS_VGA_PORT(port)   (_BE_env.emulateVGA && 0x3C0 <= port && port <= 0x3DA)*/
-#define IS_VGA_PORT(port)   (0x3C0 <= port && port <= 0x3DA)
+/*#define IS_VGA_PORT(port)   (_BE_env.emulateVGA && 0x3B4 <= port && port <= 0x3DA)*/
+#define IS_VGA_PORT(port)   (0x3B4 <= port && port <= 0x3DA)
 #define IS_PCI_PORT(port)   (0xCF8 <= port && port <= 0xCFF)
 #define IS_SPKR_PORT(port)  (port == 0x61)
 
+/****************************************************************************
+PARAMETERS:
+port    -  Port to check
+
+REMARKS:
+Some VGA ports (the CRTC index/data pair 3B4/3D4 and 3B5/3D5, and
+Input Status Register 1 3BA/3DA) have a monochrome (0x3Bx) and a
+colour (0x3Dx) alias. Bit 0 of 0x3C2 selects which one is decoded:
+0x3Bx when clear, 0x3Dx when set. Return true if port is decoded in
+the current mode.
+****************************************************************************/
+static bool vga_port_active(int port)
+{
+	return (port >= 0x3d0) == !!(_BE_env.emu3C2 & 1);
+}
+
 /****************************************************************************
 PARAMETERS:
 port    - Port to read from
@@ -313,18 +329,28 @@ static u8 VGA_inpb (const int port)
 		if (_BE_env.emu3CE < GRA_C)
 			return _BE_env.emu3CF[_BE_env.emu3CE];
 		break;
+	/*
+	 * 3B4 and 3B5 are mirrors of 3D4 and 3D5 that are used in
+	 * monochrome mode (i.e., bit 0 of 3C2 is not set)
+	 */
+	case 0x3B4:
 	case 0x3D4:
-		if (_BE_env.emu3C2 & 0x1)
+		if (vga_port_active(port))
 			return _BE_env.emu3D4;
 		break;
+	case 0x3B5:
 	case 0x3D5:
-		if ((_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
+		if (vga_port_active(port) && (_BE_env.emu3D4 < CRT_C))
 			return _BE_env.emu3D5[_BE_env.emu3D4];
 		break;
+	/* 3BA is a mirror of 3DA */
+	case 0x3BA:
 	case 0x3DA:
-		_BE_env.flipFlop3C0 = 0;
-		val = _BE_env.emu3DA;
-		_BE_env.emu3DA ^= 0x9;
+		if (vga_port_active(port)) {
+			_BE_env.flipFlop3C0 = 0;
+			val = _BE_env.emu3DA;
+			_BE_env.emu3DA ^= 0x9;
+		}
 		break;
 	}
 	return val;
@@ -390,12 +416,18 @@ static void VGA_outpb (int port, u8 val)
 		if (_BE_env.emu3CE < GRA_C)
 			_BE_env.emu3CF[_BE_env.emu3CE] = val;
 		break;
+	/*
+	 * 3B4 and 3B5 are mirrors of 3D4 and 3D5 that are used in
+	 * monochrome mode (i.e., bit 0 of 3C2 is not set)
+	 */
+	case 0x3B4:
 	case 0x3D4:
-		if (_BE_env.emu3C2 & 0x1)
+		if (vga_port_active(port))
 			_BE_env.emu3D4 = val;
 		break;
+	case 0x3B5:
 	case 0x3D5:
-		if ((_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
+		if (vga_port_active(port) && (_BE_env.emu3D4 < CRT_C))
 			_BE_env.emu3D5[_BE_env.emu3D4] = val;
 		break;
 	}

-- 
2.43.0

