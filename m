Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727BCE77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCE7806D4;
	Wed, 15 Jan 2025 02:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gZPbn3by";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306A3806D4; Wed, 15 Jan 2025 02:13:13 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C1880214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6dd1962a75bso49720386d6.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736903590; x=1737508390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhU0JBGA3VOxjaBDSTgMgta5ymFKYmX1zDicfVGXu8Q=;
 b=gZPbn3byixjBNSQtKVQQvpwxETI/uEdnK4lZcUXUEYVvgzKJ/Kf9ZLsi0mUJRXoaoz
 48/qwOzvr29CgP+xEMXqrZot14T4qf4ic/VIwM4qHd2ByogCY6olWqSCCNoGIxhW1YMo
 E0QuhisjLCn+xM9iDNWoncsGqa8qaLjAC1xNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903590; x=1737508390;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OhU0JBGA3VOxjaBDSTgMgta5ymFKYmX1zDicfVGXu8Q=;
 b=MFn+fORryOY2QtYi71Pln1rSEBMLpfXDTArtu7iQmItqwOIf6IT4KX8DZh8LtQ9VWb
 hpmSQ0Yac/tS2XqoxsL372/72x4Ak1QDg2fPgcNPQ0w1+q2P0QIjOHwcqVx2EA95kQKl
 oPE+q2sQcwnNGLCSgMW6B6TV8MHX74pgDjd30onWEgrsCDrKJZwmGYs7ZzupOYxncnji
 qZfSbFNhlofia0fKkdWurYCMkXo+jyegdMiAwabfE6ZqBuXosThLC3trRjyaL+km0GdM
 Yymog8x0a7v5QPdTfAKyFc1mjVao8ylghXF6WNdTTCIN3vA6qW6de5fPFjmRCUL5VBtD
 ccBA==
X-Gm-Message-State: AOJu0Yzb6WyJrT/Q326zD24nZZ5AxVE1pNeGV1QNPs83edfbAwavNR/l
 chkRazB7VL7th0A4qdGP5a7cYK7DIM591KewJblj8avCmH5sy8lrTgs3pHVj0cs=
X-Gm-Gg: ASbGncs4BrUx2yMefH6jtG5CDxgW6fFkAtRUWqFjSSRwsv2Ir+prPGy5dfaBl1rw5PQ
 j9SySZ/JMjboJacAEFhLULqVLknhrYLObmw8J2qYR93MDO3K1Ldp794K5x62FgvI9wRvdU2umpD
 K73633JqOzMHIql9NnBLQ4xkNBty2bM37Vb5+0e1RyvnlgTSLPdKt22R/UKPOi1BRuhN2mhjtVF
 /4EdSpJMXJqT7yTWXVQRfnRl1xW32e1Bt+jawR70aC7fErEHHA6
X-Google-Smtp-Source: AGHT+IFZdGQRCC0HveVS+gKCjnyFsw1n/J1kOl1X+qDoiGqCVWllQw/dL/as6L1bguhf1+Wj4tw2Gw==
X-Received: by 2002:a05:6214:1245:b0:6da:dc79:a3c3 with SMTP id
 6a1803df08f44-6df9b1cc9cdmr371197606d6.5.1736903589885; 
 Tue, 14 Jan 2025 17:13:09 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade89283sm58989756d6.105.2025.01.14.17.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:13:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com
In-Reply-To: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
Subject: Re: [PATCH 0/3] fdt_support: improve board_fdt_chosen_bootargs()
 for flexibility
Message-Id: <173690358703.213810.11133619882489861517.b4-ty@konsulko.com>
Date: Tue, 14 Jan 2025 19:13:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 20 Dec 2024 00:42:07 +0300, Dmitry Rokosov wrote:

> This series consists of three patches.
> 
> The first patch modifies the function documentation style in the
> include/fdt_support.h file to comply with kernel-doc requirements.
> 
> The second patch modifies the board_fdt_chosen_bootargs() function to
> return a const char* type. This change clarifies to the caller that the
> returned string should neither be freed nor modified. It aligns with the
> existing fdt_setprop() function, which already utilizes a const char*
> parameter. This promotes consistency within the codebase and enhances
> code safety by preventing unintended modifications to the returned
> string.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


