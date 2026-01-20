Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C54D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 11:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4984F83A91;
	Tue, 20 Jan 2026 12:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HT2PqzsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E7CE83A9A; Tue, 20 Jan 2026 12:02:09 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DEB83A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 12:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64455a2a096so4261230d50.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 03:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768906924; cv=none;
 d=google.com; s=arc-20240605;
 b=HE+fNMarsd3UAryDrJn4eRTyLaj8tokjgqpSd7iapTjT3ucPxvprB4/wbGG6t7158m
 5kFEcabK0KvazLzy8R+cVZNC3P45kBgNajYj9os3fEysSL7xhTR1U1VGbgpQ8alArHWs
 Yw23cz8cL5NmnZumWgMvS6LQY15Htt8MHvzUSrimU6hL1Ftkd0QV0wYfBZPg6VuuJ682
 OSiexXcoJXYgZQt7digXnllqjJjb6jC06P+q8yz9C/xKv74zUmOwHRxWdizHIXwMdmOJ
 oNQDRBScKJbYxqzn5v8WpIAhw95hMLQ1Oog12ZJS8I5asuoCUhdYGJXzZIgO5ZARS7lz
 dVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mlfP/IjXORD1ap0ymDtS6rD85RjIUXm26qBb7eEoh3o=;
 fh=ciuDMCuEbQdYKFl5+yNxfmXq2QJNFeaP7Jf7r7/h/m4=;
 b=gEmEOtmDXiL9CSUV/U2ri4AswdAB5yLSsDlRYK01uy+Fd2vAOw5SdcU/HxkkEtlc/E
 gkpH01wJZAnwx/8omjiDPybu7PqLvhrw//4qCX4M10UswY3l0uBHhOb+ueWX7xjA/DwE
 3Fyox65HnKCR6t2QAkp+ma30X7JDj/JdYyRXJYC5nCP4FkCcqi7PavIt0TYU4sURGAk+
 lcJH9hhO2dcxQtDzwcrLhY7jof3ziOfwjfr8PcsGwYeU31P0mKuqDdroqnso+aMIlUCJ
 gBePAO02HXAJPqP6GUhWZdj+JSvOwX31R1Xfz4yrincwMT0yEBfVmR31FwkfltM5n05y
 SUOQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768906924; x=1769511724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mlfP/IjXORD1ap0ymDtS6rD85RjIUXm26qBb7eEoh3o=;
 b=HT2PqzsOSqOwLzZpJ6zQt1FJ6C+6i6JzpxZY7YlGFxbmtxyI7OOZ4IcDV1hfwWC2ur
 wnHhfrA9R+q38TJPjh12fiU6vUUZju0dkixTx0qydkm/k3gTGDditp4w9YhDAoG2l1vc
 0jaIr/qZUNJ9gql+lg7F27GM6U8qACFC1xYOtDnojnTkC84Vd5v6JDllVWTo7YQupnxj
 FgP9e569IJlaKh+BFkouAP9wDfGcpFejONN5iERAPBBUgkPQPOEIr6qvReDUU4mx3YyD
 xTvmCmTm4d1w4M+nnfwwrpnI5USAP+cNpgsfYpABX/Y6iYR3p9MMaGTBGCM2O2yEZWF0
 YSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768906924; x=1769511724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlfP/IjXORD1ap0ymDtS6rD85RjIUXm26qBb7eEoh3o=;
 b=VUYbYxfnoMM9Ezm3d6an9mTRe2HjC1bFiTLy8xEByvaerl9C0GTnfNOBhLXL/XkIN3
 XnIeclI2nSdY0HPGd+mD/IWRx8uYgLAXELBXVw27aWMaa3kkrYUzmc6pXjgQdRStqvm/
 9XtwFa1NbIIrBoQeIuXdCFRAdzRH1DRaMmEDzITF8Nz1BuDYh+O6Q8+yGfLbSxUGt9GJ
 nefPsDhTR964HPYfOGApcKF0hw2yKbLdQ8VdmWPCZap6g0qHSHKz/XSKuTLfk6D2Gn4w
 udaBCI+zLae4fd+MaVQg3nQsXZVkUMuQau+cOSIB4DAs5ODkGm4YCgS9+bRlIMu3fhJ3
 lXYg==
