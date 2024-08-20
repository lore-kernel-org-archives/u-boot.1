Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB0DC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 09:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E54688A25;
	Tue, 20 Aug 2024 11:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ldJIUXqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2726888A2D; Tue, 20 Aug 2024 11:12:35 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F94588A21
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 11:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sahaj.sarup@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3718acbc87fso2778074f8f.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724145152; x=1724749952; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=34wlg47zP+Qt4mXgBXUkEa4u5BiUkBsKvBWFoYO4/hQ=;
 b=ldJIUXqv4GjZF0ikkxWkGX4LQnQVtK2Q+kCtfJL+9++gehTClRssynprOuL85INLku
 lZ9FZPfEcHz4IVLQpwmyUFoQ85e63UCBrgow1++7yG8lr7xVrVqz21mSKkc/t8pnQxUJ
 vv+/rFEKOTN+oIzbSv7ZXGTIt7mq40cWXGO5SPCYUbnD3Yqy8Zt/ITXLp6iVuq2p4h2G
 TlsTulD7njldlHtlBzwqzu6M+/yUcvVVen9xDK+l47LDO39o3U0jyE9CVrQghCUwEvnS
 DgmU4Wvc+itbbVfWMPmqNoE0YPlLEdMrl6OJTDH3v7SMibPHGTF2ji4NyA4u2X1DysQi
 FZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724145152; x=1724749952;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=34wlg47zP+Qt4mXgBXUkEa4u5BiUkBsKvBWFoYO4/hQ=;
 b=Y9RpVMYsT7pToChJB7TgT+J3jvj4iXLCgGu8JlFrhz0IC3woRMUw49ZpIn13xcH+pf
 r446rgJHpUJewPF5vNfsV0PRsmR44eLR7ktGWeZaUZvXkoAbKZwiAzZ7q9JxvEusb23e
 wDkTEmP3HjI6C/qCMWDspBYN0iVxL+Jjsdcgc35w7uLtoZQ9DRGz74kY7CHBNqfFWgfP
 NLgSiuZUOY6SHvaeINUl4hlZdfmEV6KcWPoecOpBe3powZqjqNy8gioRWeoy7C9K9702
 is4dQJxcTV8GggHeIVz+kjT1FSKXXfQtvBN1LayqF/W6FeYuhKQ+82VBBKrtgOrCkf1a
 WZew==
X-Gm-Message-State: AOJu0YzYKqg/SOpgBI+2dJYagZiHviBSrmsGbC8AUI3U7hW81OAR5LWa
 4fqxSXjJg3MVj5eVZvGiYxfS/8KmGkEmvyLC/2R1CygwH4B0X0Jt/4683BMS3Y5vzg8l9xgYadl
 8EclAV0wwumGrUQMlYLtUFoXLDEpNQs7JxJ+/sWhDRljIglpQA7Wp1Q==
X-Google-Smtp-Source: AGHT+IEg8/sm/uqvaFQVaD8PcxpGCR4znypMpoyAqTb2XaY4C+KPAltAbYMV4Z6FHnrDI+JNEOhRxI8CR3y030q9omo=
X-Received: by 2002:a05:6000:1b01:b0:371:8f19:bff0 with SMTP id
 ffacd0b85a97d-3719445235amr7086891f8f.20.1724145151867; Tue, 20 Aug 2024
 02:12:31 -0700 (PDT)
MIME-Version: 1.0
From: Sahaj Sarup <sahaj.sarup@linaro.org>
Date: Tue, 20 Aug 2024 14:42:20 +0530
Message-ID: <CAKZ1LvNcW7y0SnHwye98m1UrL53cqsErtKjFbGp0z+doiU+9aw@mail.gmail.com>
Subject: clarifying i2c_get_chip_for_busnum()
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

In `include/i2c.h` , the udevice pointer and return value definition
seems to be confusing.

```
/**
 * i2c_get_chip_for_busnum() - get a device to use to access a chip on
.
.
.
 * @devp: Returns pointer to new device if found or -ENODEV if not
 * found
 */
```

Should this instead be:

```
 * @devp:   Returns pointer to new device or NULL if not found
 * Return:  0 on success, -ENODEV on failure
```

Thanks!
