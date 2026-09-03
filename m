Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50706C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D537A810F6;
	Thu,  3 Sep 2026 14:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FNWzD7bLFqoc; Thu,  3 Sep 2026 14:30:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E6CA810EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445839;
	b=qPm4uVW48T7qAbL/2CvOtdrxb0V1dfJrcRHJeB1TzGB3iPbWqiax8P5j2YO9VaSuS5Ee
	 ACIlbjQwOPRptWARvXrV9pP7KqxeeVAJPalaQX0To/eaBWHtsHnZVuC145sAIy1ePslib
	 HKEXlm44jYrXZZIArZfEE7BBFiWX7d1vTQX9BcVw5UwzuamCIwqe8GbI9s13zfUXRscDB
	 eSA9+ZJY68EXpMZBeqlyQcnDUCjXj+K3liNu0aMMEbAxACe4jyjvtCYzmJT5/4adFBl96
	 kvNlKdGDz1yt02HFubMD4CBXZfM52TLuFzzgugeWW4wM3p0Wg6l8/8aTz2BwNebkt9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788445839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9AfptzCPzuyy+WZs4nOWG42+QzZzIc0Sei2a+jzisCM=;
	b=DEwHr8/upB6Nc61wfCBiUkYIjpcTlCe7SeI+8Yv6vCvf0Ztgsx36sgU2LrrRARI25OAD
	 wp1mSHG9Vgg+sqRtWABNccXpQz3ximKkh+JmCjb65JDNF7ZPNlpEzETNQoA6x0GWp3ZCn
	 a/5GrRoZGa38I5mRD9apcPpfxGGJFZnjE3FDNPDMvZAElMtf0b1LJLwnp6vNge3aQy2ZC
	 +3fArWGTQQNFa+okG367JqVEfbQ9o5KB0oPQ/r0A8opinPWxJqqQ6ZA9mc43P/LcXTTGe
	 OpLnPzYjFAPyg0nrk4KYU9nEgZ3ib/3HuBgTtWZOLG6uUIYcmcGfs+hCNJA5OWvIz1w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788445839;
	bh=9AfptzCPzuyy+WZs4nOWG42+QzZzIc0Sei2a+jzisCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wF+vEctOjAW6fAggzMNnbCQoJxAOpXj5O5EMqDqzEEdF1eK/ipwd4iZqyKaVEhW8k
	 Sl5FRprryCVzOpkH5gYjhZ42wWi3QlggEvgyg1LBPtIluTQAQ4KeEfqu2XxcaVasEB
	 4ETqJZnwEfN8bi366IY2ysPmdODDynvMYGVEvFelG+/KHqxqTTdIDtP/35n4Ma6LEC
	 TOulVXSRuT3p2/MwsXcqZuNQtOeLkFZ/NAWXvv8OQ5AGydW0ONrTzIigHEBf/5VihS
	 VezE9Fa4agC7BMJ4EjO0ocZ/sHRrhpqAX+egGFZyfuy6ikYDs+2/yunXoMQulGueWC
	 b32R5227Qz7ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E6CA810EA;
	Thu,  3 Sep 2026 14:30:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BFA3334E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A551D60B6B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kKBt2uh1hoSp for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:30:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7086360B4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::934"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445834;
 b=B8Xed8p+2Z0EZNuzgA8fGUkBC29ayYJ1mtSPRfEJedsTImlJ/PAc5XZxoefK6REo2UHi
 Wp4QIeYx1wRMFRrMekCCN8/pwkElUybHnAw3K/sjEAGh5CWmSHT5tUuCzMJj4jQscsmtF
 RXpfSO058jcBVASkJwLIW+On+g3e34L5p05fSbcpI0GYtYAY9dMIo43OSwgegLZmhjDiY
 YEHvEG9KXGXrzqlSb1ZHtTfmo3IYZDBaMGdLsuDbWXXUahmz/FvF042BdOh/qI5ZJ1f57
 XzITv45YtKXiLXLsykz5B0ETkzFWrRMH9alf6Dyv55LrPZPZJTIPjA3kxk5efq/AjSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788445834;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=9AfptzCPzuyy+WZs4nOWG42+QzZzIc0Sei2a+jzisCM=;
 b=c4FwC6LlTzS+ceWmUTu534F39U2WjVrObmVMyOXxcI5gR9JcyMFWaLOBr/0dDzl0s4YC
 /GlaydFBlj6Nx0JZviHmpbJ+xSnxnDeb+RiZox41Ec8oW3JDOE+NwwxU1rZ7PDNt9ae2I
 TmpRM2BRx7/Sh1ymxwwntQDf3MIln6Fz/S1fVIbYdFtxmrIZ4ho9BINvHknPwuXlypvYu
 OX8gYdO0Ami54hGSCrY39UeQuqkZssBMemG6GNkwES6GTnHCtcXbmQrwY+K8vo2vxl46Z
 zsaRHtD290PIqrhfOVrjci7J24BCS4TvaTImohc3kGb+q2/dMgSf+M8848L878m2GpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kdTG9x+g; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::934"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::934; helo=mail-ua1-x934.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kdTG9x+g
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7086360B4B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:30:34 +0000 (UTC)
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-97bf8f6a31eso854367241.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788445833; cv=none;
 d=google.com; s=arc-20260327;
 b=sBPaSxjNWfgsG+Jja7q/hL4h/ojJw6kxM8a+AY2G9g1WNxx19JPLRy8YznJLWH4b2O
 T6/31l9sCr5DBZMc/0BSjQk9Yfrt9FGUhj0coL3fTpuucFpDp7PJ/G8hh/tKOXj8yXI0
 CwnqFHqCjZCq/iUfHgSqBZR+DflKJR4Fiq06TxnSWuaEKqBhIVQwBoG3Ay+QKTfUDd1J
 VeziOW2QCWXw4IKmx5QmTfEYB5y4vqFnPk3vZ7NRQq5MO+E9Gp7vI+nCq8ckD9ZEqteL
 spGfK90WfO4Q1Lc+vi5Y9j4yXmuy53wPWHYYSPoRnRQ0Gf26XjDK8Lky61a35y5nMq94
 zP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9AfptzCPzuyy+WZs4nOWG42+QzZzIc0Sei2a+jzisCM=;
 fh=cj07GK8AAc9owMHIWSQyNb8XyDEzLPVEq0a05/foYxw=;
 b=q7lIIC3FCEwqhLbjXSSghUHmzqXOH5PG0KZWBiqeVFlBYMHEMWxOHn0ujDZT8sCRcj
 5DbEozohSF8YB5j0de41WFU3E7ocM4ONQXPUwZZljcSF9Lt/RJRK5BFilHZ3b5pq4Lp/
 kQchxEyPRDOU1viCdyRpfD71M6fVhYyr4dTIwHEndXV0lKwbllESqsmqRTqClc1mWsqm
 cADn9J9xi3tBg0e7mJ3nnEdcGrpzwpqkYwHGxJqTh5yVm4dmGSkbbblyTm2e9NzFT891
 YM2BARELtmCy2FBLIa2bNstfekQaar0qBnpIb+NjZG3TpDT21vMRlBIGnq8eTvDqPDdi
 eQ+A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788445833; x=1789050633;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9AfptzCPzuyy+WZs4nOWG42+QzZzIc0Sei2a+jzisCM=;
 b=kdTG9x+g8gxY/ywiQJJomxSTTDRqQbIqUSbNjLxTX7eAxFp17l0o4e65bTfiTdSAZi
 tVlVd3XtFQc40ny4Mabp41mwKNPjsTDRbrxIAtG7UYIryqBLjUigGFgv3W2q6bAhbrO6
 7Mir4e0WjPCwQdrexPWG5sPL7Ky/lhS7OB/j5Rfo3uOmmySmXUQCFeIec6wf3DOsh9mA
 5E+rzvbTBnFMQilCysJMTwcPjV4KVrPangGO+bX9F62K1FUrvKYG0GMLbH0aJxjEb8TO
 /3i8OT7DM7POKDLG9DEpmIEQxSjKtUOOiCarkuwKRzUoT6ro3/i8t+8hVaSNoQhUFEMI
 e6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445833; x=1789050633;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9AfptzCPzuyy+WZs4nOWG42+QzZzIc0Sei2a+jzisCM=;
 b=OOhzmD5XTdtlzmEDjkWmlOKDOzB6P5HAAzwXt/+N9Ffm7LZhq1+8TftTX8AHSbNyvk
 4xOPhT3djbfB8uZH+LWebIYEGTHUUjhl1VvkT7EpSPXXvbQNimCZJ2jlwZuROwf2bBN/
 4pbj4pO/kPyjsPdftQtvolWkopYTzVaK/SqHxlHo3NC1pxQXSaGfBk8DNjBXI+giX8PK
 pmauGUUKvr6Sx9cJnFl1QBD1Xn15ArfVzHCr0i4nYaz7Q7CmHkG7x2Ys8dfkKRaTVcY2
 TmvuNAvxeiiNnPdUcE5nn8oK+T0JLqCMLQXx++YtBHKIX/19kcTlMmn4mKTWgTM+6hxL
 92nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/DqKWt6yUL+KjlVbXiKSFkhLoMxfUX4zkCAMBP4kBYwnDRELMBBErBze3g1uG+XufAUXo/5A=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mhNCWrwJL7GwUXT+BQJ52ipnmN1PCthdCauiEaUP/X8b9I4fh1
 hVbLBFMYJx5DgSkBA2v3DCeqGZKx3PJbp1kEK8qBUrOerZO6Iax1Jvk5hNGgsP1L8wlVi3Uwv4/
 3Eqi/lxC22sGKyr0ZqjAfSXEuxEWA1W0=
