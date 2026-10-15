Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CC3CCA461
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C627F408B0;
	Thu, 15 Oct 2026 14:23:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5seLi86ibFuf; Thu, 15 Oct 2026 14:23:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2795E408AF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074220;
	b=GVJ+rKfC1NwfgUAgDjKa2qEHyRM21G8p7PYtSK3hdSfg1/1TALyKkmQTmZvvkGzoZsi7
	 zx9eu0XP3M/CM+IiysvmxvI2RxaDZ0VFdDg9kZkBstMpmKjc44NB20PrB59FOwiEaMrbE
	 0O0UtUcWdMTDor7X0OmJWUbBys/2U1Brnfmg1zqKOMOmZjfsVW1caxAW/Pj4Qwsw1otgq
	 /gCHdc7EPYHqQxbIzasCv9+iTYYCrufZKvt+pJhJGxkwaWnupS93HeUTMVYz0F3U0eQdw
	 cNXOrSVWk9umVMd3FX32rHiq9pw+QZjg12bq7Bd2AAa6ebGuDxTaFjoQGIoQRTY4OUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792074220;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nsHU0UDy8uRkrzVe5NnJGVu8R8BBqTeo2fg+fkkAacE=;
	b=WURk4dzGSQV9fd+8JRhFYaS+iGMiun1Y6kGsUltri3y8URklGJfttkxLWr5CG5hi9qH/
	 a/iGIuxa2k2OZ/OFEQmNbE5A9YI+/Jg4NKr3BFN4Q0182HwBE4P+rgsIDCOMhZ7R6XJAs
	 vUxTSdHjVstWHN9ZSLF8i2/v9lcifP3C7Z5mHTOI+KBB/Q23qHM8VHaIfZ87o4/ISCOzb
	 ek/flGgvXSNJqXmNgJDnXm0JOT1hi+t3poIwQdDax2L0D3fGKZwtAP/ImCZNEknbZhzRt
	 sC8sZ/Ep66bxJpg+yrcDFcZCZzEDNyDyCHy+O+O//pTkLgz1FgoqJNZdJMJ5QrbDNUA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=ijweHbW0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792074220;
	bh=nsHU0UDy8uRkrzVe5NnJGVu8R8BBqTeo2fg+fkkAacE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTtvvuQvCcY6W1gVRbWuBch/XJn8MIJmtz8NdgRm6NbMymdE/5LosTVYdrEF5iAEo
	 BI+eNuzUkJmo5RluODb1K2Yix7MazakXy1hJBEAEWIewqGpi7RjTFSdkrrEGqAoiAy
	 pgfTRWoRzOPyNRdRMalJJbyX7iXhRpolcVjeiU3k2VCQCzOh8E+Ro9Pu+TBBY+ZHyZ
	 lrRPz5ufdc95eAs8C/NlB5x7DGt5ARIP9Ty5UEx40E3dpRbLrx5crPOXLlYj15kQSg
	 T7TV60yEf10mICHLBXx/k+QiMgxVNsS8LxUx+RX4rTBSsWkpq/LS5sLLXKMqx1BwTV
	 sS0l+RZdj+0Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2795E408AF;
	Thu, 15 Oct 2026 14:23:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DDF4DA58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFAEE408AF
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z6wz11aCeKfr for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE7C8408F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792074216;
 b=aM9EwVF0/uBfaYmlqxGfAKR3VyK0hu8KUW6TDzrZNCTRyK8+0rIeiKD9x49XVKqeFyD4
 HtN4DxH3dJkE43sAhuiCtVbGYfwGftzdhWRO1nZTqsOVyGfQbjFwGcYDGtdiOwjfvusZ+
 U4LgI8RCDGep1fgjqLPsBW3Ee0aKGqtjQFMYXhcXcVepoXnx6c0OSEU8GUI9znbt4Ny9A
 34Qn//iNUpH+htYprb25ikzmwkVmAI7ufWdYf0E8ulM3of8wC4FBOF7nX36Ge96+10Z9Q
 r6BThX4j+CM9kIrJN3rXn4QyRLD3OOXRhjqc8RLYu3Fj+5bt57Ew6qexlpIfswBQ+4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074216;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=nsHU0UDy8uRkrzVe5NnJGVu8R8BBqTeo2fg+fkkAacE=;
 b=ktxJgS3zKSQUK/GqFhD2xaVI57QiU3b1lvAfqnhQ3CfhDU/LPtlE176GX+fPJdALxo0j
 p+GBmtAIxEBnUYapTt7e5ZXfJGF/vLmuh1V1HrIVsFCoNhOLOBuIcvZcz7cwBJdsoR0bu
 duK42qcYrsdA/yyamy97VenYkYMqhw8yufPv9LUPZY+yC7FZbR1wQ7aXNJkQvViGRJt7H
 W1DCO+kWH9E/pgKRgqnR+fotl0NoKnbSpEWyLCRIWOZN01W9xEvSPyiWsWcF/Qwq6MrvY
 gCLYIteeHr1kEcF9/Mo3HPxXQcEU5/irPf6+Gs7WohHFX1nbl8+1NIVcS+brjkFxLFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=ijweHbW0; 
 arc=none smtp.remote-ip=185.136.65.228
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 14:23:35 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=ijweHbW0
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.228;
 helo=mta-65-228.siemens.flowmailer.net;
 envelope-from=fm-294854-20261015142229544723e0690002079a-nfntca@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE7C8408F1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:23:35 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20261015142229544723e0690002079a
 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 16:22:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nsHU0UDy8uRkrzVe5NnJGVu8R8BBqTeo2fg+fkkAacE=;
 b=ijweHbW0aGufLmHURSW/AtuJ9903S1ZO/AnjxZALIJOgoiPAUpcm3D6PguEyuwL3XT62sy
 p6KH2n9xlYLrrZ+DsM/kfEJXsgWZV4up+Lzlrcp/GkhhVJmiAHeL5hLDYATgrHTLpyzQWYRZ
 YmTkcD5kax4QI4nTxZukrTyCiporQTIK3cAA5i9Y14lz6trPGoveB5gi2BH3XxUxLZp5/HIc
 u3VzMkqo0L2YniZlzlbG/p6e2H2YTMUJnuNT4DjxbU7+0O+GAreYjZcfBLNzQw01URzdU1EX
 53prxtFwnfAVpgxNU17DzJvZ96tYETevIBj0yTeMnOsr42EFPJGyl5XQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 2/3] watchdog: add support to call initr_watchdog multiple
 times
Date: Thu, 15 Oct 2026 16:22:20 +0200
Message-ID: <d5a8d75458092ce7c2fde91003f962ec8a5c49f7.1792074141.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1792074141.git.jan.kiszka@siemens.com>
References: <cover.1792074141.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to invoke it from board init code once more if probe
ordering requires this. In that case, avoid to re-add already activated
watchdog devices.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/watchdog/wdt-uclass.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 88c5cbdf508..338b03f0121 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -105,6 +105,13 @@ int initr_watchdog(void)
 	}
 
 	uclass_foreach_dev(dev, uc) {
+		/*
+		 * initr_watchdog might be called multiple times to resolve
+		 * for probe ordering issues. Skip already activated devices.
+		 */
+		if (device_active(dev))
+			continue;
+
 		ret = device_probe(dev);
 		if (ret) {
 			log_debug("Error probing %s: %d\n", dev->name, ret);
-- 
2.47.3

