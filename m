Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F6C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 07:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09727808B6;
	Fri, 28 Feb 2025 08:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s+/OL7TD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6249880BA4; Fri, 28 Feb 2025 08:41:37 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AF6807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 08:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so1472665276.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 23:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740728493; x=1741333293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X/OZUBAQ51l+FldB1zvphAHKNIzmpUM6HgW6tvUU3N0=;
 b=s+/OL7TDezD88CoJ84tBwrwwzv5Xu7id1WudNsq8K80eE5vDUQEYJdzJOd09dL5dxi
 GXrOb2uWXX3RuMsSbMLE/Six8pc1XGjbZsjjTmbjirPfzCZjEEt7fB4WhuRYb2R8541v
 oi+YwYLk4qE52D1bRaS+DN1AsmXpMUJEn4e0yli8Q+frS6bvcNsA7qOKeoA6qLZD22Zx
 C51YIoflN2Guar/gebDcsX1/JLsVrxjUOIwMZmO3jgtSkLor9rao/1wAI67X710+3kqd
 CQi/zVA5DtIavIPzKGYeY1qk211tuzZYVwj/jGGWhJA3FKPMHrvoWJN9RDmJw3NtDSyU
 VjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740728493; x=1741333293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/OZUBAQ51l+FldB1zvphAHKNIzmpUM6HgW6tvUU3N0=;
 b=W+NvH/PXOZoHpM7xCNxfVVOCXijJgrFi7Ux/HyiCTUgk3juhcOY28m1mc14iy6I4s/
 J88dJxzOvg08YivwJN1CWilNyoNvsNWgfqlL3kGam9wzQlA6p3ABFUgGovxm5mIJQxTz
 bSG0PMCAyJVyrJwAwildcbpjSkKxS9azNsGAT2o8gi5Duguo1LNSG3BaoR/7QZf8j5Jp
 xGaGzvaf5o329I+r7/QU4JGDneE1wXvyK56UVZLxpHZeUBowLFFQEdUny/0FDb/Kc352
 LWv5RHfm7GhjaaXZxD8DvDs/7s589AEZ6mxQz0pGSi1MoxgW9ttyFh9RMO0skhrjUpS0
 BMFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqqkiEJ9MNmLVBYrocT1zZ6MwL0o+kdz9fV6G0WS+vMBlb1aSVRjZFq6+/H97yYHQTQNWu0Jg=@lists.denx.de
X-Gm-Message-State: AOJu0YzATp+aetj/528AJ/QYi4pCX3iQFfLfqClh8a125DN4pifzpbBQ
 PrU+nLnIsSh23JtbiGlmPxoxQZQT3CZoFMTEzoxMOGacDGuqlTLw+YBmZz8x0r4bb9vaHVSfbk5
 MlTH2u/nqYaGNTHKRSTnBej1sqSGeidLEtetVnw==
X-Gm-Gg: ASbGncuMkVPt5X4V+IXQCuX3s9MEf9aipGx6G/hIBccwymVPhuMKJAAejUC4/EgAKOa
 pYY99bMBfEg0hWveArrvzNyLJHn0mpgWWLe94m38FzAQohIybplcdUSfpyiJiwV1Hm5TDgdoFO2
 aq/YF74A+8
X-Google-Smtp-Source: AGHT+IERUAlg96LL56GP+4eWhlsOJj5p4gXWajc6dH1FXqzuLJKDlzMgubTrvF0mvpGjh0PBZlRP1F8S/Zz4PeaBhBI=
X-Received: by 2002:a05:6902:230f:b0:e5b:16b3:ecfb with SMTP id
 3f1490d57ef6-e60b2f2dbaamr2223449276.35.1740728493252; Thu, 27 Feb 2025
 23:41:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <20250227180623.GI2640854@bill-the-cat>
 <4a1222e8-ef18-4753-9870-b40ddf35145e@linaro.org>
In-Reply-To: <4a1222e8-ef18-4753-9870-b40ddf35145e@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 09:40:56 +0200
X-Gm-Features: AQ5f1JoVXMUrmvAzQ1F6Rnf0UbPjTkis1gokrKdJCrA1ZvXsPtL5P_vLSXc71Ws
Message-ID: <CAC_iWjJJe2f7a6ckjL0XDGmJA6PqtOTeqTkjFLNOGkVM535a8w@mail.gmail.com>
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jerome,

On Thu, 27 Feb 2025 at 20:31, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 2/27/25 19:06, Tom Rini wrote:
> > On Thu, Feb 27, 2025 at 05:09:00PM +0100, Jerome Forissier wrote:
> >
> >> This series adds support for HTTP server authentication using root (CA)
> >> certificates.
> >>
> >> As a first step, the wget command is extended to support a sub-command:
> >> cacert <addr> <size>. The memory region shall contain the CA
> >> certificates. With this, it is possible to load the certificates from
> >> storage or get them from the network for example, which is convenient
> >> for testing at least. The Kconfig symbol for this feature is
> >> WGET_CACERT=y.
> >>
> >> Then new Kconfig symbols are added to support providing the certificates
> >> at build time, as a DER or PEM encoded X509 collection:
> >> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
> >> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
> >> command as well as for the builtin way).

[...]

I don't know if we can do it in this patchset, but in the future, we
could store the sha256 and the CA certificate path in a U-Boot elf
section.
Since we will soon have .rodata section with proper memory
permissions, we could automatically download the cert in mem and make
sure it's valid.

Cheers
/Ilias
