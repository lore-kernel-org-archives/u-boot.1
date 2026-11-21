Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C4606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BVGcFhqc;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=FXcDtuE7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E905940DD6;
	Sat, 21 Nov 2026 12:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-l3tN_zw3KE; Sat, 21 Nov 2026 12:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D4944059E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264524;
	b=V+9kXWQI97xtmtBqpn+qfPWE06aLsGQi6kX9YPZzNvz6X3vj1dXfzZ01MGxz9xkIAnOb
	 ck88HYu7EDtPzE7OhsUfYGQbK9UVddf0iNrpcKsnR3d2X8fNNogM4S+AML0tb9jolcjOb
	 HFcijhjZ5T8SPpaRLII9XgA+FtXT66KO12A/i/hxfwD/0Px0NVV2+WaM+iXUBV/RwwwKH
	 hzYW5YlU1joXcuSH4agBcxdU2I0ZoQ7ZQth6MmRjZldMildUf4vowDDpHK+/n7elg38GE
	 usgJ5ohljcDFmdmiwdwuP5AXpM/WJNyEoNS/tV4zN07XNP03LdPvoWt/uLbZaz9q8sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2IgL+8UKMF2TPP0jHfrUmdLVZWZPH9sjmN1LQLNMSD4=;
	b=LZnYDQmNO+iCwRnaZCKLlNX010DwgUYpbiRW9PMUZ7NqolUsVfRmrYGPEzvAKbgbKS2a
	 jg+thrGob6eyBjfRBRhPxxTvzzcKW6tPyISJqHL0OOpF66P3X+sWzhSY1HwWP7EKzUtMM
	 jxLi3UDnZBs1Ejkfk/fThUpA0JJzW8TMcPqYzt+aB4lHAJFZWKVxCkmRZADPqeQ0DYkwO
	 CpbU7dnIT170b2jChJq67Fo398aQw+xbqMOQXt4yoDf34oePsnWYkmOdb1nXH4bLmzgDS
	 W1awkOkvKAzYrv+Fkcrr9BQUtEceYCbFe6NXZeQQsyq7UWKJgiSz1JlM4+E5O3DEtrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264524;
	bh=2IgL+8UKMF2TPP0jHfrUmdLVZWZPH9sjmN1LQLNMSD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BVGcFhqcHLYCyxDCHnPJipwf+Uqc0PiRjhwSA4svU432lUkqmWBHxVT+XsZq9noFp
	 6IYvf/hl4Wugqv6fUCx07XqTUtfDiE8LoSJ4l+11W3I/WH4hwM6kEes93eLM/wy/YQ
	 hojjxUaTzU+qpJvCei6Pd2tt9wf/w3kmRSfToomyTuSsPHz+V38AilVb/22eBf4ASK
	 UzmXpQHi9jKMOqBwlc4HY/bQ0vOS0ATtx+aS76jDjJLzsP+zqhUvq1Il/6KU1+g6kW
	 A7B62EDSqvDV+XqIDdmvf71H0QtdviIfW4BXTU6vLCaBK44pBytVwCmcBu+qNDn/px
	 7DRo6GKTmBa/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D4944059E;
	Sat, 21 Nov 2026 12:35:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CAF643A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD25140070
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXAYOz6nataJ for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D754640012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=FXcDtuE7
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D754640012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:17 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso13505615e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264515; x=1795869315;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2IgL+8UKMF2TPP0jHfrUmdLVZWZPH9sjmN1LQLNMSD4=;
 b=FXcDtuE7qY2yWoyz1iwvY1VTUjksBg1UA6rlvLoRs490tuv70UvwPtkSaT5oykKPay
 6d0XPVMHP6JfgHSCpTl6onPIgBStTcMPUNWG2xapdh+O6UqWW0Kcb5Dn61C9ADHCAHOt
 GTJh4O+kNgS2g26o3CS772Ta8rKYkSGTeOfoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264515; x=1795869315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2IgL+8UKMF2TPP0jHfrUmdLVZWZPH9sjmN1LQLNMSD4=;
 b=untuEGQl/MV/Zeq4p7mfGXwMZ1B413q/xJc+AXoUDytIjzac7cMR22ANLlCcm/+yms
 GHdYshtErs2XFikTueeRoiouzj3FTyzlREyOwImIycSQrA61DX6AisOZ2j/QAyZZLD9k
 eKGgA9ZiT6LpOqJmklTZp/W7EMyGT74HVRN+xFmTPKRDd1RHRr64NtWHKeGmG6o9mFW7
 xhcu2zYyIm3l4tVFN9UWXN0JgOuIm5LhvPyJ3a4Pb3uhA8USq0b0og4cJekI9O+FOmka
 AJ3f+2pkFKFWoi1ojrF/Vc3GzN1mSauKJJ4iv4mECkKcLTxUBJIPcqKxtgrXfn6i6TMi
 3wPA==
