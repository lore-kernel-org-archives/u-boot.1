Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FE2C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 17:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3EF08309D;
	Tue, 15 Jul 2025 19:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gJlQ5E1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74747830C8; Tue, 15 Jul 2025 19:20:28 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C73A83071
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 19:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-615917e9875so384635eaf.1
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752600025; x=1753204825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTGKDxVDs1NaFghLgyz1n4WNZvurFx4ys7IMMMFpGQA=;
 b=gJlQ5E1/3IVX8wlb2cluLRo+qb8/uaR9DiQ2+IdqE015H7QiP8yRe8IGEdOP8no+zk
 e6NMejrLLt/FyAQVnela5vmTCj7ms70FpX2+/PuHCCCn0IdxDtKbqEYlGh3keZOSXQ/B
 hZ3cgyqXh4u6KOHzq1saewuPm8Q5k7xgXWpfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600025; x=1753204825;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTGKDxVDs1NaFghLgyz1n4WNZvurFx4ys7IMMMFpGQA=;
 b=GKavpfCpU3O39T/GO3EJcUPbyrZ/wz1E/Ug9I/t/STQT03vPvJ2tS+EbpGAmeHY51q
 UTKivALpO05HVt/e2pEabA0wDq5fnUiffmmtUyeCM9AF6ozPWR6kq+OJotY43+uidFfN
 npxeObEQQZHbCpw7AApMbIxFYuCLf0X+zt3QL6iqlvq6r0EfwJKByq1IVwxN6QTDGtar
 TNWjoCcUZWr5hz7CxrLfUeHjI8/IuSbIYX3AG/CigTnWTuQnmR33PyAd51WjvlVdgi+Y
 pS4WPtTTuIsqWtzoBctRzGt+TglZgrmpcmaAcyx7W9cyRnojeWkK5YQQdLY0XmbQMuUr
 VN8w==
X-Gm-Message-State: AOJu0YzbznuwpcgmSCS3FzM5A5gZpM5gJdS9OkVkhEhPjMDUtKvsHZRw
 D7rFmV3EJH/PPaG+T6bSjFlgPUgeBSCg++uGLPSnENYLgIkc7VfXmJ6WeZNX53Q2zPY=
X-Gm-Gg: ASbGncu4jOXl030D4+XFk+tgYTKpNQfEO7sE9CAezLtmegBwUPbeduGSCG/rkfp9+ee
 zhnPv2aBxF5C6sBdgauJmEqJ9vh7tfELRYrkzcc5swfo5HDzM8FnMqIAXG6gKkRrpAzDjaWSjwO
 rWEClNfo8djd1XybpuzdCq8amtvK8AaIvVea43K33DkDYDGBrN3MGpUaNXZmwJHEGW1FPemX8vm
 ukxjj2U6ohQwBax6M3NiPbv2Bhgcy3R/9lYmmFq+IPVpoxdYP7UxYbXImAbkwTjgvjRRGaYnp6r
 yTlVBbNXBRDZI2oe9qfrrHu/nGOlECP9qK+l8Zt+ASq4tqOmu6x0fwf+iPApWED8txS+ZsrC0E2
 p58ra0cFVUDtMBySEgsQhVbK/e+Cjr9ZT2O8gU3hJOUNF8w/2lVcQKSg=
X-Google-Smtp-Source: AGHT+IFBJPu0T9FA7nUjPU8KOPl/PQ3/hWo6Md1RF9+ga1FqaScwPmkRCbuMngKdOAkBngqn7TRNnA==
X-Received: by 2002:a4a:ee04:0:b0:615:96cd:ebfc with SMTP id
 006d021491bc7-6159febae8emr84015eaf.2.1752600024993; 
 Tue, 15 Jul 2025 10:20:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6142b0961fbsm988894eaf.35.2025.07.15.10.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 10:20:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250707-exfat_fix-v1-0-e5783978cd11@linaro.org>
References: <20250707-exfat_fix-v1-0-e5783978cd11@linaro.org>
Subject: Re: [PATCH 0/2] fs: exfat: Fix some Smatch issues
Message-Id: <175260002428.441891.14280598447722808139.b4-ty@konsulko.com>
Date: Tue, 15 Jul 2025 11:20:24 -0600
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

On Tue, 08 Jul 2025 12:16:40 +0100, Andrew Goodbody wrote:

> Smatch reported issues with variables being dereferenced before NULL
> checks and also testing an unsigned variable for being negative.
> 
> 

Applied to u-boot/master, thanks!

[1/2] fs: exfat: Perform NULL check before dereference
      commit: 505e2734756018af953d2e5bd1cd6ff7b66b0cdb
[2/2] fs: exfat: Remove pointless variable uoffset
      commit: dd4693136b33f2b175e8cedecf9d76e391acabdf
-- 
Tom


