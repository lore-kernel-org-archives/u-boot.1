Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6123CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 06:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43DA98460E;
	Wed, 20 May 2026 08:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q3fKvIbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FED84659; Wed, 20 May 2026 08:34:19 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD2D844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 08:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6587cee8b57so5397954d50.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 23:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779258854; cv=none;
 d=google.com; s=arc-20240605;
 b=fOoGjCoUTIFMl0B3l6nZZrFZXsp7Pnbpp18G81XRcGyP9CZuf3oI814hCcCVxkrLm0
 eibZs/3js4x1O3WiTw38QMLwF1DTUpZzn9EurZAEK+RCmGVWuzv9r6ksfmXWwzpyF10x
 OhAxbksCeSwkzGTCMxrw6FBAUQmNTgK0l71TY8SYkoFwKnxD6RwAGP4xN9g7VMxKzQKG
 0DThY4oC50oAyXWmcmgl/29N7j7AhZeQCLwLPyvewlgSOv55ymZIu0Y6xWxt5I1iYSyr
 myhObYY9NzPY9/4ipu5TLUfXv0OmeYPIkfGiPj/0BNeKyR6SvJseYZg+FOeHWHbtYD9S
 CdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S4WXDw5DQn+UbQNGrB+43XtmpxTvS4CSVvNu8/jZ2EA=;
 fh=1YFjU5b9WB3jclHra/dbEKs8P1MocCIZNzaX587XNzA=;
 b=QK7r1cxAuKS7SuO5feeWAJtkWAc0E8Ct3mk3PLCVRwM0hnj7Mm9ViIJ99OWAEnZLpC
 bwzSgo68xvjTPBWzus5b01lXXcw4Qvv9O+EzISOAAfwe1o+fY9vT7inXNylJXfjRQ+K/
 hPtDCd6ZN0zvPFqJS8VkA4nbAB3/pUIQ4J0FUUSSF4yxw73vHehe3VutU7F4w8MXAsxi
 OHno+lv1OsOPEULFBQRFXlkFAtGWr1VzCgf856zHUPCdriCHE88nR/TtWIaomaBHV7YE
 vhpYOGMMV17WPWZCkt6q55YB4fkmlr6+SGuWH3gB49xjwRc1KTTRbMTnlJbyRXHMAA7P
 Rw6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779258854; x=1779863654; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S4WXDw5DQn+UbQNGrB+43XtmpxTvS4CSVvNu8/jZ2EA=;
 b=Q3fKvIbFXL5ZisNK8JdcdveZJyD4yo2r0b9JV5HM2odbM5r4fOff6hzJ1gtbzqLy1B
 tA4OExirCe6dswH922QoWCgV2a1tg2SQEGwtSKBqGSu34vyCtVxYA4DgWK49/Qdd4XSi
 WJ9hrnfaVewzjI6QlN3X7xq1/TyYSmTyRH92dptgUFmsMjXsMXJ/SMipfKL7cP7lEBdX
 pXsa37/Wf6frddR2dfEDFq4iAbjFgtXobQIpZisViRotsM6GQfUfICea+Q3r2I3NYNIM
 uYti8+BTE/iqgu3qzmfHZglJck/rDhfXoWVxofFA8G8TF57yg3dYcbA8/6GtWrKdkS7N
 rZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779258854; x=1779863654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4WXDw5DQn+UbQNGrB+43XtmpxTvS4CSVvNu8/jZ2EA=;
 b=i8wu+DH0z6wlpCiPQO3Y7WcofEbdeH4w5mKYhLDkNt2inAemyMZVaNukZcoyTkSBfr
 SoFVwIblvShiz+AqgsuXzJN1yd4bNaG8pu3DovbPhg4KQ1RL+D9Cx3oIZA0pQe4JhoD5
 10IxjqF1vvsiyJsiVR29V45H8pqQzpfvgUER5XdFjoU6ZFGlLsojITx9uPzlCOWTq3jQ
 o0UgDGg0TVhfu7SfvRW3WHYfHzmqYQEyxHIpaW9BsocbGJfI8PKEQHP88yD45bebl6Q7
 XFZ7+lJOSuHuEckWfiWYIiEFbpVkmLKhdVhHIKAvznBLEaKXidxmnRWlXerrFE4r7ZDt
 Egog==
