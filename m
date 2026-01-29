Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CC4D6B07A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2378F83FFA;
	Thu, 29 Jan 2026 16:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e8Sh8Vc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B047E84011; Thu, 29 Jan 2026 16:53:28 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE9083FF5
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d195166b2cso808514a34.3
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769702005; x=1770306805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjE19Ghpb5eoysE5hjvmIfUGQ9mCvMlte5iZjt09RPc=;
 b=e8Sh8Vc52wDE8sHDQRR7Tqb3UbTeJFFgfIGSzvjzf+uSaiIA6oGQRvip0ufHWBajpE
 h3Eye8doi9OELH5KXQsZIJu8eVDQMXI+zzxbps62nN7WZac2rU0rr/jYThuo1XWm2fKI
 BKrBK7+eG1a81tCg99tno76gIC+zl//FoWUHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702005; x=1770306805;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DjE19Ghpb5eoysE5hjvmIfUGQ9mCvMlte5iZjt09RPc=;
 b=YNBinCEjPEb3Oq7Ij5Ith0C2v/xNWZ+GIUMRsobJqlfIuMWAb0/aqzUxVg1YKYFKQ+
 AXK4uvJR9Lxe0YyU1H83aXko3nILwF+AgEhzpDylHiqX8zMwsKSPWZqEi4CouZpsm8M0
 rO2VReRrFM3vWX6Rzv4a6E6BPUowJTnUVLoPWHv7HBDG+KC/fk9K7B7NwV0Pb3mWu4Uz
 v/KsFZvOmVl5ovMeXuAtClzOOMzfikGSeLtOgiv7tT+u2zWVwDOioj/fn9ieffEPESSG
 6apfYcThq9uHGFkRcF02YeNstfgrT06RaKSV8C3kbbuT753hRZ7f7Ehy9yi2zgpksYP1
 9pnw==
X-Gm-Message-State: AOJu0YxU85CJL7K9rubshuPRO8edc0A4N68rmSBKPR1OvdR2aGZ7UIU7
 Mm9oLWNeACjqLAvIxMrs9ZlRJ9nCeAA8V11UezuKRsLLzcMtBnXPqSxqGSKQQ4fPDgE=
X-Gm-Gg: AZuq6aJQqlIqKH38stlvFcZuCGZffmWIYw1dnRrGaxTCPaxMSoGLxPpnM8rFOlJ6Cbf
 bhQCDTnz/59SbAtKQXGk3Ue65j7kuh6o+EebL3rpd+0hTWBjHtN3Z0yt4jBVjfFzwrfx/+rjMKW
 n/YyqA58Cj9+t4BV3a/mKAo/PWRF6qUsaEPP5VFUb/SCkqUUklBjMOULpgmcbHphzfVG7SOxmu5
 jkoU0cttpyCP8i8k+I7b3g270L7cAkXPfKQx4Tziy6mYqv0BkdB6GCXYFY+1OwvkWBnVHkBk6W4
 YRln6NC4S+4Z6lJ3L+shINrF0d7pjFcXkPVN265HNnQ8xiENKcFQwIIDcig4tG055jCmtED79DB
 qz6X6Q6smNj5socVqbG9hAy5WDb2G3OxbGaXmcQx+/RifyVN4lkVtTwDlxphMP/gg3jedenhRmj
 oBtFcd8rhM4wsl6XX9sW1oQxFSHCwb6MvYSCsFBdljTVoaDbXePXSqBq8olpIMNVXc3vQAsnO5g
 KCYS7r/wlWEFyKWJA/jJyCkkKxWOlIrmqJ27w==
X-Received: by 2002:a05:6830:6d2c:b0:7d1:9160:7b98 with SMTP id
 46e09a7af769-7d1a528bbf6mr32390a34.15.1769702004946; 
 Thu, 29 Jan 2026 07:53:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c7cf4f0sm3778040a34.15.2026.01.29.07.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 07:53:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 =?utf-8?q?Rapha=C3=ABl_Gallais-Pou?= <raphael.gallais-pou@foss.st.com>
In-Reply-To: <812749b7-c7b3-49df-a2f2-519caa830959@foss.st.com>
References: <812749b7-c7b3-49df-a2f2-519caa830959@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.04 =
 u-boot-stm32-20260129
Message-Id: <176970200415.2016924.1823546867263812671.b4-ty@konsulko.com>
Date: Thu, 29 Jan 2026 09:53:24 -0600
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

On Thu, 29 Jan 2026 13:24:10 +0100, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/master, v2026.04 = u-boot-stm32-20260129
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/29139
> 
> Thanks
> Patrice
> 
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


