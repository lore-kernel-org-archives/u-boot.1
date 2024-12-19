Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AE0E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 03:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349E180241;
	Thu, 19 Dec 2024 04:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MfYAb4Om";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9015A80274; Thu, 19 Dec 2024 04:11:08 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C4158033A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 04:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4679d366adeso3315151cf.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 19:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734577862; x=1735182662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a12hVk/FNWXpWDJhum0NZRJZDVXywvvEKgSKni1Zblw=;
 b=MfYAb4Omdozs2N73ACbbmxbeFr/LgihNCNa+o3EeG2DoGSS7x/4Iadsp3oSJvZiTMA
 5n3wb5tzNQF5bHTNIjPgxy6zbncuG6qWpemL2a7Pf8+KVfqR/D+gho8w+XCcQcOGRggq
 yRHx5dUnk6OYwv/WvOQXjBE2daN2d/yvYN3f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734577862; x=1735182662;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a12hVk/FNWXpWDJhum0NZRJZDVXywvvEKgSKni1Zblw=;
 b=HsYIQTZrwkjPqZ0XMUtZsack2KgRUQE0HTWfRvRZ3yQYEHNFtnf2YJLdQEqmkC6M4+
 BQptV1LSF9vZQu+tluxh1NSbnNiJUzLPANduHZXJhe+ecypW5Ix8SIGTZQbCcOH3KwEu
 exFibvIZwtsF3MwwggUJ4cX8eZGdyYOLmSVnorT49N/ncPkBGY0B3fswBEisry4DSpuX
 a4lUm67Qimk3eMy74zMBICYBPzp2M9ysu1nVZ7iUNpGDA7fYCGar7a6MP9xSomj5W0CC
 2uGaOJNu8VJslNFxbVkV0HmQQsCQqtDoV3Nb20JdjOPnd/gadV5wZYm72p8q5+uISXyS
 hE6g==
X-Gm-Message-State: AOJu0Yy3gH96j1Rkx9C0mYglzlb2erG3bw1MtPxn5rJKMVsVMy1Qbyx3
 P8ii65OHw1RC0J+MuS9DwSj3VyTyIGcFi3u1gvKCmIrM5GNZDYUp2dcv4vN3/5m4p+GyveXc1Qq
 h
X-Gm-Gg: ASbGncv6G0oDVjsCdRw7k0hzbW3nWunJrpm07R3LwC0jaVv2fzj21HbWSpjFlaklvhl
 2bStIv1gL3er/PDSchVqpZwpL96g/BPP5PuR0ZYV+fiFkfDnwtlP5KVr0IuFLsvuVnnPrKqLfC/
 5Ua1dy0L+2yi31f+k9gRuyZOATShQMx8zJd80AoD6S2HJzaQbcs3WlgC54R7bEQjLD0hQA9H3Vj
 56xMokeJLVDliMcy99VmmH+Scnt6gS0YHAOfPhVoqJfxL4doN20l+I=
X-Google-Smtp-Source: AGHT+IHGCpnfc4GdGw4doWmClDatqnnZHM0lpB1Y5Hq0jJy6Sn69NkCeXXXiOUgUHegb2KkKidRUqQ==
X-Received: by 2002:ac8:59d0:0:b0:468:f858:6662 with SMTP id
 d75a77b69052e-46a3af9e2acmr35571801cf.10.1734577862086; 
 Wed, 18 Dec 2024 19:11:02 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64cb04sm1751541cf.8.2024.12.18.19.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:10:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241205-upstream-dts-v1-1-5a6bf6ccdfc4@posteo.net>
References: <20241205-upstream-dts-v1-1-5a6bf6ccdfc4@posteo.net>
Subject: Re: [PATCH] powerpc: Support using upstream devicetrees
Message-Id: <173457785724.3566318.6672827352198895767.b4-ty@konsulko.com>
Date: Wed, 18 Dec 2024 21:10:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
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

On Thu, 05 Dec 2024 18:22:00 +0100, J. Neuschäfer wrote:

> For new PowerPC developments, it will be useful to borrow devicetrees
> from Linux. This patch makes it possible.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


