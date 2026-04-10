Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010CEF45A0F
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 23:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E5C284099;
	Sat, 11 Apr 2026 01:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cgfTdhE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B092840D8; Sat, 11 Apr 2026 01:02:50 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C0283DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 01:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so398538766b.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 16:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775862167; cv=none;
 d=google.com; s=arc-20240605;
 b=cu8Uqc11Ey7hNstkeuokXQquTdnMoAdH4xFDdXU1RjNL8kx43UssaZSa5+ATDpVmXO
 td1I2SInrLZ97gqRzz/N7yv6NtGVqvbV4jI6pIAEh9W+4LotyOXPlZViK8940r/nLHeI
 ORXnlI2OFlHo08jY9kf2XYd2lCuQ2yZJDy0Dlec8j/kIRhrJ6aLRsn0rFYBIp/V0bWrL
 fd80p6KH3hNoChMbGejjPv56psj2ST2/uHQiIaIGtqPxsZE+YzNEw67IgkBglFN7Dzx+
 A6giDyvZrTgyoeUKa9wm0DSFcRtxHQ9YqSdaLL/UaGLI2mVJMZ44OuRrwDeaFRS3OysZ
 Y7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EizR25zkjnWPeOR2m4Wg2/JuwY+zXlRlea0kryyPjMc=;
 fh=OcaZoioaZArISsDr5ZY+o55akaQlFOAAQAGUIyYcjDA=;
 b=RVGOlArNzjQD5YHlEIP00tUFKO395RSugTzShU8lrTqBFq0RIHUGxN5tJUUi4YkZkl
 pCSlJxmiCiAl/2oVMG/V19RqaP1ZLtgjxRAU+eSZfNVcp9niscqsU7JLzuK11Sq8HuuI
 oTqX0MAU6fF9eldBF7usTvol7nv/Yi3dkC6UhG+QeJ+WnD6KL0Rs6W8w5I7bhgkVZZIu
 WLsiesCt67gu0QK9sa8gQjhtmswWvD3NV6Tu3lURYu7Pi+o27h6j7ziRFvfXayI+puIW
 GcBsvfUk/oiLRA/AAp8DH0oSf2bZpVYC7WG8Y0k5QKhwVhpbggiLRPxluR6U+j6SA1Gg
 rZqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775862167; x=1776466967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EizR25zkjnWPeOR2m4Wg2/JuwY+zXlRlea0kryyPjMc=;
 b=cgfTdhE8k8g95d1uoIY/bThB6Xn1cg9r6TWnrt4lhmek0I6rui3vRLi7dTtCzW6N55
 LPJRf90x2UfAqencvAX34fXr1W9kYO5ayw+Z1wNZTWFtSB3mjOXncIFU5FPjpppId5nR
 x8F+cdvpvr7rUVaxOZiy+cr7VX46RHeQVPNwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775862167; x=1776466967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EizR25zkjnWPeOR2m4Wg2/JuwY+zXlRlea0kryyPjMc=;
 b=pb2G2pavlgtSlCCdYdNB5D2HLG8MQzURDNeCZ5k83H5evDjwq7xzSJjCimLj8C5zs9
 K7a5wP54PJQt5wy8KyY/EqSjubPZsFEUHniDLZ8iQ4H2RXOxBG91mYX0dXtI3NwD1pqw
 PdxqcASzREcShxctTAqr4lxxnz/lOOR5JQ0zg+Mi9tWs4yfBmb6If4lc7/avh1kqmS29
 Y61aNpXh3WATNi+a7K/E6epPuaZGS2XlsaO+n91ncBbhbJmc7sp3nB1jBHFX+vxy05DQ
 eSOM67niD2hGQ1WI5b4dsA4iW8w4x7ehjTAOTYN3OFJu7ZCLM8ou2HXMnrWy0HyMwnP3
 Uq4g==
X-Gm-Message-State: AOJu0YzpY3QgCggijp1XoB/9lTxtoT05zJYPoIZ3MAl0YYQTzaMlD4Bb
 kj0WMsaRA26b0LU/5gbwk+X1KKMv66AGZc/7ZRgYlik+dyruZP/TmrCGlxUMycOco4OGiL5sZn+
 trKGJ76xXpbb9pA/R9IuXzatXYT7+QUBFYTs3JnO8Fr5UCQIzdsE=
X-Gm-Gg: AeBDiesqFkyjs70BmkOf1ZSrCgBAQNUpNDYjg9CE/+Aje0sSxrCGAOgtCRSwa188CuP
 /kpw+BkRjuKZLbI7wGciOMClDvCGurIBOWVuoWUe2kQRnVR9Vc9iJ9Cy4iUWdIrDlCFBuP8wSjX
 B8M1UaQAWDDCHhkCXcZkREZ6W6wLrlTiTBzzb06Uy/sSX71TLXB1HhW0kA1cbzJbkYyIRZQbOvh
 Xuo9k5taLtGsdO9T1/FCrGlb1h+0cxaBHQsVqiUUFOd7iD+0qYKf8KZXrLz+3zIFtYF3uZptNSa
 6mcKcw==
X-Received: by 2002:a17:907:6ea7:b0:b9b:207c:f7ba with SMTP id
 a640c23a62f3a-b9d724ef918mr318719466b.4.1775862167571; Fri, 10 Apr 2026
 16:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
 <20260404152640.3297713-6-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260404152640.3297713-6-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Apr 2026 17:02:35 -0600
X-Gm-Features: AQROBzBZSw8aS4305VetZfAbEY6eX8bMXrwbuI2RWaORxwrh1FViSQvID1YlXTI
Message-ID: <CAFLszTg_d7OVGVjASap9j0=z9D65VMCC98nqkP_0YNzOo+KUqg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] test: cmd: part: add UUID lookup tests
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Tom Rini <trini@konsulko.com>
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

On 2026-04-04T15:23:27, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> test: cmd: part: add UUID lookup tests
>
> Extend the 'part' command unit tests to include partition lookup via
> UUID.
>
> This ensures that the 'number', 'start', and 'size' subcommands
> consistently handle UUIDs as partition identifiers, maintaining
> parity with the name-based lookup functionality.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> test/cmd/part.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

You can combine your run_command() and ut_assert() calls in some
cases. Also use definite values where you can, e.g. ut_asserteq(1,
ret)

Reviewed-by: Simon Glass <sjg@chromium.org>
