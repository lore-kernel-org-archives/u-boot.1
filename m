Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBC4C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C95A8716E;
	Wed,  8 Nov 2023 17:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mjK0onCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F084871AF; Wed,  8 Nov 2023 16:34:29 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06A4870F5
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rathore4u@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-991c786369cso1073177566b.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699457667; x=1700062467; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1E2x/wHowx6BSupcYDkMAX7RCCkIbQ/xzDUeXwHHP8=;
 b=mjK0onCfyKZyfNUP28OEzTrbZOzjSyCMW0l5F6nNy2TPMNZE0OPFYOSv13Uufl2pRQ
 W/sluz8MUoI/HJ3lTWb/wqChOBuZDY4jfqA/bNQfs8rLWveffVDys9nNEA/7r7jy/dqP
 qCbxUuGhyGTTYAyo6yTuPKDwqQU3OdaI8eremRIw+zWVoP40GyobAqUM2R0DTG0Y3hKb
 St9gr1gOLG/NVx0qrVt3oy2ZFfgqq/Y4OidPGcBmge5NDHGi3GLz9eTHToX7Ch4+dRar
 ZpPsGocPo/DoPs9yBXAT6nTGGCzcPh2EOUi5x15418oxjzD0oBV+ismq9uBMSl+GLO/6
 bARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699457667; x=1700062467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1E2x/wHowx6BSupcYDkMAX7RCCkIbQ/xzDUeXwHHP8=;
 b=vbtVuNO9sD8xnGqoQTTLn3MQk4kMoSf8akEqxH2LH4KBzFZjDSH7pKtWVAssCu9Aqd
 ZRFaQNixVL1wG1KMkVRrfMiBQLzao9L5n4AsRSW6uwvL7kTuodts7YPRttqy6lxw9sPQ
 lAJID7r6L+vkvJyR7cD4Dm+CTMXe5jvNHFgL15qeaUH1m9t7zZpAVkzWFsqaGHNzSc/W
 Lv8c2L5pvRg1c0R6le4GA1jB/W9I1fGq90nW8r8rt3RIokMgUea2+UW0SJHsmT3V0wbz
 /H1QKxyr5W+98qHgxgKTRbH6aGWE03CUacLr9inxTvsDs1Pn1uKJPZswyXFp0FjMLa6i
 C3WQ==
X-Gm-Message-State: AOJu0YzwCgVo221yAoGwlzox3QgAJul4TJUyA5EgSRsC5x88fzOyx165
 hLoTh7MjPegWkD/IV7dGOQw3D4dJ7TPe6+lDLQvrFnw04ig=
X-Google-Smtp-Source: AGHT+IH8X/XcJj++Zaw5xI0enou+6ITIajLBY97m1ZoqKK3qjuN1X4SjMev9Y19ghlpfYEwq+JL501uICZClCbVRyEc=
X-Received: by 2002:a17:907:7ea9:b0:9c3:7510:e522 with SMTP id
 qb41-20020a1709077ea900b009c37510e522mr2059441ejc.63.1699457666984; Wed, 08
 Nov 2023 07:34:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2RP2LB=4GAdKWdckzXwiWUpAGY4T1UCu=YuJQgFWo4Qg@mail.gmail.com>
 <CALeDE9MaboQPWpDND5WD8ywhg5C-nhGPToXadK6CY0u-aDHGkQ@mail.gmail.com>
In-Reply-To: <CALeDE9MaboQPWpDND5WD8ywhg5C-nhGPToXadK6CY0u-aDHGkQ@mail.gmail.com>
From: Shantur Rathore <shantur.rathore@gmail.com>
Date: Wed, 8 Nov 2023 15:34:15 +0000
Message-ID: <CAHc5_t0QinK2j9kiLh-3MT=NsLmTpbqVM7P=DM5Lf1AYGfLG-g@mail.gmail.com>
Subject: Re: rockpro64 rk3399 dwc3 issue
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 08 Nov 2023 17:14:01 +0100
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

On Wed, Nov 8, 2023 at 2:50=E2=80=AFPM Peter Robinson <pbrobinson@gmail.com=
> wrote:
>
> Hi,
>
> > I am trying to boot OS via USB3.0 ports on RK3399 base RockPro64.
> > U-boot is failing to detect the drive in the USB3.0 port.
> >
> > If I boot linux through other mediums the drive is detected and works f=
ine.
> > Can anyone please help me figure out the issue?
>
> Can you share the version of U-Boot you're using?

I have tried 2023.1, 2023.10 , 2024.01-rc2

An interesting finding, if I connect the same disk via a bus-powered
(no external power) USB3.0 hub the disk gets detected 100% of the
time.
Directly connecting the same disk to the same USB3.0 port and U-boot
fails to find it.
Connecting on a USB2.0 port works too.

Regards,
