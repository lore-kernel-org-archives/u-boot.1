Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A53FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E06845D0;
	Tue, 28 Apr 2026 16:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BbZIi4eI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F3383FB5; Tue, 28 Apr 2026 16:05:02 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C23E3843D4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6764e36dc88so13150697a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385097; cv=none;
 d=google.com; s=arc-20240605;
 b=f05Yfml0idnsND/kRmVmD5uHiEx2ZpwU99wBPcOA/cya1TVT+GiTeOTr/CRR5eETAK
 J1gGJDsVb1DhBLz9th1aTnRY8nEKHeBguyJRmn4aHv80wOFFfTKZQC+5/xza/5W5TQLv
 kKR/cdmm3P7aS5vFXej9NlP2uLi/r493DhAb/b7oE17zk1HgMzl0AlB0XygM2lva5wVD
 rksBWXOwPRtLscmBuHTXxQu13zqxL8W11jnKS1fmujO7zj2NELf68TtP909U9roBbwvY
 sK1wlEDZ1GqYSaOG6PlQZyPeEwPQOLfE2dzDQxNH+9f38KPmn4Uwa9IsMe18pN8c91aV
 ML/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xv56g3TyS4TBIOHG630aNUZzftz+y73ZsEgylgkxJjo=;
 fh=PHo6SxFQeYGijuQxNVj6Mu5BE7imZMp7yjwDYBEMLIQ=;
 b=Uy6V9DQa+HJUaVq7xyTK9f2xBeI1JMHY6CrjT9mX9k+EPed6EsNgBxFA//TcFaq8WL
 GR6SaDUy5NiVJLN/PueecWRF4FFE19QthBbdz61WdvczDpbtXizdWERaPjo0bEihpLm9
 2ZFB6evAkF9XdzNX+ItijwUt5ZlxWRi+c0XOZiLe1em4Cmbekdp0nAAbFJmGPrReTc2H
 O7BVaIuc/FrDxS2rRbghCuzuo87glB3Kne/4Rkwg+bWMkqqT4FrCCqLu0Kpd19xNYEDu
 KmQrtDeZBLWEVwq0omLuFTcXaX+rbkTmuZ5P0r/Qp+1i4zi+44fOUnt/Lsj/y2jYUOkS
 BlvQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777385097; x=1777989897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xv56g3TyS4TBIOHG630aNUZzftz+y73ZsEgylgkxJjo=;
 b=BbZIi4eIbbYBtDPJtLqLKW+3vo500Md1iWQ4YaJckMn3nqYpvDcvCi/ACMJYloRXse
 LbtdQpBbL/Pj6+EnS7D2Vz78t14KoPL3szMmwDA6RZWDEGJVC5lN/P9lCmWs2fgIvEQn
 w+qOgpAfI3OxjaanHJyeMGRjGqHTzv0gXn6dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385097; x=1777989897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xv56g3TyS4TBIOHG630aNUZzftz+y73ZsEgylgkxJjo=;
 b=GNYRxGOfdFs0pBza5/40ij1FHDC5ztTX+pEdTOKL0OYPUAlKY2VENBrKkhy8HRk4oU
 vn94i4fiqtOd6XbSYIUNAW5kDHj4eTMnGZ60jrt8fnkERrzgmnAYnyQE+carUee1jdVp
 UzNYyRciX5YPV62r+EM+0UxVV966hvefW+N7DYXow4usUvdZ0LBZszz/M8B10OUsus/p
 3sz6zYqWegoO2BRbvTP0pKEoUgOrPyJK3mDyxdWlz0iz9Nu0doLWJGhD71OMVk4UfPkx
 ky3RO61vofoZ2nFlo1FZq/Qu9r334NHI/Z83ThTauQ19xUtuCnVVu8ZcdVPAVM9kHtzP
 b7Fg==
X-Gm-Message-State: AOJu0YwKaOln4BosotgUrQG9+Tt0F4/0RgrqEEvKyFYvKpWn3SejhBuY
 q8dqKVDp74vcSsg8wT6oWS++DSrf1vK9WO+uaCFg0wEnRxdBfBC7VrUSfbOMKBFxB6dSBXf//rF
 ZokqUZ7D/v7N1cqH97lPXdTrUR1bJS/dz7jEF6AtYUGQQyDZzeyg=
X-Gm-Gg: AeBDietSrKNnEmXcbWoqwlDXxidF3tdgosOJJvsZitXWwC3ZnYC5Jdd1xkWbWAObM6Q
 U0uXcIWkSNX6ABIPYUGJmjRCGJQ+CvBkWQDMfZh5bl1JxkAc5j3kONC0tAFl/L0XBXSgi2Myke+
 E0fmJ1zseTAW3RtrRL+I1PIPZTtx7c1ph3l15hgFiT+YjoTUtDaEo4vb55qVVtQpR8wQjgOuVz7
 R6qe4wpxomAxoWMEN8KzoO1maXUhZ2CTYAjjEtFZhg/tBFNrgTMmaLCniT5pvCXdOoK2uiYpPSD
 ruKol3Vw4fAsW7uq6V8rDs0zV2k=
X-Received: by 2002:a17:907:7fa1:b0:ba2:5314:f979 with SMTP id
 a640c23a62f3a-bb845a2f2a1mr136818166b.6.1777385097033; Tue, 28 Apr 2026
 07:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260423042824.3480-1-briansune@gmail.com>
In-Reply-To: <20260423042824.3480-1-briansune@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:04:43 -0600
X-Gm-Features: AVHnY4LL-RH2k78ZEYbDFJd3FQuNAYVmDj5tiIKt2JhefgWIGXAafaZ1LNve5dQ
Message-ID: <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: briansune@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
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

Hi Brian,

On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
> Improve handoff prepare on SoCFPGA
>
> Ensure qts folder header files are properly updated by isolating
> the Python execution environment. This prevents partial or failed
> script runs from corrupting the target directory.
>
> Changelog v5 -> v6:
>  - Clean HANDOFF_KEEP comments.
>
> Changelog v4 -> v5:
>  - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}' != '0' ]
>  - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
>
> Changes:
>  - Implement a temp folder for Python script execution.
>  - Clean temp folder automatically despite execution failures.
>  - Gate the file replacement process on the successful exit of
>    the Python scripts.
>  - Execute the replacement (with or without keep) only upon script
>    success via the NEW HANDOFF_KEEP=xxx variable.
> [...]
>
> arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)

The per-version changelogs belong below the '---' separator, not in
the commit body. Also U-Boot convention is 'Changes in vN:' rather
than 'Changelog vN -> vN+1:'.

You could try using 'patman' which will get this right for you automatically:

https://docs.u-boot.org/en/latest/develop/patman.html

I see 6 copies of this v6 patch in patchwork, so I wonder if I got the
right one?

Regards,
Simon
