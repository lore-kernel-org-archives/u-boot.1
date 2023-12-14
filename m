Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C1FC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 21:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D15787B57;
	Thu, 14 Dec 2023 22:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m6q/YKuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6739D87097; Thu, 14 Dec 2023 22:27:32 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C1D87B50
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 22:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c38de1ee4so62757635e9.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702589249; x=1703194049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z3wmeaWSZR+q0PxrhiLgnVGBtBbuxY6AWBy3fp6iA+Q=;
 b=m6q/YKuELSyXLSPUX9Phzxdbdoy2zX6CsMFJ8TVS7vqV6RclTXojpgk6kRnFDpVaU2
 3oxJGyxfLAR/1YcT2/+gbKrB2AwZRO/cgrpRMo6vvCr8Q3MWhClO5GFbQR2GqSFXolW3
 AWUJk4s5B7oQO3vN1zAK1/ZcL3q/4zl4DsVYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702589249; x=1703194049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z3wmeaWSZR+q0PxrhiLgnVGBtBbuxY6AWBy3fp6iA+Q=;
 b=QLA3K4cVNhhlDW7lVOSx9+kLzITzKh8Qr733OCOQoKBMy9Z7rjVPZ+eugdQb0WYrim
 iT13jdKlDUD8YC0zJ7fbP7pqzv8TvRkEZEgrHpPFKAD/Zu+lMY4Eocj+OSvMX+Hn6v1e
 6CchczW8azAsFqb+/DF3SJPISFoWvZAzaXsT7E3K9/06yQaPvTf+y0gI0tiBPCTeFrFw
 8QVGFhTza4EvrZ3GTntuoeSkUHotmQ+z8DfKIfeSrX9CRTt0t+YA7eE9Yr+vkT/r8my8
 EE5PSNNS7gS5bE+Hsp5rMIotjZMj2lhQMGJIIoxB9wuoUjw2ijZ2LBzxAfI9iuVIiNf3
 P3Ew==
X-Gm-Message-State: AOJu0YzMyzXajsBSCe7tEAktsluCOtSpx95Afl8cmti86GIedYD76Ad0
 Uwkunyid9MHttwqz687USnYQ4JpeokwbyMdnGdSkig==
X-Google-Smtp-Source: AGHT+IEoPgKlEbI2OpqJ46BwfIshEujzfySi4+f2NoBDUFRtDnQFxoTgRhMRVNC+ExmmNQdPBu6A70ErueUPDrxrnGI=
X-Received: by 2002:a05:600c:1ca7:b0:40b:5e59:e9e1 with SMTP id
 k39-20020a05600c1ca700b0040b5e59e9e1mr5134680wms.128.1702589249319; Thu, 14
 Dec 2023 13:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20231119153611.639252-2-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
 <CAPnjgZ26LAiG47chsk0swBhYZj9JZ9dSiOBbYy+zudVbZz3ydw@mail.gmail.com>
 <69562B3C-2811-4A62-8A8B-FE2D22FE3EAE@gmx.de>
In-Reply-To: <69562B3C-2811-4A62-8A8B-FE2D22FE3EAE@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Dec 2023 14:27:18 -0700
Message-ID: <CAPnjgZ1ZuWYmW6hrUx2m6PQUA6UwwYCxQ7iW87WoAjcBO_J+yw@mail.gmail.com>
Subject: Re: [PATCH 1/7] doc: Update documentation URL
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 14 Dec 2023 at 00:21, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 13. Dezember 2023 21:39:12 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Update to use the new docs.u-boot.org URL for documentation.
>
> Who owns that domain? Can we let http://www.u-boot.org forward to  https://docs.u-boot.org?

I believe a website is in progress. Perhaps we should set a deadline
to put something up by Christmas. If not, I can add a placeholder .

Regards,
Simon
