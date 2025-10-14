Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F92CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05674835FD;
	Tue, 14 Oct 2025 16:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FIzxS+zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C053835B3; Tue, 14 Oct 2025 16:20:36 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B17383327
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-38627e78203so2777176fac.0
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451633; x=1761056433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8EOb37ZQMIzP1Mok5aunjiqoVPZNZbYuA1fG/tERe7s=;
 b=FIzxS+zx3XmqSjrSU8lahbajzNMs/6O2cCxvgcaawjfdIwtFnLsQvyCupVnmQnrXBh
 4C63GLWuCaGhkp73+waG4Wr2/4Y359VzgyHfwOmz0bf1kcZCK0/9hqwctWbnga0xxy8v
 ckfXvM62bPCFy1VrOz8xGHxr/Owh4APAopioI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451633; x=1761056433;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EOb37ZQMIzP1Mok5aunjiqoVPZNZbYuA1fG/tERe7s=;
 b=Koh6kBTh7L+Jha7ULqmGXGzcty93ecLaCWkI8C9Je7UQnPE/EK5RMUCViDbJT/feBT
 2LzPFvlzykqJp/GYuSS2RFD2sb+Tx1CbkppNLnObEYGZVBfqB5uPX26JVZGmnQqGaH1j
 pW9tC9ZtcIglFkp9mBFSzy1RdUUBatOlav2jwh4LYYHjg4Q5bDpMdhe45FfA+67sD3WS
 CfbMEBfbVmjaLmClupwwau+mJpOQ3fSTQUqtymlUSFlbd/xKpdUPYPvYLvKJUBF8Up26
 gzxiPykv6aUGSKGTZEj7cNKRavjaS+ANLhciM6hMtQIcMJg6V2ugXF7MiABXPZwnIMqR
 FEzw==
X-Gm-Message-State: AOJu0Yx2hWNAY8Ad5ikQeNoLZf7jXJVbmGkuSdlgYborE/4AROgtF5ji
 BNwQoMI0Dc9JmtRS/F69eMnE+sDnQz13aYg6FShry2Sk+hreeeauYgxiOegeY7yoLrHcuA69FQ2
 /5PCfXqQ=
X-Gm-Gg: ASbGncuM3alzHNtsDWaEX3jQvk/vzGh2SoT+60hbRA5D/egi+4iDkMGq+9DmcFtlYDk
 Z25Jby4jqnJYFmBjmL9wVK959tIV+GQgEZ1GpI5jC8ilgNFf+sVTkAGy2dthNNDbzV413aURQcJ
 YaH8pLVMEbgfaMHYoI5NZ7VD68Sq8uatoxsaV9Ym9VcVF9eliN4ZzIxWs84Y98NNOHM/PkqULuh
 qlGZjnXwKOuOSw6v/Fr6uaf4E9NS/PTC+rX1bSZ+pyB/CCpCfls51QPQDuiuNvrEkb4Hgg1TQPj
 XorKES0ATos9bQ1Wc5qrAY+JN0EVHHmWCNaG1ISntZ9/nRJdXjnz8hNsqUUfJZwGU1KvD5yOqIX
 aQ0DKgnA2VSkXYflIcmU1j6Gh9wpJVI46gRoDX2GZcvpAZEBTXjoLl6ml6FGkzOI8ixmBcip5+u
 YTjL4LdXVRYMK33Q==
X-Google-Smtp-Source: AGHT+IGuz0+Rkszith3VOzNuwhok2okNhJONF8HT1cPjx96arkWW+g27Pm1iCT7aDZKACrrg0JUU3Q==
X-Received: by 2002:a05:6870:d0c6:b0:314:b6a6:688e with SMTP id
 586e51a60fabf-3c0fb62a8e3mr12290223fac.46.1760451633201; 
 Tue, 14 Oct 2025 07:20:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251003203920.1029967-1-trini@konsulko.com>
References: <20251003203920.1029967-1-trini@konsulko.com>
Subject: Re: [PATCH] spl: FIT: Make SPL_LOAD_FIT_FULL depend on
 SPL_LOAD_FIT
Message-Id: <176045163259.284655.8453170509635949149.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:32 -0600
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

On Fri, 03 Oct 2025 14:39:20 -0600, Tom Rini wrote:

> Today, only a few platforms enable SPL_LOAD_FIT_FULL, and all enable
> SPL_LOAD_FIT. As can be seen in usage, the FULL symbol is a superset of
> the first symbol, not an alternative. Update Kconfig entries based on
> this and simplify the only code which checks for either being set.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spl: FIT: Make SPL_LOAD_FIT_FULL depend on SPL_LOAD_FIT
      commit: ec90518ee679f1353915cd912b9738ba81d1258f
-- 
Tom


