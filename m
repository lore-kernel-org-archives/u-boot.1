Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564E1F41812
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBCB83F20;
	Mon,  9 Mar 2026 17:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mjhyX5Fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 989AA83F82; Mon,  9 Mar 2026 17:57:27 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF8483BC7
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4671119c1c0so547105b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773075442; x=1773680242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3SOoXYXVP118otqBN/SV08T03/0OwphKaOfJxlcNJY=;
 b=mjhyX5FzhvT+ltqctW62ResiPEPw5Nf7+xVbW5h26MBvhlWLdzsAJcVEmR3m8JJ3Wy
 Gyn9qVkGtpqlqNq/APVR94hhUmC/czyg2AlJZ0a3uuv0AkI5tEkx4icnygElAukBJFOH
 pzN1hAxiQGI293kAMXwYDXNdTyWhFb/EeJZzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773075442; x=1773680242;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3SOoXYXVP118otqBN/SV08T03/0OwphKaOfJxlcNJY=;
 b=oMwX49M6APeFci7O5C68Kn24/RXpJ1a5n5WwjzbvbaREvLPGXsu5VpxLA1TQE+VNOr
 2/xexS9BPkEyax1tTL56QE+eqb51M/pPJbGLWOqZ+WcFGdCK4uXsNlzeaddaMS58AWKP
 WTY366EAN1EV6Ed2n/lhI4vPBOPw8WRo4V7VjtxfVSpYA5RlYfLKxS4WmpCeYjNarhsx
 peceDEl63owSxBR97r/ZEhL0Hq4DKi+sNOKpWVOlxyluhGseLlzEX4ugkucv0aiPJ//e
 95bSJRcuA5t6o+4aGNPgSlcX7Tao2FdFvfVyYjufctAaz8Mym+Rw2Lxl+yypF3NlcmUq
 RGgA==
X-Gm-Message-State: AOJu0Yxva1UQCgD/Mkh65U6bozrI7FTFc1YJeXHqB0JcDqfDf5kjs3KA
 RVCLkcL9uQQ28FgxIXVwmJnwgip6kW00q2vKw21pZXoaCGrDSqDHr02HBN0wvi9PPFo=
X-Gm-Gg: ATEYQzwt7A/KUqmjYBfUC21RB0xM2VvNn+gplrifMZEyKcTUDqn/FrbvgTpDVJU4Xwu
 ZHl5+a0ILe/om6g+iFVzaUJP1tLv/q7UiGg7bm+uTcFq540s5jfS/4tlikDE23xb1elxKwLhl8g
 sHvqPlJwtfA2X65+dt/cTA2p2X8RFSvuZEaSWp9qaVg9ZTIEOPtsre1OuNGeHeavut83AKwYj2k
 /HuAsVe6yLhWvcVnQAb+qQ7U3ycJI98fH+URSAEYh3uCGbpw9gwJVuXAlNtWPtmjSGi259K44IX
 ksfKw3Zwoy+t5Pxs7i7Txhg5hfR7sSB1Vy483AwZYrdvCmx3I3/yBk6U/uHWkw7JYHsGpkrXroI
 wDKNblGLqBbDM2pNZFwj/FzsIwImyy3yaOgLbNrSvOzp2LVCXVGsv3SirJH4biJW/2/mf4YinVU
 6JZwnL98Y/uLfa/M6kqRuNzm6wVybIGS+ib2XvC1XpK0geFfe6pNEp/gVzVSRcL+CIn5JpvSDYO
 +HYt6lReL0jtDzB86GttOKaZeygsHgfy3F1yuGyAoQ0
X-Received: by 2002:a05:6808:344b:b0:466:f57b:2ae5 with SMTP id
 5614622812f47-466f57b515cmr4173857b6e.47.1773075442352; 
 Mon, 09 Mar 2026 09:57:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d74885b5a4sm2690201a34.23.2026.03.09.09.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 09:57:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tkuw584924@gmail.com
Cc: vigneshr@ti.com, tudor.ambarus@linaro.org, miquel.raynal@bootlin.com, 
 mwalle@kernel.org, pratyush@kernel.org, marek.vasut+renesas@mailbox.org, 
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
In-Reply-To: <20260309011251.11462-1-Takahiro.Kuwano@infineon.com>
References: <20260309011251.11462-1-Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH] MAINTAINERS: update SPI NOR reviewer
Message-Id: <177307544121.3622694.7672289107852248176.b4-ty@konsulko.com>
Date: Mon, 09 Mar 2026 10:57:21 -0600
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

On Mon, 09 Mar 2026 10:12:51 +0900, tkuw584924@gmail.com wrote:

> Tudor Ambarus will step down as SPI NOR reviewer.
> I would like to take this role.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: update SPI NOR reviewer
      commit: 8ee2e262d13eca993a1ee553d802bdaf765296be
-- 
Tom


