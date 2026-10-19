Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27D8CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80DA080FEF;
	Mon, 19 Oct 2026 13:15:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jEGYXSqX0E6R; Mon, 19 Oct 2026 13:15:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98C8D80FA8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415734;
	b=JtXTv7oD6AMJGWZBZI2Claq/Dl8Peg9JrRts4hBShQqB3aI8zx5ESGzRgwPiMZnwp4SP
	 2P00Suu60hSoIQx6PzrURJxHCAXCpjpX6jvXSMBuzssYyv39k6il0olHzH2G6MaWmdqZw
	 TEPiQ2W7aD3MwhJOR9o6nxcSOFYNnaJgx+/fiautfrOaWadWL+eiBvX+HziN9/G6Jb38v
	 U+EpAF+gT2Ox5V14hw1H5WDn0kZj3/Nt35eJ1yV/UnonVCvOkekM85PKWzGThCxAcgMlR
	 yotKpTiVXm5VxqtcN4EBrNMhdxkvZcF7LFeoFzB9/P9Wb57KUUoam55MKLW5iZ4g+lg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DDLijn280JgrDKhB62ahnio6Wk+3Rtpx5Ah7Erk4Ck4=;
	b=G3cXDXxGlwm2Dg++EZHfTweiDBnqPYwreFmdUftdGMSKayNmJdLoZzvm1kN2VfKt5RBX
	 UgtFHII3kmp/FG2fGdmYfs0QeJfIGlmQcrsS99xrt5FZnE0ATah3DuKwwyNsmxp3LWZSk
	 dIu2RqS0b2Eef3ByYN28lTA2Xs42T3CgfbdaYco9QpdvJrDPvm0Z24ONH2dZdl9ca6kOT
	 KTuQvAH4sH007YciHD3WGUw2GNxwTAZoB8m7Rn3fwFwAI2El7ovvZA3oJyyNldSz3FZhD
	 6tNWybfI5k8nXDo/YSHZ43DFS79lWx+p3Ddz97wE8OQJJCVcFHkJ43AodcFP/wR9SUw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ot34nm+G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415734;
	bh=DDLijn280JgrDKhB62ahnio6Wk+3Rtpx5Ah7Erk4Ck4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a8Lz0dQu5pdDVjfN+0c5hQ4SjGQmFqN0VKvzh8l8Qfz6Cp9C52Rxwcwq3CyfeTDvr
	 9AjNnnjSDNnA8iND9ta0KQMeJnttjwFTNrX0u0otuqXJoLrD5pnP8L+pZ+gShJrWB5
	 bfLEwhdY6FIl5i63CFQIiN2JT3dMl1GZYQE/CwJUO4GlnddQWUw6o84XvRzY1GsSnO
	 Ls5XLCSPV1M1ueJ1rC3GS8QRGBXwGMMM1GRUCvIOM4JL/RHd2Uku3TT/IYSl/Dxgyr
	 shKCqELr56iQpPB0en8Feb5LQEboFiGO8GBQxYJ4UEQCSeq4/qLNpgUZjHw4gh0oHk
	 Lxf77O++LjmdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98C8D80FA8;
	Mon, 19 Oct 2026 13:15:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FE0DDCF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0773180DA2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yJZFtRMxSGia for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5D7E80D5B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415716;
 b=KxYcHzUNYhL/BlZjyUo42Vf/l8HfBhO2A9OmgeP8crcuz/CF2y5Z43OWlHz0BfYy/deF
 gqZLue6RREF1wMIYZMEOgWGFv/u6y2sh2uewFQ/S138qY6DIPqBe9B5TM4rsamZZp6KIJ
 BwNLoW+4WzNOheWo2eLFY7aH/Bx1HjDRO2HlcbW61oNaT/40Lqqxu6e/m/Bx3stJYTnky
 UAzn1BxYPeYJiS0NNzuddg7aDPWoGIV7ScTuIec5MmeJJxRIpBBOoxAdT6Y9X/E/1zGQY
 AJbHRvpe9JOFot7x7DEq3Xg13ht/3ZY73aqNMHC5CoxA4UIqPJ20ueZrttZDy5sP3mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415716;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=DDLijn280JgrDKhB62ahnio6Wk+3Rtpx5Ah7Erk4Ck4=;
 b=PyEUbf9AXl8TRf4d9RbAjV/vrcvc24SonrNJ87szmtpz7phJkcjsEAenbtmMptLaD3xX
 uHgMYLIkjsVOLPHD8d7Frh6A35ysDXQbwRHbTK0KbxngxmGu7/Syw2kdv9/+S4P78Fg2P
 2rhbPqCz/Q3byrnO5PhCtujKfq3WShqBcL/+jJ7pdqxHc3q0p4SBdaXqOWoowW4cZ31yc
 dak4BY3T1ZRM6iBnhpGfK7B6160BnaA3uainaNlZKi9oIsK+OvK1q+akLgnFvmJwTuvi8
 1nu/oDdZFlc7EVhzJWYac8mtmxRnk5H1DGjnfRSmTlEvs41Won9e/fT2SAXWE453lcw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Ot34nm+G; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Ot34nm+G
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5D7E80D5B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:15 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2a4e013a44so260366566b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415713; cv=none;
 d=google.com; s=arc-20260327;
 b=PeedPDeGB/kMzaORXz10w2v2EtLY8HzFwFx47X3qH5GamNky0yExKSSzA56pQvR1ND
 YawV2rwOWrRSFthFDVmMNLDYwURAB0uuJ5tl/4k+O953Ku4p99xmaxX+atITnLQ9/q7b
 7TUjSaiHSmIatTvYsV1+6FX0if8TzMBpwahnMn9NyDd6tAi80a+qiSOG9yPuVDMDdn+u
 8iHeSn9P2jU6BbdSXke9+7wsimWmPrf7LXOYPf0dE6a/IU2lwCBm0CklwLAbihvOnRFR
 fmUCInHAud7Gvf0PKi1wtvZTDwv39xLnd/D2zmGwGwUwN7lbEEM3EP6o9rjkQVIaB8rh
 3F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=DDLijn280JgrDKhB62ahnio6Wk+3Rtpx5Ah7Erk4Ck4=;
 fh=pCIJi6nVtiOywOBF1ZIho6/JuApp1VoYqSvt+Olrb1c=;
 b=ouq/6nuOggW0Cv1VIvRyOZMqVGyxjarVbGARc0KzoxV6K3h9lMLAd9CG+Fh0PIjSul
 ZZMEsCVA1AfSycBPEPyGw1/WyIOftfj1X+3FKJdgCE3gD6ZNsEeL3w8LjORekJ390/pj
 iDMN4heC03o01JAmiiNvGpR1XvEFLmSXpqXz+TIVQkGV5Y5DBQ/7watW6Hlu4+41c1t5
 Z54DJRPhiZLAlFoGeKJ8rsFmqYALinfXl4EZJBnQdbUscIyaYSsPx13UJCnsmd6ScFgF
 Qw2hrt1d/TUhfdG7j00c6/AGp4EVF8lyHMVdXcA3oHhdOW16bVobz2Tzdqih8gNFK86O
 JrUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415713; x=1793020513;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DDLijn280JgrDKhB62ahnio6Wk+3Rtpx5Ah7Erk4Ck4=;
 b=Ot34nm+G7xjAJTaTUaT2seRfQRjvXfBBk8LMKX1iBeTHftCb9RkK2/4X2+DubnXeXc
 4lAriGgnheL6iDHDVo6oGgaplmkDGGDKjNex2JhoX4R7eliTQ6WVMVnwqkiytWymzFIp
 ZTz6CT7wAMenW4rW8fFqboFJGsVQ2xK1+PZoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415713; x=1793020513;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DDLijn280JgrDKhB62ahnio6Wk+3Rtpx5Ah7Erk4Ck4=;
 b=tnt3QzE09guYr618kTlR23/DgNOf068eax8xv3X4+lr836qUp8aA4GAiNpfkyDzLXU
 KpI0sl4qFUxRGUDslOu7U1Of2Db/dU5lHz/2xh11jdGc5rIyA+bWKpxox/+0u6U91+cg
 +frB+SYdlupZwqEUglxBtEVujCqxS+Uum7sxqd7tvuz1Zih4h/Sk9npX7jGc7AjYU6ra
 DtuNOgTGsY0WwZhmal0OeCkEmo0KXDBorZ3x22tvR1pAuE2Bsx591VsCAmQKBZZKqLKM
 wk8ULtxn+W5aOa0SazMs1cr410LQglIY2dbsWFBDY7KP4K9EYIlagoHNuu0S+rHDv8OG
 NbGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBySgH/m3aWKO/Y9nBALAc1m3GliyAWL1C0ObMvGyaRn5sUeO1GbU+twtCMwCera6FDYtMo8Sjs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLP4eQBZr70EUU22rEjc7b6N0hVWXzBwKemGq2ZU2XxDJv2F175
 /QK2185VStYNYljvEUePBUj2gyngg2BRw2gVresswrOKMSR8GtVgjmkoJr/nAGEEMFEyctsFE92
 vxJB7mERowL+Z+uzsZji02tvkJ+njfoHsNz9rjf4G
