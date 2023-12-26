Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6013AC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7823E87964;
	Tue, 26 Dec 2023 10:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P8f0FWT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCE9878D1; Tue, 26 Dec 2023 10:50:32 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CE587950
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d9aa51571fso1446575b3a.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584228; x=1704189028; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWNoiEczUETNY7YtPi/R0g78l58WTN6huchsuq4f6Y0=;
 b=P8f0FWT5XWXEJ7Decb15bNTqzxJfkkoin01OMtORLKWZfDmhFxjX6673oN1i7Ca6Ic
 9E1lVSOwtbUEryFzofFZvbG3X2+L2LgtZWo04fq+4itiasjJdXB62OMBFLpixUdefaHs
 RumyTE53YXQY0ljOzjebBrOWQysz9oO2B0Y5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584228; x=1704189028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWNoiEczUETNY7YtPi/R0g78l58WTN6huchsuq4f6Y0=;
 b=HcLdJx+fC30nmfN5lGLF3sjvzEIrTB2sFVofgXjjKT5KGdVp4SZe8e87UPO3YhKXak
 jk51hn7tXnwGwvHx3own7IVcP9QtKSSG/TihlE19zKQ9uiTwRm9XQOkeontNakerZiIx
 0Aw9UhrNuxqS9jYo9xCDTTRgkZP7Tyi8wYPGg+mziCGhy7RpiRwy4tRAue8WCXTVseuA
 DRn0dS29XOMQ4uR4f/zGrVgLV/IGrGnAQFKGyOg/CKHs7TmqA3mtY9rGJOBE0ZmmssrN
 Ml0xxz/O7kFo6kdmcGZZzrKGxN028PdtaHPG3duUQEesoQnVZcJ7d+gUAMJtaBxG8DDs
 9atw==
X-Gm-Message-State: AOJu0YyR0tQE3GPiQTQhnRs8Vi7Cka2fIv0MzKRvl2ValUwITG7qI44H
 XFZOi1cICmTYz+qdW6OscTEGXDcpoFxgACjWfovd1kymfryZ0HL26aLRmZb/Mw==
X-Google-Smtp-Source: AGHT+IGHMkyyURnYmZzNvBFaquGr6ulDNi1mZN8nhqwC/uozu3xFkoYF+DUMPVgstsMS1YEn6WRksns3M3odGT2DvoA=
X-Received: by 2002:a05:6a20:8d06:b0:193:fda5:8278 with SMTP id
 q6-20020a056a208d0600b00193fda58278mr6974932pzi.16.1703584228036; Tue, 26 Dec
 2023 01:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-6-maxim.uvarov@linaro.org>
In-Reply-To: <20231225153929.8284-6-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:13 +0000
Message-ID: <CAFLszTi3-qXao5X78UCqz6fzHOxuQg6D1j+C7tb=g=8OqUP0nw@mail.gmail.com>
Subject: Re: [PATHv2 5/9] driver/net/rtl8139: remove debug print
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com, 
 trini@konsulko.com
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

On Mon, Dec 25, 2023 at 3:42=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
> debug print delays reset of the driver. Finally I see
> bunch of "rx error FFFF" errors in the screen. CI can
> not handle many prints. While network works fine there
>
> Reproduced with:
> make CROSS_COMPILE=3Dsh2-linux- r2dplus_defconfig all
> qemu-system-sh4 -M r2d -nographic -serial null \
> -serial mon:stdio -net user,tftp=3D`pwd` \
> -net nic,model=3Drtl8139 -kernel ./u-boot.bin
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  drivers/net/rtl8139.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
