Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73701C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6C78893B;
	Mon, 15 Jul 2024 15:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L4sDRMPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F508888EA; Mon, 15 Jul 2024 15:31:56 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A258892E
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b772455ab4so7780566d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050313; x=1721655113; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YwPJAAJwRHDi4/J43zCM4znCpkNwgSTn5XHwOBxD/0Y=;
 b=L4sDRMPe/WQcJ2ku3Xv8l//cixYXqxnoUshu4oDvYACvcCTdXUSC2jmmLOmcA1mu3y
 +a0sqRyBZavgUWdTQtrbqPdMJHrr7FFT0cFfrZaaKKyeN5VaexjURp52dpNLXyZx+EVd
 UIrn+AR5OyzM3ejq+l/zTkclJwEr6ZMoxLZ7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050313; x=1721655113;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YwPJAAJwRHDi4/J43zCM4znCpkNwgSTn5XHwOBxD/0Y=;
 b=ialJrzmKJJP11Ax/9mqDOb3YRIeF/io6dP2gnqjHeKUkzX5gAbAYsTUC8GbrMaC5il
 btK7/42Gv/ApkPIaDVHqREkLdskR602+clsPsCYVGhvyB7gPmr/xuZ6T/el9MbXIQFVy
 gP0xLsvKnAYiozr7oDnhc3RNQPn2SKToFRYXzXSY0CzCdOkwzCsLRVmWGVm6bBk2PAfT
 vhUKOGEVqxUVD99iyCJBGehgeKgU4u3CZjj2Wu2O5c7KaaLGv+YHXgC5Ip6NHdRtY7bw
 sT4F7XXlL/JY6qIlCuP0VKGlXJb8Q+oLCAh/SvILsBGG5WXoDqGXahLKJXNy/+9vh9J3
 LSqw==
X-Gm-Message-State: AOJu0YxaY60n3xhm41EPoo3Uon66a3asH1hqnb9zujUjTykhpSPMSEOc
 hPslNUNIzbJ9njcqmJlnIn+4BUWrWDIdc4H/b3VfDNje+L3IHVBVxqoIKg6mMoytVmq44UcNe6L
 JSacvb0zOqcVwdCijob0EH825ZhHsKvcczs+9
X-Google-Smtp-Source: AGHT+IGrsUO2v1OEEe+a3N3isRzYBan2e9gWaIT69dLtK6OhhRvjeAYZW3cB2tgtLPooviCpzl9Kpn2WZ8Rqsobi4W4=
X-Received: by 2002:a05:6214:ca6:b0:6b5:1584:62bf with SMTP id
 6a1803df08f44-6b754b6bf06mr171162996d6.6.1721050313121; Mon, 15 Jul 2024
 06:31:53 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:52 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTg-z4TgQ1Y9hjsOhGsKczJ_A9_0j4Cm73e69Bvnu1jZKA@mail.gmail.com>
References: <CAFLszTg-z4TgQ1Y9hjsOhGsKczJ_A9_0j4Cm73e69Bvnu1jZKA@mail.gmail.com>
 <20240604161607.1133032-1-brandon.maier@collins.com>
Date: Mon, 15 Jul 2024 06:31:52 -0700
X-Google-Sender-Auth: 0NVireR2c75m_bN_qkNEi89e2_Y
Message-ID: <CAFLszTj_T76VULtZF=pfXE9ZCnuJKuCXd9DCth5nhMmm_8gr0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools: binman: fix deprecated Python unittest methods
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Brandon Maier <brandon.maier@collins.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
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

On Tue, 4 Jun 2024 at 10:16, Brandon Maier <brandon.maier@collins.com> wrote:
>
> The methods `unittest.assertEquals()` and
> `unittest.assertRegexpMatches()` are marked deprecated[1].
>
> In Python 3.12 these aliases have been removed, so do a sed to replace
> them with their new names.
>
> [1] https://docs.python.org/3.11/library/unittest.html#deprecated-aliases
>
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> CC: Simon Glass <sjg@chromium.org>
> CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>  tools/binman/entry_test.py  |  6 +--
>  tools/binman/fdt_test.py    | 48 ++++++++++++------------
>  tools/binman/ftest.py       | 42 ++++++++++-----------
>  tools/buildman/func_test.py | 74 ++++++++++++++++++-------------------
>  tools/buildman/test.py      |  2 +-
>  5 files changed, 86 insertions(+), 86 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
