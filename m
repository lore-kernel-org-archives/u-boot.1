Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB80CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8CC83FB0;
	Wed, 13 May 2026 11:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="si6p20Nc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4694084099; Wed, 13 May 2026 11:46:36 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1858341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c477a3278so6555976d50.3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778665591; cv=none;
 d=google.com; s=arc-20240605;
 b=Gb+ibUbQ2D2xoi2ShjyGmf2PACQNpbKBZu9WM06V2WufUsfKH/zYRp1FB9Drm1LGFC
 yJyfYf1o4PnHxJDGBnV1WImnQhDSI81eGxj2BC5bKnKUDeLJh5BG7ZzXqwZMjvIio5sS
 b2uozi0Z3b6GvRoBl8GaeG/S2KPoS5w2CB9vGWR5w+uraxbmPHXRn2kpZ6VjfQUcfavp
 3Q+YxXL4GhROlaRjYDaUECkXki+WrZ7KRKFTJ2bZ5i1B4PYDE2qd7Z0CO3pbLXZB9Fbg
 M4zP7Qpsel1MejdcElheUeKvIqkrJU85KT+DPuDA6odKv0LlaqGUVw0K9iujcyI9lYTS
 slBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dkdO8PZC5jzxelQnoWXil1ZcUQNQMeBpw8/tEFyUdKw=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=TVAsHHreE08YmSOqO+XB3XSIhV5rQWC+odHcEigQv240hAXHG6hDhzW9eztKor4CkS
 dBdwknZVoshYy2ENcobP2JYpARwGkEpH6+63hSCy88iSXU9LO6tZtUAmNCXqPo267+O2
 YEoZPxqepRc1CvEJDWBTguo9y+u3D5M09yhm6K+KQCLaMByjvYAFb4JuFwG+skt2jzXW
 HRuOEnXeLfCa1JgHA+aVXyJImHKPOq3+nrJ6DSusZImjOu8DzpP7IKLXxZ/IbfvXnIY9
 Vz0fmqRJK+AspCsmsuQdkHM2UZsMZHMLR0iHsPq6qUjzeG4+xvGzh3cqVmx7ytp5Jrak
 EuQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778665591; x=1779270391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dkdO8PZC5jzxelQnoWXil1ZcUQNQMeBpw8/tEFyUdKw=;
 b=si6p20NcT5pEX9ZWZYS9ZWEC7d3x0NcXXlh4VEj3ef1JDK/g89igHa5r259kFm5lXr
 kN5XcRRfmfNMySQJXIV4ePtfGLAY5fyhTsdhVJrWZdy2vACDUdNb5ATiElylXeao5rYe
 6XXpeDCy1P8MMv7APoNCFaXBr2oVRGkievA2ALtqPTG7zkTEWKUoOC5/fhuqXVc6GUqz
 EhHcCMQ7TA/ZhfejrqB3eAW/R+Vt5q/ten6GlJsZTgOvj+BLbb3StBw7O6bkNvFXEmxP
 44efBJ/6Y2N3Dp92p3Pwi9yESsl+En22saSWPmwIeOUuVFFUUrkus7v3cpecQ1J+7kow
 EGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778665591; x=1779270391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkdO8PZC5jzxelQnoWXil1ZcUQNQMeBpw8/tEFyUdKw=;
 b=eJa/VSXlDHZQgXZXAJl0Ycf08bTShpfSnwNBHcgatLgObyosufvyPZXyv7OFyfkwAA
 Ekm9hIGW1AewnWjUvIRGnkN9kVfqAFMYBe6s01QEjlbRV6hcqfKkn19jHoe7TzitnXzO
 h0UIGc9Bu4LWWOlWeABAgOHDB/zL9mFz6zHFmevBp+Kl2g1H/6FllEiBg1snQyqo+Yf4
 9Cq6U6uDbay5tL686ZXM/ygYoLCM6Px1mi6mpdJqeYkjAXh+GSync9Ba7RTkhPVI8w4K
 rA/ndFri/Mq1IWek3UDVvejNQRUSmEu/gAj9esA21UYF53mWGDONEeJkJjO7OGl/cL47
 zM5g==
X-Gm-Message-State: AOJu0YxALUU0rPyqRSbIDBtxtqaVbMuAvFdzpk4rNdQtMR6+NpQkygII
 MZtuJ1ZP1uyUipDa1ZZqJx2pG9ue20h6Go+dxHZkn3BekvgeAWNQnDJ6xQII9nQk1zPG6xE3iMs
 Qc8add/qcBlO0V4Adn0Ect+LPLZkxPY/ZqCmW7VsNow==