X-Gm-Message-State: AOJu0Yw0cgQ0JxBEQDwiB0osLFo8H2QCA9fMuGbQSq13tebNpGuOY3MU
 57nKeZAJnt7bWRdMiUx02MYKN8QR4hQT+V8qWN3G1SAzv0YdOlceS5MoX5ayiLcBd7V+qMQLg2E
 UIet0cLeLfeCZ4WNZp/5p/9jNJqr0LNfSKw9lr/yhrQ==
X-Gm-Gg: Acq92OHXS3i2SMkAaXoIo8qmTgOwlFf14FSL09S6hzHwS3Lz47TDeg/9T8/xv/tCw93
 jOj36n/0bfPVEZu9rA43ZbCbrdwecD9+dSo0rJq1FhgcOpB2ne/nhE+QTdvV1V05Ya9r5dmKRVX
 jIa3dnAik9J2AuCxYq+3YtQIfYU3HFwahVH+aeyt3NXkdBTIgl13a4+R/UONXupLUBjoDeyJfKu
 CEwDxa5Q7+b6yCs/7RYtdXGyTlGHQJDzpMkne24R346vHEwNDKEevto2CFd/ahArL8fB/Fwe2JJ
 Q1kwFXsM+ojK1EGaExbhkFoI7LXquYUVrX0xmGiHJds2Zcfhgu0KMUoZeOyiAHsVDFzdjg0LpAb
 Fgp85PWfiaOBAMcnbdLGFgWC4YmOzRJqBVboMkVQLqER4Tu2rYs1NO++i6dqdyICghV6NOR9B/P
 rajDgrlofmCAyg+Kgu6Z9KxlFdPwv/8J6SRTnTjKHna1yfuweUJigbL8kxHj90E3XRtUOXSqshU
 EM1XgzeDOaL0Omx34LC5J430MKVWjy79YXOjYN5U5pI2407Ssc+uG8XKjue4jj7M+I6f8MjqNIJ
 9xX8mKQ+z3IHtJBhRLvcUwm/Al/1Ui/8vY4o9zwXNmPcTOkmevKv7xuY15StAdWU7E3As5+PY+B
 KJMY8HA==
X-Received: by 2002:a53:ac81:0:b0:65e:4b06:f85d with SMTP id
 956f58d0204a3-65e4b06fab6mr13813951d50.33.1779258854393; Tue, 19 May 2026
 23:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260520-am62_firewall_exception_fix-v3-0-9ca3dc40aea4@ti.com>
 <20260520-am62_firewall_exception_fix-v3-2-9ca3dc40aea4@ti.com>
In-Reply-To: <20260520-am62_firewall_exception_fix-v3-2-9ca3dc40aea4@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 May 2026 09:33:37 +0300
X-Gm-Features: AVHnY4Ix-0Mp-5jcKB956fZIYNmbyPksPUqEqsapHs5BuehG-RT5Q71PhGOEZCw
Message-ID: <CAC_iWj+hPG7DM6RZn4BPveQEz=gLJAfvkJH-Uhg70c2Hx1MSdA@mail.gmail.com>
Subject: Re: [PATCH master v3 2/2] mach-k3: enable mmu after reserved memory
 is unmapped
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Moteen Shah <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Chintan Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>
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

On Wed, 20 May 2026 at 05:52, Anshul Dalal <anshuld@ti.com> wrote:
>
> Currently the sequence to enable caches for the A53/A72 core on K3
> devices looks as follows:
>
>  1. Map entire DDR banks
>  2. Setup page tables (done by mmu_setup)
>  3. Enable MMU
>  4. Unmap reserved-memory regions
>  5. Enable caches
>
> However there is a brief period of execution between #3 and #4 where the
> core can issue speculative accesses to the entire DDR space (including
> the reserved-memory regions) despite the caches being disabled.
>
> A firewall exception is triggered whenever such speculative access is
> made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
> by re-ordering the sequence as follows:
>
>  1. Map entire DDR banks
>  2. Setup page tables
>  3. Unmap reserved-memory regions
>  4. Enable MMU
>  5. Enable caches
>
> Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_banks")
> Reported-by: Suhaas Joshi <s-joshi@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/mach-k3/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 396018b7a7a..19a6e24f38b 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -279,7 +279,6 @@ void enable_caches(void)
>                        __func__, fdt_strerror(ret));
>
>         mmu_setup();
> -       mmu_enable();
>
>         if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
>                 ret = mmu_unmap_reserved_mem("tfa", true);
> @@ -295,6 +294,7 @@ void enable_caches(void)
>                                __func__, ret);
>         }
>
> +       mmu_enable();
>         icache_enable();
>         dcache_enable();
>  }
>
> --
> 2.53.0
>
