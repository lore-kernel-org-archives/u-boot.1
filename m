Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9EC606A323
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oPHk3w4Q;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=k9egzxlw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C5CD40828;
	Wed, 21 Oct 2026 17:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zFguYVh4liWz; Wed, 21 Oct 2026 17:35:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 260F440800
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792604141;
	b=N1aWyv28LoGPK+BbHY3tFuCWYbkyEeQohSLCxPrlTm0sRR9M76zDIVGvoSPGOEQqewNj
	 8yXExW+1dkkP89TA7iRtonQ5QO1dsVTCdBdNKfkcL7Mepoh7+hCW0/0kT1tW9pytCqvTi
	 4YEhMqri9RZZAdwhShpgkz1i9s9AjP8x+GBukiFIHH+pp1qfU/nOsTAcDKPp7bxX+ozGY
	 86S54pYW0/p7u0VAqmywJ91Ygg/YYsGDqypvMegisJ76HfgzKpf8op6LyKSM2MkCQgPQn
	 yZy15Z4sqMiZR/jWNWItAWPs5pNBwxnm93Qq5ncb+8j9z+TOmGX/I5oSHkJJXf3fXfw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792604141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T+D1uAmzhaVRv7Ev0koHUwXpAUciIc7dpdt/IIqVaqg=;
	b=S1SW0K5w19OSMchyopB5wH7l9S50pSKHVJTxMfDHRYvF5poCS7nugjE8EOVTpDJeZmJ6
	 TrJfDo8Y86Cr/+C7A7kWv+i56LUCY5IDDKDm93YOeOCSP0+d9hd8F9IyAkDb8QoL6xEdf
	 5wypxj2G4a26P24GLmGj2rEsuH5rQUT2HBBKpmXtV4f+opfXmPbHnqCrR3mLnCdq01Kil
	 01idRe61XEjIoojTueypA/G6u/AXMx0wG3qsc3S7EnFBws/U57XrZc4m7qg1A5317t301
	 jbLU1k+ycKJOrAqRzn0J2no74hFeoktm9wDa6W0QVM7PWRuzcQOoIYHBTW/0TTPBNSg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792604141;
	bh=T+D1uAmzhaVRv7Ev0koHUwXpAUciIc7dpdt/IIqVaqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPHk3w4QripdbHTPKh8DPC//7DlXqh6HqX84sMB7vHzVBzm6vk8a0f3cY3rwjJ5m/
	 K6WYwqdpBerPmet5s/wE/pFPtRIi7lnsw32XGaaranFeokPElobepzeIKRCFa09JKq
	 +pCN4Rg+PgV2EdzYdyE+zlZ4rK16eDuDpTj23CjhwqWfdyo3qjMgXwPhE0nFc8ZGB0
	 II8uRzTQgbyh3tdZWXHztof0odEy39CGGiiVMjQF+KxxTvPkjdEQL9c+PDjYz3UNev
	 aiF8axdNGizyYWqhuagLOyjg36R+LK2hsw+iFpalWElC+gnMD05rTglsm7y82/IV+x
	 5+VDGI1bqbJBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 260F440800;
	Wed, 21 Oct 2026 17:35:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9FED1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB8774039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:35:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ED5TrRMXOB5q for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1DBB14016D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792604138;
 b=Vt7ZPgteDP3KLoU5i0uDthnqfM6Sfw5b9z8uLumPGSt/OLu6Sjp/U2g/iwuCbQXDZrJr
 omS0WcWwrweWlZeBjm66rxycPfSoq31Q5sBt435RNtYFG1lYdqY1HqHIXHyEJtKl46hwv
 vQY23rGMYW2XjiJE5oQkh12xCA9NpqgstmfkI1h+SeuMBSYGkl/JKMZx/l2VNJCY8IuOm
 L+dScL2DuwWqXKTuH17IQ3IUvU4ZrdU0yQi0Py7f29eQF96sFpHiqtrl6ulwEeOiFIp3d
 UpNUi3mZOSGxc8x8OebiM6cM893MxQTx2/tmYx0l6MElzrscToxCv/ULBcGzertVTtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792604138;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:X-Virus-Scanned:X-Virus-Status;
 bh=T+D1uAmzhaVRv7Ev0koHUwXpAUciIc7dpdt/IIqVaqg=;
 b=kXCsKRSXYn381feZGEIgD98YsngfrEx/R5rh76eYp0m3PLNhxuMv+eJcNWhSKG9Uv1X4
 Lg9N5MNclYfaEPECtD9aU+Qk9vzPx8rwVZ9lewcHfzeF3UJAkT1vTLhitTp5mQ1f33Jgm
 WZWZ6fOMMRSnuk4irSyuxICvdA0RexGH4A48oWsL8RbFxwR1sMl+iGfX+fOvxgM2EFOWO
 MEmOEAXBVZvHuUVrT0B/qPNXwEqSPTG1G3MuXzQ4BFNrt3/49JVu4He/RNZN8dRbD2ard
 1vJ9/kx7zClngYDwoVDvtCsMdGGM6L3JKVrYlfX/s7uIj9gs7396uk598pPwa/uadlA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 spf=fail smtp.mailfrom=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=k9egzxlw; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=k9egzxlw
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DBB14016D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:35:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC4C844F6; Wed, 21 Oct 2026 19:35:35 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF8A8056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 19:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so1091939a12.2
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 10:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792604126; cv=none;
 d=google.com; s=arc-20260327;
 b=k9Din4xBqtrMVnxn0zuJ6gCbBozU2rO3iNSHm9Bb7LKDDceXbTv+3HXfRizkI+6FtT
 PD12/fd9evbf2s5vXkVC2TH0ePHgAL3852iY9NK5Hz2TT0sAX+a08Ygbf1yEwCuCErCI
 DYYMWLN/0tSgXrnQABiZQ8wsFQPMqgaezoBXMYw2IGwk3gQyWUl026rpj5KrBUkabx0L
 k79PBcyhQlpG6NGZkboJJM58yeZEIEbmxNmAFiykKWj8RmB/kyjvdHE2wOR7C96Lf1b5
 d9LUMmMCwLAhSuTyufZHi7jzFxS7gHUCk964U9RYiMZTTH3orSoTjaBqtFzFSNGz/smm
 Qyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T+D1uAmzhaVRv7Ev0koHUwXpAUciIc7dpdt/IIqVaqg=;
 fh=EKXFhc9lCOgwzOBZUX5Zu2pmjGz42uO402q25xqRw9g=;
 b=KoMCH+2ZR9hME67YxPlO0nv9v8GGoWDGVnTr/i8d/gV7fUd0F4gatej8TKtkylTwT6
 k2GQB0tqhsf4vDB8z4XD3rC8P4+200Uv8+oWFwEDjQAVb4HCJoQwUuyfTtPKcO/sKPt4
 ZUkbUBuEAxi3XDXtWHYsNaojD5jmWX63vSK3pI20vcTmshdhWa9GBSSjDCJc0uHHZcFG
 j6oBNg05aPyMjToHx9zt0oYwEgnFACDbtxNpCH4/TENAVAKMV7R22WLaUodvn9U7QQQ/
 Yp5JrzUH3PKi9lWfJgKEIjj3dStUTNe1EZZsEtsflN9FfXO9p/JaZxrsOOj15jfmRoRj
 iR4Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792604126; x=1793208926; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T+D1uAmzhaVRv7Ev0koHUwXpAUciIc7dpdt/IIqVaqg=;
 b=k9egzxlwVw5n/ikeCqyxu9jbee0y8SdHS7nFATmIn8qSHh7E1MMci3uqg4i3aPd1c9
 57+lySUGbJ5W6MPjrmuU8wAyplnZuWy2OyrUS8rz0KKM6eXeVzQgKcZN0QObjmDBfpYM
 Qx0UP7Olt0knvxr8+HdY9jZmRgf2iYTWx+oHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604126; x=1793208926;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T+D1uAmzhaVRv7Ev0koHUwXpAUciIc7dpdt/IIqVaqg=;
 b=X1Wo4feiU+WBSFhEq8v96bxSOubI/fdkTwLn1l1i0bQF/E3pOsG+sr4r33zh/0Sk3g
 VM57HGXcNHkd+8pbSAXBFq3/Lbb5MmcQU+kZ5k8FZBYBEE8crtFC4JP73JPF8AsrnrdU
 LwhUPrZ1cXIFygm83iMo0AFBdavMEt+OERiqRwmTkDCO8Vi/o4x3975/Shliy8PZtI4W
 FT5m5c6DPFZ/nO5/yuhPsm5vm75LFpKDpPE2v94bYH89AZpIuGt7Il+gX+vhwB6FJRBi
 c/TRjz2Yb5X/x7xHucjMmMePwL/3fnepeCDp0pF+Xgg66NE3g4/VNsABiQUzxZNnkS3Q
 pwkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoimOHIbuWjRg1fIGmMBFmGkK95DenjHD6AzgV/0gU/BwO8pgufcXIT1bsnku9+j0krG3P6lM=@lists.denx.de
