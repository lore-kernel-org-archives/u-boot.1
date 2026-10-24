Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A858606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ncf1YIww;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eRy8we45
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4362406A8;
	Sat, 24 Oct 2026 22:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_tCrGqI5Etg; Sat, 24 Oct 2026 22:35:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8943F406CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881345;
	b=syfP2P+ciQh01LoePA0Zjv/5/Oyc68/fXioV89PpsavHY6YFmx5bknCQNdsFJSehxxM1
	 ztHfCSu01BPe7CROz1ZeWhGCHly2JMRb2VmIn6e7zWv0a9KT1q98aP8YJrJcq25gHaZcn
	 Xu9VdGtADFnkzbZTfD/rWDnl373nbhnBoxIAZX/5Nt1EMLQh0zHnle0DN5ZQjL5irZA/t
	 HyzqHZcsnI0wS2DUuFVd2vDbYxtyoeGmJGXJLFtCqR5s+73Lnm/jeax8wWQYaJMo1bT+t
	 zpXNuy4z6A30+6FlBK5w/YsqzcnPmurVKB0K7Oq1ln4mytljCpNWgPLk0rF/cJYkyyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881345;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ovg97xqfFR+wdTMXrKBW2yVxj3AosHUrrSbpp69a+BU=;
	b=Evlh3o0ex0NN2Dde7sf2sC8g0rvEXGXheQWCINaFnGpyHY+sD/aIvH94s3DUIjH/zy2u
	 myLPXMU8Ygb4OkGrQCScRQg0ZxmyFBPH0G4r0QaHSE42b9OwSdG1OI3RxKFIZWS/DAHah
	 z0vKmeyYjHvqrO3zLzK4c+2CnDzR8hd199PeIeRNsK5EkhewpBQU7aPiVagAeAlWn3Hp2
	 DpiCrjFGb2X2W9SdKDWyXXsDlx2XFlD/ox5JzUI4fYXysjg0aPE+p/TtcsKHRNlXBDg1M
	 saHe3kSNr7V0WN3X4DH9mu+5C8fj5KYSIyAqS3fvGXBK2aihnZ+F2OyvcPRQHfo4H1A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eRy8we45;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881345;
	bh=ovg97xqfFR+wdTMXrKBW2yVxj3AosHUrrSbpp69a+BU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ncf1YIwwF6Wcfm3WB/SvzBl88Q7WtHak2pyqRYT2AoXUVGfXN2uJvA0KWeNxBS36q
	 rI/njuL1597VmoZIsbL3G5XDmUAAFvpdb81FZnHak8wWghMPUvrTRlUWxYFvRJf9OT
	 L5lDcdqYpR2iLPqUtHjNpfeRT5lLLy2EaNgtPLW/TBc4oZuFWvvlbaZjIwtrhYgHVi
	 HGluEs2T0sNafW+yxnCFjW04TzHdKd8LXENbU9VffumAC1/417zKUzoPJZDO++ItBf
	 JAH/c65zF4S1672ZPXWvLYVVJp7BXCcM82u9/iU/SvoArxMD4QuSRR7CEQDxB99yVC
	 FK55ocdZH0SuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8943F406CE;
	Sat, 24 Oct 2026 22:35:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 329A0380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18D8B406A3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IzR8syns94TM for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4DCC406CD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881337;
 b=go7iB8/mzWc0UMX7r3ENMSwKloq0M+Ts9j6ou5PgOvbcA6ALR5aCBaN5FQgGIH6Iqefc
 IeS2nRhdnOabF5rztmPyOZ+8dpMdqXbmVlyFquN+muMHPUxyHN5wJaptVcn5SAGOz61Ux
 QH29YTH8MQKR1/YbJlvZwlVA8CJfdQn0+lNT5sIe/ManSjFmPrsO9ZvTgcqoNzJR2PHyK
 ye1L6fdYMI+Eca+D1phGypXqmrjmNq+LYhY6dITLDmIgB3/LmUsElC/tU427oNLT8c3AU
 pKA9/hbAZ8WL+RWeNAOM8BIVXnZaVflY5xnQxWVYWdAnsSJsoJy8Kwy0SZbizcnn4Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881337;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ovg97xqfFR+wdTMXrKBW2yVxj3AosHUrrSbpp69a+BU=;
 b=qfFNuaGid3RqCDyqLQ7LOMvfT8zOVwWrakH95bXaxOQcDNCW6eQ1eyj6yl1qm8h9+Rt0
 vvnpvbmdhBekdJ7Llkp1s7YU6G2R96Z5D/5RUEJbZuwemgYMdv8iKT9zQQZni5evtOORg
 Wj4iI1VYfUfJAcAFLqD7kMg4D9Au/LxFz/PtoWBdXTUDGBMZNsmb+g0QCW/eOnmVMK/ck
 19/EqhdnJ7hS8tUj9VK8Mt8Spo2RcKPcQwnhBkCEPvNuYKgjfqNPDUAu663l/1cs1P8ea
 F/S1651oRNZe4H4X0y/6gHkz9K4/IHPFxaA/KpbiXe9ANljS3TG24tWkqlnWA+8jyoQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eRy8we45; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=eRy8we45
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4DCC406CD
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:36 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-53656465d1dso1051262b6e.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881335; x=1793486135;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ovg97xqfFR+wdTMXrKBW2yVxj3AosHUrrSbpp69a+BU=;
 b=eRy8we459e+kV4FeZpztkjXHmkHtC+CKnUMuMz5EUGG/U/BGP0677b+b4PIkmBErNP
 EQ7c8qRKmfJt7pZUb8sq/ZvhUA0NK1GbsdzS9Q807fTVB/0VKCabU7RmcytjGn/TXIjz
 wtLS1hc8DI3GiWgSchtCd8EGnkqZcPTdhHMb8qI1HOc4IvZxbSw2jYo0UcDDkQFW8j+c
 RT7mATs03KOom1bde6CgbbuddkbtapztLkaK8VoXMjMFgaQ4jDRuNyUV/bdym7x0vVTU
 1ceh013fUFuEkIYP/96Nq15pG8VQKbnFL3F3RPWtnL+4ZHhKBpWpovaXQnYkbXbceCoj
 XgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881335; x=1793486135;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ovg97xqfFR+wdTMXrKBW2yVxj3AosHUrrSbpp69a+BU=;
 b=p7y329c/M/k//e3sYiOzgwwND4rQ7ix1sW06Wp/gu/5YXGCglZk+nPIKRAeiO4Ky6C
 6Ez46tCkkYqIC4ll8vV0hyHngz0PANJV5R5kCVbEBf/0988jpLRX07XmqIdubVi9K77R
 aFduZbcE1hcie8myqSgrM4fuz/UbR5tNidjAD4CPaLoq4R2gJv+ZjmIjeXADT7juFez4
 Nu50p/tGzjArj64H3RciDyxS4MRJOed3J2vICAFbKeVoom3uuU9ZprJOG+VSD5bIZUj4
 ko/oGGAd8FCTOnXdit9mnTtimXJkdoA0c/q0pAVb7aBNny+3xr+fZVKPdzILgYlQnXw0
 ZKwA==
