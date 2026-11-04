Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF4606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NN73lifE;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pSC/9n+L
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59C6560850;
	Wed,  4 Nov 2026 09:41:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w-oXNSpnSjEI; Wed,  4 Nov 2026 09:41:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA82C60822
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785264;
	b=kv4W/j91nTtOAOSm7/jQAIlANcLguynUdeJae2IKR2U3+X0TSCD81TfIXa/E9ZyFi2h8
	 NnEDjcPTVKPZzT4D+WA22mG9bH4exenVKMo3N1t+YdNhm8KYvLFhTLjmFyxYtiUAnw3r5
	 FMFqOt8EL0POKar8P2DWvxScJ1v8R6yNRx+rlS3RoZJPriO0d6CsA6tddIjPfnbNAftHx
	 cHGh661Kmhf8+88a7AzwkaCHlG0axJdGRwQJrb+fTEdutCenO1ziyPBaKwcb9NIdz1xDz
	 A3GuyPp+P1sNeQXXGsqBp27wrrEHza6+TS1V3ERytT78EXuNdREMsLUMr3qso5twOuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
	b=IM6NQaLN8kQdp4DqBTAuGf8IZHMbV+W21o/MD5RNJ/Jom++dQSWO9STIBbolvLCsnxiz
	 DkYmZHcoHmV+cEBzBTDPNevSt5uz/E1LpR3AbUC3+lPuL5m4xsCBT7xCqlQcAFnBgWLKe
	 +1cyT2tkKh+hYPPC6lyojyj7IaK+zKAvo1q4z+8GyhGL/Tmg2suJLYSS7COlUHKBGvNU3
	 zhO6HoJ8PfKPLpnKeZl/W7WBUQ52TVlRREsA/HMEnV/BVgd9e+/IMkz3HnijUEfj/RmmS
	 ahtZvTtG46BBNhaWmicOvu0CquyGqvWwviaOD6gvtNGdmzCjS98TYibtS45CRYMv97g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785264;
	bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NN73lifEkMQ29EgdMqrYBHJl9fl9gQ5ma2O/AeiMB3gilDf94JAuqm1A5/YVP+IwD
	 3IY5RIhQ/Bd8bqMPagmLahOc3erZz4xG1J2kzLj4YvQ1UP5dBLyejpyzn6qXDL8P/d
	 1xX/Qf68CN6KZt0U7Z4gENTG3kIrkvDz7ZmySSixegOcfcUAogsxQSO4DkvEOGl6lx
	 SjqCgDil6KnJ8jW4UOzs4kqF+3lrXS8fVykvh5w/pB9avXgv36xbj0YEkO+dSlwCHI
	 w+ZTBTxLjMXam6fqDNONlBL9KedDKzthxBdPZ9+R3JQGoDmd2+Wc39wSdEBahAmL5S
	 z00HmtGCaNBtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA82C60822;
	Wed,  4 Nov 2026 09:41:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AEB8411
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00B8E80F5C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5B2dqXVHjvYO for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:40:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 72EF280F3E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785258;
 b=hiwNJxyQHYkxlWAlwDe3G6itn/vv5LEqszRJZGu/ANjAdDEAXPvWUxONdT22+/7ozBM6
 mKcAbGNBW2SMEUkSfN+g8gUae+UFzQTPf0hTPXaWDy2Paqwzc1A9BSDrp+xJHY6Hd/9lX
 2s0FvnQTutenx1N3W2XWZ/JYMBS5D8qlVWLjDLyNzgs2hER7AZrwcvxZ0Ah5toTVlh26C
 sPgAi4m8n4vrn3ly8uJTKsSpqrWaGAZ721Q/bfNshe/6PZyefsdOFVHZgnZg3OS+xSk97
 jUyYxHSkAcYMvL9jSeSpqRElgEsZQ/ooeNXTNld+fVrsg/zVgoMtyPqOTVnOD/GiAkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785258;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
 b=Iq5v9/HvEYD8XiKgFg/OaoeLG+r2dyvxEJPQ2iJdLb4szUPtfMKKvqlS7DWYMkNrS+t9
 rQJ2n/krYu1uAz0CSC0rTuZx52tecgIB8Y2ClTaSWVoLSuohpzu29T50Aqo249ZVjx7LN
 DCI8VO6E1NJd4GLW00l79cpqQSrZvEDnPyBgzGH2/5AqQ2Dxc5I+U4GWL61XZ4pB0Ngyf
 usXX0ODn91O1xGUbSmcHJekCn3bLFd2RPzej7vbG+5DiX9QuRim9jkr3KMghmgFhxbHrQ
 Jc7fq7WkJrwUVP7PRhPQmnL4e39uOHX6wWjJd4uORGh5TfJ4ilI2VdJcpXQz311hVoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="pSC/9n+L"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pSC/9n+L
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72EF280F3E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:40:57 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so4105755e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785256; x=1794390056;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
 b=pSC/9n+L8Uj98OmkoNeeG7mMLw6qLI5VZ6XYdescYBuTEBZ/3Z8PJ++/dxBCM/kNJ4
 2xqb+hPLfRNiVaeanbkd10+OaLp3obZuC9RT1EHHpH7frDtA3msZcCWwpz8+Gs+28sw6
 /QRqgQrwFRLAMUOncv25M2M70iqFcS98uWY/4WZMpCGvkuhgvvsHRNTtLRVH9NAFGBHW
 loT1GeZPaBtUP9y57t/fzLAaS/13tqqLqw8Qbq70Mqk2la5sBvb7zQN2Ht9Hcz7Ea3ho
 56J5EAGmHrtl+yYo0v9nb2OJEqDoL4EsjQf83bfM5FBUp/miaT07ANYElTxZcAaXYkob
 oGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785256; x=1794390056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
 b=NMy2kUcFDFl7EIgOlxH8FoYuoAFJrUFbPaBAFlLOj+EIF5XvqxKhLwRP7TxWqTF5lV
 t1KuiFMZlQymFAC6jucE0FHVT81HQ7nIbkGkoYeeZgmXCDqTP7ql5cOUur1RorIL8dc8
 daoShsrfvh56LbHSUzDls6YMtdoG5zYv9BwpC1/3v9OtQ9+K1PYL9gxAM0xN0fR5qJRE
 65WzMqWqio6oO1ilQyLbbrC/qGfsGgy7G1w1t5WOaSp7O+yVYjr/pS2oUYlHvKBjGcMk
 n5sDMa9QHj4rdeklK7wZZwmXBylEVlRzY64Wd1apetn7gOFKaWZ44Y7NsbXKnIQA5zH7
 pnPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNQwuSsxajT2vyXL9DbrVJ8b0cJ2sg8IQrQaGLiJTBPWtt/rpPatfSR3oSXekQPNbZ5zba3js=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+twwL/pxETy0FaAFFylOi+1KPOQ0wFo76xWp8L6WG2aJy4Re6q
 nKq68okRWxabconVJUFVPUg230Sw9Cy3UKjkiEig45XzWKh8Hcvvigh/mSCLEu9e1D0=
