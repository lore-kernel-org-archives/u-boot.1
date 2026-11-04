Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B73606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R7FBoQl2;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=lkgiKNpF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E441B80E95;
	Wed,  4 Nov 2026 08:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qdp7pJyzAQFS; Wed,  4 Nov 2026 08:52:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B6E680F46
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782320;
	b=GCSH1sD+QxvVUv0Nefu6zN0uFYbOhUznTPvoDsTWY9uzx2gUHvVO8TR9D9/jOzF0kX/0
	 q/wIgCw1bzTBuMCb7X5IARR+/d7G3kUoYL8S8CdepsJVihq/WLhzk6q8Gwp0NKyuSOEGN
	 NboNL/OT98oGECDNE32OGOYeFVMY6zsJrfpGC3oYWACRnrAoctSo6qqKIoklLNlTzxxuN
	 ySsjZN5ggBYHeElHVawkP5nRUbbIHzA2ZZb09JMRpaqKD/iGxU+uZZtPjlLh021tNBWjx
	 RkM8X78fRT8ip/ExPrcmvjSl4HpZVd8Exj7J2eAmTNDrYLPVxhYiBRySnKb90/3u9fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pjP8+6Rpk25xx41kblJdcnBzlRb2gprTWz3voisThN8=;
	b=WtujUiktQhSH9+FMrvv3uY7r/KFPEZiLbSw358J19FVs0jM6nJSY4QiZMLDZtjqkr4US
	 sfXwtvoKn8sRPF/EL0aAeFApAUCMyy0wevkbZmavSZHq4lyaJ5exsEP5d5xNN94Y6oH0X
	 THLBgu+AbZk4VdYrz1bGRCVCnMNdIXoyrJ/58sCXGj7OFSfubQXHkl4eXF8WRtKYKOMsd
	 KUq/d855kW0qwYwzWz0OaFtEOaGJH5VbAOcpKIFWU9NoU469XjbjIDXjEUe5H43AmFea+
	 B7sfy3VbmdXc5oalLD/ZO2uYoPoiXhKsQNU4huJhCLSgBUkROYmQ3Bm4YBCx6vGYUpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782320;
	bh=pjP8+6Rpk25xx41kblJdcnBzlRb2gprTWz3voisThN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7FBoQl2cTiP/oS1NeDfIVXJSGK7xoILA02TJt+/KRGng9ZPUfAgzA1PZ+MSyr260
	 QaZzUXvxdlyyVDjLgTFyqDuhIPUQiJEvEhL6C6fHKcdl9Gf7xrZnU0iFORrq3TMLyZ
	 uo/GzsjaLb6Tb6Z/1tN2zgUAYim/TBduZ0nDBEGtzI09UfoafzZo7LhdxfbUgDAxIf
	 ETLq5JyoQTkz0G+8ynNBUJVbl1JumKtdwg3ipERE4Mt+LqXfMbXW6ATqi3IZ7m796q
	 BJaH7B/zP4pCAyWMsRZcpcX0iMnHP/DsVeKmkbclNUu5l4SrvnkBOaT2bO101URGOI
	 7cNWvO3DoZJ3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B6E680F46;
	Wed,  4 Nov 2026 08:52:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 11E64235
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC186401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NTBBRNrf32-Q for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 12AF84004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782318;
 b=PesBA3DXDRpuQ/gAdFrouEuxU0vxAEjsqylhwEYwvU5FFJHkD1yPY73DBMsVGT+GrpAa
 YzDn0ZBCigqPLTohrNqaR6JAwQHWgrvIjFRwR87Es0J9em8ZXq2WJ0bqil4xulsvzGemF
 Mtpqp/jz1TEQTi2SFBUdW9LdVLW4dfDUjXAjRaUbVXeKsqDd3leNTRkuSglWldUDtm3hj
 f3gGxk4jisl3T/0zdmmmHnE12Q1dFkQ7u8eRSeAO6EB7EkweLHdfNvvYW1wesPlS6XdwY
 fKrZJYZmUITBDF3//5WowMeeN9WNXna8hmaE8U3GobagSqb6oXNdJkznf4f2sZdlDnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782318;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=pjP8+6Rpk25xx41kblJdcnBzlRb2gprTWz3voisThN8=;
 b=IbJ4IwPunSz8KhtHCneGGdf/gfbt77sluL6mK7Gsw+00J3oNKOB33QpgRJRz7QScWLwL
 dOxFnUpfudb9eqWG77XwQQbAAyfB0lwgr+uFazcaIdjcHH1TXS66Dwq5rAUPLEiTOZV/0
 uILWZq6gX+7TjZCPwwCYN+2Y9gpwZRV/H7yyq7HSEpRrXjg0Y86c4qCYnxButJq3uMc1I
 uO4kXsN4atE+dyvB3PlD2NzgczYIZz62Y2ZULl7g5GUms6xz51SqAN7pV1oHwaMDbPoKC
 wyicfI+plsJnklIzuevvF11CJbaJKr+QxCw0LNXMhdQLZwT/96Yhm7O3x1o8B161F6A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=lkgiKNpF; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=lkgiKNpF
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12AF84004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:56 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso2554275e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782315; x=1794387115;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjP8+6Rpk25xx41kblJdcnBzlRb2gprTWz3voisThN8=;
 b=lkgiKNpFEMysNPm4v0qvwF4/M92fBTccqCTPLSZxC56VcH90t41iA8zapK45X/R27n
 NFE6bADrV3H0Nap/EOzCXZFUI11AnzxE+6tl3zHvWG4lEZoYT0ruIHXJLFXWNvaNNTyA
 5ZE93HTsT/B77DCI2wjiauaNsC348uDDz9hRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782315; x=1794387115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pjP8+6Rpk25xx41kblJdcnBzlRb2gprTWz3voisThN8=;
 b=oLK8aMEt4AJ/Ke/6y8lR8XXGazANdsetPkR2IIaEJqjQIGB0vM2EItghmr0tKoQ7Ut
 hwW2UoRTjMS5qZJOlRlkPgOR+tmfl6VfUjhOKaTF+9Ixjym74Qc2ATeTASr0SAxQdO5N
 UYzwbgb1nHwizudfnFiqeNnBh0iQpniTjk9Upy04iPCeoac3ccFYavcDIg3SP1GvuxtU
 IXV5/s+Gpj0cJs9r7gIR/UgC2N4CJzwcKIEUXg2SECZG8lwxtqZg26SHo9EVsp6XonYL
 wtQsu3yT8fJ8YoBNPKzieZIu3LuQZ5c7tGtERZEW16ebeEXjlgkiE6kxEbsGuGQpcq1T
 CfSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+DSlY4bvcgACzMi/NQGzWA560HmbUEO9hbc+6O9aCYLUFlP3B1Jeq0JovvHidaxcf/Rx0d+8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z859lnBemQ52anTUu7fpYVqQ3cn3jU6X9v+g1glPfAkGsOXsHjY
 by/t3iF7+jIAaVinrjRABcS62uN2Y94MTmY8DXCCqKeLAFDFBSSwL6+BsTlELVt+Z+Q=
