Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0649CCD19F
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9EA838C8;
	Mon, 20 Oct 2025 19:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bubSD0a/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F73831D5; Mon, 20 Oct 2025 18:49:58 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF6082C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-580a1f1f187so1906954137.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760978995; x=1761583795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WLb+/mETn4pYiDVZdAsuyRDHgg45zRbAQjR12rjtYPY=;
 b=bubSD0a/ACoY2jaT42FUcZdn4kfZGis7BVNpR/gQEiFoDb0S9MjA2YYf44AwO8bUgl
 m0VSjyqPiIvFgH6DS0YSK5+Sf3sqeCvEGxMD2k/1fvcxrED1BaEPG4snEun0ACST1zjD
 Mx/ayQtYzs0hEyj6mMF6Gmldm6gHo5uoT11P9qxvXrriV2QaBrmCGXUa/jCskYszqgAi
 BwfnOZgRDnOwUYK/4ZRpw+yHrRebjmPphec5oCty4FjfpwuPGr7aTpRsID/OmNpEVebe
 OUmRvzd6dj/LjynZzqidOjThLvzNGrgTA91Xma7CqSYIuRa7cro9rQzyams5/woNallZ
 LP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760978995; x=1761583795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WLb+/mETn4pYiDVZdAsuyRDHgg45zRbAQjR12rjtYPY=;
 b=ay4IF92L6xOru1zlJIzH5WqC+nxKRPYTCwzy3RQaQolcmaol1fJDR997QeHASETLvN
 7EJ+3k63KWdI2dimCL/4YovjPlCU4mlZwxhpL+vIcyAmUcmAJUG2rCm5x3jRYfZTfWjH
 1nxxc5GG/k1u+b9CaFixlzp1T7+sX6K0Y8nmC3b6KAOgkt+2ifzz20FkolyWQRvelhT9
 iEE7qS7T9P+V0jPAQv1DWXch7aBLwjIVeCH183KpjPNzLm3PcQ+iAdDeM+MR7zJh7xjX
 hBVHa/LyMCsaf40fDvlj8IAEV+0gfWmjFn84rwKOwpv1bbkgcOglaHqfIFHx3Vg5L4sj
 XGMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXRE1WRWDqeF9lLL501HUZ3ESQuwCwmJB4AbYlrp0vB5c+vQHs2wxcePFXd65unSkdfYqLbJQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyYp5grcASUwbnZ2LWCxMLkMqdjhD6++5xCEI4pgtOWd6xhAV2A
 4o2yReu3HlznonTY2jHzjcXivMrFo03sSMtcW80EIzfC/29hUAooR1htmvIXQ8eZEg6IwwXF9nn
 6COotbMcd1Yk2gmgrLeethFRw7Mlgi4M=
X-Gm-Gg: ASbGncuG834/acTZKscy/mr4r1QgCaOjliw2eQpxmQurMjMhCqMiqembesWeZfLhF7U
 r8aHdlfNSTGLHonPRSFbNdbdXH3uz7Q7unEgdcQyiRLr/5z+cDMbAb/04m1udclXGvtCMQr2LgR
 wsJ6oz0XZFL7UydQx9oDbeRtSDJs2S7vAkQX4s5EQLCCmr/8NW2MQfLY4XNq1tbbb8c3CaKttqC
 MsTNuLMM5fVPr3L3gb/FGXlmW3tta+rOzTag4L7S4fyj7y082FLvdF5LYbOpigQvPgB/taKT66z
X-Google-Smtp-Source: AGHT+IEIWaqpAN4RdKrj8xPNyP2EUwSp1fY2Hn4VHh8V4oPcpkGK4ieXqBIPoKc/KGRuFojKFXepLERIKTViIBvttd8=
X-Received: by 2002:a05:6102:f09:b0:5d5:f6ae:38d1 with SMTP id
 ada2fe7eead31-5db093f61bfmr490045137.38.1760978994978; Mon, 20 Oct 2025
 09:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
 <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
 <871pqdaepm.fsf@kernel.org> <873484jt3u.fsf@kernel.org>
 <CAFLszTjuZb=wwQyKEJFj5TAMhXcWxtuNngwFAURFzju330rRJQ@mail.gmail.com>
 <CADgMGSu1es4dex1u=6ai4WEBK2Loo2RAZdONRf07AqTWhZL8mQ@mail.gmail.com>
 <CADgMGSu7n+85gzdescBJd27WKvwryhtvXzY4MX3BWR=oLsLyhA@mail.gmail.com>
 <CAFLszTg9pwt7p45hE-z+bLM-RNofCouYA-jtXDw7RP+HbFQ3Jw@mail.gmail.com>
 <CADgMGSuH21te1Mqy3Z0C8R6seoUHLffvLyuVY-ukVtKHi3GVOA@mail.gmail.com>
 <875xcow8d9.fsf@kernel.org>
 <CADgMGSt6BCPvqcd5z_qOJHJ_S9hsfdb3gVb3pS5MaRf8oBfyEg@mail.gmail.com>
In-Reply-To: <CADgMGSt6BCPvqcd5z_qOJHJ_S9hsfdb3gVb3pS5MaRf8oBfyEg@mail.gmail.com>
From: george chan <gchan9527@gmail.com>
Date: Tue, 21 Oct 2025 00:49:43 +0800
X-Gm-Features: AS18NWBELe9vdqKO8OnpNIlwLuGje2jOdcmAJ2zfEZ1b66pXKS6FGeEC-1kqOG4
Message-ID: <CADgMGSusH9kpX7iKfHNH4LtfjJ12+TddpANWoJ2s3aReL=G7EQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, 
 George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Mon, 20 Oct 2025 19:17:32 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear all,

Since as the known situation, I am letting go this patch serise.

l will split those soc related and abootimg related patch into individual
series as followup.

and there is nothing i can do for fastboot case any more.

So thanks again for your time.

Regards,
George