X-Gm-Gg: Acq92OH6W0zPKEjqVET9mmU2SAMO9B80/F9HfqD77I92y0cSK1EC51EEqJBmPVpPGr6
 0EidCv7NM5r1Kgzz/wJ0fWn1lsxRwRugvFQrUus8/hPm+PiI37F+aHf2xgrHW6YLYtNy7yGxDet
 ypD0pf2R2qZi8JwY86iM3GYl4O4QH/SzkVIhpBqL1uEnkezf02fqN3dLccsXekUoc6VrD4SpaUz
 1zkfeM0oZcDo3jGqhPJPLwacrFWgr/OoeU86rFW2Px3RrpvOB80tEWnCUcF8K15s7Q6flgqjGSP
 7gy6qyX8dBSiwRGMXgtwhnoGtqfX++dlpDcVnfKm+Mu6VbFE2Ag+vHKVXSXt5ItBHW7xQSikeJj
 kOnAnJM3aW//u/dOjUEMRr09QKuRn63p+PfS0qjXP6XcvAQwHR4v+5y/ox0NSrQTIl9hSbikYTu
 3xtVyBw1Fv75p/dKVE2hNdk1JmNI1BdIFoUwLd6ZwCqDVhWVAPaKLKWl5/p9SvQRQNuGJnRdcdx
 HAPOnnr5yM0tdQGeFoOz7Y9Uvy1aUCqXzQ8ZMLckyWhZMpBJRu4dB/6vmEG/Y+gSXx2/hw8r6LN
 3OT+6JoTGg8b0CXQBoIJKCpu/0geUgPZ8jirvtOdSKPCMIi3mybmlN/hbmw4qNirn6Xa+HMLeVM
 /vnlhSg==
X-Received: by 2002:a53:d018:0:b0:651:be50:af09 with SMTP id
 956f58d0204a3-65df80ce266mr1727101d50.3.1778665591510; Wed, 13 May 2026
 02:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
 <20260512-b4-mmu-unmap-fixes-v4-2-fab802f647c9@linaro.org>
In-Reply-To: <20260512-b4-mmu-unmap-fixes-v4-2-fab802f647c9@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 12:45:54 +0300
X-Gm-Features: AVHnY4LQ_zlq28wp5o_Q3Ho08LKZB25zT6TwsKxfQ4R1p_s87fzd-ip10PlcOL0
Message-ID: <CAC_iWjJnJ4T1F4difHoR8k6DPj5BmHeqjCeTtJ+jqc0Yr6RhMQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] armv8: mmu: teach the pagetable dumper to show
 explicit FAULT maps
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
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

On Tue, 12 May 2026 at 14:13, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> When a region is explicitly unmapped (like with
> mmu_change_region_attr(.... PTE_TYPE_FAULT)) the address translation
> still remains but won't be used since the region is marked invalid.
> Print these regions when we dump the pagetable to help with debugging.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/cpu/armv8/cache_v8.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 368c622cd18e..36d337378fcd 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -533,9 +533,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
>
>                 if (exit)
>                         return;
>
> -               if (pte_type(&pte) == PTE_TYPE_FAULT)
> +               if (!pte)
>                         continue;
>
>                 attrs = pte & ALL_ATTRS;
>                 /* If we're currently inside a block or set of pages */
> @@ -572,9 +572,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
>
>                         /* Go down a level */
>                         __pagetable_walk(_addr, tcr, level + 1, cb, priv);
>                         state[level] = WALKER_STATE_START;
> -               } else if (pte_type(&pte) == PTE_TYPE_BLOCK || pte_type(&pte) == PTE_TYPE_PAGE) {
> +               } else {
>                         /* We foud a block or page, start walking */
>                         entry_start = pte;
>                         state[level] = WALKER_STATE_REGION;
>                 }
> @@ -707,8 +707,12 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
>  {
>         u64 _addr = start_attrs & GENMASK_ULL(va_bits, PAGE_SHIFT);
>         int indent = va_bits < 39 ? level - 1 : level;
>
> +       /* Ignore empty blocks */
> +       if (!start_attrs)
> +               return false;
> +
>         printf("%*s", indent * 2, "");
>         if (PTE_IS_TABLE(start_attrs, level))
>                 printf("[%#016llx]%19s", _addr, "");
>         else
>
> --
> 2.53.0
>
