Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RVqSp3oO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E/khd/Se
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37B0C60A8D;
	Sat, 24 Oct 2026 10:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Hk14S67zM5t; Sat, 24 Oct 2026 10:12:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB88E60A83
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836762;
	b=ZOFPjXo3CkONidarL4oXuXAqLvUbRd+EyD7WQs+cvfHODAlMtKHW2oPoRxQqCqbsqLaP
	 EyX5eRw4nPbakOTsaOG7b9JoFpG/wRT751LEAsFgeRsr5vzrI6HY3wmxeaM436iSCJoKX
	 ny6KIaCeC78zABWDgyVNqO1ilCg/yvkj+7qVqW8mzdV1R2wUgRD4W6WrYc6hLFIvovNgF
	 LzsACokUzQ9YgmKjzhxRnBFQFKhgg8Y/TKOOKGq9qNTThoBDHFUdzxDk4x3PLsb7M9lFe
	 saNR2z88I3XmNBuvQci0fPmBANsI41jP8P8Wtip//fJUC16Xfth231xDd8DH3VjO36A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792836762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XoFfpjlFKaASJPGE+tZy+PFOhzOjIDOotUDlkigGt0E=;
	b=en78TcIwu/Jt086xnZ58s/pwTCaNasjH9kjvjzBkQex3TcyhRVoZmhPlI8/fHfjqUBfJ
	 c8VgJMjzFfMlC+Z7C5J6emoJUcApdIQOImNtnoeM0BwYxG3iKvnSf46I5k7sKNzsUFYRP
	 t/IwAtMj72cBQUAhQeRslxUgY/qT7hl6P7GJU2iU3Q125RL+KqsJT3+2qgt+diTxsoSwo
	 f9SsX5dGF2AqCYvdqHNoXYR+eWCZU9ggt5EwsI+pf5J5WXEdDnEPSu/8vaYzxE/06eoV9
	 Mo+kSfPBZvqynAnncM3k25iPU7mhPCJQ1sTA69ajrPGKcFw9r1Lp/NXcbZXF16ieZ7A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="E/khd/Se";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792836762;
	bh=XoFfpjlFKaASJPGE+tZy+PFOhzOjIDOotUDlkigGt0E=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RVqSp3oOCAUUeqKIe6ZwIK/IBk2VYSFZWs/90pe6R205FQajDZ8WZRM9TQxniN0n5
	 GrQLIHCEZoFFd1LY5pOWSCjWQetzRkSQ/AM7hMZtyyfTqvrrXC8Xn8POPArSk0druO
	 zw6hl9DFT3+9g16zkYd0knHgcGzmhSQfY8CsUFttasfNTXw/xjjEa5KdZuzNSTrRk2
	 yvRIFk2+dGjy0xw191vTNXnRy1wxKSLZA+LEyv7FrsPOW0FiyEInLJhHr1UxdahX2d
	 hBQaN7CSKpvFWhiuj8j7KsvHqBiMRf4CGHtucI7k1TDHw2kE3uJRM3QxyMCzyOm0OS
	 WGDnIJ1/JlbfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB88E60A83;
	Sat, 24 Oct 2026 10:12:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A96BC235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BAA16072D
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iIFRmJg1QW-6 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:12:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F00A60735
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::231"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836759;
 b=o+7jXBCt2hyLYZ5M5IgiyQ+dNWNhN+/552xdndgNc6FHvPxTqj/XzgPAFHMPzMK+iW4z
 Gfpr2ucmXBvF/5xBmBoqqbMM8yyy4WNUv8Sl5O+SZb33qsDPzwv/At1MZ+PWssYzQVsuG
 eMNzZafZB59FiIm8YM3y5L8ffq/epk3GuK+eX/CSE4oZoEIBdX/zlfT96X9C1RLOy4RVA
 IowpjCizglExSE4COuiwRVQIFO/ebLQcOUwt7X1NQOAv9jaKRR2qCYeIKL+aCk2rc9Bm7
 M2W7ECtnreBaHt3n3Qd87ypkbBkd1AkY2SRwXFU9qw4sbjPWwRv9+FXBBnEiNFacycA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792836759;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=XoFfpjlFKaASJPGE+tZy+PFOhzOjIDOotUDlkigGt0E=;
 b=i+fy9FH4S4ElTy0pQ742FfIYIWqXfFItibSGOmLDr4k4Mo43PI/NH/vf2lBrL99ehkVA
 0c7ldaTmZhtFqH73qRTw29yzUJrqQmOMhyKTZQWJvUmw41Er2nbUwGv7oCmLVZ2ZUy2RI
 buJkYL9EBs3jB+UNSA+m2EVM6Hi06Bm38RdkWOhZx5SvMnFtDG5eQnTKkjV9iyG5hSVP3
 iRA4xkw5L8B+24O7tYHNin4fHwj5hs0OkbzTW0bGJAbawWmEWxk62yO0jsgVBXAHDWzv1
 lgPqenr+51pudsiX39CqSAgKlXMcLorLRw14EoDH0DFtMDdCxFGXrz5rXrsNGLAhqnw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="E/khd/Se"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E/khd/Se
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F00A60735
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:38 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a451915d8aso1241578b6e.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 03:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792836758; cv=none;
 d=google.com; s=arc-20260327;
 b=HOMByUeX2Zcv4rSsfKBOpLiPDYG9X5HEOY+4/y7kxPkZHyd7JWy9xbdo3VKRAbwMaZ
 bcAemGdDa1lCce7xNDahsmSuRaohTFcm96+BjsSGlE3eHn51mrImq6t/e01oE70ZGJ0H
 8nbZuPjyVD5uPr+UpmfX7z/8GrI1MFRfsynxV09qiV32GXrOREWE9gHDZZkomtEjV/Fx
 3xr+n5p3Lg9PoMjGwrd5fO0slyd/DQ6pQht0JS6UXXsPFYNZHvF09rVQyD6DER3iR3vz
 b6YirKVueGplMjuVLj2XGTr6nn8eMXpZ+/kdUXVeiRHAjfYp17ToNIOfx0ao0Wo1XS+J
 cReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=XoFfpjlFKaASJPGE+tZy+PFOhzOjIDOotUDlkigGt0E=;
 fh=Y1ZREHJ+pHB0HlzZ/KBn18KcwK0OUTCLdCrezQyH/Kw=;
 b=Eg5GgnmCAvlzBWz5IaQYESG64iS9qbpR48kmZAUY8tXM3DLwsb+YznNXsBYGcreXAu
 m73qyNzU/HlgypbvpnVHN8URA1oUvQrQ50b0osrbaMZ8xFNYj3Svw/pw9AKGaDcs5La5
 MbZT/Bng0ZZwm4M3q3AgmDiA0MVhN3iyCeZhcStFurfDXWA2TLTGbSxD3FhBQGHBL75/
 dpXuZpYgnJl36vsdqPDTcikzWePdRK1enW0ISqZTkYsYt4BclG+uW2tJoqndf4yy5QaX
 axjXkQXMhvwHcR9k98yxALUei0f3gb/wVVDeGJp76ZaAc9BZwRr0lrz8bbohNddXhJAR
 Xm+Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792836758; x=1793441558;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XoFfpjlFKaASJPGE+tZy+PFOhzOjIDOotUDlkigGt0E=;
 b=E/khd/Se+wfYoi8IvDK1nW7OnYGLqjQ8oBnJqwY681M5ayn9DXZAx+WU8yY5LQr7ic
 QP83vwJkrcUmAX+Sim3iXcQaasJLn2MU5eCIKmwi51prdpPa182Vi5KP10hfJJN/a983
 8i31saABH4v8X0tJezDc4PPY+lcvUmq6tFrh6oQyUsr95vsLzPplxWtPqqdG2QO/WDSK
 UtOZRmVvDdo01OxVcel2KRBIFpk/f7rcNPfXQF3Q7p3s1ByPRR57Fw4IlXxe/neCLbbf
 Q0M0crNsK9gcxEl0z2GJbPrygq8ZVKIK/s4rYKd2+bsOg8RtOBJY8afxRsO/P1gXNRak
 GMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836758; x=1793441558;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XoFfpjlFKaASJPGE+tZy+PFOhzOjIDOotUDlkigGt0E=;
 b=M1jLEzSi12ACXUvlwzauexunD8xa2kIX0Dm74TVP83LzzPwdoxbsgqI6nLWiFizU7v
 BtMFPhJwIzeDSnfitxh2GsGcbkZzTVhBV3Iuevdp1bbUMpD8poI1J7U5vlzOlXaP+qDB
 AoUlE5IcMHAQ9595d6kOccAk0sEA8xHBreIEjpxVy9NDChMXPYIKsSH2mm+CsFsEuhxO
 SFplUxEJHX44WRaVGDdqQdsSBnV0AfwnDNHhvMN/TGMu8FH9IAV3MBgp/e1aqCWwNEx6
 gkCNhLhIlkNPDiB+o/wHsBgZA9CLwIqpQ/wvMA+3D3mBWtg3VouG/ei+wzGtQhMq8SzH
 sbjg==
