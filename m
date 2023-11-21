Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B5BC54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 08:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1E587480;
	Tue, 21 Nov 2023 09:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JghJLEpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E02E8757E; Tue, 21 Nov 2023 09:21:31 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EADBC87480
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3316a4bc37dso2571805f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 00:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700554888; x=1701159688;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7w9nntJszUUJfqvbVtn+CQx+wEuwEvlRB3N/TVUrE4=;
 b=JghJLEpD299TXMpZYkzLgWa/58t87bUkhOKGxE75bNzWxUPke4Ex8u/qaXG7rPERZv
 wG2L3LZJ3hoURWtpsw/BT6/EaXqVv5apDTBQ9Ly9iyS47+AiyjZ/y69gWX1gbKPvkry6
 7Dtkmk0KrPlm8a2wIB2+ZsuywEQ1hbVi9HkcvmZ0qCcAAx3aCRfO9B1h8UhR/GE5CzsM
 D6AAvHk+zr2ynevtEXJqqCrdjiGusDdDs/RYrk78rknQ6VzLssey4dV1jNEFxP+PvUTF
 9xaAa0eVupalBdMtA8aCkyz5UOuSDLmYiIkMBORVU/w2VUiW1oDYo7cnkGijzbGSVwmm
 QxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700554888; x=1701159688;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7w9nntJszUUJfqvbVtn+CQx+wEuwEvlRB3N/TVUrE4=;
 b=lmgdCQ9QAfEpX6yuVL4khlk+ZFHtjV2ae9aoI5AlAc5SvfvV7njw6elaElGAPmZ7ke
 61QdHSlzpYwTklyqXnWQE3p3UB1Ae/mTHlYxLW7uZHefpVT+AV7GuDPpHwJ3OBSpb756
 MpjDWKQKUiXrX4LA52tOaZ+YQ4qt/r0K9ESvsGdJJd20Ii/y/pg6IJGBy5XFRIyHL3W3
 QVMVZgNqnWjYfwwlJdBIoRYifeeW0LYstj5dq8JnWYT0XmIz5D1X9e+5occIhuyAjROx
 I9veR0EXDx3lKP0yY5nUKJr81/l3MWiOUdc3E80ck782wCdGZfBfM7bk/xE6/2BpV8wk
 jymA==
X-Gm-Message-State: AOJu0YxX0lspL9ZsGUQU9i6Rjr+EzPej+NmMZgA2hja9dYQF/9SzZPLY
 NJo2IXlzRzkNdtsdC87gISBkaWzPpjBLtfq/cGo=
X-Google-Smtp-Source: AGHT+IGAmNUXydFSduwjHyknAcH3btPt4Vry5E+/9qKiuiF7cneAN8Q6jj0l6Qdba1K1dQVqSwQtgw==
X-Received: by 2002:a5d:6d0b:0:b0:332:c9e3:a006 with SMTP id
 e11-20020a5d6d0b000000b00332c9e3a006mr3399280wrq.63.1700554888402; 
 Tue, 21 Nov 2023 00:21:28 -0800 (PST)
Received: from [192.168.2.81] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a5d4004000000b003316b3d69b3sm12870972wrp.46.2023.11.21.00.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 00:21:28 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Simon Holesch <simon@holesch.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20231120002024.32865-1-simon@holesch.de>
References: <20231120002024.32865-1-simon@holesch.de>
Subject: Re: [PATCH v2 1/2] usb: ci: Fix gadget reinit
Message-Id: <170055488746.398010.3402572350724276277.b4-ty@baylibre.com>
Date: Tue, 21 Nov 2023 09:21:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4-dev-6aa5d
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

On Mon, 20 Nov 2023 01:08:34 +0100, Simon Holesch wrote:
> The ChipIdea device controller wasn't properly cleaned up when disabled.
> So enabling it again left it in a broken state. The problem occurred for
> example when the host unbinds the driver and binds it again.
> 
> During the first setup, when the out request is queued, the endpoint is
> primed (`epprime`). If the endpoint is then disabled, it stayed primed
> with the initial buffer. So after the endpoint is re-enabled, the device
> controller and device driver were out of sync: the new out request was
> in the driver queue head, yet not submitted, but the "complete" function
> was still called, since the endpoint was primed with the old buffer.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] usb: ci: Fix gadget reinit
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b272c87925025a44ad6ff851711c68847a4cff4a
[2/2] usb: fastboot: Add missing newline in pr_err
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6f68dcd0259f9f1c03f097669e9490b13b5325c7

--
Mattijs
