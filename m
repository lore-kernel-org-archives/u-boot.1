Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CE5E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A04289685;
	Tue,  3 Dec 2024 20:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ola2AL63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7A5896CF; Tue,  3 Dec 2024 20:47:44 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CEF896E9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee8647dbb9so2602730a91.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255259; x=1733860059; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=myIuJ7tnopglUM05OLjCZq6+uHaxKxFNXkmZI5W+tMs=;
 b=Ola2AL63QZ1+PPJXTjjAsEkxh6pZEhiOva9JaXNKFGZEQ4/rZHNuuFJ9Uszca+Y+qC
 wub9+LeNcC7rZWS0DEzkncaTl1jviQy07QLuTEmj0Xfx3VaDrijFAyWrOV0zGurcE3jH
 aoJ/3IY40kvN/lvSZleioMBgBwHr289chyvcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255259; x=1733860059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=myIuJ7tnopglUM05OLjCZq6+uHaxKxFNXkmZI5W+tMs=;
 b=ohAtF4yv9/xyWbfzXkkZSnheblB5xmSRqxI2otBk3YqoTruhfsJkDhD8XUqdTsL36h
 6S4zUxwBjBpHtV5jJ2s2XN90hXElm6wkvUWh4KkFejErOtRUmmCtdBB15+bl3YbG/zO0
 1JV7SM6ufrZFUgdgFbwuPk92U63kdz0YQPqaWjTYGz00Egc6+u7Y94KuscziwfUUjZr1
 Nr4UUfEwJ97VH4jlRlDXKamusnvQ3pk7teaUn5W0mLxNtQFyHQ5gm6u+3cp3qbJxpizP
 8ePyy7mtf37SNA3CA8n4QfIgjr2qCVNnJ2UEWIYO7GtLvvbahBTDojq3O+oSHOMfXJVf
 eSDQ==
X-Gm-Message-State: AOJu0YyiR6vIfTzp/SAKmgSwVFPuPZUFytQVNHWeCwmmyIvejAqceGOf
 KVxxTxv7sAV4hboBYWJWji1E6R1VEtoR9yslMj1/+QqaNYStukGZ3FOhmVR1zZJFztUoukKdbuy
 nd3ZupG2DyddTMOuu1KQgKtV1EX+XcjAAQyWkHMZbT1NcC3E=
X-Gm-Gg: ASbGncspGAdkk+xG6btKzV/LKv3vwzpxmGl9V2wD1KI3ZIRP5PXAcaT2lROnBFQSvCo
 iiMyCT9hdnqYsy1wxBVZZY/lAw6bZsA/N
X-Google-Smtp-Source: AGHT+IF/c4LzdLtKJjixwdco3lxgNatoPcwQGYN5nMvblhmE7/dna03jDGu7+oDULp8QiDlx24xqjgYNYvHm4k9AVOQ=
X-Received: by 2002:a17:90b:3c51:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2ef0120f37bmr5386829a91.17.1733255258856; Tue, 03 Dec 2024
 11:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20241102221737.547938-1-sjg@chromium.org>
 <20241102221737.547938-4-sjg@chromium.org>
In-Reply-To: <20241102221737.547938-4-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:47:23 -0700
Message-ID: <CAFLszTiLjD4wTc4-G-Qg2sK=CTSAPCUpUWuGPfSYKWk9+xFM3Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mx23_olinuxino: Drop status-LED code and use LED
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
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

On Sat, 2 Nov 2024 at 16:20, Simon Glass <sjg@chromium.org> wrote:
>
> Enable LED and LED_BOOT instead, since this is the new way to access the
> LED functionality.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Combine removal and enable patches
>
>  board/olimex/mx23_olinuxino/mx23_olinuxino.c |  7 -------
>  configs/mx23_olinuxino_defconfig             | 10 ++--------
>  2 files changed, 2 insertions(+), 15 deletions(-)
>

Applied to ci/master, thanks!
