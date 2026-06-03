Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B25CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 838E684881;
	Wed,  3 Jun 2026 17:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lp9SREvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A202084879; Wed,  3 Jun 2026 17:57:47 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC4484868
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 17:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-48611d28204so1575656b6e.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780502264; x=1781107064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yn7OsDlbxNFevbnwztmUD0GUlCT/60Jv9GM8AiqWKSI=;
 b=lp9SREvt/7SC1HTrSrIB1MhMOFdnqLEMhzBzDbAbR3nskbZiwiIPKMmTTNhkg4D4z1
 DXu7UjBX9DSyNzeVeWDrQ2w+vldFISJbSK0UH4vIFu3HRgdFYYamFnG9I6Em9dAJE4zc
 0oplKqh2lDbg3xq8ci9+7c27bCAiU9PTWEhhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502264; x=1781107064;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yn7OsDlbxNFevbnwztmUD0GUlCT/60Jv9GM8AiqWKSI=;
 b=moAyW5rNYyAitnCjSu3SgwhFcTDUTgiemIX/0GGMupyWxPYHoK4luf+HpjAjnbYzeS
 OhLK6QONe3jUvp2WPgtPpdeEN2JqO9OU/pvV/Hdn+1HbuLGqtS+tpRCHsvSH2JkdTxdV
 MNyIA6JxJIEaTZ1qQTvvFd0Ly8xqgMq1J8i4t/Hr/CbjbeClOmO9HC9bKEyDlMkQTUfl
 hjwt05Ztdszt+4BBzzO3HjNJurafcaFoF7lcwrqes8WDqc7z5JNICO/cJnvAxqKaAWts
 lHlcsBGD8c+n8Ng88R7NL3MijpAuqgZm6awBKGy//fa1PUwdZmNl4aPVxsqIhsWrb7l2
 mBJQ==
X-Gm-Message-State: AOJu0YyJvf4N07RsWRlhI3qQmkV5oIvzuc0YVBkabZ4/b6W7kP8TnDAa
 u+/9gRpfF5UwBgA2/JLuTR2UEBlLc1tMa64uPleA0LodF3kHteVY2tbfnHog8WEwwoI=
X-Gm-Gg: Acq92OH3vxuHSnB9REa1BisdTVTRO7pA2TVC1Wipqw5V5CrFWiF2GoEZeFb3xb/wSBJ
 aHn8PVHUR/m0yvR9cE2/CQIyhA3SxupMkT3FWZU1AEgfunQXaVHgVK7kKx0nl7lLN1TWi+VtIBj
 j2EOw6NfNzw6qThW2PT2dqMf6H5lKiw3y/5BH7/kBZGruqIdYARgJ+1k/QhClND0GnAdjJiIjjO
 muVy40hp6H6pDJfO1DbBmAcVK6kyP1k/K7ywIn2zZL5DzBDiSSI1UBf2A2PgR/7xnvYOrSG0Z4R
 imQcNOOh6N1hHZ1YMK9vk/sK6KkZHMUezPCmAcQpDPJ+zmRUiEsv8/OfqcYdAblso2JyGaKf3Bf
 M0kdWKrw8SHZ2KQnrdgrEHtlcK1XkHSlAFiHmc5vfV833W4/MS2VXJuotxUrv9Yy74SVxw+1XfH
 kLueVptEu4u7+INiFz5xAmsPQzcNh4Br+fHsnf4+lCG3ApLOWW2UoJR7gd/6CIyic+bdgtlfEYC
 3KmAK3LBbp9GjlkNQ6qwbU/U508c1i1JtZimzTtl1zyhokRBcxovu27qXF8
X-Received: by 2002:a05:6808:2e45:b0:479:dcb1:dcf8 with SMTP id
 5614622812f47-4865aaf9624mr2666443b6e.29.1780502264059; 
 Wed, 03 Jun 2026 08:57:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78e7f9csm1970441a34.17.2026.06.03.08.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:57:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
In-Reply-To: <20260602231810.113143-1-marek.vasut+renesas@mailbox.org>
References: <20260602231810.113143-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <178050226318.2193579.5359812125271105253.b4-ty@konsulko.com>
Date: Wed, 03 Jun 2026 09:57:43 -0600
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

On Wed, 3 Jun 2026 01:17:45 +0200, Marek Vasut wrote:

> The following changes since commit 30b77f6aa146c96b831cb4ece038130b655b6a41:
> 
>   CI: Sage: Drop rpi_arm64 lwIP variants (2026-05-29 11:03:25 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