X-Gm-Gg: AYBFou0Qt/XTfrXP/2oVa7qDGEsorJOXaYFVf6XIqeWved/BLwTLXA4jjolLI36e5zr
 nAJpKvAvou0tYk8KDh5EuI+ghIzWtYSg3RhpF/ej/cuH3R4/wXTp4SG5mQ+2/90lV2PuR1OTvSa
 pgsAI+YDcVUa0Z0aTLI9dBdjBc0xFFYpoMjKZHYc9+gQc8E+0vkgD9nlTD/LMlo3SmooXxUl0ca
 gpwWoA4FjWAfSQeGFPAnk0XsUoMawUSV3Az14pMSRiDn7pE+CjxROt72h1ke6AQPBI/HEwTFt8t
 YS7vaWT+P+MQOqzK+iUqJPWFSjKghqcmRP9Nc/EPQjeF8R5beXcdg73hSRsGowSTaxKw1iNyoGK
 3l38Qw5e2qyLUcAt5qANO799g00M4+B1msGTr1I/Z1RUWy/ZI3huJXdt7Zi1TIfFwLKGftQlAtd
 Htil12vlZ/s7cM9j/JBfeJgKFsCXjZOyrL7/bhPIDb8HTLpn6XN/TW9wvXjy7ZEetVSx4RtIRZJ
 2GitPNLUirir45TQtDcbe4/ZduOW+NT1NdJIcSy80XYT9uv0Ogu0lzlh2pbbi1KGq4nxl/55RYm
 twUmpvF6BqHTsYpCs71lgQ/16XfdcZrNv4rcEl98/OYlme+AfZZdC6TT5hlVZxcQ+c+fJytU+34
 QtNLzu6NqfxBCKVX7ImSDf+wWORw=
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4ac187a6960mr354511905e9.27.1793782314857; 
 Wed, 04 Nov 2026 00:51:54 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:54 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 20/33] clk: stm32: propagate rate changes to the parent clock
Date: Wed,  4 Nov 2026 09:49:53 +0100
Message-ID: <20261104085036.4012238-21-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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

Since commit 901e0d95df3b ("clk: stm32: fix clock counter"), the
set_rate operation of the clock is called directly, so the
CLK_SET_RATE_PARENT flag is ignored and the rate of a clock relying on
its parent, like the STM32MP25 LTDC kernel clock, can't be set anymore:

  stm32_display display-controller@48010000: fail to set pixel clock 27000000 hz, ret=-38

Use clk_set_rate() again, which walks up the parents having
CLK_SET_RATE_PARENT set. Unlike clk_enable(), it doesn't update any
counter, so the issue fixed by that commit is not reintroduced.

Fixes: 901e0d95df3b ("clk: stm32: fix clock counter")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/stm32/clk-stm32-core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index cd6bdee5412f..f9a0ba2f5748 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -168,17 +168,12 @@ static ulong stm32_clk_get_rate(struct clk *clk)
 
 static ulong stm32_clk_set_rate(struct clk *clk, unsigned long clk_rate)
 {
-	const struct clk_ops *ops;
 	struct clk *c = NULL;
 
 	if (!clk->id || clk_get_by_id(clk->id, &c))
 		return -ENOENT;
 
-	ops = clk_dev_ops(c->dev);
-	if (!ops->set_rate)
-		return -ENOSYS;
-
-	return ops->set_rate(c, clk_rate);
+	return clk_set_rate(c, clk_rate);
 }
 
 const struct clk_ops stm32_clk_ops = {
-- 
2.43.0

