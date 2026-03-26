Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37BD106F313
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BCBF83FE1;
	Thu, 26 Mar 2026 10:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pxeb43/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B33283FED; Thu, 26 Mar 2026 10:36:40 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 106FA83FA7
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64937edbc9eso732172d50.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 02:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774517797; cv=none;
 d=google.com; s=arc-20240605;
 b=FUp+lZZTn0Yl0JdHAGdUnSde6+W9wdA26LG6HCjsBzhgRGBHVhKckPgMcAgwY99Ihm
 KO01LjdbsUdRX1V7M01Lrbvd5llAlqhZYzk03dkykciotnhPoCUVQhJN7PIpG9dsoEkD
 tOY8l3HnQG8Gj3V6zQBXFCZ4nu/L2yJrWGuaf26wLMKnwGEIZzl/o+nTjfpT5TMLUDpt
 Iqrb7+cBs3BT1bvs/cDq6TS7IUjs38aHyjtvi0vJcVRsMTQqgaShkU40/hHheQh2wcm7
 12nNFZyu5HWl3zgCVqh0ZrmWcRSwkjVkFMAjypVIIUlejB2oAELWhSD+Vlr+SQXgAm5S
 74Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xsdcjAwBdwguZMJfN2XY0eQB1VgoNMIcHUXxsmgEzv4=;
 fh=nEkXRhqCjx3ONPRTdOk67xC+ThsQtT0sulRkQM3zgmo=;
 b=gJiSmSLgmenwWqXFXMQ5w1FO6OnhDOnFfUTDddMyCf5KlaM4hj80X+AORvE2xcaSf2
 hqd+7oJRFCieWlxLnLsdwomLjuCHxccd2CFdZjzitCwvBs834u5QrfFDStEjG6TBE98V
 avIds4sFDSQSzkZdFqtqLvs0y2/rUGVa5wzCggJ3VBRj9nkNE6OdeCnz16ERRqeomiwS
 guuCdnBDvn8EJ8MZdMbs75QD9G68LxotPczkcGml0BlerKBr3cPntnpwq/z2aqtnFA9y
 tJ7lifMp0hU/V+/y3V43diaj575OfZPGo3hEGLknUQ9vFRXI4+e69oqgwpgdK/2AvCDD
 4ZRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774517797; x=1775122597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xsdcjAwBdwguZMJfN2XY0eQB1VgoNMIcHUXxsmgEzv4=;
 b=Pxeb43/RdgKm0T/hE6w7i+Skoux0wgzZy4CbTfQ0+1mRegrGEOxTp9ILeTMOPNAYoR
 +hrsoswNS9RIkfUkLnsu1WrKKEXKALhGApdemtF4MB2NOAnDPhIgife99IAiikvCqAAq
 xnsJSgCiL8e/20Hp9Y9ZLE69xmdS4LhnX8p1Ms571wLxqEU3USz3a66J3d/I+9P54j1X
 WF7tAH5lqwZHANuBsw30Tfk0zyWluaF/U+t4tMgQHEDJSP733lTveujbWuFg19Y0nGun
 p/Jlk8yztpypmzBxMqKfx1nWiv3fCsVUk8TaLT77BdEYiRilmRNPOFixYZTSZZS567uI
 KxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774517797; x=1775122597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsdcjAwBdwguZMJfN2XY0eQB1VgoNMIcHUXxsmgEzv4=;
 b=mAsHIqLeHph78SB23Z2mtshYKY9ilu6AjBtvzxI5mXR8ONSfLcxxzk6RjR5UV6COpA
 uHSqC1+kway805VPbWyHMEXewgcGTbw9eHYI0QnGD9Pdr+nKepmW0sZom8K+6wI7Xrbl
 DBuJ5v9C36TyF1msUisArnMoQSj3cPvMJizE+DmHv5XegvfJQKg7jOUCtNSodJyhDygn
 0bEgBARZfNxFbsjw294KZpzo8dYR658UzJcNJIM1msThO1CP6CmNR8gR5esuEKobVpJG
 fGC2HSYAct9veAyxkgwvUiJJcO4Ag4I3darKCv78jihvn6UHpNRe+TJOXjaFDAbgae2Q
 FeVw==
X-Gm-Message-State: AOJu0YzHHf55DNOVcVCLZhfSM7v2EFgP3MM5GaP615qu3th4mkwxciUi
 xbPtzdpOBzk6O4ZvXo/R7Ca5MmXJtjP3bYhXChgFOlumcMmioiC8EU3uUUjam0zGpjwVOP866TM
 RQ7ZwjtkdzD34fmIZlEZDz9BR8Eoj5DKHKZL/wFEHpg==
X-Gm-Gg: ATEYQzzkkk6KpTZmw5BdQiumuMk7x4CaDdRCUQf3zn+t3v1W6xZy44msm8DLV5EMY1S
 kFyAYobhe/A/W/AyRriUZ9A0IKixGoN+MZ3qdiX7e4avirU+W/vb4eP23BG0EAEQHIlLxJR5pUO
 H276AH979GzbHJ81pdc/28ZpTN0jkJFWZ9ORnuL0DuJRLRk1XLMrhRhCqMDnHQDjYEYo3mJ2htw
 jgowq3yNOAh+etviRcJGLtOfEtPdcBxWcfaF5ui4yvv0N1Hzh6PpAEJnnUk97+x98wq7/Tmj1a4
 /yHtjYcp0SLjEB7X54yVFwTSWxjjx0zWuKcIIR9jQx8rI4/DdfbiuXZc+lKqDb3Oa1SNrS8DZ1c
 nVRnG/RWosGnNnQJUZCOEo/JFzWqkwvQz6Yt3b+7DOIRto4Oe7rj3Koco90wwQoDZe5B5sc0ls7
 Gexpp7+qc1ypuFJ2U1J/vE6JCjDL7lNnnLNSO6M3Y8j/hDayWC8MT7bogXPywo1DUJ0nr0gOWZL
 G2c8wd7eXSHE83UkoO1Z/p2G/TXCRySozFxrGjfKJmGSOxGLl1T9NSLqg/jS9bjA/Ki1co1+xQl
 +1Cl3LK27hpcW+FiLP1YlT3L39QixwCIGc1X0LNtpLNp