X-Gm-Message-State: AFq9FYIw1EzoaF4O6fBKKtdj3pIuBhAH8Tw9zT5KSsoD/5mxpYOb3LLP
 w6+EE5a5uyYuVhRnAxVgkvdYBTPnn3wpBRN/b7t+8xmSG0YirtkFoi6rIZUxs3OZ7yfUqHq/ozA
 ya9E0aacunSYchVVVZZegB5x92oxEOWiEhSm2ZgQh
X-Gm-Gg: AYBFou3utOQJrxsIZgE93hRurJCXR2+i+eEEkhoZwgj8VTKnMX3Kw1OLZK/+YjY8+al
 UcpVyNWOtwJEaha6iKlWWZKAUXjKpq1QhEkIeS4Mf/NXbEnA5JCaCe1bggjyL2jJVKHYdXpqThG
 rtQm7GV3TzFDvoxTjC9sFQhgGBpx8g8x8vRkXCXYwjj124yHjiSfK2qNU/T+vv6GptFkgTvHDOY
 vF5BIxiMiTOyDTm3OyhH5nda24Djl6K15yOi7RH0lK16ApESx4jqD+fu9jknNj9TL1NdFOK83wO
 DTwsjvzxv3il9Tx85Od7U5gpQVxUmrciHJwdNi2YriyB8Vkp5BwTk436UU96PAtqYKjIW54QYjN
 k46ELH3vGSWE5PbkgmCIufA5tGdzK6FfzQhY=
