Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF7CCD6E77
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9A784940;
	Thu,  4 Jun 2026 17:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BQC8P13g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08A184995; Thu,  4 Jun 2026 17:35:34 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5CF84964
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6b5c374e5so923583a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780587331; x=1781192131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFtsQAbf9bfuKCHJRbX+zTAay6Z9JPKuj+2/b3Se198=;
 b=BQC8P13gc+6qVjGduMj2LPMi0g9aoO+Z0h2kYFwPURxmUexNVNRbSCcWK+IJ9VCQqD
 Lp/K4BbFUHTXrobRMsLJrmi3EjSxwg4uWMBr91D0dzgkygL9Mt45fZLc1t4mAAKQF+4c
 Is7RcTOqWMdDNsRF7ncbhPzlqwI0ovK8/LHCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587331; x=1781192131;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jFtsQAbf9bfuKCHJRbX+zTAay6Z9JPKuj+2/b3Se198=;
 b=Fd72pFWPzYuV2+rMWbuV2cO7HVW0jUZYjgijXmHQxU1FtT9yUrVLrCAK3A+a88fjS9
 FIvedVHvjpBxityTbKQ/kI6SjNMID22M+y0lx0UOTxMNxWI3aib4vtBUinLyKkofDxb4
 fIg867ldrEY4NTF2QSTI7VfuW2C1ZYKfYEDfYw6XDwljtzedAO5A/+Fgw3Lv+NQz/lUN
 4leOAziQwSP06hXA6rDc/WifxwP1KWbf60qYWabEDue4GBvtFbuPsW8JTO7+XNuKHf7O
 mbpdIue4P1xa3qAiDNaGhLdaSQcqro05UpXm84S2T8b9KVREjHL7GLVNicM/Pj3M7Ghl
 dHcw==
X-Gm-Message-State: AOJu0YxB++YV590ZbKmx3P42l6uLH0mcC9Rr3IBRJqBEJhJqIYInBYtj
 XFBSWnjG7mG8W6Vp5JJCLdaXCkeFzNm84xOg+q/DjT8gUQ/7L0pxNf9jPLq8kf/dmi8=
X-Gm-Gg: Acq92OE5qnSGLKTRxyDRvxB6kUmrbTVKjx0Ue9MH0BoNUsEtoggWjLTniLlYL8DgjnI
 U7AkUJqVhQawoxh40X6oZhtve8qE/m9KYg/dePcskT4+vtvXRMQ8AY+J5mMXx8xreKMZVRibG01
 MPx2fgJE4QM209AO/3UADCHKZHprcpbSwOZbJXzfG3FV2XS/3eCwJvS9if95oj6Hw6LF+xJPVaS
 Ja927Kh5Rf6nEbGKl4kTQX8hywMyDDd4TdWnTul3gjGP8bjZJu1Jb8Z1IEWurt9mqmcE/pMmyFy
 Bd48kAbVz22/eC2AEbIb3KaRSoED5kv/t0gOe91C4rb27UJbdbgSKm6BJsQ0kpaOt853IFGn4tA
 EC8tW3nC/ugODt2d9zemYEgwIO36blifnau5cwr1Gikrby4/H21lNDEocMxDoRl8vYdgMsBOIgT
 AwObbj+CTOSiZOfDxooX2KGfvaxwe37j6pC3dJ2PN7UE4dLx/1AsrLHmxHFt3zssL2W3SX9N7gk
 j9NyrIHLJRc3kf48BNyOunWtPiIiv2nJ7xgdqwXK3IFU458ucDwLrR3outt
X-Received: by 2002:a05:6830:1e3a:b0:7e6:c8e:89f3 with SMTP id
 46e09a7af769-7e6f9244026mr1589079a34.6.1780587331337; 
 Thu, 04 Jun 2026 08:35:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e71fe69esm4272283a34.0.2026.06.04.08.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:35:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260603141814.12672-1-marek.vasut+renesas@mailbox.org>
References: <20260603141814.12672-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v1] lmb: Optionally limit available memory to 4 GiB on
 limited systems
Message-Id: <178058732991.2488090.12988301206304472376.b4-ty@konsulko.com>
Date: Thu, 04 Jun 2026 09:35:29 -0600
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

On Wed, 03 Jun 2026 16:17:55 +0200, Marek Vasut wrote:

> Some architectures can not DMA above 4 GiB boundary,
> limit available memory to memory below 4 GiB boundary.
> 
> 

Applied to u-boot/master, thanks!

[1/1] lmb: Optionally limit available memory to 4 GiB on limited systems
      commit: af4aad1f0a0beba82d2015d79b450b59bf34d2bc
-- 
Tom


