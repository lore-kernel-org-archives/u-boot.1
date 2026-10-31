Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE657606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BUfFo/4m;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lKpOAaxg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C14480FA1;
	Sat, 31 Oct 2026 14:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QqQwZZodRmfE; Sat, 31 Oct 2026 14:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB04580F4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455941;
	b=BTl9z1Uu4yS2aRBZb72cmMGcChzaKvhIilxtQDk+5W8s3z0Y9NifRaIoMHe54KxUGMlk
	 +B6MI0RJ1/7NbPakaEImaTzzfubRPTT6tPs0a5wNSOCG6FZJTPgBEYjgFRLWNulbBU6cT
	 bBeCKT2/8EbN7gknIlCssc738h4gLVGZsV64daPHHaQ4fVjKYLFPJKrtgysy+8HaLwcB5
	 /q8fXNMou2Olz5p1LC4pvZN9BP+Gm2jyU8QNGP8D3UUFc07ipKP7B3hbGTZ2mVExg5bUp
	 i88ldJ7lbQJjm/GzCilB138buUMn1WEkgp4z8BHboPj6QFxmTcMzxtLdgLujE6Iya6Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Qn5/phTMP9jocV4KdMQCBv9OO0Bvehs4NUefI5kn1HU=;
	b=JukrEOdtVE4XNOF6wMp3NN+lzIayIxQe4SRcq0/0H3jwuyXhfe5iW+yFOBhKWXIbSzxF
	 5ACt3PG8DsDzt5P8ZNuSAcFdOReIJx3a5kXwPZf8YfHUyUcr3ZqhQ/U4tGlpXraYThE/p
	 EDPuitPwQpdQiDWsuJbsC9p6e5HtknTwfh5NYGOlepLVeVjLZnvYtXeavB5V5l5784PL3
	 v8xmFHCO8oTNe76LMuqWjU3cUU2+AtELL3twhSl9KI+D9iWCrNI2wfdYTf6YkgDVkKYu7
	 VaAX8vfNug7ChGRExYYhMOahshJInSlteLXrkTazeRIOWIjIlh3xNE8fo8Wf/kzdeOw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455941;
	bh=Qn5/phTMP9jocV4KdMQCBv9OO0Bvehs4NUefI5kn1HU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BUfFo/4m9+txFO+ynQ6Rfm7tVEf6wgtX4ryA+uyEM+IaraB/bx1eo+EJrMXPm92Tr
	 PnBbB20IkWPyLLV1d/Vvnt/2mcza0KEf8U9tLEeY0gmwwYp/7Ee3jPVDcJfIKFrneO
	 abiUMU2VtB1TkqWQ9eOvcrbJziKKyHrPDQZYp8k5BtoycBIcPkOkpcoCr524zv95iT
	 boL5x+XCR8S79QP7z+Y8h0ConPqykEe6UVjmo9eP9p5Nfyq0HXBbAzxyHu61vRk4/r
	 pt6g03wOCE1pntwaTqV0uEM3Dw6ufMDDJk+orWEmAYPKworca/UgL2WBxmNy4UrwBb
	 bJSylaTfCt3JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB04580F4A;
	Sat, 31 Oct 2026 14:12:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B040411
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5089A6060C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyW3-5QniIJx for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 80685605E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455939;
 b=YXIJ++C5mGOkrcPMfaGY/B/ygJS1PQ+jKllnrTwlaj08b/s2diiI7HjKo3MS0y63aZxk
 7jHFJmLNhfxLPtw6iqirD5F0WdtTINmX86u7aK+JHAuPxijTfgnpod8kKuCf7M53dhFJ7
 so+VWpi1f+arzmP2pl5yIRBO5810K5P5mjy/u0k662Hkf2j3KH3c0nebZb1tX9tfyMLH7
 v/2jFTPYmHwRPaHZ2FUhQWO9C6AlPySR/WJBECbfs2IMLJ0/zp8BcH+pkZr9BkFU4PCTq
 ROb7Fh3O3evzbEGzgSD+6c+BbPMMbCn2dR7iMK1W8FnhAKLOPIs1y5JxeAFcIhhj9+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455939;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Qn5/phTMP9jocV4KdMQCBv9OO0Bvehs4NUefI5kn1HU=;
 b=jT3UPiewhDOgrdmSP+xZsg8rPprhceGAQrsXiIu9lLzD4D+Jd7monUVqn9+yZ6n2bz4v
 mBO1ENBNNw9VuXnaFUeM3jqNk5EcctE6VNFniuWVRlZOrh2AW8FyNl5sDzIxJP+j1/W9T
 HuMK7uOxu6c6FE/vCMtKgQisYqyYM1CgzwqPcV9PPAzAPLdRyGIyiTrCYuTPDv30m6zlq
 S4z5f2QXoGGjAMJa/CLSfVYXbN6R5LF7C6+O+VH+Q19EruR7xqtgwySPpiNlXEE4sxaP3
 vkCYxeY/+rrUC3pt1jYp3AK8RmO8QzjcjRUatBoEPkbzE5E913FLwjOxBppJzgd2raA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lKpOAaxg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lKpOAaxg
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 80685605E4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:19 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ac7c7b3a90so747937a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455939; cv=none;
 d=google.com; s=arc-20260327;
 b=gYKMEyy/AcDOYcn4L4ZjMJVL01w3NDBkg9ZjpOYc/Jf/nRxNbisXgE5KY5LPXLU6w+
 GN+sOaIRk7zn9eBx2VyvMdgdO9cQe/RNUGxIvlaWz458o0HebGBo14HY6NJHJ+A+pBOD
 24MTJiT0kFrlNUX4MiYMdt0Iajnc8DAVvXUNqgj2E7Lo9K8JeLJwmcGQ0Ms03S1ST8jY
 L9/vsmXLa3/4QIsEze4//+DSm3yrK8RZ/0km946NTyOIwZ0GDsQ2XSZptu8UL6TtoX1r
 /HUIJuGz578kC+AuvEyGcTONGTlpefonWHmFRJuJrRXWvhTdSXaDsMxt3N69PUqdhYb7
 02oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Qn5/phTMP9jocV4KdMQCBv9OO0Bvehs4NUefI5kn1HU=;
 fh=zP70F2aREQ/p2xCbpzFaiLIfLKNYTbybyQZzpsnkvWM=;
 b=kTbVAYmrQ/cV+oR6Z6dRSkePKoC3/EfkylPQW5UTAyoEVYMxusuFv6pzd9AlfhnO9n
 XuHBVEddCZxfaZI7IkNk2//tovBY7skM8DHE851vrm4VuRwUgqOAqFcNsPN5cltr8r5S
 eE2JORjclA3AmoMq0gjVgwutS1QfSB2wuWGNrpC5enljXAPy++DI+iIi9FexO7nJOSRk
 Tpzts3OVCUE3tjjGt4AKoIz6JeOrjlcN02twH6yKYKzZ4+EF6FPJgdDxAuwxirjgazPl
 DCY0BnIO9b7H5Q96sUs3kAHDwUENTw8ipJsEewxteonkO/ym74Esd5ORdjSVlnzrLbAt
 6MLQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455939; x=1794060739;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qn5/phTMP9jocV4KdMQCBv9OO0Bvehs4NUefI5kn1HU=;
 b=lKpOAaxgGQejwL5e+hZF8+fDszIOiKS0B4NxJ25C2CjEZAcPZmrJq8NZHq0jPJx3+Y
 p/f9DzeBRWUcPAyjnEe3m6KtVZBw/8UR4PPMbYUsWrQ/HxMwcyrlviKf1STm4BI2VtIs
 EsLEqLOmFkkowGGD4V0CxNJYK9362iLUyjqx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455939; x=1794060739;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qn5/phTMP9jocV4KdMQCBv9OO0Bvehs4NUefI5kn1HU=;
 b=rpH8sodM48Z9wyVw15i6p10dpgQ+lOgEGAWp25zf6VJN4SXO6BLyc4n8bcNfQVwdpT
 a3fqix72xoOVGEAYGa4HJ7ZySlLwbNlxctO0WSIzQFdWM/lJlsDVlVdX/xmwWVQ8sJjz
 +TChDAPbTdLPRubYfeImuE/Yisg0BqR85dc/rkTVzuJy3evmRnVgOy/wJbwitv0ouZLD
 a2lmG2GuF5f2ISZiFkKYproXH939fIlpk+UTxz77icLxuTV+KUwKmNyGYseEPn7jVfHf
 VXY6V5JPkOcVcf3WxQAoFErrzeQDJLjvHppA042T6W6c8I1T4ybTaL7skxo1x15TEj2L
 QG+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByasHUPFXjKllD014bceyLJVrHGwj9jykhZyqKDMn9+itXRG1rvUFcqscv9DDWcxO6LD1vuE0g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIW9NcCyk89G9YArb+Gr2q3c8WNKx0SGlGJWxTV5UrnLWGF1kjR
 zq4iMI6i9boILdWbIcFhbXByxMShsSS8QcoeHzY92U6sq8uCuXFH5JjB60LTpoBQGVGn9NukGzS
 xCswRXjTkWOh3H+AB9zQEDBG9v/LIObgYDG/mVJHfxj8TehduFW4=
