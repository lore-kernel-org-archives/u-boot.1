Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923E0C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50F4781106;
	Thu,  3 Sep 2026 14:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xfQRzA1Gl909; Thu,  3 Sep 2026 14:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 684648110D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446199;
	b=G7kRysWvIIlb7Dv6GfL0MFEQ3nM3YWc2KejMYQ3tB+nnDyyl2pW3m5fLPANnhfPTVh0T
	 ngr+5yFcNBufrwyNw/t89J2mws/PSJJCLHyR3WYlqeV2L6qw0hkpIg4g0x7bcFi0SeOaO
	 y4Qz8b+0DfW2JDzTHJFRpWJoZ1OiGkNSeFefAXxp2GQaYElp77x78P764qkyp/aDc86sb
	 4XZmcLNDhus9cx4/njxs66MgX8SQUDYXyiiIWhvrp3XaTQHFyTSN6tu1aA42VeEuBnQDc
	 qbt6dae+R7R8D0PXHGDYj/umchCaAYF1jov8s7Ett+eoqEaxJ6oSFg4GqJ60NfRCAqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hUfE8E74r91GzzwhWZro26tBhXkaNdDuaUPLR/QmAT0=;
	b=jZW7Xw0Rm82brkWeKwE6YkQdaS/fiP2suMn0/uyrP44tW5cVQrysjTc7dG+njdMdSJKr
	 OQcPIULMDSl6jlu1xbhdapTHpBNx5cwDqiZMhlK2xZa6uafimKlF2GLT9lsRUdyM6Jm7n
	 W91ZQS7G0Rqd5PAXQSbI/AqMI422QzB52tMXVYtuqNQQRv4as+AaF1DS37p8XUqpwOs1W
	 C8OCnrFxgrFe0HPZ2GkTAtI3c0Zc5q+5hfzE4LM4rdv6uzo5PsbghfZK7mzfHKj9XjYd+
	 OKuOGXNjZPc2y1Rdih87M+PyxiDybpLzdvbHo6xuRRTGCwgvWuGOqhXV93d/PfC+ZLQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446199;
	bh=hUfE8E74r91GzzwhWZro26tBhXkaNdDuaUPLR/QmAT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0ekVrONDl+fDqUgdAAUj8hHNBA3XbfG3oR0GsW0jBaPYo5ooEH50Xpc7zU9Y62/lF
	 NYtpK98o+ZKBbtw77/uDvKL4jkhsK8wZMynjbWsmUBM4UVZdx1me4Lp/hqATp/7hnO
	 5iDGAkLvKCtuujvYQdbpU7ohki1trIzfkC3wqYoMfLCiWKcF8ZrR8yjMdSnMxpwEQM
	 3YZXtlSrWyYo008+/SOoFkk12PABHP8hneMKpaoskt5js9QlNClAEP78U9d3eV/IxU
	 QEo+yJ401kzKK3Z/SUzeLTgQeMqnOL8kCnDmV79p9bfaqVeQSe+4RccKN3wUOyIv1J
	 AKwXX1wxpbf3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 684648110D;
	Thu,  3 Sep 2026 14:36:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6055279
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC45740AE0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErrDOynuNZWE for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CBECF407FD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::930"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446197;
 b=N6D2I70PRPdRf8ZvU1Nr5IGRXGO+FDZ/6/atYwWQW/LsQ+F1SO19Fn5E7+fvypqgehnR
 2rn2RSc3JPoWlfy2zOkRvmPtah+3MA5rDJi4SKYvGhLQcQxeFd26QwOpgxg0Ouu651/p6
 objL5qK70mRr3SpEXzUuCk3lv14koPLwasOXnhWske6VEX565wmC81NFJoys9esGZ001r
 dYISNiMO+yiFF3z6gNYBmphvfSKPqY/BwRSp1GH8aYlLP/V/efNM+jsQ857gunn0nyaVw
 dPcpJ1DvxhRtQciXg+9xP1IGAl2ksgxFyzSVJClyMnZsJ+LgdWEKbKn8pO80snrmsbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446197;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=hUfE8E74r91GzzwhWZro26tBhXkaNdDuaUPLR/QmAT0=;
 b=YytylTPW6WviyTek3C4yXv8Dyyd52OAQXwx++k7kxB0i3118ppl1pjVP+91+/2B/Cc+y
 HxRDKqxSCaZT3W1EDFuEpYhczGfN1oH4E7A0ounvTkp+KppBiCsa8YPxaVCzET31cMDkF
 HPb562nQRQV02yY12+Pk6tkWvU62nJozHZo2bGVDh4D0qOCtTwdj09Uw6SR1JpzlUteN1
 Wct6oE+361NAiA4qtZhbVsaDQmhLFqvIvu/QQEkANIxCpYh24pEHoME43MYcJGkrS1KYP
 x0YSblw0GrZGuKCeTAq0559U+Dx/0IZAgwRnSAjHS0xChBwmZwKf7bU6FWVhSdWlqDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=I2ApJLxl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::930"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::930; helo=mail-ua1-x930.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=I2ApJLxl
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CBECF407FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:36:35 +0000 (UTC)
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-98084f8ab1fso280064241.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446194; cv=none;
 d=google.com; s=arc-20260327;
 b=Klm+OUBXG5QaIacm2eGXKiCs+XxABthMBoKesNfGs3GOuUvF23H9NUV0L5Xc4LTSCb
 ZxZA32OE0qlQqQEviNO4nEFHY9mOxWhp0EW+n/6ZQliyyjc5LNaLj5AM60AbyFZLJjAh
 04qzceJkrEG1rYeeiOE5+OMyejf1rpjdJBur65hGcEkq3asUxtpIVLSlvul9eIhrSKSO
 IY3puX3fTIMJDYW6V4tfa7DJTaHOSBMovBthLzhRHRDyhB0ravqOJgT29QYYrxRTdhCT
 /Y5DlPVDgDAYQs0DyNnxE8YXv17tPcjGKQ4DgcdAvPWHAaYgFLRC9KKjQTjT4kvX6s8T
 uGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hUfE8E74r91GzzwhWZro26tBhXkaNdDuaUPLR/QmAT0=;
 fh=UfRoWLkG94s2KGZc5dXIHQRS/hTwyhu2dcv8QOsSvM8=;
 b=HNhcjTQbmHpQQR6Eeuj5LMyrJb/28+u6Q9bfd99sgJgkaIVPsrXFAAIYCdOHack6hG
 U0zU/2KSTjjPKFVgU7sKkwEVgRLhBuUfSFbdRBjnO7y+bSMBH/RaYZpp7Ma4YC/+KYCJ
 EHunUzU6GfqacrRZUSsoUYet7zZKW/q3X+jUm4hetM45ne89hP9ax1sCrBMe62utRYQ9
 y/Pn7VXjNspKBMz3uFDir4vNYq3nh9pGso+Y1Jur5+v4JJmt7TpxdEqEMdKkYiUp+HJQ
 2xNu4EgY5S+P8+Haihm8oUkhPZeU+bSiI3z7Sao4THt88ZEtPdX+Y//Ru4l+sVNhpHOR
 yZLA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788446194; x=1789050994;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hUfE8E74r91GzzwhWZro26tBhXkaNdDuaUPLR/QmAT0=;
 b=I2ApJLxlKuuPC8sBDC2b6WR1bkOD08D0uQfpiGqQlQVee3WMkXB2PkN/9ssNIZwwgY
 M4pZOfCzzplZmU+p4UFw8nOZAgPG2KsMxG1iZ2BJ9ifSlVyNCKH4x//PdFcY/cehBDNR
 SrhyvLe1y7UvVYTkIH4/OIHgrkG50AnpEYTlgDtWyWN54BhaWhoTh6FfIUN669NFnp+I
 nB+UvUuARBq4gi+Cyr9f9PNt5J5F9IxLM72YG6pUpCYKmsNEhTx+JnL57IW2mcnXj2cN
 ob1y64l0Ls+LAjusHcm4gadD8OOAKvmFN7uzvEcVUvJIIVYFTGXoozy9/On42zL+QGYu
 MHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446194; x=1789050994;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hUfE8E74r91GzzwhWZro26tBhXkaNdDuaUPLR/QmAT0=;
 b=pWQEv0n95NfbZ8q4TRUiVey2HOsr6uNoD0XQhB5tNlsHpRLBum9gvrRf+4zvrkGqLv
 42UxaQpBZqPrEtpxJaCDa2zatF9nO0SDJ9no5BU5RjaHpPq1WQt4ENsv1O1gjxYr2Fc0
 Snt1PyTuMCLahHEdRiHA8LGsOxedIbGKd0DCb+0+77z9FI5chEgG+1YH0yvItV1a61FB
 HjCcRM0pkvQkRziLrjjC+jJKMk1b1tRgqXOAaXwLWfzzNa1tMGnH+qbDtlwPC8N5WSbq
 0RpicLtQmiezCQ55ljzUNQe4ttyRgDdcWWWd8BEtxlQbPGqG2IrsUgnflpasFs2kdN/H
 Ks1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ9tOlztaWEpwmt+qE9P5Hl8Bz8BLX3iQG9LuZU01yB79xoWm+5ngenpWauhwtfHdlPc5fnD8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lDPRuClcxBZb873pzF4exrkqN9TgI/iSLgmhPSmnoXkDatCJOo
 gdRePYIcvKuZ6qJ6mLMEDp9ArXePNIcm1XDK/5q3iVUchDtjeIsX+L5nr5hUEiu4rAbATWFBhlG
 Vl0uaBAT5S3uJz6Qe6RIPmW3OM7CWL4Y=