X-Gm-Message-State: AFq9FYKPLwdhrN6WO7wna+U1nJkKFQLOLDkOSgKZQFJ8tF7yiPM8hXWp
 53oTfsONi/Zqrjdd24Ktja0FoDQMchiD/vpta66mk2j5REErZgyXj5l/
X-Gm-Gg: AYBFou2ngFHWf/LS2h0ox/BYs9SXXGoB16f/O4aiij27psXNqMgAv1dMk+W3wnbjI6o
 izMre73ef1Hf2LargNGF+NZNdSIubr/MGMSvcgJn+svgFmxzBFMOm/KxhgrNkBFWkm0s9Q1zGQ9
 5z/ht1GqKq9Xfs71BGQKJOXzBjM1HT4NrhaI6Gosb6l8BjR/oWlQdADcZdAOOfA3vFaCsxdjp5P
 VWwIa42m22HiXuixFxlaOB/CgNBC/ZpQipALtKdoTyaMS1RFqO2BRzb4bTrqtlyX00Tl4OrR/kq
 WtrpO6ZAYLkfwUUso8IzXOVkMmNWYBIJ0F1jEdA7ZuYtEj2AqMKxkjeW2faMcwxAmigwWueYOfl
 oHnxxBtNLvnVEK9BU43fK9rBG1KEEmuk4CDXetVtgSXucsOiZfgyuRj8IylhOLxDV62+UgPpOSF
 wSSppMx1izZ/F4IdibklykQJgU8FEq/a1o1TWZL8RIC1DHMH0eRYdfDpKvGjWDg3ylendWidvso
 5Lf5tVL0/8bM0dG69a0yEYWXu6ade2lFYHTTj9t/Av1FvcXFz2GKO3CRNwEVnrB088qlNom4EbL
 N5MhWRy1bSpSxgoacol1+59U4gHF++8z0R4ATNLZlm6i4+7XsrapiLU+AUYK7erWSBVMZGHlPXz
 ViReuCw+vKRi2A7OOkjIsSY3A+Yv6U2hOV+ZXNCPb1A9nr9uknrR+6PpzOhb8fOBCvCEcSXKkQU
 jJqkM=
