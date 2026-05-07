Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC15CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 13:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB3E84AE8;
	Thu,  7 May 2026 15:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ePTVKXUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022B884A78; Thu,  7 May 2026 15:30:37 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26AEB84AE8
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 15:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bc188a20e0aso112342466b.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 06:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778160634; cv=none;
 d=google.com; s=arc-20240605;
 b=jkX2Ix7bwnwDSw/IWtgOeiTTxOCvkkLCn561NExZ7vhEyumJIbnfDpqilH+GrdlbQr
 ZbthI/tX4UtATrM0nv+S7sb2n/YLtSAHJUwz6yLGKywWGRpMAxKmDA2Jqq8rWd1VjCZC
 KQ0KHyxegMBHUlNv84iRGxC9B4njPvRncLm4Q13eCtSVFNUqNzt2Obk7vnojLgKlia3Y
 IVWn8S0iu/YE1+C6ttqWbN2BKZL0dorNYe11fsFgFJl6DsCS/IxORKcx9ENDaKktXDtE
 p9bpeg0M/UQpUbnqBAfMC2PjJWWaM4RRGF07pzSQT2DNSGOhd5gUBz31dj1kS/CN15VO
 V/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W3ugf3vh7fEYQ0+ewlPw/nnr4H/5P3JiL2+G+ngBvJI=;
 fh=Lwet1BBut5ur9R2NSYCMNJw+S6PZXZ1ROwp9lg8y6LE=;
 b=QfY/3R99LzwyC1L2o+PMRgy/2MSHMU75KL+LocsuLmrjxK7UnuIW5H4QdniGCMd/vH
 NJHj4hjoJWt494QnBiVN9Wp/6cmZtsyGkBEbsCOH66a6VGDY7+2J/IJX7hn6BflEtL1s
 iAFYCr0a/MFKXan1VEJ1Jd9vMAdFO8qpv/7TuiKwd5xm8z/ock0Em2ihpLX/mRf5XSNc
 +wqsYuGRUQzv5AVOk4aHk2HSCZhCaRvFusfDnb/KfkCuHf+xmp+l+y6t2QLeZhBIGZKd
 RkKGoI14I64/tBESOoRLHRVk6I8FhAM6YK06bB/HuewqZyFWmcI2RS0MBzU2wyyUJDFl
 HBqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778160634; x=1778765434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W3ugf3vh7fEYQ0+ewlPw/nnr4H/5P3JiL2+G+ngBvJI=;
 b=ePTVKXUeX436qPg9zbtzn4fIMd1OytaWWQ3mTldtxDZdk9pfGBtYbObmTlVW1ml5KR
 Cb6CtVFZ+GkIPHeZv3fM/kY00STn+epk+kvY/IJ9G8YEFRrIhjiOBJEuA43a/XJlx/aC
 J0MGxTTeV3rcBThUDwmMMzc93rFal4NiYCPB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160634; x=1778765434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3ugf3vh7fEYQ0+ewlPw/nnr4H/5P3JiL2+G+ngBvJI=;
 b=fNaZYT8wQ+6y8AD9pJpCeQ5ufsOSGiVm3TVHCfXPtLn+zMsfAD5qHvV02kEiRd5rLO
 CkvHCRwrSrpxhjEMgYb1HphELDUVrIsUzZ/6kxRxZbHmKM1beyjEmjfc+pk9bnJsx7Hn
 EI9eeD6cJqmOMf+lhybtKidnN/XV38awphvxHGftQf1DTas3LDtZFKCPRXKq8mSopXrj
 u0zZQd/i7SS0jlhJDg2/mgeae7cXZ+nW0LNaU0zcg/9sWaMb5WeoOg3JswFbqNrS3QDF
 Z7Svfn9Di1O5j6SjrP6LGaMSGcxx2arxwqA6sRI6nLpyemy0U7w0KZrGfhsi6E4WzgCM
 c2gA==
X-Gm-Message-State: AOJu0YwZnC6PFtSSMv8bQfLe7WQNPVe30dK2Ob0AHEkXVUFEbd+K1tnd
 wFnXcbQSeek8G0uqprLXlxTVqVJ1B+tSnxdXna4U6SUPf8McRK/IyJxSijYemCtvt+c1IAcP7Gu
 lvSLX83xWGbPakiDXPkktz02ILFtsrNuKgxeGtpC6
X-Gm-Gg: AeBDiesJXouVrVWC4komqQCSOdNkgTTOdes9MFZDa15u5kftqAmG0GIvuvQSz1pXgCi
 dejsq18ysX7YMAXyMSeeF4lLSS8m4lCE4HmxwbnuxlGdI8eS1AtrNbXxTb0jSt3aTPFuyMFcCWX
 5HaQXLMCAwzPmKx3ysC+dw8iHUDgqqyM8HK1M0Ht2s3CFRIPmO0oSRmd8/+Z8ZBZRMpY/zaQP6q
 oxh0VliJxnKKcz5bqAD1zY1vr1ySLn5y3KfpGt6yz204tIrFZNRNCROY5L7Fn6DbmtiJz6Yt524
 u6YxyzeBycQvJJVu+fTbYjIX2iA=
X-Received: by 2002:a17:907:9304:b0:bc5:111d:3c96 with SMTP id
 a640c23a62f3a-bc56b41dd69mr414669666b.10.1778160633887; Thu, 07 May 2026
 06:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260504172731.156719-1-jhaller.oss@gmail.com>
 <20260504172731.156719-2-jhaller.oss@gmail.com>
In-Reply-To: <20260504172731.156719-2-jhaller.oss@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 07:30:22 -0600
X-Gm-Features: AVHnY4Iuqm9_sScffCvxFRpYZX-ngih6CkC5DctZhnuIoMOKxEPmgHcBLWqpk2Q
Message-ID: <CAFLszTjDocxMsHM8V20dCxkdh8gEwVXfCV4FYwiBbqKObC4Oaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] binman: nxp_imx8mcst: disable configparser
 interpolation
To: Julian Haller <julian.haller@philips.com>
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

On 2026-05-04T17:27:31, None <jhaller.oss@gmail.com> wrote:
> binman: nxp_imx8mcst: disable configparser interpolation
>
> ConfigParser uses %-based interpolation by default, which causes
> PKCS#11 URIs containing percent-encoded characters (e.g. %20) to
> fail with "invalid interpolation syntax". Disable interpolation
> since the CST config format does not use this feature.
>
> Signed-off-by: Julian Haller <julian.haller@philips.com>
>
> tools/binman/etype/nxp_imx8mcst.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
