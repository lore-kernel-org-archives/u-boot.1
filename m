Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71EAC982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C52E40B0C;
	Sun, 20 Sep 2026 15:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUl-vpWiyeuD; Sun, 20 Sep 2026 15:49:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F3C5640AC7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919355;
	b=Kl1FLMx0Dqhn+uZAHy8i63d6foRMKqF8hS4WniEuWwC6bJprVOJ38a1lgKjfszDbeCPs
	 S2fCsEaeJE1mlR0gKsIvVNra239bE2aFHXCjht9zxIZUq6ZBOA8Evb1e6YWoLCFCtrjiS
	 Ah+Q1SQUlJ3JY5xWLftwXlvbX9GjJ/n5429hohakD8ixCToa5mCwVjhZcbbSCgnkonup0
	 N78uDcGT8tG1nZqAgHocEWVTuOyck+H1NLMIcro8N1i3ncIOtUloCC87JKKTpRBVNVJOM
	 bVU9eZ9l+TcCmC678CVLmrFLbsq49/vdsXaDHBt8zvs9NGO6O2GxAz+BkFVxuUT8hpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919355;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qjY1ZDXVtzKTwiVWB3KvGYq7qsNMea099BflJRYaupk=;
	b=MQwaz5P2X20ETcQ10BVfIZveGyL/5BJfd7ferADbT8HSt6KAHhRnywKf2We8gCRkFIBq
	 nArdYMCBuPFam3VaM+JsbUU9pHhD3xaCU+beDmIhDFVpsDeaJeD99sl0e6/FHmOrn54qt
	 A1POnmANPXoXazh5n0IAV9YVb/jBfdnBjQCJ1FS3x1/AniBEbbREV1sf9aXwr3jMqB1rN
	 Vvwok4DqkswJ+46BztS3uxGQSHSBeu/tZirv96bVgWIqJ07nnfsp+E46A+eoF920UBlM3
	 QkxSJdpy2KrmjfDsYKTBLEFJ3RHwXUdEnaxP/dtP/XtFaslGfCPaetNzoPkvTaF4Hlw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919355;
	bh=qjY1ZDXVtzKTwiVWB3KvGYq7qsNMea099BflJRYaupk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z1ixiVB0YbLo0J7yk4IB3nOCqO4cd8lTcSy59ahFQIP4mvZDxGVvKfgEeGFr+xGws
	 giH4E7EqDrOGoPNjPeO0GIjuf3FLLXBlqhQQON/c/IHjzFllhgZ6T9V/H85CgM25d3
	 R7XBdwbUigtsHM9EOy/9GQQWG6HOXyd4GIwm0QamWn9D3oLMbS078UvB5Fu1qQkI4r
	 WJ/2VBwLSaU/WmcBZdqGFZM7S/60FneZz3tOgeRtmO2vgMvmjcEkcquOEEDPBFPHGT
	 g2W3i0k+rFKm2G7BYd0TF6oRspdNCryymvHf1X92Nmr1zWqQjbkExLr+tkGmIAAihH
	 0598en5nyjKkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3C5640AC7;
	Sun, 20 Sep 2026 15:49:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 929EF422
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 20:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83A0C810A2
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 20:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zD5O25IylzFc for <u-boot@lists.u-boot-project.org>;
 Sat, 19 Sep 2026 20:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2520881065
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789849996;
 b=kuZMAZirkS122uz0IeHuSeEkK/qUHCWb812E3cbNXJgOMUw8coX8W+/p4sHvTluDaijS
 Giv3MIvBeJCVoOHylI7tQChhJmZTVVYemmfl8md6sqtnWTjIglHHacTsUDlFqLJmenBok
 Micnly7FAwRl0i6cZGg0zQ051SF84XTRpMvH1hpmKHyndsNTmzSHv47THnA0N+JB7YqUx
 HI+IXdgBrVHs0xfkdi8+9H2D209Go8s5/7ApwckAO6KT4s3eAwdeYbdOlGZVzA5GmfG1j
 fXiIfLii7AIwkWaJ0rTuP/2Ie+weefhCycVrj0NOLasGlX3P5ag8BVXjLNVlEpR0i3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789849996;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=qjY1ZDXVtzKTwiVWB3KvGYq7qsNMea099BflJRYaupk=;
 b=XdqRxHqp67A2CzEFPQ2qkg3bTVywAuZSUAKmikfcKDfIFY9yVcIu+mAneDpxiZqFQ5oK
 RZQ0Jqel8Z0OxWemcKWNRLLo0MJJxlyxbqobIAsVhfQ6qlZ9190zEj/8dpOBfR+2HgYEv
 kCL541bGZKrdM8gB7cVMs1EpL+cuh+wvwRQEJJXouQuAmVVqRBG4i/du9O9k/3IhQgoEJ
 0nBI5PCTjoIgvHB9bCtJUsHjRhCQAAL+dhEdM1mQc9QHM4gOr/XejGivAZVpcsyC91YKc
 BhWt+npGmhF159vocKEmbJtp6KRAGTt2OkQ0WmM/7wjsium+JgmbKT2EcDLpclSZZ1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="pEr/IeWu"; 
 arc=none smtp.remote-ip=185.125.188.122
