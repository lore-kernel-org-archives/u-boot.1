Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EBED61033
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 17:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438EE8409A;
	Thu, 29 Jan 2026 18:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iz5aPhrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9502B8407E; Thu, 29 Jan 2026 18:19:04 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB7683FFF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45f171cb842so802809b6e.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769707141; x=1770311941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ef/bN3uYxyL5XNUDEPRjZwrJwk+p4VU1blmnTVrTq1k=;
 b=Iz5aPhrfmt+gKhDBnEAf7e5UN61lSMSWi8Yfk1PXKEFnCGewWqidMOf9QPIsunarP3
 ynVOGm9/KSOKHDEWiJNCJ6JcbEd3eRKLa1b/JDnQQUvAEAbQcSpxWNZxux2iUjiEP/lv
 GLCeLH58hPUaRF6vKjZX5hSUqW++ZkdB0LoLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769707141; x=1770311941;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ef/bN3uYxyL5XNUDEPRjZwrJwk+p4VU1blmnTVrTq1k=;
 b=Zq+tjTsArQZSuxDxFrxbItc9Btd1pLGDpslZrApXiu1SZq2kATcXdrgJFk5bBmONoz
 0XXLIuK5G5848XWbyjF4+3YISgOpBeryMCcjGc8q/WUoTMDcBIEtzPkgbGbguctJDOHp
 aLwKfreqbfzuHuBPqqygw5PtkL4UZF42O81d6IjdPQAjHwjuFAHxXVRsmKUcyg60goNa
 7HpmBBAojK+z/C7SHCWicJy9xoDSCqPj/Aj2QUY2rjf1vnZcPBCWK3AyajFWE/fqf8UD
 op24TXpKs+4q/dGWErWRSHrnR/SULj/vMmODdM/vvhbINcTbI1rFWkJQ1G98gUFyYGig
 EzfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzKwwC2L9hfMdo+jKoXtiWmD2U03PcCKNGuzIBk4TnzqSfDgRMllYeAl5q7BBM4GdIxl2/fvs=@lists.denx.de
X-Gm-Message-State: AOJu0YzLZ+NYRaFn+JyaH8yPbH7j0BjWK3ZXCPCNoPi5zuJttizXSpS3
 BDEtuyASfFdgm/gMvEUFbhEpNGmewmRVukEs9nrR5n38s8pCV0+trpOVADNRqIOG46VHo9kYp2/
 htDvqSuI=
X-Gm-Gg: AZuq6aJ/ZZeXISRAJ4cRju63rP39Qib1GzxDbUzxc3u3Iiyo6HJWYoYZB4hCq7/HrSi
 S8gKsdaXzbFmNQueb0MxKuhSrV2qIora6nFH/soGhQsyonQQysmLLoPpvvsuMVHZ2QS5vqb3yeR
 rA8RWU+VdtDaKfao/epMf2bpS7hVfQwU0vKeeTBqHjGCNtFVs/faBUA8om3sSMzOa1WEiRrAjgs
 oDkQLGvcn+2Cw4FSHKxhmz/GryMgGZkw8XcaBBuxEtJzEyLMEekwTIjbgBtc+pcstq8G+iax+Tn
 0jrLpAm3sbxjRnfFBvgRTPvJ4AKlRAOW8CIw2IYpRLM+MOHJ4rPzq5oB2UmxA+I/0KNRYvY06ZJ
 kwhMLPtlr6qeHWRs6HDEs0PvyMGtB27k0ofgmWALQmBVKAsLtRe3GuZ9zGJ1GzwWVTz2ZPLAg+z
 112ztoq5UJ+DykCPUyWNYLpZHDIyln1GTN3sOe2UgY396Z7KhPEuLvGJMmyYeelwgpqo4Ec6JO7
 6bV69fEfp17giz56DNlODBXTTWZWI3oc9se7w==
X-Received: by 2002:a05:6808:6782:b0:450:b87b:1ec4 with SMTP id
 5614622812f47-45f1e34698dmr1750806b6e.15.1769707141274; 
 Thu, 29 Jan 2026 09:19:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08d894f5sm3413822b6e.5.2026.01.29.09.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:19:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
In-Reply-To: <20251231192157.248090-1-heinrich.schuchardt@canonical.com>
References: <20251231192157.248090-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] video: correct label for cyclic video_idle
Message-Id: <176970714010.2054445.2468137564413437735.b4-ty@konsulko.com>
Date: Thu, 29 Jan 2026 11:19:00 -0600
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

On Wed, 31 Dec 2025 20:21:57 +0100, Heinrich Schuchardt wrote:

> When the cyclic function video_idle() takes too long, a message like the
> following is displayed:
> 
>    cyclic function video_init took too long: 87707us vs 5000us max
> 
> The text "video_init" is misleading. Replace it by "video_idle".
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] video: correct label for cyclic video_idle
      commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
-- 
Tom


