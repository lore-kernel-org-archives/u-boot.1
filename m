Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89085E8537A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 16:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD1F840B0;
	Fri,  3 Apr 2026 18:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GOEWAFgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC9A84154; Fri,  3 Apr 2026 18:32:04 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 293E3840B0
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 18:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6618bc129acso2807509a12.2
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 03 Apr 2026 09:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233921; cv=none;
 d=google.com; s=arc-20240605;
 b=Oa3iEBnhsNOMJi1Dz+3XLaFWtWFZByC3Tm9plLBCa7JliOgTpUlsWhMkrigO73wsur
 O7BuxboSJsTBFlO8vyZuajEIT4zRatqoypIiRzMODnzXEYgVhQv1eNDitBdVIKn4gTSd
 tEoB6S+J+0y1AB/eNxYkeLUgt7ggbHH9PiiDxqhcymDC3OvwePkR4DcqIaRRq+a2XBfV
 K9OdN34qiVrj0aEdhyOwe+2dxt+A76vkKsjnb2+jgZBCrUxdJ6gfMXrRnL2S133/VxGG
 9upeG0GytjVOaRPRks58o8hLjr+ma44sqEjAFukWp6v8SlWMlSrfDRB+SCzqS6XxG0xH
 L9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0y6p7uI+NrFE9aIOD1W9Ftz7FrcDwgR29BXg8sayB4A=;
 fh=ZlhOxTEOyhvR0HZcDrq9ltsPcplPZE15XgKDRn/JK4U=;
 b=OCC9/yj7ls5/iEhGGFf5K8G7Pk4GnKK3gDS5Ssxx0Uo5B16iXmM6MhAsCYdOgcicnk
 IbAMyFi2RS7wusGt8E9FItlwiq6KVjjLVY1/MTt8VTHQCi+Ecb0m8miCwME5e/3Me8VW
 i/sHBmeGY71vVouJ447qGqhMgtTGia1/T5Rh9Een/xy8IvbdZDduTPgYnHRoz1Hv5yb8
 vcqhMEHDBgl2kwTT1KMlX7fPfS+7x5BM+tqmJfQ9Pj3Y20bw8XvFlDpmebOGwdL9CsKx
 u1KZeRkIgmWaqkblYJKtHcJDo4STZgeHQb6IqCAxS6SS8Drj6GMJhSvFWEfsPFoEBq8k
 rtcQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775233921; x=1775838721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0y6p7uI+NrFE9aIOD1W9Ftz7FrcDwgR29BXg8sayB4A=;
 b=GOEWAFglltmyNz/APoLymEQvDDHVldDP2Srm/VCq4k+6tqmoetppZoZ8e1dMp3oCnn
 Sih2Qwu4XLiOa300pNIzRb8LAoZf8Tp9plUF7IoLzHUbXBB9HHLtfE/4Udmnu0oFUdre
 sUbHZxMB20Zo8ngZ/V0iEp5AhTBAHPARQq09k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775233921; x=1775838721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0y6p7uI+NrFE9aIOD1W9Ftz7FrcDwgR29BXg8sayB4A=;
 b=Q0ZTDYurR05hQMBW9tfNMgpGX+7mvrBNG7nVPcqBHpDOp5EqbcWke15Jy1d6A3x1sU
 cc+poeMDyapWvNozVcZ2FobLA7Hc1yMsBqOREJRlypU+yQCxtBI9snBmXt+5hdkUdryr
 NltYEQ7q0wsKXgqqCtWGhP4hmIWBP3jiZXsHUbBtXsLPbqCY9IA4wP0SCCwUdzkOOpEV
 LrmiGNnSzpLMD3r3iryF4niP+ndpNUu6JLbW9sPuo6onozetA8EYwweG+7IMmOfNc7FM
 x4JsIc1o8SdaZQttWArZDExGaehSWQA5kjpNEYHjhz+dN+TLb5v3VbMWuEoKoP9NsAnM
 UoxA==
X-Gm-Message-State: AOJu0YxTY+ajoQjs85ZNKU2dnIh1WlWGCShvMmRT63z4elZCKXkDrrzb
 0hgQPSDm9PADzNMVk7+0EB3R/typmbhWSfSdKSYv3R+vPyF0vfC+CbEunkSocg+pw3qXNTO/mKZ
 Q0Nz2ZGNXjVT8TlRL0Io/xj59eXic508UMO1aoVqT
X-Gm-Gg: AeBDieszXzTNZ6gpCo+Q1bkwocnfOo5vcH+n0sgoabSmpuU6BNlaB3oeYl832mIaM7k
 uE/U3jKRauM9b4s705R4Ewt7QvZdD7B1emxMZLVpNoqNgryD5MfBRANM5K6JR/KCaqx5QNKIw3/
 xwPV0QAxnM+OhgkQb1q6ejRHju8ZnXKg9TEDc4K9DVlC0Jv6aAyPKj/pRk5ZGSj5dNTfOicbtOg
 xHpvx0Acf5Zmv5rRDB51/b/dkZWoaEIJk233fLQRE5XlElv/X0BspZQYD2z2IgYVnbfP6Y9jdmW
 F/L/8P51RTmERhMX
X-Received: by 2002:a17:907:cf8c:b0:b97:e32f:7ee8 with SMTP id
 a640c23a62f3a-b9c67b786f8mr189641466b.37.1775233921317; Fri, 03 Apr 2026
 09:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080636.380507-1-paul.henrys_ext@softathome.com>
 <20260331080636.380507-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20260331080636.380507-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 10:31:49 -0600
X-Gm-Features: AQROBzAXEXstPWeCKs4OgwPbSXQ0M3j8kQCmaLLetC4Ek6Wa0EG9617QnVlVkG4
Message-ID: <CAFLszTiz3w9q68DAMKZ1TSWrSbz=GSVuGCSAOB6p1_U=TO_=dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tools: u_boot_pylib: ensure all Python modules are
 installed
To: paul.henrys_ext@softathome.com
Cc: u-boot+nodisclaimer@lists.denx.de, sjg+nodisclaimer@chromium.org, 
 u-boot@lists.denx.de
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

On 2026-03-31T08:06:35, Paul HENRYS <paul.henrys_ext@softathome.com> wrote:
> tools: u_boot_pylib: ensure all Python modules are installed
>
> Add setuptools package configuration to pyproject.toml so that
> u_boot_pylib is installed as a proper Python package without changing
> the existing flat directory structure and making sure all modules are
> installed.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> tools/u_boot_pylib/pyproject.toml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