X-Gm-Gg: AYBFou1fiHcO3skjDyXf5u2QtElgZ7yuEqi7csXfA1Vow4/A355C5AakYoc5/7fm+qb
 tkG3qIn0oDi8nwM0RLDDRySkTTFefTlDQWOgbydTnZ7ObVBpwjy+AUUPdTyhIjiGFAxaubqJPZx
 949v3F1FEX2RFdwf4q3ann8zLgaz3Ad4H08Q+zi5+75MMEqZv6b+F2DhxCbEnQZH9yh0o2F7jjK
 pfD41kECYmDLxG+VAKqAqzOkC5OqBJ6aEjQnbyNJ4ayMahOcanINxbdUolKKgLCZEhagcLeKYSx
 gAie6ZvnjvxKhHlhTCjTqKzVJvZTSSMq6OedNoaJy8w0N4yNMFVkUw==
X-Received: by 2002:a17:906:ba88:b0:c29:3c97:c994 with SMTP id
 a640c23a62f3a-c41a06e6f22mr542840766b.35.1792415713160; Mon, 19 Oct 2026
 06:15:13 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:15:11 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:54:42 -0700
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-12-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-12-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:15:11 -0700
X-Gm-Features: AclHuK89C3siO0aVVFum6gcb1OkFCKsOMpqtxfowpZ2x_T7GSh_Xw9cy1vB8aC4
Message-ID: <CAFLszTha42GZ-Y3ijr6i1U5wOQ7pNDFo+gpi00utk1qdub0j+A@mail.gmail.com>
Subject: Re: [PATCH v5 11/20] LoongArch: Generic platform type
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
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: Generic platform type
>
> Provide a generic platform with some common routines expected to be
> implemented at CPU level.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
>  arch/loongarch/cpu/generic/Makefile |  7 +++++++
>  arch/loongarch/cpu/generic/cpu.c    | 23 +++++++++++++++++++++++
>  arch/loongarch/cpu/generic/dram.c   | 16 ++++++++++++++++
>  5 files changed, 60 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
