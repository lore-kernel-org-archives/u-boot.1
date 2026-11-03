Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC08606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Std8ZyUL;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MoQYwg3Z
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8098605CF;
	Tue,  3 Nov 2026 15:49:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LDD-oRrUEnn7; Tue,  3 Nov 2026 15:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E2DB60856
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720966;
	b=qoVSOmUrHEPzkpzrmsjkL5RlfQNnhnIikfMm0n+uXcPIwfhMxFNvX+6s+AQpN7b5H+91
	 0yKpxeqMj1wJ5fIblKTtCyXbUW0Q3ZyBDV5ioKhNcdzSXT4DWmFT4tT71aE5C4tePZnnY
	 SkKb2sfDGwYyDXKEQ/DLjJZqmbTxNdMzDB5zaErItVzPhxKDVm2CKtwsVlzh1aimonXWd
	 E7cR6/b2pFTuBJo/Ckh1xArgyQ7elJOKGA/UIFMMsH2KgZP5HgYfQZTBCYrJ1J0CHFwth
	 Ln7QdeNBkSQuSWcvKq0Uu/fgLgqtMaOAhpgpDaa3113dLHmOQ/7Ah5KmqSadJyC+zXQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cjyPnoHXC/Xrbq69iBGQC5mB84M81GJ5DYDSQmoyma0=;
	b=pfS6sSvWgFJMXOdN6/KdmaUn+KPdifNMJt9re/tBDx4sJGpIOZKH5ai1ZK+IRp6CVG1+
	 HkeBkhhX70sKulrGwE1TGoO6tDpq8IO0y3Zl+mJJAhXbWBPMH6CvJcATk4L/YQFALhnP9
	 +Abc64kqCT1kqntH0JngNRl4xQ59rMsVoKxcTbwXYTVGtpCBDMozC6kaJl2tV25Pvba2i
	 YC6p3kUwzCY/4YKKM9gA62vSLA/Z9ryzd8f9iQgQlsDB4SP/JDYlKcyoKA3U//vVWBAos
	 wL2pUMF8TkkfAFShcfREMtu4hKWK/M6sojQRLxi/xKbRWnVzrbbS+VVOH5dEGa3FXqw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MoQYwg3Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720966;
	bh=cjyPnoHXC/Xrbq69iBGQC5mB84M81GJ5DYDSQmoyma0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Std8ZyUL1P+eWKeccGvM5HLAgUL3F6ymkG/yXgy4JRc9iSWi+Cbuy8zcAf57tc7L+
	 B3TsaLUvbcJvGQePdOFZoPt8ow21oKFyrE6xe+2ApGlQbrP7GPI2ZbVr1hvf55sKQN
	 jWgh7NKYyxhdQF0xc9AqrT4aWaqejBcctEMA1UnEf+MifQfHJnpPMQBpp18KR9t5kc
	 ZjayeNiovHQT9YVFghEoBzJWTNGaj8s3oIS8q4gm+Z0Dc9KyG6naEMek6iJ7qRYg11
	 BGUVkXgwn0MxMlSKddefjV0x73bWHMHUVouDcEqTIztgtj85dK7D3fY7+yDtw+59XN
	 5mSiD9Mb2hj1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E2DB60856;
	Tue,  3 Nov 2026 15:49:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18FA6A15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F24FE608A8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EKtKuuzcRWGB for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:49:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 471A960856
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720963;
 b=d3OuyiifhvpOG2l+UKSWO1eKKkizbIWZbmCLp6grR+mAiFc42nWsqmYHRtW0OHxtWYLA
 gdRP+33SeT/wYv9kdf7ViOhT5CY5EMhd1h8VVaMs9mZUOFo2PkmMAT+HDW7x/2T2ZoEjG
 I2lUwhlKqLLoN4Jc5YVqszs2OBAUEsqT/Rn1TQ65vCBMmHA0ZRZMrpxwkquhA0tB9o7Iq
 +3AhIxbbAT9DtPcw8b6l0jFd3aZiH8CwkLT246XL0MXK8J8rxNE80JmFXuhPPiiArlVgq
 4zmkH4Qu98aF6e07AvCkYIYOC9/L8ufP1z6gwgRv8TYe0Z8jczmOh+UPUjzHv7uTh5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=cjyPnoHXC/Xrbq69iBGQC5mB84M81GJ5DYDSQmoyma0=;
 b=XMUiL4jjHKmek9g3xtrRW4Cjebo2QS+XvHLgEXAm3NxKJT6kwGpq8cqAiKyCWNOgSDsB
 EIdP1pe7/lZgQpUUgNzFC2BJDQE21Yg8O6K3aDIzsLgemv8S0TSX0Ed/F8UIaH1WYypdi
 kdWu5pF9PXuWXFsIppZZPAJ55hDoAGX0DodxL+Sn+kuFoMDx5j+mDnfwXyW3kDuxfUS9+
 XGM2vWvFIiESod/ZmdsZd6ezXrHqZoQk0jkr1TnuVJz39DTzkVUrghkmbFee4cyIVxH2u
 a+wFuylJMa+Uh16sMtLm1dEOjMhnl2Oh7kk8OfbtoTmbkYfgRveAl5jAhtEFLQAGmYg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MoQYwg3Z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MoQYwg3Z
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 471A960856
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:22 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so40526975ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793720962; cv=none;
 d=google.com; s=arc-20260327;
 b=Ns2t04xzW1Wen/F4vYcIgXtYpoI9P0GIXJ4uJtvYDXKnn3OvigZQh65x8csrlnKRoI
 3l8ju2MUzJv65HSkxg3r0B08xJWWIBRwlNQz27ZycyK5poIS0WoFLR3qRaIodcNnmWc7
 ArzhrcWzMeyfpIDOQXJBg0SMvvuAEQNaRT3fzi0CxvXDENlfOuVQ5XBKDiBiwR5xMKNc
 S7IdxzcOrzDLE2vohhPBJW+eByJs9YqZnsODH4QhoNzDz8CiIe8IbqfxCYXrGZYULClt
 5sDFTo0bczAu8OYAT4S+pRtYdZA9J0aAag/prtKJreqh6UihV+sk9QXOirqVHeqEtEOr
 tj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=cjyPnoHXC/Xrbq69iBGQC5mB84M81GJ5DYDSQmoyma0=;
 fh=vAmY7hRBdMrkxhak4XNxRo2S+aXYqAOi9P6V2g3HEEg=;
 b=KqNzFMq6AyISViuL412lAIxFtunndAfACy7jqNI6YyXTC2fbJyZOWzvsTB7ZFbor/i
 m3bL4KcHEwDQSZ2TzQTxG5EIZrwW9ZFCdMpC37coG0PYXpYd+Eb5jApb6IDhIhNtefmQ
 KK5wNf9Stqavx0b3R7wdyrBR3ngJP023QLQJjngBPko68OhYoZw1MYx+AsSHQKEZW5lW
 eBMnv22sV3QDsW0r2KHbcASZARfVc2RVGRRBNdH5KYWf0VqMAzcI5iJIRtwNLoZiqxqJ
 I3/pTYJ9kdWCRjJIA/tTI6VnKz8NTponEcm6ZEaquXei039I1ETyT6Ooa3PwzERbaPMY
 GtQQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793720962; x=1794325762;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cjyPnoHXC/Xrbq69iBGQC5mB84M81GJ5DYDSQmoyma0=;
 b=MoQYwg3Zd0w89TYtEtQfR5jBQ5rPeCVyNXKAuqLh6jschZlk1tm8jJEYEscCOJqXKd
 Lb2jZz3vTWgm6FMHvm5waUgCAq3epeYW5NuKQ9lIDvW9DhvKnJUtRiSFQ0HAJMXZdpPJ
 SPycePH59rMJxzcBA5/A6U6RTDM2lFzvDB3ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720962; x=1794325762;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cjyPnoHXC/Xrbq69iBGQC5mB84M81GJ5DYDSQmoyma0=;
 b=XPN+fabHrsalyWCHpp6eXFo76wfP609lI+xYe7KtvG24cOTVohByfZRKz0JI+ZA2Qb
 58lqDk93t4DhOYsqTNbaCcPR6oGWMsAQot8Fn65qeIsntRcgeU2nuAw/+9CSHPSnK3Rr
 wtsRlaSzVBY7RLPcqglGy0SHnUrB0xl+qhHYFZ6tUbfiEDQI8m8jUsUKZNHkMr5LqVVB
 flNBk0IEZyf29a4y6qwtToR0MiJI0y4nfy2RgfYnzzeHUB9AhgJn0KdMzj5dJpS/173v
 Q/UuACmNdr4+AU7pfAsdrEWQ0SdWFqlsGSe7Zs96Q/3wzuwoywPKVwOWPl/MCpRmt3Rv
 3VjA==
