Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AF0CD4F5E
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6A784841;
	Tue, 19 May 2026 22:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D0/JLTDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC95C846EC; Tue, 19 May 2026 22:00:52 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F36E384707
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 22:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso9066324a12.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220850; cv=none;
 d=google.com; s=arc-20240605;
 b=haNn+M0G1lx/BeC7aFpEFgZZBKz6774BsJQyfAZFkbG0ZC8tAK25QKYEOIFArUmkWc
 hwTLA1M1hIe5PjxzHenpS2DnqLQky5Bg9NPwKhAJeqNWAtm664MYCj/4FkOltyMsKrVI
 ponJC2gDM1SIXddc+ObMUhvZ+VFwvevfqsxqnt5JD/TE6rkmCLC6thxRgpSdWTPGEaq1
 H7um2trXdUsMyMur5sLXTZX2sj5Iqm0uoJ6kuYFug4wpk3qI7OIdOO/xv1NQ9c499m72
 Vvl7FkEG6y4F3oaUIZvFcSHXdlyIl+hwxLVl0C9+mbpeiqhcERePfRkiV7xXCLyIHJem
 bZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lwuzneXbvXgqa6Bkbu/2Ynh+GBSHRDdIshE+cuLXX+A=;
 fh=E5AiPR8xocDBi/9L6FqCMaROuwf7rld9pDlmq7x9vO0=;
 b=KG+5zPJ+KxLRV9l8GMB4G0+eSLTIH1IO2zLgsKQ3rlbpv7SYlBCx7qv3QD+sondpNP
 oxoACzPCsLebETY5JYJTc7jJuwNM9jAx7uk0pN5IfVUPNt0BsiBpomkiJ//hEc6IUTaa
 4LbqDTiamFwf9sjoKGLtT3gUxopKhQk1z2DRTRMRpONGNygNzRFKgV3wFV7GMmWAhCK+
 wu9E3Be86hsW1B26xPZ17LFy1xHbZsHuKTE0+v3n7IW+TpD2h7P3ih/mzndn5pCih1VB
 m2ALChMolaMaqFo22QBoU1dYDW8pg753QWIPP+VxLEMNCak7kmachhzPBrBUJasHgvMW
 KnUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779220850; x=1779825650; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lwuzneXbvXgqa6Bkbu/2Ynh+GBSHRDdIshE+cuLXX+A=;
 b=D0/JLTDK1pTpbQR6Fbq2PTY/YMVjMchGVH8q+1ZqmkczAWcZHGUXgaSu9/hxmXisLs
 cT7nsjtwKPbWQ4VGk19/T0NoGnCnSlwYvQ1mg8IPcwfV1NQVDQgZwgDWxSDThmExIRP6
 CLcr6/HqmEMNYCEUQxJDjY2SLJBzMGcGJZAZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779220850; x=1779825650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwuzneXbvXgqa6Bkbu/2Ynh+GBSHRDdIshE+cuLXX+A=;
 b=XRxvsyD9BQfVBVTZz5D/xX5k3p6FoFSznYbh5C6aUDgA6N0p97u/yY7z5yT2pgjaY+
 /p40UzwHau0Lt+cxYEQwt9IDgBIuGG0qseXgpiJReI3k5Itj8vIurdDdQ7YXQW6JTyAl
 QEpXLp20TGuZxbef3iNI0fLYl948SO5OP1z7ISte6P7mleS1VPsDBSUodApyHunbnS/n
 B81CGTjHa91DKIus80q511rNkvzV+DyWBYMAnDsFJcrHUcqB0xnxTUKkU/dcNnQfSuBB
 jJSJVQhYCXX4Y/oBm5aEe2v4mKOLwF6l3YjR83wWxMaB35v0txVXHFExQfisC3Vae0ky
 UhJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aVf6h4G8Uf3bVmPV/a6hqlGlKkxbIg7bAjLK9zUq5AyBPqOusYtvYqQ5uZRXCWbrmU2ewqAk=@lists.denx.de
X-Gm-Message-State: AOJu0YyJDL+ZBRbqU4fH4lT+IvwZyeQMIVEELsqCR34maLcFxsupkwy/
 va7OJMq2DvF3YI3jM9ybxiiWxYnHzgN50ftAelWX+q5ey2MgJmrSDDgGynKFKLbl3d/0pkYFxGM
 uG7FOJzLnlbdRQqr+jrL2F6/1eq1ARqRyR1bHiHl3
X-Gm-Gg: Acq92OFXHt3WSifUBzAXfSyoADTq71phwajxILnxz+aGl8bu6CBVWvIN7Cn7SDr1QN6
 toIhl0R0OaIgF6u9UgspAM8/+02/mvke61iRsjCvTjkkuNgN7U49fFm2Q9tkGO5ov7t7xcFsn9r
 4wjxv7XCYA3uziS53aH1bUbaRdH7m3B1ne8w35fbsP4m0RHzuBcGkW/th9ng6byfR+PU8qPhawf
 KNRGwcZqz7FLbFR4Vzsdoxo28L/hMRA7KqbyApLn0GjRThYRaaCk0x+5b7sC/c5fkRFysTOg4pD
 mc3Iwg==
X-Received: by 2002:a17:907:26c5:b0:bda:7a3a:b05c with SMTP id
 a640c23a62f3a-bda7a4a0d99mr21994866b.42.1779220850366; Tue, 19 May 2026
 13:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-8-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:34 -0600
X-Gm-Features: AVHnY4LEd8HnuTfPu1Wx1zno3zaqntNzH3CitGLfmu9PDvntVnfPbTMaqGHoN9Q
Message-ID: <CAFLszTikKyaW+OUGuz8KRffyU8Mn3xCZ6AvJtpGPuFAhNqyqrg@mail.gmail.com>
Subject: Re: [PATCH 7/9] test: fs: allow optional date field in ls output
 assertion
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
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

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: fs: allow optional date field in ls output assertion
>
> fs_ls_generic() now prints a date between the file size and filename
> when the filesystem sets FS_CAP_DATE (currently FAT and ext4).  The
> two regex patterns in test_fs1 used ' *' (zero or more spaces) to
> match between the size and filename; that no longer matches when a
> date is present.
>
> Change ' *' to ' .*' so the pattern matches both the old format
> (size + spaces + name) and the new format (size + spaces + date + name).
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_fs/test_basic.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