X-Gm-Gg: AYBFou15wjET3TKuM7Mz88BO3373ozosubjl5YIvIk59NnIdyUcgDkWPtro3zxJYf75
 urlSIXtaWiWVEY098x6pM9uMUzMbcsfRyqyAfqx0z/3usLchf/UW4SLe7Ef0w1ZeEptXzMyQ1zc
 3DjiY9moK2Kw3FgwlxWpCgXpBTGFpBmPCqRgoVnFM2dx5E0Ex2Vv8ahPtk1g6ftYh1H1Nl6OWuT
 Y8wsYMRtLO7BlZdWVtV2bEsmCx/jBMxiXsUb57zYZwKBX6wFAevvZNLdAfz1sreNYOGoeLGgfWr
 ESIXERW24ZqqioG4whfN5C/OqYNIE27pQyd2eUV4i2YqGiQ=
X-Received: by 2002:a05:6102:3fa8:b0:784:5883:9cc4 with SMTP id
 ada2fe7eead31-78a1f326a40mr4007479137.11.1788445832620; Thu, 03 Sep 2026
 07:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-2-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:30:19 -0400
X-Gm-Features: AcwNN1U0rcUdyWAZVqf3ws69JLz0fqx0lnW3VtlHFyQcmtQv4_rOjScP8muOZ_g
Message-ID: <CAMDkj5x49U1pJPByhYQWhpKH5odH09x_YiLGnhXPK3E6k0+1wQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/15] ecdsa: fix support of secp521r1
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org
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
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> aligned on 8 bits. In this commit, we update the keys management
> for ecdsa to support keys that are not aligned on 8 bits.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - intitial version
> v3:
> - fix typo in comments
> v4:
> - fix commit message
> - clean code with DIV_ROUND_UP-
> - duplicate data before shifting
> - support ecdsa521 and secp521r1
> - clean code
> v5:
> - check that x and y are not null before using them
> - free keys when keys not found
> -v6:
> - free x and y if x and y are not null
> - do not free key when an error has occured
> v7:
> - no change
> v8:
> - check the exact size read in the dtb instead of doing a simple
>   test on the expected size
> - change memdup api to use the same as in the header include/linux/string=
.h
> - code cleanup
> v9:
> - no change
>
>  lib/ecdsa/ecdsa-libcrypto.c | 75 ++++++++++++++++++++++++++++++++++++-
>  lib/ecdsa/ecdsa-verify.c    | 71 +++++++++++++++++++++++++++++++++--
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 ++++
>  4 files changed, 148 insertions(+), 7 deletions(-)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index c4bfb2cec61..b3fc75fac48 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -26,6 +26,8 @@
>  #include <openssl/ec.h>
>  #include <openssl/bn.h>
>
> +#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> +
>  /* Image signing context for openssl-libcrypto */
>  struct signer {
>         EVP_PKEY *evp_key;      /* Pointer to EVP_PKEY object */
> @@ -41,10 +43,36 @@ struct ecdsa_public_key {
>         int size_bits;
>  };
>
> +/*
> + * This function returns a valid pointer so
> + * the caller must then free this pointer.
> + */
> +static char *memdup(const void *src, size_t len)
> +{
> +       char *p;
> +
> +       p =3D malloc(len);
> +       if (!p)
> +               return NULL;
> +
> +       memcpy(p, src, len);
> +
> +       return p;
> +}
> +
> +/*
> + * This function fills keys with valid pointers (x and y) so
> + * the caller must then free those pointers with fdt_free_key().
> + */
>  static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, in=
t node)
>  {
> +       const char *x;
> +       const char *y;
>         int x_len;
>         int y_len;
> +       int expected_len;
> +
> +       memset(key, 0, sizeof(*key));
>
>         key->curve_name =3D fdt_getprop(fdt, node, "ecdsa,curve", NULL);
>         if (!key->curve_name)
> @@ -54,6 +82,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, co=
nst void *fdt, int node)
>                 key->size_bits =3D 256;
>         else if (!strcmp(key->curve_name, "secp384r1"))
>                 key->size_bits =3D 384;
> +       else if (!strcmp(key->curve_name, "secp521r1"))
> +               key->size_bits =3D 521;
>         else
>                 return -EINVAL;
>
> @@ -63,12 +93,45 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
const void *fdt, int node)
>         if (!key->x || !key->y)
>                 return -EINVAL;
>
> -       if (x_len !=3D key->size_bits / 8 || y_len !=3D key->size_bits / =
8)
> +       /*
> +        * The public key is stored as an array of u32, so if the key siz=
e is
> +        * not a multiple of 32 (for example 521), we may have extra byte=
s.
> +        * To avoid any issue later, we shift the x and y pointer to the =
first
> +        * useful byte.
> +        */
> +       expected_len =3D DIV_ROUND_UP(key->size_bits, 8);
> +
> +       if (x_len < expected_len || y_len < expected_len)
>                 return -EINVAL;
>
> +       x =3D memdup(key->x + (x_len - expected_len), expected_len);
> +       if (!x) {
> +               fprintf(stderr, "Cannot allocate memory for point X");
> +               return -ENOMEM;
> +       }
> +       key->x =3D (const uint8_t *)x;
> +
> +       y =3D memdup(key->y + (y_len - expected_len), expected_len);
> +       if (!y) {
> +               fprintf(stderr, "Cannot allocate memory for point Y");
> +               free((char *)x);
> +               return -ENOMEM;
> +       }
> +       key->y =3D (const uint8_t *)y;
> +
>         return 0;
>  }
>
> +static void fdt_free_key(struct ecdsa_public_key *key)
> +{
> +       if (!key)
> +               return;
> +       if (key->x)
> +               free((char *)key->x);
> +       if (key->y)
> +               free((char *)key->y);
> +}
> +
>  static int read_key_from_fdt(struct signer *ctx, const void *fdt, int no=
de)
>  {
>         struct ecdsa_public_key pubkey;
> @@ -89,8 +152,11 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>                 nid =3D NID_X9_62_prime256v1;
>         } else if (!strcmp(pubkey.curve_name, "secp384r1")) {
>                 nid =3D NID_secp384r1;
> +       } else if (!strcmp(pubkey.curve_name, "secp521r1")) {
> +               nid =3D NID_secp521r1;
>         } else {
>                 fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.=
curve_name);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
> @@ -100,6 +166,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>         ec_key =3D EC_KEY_new_by_curve_name(nid);
>         if (!ec_key) {
>                 fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n=
", pubkey.curve_name);
> +               fdt_free_key(&pubkey);
>                 return -ENOMEM;
>         }
>
> @@ -108,10 +175,11 @@ static int read_key_from_fdt(struct signer *ctx, co=
nst void *fdt, int node)
>         if (!point) {
>                 fprintf(stderr, "Failed to allocate EC_POINT\n");
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -ENOMEM;
>         }
>
> -       len =3D pubkey.size_bits / 8;
> +       len =3D DIV_ROUND_UP(pubkey.size_bits, 8);
>
>         uint8_t buf[1 + len * 2];
>
> @@ -123,6 +191,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>                 fprintf(stderr, "Failed to convert (x,y) point to EC_POIN=
T\n");
>                 EC_POINT_free(point);
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
> @@ -130,11 +199,13 @@ static int read_key_from_fdt(struct signer *ctx, co=
nst void *fdt, int node)
>                 fprintf(stderr, "Failed to set EC_POINT as public key\n")=
;
>                 EC_POINT_free(point);
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
>         fprintf(stderr, "Successfully loaded ECDSA key from FDT node %d\n=
", node);
>         EC_POINT_free(point);
> +       fdt_free_key(&pubkey);
>         ctx->ecdsa_key =3D ec_key;
>
>         return 0;
> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index 629b662cf6c..494b60b4ab0 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -10,6 +10,7 @@
>
>  #include <crypto/ecdsa-uclass.h>
>  #include <dm/uclass.h>
> +#include <malloc.h>
>  #include <u-boot/ecdsa.h>
>
>  /*
> @@ -24,13 +25,23 @@ static int ecdsa_key_size(const char *curve_name)
>                 return 256;
>         else if (!strcmp(curve_name, "secp384r1"))
>                 return 384;
> +       else if (!strcmp(curve_name, "secp521r1"))
> +               return 521;
>
>         return 0;
>  }
>
> +/*
> + * This function fills keys with valid pointers (x and y) so
> + * the caller must then free those pointers with fdt_free_key().
> + */
>  static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, in=
t node)
>  {
> -       int x_len, y_len;
> +       int expected_read, expected_len, x_len, y_len;
> +       const char *x;
> +       const char *y;
> +
> +       memset(key, 0, sizeof(*key));
>
>         key->curve_name =3D fdt_getprop(fdt, node, "ecdsa,curve", NULL);
>         if (!key->curve_name) {
> @@ -50,15 +61,50 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
const void *fdt, int node)
>         if (!key->x || !key->y)
>                 return -EINVAL;
>
> -       if (x_len !=3D (key->size_bits / 8) || y_len !=3D (key->size_bits=
 / 8)) {
> +       expected_read =3D DIV_ROUND_UP(key->size_bits, 32) * 4;
> +       if (x_len !=3D expected_read || y_len !=3D expected_read) {
>                 printf("%s: node=3D%d, curve@%p x@%p+%i y@%p+%i\n", __fun=
c__,
>                        node, key->curve_name, key->x, x_len, key->y, y_le=
n);
>                 return -EINVAL;
>         }
>
> +       /*
> +        * The public key is stored as an array of u32, so if the key siz=
e is
> +        * not a multiple of 32 (for example 521), we may have extra byte=
s.
> +        * To avoid any issue later, we shift the x and y pointer to the =
first
> +        * useful byte.
> +        */
> +       expected_len =3D DIV_ROUND_UP(key->size_bits, 8);
> +
> +       x =3D memdup(key->x + (x_len - expected_len), expected_len);
> +       if (!x) {
> +               debug("Cannot allocate memory for point X\n");
> +               return -ENOMEM;
> +       }
> +       key->x =3D (const uint8_t *)x;
> +
> +       y =3D memdup(key->y + (y_len - expected_len), expected_len);
> +       if (!y) {
> +               debug("Cannot allocate memory for point Y\n");
> +               free((char *)x);
> +               key->x =3D NULL;
> +               return -ENOMEM;
> +       }
> +       key->y =3D (const uint8_t *)y;
> +
>         return 0;
>  }
>
> +static void fdt_free_key(struct ecdsa_public_key *key)
> +{
> +       if (!key)
> +               return;
> +       if (key->x)
> +               free((char *)key->x);
> +       if (key->y)
> +               free((char *)key->y);
> +}
> +
>  static int ecdsa_verify_hash(struct udevice *dev,
>                              const struct image_sign_info *info,
>                              const void *hash, const void *sig, uint sig_=
len)
> @@ -76,8 +122,11 @@ static int ecdsa_verify_hash(struct udevice *dev,
>                 if (ret < 0)
>                         return ret;
>
> -               return ops->verify(dev, &key, hash, algo->checksum_len,
> -                                  sig, sig_len);
> +               ret =3D ops->verify(dev, &key, hash, algo->checksum_len,
> +                                 sig, sig_len);
> +               fdt_free_key(&key);
> +
> +               return ret;
>         }
>
>         sig_node =3D fdt_subnode_offset(info->fdt_blob, 0, FIT_SIG_NODENA=
ME);
> @@ -93,6 +142,8 @@ static int ecdsa_verify_hash(struct udevice *dev,
>                 ret =3D ops->verify(dev, &key, hash, algo->checksum_len,
>                                   sig, sig_len);
>
> +               fdt_free_key(&key);
> +
>                 /* On success, don't worry about remaining keys */
>                 if (!ret)
>                         return 0;
> @@ -135,6 +186,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) =3D {
>         .verify =3D ecdsa_verify,
>  };
>
> +U_BOOT_CRYPTO_ALGO(ecdsa521) =3D {
> +       .name =3D "ecdsa521",
> +       .key_len =3D ECDSA521_BYTES,
> +       .verify =3D ecdsa_verify,
> +};
> +
> +U_BOOT_CRYPTO_ALGO(secp521r1) =3D {
> +       .name =3D "secp521r1",
> +       .key_len =3D ECDSA521_BYTES,
> +       .verify =3D ecdsa_verify,
> +};
> +
>  /*
>   * uclass definition for ECDSA API
>   *
> diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
> index ecb0344c8f6..090246b44e9 100644
> --- a/lib/fdt-libcrypto.c
> +++ b/lib/fdt-libcrypto.c
> @@ -10,7 +10,7 @@
>  int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
>                    BIGNUM *num, int num_bits)
>  {
> -       int nwords =3D num_bits / 32;
> +       int nwords =3D (num_bits + 31) / 32;
>         int size;
>         uint32_t *buf, *ptr;
>         BIGNUM *tmp, *big2, *big32, *big2_32;
> diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
> index 5285263c616..285547994ca 100644
> --- a/tools/image-sig-host.c
> +++ b/tools/image-sig-host.c
> @@ -83,6 +83,13 @@ struct crypto_algo crypto_algos[] =3D {
>                 .add_verify_data =3D ecdsa_add_verify_data,
>                 .verify =3D ecdsa_verify,
>         },
> +       {
> +               .name =3D "ecdsa521",
> +               .key_len =3D ECDSA521_BYTES,
> +               .sign =3D ecdsa_sign,
> +               .add_verify_data =3D ecdsa_add_verify_data,
> +               .verify =3D ecdsa_verify,
> +       },
>         {
>                 .name =3D "secp521r1",
>                 .key_len =3D ECDSA521_BYTES,
> --
> 2.43.0
>