X-Received: by 2002:a05:6402:4554:b0:6aa:f809:ef3e with SMTP id
 4fb4d7f45d1cf-6b408e97bbcmr1605441a12.14.1792604126005; Wed, 21 Oct 2026
 10:35:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
 <20260902211501.127915-1-bhargavdas100@gmail.com>
 <20260902211501.127915-4-bhargavdas100@gmail.com>
 <CALeDE9MFJEZLVf_eOHVOL0HCnV36=ZGHOn=4hi-RJGMO9iGXsg@mail.gmail.com>
In-Reply-To: <CALeDE9MFJEZLVf_eOHVOL0HCnV36=ZGHOn=4hi-RJGMO9iGXsg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 18:35:13 +0100
X-Gm-Features: AclHuK9JFqydrvLR4ChlkX5I_2yq8___x8y8v77IUaW08VlCzMsb2NQtjNWnRro
Message-ID: <CAFLszTgwvSOstYBU-YauZxGywgZVsO9Ns2J+0JjbbrQeYmy95Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] board: raspberrypi: Add Pico 2 support
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Bhargav Das <bhargavdas100@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hmm I already reviewed v2, but haven't seen it go in so I went hunting
and found the wrong thing.

On Wed, 21 Oct 2026 at 17:14, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Please don't reply/thread to old versions of patches/series.
>
> On Wed, 2 Sept 2026 at 22:59, Bhargav Das <bhargavdas100@gmail.com> wrote:
> >
> > Add board support for the Raspberry Pi Pico 2.
> >
> > UART1 console is functional as of now.
> >
> > misc_init_r() sets a fixed value for the "serial#" environment variable.
> > This fixed value is hardcoded as just a placeholder to confirm that
> > evn_set() works post-relocation.
> >
> > Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
> > ---
> >  board/raspberrypi/pico2/Kconfig     | 15 ++++++
> >  board/raspberrypi/pico2/MAINTAINERS |  9 ++++
> >  board/raspberrypi/pico2/Makefile    |  3 ++
> >  board/raspberrypi/pico2/pico2.c     | 81 +++++++++++++++++++++++++++++
> >  configs/rpi_pico2_defconfig         | 29 +++++++++++
> >  include/configs/rpi_pico2.h         | 36 +++++++++++++
> >  6 files changed, 173 insertions(+)
> >  create mode 100644 board/raspberrypi/pico2/Kconfig
> >  create mode 100644 board/raspberrypi/pico2/MAINTAINERS
> >  create mode 100644 board/raspberrypi/pico2/Makefile
> >  create mode 100644 board/raspberrypi/pico2/pico2.c
> >  create mode 100644 configs/rpi_pico2_defconfig
> >  create mode 100644 include/configs/rpi_pico2.h
> >
> > diff --git a/board/raspberrypi/pico2/Kconfig b/board/raspberrypi/pico2/Kconfig
> > new file mode 100644
> > index 00000000000..eb06fe6baeb
> > --- /dev/null
> > +++ b/board/raspberrypi/pico2/Kconfig
> > @@ -0,0 +1,15 @@
> > +if TARGET_RPI_PICO2
> > +
> > +config SYS_SOC
> > +       default "rp2xxx"
> > +
> > +config SYS_BOARD
> > +       default "pico2"
> > +
> > +config SYS_VENDOR
> > +       default "raspberrypi"
> > +
> > +config SYS_CONFIG_NAME
> > +       default "rpi_pico2"
> > +
> > +endif
> > diff --git a/board/raspberrypi/pico2/MAINTAINERS b/board/raspberrypi/pico2/MAINTAINERS
> > new file mode 100644
> > index 00000000000..e081f894e00
> > --- /dev/null
> > +++ b/board/raspberrypi/pico2/MAINTAINERS
> > @@ -0,0 +1,9 @@
> > +RPI PICO2 BOARD
> > +M:     Bhargav Das <bhargavdas100@gmail.com>
> > +S:     Maintained
> > +F:     arch/arm/dts/rp2350*
> > +F:     arch/arm/include/asm/arch-rp2xxx/
> > +F:     arch/arm/mach-rp2xxx/
> > +F:     board/raspberrypi/pico2/
> > +F:     configs/rpi_pico2_defconfig
> > +F:     include/configs/rpi_pico2.h
> > diff --git a/board/raspberrypi/pico2/Makefile b/board/raspberrypi/pico2/Makefile
> > new file mode 100644
> > index 00000000000..a2929172d0a
> > --- /dev/null
> > +++ b/board/raspberrypi/pico2/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +obj-y  += pico2.o
> > diff --git a/board/raspberrypi/pico2/pico2.c b/board/raspberrypi/pico2/pico2.c
> > new file mode 100644
> > index 00000000000..c11e7ea2e55
> > --- /dev/null
> > +++ b/board/raspberrypi/pico2/pico2.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +#include <dm.h>
> > +#include <env.h>
> > +#include <init.h>
> > +#include <log.h>
> > +#include <asm/global_data.h>
> > +#include <asm/io.h>
> > +#include <asm/arch/rp2350.h>
> > +#include <dm/platform_data/serial_pl01x.h>
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +/*
> > + * dram_init() - Report SRAM size to U-Boot
> > + *
> > + * RP2350 has 520KB of on-chip SRAM. There is no external DRAM.
> > + * U-Boot's "DRAM" in this context is the on-chip SRAM.
> > + * We set the base and size so U-Boot can place its stack,
> > + * heap, and loaded images correctly.
> > + */
> > +int dram_init(void)
> > +{
> > +       gd->ram_base = RP2350_SRAM_BASE;
> > +       gd->ram_size = RP2350_SRAM_SIZE;
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * dram_init_banksize() - Set up memory bank info
> > + *
> > + * Single contiguous SRAM bank on RP2350.
> > + */
> > +int dram_init_banksize(void)
> > +{
> > +       gd->dram[0].start = RP2350_SRAM_BASE;
> > +       gd->dram[0].size  = RP2350_SRAM_SIZE;
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * board_early_init_f() - Very early board init (before relocation)
> > + *
> > + * Initialize clocks and UART so we have a console early.
> > + * This is called from initcall_run_list() in board_init_f().
> > + */
> > +int board_early_init_f(void)
> > +{
> > +       rp2350_soc_init();
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * board_init() - Post-relocation board init
> > + *
> > + * Called after U-Boot has relocated itself to SRAM.
> > + * Set up anything that needs to happen after relocation.
> > + */
> > +int board_init(void)
> > +{
> > +       /* Nothing special needed post-relocation for basic shell */
> > +       return 0;
> > +}
> > +
> > +/*
> > + * misc_init_r() - Miscellaneous late init
> > + *
> > + * Set board-specific environment variables.
> > + * RP2350 has a unique chip ID we can use as serial number.
> > + * (Full OTP reading requires more setup - placeholder for now)
> > + */
> > +int misc_init_r(void)
> > +{
> > +       /* Set a default serial number, rpi pico 2 part no */
> > +       if (!env_get("serial#"))
> > +               env_set("serial#", "SC1631");
> > +
> > +       return 0;
> > +}
> > diff --git a/configs/rpi_pico2_defconfig b/configs/rpi_pico2_defconfig
> > new file mode 100644
> > index 00000000000..51e4361fdbd
> > --- /dev/null
> > +++ b/configs/rpi_pico2_defconfig
> > @@ -0,0 +1,29 @@
> > +CONFIG_ARM=y
> > +CONFIG_SYS_ICACHE_OFF=y
> > +CONFIG_SYS_DCACHE_OFF=y
> > +CONFIG_ARCH_RP2XXX=y
> > +CONFIG_RP2350=y
> > +CONFIG_TARGET_RPI_PICO2=y
> > +CONFIG_TEXT_BASE=0x10000000
> > +CONFIG_SYS_MALLOC_LEN=0x8000
> > +CONFIG_NR_DRAM_BANKS=1
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20082000
> > +CONFIG_ENV_SIZE=0x1000
> > +CONFIG_DEFAULT_DEVICE_TREE="rp2350-pico2"
> > +CONFIG_SYS_LOAD_ADDR=0x20010000
> > +CONFIG_SYS_CUSTOM_LDSCRIPT=y
> > +CONFIG_SYS_LDSCRIPT="arch/arm/mach-rp2xxx/u-boot.lds"
> > +CONFIG_BOARD_EARLY_INIT_F=y
> > +CONFIG_MISC_INIT_R=y
> > +CONFIG_HUSH_PARSER=y
> > +CONFIG_SYS_PROMPT="RP2350> "
> > +CONFIG_CMD_TIMER=y
> > +CONFIG_OF_CONTROL=y
> > +# CONFIG_OF_UPSTREAM is not set
> > +CONFIG_OF_EMBED=y
> > +CONFIG_NO_NET=y
> > +CONFIG_SPECIFY_CONSOLE_INDEX=y
> > +CONFIG_DM_SERIAL=y
> > +CONFIG_PL01X_SERIAL=y
> > +CONFIG_TIMER=y
> > diff --git a/include/configs/rpi_pico2.h b/include/configs/rpi_pico2.h
> > new file mode 100644
> > index 00000000000..b5236320344
> > --- /dev/null
> > +++ b/include/configs/rpi_pico2.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef _RPI_PICO2_H_
> > +#define _RPI_PICO2_H_
> > +
> > +#include <asm/arch/rp2350.h>
> > +/*
> > + * Memory layout
> > + *
> > + * Flash (XIP):  0x10000000 - 0x103FFFFF (4MB on Pico 2)
> > + *   0x10000000  Second stage bootloader (256 bytes - handled by ROM)
> > + *   0x10000100  U-Boot image starts here
> > + *   0x100F0000  Environment storage
> > + *
> > + * SRAM:         0x20000000 - 0x20081FFF (520KB)
> > + *   U-Boot relocates itself here at runtime
> > + *   Stack grows down from top of SRAM
> > + */
> > +
> > +/* Flash geometry */
> > +#define CFG_SYS_FLASH_BASE             RP2350_FLASH_XIP_BASE
> > +#define CFG_SYS_MAX_FLASH_BANKS                1
> > +#define CFG_SYS_MAX_FLASH_SECT         64
> > +
> > +/* SRAM */
> > +#define CFG_SYS_SDRAM_BASE             RP2350_SRAM_BASE
> > +#define CFG_SYS_SDRAM_SIZE             RP2350_SRAM_SIZE
> > +
> > +/*
> > + * Stack / Malloc
> > + * Stack at top of SRAM, grows downward
> > + * Malloc heap immediately below stack
> > + */
> > +#define CFG_SYS_INIT_SP_ADDR           RP2350_SRAM_TOP
> > +
> > +#endif /* _RPI_PICO2_H_ */
> > --
> > 2.43.0
> >
