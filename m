Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D29C87FD2
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 05:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0C583B5F;
	Sat,  2 Aug 2025 07:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AjoNnMrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA8B283B5F; Sat,  2 Aug 2025 07:10:47 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E1383B05
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 07:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so1818256f8f.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 22:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754111445; x=1754716245; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adXJUf+lCZ6y/TftgnAnliRm17RwAN/STYXD3ARvHEI=;
 b=AjoNnMrKbbongqS+yejzk7+aVnNZJmH24JxA4Ti5lwBJ/0bT7TLJwyMtsmt+LH9dE1
 aD18/QKdRIyUFO6N/ayClOdoMHFFd1pHBVU30JNPHGRsKolhJyU6H+K50kdPp/5OAKR3
 ZBq+mRBsEvkCbcRYiYwM1i1CjAMLn7EM/PIlPjFpZOZwJH9e94yocv95JK36BYO0BRoo
 hZ5jEqSdaLAkXrpT8BV0FgvMjaDkYZ9rHuvPa8CIagmicm4wTXCMy1/TReq7Zy+qGQOz
 NlP+41AHTUcCgGur0W4tera3qWuff1aKX13HXwB4DtbOCQEOh8w3sjH+50u4ByphTW+Q
 a8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754111445; x=1754716245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adXJUf+lCZ6y/TftgnAnliRm17RwAN/STYXD3ARvHEI=;
 b=PLTonAhhB/rY84iQB5E2jktr5Acn02k+gtXKTaa3ybXqRO/8CRFOaeRyNG4AnhvDt3
 LdXRnUhxFlPf4SaHXUrahK8aErVNCvLgtiUCth6ckUY4rozrX/g/hzjpjIpi1Nh91ZgH
 Xx86namdW1ItsxpCzFzKU3+vSUTEGXUH2BZil/AUMoc3foYZCoWiOSfAHbOWRXB6DQUZ
 AndzZstAWhyTs5+Qzh5i6JCrQ5yZrzz0ltML5xjAjEjmFjJ18VBz+gYApGi4oucio91A
 9xecTf8jUArHraF6aufzS5j7xu2fe20cHwkdqHvyQFqPWdBbTzVLFbh+TWnLCoWHBI4v
 zqoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqy/icD90xRQijiMUl8DcuURvfyUGLyYGiWzQSeDGbhztu/35hlOYlK6OGYSIzCd/IM9/iVF0=@lists.denx.de
X-Gm-Message-State: AOJu0YwZ6qPA/w87tRWJ4r6nYGDKz0tpM8SppAQWx7Wbqiif4GgixmEW
 2uhuI0zUCZRcPCPztd7LyLPC8yTGTT33xaskqKNfLgx4At7BBeQtN+SAvU6cTKIk11FSgsc9zbz
 KGNVjsaukkmvuwGDtqy02yIsdjFIk/Jk=
X-Gm-Gg: ASbGncuxSr9O04c1T1W0SCP+f9FRuuPqqDrr4GRyIxTsjDvr+TBRky1R0g5oXpdSKhK
 6FsTuzMKy4SVvV8ZVceGCb/ecozVd8Y5y41BwWykI7K53upOJ9QnpgjTl5O/+a97sh5yqYUfQ83
 M5F0Lh3hr+WGcYw7m0Q2bsouHn0WQcwf/BnkC7xerHffTwF3qfGdGuvHQ9o3vpOiORmysZ8W45e
 8Ewmsjs
X-Google-Smtp-Source: AGHT+IGVBS4/4pHhbvoJ8D/GBLZnPzAtbBZimM95JGfqsrxlz7v4id5CA9uaIuJm+3bGUahnj06cX4GUpxivkAzdleY=
X-Received: by 2002:a5d:64cf:0:b0:3b7:8914:cd95 with SMTP id
 ffacd0b85a97d-3b8d946b3b8mr1507919f8f.7.1754111445331; Fri, 01 Aug 2025
 22:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250731193656.286806-1-ion@agorria.com>
 <20250731193656.286806-4-ion@agorria.com>
In-Reply-To: <20250731193656.286806-4-ion@agorria.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 2 Aug 2025 08:10:34 +0300
X-Gm-Features: Ac12FXxkYfMELaOSZE-mPKYT64w5W_3KWcHMVcZm_CX11Qkr39ha1jFvYcuTx0w
Message-ID: <CAPVz0n0OWvg4StfTS3_Weiwc2gJNaW5BzOpCKjfFPQPE+Y1wHw@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] video: panel: add Samsung S6E63M0 panel driver
To: Ion Agorria <ion@agorria.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=87=D1=82, 31 =D0=BB=D0=B8=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 22:37 Ion =
Agorria <ion@agorria.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Samsung S6E63M0 controller is found in some OLED panels like one used in
> the Samsung Captivate Glide. Currently only DBI C panel is implemented.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> ---
>  drivers/video/Kconfig           |   8 +
>  drivers/video/Makefile          |   1 +
>  drivers/video/samsung-s6e63m0.c | 393 ++++++++++++++++++++++++++++++++
>  3 files changed, 402 insertions(+)
>  create mode 100644 drivers/video/samsung-s6e63m0.c
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
