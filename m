Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81466CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD5B84688;
	Mon, 18 May 2026 11:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HyxtGPIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29AFF84693; Mon, 18 May 2026 11:49:15 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC2C78469F
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65c21049dafso1804456d50.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 02:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779097748; cv=none;
 d=google.com; s=arc-20240605;
 b=kCYAvOJZgK1eSl9FE2ZzIj+OM7dRRxklEoageVXN/cMHp+95PyIN6G5uRhZ71u3yGp
 IkYMXxnGxg9gTdkYfsAWIcDFKa36K+Xkneq8N6DouyHk46gR6AlbGopZhX75r8RSzcyH
 U7yM/gEEqUsigsMM+PnhzimdX1pnS6zFtm7EMdLcZOBgDa6HiKm5YbEKos8VDj9wvGvZ
 WNw0ce4wo7kDV+ydl6f+vOjAVjcEAgrqBmRm8n1zTBkrD1AJR7cwqj8r5EYiCJc1rIs8
 zG7L9EpD74XWH88NB9aP0Pnow9/+dqzifnc9cW8TWvB3AzEUcf1XUijzkADIIQ3I2zX2
 3BNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kca9rs1+YRfvvfUylCk+goH4z4SkVlxP66iIz5IGj+U=;
 fh=ovq/5t1o7AdIEUD75iX2y2XHOz36vZstehvnqiiYK8I=;
 b=i5HIt1wy2n2MwGOvijZZ42WNJOAI3eOaXz4R/eEGg0Lem54nRDaFarOPHf674rgie1
 xRX5XySgZsTA2V73M/L8g/LDM3hwFhtM+YSFavwGfOfp1znubJFAdPxs8cK8gF7H0XoE
 Ke+ZIuy7dvJVHhpdn1r/tOKeJHuEcmwaaao73o8LN+3BLAp5+bXFCniLLSxeQz6cTnaF
 ASWS7lADAUWViMaCnEOrQ2dSbN1WqF2UwUoveh5g/ylqpZZnXRI2LGePt7F3M6oUD1VR
 a4wJeQerY2VwO5N0vVPJmeTyWQfYivZe7bsn/X47KpGrMSkRHDdNU4MwoDkWRQtvKf+b
 ZfIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779097748; x=1779702548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kca9rs1+YRfvvfUylCk+goH4z4SkVlxP66iIz5IGj+U=;
 b=HyxtGPIHMSWsZNLC02LukblekBU61LqGbVK/30gxo9ZqxPnUBzzuQi3NWUkKb0eBHI
 P4S+CK11RZ1NPJLH58F+5cNP2h+82x/HQoVr68OUCBvpjmZHxAsWDqyXY73CIATx6vs3
 okpiOqKyGry78xMW+Cc7YKUXvdTic59KhY5K55occnc24ZyLvSn/qbc3Z86cwh1zKnC7
 ZNU4sprhRHpHw4qJgT2QnSk4FyjEZ6Mipk2y9FFDYZG+bgamL1WsjK8RB70/n6jCj21M
 PSuXTb7LuLxVz/t1z1dbRsHr8dEzxZZu+tD0K823JofqP17ar7UBcyVpWrJJzuXapzMX
 6+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779097748; x=1779702548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kca9rs1+YRfvvfUylCk+goH4z4SkVlxP66iIz5IGj+U=;
 b=EFGLJjciKCHgQN8SpwIuG+ZH9/7GLOlvvT0ZhujZGixbD4J7IVy50RN2WXf9hPxiYz
 z32THyV9LSFqYuhrrXmNT3xnQCZT5pccZOzSpa5M9+Q/w8TDHZFJLAL5j37Zgvm6z3BB
 ChyKqPfxIpoU0LQtUST51H+l77HvilbvRIMsZEx1Q1YeUJB25Qm1k3TcRD7fimSlAGa4
 xbKuCi3HdNxJ0urHrXPlW77q3gBG4S8wR+UXEPoK0fhES0kBGDnLKRuluTcuMStiUCP+
 j3pywIntBCLdv8poYNZYYBO1V3Q6HuxKNHe9PFo+MPBcPTZvd1LScbI5iOYXe7+NDOWm
 z0GA==
X-Gm-Message-State: AOJu0Yw05jaBf048N7lRygXn4rvrhNBGSAOR1WELPUgUOmLke9a7ijkW
 xnIbPtwjusCZv96HT/uQRZitrekpi89mHdoqU6Wklgvaam4oY3X0FwUVPFakl4/9RudxKfXwjNe
 j3TBIWNWXjnOnJZKYOAQcewiprqWEMH5AbMSGcVMzf6Chz3jH7wXy8dQ=
