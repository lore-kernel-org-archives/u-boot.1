Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91869C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C654D888CC;
	Mon, 29 Jul 2024 17:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dw36DzA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B501888897; Mon, 29 Jul 2024 17:28:56 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A60688892
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5d5c2ac3410so2195506eaf.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266932; x=1722871732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MdX+D+cXnA3/8o4qP7bEhj5dwu64FeM+uooib2y1Hy8=;
 b=dw36DzA/v23LsUaOnuTW6Ax+dcr15GnX+Ng4C4iAxtjFHAiO2zEfzlJlVqIz9GhrMB
 MkQeeJbmVxTmLl1pIRCqPBCc7oaUS6QuSDrSYdzhVDXnm8ub0+Bznc6QTI2dxojIGMY/
 i8xsvQDjcN41ZKAOWmsJ/WyRL6srzlnpUqkuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266932; x=1722871732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdX+D+cXnA3/8o4qP7bEhj5dwu64FeM+uooib2y1Hy8=;
 b=j82ppQdwfJzIVUrPhNw9q35FtFTp3jIgnqD1NzS5VHwXJI3kAv70s9w6ptzsD3cuPq
 kVqHTuaO1cPMBqZLpUkBY9bsMC9zpMGTYibG5HbVYdwNnLxCpljfI5JrNUjaPuM0t+Zb
 tVBNSptfZZBQqiVK37zigjzGG4dj6Mtrnpjz3PSkewhOrojDPA679d+AOwUPszJeRxvW
 xSsHWLUNW5xUdDCnL7ZRyEZQvJGajD8ypM6HQel95G1hi+MfJNq583uMwfxIPlj2aR9S
 KBLMcVKVeeX306Su2JH+6FkZFRSubAYA/RmjJyI3EAibVHCxDSh9kw4Rtulx81xwolcs
 koBQ==
X-Gm-Message-State: AOJu0YzA1rFLTMSWjxUJwRLeB4hTr5mE5IoVZMR+iJYP1RxQ0rgugmwA
 moSp+s+eJXOvPi78ttOhKi1SEcS7oh3QyIAKSwqubs29o4lT8DbX+pxZt9lyrxlp8W58ERWKWeR
 rkw9EUsAonKNnLr7L8NvovC7j0r/US+SxEQ6YAaYQNP8X0kk=
X-Google-Smtp-Source: AGHT+IGbpZSr424lZtsQMp9FUAg21ojoeFIpvS9BpKA276a+5UR7hLhL6q03b0eQnRce3btmSF0rFKHt8nNI0L0SKjo=
X-Received: by 2002:a05:6358:3208:b0:1ac:f349:9a14 with SMTP id
 e5c5f4694b2df-1adf1e76317mr1249984055d.29.1722266931942; Mon, 29 Jul 2024
 08:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-14-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-14-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:41 -0600
Message-ID: <CAFLszTh8L4LmT9tOH8eGb-Ruhxa7d+_tkMrygzJLCLkFu4FnCQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] board: raspberrypi: Add ASL files from tianocore
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, trini@konsulko.com, bmeng.cn@gmail.com
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

Hi Patrick,

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Simon Glass <sjg () chromium ! org>

broken email address

>
> Add the necessary DSDT files copied from tianocore to boot the RPi4.
> In addition generate a board specific SSDT to dynamically enable/disable
> ACPI devices based on FDT. This is required to support the various variants
> and boot options. It also allows to test the code on QEMU 9.0 without
> modifications, since it doesn't emulate PCIe yet.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  board/raspberrypi/rpi/.gitignore   |   3 +
>  board/raspberrypi/rpi/Makefile     |   2 +
>  board/raspberrypi/rpi/acpitables.h |  91 +++++++
>  board/raspberrypi/rpi/dsdt.asl     | 290 ++++++++++++++++++++++
>  board/raspberrypi/rpi/emmc.asl     | 136 +++++++++++
>  board/raspberrypi/rpi/gpudevs.asl  | 372 +++++++++++++++++++++++++++++
>  board/raspberrypi/rpi/pci.asl      | 177 ++++++++++++++
>  board/raspberrypi/rpi/pep.asl      |  90 +++++++
>  board/raspberrypi/rpi/rhpx.asl     | 195 +++++++++++++++
>  board/raspberrypi/rpi/rpi.c        | 182 ++++++++++++++
>  board/raspberrypi/rpi/sdhc.asl     | 111 +++++++++
>  board/raspberrypi/rpi/uart.asl     | 208 ++++++++++++++++
>  12 files changed, 1857 insertions(+)
>  create mode 100644 board/raspberrypi/rpi/.gitignore
>  create mode 100644 board/raspberrypi/rpi/acpitables.h
>  create mode 100644 board/raspberrypi/rpi/dsdt.asl
>  create mode 100644 board/raspberrypi/rpi/emmc.asl
>  create mode 100644 board/raspberrypi/rpi/gpudevs.asl
>  create mode 100644 board/raspberrypi/rpi/pci.asl
>  create mode 100644 board/raspberrypi/rpi/pep.asl
>  create mode 100644 board/raspberrypi/rpi/rhpx.asl
>  create mode 100644 board/raspberrypi/rpi/sdhc.asl
>  create mode 100644 board/raspberrypi/rpi/uart.asl
>

Reviewed-by: Simon Glass <sjg@chromium.org>
