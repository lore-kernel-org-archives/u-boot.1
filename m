Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBC3C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D522388852;
	Sun, 11 Aug 2024 16:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iQctIAX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 923F6888EC; Sun, 11 Aug 2024 16:50:32 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AEA88898
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bbbd25d216so35111266d6.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387829; x=1723992629; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kHOJ8hZaNZ6QyAv1tTfWUqadPQsV500P6dxvpjjczkQ=;
 b=iQctIAX/0Urs2A+KlLQ4SysmDNm1BNpy6m8uZyYdGWNHc9SLXa+eH9azjIMrxgHdEt
 WT7CPlVK1C89248CNAIOUHWR8yZ3/FboH8rfJ38gQzi+Mns24rvg3JiwCVUHzpSuLZXm
 ieiWN/kGGMSFI7JX50kxKNLtU47LNnPYyes/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387829; x=1723992629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHOJ8hZaNZ6QyAv1tTfWUqadPQsV500P6dxvpjjczkQ=;
 b=vUZyq3V8sNPB07aerb17ar0n0ZtEKWLhl7XK25R2dSabdwJtyCwAnpO1zgxa0ltwUI
 R2X/8ryXoPH5DEjjvjDdmofvZkQzctTnqboMwAtucMKJl3ZN7M4Az9bvjMAe8HSY8K8B
 ZO8KdLzqkB0VPOmCH4B5bfcM+RH6X2gGibZ4fUmwtqqyg2Wpt230YdaWXq//s0LJrpi3
 WGA3/onFCT+nnoVkFEbmvmgMCG+mmf1MN+4+gPtu/DPzRNCblXsohJGu/qQyiXKC1Smj
 FIfMlW69g6kKK+HCU7YbvupDOI9EYNpCkg/NtNkfns546xjwEIoMf1xGMmW588oOiERf
 l4qg==
X-Gm-Message-State: AOJu0YwOw9FkvOBTuW+w2rgtDmsFlNGVkVti01B+M5eSLiMQHE+XPGvQ
 Wez4x4ROwhGCIhslzn9tdfNo4KPFz5nBAzisF+lBPriy6EcgW+OmwqGbZBTMT3tT7+wfpSXLyqy
 g2O867tIks56z1nzYJGNLBvKFu54doxdO9xyjxfeiy23K0Iw=
X-Google-Smtp-Source: AGHT+IFdrRDUY6fLWUy0dudSgK9HzXL4CFWkTGNPV9Ie+zZANH5GA/72JqBZHKC6mwlOer1WwZk6gyF1dCZm0ywVhdk=
X-Received: by 2002:a05:6214:318b:b0:6af:33ed:87de with SMTP id
 6a1803df08f44-6bd79c0ae0amr106588576d6.20.1723387829102; Sun, 11 Aug 2024
 07:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-8-sjg@chromium.org>
 <CALu9rSbrAcxkGkFHuiFSBd-JMTm0kfEwDuBCDNYZc33eTLVU9w@mail.gmail.com>
In-Reply-To: <CALu9rSbrAcxkGkFHuiFSBd-JMTm0kfEwDuBCDNYZc33eTLVU9w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:18 -0600
Message-ID: <CAFLszTjujOXs39KMnV-5NNWNqJ8K+FoisPYB=1HmC5QHf671ag@mail.gmail.com>
Subject: Re: [PATCH 07/21] Revert "net: wget: Support retransmission a dropped
 packet"
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marex@denx.de>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Richard Weinberger <richard@nod.at>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

+Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>

Hi Yasuharu,

On Sat, 10 Aug 2024 at 20:48, Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:
>
> Dear Simon,
>
> Could you inform me how the wget test was broken?
> As I explained in the commit log, I fixed the bug in specific conditions.
> Without the details of how the break happened,
> it is difficult to find a proper patch.
>
> Best regards,
> Yasuharu Shibata

Yes, I should have mentioned that. It is test/cmd/wget.c - see also [1].

This is a good run:
Test: net_test_wget: wget.c
HTTP/1.1 200 OK
Packets received 5, Transfer Successful
Bytes transferred = 32 (20 hex)
md5 for 00020000 ... 0002001f ==> 234af48e94b0085060249ecb5942ab57
Failures: 0

With your patch it hangs:

Test: net_test_wget: wget.c
HTTP/1.1 200 OKT

>
> On Sun, 11 Aug 2024 at 05:52, Simon Glass <sjg@chromium.org> wrote:
> >
> > This breaks the wget tests, so revert it until a proper fix can be
> > figured out.
> >
> > This reverts commit cab7867cff33f9c21025102ea9ca3b26e362fb52.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  net/wget.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)

[..]

[1] https://docs.u-boot.org/en/latest/develop/testing.html
