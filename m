Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A19AC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 18:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB14D8169D;
	Thu, 13 Mar 2025 19:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fUz2J3+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B14B8169D; Thu, 13 Mar 2025 19:43:38 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7701F80540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 19:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dd049b5428so17964296d6.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741891414; x=1742496214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xXZ6ISjcroY7z/LhUJwtE7YJGmFM1pNEaJNLwXGppU=;
 b=fUz2J3+uUdqIDyZJah1rxaqrnvQolYcS2OVjqvI0tSRJDTk6NLK+laXtbeqAr/QZ4R
 rCPe4/yBwu7SUb1BmSKkjFpPFt9p0aUHT8c0vNGdofBh/G1m8db82QIHMBMLtPkb+gSy
 SmETUgBBp9XXGJQPpBpIkaGC8TZSEMowMibZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741891414; x=1742496214;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xXZ6ISjcroY7z/LhUJwtE7YJGmFM1pNEaJNLwXGppU=;
 b=UlhDjuubhoLu9JZYebBx6HPrEo74a5QfFEYMji1yJKfmdtwxdZPEX25yIAf8G+4XPX
 s2gM9JuszLGVUu/Ukgr95IpEyDWus3vK1NKmxO5vm2fHk9aeDgg7LRfdMR0PSqAoktsE
 nEBMWDCHQCrnd2NNX8bUDRXrYoaX4fMKqqh+vgH/iAEQFmk8o4bDGTtgwRNJV/1q6yCY
 ynkukwMyVcRiOh8pmEFS3AIa7up5PwFZsg7J2LYutC/OwQuDjp2N6Vsv9CrgTWeeiPsu
 7mxA1RPp8TWsDCfyiBs9xKGKVDuHTv5bvbrh1DXAJfeXDPe/V9wa8xsZkV5LX4UYKjIn
 eQxg==
X-Gm-Message-State: AOJu0YzA7IIUcyci1f8pRNYZmEmWwBxSvdnXTuHnX3XCVnAwSSSUjNL8
 52nrKEJmN9VnvFd4bX+jIVDWmuF8RxojXnav7FoqP45GNLSG1D0PIuzLdQkdd9g=
X-Gm-Gg: ASbGncsl80AbDpbcqx7EdWYwE3tQQjjqgK7W1UOUSRhtGeYVIgKwTobWv5LbR2QG6TF
 7RCS7Ja+ODXc5cqfwk836t2hsw0wStGfDaNeG4w/zgQqVmMTlE9eyffCzOhdiSwIBJ5CVhpPqKF
 67eG2kza39GzIy/5J7aAgSS5UwwoZBsLIUFgqxLMSIDcyRyz0ByVukQtUTXzRu/eVrsNpkhw7Nn
 +8BLh4oaTsvS2eMtUs7v8B0y/McWE8pM6BXlTh+/6ette82EtLCWNhLVTw8GWPrQoOfaz1qV3Rg
 5ELOR0kdNG6Olj1NUzS9KzocRCOEltBgZyHime5V07WA
X-Google-Smtp-Source: AGHT+IGITMVvnNZkO9AQgFDVKJw3fNxGoZeMEhxUyCAuyZNavaDBDZFgOn0n7Vhr3S/5tWsIvCWChw==
X-Received: by 2002:a05:6214:226f:b0:6e8:8934:337e with SMTP id
 6a1803df08f44-6eae7ae3f32mr14554126d6.38.1741891414363; 
 Thu, 13 Mar 2025 11:43:34 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade231261sm12640476d6.30.2025.03.13.11.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 11:43:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com, 
 Santhosh Kumar K <s-k6@ti.com>
Cc: u-boot@lists.denx.de, n-francis@ti.com
In-Reply-To: <20250226063923.2266288-1-s-k6@ti.com>
References: <20250226063923.2266288-1-s-k6@ti.com>
Subject: Re: [PATCH 0/5] Update DDR Configurations
Message-Id: <174189141300.2132480.15937131289034477993.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 12:43:33 -0600
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

On Wed, 26 Feb 2025 12:09:18 +0530, Santhosh Kumar K wrote:

> This series is to update the DDR configurations of AM64x EVM, AM62x SK,
> AM62x LP SK, AM62Ax SK and AM62Px SK boards according to the SysConfig
> DDR Configuration tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02.
> 
> Test logs: https://gist.github.com/santhosh21/43723900f3615e4cf98da57ed9618cf9
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] arm: dts: k3-am64: Update DDR Configurations
      commit: a11f351ed46b1f254535f36f45e11c3441d5d5cd
[2/5] arm: dts: k3-am62x: Update DDR Configurations
      commit: af3d03c28b08d235a25961fd8c6fd5d9fb60b370
[3/5] arm: dts: k3-am62-lp: Update DDR Configurations
      commit: 1132a455f4c33648b49984c0b823f73c39589620
[4/5] arm: dts: k3-am62a: Update DDR Configurations
      commit: 1df8c8bce619db1b1a9e40418290e39e03756464
[5/5] arm: dts: k3-am62p: Update DDR Configurations
      commit: 226f16e40650e6c8a0b49ba3f29ab3b0393df19d
-- 
Tom


