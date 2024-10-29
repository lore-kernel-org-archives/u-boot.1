Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890FCD74948
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28DAF891B8;
	Tue, 29 Oct 2024 23:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XTxLrP+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF378891A8; Tue, 29 Oct 2024 23:28:25 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE53891A3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b147a2ff04so493835585a.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240902; x=1730845702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1jmjF7NmRqTXNmlVj/EfGgjOnPkuDDTPvETV/wVJnc=;
 b=XTxLrP+FtGsBmukC3Uocw5P25WlHdABoBQgey7g+bLcR1MtDvcB5thDM3vdALbk7mb
 PdEYVoXhlTX5YahXtHpz18l9b3QOf1zlMg8OqxTeg+5ZKceUdisvx0m54jPsIbLkwbus
 lxx064qIHjjNPTnuDf2vfXcTQKKSN5Fi1XGGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240902; x=1730845702;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1jmjF7NmRqTXNmlVj/EfGgjOnPkuDDTPvETV/wVJnc=;
 b=wG3Z5+tHZHvZAPmt8272a9D8IGe18xj4ToQ02vjK0GyKIWjb4wekGUZom6WD2Fif3W
 ixczfKAHtmOKziPYVeD9CytQaF+V+3q+YZoMbPYvan2ov78WelsYfR3wMIUm93GFieCY
 n8/ZXWKiNFgc/M2AqRtRwVnN23BuwbXw+vQoSdIYyhRylEU4PrxMPZXzVv/9bCbAvFEY
 Kn1F2mpOO/z98bGQb/zT55Ji7Tb39QEeWH1ivyM2kBUWzKDZKa8Zjt6GCeKIbQhmbnb+
 uyS5bGVTmymEJAgeSM96KNxWrdiJVV83Fr6g2dKgG2gcrvWiaLJUyeGUM4V/ke9Ierxi
 p9nQ==
X-Gm-Message-State: AOJu0Yx3aHJwtcCiWkOld7sb74osJqQxef8ZEX8e/OuUyAc18d+D7meq
 7rNEeA5NwTmwKNTWtKQZTIkUPxVxAgYr/eUx9ltVJjXIjLvU080BA4fIsJgMHPBQyIt8Ym10ixi
 +UFs=
X-Google-Smtp-Source: AGHT+IEaEYD6YLNEbVtBb1VJGJ5h1vLtaHs4X3D8LmRpACpZtE06y6vGaHFyjmvfkvdLO/WMm6v5yQ==
X-Received: by 2002:a05:620a:450b:b0:7b1:1352:66fa with SMTP id
 af79cd13be357-7b193efebf1mr1706243985a.30.1730240901862; 
 Tue, 29 Oct 2024 15:28:21 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20241022163118.3128014-1-trini@konsulko.com>
References: <20241022163118.3128014-1-trini@konsulko.com>
Subject: Re: [PATCHv2 1/2] CONFIG_SYS_NONCACHED_MEMORY: Move prototypes to
 include/cpu_func.h for consistency
Message-Id: <173024090090.2563570.10480856382193771689.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:20 -0600
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

On Tue, 22 Oct 2024 10:31:17 -0600, Tom Rini wrote:

> Currently, a number of generic cache related functions have their common
> prototype declared in include/cpu_func.h. Move the current set of
> noncached functions there as well to match.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


