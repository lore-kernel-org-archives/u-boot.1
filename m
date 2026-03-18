Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A461077608
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 18:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBCDF83952;
	Wed, 18 Mar 2026 19:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dPrsN+E4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E59836D3; Wed, 18 Mar 2026 19:59:44 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509D6805D7
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 19:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d751ef36ccso120924a34.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773860381; x=1774465181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nkvtm6TMXGms3U5bsQAjLnlK/YuZhogak/aErsVhHYU=;
 b=dPrsN+E4Lpc8zJqhZriZDSb/4wG9c1e9aSMyDUDkcVz8gMGoBOl/exfAeXWNSsp8PY
 JPOUmhVDMBG9/jFVHTPhHb/yI2ZtgTMqoZMjidmOCf20pYtUi9mOkinPiCi4tnquNAIo
 ez1FCbnIvqEfZc102Ni7uLNqm593WUTJPCoPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860381; x=1774465181;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nkvtm6TMXGms3U5bsQAjLnlK/YuZhogak/aErsVhHYU=;
 b=SRMT/r6R1kZPvuJAY9+HMMpIBnskHMXdwhYh3F9SGo6f19y8hQne8wz+vsfphusw5s
 3LJh/fsaTAb+fDrGwBrL9LxfvORCjzLls0ajf1RuWmQZeoZRRo7X8eEig72meFuCXQHN
 rBZs1SIwi8K5WS/H98D7w51wLc3howSrq7ztSQLxOAeiyrK+3vsW58+2C9l7I8aklJta
 +AObJtikT/u7K8aoTKJv1Jo42CA+1LYne6F/G6zNx6qrZw+/mTBVHU2AyS1FVxVoapGX
 86QJAQuzNAB5BPgXOKJiosYHMSe1waHSlzHP768Kd4rLl4S4w6kYYPeEmVzyx4kLCCvs
 2i/A==
X-Gm-Message-State: AOJu0YyogO7n7l2YAxI+H1WCNlk5WxoKs/BN34rgtPUPXpZRDM0SUOoK
 wSXot1eeF6MFg6ZA4PktJ/NYSzhqqiY2MHt9+JBbncVWi6/OmquZNS3XqNhl7qrW5+M=
X-Gm-Gg: ATEYQzyC0B9pD1jvDMSDqMJMhgSNe1jQnkhUjBxZXwBUTkIEmAnLOxlaOVE8FZHdPd5
 DHyQsC4MES2teQ2nxVsGN4HviTZoKvKXF99PNI9KPrBdZe28hIda1C5boUxbok/BK/vlnNlqwFO
 x0sR5+084Qg+/SdmBu1cMuW+pDnkrsO17LTExpnZRcPphPWELIL9jZ0pdPCRvGo4Q5r1I8CCMz8
 rAQdJLzwCyfDq3b8wvnKbPWnIPWewIMA9VxXKi83dRoi7PZ7v49odnc8f9kKRHj0CsABQ+S6qKv
 Eri3Z8evBhhS+8Jl9X1Pk/FAf5O5QkwDDdM50jDrI5pvH8TtQJL1gWbdJ6WMED/kzEVW3VRyMRz
 xU4Kw68OsRrH7ELpJALamrCRV0yBiK6U9EPGu8odspWSisDk0q5QhA+3IsZgGUgB2d7yseZNBSc
 7f1rJmL+2iR1ezUu1rfokJVRyINU3TDcHV8kii7YOMwbYnzJMYAYLrp+Bn8Aax0wUjh28RYNp3Y
 LnEqbFP29GwJblTwMJe47t0FeuUErpJ1vwkXB2dAMns6M4=
X-Received: by 2002:a05:6830:6581:b0:7d7:d1e1:6982 with SMTP id
 46e09a7af769-7d7d1e17407mr1490239a34.29.1773860380915; 
 Wed, 18 Mar 2026 11:59:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9985c1dsm2807715a34.11.2026.03.18.11.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:59:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20260304075100.3637609-1-hayashi.kunihiko@socionext.com>
References: <20260304075100.3637609-1-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] image-fit: Fix mismatched parameter type in comment
Message-Id: <177386037998.1227559.9700813575131573397.b4-ty@konsulko.com>
Date: Wed, 18 Mar 2026 12:59:39 -0600
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

On Wed, 04 Mar 2026 16:51:00 +0900, Kunihiko Hayashi wrote:

> The functions use 'ulong', however, the comments said 'uint32_t'.
> Update the comments to match the prototype.
> 
> 

Applied to u-boot/master, thanks!

[1/1] image-fit: Fix mismatched parameter type in comment
      commit: eeca6ed86ff65cb8213d0d960a0733c7d8ddde5d
-- 
Tom