X-Received: by 2002:a05:6808:1804:b0:4a3:3108:866a with SMTP id
 5614622812f47-55c0026d2b0mr1700441b6e.17.1792881335577; 
 Sat, 24 Oct 2026 15:35:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:59 -0600
Subject: [PATCH v2 12/16] net: lwip: preserve interface state across
 network retries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-12-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
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

Reuse the Ethernet device already started by net_start_again() when
attaching the replacement lwIP runtime. Starting it twice can reset
freshly initialized state and lose packets.

Clear the previous attempt's wrap marker before selecting an interface,
retain the new marker for BOOTP_MAY_FAIL, and preserve the legacy
ten-second wait after rotation wraps. Keep polling and allow Ctrl-C
during that wait. Callers still detach their runtime on all errors.

Exercise start/stop counts, wrap handling, the delay and cancellation
with the sandbox Ethernet driver.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/sandbox/include/asm/eth.h |   6 +++
 drivers/net/sandbox.c          |   6 +++
 net/lwip/net-lwip.c            |  72 +++++++++++++++++++-------
 test/dm/lwip.c                 | 111 +++++++++++++++++++++++++++++++++++++++++
 test/dm/lwip_dhcp_policy.c     |  19 +++++++
 5 files changed, 195 insertions(+), 19 deletions(-)

diff --git a/arch/sandbox/include/asm/eth.h b/arch/sandbox/include/asm/eth.h
index eb7c7ab940f..a23b2924fde 100644
--- a/arch/sandbox/include/asm/eth.h
+++ b/arch/sandbox/include/asm/eth.h
@@ -90,6 +90,9 @@ typedef void sandbox_eth_free_pkt_hand_f(struct udevice *dev, int len);
  * recv_packet_buffer - buffers of the packet returned as received
  * recv_packet_length - lengths of the packet returned as received
  * recv_packets - number of packets returned
+ * start_count - number of calls to the driver's start operation
+ * stop_count - number of calls to the driver's stop operation
+ * restart_wrap - inject an Ethernet rotation wrap on start
  * tx_handler - function to generate responses to sent packets
  * free_pkt_handler - function called after releasing a received packet
  * priv - a pointer to some structure a test may want to keep track of
