Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F932CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FDF846F4;
	Thu, 25 Jun 2026 14:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sl04QY1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 229D884894; Thu, 25 Jun 2026 14:13:55 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05C88460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c7f11150cfso7842315ad.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 05:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782389631; cv=none;
 d=google.com; s=arc-20260327;
 b=S+xHGkzUtHAegxe74sl7EPYbq++fgftVpe1jefdMX9oRYBnkBDjmfA1Wp0i83yzlHh
 BuT+RU37tjgo9b0Z/F1UejMm81f9UPA8ZVd1VOIenZ7GKzdPDKwiJ9fZSaIbY/oUCayv
 9HeaLYdSK6Uyu7ceTdFJ2hvnhFi4rzqYjXW22eNr1Si1lg8IaVoQAXKjzA+ue+BthOCS
 LFgr9SXzBJCJGN2YyeUm9hFAwbsjdmZSnZGlvCWm3u8T8FlDzavqnhQnwhMCNCzLi7eL
 KuZ8LF4ONf0s5cMIGWlUJJzdgsuQfW97Y2u0lTi00/uikJZfjQjF6QUQxK4j/Vf7q4qt
 Bs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+Ym2Ga8kbhUE3XqB830FxZQsl2YTi5S4LaT2gXiBfCg=;
 fh=28iG3kVR2siwnk9LAUcpAX60kx8af6cAG2obkWVxDT4=;
 b=PRI812lc6iuazF2ywYD+QkdIncVr8KOggzDe5oeX+R4ELarxf88xs2bJN5yjPqLxVh
 sqAmkcdY5VuT8heRxtYi86JIOx/nfNoJGM7bTKXqevJR+8oJQ3xHEHvYb69ZJ0rdTaYN
 IWtnGXxU+iS2rPcM/1WpRkwpX4fRTew6o1wx0YJyKTlte5QLGlyFOPfhn7xKrciaQ0Km
 Zo9g/h7fwaleyJjgxzcTNslZxjBtv2S9xobtXcHKDk5v4MSI7sP3D837QJjg9HCsIYnN
 NTtrwrdjgoG9RdWfF9V4g/ppms7qYRxl6xX/ArKV0ukpPQm5qbcshPnZwmLsWx16UXWD
 WOfA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782389631; x=1782994431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ym2Ga8kbhUE3XqB830FxZQsl2YTi5S4LaT2gXiBfCg=;
 b=Sl04QY1irb2SBUrrr3oOtyx+zp0/yLbwQhp22VTezulNHHLI35Rkhz6uBEkheFIEwd
 8Kq6xDa4+7jXAVTz7Fagkctbtl1PHXlJfgbKNT1ahNuVnGAQmDHi5q2mEgJTKFxgwJbK
 htV5lKKFghjOpaaVhEL6rHz3f8Ai1HruicAyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782389631; x=1782994431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ym2Ga8kbhUE3XqB830FxZQsl2YTi5S4LaT2gXiBfCg=;
 b=LK2WyWZB1yUVcbFt60Lqm7Fn0tEou8hP6GAPSCk73f8Tu2z5bhNOQS0wYfur6ggzsp
 AD0faotnHtG1LwDEJgudDRcCWkVKTek11+MMJfDseWgB07hToQv/CuABxS+f9gy19d9P
 iquUBkJSJlb45PE7xmFoaprHGTfYvCtQzqKqjj75CDGTKqnRWq0VFfS+cjVqUIPbDsL0
 gfymr84SiRBDcIqEpnV8mLLfdaAatBxdOaHxKEee8z9MQgl/5mUtKizJ+AV9m+G1c+a9
 EjikZBhYDizvqQeHe0+1Om565h7bgl6BR1LawNp+6WveYcQXYlXRUOIYb6RsEqhFiVPD
 Qf8A==