X-Gm-Message-State: AFq9FYKIUE4tnpzNyOKuGvnIv2kUJrA0Df/FQyyK/T6TNcOtPE2373GK
 2JWd0lmVjmIXD0tJEjWNOj1SkgWyXdA7FwkSQQMD1pJPXUi1t7MG2nr+0hM2f+NwGWG7bewCtX9
 UkfM8BzCXCGlbljNwN9Ox7fl5bqPNH4B7gKSh
X-Gm-Gg: AYBFou2Ufwhz5voQpGn3d91JabIsyLJHZ3rIoICscubs1SN6uGDKa0yzsslTgwZN+9A
 lpYwkbCqYwGigGdVyvjjui4wfvX2QF76XgyRdzOuJLI1/BFf7Gr7Z4fssZ3TRZoJtppl8AUPJXa
 rkERCYDjr6232AecLHU6oDasGQKk1e76+LCqdUOlF3MO/kIU+v+Jhu1jlDHeGvFPJ9BPZGv+Sa0
 tRaISRDeybsHmhtZk0d+Znf9xqDrlkzxkExpj/6aS6GrNFTOYe0lrxSTTgJptrvXwhdrxx9gwvR
 ICzJp5zv+8I7VpEIKOWTt7bOPY1g5Isef2Y/ca4Q4CHOeSdAht52AeFFLT58KB6ChG8mihBTBCg
 ZEDSFFhqC7rI1m1OhFHyl2lzGona2sNJSxReakw==
