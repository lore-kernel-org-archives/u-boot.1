Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96328CD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 09:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22800846E2;
	Fri, 29 May 2026 11:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AaydtWL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95DB846F4; Fri, 29 May 2026 11:58:25 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11F184671
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd8f9725b30so1602330666b.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 02:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780048702; cv=none;
 d=google.com; s=arc-20240605;
 b=SY3fEB9jMizdueklwenJIEJFfE8IHglTXzs6ZY1Vb1WZidMcOZwcqRRS1cOY3SXk1U
 FfYzWNfEFrvt6HU52oQq+Vimmzhq6rzxYsDehsA3W81L3KfAyIRIsa2xFryuFh/Efg4q
 MhDQzS5gRoWHRKwYlhXoFFdCBYrgeMHANguuEcHakM0Ak5fjOmce6LrFeunZ7CLcpjcM
 nWTUEYAAw+kaRc8HsvAIS3X5Rq+QGhQU7lA5TdMxHYi5oRAnoyMtG+NT8M8pZKyqBhtu
 gxLN0M43N0OCnfsIsyedtWrzHHJnjYPVDNS7fT/ndxDnyktnDXMIOhiHRBV0Xjp54bgC
 hUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=plsrkw9X8ViuflVvXJRPlu0aSplEURPmg33U2hBrWPo=;
 fh=Pwed0uR+fUcTESmvhLrbsa6n1RHCX2s8IPfo/JJetiI=;
 b=eie0lNcnU8ra5PIDBozHn2kYDSLIU2LXKkbb1ROUaUh5oxaZRJKmPS8ldXObkWRC/V
 KaJE0YKbgFb7ITuAWUSve5aBGVGfQJmpOxFmR3oAoY1vqyCxWOz2swV+p92nk17xYkig
 i48h+p2OK7EH3wOh3iAZQ7wJZ0MCVinrC7Cre+dOVXwOLe3Hmr3Bqst5bOGm29D47O0p
 5BEINamRXkuZOlOQsUjU4aFWFHNVuoMpZAA2MSGVDTM/UA/K0g453zlTAVwDcfqzlZn+
 7Zx3IEaZrUmv4uezKbkPUkJBUwibY3X544Hr+x7JWMpQr1/cw3MmMiikye8TMEz7bYT3
 STDA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780048702; x=1780653502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=plsrkw9X8ViuflVvXJRPlu0aSplEURPmg33U2hBrWPo=;
 b=AaydtWL6iFzxHaPSbNOWiVS2UoFPeecPUQShn6+2xs+0BQ7rBB2GBKk4www7P1wDPr
 vE1BFhS+0Rbt9sWTyu4RgHBQHNj+X1drRBbdqBpJ3tKGxnQuXHqAFJHEYUEacxQ4/vqF
 DKRqXHOgAnIfI9WcyZjqfxb8/O8k+VxCYJVgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048702; x=1780653502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plsrkw9X8ViuflVvXJRPlu0aSplEURPmg33U2hBrWPo=;
 b=U43zZ4BjBOalQuFZtlgepXWr5kBsOVj+0nPO4/AxkJX+d7H2MgerDUqrSTZI4JmBCx
 8Rp4ZYPgbjHNfjyTjO4EwgfKM664n6iu6OJWOhoXEIg1Mr+w3oulQtG3039NDx5DGLQ9
 G3ICZevT3sye5iphsp+L7VJtU15ruRdy+Bfx6TVZ1/Khmku41CYadrQk1MVeTd20ex7u
 OIEKvapcWUhZvoEb/5DQeryv6gn/8V7V2ihutzqgMwOyzXB23Ubatlnoh0ipE0kREYC+
 50C31Dpam5HKHQpV9bDecrBbRQxBwyPueMFZ3/c4uIK5v7xalVwGfGhVDwBKIhm1HJpr
 ngxw==
X-Gm-Message-State: AOJu0YwkeVLvNXJxbg9uOCr2hzOt1lN2NN8wrYyF8io5rDaO/jlrRG0A
 sZO/2TleLp/7q6fZZapNz0nELalOUpxPfPgRWpZ4dRDQBQZAdZHXc7Yqok8UW+gEONzIw38QWSZ
 E7D1vrJCrurC9PO3SPWRQSusjejB5S1TmFUZnJaD2
X-Gm-Gg: Acq92OEiNWHmDwuAaCJBSwE5VTpVMvhfBFMRsHnOA/fHC8UDKznrJLycE2Mwtzk45pQ
 9RwqQ0sG1wEWuqPOD6wg2iefptBuxXAvMyhCgOZa1/sxOPwCnyxXZDpUBmtaHStenO5mo9u5Fl7
 Ci0XL0t2qo4UMGw+6BjUOw3lZQxtyPffqVzrHTJI66oqvKBGbT7aJbJleS3AX3o7j57Obi8Dy5k
 weSQUIzo/67LWhus3VBKagTlwuH9U/o0wEhzlHWZQ1QDb+FbBBQZbxGOv4lgKSk89hJQzTSp/th
 NePHu6KbR738mLqQbowLEiL3RYV/2Q==
X-Received: by 2002:a17:906:8a7c:b0:be4:e284:104f with SMTP id
 a640c23a62f3a-be9c92429famr76188966b.17.1780048702511; Fri, 29 May 2026
 02:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-7-dmukhin@ford.com>
In-Reply-To: <20260529034441.2075305-7-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 04:58:02 -0500
X-Gm-Features: AVHnY4Jj0XA9Hlx6MALLdXy9U0tOkkAWQnL5-Cz2p6MVl851BtIOK5u2_oeocE4
Message-ID: <CAFLszTiy4SbO3DO2AhaCQm2poaTgba3HVA-w7rVpOdPz9LR_jg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] docs: nvme: Update QEMU command for testing
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, sjg@chromium.org, 
 trini@konsulko.com
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

Hi Denis,

On 2026-05-29T03:44:35, None <dmukhin@ford.com> wrote:
> docs: nvme: Update QEMU command for testing
>
> Switch to x86-64 QEMU machine for NVMe testing in the docs.
> Also, add format=raw for empty NVMe disks QEMU command line.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> doc/develop/driver-model/nvme.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/doc/develop/driver-model/nvme.rst b/doc/develop/driver-model/nvme.rst
> @@ -95,4 +95,4 @@ Example command line to call QEMU x86 below with emulated NVMe device:
>
>  .. code-block:: bash
>
> -  $ ./qemu-system-i386 -drive file=nvme.img,if=none,id=drv0 -device nvme,drive=drv0,serial=QEMUNVME0001 -bios u-boot.rom
> +  $ qemu-system-x86_64 -nographic -drive file=nvme.img,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=QEMUNVME0001 -bios u-boot.rom

The commit message lists two changes but the diff also adds
-nographic. Please mention it, or drop it if not required.

Also, format=raw is needed for any raw image to silence QEMU's probing
warning, not specifically for empty disks. Something like "specify
format=raw explicitly to avoid QEMU's raw-format auto-detection
warning" would read better.

Regards,
Simon
