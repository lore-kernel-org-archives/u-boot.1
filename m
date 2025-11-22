Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE716CFC51F
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 16:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821AF839E8;
	Sat, 22 Nov 2025 17:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YZnagT0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44C9839E8; Sat, 22 Nov 2025 17:23:29 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBCB83AEF
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 17:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3e80c483a13so2005207fac.2
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 08:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763828606; x=1764433406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgNbRNaoTHZtcdiVHbirqXorZdZ0CBw5RQDvEW4AyFI=;
 b=YZnagT0f87u7looXeEfGFbmbZywkvP9xTTECph1L4Pu23i+2W2BwxPSHMeTBFt68bR
 I+WrjSdAfDp4DK0xaFWdlDqjP7xwrtQZ6ghe/n+A2orqkP+J4yOOoBwiDr580yiT0PpK
 jmAPFYe4GhA5sDDVTA18ROAZmeupB7sBnAwTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763828606; x=1764433406;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XgNbRNaoTHZtcdiVHbirqXorZdZ0CBw5RQDvEW4AyFI=;
 b=H71gmxnc6INeY7FFktvfbptJCF2gopiVm62XZt+YjV3nBHr9TUi9B46MPfUM3qMsv5
 Kc8fCWV3TSoNxZ+DlvF3HE+sZ7xKeboH1PxCdYcPf8tu6955An7O44NxT7CMipclO+BY
 IZb3/kjOF9TWf3Eiw2P6W+Ed9egY0SPKlLGkevNSTDeTm3wjwUAVMm3HEbEhaYQhoxm8
 gmfj5bSQ6VvlBLZUsaM7NY7l7D3+eRuD1rOmm3fOMTbyp2m6rr2eZvcZ+svEJVNtDN0P
 xbTaEBxRBFO3T82OsKOAWM84BKyMFfLbSNCuMOaoAtT9ZhjXBAqEPV3ZiJc6ZLIf5V+e
 CR9w==
X-Gm-Message-State: AOJu0YzxVD4ff3edDPkMPfeFB1Ucb1fSWYcKXnjfxHKASijpm8S1mh8L
 i087x15GIpM8MGRs5U43LT5yscVuJDWPcfRVbbUXYUjIRgudweWykLkHx19Tw4SGVa1gwKBQHmt
 ZkPeJrWs=
X-Gm-Gg: ASbGncsAA75y4Tu0VwBjf/S7o7vTj9gGwlXWasr6RhnuFbDUuMeD/xFBWG4qSiUgYGB
 Smr8eWBzq0EDC0IUOJ1EOiYaLatLZMcZHiuaaZ0a/uuMcEpCSa4RzQH5iehY1UwgiTTWKPX2Hbo
 tTIvkzjpWrLpqHdnJmAj85wu9WVLs3BNhgAdmX3xkKJrT7OH0zfPp2cGY87iaSiGVkdHh9/bCQq
 voAFzaKuFCLDGD0LNcV04TCmBZVQJa4NXz0LygV6Vof3uqHRgtCSRw7Bw/RQfjrv4RSouX7CyDd
 76s/XIbabs25ACyCSEv8GbEqzIo3leEAlC5wbvGZc44groWvLxdxnFoXgGz8UHrXgIqHGOC1prK
 Sh/at6eWyz6wk/hKYtTh981OptCTLR7/+6LB3pQHzJKLlMjr0fe8JzFjRlQrxbxRvmEtDzvlBhx
 /qDPktiDDV3SadL36bexHOkV+5UoJbZnE1W8pd98BxXv+dnkWW
X-Google-Smtp-Source: AGHT+IFkkTPdS09mAKyX2c3Y9Jq8HT7yNIZsYV4dNcO/97gXywfNwmbCDO/VgZnSPycU9RGAA9u+Sw==
X-Received: by 2002:a05:6808:1903:b0:450:b0b2:96ea with SMTP id
 5614622812f47-4511572ee91mr1957759b6e.1.1763828606025; 
 Sat, 22 Nov 2025 08:23:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782a359efsm2488378eaf.4.2025.11.22.08.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Nov 2025 08:23:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <74b3bbd3-c1c4-4711-ba4d-42424dd378a6@gmx.de>
References: <74b3bbd3-c1c4-4711-ba4d-42424dd378a6@gmx.de>
Subject: Re: Pull request efi-2026-01-rc3-2 for master branch
Message-Id: <176382860429.3054897.10110492416110157212.b4-ty@konsulko.com>
Date: Sat, 22 Nov 2025 10:23:24 -0600
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

On Fri, 21 Nov 2025 22:11:18 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 2bc0715b558fa1ac5c88b11e250740b16a905837:
> 
>    Merge tag 'u-boot-ufs-20251119' of
> https://source.denx.de/u-boot/custodians/u-boot-ufs (2025-11-19 09:04:32
> -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


