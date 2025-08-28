Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B505CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 11:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B520832C8;
	Thu, 28 Aug 2025 13:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AhLY/O/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 150A5832F0; Thu, 28 Aug 2025 13:06:06 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61CE8328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 13:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-afee6037847so87192166b.1
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756379163; x=1756983963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vJYp+NsWTcc4J28H6ahN5AuUAD8pJsOtXBIrgXnOUFc=;
 b=AhLY/O/KtNdjr2GiwLU9SrG5nYSZD7MMDWSF6eHlb3nY+euBWnzQzizGAJM0Lk3han
 T+u6yrs+vaesC+r1ZDdEeov/HE0Qk1rJzIqtYRIKBZyKCoQ8JC9BFWfIo9luKz8meB0G
 OsqJ8ClPewbmtKt/UW1WlmZQaSFzC+cu2THCzuAzCIR1KdukKHX2WhezuGIz44UFH9nz
 MDQgvmNPiVmqC6XxP1NYj/UDXWZQWug/aOXxyFIyppy6ynF+d8PR6IkNqiFMrFivuWIX
 s+F49DOE5Tp4GUdpAaCBsR9u9e4I8yOGoLsisGtZ7bU1z5cQM4ISWzHFXWZJVWiLrS27
 9Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756379163; x=1756983963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJYp+NsWTcc4J28H6ahN5AuUAD8pJsOtXBIrgXnOUFc=;
 b=sKv7xjIsvQ+sy1X1ITbiYt3r5kWIW1oOahwInqxzdzfBwXpP8m9Ozyxb+v79mbKfvf
 1FjOSsyRIIpwmxlIf/gRtig0XvLyvrz1PUhNU3RIYE5HKjPXFkZ4N2kZYAfgrqXlpqk9
 ZbclDY2d/tuFXgSn0kwublSGsvQkVqcIcQvrhxbL2KnmyVTyhgWC6ALXLeipPUi8IRUE
 3/cwv0cOKlFpkLipZrfbFPDx6AqgVbyQLxLsvE2hs9iKnLNL0Wj1WvGAZAI3GGtHOJxO
 ZsQv6VDy9O6Knnk7a8mHkNqnb7vz5mBR2sbavODT0HQolQAvqg+WFdctMmza26vN3NYw
 Hxyw==
X-Gm-Message-State: AOJu0YysB8XCaME6xAf3S9UJcvAZlNXsq9AW87sY8zvwxIxPWfnrkT9A
 /w9H7OBvtaPkopE+2vL1wpI4M0e4f4vJzlqs3u2cU1SPdO6wnaaFuviS+ehXUmDJ33EZQHkjj8y
 AVWbNHf3iFivD38hS04vYd3Uquhc6VE8=
X-Gm-Gg: ASbGncsprw5GPNOWYPjnx1Zb18gFgvePIGJaDmhPLkLwWOBJPvaPwUDrt/ZgTGhAgqU
 w/mIqigFh7NNu4GsqsQM1WGqfNVBzDIdl0esvPdYXgvaBDjjg7+ui5F2L2t8bO5OzgIy8tpS6b3
 wSQpQBvkllZzqB7du802O2cX0mmdjJH8QJkeHja3dJ8b74/k14rJ4wFL3nkdNXiOQLfGIRm2uiA
 1S4F8NdgKFGcgYJv5VXFd6cvDMrJRiM52A=
X-Google-Smtp-Source: AGHT+IElkFziVAr8K8x3GxsoH6ynFbDHY49CyQRBBmBPwMY61/hUVzf+71wnZcjbmTGy7hfjzFRG7IUHA60e0H9014k=
X-Received: by 2002:a17:907:60ca:b0:af9:35f0:7a0f with SMTP id
 a640c23a62f3a-afe28ffb668mr2059472966b.28.1756379162915; Thu, 28 Aug 2025
 04:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <a09a51134c3d66a9644d2aadb15c99558ce5e7e7.camel@opensuse.org>
In-Reply-To: <a09a51134c3d66a9644d2aadb15c99558ce5e7e7.camel@opensuse.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 28 Aug 2025 12:05:51 +0100
X-Gm-Features: Ac12FXxtkpfXCMOI4ZFRLG7sZDtzomwI440ef_V4MKZxm0clbKZ6-_201oummhU
Message-ID: <CALeDE9NwpDJ4_to1Z6L+N1WqL4L_UgegyHqShDvTYTc7Cc8tnw@mail.gmail.com>
Subject: Re: No console output on Raspberry Pi Compute Module 5
To: Jonas Kvinge <jonaski@opensuse.org>
Cc: u-boot@lists.denx.de
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

Hi,

> I'm using a Raspberry Pi 5 Compute Module with a sourcekit.io board.
> I'm not getting any output from u-boot to the console, I get this with
> CM4 with the same setup.
> Do I need to change anything to get console output on RPI5?

Well at least on the RPi5 the console has moved to ttyAMA10 from ttyS0
so you'll likely have to update something, it will depend on how that
carrier board pins out the UART, but it works fine for me on the RPi5
so I suspect it's something config based.

> I've added the following patch for RPI5 which I found on the list:
> https://github.com/jonaski/u-boot/commit/2f60b5d80b3a08d480074e8230ada543bfa42401

The rpi5 is supported with the rpi_arm64_defconfig so that's not needed.

You also don't report what version of U-Boot you're using. There was
an issue with the serial console on rpi5 producing gunk on the output
but that was fixed with 2025.07 release.

> My config is here:
> https://raw.githubusercontent.com/jonaski/u-boot/refs/heads/rpi5/.config
>
> Jonas
