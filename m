Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3856DC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA68A407BA;
	Thu,  6 Aug 2026 13:05:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3QU3AR2rw0hS; Thu,  6 Aug 2026 13:05:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59D0540799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021519;
	bh=xchkT2DqyNwwSqVr3EUXvxQzU0mq2L6qK8EGQcObw3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wZevxJUVVragn0eNoe35tc8crAopcGh9VVcwJlVpV9d+eWldMFq9PDfnTGfX6vOeM
	 7mJquhP+nYBtFhxdlUFC+MZ4xrEMhDZLUuPsc5gGEADjxz8V7DxRqyP0nAxZxwLfG1
	 uQjrxao08+wKVeHNrJ31cld+XZcaP6t1/R9w9Dn30U5xJqRt43i2sofOTbEpkCBFgf
	 +KyUrCMIes+20Y9mmvlcovew84y5W8xqEJpQIR6LuQIfNmigH4u/ORLDTYJODtSM5d
	 Npdu/RZqB4M8dHsFZF4SQSfhSU0AQok6ENtwKwGi+oWmlOJ2/dayNyWbRBNdqh9Z4r
	 /Ao2rpIPFXQNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59D0540799;
	Thu,  6 Aug 2026 13:05:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FB4328C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6169E405A3
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6ptU1s6Feo9 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:48:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 826394059A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 826394059A
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 826394059A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:05 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso24063925e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786020483; x=1786625283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xchkT2DqyNwwSqVr3EUXvxQzU0mq2L6qK8EGQcObw3I=;
 b=U2Ye/u843djnz+PiT/Yj8z2zUwfobNiKu+n+l6bcilosCv/QlJnFewqPM60sLS9EhO
 baUHv4CGWfah0MLg0jE0zAvUhG4uLAFQ3KIu492h04X+JacoFT5y0mPmxSmyVmRffTVF
 PUKNa/4a65b4CdsRDbMRLKGVxY1ntCS+IYJuCGRr3IYlIPwwqB76JIxaIzfUpJL5kQ+T
 BXMPs/hKeqZM8vk3GVthhLKc3TbHMyrkHuZE0D8qDhMpcfyaaGZCLX2lFLDr9alpsBo4
 TbuHYORCisTPxKy6YgZFBMKKFjD0sZTotv6WGb2aOuoRLyxrQo2Ov+kKNiFbD6OTIagN
 dn5A==
X-Gm-Message-State: AOJu0YwHQp4PhIgTuO9Szo6ZN1BxxMwWcZrTW1AcHSjLsmLimwyQI66o
 10Tky5Fx18O4P5SssYBbydF1A/SCp0iAMHjLNbKAhw6H2lh/QzzRXxHjl+tfw8tm
X-Gm-Gg: AR+sD10sL8uVg+cTGWJMX/bqDsPjMByqWXJPL0Wi+ZFZIMTMxvNDw2DVnjfbu5xnnhc
 5hvGfinY07iQlEoM9Wh0toJaG6Vg+phZ5IsjijJj+dTFAV+S+PYbKBSPBnSrRCuVWKuzY052ek4
 myQWTqW6uHNNsUhI8sSejmLp+9fPt0gPalxljnQxVyngoH99QFsABJWfudhS9tu/L3w6p9xKfiB
 n4g7ONOqEYq0onE8Qe0Y/EsoUTvLUPSaoP/V4aICWjZd9cxNvx/P8nmEDI/GEmeBygP3f4ttI/G
 PYrEdxaXSiJT0dc7Hp5GGxr+xXdkerhdigfwVERw6Wrvo3tMxN21kliiqHBbZcnEYSqg4539cSG
 XfT/a8uwJ6TTJbspa87CHYNUeS2Rv9f8HPyX3ODRztafAvmcohOjRKscUjqBOfhfP2LhQn4GcRv
 CVqj9ECMdD3SVdSUTzYtFG762wwvbn26kzwHs/UsDXa1T5j0HiY8yEHW1ITOtOuHFIhJdsXCrqc
 USYzEU=
X-Received: by 2002:a05:600c:35c4:b0:499:4dca:aa4 with SMTP id
 5b1f17b1804b1-4994e70ed73mr196880065e9.4.1786020483082; 
 Thu, 06 Aug 2026 05:48:03 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b183b2sm6662832f8f.24.2026.08.06.05.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:48:02 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 2/2] serial: lpuart: test the receive flag,
 not the FIFO counter
Date: Thu,  6 Aug 2026 14:48:00 +0200
Message-ID: <20260806124800.262013-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806124800.262013-1-mehmet.fide@gmail.com>
References: <20260806124800.262013-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786020483; x=1786625283;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xchkT2DqyNwwSqVr3EUXvxQzU0mq2L6qK8EGQcObw3I=;
 b=rooYLa9zep7zq0Se5QELHWSTlFyOlAZW0tmZtUfiFIINO3nWug3qFM51yXCsgCBEdD
 CguVJNcodQeMnjyGl+EyR+smt4FLCMNXgvQJNNvRQYzop3PClU6HFxEL2FEI/WlXYGfg
 E0BZf167K6068+V71Lhz5BLM5ZnCJp/5dZvQbAzleSYzIXIFX5k8zi+pXZzmlFziNWqB
 O6AUAxlx5HrYQnriR6ijp8LgXZw01yfELr8KQeVvktxxmHc/E3MEEOcS+xxOlzbpkLao
 vMXSw9rYJD8wxlguZwB2O6clXftANdGb0rFDbqZsqrcUXnRXOHL9iSHmocvy2COgm7sm
 1X3w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rooYLa9z
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

On the 8 bit register variant, the only user of which is fsl,vf610-lpuart,
_lpuart_serial_init() disables the FIFO:

	/* Disable FIFO and flush buffer */
	__raw_writeb(0x0, &base->upfifo);

while _lpuart_serial_tstc() asks the receive FIFO counter whether a
character arrived:

	if (__raw_readb(&base->urcfifo) == 0)
		return 0;

With the FIFO disabled the dataword lands in the data register and raises
S1[RDRF], but RCFIFO stays zero, so tstc() never reports a character. The
console is then output only: autoboot cannot be interrupted, ctrlc() never
fires, and anything polling for a key waits forever.

_lpuart_serial_getc() in the same driver already tests S1, and the 32 bit
variant enables its FIFO in _lpuart32_serial_init() before reading the
RXCOUNT field of WATER, so only this path is inconsistent. Test S1 the way
getc() does.

Tested on a Colibri VF50: U-Boot printed its whole log over UART0 but
accepted no input at all, neither a key during the boot delay nor Ctrl-C
during a sleep, while Linux received on the same pads with the same pin
mux. With the fix the boot delay can be interrupted, including with
bootdelay=0, where the key is already buffered when abortboot_single_key()
checks.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/serial/serial_lpuart.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 9fdb6503085..9c02b3a77ca 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -198,10 +198,11 @@ static int _lpuart_serial_tstc(struct lpuart_serial_plat *plat)
 {
 	struct lpuart_fsl *base = plat->reg;
 
-	if (__raw_readb(&base->urcfifo) == 0)
-		return 0;
-
-	return 1;
+	/*
+	 * The receive FIFO counter stays at zero because _lpuart_serial_init()
+	 * disables the FIFO, so ask the status register, the way getc() does.
+	 */
+	return __raw_readb(&base->us1) & (US1_RDRF | US1_OR) ? 1 : 0;
 }
 
 /*
-- 
2.54.0

