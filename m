Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CA2E9410D
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 03:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1ACC84011;
	Wed, 31 Dec 2025 04:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="KWIJtxLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1509284011; Wed, 31 Dec 2025 04:59:42 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A7F83FC6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 04:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso8557024b3a.3
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 19:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1767153577; x=1767758377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CfpXE79ruIGaiNVPzK7von9NkCsxsBBHW+k5RGHkJHw=;
 b=KWIJtxLqRxLT2/rjQl4LeSEA2N8vS9ZNgkFmH0dbVLJET8KTqOQeX4ic6bMBc/5xWb
 Z37zp54P0sRsNKzf58xUL9ovU8bfjWK2PkzhJYdARi7JvRE+yUmZjrLXMUokOv2LxZFB
 6d7lSx8VgLTCZkder9e4g32BesqO2NmDdIw7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767153577; x=1767758377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfpXE79ruIGaiNVPzK7von9NkCsxsBBHW+k5RGHkJHw=;
 b=xGTDWd+DyUin+uvGuJSSIqA8UaQ4SQ1Um2VCdGGWctJpStGdY6CVd/dtL6iGeyOgQn
 a0TvPoOH4nc5ACdbRm84JgXxCZBMpVXIwK76BuEeW+LWaITNPuUeiLnyNW8n0y7BtZ9V
 T4zAlgdBm42GuIWBNldL0Pa+VvBJpyVc2rubuVQw4FB2DLMGSZRGh06xAGn6vbI+f3Vk
 fxE09dXXQic/oP2ot1O+4UBppYRjLTuHwp605kC4dNLXfGoxo/P3bPdkXlhgedUwee0b
 rSO97wtu25xDf8GWofovGmFGKPISu6c7XcAuHr9DCZNIETCO6Y0qNJ5baJq3EokXkDvX
 6svA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrE3/vfVkZZqP1H/uRF9PN98aZtplGY1olkeP/eKKurwrywiuDg9hlkHwQezIznmwihub5vnU=@lists.denx.de
X-Gm-Message-State: AOJu0YyzARXVejO4xakA5KCdX3ceRNBuzk5bRFCjQv6TrID4mQnd2VnB
 YyhtolmS1FjA09nY9dQe3xszCPfesLe4QHCVwxMhyss/B4RIzJsuTH1gS4m3NqhMja7A59d+po9
 akpDTuIgrJVx4ZhFIzM+J0haE5/H9iV2kM2pw6KqOHQ==
X-Gm-Gg: AY/fxX4nl8laLY8j6GOIO9VOvUxxVQ643rIr40LwdVaj2PSZWB8qN2aXVFkZLr2f07W
 gbCH2X2FCGviBZ5UJURXG0TseH3B4t1b5fZ8W6ZIhudmrnVfHdlhYTo4I+0p1/1Ob3OkFdhGTNE
 BVnCUtKBamiE0qFMRH9OXwAJXXplaYKtEeoywsDAVLSGmcEAu9Kt2NZWe3d7u9DS0rie5G/QDuo
 SNvs7gIYJux6f/xSBIAl2IvL7AfE0Tf2H5jyftPYJx7L8Nl6tHqJ5gLbDo1u8CCeV9f2rhR
X-Google-Smtp-Source: AGHT+IHavRssdPPYEIUDsK0oCRxZFMBEppuR9qxYZLEo2JcYQgKwtc4XjJjrdhWDXfioo6r760eBlVzSq1LlcFdlr8M=
X-Received: by 2002:a05:6a21:32a3:b0:361:63eb:d024 with SMTP id
 adf61e73a8af0-376a7cf4ea4mr31940029637.23.1767153577071; Tue, 30 Dec 2025
 19:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-6-visitorckw@gmail.com>
In-Reply-To: <20251230160112.3045527-6-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 31 Dec 2025 12:59:26 +0900
X-Gm-Features: AQt7F2qypL7oPaUePw8O_NBRRvRCJrLK9TKnNaUbqdVHscbM7R44_p-SK5JIs0w
Message-ID: <CAFr9PXmPL_5sS6oyZxt=eM+AcQnqn7HjVFGOLL+jTQDyD2YQ9A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] board: Add QEMU m68k virt board support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
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

Hi Kuan-Wei,

On Wed, 31 Dec 2025 at 01:01, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the QEMU 'virt' machine on the m68k architecture. This
> board emulates a generic machine based on the Motorola 68040 CPU
> equipped with Goldfish virtual peripherals.
>
> Introduce the necessary board configuration and initialization
> infrastructure. The implementation includes logic to parse the QEMU
> bootinfo interface, enabling dynamic detection of system RAM size to
> adapt to the virtual machine's configuration.
>
> Enable the Goldfish TTY driver for serial console output. Additionally,
> enable Goldfish RTC and timer drivers to support real-time clock
> functionality and nanosecond-resolution delays. Include comprehensive
> documentation covering build instructions and usage examples.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I have roughly tested this in QEMU and everything seems to work as expected.

Tested-by: Daniel Palmer <daniel@0x0f.com>

If/When this gets merged it'd be nice to get the virtio mmio part
integrated next so we can access disk/network.
I think virtio mmio has endian issues in QEMU or u-boot as I had to
add code to swap everything to make it work in my version of this. :D

Thanks,

Daniel
