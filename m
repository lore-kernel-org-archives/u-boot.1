Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0A606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=reAe/G5Q;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lXxqxOnS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54BB240B33;
	Sat, 31 Oct 2026 08:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62dK4FUnSX3Y; Sat, 31 Oct 2026 08:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70A3240B03
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436816;
	b=VkpeR92yW3tFr9k2pwa/LlCDGaxg4B3p83cYuUawnXwSvCIm+WkO8NsUN9LaapufRaL9
	 y51SA2kEe7+LTqry4a7t6X7UAmDZ375kcHTT3xVPG/VO0mJn+xe8vbVFsG5ArU/BgY0nq
	 XL2BJXjoBGOjoMIqEfrQU3ok+27b4uuGHK4sAlvDoyVKcwWkVRHPLX0O6vdJvCpHQd0jR
	 +HrPCR5Mi7ECZjLU33OIgJ+oc+xed4hIgXOBrnc/YlqacO/2QUOXfHZeW8bukvr3qMbij
	 Rl9UGsvqobPUmePLuhC8YdED7ImT+h/etera4Veu/LFlkMX5FkFVZ7irNZxqvo9+syg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TZUyg5at0J1YKMrfnLV4dvV0qp7Qepv1fAyNgE+tUVo=;
	b=MxtNualRHt/tE33fguE4d3N+P3f3NTXypq9Inu5hISc2VZNXUJLq369PZ5U5QcIvXUJ+
	 JshdYFRhiylBtmP4mnkzQUSuzXDRsFuBy1i7ETMxgHhuMcZKna6JoVUk6P6A9RoWOmxAz
	 ci87pSX5w74q6ayNPdFyk06gohfMOP9q2/AOvXGasQMrPWcwp9fSdtVpngzuDSoQhhXpM
	 RlXO2Ppp1qUbZNqEPBRI08rwkh4/RbmW52721GYf2MJomrFIT7xCZoGSPi6qpktO3+Ij8
	 mfhv7sWTZ/qNTsCaoTD7zqPmwvTHgtm9n2vqQuSczSNdIEmjSlth1jpmvXltMNe8g9A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436816;
	bh=TZUyg5at0J1YKMrfnLV4dvV0qp7Qepv1fAyNgE+tUVo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=reAe/G5QDF1ICByzMzHwj9SBRAAr/oRaly4IZ4tqkTVVbXaqj/FGp+IxTb3aHiivI
	 XnO9RqrwaFcgAuh68BsWw1ZYVa3bEo/T31aZX72gqpqInChlxSupdh4tREVWLcGDX8
	 9o30kSj2nWG7XbFrkDCUIgaxZT1HNeiekRod+Vcb2O6OwPt5je5sGoZD5GbAnA5laq
	 hVWkPqXqPjTSo3+65qYv+Et9X//tmFNyssUh8ydm9aOQjmESlV7vF7pRSw+Hxynaca
	 c0VRyk0pbW1VOeTJHE9tsZRIRgYudSmQzfQ1uL/OmExFTd7/6uCsx53o+4qSXA+DmF
	 k6vsHUa+Phqhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70A3240B03;
	Sat, 31 Oct 2026 08:53:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C12AA156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6A1360AEC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SzjHG7lX4qCI for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D7D6E60895
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436814;
 b=hav05lsG+kmoQ5K1Rl9zSYnPmrzLq/XeikTyit3rgCmkN9Qk9t6QbN1L6VEPD2Tl/P4M
 7guXBADcu2F6RsocgUFeNWrB38cSnexqmvmWvPKE6nKgeMLrjfiApekSialP6fhWZQVma
 QlomK3XyEM4J0DiS7qMRQl6mJKn2IYAopyg7FIOM4eZ1JkQ77KIcK73BzWYa7ePhSqZvQ
 T+2AGqIiiDxJY4XNt0ezmuHbbazjGdkD7JeeOPIRVcCpVhHy602GKAQgv/BTb4Ye+EJhn
 z0/56nTCSHyhsau3Zk3k9oiXB3ChKHxQn+y7RnyiD1rArA/u3rqD61leQg+5cey/OPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436814;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=TZUyg5at0J1YKMrfnLV4dvV0qp7Qepv1fAyNgE+tUVo=;
 b=Tesa8aEz87g15/wTkAVJaM0B/TpWyC5btmVXZodNYnsdDwovp/Ic7v5LGQkSKM2wraEB
 F1N/JYVTMFvr8ILwclB/jDB87y+/PN5PQTNQ8YNWgF02zWHSZHtBUbhNBhEj6zyiHwM5u
 AcGtnsSC2hUdStStfa00K3Qb0VmNdhmzsVh/0H7oMVDmncpWx9EeYf+YCUaQVXqnbTesN
 sZZ/J4tPugsZTSOxFectb7syO9Ld0/U62BsfT1kBDaxiuNivBzkSDJmTYwaKw0i6cWlks
 z8iiWBzXFHuL5y63aiGfmOjiohUm/LbxfV5cRxYDOIhZwEGHqgyXengYxdQoJr5Vztg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lXxqxOnS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lXxqxOnS
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7D6E60895
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:32 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so729759a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436812; cv=none;
 d=google.com; s=arc-20260327;
 b=rHY3JMx1RiVwfd64RQ4mcl0watIxT8T0mikbJVL0gCj2T85w3mIblW7070l4gImAY7
 8SJ5Cn2ahw9gNngzV3vtqEes8NgCDEjVsjrqD9R60sx9Zg5S5f83c1WTHbcxqzIa4Bur
 Jl77zK/rF5oaHQhvtXc2MmXSBHxGVJEqdlw/QBqNUMgn1K8kGgOSKuUy/onmoLi77vaz
 fJ7urdbl322VZscwYE2TUaNiGT4d+ORdhrEYjK9RXnp+ICNQeLxc6p+ngAJ5cH/EZYQo
 0ALNq1mpJ7CQzmDxbyRMkA2oCntbExidHx+GIYpSGE88I+hYBYuXTChfn0HduSFo4dVv
 5eNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=TZUyg5at0J1YKMrfnLV4dvV0qp7Qepv1fAyNgE+tUVo=;
 fh=14V5QZ2qJWOmkUpIay8f5wLH4+hU5ubxJ+YNB0Krams=;
 b=GO/x/9e6y5MvhR2aBS31pKNwQCaGtLqTFf9cSS1krEoKO6Q7z6VdghBWjNdyNY6yT2
 jBM0QruKy08v13oJq4HXocveWfdinV2koSVwy4eK9I8OSy2N97ZhLehK+yTuGdGTnxZ0
 UEAhh/JKlHBq0CeGKYrNYfWI9UAYg216FfI9dYURxelv429MzbTChbeeF9bOohRw0P4I
 U0gXPi/BLyq9PkJregKUTjMgWyzZKw2rdxDQh1Si0F1yl8dDDOaQw8Ha5Kui2ODDpdMn
 dIIkNF4VmVxY7SrJ+6WvQdMfTgzrBEtt/7SOKNQ5RVVVsX8BLGZY/aWs+UITyv9WSu4l
 cM3g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436812; x=1794041612;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TZUyg5at0J1YKMrfnLV4dvV0qp7Qepv1fAyNgE+tUVo=;
 b=lXxqxOnSvErb6liwLvp7a9Cmy5sOE0aBRuSgmMIeRMTwwUBPpYNYNzNa+yBs7BgCAv
 JvlJgqegNXvpRMJ8srsnJGnnB1PwckuAlxsCNnisA3LwAzyHcFd2/3Z0cKHAV5D2Bbbd
 JUDA7vFYRag7NKjKurqK4Zty3Sq+VGMlwrbvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436812; x=1794041612;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TZUyg5at0J1YKMrfnLV4dvV0qp7Qepv1fAyNgE+tUVo=;
 b=ny28qTouf/i5Dac7LEFVEZdhnHiI06gocZJwTcG7Xrn/5QDO6WZMxcgN9yWL1891TU
 T4gldvgd2yRjIl6CAhtoyOI+8kG/ntG02V3xaACKn1eGjHN+kJw4WpoGzKHYbAMOs9NF
 0jiaIlSxgnIhbRTVPAoLsF/1nF9wX3LdwCqWshZ3lMpe1a/rEyvyhYq6hJO74mOgp7NM
 Ix3ZQMn2EIYOJPBUAZyOmXC6oxMJuwxeMTFDl3tNpK4ys0ON/hySIYlJp4VUQ3QpwiTy
 9/a/wPwXUGu5/FBOvbJYxwYO6W4b0lHEvvJ8/Ut4+mouPm6OKUqh31GR6caaCIBBrVef
 6SkQ==
