Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB977C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 11:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2C587FBF;
	Tue,  9 Apr 2024 13:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EbNKmjgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62807875E9; Tue,  9 Apr 2024 13:21:16 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52CB587FBF
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 13:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ed4a80c19eso273400b3a.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712661672; x=1713266472; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBYxPZVnEUfHE7eWprJ6ovHr2j0VRpuYUAIByVbrjGs=;
 b=EbNKmjgtBavcifUcZ69XOVWDM3Fsn07q5729gQfCPLGNB8wE2LN+SzmW5EwUvFbH58
 9UZ0GY16v3qvYbBToerc/AM9NKZsma7+STllj/1iTLSlLSkmz0LykB/IBFT7Jk6ROlXZ
 Hgq+8V21uLwAsKHru+bcMVZ6qdL8ecMYCVQ8nYYBnCJaFFfJJTyoQhkg1xxoWd1v1xv7
 vXuD1uSd9nK+ULE9xfT8FYlHhAuP0lsgQ0vKx7Y+kowB0/ctnXE4zCCGCRYtupJG/Mhl
 pV4qlSezAauCQte0z5B3IdUE3XnklYO997YQY+7sJuOpWr0gwWtUQUWfcQWR8KmjPyp4
 RpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712661672; x=1713266472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBYxPZVnEUfHE7eWprJ6ovHr2j0VRpuYUAIByVbrjGs=;
 b=vAc0iFDrKkCUom/wpZzweeJGWvOC6FgjuAssxN7ehLCROQihGsYlWA47vPjgdBwTUh
 OdeFGw+wdKPczhDkYUcv8NWvJrcGAkLQI2XNWD5Py/Sbw6glt7xi/MxARpjF0M68eABX
 FP8fYyiTiVST8BhWAvctzocxsTccgiSqRnIGRViJquXID9tII+Ayn3SnaJa1pwH+umdb
 hvzGUStl/+9VqPChVrBYAuty6E95cH0PQ+6cAno1Tq9/f5gRo6vWh35LJ+SbSFPTwsH6
 XCVbD6AgYW/Es9q5ekiQNUg05+80EcoZi8rDbm4CcFYa+jHr5NfV15d4u+qfEVLOe0Ni
 L21w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHmSrhgSQENzY3fAIo5P7frT6cTkz/zMH2W7RQRJP0yH6C5wkL4AnPLsZCqPB6HX10CGNX9T3eqc1M4m+XXZ6XISgZwA==
X-Gm-Message-State: AOJu0YxdgEfZWZLlg2vFLiKeZ56YGxQ/JSjN0A6FS2qhLwXfSjRcmJy8
 xu9arkp5+RCaEPaYZirrkNWmf/Sf2Fl26NBDXT8Y7dMcr8xQUcA8B/MInyO0IcEAlePnbupJeOO
 DrmSTekIFCM21vXOLKWsF3JpS9aQ=
X-Google-Smtp-Source: AGHT+IGTVQLHgKr0zSW/JgcAi34QY6gvK7HTD8PanoY+ShaMqQkH4LtAvt7/fTTW1YFBn7hXBHnOG29j8637x9hUBGE=
X-Received: by 2002:a05:6a20:daa2:b0:1a7:8b77:d684 with SMTP id
 iy34-20020a056a20daa200b001a78b77d684mr3830591pzb.1.1712661672566; Tue, 09
 Apr 2024 04:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240407090503.2312483-1-joy.zou@nxp.com>
 <20240407090503.2312483-3-joy.zou@nxp.com>
In-Reply-To: <20240407090503.2312483-3-joy.zou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 9 Apr 2024 08:21:00 -0300
Message-ID: <CAOMZO5AH1HuqMw9vD283+gti6KG5=7A3ZAt5U3FzO3oZAZkkPw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] imx: imx93_evk: add rtc PCF2131
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de, 
 sjg@chromium.org, saproj@gmail.com, judge.packham@gmail.com, 
 uboot-imx@nxp.com, u-boot@lists.denx.de
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

Hi Joy,

On Sun, Apr 7, 2024 at 5:57=E2=80=AFAM Joy Zou <joy.zou@nxp.com> wrote:
>
> support rtc PCF2131 for imx93.

Please improve the commit log:

- Start with a capital letter.
- You are adding the RTC support for the imx93-evk board, not for imx93.

> +
> +       aliases {
> +               rtc0 =3D &pcf2131;
> +       };
> +

There is no need for this extra blank line. Please drop it.

BTW, you should also add the alias in the patch you sent to Linux.

> +       pcf2131: rtc@53 {
> +               compatible =3D "nxp,pcf2131";
> +               reg =3D <0x53>;
> +               interrupt-parent =3D <&pcal6524>;
> +               interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>;
> +               status =3D "okay";

The status should be dropped as per the feedback you received in the
kernel submission.
