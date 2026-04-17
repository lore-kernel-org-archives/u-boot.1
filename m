Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0A1F436B4
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC67D842A4;
	Fri, 17 Apr 2026 17:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OH4yED0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4139E84246; Fri, 17 Apr 2026 17:52:30 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2370C84246
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso863966a34.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441147; x=1777045947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWFVso/JjQacIIyagqHhUCLRx6zj71Iio80hEkteI8o=;
 b=OH4yED0KLpfgdG3snvzzPAk5AyTWrFGqV9xdVM93jZoLOLP+BSsJH0W4wCdWctVdC0
 R5rN3gDXl4WmDS9gAoCTcmu3JSbhXlVKKpGNwfA5Y1FiLluwP9qZ4S9kiO0KmPEnEBCQ
 YCX7AcpFMbsEz+MLDoGK51QXjQX4Bd2v6ENDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441147; x=1777045947;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uWFVso/JjQacIIyagqHhUCLRx6zj71Iio80hEkteI8o=;
 b=F5gJ7PTsRATYQ3OM+ZCO2FvIl53NT/uaWSJPzRSQfBnuHqGS8N/EsGAaCOSqZ/LWxr
 sW321+PqV+Jaj/ehMe6PQEc2MIy0Y6qFDbsF+tqiwh5QDeKYhrytSoo03OykTSp0Xfe1
 YoRdlFQYThLukVrYQsnZ+43i7lutz8tSlgasgqhDyYn3Oe0y2FCjeFrjicuGkBV/gtAa
 PhdKmExgzsk/+b5kAavfXNsgQLqKEPhq//cUkNb8xJOTs+pjNve/OzjQKKjW5EGK7JqH
 ISOJJnffEogQFhTti5wtz6JiLrhxUQicArvSKjRpW/7oNV7BE6EIyiG+yugXUvAZsdC7
 TpZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6r4xZlI3GcKtdUvSnv4GN+086DGCNkMEXLtjCrCJIuBFGwa/wf4IE4l+OhXB92kTvBIACgeE=@lists.denx.de
X-Gm-Message-State: AOJu0YwDpJTQSz7cC1RDjqjT3riUuZBYrMAZ11eZEPF3gNasBRnEn/14
 MzldBE2rirH51ka2b6EHYhwbG1rvIYl19Bz+iTq1rym++flsB2rI+sWY1qjodv8UTNo=
X-Gm-Gg: AeBDiev9v4B9y9pPetWGDA3HiB+R8PyFsShYpFt2GbcQATVJQzQdqVtcoGSUWlOlKWE
 wrQi/HXy1o0SyXzFYxbV/lsYY2x0uopX1y+WvSQpw1czH+3eTaVRUZDaTusqyT5FU2xtIPKMiR9
 t8eMaabJoXKVZze6FBapVvbsgee61qXiWT9yUXGfMiiW2SUIRrGt+egwegXE5bBkxo5J/IWbrKV
 WVzXDajuS8pqBX135tZLXx7jfnii7zMCgsNjOMcGI+BSA6MKNuVZZ7fUBDzVWr2GSYNL0D04ZfQ
 LmLYr0jkD0dRDzy0OB+zCy+0/Ts2x1G7t2fR004Vd4CWmQ5s3NgRhd7Duh61JQfP5AkNDUERCgc
 za6k3tb8OKV3V/FNrsQF044rwfhqP65X8zMgIMMfEgO00HlRyR8OpEYe5bBfYcSC0eF3rP8gY0t
 eIw0UOA4NfINIzSR40Uiz+QHpdD2SUlhD7jahWDiokr2zCpiDEs0GTI9gI9Vg+TxuQGVnfdo53z
 I81BgJgRbA8v9uZB8/rgmdLyctdPxNv3ht9CdlaYbCKBW6ZmIcCUJbVxSqO
X-Received: by 2002:a05:6820:4cc9:b0:68a:116a:a5e5 with SMTP id
 006d021491bc7-69462f303ccmr1856193eaf.44.1776441146809; 
 Fri, 17 Apr 2026 08:52:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: jagan@amarulasolutions.com, vigneshr@ti.com, Ssunk <ssunkkan@gmail.com>
Cc: tudor.ambarus@linaro.org, u-boot@lists.denx.de
In-Reply-To: <20260206163713.812-1-ssunkkan@gmail.com>
References: <20260206163713.812-1-ssunkkan@gmail.com>
Subject: Re: [PATCH] mtd: spi: spi-nor-ids: Add support for XMC XM25QH01D
Message-Id: <177644114597.690930.15753299695770762391.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:25 -0600
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

On Sat, 07 Feb 2026 00:37:13 +0800, Ssunk wrote:

> Add support for XMC XM25QH01D SPI NOR flash.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: spi: spi-nor-ids: Add support for XMC XM25QH01D
      commit: fba241926982eb17ef79fafe8531ec9fd6837ae5
-- 
Tom


