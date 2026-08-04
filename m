Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D38CC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22BE780C85;
	Tue,  4 Aug 2026 13:07:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rn5xPXIUg5hr; Tue,  4 Aug 2026 13:07:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF27B80C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785848820;
	bh=800hX2UR7S+T6JbuQ49C6rQ/EQDi7WCmCFnOJtjldgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VeujxEi1hxVZWuI1aFZQdpdMz0JgbXmNOKVioQwSQJsixRxwpUdG++6/onP3oSppm
	 C3zuFRbBb1LOYsKsVxO+sm3kOGtCiiCsDrQa2QPD9FC8I8BKZexPC85+j6xHNEXWwW
	 ncPp17dpMwhr5p+2eEm8Y61ytxLgcmyQJQsxP17dRUT72XnZINX9lGyu32HmjdCCvs
	 LO04z0BPpYTmUbHjrNnHFRPCJFMeBHH7dQrNjeSMbuuDln7cwpt7ySVfeHGWCCsVjq
	 eSMjlccj8+MjEYVrwD1USkg7V9QsWTeJWd1WuWJ+5IYn2EBkoAwJ103nWCJJW3Qtqs
	 1aTeXIPTn6aMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF27B80C6F;
	Tue,  4 Aug 2026 13:07:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D6FB350
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EF54400DA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0BMBGvsUjNY for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:06:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6DE5A40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DE5A40071
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DE5A40071
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:58 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so64073245ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848818; cv=none;
 d=google.com; s=arc-20260327;
 b=ZOwZ/iQ47dhJLEMjKHmwFEtimARSYG7OToLzsa1+BkuhV9NI9ZC0egyPuvWOEDDjpu
 ngVitWQ+gMDGGFsyAWud8OYN/o2fCCA2e7mH+CNgDEy50u8Z1EaUjMsoJYbOaljmMvSv
 jVBa6AYryv5TrAH3xP+me55mSZmim58D1pGIOUEp2uao92HDjCfbbt3jZ3KG5LyRO35X
 CtYAM8SAB/6jovnzuzHZVDq4O2YLjRSyuqf6/onNAo9wOIXdC5Hwz5AbuLWpYKoqPaLK
 t/hrdOZTaq3BdU6oXN5OdX4Tz19+j9HAXJNBMPIkaQGghh549z3lUC0Xj4vb8NGVHqXl
 ZIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=800hX2UR7S+T6JbuQ49C6rQ/EQDi7WCmCFnOJtjldgo=;
 fh=AQR1yYbryuDBAyUMkONZdS17UtE0oglklJGdA2HbjIg=;
 b=Kem7p358yTq9gDMIc7Rf4qXEhwRc5xHew8P4Co26oPgtcGeV/BWtC/tp3E3FXVblmZ
 AdY7nCMVWwmA0FfMSpvTJXP0SXAl63yhUx1EDvL+E7HUKY6txqPqe6g+r9YEBlnGq/H9
 kCfmPti0sbWk9KfPNbkCpjzk8ezTK0JkwvrcEnrSl+znExSoJeqLPhbAzxaNrcfq3nyA
 86C2I3KlwBmeywgUED0DTYlO0bKqirD05pEFTIaNFSIonwIzxxl4W5XkMKzTiflsPwxW
 0dk2tUythmnQDi9R8BOuo9gbTd0Tszmdc1uHfe7y/+PqcFPZ/9GeZQ8KYAyccSFcGm08
 IQ+w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848818; x=1786453618;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=800hX2UR7S+T6JbuQ49C6rQ/EQDi7WCmCFnOJtjldgo=;
 b=pQMhrWsFG594PP8j0FbvhWtouIhb5AQTiUEvt4NMKog4KTxu+vCNJjYU0EcpT3iizW
 eEbkTPzZPEZ0MXFhMIpkez8iZdf8h2OpTtzVCJlyK2Os78FpcsaYeafYU+1Bodrvv+HR
 Op/qQM+NWgN9t40peo1WKTrKcyhZXBaH8WaTIpoPxwvziIp9JviJiZwzcOrHCfeDKxv4
 ckTnAemB219B6D+c0RcTY6cnp7SYfjQs3TyFfgcS3VP9GdS4D3VdCie8eAKHKHCapSKM
 vV9WUDXsiBthtiknGqP5PdEBm2wgKEMRAe5H40EVUFpzmQ2e/s9aWzzds9lqbmgEkNSK
 xZpA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqcMgJRaHds1xSV9ITwf3g/agAInRZ9Ghcjmi1FPKIKxfZQ6xX1xG4pU208t2KKh9bVfavwn8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzAOeLyfgEZrr2vLxgl8iSaiAqFb15c/yg2fZaA65qx4B2DvstU
 Z/rd0dlInPqR2y4MPf9Fo0oq8GqkSOHE5Lp1yawy/ZPZvSO5uy2ASha10ZdwMEcg6uCEuloT7PL
 7g+nd5eKMRHRCYNfRRPXlgmAR9KGTSPhRsuJH+SbQ
