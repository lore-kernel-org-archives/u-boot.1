Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FCCCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C7D8489F;
	Mon,  1 Jun 2026 23:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mBXVgFlF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D64C4848B4; Mon,  1 Jun 2026 23:14:14 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC8884894
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bed2b9bfa02so192083066b.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 14:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780348452; cv=none;
 d=google.com; s=arc-20240605;
 b=AGg2nw3L6dup4A+GbLpdQ4whnEaMiF/iNWDCGL57UrWWDGLTTYCUVhjZVHkuoYl5DD
 dQwudoTqhT9iE2ISqsbrMJBp1U2AeXr8dJw9PVeUpTkLzWWtOgVcU7eheo+r4S5EoPKb
 sSjZfozOisxoLYfqgBSBtfqzkzZBu5qOAEoF5jzHob7wvfeztfxbBmVBB3+BbKJcag8E
 tyibqPAF96NQLsmSHQFRW1vEITcDWy/HaG5W5qFCdlzlsd4WFHbZYiQNeJqwziUHWRVR
 OIsoNapL0PQL3K6CygfhLIf6uG6WAdKHMAp3ELxCJJIujGYWf66XrqMHTOjQ0M5QP7Hd
 C8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EWnRAugzTHznoWHq+evg9N+qPY0Na3np+rx9rI+iuAg=;
 fh=E+8fvvX96oKkYPnHEiqLJj4dXxgtYuWtHYrWmCJj8Fc=;
 b=QCSIvLtWBUIMuNiwpcpiAldXAoWSTAgZOf053xic0zjm2WLVx9FC7VJ2/qBkoo+wqE
 k9eXZnpq/WSK9pxJGrwNqu9OYAX68793J+T1DS8eTYYG+X6SkjYotIMTHO3GffZuu/NW
 QFlVd+MuFrDHzmxU982scDfwTfVKSZh4ISmTynbCRGWEblHZJhe2sFNChkeMP20svntf
 w+/KFU5mpdKlk1ypXLYr42c92LTK/IosBPaxraPcLJ8IBP19ThgETPYMATjPwrVx3sic
 ri7/9IMGDqDYaEomSGZaLmlI6s9ldOSv66VluC5zMOUTw8Ns43bAHrO5wW7udiuPQrxJ
 DP6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780348452; x=1780953252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EWnRAugzTHznoWHq+evg9N+qPY0Na3np+rx9rI+iuAg=;
 b=mBXVgFlFVU6NEnGYHlRMVHBhqJzz2xkWk4t/74+0WRPUW/FARdBMVU8w2d7qvVxw48
 8nZ2B+QILqTiBbXEUwLqkQ+KmIRL87IlG6KWqv0BHqFlYxDDbrW0ODLeEMBNtWGsxDhX
 CFX17Up9FMl+r24UBzWODZs1h7AIVXbqzEJqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348452; x=1780953252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWnRAugzTHznoWHq+evg9N+qPY0Na3np+rx9rI+iuAg=;
 b=A8qsvHoRSJCjWLOHsHn+A4JCv+CLc2NzuD3m7uaZUq0gxFKcs9kwGEL8wDcEBGBCfm
 eZY/IVRl38MGCv0rA7DCqVTPXVslf5KN/oqX2v7mG55ck7D+FapPdYIptKT2MMv+RLdu
 5WENIJIfMus89eaXilFjbhlhnQysLLNYgWUofpn4lFqQ+y5CHh5NSc2KMaoMdMgzcDgF
 uFSP8+qfRb1NwnwKg4xAkC5V2Vgp6YgJfU+iWjsyiNm2Qeg6O0CWmjfqH481c07bINNI
 Xz6rKXvkbLqRJ4UHBZA+HHTfsvC7SrYQV5sxALM4MQW28dOQFRDUa3wYddoUwJgnTKgH
 Ku7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rGxvRA1m2yMUqCbdqNUbNI9VMcvMh4wN0xOvmMc4960/rcdAD/VyhMEt3KPE6EyuhMs3uTyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yymne6PSjxzbg7KpFeP5IEdOb0SNOhK1dsiqVx1SS703otqanz9
 MSO6D9obQEIUdLm5ARTZ/x+P1xFDaB5hFTaLscMirtDw3wF51Hp7RoUq5g25FWj1CTyzX8ibrgH
 H0yU0VOnBooqAi6a1KH3LLqo3GG/zuUybi1p22PU0
X-Gm-Gg: Acq92OGunvr6HJaBrLCJaXcnSUZyl0ze/PiejGWX1LW8XVveKAcL9yr903a+KzTOVj5
 8n71zFzQTQj/pnSBYZme6JomR0cFw16wXHt4h+3MR6Hzz2UsfOCcsZi6NenChl21rQVvf2fdmbM
 fMswb2LhIMSwcpva0KGhxqOJYb4+wt1/8CUUvqeSTkkJhXyNL0bg2EsOnmBNDOa0zx21cnioOGo
 cEqWRcuJIcqUrUuhV+bN77jG51dGh9/efeFnbsWsIIFHla645XFC+2KWpqN6+fB4qMP4sFU7/7J
 9vr/9BYbc35Ecc2M
X-Received: by 2002:a17:907:7ba1:b0:bed:5d12:db5d with SMTP id
 a640c23a62f3a-bed5d12dbffmr363932666b.4.1780348452008; Mon, 01 Jun 2026
 14:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
 <20260527095123.50797-4-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260527095123.50797-4-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 15:14:00 -0600
X-Gm-Features: AVHnY4KVTE8b6Zzn8udHsJ_qqLO_NzeznUH7Hp8zwrm2aJGq9Lniw3TUJN5GX8s
Message-ID: <CAFLszTi=v0ijdUL2tUp=0o36dRmP_XRKY9o-_X=PwMRZ1z_sTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] sysinfo: tq_eeprom: new driver
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
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

On 2026-05-27T09:51:17, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: tq_eeprom: new driver
>
> Introduce a sysinfo driver that can be instantiated from the device,
> which will provide information from the EEPROM found on all TQ-Systems
> SoMs.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> MAINTAINERS                                        |   1 +
>  configs/tqma7_common.config                        |   1 +
>  .../sysinfo/tq,eeprom-sysinfo.txt                  |  36 ++++
>  drivers/sysinfo/Kconfig                            |   8 +
>  drivers/sysinfo/Makefile                           |   1 +
>  drivers/sysinfo/tq_eeprom.c                        | 203 +++++++++++++++++++++
>  include/sysinfo/tq_eeprom.h                        |  24 +++
>  7 files changed, 274 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