X-Gm-Message-State: AOJu0Yx8Wg+4ZA3upnpUYpdGGOjeGig9PyP0XnQLl7dgy+ZsqLC4KIQ2
 QPm/SQP6E7oVPM2j15bPLrG7KmZKEu6vlJZp9P44K3G7W4hNNwzS2hs0CooEKDUT9s7HyZN6s9i
 CRdyCqmnXPj2ek9S3JOlmDitSXyr0QciWW3e2/Oed8F3eqdF2kI+fsA==
X-Gm-Gg: AfdE7cnAognekaIanLimf6qjJT8Y/2lFPtb5dGvGZ77/0PcVh56afX5QEHcaMivApPL
 alOJw/3ByQDnaeZuTjwRPOGfLoa8b2IiNnHYPtXVKpn8u840G3vZgB70jrtonETgIi8JillV0yd
 w8XKqbjTz41DzjKHFCzqSOfINej7PhAHGV/xEyYjBJDwv+dWdVqnz6ciE7bNBiEMF+Ix4t28eGx
 3ntscDC+x3afTTTlm3LZOfllEk/TRRkYLNuteZNMtZtwRIYC/cqbZtNMIsUSPF3p9R6bOHZfA==
X-Received: by 2002:a17:902:d2c8:b0:2c7:e823:6834 with SMTP id
 d9443c01a7336-2c7fc657e3dmr24446195ad.8.1782389631178; Thu, 25 Jun 2026
 05:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260619155857.9665-1-jon.mason@arm.com>
In-Reply-To: <20260619155857.9665-1-jon.mason@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 13:13:30 +0100
X-Gm-Features: AVVi8CdUDAfQPoIiTsgeLunsOfqC-jxOaZ7ltHniMpv4Q6NijdAldyPGWfat7fw
Message-ID: <CAFLszTiCVzQTd+5H1SKp+4PSizJ7KCU7QA-c=xdhvcOPrR45+g@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: move efi_var_seed.o to objtree
To: jon.mason@arm.com
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Jon,

On 2026-06-19T15:58:57, Jon Mason <jon.mason@arm.com> wrote:
> efi_loader: move efi_var_seed.o to objtree
>
> With commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
> (kbuild: Bump the build system to 6.1), there is an issue when trying to
> build out of tree, where efi_var_seed.S wants ubootefi.var to be in the
> object tree, but lib/efi_loader/efi_var_seed.o wants ubootefi.var to be
> in the source tree.
>
> If we change efi_var_seed.o to look in the objtree, then it should work
> in both local and out-of-tree.  However, it would require anything
> previously working to put ubootefi.vars to the objtree, but it's broken
> now anyway.
>
> Signed-off-by: Jon Mason <jon.mason@arm.com>
>
> lib/efi_loader/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> @@ -75,7 +75,7 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
>  obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_debug_support.o
>
>  EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
> -$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> +$(obj)/efi_var_seed.o: $(objtree)/$(EFI_VAR_SEED_FILE)

A couple of things beyond Heinrich's objection.

This only changes the make-level prerequisite. The actual lookup
happens inside efi_var_seed.S via .incbin, which resolves through the
assembler's -I search paths. In your failing log the assembler is
invoked with -I. (the objtree root) and -I ./lib/efi_loader, but no -I
pointing at $(srctree), so the file is only found if it sits in the
objtree. Flipping the make dep to $(objtree) papers over the symptom
but doesn't wire the search path to anything new - the build works for
you because -I. was already resolving there.

If the intent is to keep the file in $(srctree) (which is what the
Kconfig help promises - 'If a relative file path is used, it is
relative to the source directory'), the real fix is probably to add -I
$(srctree) to the asflags for this object, e.g.

    AFLAGS_efi_var_seed.o := -I $(srctree)

and leave the prerequisite pointing at $(srctree). Otherwise the
Kconfig help in lib/efi_loader/Kconfig needs updating in the same
patch, since this silently inverts the documented behaviour.

Commit-message nits: 'efi_var_seed.S wants ubootefi.var to be in the
object tree' isn't quite right - it wants it on the assembler include
path, which today happens to be the objtree; and 'ubootefi.vars'
should be 'ubootefi.var'.

Regards,
Simon
