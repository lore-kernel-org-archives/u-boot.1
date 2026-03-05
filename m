Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0001F47CAD
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 18:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF93283E81;
	Thu,  5 Mar 2026 19:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0JcPU1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A0683F2D; Thu,  5 Mar 2026 19:21:16 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CAF4839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 19:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4d8712b40so3890166a34.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 10:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772734873; cv=none;
 d=google.com; s=arc-20240605;
 b=jBc5fgzF0SY7zsW9pUGa3/WOHIKDL88CS5N7azH4pxkDR6FhoH/8+7eDhKghA+BTEv
 SvNqrRHgUVvnFEo/aqFN8F5yOHRHSb1g0RLu7DQakLIJqtKhEReE/PKQ6hgB2DVMQmhr
 LkcH+9Ry3x65xhLMcIyg91ZBrlKoxn8SGdRaE4kXH+dTZGRO0pVu2l1dSfZS5KzQEFwP
 FPd4xBGzetoMXooDXcswraF5piINiP9sLTfRmuHXiadhVkFHeI7gsf2ZKE4C3kivPsXS
 TFiBwfqFRJ40UWjNvYafR6FDZqqau8wnxQF0nkaNrzFAxWcoM/sPyIylpmGrbcCu9yaM
 LCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AofvTloBjNU4wRam0dud/rtPrUTabhRsyji0yZTsjtY=;
 fh=mD9epQ3K6GAhWjgJAp6xksZxGN8f+e+RTn8jGe1Ak9Q=;
 b=BNYXq1YAri1vDGE6UrT2DrunwxIXRLH0VnFxf/mF/SOFX0Le9FrIP/2beyPfxxczvQ
 Wy1q0pLsDOWSF1M347xJ0ZmbHoaErw/tXgZcXd1jvrKR72PHQXoCgcvsJeYW/0EfUROy
 FxT+RG2zd8m99Vjyx5McyZ7pNjyM2TeQq5tReGkY5Vr9qO9Rz5ncOGZCDn2IeBAsX/1f
 1KEw/L5OkZcPP4/8qcpFTWonjrRguRUGeZ/jv85oljlqoeygVL7XAJNy9OEbFhPRjHkE
 /f5q1P20Ea92x09htadC43d+aigEcdhvLOEacH4RwgnZMx7iEXC9VC3ZEY3w91fGGr4y
 z+GA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772734873; x=1773339673; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AofvTloBjNU4wRam0dud/rtPrUTabhRsyji0yZTsjtY=;
 b=d0JcPU1OzAyUvfj9Ppg/NtpPbjmaqP0K0B4uJpuDLSU/ukROReYuccbbMfJVh9LeI2
 ywutA2gaHXF/2GujCgUiJDSpax+mhu32OnpSVrUyLBVLwzezKxuwdat46rQSGBXhLKdP
 59G3SAMND5WNy+AVpcjFx/K/4A2EO96i3P6tHu75R60TNcjGbDz6W26wNIcTByeMr4fP
 BVtvex2S+6IDXT6jQqgDlNNznxFciS4Z1aZo/BwQ7KLZZqD9dX4xmJTC6TpcOooAiZ7x
 AfavnXM3j6O9yJ/SYZRAnQzi9T3WBKuF8VaN6rM9mEA/igM+qy5K8G7o4CsAwBhtY3EJ
 SVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772734873; x=1773339673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AofvTloBjNU4wRam0dud/rtPrUTabhRsyji0yZTsjtY=;
 b=OrirJphsSFFznx6EUfjkWrBz3Q+iui4328J1MiN9q3QPXEDEi1us2/Kdtxn/qz4rcB
 TT2hKttY14E+ENZSBISLikaFN8SKw1eh0EsC5Wbp+HMU53YW1+8P6QojGBFSUH6RtKk2
 Ci1umvI5TB7kKtIICQ8FRjlHLV55YkHEYiKssobFv5acQAOpiRDMyOPTWgZPW9P2zWxa
 wSaQR7WL3kyo50ZICXBIgkAy5n35G4WTMCfyvUeKHeSDUIxq/QUtjqE8QusgOd74AkEY
 N8u2OStcvDxIZ9K7fznXD77fzGjRkEyg8/azzjPe3fJQdUd+J1fbIpbtn9A2FNwoFtZ2
 ZHag==
