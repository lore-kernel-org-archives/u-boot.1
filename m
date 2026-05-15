Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E01CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AF783EF9;
	Fri, 15 May 2026 14:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IwcXePXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FD158407D; Fri, 15 May 2026 14:43:17 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516A383AA9
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so158486766b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778848995; cv=none;
 d=google.com; s=arc-20240605;
 b=OCtGZoIUTjfKrNip20bhzFjmO6aRMMa20i1vQhXh73JdLCbr1dEWwCv9aVWMIywDlY
 FxuwzzvGS5EhI98x/jk+X5DNrM8yuZoLyH1MeLGO1gu3MSSF/NG1WvkpN0DrMYau+/8k
 3Bh0sjcv621Gnwy+s15WMNSuN8fDRRyKsMk+NR1t81nn+M6f1dPOAuFxRCc1wO/U3IWV
 YPDDIbBXLn+lZK38+1SYLPlBIk50KT1niNuNv1hknf/12WBL/zxVm7Y9kjcCwpKil0yF
 vrszdolodw7p42khb2DOORhiHwRQz3TliKVSmrceRwsbhb80JD82c8jgiZT6GnlaDxIq
 /HKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eZWw2VwcHAvnvQKuz0LDa2sgPN4tqvO0OLYxeAIJ3dw=;
 fh=RVWJkSBxkJjMmPleOygzayZFX+3lGmvZPcmiHlTAy9A=;
 b=Vt1wfIMKqCW6Ck0sLZ8mIDNy+2l4av6BPZ46UeejWHC0a+D9lN5R07FUoFmJk6SOOQ
 q0XeXsB9kT/HQraPW85Mqe1jBCUW3Iq2IT67lzvg2A/22fPdt2YZN3qgSQn/13VPuk0c
 4dOohH03uiWV7uj6QliBR/R4yBOJaRFEParoHecJphlA8EdkKV+VXvu1CNdN3zLIGXbU
 SMmB7JM/0ZNam4bgTs35SBUCLcpwGgVUbdam1wPEH9skVIR71YCgO2cCVjazagkAOeCy
 kQ01vTltPKZv3zvHCJY1NMZowqIRADyO8wCLI6XAtVBz+ZXh1pHocNYJH6We6Ov1uwmu
 wEtw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778848995; x=1779453795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eZWw2VwcHAvnvQKuz0LDa2sgPN4tqvO0OLYxeAIJ3dw=;
 b=IwcXePXZzSnb7Is8GaiCDHnJyQ+MD0W5iIqcMl0ladfCjvkWe5R6iShmbSaYZuSZc1
 hr77h61dk2UwR+t6rksrUdbA4iE0BL6SPliMbgKeYEZfBof19FLYA6MTVFHDrSS0gaJ5
 kyz3kKjzXBsPu0hj21p7EtcPQUy8gyPRy/2Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848995; x=1779453795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZWw2VwcHAvnvQKuz0LDa2sgPN4tqvO0OLYxeAIJ3dw=;
 b=JL0PQLCisxlT/IPQKIPXrzBKb9mXcZIYKBog0l63lhoPikO40uyffFwKk9lPB0e6lI
 GzidxjRsfkHAFywzlr7lHZJIIVgOadnopJXg3cNkxYNSOf42zwtw1vDHptYBgn1WhQie
 mKmNv7BV8ATli16oY7aVnq5jX86Uz47/1H1sqKQSRl/E3cm+MzrF+aXXMo5AeA0lnnTD
 HjR3H5W07Um+UXO5R5uErb0d4aH3YugjCpJmDbWJnzoT2HSSfY9m/VKVvDOXgl45vwe1
 TowhYyIkrRlFoqk+8dBr2Qm5P9UFZGG3V1vQJahzBYY5LJtds0H908vkEoKczD5j9Fjk
 VE6A==
X-Gm-Message-State: AOJu0YwBEj100AOwdE7xbK/J4Y2ScP/CRAO83hpyA9c6lp3rgG6YkEBh
 SaJGhHo1jBlD3Nldcnnl3Z20QNiOX0251ij02CrV7imCi1PbAR591KCgb1Jv942SRfmvdMJStNz
 gA3MUTBSxExDz3p17TFmGvphCelH/IMCXWZnyFYCS