X-Gm-Gg: Acq92OHFJanCiGWb6/mBWRMNCqMr9aAFUjcTB2Gpc2k0lH0AG2+Kyt8jRTNR1QkE1rr
 Nbc/ZQND4l923JNvFWWpEmw5l9wBnRQINTDBn2CfHg03FuFdIsnwIN/wviyvXk47Fb/qZxVS/Fb
 1VO1GQyfWuP9XRq74+KRgifaXi+yOVk1Ui+UNl8drVuZc/Zmbpy4yt4N0+EvAllGTxgQLD7/BLP
 RXQnppSaf5BhWDudCABqstGd4xIiBNpI2oKcUPMeawPbURPZIv93DTCXgquK6ehpTrneUEUSHfJ
 B4UYrGtcGmwQ2IMUzFaxXTD9kh5cEf3+JUEjBkQCr7eNjLVxjSEkLvX/mDWq/GsRJkha6o3zuoa
 mqCRze1Tv2PUD6NWhHXI+CrZ16GBY2VnjHZg+TdyWRDdbowUduy3NP7qDU/tvlUYgFfgasEDS/b
 g0Xk4AK1ypKHEGCr527GDWhTttd97GxhRXjzSYfDI/O4Ql3pw5NKhAwzUmUZn28ENDl3ieDK8cn
 VQkHX1mjkRhSIyJhjzIXA4yzdRff2OhupwZP9UN2Lqzl15X8D6+kWqSAkxzGXAwaxWfgVjsjDtw
 8oQQv8KzMZ0KwSMH0j99LUmkpX3FGWVlgxiMA6RV4TomrLav81yQJqIRJjYnvtTQnPRVsFrOoMa
 gq4KglQ==
X-Received: by 2002:a05:690e:2512:10b0:65e:1d95:29d0 with SMTP id
 956f58d0204a3-65e227d3a4amr11405835d50.34.1779097748373; Mon, 18 May 2026
 02:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com>
 <CAC_iWjJHnzfgMThnUnzd=s_21wndWX57pinNMoq9As+e_TSOOQ@mail.gmail.com>
 <DILOQEO4WE9D.AVK6J4D35NY4@ti.com>
In-Reply-To: <DILOQEO4WE9D.AVK6J4D35NY4@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 May 2026 12:48:31 +0300
X-Gm-Features: AVHnY4LZ5atiPaY8AOKw25eOmJ3uqjH2mHgm6jte1eXcFEGRy9B0b3vmESLdJGo
Message-ID: <CAC_iWjJ9qhN8an2Z=J6+7-N+wPQ31gPAimBSEdHGLkiU5BR_NQ@mail.gmail.com>
Subject: Re: [PATCH master] mach-k3: enable mmu after reserved memory is
 unmapped
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Moteen Shah <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>
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

On Mon, 18 May 2026 at 12:12, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Mon May 18, 2026 at 1:34 PM IST, Ilias Apalodimas wrote:
> > Hi Anshul
> >
> > On Tue, 12 May 2026 at 14:03, Anshul Dalal <anshuld@ti.com> wrote:
> >>
> >> Currently the sequence to enable caches for the A53/A72 core on K3
> >> devices looks as follows:
> >>
> >>  1. Map entire DDR banks
> >>  2. Setup page tables and enable MMU (done by mmu_setup)
> >>  3. Unmap reserved-memory regions
> >>  4. Enable caches
> >>
> >> However there is a brief period of execution between #2 and #3 where the
> >> core can issue speculative accesses to the entire DDR space (including
> >> the reserved-memory regions) despite the caches being disabled.
> >
> > This is indeed a problem and the fix looks correct.
> > What worries me though is that the mmu is common across v8 boards. Is
> > there a way to generalize this instead of adding per board variants?
> >
>
> I think the issue here is that mmu_setup does two things, first it sets
> up the page tables and then it enables the MMU right after that.
>
> We could modify mmu_setup so that it only does the former as follows:
>
>         --- a/arch/arm/cpu/armv8/cache_v8.c
>         +++ b/arch/arm/cpu/armv8/cache_v8.c
>         @@ -801,20 +801,20 @@ static void setup_all_pgtables(void)
>          /* to activate the MMU we need to set up virtual memory */
>          __weak void mmu_setup(void)
>          {
>                 int el;
>
>         +       /* disable the mmu */
>         +       set_sctlr(get_sctlr() & ~CR_M);
>         +
>                 /* Set up page tables only once */
>                 if (!gd->arch.tlb_fillptr)
>                         setup_all_pgtables();
>
>                 el = current_el();
>                 set_ttbr_tcr_mair(el, gd->arch.tlb_addr, get_tcr(NULL, NULL),
>                                   MEMORY_ATTRIBUTES);
>         -
>         -       /* enable the mmu */
>         -       set_sctlr(get_sctlr() | CR_M);
>          }
>
> Then we can have an `mmu_enable` to explicitly enable the MMU:
>
>         void mmu_enable(void) {
>                 /* enable the mmu */
>                 set_sctlr(get_sctlr() | CR_M);
>         }

Ok that sounds reasonable. I greped for mmu_setup() and
dcache_enable(), but I can't estimate how intrusive this is going to
be to include all v8 boards.

Thanks
/Ilias
>
> Regards,
> Anshul
>
> >
> >>
> >> A firewall exception is triggered whenever such speculative access is
> >> made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
> >> by re-ordering the sequence as follows:
> >>
> >>  1. Map entire DDR banks
> >>  2. Setup page tables
> >>  3. Unmap reserved-memory regions
> >>  4. Enable MMU
> >>  5. Enable caches
> >>
> >> Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_banks")
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
>
> [snip]
