Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA0DCA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A3BA838DD;
	Fri,  5 Sep 2025 15:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d46B/wej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DF8838C2; Fri,  5 Sep 2025 15:33:21 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BD0838A5
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so343007066b.3
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757079199; x=1757683999; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBh/hVCf9yhoFpkuGSK61wYLdRjovG08FyQj3aZms18=;
 b=d46B/wejTNd3FZcW3lvvBcPQbjHUoiBUbopxJ9NmuTn4Fjt+W8uI+mqV/hN31+blPB
 GYJWdfZm9bZ15pyB9uhqOIfidDfATWGoed0AmHnOFAg7TU4dWyeSjpC1AVOYfbnUlA1B
 3rju6/4CzPEopP6dhjDyIc7P1YInTk5hrB3B8839g3pmGnovpZn3jdUUrrpITWV/eCFO
 obdUNS3vpQshh1z8LdIUtkPVNbTuxN9RGEBgJ01ZI2hiWI+0yUU8fh1NSQdt2yHdS3d1
 hXZ769tq1I7I4WEDeQutUbyiIHPGc8uUq+7m+lxC2FqNX9nWm852U+AXBa2HUYBaXgTs
 kgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757079199; x=1757683999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBh/hVCf9yhoFpkuGSK61wYLdRjovG08FyQj3aZms18=;
 b=TR9XFpDD62FBUMCja+m5CwaDehZQQ/RAbyfUpzSSdQCzMIKjwEpX/9pwdEXcnHtVt1
 +RVhOjVA7SuyEL+jOVxwaYsVuXc9R/NmP74YIeajpEabssFe03XTNTIN/6JNi9fomdfC
 XeCjTxtthw0/pCMRBegxX9H8yDenBn55prj7IpvrJ8wzhU5GFW+CJEQzTF6FYHs1M0uA
 6IJTFR7GusWYlcf2b6BokVRiF4XcXfYqEbnDlHJbB1oJ5oAfqIYPVDU8u4kTcGy3ycxB
 ulBnBoqGRF/75nghn/x0KoH0EevtFH4+YTDdSqjUE5RNPdLZHKjvVggSSYy9+xYGWjuv
 zhqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqeT8EZsBW3MXHl7BWQA1AgNfpfonrNsD5wo8JNhnatRgJ3BGpbzkWXDRHSO6WWjGyx7GsP/E=@lists.denx.de
X-Gm-Message-State: AOJu0YxVR1CZ5T8JvJkIm5o1j8x3+nBh1Dfno7Tjr8GcjHWljUYhw1Lc
 75UuZPHgC2c3jEEtqQrgiU49uihrOI8N2qyyUIJUnWfpB41mrenDY98vJB066A3DlQhy2WZUiLh
 3w4yTy6w1SauWuL6dPbzjIt04eXx4EUA=
X-Gm-Gg: ASbGncudP4wk4ri0+f2PeXOxqyjyNc/gnSvER8yvV6shZ3CGNFpyqH7qbNXVtBtDaB+
 NP70OZ1nJyzrpAAq1CkAoSp07YExHmfnxo6fF7NUEw3zPlx05WpvLUNviBC/ySZC/BV08vJN8LQ
 iNikKBw+kjAIdqFIQ9fZhpN/3j6vLm6NJuUt6lKkFO5MyCaVIcfiOVzcl2mEPP/jOLoWuiLHc57
 vo+nh5omC6Jk0Zi17N3o0a7z8LDDeyCKldLEJ6D/9F54EkZrA6E
X-Google-Smtp-Source: AGHT+IHDRhQ9Yl0gpg7NGalyQkeHSjUIfvSmVz0D+LvUW7Ze9AQP99aS6Q0PviRetpuTjtiGxPEQeLPDSRVj1dEMzwY=
X-Received: by 2002:a17:907:72c5:b0:b04:9b10:1977 with SMTP id
 a640c23a62f3a-b049b101cdcmr259792466b.57.1757079198597; Fri, 05 Sep 2025
 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250905104534.382508-1-sidharthseela@gmail.com>
 <20250905132510.500d5777@kmaincent-XPS-13-7390>
 <CAJE-K+AYm6nbbSCkNm23KoPHPVvRNGjwzjWSOnEMJw5q6hO92Q@mail.gmail.com>
 <20250905142706.2b0256b4@kmaincent-XPS-13-7390>
In-Reply-To: <20250905142706.2b0256b4@kmaincent-XPS-13-7390>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Fri, 5 Sep 2025 19:03:07 +0530
X-Gm-Features: Ac12FXykXsweD5k3GWkJtLr79a81qAxgPv2eDx09E3nWZw5PP2aJa7ZQzag2j9M
Message-ID: <CAJE-K+DSiMuXt11Cw2a0_ep_rcE0L2BimUDrJV5Lx26Qy+L81A@mail.gmail.com>
Subject: Re: [PATCH v1] board: ti: am33xx: Fix serial_getc comparision in
 spl_start_uboot()
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 jerome.forissier@linaro.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 05 Sep 2025 15:45:34 +0200
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

On Fri, Sep 5, 2025 at 5:57=E2=80=AFPM Kory Maincent <kory.maincent@bootlin=
.com> wrote:
>

> Indeed inverting the condition will change the behavior, but is it really=
 the
> issue here.
> With the current condition test, serial_tstc() is called then if it retur=
n
> something not null, serial_getc() will read one character and compare it =
to
> 'c'.
>
> According to documentation:
> serial_tstc() - Test if data is available on currently selected serial po=
rt
> serial_getc() - Read character from currently selected serial port
>
> I think the current order is correct, we should test available data befor=
e
> reading it.
> Your issue may be somewhere else.

I think you are right. I have tested it again without this patch and
spammed 'c' like a lot, It works. ( One has to be really quick to spam 'c')
Somehow, In previous iterations this was not observed, repeatedly.
I think this patch is not required.

Thankyou Kory for your time.

--=20
Thanks
Sidharth Seela