X-Gm-Gg: AR+sD1113qyYQgnyoY0J7Eq7IbFQZIFrg9TRHGC8dWrvbAN44NkrQX1yKoDtbtu0z8M
 J4t47F8+A5FqScrOIs0wpfkGcB4/Gt6ehl3VPzefekYDILDLeNb8tOOYfytKXSliJRoGITI0Ap1
 8r68CR2ldjZP3Js3vmKqFjOVIBA4nr5JVg73ddDoTd6CTESFsV/vyuHVfSYz8urQv9Iw1vPu++m
 ESCVUB/h/TvHaeSwom2mfFkuB2zXjVJNNkatzTrOGpUgdIV1TXT9J5oR+K9wwE0446P1N0/I/a3
 pazNZ9uxdQJfoPitfj4auHC7B1tjnXLvS5A6q2mHZ9g=
X-Received: by 2002:a17:903:3d05:b0:2cc:aa36:c046 with SMTP id
 d9443c01a7336-2d0521d44damr137870185ad.14.1785848817605; Tue, 04 Aug 2026
 06:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260731112229.2211474-1-me@ziyao.cc>
In-Reply-To: <20260731112229.2211474-1-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:06:18 -0600
X-Gm-Features: AUfX_mxQ1OxsIfQCLoAhcrSbDC_X84DpVHVwHyaOHcqxGopQ97KexWqEizVVlhA
Message-ID: <CAFLszTjqKd_wK5Dnhzm-TTc7TOvGfcu1pw=_=sJHdrhL=y_+Uw@mail.gmail.com>
Subject: Re: [PATCH] buildman: Differentiate 32-bit and 64-bit LoongArch
 variants
To: me@ziyao.cc
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848818; x=1786453618;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=800hX2UR7S+T6JbuQ49C6rQ/EQDi7WCmCFnOJtjldgo=;
 b=B9w90xoR6XDqI4bp2LLmw/YtH8tTfdpNYYEe2kvP2GzeWCV/WXGqvQtc75oBxHgVCt
 xzDJftl53rOsttlwCBH77omz2Wad1b+tR5JU9YMmaTYRUsLiWlMUj3Xlv+Plw2GKw49a
 yQ15ju9TRMtl8FIMjz7ixudx8i/U2sv4bbsjk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=B9w90xoR
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Yao,

On 2026-07-31T11:22:29, Yao Zi <me@ziyao.cc> wrote:
> buildman: Differentiate 32-bit and 64-bit LoongArch variants
>
> Similar to RISC-V and ARM, 32-bit and 64-bit LoongArch couldn't be
> distinguished solely by CONFIG_SYS_ARCH, but require different
> toolchains if multilib is disabled in compiler, which is the case of
> toolchain provided by kernel.org.

Please use present tense - 'cannot be distinguished'.

>
> Let's override the parsed arch parameter for LoongArch configs based
> on CONFIG_ARCH_LA64 Kconfig symbol.
>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> tools/buildman/boards.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)

> diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
> @@ -309,6 +309,17 @@ class KconfigScanner:
>              else:
>                  params['arch'] = 'riscv64'
>
> +        # fix-up for loongarch
> +        if params['arch'] == 'loongarch':
> +            try:
> +                value = self._conf.syms.get('ARCH_LA64').str_value
> +            except:
> +                value = ''

The bare except: mirrors the RISC-V block, but pylint flags it -
please use 'except AttributeError:'

With that:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