X-Greylist: delayed 392 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 19 Sep 2026 20:33:16 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=pEr/IeWu
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=valentin.haudiquet@canonical.com; receiver=<UNKNOWN> 
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2520881065
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 20:33:15 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EEC143F301
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 20:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789849601;
 bh=qjY1ZDXVtzKTwiVWB3KvGYq7qsNMea099BflJRYaupk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pEr/IeWu8HZtneSpHMqiH4xzDQw6NxV+I2nPw/E5YgenwZ9ejSlaoXe9NVMq0YV1j
 sM96TiKJOj21a8Jz693Y657Wd9sS6uY2uxq1ax8JC9BSQXI+8drkifWHL57m99haig
 bKeY2QxwdukksqViLWChtCPBH6XNE+wyaAkVH1XNzih79bEa/tr9GXJ2nLVVWKPeR4
 ADLS0j0vE0FDb+M2r/GCPqQ0FfqmfuarwjR3EvINDfSc4q7akO15GGeHtIKl/h+c3+
 rADyCQMmvbDg8La0F29hzOGXO3qtG9J4xWIjKfuxoGsty+AnqBlIFdeShemTnY1QwG
 ayIp8hkuQG/jADpLMOb0OFp2l3V1W0o6iceSM/sACIsFcHxLCeRf/cjYHodOb2egiS
 2lDL9p+j2x8xO3kWwND50jFJDWMpACEAPQqdJxgxMDhfOK7ioPSeT0snAprbX+OnSJ
 D2JR+NEoO8YjIpYlCI5FaBMAan2/T6OPzgKTLC2JFQ4jX0BFlYF6kiJYTQI7t6ZFgc
 q/qBMXWRlVq7mgwQnLhOonNH5/X0g4sqaDjuK5xtHS/XpzfeHExdVbc65HCW6dWzVp
 c/gQRRHN4+9RzL9Da03ty8tgChqL3ftSe1EKmqu/Y/BMGfQSLE5/1nZ0ZkvpkX5eww
 GsmclB7zSJlYpg0LqMWWVs5U=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so18619955e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 13:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789849601; x=1790454401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qjY1ZDXVtzKTwiVWB3KvGYq7qsNMea099BflJRYaupk=;
 b=JN6lby23X227n8DOngDs81i58jKBmP1al1rrya1u8eJxEvTVdld9w8rZza8VZyjO0X
 GIt7KvFysgrJE2tOZMo9Wk1qoEVrwZd/u+5cCAe4XmTvER2+Ofly36QUXf4Szpx+mwBK
 HfiI4qg5gOpqQPzOxvgw91JntFBCUv6kuhcYRWYSetNDy1aq0mUYirUpxYqBpHKZJ8B/
 d9+t37U99ujGgR6o9i1Mtuk1+/dJGhXIOUqZa+BhzMLXLKDZSvoNA8CRjXa/NJ+sbgdC
 TURrd9blFcATZcJFSE+cxk6Fnd7Q5wDKrK9Xyu7sWyHAbVtEgXzq1/sH4/f2ZXUQ1Y22
 T3Tg==
