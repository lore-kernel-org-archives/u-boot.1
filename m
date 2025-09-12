Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C20CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 18:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9282A833EB;
	Fri, 12 Sep 2025 20:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sG+nFY8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0145833F9; Fri, 12 Sep 2025 20:29:46 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32B4833E9
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 20:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-31d75b4d485so1133352fac.0
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757701783; x=1758306583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JdtjaBp0/QgFW+ocsEGTp9ROj1+57B7hBBbYz9JzatM=;
 b=sG+nFY8nSkBEOGavD3cwP2x1A5fTKxI8uT6FkaryWxPfaiLUJv6tTp9Z4+P0em2acz
 8+ryP/zwr/CHScJ0XTEnRV4ATzI/mSYUIIqJ2nkPGanm0jVRSLsDifdomcUeQVJqbzJS
 1Ga4+sgCSL9AR/ceUHvOWtxop2zbA6EzbvhW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757701783; x=1758306583;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JdtjaBp0/QgFW+ocsEGTp9ROj1+57B7hBBbYz9JzatM=;
 b=jaD8I1mwBK/mj25T6I8ZKfZP7OKLSuZGFhsuCBtIFpmjJ/q1fVPl8Wycix8Pxj0qky
 nbdERGoLHVUGMkU+PEYGojA9MUhPj6Kr5zigj1MOrFFaUqandEcMDabs6BctCmbIyO73
 0Y+BFFIs6ic1LJbSd0ZmZZvNgYY9QrKOPsLG8pltnfITT7tHeX9iGvjFVN1ULVj55zkN
 guGqdMsJctyO36jVPvOmSkjdN5Mm2xgCUs3g8Ac9kxmJX8YPGu67PKH8Q+Ph+lb5Buin
 BJUYGTr+InZYOHX2HSme6+5NDuzQkTrz4fQa89RmVNSwieWuRWkLCCXK+eBle5TvKhFx
 GW7A==
X-Gm-Message-State: AOJu0YxIDu3roAhfznOdvI5shx5DsIV9cWY9OP1MNH4mUfyMwAwG5Ixt
 0iBZ1uVf5d06GvECcCrRi9kq9Bw9S6HsXJ7W49P10xNmzfJIsR75QmV4ljojHWN+SPE=
X-Gm-Gg: ASbGncs69D4uSF8a3Z4tOqGpZRcSLh6bw5IXkmM+ro9QAcawkaQ1V8ax7J49eliBUeo
 B2uaXZTkdH7AbyWiJQzl5qbuxMvGwYWRRZ8abEvyVSFY0468yHucxhNeHPFvDzO3DT1hd+rNrFZ
 2G4lNpuFSSW3GIxR3ZLWpflGwbPE0WegmNiUM8MWymxSguEEJihju2hJF3vrwx2EPoroIBOe3Vg
 04sd3Y5Z/yZacdMZBMOxVecl00t8PVwLxdkLhP7aW1IX8ZE4Ks1+jDa9zVcPfsCN/tLXkl1vDMj
 wd2DkAEhagOqj8KKjzcw+zuE2wAyN/LzX52Qfca+J3To928qy4OFP8gpNcU0WYfENQKnybFFwc+
 FUnbXrEzKqNC48vDJPk03oLEPcupAPrtHmttABy8TRMTdJtgtx8st0GDnPptZWpFoew==
X-Google-Smtp-Source: AGHT+IFSTQQhVXWXFWkr5Hkf6J1kEBCHr0t2mAGTAl2Im/iT4lKNyOAxUb6SsIVguS9WGQFPxu1AKA==
X-Received: by 2002:a05:6870:7d86:b0:314:b6a6:688a with SMTP id
 586e51a60fabf-32e57801ecbmr1617628fac.42.1757701783306; 
 Fri, 12 Sep 2025 11:29:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm1358464fac.1.2025.09.12.11.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 11:29:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250909081731.2625363-1-anshuld@ti.com>
References: <20250909081731.2625363-1-anshuld@ti.com>
Subject: Re: [PATCH -master v1] spl: spi: fix falcon mode for spi boot
Message-Id: <175770178225.4085943.824501926292155017.b4-ty@konsulko.com>
Date: Fri, 12 Sep 2025 12:29:42 -0600
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

On Tue, 09 Sep 2025 13:47:30 +0530, Anshul Dalal wrote:

> spl_start_uboot is a board overridable function that switches to falcon
> boot mode on return value of 0.
> 
> Though for SPI, the falcon boot mode was being enabled on return value
> of 1 which is not the correct behaviour. Therefore this patch fixes it
> to the expected boot flow.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spl: spi: fix falcon mode for spi boot
      commit: 210702ae6ce820713773549c4e102b37f09d7cc5
-- 
Tom