X-Gm-Gg: AYBFou1oNc9oRD+vftiACR/e8E8YvKbJJe3eedzKVMvhc9BcCCfWc54dTh/XlN6sIXf
 NNGaDuNVi7YmprbAcolT9tZ5/ucKL/IezWitzKR2VJ83KYKP1IEYd2kKuFoy9trfK1xZ+aBd0iH
 QpunjabqBMpTZ7ppTE0EsyisxPMGxBS8WVDlmiossAmritWoHR88Zq51emxVJSavlskvLadhHUX
 hfbR31Rm0JeBXRKcGN5zSB7G9k6BvpD+Ex5QrARMdaLEo3mGPXNKt8+Xhz4sbmvTSVvWPBYcpAR
 qdEbnpWIyWdwX59hUD2OvRNy8JQ62zy6kzNeQdJDunpNsu8d6IAIS3SVY9AXmldEyIvwZW+DbyP
 7ly3vO7QfIhFrPXBUP3fu9FU2nU3XpQNUQ0hSe9+W4C6tnRDXo5JTtVijYGBtIimcJNz/GMWj/q
 dy9tz/HKHxoYNvmNhJIQ==
X-Received: by 2002:a17:90b:1dc3:b0:3a0:b312:1fbe with SMTP id
 98e67ed59e1d1-3ae897cfe51mr4184443a91.23.1793455938678; Sat, 31 Oct 2026
 07:12:18 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:12:03 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 10:09:48 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029201348.730274-3-ekovsky@redhat.com>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <20261029201348.730274-3-ekovsky@redhat.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:12:03 -0700
