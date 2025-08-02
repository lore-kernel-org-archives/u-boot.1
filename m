Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A7FC87FD2
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 05:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DD583C2F;
	Sat,  2 Aug 2025 07:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F8gR09to";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 490C983C2F; Sat,  2 Aug 2025 07:11:44 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB40183B05
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 07:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b7862bd22bso2154118f8f.1
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 22:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754111501; x=1754716301; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOyqwD023ey95Yu+XUHMQHhtiqWdsPg1X6R2yW4uKyY=;
 b=F8gR09tofEl4sk5fO5s2/UY+SQW/8xrA8OuV5EcEyOfkihg8yEByDJrQjHbObHN7Xt
 3KWXc8CUtzok/U9AtPPVDIBEapZOyjBNrMHEvHz+1YzA5WR1a5OoJk3SxxGeRw9Li9Fr
 36+s9YeR4Rn0aBTzNHnwE54wLWiscY3fck0WUfoj/EEzFvthzNbl2YasVatj/n52ZgIk
 8MNRoNDi1PFv0iuAx1MedcJf380YgXr16HhMRT49QL/p786aXFM4LLMYu8BXxWEjpCMO
 K4NyHPSNpfYbqNmcmIE1sSpRuzobWmhdyog8Dc+rFAAnhSA79eK7OwMSpFf4KDU7CFG8
 KI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754111501; x=1754716301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOyqwD023ey95Yu+XUHMQHhtiqWdsPg1X6R2yW4uKyY=;
 b=FwF17Du3BDMxqeSN9gDXA6r+dTk8Zxbg2gzkgUK3Wr3WKho8fqN+9+HOXN2XXzx56p
 W3UU6mKv1zlW8veal3dmJCIAWcWTDsy6cNbkGCeKlsD/gPho4KK+mXd8OX4qG1AuqXDl
 GK8J8x7HBS1+oYCXkq/FXJhFrmpbzuqY9Wa9D4ZPKMGWmFFq5sVWZobUc03XHRp6eNQH
 YOqBiX2qtTfAinEfxgJhC0H6QZB/95fzaoIgG5x4rL1euSBQsBiDB4E5KBjEuOAndXhf
 ljDzJOWL0r3xJ+xi+qI0qkVygc/O1y/mA+ZYCZm+PG6DjkMzv1E2jaLBFrTqzMaOVpgn
 WVlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNlg3lm4NYYn08xRkGSRDtM7/eApGufgKL8yIPjIKvxskQyBf8N1/HNEuXhzt7HrvMLwK/3yc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2fA9L7pbO1/4siZ91UYRMfoN5Pv7Z/PB9PnHDCBuvvLyxlZK1
 y/c6iZlHBFYqW4c7W3Ddg3/2908RozcUiU8uRkqOynAJ4/xOaeafc3N8ZuLFzz0DWkLVvzPRhek
 nBNkAkpY9NGOa6DFE0aoHHgY61BtYZS8=
X-Gm-Gg: ASbGncuWl3s2ZEnAAGzJjx787+8SLzVQx91XFmExadL05IlLr0HQ71EydGd4kcAly86
 Y9L9dNU5knq+lKoIaGY61uiq1/iRJKEEwnfHA9bg4XKrZExehL4nkKmPegIE07r6FOOsJ0o+bJg
 F9vtJ4BGSw17bQsfDSCONcWGILi7frks39n3+ZoEMCSgGIZHhqDv+MITQv9ds13q4z3cme705cc
 BBXEw5b
X-Google-Smtp-Source: AGHT+IGt1enBNTSK3JSN0OLSbmalfFagQNtn3hiYiX/3sv0ACEdlLScYHPDlU/nUZRGGaF044dbi/Jwv+YJZO/2tgTE=
X-Received: by 2002:a05:6000:2c03:b0:3b7:9703:d99f with SMTP id
 ffacd0b85a97d-3b8d95ab6a8mr1433264f8f.27.1754111501116; Fri, 01 Aug 2025
 22:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250731193656.286806-1-ion@agorria.com>
 <20250731193656.286806-6-ion@agorria.com>
In-Reply-To: <20250731193656.286806-6-ion@agorria.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 2 Aug 2025 08:11:29 +0300
X-Gm-Features: Ac12FXw8xTkEtE0ITfMjjQW_hHtAxd05V_zyv3Rqx43ep-Yww2BahgL7XuQMn70
Message-ID: <CAPVz0n13XHQC3Jtd10kqG8Bz-zJDxjkETJU_VeHaAdkLxgwJRw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] video: backlight: add Samsung CMC623 backlight PWM
 driver
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
> Add support for PWM backlight found in Samsung CMC623 image converter.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> ---
>  drivers/video/Kconfig            |   7 ++
>  drivers/video/Makefile           |   1 +
>  drivers/video/cmc623_backlight.c | 124 +++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 drivers/video/cmc623_backlight.c
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
