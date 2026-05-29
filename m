Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38C6CD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F8A844CF;
	Fri, 29 May 2026 09:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Shq2RX8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 946A4846A5; Fri, 29 May 2026 09:20:18 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD87783FF5
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bd4f8260e4eso2385506166b.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 00:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780039216; cv=none;
 d=google.com; s=arc-20240605;
 b=b+RRnV+u48VaTZukjYpqG4maPFyBesa6WGj1QnP2X0EfNT+zsVmEdBqjBmZvngmajr
 OWxgTY0MPnhQvlR5/UyLA5xSOYyN7AoC+8z8Tul24YSsdnRwCVSm+UFq34GRwoU3pZ0+
 f9IXHWRbOfVMKWsqX8EeQKUJs+rfBsXtKD2z7R7uz3nlhTIuzt5sgCG+eY1u5NPg24sn
 d4+675EhOVcQAUHm+mHA/8W4ni/CZ+fVosbeRxm0kB0OZZkwO1MJ8bYt0sDI/pvjMGQM
 MiCwJN2XXtf7GNUVW5sOO5UmH9mYMgQggtf56HAFihUQ9jvctmMVmakLDMAW7xy6SNI0
 MWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EZExBhtLULHjSwevJqJB+EDc+IViKQmGDx2x+Tc1AQc=;
 fh=tVuIJKKBe51pS3nHGtFT7tdbejNE+gCxrpQPXUz+1UY=;
 b=WaVp3oDXnbIdVUDMHS10tii5ydMP0Ioacy5+FvL1wH3eO1IDIEtJY9Gj7qWEQBUiLY
 8PvuMGtVrmDg8I/f2u1ifN2niqe9XAXFPnB3YRxrWfYHX2EkOLRiCqRjH2f2xN9LP8fR
 fMJtqWgdZIRJsYWIz15b5ucmpIs6g+N+Mf1UBJYfYsziaNgaR+yZRTsDdp7o6ICYfKXc
 S3QpVApWE4n2pXw8TwVQPATnfGTD2dExp7qNOYwvXYB9b1u80zGgTxxWPAvvAc2q1RXQ
 hbxM0K5D/FqLNLn+qbOJONntOcuTeSd02fIdrr/sfneBnPzEuO1JIFw2wxVTrgE/J6KQ
 J1mQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780039216; x=1780644016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EZExBhtLULHjSwevJqJB+EDc+IViKQmGDx2x+Tc1AQc=;
 b=Shq2RX8mHpi5UHoX6Xngako5XtZXGb5/99knf/DbkBEw0hK+wNcbpTlygohpk6sfNM
 xj0pRTkh5fn20fhFKF0L4uxUdvonhbwJDJHd8lVW6DOGR+sESVzq7T/EtIKtCgT3V7de
 Xd4EJWDXh0FO8GNbSYqrAN8ZrxMYH10AZosTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780039216; x=1780644016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZExBhtLULHjSwevJqJB+EDc+IViKQmGDx2x+Tc1AQc=;
 b=NQ3vY3y7h2Yivptyqoq0Fnqx4X2Ktm0t0IuVUmUwkkD7rvEEQgAyJ/7BO/8FByCA0b
 nQa3y3hMPFo7l1UQI7lQa4FjnrnBz6a0308Hx3P+nkXaxmnfEqxA31SsBza926KctCxT
 lgOm+dRbXg7hmCpe9YyTpnPU4oTLQiWxNtvliyKv9XnYGogHGxeJXPCjiF4CsPuboLPG
 GgXym/y2HJ6ppXNeU4V4Dtf4a/Anw82mv1eiTwReHAhxHHgDM0VMqWSYUoMPByeAHfyd
 AjXvh9H3HzdKSYpZvLLQFOONe2UG33ppkMwpVXX4ocuWoxX1dZ8IFK6SuCnVABluGvwi
 7RDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WjVliDBQycGKMR3u8HbFLrddCKVIiWfFjQ07sQKpF4l4RtE538YDZV3E8ZhwCkAaK5hFpRfI=@lists.denx.de
X-Gm-Message-State: AOJu0YyLuHkME1bBiTCkbQVQiW046QrWNzznbShstkv71R56gxNIBtO2
 1eMxPpid/hMBiWZxtSZ364u2bnBL6E7OIS+aocIGApB0zG/F4rOd6yw0idqWpPBCIOm3bPrLsqI
 22HV80eZQuSKaZSHyxWzlZiBmUw70cmUUUZ6zYoS6
X-Gm-Gg: Acq92OGaoMJeg6D0VYAH8xyOdykOPsniQdjWC1FBNR/BcTA3uslHCX5lgA5h7eaJTtp
 bEdfJ28frrdBxYb586Djfu5GskLcI1EdH4RGgSpnjB8lrNpP3BUCRehZrjOmxWDDlmJpNfZiiy1
 9RkW4GiQ22lWsiaRj3H2A7NP5/+kFaknklZPEfn2bpCda3yMrhcVgc7/i29szpiot8xBLHEpbJ9
 YAHQuPT1vHDGvMtfOnga+GNDxAUzw6x71Yfd0+tgd8tCNhVJtWKUgRLTF7nW4QXDZK+kCz33XHr
 Iehdmbo6qic2Ob2MR07pmsuukX4Wpw==
X-Received: by 2002:a17:907:a606:b0:bd2:aeaf:470c with SMTP id
 a640c23a62f3a-be9cc89ba4cmr82458466b.40.1780039216051; Fri, 29 May 2026
 00:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260527062936.26895-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260527062936.26895-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 02:20:03 -0500
X-Gm-Features: AVHnY4LGgY0OHJsEnmZ34hwQr2wraRwC5mgR_8CxyuMcisN_1_DA4E4wB_eZ0p4
Message-ID: <CAFLszTjE1cGi1G5bPmz4fvC1sSceoKjE2hBB5-jm8Sa3EUixgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: validate PE-COFF relocation data
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Anas Cherni <anas@calif.io>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On 2026-05-27T06:29:36, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: validate PE-COFF relocation data
>
> When applying base relocations from a PE-COFF binary all data must
> be treated as untrusted. Add the following checks to
> efi_loader_relocate():
>
> * Reject relocation blocks that don't start on a 32-bit aligned
>   address.
> * Reject relocation blocks whose SizeOfBlock is smaller than the
>   block header, which would cause an unsigned underflow when computing
>   the entry count.
> * A block with SizeOfBlock == 0 is invalid and does not mark the end of
>   the relocation table.
> * Reject relocation blocks that extend beyond the end of the
>   relocation section.
> * Reject individual relocation entries whose target offset, together
>   with the access width, exceeds the mapped image size, preventing
>   out-of-bounds writes.
>
> Pass virt_size to efi_loader_relocate() from efi_load_pe() to enable
> [...]
>
> lib/efi_loader/efi_image_loader.c | 85 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