X-Gm-Message-State: AOJu0YzxOQuzeYM/uRU54GUNwxxZ1988a1PDUH/QNXZ4AQphp6kwNlwI
 ewBqdEs0FcF/T6wjFb7za6ok0S4G+/UigYRe4fyMrM2MQ66tRozwH+Z5/o1tqZN451CFJqHmQV5
 OX46RXmgWKCEdEDw9s6RY/oSurDYFHbFNqg==
X-Gm-Gg: ATEYQzyZETZSBQmKtonj0RYkiXeP5SCBw7SSiVd5NKK4yZV2+O+DQeiSHmEoTj69TZo
 tt6D7Y+FjFMRV4I1iGQifOZt7y6hkaEZSuubXGXr/agcTAoj1WVbXuCZIXrj3dojeZ9UEM7woLz
 HeI7YvY0H7BHvawgGg7RT8p6IUHi6FWXpIGOccFJoWVQBSx4V0a4qkqet9FokxKleBM3HbHHGhP
 54qD7xD67+q/Il4MQFGPvMvOYFCkkLCqmkkp+oVmElZBZIete3I7iuzEcqzQSGmsfxXM1muggm6
 RVTddxhHkhTPOpSzog==
X-Received: by 2002:a05:6830:924:b0:7d1:94d0:e8f1 with SMTP id
 46e09a7af769-7d6d12682f3mr3958885a34.15.1772734872781; Thu, 05 Mar 2026
 10:21:12 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SBrPb6hY_tJMioS4uWs=uZ2dC-0Qrx9C=_M1ht5hJGRgw@mail.gmail.com>
In-Reply-To: <CAN7C2SBrPb6hY_tJMioS4uWs=uZ2dC-0Qrx9C=_M1ht5hJGRgw@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 6 Mar 2026 02:21:01 +0800
X-Gm-Features: AaiRm52hpFUDHDm_PzeVFL5TR5M-ixc2KVdqgzbSdBe8X49jzg5MVbOIrcDmugw
Message-ID: <CAN7C2SCXOWXbu2gN9nTWMsStJ5vfLHf0HEnS-FyTAAHn78pQWg@mail.gmail.com>
Subject: Re: [BUG] Latest GEN5 socfpga handoff python script sanity issue
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>
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

Hi all,

Sorry for the noise here.

After git pull from the latest master.
The issue seems gone, not sure why.
Just discard this report first
Not sure what is the root cause.

Thanks,
Brian

On Thu, Mar 5, 2026 at 11:06=E2=80=AFAM Sune Brian <briansune@gmail.com> wr=
ote:
>
> Dear all,
>
> Issue:
> Current handoff script generated files show missing behavior.
> When using two IIC to FPGA "pinmux_config.h" shows
> 1, /* I2C3USEFPGA */
> 1, /* I2C2USEFPGA */
>
> However after SPL under uboot simply reading via md.l shows
> 0xFFD08728 is not set.
> Based on cv_5_HPS_tech_ref.pdf register 0xFFD08724 is properly
> set to 1.
>
> Possible test and run:
> Even manually modifying the pinmux_config.h
> 0, /* I2C3USEFPGA */
> 0, /* I2C2USEFPGA */
> still introduces 0xFFD08724 set to 1.
>
> Based on the above situation:
> distro or kernel basically fail to communicate the missing setup bus.
> Manually set under uboot command can resolve the kernel bus issue.
>
> Not much data on conversion and format of iocsr_config.h from hiof so
> cannot fix this on my side.
>
> Thanks,
> Brian
