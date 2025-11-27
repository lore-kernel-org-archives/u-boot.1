Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA322D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8E884459;
	Thu, 27 Nov 2025 18:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VvUUXDCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B144B8448F; Thu, 27 Nov 2025 18:48:26 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944878437E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c75fd8067fso641377a34.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764265703; x=1764870503; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ElPV5k75LQSBDCPI4M2AuE8aym+4xT9Zdiq4PXIlmZo=;
 b=VvUUXDCxeDnDks7gq5PS4SPKg/auE8SGGwH4IE2Anlyr9WZs/kfYPYkFBKjMq0bfTI
 iOd1/TEAQivgyV7mxE0LheEXunB280hqKL7qwi3Ut0cG2LiXUkc1zAYUS4UdQ5Qi27Ia
 j4XVKEjg0QHd5fQ0juWTuADZibHYs9nLVXrCi6hjdEicPYc1dcNsvKpTHT3AqgK1qZ2z
 uxLyaENnv3kVZ2BIc0/MYGi0YJfnJLDTHwV9UapS6tEZWvZGEsl/gEAEqX5XCGrQVdQz
 LO0jUKx2ua3uwpXctI2SbXi0JajeNdH5jJ1GqRdlhn6Dj18o2ET/mQKnUmd2gkgbluYg
 uZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764265703; x=1764870503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElPV5k75LQSBDCPI4M2AuE8aym+4xT9Zdiq4PXIlmZo=;
 b=r81Koer7jXa2OC/TjUp7FVfU+K0DQuObCGd9wkDv+w3ksDh8qwuIZvg+0ar+XeltTm
 4a1XQY3DlWoPnebODjE/Wd1knp2ErsTwrmjYObV43TqfJG7+hAOyuU8k0U9uhsIIirpZ
 Jwj6wNrmUsFyH524SvQsmD+3zQke4YEIH/flYXzJnPsBsrBZxce24kySZMgRE+a+blbX
 ctYw3oA+oeeF1JkiQjUOrKD000Q7KcTHtxCIjfs8tmAZUE/BUh5xP1g9sjvICqgM9NJH
 q1ZGzqPErhCxqovbSjp6OVfiSF/9kv6MUNFitFZAkeUBqVC2ISEcDbH1tnICPRhxFFL4
 4w8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrspVet9++6gk9jtmH3LoJXJm7H9Q2Gwroj28jx0lo5ML1HVWw8LHgLvDyLwWQQb8P7kPwGeg=@lists.denx.de
X-Gm-Message-State: AOJu0YwLNbSyg+GkL+/EDaTYcrCdE5wbMr2OIkE2iGfnanYT8OLEMtVu
 OoNd1lJc6PAEkt0/RQWRUJ++zRLeZtozp+FsyrADz7F7z2iRhfzFfu3fqRLVHHpc//d/fz7u6MW
 CmDofluVbSq8eiu/AODC4r2imQYHRCdpQgu3hutg=
X-Gm-Gg: ASbGnctZ5X9bgmkQPURqG8Ybtehpjn/YlIzhNiSCbIpH5l5vl1MVBRoGTiap8hTeIRL
 HS7Hp7maNWPWiLeBS9d/6SHvlHT98KdlXMAMZcFxgk5AYYo4ALqWLhB4pt9zCMsp8Hr/b9hBM1H
 +nb1M1nYd6B3vX/wXL6xE+n9far7WBtA71TXRNJpL2R1q+NPZQ2fAwheJPJb7q66MRp7p9nC9f9
 RNHw4EYd3RY65kxnL+PYxr00+UCxJScNAkrn1s6/VHIwyU5xMdHWSjGum+mHGTvdaiRodjpMhLp
 lqGPSg==
X-Google-Smtp-Source: AGHT+IGxDL06xw3/10JNWD+7rkAzCG044orOuF1OiTlkhZQMnVfLJD2ZIcPxqGHFWtz4nRPYi34cSsxQfHASrSosWMw=
X-Received: by 2002:a05:6830:6104:b0:7bc:6cc3:a624 with SMTP id
 46e09a7af769-7c7c45314a4mr6281154a34.32.1764265703286; Thu, 27 Nov 2025
 09:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
 <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
 <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
 <CAN7C2SDH6g0PgDUsu8hEnEA4yr6z+YA5afWhK9-D7-7wBbe33A@mail.gmail.com>
 <b977adfc-f16e-4436-91eb-8824932379af@siemens.com>
 <CAN7C2SCiTqJDK2ZVjJ_859NEDg6tD3KWQqzVHqqmbyM8+aBvLQ@mail.gmail.com>
 <d4b1acef-fd8e-44d2-b583-450d4c61190f@siemens.com>
 <CAN7C2SCQkBfbq1f7b6W2sm9Q-rtB3+5a5NUMOrXWCite7BTLNw@mail.gmail.com>
 <4f44bb43-3b8e-4cc0-956b-af6f1e6e65c4@siemens.com>
In-Reply-To: <4f44bb43-3b8e-4cc0-956b-af6f1e6e65c4@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 28 Nov 2025 01:48:11 +0800
X-Gm-Features: AWmQ_bmeBAaHFbUqLw6KPej0InvHY0pUaZRGL4p2pWhdizpjtvmpLQD5YIwPbHI
Message-ID: <CAN7C2SDKj_Pstez_gPOu3CSbNU9uzn0eBTLgpTK+Ezs4fg5qqQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, 
 u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

> Now, let's assume someone still wants raw mode (and [1] suggests that
> there might be cases), the raw sector mode is not so desirable because
> it forces you to place the binary at a specific location on the disk,
> requiring that to be synchronized with your image layout (such as a wks
> file). Given that the romloader happily uses part-by-id, I would prefer
> that for the SPL as well. Still, if someone configures another mode,
> that should still work (when providing the right magic sector value).

Doesn't matter I had completed all three modes boot with minimum
change on latest u-boot. I do check your patch include indeed is
bug. I will pass out patches and this group members should help a bit.
Just need to finish checking that the fat boot is not affected.
Old u-boot-with-spl.sfp on my patches should run w/o issue.

I will acknowledge your work with no worries. Then let T.F. see which
is better for u-boot mainstream as well as Tom.

Thanks,
Brian