X-Gm-Message-State: AFq9FYJHbWHDrKUIMOaZ1JOp5qFvVB4EqK4X24LlwhHxNBzFJzkbXtaJ
 zWLhqWNgUdDaoV1f+iYcpIaQ/2O/Svm1AfWsLk3Jc3uExgDaB1X3gWNX9rGPiG/V/SbF7W4+TLv
 FQPqIL5ttSOKvCKD6qyIbloNw0SQR6C2A/Rpng2/584n8JpHA/32GUw==
X-Gm-Gg: AYBFou15kRUHDtQrNlF0LdgY0yfqJJGONu23AVznKZs5gHfUvlctYB1yAaqJ8jgFBKs
 Lz+GknkocpZQ4b4Kz5oZPbNhmb3/JU5u+HQPjAio+vT8Qiq4XlAX2HZpCUR1uG50ae7YAtlwdRs
 +8unxvRh186MAOsdyoi78KQP6XTXAPI+uYLdttp/LBHqj1k6MM12MZPdnQLwwnv08kQZduzMynA
 iRg9AcowBHCItT2+m2ow/E4BsPKTTt77G5w5xFewVbqQ4uFTpnG8ePQuCoAK+anJMAO1DRXT3ZA
 c4wd8Ste2ycvh2cYbWF5aTBgzP6Zd25cBPXnWBeavDG4ettwntkBWgGu5fe1LYDd3Cwx3WIWYvG
 gc1CJQFfvlzH2l0GUO1n15P1t8NJ9mmwd7oE2GDx5FMQqklzIV+26BhVXxHFWNXfsCpokIJM=
