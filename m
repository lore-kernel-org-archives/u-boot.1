Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BC8EC1116
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C483F83E13;
	Mon, 23 Feb 2026 18:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n5X01TNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B6D83EB3; Mon, 23 Feb 2026 18:53:07 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48C283E76
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so19767115ad.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:53:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869180; cv=none;
 d=google.com; s=arc-20240605;
 b=R/5Uw/tLEd67i1zRRYGH34j7hQUaLhqzxl/gMzrcmJoLrJtPpcYcF+5S8uS9fc3+JG
 JKKeqI+nybrPgO+iPCvNSI+cO6s8U/L1lmpy0TvqwsD3Sn9b7NoUckkUzyx3KvlZTFCi
 Krxdz0y3preVPuRdAw1PkwNhHevaEZZHVYNelUYvFSNbyxnd6DNsKc/pGERetrhVCYFu
 x4ZJk7o75UF0kmGo0HAme26No3vmOkYU/qZr+5nvafz1sdtuoOUeH5+1NGvHUQElL4qh
 A4DsK1Qs3jTDY/HbDx+6Hns3LyqZjG9Y0p4wc8+bVTzZASdYDSun/EmVxYKsiVmMk1rk
 S5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z41ogOzccyrOff7C7Uq/Q1EGXIfX3SgMtm1eKBf5VtI=;
 fh=RbmaUz0TiN1rTfhSVNLcOM0n4mmPh8Ts0q/lgeid+28=;
 b=Ft8uCcqiyqfESbmUiASbERK/eEzSzqD3WI66Zh/2xsuQaJdSl/ECvbPWvA0ybvCfeD
 8r+T6cc9ucn1V/SiRs53C4CrbWVJGgfhjMwnMohs1nlsCD4cwy8c3Yr2rHs2heSqLa6Z
 9MRH1nfj1e2BNXuLCg0IHS0kLGtv6d1FGKstr5wUZyIB49F7c9oVPMk1RQNaJ4Xzp9Gn
 bXAD3BAJQ+GDjmXHmALXhZxg8v6J5gqKHr2la7DZh3Ljt/gfemNDiJmSvbRbu2kAVkCN
 0t8R5lJPHej+PbLBdPpVdG2QpwvBI8cbOnJ8yLYcrn7VKvHE2KTFX3v7WUaldTDejt3H
 SukA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869180; x=1772473980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z41ogOzccyrOff7C7Uq/Q1EGXIfX3SgMtm1eKBf5VtI=;
 b=n5X01TNln91OvjMvLODFVeZNFn7FYhyox7gx4M+zi0hCiwKgu8zQVFNS9XXjitp/6p
 p0PTPdRHwZkVeQFAjATqKTDn5PNXQoBooSpDSNaKfH4E136kZ6xvBHfovcgINalDO/B7
 0Q7vk0aQSAOqsijNlUobuzAB4m8DykpCwwA4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869180; x=1772473980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z41ogOzccyrOff7C7Uq/Q1EGXIfX3SgMtm1eKBf5VtI=;
 b=BtkfNJSHqd8HeQzLtehlrIZBh7ISNwJ75oG8SNbNnKcxuyEo2viMw6KuIGDky0nC+d
 vsUeNBmpUQFf8SH6wjYSQqVZ/7GGc3dvAxE2afEMrbp9VTT4IOVTyjXm2BbLRNy004/T
 gldBz46oB2ZRJrhi+iscEoybqcvRCXQIZjlDID/K0ufjdUHQCcELS2AqcjvOWf8oWzPI
 wfKQGC6tXfVFV3TC3wLhDgUMy/04LF+bAyGERJP7XeIvXBEq2erGAD7LZL6Ybc8uqf5X
 wJzIHtEOz2DaAE2Kvrv3NcpUk5wG983fhSdF//baA6zfGH5skODqrYk1WE0rrX5x7wFb
 cBDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO2Ynu7OAv/mxiAaFKygQyATRSVOcxA2cyG6WMKdD0+u1YzmdFPpLa45RlqYmHzMinv2/QwRA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf3oS0IDxF9Qce355SVgexb3HMtv4Xm1GHF3aXj8beOBG4UYcC
 dkv1swnVnp+4kdqQRpkGila+ozUPZlPdvwl7chtaLQ/dUyC9rpeX+XX1G+YvJRMipcH+Ktq5b4r
 uROrdGLEiZaj4mPDTwmiMF+Gq1LXLN6tyaaTa4/y8
X-Gm-Gg: ATEYQzw4DX0jLA/yEeXoJKB1OFM+ieiIdYiex48w1C86IBIqUK4Kl89BzDvu3PytS6s
 brt524nm9Qc7TGITqX2LEhFpySkJX1qb9/ER1WzELK0vEgtVIPJR4kX95ad7EbqL3c92lYfezUr
 uy13sNjSaIe+/56bp9o+nPATGBH0ha22Uil0xPENJAWgyU454mYXGVv7K1OgVR9HJNwOMpihp1g
 i5x3moRl5uvAab7U+NenrhmkZQJ5Mxnb2orbIzahoFENKnfjZqBk7U8ObxUlV7x0kQEzLEci25e
 37BMAyCiUYEt67Zs
X-Received: by 2002:a17:902:ec8e:b0:2a7:9ded:9b4a with SMTP id
 d9443c01a7336-2ad7453d7f3mr103412865ad.36.1771869180266; Mon, 23 Feb 2026
 09:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-9-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-9-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:20 -0700
X-Gm-Features: AaiRm51-5y0zTQvkJ-CGuXSYKPCofzQ_nZ1D93TMLSDAzTQdxR_dwoilvks-yFQ
Message-ID: <CAFLszTjREwVXW+cW0Neburz2Q=QHnppUHSCxaKuXTJ_625H1ZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 8/9] test: py: vboot: prepare integration test for
 ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, u-boot@lists.denx.de
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

On Thu, 19 Feb 2026 at 06:27, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> The vboot tests only consider rsa algo for signature.
> To prepare the integration of ecdsa test, the signature
> algo is now explicit.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
>
>  test/py/tests/test_fit_ecdsa.py               |  2 +-
>  test/py/tests/test_vboot.py                   | 99 ++++++++++---------
>  ....its => sign-configs-sha1-rsa2048-pss.its} |  0
>  ...sha1.its => sign-configs-sha1-rsa2048.its} |  0
>  ... sign-configs-sha256-rsa2048-pss-prod.its} |  0
>  ...ts => sign-configs-sha256-rsa2048-pss.its} |  0
>  ...56.its => sign-configs-sha256-rsa2048.its} |  0
>  ...84.its => sign-configs-sha384-rsa3072.its} |  0
>  ...s.its => sign-images-sha1-rsa2048-pss.its} |  0
>  ...-sha1.its => sign-images-sha1-rsa2048.its} |  0
>  ...its => sign-images-sha256-rsa2048-pss.its} |  0
>  ...256.its => sign-images-sha256-rsa2048.its} |  0
>  ...384.its => sign-images-sha384-rsa3072.its} |  0
>  13 files changed, 51 insertions(+), 50 deletions(-)
>  rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