X-Gm-Features: AclHuK_jiaCzlrWJy40hfm3fyXMVtuynZc7aYXJC0f7JTxyWWymjnRKFTLyo6oM
Message-ID: <CAFLszTiO0jXX4jzLBJzufy18d+BU=zbk3qefesrdcegkSvLVZQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Add pkcs11-provider package to build dependencies
To: ekovsky@redhat.com
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>, 
 Jan Stancek <jstancek@redhat.com>, Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, 
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bastian <bst@pengutronix.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eddie,

On 2026-10-29T20:13:40+11:00, Eddie Kovsky <ekovsky@redhat.com> wrote:
> Add pkcs11-provider package to build dependencies
>
> This package is needed to use PKCS11 with OpenSSL >= 3.0.

As I mentioned on patch 1, rsa_pem_get_priv_key() now loads the pkcs11
provider even for a plain .key file, and calls errx() if that fails.
So on any OpenSSL 3 host without pkcs11-provider, all FIT signing in
mkimage fails, the vboot tests included. Is that why this package is
being added to the Docker image?

If so, I don't think it is right. Linux sign-file only loads the
pkcs11 provider when the key name starts with 'pkcs11:'. If patch 1
does the same, only the token path (patch 3) needs pkcs11-provider,
and this patch becomes optional tooling rather than a fix to keep CI
working.

If it really must be required, this patch needs to come before patch 1
so the series stays bisectable, and the commit message should explain
why.

> diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
> @@ -28,8 +28,8 @@ Depending on the build targets further packages maybe needed
> -      libgnutls28-dev libguestfs-tools libncurses-dev \
> -      libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
> +      libgnutls28-dev libguestfs-tools libncurses-dev libpython3-dev \
> +      libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl pkcs11-provider \

This is a runtime dependency for signing with a hardware token, not a
build dependency. I think it fits better in
doc/usage/fit/signature.rst, which still only says that libp11 / the
pkcs11 engine is needed. Please can you update that section to cover
the provider for OpenSSL >= 3?

> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> @@ -122,6 +122,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
>  	openssl \
>  	picocom \
>  	parted \
> +	pkcs11-provider \

The image is based on noble, which ships OpenSSL 3.0. After patch 1
the engine path is compiled out there, so libengine-pkcs11-openssl
seems to be unused. It would be worth dropping it here unless
something else still needs it.

>
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
>
>  doc/build/gcc.rst       | 4 ++--
>  tools/docker/Dockerfile | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)

Regards,
Simon
