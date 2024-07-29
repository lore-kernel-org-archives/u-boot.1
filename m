Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C806C52CDC
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39733888BC;
	Mon, 29 Jul 2024 17:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WlgfQloa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37ED18880E; Mon, 29 Jul 2024 17:29:06 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322E688887
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b795574f9dso18641396d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266943; x=1722871743; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pG1v1PvfJC4QscaJBP3OuE/8G1wLv8G+4/kyrBlLkO8=;
 b=WlgfQloaWTj5OtqJoGBHQ5Da3T8X8ur1oNfg84AWUjkdMrupAelPzbvFB0VQZry599
 Hz2bInBsnOyREGu2WB86iRYsdHV0k4mb46shXVIZ5fZX/3vbtaVoJs1afcSvCamUgwZV
 ROj4XXdXwxJCrr9D7D2dnFCaXg7btPXrCtGPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266943; x=1722871743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pG1v1PvfJC4QscaJBP3OuE/8G1wLv8G+4/kyrBlLkO8=;
 b=gAPoXyjTgSuy8NSEZ5jMuhtgVy77XBD6unlr/Ln5x/VqfDvjIiasdIJRT0RPhKiJZC
 UDny+kOn3A1fZ3A9ZRzSD6dKj0JPWIsfFW31kBIsO9jgjtxfKSCLERpG6c29U8Pn1Zjn
 bjGkF9Pv4/deoYQiVgYsm7W/ylMwPqizHlq+RNaK8JUvfZN3XqFVHGzTL4mHpHvQLkbd
 Exy8Xya/vRJrXAEoNEcvTOflF+i77S/ywKnG1Qk9/9xUfL8O0JaqVAljIdh5p03uGWzo
 fwN1nzitM5veFxB64dIvKclwLT/uzQDRy6JUdjb63Xso4WZPdGvjxWZQja5u4iqxUYz2
 NX5w==
X-Gm-Message-State: AOJu0Yw52P6TalKsJpuyfwrWqrW/ya9enG3PO/k4L3Kjvif71mhhxlFv
 e0Qw9bnigxmVqoEa5layzBRG65PS6R+LoLSW+NosuAbc8wltuZapWVFS/yhmBeabwIRv9pxKF8J
 OlikTMtUDjz9SwNC8MfJiVoScc7Ll1Tu+/o9v
X-Google-Smtp-Source: AGHT+IEeT2+KQsFsXNE04DWvCJfFS8Qasp46Ckv1KarkDJkZLO4OaT2Ti84rgB1lCLB4PCHlW5iCjOEK2lHNDziJnTE=
X-Received: by 2002:a05:6214:262b:b0:6b5:ab8:3c67 with SMTP id
 6a1803df08f44-6bb559bca1emr109873936d6.12.1722266943070; Mon, 29 Jul 2024
 08:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-17-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-17-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:52 -0600
Message-ID: <CAFLszTi3aRQZ08mVareEAX1K_pRRP=ur31akksChjxn0ZHHJGg@mail.gmail.com>
Subject: Re: [PATCH 16/17] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On FDT platforms the APs are brought out of reset using the spin-table
> as defined in the DT. On ACPI enabled platforms there's no FDT, thus
> enable the ARMV8_MULTIENTRY to use the ACPI parking protocol instead.
>
> TEST: - Aps enter U-Boot when run on qemu-system-aarch64 -machine raspi4b
>       - APs on real hardware do not enter U-Boot! To be investigated.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-bcm283x/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
