Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91D5C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6346E80CCE;
	Thu,  3 Sep 2026 14:39:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EGzlzLORqe61; Thu,  3 Sep 2026 14:39:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 92A2580F09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446365;
	b=UVtR0rgm5Inv1u2nNvoDmhhSPH8Rytz7Q3a8xEhciBrlyITHUdDWA2G6SIPI4nGZfmOk
	 GAN9Lepj5g6G4EqB6HnFcnK4iRngpbOIrrcQeHMvImtSk6CI2TJ5GkVyOjwAMnfASDrOy
	 t24yu/wYWO0H9JNeEye8ctJ+92UeW/I6FxXYbCVCxXFvV8RGJiYqNVPF30lQkgJ2o7pLV
	 2/+BrVR2ZTZE0dqS6Z57wkADO38ZFbsWo/XmBauHJYpOV5N/FEYA4t6w5Hp+js5a04YjY
	 GYvPCUjP0mwZbpt4QVAmWs6iaY7mrk+ywjKJvHcSYX3EWSeTdtvJksFAf8LrfwACwxA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0zmHCA7PrTZBz1pLmeS87V1FB5DIsVjMOnypxyogQUY=;
	b=eQCR8litw8BNaSTS3lNJ7rpKlWN7cq7VYV5wVgNhzaVY6iVMBeFCmV9Nnr2rqw1b2IT6
	 PT+qhCIdgFBTG2/a1ywi75RGyBV4CYM8qt0qu2vY2Og12ucWkfwTO9SDwSv+j52JvIrrE
	 h4Hn1s69c9u1nFqgNk9fDZcBpssCLlZB3h5tvfl4gk8rbdMyu1bARHoTEJzyzIxHjRQct
	 9sf+RqAqjdkOwSHIeYqMWME6u/tWQCdJkbfaMfJGsNJ36A8wVtVXnmcFO9MdMamHIQUaB
	 DTVJjrDTUOpEq6IAdBj9xLOzivF1mN4WYXXQ1rIfPtKV3AjCWvjPKQOzT/xm0Gh1F9w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446365;
	bh=0zmHCA7PrTZBz1pLmeS87V1FB5DIsVjMOnypxyogQUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ijc+OGFYhhjsK4wShaAC9bOIDgEnu97fiLAcIoiyRJ4AG6qgwDJ4pBYz/7BQXlzN1
	 dwDUl5Nkbj4hgLJho8D74dWs13bPpvHmLXhhOhPRi87wp9IpYZY++NvlmBgPEdQQdz
	 Q75Cp9X3Z1xilxiLpEpyqqISLB6H3t10p7klWQ15bIF98aNvwBvDPplQ1plpUL1uFY
	 Lnl4FCFYGLtetJs8A7F8aB8wXAJrEEMlUAL9DcfL1YznI7Oz1zp+ZoU6eYuRCKejXF
	 75khgUdvY+qxLQYyUWx3XWVHCc2aMRgzRks42JToSOZsMZbtV6nDohSz5EmXvwG+cq
	 pk/hsufmEruXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92A2580F09;
	Thu,  3 Sep 2026 14:39:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 040B7498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEC0440A34
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_1qqTf61WN6 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0AD2D40A30
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446363;
 b=nuzr0IDyuv1mwZs5s8PLrw++rZhBqmnuXMtrvBiNS/ixf5xZ+QG+5F6yht0TdmQpXXxC
 FIpcvpmMMNbz2E/N3xcHPTJ0SxAD0qQcYCiqlMZzCrHKF2f0yDVHuX/W0ccky/IH4Rndi
 lPLXyyPUJuqwLRh2Bj4g+MAh8jeEyehmR46IWP6JBNHBGSw+Qa2g/4ESmqETgnpNiRF+n
 qlbRRkEfUnFWrEKsP1KHl4DtSB6q8NgsqP74pyri0asKHZZn6mjJkgKkzU8zUYkUc9xfG
 WZ86XuhQ4ykTkBrgcCCpYk0Tim7fZVY4i5g7DzvDKTJ7EYeD3dEwdCfT1kcNxsYHjlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446363;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=0zmHCA7PrTZBz1pLmeS87V1FB5DIsVjMOnypxyogQUY=;
 b=GG4IOqxaDc5sKzCWgL9m3fTEDmFJQpwaPUW6jFO05WVprachTUpzTOfy7rhQBbwP6fad
 ueyWR3MrxdFAMeUr9UAkT9lF7nKW/W9u7T7sYtrB3kzJeSJuB+iedqhc43qOOC1VoR9MX
 VmU5y2NuLAoqhydTNatD146HQiC6u6kt39uMq8MeL8JhrXjqEqJz+p+2kv+1xsi70FqWi
 fxvV8PWdQeWIhCG+GPNgLEFf4Mf45vg+qbVhZC1C+tUukh1HcRiFbjY7hf6aiaA5Q8SCA
 BdRQESpOzrOcKMzDxq9/MuwDkyucF1azTvfQnyhq5yuZwKWVX/sotRs7iaoAXSoUAlw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DFV0NXfm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::a2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2a; helo=mail-vk1-xa2a.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DFV0NXfm
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AD2D40A30
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:39:22 +0000 (UTC)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5c7afda4515so1416474e0c.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446361; cv=none;
 d=google.com; s=arc-20260327;
 b=iDFfFjTMnXAbYqLT+hhtYnIL5lIihVqO8NDkiAnkl4OXk+AW7eMeg/J3NTlVNiDK1r
 Qi4SfYuHMyOfkh0zuLn9KPvrUffQkFHXEdWHLA+KUUBjwN7DeKggPcukjwAV66K2sWkk
 8cpkYLNL6v1hMfs+1IA6NEZmZ5tIfRnzsdXIW4lzwUcWqngR7lrOzsq/IcSRX+dPu/wS
 O+g5IXTG+y49rlq+YWnLeKHtZXB2Blu2xyMZxBEjK2ThJB/JcAAbFkNdtQ1jtDeitsbJ
 I6nfNFLDxProW0JQnWCuYdHKyq8JoWdk3WeIedSyF0sxBDcUaAJ7+cR87w32GT7XZaSf
 DiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0zmHCA7PrTZBz1pLmeS87V1FB5DIsVjMOnypxyogQUY=;
 fh=serNXUmmQpKBmfSdCiiFTo8afwsCnvn4akhnhGc5m0E=;
 b=VaZ/0o1BMe8eLx8sylr7O2vVfn3GTCs6FWEUcBSZRtgz0lKu7PycU9ufkJ13FA3hjG
 17NbrDDgK472FptHH+HCs5j6nmv1aZ4+DGO3QuJL9R6tW90nwroqgF4IPCXVQSpCIbA/
 qYUim9Kcp9QX0X0JI2bmdXRj4NEyL0Cmz1lFKIChwfAsdv4qyiqJSPUsPwEr6Q+pDVIU
 7ZUzLKzz2WAIOLta6a9JhY8Cs6pNv2WGOCGvTRcF9hqaaGfatRuKS7UUo2bjOicyVXeH
 r8tNJWqKQMrls3RQiBULZQ81S1OFjx3hCSXVtFtquvyIDmMr6d8AxntVloFwbiNaF7ro
 iztA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788446361; x=1789051161;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0zmHCA7PrTZBz1pLmeS87V1FB5DIsVjMOnypxyogQUY=;
 b=DFV0NXfmUzCcHyYWX5pTf+durVqvzIauJc8ADinZ35ycUYD1uABY5CnSebi4eGPoB6
 ojwwXfum33egr89Rdk40Ul14jq4IzTHrYKFklbCNH04Q/CZQemmbBFC7xrRfdC0nOyEA
 dIxEU+FTq+LlxRg9sPcILcqa6E8Zq3AVDYyhjrpaQUXkmTpH+rg12kngdQfWat9x/Riu
 Fo3a1W5hnNBuplBVnib5LZn0eKX3we5mFm+BdVn1GZlRahRW1xR70jaiSRoKiw2Xyc6f
 Y7g0qWKMIk/uWPPOGcRrnLyW8BCSSxKXHkXLKL0rkTkQNfV1AF5zd+/gzffYJ9Sm33bY
 OLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446361; x=1789051161;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0zmHCA7PrTZBz1pLmeS87V1FB5DIsVjMOnypxyogQUY=;
 b=P9X3D+EsPb1FElXZ1anj92NADRsNSbS0tNMhS79vqKIWmsP1w1wqoVqIPbIYvourOP
 pSBhtmS+HXyEWaJJP0S8RpREVZ+iqSn3lDBH/YkGwYW/TcaFs6nHBn8ZfOzf1pd7fkiJ
 17IrRmRpl6w+B2kMinvO3BlDViDtntzjJQRHrpthYlkhaWd67WvAv2oZgDHcLWXVWY3/
 KKdJogzCJ4tVtQ/Lz6GFwhWcLjrHerHnUcPWchA2ETll2fa1UqBnRwrA8mV7EuMj85Ua
 I3M5SmA10WknCm/wj/OajQbyUyDj6i8l2Xw2Qua7aCMOqr1BqJTJKKwE6O2pMnqTbGJd
 eldQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAWtVeJ2mwWw9RcACoWrSVTTUhtqsEbEtgo2RdBtzpAPOd0J4Byh4fRPdGH0YcSGu/xeHokT8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lQcPYQtvyuNeApe/xRTwioGKWRmwYcIZ4fTmeB4zaIsghyJmZW
 kqp1Tt17+SriBlwHLmze9RK8zM43uQ0TdZ9E4IDwJu22PzuCCpfBadfJ3Z/Iv1F+yPxIxZcI+D4
 4A9SSg50G5EXhQlUM27f3eDenetlh8sc=
