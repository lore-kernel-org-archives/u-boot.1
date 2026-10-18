Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9CCCCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 04:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21304812AE;
	Sun, 18 Oct 2026 04:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id naJQxKan_0x4; Sun, 18 Oct 2026 04:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 59C2881270
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792297454;
	b=tLrNlMsY9C0BBwY6ofFdgVyzpo6anJgV1LzcrksLEEAI0/jichY75VEMI46OUK2aHnsc
	 pg+tsbyAtplFd10h0ZXTUhY4XdfBDOkjcqz9dSiUChMHMtRUSfL9LLcyuzJYaHR53FXm+
	 ADrGLOLdgHjjGTAD+/yloF8eJdnyGyn7GQdJbRQKv7l8E7WniUa3W3aOmGO3tQtsAH7c6
	 0EYs15vIo1olRfTuIwJRkwcejQLudEQ0k2yBm644+kKLV/Pm7Hk3nBvepGSAmfVAWQL+E
	 G83EgRUGNBxU/X+GbuNTWmg9Fb2NHC9DEqEwH4Qvf6fNgnuxPH9TLucpqLXHWmf9qrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792297454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zbMFHTOU9Oukp6W+PvLoYoWsYyR/Za1c7aT3psq55S8=;
	b=noLpuBUycPYQ/x7Yp9+9wle13BvIRuAT4SK0LoGwwzQQiTiAQfvxCCXhioXNHRY6X374
	 1c8lI1g0Rn0N4pKp9AJLlc+213TIJ+s+6wp9BCMcadInov9TovFdCSJCBKAHhk57o2xur
	 NojATQP/1B5sDnLhnLJBAF9d7Xz71rZKCSBvOzDD/z7rjou0fGL5WR14/fqDJab/A9m0N
	 zT6l1HjcmoffnzVxkJIiRgnkgJI4J5WibzqmvNbHkvYjE7wLafbINirIh8Ck0Hm58zqhf
	 9aEce0bfdReZy8sApz5eYCNfwXpd20IK03MgmAlXq6jLiMmzgg8AuYhnwJb4VtMCVog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792297454;
	bh=zbMFHTOU9Oukp6W+PvLoYoWsYyR/Za1c7aT3psq55S8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRSnHkGWzcOAvMNL3RPdretiFxomIG+9g0tcK0H68UsxJUW0ecnQtaAW5vFlHX4ww
	 NPyqOcRZmYsBGsCJ5jMaJYyW0ts+5EDBZLhNfaSqByPouDdN0CevbqrraYb7lpvEyU
	 U+8TrfpE1hK4A/7yiXX8BLmbIBZmsqZIszi9o2bWu8V6MwFgMwRZHBlRtCTO8Fmmmd
	 rx40yW53SUXm+TE0t3X98nBPKHpvHfICv8MEZ8ql8B/tihtVOgs5agXBqI/Wv16i72
	 sMMAeU7TaSqxkneLMMWeoc1mSpMiMLxm9nZG9VEO9ia7l/N14cF8dzwK/ouVfJ1Kkq
	 qHxzffrb4f7lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59C2881270;
	Sun, 18 Oct 2026 04:24:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02D6D356
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD14B405FF
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V6RTdSAmDgq9 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 04:24:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F66240576
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792297445;
 b=sZ1sdAh6lWKlypXj3I/t6yo7NKd/nd0gIPlARm0FWJ0T2Y/WQKVDk1HU8TX2eZlVj7UL
 Gze4Y7ifaqROUNe+oHGcIuUl+u+UdF1lpi2F+cLJyx+0y4y/GvStGsOL3F3++qN6+VLgD
 lGw4BXr5ZVBUCB48N/RliBCY15V71prsitEwpaECBuloTbv4n0m/PgmvPjRqLbtiNDoX5
 qu//ibmvbGK/IcR1SgTwr1qpdkJam3Z9qMQoZiv/yDe818L/j+EzWBg1Lo1dtcNqT89rp
 5kvZ6sI1mwEcDlIV67TYzBY8cnksnUhEWP548i8U2O3JUzRW/BLcrfGy2kvku1Rz7BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792297445;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=zbMFHTOU9Oukp6W+PvLoYoWsYyR/Za1c7aT3psq55S8=;
 b=QzahOKxHWuYVEe5+4MGnN8tbXxe5jbSaG+EoOuqBeT2TGWlOXZQ4rFnKk8eR6fC0ZySt
 QPWvAxP2eS0XpBl2amVaVpQSbmvRsc5qPjJqGu2Troag4PCo5Zf42kPQ4RiE8Zlgzn8it
 j63erI2s9pI/xtkfpXnKCoRAT9Gw58yASLB5b6Assg00dvLit87358H7DWUzW7ch56g2Z
 7ko1L6mp2AFaRz6+p8tvTbE519ts8ck8S/BG4PNcir0tfx4vWh9bZxb15F/A1QUVdaKof
 QBsjGRBrZzqxWkvL1C/VndLHBvN4H0DfBKhJom68S6mQRUBu6DbcDj3p+zJypZcQBeA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=JQF1C0+2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=JQF1C0+2
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F66240576
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6798c43a3d6so734742d50.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 21:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792297443; x=1792902243;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zbMFHTOU9Oukp6W+PvLoYoWsYyR/Za1c7aT3psq55S8=;
 b=JQF1C0+2hgRao9vhNWwdC0WKKInlGB20jwNvoLUBVuo0qEhI1c5Eg/FsGH+5Ry5qkQ
 I1xS1IfQ8NZKEAAK3Z2m5fWRDAkxQmrBicIh5IglSv1ZPqOSfQ5uvbZVCSwE9fOU+YvF
 yd+2pLcPUg0ID6KgCmvrYhcnAPBflEVXFAHa2sVNW4FYV/d3E0pdnjNBDN0YB+YkZXh7
 /HH1m4btuJr8CwGRfLCyn9tyx7ovHET/S+lYlOubwBMZuDTzbifzHrNmwzJob7D4Y3Ow
 c0ggYq6Eg+WlZzhUNsffITucYm34H/0ZbMMQxdZ4enpY1CcekvDdyP3kp3Yn/oV8BhS+
 dPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792297444; x=1792902244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zbMFHTOU9Oukp6W+PvLoYoWsYyR/Za1c7aT3psq55S8=;
 b=WZlXBs/R5T9XlrlHOHniBg1qm9j9KkK9m4gV5jn65DcbPQlyQrjOwpCZYW0xAv2EYs
 ZS8tX2GPBoVpF6pXj8cEBr+qszDqenbPueKshKFN4/GWZ161EjoKAsX37zuNlQ5WN4n/
 4YzPRpmYrCH1t1z9PszU2jZLPkoEz7UkckPX3/X140jaqNFy9367uDY7PYVyzYn2XxbQ
 zMOeBAFILik/LaHfTySBLh4aGpcRk6iQrM0dNU1uqyLqD4z4GsD8jq02uag6dI3fpp2x
 uvzLdNeR3YWeU4MumBLtANn43VL2KQErBu9eT9WZQVltatf3mxjKW4q2WGRXMUdZvnJn
 rJKQ==
