Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08394D116E4
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 02:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857DE842A2;
	Thu, 27 Nov 2025 03:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KtV6OqmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE7F842B7; Thu, 27 Nov 2025 03:26:07 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582C183B72
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 03:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6d699610cso141925a34.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 18:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764210361; x=1764815161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EEFGJVDfHQNQ4+hv2qlZOgiBpTSZwX/C8kNyTq+ajOA=;
 b=KtV6OqmIptFQ/cH+C6k5iVQaVPHyXdHPHR15NAG4hVSlc0oE//f7Qa687Kesb3PENV
 oQRl8tlwultwC6VXBHPOEZqWUP4GsHjTFEj7N2gwVhDqtkqlB+pvn0bqo1Q8ufoR+QiH
 2qGJrjwP1BTXfGoN49WWB0PtWTC+ByKSRtR28+IgLHwVhJz5ZNCuBU6YNkJ0p3+JKTqk
 sCEY6ZHiuO7kBJ2pY1j0FTNEY1Ia5R1brpeeR6BXFdcHg9b/mKSq44kaaYkxaBkqYP5f
 YezGaoLkjoj+cUkwnIHmAv8OQUuo5FWupmk4rb2Fym0vZURiIHAAe2ZOmGZIWvacoYKh
 UPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764210361; x=1764815161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEFGJVDfHQNQ4+hv2qlZOgiBpTSZwX/C8kNyTq+ajOA=;
 b=GCt3aoYM6IJ9zfVZFiPxbQU5BlCnQThpFqbAZyNQthRSImQc84cbH9k63v0Js4GxUl
 Mb9dx3VwwMgx02Q5I6LjIoHKMQhzM1wZ+brhPQ4+cB4cnJw64Pakfepyas1iHNfwBDzO
 5CMOg5wZWsIEzGFBmnBaxy51pyxl0+Voh1oTx5TyGEAWzcjTVzvtdTIZkXwSM4/4zFlw
 7+HpB+D1vYwpop2jm3egW02czEXKCp2aZ/Q1Oczf70Akf3EgdQbGfU4DVmw/GNLMeIw0
 o8tMhSQ3V597qXwtyb6SeXS0m4pykLpKpDkTePRCtKLBT9k+j73Iw3F7QNvedOZPK5Vw
 +sPw==
X-Gm-Message-State: AOJu0YxnI4dFCO18naVSXn79SjObCU65g3usD6UDziE5tqj0LYB6S+Hb
 41FYTKVgQWKSFfV1KGqmHBmG5o503GWXcCTVIS3UzLK7ve1AgTH16KFgJAEfbVHHREkukGMc5t/
 epnPOoFOCb7nmdGFmuKFZMlosERf6H9ghRDhH
X-Gm-Gg: ASbGnctKOKhX7F6O/wNLPbGkh/OZeGblJQfWkxmc1nS4eWLpMSuUSr25wFVhKF9DjgB
 Y2V2RRf+BjUUe7R7taYahJ0HkcXi8F5R+N0MXREuADFTzMfPedbzsFiKrYehixu4SViEeSY5u1V
 40GsHHaDKoGPOI2+rFRtU0YSFqg81/+7pT3J+4AUsSRScyfNmuVNbAnEUNd8rBU1RW7/Fh04Z2V
 7PVCDA9BKh8h6PFf6g+u6n0ktPFk9oCc0QtRLsFn7q9sHGbvTXc4KiIy+OQAy5QGAd9O/U=
X-Google-Smtp-Source: AGHT+IEcxK8Fdkiwcy7DiMZS22CuLqDAbZedWmydeCS0UZWiNKg9TWL96fGsXO3YvfsU8kUxn9YgYaYtX4iYr1FjO0A=
X-Received: by 2002:a05:6830:674a:b0:7c7:8060:e197 with SMTP id
 46e09a7af769-7c7990ae5damr9447405a34.34.1764210360803; Wed, 26 Nov 2025
 18:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20251119111653.456-1-briansune@gmail.com>
 <CAN7C2SDvkci+ss2v6RjwEnmfWF5Of7wxSSHbsYwnd8Q39jZs-A@mail.gmail.com>
In-Reply-To: <CAN7C2SDvkci+ss2v6RjwEnmfWF5Of7wxSSHbsYwnd8Q39jZs-A@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 27 Nov 2025 10:25:48 +0800
X-Gm-Features: AWmQ_blcqXfMqqa_Ea4Z7Q2TPlNtBmnnevnj1OtdJXxySAq7IuZDwK3UOOXBx8s
Message-ID: <CAN7C2SAn9pFz_tbsS1QW7GNZVBgry6AnpqUXUDC6a3wMnRSMFw@mail.gmail.com>
Subject: Re: [PATCH v8] Add optimized Makefile support for SoCFPGA handoff
To: Chee Tien Fong <tienfong.chee@altera.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

> Hi T.F.
>
> Please review the new version.
> Thanks,
>
> Brian

Still no update on this please to pass this review.
So U-Boot can keep up the prepare setup.
Thanks

Brian