X-Gm-Gg: AYBFou1UFp5ND1NliNu57MXRBbAWzqog5g2hAlki2wYfBX8vF0CLdtjrA+4tTcJanTq
 HRzl0OwZ9XhpDvb0MobbQBfkIQZGdEHAfaQhUfRZll4bUShRhAkaUfiOAQp28Zg49smgI+Iuc3Z
 2PUfUCA2XNbccyqKeeO6iebPJdZxToeIxsWYQwa3FSkfvKnKshUYzCC6UuwEj6xcjg4qGFVdRtv
 T1SdlLO9OezSNni7knIXK1EFNOKhBkIEDW4dfBSbZB+0R89IcDAuTWnegvXf/leM63WzMOdNjBP
 hJIUeuPnyZe0G3pzlqGwfVyDESjPVmjdyX08pdotI4ioP82kOQyTk3fhwUalfwkn9i+KH41a+yo
 pWw9MdMMeMzIXUoccPa3ItdsaNxUi/4FVKyEnkB2j6FxJL/nbfpAJXSzZipnEHQ1IQoTTq3ROnG
 yboEviPcHppUGKSnPoXtQX2eHdpg6wY1CW/Oros68JIoEX+OGdd//BhHv1p5GNWu2nY2V02nbMQ
 o6HSq2sIsmLwRMk03G6ot/NiqP/+AnA/eFZULOIJTFoR/yPliOnIs1MKMIRmeH4xSFZPP6Jz6dG
 70aNBEfVZBIb0Bv7ZkHS02sZtO8Ah3khh4j1JN6lAlUUP5eSrR87V0y4sONezr0yrOC+248AdiB
 ZK085y5g9f39E6N5824k/Ob1p2hRNcyRB9VLcUOt0oQp44w==
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr371733065e9.13.1793785255894; 
 Wed, 04 Nov 2026 01:40:55 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4527fed5bsm49856945e9.3.2026.11.04.01.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:40:55 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 10:40:22 +0100
