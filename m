Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26858C3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 22:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378E4820EB;
	Wed,  7 May 2025 00:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PA4I8IPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84055820E8; Wed,  7 May 2025 00:03:00 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 626EF80050
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 00:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c3b863b8eso2237979a34.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746568977; x=1747173777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFzJpux0XFTJvtaR7jXqpqbo8yIyyhRqbFpOn3fLhGE=;
 b=PA4I8IPZ/cx216N+skZD/zWBMxG2y/L5D0XvPCUJMutKqyNxgdxQO8iMDlTnJhCVaB
 k7P1MuzxO0wYfKWXT4W5kJL7db0usm0PtodRQ867bgB58IRDSgz+lqnsfgnscgvcL4mU
 hMUmZ4RxWZZGFBajFHc+a19/UIN4EEOHxuQmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746568977; x=1747173777;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFzJpux0XFTJvtaR7jXqpqbo8yIyyhRqbFpOn3fLhGE=;
 b=KN0j9fqC5aWODejdsB6PrNVyxRSWJx0ySxWXiXrpTW3lgOW62dcsNGF/Ea0KjYOx40
 a9sh/Vlfs3YTxT1Tim/+xGycyY22wUyHl6zn5AaZOupZhO9MgsFgV+NJhkmQtxljaove
 +l3dgLSBz3IAtxAmvt/OwBl9spCe2IB+IG1T2IT9N9w0aKIle5WzpX2q8Fe8Xh7qTJGD
 HuUjHWyxnjieifmHOFLIr+cQa07a5uTd7V259TwuhygtTuJGZH5+JYK+IR+Ugqx3Qsna
 tXfHoCtS8xpcvj6ANNoTVNc5EQ/dW0/uQtNbehbMVUBkxHKsEVk2AfhwSKzrw8JMj/ww
 ZmXA==
X-Gm-Message-State: AOJu0YwlLOQ94rcGOvDiK7Dy1J33hdqtbMM7Fy1gq0goa3m14P6MiMUy
 EkvrJ6IzG73RsVilkf0/bvYMzurWf31pU742eqVHo00gegAWbZ4nK55iF8gBSdY=
X-Gm-Gg: ASbGnctLcFfH0YKjat/Htzdy75L3QFzvoiGvd1coQqPHfJ/zrSPGj6OihtXgSCITBSJ
 FkGDsLbln8/YXZrYRs/ymRBpnlyMJ6FuQWWRcY8zEi9Wj3+zsg3uAFzvXFQmx7lucYBffSYb56Y
 c9+J7EjlT9JiRuDdSU1ATueeKmY8U39Xa8pvaK58yXEEfjxqwXrPX01dODVYTwfmDfVB1MlEED+
 l+e8t0WAQ3tqme7dIIGZM/jedJQEuz10sZPP8mqk19QFs7g+r2dlkP4keBT8IcXHBl23ZKSp5BX
 OIyMYqCMwG3PbfrRigCMBbsxPxO14yfC0ns+hgRBK1eJk29g4s3SXMumiHzd+LhY5/WD+pXhNIf
 F
X-Google-Smtp-Source: AGHT+IGQOAtEYnIa8k4RZCG/Xc36qb4Q3fx85vprpy3+0nAFearPraq8wal21gdLSYQIqp6lm6gt6A==
X-Received: by 2002:a05:6830:6302:b0:72a:1e1a:e578 with SMTP id
 46e09a7af769-73210b14d7cmr540941a34.19.1746568977108; 
 Tue, 06 May 2025 15:02:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73210a1b343sm143796a34.39.2025.05.06.15.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 15:02:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, vigneshr@ti.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-kumar1@ti.com, j-humphreys@ti.com, n-francis@ti.com, vaishnav.a@ti.com
In-Reply-To: <20241125104947.1324824-1-p-mantena@ti.com>
References: <20241125104947.1324824-1-p-mantena@ti.com>
Subject: Re: [PATCH] mtd: spi-nor-core: Fixup SNOR_F_IO_MODE_EN_VOLATILE
 for MT35X
Message-Id: <174656897592.280764.11260411090922713147.b4-ty@konsulko.com>
Date: Tue, 06 May 2025 16:02:55 -0600
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

On Mon, 25 Nov 2024 16:19:47 +0530, Prasanth Babu Mantena wrote:

> MT35XU512ABA has only BFPT and 4-Byte Address Instruction Table
> in  SFDP. commit bebdc237507c ("mtd: spi-nor: Parse SFDP SCCR Map")
> added checks in spi_nor_octal_dtr_enable() to bail out if the 22nd DWORD
> in SCCR does not indicate DTR Octal Mode Enable, since MT35XU512ABA device
> supports octal DTR mode, add this property in SFDP fixup.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor-core: Fixup SNOR_F_IO_MODE_EN_VOLATILE for MT35X
      commit: ea2c6df478550fd5e4a412412cea30c986883808
-- 
Tom


