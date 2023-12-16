Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CB0C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4642D87CA5;
	Sat, 16 Dec 2023 19:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hD2l8sVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4F887C73; Sat, 16 Dec 2023 19:48:42 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B813E87C75
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dbd0728beceso850958276.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QlEfy2uYqZRC+QR//QjlL11guQ3klI8P2mPDXS+QG9k=;
 b=hD2l8sVqYqMwBots/XptRMd5Oht4r2F9kxDrfgqiXQg8IL9EYoLcXs//3JgeIZfRwA
 fQpJh//KVSvn6u1ElLsWQSyXemHt1Y4sOOLoakLdN2Q4qGPpiHHPb4U03J67Ov2Q1lo0
 NO5PjhbB2RYs0vF6SSkCryTES3z8VOrDFv4xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QlEfy2uYqZRC+QR//QjlL11guQ3klI8P2mPDXS+QG9k=;
 b=vDirTNlnytNur+tRcOb4BUzbGGCz83m4ndRz9n2supjewQYNNIV+4RsnWXPVd6H4ov
 ByMR5i7YfnboYE3rIT3YA0427EcwzpRl7NRBbLCLOwxIo/OU8jDeOrDtsaLDea6hzL9L
 eWoNp3nSwU0t3PYpCql47EKuFMmXAqzO2IVsZoLHKLVzKnO3HpI9fj5MxpQU+I87rEH3
 ZfvfzEIiPq8y7JGnuKGydcKoFIbAlc2byGof/LNzKszUXY2rbFqar3T1LXnwo9RaDrXD
 dpIw7fG+B8z2aeeEp8V0AvpEcNZ3WOPxmwMY2Tqv8dQMpel4zCqC/xO12OrwhUgZdG25
 3Kog==
X-Gm-Message-State: AOJu0YxQQ1oCgQXT4KzlwojOVx4T/KFJSx/3JrCnkVTG3lvzqrE8yUTD
 VLhAQyCmUouvvGmG6uTGZ5drSBEBVEhudzv5okjxKA==
X-Google-Smtp-Source: AGHT+IEMtPd+ichaSA8kJv1TEeHeWJWOGnVr/mdX96cIRkR5NLE3PkPEQ/bXZaSSsZKNwk5meMg09ih+rIfoTZvxmks=
X-Received: by 2002:a0d:d812:0:b0:5e2:51fb:3233 with SMTP id
 a18-20020a0dd812000000b005e251fb3233mr6727315ywe.96.1702752514131; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215133245.7923-9-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:12 -0700
Message-ID: <CAPnjgZ2C45f_WhDQz5TKk_THVh5HZ8t6PzozKZ1ROF4r16Cw8Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] configs: qemu: add config fragment for ACPI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Fri, 15 Dec 2023 at 06:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a configuration fragment to enable ACPI on QEMU.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> v2:
>         no change
> ---
>  MAINTAINERS                         |  1 +
>  board/emulation/configs/acpi.config |  3 +++
>  doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
>  doc/board/emulation/index.rst       |  1 +
>  4 files changed, 28 insertions(+)
>  create mode 100644 board/emulation/configs/acpi.config
>  create mode 100644 doc/board/emulation/acpi.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>