Subject: [PATCH v2 2/7] fastboot: invalidate stale and incomplete downloads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-spl-fastboot-boot-v2-2-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
To: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A new session or download must not retain the size of an earlier image.
Otherwise a failed transfer can leave commands operating on stale or
partially overwritten data. Only mark a download complete once all
expected bytes have arrived.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/fastboot/fb_command.c | 14 +++++++++++++-
 drivers/fastboot/fb_common.c  |  3 ++-
 include/fastboot-internal.h   |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 63b0f5705fe..056d95cb1f8 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -318,6 +318,13 @@ static void getvar(char *cmd_parameter, char *response)
 	fastboot_getvar(cmd_parameter, response);
 }
 
+void fastboot_download_reset(void)
+{
+	image_size = 0;
+	fastboot_bytes_received = 0;
+	fastboot_bytes_expected = 0;
+}
+
 /**
  * fastboot_download() - Start a download transfer from the client
  *
@@ -328,11 +335,11 @@ static void download(char *cmd_parameter, char *response)
 {
 	char *tmp;
 
+	fastboot_download_reset();
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
 		return;
 	}
-	fastboot_bytes_received = 0;
 	fastboot_bytes_expected = hextoul(cmd_parameter, &tmp);
 	if (fastboot_bytes_expected == 0) {
 		fastboot_fail("Expected nonzero image size", response);
@@ -436,6 +443,11 @@ void fastboot_data_download(const void *fastboot_data,
  */
 void fastboot_data_complete(char *response)
 {
+	if (!fastboot_bytes_expected || fastboot_data_remaining()) {
+		fastboot_fail("Incomplete download", response);
+		return;
+	}
+
 	/* Download complete. Respond with "OKAY" */
 	fastboot_okay(NULL, response);
 	printf("\ndownloading of %d bytes finished\n", fastboot_bytes_received);
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 9184bc6346d..59a08018a79 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -15,6 +15,7 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <fastboot.h>
+#include <fastboot-internal.h>
 #include <net.h>
 #include <vsprintf.h>
 
@@ -261,5 +262,5 @@ void fastboot_init(void *buf_addr, u32 buf_size)
 				       (void *)CONFIG_FASTBOOT_BUF_ADDR;
 	fastboot_buf_size = buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
 	fastboot_set_progress_callback(NULL);
-
+	fastboot_download_reset();
 }
diff --git a/include/fastboot-internal.h b/include/fastboot-internal.h
index 610d4f91414..41411601da3 100644
--- a/include/fastboot-internal.h
+++ b/include/fastboot-internal.h
@@ -13,6 +13,9 @@ extern void *fastboot_buf_addr;
  */
 extern u32 fastboot_buf_size;
 
+/* Invalidate downloaded data when starting a new session or download. */
+void fastboot_download_reset(void);
+
 /**
  * fastboot_progress_callback - callback executed during long operations
  */

-- 
2.56.0

