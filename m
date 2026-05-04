Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF09FFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3AE8465E;
	Mon,  4 May 2026 14:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZfDBbxau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE2280F0E; Mon,  4 May 2026 14:09:02 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C988464E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bc177ebda91so208843466b.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896539; cv=none;
 d=google.com; s=arc-20240605;
 b=MIjHyzSx/DP37IBGK0cvdn/XUiZ3fAOYtgb5UOi8QK9EcQacH+bOwcKDaITEAa2HHC
 1/Pa9EbELQO4MyRxQfAbwob/x6f3NbW6/qH0xVy/vfX4kebYg7OUzpLHELSBNIPc+9je
 v0jqrceztHDFPgBT882kdo2k3Bs6NgUHOUBqPRo2WFt96CNBPBHJg9TVnIayL+7aiyJl
 Osb/3KtINToOhxYUiMbRXXS/2RQFXl9qREn7X1JVJk7QpJayFLAqeA/i7mgu8aTzC/Td
 5vnachro0ilDWQBjnq9wHRmql3j03p4cSjCmrvRLy/C86DXE9f9aUn9EB10tFl7S3gHE
 lPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aMozqYnhTNqbxVmtwkHAqnNfu9YcUwJE4Mq83O5ufPI=;
 fh=PvMd4X2mdXT08JWfisjv9stH8Lx5t+gM5zKif/Je664=;
 b=aFT7mG3k5OQZwHtCJ1Fr/vqBlCpBjatVkMkwVXQHiQEPTf6bYkbW4rMY4aFiHeuZg7
 z6X+72xvxSpX4u/P+rdcPemWl84RUM3eOLdRjxUh0R1LaON5eSPIfeXtb5fyGRxZT8l7
 rb5Yq5WI5H9L7af3uM0MmGETy/lulLyCNDeip+vihzinIjGw2yyE2w3aMqAPDch/H7PY
 k3vWTQOvDZj+te2nMgp0vJAzCv/4zT/hz7c33IrwdCngyEHvaD/uVnTfdm1UuXJXRKNQ
 615ASmCuhzCzLRvDUFgkvFeAqJEEPgGEb4C+w6A+oVh+OR10951eAkpJ/u5ixPjIiITC
 SGbQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896539; x=1778501339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aMozqYnhTNqbxVmtwkHAqnNfu9YcUwJE4Mq83O5ufPI=;
 b=ZfDBbxau+J9HTcaXO9+k5F43ykpE331ZC9st2uSy1dE+hFv2XQv8zfUSpr+tG67+uG
 hpvensBDhLBoGT+Li4fP/cI14w2a4E/aLCDurZzgO3vCQ83GrVs082J540fZlJS5J2Ic
 x7bcvHmOx4xtVcUS0TvRRd3sOf/4u8xEP+6f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896539; x=1778501339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMozqYnhTNqbxVmtwkHAqnNfu9YcUwJE4Mq83O5ufPI=;
 b=sEwmS18VsHC3BlSLoMFTHQQF8xiVUAgX94X4echbek121wdtn/bV7u2DSDLApUB/X4
 XCyxbhm1QhKkwvcun+nS6wGeGduk6x0M8+tom//w8/SAssRlcC9cUb7oPinv9LHWmwcK
 IfBC/N0NCMTd4qShy/TsowJScSeCXxThc+cw7+ZSOcco13XIudqh516aUgrQf5YnAIop
 WYt72V1MZtB1Tu34r3uGHgt58tkNhQkqNfq6uCJVIQ0M2UpFt7b8qFGPCylo2XQnkPnh
 F2eanAU/QI274yjknY3+Lh23MfhYkSDfpfOlMF5Z18fi2+XjuDhvsWY/kspkiVijr7Y6
 LWRQ==
X-Gm-Message-State: AOJu0Yw/DU+8KH8Y5qx13ofC7OpoDcZ/Q8WrJMAWFIg3BcvRi/AFHLXC
 x2K0JJKYZtnQ2NFMVFhssV1NdaPi7+yANypeq64aNJTTlYezgBlmJy6vo7eJbaIkiuEZHF0x2HB
 bPqihW4jdux8h5ZjxbCUIOOG/t7R+mI8t7mLMS4ne
X-Gm-Gg: AeBDiesc0N1jQ5QSDcjJ3J0EbCITsTZkYYwS8sHyOq5jjSRTqr9+ZK1WgYEyjh0gduT
 71VHu/mK10qtC45sBpkriLA1+z+aEgIwKc/0iJ85wZ8so+hU019tM5F4jYfzGMOs+vDq1j+u7fm
 vHsVCUxAKSo98Duatbw9wgnDIoESEKl5m8NLpOOAiiwNP7K+PodX1fVNbsatIm3BDnUFPF7Xz3X
 teS1MYGIiMeBuOTnyu0pc6EXaC/YqZciYr49tRoL04NL1Fd0w9V6Rf98MofHv3NoELm9W0V1iYR
 DTMsYNNAMP36znoS
X-Received: by 2002:a17:907:25ce:b0:ba7:7a1f:1097 with SMTP id
 a640c23a62f3a-bbffa62a5a9mr463574566b.12.1777896539195; Mon, 04 May 2026
 05:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-3-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-3-dde63beeaab1@valla.it>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:08:46 -0600
X-Gm-Features: AVHnY4KDir0ZP0qSw7TWohMkeqbTk6KHRqMm1X_X9MhrnDxuL-ijckC49YqZKqo
Message-ID: <CAFLszTj2X4g1n8dvwmmjqJ3PjQ9p7iVHKRy-23rPAspUj99Ygw@mail.gmail.com>
Subject: Re: [PATCH 3/5] boot: fit: enable FIT image post-processing in SPL
To: francesco@valla.it
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Michael Walle <mwalle@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> boot: fit: enable FIT image post-processing in SPL
>
> Since CONFIG_SPL_FIT_IMAGE_POST_PROCESS is a valid configuration, allow
> it to be used when using the 'full' FIT loading logic in SPL.
>
> Signed-off-by: Francesco Valla <francesco@valla.it>
>
> boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
