Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4FAC47DDF
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 15:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE5CB87C28;
	Fri, 26 Jan 2024 16:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HI1V24kU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4D287C11; Fri, 26 Jan 2024 15:57:25 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C22187B84
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 15:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=federico.borgo.03@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ddd19552e6so258850b3a.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706281041; x=1706885841; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Mk1INQBieOve8elkDd3ACTCiTLFGOvGNYn7VYEZX5FU=;
 b=HI1V24kUJ1VAMOof5imdq8jxlJ0KGLexfu4wEBPJ/pkVkyY/9RYoG1pSl8yTFlZCj+
 fm86MwOjNUDFQ1pd8kIg27qCKygXfZ/nVEQ7WEMwErV8xG3MoVqu4V3dClVwtIDK4sum
 T/KlFJH9inS4fQQmYsEYMiXzs+DoRwKwACVn2mbm5bVwN04AVpn8EYjvhHu4HMJQ15I6
 lKd7ONF9obZykNhhaRGwtxudqguUqDOFZqNJslUdhstaapQY5S6KfHbZWyZEayluZ56r
 kddzyJrekF2ocxMXDM1VwWoZ6A+gPEktoaUFge73SX2PCt9sVhrBlxi45tpC+R1RPGRk
 y4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706281041; x=1706885841;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mk1INQBieOve8elkDd3ACTCiTLFGOvGNYn7VYEZX5FU=;
 b=pmRzqrraFdJJ4GWWqtFv/lYzEotAMvUM6obuS74e4IQBZdLUkkJqQ1vuJNW7XjnUsg
 gXUIpXOF+rWF5kq8vDmHDrhjHLJKEsG2Hh0jNzz5yPTtLVOEfxomPdOR1E0qkpiB/j4Q
 ZeOpO0cJFGmJ+3Lfb23nupf6rYyix7Ncxk6AAmpfKLCLGk7J5SK1hAXq90umBW6RhsR9
 L86M8qu2sRGdMDOqLk1BDBypzzka41TBOYnQUaGQ+qc22bLkxo7j3lblzqFf8gxZABl7
 MNnF8tpXNkIb3TSPPWTb7DhV0d6TmIdDAa5huiv3Tdd0qpXqpL4FyKccmnm8KZeBoxDr
 HQzw==
X-Gm-Message-State: AOJu0YyFnctADVXhwf0ZDL9jiY7ZXBYekyCFSrHVcp1fy57I280TsfGz
 47+HcLBo2EEDRX/q7lNbq/mAdw88Lf+XX8aXW/5HSH3tJxYE+Hg7Wl9FToDYws+nWI0TdTFd0uC
 u2J5isPkLa4SZ3Rf1mvXNY6rO1rHmunZW34CY0w==
X-Google-Smtp-Source: AGHT+IHMi1LTU7IO2NscHG1UnH73taHZKgTaIxk/SdTgvSEdfSQr6uzfnXtQA2+ZylrF6vlfK+8YPlQgpaKStcT9f7U=
X-Received: by 2002:a05:6a00:2f5a:b0:6dd:c1f2:8ae4 with SMTP id
 ff26-20020a056a002f5a00b006ddc1f28ae4mr1586540pfb.14.1706281041402; Fri, 26
 Jan 2024 06:57:21 -0800 (PST)
MIME-Version: 1.0
From: Federico Borgo <federico.borgo.03@gmail.com>
Date: Fri, 26 Jan 2024 15:57:10 +0100
Message-ID: <CAOXMtD22zCoDgWSSXG8Bc-mOq4_ZvB9MWywToA=bu2XKYdySVQ@mail.gmail.com>
Subject: Adding support for Orange Pi Zero 2W
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 26 Jan 2024 16:35:54 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I would like to contribute improvements to u-boot to enable support for the
Orange Pi Zero 2W board.
I think it is not very different from the Orange Pi Zero 3.
The board has an Allwinner H618 SoC.
I already tried to run u-boot on my Zero 2W using a similar configuration
of the Zero 3 with the devicetree file taken from the linux kernel (
sun50i-h618-orangepi-zero2w.dts).

https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts

Thanks in advance.

Federico
