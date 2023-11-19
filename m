Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F386BC2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858128710A;
	Sun, 19 Nov 2023 01:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f3CJOjRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63EDF86EB8; Sun, 19 Nov 2023 01:43:31 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B109E86F64
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-544455a4b56so4443302a12.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354602; x=1700959402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=joR0kY1gadNsRUDBN+tHYED9QT5yAyoGH1J6kPTudiw=;
 b=f3CJOjRryMniBQigAXu4f0gxZtU3a9Weuil3SZELmEZLYDO2R7PCGccGlFG91iw+J7
 34zmcqTLfUPc3SUU7osG8TQaQsBEHYsTrgooNfNMN/JpJNsFVlMapZFxqzMdBpbNu6YF
 lsYuxJIZI60SzmNWpVfmnV5KJSveYI8GAxR3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354602; x=1700959402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joR0kY1gadNsRUDBN+tHYED9QT5yAyoGH1J6kPTudiw=;
 b=U/nKYFsThBEXXuOTzv0A709cx+zUmEpfoX14rrqF/U43kVqn2MMVVdkgNEBJIk6lCk
 h83ja6ZQpxSvU0eTb+WGrPFPUqJp2B/BrxxJvj6nktf8z1KHv4sJS9EMAU8eAdmtuMLN
 u4DCdh9r02mlleoXqMumPcIqyGrKD55oi25pXBvXE9fnNYgj84n3rzzK4CYc+p8qV8W6
 mi1ys+qcEvsktQ22xxLlrPZALA2dnKpEBoZr7y87fpmGQq3z+tLT3jmpZ2FPUjCVEelg
 2L14vVDsrbhVOWxn6hkIWQ4qCVawmdsW06alsnSOFjqP2GACEYbwJanagd4tkXIIQMhA
 qBIw==
X-Gm-Message-State: AOJu0YzdX5oFr2etRCNA5svJJWtYriW/SRbS7TAqlPKuIIuUaZRLr04R
 Ro4Ga0d9IkqQQo7nZOlpp/MBjTOjvdl77rLwUOuyiQ==
X-Google-Smtp-Source: AGHT+IGatQyiYy1zGXdOCAxgACyUq/1mDgU7MY1DEio0DShDV5vHCZcbZ8mePE+EowYEnq9GqodQ04NB1bxf+sqsGM4=
X-Received: by 2002:a17:907:29d5:b0:9be:839a:3372 with SMTP id
 ev21-20020a17090729d500b009be839a3372mr1986628ejc.59.1700354602146; Sat, 18
 Nov 2023 16:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20231118220313.1271556-1-i@shantur.com>
 <20231118220313.1271556-2-i@shantur.com>
In-Reply-To: <20231118220313.1271556-2-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:06 -0700
Message-ID: <CAPnjgZ0NwDZYUC1p7A3gs9gkeCGS8f0BkQPYim+hhjAtjkDtrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] bootflow: bootmeth_efi: Set bootp_arch as hex
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
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

Hi Shantur,

On Sat, 18 Nov 2023 at 15:04, Shantur Rathore <i@shantur.com> wrote:
>
> bootmeth_efi sets up bootp_arch which is read later in bootp.c
> Currently bootp_arch is being set as integer string and being
> read in bootp.c as hex, this sends incorrect arch value to dhcp server
> which in return sends wrong file for network boot.
>
> For ARM64 UEFI Arch value is 0xb (11), here we set environment as 11
> and later is read as 0x11 and 17 is sent to dhcp server.
>
> Setting it as hex string fixes the problem.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  boot/bootmeth_efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think you dropped my review tag on this version.

You can use 'patman status' to collect review tags automatically.

Regards,
Simon
