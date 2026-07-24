Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3242C531D0
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CCD760B56;
	Fri, 24 Jul 2026 01:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVeix_IIDWlY; Fri, 24 Jul 2026 01:02:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40BD060B31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854945;
	bh=bC320+lKimG+Hp+Nafl8k2amRHfyRmCgHEJoc3M6axs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rTBuUXN64mHV/bZo/2FrsnebdXozlpHuJdie1Qsrr/rlR2luGqR2NmxXCrYji0e+7
	 WsZq+pJycgODrJJK3zIcgU4OOBT7bXdcyKZGTyc7syZaH1nzt+mvapKM6xwkHrqicu
	 l/4gkVjhBx9bzJbhq24t1rWyhdHxMajex02tJMdKO/1qJsTDZA6FeFivSAfHv22Pxa
	 8WIIA/rp1Zy6jxsX/+zAv+WeQgIpSS2HKK44jMNvlUNxf/8t8OSYvzN2aZqBhQ5Ifl
	 nqfL14E0Z+vkdrv1A0+xyPo6adD2p7ZInvzE7W+dyryY1sXbteUaEtkawIeQPX09cN
	 9REHx5Z+EA2dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40BD060B31;
	Fri, 24 Jul 2026 01:02:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A99324BF
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A758C40194
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZlq6P6sTMdt for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:15 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2F39F40072
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F39F40072
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F39F40072
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7773D800AE; Fri, 24 Jul 2026 03:02:13 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682BE80117
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:02:11 +0200 (CEST)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-44cedfaab6bso417058fac.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854930; x=1785459730;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bC320+lKimG+Hp+Nafl8k2amRHfyRmCgHEJoc3M6axs=;
 b=KCYcgJNKOfjiyOi+2HuBmCabb2vJW94sjP2Tnm9jwPIRSMvjv0MQUTBVn6XSxlGouC
 BYhdPuyaUz6XUt6HMhnSd/p2n1YZipGOA5lvY/TQ3AoDc5m3FJXLD1hCGxvOwvnCq9aF
 VBq8VfhmWxo4ZOqQmeeGmreBBc7m688414yeDSX+kQSkUpJvE8PLYubDpRZ/2z3mKudu
 n6B10Q9Ax1BQqYUQSkUNaz8DVLQG5jovIL/OYRvLPnJgygqBPs5UxqsBIPfZygyQIeNn
 2T6zYIgkONvYAowU1RH8p73DLSrpRwLCNc6JjyLT659VIwcDXjLSK82/xkn9rz51ycLa
 rhUw==
X-Gm-Message-State: AOJu0Yy7+F96FgenlHkn2e7qBpGVyISm2+Sg8cx86ZfM6uwnU+XTWmND
 sQ6pFhAwlGW610IL2kUHGujtTzEpAXueAm065bmc3M/LOTYUOeAZiLsMuWsZAcb4u68n585d3I5
 CsY0O85o=
X-Gm-Gg: AR+sD10GPrgTA5Zqbmf7Lg1sIv3rQ92+BLqG848bolheGOUQQm6BTiB+msGTNyYzFXF
 7YT2TZo14hILNRIq4V6YrPA8Fmmbpr8jDc6m7wD3YsS1sTfAlI3F+B2XocgQDdfu78SW0177Rab
 8wZcqdaTQ3nEZ+121JJeci6Tj3kLw/iVYzFPE5SfkYB4o4LyKPSPqTR7cRlkLwnIpVdknZ1/viF
 7dRs/1mDCPxQdE1QY32n15LH1wGIYH91A38NvNxfo1NMgkSn3MuV/EdKzAtxx/sRfi8P6j/QiYn
 4oLcd2ekU1QrX0CC48fIb2lqC0rT9/z2bVTt9S0IlbyBxHd527SPH+Zq+3Z0vEI8QXJ/Q29eD87
 zzy3IyyLPbAKemCEA1ltMaMwchCSBoO5rmjfW+eEShhsdfYKpPAsN4mbbdjPMIwm/ykhjvaqZSE
 SWG0MWDicv1r6l2O36JDJhiccdoH9eVxHy9k12Kq4gT0ZME8zAOMaQaLRCRe2bo8QLSv7gP8hpH
 pv0TgwPlfZkibExRYRIdT8S0g==
X-Received: by 2002:a05:6808:c40e:b0:497:da97:8c7a with SMTP id
 5614622812f47-4ab3571b2bemr2956673b6e.41.1784854930024; 
 Thu, 23 Jul 2026 18:02:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:02:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Chintan Vankar <c-vankar@ti.com>, T Pratham <t-pratham@ti.com>
In-Reply-To: <20260713-am64x_sw_rst_fix-v2-1-3e0df7c88a96@ti.com>
References: <20260713-am64x_sw_rst_fix-v2-1-3e0df7c88a96@ti.com>
Subject: Re: [PATCH v2] mach-k3: am64x: clear MCU_RST_SRC before reset
Message-Id: <178485492880.3246206.1129607378996362262.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:02:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854930; x=1785459730; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bC320+lKimG+Hp+Nafl8k2amRHfyRmCgHEJoc3M6axs=;
 b=be8YsZJQRQ6+1iUFEhcH3oNufa+V/zZ8WT5WicUC1r1Ipj6T0Cu4AtHNZ9+Eb85d+b
 7Lmu7rdHUM86Vx7CqJYb//A4gENvh43+Kg3H5rYq1H8Q5GeDMf9bSRwWesnoqFyViLd7
 91e1UGiSPf75P/GsKy60qZ9gzlevQiZH7RaIs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=be8YsZJQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="be8YsZJQ";
 dkim-atps=neutral
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

On Mon, 13 Jul 2026 11:07:05 +0530, Anshul Dalal wrote:

> In warm reset, the value of CTRLMMR_MCU_RST_SRC was not being reset.
> 
> This leads to a reset-loop boot failure when a warm reset is triggered
> from the MAIN domain (by writing 0x2006 to MCU_RST_CTRL).
> 
> 

Applied to u-boot/main, thanks!

[1/1] mach-k3: am64x: clear MCU_RST_SRC before reset
      (no commit info)
-- 
Tom