X-Gm-Message-State: APuU4Z8UzwkI7k/b9iD6xTsqWQXZbAlQVV/mJAF0DMMvHHef3lq1iczc
 Zm8eGu2oCdMQJJjNytRKEfDpFjyZbyS9nGtht/EMCRSB9mDqrTm2SaPQn3EKG6BinerJEf43wcr
 zzLBReE71mqLVdioBOX9OoJMWRiaSA1o8TqmQTamu
X-Gm-Gg: AYBFou0I7rkYSgQsSK0C+edmn9Zfwi8Y9FujQ65cmDfZL6Tv78dFs7RI/BqCiC/JJPp
 wGdzszZHKhLS+Qi3/fpTf8Hacr6qKP0LWWvJrCkx+5rfk+pBoO2pgQkOn6+H/KM+i8QVg5ughUA
 XVQ3ttrXiV7Ytw9yhTkBUVmPvGgooKgoAUcMQ2BiF9B+fXea/uRJwLGdV+0vlghJM/kyVSyNgHq
 1G9Mem/rRMa133iF6FgWTjhhhJfU+cr7lqlMMsJNlvSeIRrCWtPCgFM8geO5k55m/M2hQS+e0E7
 STcYyYrNIEFQKoc0wbgb7zS5zRUwvcR1JtQivn9scnub0q4TEftc/RjGER0CggDXhZzmqqGQyiR
 6ASkNzSpQ0aWdra3/8Rschq0dZuJdU0W3kwzjidSxhzQ058aKaiu+7lJ2djCJukR4ImtYTvQ=
