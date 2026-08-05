Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AA3C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 18:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9EA280E37;
	Wed,  5 Aug 2026 18:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xkw9T8i7B-To; Wed,  5 Aug 2026 18:58:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CADB880E28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785956338;
	bh=A3ebwHQ55LHED9mgogfqALoxWeuvcBANBGDMOZWvdxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Utiql2NmZ4Ze1tAMxz2zjBdycKw9KZYbwv0JbE52m28hVcwcWJ3Z4aijMdsngrab/
	 DEZMlAlCtt4BXxOQrKsvBnorNuVp6TyVcmvDjSB9gTnkc2sM9jDE0YvfE9nHB6Q/m+
	 liRnW9GAETJxc9c925wcDNdV+4zsHTclsm3Lm5ooUnHRmNf9lt4brE/6dD3uc4mt1n
	 TN+t8jn7cyNH2EbFO01RCTdJuvOMVxL0cJWVKQIHtxgiLUNo1zJ7eNeq1x+nMw1Phd
	 FdBLEn0Xmynj+dQK7Lg5aslIwXejuU7Bz3k9Q2wCxEZEQEhHRzX84cwhumsXKFwG1e
	 +BOXDEYebWi9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CADB880E28;
	Wed,  5 Aug 2026 18:58:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 492C62B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B22860613
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0dcauITuvmU for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 18:58:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 57410605D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57410605D1
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57410605D1
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:58:56 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so1446872a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 11:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956334; cv=none;
 d=google.com; s=arc-20260327;
 b=hlOqQT+GDxY1KLfvqxigTW127cOL/ycQ3hRU1nyNQegwNUfs0A9ZmjzA3t0OKa1Zu6
 HaH9K9ejl1/vFMGVd3Ygk4n/1+UqSN2e+MLT8qxngBEPLcVKLdxIs/Mr1Eq4zvFdktt/
 3uXX+xT9oxYQtX0iTJpZcGMheCKuhXTdBCgal47eci4KQvjvdvrfy3GQCASk2oC3+Kjv
 W0y7II7xAzE/n9pHn4krAYumHMyi0I6srHSUnkRyC5Ove8Ss66HoIyXWYN9XmC8kapQf
 PoOb95NSoJrTv4cIya+mnmVZ8ATccLa786dfCnBTYoGMWaAWz+OMQLEjLGtJjWTry25M
 9Epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A3ebwHQ55LHED9mgogfqALoxWeuvcBANBGDMOZWvdxY=;
 fh=zlmEZsCfV9AJYvqlp/divHgxhqIBhW+grZ7Y0ziDpXQ=;
 b=h+vigzjwPrbaMhbVR9+0Mz3uB8zgsGlzSMb6lM/knhJYcItGMWU8gtQWkjAS457FzO
 7OOXxk6PYo8P3HT4raen16J8wvvecwdqwNLVwUqqJy7ZGQjP/gKZ/hDjANLIarillG35
 H12LBoyROTkWjeMXYA1drWtcPxQ+fo41XvvspVON2pyUGGXjnIcdNbUS1lugEgYzhhmr
 1a711fL6K0/tZnBkBCvjNjdIlzlWSM2cUtR2ohv1BXuApmFiX1ivn9FTFIsPz0Quj5GU
 jOUZ+FYjFnpMhmmynqmXzPViDpYqtEn/nc0JCgZ76bf/gToyg0GxKLSqQdo2jkTD2c9J
 4z/A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785956334; x=1786561134;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A3ebwHQ55LHED9mgogfqALoxWeuvcBANBGDMOZWvdxY=;
 b=EZGAOE1qa+j4OI8C3sh+22FlDFuQXeqXlpFYMvFkDKh892ceJyTpSQ7J7gjBjQjXEf
 erm9/7I8A63mtb/FgcR/07EWHkJ45Ouf1E38sA0YLxLa8CDvLmkW4F91MciUishXMf0C
 9kZExQfU3x2Xl6tonxcu+lFp/adHw+xxA8rGQsw+oecgNgZwi7HWNg/M32SWPxiCDeBN
 VbNDQDiwGT3O3i7gFcz4kd6Q3JKf4uE3hRc315/AIwSXPZbsqGV8CiiWCwIMh/RJIlFs
 FRZKkxK0Uo0rv4XHplhri5E9ckIK8/RBFpXxCGDQg2kbPQYCGEk02ten8c6VdsygwBg2
 X17w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSiKbdApZtmGNVPlqsz8qUnTFRlhQR2uJMKLU/V6vp7Tnz6h1BR7iYlGDCxBShaV7k1TLTn30=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwELClhdKmN5P2pxpLp+FQoZ1kmDvR+qn3kmwOf2y/neL3WHZuE
 AP6Vm7Xjlpsy+3H7/YpwSZ5rJOeztQqFQR+iNputbULqUusMgviHDeCQY/idk6KXjtz2WXcf7/7
 AgDOaHtsTlC91cCVMLqcsAszguqmJZjllEErXJ2nq
