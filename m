Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F353DCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB3784862;
	Mon, 25 May 2026 17:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dYhlv+t/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685FD848C3; Mon, 25 May 2026 17:15:26 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF918482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bcceb394417so1176980966b.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722124; cv=none;
 d=google.com; s=arc-20240605;
 b=PDJH/q2cZkcHvEfz+cq0p1g1PSb7368+61kyE0A8YNGeeZOrhLBRuRTKplqV9Cl06D
 JRs2+0CHeAVrkPP+ouVLqnCRHz48f2n4OBMN3dtF9Oc8Frqo0XvblCK4Tx+sLE6olUfn
 dAhIxMciIjv8MEA06NUOI5hku9zVAKF5yROBno7IPlctvqG15v7arCiP/MxpEOY8hagi
 RF7MUTzBI/JDUpi0qu3JNqBRvs6JTCW8aCGCSdXMphFUzkoYZRpinARsC8ML3eYuZtm4
 1Gi7ddbS8vvoTAH0/NWE2DJ60mWYxGlPNaRDXYYRWVohDGSwkxNjH/jYjXdMRo2jacTi
 Iq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i41RkZBXBmSjUa7Te0R/t1cAd98Cz0Kt8Odp14Od70I=;
 fh=yf6+0PagpmJ6iaxXQvGB/IlszTU1tSpymH6rJ0Hygz4=;
 b=MPcaACkWgI91XS6ucB3N0PdOE6NrqRvJ90Q4I5fMLIg1HkEGsIvZCAQUYMCWObXoNV
 Crtp42jVgjNwHMx8BL8CQ+rDpMfJRke36ppxD8EeheBv6zO1V6TBoKwaMm59Farev49g
 Q4y8X+D68flta1ScyOwl6XQcvdQgxcllWCwM894BO5OuPMs21lBxog21MV3etunj7U95
 qZJPiXQQZrzPec5MeZCV6UHH6Gmqhu+Htn13OklNqO4iulm4CDxk6XCt/bUg1evoFoak
 uwTEjx4nbf2nI0WTCZsmMz5XY5HOq7lYLwY/cHeTYb3tY3W+454Z1UBfbI1EKHy69lQL
 moXg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722124; x=1780326924; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i41RkZBXBmSjUa7Te0R/t1cAd98Cz0Kt8Odp14Od70I=;
 b=dYhlv+t/IifGJ2uRHA+HI4LBe+NuFf8APOoH4sRx2mUt0oIcL/VngFupBVwuyQ6PIt
 oU3BJlWh+WLnMS4TwqHio5JfS5gdnuxdelB61pVwt6iz3NKYfsncwpXG1jyzoxr+xGXq
 p3oTsk1LMLDEX+tNSAhDESBjbHZTKfk1XPRyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722124; x=1780326924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i41RkZBXBmSjUa7Te0R/t1cAd98Cz0Kt8Odp14Od70I=;
 b=ZkIGD/byXZE2AqHOwQnUWy/15d2wI8EdJB6Cje44ohpTACeMhiSZxWeQyMcN4BxVGc
 2T8mU6XtD51Vi4J4QiQ7i4WKJhR9y9SXAYq0Uxau8CtGsFss3/i7iWr9kUYN0h/tkBPK
 MooI8SGQwqr/xfcVUfWkbgtozDgbg5aixThBw95v3GYG6YF02e+NOgd/ZKT4o8kN6GPt
 O9IfZlkk8n9EixgRew0eQU0yaBV2rqT8SC7TN041E1DHoO5T6hL3XnHRYnXgPaBVX6VK
 5405AoRmCLrmpFvwo33DxzU4KyEnFhQOJC/QoWEUZuROaMYNuDzivpBGoynepe9mPj5F
 5oAw==
X-Gm-Message-State: AOJu0YygbuRxltm9v/vx1q03asSkIBDyHFBFcFMrAi9vth0dIQSUSVEA
 6+chZuTlGeIUfHb3C+3O+krz/Nqr1M0vUuhpt5z5QXmlvNh57HS3I0YGGeMQvv+kYTs5NHWOs+7
 VXIdAqKjDhMPJm3BHUwRBu7El/kggqTv0xuRD0RN+
X-Gm-Gg: Acq92OGPwphm9Y0PSVoeUka93DLZPQtkyv/9SCZqSiYA2FoGJovsNETNUCuIRMhX4+/
 98rTIzDHNeGD2v0Vh9uckwwp36KODjrTFlsuuYgORK0WeftNOqzHYnMHIG8DhBa3oa2gfGB395Z
 TZZchqzCpzQoXeRkbD/1Ho97DzsRKCY/URDDFeBH+Sp5+ZVQQ9NVgkhgECRa/iuejk0QdXHEbOB
 qP5TaYDjQxyjd82l6++ulDjJ22rEG4DsiWOO6XrOytO8or/qU1+8eWcM02NSUjkXij4qNMNErUA
 dB0ivQ==
X-Received: by 2002:a17:907:3e0a:b0:bd8:f7f5:269f with SMTP id
 a640c23a62f3a-bdd282a7439mr944972466b.6.1779722123945; Mon, 25 May 2026
 08:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260518204605.1415006-1-santigio2003@gmail.com>
In-Reply-To: <20260518204605.1415006-1-santigio2003@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:15:09 -0600
X-Gm-Features: AVHnY4LBWSMm1NF-Zexoe8z8MwvXiyM9wlWfRXSJqaKFw9FuHDtvvbzh1suyvaA
Message-ID: <CAFLszTiqZb8g+aXo4picgnGESa8tEs1ohP47T=eJ7606ADoOtQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix extra dash in KBUILD_CFLAGS
To: santigio2003@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

On 2026-05-18T20:46:05, Giovanni Santini <santigio2003@gmail.com> wrote:
> Makefile: fix extra dash in KBUILD_CFLAGS
>
> Remove an extra leading dash from the KBUILD_CFLAGS assignment
> under the CONFIG_CC_OPTIMIZE_FOR_DEBUG conditional block. The
> extra dash breaks the build when CONFIG_CC_OPTIMIZE_FOR_DEBUG
> is enabled.
>
> Fixes: 56ae3c2a44fc ("Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support")
>
> Signed-off-by: Giovanni Santini <santigio2003@gmail.com>
>
> Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
