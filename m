Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B531C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C7D87646;
	Tue, 21 Nov 2023 23:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xkb+Li5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C148744F; Tue, 21 Nov 2023 23:12:18 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6753387629
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-daead9cde1eso5279735276.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604730; x=1701209530; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/iBJ4JhO4a5emkJteQ/CKxayW7urtlDCg/kFlzubU+Y=;
 b=Xkb+Li5nJub/cCyX3DiTCXiTMXtbNpn6ajQ6Pbf6gRMbCk4yosBr7I2fQ7vpnwTmG9
 lfoqonGQ3HHOSr7vQoV0dOw4TptfHjEoIygNhMuPKSnKOi+I7hIaszE2BMvSRhI9Bqlq
 dRzYMZfpSqbLtBTZgwBOfosCUDdib+FBJVozc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604730; x=1701209530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/iBJ4JhO4a5emkJteQ/CKxayW7urtlDCg/kFlzubU+Y=;
 b=cGG0WULd9ZlqEkgTfOSOLTJvh2N0P1u6MrQTTv1G2NfwGnP9KBipzeVCg7IoHcACad
 17BNqA7LOmeH57QWSyJRFU3tU+xoB0Vqd8YMvFeAJCAwJrm0hOezjNUlp7Rb0uOpnTeN
 vZhcc+ocTHeYrGOR2R7dlFm7ZdAd/K/ZwAH4BP+5m68xS+Tixnr9DpO87D4fSnZ6Lso1
 bqbnx9yykl8c7WufkqhtP7Zd5bM7jXOSi1B0qc1DQ27nXeo+e6NMOu6tcdhjodW+tZ1X
 QBVCFT50HcqNe1RH+C9qwx7dn0BtEHaJMbksA/4bO2Dl38w8j5UClnSJL4kJqbZy9DJL
 C6FA==
X-Gm-Message-State: AOJu0Yx/Yr7Bv5NliJGCi8mAjYc0TR8dxmaWQ4DBQap6A23/gThX0Ajd
 t6Nfx51a6DVGD6eNnMNMUyX7Z+wTLY3XJ8uCY/+Tfq654QtPKDj6ZjY=
X-Google-Smtp-Source: AGHT+IFKbv3KwdEqzR0lKquwAv3CaQNHVMfHF+nTFKKMW9GAE+SNySLyOBAEBH8IxrX5uv7OtzuORGC/uS+uXbvnAMQ=
X-Received: by 2002:a25:73d1:0:b0:db0:4390:a51b with SMTP id
 o200-20020a2573d1000000b00db04390a51bmr316564ybc.19.1700604730508; Tue, 21
 Nov 2023 14:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121152740.24783-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:11:49 -0700
Message-ID: <CAPnjgZ1ejTg=EZpz5WPMNoMSjFTcerY6Ju=btF6bvtvrev-j9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] acpi: carve out qfw_acpi.c
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Yu Chien Peter Lin <peterlin@andestech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, 21 Nov 2023 at 08:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Move the code related to copying tables from QEMU to a separate code
> module.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  drivers/misc/Makefile   |   1 +
>  drivers/misc/qfw.c      | 240 -------------------------------------
>  drivers/misc/qfw_acpi.c | 256 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 257 insertions(+), 240 deletions(-)
>  create mode 100644 drivers/misc/qfw_acpi.c

Reviewed-by: Simon Glass <sjg@chromium.org>
