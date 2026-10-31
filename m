Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ACA606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=axhoHpak;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=B0Ut9esx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84DAC60AF5;
	Sat, 31 Oct 2026 08:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rFw61h1tatjQ; Sat, 31 Oct 2026 08:43:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B768D60AE5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436211;
	b=N67SasrMH8RhLjQ4dnRtY/uKMg2VUyt2+28qseMZW4+rlFfihoIC3pwPxP226LA8hrsx
	 aS4WUxL4xdpdbdIzTatpRULtrx3dWYUvxK8PkRxbVpZj1a5hQ3itweKXhNo1TNwzfBz0h
	 TyZYRIHv/MyxAHRnirSKTAR8nSAPN9keB0CcYf2aX5moNMxDXuxXBOBTWhtPVvvxqq42c
	 ACLEu6Uuix4W705JdXpJ/vriMSMihsq0KLfcvYynLOn8IQZqW3OXQ+HTUN9dSyTTOairh
	 X2crXz71MKPzHrw3C+Ia8/1fIp1hpjJN12f83Wj5izDsNmAI2yAcXhiqhq10qr8ODWw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XRjf7rZv8DXQVGhCnUtHxgsGxEz2ZlUJjuzfCAwZrrA=;
	b=Ev/WNc6iFyhzqNCxyDRrN3Wa6wh873Tz6y25ylHqHUWjD8mw0PfmuvA61oyQgkqeLLdl
	 +t9Bv8cvbY3C6ELPI3Bc6CLvG9fxhWzTA2Ic96bhDc6VUxJ/iZZqMAnfNkqVJDCV+6AEu
	 JllEJXet2byPnSQbzsJ4+ybVFIn67eq1EfVkxO+Mi0HpKbJTQmFE7AGyjIlA8/QOqr8dX
	 H0o7N+okc183aXJkYRtv2kdSX2ISNFbjuyNTl0t7l3j1FhIswsME3ZwbWNbyLYqx2oQw/
	 pCafQSpZ7Wf0An+MHp+2dFFSlTRaNhh9fqQjI7OUm48AcmO2lPqdNJbHSHNOLem7PDg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436211;
	bh=XRjf7rZv8DXQVGhCnUtHxgsGxEz2ZlUJjuzfCAwZrrA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=axhoHpakCL3bMZFOxpvrKtHz4L8F4k+HVwHViRnYhETv4qw1ZEb8w5eMd6J3e2jJh
	 XHHUQOPAz152yPIGXQZmQGJEO118OrCSzcKe7N5eKrWIiTyP3eUVW3IW6xXMFiNnDy
	 GECRIRKecpJKAcKIYqaV7p058O1TIfpSj8NN2ZkEz4niHPUoFP6kZiBmBd4cBgR0NV
	 MZfUcQHS1h6hZLf91h+smbk6x90KBk6OkO5Fz2K4aGyEKaAHmOeADD6B68zXjEl03l
	 dbweWz9tX3qT0fFcyxCEF0geDq6uIbUkRxztslZhnhu3KEGQF9XIKNLhCdAgKOT63O
	 /7g3UlIA7l6Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B768D60AE5;
	Sat, 31 Oct 2026 08:43:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 913634BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8026940B0F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qbILiuFVt7I for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DDDE840B09
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436209;
 b=QcWXbEZBFWVgwWNbx87auYjUzya+eOdRGu4kCI7vFI7kqrK3Z0mKRZFjUlNLulEGtOJJ
 tjR0R6aeaO843ziY8fcMlBCfpSyKl8I9O/n1QlhXuRmQAZP+TIogBbIzdkQgkTygQqYE9
 wMckMqwrbLc409bxAtS5dJe/jeuQNsn4NYMD934blMRRhaQ/hBfQvmRxy4vLXtLQbZQ85
 QWKk3nMqRp34C8ztfX3t7B6ngVSD11n2NciOWWhzlEu2JAi9F/rUDk+l1+DLlmX5RC/Po
 T5nfWgVPDCf/7EgCjhd/bxLgNYXOWQ4dktjvAnwiar4RZ8diQMUaZk83HkJVwijdu/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436209;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XRjf7rZv8DXQVGhCnUtHxgsGxEz2ZlUJjuzfCAwZrrA=;
 b=cdOIz8JPw1JM1vQlOX8kULj9TskEw60uE18DII6t2VzuSBg6TwjXX49VemL9rgQjNIU3
 HxjNHjXdTjXIWg3THpNTbfnfvhgxDcg7khlsZUS8x63ysdTpFhO8YUHDKHZQ56dbST08j
 fTYlSxwyF0ft4AAD6qnXBqWIOq8wEoRhUGKS852PyOi1tm+zGPArn2G4t/kzTwPS/8P0y
 d2XCahN42UwZ/q/QtS0EuZSwJzlW6EyI7qzjSCqBgJNEaWNuOmoTpyEnVwAp9PHq7s41q
 8zjKKArg90vLK4IhK4YZxwzfc2HvzitV5r9CKo3HIlrwMU9T0DIpHkVptyS5PZniODw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=B0Ut9esx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=B0Ut9esx
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDDE840B09
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:28 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cd8ca57ef64so1151707a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436208; cv=none;
 d=google.com; s=arc-20260327;
 b=X2d0MW4+wKv4SQGy4AgU/q6dRMup+e8EpOwmRZrGTUkmIi0PsMO3r6+UZUsg5w3z74
 GPE1iVwrWhvE+eHAupJABQJMXjTUT0oMsBZ9SyWOlo/xYITLP+s/ABdJDARggMFTCIt/
 lqHh/moVnIkh+qkuR/vIV3JdPup8mIjxqU41RCCc7+TxCmVfNqCveXg8EjzyGVv636a+
 dt010m4zHX3fmtZt5PDYEP9MGH4jUD7Cgb08irVs35suwH6RvBIsc49UPdDo2ioldlO6
 JeejBXpGyZremgmOZ6xZDivlUBoUtSWJHSsjBYpzst6xKntxevYv/vbzOtQFW/SNs8d0
 n3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=XRjf7rZv8DXQVGhCnUtHxgsGxEz2ZlUJjuzfCAwZrrA=;
 fh=2sFKOQxPZ2fF4OeY0ZOzmC9Drhm014I8Rqivip9vN4I=;
 b=Ir/p6ArBV955ByBVfAyv+TXnzZ7J3WaTPfJyDETKx4AX2actwv5O6Mxqtch6pp9aVV
 IT4bheO9dRdjYNm1Wvfr/BdHw8I7DtbbwpietHx0XbEiyqHjWWisRv9u4Kcn0eo/xFAa
 a/BQvNaX/mT5YNzYtOODaa7tXXIPP4n05dmyDDCGqbTEqPysyRLq+stVPj5hZZBabNcN
 60M78NTJ/YJ2jjAUNfHQWXnm2t/f088sB2CpbgoZcFgEOZxHzUwnLY7+4LPHFccURTg1
 iv5hJJvWTWl4NeKhk2L1BO8OxnGZi8QJX8UfXRRfYfe22ob4VAormU1GUHGBg1OCnDRE
 0Ilw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436208; x=1794041008;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XRjf7rZv8DXQVGhCnUtHxgsGxEz2ZlUJjuzfCAwZrrA=;
 b=B0Ut9esx86VNCruz5FqUI+kPEfCqtZHFVGiAeQA17BIizCqQVmjrmuPoTIhpPxdGz8
 pOUbJ3EAvukKrN+UrCYicVYBuvNeekQBlcqBln9MQXxXPKWftamuSKLcsEcoiE+WIari
 NXiNGRYkS89K/8Sl2/cCKoay+CP3lF7zP7r9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436208; x=1794041008;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XRjf7rZv8DXQVGhCnUtHxgsGxEz2ZlUJjuzfCAwZrrA=;
 b=sWJ52EO54xkr9wX53JeNcAdD3hA6m1WACNZ6Zovhj7/Z3unmm0Wr9aq520CDGjg3TM
 QYiRMvf72bIMU4PNl/hK9ABnWdkCmzNpwNCag839QrYDUC+zA7z7VLCnf7xGS3hEzk0n
 xH/CYoat4WSFW374dpCHO7H4tXn3jBi4sl6q0a1ro/bKNcAy8rwIc1XaBo+NLRW1E1cS
 X5MmysjLNQSAgtN5hQGyrHZr1JUfI2Vq+TaHxGZmx8rJB7bf2ug6+ve+B+awHtaeBUiU
 cHzBYo4P28hNI2Y/a/M8Mw4nizDkCBRpAEOHieDCtdACX4/il4hL5NNIcDFyFseQRWdv
 zayg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeEszFAtvfMy8eT5aCMeULpvvshnasUD5CueJqL424j0hN9K2oxDVdsvaTGnV/m8DL0facyoU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLv0ubKa56ys7u8BCMNjr3lAiffWTCFGbtu1z3z2JNF6n5kuGhs
 K5GC1N2Su6byuUkn1ivZeYQ49oY6VUw1/X62kdBHqZlarDG2s4q/YUNPe+r6e3dBygCFt0K7LJw
 wfH1hYPErVjvLyLqr+7kmglj+f8uWOS84nYKTAeHA