X-Gm-Message-State: AFuF++mIP6BP63jwJzHX9j/EahpKU7DImHxxsqzV6OhirPIu91CGSMHR
 utPGfq4/9hTQlM06SLBGYFfdwtiQB5Z7zJdSXUL+NAxEui3vVi5838BlIq6TaFAeD2HcrFXaKIT
 pLSWgx7UpcoCtZz2oO+5m3czTzbubn23AYdQQ8q7kCGsFxm7661d7PSqDFvQs2TxgCcyWUbYpy3
 O6R71VXtFbQEIfmsGOQQ==
X-Gm-Gg: AYBFou03n0alX0gEjBcxImeYlSfuEIWb/wwQGvefxqnlzfWB10UxEkpmOt4mcxipCW5
 3xbBkMQQIkMJoWzCFFEISlHFeH+kPzUU455tLtTIN3K72+ywF6/O3bD5ZlmynR3HU35Cbs4nQQ6
 lCoHx7235PiXC3FJz//1QxaufT04KHE/fE8WfMLAuY3DOcgU8lQJ+I3TmWwaMeFmDeNKuh2Zpp1
 U4pWrJHtcJjFn1A5MWe7u2CoXkE3IkMv9ZpD7oQZ7R86r4/KuPF7GAjdwmy6HI8eSiLnDv6cbGx
 8R3BEoNYS/cgXm9gChK2IaNmmXQsdnAY/0CxO3YJUP5bhcIxweEJbJfQ4J2geBwIPHFvJpKOOMh
 tWTeWh5qR/pIRpsYR6IGWxfmSulZrKc+W5Q==
X-Received: by 2002:a05:600c:34d0:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49fc5671650mr84011355e9.3.1789849601601; 
 Sat, 19 Sep 2026 13:26:41 -0700 (PDT)
X-Received: by 2002:a05:600c:34d0:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49fc5671650mr84011225e9.3.1789849601276; 
 Sat, 19 Sep 2026 13:26:41 -0700 (PDT)
Received: from k6.lan (141.175.65.37.rev.sfr.net. [37.65.175.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd068124sm95702085e9.3.2026.09.19.13.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 13:26:40 -0700 (PDT)
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>
Subject: [PATCH] video: console: report damage when showing the cursor
Date: Sat, 19 Sep 2026 22:26:30 +0200
Message-ID: <20260919202630.3366037-1-valentin.haudiquet@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

With CONFIG_VIDEO_DAMAGE, video_sync() only flushes the dirty rectangle
reported for a frame.  Every vidconsole write path reports damage except
the console cursor: console_set_cursor_visible() writes the cursor
straight into the frame buffer without a video_damage() call, so the
cursor was never flushed and stayed invisible until other output dirtied
the same lines.

Report the cursor rectangle when it is drawn.

Fixes: 37db20d0a64 ("video: Support showing a cursor")
Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
---
 drivers/video/console_normal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
index 6dc0a6eaf9d..2c1b6f84180 100644
--- a/drivers/video/console_normal.c
+++ b/drivers/video/console_normal.c
@@ -121,6 +121,8 @@ static int console_set_cursor_visible(struct udevice *dev, bool visible,
 		return -ENOSYS;
 
 	x += index * fontdata->width;
+	video_damage(vid, x, y, VIDCONSOLE_CURSOR_WIDTH,
+		     vc_priv->y_charsize);
 	start = vid_priv->fb + y * vid_priv->line_length + x * pbytes;
 
 	/* place the cursor 1 pixel before the start of the next char */
-- 
2.53.0

