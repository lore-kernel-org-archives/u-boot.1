Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D933FEA71B7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5697A842E6;
	Mon, 20 Apr 2026 04:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jx7JAg8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDB4842C9; Mon, 20 Apr 2026 04:52:44 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D733842CD
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so4387429a12.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:52:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653560; cv=none;
 d=google.com; s=arc-20240605;
 b=fmZfnQ3W3/UzSdlC2zfq0xNcPaZmD2I46qtDrtCEB8N5JdmKr3awJ0VN7vkyv2UJLd
 xYCW3sRB4Wmgo97aEi5I1StPeyCCDgNe3ZirBwlbfE71XGB7R6QPfQGII8vZY5TFXUM8
 D6HjnYlGK4znlbDgZYcd0Ix0e4Z37WT/IDbqRl1yNB/t46k38bYw7x6nzMf6hzzf2eQx
 UVeb4za0PvMU/s1YTyiW9KZTCyUfvHbuci9t1uuOyPA/W4zQsAFBVY0WVW7m9RfL0c7A
 3DFfjBCFr5JXlqzFvbg4G5HFYRwQ3kEZajGQUtPZ+NLXqifbYifbYObFRbr5mXAXlenY
 BURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LRI4DwzWUeXiR971oNh3keL59PJfuWoJz43XPLjtyaQ=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=JAEBEU5NDytxIQFsRWG3jnHLQWthlixpf541YCIelJ6zJLRdegVCTBNjvBVpLEVIV/
 e+pRZyAZmJyPMcThqfz3dPoMiuZQY3bg94r37KPRLVdB5BQP6xTybNqquL8fJDF1zwCS
 PFFn45DlygDzg/sDoURMJACG9kQvqGRv+Mr7fY5Oyx6e135x+8i1PaToWxHFQl2Ehj8P
 IqdhC84A9dOIoMSMys2L7ETSbFZgw434whKMAp6voYV6OtqfhLXb1c/91Q71KzaZJ5tI
 PLRLfniF4/c/BC0ugfqT2iJtlEFSPgRKcfUmxNJkDgWsYQGRGUEpXWA80N4KyRaMrnrx
 Vf/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653560; x=1777258360; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LRI4DwzWUeXiR971oNh3keL59PJfuWoJz43XPLjtyaQ=;
 b=jx7JAg8t648XXl7idx/8g1PJKi+dsS4HAqgjIDBHQSk2inAm2yKmQNzz7UOKtVGITC
 h/gnLFfDnwrLRHhRSyzSlNfbI9maYK80MmaLlhO48DeTfDz7ws19dBJpe+eeXoedN00l
 q2C9WxHLocFcAEt/Efytt5OiC2guXTQazAAa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653560; x=1777258360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRI4DwzWUeXiR971oNh3keL59PJfuWoJz43XPLjtyaQ=;
 b=Y/WnXyqr5naAW3XNF4smTtQqZy0ltjWfoHeBS/zIiKSif7bb+aEQJdh+LbQEn3ZS/9
 oxa9VY/9cylmIAm0T4f3q8YO3xHTvSFbbUtiFL93LNmK6/LBZ7WbECt7otaexEF0I7tl
 va9WT3CBtpJD3nW1v5ePnAJCdUBe3tvCRpoimevskQIshX5Xw3zMFr13IdRmP/HhrQMT
 WY7475b8d19yhgXnpRrpgjzVgkHnED/Zu+1ntN+o1mk/2IWo3q+3NPELK4lVZeO394Vc
 EjfTfzGE+vOd0mBEXu6+udVy14omL/UO34+KYiWEfD+pOnUOfejnqAnj/lifPb2W5quE
 Al7A==
X-Gm-Message-State: AOJu0YzfBeq2YRaccPQL/ARrYvxvUOH/sttHwVsNvLlFBni1i7dmzTUa
 l/oaq9ZLhRcXBqcqznteFmr2BFpPbPAbFmIS2dVUWfqChoOZ865a26igGEhvUcq/UPkINXFgsNd
 zSwuz7hTrVfVzQS9eu8PDg3itWg41QMBxr/KHeoDC7Df32WLQl0sFKw==
X-Gm-Gg: AeBDietejCRKyQ1wLeDNPDiio63ePsStAiKKJpFLjwgXthjdgM/GBy2EyySVS08eQi1
 IPmXhlpVJUag34HgL/Eal5tJhjfrySuZibV5Zf04D2tp35qq6fOd6ijaQbpnTQirZfe/FJsj99B
 fjtCtBnr3oOJlulqBA1AvYyuTDZBSyAI17mWznT2wfVT+GPT4ZZtx+KW1zp8WFOW7W4abZQyUPd
 UKOgbdq6Cdu74mrolHXrNMtA4kKpj8PleRxFEbL/Nkcic1vGyH3ksFdFfUqJx4ZvibPQ06tZG6L
 cZU7ot6JSOEjApcPI8j/
X-Received: by 2002:a17:907:1c96:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-ba41bacff3fmr462952366b.9.1776653560341; Sun, 19 Apr 2026
 19:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <89302771cb07f6f8ff7b5bf09c822d79bec4223e.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <89302771cb07f6f8ff7b5bf09c822d79bec4223e.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:52:21 +1200
X-Gm-Features: AQROBzDdnEOrkWou371SyI65e8Wrz12Jr0c0YuY0L6KMq2VJBIVL5PthwoHoOxo
Message-ID: <CAFLszThKJZ7HZUT3KkB7_ad7mf030BRq=UMdoQsOSyEdm30qtw@mail.gmail.com>
Subject: Re: [RESEND v4 08/14] mach-sc5xx: sc573: Rename EZKIT board to EZLITE
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: sc573: Rename EZKIT board to EZLITE
>
> Rename the SC573 EZKIT board to EZLITE across the device tree,
> defconfig, board file, and related Kconfig/Makefile entries to
> match with release naming. EZKIT was used internally before the
> official product release.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/dts/Makefile                                             | 2 +-
>  arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts}                | 4 ++--
>  arch/arm/mach-sc5xx/Kconfig                                       | 8 ++++----
>  arch/arm/mach-sc5xx/init/dmcinit.c                                | 2 +-
>  board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig                   | 8 ++++----
>  board/adi/{sc573-ezkit => sc573-ezlite}/Makefile                  | 2 +-
>  .../{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c}    | 0
>  .../sc573-ezkit.env => sc573-ezlite/sc573-ezlite.env}             | 0
>  configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig}         | 2 +-
>  doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml                   | 2 +-
>  include/configs/{sc573-ezkit.h => sc573-ezlite.h}                 | 4 ++--
>  11 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