X-Gm-Message-State: APuU4Z9ZkA1xdwjQFAQoUKRklqjczeALHbkpRDB25fvVASMnW4wBG/2W
 5r+j1X9/+ugYwESpVOd1LpihVXqIAs02BAUlev5T+J/g7Tn3MkTKNIepsyrP1Emwe7hilE7DpeA
 PK5bl
X-Gm-Gg: AZFdTZcbrBU7V+fLdR63JTAUpdo6E9hNSpQqQAx4IEOlCDMNbCSkLLbjgz1GOxz4/nw
 LEpqXRbyIxRYORTlBgWKKBK+9j0NhcZ+Od3B/oHuiUGyw0/Clx80f8piaBKndT5RkCI32LYuLLO
 JrexMNjnuZFTJ+s69u+82elKPKsDLpIzwfS7P1WeFqt9VAHNZ6ehcJ38NcfIS1kYyHlnMKmhND8
 a7vAyzUn/lW2W8dZv0Hxynjjmh5Y/j12wXUBx0lMf9zf/ZWD6pJcxy+o30do9+fiRm0E8DRvmFY
 zUs7D2ve+gx3Zzpoxpx4224mHy+ePMtSL3mYPr0zPjiLwZYm/lfpo617aK+NB1y/lXFTO0EW5m0
 RQyu1/oy4M423krng3q/ayUn/s93qj5AAwdj9KEMD7xXWMwXR+eZY6ipJRhzBmCGJFFDNzWkbSN
 pV/XqCBIl36w8kz6b3CqeyXr9jo+v5yzdM86bkr/oVq3M9uI+Sy12PwUI7rPLoZkn6ohJCg3M1D
 jxHP0yM4FHCzEJAZSNPh90I4TZi1nxgnK6ysGPVdrNSUHwRnNGRYK5lm+P6CYaYm9xsxD2PgLDm
 X+7DboYQvFtT9YAiuGMdV+n+WhPrDnuBxjTjJQqN+T2z9GcpGaOVeog/iZmxUjE2U3qyr4dJTBe
 QgnztSipXu4lGYnWaUueWcQOgl6Uo+zpzvrzz49FxFezuDaOLYLo8jNZgOH6UZTuj94omE7MklB
 knRYNqwfBjPo85tum2kS1tHVxQiQ==
X-Received: by 2002:a05:600c:4f4b:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4bb888226c0mr153122925e9.27.1795264515577; 
 Sat, 21 Nov 2026 04:35:15 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:15 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/25] video: mxsfb: add missing space after if
Date: Sat, 21 Nov 2026 13:34:00 +0100
Message-ID: <20261121123451.2471185-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix the checkpatch "space required before the open parenthesis '('"
errors in mxs_lcd_init().

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Add patch, split from "video: Update mxsfb video drivers for
  iMX8MM/iMX8MN display"

 drivers/video/mxsfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 71429a43e064..d7a6214e5a6f 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -155,13 +155,13 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
 		  LCDIF_VDCTRL0_VSYNC_PULSE_WIDTH_UNIT |
 		  timings->vsync_len.typ;
 
-	if(flags & DISPLAY_FLAGS_HSYNC_HIGH)
+	if (flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		vdctrl0 |= LCDIF_VDCTRL0_HSYNC_POL;
-	if(flags & DISPLAY_FLAGS_VSYNC_HIGH)
+	if (flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		vdctrl0 |= LCDIF_VDCTRL0_VSYNC_POL;
 	if (flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
 		vdctrl0 |= LCDIF_VDCTRL0_DOTCLK_POL;
-	if(flags & DISPLAY_FLAGS_DE_HIGH)
+	if (flags & DISPLAY_FLAGS_DE_HIGH)
 		vdctrl0 |= LCDIF_VDCTRL0_ENABLE_POL;
 
 	writel(vdctrl0, &regs->hw_lcdif_vdctrl0);
-- 
2.43.0

