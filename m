Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F6606A31D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mjeJdjei;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hXNA2CrA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DE9B811E7;
	Thu, 22 Oct 2026 08:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1GVpbqndDskj; Thu, 22 Oct 2026 08:25:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A688811E4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657542;
	b=DJLTgjPp90og4bWh5O+dNzm9ZruPxJM/LIsYvf3FxVhTvItC9UTcRYul/OWmYRpReD4p
	 97mEmwo0ycvLyx6QsR9aXQ+bSgMVzA0mjrieuUKBKcmRybf9RNDGty9zH5z4altlD/nVX
	 fXt2MejpARD/LqyEhfd+zGlkrv7gvOFIkHl/TtiK3+VQRw/N+blpIj4WekstgSbp3dZED
	 y4qnZfYvd8VNB6DT2WW22H8xnOoVwCRzprLk7Gu9BMwQ3/eCRp9ltVPpPO71ledbkAz3D
	 sldB0iykN1rsbiPJ4LqcaVRVarFZo+OjVYPLuETCX1TdlXg0qQBjgtJj4kCH1ZyOoew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LV8ReXycMWtY50YkZk2Tk/183Q52lPz9WKUphiWP2Uk=;
	b=cJLKFSfCoQ4LxRCZWy7SLMY2TEqEvpM/dy8YUYZg7RD5+RQ1QzsCMG8PPPfM5cMt87OP
	 XqjzL5GU4bvsdFXVvcNsHGCDbtisOHOJfGQ5g6eDoq0vwh3dTx3qHDF1gfWRxC1nNqJM7
	 pUiWXMPpQYJcOTGR0d0oW+umxDRPrNMQ3tZWflRb7B/M3pdwbt6MbsyN+XiyjUIctipaL
	 uHjoBi1LzAEEUMCweTqFeUbnCiua4b3k/zzGIC5ZnojXKrswHIMKerF+dx59xlyzyDSW6
	 /mcheuiWPxkAn29Ceh8e9aXULeNFMuCPz4zw3QceAHQPzwdRPrScZvRGt9EDWwJdclw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657542;
	bh=LV8ReXycMWtY50YkZk2Tk/183Q52lPz9WKUphiWP2Uk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mjeJdjeiPlXLbO8IA3sJYm17h62dQbrw1s9GE5VXc3yJD7FUJ+V2bVT/zs65uLO2j
	 xLM6oJy3QvsB/ryawaXEC0yk70NK2na8NUJfaK/ZrAcxTwbIM7SJpwt4bD2dr4Yane
	 rg9kXmEsvziBVO5r9YEvcN7huLblFEuNlwWNbf8Ovly+Vbc2/ikCiXRrpsS1C//wKk
	 utbi0PGBO/VVuVGEbHoM8hlwg3HMEjurj6S7PevTdP0e6+IIHrUSlSFhxOALMp1UdA
	 azG5Er/CHnNiIesSVITC5O0I15y16ZIqyWDoWm9ZsEcWF9FWzP5DSoS6MeAlmxeHms
	 aAquTA8KJ4rXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A688811E4;
	Thu, 22 Oct 2026 08:25:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 029FE3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCEFE60823
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DCtVPCLbHdu for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:25:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F01FC6081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657538;
 b=LO26d4aDCT8WJKpdPZgx2Y1rGLo4eF7benfBzzc1DdmALEyHsVJuxYwaWDbs5c53WXBN
 /KxcSnNyzXillvKrMADKsytcD+DTC9l0227MpgU2MfEuB+9ga37/lh0Ug8XvwK1MbBSC1
 XuixDa2NoLlyWQYcv/WyvVwGgAxDW0LWcqh135Yc98aPmJnLWSfar/AzNmRFiFd7Xpfek
 5vK5uHjEhXBAapRtZK2gmAXM5BRulheWAGPBv0wCV2VojFRO/Yiq4x2/0q0pwIsk+3Mka
 T4fQEbAuc444lPrTWXLKP5EqimdBBrHEQb2GRvdIhIsR0K21IPPuU/z92FymAo1RFRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657538;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=LV8ReXycMWtY50YkZk2Tk/183Q52lPz9WKUphiWP2Uk=;
 b=FPVyo2S6NXod3p14NKNbwUKcOfWegpLWfOPgPlcTgykT7S5//OUNGPepUtI2s0rQhyi6
 ZkB1OfXmXRJ94X8iAcCsNSwsfvCpy3Ub5JCRBnGNIwC0E0XcIF0IBw+8G5ysTlKH7ThGD
 N8BEzQYq9SlTwGA3o0Ync7+u27CKNNfiedKHrXvmrREEafBm15rWPODWbWwL8JHuH1YUt
 fJTEXDjH7VJ4tqOtZI5dc+GWwvqbESHJ1NgAYV/u3fGm9h2TYosLZ5OqgCqdUGUEO9w24
 B2ifX0cnh5/RxPhxIcVVMfcO1oxYI7teOeUmX79hMopb3LgodiCooQ50HAg97/iRW+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hXNA2CrA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hXNA2CrA
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F01FC6081D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:37 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso252816a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657535; cv=none;
 d=google.com; s=arc-20260327;
 b=IGW+pcZzHz4fk/AmdOjRaxVCvr9XZj6r4a8utChF4OIY6kITk0gZg/jKf5JZ04hiYq
 /QVBm1iSTDVwMY/RRO9/g0QY+yVVJA8B/P09hT9ia0z0rcXGN3pwFL4ftLO6w9+F+NcO
 VciZrcbvKMjnqppuolJmtm5ZGXqIqdVJZ4w4ASNwo2+e6Nw/r9hXe58BClSoy5WvRizP
 gZxFcHlBECc40L32iebYeuwyBabjmuzX0T8ShVn/CiCXvfuJV+6AuYiqdOzzbEZL5mav
 gUuD1rEZ+6zBoo3eFi4TUDSulMED3Mgq4KJTqLA7gFgphS/rmhHZ9GJgLT5Cvk2IYwRL
 Z6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=LV8ReXycMWtY50YkZk2Tk/183Q52lPz9WKUphiWP2Uk=;
 fh=PLC16g473vW4rPzOUieCFc3gl/NLU+haz3bZBRKv6oI=;
 b=LXGUukz1G1EVhQxYl2PLZQXTNrDBE606I/VyVavlgZ5KhvdH/g/a/FetRgrl5kyKXu
 LKru2DkE0H4nDSeWam/nwUjlnwWa5c1880wsDEVYJX7jUF8mok6+DmmPBFOIVQsb6ZO0
 aGMSZdEs5QGNosi2Frcbjk9DO4fFk1JPC8qjZT20BRUb1ZZeO5DhRcP0X8sHiaO8UOsn
 VgCTrYlLtM0fFbGu6TizeIG9nT8K4M3oTuuWBACJHhiMkBeeQOgx3YlkndpvLhHr+GD5
 ekwlPrwS6cfjUEF/sdyymAw5C2X3lpTvwGlJNv7rAW0gqtMHOUT92/Qk9CcydDjF0aOj
 jdHg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657535; x=1793262335;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LV8ReXycMWtY50YkZk2Tk/183Q52lPz9WKUphiWP2Uk=;
 b=hXNA2CrAU2UY6Kl30KAqOfcIg3XWNuwkrwdMPpKqLFLPstrPEx/HjyD0fYQmll4RNg
 ZV1cK1ISuC9uWSc8yml8IbtOOCbmJSgWS708mdfx/DeljV4Hyr9qVoY5jcrG7KnQLgln
 7QIm4WxDDhgIVk2A5N6f3FzlE1kzaEvYKGhBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657535; x=1793262335;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LV8ReXycMWtY50YkZk2Tk/183Q52lPz9WKUphiWP2Uk=;
 b=KmOmdYJYq4vGUEtK5hYBLG25uVmY6yLHzSEy5RBpyUIi52HtYyLBVNkyLfcHKEPyXy
 1pJ/OX9eFfIt2k7KoctisrOrqFfj3gxVd6ATC9eh1qUDSQ4EoTbft6dD4MyVL8uYNdYE
 3JrvyBYA0APcg6d48L6FdH6JMgF/IpUGikx6YpQFj/cxIr+4ERA1UDfhq0Y1hDWwayBy
 cTCzjgKhkVApHOKi0XXBw6zc+U2+lGuPMs2RwLrXHHK77IzZ6bHaiG17+WOSfaRlZDY/
 uz/T8M+8oZDpR2PxKfC4R69KtFja25j24J0ErN507HRSSk8qjClcjTEsyKJlX4ANt0Hl
 bFYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByEZTc59HcSeCe7vczM1UDV6M5855CNevU2FLawXDKkyDltmq0FNYZ7uDy4SwLnmjbVjWxZ408=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIY1ATyObb3u7OQuGSm01v3f0vgO5HIoAwfDkUDZOcuRSR9ykuM
 Mrixkcx7n8x9KyD+mMCs9ilqaUCawm8/CgnYA87SZ5BbLIRQW6dxiwzIrmd3R9go8BQCCVLkffZ
 AzHdFlw2ZlhHg9WlWrjbD6R7SCxSXft9Ek9kKyH56