X-Received: by 2002:a05:6808:c1a6:b0:552:9d62:f1b6 with SMTP id
 5614622812f47-55c0039eb9bmr911775b6e.51.1792836757664; Sat, 24 Oct 2026
 03:12:37 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:34 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:34 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
References: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 03:12:34 -0700
X-Gm-Features: AclHuK-EqQDrFKJraAYF63xebJcl8eUNRAMVdeL-AsaiKM4t8E1mM3xCqIjDZXE
Message-ID: <CAJnxHsiBj7VEdx4e4LwPuChoHMKuVrxiOJds3gBv+mxt8LAVcw@mail.gmail.com>
Subject: [PATCH 1/9] block: Refuse a device with an unsupported block size
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000014d565065e93567c"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000014d565065e93567c
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000014d565065e93567c
Content-Type: text/plain; charset="utf-8"; name="0001.patch"
Content-Disposition: attachment; filename="0001.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: b8affc462074dd9a_0.1

QSBibG9jayBkcml2ZXIgc2V0cyBibGtzeiBhbmQgbG9nMmJsa3N6IGZyb20gd2hhdCB0aGUgZGV2
aWNlIHJlcG9ydHM6IHRoZQpSRUFEIENBUEFDSVRZIHJlcGx5IG9mIGEgVVNCIHN0aWNrIG9yIGEg
U0NTSSBkaXNrLCB0aGUgTEJBIGZvcm1hdCBvZiBhbgpOVk1lIG5hbWVzcGFjZSwgdGhlIHNlY3Rv
ciBzaXplIG9mIGEgWGVuIGJhY2tlbmQuIEFwYXJ0IGZyb20gdGhlIHZpcnRpbwpibG9jayBkcml2
ZXIgYW5kIHRoZSBob3N0IGNvbW1hbmQsIG5vdGhpbmcgY2hlY2tzIHRoZSB2YWx1ZSBiZWZvcmUK
YmxrX3Bvc3RfcHJvYmUoKSBzY2FucyB0aGUgZGV2aWNlIGZvciBwYXJ0aXRpb25zLCB5ZXQgdGhl
IHBhcnRpdGlvbiBhbmQKZmlsZXN5c3RlbSBjb2RlIHJlbGllcyBvbiBpdDoKCi0gcGFydF9nZXRf
aW5mb19leHRlbmRlZCgpIGFuZCBwcmludF9wYXJ0aXRpb25fZXh0ZW5kZWQoKSByZWFkIG9uZSBi
bG9jawogIGludG8gYSBidWZmZXIgb2YgYmxrc3ogYnl0ZXMgYW5kIHBhcnNlIHRoZSBwYXJ0aXRp
b24gdGFibGUgYXQgb2Zmc2V0CiAgMHgxYmUsIHBhc3QgdGhlIGVuZCBvZiBhIGJsb2NrIHNtYWxs
ZXIgdGhhbiA1MTIgYnl0ZXMKLSBmc19kZXZyZWFkKCkgY29udmVydHMgYnl0ZXMgdG8gYmxvY2tz
IHdpdGggc2hpZnRzIGJ5IGxvZzJibGtzeiwgbWFza3MKICBieSBibGtzeiAtIDEgYW5kIGRpdmlz
aW9ucyBieSBibGtzeiwgd2hpY2ggb25seSBhZ3JlZSB3aGVuIGJsa3N6IGlzIGEKICBwb3dlciBv
ZiB0d287IHdpdGggYW55IG90aGVyIHZhbHVlIGl0IHJlYWRzIG1vcmUgYnl0ZXMgaW50byB0aGUK
ICBjYWxsZXIncyBidWZmZXIgdGhhbiB0aGUgY2FsbGVyIGFza2VkIGZvcgotIGJ1ZmZlcnMgb2Yg
Ymxrc3ogYnl0ZXMgZ28gb24gdGhlIHN0YWNrLCBzbyBhIGJsb2NrIHNpemUgaW4gdGhlCiAgZ2ln
YWJ5dGVzIG92ZXJydW5zIGl0CgpBZGQgYmxrX3ZhbGlkX2Jsa3N6KCksIHdoaWNoIGFjY2VwdHMg
YSBwb3dlciBvZiB0d28gZnJvbSA1MTIgYnl0ZXMgdXAgdG8KQkxLX01BWF9CTEtTWiAoNjRLaUIs
IHRoZSBsYXJnZXN0IGxvZ2ljYWwgYmxvY2sgc2l6ZSBMaW51eCBhY2NlcHRzKSwgYW5kCnJlZnVz
ZSB0byBwcm9iZSBhIGJsb2NrIGRldmljZSB3aG9zZSBibG9jayBzaXplIGl0IHJlamVjdHMsIG9y
IHdob3NlCmxvZzJibGtzeiBkb2VzIG5vdCBtYXRjaCBpdHMgYmxrc3osIGJlZm9yZSBpdHMgcGFy
dGl0aW9ucyBhcmUgc2Nhbm5lZC4KVGhpcyBjb3ZlcnMgZXZlcnkgYmxvY2sgZHJpdmVyIGluIG9u
ZSBwbGFjZS4KCkEgZGV2aWNlIHdpdGggbmVpdGhlciBhIHNpemUgbm9yIGEgYmxvY2sgc2l6ZSwg
d2hpY2ggaXMgaG93IHRoZSBTQ1NJCmNvZGUgbGVhdmVzIGEgcmVtb3ZhYmxlIGRyaXZlIHdpdGhv
dXQgYSBtZWRpdW0sIGlzIHN0aWxsIHByb2JlZCwgYnV0IGl0cwpwYXJ0aXRpb25zIGFyZSBubyBs
b25nZXIgc2Nhbm5lZDogcGFydF90ZXN0X2RvcygpIHdvdWxkIG90aGVyd2lzZSBwYXJzZQo1MTIg
Ynl0ZXMgb2YgYSB6ZXJvLXNpemVkIGJ1ZmZlci4KClVzZSB0aGUgaGVscGVyIGluIHRoZSB2aXJ0
aW8gYmxvY2sgZHJpdmVyIGFuZCB0aGUgaG9zdCBjb21tYW5kIHRvbywgc28KdGhhdCB0aGV5IGFs
c28gcmVmdXNlIGEgYmxvY2sgc2l6ZSBhYm92ZSA2NEtpQi4KClNpZ25lZC1vZmYtYnk6IEFuYSBC
b2JpbGxvIDxhbmFib2JpbGxvM0BnbWFpbC5jb20+Ci0tLQogY21kL2hvc3QuYyAgICAgICAgICAg
ICAgICAgIHwgIDYgKysrLS0tCiBkcml2ZXJzL2Jsb2NrL2Jsay11Y2xhc3MuYyAgfCAxNSArKysr
KysrKysrKystLQogZHJpdmVycy92aXJ0aW8vdmlydGlvX2Jsay5jIHwgIDMgKy0tCiBpbmNsdWRl
L2Jsay5oICAgICAgICAgICAgICAgfCAyMCArKysrKysrKysrKysrKysrKysKIHRlc3QvZG0vYmxr
LmMgICAgICAgICAgICAgICB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIDUgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9jbWQvaG9zdC5jIGIvY21kL2hvc3QuYwppbmRleCA1MWYyYjFlM2Y2ZS4uNmE3
MTViZWQzOWQgMTAwNjQ0Ci0tLSBhL2NtZC9ob3N0LmMKKysrIGIvY21kL2hvc3QuYwpAQCAtMTMs
NyArMTMsNiBAQAogI2luY2x1ZGUgPGRtL2RldmljZS1pbnRlcm5hbC5oPgogI2luY2x1ZGUgPGRt
L3VjbGFzcy1pbnRlcm5hbC5oPgogI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+Ci0jaW5jbHVkZSA8
bGludXgvbG9nMi5oPgogCiBzdGF0aWMgaW50IGRvX2hvc3RfbG9hZChzdHJ1Y3QgY21kX3RibCAq
Y21kdHAsIGludCBmbGFnLCBpbnQgYXJnYywKIAkJCWNoYXIgKmNvbnN0IGFyZ3ZbXSkKQEAgLTY3
LDggKzY2LDkgQEAgc3RhdGljIGludCBkb19ob3N0X2JpbmQoc3RydWN0IGNtZF90YmwgKmNtZHRw
LCBpbnQgZmxhZywgaW50IGFyZ2MsCiAJZmlsZSA9IGFyZ3ZbMV07CiAJaWYgKGFyZ2MgPiAyKSB7
CiAJCWJsa3N6ID0gZGVjdG91bChhcmd2WzJdLCBOVUxMKTsKLQkJaWYgKGJsa3N6IDwgREVGQVVM
VF9CTEtTWiB8fCAhaXNfcG93ZXJfb2ZfMihibGtzeikpIHsKLQkJCXByaW50ZigiYmxrc3ogbXVz
dCBiZSA+PSA1MTIgYW5kIHBvd2VyIG9mIDJcbiIpOworCQlpZiAoIWJsa192YWxpZF9ibGtzeihi
bGtzeikpIHsKKwkJCXByaW50ZigiYmxrc3ogbXVzdCBiZSBhIHBvd2VyIG9mIDIgZnJvbSAlZCB0
byAlZFxuIiwKKwkJCSAgICAgICBERUZBVUxUX0JMS1NaLCBCTEtfTUFYX0JMS1NaKTsKIAkJCXJl
dHVybiBDTURfUkVUX0ZBSUxVUkU7CiAJCX0KIAl9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2Nr
L2Jsay11Y2xhc3MuYyBiL2RyaXZlcnMvYmxvY2svYmxrLXVjbGFzcy5jCmluZGV4IDZkMjE2MWNm
YzdiLi5kN2I5NDZmMmRiYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ibG9jay9ibGstdWNsYXNzLmMK
KysrIGIvZHJpdmVycy9ibG9jay9ibGstdWNsYXNzLmMKQEAgLTgyOCw5ICs4MjgsMjAgQEAgc3Rh
dGljIGludCBwYXJ0X2NyZWF0ZV9ibG9ja19kZXZpY2VzKHN0cnVjdCB1ZGV2aWNlICpibGtfZGV2
KQogCiBzdGF0aWMgaW50IGJsa19wb3N0X3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpCiB7Ci0J
aWYgKENPTkZJR19JU19FTkFCTEVEKFBBUlRJVElPTlMpICYmIGJsa19lbmFibGVkKCkpIHsKLQkJ
c3RydWN0IGJsa19kZXNjICpkZXNjID0gZGV2X2dldF91Y2xhc3NfcGxhdChkZXYpOworCXN0cnVj
dCBibGtfZGVzYyAqZGVzYyA9IGRldl9nZXRfdWNsYXNzX3BsYXQoZGV2KTsKKworCS8qIEEgcmVt
b3ZhYmxlIGRldmljZSB3aXRob3V0IGEgbWVkaXVtIGhhcyBubyBzaXplIHlldCAqLworCWlmICgh
ZGVzYy0+Ymxrc3ogJiYgIWRlc2MtPmxiYSkKKwkJcmV0dXJuIDA7CisKKwlpZiAoIWJsa192YWxp
ZF9ibGtzeihkZXNjLT5ibGtzeikgfHwKKwkgICAgZGVzYy0+bG9nMmJsa3N6ICE9IExPRzIoZGVz
Yy0+Ymxrc3opKSB7CisJCWxvZ19lcnIoIiVzOiB1bnN1cHBvcnRlZCBibG9jayBzaXplICVsdSAo
bG9nMiAlZClcbiIsCisJCQlkZXYtPm5hbWUsIGRlc2MtPmJsa3N6LCBkZXNjLT5sb2cyYmxrc3op
OworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CiAKKwlpZiAoQ09ORklHX0lTX0VOQUJMRUQoUEFSVElU
SU9OUykgJiYgYmxrX2VuYWJsZWQoKSkgewogCQlwYXJ0X2luaXQoZGVzYyk7CiAKIAkJaWYgKGRl
c2MtPnBhcnRfdHlwZSAhPSBQQVJUX1RZUEVfVU5LTk9XTiAmJgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX2Jsay5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX2Jsay5jCmluZGV4
IDQwNGQ5MTQwY2IyLi45OGJmYzgzNjljYyAxMDA2NDQKLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX2Jsay5jCisrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19ibGsuYwpAQCAtMTIsNyArMTIs
NiBAQAogI2luY2x1ZGUgPHZpcnRpb190eXBlcy5oPgogI2luY2x1ZGUgPHZpcnRpby5oPgogI2lu
Y2x1ZGUgPHZpcnRpb19yaW5nLmg+Ci0jaW5jbHVkZSA8bGludXgvbG9nMi5oPgogI2luY2x1ZGUg
PGxpbnV4L2Vyci5oPgogI2luY2x1ZGUgInZpcnRpb19ibGsuaCIKICNpbmNsdWRlIDxtYWxsb2Mu
aD4KQEAgLTI2Myw3ICsyNjIsNyBAQCBzdGF0aWMgaW50IHZpcnRpb19ibGtfcHJvYmUoc3RydWN0
IHVkZXZpY2UgKmRldikKIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKGRldiwgVklSVElPX0JMS19G
X0JMS19TSVpFKSkgewogCQl2aXJ0aW9fY3JlYWQoZGV2LCBzdHJ1Y3QgdmlydGlvX2Jsa19jb25m
aWcsIGJsa19zaXplLCAmYmxrX3NpemUpOwogCQlkZXNjLT5ibGtzeiA9IGJsa19zaXplOwotCQlp
ZiAoIWlzX3Bvd2VyX29mXzIoYmxrX3NpemUpIHx8IGRlc2MtPmJsa3N6IDwgNTEyKQorCQlpZiAo
IWJsa192YWxpZF9ibGtzeihibGtfc2l6ZSkpCiAJCQlyZXR1cm4gLUVJTzsKIAl9IGVsc2Ugewog
CQlkZXNjLT5ibGtzeiA9IDUxMjsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxrLmggYi9pbmNsdWRl
L2Jsay5oCmluZGV4IDJjYjljYjMxYWMyLi5kN2VmYjYwMTJlZSAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9ibGsuaAorKysgYi9pbmNsdWRlL2Jsay5oCkBAIC0xMCw2ICsxMCw3IEBACiAjaW5jbHVkZSA8
Ym91bmNlYnVmLmg+CiAjaW5jbHVkZSA8ZG0vdWNsYXNzLWlkLmg+CiAjaW5jbHVkZSA8ZWZpLmg+
CisjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4KIAogI2lmZGVmIENPTkZJR19TWVNfNjRCSVRfTEJB
CiB0eXBlZGVmIHVpbnQ2NF90IGxiYWludF90OwpAQCAtMjIsOSArMjMsMjggQEAgdHlwZWRlZiB1
bG9uZyBsYmFpbnRfdDsKICNkZWZpbmUgTEJBRlUgIiUiIExCQUZsZW5ndGggInUiCiAKICNkZWZp
bmUgREVGQVVMVF9CTEtTWgkJNTEyCisvKiBMYXJnZXN0IGJsb2NrIHNpemUgc3VwcG9ydGVkLCBh
cyBpbiBMaW51eCAqLworI2RlZmluZSBCTEtfTUFYX0JMS1NaCQlTWl82NEsKIAogc3RydWN0IHVk
ZXZpY2U7CiAKKy8qKgorICogYmxrX3ZhbGlkX2Jsa3N6KCkgLSBDaGVjayB0aGF0IGEgYmxvY2sg
c2l6ZSBpcyBzdXBwb3J0ZWQKKyAqCisgKiBUaGUgYmxvY2ssIHBhcnRpdGlvbiBhbmQgZmlsZXN5
c3RlbSBjb2RlIHNpemUgYnVmZmVycyBieSB0aGUgYmxvY2sgc2l6ZSwKKyAqIGV4cGVjdCBhIGJs
b2NrIHRvIGhvbGQgYXQgbGVhc3QgYSA1MTItYnl0ZSBib290IHNlY3RvciBhbmQgY29udmVydCBi
ZXR3ZWVuCisgKiBieXRlcyBhbmQgYmxvY2tzIHdpdGggbG9nMihibG9jayBzaXplKSwgc28gYSBk
ZXZpY2UgaXMgb25seSB1c2FibGUgd2l0aCBhCisgKiBibG9jayBzaXplIHRoYXQgaXMgYSBwb3dl
ciBvZiB0d28gZnJvbSBERUZBVUxUX0JMS1NaIHRvIEJMS19NQVhfQkxLU1ouCisgKgorICogQGJs
a3N6OiBCbG9jayBzaXplIGluIGJ5dGVzCisgKiBSZXR1cm46IHRydWUgaWYgQGJsa3N6IGlzIHN1
cHBvcnRlZCwgZmFsc2UgaWYgbm90CisgKi8KK3N0YXRpYyBpbmxpbmUgYm9vbCBibGtfdmFsaWRf
Ymxrc3oodW5zaWduZWQgbG9uZyBibGtzeikKK3sKKwlyZXR1cm4gYmxrc3ogPj0gREVGQVVMVF9C
TEtTWiAmJiBibGtzeiA8PSBCTEtfTUFYX0JMS1NaICYmCisJICAgICAgICEoYmxrc3ogJiAoYmxr
c3ogLSAxKSk7Cit9CisKIHN0YXRpYyBpbmxpbmUgYm9vbCBibGtfZW5hYmxlZCh2b2lkKQogewog
CXJldHVybiBDT05GSUdfSVNfRU5BQkxFRChCTEspIHx8IElTX0VOQUJMRUQoQ09ORklHX1NQTF9M
RUdBQ1lfQkxPQ0spOwpkaWZmIC0tZ2l0IGEvdGVzdC9kbS9ibGsuYyBiL3Rlc3QvZG0vYmxrLmMK
aW5kZXggZjY3ODY5MTA3ZGEuLjgwNDQxZjcyM2M3IDEwMDY0NAotLS0gYS90ZXN0L2RtL2Jsay5j
CisrKyBiL3Rlc3QvZG0vYmxrLmMKQEAgLTksNiArOSw3IEBACiAjaW5jbHVkZSA8c2FuZGJveF9o
b3N0Lmg+CiAjaW5jbHVkZSA8dXNiLmg+CiAjaW5jbHVkZSA8YXNtL3N0YXRlLmg+CisjaW5jbHVk
ZSA8ZG0vZGV2aWNlLWludGVybmFsLmg+CiAjaW5jbHVkZSA8ZG0vdGVzdC5oPgogI2luY2x1ZGUg
PHRlc3QvdGVzdC5oPgogI2luY2x1ZGUgPHRlc3QvdXQuaD4KQEAgLTExMyw2ICsxMTQsNDYgQEAg
c3RhdGljIGludCBkbV90ZXN0X2Jsa19maW5kKHN0cnVjdCB1bml0X3Rlc3Rfc3RhdGUgKnV0cykK
IH0KIERNX1RFU1QoZG1fdGVzdF9ibGtfZmluZCwgVVRGX1NDQU5fUERBVEEgfCBVVEZfU0NBTl9G
RFQpOwogCisvKiBUZXN0IHRoYXQgYSBibG9jayBkZXZpY2Ugd2l0aCBhbiB1bnN1cHBvcnRlZCBi
bG9jayBzaXplIGlzIHJlZnVzZWQgKi8KK3N0YXRpYyBpbnQgZG1fdGVzdF9ibGtfYmxrc3ooc3Ry
dWN0IHVuaXRfdGVzdF9zdGF0ZSAqdXRzKQoreworCXN0YXRpYyBjb25zdCB1bG9uZyBnb29kW10g
PSB7IERFRkFVTFRfQkxLU1osIFNaXzRLLCBCTEtfTUFYX0JMS1NaIH07CisJc3RhdGljIGNvbnN0
IHVsb25nIGJhZFtdID0geyAyNTYsIDUyMCwgMyAqIERFRkFVTFRfQkxLU1osCisJCQkJICAgICAy
ICogQkxLX01BWF9CTEtTWiB9OworCXN0cnVjdCB1ZGV2aWNlICpibGssICpkZXY7CisJc3RydWN0
IGJsa19kZXNjICpkZXNjOworCWNoYXIgbGFiZWxbMTBdOworCWludCBpOworCisJZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUoZ29vZCk7IGkrKykgeworCQlzbnByaW50ZihsYWJlbCwgc2l6ZW9m
KGxhYmVsKSwgImdvb2QlZCIsIGkpOworCQl1dF9hc3NlcnRvayhob3N0X2NyZWF0ZV9kZXZpY2Uo
bGFiZWwsIGZhbHNlLCBnb29kW2ldLCAmZGV2KSk7CisJCXV0X2Fzc2VydG9rKGJsa19nZXRfZnJv
bV9wYXJlbnQoZGV2LCAmYmxrKSk7CisJCWRlc2MgPSBkZXZfZ2V0X3VjbGFzc19wbGF0KGJsayk7
CisJCXV0X2Fzc2VydGVxKGdvb2RbaV0sIGRlc2MtPmJsa3N6KTsKKwl9CisKKwlmb3IgKGkgPSAw
OyBpIDwgQVJSQVlfU0laRShiYWQpOyBpKyspIHsKKwkJc25wcmludGYobGFiZWwsIHNpemVvZihs
YWJlbCksICJiYWQlZCIsIGkpOworCQl1dF9hc3NlcnRvayhob3N0X2NyZWF0ZV9kZXZpY2UobGFi
ZWwsIGZhbHNlLCBiYWRbaV0sICZkZXYpKTsKKwkJdXRfYXNzZXJ0ZXEoLUVJTlZBTCwgYmxrX2dl
dF9mcm9tX3BhcmVudChkZXYsICZibGspKTsKKwl9CisKKwkvKiBBIGRldmljZSB3aXRob3V0IGEg
bWVkaXVtIGhhcyBubyBibG9jayBzaXplIHlldCAqLworCXV0X2Fzc2VydG9rKGhvc3RfY3JlYXRl
X2RldmljZSgibm9uZSIsIGZhbHNlLCAwLCAmZGV2KSk7CisJdXRfYXNzZXJ0b2soYmxrX2dldF9m
cm9tX3BhcmVudChkZXYsICZibGspKTsKKworCS8qIFRoZSBibG9jayBzaXplIGFuZCBpdHMgbG9n
MiBtdXN0IGFncmVlICovCisJdXRfYXNzZXJ0b2soaG9zdF9jcmVhdGVfZGV2aWNlKCJsb2cyIiwg
ZmFsc2UsIERFRkFVTFRfQkxLU1osICZkZXYpKTsKKwl1dF9hc3NlcnRvayhibGtfZmluZF9mcm9t
X3BhcmVudChkZXYsICZibGspKTsKKwlkZXNjID0gZGV2X2dldF91Y2xhc3NfcGxhdChibGspOwor
CWRlc2MtPmxvZzJibGtzeiA9IDEwOworCXV0X2Fzc2VydGVxKC1FSU5WQUwsIGRldmljZV9wcm9i
ZShibGspKTsKKworCXJldHVybiAwOworfQorRE1fVEVTVChkbV90ZXN0X2Jsa19ibGtzeiwgVVRG
X1NDQU5fUERBVEEgfCBVVEZfU0NBTl9GRFQpOworCiAvKiBUZXN0IHRoYXQgYmxvY2sgZGV2aWNl
IG51bWJlcmluZyB3b3JrcyBhcyBleHBlY3RlZCAqLwogc3RhdGljIGludCBkbV90ZXN0X2Jsa19k
ZXZudW0oc3RydWN0IHVuaXRfdGVzdF9zdGF0ZSAqdXRzKQogewo=
--00000000000014d565065e93567c--
