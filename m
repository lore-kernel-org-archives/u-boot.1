Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74241F5A8B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F07843B7;
	Mon, 20 Apr 2026 21:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iHCW3I0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB397843C0; Mon, 20 Apr 2026 21:51:32 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE38843AF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so610129866b.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714690; cv=none;
 d=google.com; s=arc-20240605;
 b=CGazT2U4Zf0vJs8yTOdjdxyPPHQkyvPVLkUgmLJm7AQPMcdc9Og1w0Z4nanJfo0FRd
 6BdJvCzG/KJ0NXnQn86nzAvRnUyr4wZl1rD7EhvodoKs7ev6cn4JJDIVmlM6TnaPHjNL
 ePz3RKIfl3XKuvteQIqEmP+YrdiYpaNe4htRYVxTsHGrO3AOs8LUUcCzk4pPmPzE4i8i
 cAoJ39s+q7I4sdZahcrdfUOJUcvY6LUPlxdbAPUhj1pq51CebiUnW8cUcCm49p4MZGmc
 QrvKCL4SkTOgfjRfun4E92QT5wcHWyQWVidfDheKJfFz9d/5q05blvy9TbDkeAs0hLjt
 6jaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u1omAFqFi+0eETOiT/2+mtdos4MUmPqH91EIyV8bYFM=;
 fh=WOkCmvJdQVnxlczYZTGpLMgvazjjyk7tMvFjba9XDSg=;
 b=OZ8r/6tBWIIoDWQiZ0wNjHllAFL1gy7ScF6wO+9y5QGfyAHq+XEo9/MvmzJ/hhrB7/
 0SFzl3HKJNjzij6+k0emAa8JpAOmbYhKp6rRnWLfNmQSY9bXM7S6TiqAaNepARv56/VN
 nB4Y2ojYDvrZHSsUnrT320GjGOMQJkV73zjfXU3OT04dvqc+mNQ4kwx9GdUR7blMFRAK
 /gONQ2JJTA0vP87BaO9dcNru9mDZir1XhFShh0OSLxNgXCtxYj5myZZ/uyKpHxOehA16
 ZyIjxFcrtFboNNTfTaSMGk4AZYqugKR2nkYjjmP28mK4gO076PK+r3+Npz2fpnfnyGcZ
 M2wQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776714690; x=1777319490; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u1omAFqFi+0eETOiT/2+mtdos4MUmPqH91EIyV8bYFM=;
 b=iHCW3I0LMpZ/Y7Vvc4nnDNo1KZBFI2lCx3GypYT3f8L84Fyrev5fkRhXlxiYBG432a
 OIWiy4S2c8vgisenDcKeMvK5GF8NDik2pqKh55nHTAbeUFoyKD/ndIrqe34XxRQ71xt5
 9/r75Xv+3ys+xRmu0ipC18ur80lPOJWx4vRew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714690; x=1777319490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1omAFqFi+0eETOiT/2+mtdos4MUmPqH91EIyV8bYFM=;
 b=E8Ap0tjH5/I8wpGelnGH9FNYFnm/xnlPCpxfoHg0sY5pb+VxYLkSdZiQCyRNsv2uwd
 qWeUK88RRrynBL2eMBO7vNEFPGxXZWUL9w5uksHb+Ex2WXvPCK+6cfFwb16ngDLZSNzZ
 J7XTkxDkK9ttScZRn9FgVhONllyEh2cmTs9XfQLTBQtJnqxKpoeGjPTen6IUxHOzPdLp
 f3HoxEGkHoU+MtYhaHUWZUvDkGSbrfe7yBta7eUJk7elwN5aykOQGqRzLu9wwDlbEkYu
 glzUBhlCvdb+lb5pq3KYsmFFcoD/eydRnFhluIG50sEo9gBepT1gDWtezMpYgg7lYWBl
 FB1g==
X-Gm-Message-State: AOJu0YxeeTUFVN5i2GitIwV80eVGSIDyW3e3nb9T19wJ7tdPhAXdb1Wc
 r0ww2TBZYhmg8yadFDVTfr7RRLpuiL0B4wttaRl+KwErFGy3uPDG8Vvvf1DekAyl7t/1u7LkIhx
 a4CbX9ycueQUFGS1dRxY9pIwLgs/Pl/Tkvl6Psm04
X-Gm-Gg: AeBDieuLQ3sXAwggXP2l3OJyVQDnbmIBwcGcuLtWoU8VV4LLgyG8F7UxYYuQ3XDIbN1
 2+P/Bux+NP11k2Z0GjJeKhV6nt+odLf0M6kUDDOZSd983yj9YvbzoO8pDisIHkQLkJOH0U29CHy
 2rfjXsfGmJIgroc8/EBknrLfOuSKYCPbsNWWiJUG8mwg74MEAEZiYnc4940eFY5T5cip4oZbeYH
 hBEgfUcP+VUl3EbOW/M9/FGHFu2f9y4rvRSxgiPxvItQdV1Mvk2vepzJV3CHr987fn7QCi7hoym
 yq28uxJnEW8hnIgGmsyB
X-Received: by 2002:a17:907:3cc7:b0:ba6:a05c:ac41 with SMTP id
 a640c23a62f3a-ba6a05cb521mr385759866b.9.1776714690201; Mon, 20 Apr 2026
 12:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:51:16 +1200
X-Gm-Features: AQROBzCnpRoEF5RIVorJdCfCL6j-zl_rA_QgpKWuZcs8_dO1tBl8tWvT1-dk1Pk
Message-ID: <CAFLszTjTSUOy9=d5NpgsP63dQp7UXuhpqg4wFwnXgWJzD74_6w@mail.gmail.com>
Subject: Re: [0/6] net: migrate NO_NET out of the networking stack choice
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de
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

Hi Quentin,

On 2026-04-20T11:36:06, Quentin Schulz <foss+uboot@0leil.net> wrote:

> This series introduces a new NET umbrella symbol with NET_LEGACY and NET_LWIP underneath.

Thanks for this cleanup!

Re SYS_RX_ETH_BUFFER, how about moving the extern for net_rx_packets[]
to net-legacy.h ? (is it used with lwip?)

Regards,
Simon
