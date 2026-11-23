Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19431606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TbpuYcw0;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ExtxfKpl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE66040665;
	Mon, 23 Nov 2026 09:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qL0X9h8txROr; Mon, 23 Nov 2026 09:47:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F335D405D9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795427229;
	b=OU7vU7DbfkcwpwI8ZpZvJOaVc7XiTJ2gXfRDqFQ/V0ZBhJmEAHPssVBIw9usX2824n2K
	 AgDG2a6+gECLCUAHtc3YkI8T9dl+KcX9dhgBsTSQfxN/MM5OXgnwPJ09ax1HOxbeQrQvp
	 l5TgUQ1SkOgvPVGc9jqgaNqb/0Om1raNuKD8DydYxXB61xXFAnIu3TaTHsaZyhHV4L6ko
	 91g6b9eFTJdASNDAKnTSL3DQASsUOm44lEk08SlVj3Wwe1FGXb18QqJDuoQv71Pt9KEsk
	 L4j1LZTBSZ9WZwhDJfzCSBi8lBDTw9ugWJZw+fA7cTX41Bhj1gZpG0mbv3m0R7C7TAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795427229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FaOyZ/BhOulweT0gsJ0COZ98l39BgC1RhKWBxOq63+0=;
	b=ZrmP6CUp8Ld+4ePQTGrq3XyX5j1B8jGEBCZBfNEp9FjD/YMDmvEA0d2uftgqSBL6VNKk
	 ycKxA+PcxYnhi6tbx5jAymIayGMT4ixOqAQFjolisFe5EGosDU1GeevZ4rOASlx77kkg3
	 YNC0xkuQpaZV1ojQvWevFbNkmM5DBUYwRKqfWIB5SWvCE0ct1WhozJ+p9SQeDfpZjYMOB
	 vnJ3Dke6mfS78CvQEPYaPdS/sAYXCMRjM6sOVLd/suiSLXLFaOpSWP9ySpR1oQ+9ZBvpO
	 T/2Hz/wentpeBpZDVyLslYK17DNpQXKF90KM9lJslEVmidiOo2Zyv5D0bGwWOLe0jTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795427229;
	bh=FaOyZ/BhOulweT0gsJ0COZ98l39BgC1RhKWBxOq63+0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TbpuYcw08lpL+qhgZ34M6xUqfENyiGetxLFwEAvkqK9uQ/vBBG5e8zSlhReXfOO6f
	 FHjpdMRUBcOPPfzUyXoIq7DjmG8zh+MfNO6pDwMucBsyGgHAy+tvmfp6zJIc9ccWR2
	 D4riGkyLyG0J5cdFK7hGplDA4Y6fzTa6t8iUN5rwSUgHR3tsoGtJ6zuxDS51SQqC6G
	 0nqrzRpwVFDuehcYwaJygny80uMr+rJ+cLpmcovrOEVie3tKMC9JF3jcGrmhpuvxcq
	 cYeElf1J0iKU9J8EHwUtkB6XCJnbrb/MwJgWXROLbaJx9YpZJQKB8chFqTMHct45XL
	 hthOh8ndwqhBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F335D405D9;
	Mon, 23 Nov 2026 09:47:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 442A822B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E70E80CF8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:47:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e7wiI8bylEWV for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:47:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B2F280BD6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com;
 envelope-from=terryzhou05@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ExtxfKpl
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com
 [IPv6:2607:f8b0:4864:20::1236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B2F280BD6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:47:07 +0000 (UTC)
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-1b3acec6677so4309837c88.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795427226; x=1796032026;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FaOyZ/BhOulweT0gsJ0COZ98l39BgC1RhKWBxOq63+0=;
 b=ExtxfKpljQuG+htvGQIQUtLOZVx39Z5ntobwkdaLL8XSh1Uctrq4a9ju9Lv3jzQPh0
 C++JacOd6hwTKoBxavwAdB37TQcugY10/I5doIH82i+TZ7Dv4eR1imBeph59fP6krTyr
 iEMUrObR9NCVFQ9XZdj+mVprwhb5rnj1PpIwmUGkmPOa3wybI64Ja4+sa5U0ftPLKyXl
 9hVD+C+GqcZciBNhbn+tZlPZAyBGU+YwsRKA0a4HMoEyXEbzrYOseKYn5HgZ/eyp6lRp
 C08vwvIpGZk0d2sKnA+sNkVJuqtpHnMooay3VYG9MTF0DkfrCdfK1vX4L0BxTBg//0HM
 pP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795427226; x=1796032026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FaOyZ/BhOulweT0gsJ0COZ98l39BgC1RhKWBxOq63+0=;
 b=NqOF/lXij3Cgpqy/W4ZF/Xh06AOEdSdxo3nYVJoQ976p8tEJoywkrzD35lfVb0hJ20
 TeOP0KXP8RSGVkXIq09GTFndcVdMn60c88H/UR9BloOuHt9Kxi5y1Z7gsFh8k6u5wXce
 twAY44ghV4mqTiFXwbessa7UnqgE9airppnTyUv4dY0Kj+CgmVHvGlY1XoPw/vkkOdo1
 wPXD93kxFfnQ/3DbNIBgaTGQVilNH8S5k0eiWyRW2inzYHGHAhWr3BAe7bSYRrb4b8kv
 e0vFETgavgQJNiNaMocx2dZeCsYwoOKqNzGILSaIIF3tJIkEKPnDPhJeXkbnXyRFFqcb
 i7Bw==
X-Gm-Message-State: APuU4Z89s6T+oYXG87kEwB1e7jtbRT7dkNUVma2Vi0iAggW82k0pEEdc
 QwrBdNX2aYXY62M+7EXH2oIDPdtGod3O74QFj1ldvpRlrJ671y/zFiWF+6XtD0EP
X-Gm-Gg: AZFdTZfoRldDGIaf0sJsaW6DirLiAbp0VxRvh+pNhO2gWNfOFN+Xk5xGr+ICxPktes5
 C0tztul0DbzQN9LMY1od548yzfcwQ7OT4qW03+CjLMem4zH3lBNMkT2yA7+iGZWHUnMc8yAyzl6
 R6ZEzk/vCeLX9me3RnxkBfg0KicuuDYvelFtHQubTmEvGV7wSosTeAObzG3SWxUYuaGHukLX/BL
 hxa6pXb3WLVItYcnEy6/Luvp43nHQHY3fuxt2Z1HUtdplvDTrqWz1IzUUGQRCR6pvYwv4fkMtS+
 5M4HkIxBLwnBxYD+K2WtTYWWoVFeBtlKNM2Xtvn8ih9E5PmlqAb9UlnfCWRCcyZSczcxH7QdSct
 izuBdMXNU4e0xNJtKK4Yr+OZQt0Qy2P5Q6Ug1RJoofMsSuaxWro4fmHPqicarXPj5eyoDopdvKq
 PIQKZUxCaYKel4PsvUzzZ4bJki0SKYHHvZ2QnMEDSBbK8DwAoTgR1lKYkDclqJaUwswl0UQkrDG
 DNtqCg1xCL4fhrEoaLu7SUP7yWVSan+oLayTLT6FqN0BGMZsxhaAc4CETpDU1kXY7uszbhbX4xI
 kob/mIrvA26rU43c+no2WnVoV+dr
X-Received: by 2002:a05:693c:880e:20b0:386:b26b:d67a with SMTP id
 5a478bee46e88-386b26be80fmr2081353eec.12.1795427226254; 
 Mon, 23 Nov 2026 01:47:06 -0800 (PST)
Received: from pc10fkr8.. ([192.147.44.15]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm23623328eec.1.2026.11.23.01.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:47:05 -0800 (PST)
From: "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: hs@nabladev.com, trini@konsulko.com, michael.drobot@garmin.com,
 "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
Subject: [PATCH] i2c: designware: report aborted reads and writes
Date: Mon, 23 Nov 2026 17:46:51 +0800
Message-Id: <20261123094651.151952-1-terryzhou05@gmail.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Writes to an unresponsive slave can raise TX_ABRT and leave the bus idle.
The completion path only checks STOP_DET and bus activity, so an aborted
write can incorrectly return success. Reads wait for data until a timeout
instead of detecting the abort.

Detect TX_ABRT in the read/write loops and after the bus becomes idle.
Clear the abort and return -EREMOTEIO.

Signed-off-by: Michael Drobot <michael.drobot@garmin.com>
Signed-off-by: Terry Zhou (Synaptics) <terryzhou05@gmail.com>
---
Testing:
Validated using downstream Synaptics SDK U-Boot on SL2610 RDK:

Bus 0 ran at 100 kHz. Address 0x60 had no responding device; address
0x43 was used to verify access to a responding device after a failure.

Without the fix:
- Reads from 0x60 reported -EREMOTEIO via the existing DM error mapping
  after timing out.
- Single-byte and 4096-byte writes to 0x60 incorrectly returned success
  with shell status 0.

With the fix:
- Reads (with and without an offset byte), single-byte writes and
  4096-byte writes to 0x60 reported -EREMOTEIO with shell status 1.
- Subsequent reads from 0x43 succeeded with shell status 0.

Each test case was repeated three times with consistent results.

 drivers/i2c/designware_i2c.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index 2a4c3f8a398..9185888639e 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -451,7 +451,14 @@ static int i2c_xfer_finish(struct i2c_regs *i2c_base)
 
 	i2c_flush_rxfifo(i2c_base);
 
-	return 0;
+	/* Check after the bus is idle so a late abort cannot be missed. */
+	if (!(readl(&i2c_base->ic_raw_intr_stat) & IC_TX_ABRT))
+		return 0;
+
+	/* Clear the abort and release the controller TX FIFO. */
+	readl(&i2c_base->ic_clr_tx_abrt);
+
+	return -EREMOTEIO;
 }
 
 /*
@@ -502,6 +509,9 @@ static int __dw_i2c_read(struct i2c_regs *i2c_base, u8 dev, uint addr,
 
 	start_time_rx = get_timer(0);
 	while (len) {
+		if (readl(&i2c_base->ic_raw_intr_stat) & IC_TX_ABRT)
+			break;
+
 		/*
 		 * Queue reads without waiting for each response. Reserve an RX
 		 * FIFO slot for every outstanding command, including those whose
@@ -572,6 +582,9 @@ static int __dw_i2c_write(struct i2c_regs *i2c_base, u8 dev, uint addr,
 
 	start_time_tx = get_timer(0);
 	while (len) {
+		if (readl(&i2c_base->ic_raw_intr_stat) & IC_TX_ABRT)
+			break;
+
 		if (readl(&i2c_base->ic_status) & IC_STATUS_TFNF) {
 			if (--len == 0) {
 				writel(*buffer | IC_STOP,

base-commit: e578056c766d653270b14557c2a9d8daec414c17
-- 
2.34.1