X-Gm-Gg: AR+sD10yDCT7bfbFXQbQQD2y/lD2q5jGwxMdhdFwEfMTmVGweM0PuQaIr5ExfJYjQoN
 yokMDsPc/b4JXryQIFuO47Dfs7IGxfVfVMar8053H4gp13D1tf+HWJfGm716H68alLzzh5hM34s
 iDppF18rOxlLjUs4xrk8kflynv85RPRvhUyLdeqQtm56khRpejMcruUoCytSjw8+LDPsPew5/A8
 L7FyjcuddEQXVHGLh6ibcSARjv73m4crL2WP1GDrTy5QCOuAAZGyngIv77Qn0DQNFoVKyYFV6x7
 /If+gAFOow895HU9pHmA6lGr+M9acge79TCdvfYlFGg=
X-Received: by 2002:a05:6402:3888:b0:6a1:8fff:1590 with SMTP id
 4fb4d7f45d1cf-6a1900e636amr445716a12.19.1785956334355; Wed, 05 Aug 2026
 11:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-4-sergio.prado@e-labworks.com>
In-Reply-To: <20260728113535.128601-4-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 12:58:41 -0600
X-Gm-Features: AUfX_mwogfLBo0ppUq9GkPoCYcDFlKvUat02NL_B10SUvkYUPIOF481wbFZXLvM
Message-ID: <CAFLszTiUeMSM1iJUWObYjh2wCOVV9+LYuUzPZQd7Q-D9o8cjog@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] binman: ti_secure: drop the redundant keyfile
 re-read
To: sergio.prado@e-labworks.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, pbrobinson@gmail.com, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de, 
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785956334; x=1786561134;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A3ebwHQ55LHED9mgogfqALoxWeuvcBANBGDMOZWvdxY=;
 b=lotL1l5LUASg1Q6fGZpqoMl5jSoh3GT4M5/+ziNuaZ4sH+2aI91y7r+0pKzRcgrG+v
 f5diGqnX4kMH6qOdR73iOzKdOFFVqRQOuG5gtE9LC7Upyncfzl9l6Ni6TLaa5rQ9jjrs
 DtDJF15wEyFqCrqYwSw4jnRTQEl/HswJJihPw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=lotL1l5L
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

Hi Sergio,

On 2026-07-28T11:35:30, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: ti_secure: drop the redundant keyfile re-read
>
> Entry_ti_secure and Entry_ti_secure_rom both call super().ReadNode() and
> then read the 'keyfile' entry argument a second time, with exactly the
> call that Entry_x509_cert.ReadNode() has already made. The second read is
> pure duplication, and it means anything the parent does to
> self.key_fname is silently discarded.
>
> Drop it, so that the subclasses use the value their parent decided on,
> and drop the EntryArg import which becomes unused.
>
> No functional change.
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>
> tools/binman/etype/ti_secure.py     | 3 ---
>  tools/binman/etype/ti_secure_rom.py | 3 ---
>  2 files changed, 6 deletions(-)

> diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
> @@ -71,8 +70,6 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>          self.sha = fdt_util.GetInt(self._node, 'sha', 512)
>          self.core = fdt_util.GetString(self._node, 'core', 'secure')
>          self.bootcore_opts = fdt_util.GetInt(self._node, 'core-opts')
> -        self.key_fname = self.GetEntryArgsOrProps([
> -            EntryArg('keyfile', str)], required=True)[0]

BTW Entry_ti_secure_rom.ReadNode() also re-reads 'sw-rev' with the
parent's default (line 70) - same pattern. Folding it in would leave
no redundant re-reads at all. Could be a follow-up perhaps?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
