Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A41C4451B
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560AA84E3B;
	Fri, 17 Jul 2026 15:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YdeZWZ/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD1D84E30; Fri, 17 Jul 2026 15:46:26 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA1B84E30
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so360998366b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295984; cv=none;
 d=google.com; s=arc-20260327;
 b=I+IG+dtibsNp2+q0WNn2gV0ixGg7e4G8wiyVP3ocCLoI/CFGGhYDf2mb3HFgGTfVMQ
 Jz4sO8yd5srEZDPzgM6ubS0afaStPl2HGzqamn+vNyWQ3mpcO9gFrC/mYxWvLVsBF62G
 n0ebeeFqJ4/qUgawNiEjb/iJFyLm30KFzQcen2STclArS01ofEIzJVRvUhchJ5MO3p21
 mIIMmSp1OuJ7KdqHip3hxSp/S5z7Tvc1/KlbgCaMn942fh6t59mOgwYA5QfsFv+XRdWi
 7nf8Ri8zgTPK3YwQs1xIBfv9xF+ZZMORoWjJfqjGiA9JyHbd8bES+7rIDl8POf9ZF8xo
 /UKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XVUp71G+3YQurScxVjY0hswFw40tRWruCH8YBNZaloc=;
 fh=tPNh2npi3z5M2IK4RkMrFcixX0cM0j5MsPuttJynFHs=;
 b=chV1LF4RF+cscXAEYxTyUj/PWkqcdurhjiTNU2qkbr9hWNaZlv59nrYYsG7nWMRM3n
 OPYo4bMLtlMkL99G5eaGlmHDuyCeWDv8U6pexwNl9i848/SsMY1/mMGKJ8u2Mw33n7ZP
 mdsu25BoolXH8yxTCT0QbZoq/MX2YtAhfAjaIzSr/4JEk2A6aY3XlvIF08mqJHy1EyQw
 LRYZAQWFc5b4FGqXlJd+skc5dZ7j5C+pn/C0dGkulgWj/4PSMRoWb46l+Zf3MTXL75Zw
 HZHWLA0ru4eczbOFwhgixXz6Tx2mQHb1TA9atrs5kp+aZeUiN0Cejz6P6Xpu3CSFnZZd
 W7ew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784295984; x=1784900784; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XVUp71G+3YQurScxVjY0hswFw40tRWruCH8YBNZaloc=;
 b=YdeZWZ/fWbKay8YSCnx1mRYXRD5/NhJKVJqDdrvmXq/9GVZySY3jy6d/Bf/6FSVrNk
 AzsH0grWl7WNFkDEtcpS7OmD31BRGZaFb5GsqW/+9p1vIExVpLeavxmbd9u8iE6sjUv7
 P0VEVDGx/iLUg5uzIwQhuqrbEq/bqrgs28ICY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295984; x=1784900784;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XVUp71G+3YQurScxVjY0hswFw40tRWruCH8YBNZaloc=;
 b=qKUGYdnU+bitS5vilSV0G9ypjUuZ775txlY0KzDejZV84iGng6g7ImvmDTXFSTsg9X
 FXuKfd52sNGbT2k+y8DbcdWkPC/9Z3Wol4jHkZZtVndbsuzjU+Y43u2jzRXjPAg3Gsmm
 wmIdikSUXtHaWDXtMVWcIvqVrAGMuK9k5wLWRX3pYQ7icfyBaTVirWVYzGH1PKjltvNv
 8XEDpZIhJVqbDuN0PJK2l1zJiL4c3cMXX6xxCTgMmNzVohqJMsgfowy9d1DVp8j2MOOJ
 G8Hzo8enVZm0iOnLjc3RU0/lcT0u5UNZHbELwg0j1QYItViuMcCrZAtJYcKkmdKWoye7
 JGDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLNNas+WGJnXSbCeFrAGP+QleAobFkxp0pwrkhTGcOZOxMgCp5MdeZATAoSDigpwARQ04ZPgo=@lists.denx.de
