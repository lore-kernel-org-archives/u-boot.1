Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8A3C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D27C875D1;
	Tue, 21 Nov 2023 03:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QHxL5njP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82697875E1; Tue, 21 Nov 2023 03:16:53 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AB487584
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ca9114e0e2so15342377b3.3
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533008; x=1701137808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zzznNjjC9IuXYO+VrIZWycZqDNr7uRjT70Cd1hczn5A=;
 b=QHxL5njPfKaVxiBtp+Zn6AFbe3YNeIapr7o+8gxPdbwRlCkHu2MbVcCGU1W9cuB/RQ
 HvYxpLonO9JKftb5vwwU8AbUoDb0K1DAoj2867ImwoU7QWCC4dgeoHwYkjajOwQgK1XX
 s+dIrPqaWzOSS5CMOYh6P0d3WDayzzLgFsFRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533008; x=1701137808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zzznNjjC9IuXYO+VrIZWycZqDNr7uRjT70Cd1hczn5A=;
 b=SddiwyylJBjXSdXTLsaeE4kPFHz9v2BXJSliS9qWOZX0q1LMi+GfO4FH+1wWzVYsmz
 JrBBYlMMcHRrzWpMTn+HosaWCGy/cHpPaHPUBzGmAvQbTfFuNqQwNFU/Ashsdm7ScNCL
 BKDanv+mxBVRwfSC0gEf1casmEz5CzfWRvLZjzRfz7FW6Wa2hG8I34ey56iEHf0sujOU
 4zJMFD56QMgt+/yxOitMeaRTH8d9DaKDMIn+2OoZSNF4GGYZu1qeAjdhwsU7hoHu/5NL
 PFj5GneRxrQLTDTfIEf0AyxW3KUt76pv3ckE4nVcdD36bxCB/zu60GUSTxpNRbbpWrPb
 6kYA==
X-Gm-Message-State: AOJu0YzgNE0z4SSyV7Hv+vDs2BuH01L7s7lzGiMUPWCERGXm4LjpNPJo
 Y+OmpPIW/BuZLq0xWJX4590VGD2jE0cyK7JMG/VZYg==
X-Google-Smtp-Source: AGHT+IFBFdQ3K3LNUq4ln+p4OrO3uFbLGTLSrjYC+E0G2mN/cz/Ni6TS8UUo4ZT9jJiqH1P1i8oMz5WVOrhFhWOlHaI=
X-Received: by 2002:a81:53c4:0:b0:5a7:baae:329f with SMTP id
 h187-20020a8153c4000000b005a7baae329fmr8308962ywb.15.1700533008265; Mon, 20
 Nov 2023 18:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20231120201723.619989-1-trini@konsulko.com>
In-Reply-To: <20231120201723.619989-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:05 -0700
Message-ID: <CAPnjgZ1X1iH_GjyjTHks2TFd5eSmYKWLOegHGc1fbn=6Kf1Biw@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig: Correct typo about SYSINFO_SMBIOS in help
 message
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 20 Nov 2023 at 13:17, Tom Rini <trini@konsulko.com> wrote:
>
> The correct symbol to enable to have SMBIOS populate fields based on the
> device tree is SYSINFO_SMBIOS and not SMBIOS_SYSINFO.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  lib/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