X-Gm-Gg: AYBFou17xT2ME9TKURSER7bARqDb7hXO+G32VhMHHWXqaIHru9Qga4gzKpFB5lYzYRG
 Yr3oeXs6FHUTJ690Rwmz/2d+1p4s+4YkOaDfq27s7lbY4Mm2+cHxqQmXEEk1Wiwe2NgTuH1h5c0
 fbJ/J+d5m5W0Cmi/1lDZ10UopJ9GFVJPH07awPMd3VUpJ4vt0S0owroQoEaCh6DczAfPhIsysvH
 RgV+GSoZl6X7NixbEG1eb2mAuH9uqiNNdxz8ByFWclPhOX5TWNz43Wl7trwWjg4opHLuxTt1/jg
 H07Ptyo4XkHwZW2pekQgTFKQjDsgINUa7w4byUZuny/PuRE=
X-Received: by 2002:a05:6122:d28:b0:5bd:81fc:ebe9 with SMTP id
 71dfb90a1353d-5c7d23ac451mr5431101e0c.0.1788446356899; Thu, 03 Sep 2026
 07:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-14-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-14-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:39:04 -0400
X-Gm-Features: AcwNN1XaHwmn9o1bhMNT7joiVvGzoUpmxFLRsPbE3wrp9aOFdwH4yu4KtnSIeOY
Message-ID: <CAMDkj5ywe-6D8CTU1HXG=XjdEGud9c-rrpP=0jjfQ6d292UtUg@mail.gmail.com>
Subject: Re: [PATCH v9 13/15] tools: preload_check_sign: add support of ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> right now, the tool preload_check_sign may only
> checks an image with a pre-load header with rsa.
> We add the support of pre-load header with ecdsa.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - free key to avoid mem leak
> - fix error management (set ret before goto out)
> v5:
> - add include ec.h, evp.h, err.h and image.h
> v6:
> - no change
> v7:
> - no change
> v8:
> - no change
> v9:
> - no change
>
>  tools/preload_check_sign.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
> index ebead459273..d94f0509e74 100644
> --- a/tools/preload_check_sign.c
> +++ b/tools/preload_check_sign.c
> @@ -8,9 +8,13 @@
>   * complete file. The tool preload_check_sign allows to verify and authe=
nticate
>   * a file starting with a preload header.
>   */
> +
> +#define OPENSSL_API_COMPAT 0x10101000L
> +
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <openssl/pem.h>
> +#include <openssl/ec.h>
>  #include <openssl/evp.h>
>  #include <openssl/err.h>
>  #include <image.h>
> @@ -144,6 +148,32 @@ int main(int argc, char **argv)
>         info.sig_info.key      =3D info.key;
>         info.sig_info.keylen   =3D info.key_len;
>
> +       /* For ecdsa key, we have to update some values */
> +       if (EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC) {
> +               EC_KEY *ecdsa_key;
> +               const EC_GROUP *group;
> +
> +               ecdsa_key =3D EVP_PKEY_get1_EC_KEY(pkey);
> +               if (!ecdsa_key) {
> +                       fprintf(stderr, "Can not extract ECDSA key\n");
> +                       ret =3D EXIT_FAILURE;
> +                       goto out;
> +               }
> +
> +               group =3D EC_KEY_get0_group(ecdsa_key);
> +               if (!group) {
> +                       fprintf(stderr, "Can not extract ECDSA group\n");
> +                       EC_KEY_free(ecdsa_key);
> +                       ret =3D EXIT_FAILURE;
> +                       goto out;
> +               }
> +
> +               info.sig_info.keyfile  =3D keyfile;
> +               info.sig_size          =3D (EC_GROUP_order_bits(group) + =
7) / 8 * 2;
> +
> +               EC_KEY_free(ecdsa_key);
> +       }
> +
>         /* Check the signature */
>         image_pre_load_sig_set_info(&info);
>         ret =3D image_pre_load_sig((ulong)buffer);
> --
> 2.43.0
>
