Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469BACD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C81849CD;
	Wed, 10 Jun 2026 00:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="clyHMG8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C828849D2; Wed, 10 Jun 2026 00:28:27 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8514F849BD
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4864abba33fso4431471b6e.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044104; x=1781648904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVJbRr+KgKuWvPmoRrIBG1WswTAsruLtpCoaJXI+9zY=;
 b=clyHMG8VnBsVhtem9krQMpVbgXJ8AH84//pi5bWAFUtOjmSGuScEctHbV0F6tQXz1N
 MhdSsGnJpJQYfUF6vx56sz+7Ul65I6/mdd0AsTgNXtZ9bRJojJ90zw+s3r4yZGUpIWF0
 kXrLEG7HYSVmVwD4dP8C+LtcitwX/zkQpOYug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044104; x=1781648904;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aVJbRr+KgKuWvPmoRrIBG1WswTAsruLtpCoaJXI+9zY=;
 b=UOP365tdb/4M2Q7pkZn66KljXlqwrcjGX7mcgcqcUVP+RLy9FmtDoXXumq6qrXMANw
 LBbBcg4ji2x4C8PkpUYWWdgvPNC7XGipBCmiVwCql9BGcQyRpD4jjaejWCJc1TEOxlfv
 /ddKvxSJhVJeFkiF7Hzqa+PiPZAdEPLvJuNgYy9EBJLLq8BhVG9tZGpy+d7IhOStDVsI
 i1/Bg3hZKaGTuKj4D9EJUVw3F4Fk7ku+8Ip92DZkBNWRI9tiTU2Typ5dyBNZGrog+Ggo
 IIrHA8nFCSPzSbWN/MlRrDz9w7xP7eJn/rWa2PeR42tEtw4MyPz4nlt0ZRLcm3DDk9fw
 i7hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sy+JCqvV+kLkzF7cau3tv8XxcfhrK0lYz3HmiP7u8sWm8YyoKL6GKfsfoEgh84cIGopYznfI=@lists.denx.de
X-Gm-Message-State: AOJu0YwyEZdbDsTerAdwN41vTrcubDLcURkceE4UziHiOvPwJxABVh8R
 CuZEcHQDroHYXp58wMNtp+Fm3yIuYp16WysJJzlOCJIFhfZZWx3SE6dvuQ0tY4MMdZg=
X-Gm-Gg: Acq92OEQP91XLl4ofaf2YveD/NlDcWnCVat5Zfzw+Hj5CjOO4OfpYmK1MTGXzSXLPUO
 vFfr1QV4oWz9kzM9pQHsAIywcAiRJeaX8YJBwPyBgc9I3b+UxrSgAbPPJZ3Icbkn9n1XOHPMDlf
 hHpnvjiJRG54Jvc8UrXJ4kt8Yvtk9ePCjI5+QyRevKzwljTGNzZqJZwjGozLph9DQVj7dO6uUMt
 cqc6nhvjSCT7k/xkqDGpzAA4G3uXVPB5KM2a0Szr4wyLMZ8lq22xbOzlvJ9P5XDMWG5BL51Ti/K
 tgrZ53xRiSwAuFPjm8VQW474XNJHYqGG8HgRofg7dt+eMvbCgxB+p2eSXs4y7yXl39+xs7ug9zg
 GT0FaMb37rMtbBbt0TlEc1+r2LuieNlLwjTcEOx3oVf0gAlSCDwlm71CESQGdFYqQL3Kp6Re1FZ
 I+eQJHmOIImzyZesbxB3gQjORff9u/dYfEVU2JSoRHbYmUF15UJivNwkTLtBi2DerqPJSubpQq5
 7LLktB/3Q+7wlMGNKIHocSvLpOkC2CUGffX/rYxXYuuSAYCrKV4/Vl8OT4K
X-Received: by 2002:a05:6809:10e:10b0:486:e5de:72da with SMTP id
 5614622812f47-486e5de84admr2265833b6e.10.1781044104347; 
 Tue, 09 Jun 2026 15:28:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, peng.fan@nxp.com
Cc: BMC-SW@aspeedtech.com, joel@jms.id.au, u-boot@lists.denx.de
In-Reply-To: <20260526064801.2741437-1-peng.fan@nxp.com>
References: <20260526064801.2741437-1-peng.fan@nxp.com>
Subject: Re: [PATCH] reset: ast: Use dev_read_addr_ptr()
Message-Id: <178104410299.79918.4465691286112992795.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 26 May 2026 14:48:01 +0800, peng.fan@nxp.com wrote:

> Use dev_read_addr_ptr() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> While at here, correct error return value, when priv->scu is NULL,
> PTR_ERR(priv->scu) is 0 which implies success. Change to return '-EINVAL'.
> 
> No functional changes.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] reset: ast: Use dev_read_addr_ptr()
      commit: 305c014fdb7208ced179e47dc3634e7faa6a2502
-- 
Tom