X-Gm-Message-State: AOJu0YwOKfusRlHXAcizrV8ZztBQXcaSV1RovTXkkCulcAeeJUcIA+sW
 XWHU/sG0dsMA5Ux741u4Yclp096o6YNj2KSbgTr8MX4IOCKfBJnxCp/xmhD+tOYULtNY9pHYOg1
 7Jnbp24c6VTyZnxmzKJA+aT4TaRFah85Oa0ILb/PEmA==
X-Gm-Gg: AZuq6aKI6IA0TN6JnaejY7NBr88Jy+uW2+lXDFZ8AlzqoV3WbAK6gTOe0Ecu0BtsJIR
 c7aMMfWmgonNm2aRk4d2GEb5z+/Fc3GRBiBzZvd8m0mM55SdAqKNwjWJiVrl8forg4bshCEUV4i
 HEbYa08CgXTlTYa3GZkmDVFE3bvJ7iyrnPkl3HVCam/rbxZ425qah+KOe77BpMvdTPTRuG8RiS2
 J9ozMHOW63F1KIR+snizA4ftou2Jj4fIZyjdc2HTSZVotNW1/z0a4ICAalRZO77DiNqxMwOKvjA
 8xBsuSJkHimqobl96xpEeC8jlIpN6/1wdLHM6d4//vhoP3v5q4ysq6FrehtPYCnUDqzbp4oO3P+
 npAy9OlBFFiGG1ScNzwukqSPh8EbvyA83U9daKlPN1lPx1a/I6NaGS0fGO9oN0O439Ra6RDH+NX
 5qzx4XD+MCvT1sk2URukC99xv86kQs3Olonh3uiktZnTlbr/uGe0pNNUtrFd7bTsOV7H4HoYTJZ
 Ecb0KY/isDwgMkBPU+KKSGZYJsGeC8y2Ta494wpy3rh/qSDFlDqDDPKg21Rm98lYrjRrq5SGomi
 IRtM5XE3MVPMufYeygaAVsnzzC5ytSTBOFlL97BAJMw=
X-Received: by 2002:a05:690c:dc9:b0:793:d0b2:ff08 with SMTP id
 00721157ae682-7940a0e6759mr24301447b3.8.1768906924166; Tue, 20 Jan 2026
 03:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20260110195610.42068-1-kettenis@openbsd.org>
In-Reply-To: <20260110195610.42068-1-kettenis@openbsd.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 20 Jan 2026 13:01:27 +0200
X-Gm-Features: AZwV_QiuJVVKrLxAu1GlZWR-8NFaa6Fbwta-hcEyNdYJrUi-1tcXaOqaYFZ5l5M
Message-ID: <CAC_iWjKj5b5tF3U3uByuA_6wbQh0oENE0JoQbRuqt88sL9odjQ@mail.gmail.com>
Subject: Re: [PATCH] arm: armv8: Flush TLB before enabling MMU
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, anshuld@ti.com, d-gole@ti.com, 
 casey.connolly@linaro.org
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

Hi Mark,

On Sat, 10 Jan 2026 at 21:56, Mark Kettenis <kettenis@openbsd.org> wrote:
>
> Commit 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on
> dcache_enable") broke Apple Silicon machines in certain scenarios.
> If the MMU is currently not enabled we need to flush the TLB
> before we enable it to prevent stale TLB entries from becoming
> active again.  So move the __asm_invalidate_tlb_all() back
> immediately before the mmu_setup() call.
>
> Fixes: 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on dcache_enable")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---

Should we keep the check here or mayber move it in mmu_setup()?

Thanks
/Ilias

>  arch/arm/cpu/armv8/cache_v8.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 0309da6d397..39479df7b21 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -878,15 +878,16 @@ void flush_dcache_range(unsigned long start, unsigned long stop)
>  void dcache_enable(void)
>  {
>         /* The data cache is not active unless the mmu is enabled */
> -       if (!mmu_status())
> +       if (!mmu_status()) {
> +               __asm_invalidate_tlb_all();
>                 mmu_setup();
> +       }
>
>         /* Set up page tables only once (it is done also by mmu_setup()) */
>         if (!gd->arch.tlb_fillptr)
>                 setup_all_pgtables();
>
>         invalidate_dcache_all();
> -       __asm_invalidate_tlb_all();
>         set_sctlr(get_sctlr() | CR_C);
>  }
>
> --
> 2.52.0
>