X-Gm-Message-State: AFq9FYL9NUiBUGNw85puVo25qxZzbV+KuB0sa53Lnt/hW4NeW7zP5DAL
 JSik4nOf7WPsNrXVdc0RyKYoiLVyoU927riVO8pbYEgf9QG3Yqctpj38T/A9mtFeBFg=
X-Gm-Gg: AYBFou3p2G6c6G3gJ6GAoRF4BpMQEgCZiLQxBkGAnFj2UpBD8JBY55MCB1I3dLpJX8B
 ArbCYXTv5onhvsgV/aHKo2mtVPsfVwytoYlQMtoF2mUgFfqYXQMUkIXc8aG6XVZMusS9D5b9n2f
 46cCrD+5uj8LxEwWmMWlKnPexmvJpQnpa+ggsjftK4GFKL+ZLzVXXk9WX3WT85lC8xZIYVers2N
 dTr1NWwimx1YisrQPhAvlqgccQ1uIQ4yBQQrg0zillwPbjZzhVsRD4CQPniGSYSpaShcwIhj6mb
 BwahjCzCdO81QKjs8BYbf+K56b20IQmswi7Bmrx+/7V3oxkh+SER+Umn70Y1gGEn23x8JJB31ML
 XCtn8MycFHN449gLPlbqiXf6EYyclwrelkkSxLIzFsfdBdOc6zprBZdWxKbXNCC+XpCCkEYT93X
 cbEAL93GXq5F8Exq3RNRcw6wB5IXGQfZkvXLLMxVilWiHYIko+lu2b8IuKe2OEH2+mMOT10YjF5
 AQaZFTOHmFr5ML4amrWRTls+OZVxn2hDmGz5svkbuHd7FL2icn+WQ==
X-Received: by 2002:a53:e948:0:b0:679:a7ce:6798 with SMTP id
 956f58d0204a3-679ca92603dmr634831d50.139.1792297443700; 
 Sat, 17 Oct 2026 21:24:03 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:4b47:590f:51dd:a46d])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-679b1f0e01fsm2838791d50.20.2026.10.17.21.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 21:24:03 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 17 Oct 2026 23:23:49 -0500
Subject: [PATCH v3 4/5] bios_emulator: support 16-bit reads on VGA port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-aspeed_vbios_fixes-v3-4-961124989594@oss.tenstorrent.com>
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

BE_inw currently doesn't handle 16-bit reads on VGA ports and falls back
to LOG_inpw, which doesn't do anything on non x86 architectures that
don't support I/O ports. Implement this 16-bit read as two 8-bit reads
(similar to how BE_outw implements 16-bit writes).

The Aspeed AST2600's VBIOS has these 16-bit read instructions in it, so
this is needed to emulate that.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index e02c9fc636c..76a05e74f55 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -612,7 +612,9 @@ u16 X86API BE_inw(X86EMU_pioAddr port)
 	u16 val = 0;
 
 #if !defined(CONFIG_X86EMU_RAW_IO)
-	if (IS_PCI_PORT(port))
+	if (IS_VGA_PORT(port))
+		val = BE_inb(port) | ((u16)BE_inb(port + 1) << 8);
+	else if (IS_PCI_PORT(port))
 		val = PCI_inp(port, REG_READ_WORD);
 	else if (port < 0x100) {
 		DB(printf("WARN: Maybe INVALID inw.%04X -> %04X\n", (u16) port, val);)

-- 
2.43.0