X-Received: by 2002:a53:ac99:0:b0:64e:f106:60e4 with SMTP id
 956f58d0204a3-64ef1066a8emr4192138d50.53.1774517796740; Thu, 26 Mar 2026
 02:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Mar 2026 11:35:59 +0200
X-Gm-Features: AaiRm50JWAvwaE7c9lTac9EsncRQHPCxTIJPkl2vaJrKg7G_1FdgGP4vohIEb7M
Message-ID: <CAC_iWj+BtaUn-8zo6jARgOcM57i+octphEg8ADDM8bBGTQq7KA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] fdtdec: Deduplicate iterator function
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Raymond Mao <raymondmaoca@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 25 Mar 2026 at 05:17, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Both fdtdec_setup_memory_banksize() and fdtdec_setup_mem_size_base_lowest()
> implement the exact same iterator over all memory banks, the only difference
> is the body that is executed for each bank. Deduplicate the functionality
> into iterator function fdtdec_setup_mem_for_each_bank(), which takes a
> function pointer to a function which implements the body as a parameter.
> No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  lib/fdtdec.c | 77 ++++++++++++++++++++--------------------------------
>  1 file changed, 30 insertions(+), 47 deletions(-)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index c38738b48c7..d820f75b031 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1092,7 +1092,7 @@ ofnode get_next_memory_node(ofnode mem)
>         return mem;
>  }
>
> -int fdtdec_setup_memory_banksize(void)
> +static int fdtdec_setup_mem_for_each_bank(void (*bankfn)(struct resource *res, int bank))
>  {
>         int bank, ret, reg = 0;
>         struct resource res;
> @@ -1120,63 +1120,46 @@ int fdtdec_setup_memory_banksize(void)
>                 if (ret != 0)
>                         return -EINVAL;
>
> -               gd->bd->bi_dram[bank].start = (phys_addr_t)res.start;
> -               gd->bd->bi_dram[bank].size =
> -                       (phys_size_t)(res.end - res.start + 1);
> -
> -               debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
> -                     __func__, bank,
> -                     (unsigned long long)gd->bd->bi_dram[bank].start,
> -                     (unsigned long long)gd->bd->bi_dram[bank].size);
> +               bankfn(&res, bank);
>         }
>
>         return 0;
>  }
>
> -int fdtdec_setup_mem_size_base_lowest(void)
> +static void fdtdec_setup_memory_banksize_bankfn(struct resource *res, int bank)
>  {
> -       int bank, ret, reg = 0;
> -       struct resource res;
> -       unsigned long base;
> -       phys_size_t size;
> -       ofnode mem = ofnode_null();
> +       gd->bd->bi_dram[bank].start = (phys_addr_t)res->start;
> +       gd->bd->bi_dram[bank].size = (phys_size_t)(res->end - res->start + 1);
>
> -       gd->ram_base = (unsigned long)~0;
> -
> -       mem = get_next_memory_node(mem);
> -       if (!ofnode_valid(mem)) {
> -               debug("%s: Missing /memory node\n", __func__);
> -               return -EINVAL;
> -       }
> -
> -       for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -               ret = ofnode_read_resource(mem, reg++, &res);
> -               if (ret < 0) {
> -                       reg = 0;
> -                       mem = get_next_memory_node(mem);
> -                       if (!ofnode_valid(mem))
> -                               break;
> -
> -                       ret = ofnode_read_resource(mem, reg++, &res);
> -                       if (ret < 0)
> -                               break;
> -               }
> -
> -               if (ret != 0)
> -                       return -EINVAL;
> +       debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
> +             __func__, bank,
> +             (unsigned long long)gd->bd->bi_dram[bank].start,
> +             (unsigned long long)gd->bd->bi_dram[bank].size);
> +}
>
> -               base = (unsigned long)res.start;
> -               size = (phys_size_t)(res.end - res.start + 1);
> +int fdtdec_setup_memory_banksize(void)
> +{
> +       return fdtdec_setup_mem_for_each_bank(fdtdec_setup_memory_banksize_bankfn);
> +}
>
> -               if (gd->ram_base > base && size) {
> -                       gd->ram_base = base;
> -                       gd->ram_size = size;
> -                       debug("%s: Initial DRAM base %lx size %lx\n",
> -                             __func__, base, (unsigned long)size);
> -               }
> +static void fdtdec_setup_mem_size_base_lowest_bankfn(struct resource *res, int bank)
> +{
> +       unsigned long base = (unsigned long)res->start;
> +       phys_size_t size = (phys_size_t)(res->end - res->start + 1);
> +
> +       if (gd->ram_base > base && size) {
> +               gd->ram_base = base;
> +               gd->ram_size = size;
> +               debug("%s: Initial DRAM base %lx size %lx\n",
> +                     __func__, base, (unsigned long)size);
>         }
> +}
>
> -       return 0;
> +int fdtdec_setup_mem_size_base_lowest(void)
> +{
> +       gd->ram_base = (unsigned long)~0;
> +
> +       return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
>  }
>
>  static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
> --
> 2.53.0
>