X-Received: by 2002:a17:90a:c886:b0:3ac:80dc:f407 with SMTP id
 98e67ed59e1d1-3ae89865dcfmr3549196a91.60.1793436811948; Sat, 31 Oct 2026
 01:53:31 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:53:29 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:46:46 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028103102.414657-4-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
 <20261028103102.414657-4-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:53:29 -0700
X-Gm-Features: AclHuK_O__Mwb-ifMGxdydafmmzwC1oMJTQePHQyGSxeTUkK5QCrGsr_LHAqQQY
Message-ID: <CAFLszTjEY3om+OFcnaM_Xt1S5ijTbdZ243umx7-YM_PEXUGR6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] lib: ecdsa: Accept .key private key files as a
 fallback
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ayoub,

On 2026-10-28T10:31:01+11:00, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> lib: ecdsa: Accept .key private key files as a fallback
>
> Allow mkimage -k to use a .key file when the ECDSA .pem file is absent.
> Keep .pem precedence so existing key selection is preserved.

Please can you give the reason for the change here. My understanding
is that binman only looks for '<key-name-hint>.key' when working out
the -k directory, so ECDSA signing from binman cannot currently find a
.pem key. If that is the motivation, it is worth saying so.

>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  lib/ecdsa/ecdsa-libcrypto.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -289,12 +289,24 @@ static int default_password(char *buf, int size, int rwflag, void *u)
> +	if (!f && errno == ENOENT && fallback) {
> +		f = fopen(fallback, "r");
> +		if (!f) {
> +			ret = -errno;
> +			fprintf(stderr, "Can not get key file '%s' or '%s': %s\n",
> +				key_name, fallback, strerror(-ret));
> +			return ret;
> +		}
> +		key_name = fallback;
> +	}
> +
>  	if (!f) {
>  		ret = -errno;
>  		fprintf(stderr, "Can not get key file '%s': %s\n",

This duplicates the error path just below. It would be simpler to
switch to the fallback name and let the existing check handle any
failure, something like:

    f = fopen(key_name, 'r');
    if (!f && errno == ENOENT && fallback) {
        key_name = fallback;
        f = fopen(key_name, 'r');
    }
    if (!f) {
        ret = -errno;
        ...

The message would then name only the last file tried; if you want both
names, you could print the first before trying the fallback. What do
you think?

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -408,6 +421,9 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
> +		snprintf(fallback_name, sizeof(fallback_name), "%s/%s.key", info->keydir,
> +			 info->keyname);

This line is 89 columns. Please can you wrap it after the format
string, as the line above does.

Regards,
Simon
