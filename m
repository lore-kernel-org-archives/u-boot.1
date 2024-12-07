Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B51BE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 20:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2770389049;
	Sat,  7 Dec 2024 21:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eLsy5iiV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337538910C; Sat,  7 Dec 2024 21:48:57 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FED88E81
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 21:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8e52so4962997a12.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 12:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733604533; x=1734209333; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bAtmrlFEhVutfJx6RpQ6v9CfVhJSOF7SMyciiJbqv4Y=;
 b=eLsy5iiVxR0YEDsCOyYjuqZd0yZ3dOiCynNOVxvVjjRHH3jQIcT9E+iHlzOJ3GsBuR
 uHPt8Pxs63EmZbSpsQ+7dFV1tMJKIZMABMEp3tNPkhBKO9APVsUGT35Eh3TjEI37goig
 9C3BBMzVLTVkdBt0fqg8OqT+yDt2JQX+LKIkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733604533; x=1734209333;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bAtmrlFEhVutfJx6RpQ6v9CfVhJSOF7SMyciiJbqv4Y=;
 b=QhLOoD8Am42HvC1LS7vI6RmXujSdaWAeLR1fO00Z8lz5RPPz5SJALfgjXlMAAF1vkb
 qTgK8qb4JGsEdleqRVuX2QhsdMrHXH4C+sDYYtIbnwtyvlqMRopDem0qiq0EOMOelDic
 at0iln0TaL88z9oVJG3raMzZ8fa/DX7425m9cCVwEWHsFlY5NhsoIuuaoE0edxhs+fqi
 ZwajM7yLm5LAAuihoWIusneKoFxCCcAUXMRX7b3xn/qQ17gK/gsI4wI0qkxZ9AlCpfa0
 wHGFUVBCrEMJtIA95KYPHWCmq76KI1FL3AIQCvCGHtOnL6v7ydEI3sEdIJ4AQk4yF0Lg
 ZSiw==
X-Gm-Message-State: AOJu0YwQQ05cb7gzl60DzUha3iGDeW4LoC9wc1heu9d/l0eO4mISPiw0
 FyYCVHvBhmOJ20xV5wmhRLJOWGQUSOFxTLMekZwajfeLGYgMg+SDKZLAKXX+CgUIBMEa7Fpvmi5
 +Q2N2RyVHw8brnfVqG3qNkQd+zmixg3bmU8rUzh06yX5GIGST5Q==
X-Gm-Gg: ASbGncu/bgo6Nu+RWVKCwdQwp5eknCrvzxn3SXMKqLyHUWHFC5oTykO1TM2mQASjd/D
 AsMdvvTwzjpd2XHrbGy2K7pD4UdOAOZ5o
X-Google-Smtp-Source: AGHT+IGtX4j7xCmZfoUbK/cApz3y5+zQJ8yD5CNMiZoZ/NhghuW0alZEKeNXb/V3o5sY5JA3qchgq0GeXOKP6Veih/0=
X-Received: by 2002:a05:6402:280f:b0:5d0:ee52:353e with SMTP id
 4fb4d7f45d1cf-5d3be775b5amr6740364a12.29.1733604532985; Sat, 07 Dec 2024
 12:48:52 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Dec 2024 13:48:41 -0700
Message-ID: <CAFLszTgnwTtUdgSHu6-1AC7cFU-oBNSp3oHAFTzisG5LmWs4gQ@mail.gmail.com>
Subject: UEFI messages on startup
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi,

I see these messages on startup with a rpi_4 - what can we do about
this? It happens on every boot.

** File not found ubootefi.var **
Failed to load EFI variables
** Unable to write file ubootefi.var **
Failed to persist EFI variables
** Unable to write file ubootefi.var **
Failed to persist EFI variables
** Unable to write file ubootefi.var **
Failed to persist EFI variables
** Unable to write file ubootefi.var **
Failed to persist EFI variables
** Unable to write file ubootefi.var **
Failed to persist EFI variables
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 0' failed
Loading Boot0001 'usb 0' failed
EFI boot manager: Cannot load any image

Regards,
Simon