X-Gm-Gg: Acq92OGxnUiwIQFSz3LDgilBzr4Z5T25yi+ULBrgbbZIgz/COU1Lmq9KAcDl1gBenrJ
 PIpgoUhXWSUQ52SXFRzeFt6Vz20buUXyqdfI+Cphwn5ItyYhjgn5EADNUctlpNDl6vvSU289nN5
 IEiD0r1c86dS/P+QMlgLfiglz7gvRTqV/4bPtKpO7tVzj5ncn89y8lqWQ0aCD8bWHpk3bjhVWoT
 NAtjLFA0xb0ArlAyHWJaGnAyaWyFK8RgdcsX3SK9TGctifmR0NS+3rXXkyP8QDOU+H3LBH4G+ZU
 mpuG7w==
X-Received: by 2002:a17:907:ca26:b0:bcc:14d9:f721 with SMTP id
 a640c23a62f3a-bd515390708mr138834666b.10.1778848994805; Fri, 15 May 2026
 05:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260511115340.675883-1-vjardin@free.fr>
In-Reply-To: <20260511115340.675883-1-vjardin@free.fr>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 06:43:01 -0600
X-Gm-Features: AVHnY4LDteIfpdyn_9WmpdICCzI5ClD72TKc3Y4tkkUTrRp-nV31lZPTvHpLHL0
Message-ID: <CAFLszTj40xCsVeVMxCCCHAx=N16-LL48OJ4_M_tja1ka48vCrA@mail.gmail.com>
Subject: Re: [PATCH v1] fs: dispatch null_dev_desc_ok filesystems before block
 lookup
To: vjardin@free.fr
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
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

Hi Vincent,

On 2026-05-11T11:53:35, Vincent Jardin <vjardin@free.fr> wrote:
> fs: dispatch null_dev_desc_ok filesystems before block lookup
>
> Filesystems that are null_dev_desc_ok (semihosting, ubifs) have
> no UCLASS_BLK device under their ifname, so on real hardware
> fs_set_blk_dev() always fails at the partition lookup.
> The workaround was to add a per-filesystem
> command (example cmd/ubifs.c), which duplicates thue plumbing of
> fstype_info.
>
> Honour the opt-in directly: probe such entries with block_desc=NULL up
> front, so "load semihosting <addr> <file>" works without a new
> command.
>
> Sandbox boards that exercise the existing fallback through "host
> bind" stay unchanged.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>
> fs/fs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -464,6 +464,24 @@ int fs_set_blk_dev(const char *ifname, const char *dev_part_str, int fstype)
>       struct fstype_info *info;
>       int part, i;
>
> +     for (i = 0, info = fstypes; i < ARRAY_SIZE(fstypes); i++, info++) {
> +             if (fstype != FS_TYPE_ANY && info->fstype != FS_TYPE_ANY &&
> +                 fstype != info->fstype)
> +                     continue;
> +             if (!info->null_dev_desc_ok || !info->name)
> +                     continue;
> +             if (strcmp(info->name, ifname) != 0)
> +                     continue;

if (strcmp(...))

For the commit message:

1. Typo: 'thue' should be 'the'
2. If cmd/ubifs.c is the duplication this patch obsoletes, please
either remove it in the same series or reword the motivation - as it
stands the duplication is still in-tree after the patch, so the reader
is left wondering whether 'load ubifs ...' is now the preferred entry
point or whether ubifsload remains supported

Please also spell out which user-visible commands get this new support
('load semihosting ...', 'load ubifs ...').

> +     for (i = 0, info = fstypes; i < ARRAY_SIZE(fstypes); i++, info++) {

Can you add a test for this, that loads via the new semihosting
ifname? Do we need a doc/ update?

BTW, what do you think of this 'desc being NULL' approach? We should
perhaps improve it so that we can support non-block filesystems more
generally.

Regards,
Simon
