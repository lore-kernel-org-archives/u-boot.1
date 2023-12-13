Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A427C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB09878E1;
	Wed, 13 Dec 2023 21:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PTrBFeaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E961487899; Wed, 13 Dec 2023 21:39:35 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EB6F878EA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a22f59c6aeaso174857766b.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499973; x=1703104773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sBqsX9OnyigMVZ+lp5w0R4zHM/gfOOjxumy7aj5ygB0=;
 b=PTrBFeaZpQygZshtvc4OWHf2kZy+h7tLa6aSQHGnbX+hNClZ319CVfZy89+zuTaEbE
 79JU4N+Vy8bMzFvBae8VrRUDxyKVRVBKwaNMtQWnl74VmvDO13TXwxMK1p9v48spTUXe
 ipFhwVIB7zOx9AW2dL+ACdwZbHwu5Phi/cYaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499973; x=1703104773;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBqsX9OnyigMVZ+lp5w0R4zHM/gfOOjxumy7aj5ygB0=;
 b=l2VoqItAR9JY8F4+UZYVvprrptn9zBf8sski/aMnqcyCkjqdRJFSBWG7rG4m9Wn3Q7
 5aELKCnbVKD3MkF00UozEmRk/p6uSzpNBNRLSQPhGgsutZ1dJz3n3Nm5lekz5XkDQlsf
 cHnInf4YVn3fsH9qiBs6XUSQEd3Jnr9g7iUJ3H3dJ+tGO7zEzN4o8i+U4g+DbqyiVStH
 3sGRsncylF6rSP+fhtF4dii8OTnQBa+o/XpCmw4K7ov41WPY4AaCigPU4cv6NdA3Py58
 PDS8gl0BX1qpk8yZMvmTmKytq35taWXvxxMuQyo2LyxTvkrlbgr3M23ERoVlmwKPS/Wc
 djeQ==
X-Gm-Message-State: AOJu0Yyk2XIaHVtxdEQasWQXPCgYi1E7+DPUBkDsTtNXQvCPeDy5Fhm6
 /zLnhHRrQWzwmeritmaOgttU/t75vpKZtM8keM7dNQ==
X-Google-Smtp-Source: AGHT+IFyBtIJa8qhLv+FALd7OtAnPaumA3hz1dRO6zPiONUfhM6bvKouHM+ep+ERjXfS3WcKz/zWfsxCjlncFEr/eW0=
X-Received: by 2002:a17:907:7203:b0:a19:a19b:55e3 with SMTP id
 dr3-20020a170907720300b00a19a19b55e3mr5818225ejc.115.1702499972836; Wed, 13
 Dec 2023 12:39:32 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:31 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1MZoZ018YvjWnY4kSBSR1ZPvDZSJFg6GqoMjFK_FYcfg@mail.gmail.com>
References: <CAPnjgZ1MZoZ018YvjWnY4kSBSR1ZPvDZSJFg6GqoMjFK_FYcfg@mail.gmail.com>
 <20231002011553.463514-1-sjg@chromium.org>
 <20231002011553.463514-14-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:31 -0800
X-Google-Sender-Auth: lhkto0bXY8_p16r5Mu9UmXP9AcY
Message-ID: <CAPnjgZ1emQSCO4+Z1BJVdjJmq0hASNB=UErz69aujzv0e6sotg@mail.gmail.com>
Subject: Re: [PATCH 13/34] video: Add a function to clear the display
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 1 Oct 2023 at 19:16, Simon Glass <sjg@chromium.org> wrote:
>
> Move the code from the 'cls' command into the console file, so it can
> be called from elsewhere.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  cmd/cls.c         | 25 +++----------------------
>  common/console.c  | 31 +++++++++++++++++++++++++++++++
>  include/console.h | 10 ++++++++++
>  3 files changed, 44 insertions(+), 22 deletions(-)
>

Any word on this patch, please?

Heinrich, do you want to look at it?

Regards,
Simon

Applied to u-boot-dm/next, thanks!