X-Gm-Gg: AYBFou2FTcZm6GdHjKSnT4Y3ayMBqTCqOeYFVffshj7MxKImvmfu5c4CplyTZzHMhsN
 hvKFGwpMy0la96RtG/dI2EcbvGZoihvfkkgHmJIiTE98rctKNlsZwOHwK4HUjpWd/RYzwGFXEUX
 9x3MJiPb2CTyVZ7cxXpopG6c47Ppn5iauNymdZHnb0JTf0AiFD9Kar8XHa2BW+L6coXQxLHIZ3Q
 xtJB0uu/4OD651BqqPMeVvK/ATWVh7cgXwtbg440Qgv4Xdr2xN/HJy9cSJkVpvCAv0BTVG4sxmv
 681Mrx74Y/4lFmhVVWwyUeq8YB9LuflgGqwYSMsUVNygnRVKJGl69uNMOFoK3UMhp1wY+i4K7qF
 dpMIUbdm9DGjfanxHXxeJvQsmA+NadQtXH2ycbyq+4QNWuCT6Dvr0qUrn6Vmd8SjD50xMvi4=
X-Received: by 2002:a17:90b:2ecd:b0:3ab:b39f:41ca with SMTP id
 98e67ed59e1d1-3ae8979834cmr2427148a91.31.1793436207884; Sat, 31 Oct 2026
 01:43:27 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:43:22 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:42:00 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029050738.1107663-10-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-10-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:43:22 -0700