X-Gm-Message-State: AOJu0YyL1yvF38mtZDwfTjLSKUXaKijOOPIDCzHk4Jb6C3pUGcP+7P4x
 c/u9b4jH/1oDJPg4bCs/dOjnCN4EpVowne8HPUFnJgrFKOKxYCK8owuc5Cr8k6CyppCiYOAzIQq
 D19lRnCEylKCQpbx1BFP2NYJqDlb06EdNMl5lCJAb
X-Gm-Gg: AfdE7cmsiNx81elM9p38QaZEQWoJSx8EJK8OuiyA0wkvr4lZfy+p0iqPCfhtOUvT1Hs
 b0YflwdEg1j7+u4Y9FBMnDBmBr1ChnX/iaLLynwKpzRFY+Yxa1QOeTtIyn8umLhnP88iENp2UbE
 LrmV/RrH6Hpyk3upCJNvUGPaJq6ucg3/11ubZ0e7HbtKE2sBatnvpxP7pvucGCqsCy2bQxLP+1Z
 lzFN2SQcck708sZDWDDrIZ0p4nzirppwnwf2hanrpZKehhwtyP+Pf/vl7AJ
X-Received: by 2002:a17:907:3d11:b0:c12:c5d2:bf37 with SMTP id
 a640c23a62f3a-c1692104a7cmr290562066b.12.1784295983781; Fri, 17 Jul 2026
 06:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-9-jonas@kwiboo.se>
In-Reply-To: <20260711160808.2022242-9-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:46:11 -0600
X-Gm-Features: AUfX_mwUoLe_-KqbKafTYdshbohWuEpCHH2GbtrlOTrEQQ04UGIGoOF9n3o_ohc
Message-ID: <CAFLszTh5ir+hgUyvsHi0Vv4gedPyChhCoW4=Srsig9MFfR9OtA@mail.gmail.com>
Subject: Re: [PATCH 8/8] usb: eth: Bind Realtek RTL815x to CDC ECM driver
To: jonas@kwiboo.se
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Jonas,

On 2026-07-11T16:07:58, Jonas Karlman <jonas@kwiboo.se> wrote:
> usb: eth: Bind Realtek RTL815x to CDC ECM driver
>
> The Realtek RTL815x Ethernet controllers have CDC ECM support. The
> RTL8156 and RTL8157 also have CDC NCM support, however RTL8157 fails to
> signal Network Connection status on demand.
>
> Bind the Realtek RTL815x Ethernet controllers to the CDC ECM driver. The
> driver is sorted last so should work as a fallback after the r8152
> driver.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> drivers/usb/eth/cdc_ecm.c | 5 +++++
>  1 file changed, 5 insertions(+)

> The Realtek RTL815x Ethernet controllers have CDC ECM support. The
> RTL8156 and RTL8157 also have CDC NCM support, however RTL8157 fails to
> signal Network Connection status on demand.

So you have chosen to use NCM for all RTL parts, right? That seems OK to me.

> diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
> @@ -278,6 +278,11 @@ U_BOOT_DRIVER(usb_cdc_2_ecm) = {
> +     /* Realtek RTL8152, RTL8153, RTL8156, RTL8157 */
> +     { USB_DEVICE(0x0bda, 0x8152), },
> +     { USB_DEVICE(0x0bda, 0x8153), },
> +     { USB_DEVICE(0x0bda, 0x8156), },
> +     { USB_DEVICE(0x0bda, 0x8157), },

The r8152 table also matches a number of RTL8153-based OEM devices
(Samsung 04e8:a101, Lenovo 17ef:*, TP-Link 2357:*, NVIDIA 0955:09ff).
Without entries here, those dongles get no ECM fallback when the r8152
driver is disabled, since their first configuration is presumably
vendor class and so the USB_INTERFACE_INFO() entry will not match.
Should those IDs be added as well, or is that better left until someone
can test them?

Regards,
Simon
