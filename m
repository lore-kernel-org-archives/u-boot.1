Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F32C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CD882DB8;
	Thu, 17 Apr 2025 20:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DbAb8kmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CCD782E8E; Thu, 17 Apr 2025 20:41:05 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5255182D5E
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5498d2a8b89so1153917e87.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744915262; x=1745520062; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aG4XuQYr5LOzjKtrlQu/4h4ZlzHIhnmXcCeDiEDp2A=;
 b=DbAb8kmIFodyqgPgFd+pNA5MpF1ZCgYPZ5K8uISMWkG67vFgfZ8A0DvZ7H589AkWRw
 +I6gDFuvgtVkUP3wSSuIyHT3Qz4ipa62bLzJTphO/fiD466zxJg3uiA8fzhQdgGO2+nZ
 EV/FVcMxgF9Qb4xb51YwmOzDyPuHEze3zwz6lvQtwfIIupPK7jLsaqn0ZSfvjYefdBD6
 YvjsLz118OYCug1kWOhospvjKdLoDCf3xQ0PENxaCdZx8rzJxcDHfA3EwyozjIvg7SOO
 wV4zRJ/aMeZXNKcVL/YJfylzd6Awb0N15ouHTwMeOjABj/Vxoq7jiLBha7nDa24Wkj2K
 PSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744915262; x=1745520062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5aG4XuQYr5LOzjKtrlQu/4h4ZlzHIhnmXcCeDiEDp2A=;
 b=sbQ3fP7/6Oifw90jpDoiLebC6kGdWv2MdC+c053m7a8PWMyPS7TRodxgg6gpvTk6BR
 iuZ/8uSUrnW1QCTJ2bdt1Nig4emh0Chsvv9gGht5agSph7tRy4NxIqj7PaZG9H2+GUSC
 azqAkeBkFyzBdJyWSBbMCu6YKFwG7CautSpe8Z60r9Z0YWF9C/QMZ1UsqJad8GZ0WpH6
 4+CvjDYQaO1N3CeZpOLoGQzmVU5pTG/WUs1mXvm5Jz8XCz41pVwVJqssYlUyhWwaTlLR
 Vs+/4DA8UpTRTaJLW9CvrobWYXznSGaGZVKDA39xma02Kr43FpYQXbffgv2i2cm0EILL
 XAlg==
X-Gm-Message-State: AOJu0YwFQ3CcXJ8WY5CdlfAw6HkJW3yj8EU0pCeviAj3/B9AxrE5pkdD
 GoB3SSDqzVMPE00tefS9cy/jEHXTlCKX7+jEQ25MVjfyxYLA2XHAcm7SuopYBq+jNHoB3kl0A9C
 9hAypyznxQ8IqnbSpQfqbyEHRqeY=
X-Gm-Gg: ASbGncsN9BHvv+xH260GCj04RQOWzBJWWyqMOiQPTt2IRFMnnHVx0s++KWxktMUZ9o/
 n4+rHTafyEfL2WStrVRVW3JfwgIVKilP4YcaGdJLJ51d8YpdAerSvsPh3k5FKqMwn1L2XCREUHC
 0IUVJ9mdxFYFJN9AfHZKQpTPCNvIjAIGt5PGoCR3bODacupySFmzXqNg==
X-Google-Smtp-Source: AGHT+IGdwpYil4ilqgw6ydsCRkarISZSo4JBEE8bzTLBvYBsVyMvvnuRxMN87tgKL/GFPUtFMQ3Gi5+Y4E3ugegX9So=
X-Received: by 2002:a05:6512:3b98:b0:545:746:f36a with SMTP id
 2adb3069b0e04-54d64aab2b6mr2411727e87.34.1744915262271; Thu, 17 Apr 2025
 11:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250417181613.1355024-1-sjg@chromium.org>
 <20250417121601.v3.22.I321f53b875ffb594a569796509e64830b9f3fe09@changeid>
In-Reply-To: <20250417121601.v3.22.I321f53b875ffb594a569796509e64830b9f3fe09@changeid>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Apr 2025 15:40:50 -0300
X-Gm-Features: ATxdqUE6tG6RhyW4wC62_C4RsovFD0Gsr5cCZw1YU3mi_fGCtBnnPzP2ONBelCE
Message-ID: <CAOMZO5Ad4cxuXzdiWO6y8UasJ08YV9+gyjTV=3hqFJH7QbBGBg@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] CI: Add tests for gitlab and azure
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Bill Mills <bill.mills@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Thu, Apr 17, 2025 at 3:27=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add tests that

Incomplete commit log.