X-Gm-Features: AclHuK_p1arMf9gdeC7YjP5iPhNx2nJax-MF_AevgBkaSodEYsgNHewInrL90fE
Message-ID: <CAFLszTjY5vKOwaa2nis=HdNvSO3kFh_xu_MPevApBJnPPbZpWw@mail.gmail.com>
Subject: Re: [PATCH v6 09/20] LoongArch: Exception handling
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
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

Hi Jiaxun,

On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: Exception handling
>
> Add exception entry assembly code, import stackframe.h
> from Linux, provide debug prints when exception happens.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  arch/loongarch/Kconfig                  |  19 ++++
>  arch/loongarch/cpu/Makefile             |   2 +-
>  arch/loongarch/cpu/genex.S              |  21 ++++
>  arch/loongarch/include/asm/stackframe.h | 175 ++++++++++++++++++++++++++++++
>  arch/loongarch/lib/interrupts.c         | 185 ++++++++++++++++++++++++++++++++
>  5 files changed, 401 insertions(+), 1 deletion(-)

> diff --git a/arch/loongarch/lib/interrupts.c b/arch/loongarch/lib/interrupts.c
> @@ -0,0 +1,185 @@
> +#if IS_ENABLED(CONFIG_SHOW_REGS)
> +	show_regs(regs);
> +#endif

show_regs() is already __maybe_unused, so please can you use a plain
if (IS_ENABLED(CONFIG_SHOW_REGS)) here, as you do for FRAMEPOINTER
just below? LoongArch has no SPL support yet, so it is fine to leave
out SPL_SHOW_REGS.

In any case:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
