Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184E61112241
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D327839DF;
	Thu,  2 Apr 2026 01:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FRUNRkCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365F383CF5; Thu,  2 Apr 2026 01:22:29 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4457B80517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so39057566b.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775085747; cv=none;
 d=google.com; s=arc-20240605;
 b=NMe4vmLBx+1NuvCoIrembyA4E0OKDOBHMSfokFMoa/49Nlddz6xz4XR7r9ZhPfUFcy
 2xiXwJwhPoa3anZNGaHzs6vsbhNhpYd+pqW/mMB8cicH2QhOyLUt/LlfTDJoDOIQ2fRK
 P29Z4TCke98kBBtHq9O4YkxMZshHDrAu32AAEwmZDYmjq7BboHleirnMtZ7F1pOINuNF
 rFbaFKSXW5sw1SC9t1vGpNroUggDqHrOr9UhqiXsaCAiFWDj8MQIoGAs7n3tvBTMehLZ
 98icDlGb5w7AzPVcvxApMf3deCY0N/xoouEsC+VfRlYJ+uJQYtDukxhPa8sfRizaQl95
 WOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ru+VqHDTCjceattOvXFgSLjUgJWJztJFPRA4v9jhwcY=;
 fh=pb1V3rC/YOD1axA7yiOFKLmIQEYkcRc0AUeTYO1Qr4A=;
 b=FeVxrqnml2XTSqtCFaUv9NGRoT1ShdWpTe++67e7qRhikJWOzWReMn0SL0Tty//RF0
 pHtKd3gDicUfjGQXgxQDuVS6suZwdxN2t4Vs8Pg9miOVmJoZOssTvGrmgi3ORsWjiuvA
 waEO+CTNnSTZeYRBgekohtQEIQ9XK9VqKv5/5WBN2+0BllIu1zRBtasuPs8zV2OIwnQz
 6spKrogZgHHwDQiALQLxNiS+AkECvKhQ6BTXgYfPtIx5UwB8LYdLgsKl57kHWDQiSDcI
 soUSPBsNJrV+1A9v5vj/+ytdWqyKsl4/NOXD1efwn5NVrBj/BF2NL265BB+VYfBi7up8
 F8tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775085747; x=1775690547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ru+VqHDTCjceattOvXFgSLjUgJWJztJFPRA4v9jhwcY=;
 b=FRUNRkCriUy+owIm1L1mSWGpBGPJVp4meH11SGXutla78XbCVomIJweyxbiNL1o1cF
 nuLBgdncHv5lNcqo/YffB2ttnVDW9D1cDwiE2a7RWbTzGR7rkRPH+Q38O8gLi8amK6Ay
 i7dCGtCe+Ni2o3G7HUbONZe+PFwrWRZ2vzbi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775085747; x=1775690547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ru+VqHDTCjceattOvXFgSLjUgJWJztJFPRA4v9jhwcY=;
 b=IyRdppPdr16sgkmcse5/wfpdcpq46ZeQq0z0S6ml1FtQnb0Z9nybmsmx6ng9z/oiDy
 Xrab9E+1/tDdhjB+v1Xah9V4lmh/XDQxYQGBGj7tL13pzql3xYhIMSsH7DSCdJovfA9Q
 AsLi3Paw0rvlBxkVtLE3d/PD+QmHrLKRH6IUzeFjlAIZVazseSSky0s+q9OjmEw8/vtv
 q8DEl6Sbd/Xzfo3Vtbjrjn/xKiAQtNR3+SOYDz/1Bci2oZGtPPhUrVmKRISGKl8WQhJ6
 P/qreVj2t0BTzrrUggws0hqw4UT9cu32Qhnbjdq9Yj5shnfIY7i2DOSTUt+dfxizBviY
 ySVg==
X-Gm-Message-State: AOJu0Yy1uEG4CWdZ44awFzRY5RcgCl8nQQZs0yn37ykz/bRexHXn06m5
 Ub1Xg7U5VNwys794jjX2lCoBz6zs/AcZty6xcmBSdXmMXhaczBwI+7EGHuJxvBEuC+v4aXDQ2kJ
 ewinIczzdS2u+T0uPpkVL+OWvyGBWTlDf4zNV0wGhnPdkwm3MczY8Ig==
X-Gm-Gg: ATEYQzwjbGO2335Z+YqXE5+U2BqgXYJEa5bSVcqHuMRLL4Ay4HHmV9yKIA+RAjVd+Rg
 QaPU7wSHOYFe9Z9YETO3Eys9iEJ8C6CuSirWTRE1i5Sx5C5LemugqVIUIq1Ah1pQpMzpadVt7JA
 R040DA1Y5ABW3xjPyWXo5lZt+sZ62mSQfAl20sPoxvgukLlm8PHfk8ACy2rz8jFfA7j+RONeCpK
 KwU9B9AwxvQkjw5cU7RFz7EmaG9fuIWr+ORF9TbZU2yNMhmAUxEgUAXrPJDcWmIeP6pYLMM8n3S
 rxYQXQ==
X-Received: by 2002:a17:907:96aa:b0:b9c:12b0:2e38 with SMTP id
 a640c23a62f3a-b9c3edf5de3mr60752366b.1.1775085746708; Wed, 01 Apr 2026
 16:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260331075338.2391-1-ansuelsmth@gmail.com>
In-Reply-To: <20260331075338.2391-1-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 19:22:14 -0400
X-Gm-Features: AQROBzADNYTM7CcJaK7l-5q5LDlu3OBLY6fLVzIC7rkTdqpj7GlLaUizPjHFUyw
Message-ID: <CAFLszTjkgOT6vBYL9MfbJ0X46tc=efERKmG-wT__CWjNt2bt_w@mail.gmail.com>
Subject: Re: [v4,0/5] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
To: ansuelsmth@gmail.com
Cc: u-boot@lists.denx.de
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

Hi Christian,

On 2026-03-31T07:53:19, Christian Marangi <ansuelsmth@gmail.com> wrote:
> This series mainly rework the FS loader to permit reading firmware from
> container that are not exactly a readable filesystem.

Splitting out the generic firmware loader infra from the
filesystem-specific code will make adding new loader types easier.

Maybe move the request_firmware_size() patch (5) after the
reorganisation patch 2. This would avoid patch 4 lacking the
get_size() handler and then adding it in patch 5.

doc/device-tree-bindings/misc/fs_loader.txt should be updated to
mention the new FIP loader and its partoffset property

Cover letter mentions request_firmware_size() comes 'then' after patch
3, but the order seems to actually be different.

Regards,
Simon
