Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CEEF436B4
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3FC842ED;
	Fri, 17 Apr 2026 17:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rGeOXEsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D2583FC0; Fri, 17 Apr 2026 17:52:32 +0200 (CEST)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240928428C
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-6841e6a5e51so462046eaf.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441148; x=1777045948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2JturyEndWPQ8HG1fymsn+zP6VOrn08LK3cHNy4D2k=;
 b=rGeOXEscx8BylkeOSoDbzD9jtIwP9BL00EAq/6YxRPAceeO4GE2lRK2vnZXo/6dx3A
 BuJvP1h59jjNCWGF3xgEC9ctE4zZSztrqQFe+5pgnbV4A1z0AT0AHmxdQ8RrBhb75OKP
 Fd9B90lL+zLl8tdSoPFrXUfc2dulYxEw1gIo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441148; x=1777045948;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2JturyEndWPQ8HG1fymsn+zP6VOrn08LK3cHNy4D2k=;
 b=K/IgHNGUf4pcxehdH7XliqneSpfns6m158GL0xaz43VGTK399PYJqVE9Xw+/KH+swn
 Eq2LGoR+B/DJ3t90Ph9A3ee3iZnUdGJak3a++tyRJi6u+S8kShk5LyYwPJmrH2dkMLen
 zxk/Eos1SvkK53kiqocAhw+j+/WYdNXrFwNAanlhn7FF1ROZVoucGcjVVCqd6dOUFUYO
 QIlWNbi65biq/W+Ir5/qVsetZVSXs2hamhMSNH8GNfO9G/crpX1FtI4n3NM6wlG3n2/Z
 d1atJwWntZXmnY6Ibq0s7dK1oez5LRogvXngJn/tZhkV5yAVFFqgEsDPqz5fa+T+XPFn
 Ye7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bGAkhWDUjtczBGKK+tM1zv5l/JOy4idBRCmGqVAef2xyHcC0LcsoNJC24YlaZK98083jRyIs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0J60/O120l54jw6497kl6C84X83tuXTiZKKZHt2GxN6gNeST9
 f2OsfYj9rNZ5l5lWv7AsXboT6P+4BsbofTJavwSPt4owHBYscffBsxYhZx/m9eUuCG4=
X-Gm-Gg: AeBDiesN/kU7uWs4tCSf5KAOgyX0mClKbXPXKdg6hKIK3KiXXFB914jEfyAiYrBsZPE
 MRTDJqnT6m+OLXo6JRij9evMf+/y5+ip3LVkpl7iK8l9DejLZiaTjIbX5tFYjcUwvympr9yIHQD
 U4dm/97s3uDdQG0/ecpbFDmCtQSjjbIi6MwuSXOnCkILKniGqlrxg5OzM6iNxZzXOkG1X3DR7j/
 FBqPayB9qFuUxdyYUq5mtcq+/MXWom1W8kjVf4X4iv1z5RVtkNcqPziUxm6J44ylX4ypbm5PA+/
 BEoy8ANZKBfZWpcSO5BhDhZuqNlgIylq+AtvwFeY7q3hH5dHo5+VUzTuEakYV2TCxyRVob6vmeE
 jWydybpjtEES5GE3wheZ3/BRF08KeNk2ZxlTOlikwu3qOurcrA0eFp6eR1ay7YB9F+Jj7ia46yg
 uQLbM2jOsU8GB+2jA43csoqxlOUEXUuS67lcelE+G6561jgrVLBWhTagEJGjiBI2PkXb085xwKQ
 463NXFSQBAc6e/qXwxrTqm6VqMN6/5pZyroekrEB0zFcSdKO9llXJj3rG/m
X-Received: by 2002:a05:6820:c97:b0:684:188a:737d with SMTP id
 006d021491bc7-69462f100camr1771519eaf.44.1776441147860; 
 Fri, 17 Apr 2026 08:52:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: jagan@amarulasolutions.com, vigneshr@ti.com, Ssunk <ssunkkan@gmail.com>
Cc: tudor.ambarus@linaro.org, u-boot@lists.denx.de
In-Reply-To: <20260208041757.830-1-ssunkkan@gmail.com>
References: <20260208041757.830-1-ssunkkan@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Add Dosilicon DS25M/Q series support
Message-Id: <177644114693.690930.1037615449076072297.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:26 -0600
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

On Sun, 08 Feb 2026 12:17:57 +0800, Ssunk wrote:

> Add support for dosilicon ds25m4cb, ds25m4dn, ds25q4cb, ds25q4dn
> 
> Datasheets:
> ds25m4cb:
> https://www.dosilicon.com/resources/SPI%20NOR/DS25M4CB-XXXXX_Rev04.pdf
> ds25m4dn:
> https://www.dosilicon.com/resources/SPI%20NOR/DS25M4DN-XXXXX_Rev03.pdf
> ds25q4cb:
> https://www.dosilicon.com/resources/SPI%20NOR/DS25Q4CB-XXXXX_Rev03.pdf
> ds25q4dn:
> https://www.dosilicon.com/resources/SPI%20NOR/DS25Q4DN-XXXXX_Rev01.pdf
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor: Add Dosilicon DS25M/Q series support
      commit: c56db9b4a4412cefd97dfa1d2517706be3507daf
-- 
Tom