X-Gm-Gg: AYBFou1snYlTqrOeQ65jkKnUw5BT0m83ZeKsu15tTy8Sv6SsmX/kwKYCM8I0wV7r4qp
 Y9hPcQ3+XVE/TVZIqUduH1zGoFN8PFR14MzSyTWLVG4KHHNz2KHJufFbZtEUUxoRyvIfL448IXs
 9mb1mAFaraD24hsb4XLzF4UIpNbi2ACwpoVgLrWtFS81B7Vlc5B2JLhqaWSTKoEkUMgT2+AKCws
 LPvfxyT1NOwrKVwEW1SZeeRxEuZ+duCBRHFg5YG1EPHfgdnG6BKZ0pNhIHsWr2TeGkRsnvB0onc
 MivRsxpZuwEWOoeAH0uO33jr7RWtO9xudTr2xsMPmoFm8t8=
X-Received: by 2002:a05:6102:8084:b0:779:c38e:de53 with SMTP id
 ada2fe7eead31-78a1f36fe00mr6082009137.10.1788446194331; Thu, 03 Sep 2026
 07:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-11-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-11-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:36:22 -0400
X-Gm-Features: AcwNN1XmE_hh5RW4ssQEdxNZMTDzFUIgQauXM8SgPIYC3vvN_lORZk0xNd_VQes
Message-ID: <CAMDkj5w_cXggR2L9Juyje416Ezb7Xj1Ktj95Jn7eWerjq=oWXQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/15] tools: mkimage: pre-load: add support of ecdsa
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
> Right now, mkimage can only create pre-load header
> using rsa. We add the support of ecdsa.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - use pre_load_noffset (do not compute it again)
> - release memory allocated with strdup
> - clean code
> v5:
> - check checksum and algo before using them
> v6:
> - no change
> v7:
> - no change
> v8:
> - no change
> v9:
> - no change
>
>  lib/ecdsa/ecdsa-libcrypto.c | 29 +++++++++---
>  tools/image-host.c          | 92 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 103 insertions(+), 18 deletions(-)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index b3fc75fac48..5e69782424c 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -517,14 +517,9 @@ int ecdsa_verify(struct image_sign_info *info,
>         return ret;
>  }
>
> -static int do_add(struct signer *ctx, void *fdt, const char *key_node_na=
me,
> -                 struct image_sign_info *info)
> +static int search_key_node(void *fdt, const char *key_node_name)
>  {
> -       int signature_node, key_node, ret, key_bits;
> -       const char *curve_name;
> -       const EC_GROUP *group;
> -       const EC_POINT *point;
> -       BIGNUM *x, *y;
> +       int signature_node, key_node;
>
>         signature_node =3D fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
>         if (signature_node =3D=3D -FDT_ERR_NOTFOUND) {
> @@ -559,6 +554,26 @@ static int do_add(struct signer *ctx, void *fdt, con=
st char *key_node_name,
>                 return key_node;
>         }
>
> +       return key_node;
> +}
> +
> +static int do_add(struct signer *ctx, void *fdt, const char *key_node_na=
me,
> +                 struct image_sign_info *info)
> +{
> +       int key_node, ret, key_bits;
> +       const char *curve_name;
> +       const EC_GROUP *group;
> +       const EC_POINT *point;
> +       BIGNUM *x, *y;
> +
> +       if (info->required_keynode >=3D 0) {
> +               key_node =3D info->required_keynode;
> +       } else {
> +               key_node =3D search_key_node(fdt, key_node_name);
> +               if (key_node < 0)
> +                       return key_node;
> +       }
> +
>         group =3D EC_KEY_get0_group(ctx->ecdsa_key);
>         key_bits =3D EC_GROUP_order_bits(group);
>         curve_name =3D OBJ_nid2sn(EC_GROUP_get_curve_name(group));
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 9a85a3dda2f..ed1bfe68a31 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -14,6 +14,7 @@
>  #include <image.h>
>  #include <hexdump.h>
>  #include <version.h>
> +#include <u-boot/ecdsa.h>
>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> @@ -1681,13 +1682,74 @@ err_cert:
>         return ret;
>  }
>
> +static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
> +                                    int pre_load_noffset, const void *ke=
y_name)
> +{
> +       unsigned char *pubkey =3D NULL;
> +       int ret, pubkey_len;
> +
> +       /* Read public key */
> +       ret =3D read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
> +       if (ret < 0)
> +               goto out;
> +
> +       /* Add the public key to the device tree */
> +       ret =3D fdt_setprop(keydest, pre_load_noffset, "public-key",
> +                         pubkey, pubkey_len);
> +       if (ret)
> +               fprintf(stderr, "Can't set public-key in node %s (ret =3D=
 %d)\n",
> +                       IMAGE_PRE_LOAD_PATH, ret);
> + out:
> +       return ret;
> +}
> +
> +static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest=
,
> +                                      int pre_load_noffset, const void *=
key_name,
> +                                      const void *algo_name)
> +{
> +       struct image_sign_info info;
> +       int node, ret =3D 0;
> +
> +       memset(&info, 0, sizeof(info));
> +       info.keydir =3D keydir;
> +       info.keyname =3D strdup(key_name);
> +       info.name =3D strdup(algo_name);
> +       info.checksum =3D image_get_checksum_algo(algo_name);
> +       if (!info.checksum) {
> +               fprintf(stderr, "Can't find valid checksum from %s\n",
> +                       (char *)algo_name);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       info.crypto =3D image_get_crypto_algo(algo_name);
> +       if (!info.crypto) {
> +               fprintf(stderr, "Can't find valid crypto from %s\n",
> +                       (char *)algo_name);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       info.required_keynode =3D pre_load_noffset;
> +
> +       node =3D ecdsa_add_verify_data(&info, keydest);
> +       if (node < 0) {
> +               fprintf(stderr, "Can't add verify data: err =3D %d\n", no=
de);
> +               ret =3D -EIO;
> +       }
> +
> + out:
> +       free((void *)info.keyname);
> +       free((void *)info.name);
> +
> +       return ret;
> +}
> +
>  int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
>  {
>         int pre_load_noffset;
>         const void *algo_name;
>         const void *key_name;
> -       unsigned char *pubkey =3D NULL;
> -       int ret, pubkey_len;
> +       char *name;
> +       int ret;
>
>         if (!keydir || !keydest || !fit)
>                 return 0;
> @@ -1714,17 +1776,25 @@ int fit_pre_load_data(const char *keydir, void *k=
eydest, void *fit)
>                 goto out;
>         }
>
> -       /* Read public key */
> -       ret =3D read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
> -       if (ret < 0)
> +       /* Is it a RSA or an ECDSA key */
> +       name =3D strchr((const char *)algo_name, ',');
> +       if (!name) {
> +               fprintf(stderr, "The name of the algo is invalid: %s\n",
> +                       (char *)algo_name);
> +               ret =3D -EINVAL;
>                 goto out;
> +       }
> +       name +=3D 1;
>
> -       /* Add the public key to the device tree */
> -       ret =3D fdt_setprop(keydest, pre_load_noffset, "public-key",
> -                         pubkey, pubkey_len);
> -       if (ret)
> -               fprintf(stderr, "Can't set public-key in node %s (ret =3D=
 %d)\n",
> -                       IMAGE_PRE_LOAD_PATH, ret);
> +       if (!strncmp(name, "rsa", 3)) {
> +               ret =3D fit_pre_load_data_key_rsa(keydir, keydest, pre_lo=
ad_noffset, key_name);
> +       } else if (!strncmp(name, "ecdsa", 5)) {
> +               ret =3D fit_pre_load_data_key_ecdsa(keydir, keydest, pre_=
load_noffset,
> +                                                 key_name, algo_name);
> +       } else {
> +               fprintf(stderr, "The algo %s is not supported\n", (char *=
)algo_name);
> +               ret =3D -EINVAL;
> +       }
>
>   out:
>         return ret;
> --
> 2.43.0
>