@@ -103,6 +106,9 @@ struct eth_sandbox_priv {
 	uchar * recv_packet_buffer[PKTBUFSRX];
 	int recv_packet_length[PKTBUFSRX];
 	int recv_packets;
+	unsigned int start_count;
+	unsigned int stop_count;
+	bool restart_wrap;
 	sandbox_eth_tx_hand_f *tx_handler;
 	sandbox_eth_free_pkt_hand_f *free_pkt_handler;
 	void *priv;
diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index b03d83dc86a..f64683c64ef 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -415,6 +415,9 @@ static int sb_eth_start(struct udevice *dev)
 
 	debug("eth_sandbox: Start\n");
 
+	priv->start_count++;
+	if (priv->restart_wrap)
+		net_restart_wrap = 1;
 	priv->recv_packets = 0;
 	for (int i = 0; i < PKTBUFSRX; i++) {
 		priv->recv_packet_buffer[i] = net_rx_packets[i];
@@ -480,6 +483,9 @@ static int sb_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 static void sb_eth_stop(struct udevice *dev)
 {
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+
+	priv->stop_count++;
 	debug("eth_sandbox: Stop\n");
 }
 
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index ac8d3906fd9..df11322ec3b 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -3,6 +3,7 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
+#include <console.h>
 #include <env.h>
 #include <image.h>
 #include <dm/device.h>
@@ -22,6 +23,7 @@
 #include <net.h>
 #include <net/pcap.h>
 #include <timer.h>
+#include <time.h>
 #include <u-boot/schedule.h>
 
 /* xx:xx:xx:xx:xx:xx\0 */
@@ -367,21 +369,9 @@ static int net_lwip_configure(enum net_lwip_addr_mode addr_mode)
 	return 0;
 }
 
-/**
- * net_lwip_start - Attach a client to the shared lwIP runtime
- * @ctx: Zero-initialized client attachment
- * @addr_mode: Initial IPv4 address configuration requested by the client
- *
- * The first client starts the selected Ethernet device and creates the lwIP
- * network interface. Later clients share both resources. Strict environment
- * clients and address-less clients are mutually exclusive. Flexible clients
- * can remain attached while an address-less client temporarily owns the
- * interface configuration.
- *
- * Return: 0 on success, or a negative error code.
- */
-int net_lwip_start(struct net_lwip_ctx *ctx,
-		   enum net_lwip_addr_mode addr_mode)
+static int net_lwip_start_ctx(struct net_lwip_ctx *ctx,
+			      enum net_lwip_addr_mode addr_mode,
+			      bool eth_started)
 {
 	struct netif *netif;
 	int ret;
@@ -402,9 +392,12 @@ int net_lwip_start(struct net_lwip_ctx *ctx,
 		return -EBUSY;
 
 	if (!net_lwip_runtime.users) {
-		ret = net_lwip_eth_start();
-		if (ret)
-			return ret;
+		/* net_start_again() already selected and started the next NIC. */
+		if (!eth_started) {
+			ret = net_lwip_eth_start();
+			if (ret)
+				return ret;
+		}
 
 		net_lwip_runtime.dev = eth_get_dev();
 		netif = new_netif(net_lwip_runtime.dev,
@@ -443,6 +436,25 @@ int net_lwip_start(struct net_lwip_ctx *ctx,
 	return 0;
 }
 
+/**
+ * net_lwip_start - Attach a client to the shared lwIP runtime
+ * @ctx: Zero-initialized client attachment
+ * @addr_mode: Initial IPv4 address configuration requested by the client
+ *
+ * The first client starts the selected Ethernet device and creates the lwIP
+ * network interface. Later clients share both resources. Strict environment
+ * clients and address-less clients are mutually exclusive. Flexible clients
+ * can remain attached while an address-less client temporarily owns the
+ * interface configuration.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+int net_lwip_start(struct net_lwip_ctx *ctx,
+		   enum net_lwip_addr_mode addr_mode)
+{
+	return net_lwip_start_ctx(ctx, addr_mode, false);
+}
+
 /**
  * net_lwip_stop - Detach a client from the shared lwIP runtime
  * @ctx: Active client attachment
@@ -492,6 +504,8 @@ void net_lwip_stop(struct net_lwip_ctx *ctx)
  * Stop the current interface, select the next interface according to the
  * normal network retry policy and attach @ctx to the replacement interface.
  * A shared runtime cannot be restarted without disrupting other clients.
+ * Wait ten seconds after wrapping around the interfaces, as in legacy.
+ * Callers must detach @ctx even on error, including an interrupted wait.
  *
  * Return: 0 on success, -EBUSY if other clients are attached, or another
  * negative error code.
@@ -499,6 +513,7 @@ void net_lwip_stop(struct net_lwip_ctx *ctx)
 int net_lwip_restart(struct net_lwip_ctx *ctx)
 {
 	enum net_lwip_addr_mode addr_mode;
+	ulong start;
 	int ret;
 
 	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
@@ -510,11 +525,30 @@ int net_lwip_restart(struct net_lwip_ctx *ctx)
 	addr_mode = ctx->addr_mode;
 	net_lwip_stop(ctx);
 
+	/* Retain the result for callers such as BOOTP_MAY_FAIL, but do not
+	 * carry the previous attempt's wrap into this interface selection.
+	 */
+	net_restart_wrap = 0;
 	ret = net_start_again();
 	if (ret)
 		return ret;
 
-	return net_lwip_start(ctx, addr_mode);
+	ret = net_lwip_start_ctx(ctx, addr_mode, true);
+	if (ret)
+		return ret;
+
+	if (net_restart_wrap) {
+		start = get_timer(0);
+		while (get_timer(start) < 10000) {
+			if (ctrlc()) {
+				puts("\nAbort\n");
+				return -EINTR;
+			}
+			net_lwip_poll();
+		}
+	}
+
+	return 0;
 }
 
 /**
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index 5e3d26eaccf..8bb7e2bad9a 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
 
+#include <console.h>
 #include <dm.h>
 #include <env.h>
 #include <lwip/pbuf.h>
 #include <lwip/udp.h>
+#include <lwip/timeouts.h>
 #include <net.h>
+#include <time.h>
 #include <asm/eth.h>
 #include <dm/test.h>
 #include <linux/kconfig.h>
@@ -375,3 +378,111 @@ static int dm_test_lwip_runtime(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_lwip_runtime, UTF_SCAN_FDT);
+
+struct lwip_restart_test {
+	unsigned int ticks;
+	bool cancel;
+};
+
+static void lwip_restart_tick(void *arg)
+{
+	struct lwip_restart_test *test = arg;
+
+	test->ticks++;
+	if (test->cancel)
+		console_in_puts("\x03");
+	timer_test_add_offset(1000);
+	sys_timeout(1, lwip_restart_tick, test);
+}
+
+static int lwip_restart_check(struct unit_test_state *uts,
+			      struct net_lwip_ctx *net,
+			      struct lwip_restart_test *test)
+{
+	struct eth_sandbox_priv *priv;
+	unsigned int starts, stops;
+	ulong start;
+	int ret;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("netretry", "yes"));
+	ut_assertok(net_lwip_start(net, NET_LWIP_ADDR_NONE));
+	priv = dev_get_priv(net->dev);
+	starts = priv->start_count;
+	stops = priv->stop_count;
+	net_try_count = 1;
+	net_restart_wrap = 0;
+	ut_assertok(net_lwip_restart(net));
+	ut_asserteq(starts + 1, priv->start_count);
+	ut_asserteq(stops + 1, priv->stop_count);
+	ut_assert(eth_is_active(net->dev));
+
+	/* Exercise the wrap signal without depending on sandbox's NIC count. */
+	priv->restart_wrap = true;
+	start = get_timer(0);
+	sys_timeout(1, lwip_restart_tick, test);
+	ret = net_lwip_restart(net);
+	priv->restart_wrap = false;
+	sys_untimeout(lwip_restart_tick, test);
+	ut_assertok(ret);
+	ut_assert(get_timer(start) >= 10000);
+	ut_assert(test->ticks >= 10);
+	ut_asserteq(1, net_restart_wrap);
+	ut_asserteq(starts + 2, priv->start_count);
+	ut_asserteq(stops + 2, priv->stop_count);
+
+	/* No inherited delay on the next retry; Ctrl-C cancels a new wait. */
+	start = get_timer(0);
+	ut_assertok(net_lwip_restart(net));
+	ut_assert(get_timer(start) < 1000);
+	ut_asserteq(0, net_restart_wrap);
+	test->cancel = true;
+	priv->restart_wrap = true;
+	start = get_timer(0);
+	sys_timeout(1, lwip_restart_tick, test);
+	ret = net_lwip_restart(net);
+	priv->restart_wrap = false;
+	sys_untimeout(lwip_restart_tick, test);
+	ut_asserteq(-EINTR, ret);
+	ut_assert(get_timer(start) < 10000);
+	ut_asserteq(1, net_restart_wrap);
+	ut_asserteq(starts + 4, priv->start_count);
+	ut_asserteq(stops + 4, priv->stop_count);
+	return 0;
+}
+
+static int dm_test_lwip_restart(struct unit_test_state *uts)
+{
+	const char * const vars[] = { "ethact", "ethrotate", "netretry" };
+	struct lwip_restart_test test = {};
+	struct net_lwip_ctx net = {};
+	char *saved[ARRAY_SIZE(vars)] = {};
+	int i, ret = -ENOMEM, ctrlc_state;
+
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto out;
+		}
+	}
+	ctrlc_state = disable_ctrlc(0);
+	ret = lwip_restart_check(uts, &net, &test);
+	sys_untimeout(lwip_restart_tick, &test);
+	net_lwip_stop(&net);
+	clear_ctrlc();
+	disable_ctrlc(ctrlc_state);
+	net_restart_wrap = 0;
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		if (env_set(vars[i], saved[i]))
+			ret = -EINVAL;
+out:
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		free(saved[i]);
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_restart, UTF_SCAN_FDT | UTF_CONSOLE);
diff --git a/test/dm/lwip_dhcp_policy.c b/test/dm/lwip_dhcp_policy.c
index d60bebcd86b..1e55a0c097a 100644
--- a/test/dm/lwip_dhcp_policy.c
+++ b/test/dm/lwip_dhcp_policy.c
@@ -104,6 +104,8 @@ static int dhcp_policy_check(struct unit_test_state *uts, struct dhcp_policy_tes
 	};
 	static const char * const invalid_interval[] = { "0", "32767501", "4294967796" };
 	struct net_lwip_ctx other = {};
+	struct eth_sandbox_priv *priv;
+	struct udevice *dev;
 	char * const argv[] = { "dhcp" };
 	char name[256];
 	char max_timeout[32];
@@ -195,6 +197,23 @@ static int dhcp_policy_check(struct unit_test_state *uts, struct dhcp_policy_tes
 		ut_asserteq_str("eth@10003000", env_get("ethact"));
 		ut_assertnull(netif_default);
 	}
+	/* Runtime restart must retain the wrap signal for BOOTP_MAY_FAIL. */
+	ut_assertok(uclass_get_device(UCLASS_ETH, 1, &dev));
+	priv = dev_get_priv(dev);
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	*test = (struct dhcp_policy_test){
+		.fail_first = true, .bind_after = 1, .ticking = true,
+	};
+	priv->restart_wrap = true;
+	sys_timeout(1, dhcp_policy_tick, test);
+	ret = do_dhcp(NULL, 0, 1, argv);
+	sys_untimeout(dhcp_policy_tick, test);
+	priv->restart_wrap = false;
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) ? CMD_RET_FAILURE : CMD_RET_SUCCESS,
+		    ret);
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) ? 1 : 2, test->packets);
+	ut_asserteq(1, net_restart_wrap);
+	ut_assertnull(netif_default);
 	ut_assertok(env_set("ethact", "eth@10002000"));
 	ut_assertok(env_set("netretry", "2"));
 	ut_assertok(env_set("ethrotate", "no"));

-- 
2.53.0

