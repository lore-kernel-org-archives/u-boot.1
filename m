Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0554EFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE30846CE;
	Mon,  4 May 2026 22:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UXtJBWq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C086847C3; Mon,  4 May 2026 22:32:06 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BDE846A1
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so8864248a12.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926723; cv=none;
 d=google.com; s=arc-20240605;
 b=ZtXyzRXrF/z2iAn/UYafRgBamBpMw7JgfIR+i+JP4b0/wQ67wN/k3QHLkhO96UsL7w
 j8pD0YSgjL+cCz9WlvqiYgp41FJxqVONsGKS4orrrzKHlU0qpdvFT+wGuTq1Ayx9WJfJ
 FGq28x8gsFBcOTEQurc3ccp+e0rRm2vDTvl/uxorvRNrXtYd7IuK57fxqtW0r1VFV/qQ
 U+gV101oSHY/F6bw27zTtaZkBPofaFGSZxW0aRE74C08579PHJdshOA3HWjg7+pyIMzR
 zBTasNQX3iOwpHEHifL9zwQDmThKsBjhDsLbnf9M7RCxykOO9bDsAKRlTbRgw8lpuvjp
 tlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3zji5R/Q6SYwiniuucX7mWq675uYBxGMK1Cc0/Hz0J8=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=dU6Z4CXauKc+qCxFJNXU35VZ1kQmmuY1r1whVg73sDi/gMoZKkRSkLw7R8jcppr6IE
 T8+Fzy3Pv+tqHn/2wetRvN5yJQlUkg+bU5yVBAlBMM5rybWikWtjdZs9pzOoAKnG6thW
 chiUunjNdl9EY2Nceoa+PVmHMUfXE/xAIRnyouAmyCBDBETsdofCccCLnTxQGAkh03yI
 yOzskzrU/YFdKldWmBGw8b/HvGMesk+pKyDCk+++UXL6AudKUomStDz0Aw8f9w4/NJSe
 Kl2TTZl7noow+tTFxR7k1wH7W4Zxnnkl/y3GSvyV+MbzLxNjxngEpJiLgeCBEq6GpPsY
 VKEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926723; x=1778531523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3zji5R/Q6SYwiniuucX7mWq675uYBxGMK1Cc0/Hz0J8=;
 b=UXtJBWq00C5/FI0JB+phfrx+kuu6LsV3sZGD68M/v/aMdRU728CnelzMbknaUlMgkG
 bE1CZJuCbUxjaIcVCEjbgJXoygxu6Wfa/Xk1KA8B0S7MwOYYGYK/QvKAw4yt768HUyIY
 +uKWvghG1HyfofF1cjRkNDIJALjAqi5BVn7vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926723; x=1778531523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zji5R/Q6SYwiniuucX7mWq675uYBxGMK1Cc0/Hz0J8=;
 b=jZZtAVUwZYdFW8bOVmrFfvv24NY++MGyTTuw3tZQa37VuXwie1FI51hsmuxPz5CF93
 97EmaRfU1cGl7H/rYBxiWy6mvq0am1Inxu82i9T5RGsZeE7BPDPZt/aI7YqXiLRdrhbB
 5Kwc5J7yXnXsaPHFnW+w5biwAA1IDlz5QDcr0TjWcBTlNf+/Ktu47siZe3WQheQa6nrg
 7id1n/8N7U1+A5+9ihrocHKC3hLxiwo7Zt380dSW2OGOE34oxYNiFwIqC71Gf8a76H6g
 ngJplWUfN35nD1FsMNHWBBoyELC8goO09bGmJb9n/NHcFNAA36hhEluZehyDZWFR7hxC
 U/MQ==
X-Gm-Message-State: AOJu0YxxWpzbSTKnZkTtIYGxDI40Rmcp/+xmXt86WxRwMoUJhN6pxIeR
 s5mDLt6/1GYT1Rc8GgoiYTEsqKlpdIfWmOHSt46IJn0BMBuOq5HGGwq1s108kz5itwyuUV//G8M
 OhUetCova+X7Jca83Bdj9D5vMzcJo6JuEOsBp0zaw
X-Gm-Gg: AeBDietdkgCrcJgt8wLCVXrHMiuL+Ps9WMe9mYK0EJfjmmIvvGV7gcNm7evdXZpb0xf
 KK2VYZzFPi4ZCnHhATQA9+b4sCdzE2po1TXHWPjC676T8QFGaDkqgigzwA8bUUrDt60eGzZ86g4
 1Hbt9ebZJSBeqy1D4QEEX6TnFCIIY8kwEdd29rIrWNBhuJa/NT74saeJ/fEacN861mt8Ul6I+9Y
 8z5VCCtLIp+i9ZRUoRwsuhkywSSQ39K3avqKnm7IibPnECJ9YCUCaTrUA35V3ts3n10qAyYJbbO
 aG4xlVeTtCs4Tb/S
X-Received: by 2002:a17:906:9f8f:b0:bb9:120f:965 with SMTP id
 a640c23a62f3a-bbffab2fb42mr637124266b.7.1777926723071; Mon, 04 May 2026
 13:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-11-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-11-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:42 -0600
X-Gm-Features: AVHnY4LQXBtxmYNVuj4m0wYeyaJ0scZWBG_dKHCoKGrSPuyk-6jpB6KJz3pA9AE
Message-ID: <CAFLszTg9dG96FjD5iQngbmoCs07YtNcEg9SCFrgG6-u7tn33Eg@mail.gmail.com>
Subject: Re: [PATCH RFC next 11/18] kbuild: unify W=e and CONFIG_WERROR
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> kbuild: unify W=e and CONFIG_WERROR
>
> [ Upstream commit e7a10929c574cf30981a8e19ef39bc35e63e8b46 ]
>
> Original commit log:
>
>   The two mechanisms have the same effect, unify their implementation.
>
>   Also avoid spurious rebuilds when switching between the two.
>
> [git conflict trying to remove the KBUILD_CPPFLAGS for CONFIG_WERROR,
>  because U-Boot didn't have it before, due to missing backport for
>  e88ca24319e4 ("kbuild: consolidate warning flags in
>  scripts/Makefile.extrawarn") which we won't backport for now due to too
>  many conflicts]
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.extrawarn | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
