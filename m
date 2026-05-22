Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36082CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 17:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 745068489C;
	Fri, 22 May 2026 19:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pMqzEEMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF5C848A4; Fri, 22 May 2026 19:48:54 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE754846C0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 19:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5aa2691db86so5837528e87.3
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779472132; cv=none;
 d=google.com; s=arc-20240605;
 b=TElI0QT1hSfSEZICkrd3/uf4D6RkpXpPzxCayHsvynbp5XwzNz0JK/0retvyWmhz13
 EBxUdGT2NxWapzZ0xO4iWv4FPHS8SY1Hc6SNr0XEB8TWotS5/IseiF08X644B7E9Ab7Z
 ZVsnbQp03nZksXCGSOaK2BiLce1tdR5gEx133LE5G7loUYMP56RfajzVJpv9BKJMG+Z2
 sfn5baSwdrQVBiVU6WSUp33gmwuQN68sAJLZgfeF1E1Pq2j+aRuCPDlB1PQYNbzNcCoL
 PmL8pCqfEnOC10KxVXv9zAEHRpqfPBG8/JqDjfoKQUN62ZFxy27MH4Xaio3dErQV16ao
 4T5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K92lrvXgEx+T06bg7oFPHpwIvo63hyiu4zcZpe8V6mQ=;
 fh=WYYZAUa0Go6bNczUqhHSxDnQrgGwmW1N5zi/f8sLBTs=;
 b=TlUbSOqDAd3xsWbDT7GKF9oQlfqn+/unIZ9wimN76djB0621vpx+vBlXR9MUcKjMUN
 nTfmAHZQWy6+KKB/rdfHoh+0FVKvZrbtw9rm18HLvte1pwx3/G6WZlJbug42u3fVAqT3
 502R4gO4I02/nScZG58EY2ipTWkLrlE9QST5Lza3TIrhWOwyegItbtgTMYnZf9ON5sM5
 n+/VHuhS9oP5BBeQ24NX/qDQpFjuEUN0Z6LKaX/mzoZxRQQX0zVAiEJV7ujfoRnem71V
 2HTn/OqAwGkmg7KFem9uiEJU9AI1L6p9tonC7HalQJD0i23CF7c0A/QgArvz9oKmfd1e
 PGQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779472132; x=1780076932; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K92lrvXgEx+T06bg7oFPHpwIvo63hyiu4zcZpe8V6mQ=;
 b=pMqzEEMccVqIyXmTpgcK9y5u9fpmdmxd7BiyeYlAd2sYWx4OAk2VymmA/3qR/RPjg6
 Oax2hOgGzQnm85ClZqzzIpJq4ghYeDEfeyLfeXQNUcT0VLvqtj4IRbRoOAl5IMHS+qvM
 p2ERJJLr+iie45/VQyM1gLuGqX+FqhmB34G32OcU8hXnDCXkkMiAq6FrkLe7eC+qA93R
 0quBa8+UIROLbGvYyQcGAHi8HOFFeOlUpQR5JRVljUfiB0lQaODhxrwyiYCpqR4Dewyq
 Qzu46uHuz9wXk7LQFwOxIDgvQGCbD70mr06jd2mxXve8do7LObuL8uma8wvAq+8jZLtm
 b3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779472132; x=1780076932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K92lrvXgEx+T06bg7oFPHpwIvo63hyiu4zcZpe8V6mQ=;
 b=BMarRKXudOsPE0RyenPTAIep7yp3lJC4FnKFxzyoz0vvmjAkRRBXL1zyzCROCAQG/l
 dG9PYhnCltFHAlO+ZPU/RPmbFq4UbmgGtMEzP6ILEw3o02hqIP6E72bcrsawxxMJ7Iou
 LUC4isRu8ace/LdaAO0vGIQoXJRrCbFt3A0V6CdnkXePaVJYOGYXz6xbGtM4KoUBf0sa
 ieYrleEt8deAdYkCmWrCGXTQj+aryA10/mcRyyjnL6M1CfGmo2I7QK+n0LQykoXZ+aY5
 htbgJ1dhZgnKzBf6ew10+2zXjfhAHZl8o5RmQRr9S9x7Ua3I71QiNQnWmsexSAxdCKY9
 oB6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zetv3nsOvll2AsBaO0pmgNWUhT3WQ1gUrC18JlmhvpTdQVk/M+GZcdNX70zXtEfkttQ4saEg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6EHgRORuyzSWv1/CIlQFTyBqu5zlcFFFAR0wtQh/iIp8jt8xX
 B3vc0NUtIzpuzRzdI+hyEiOe12QYHghd8bFnR3o1lqALucj4zTkfWZtYllmPiLNvxRveUVd+MG9
 9gd+sc/s0V0LBdCjNn7zb7J7XXhs8gPI=
X-Gm-Gg: Acq92OHgh5joZULq5lM4vVA+y1jdtqOiBrlmuURvV8zx6bKb1OfsMCNj9s2yC+PtGr5
 OVMafnV7zBl6SBEU7MebSqFCchHOngSJVTzlghS0zSQUg5Y8rD7OaCuD7GAX0/kCklQ57IFjKpO
 n398x5vOtJ7j0C0xsu3JW4rTtFDBw9vcKHrS25NSoBIDuqlGCCtAQPe7U1SPTPjW8ijfXdOI9Of
 foPJBYhW9NLOGPRitOOuvoTGtHBuYwP+pIMAZ/YVN/g3g/D0EPwil5k0CnImWNpSMZwmLE12Qt3
 yDPe5629zo+YN7uKyW5At0Uy/Z+NMFv4b9F/Dew4JGMB/Qx8X4dtKiQ2FUm1FzCnLhOSWREGcTL
 42cX50y4=
X-Received: by 2002:a05:6512:24db:b0:5a8:f8b3:6c8 with SMTP id
 2adb3069b0e04-5aa323b83e7mr1017345e87.37.1779472131695; Fri, 22 May 2026
 10:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260518205734.163815-1-shofiqtest@gmail.com>
 <20260518215445.175753-1-shofiqtest@gmail.com>
In-Reply-To: <20260518215445.175753-1-shofiqtest@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 May 2026 14:48:39 -0300
X-Gm-Features: AVHnY4LbL2MwFPy5wU5-3hkvVo3Laekjem6kOTUEiW--vLSukJvIDmK9594HaJo
Message-ID: <CAOMZO5A-4Kyw1OdsWPM7er_fpb2LZeLffFhXJZkniG-yfXqA+w@mail.gmail.com>
Subject: Re: [PATCH 0/2] imx6: fix LDB clock source selection bugs
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: brian.ruley@gehealthcare.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Md Shofiqul,

On Mon, May 18, 2026 at 7:03=E2=80=AFPM Md Shofiqul Islam <shofiqtest@gmail=
.com> wrote:
>
> Two fixes following Brian's review of the v2 LDB clock series:

Please coordinate with Brian and submit your fixes as part of his series.
