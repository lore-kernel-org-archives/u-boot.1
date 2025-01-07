Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E6CE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C604F801FD;
	Tue,  7 Jan 2025 13:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IS8ycjjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87A6801C3; Tue,  7 Jan 2025 13:09:25 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F2B8036D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54025432becso16214635e87.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 04:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736251761; x=1736856561; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vmk9w5mHQTKyaF9W/WiOl78XnoQsM6o5JEck3x2rK5E=;
 b=IS8ycjjZ0+CT8fOAu5oem1lMBKSd30eMpEZ1ObDEoBVYnNnPRgxU9BMTBM7unsbb63
 9BFYrP2NBz03IKhK5o8T7qfL7JW63l1HDjIoRc5RlFvE52aokcUIFIfXlcQp1qJOZcL2
 VZDwPXP7+/BkOvQHloMDvDcHxcYSd9dFBln6bRze0vmGB1Vdr6QEEk0s1UzDLrn/C283
 kyrdKdE81jnco8xu9nLMgBPU1fIFzbEuJfDMXg2hKhxKD0AguRGe42ahqtJthCD9DXMk
 6Q0n2nFDjf4z7cMwXJMSN+spkT3CyDFiFr2DPazxyLYOCU5fjvx/gCci7UcmdbTwGBqz
 1wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736251761; x=1736856561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vmk9w5mHQTKyaF9W/WiOl78XnoQsM6o5JEck3x2rK5E=;
 b=nV2w9llcyS2koZseTfJ7TD0kgJWMVszhFY5bHFDUuireuuDW/kcedcs9WN44vgoVYL
 eZ5MBriGRsDhiJkFpsueYnDTvOvRcrzGqYdDkRIyPs3GP+DIeXfV84mHEwbO+iktzKza
 yPnbeG7z0c22r//gtW2Idt0C+mLCW1iWg5PJFY3+caXraoWKfnufWFcH/7FfMYMueVE2
 s5rigmqtxLD5kVZBPmBtlMy8DQ9piNnbMN+vS7HeWGs9Kh8LdeVqB/WF28VmVopr1zVY
 5Qz8DH9qzN4w8YyovEA7ObTCzvD3Sq+VfQYcYY8uqGKPqeEzLSOO1hHUKl0Vv4xDqErM
 q+dQ==
X-Gm-Message-State: AOJu0Yx1ix6iCHNS5VE2X3mo28IsCwtAAvGJApN8cWHTtV+EOzWniXm+
 vfMbvtmQhpDEqB5becWxsZoi4X4tN7XnGnzNgAbual10bFU1la3eT06RpsSx9eiDHU9+lUxNBsc
 rVzpDz3VImH07RKrvbXvZ9968rSDZCQ==
X-Gm-Gg: ASbGnctXrl0CyKJcXuWebzQR59Bb42xXjtnb/z5t7VKLGm/py1Hs8ek3as1yfwqkSoU
 7ZiGsPSg5L022QaAdzllV8P4kuwy0C/9RDO1fpWKpgRmgGgCYs7u4wjm/uYV+0U3vPPGtAw==
X-Google-Smtp-Source: AGHT+IH20Qtxxihd4SsSFFFo9ZEwZGy6KKZyvPQ9qP7cXKZTEnIWNL+w5bLRxNWIGldvirqI+9HXTZRs3FkW4tTwrOU=
X-Received: by 2002:a05:6512:3d10:b0:53e:350a:72a0 with SMTP id
 2adb3069b0e04-54229598a27mr19918054e87.51.1736251760553; Tue, 07 Jan 2025
 04:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20250102092305.GA18027@lisa.dawes.za.net>
In-Reply-To: <20250102092305.GA18027@lisa.dawes.za.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Jan 2025 09:09:09 -0300
X-Gm-Features: AbW1kvacPzySzqrOfuUjoKarXQwiZ3zzh4Iaz4zPelJv7HFlzIFxnPPzYsCdSc8
Message-ID: <CAOMZO5AAtOP8RvyrKJuh4qY7xk+7bS5K5mWT9RZn5E5xKaacxQ@mail.gmail.com>
Subject: Re: MUSB compile failure for imx28
To: Rogan Dawes <lists@dawes.za.net>
Cc: u-boot@lists.denx.de
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

Hi Rogan,

On Thu, Jan 2, 2025 at 1:27=E2=80=AFPM Rogan Dawes <lists@dawes.za.net> wro=
te:
>
> Hi folks,
>
> I am trying to get a modern u-boot running on my Wink Hub v1 (Hi Fabio!
> :-)
>
> One of the features I am trying to enable is ultimately usbacm console,
> but in the process of trying to get there, I first tried enabling MUSB.

There is no MUSB controller on the i.MX28.

The USB IP on the i.MX28 is ChipIdea.