X-Received: by 2002:a17:902:f642:b0:2e9:970c:2c2 with SMTP id
 d9443c01a7336-2eb364f3544mr129834625ad.48.1793720962242; Tue, 03 Nov 2026
 07:49:22 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 07:49:18 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 08:38:02 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261103-riscv-full-fit-support-v3-5-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
 <20261103-riscv-full-fit-support-v3-5-e1dcdc9638e5@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Nov 2026 07:49:18 -0800
X-Gm-Features: AclHuK_fKGkPAKokcEdrs2guMY9ImIo2_TncPHlqOrg7viVbE2hgGMH6it6MRQQ
Message-ID: <CAFLszThG5d2A3NT68adgycy2aDhu89LBZPbBmZzbh2E9ZYmfpw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] spl: fit: Record loadables to spl_image->fdt_addr
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
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

On 2026-11-03T09:53:01+11:00, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> spl: fit: Record loadables to spl_image->fdt_addr
>
> Record loadables to FDT passed to next boot stage.
>
> This is required for spl_invoke_opensbi(), for example, which requires
> u-boot/kernel load or entry address to fill opensbi_info.next_addr
> entry.
>
> spl_load_simple_fit() does it, make spl_load_fit_image() also capable of
> recording loadables into next stage.
>
> One limitation remains: if the FIT image does not contain an FDT blob,
> spl_load_fit_image() will not use gd->fdt_blob as a fallback,
> unlike spl_load_simple_fit() which does.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
>  common/spl/spl_fit.c | 80 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 64 insertions(+), 16 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
