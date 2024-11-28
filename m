Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84265D70DE8
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 18:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44BD8985C;
	Thu, 28 Nov 2024 19:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dQ5jQxrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80FCA89879; Thu, 28 Nov 2024 19:14:02 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30E148986B
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 19:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so120415866b.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732817639; x=1733422439; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HEHwXXcxwF2QYu7XZzABum1s76tA2GZymuMjU6U1e7Y=;
 b=dQ5jQxrvKqjb/RsbwW3eu7D1kKSjsTOoJA5GtkmdjnaYbwxNl0APfzS4SvXHZjBQ3V
 OLsJV33WRNpIbh96OALmLOZ2UW8/dQIrZFKgXu4v9eOCoU9V1on7juxwdG74lE5WAA7t
 uT8UoZeUtSAYS7JzY97hO3crFkE7SJjQZ68c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732817639; x=1733422439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HEHwXXcxwF2QYu7XZzABum1s76tA2GZymuMjU6U1e7Y=;
 b=DBKPZ533Z70DsaoPAg3QNaTr3r4HyoTNtGItteKrXqtPXLDYlrhyKLFJ5sCg8nz7e/
 bkq9fcKtBzWZjE+k/vxHwutvih0LZ2wTttUMBmufD2sAVbMCNFWbi+DKfaN7TqHsycDS
 yWQ2jlDgQMH0ubtcRy4ZsYnlWk1wBbJn294Lf1AI2UwjLKbf+HkuPYXcRmUfll9ZBX9w
 Smb8BvGmulMi/2o7RlL4Z7qhs5YKE5khp2vtQySmKUmXSA69KRdcdJky6Dla5EDAT2lt
 lTngX4lg2yW7EqkAVPp6MzOrjggfknUf/HkBtOuySqjyEMm+w0UWc4BWHxFZr9+VYR++
 yq6w==
X-Gm-Message-State: AOJu0Yxf4vH2EkoquK6galRE1CERzeF/0yEn/xjnJpkhZ7zA3pFr145/
 vlV46w46YnawBA4xdvvw8OGhgP9WnjLhWVdlRAz1gpa53hAP2OngPggwkEEsKCKkpEmyR/T85+J
 JOJFUsiiEi485yDrFxVimeEICavHRxPRaMJIJ
X-Gm-Gg: ASbGncvleEt6dqZlosDqwIoCCXqKEPPn0RFt/SAAeyho75uB4QJAfhxHzz/4OQoxcsS
 BqKeRU7KAJDBo4weAunfNTzBixQtmNlA=
X-Google-Smtp-Source: AGHT+IGxvAi+z6sF3Y5PJ3h8kb05orrqKqBWFjSh198YANS3vX7ehsrQ7Yr8Xks9pdjOKjLi5h6NM2Fh3vjYVwuMrZY=
X-Received: by 2002:a17:906:18b2:b0:aa5:241a:dc77 with SMTP id
 a640c23a62f3a-aa581073ea2mr549433066b.54.1732817639586; Thu, 28 Nov 2024
 10:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20241128151233.1962926-1-alicja.michalska@9elements.com>
In-Reply-To: <20241128151233.1962926-1-alicja.michalska@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 11:13:48 -0700
Message-ID: <CAFLszTh_oQAwoSB_oBtayTECpHio70ZG5Q128NpFL9-7e=6_EA@mail.gmail.com>
Subject: Re: [PATCH] Environment: Change reporting "nowhere" as "magic hat" to
 user
To: Alicja Michalska <alicja.michalska@9elements.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com
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

On Thu, 28 Nov 2024 at 08:12, Alicja Michalska
<alicja.michalska@9elements.com> wrote:
>
> Make string more user-friendly
>
> Signed-off-by: Alicja Michalska <alicja.michalska@9elements.com>
> ---
>  doc/arch/sandbox/sandbox.rst       | 2 +-
>  doc/board/emulation/qemu-x86.rst   | 2 +-
>  doc/board/sophgo/milkv_duo.rst     | 2 +-
>  doc/board/starfive/visionfive2.rst | 2 +-
>  doc/develop/uefi/u-boot_on_efi.rst | 2 +-
>  env/nowhere.c                      | 2 +-
>  test/py/tests/test_env.py          | 4 ++--
>  7 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

A little more whimsy in U-Boot would be nice!

BTW it would be helpful mention these environment drivers in
doc/usage/environment.rst
