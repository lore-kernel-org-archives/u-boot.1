Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98478D2F33E
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFAC83642;
	Tue, 13 Jan 2026 17:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PMKkNZuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5253780B98; Tue, 13 Jan 2026 17:13:27 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36020830CA
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-656d9230cf2so3972272eaf.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768320803; x=1768925603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sOMuRG1YuuMsq2Y2YUG9j0aMjRoIAyRz4CG1z26TH84=;
 b=PMKkNZuAbUcNep5GC80nTxHIGIjw8eoxlMVu/0br7Gd5KLn6koCbOVMCkxEOjUDQk8
 PkTfyuFaRcNXvYztfYzrbGeNTytcVlR4952ySIQXXW8wbLmAcTToMNWyAQOpflJ9x4w6
 wXkQ8C20mDpmjTJtlx568lfvPIfsBWFdoBLN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768320803; x=1768925603;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sOMuRG1YuuMsq2Y2YUG9j0aMjRoIAyRz4CG1z26TH84=;
 b=l9QjhSQis5ocW1C5Yb9a07peHJ82nwhABjpo99mxdHKR2Pm0IHHWK2mvc22PL3Ps1y
 bN1By4V4TRF2z8ySW/cD72LUd7D1uoYldvK1T3+t8tATuWZd12afyEof2HAwNFbmun4C
 J6hz18J1HX/E0jXkK9EVktDEfkmwc/K1H6AxNvCY85OW28jOhtw0IIEJP5KzttlIR2L9
 2r/wAKopJ1vGvbceaLHCzaVgML7dzf0EPVU0Ydur75WyDze5Y/omrI+6RDoqalF92iJH
 UXjlvpKWwgfKKZr+LaxgPcwXXf7u9EYjEgRB/lMYbBeB+97QpkgAnAKQMNgsYnQULxff
 hKfg==
X-Gm-Message-State: AOJu0Yy58nkmH/KGNq8y67EhXLEUZ9uIBUz+Ubq2kfFVGiBNb5vN5fkS
 SGKEdz/9SiSlzSvSFBxYw6Z9AmGXDWrhXpu995ih4gbqRFsSCR6xZZrjorutpAVBZ9qXpeNS8kp
 dIcfpFt4=
X-Gm-Gg: AY/fxX7R3X4W2VREEiwgKgvtyJqaT73RcMqEK+/K3nUJtXnI0maO4y7BuH5EeweZMlA
 VzsQ0KTjwo6LPnwkeb75uqH1pxZ5K07UhYE1cn1pDKS1jZ/BkLtVo9tGIfZLRUQ2trfpH2ZAJae
 vl9HVaJ+ZSnzGrSUH8cReV+C8PyPx0S9hQdaFf1Od6I3NOZ8H+qrcesme73wTDx6ZtAFHZmSTHQ
 RgITW0ebmqHMcrfiTU15tFy4dpdsoXZLEWla4e3aM9FITvzjl5c4Kg/wTZ+ZUuDdrfl0++Jne+m
 UKhSPMIR2nUeo+5aaPEjFsY0BMr2CSsIG5tS2ZJgNXsYc3Ji6Ar17qCnsOtbPp/B61n4yS/Uwi3
 nvo8bN1Y/Jb83dFVhgyYYTHzTK0QwWSHoxszp3X9oIbDmIeoJEcyhCpMwW2azH+jXzcyvSdxIUj
 ye1n7WblsSlT2pZZlc4QanyVPR2OubA30TNY8gSgv5ERdLbfpfvpiiSSeP2PoDKVniTWyZosr63
 dPQa3WAiOQTyKk6a4Cs7/Pc1WsfGunwwDnHXBWGW9y+P8Yf
X-Google-Smtp-Source: AGHT+IEij8RnLYyXCRUvi6upuxKtXKI4wQUBkZIYSOw8jkZcnjeH8Ce9wT3oZEKJ9Tsd64Aek0ifxA==
X-Received: by 2002:a05:6820:a181:b0:65b:37a9:8b25 with SMTP id
 006d021491bc7-65f550855b5mr7633924eaf.62.1768320802892; 
 Tue, 13 Jan 2026 08:13:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ccff66sm8575162eaf.16.2026.01.13.08.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:13:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tomas Paukrt <tomaspaukrt@email.cz>
In-Reply-To: <4fK.Z}kd.3rlt0vRvdGr.1fMdBZ@seznam.cz>
References: <4fK.Z}kd.3rlt0vRvdGr.1fMdBZ@seznam.cz>
Subject: Re: [PATCH] lib: crypt: remove dependency on autoboot
Message-Id: <176832080227.2039494.3318138817567488130.b4-ty@konsulko.com>
Date: Tue, 13 Jan 2026 10:13:22 -0600
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

On Sun, 04 Jan 2026 15:02:11 +0100, Tomas Paukrt wrote:

> Make crypt_compare() accessible from board-specific code
> by removing its dependency on the autoboot feature.
> 
> 

Applied to u-boot/master, thanks!

[1/1] lib: crypt: remove dependency on autoboot
      commit: d54691b64e74438cf24c7ad4d9d54f418808c196
-- 
Tom


