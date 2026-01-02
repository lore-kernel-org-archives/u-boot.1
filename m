Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AEDFC6165
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 002AD83B7F;
	Sat,  3 Jan 2026 00:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hIzaPyis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EB283C29; Sat,  3 Jan 2026 00:23:47 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B2483AAD
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-44fe903c1d6so2649099b6e.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396224; x=1768001024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAPQkOwvlkYjBQJW0Rrrs8iu2064llgiMxzOB0PcmlE=;
 b=hIzaPyisyifjqJkMJtjmOfWZzG3785Dbno9kNRNlXSYnZfA9aoQ7SV6HO/819A+7ZK
 ShWHu5mHVnFxK+Alkw/7HO/l/Aa/Ex8vRUPpq5qyA0kwPk6PWzGmwQxY9hoFAxcxvWOV
 2eWkdKS4Bjm3HRJXgc7IEdXKGiEPGpUa0um3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396224; x=1768001024;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XAPQkOwvlkYjBQJW0Rrrs8iu2064llgiMxzOB0PcmlE=;
 b=fOGmJxydZcdzH3lO9zsWIP6qSXKipSy6HInS+hCCNvNl5qCnGw1/ao37w9XxqT0oZ+
 Q1nHIK4JQSPsibvhWJizxen/fU8TeNsqAssprmwhsk1Md84XMleUAe3m70Fc2ZMuYmaI
 lITj3hm9d9aNMm1uWwq3BAcGrnhYHYoCMb23xqv4tDapcyCrOLEi+h6XQI2YhusiQJ0d
 4HtnePbBdmFPcxEw5IuCOYC7hhaEVCKmEoD3viT/GsfU4bhJNxP3P6s309ZHeIAXQwRG
 bWNv3vut9kJ3IFx+OLONWzOsb6dvaHZDzwhSvLEPW5gGngOTQIB2HNtbvpo8K6KDwpd0
 DPtw==
X-Gm-Message-State: AOJu0Yw8Z+IS96y8PqHHiA97w1to5qIw9bNS0GdVtVBVVBW55hUzf5Ts
 xfmflMTiZ4fSHeuVob4YFlGpgI1hSEMQBryRoN82Y7rvzrTwmcYb8GWfJnnniBYptSisWBhVXt7
 EtGjHWIY=
X-Gm-Gg: AY/fxX5FiDyiSVwI28K1+y/Iw7Gi1TiE5qYV/Y1EyPz7wYACElyUmjUruvZhUsRizxB
 UAg04//VO3poPgYdBeeu2BELG/GX14HccstmOt6Z9OgbMgt0e4tLbGnbRHnVzYxEYXV5dK//EA9
 NMWBU9NWYYh4Fk/CcJBfJ5l7JNrPDLpq6qFmfH23D8Rwr+SgGgdxebY3xP6C/Izu2qVKCa5o/c+
 FZw2rhLf1PGunTG3jFoyJOwZB9B2kG5Khi/S+tWtaBj1JjrmqdrLUV+tyorciGSM4sFhPYzfnqj
 Q77tBUIz2ZRLuiYZlnAqstFXuBz7G7QekO4nTH8CvV12wZHU2qbZ/7CEAHlDTBkQbUGGGSC3tuZ
 5M5LykRT7cgn+aEDa7ZGSP9BIFPrPz/4pbGnSl3CbFR9vWroU5m9LLCaEmlnzLEalsxHxHsCIP1
 lHxQwxpkV3afmt43STTZ+NWOt4WKzx9x1RhAuestDuWNZ70pc9sYXKujB2hRQb70CQ2w/blMenB
 mScjcOlFCb8E7ZHRU5btQ5RuYTTlyldlFmgxg==
X-Google-Smtp-Source: AGHT+IFo44dOmVz77Kgtx5YAh9XRxGdVrghn/KNRGgrHRKR18B7HeoK6aalH6QrA1ICisPaJfQWk6Q==
X-Received: by 2002:a05:6808:6715:b0:450:aa96:3c13 with SMTP id
 5614622812f47-457b2088139mr16100588b6e.3.1767396224619; 
 Fri, 02 Jan 2026 15:23:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: u-boot@lists.denx.de, "Ching-Chun (Jim) Huang" <jserv@ccns.ncku.edu.tw>, 
 Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20251211183130.3442378-1-visitorckw@gmail.com>
References: <20251211183130.3442378-1-visitorckw@gmail.com>
Subject: Re: [PATCH] lib/bcd: optimize _bin2bcd() for improved performance
Message-Id: <176739622373.296893.14632837062911055174.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:43 -0600
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

On Thu, 11 Dec 2025 18:31:30 +0000, Kuan-Wei Chiu wrote:

> [ Upstream commit cbf164cd44e06c78938b4a4a4479d3541779c319 ]
> 
> The original _bin2bcd() function used / 10 and % 10 operations for
> conversion.  Although GCC optimizes these operations and does not generate
> division or modulus instructions, the new implementation reduces the
> number of mov instructions in the generated code for both x86-64 and ARM
> architectures.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] lib/bcd: optimize _bin2bcd() for improved performance
      commit: 9ac621e671858bf0b80dd26b883f3781cc5acb34
-- 
Tom


