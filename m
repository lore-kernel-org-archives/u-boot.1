Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50350CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E345B849ED;
	Thu, 18 Jun 2026 17:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M2A0JI4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2481E849E9; Thu, 18 Jun 2026 17:12:56 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41682849C9
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6912f4acca4so1801498a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795574; cv=none;
 d=google.com; s=arc-20240605;
 b=bSTy2SGrvvaFlXpeJALQm//VLxnTjpwiXEo4NmMzRExi0VV99qtUMKLGvOZVKvrpx/
 /TK8A9Vu73mwYi/I+LzVklq4vwxjlHuQPrCRQUGu/m6ApJjdk1TkXU2jZefnnJS3MwJ3
 Ci90YEBrqmS+vDMyw6LyO4f/tleeurAdjf3wSY7aHA3I8oOlwBEFZEDJhFOx0LmK3jIj
 pH+EN6VFUjozOgUcwtQeYOEkOeC3tbqcbfP6HFDczG3vjjafPmbIDtxQIddjMHJxXAKd
 TjoqMXNsjI2ejEWNY8LxGjGpQt8hmT+W3ct4Cwi17WNziy2L7F77rsBMeSSXG/0yul/w
 96Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TLEWP35bin9HKy3bSZU6hhBWbjkyDB4An4WOhiXsLcs=;
 fh=yOpbVoGHCXeHD/e/WwluEoSkycH7ou1R4r9lMor1N4A=;
 b=Omw2ZZBhevtaLzd4aYRnB3Jk+8PM38iNDPqShmspke0GXhFJIv8Gg4QG/DYprf7grM
 9ulc7CA16yZxxYmWjcGNoFvweXVL5xqNRN/Lcir2DyPYZnXey+sGCvrmjrq98QYoiby1
 M0A417CFz/hmTHECJSlz88esNAaAwprBE8N8KfjxlRW1VKdIIcAWo6msvlt1RvNP65M1
 is4czp6ie+eJ7yDQ77EpHQPDlAFz3dBoTm+wWXTPVNV0XOibCMc4fFb8jy5BPXMwGEER
 JBVNfHwzDR6sOfNv48tmdgE/f08+plWTOizAoyCpRws8rpkomjpKfKkQeUOmN/TqNPqE
 zEUA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781795574; x=1782400374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TLEWP35bin9HKy3bSZU6hhBWbjkyDB4An4WOhiXsLcs=;
 b=M2A0JI4fJNFrUTr7Bb8FSRxrw+6+/8YZjW0xVvKQpA/X4YBgu/Cj5k0MxSzygjCH7t
 VDhad+LZQK4JcxvUmWeDrQkHHUES7FF56mNt+L2AbfP7P29ap2tNLZXptKd1i6ZKt+ZX
 9aqnB3bCQjNfq+Ht+ftGS59z1+CqaycAxugHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795574; x=1782400374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLEWP35bin9HKy3bSZU6hhBWbjkyDB4An4WOhiXsLcs=;
 b=MLy6kPm/wNhMhNahwQ0pWaT3BZvKxCC4NGU+0kMIFhAZDJ/i4gduBQAwxbcF9V/osQ
 5MMLVxo1akjQ1PA7tCLQcR3J/9iN1JdiH8kxZABm4diOArmQLZpv72ci35P4NhENxpvB
 GGv08Dh0RZagQpKmRx72Zo59Er1Tdxs8m2locPDalYFRyB2YUdMCyqmBNWup7eUKrzbk
 IJ39d0VdMOoKBFgjx3+OA09i3+sJNjIYD6j/d1NaqgyLqpmDX4JAQ7UkyqgR1LJTNCko
 pulM0Mf7aXN1ev27lhCfGgGfYCQy8Cuf7SfbZyJdWr/skvpblDnRXquNdiMkUN3HJunA
 AZIQ==
X-Gm-Message-State: AOJu0YzbqvdkN7CjTm5cmyfeBWlu1ZJwCwvhd7HAAiVIkUewbbmPLW+A
 K4aFj5qWRYmvdjLyfDfARX0FXta2SGhDFWkQNixkHEHHArtT4TOIGIePHmlExZqnwW9z9dglIgE
 HnZaxGPOMbtRDBUPXkMWq4G2/j8vqaU0XDdA+fFte
X-Gm-Gg: AfdE7ckUqMh0yl4GFPXjXTj0bPaSGy3hwRK2QO0Hb2BQNj+Wk7/U1WLO6G26NNkYQZr
 ajWeeFV/JTNSY0WDWOYge0oqntBP6/C2O3eaZnMoTJ3O4MTizRvWF+bWSPLSCOht6ALIRd5y2Ze
 qozm3shfPxO0yD58sDvAt59HgTiWtHkxNtJK1zreta55cKb61u4hhGNJu9IoFbacq/GlzM6FaCm
 be7AVp+1WfCx+6ChHWwDqipNRXXjLl017vLvpzaRLX7yEYPqJIa//meKQ87dcJEqNLuvpCEaw==
X-Received: by 2002:a05:6402:2743:b0:689:92c0:22b0 with SMTP id
 4fb4d7f45d1cf-695bb1b6afbmr2265688a12.3.1781795573650; Thu, 18 Jun 2026
 08:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
 <20260604-spl_fit_full_cleanup-v1-5-ec036b5872e2@valla.it>
In-Reply-To: <20260604-spl_fit_full_cleanup-v1-5-ec036b5872e2@valla.it>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:12:39 +0100
X-Gm-Features: AVVi8CeO6yqcGN-d6z9KsUql9RVEX4adG50xSOfIkpTOPeWA4YPj8KwSMIX37qs
Message-ID: <CAFLszTifNxVOm=_1n+vUmRaHzA+bDR8ZwmNCU6+x6sQdVmwU2w@mail.gmail.com>
Subject: Re: [PATCH 5/6] spl: fit: use CONFIG_IS_ENABLED whenever possible
To: francesco@valla.it
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Walle <mwalle@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut@mailbox.org>
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

On 2026-06-04T20:41:35, Francesco Valla <francesco@valla.it> wrote:
> spl: fit: use CONFIG_IS_ENABLED whenever possible
>
> Replace #ifdef directives with the CONFIG_IS_ENABLED() for better
> coverage and cleaner code. In the mean time, convert the last
> IS_ENABLED() to CONFIG_IS_ENABLED().
>
> Signed-off-by: Francesco Valla <francesco@valla.it>
>
> common/spl/spl_fit.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