X-Gm-Gg: AYBFou30bPq8ONuSt8Ks7nm0SA6GfOScovTrMFwig91Y311NjsfAUCryVmrsM6VGEzY
 51LFoQ5NMR9rOSAH+Iylpw2gpEiYNa9m/HI7HsdiAHNsepPi8qiACVX+60vorihnzyHggR5z3tD
 uw6UfUoC8jZWz2eaiLWJlP9gRm9gmEtKL19vzlfX2DqZIx9b1Crqbu5LdfkP191fcQ6oY3yYUTC
 bOhMb/P5r51f6YwmxvGZ9zP9xSHHhXWUPh5YXlO3/tjIa/6YRqkwjfGxJ1EXzFg8XngFw0d8AA5
 Dkd7xMSEAOktUlNt00QaXUkFZDvyfwjz8ILS4696oxAL5AdpD3MGZxDU98hYEEI6vCMz21GjPZe
 1IwtJFaFAcwWpQuEyXbapnsIcolYvaGoziofP
X-Received: by 2002:a05:6402:c50d:20b0:6b4:1a6:97ea with SMTP id
 4fb4d7f45d1cf-6b41d60812cmr1166214a12.12.1792657535497; Thu, 22 Oct 2026
 01:25:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:25:34 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 14:09:03 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-2-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-2-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:25:34 -0700
X-Gm-Features: AclHuK_I03rWvvrlc-NruvJs8r2T-EyLqsP5Ov5kwSywMYL30K80MFJogYojsfI
Message-ID: <CAFLszThuBtEojCsGFSTVOkbPEm5s52OBjpmdYeerz1xzV7rjPQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] test/py: android: Move android image creation to
 a dedicated file
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: android: Move android image creation to a dedicated file
>
> The image creation code in test_ut is huge and difficult to follow.
> The android part contain code duplications when making mmc7.img/mmc8.img.
>
> To prepare some code refactoring, move the Android specific bits into a
> dedicated file under test_android/.
>
> No functional change.
>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  test/py/tests/test_android/android_image.py | 135 ++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py                    | 129 +-------------------------
>  2 files changed, 136 insertions(+), 128 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
