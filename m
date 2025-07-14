Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C7EC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71A8830E4;
	Tue, 15 Jul 2025 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CQcsLT2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C22982E52; Tue, 15 Jul 2025 01:12:10 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC8382B07
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ebb72384dbso1485191fac.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534727; x=1753139527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFcu21kX1YkB+BfwFmQOhipQoOd1QZc1gemYqCX6ZP0=;
 b=CQcsLT2dVEEiN+iC4lNOyh/mJMJqbKFvvxb00txlhRz5vD9Io7N19xAiCAiwGgQD/F
 vz2MFX3o0CYir+YUubFLtcHd0Rz/36ispExpeSwtUllTDl1luXnzJh4RzvORMEiHn92t
 IMSUfQVAJXk1Br/clxHH5hemH6oGGd+fca71Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534727; x=1753139527;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFcu21kX1YkB+BfwFmQOhipQoOd1QZc1gemYqCX6ZP0=;
 b=ORKYELL8Jr79ynnBHnZoWowtSFGTPUWZEjAGJKvheqU42ax3hS0gdRQ/yZ3fez3Zcw
 KhrP9rUAeeDXb33bnIEW1pdqHAdRO26NA43pikYPpZjG+OQOL0wGyG4ESmJnQmgeiEkE
 IUDB+e0rXcTLS7cL3XVMTZlU5Zh4RpPA9XFCRCe0HY7X+SX9N33s1KP+A6CKOvDfRBUt
 lgqMBUxuOL46X4jAJHqnp18SLzm6O1OHt00pO5nTO7WYtfQw9OsPPq3i4FiplHH+szYo
 glSojnUthvokv+/FJIquvOV1x/RLOoypZ0P8x67KLX9+iQUn//BI5sfAfXqlPajevbbD
 tiXg==
X-Gm-Message-State: AOJu0YwLccqovTXJ38b2o271H+JIDMYGS7RES/NUwciRP4rW9vNWWRW0
 Xa2IdGuMYN/5xkkj5fL9jrHiTtcA4jYahnkE4/O++UljO+LM3GyyrtSLS9ZrakNHv415CD/EL+I
 ApRqCeXo=
X-Gm-Gg: ASbGnctjX5XfG6T73Plb608GJla53DsulKfTHgOTduFpXDG3wD1APmweMvRnoAuaKD/
 rg607zTZjeqPNnNY7tDQuCiZ4yLhuF21hzyXaGhS5jowSwnqaEW3cqHjLHfB+xV3buY5LXLYbmx
 mbmGFbwybRW6uRk24TcG/egjxKgSnbxhToe1d/+5oePWPG+bCNAZX+oLYrU0BcGkwBkQGzgFI2o
 j43vimCvO1gi9ZnDvWvWmL4eTxCamFiKOcRMkojS7/LLfZ7tPI6auMRLsty5Jz/4+CjgBz2NPbU
 Xa1fpyAaHhgrsOG6ClLv2f/OPsLt8XgVjfBcacXhhWT2IvLS1etlkBD9PJ7R5l/F2kjwCCI0BWC
 226icKFthp8HPdeNWUNYxQ3EiZ/9i5SkfOL6buhXdJ26zFG88RQDGEEjWCCDss2al0g==
X-Google-Smtp-Source: AGHT+IEnMpw25x+5qIKRi+LkwQRrxMBPGAolQFwxzi/XI4qyRP2mL/KTG11EeLozXw3ab49TPD7Nsw==
X-Received: by 2002:a05:6871:647:b0:29e:2ce2:94d with SMTP id
 586e51a60fabf-2ff267f0eb1mr10641775fac.14.1752534726610; 
 Mon, 14 Jul 2025 16:12:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250707-scsi_fix-v1-1-26a3b1af4b9f@linaro.org>
References: <20250707-scsi_fix-v1-1-26a3b1af4b9f@linaro.org>
Subject: Re: [PATCH] scsi: Make static functions consistent using lbaint_t
Message-Id: <175253472589.280771.17075310945066249930.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:05 -0600
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

On Mon, 07 Jul 2025 15:12:20 +0100, Andrew Goodbody wrote:

> The static helper functions are inconsistent in their use of their third
> parameter which is used to pass a block count. Keep consistency by
> always using lbaint_t here. This will fix an issue where two left shifts
> were overflowing the variable type in use.
> 
> This issue found by Smatch
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] scsi: Make static functions consistent using lbaint_t
      commit: 41713b99671f6775c18d70d31ccd8b27e438abe1
-- 
Tom


