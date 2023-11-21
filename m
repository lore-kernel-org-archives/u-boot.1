Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D697C61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5AF87635;
	Tue, 21 Nov 2023 23:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mBFvVd9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F4D87622; Tue, 21 Nov 2023 23:11:37 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C9C8269F
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dafe04717baso5620204276.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604694; x=1701209494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6oMkYREIDiMfLUoTMulgYQ62E1ppub2PAY1s7VL1bF8=;
 b=mBFvVd9IISL5WG/T5mQTbO4CxYbBnXWYWtHB7lWU4CAcNIrXvLgkIspH0Rq/rhn0p3
 yTwGWJ8KvNvLeFJq2MRSncUKwISiBbF/WJDaLE5DxqWxnY20ffsRq1i3gQAdsHUhvpsj
 BXcTG6ukLQTW5Kgt/pcw0ZOyFqk8hPMXvzBUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604694; x=1701209494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oMkYREIDiMfLUoTMulgYQ62E1ppub2PAY1s7VL1bF8=;
 b=URnZukAPyedHs/2FpjIELEVrZiyQF7SmOqDgVgDMRP0NZ+Y7Fk2EiEhCdMOyqvpcgV
 Jownpu7Y1dX6sfxpO1tfT/pClYvZmdOxaPFXgJtZ24zAejaaWvW+PPy22czbiP38UhE9
 84OwLDyqZbwGV3E0b7otVUdOMJ7zCFvpmAj4X//B2wz5nlAY+Skf+OWdGHVdZpQQxEYZ
 f27HsmkE3uMY0jIUDeRYOx1EOc5XhpeY3FlYk5lbU1Hqq2p3keO3nJZA/j8dEEuryleg
 EgcqU9hQx1lhlUdxCCK00fJRFKxmb5aCnJp4s1WuSxe5r6P1oxviFvGdWkBEcP9qNFS0
 BrwQ==
X-Gm-Message-State: AOJu0YyCCbL7XY7Lr2ltq/l6wh0gheS1VFMLDx59Nhhfua6nprQSDkmt
 xyF1vDJ3PvWblfLWasphU7/uX1zZBa3nDXbwvyQKxQ==
X-Google-Smtp-Source: AGHT+IFGZVYQQB1qahOQvbd//cylFWjRcHZUX39x6SDAviu0xPS5SV7d26HS5vbmcNKICWo+veOthe1vkCf0kVEOtgs=
X-Received: by 2002:a25:512:0:b0:da0:97d3:4e2 with SMTP id
 18-20020a250512000000b00da097d304e2mr351038ybf.42.1700604694035; 
 Tue, 21 Nov 2023 14:11:34 -0800 (PST)
MIME-Version: 1.0
References: <bd09ee5c-5c73-4990-8b27-bca9bbe14881@canonical.com>
In-Reply-To: <bd09ee5c-5c73-4990-8b27-bca9bbe14881@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:11:03 -0700
Message-ID: <CAPnjgZ05=yibPQEfoyAXijrepjZ9Q9crQaPbB_jYaubuY+M9OQ@mail.gmail.com>
Subject: Re: [BUG] Video does not work as expected on efi-x86_app64.defconfig
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

Hi Heinrich,

On Tue, 21 Nov 2023 at 04:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Hello Simon,
>
> I have built efi-x86_app64_defconfig on v2024.01-rc3.
>
> On my laptop the video output appears twice. See
> https://gist.githubusercontent.com/xypron/24ceedb749a68031790864c3a35c5f30/raw/30068496f43e5b088300748d062d0ad64674bf46/screenshot_efi-x86_app64.jpg
>
> Are we accessing the video buffer directly instead of using the EFI API?

Yes...well we are using EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID
(drivers/video/efi.c) but I suspect we are also writing to the serial
port (drivers/serial/efi.c)

If you adjust stdout does that help?

Regards,
Simon
