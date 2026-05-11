Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35D1CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3670C83BC8;
	Mon, 11 May 2026 15:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LZJd03bm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06456800AE; Mon, 11 May 2026 15:08:12 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39EBA83BC8
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bcc1c602a87so267627066b.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504889; cv=none;
 d=google.com; s=arc-20240605;
 b=Z78STvTUJP9NVsbPSpN4poCba2FiahkHyP3mY2Bjh+jffLdHz0QU+bTaDx56pTb7QI
 pXRErT2k7+siTJ8gFi5Pu1vPRdPCh0kpgkHr/CXg6YvRSvEwnk0IqPYswmq5qI3s37dB
 iuNcCzbX0Cnl7Z48UDK6DFkXB1CKfbnUPimYIROnuc8gtNjOYa2V3Vd331QFrG+d7fEB
 0dYBQsPr4ZFy7p8tO8chnzD8ZymTVCMhWxnsJAfoqNBabUAAj0vrTnOC2HdsJjW83FPw
 N1ikHSPl8l3HvFnuwEEvRxQQDxe8bsfFp/0/EMFmGwLZ++/QT9TPMkxB9CfydspZ9fvq
 Z9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gvQTZgQRrTezTcr8jLPMa1qjE7+jTukNmn/Ai5aKKbk=;
 fh=3UE+hL5wYV/QcQonE11JeReuGz2UlLnDNhTRxsM2Tsk=;
 b=irld2NEfNjM7vcy0gsg8nCiOh+SliCb6UBtub9FDjySLgVWgmZEPpvk2BkqbZHHbir
 LklREej+ouGhauzzogIjANYcj+MgUgxn9m8LKaYKPlK9x66suK6uyprOQ0NfxdCacgPp
 mym8zKElAacXPU/9zChzv7d/iuRKXceg5jM4U77s01QyO3rRiBd4/rbqTeC6Do1TYGVW
 1QSHGXvhONm+Y42pzJqvOeP1j2hDoKSH7oN0goHW0pluHILZ4fqGJY4PHWOjkQ7I5YIF
 sPWbqtkKdDiwjGjhzWGDluqiPF0fRqemTat+ZpAFx6PKPpCRXAYQN0w1WlEfUhjU5VD6
 WI0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504889; x=1779109689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gvQTZgQRrTezTcr8jLPMa1qjE7+jTukNmn/Ai5aKKbk=;
 b=LZJd03bmrC334GMUI+jxHpNVX2XuUkhimQW0c7xpIlYLLErNoMFehzoW4jZyyHhg+z
 VtYLq6ytVmZulJ6QhbWxFmSiaGToy30e6ghSkWslGftzrF+55PgDqxPIARWc4GnITUc5
 hdX75m4a8fl/DFxzSu2URmWOKfHPMHzTTKazU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504889; x=1779109689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvQTZgQRrTezTcr8jLPMa1qjE7+jTukNmn/Ai5aKKbk=;
 b=MQRD3bi02vR7XMWpCCLRdEPLVVrz+/ePV7NlSWm3tT/TFufldM5Ul5r9+1qNEwUV6j
 8F0/wBxjha2nDzKmSQWfxaz4hotzGsW3UUHPzzAKznR0xDSAAYuETquAP2SmIwQI7tr9
 yGToOdWQg2WJpHRS59VgaN3vAI8fgm/5lsRLIPfF8/3ob3QNSOTjm2xs0gNflhnnL/Qb
 rETYdP84AJ+i3pDbvMXBsAsVr7fL+0WJfx9/iPGCY2PFsKhnbrwGsLawE/ba3BeCZNwO
 ezYz3hOGede0sdMhdvlU5LzhwWiCvYZM/m5qNGefQxuI02Hst7AWZxiTb3yu7xFLc6RM
 yC7A==
X-Gm-Message-State: AOJu0YxV6bjLe033ZYYh4VVo7zZF1oSOKdazUZmPvrtkagE/GFTwcNXF
 v1jUJeleMbfQMfcfh5k3EYsEgKrRX/JzAR5llA+LkspQ1GEqqmjXIwb6zAgysqdfja4ofDb+XHP
 XYeU1TJZKCqUTvIZ1h8lQb6Riucs1fio1y5+ivFBV
X-Gm-Gg: Acq92OFtf6PWgxCgRCyCBfKOlTJbVqJiMrBjQ7WNBePR1bOKhPuscXD9EVno/mULcAo
 NjPAK09XjlV8wwmGeSVrydWuDvFlQPVz5qjUOG9bPOISV5ppYjgN8JQo/I88+6frmZcNhUN2Dnp
 l45o3TmXedUFJG+7MUu41IktiYxkIKjjRpjWiQCFObfBwh+4y06HILnlJWYxDOF339+3TcvQvTE
 iS4UfhkNAIaqEWYxXNWWw1TD2i0qwxsNLHQymi0cqK/FpHODc8/OURIOh8v4DM3/eUPgS7TPVNF
 i7Af7g==
X-Received: by 2002:a17:907:7293:b0:bd0:6293:bd0a with SMTP id
 a640c23a62f3a-bd062a3013bmr173816166b.7.1778504889433; Mon, 11 May 2026
 06:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-6-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:07:52 -0600
X-Gm-Features: AVHnY4JKFfh-WKa7H7ojNE28M9JPxCQnyccyrJF9pP-JK7KhmHMihbHUDadZpjc
Message-ID: <CAFLszThkSjLuJD7E6G5+5uEkoMq3fDEu8ojDPAgoEd=f2e568A@mail.gmail.com>
Subject: Re: [PATCH 06/11] video: console: truetype: Staticize and constify
 driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: console: truetype: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/console_truetype.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
