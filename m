Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29DDCD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319BE8499A;
	Fri,  5 Jun 2026 19:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A0hlE94n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7098499C; Fri,  5 Jun 2026 19:32:13 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E6D84995
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 19:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4863a7dac63so1197888b6e.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780680730; x=1781285530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O39RQ+MqpJgguec6azzLuwiYD3d2PMkgssIjRsoiFhE=;
 b=A0hlE94nobU6T3CFIR6hULzZISmnxAxLngHJdTYiJWT5JWtqmY4xep9Jfc7MzhEupf
 8MmUzX5GrklAj7h1E0IroOwfoxYnAy8isqfvLBsXC1XoGjsBwkEdJNC+FsDqlAXAt5uB
 /2zZsBkDXLTHgKdlJ7RPvyHKPoCKfm1uhY+t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780680730; x=1781285530;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O39RQ+MqpJgguec6azzLuwiYD3d2PMkgssIjRsoiFhE=;
 b=s3CFnrR8SkbHY3GWuFhdcIFHt8oD89+aOYPv2GBHJgkiSRNoOglTcY/YGN/ESvYAic
 dzhRwnJVRR5xqDhPGfphsGqpBYoTkqW/smY2x8WrAFv/wnPztlFL3hMmA+J6U3AH5Qc3
 qnormEh2qAW6gQvlnDc4CbXyklbCOLezR3ZdWAstRBHlv5TdmIfKcI2R5cdKMGZhwpMv
 jsLB6H39PTEq+8tQ2vf5y7zAaBkoWgR5lKvWW5Bz2oWnu1J7rdqr9pTnRRHFDWAXzl0M
 pd1XYQ12Hikq6AdrMHzvLxx7RRiMI9hBpKC+Ft2jts2bf2OobTUCf/UYS51cwcMBjmoK
 5qEw==
X-Gm-Message-State: AOJu0YwMolgdBrr+T42lhu/OUCTKUdkkLnhTnp0C70kkzvLdB87xfCRI
 GwQAkT7VkjySrZB1iAG9ed0eusoVAe8G7hzGtzyIshNdQ49BMAq+RaLpyCdeSbeBbAcNGfKCRKm
 offErJX4=
X-Gm-Gg: Acq92OGHTgsK3MtFH+3fODxeQ8EzOOissgkRfbuYSBmurb+/y207XFYYG8e+T49MEla
 8KQcwb8u3z8VyuaOwOAwxDcWzfxEHjyBqe+ISamrNEpbRHLAr1Y6c+knSv0veXfO89oIRKy5omY
 hZqTnT55ENAWVOUTCIZZrsSX5ZstbOM1eDGo2Cp7B4UHMlX1pCTT6vHAd5XsTKTE0qGf8jNAQ1n
 xwF1LVE89yT8sMfsKuk24P2VPCIDqGp34OHeU4krt4MduKb+iTtPp4LZVeoTCnponUZSaomtkLE
 jj+uPrb2dAILOVglbZPTs4gGY2W983VYqWDwywKJQEmee4I9KHwBJgzJCQ1sc8odj3ROLuXOscY
 Nrk2OeHiQP+JxctUP2U4KKpQR2YcF3hYmwcDQMoqCLnwzFwBUO78hx7YCNRdSKRSNvMa40GFpid
 V8QYm2J1msXkL6LzuBnAI35tMB2WQ2mwImPEOnQZGNnHO3o0QVqVslee4KOuu7MlJkJ0JCpm/+V
 6nqUnp7L+qjoYYLD7zEYVAgxGQj5j5LQ0Re7N+eYGgGmQQAhUba+C6hF8fdhq/cksVvGq8=
X-Received: by 2002:a05:6808:1387:b0:479:ff59:dcec with SMTP id
 5614622812f47-4868decc0dcmr2942461b6e.32.1780680730292; 
 Fri, 05 Jun 2026 10:32:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d4f449sm8452655fac.8.2026.06.05.10.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 10:32:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
References: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
Subject: Re: [PATCH v3 0/8] rtc: pcf85036: improve spec coherence and
 extend features
Message-Id: <178068072954.381060.9161654624530889228.b4-ty@konsulko.com>
Date: Fri, 05 Jun 2026 11:32:09 -0600
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

On Fri, 22 May 2026 17:39:20 +0200, Alexander Feilke wrote:

> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
> 
> This series fixes some spec inconsistencies and oversimplifications in the initial
> PCF85063 support, and adds some missing features from mainline linux v6.19.
> 
> Changes in v2:
> - reject day 0 in mk_date for tm_mday, analog to tm_mon
> - improve commit message of first commit regarding mk_date changes
>   - describe previous and new behaviour
>   - note tm_year not being initialized in the format case MMDDhhmm
> 
> [...]

Applied to u-boot/next, thanks!

[1/9] cmd_date: make mk_date() static
      commit: 58545b01062e7acdaaad15f236301f3f36a6156b
[2/9] cmd: date: validate date using rtc_month_days()
      commit: 3bf0e5d90c0c74e7dacc185558516cdf1e3b045c
[3/9] rtc: pcf85063: adjust date format to adhere to the rtc_time spec
      commit: 8763c0169d8d8f16ee8c88fb9672f18638f0bba8
[4/9] rtc: pcf85063: add support for NXP PCF85063 family
      commit: 1f04246641079ccf64c29ac53891ddc41d1b1694
[5/9] rtc: pcf85063: add missing register definitions
      commit: 49754d293ea4a2df923cd70de8a69a4ba150477d
[6/9] rtc: pcf85063: keep the divider chain in reset during set_time
      commit: 2b6de25797b49a1b3eff6d24bfa0f7808028b962
[7/9] rtc: pcf85063: support loading quartz-load capacitance from device tree
      commit: d8f535cd8f7cb5f9231f91a3307895db7c9f9552
[8/9] rtc: pcf85063: add power loss detection during probe
      commit: 059174b9554ef4f366accd75b641447244c00f3c
[9/9] drivers: Kconfig: rtc_pcf85063: note unsupported chip features
      commit: 8294d86b1d9ec63dbe7d145dc67f2385e3290c0a
-- 
Tom


