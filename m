Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7DDC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 19:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1C4805C3;
	Mon, 24 Feb 2025 20:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RKejoTox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8A1807B1; Mon, 24 Feb 2025 20:54:13 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EA080017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 20:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso30117005e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 11:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740426851; x=1741031651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JDKHSE6ZfR8soxKP8JY1D+MdXuWHpGO3JPz0sJdX1RQ=;
 b=RKejoToxShFhUpw0PA4LGZvKeyecitcHgDUuyfXLY+EKiMY9FBfgYVfT/ipuKTPw/M
 yJDgzN9W3wQy7JBLcmhnG8G95TooLJqM0ZtTcI4HYDMb1SHUmwheSvGb8TUFqDGoAWyA
 dkO2O/Ww2s+c9NqWvF456PpM4BOHSvhf8kgqL/sc6yE4B78DEInkjBXU+bfo7Ii0Yq5i
 9VK9G1B9+/iQnjSQrct5csiIxQgR+Jzg1qFGhW1bhoOBtQI/XAclKvkUIiC3shs1s4pD
 sDVLZn7N1z4eOcw2c1gtK/Pge2e4RKdX9X+/1byfZypD+ljJBLg9yZ7g0x3PvmOM0ezO
 +gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740426851; x=1741031651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDKHSE6ZfR8soxKP8JY1D+MdXuWHpGO3JPz0sJdX1RQ=;
 b=Gvt+dT1a7mc4hgfLVHDXZNoCfQbPedPnSOLOKyagwgYwcbYLImRlYPC1iD2rcdUaRC
 KwG3FEu6tRv1geaGZnmIN+n8LnW7VylmiDpgZp2MulMEzqsVkuwZflICGuq0nM0pM3sC
 Q0arPC69wuYZUFWRybet0rKp6Atbnb0VbpZM4Ta9Eb4tvCXJaUMLnwtIxEp9bggGPc3X
 XE2qPF3qewIdrwMNsZKY3T7l0lmLMiitc8PG8MMhUxScqo8thKb4m+ypsUHuEe2fe/b3
 FN9Q5pDd+PigRaMx0638XtYkvKkwXBQFTbptVQ1vAQ+lRQ8jFEuM6j99lq8W4BDvXQkN
 6bkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfqtzN/tIl1ZTIs1hNVntJvVDhgc7JONZLEKfXKAh0Xstx+mZ31GKLZRJzhGNIFA8a1noG8yw=@lists.denx.de
X-Gm-Message-State: AOJu0YwojpEzj9B3OgMf41fM1n0h+Y7oD1YP44WYbJoBQpJoE88Gq2wf
 MXWIUfsRisBcvICTtUheJ+QG8wqNM9SWgAewo0hwKDkxC5XdUK/Eb1SPCG7hg/Y=
X-Gm-Gg: ASbGnctpWz+6k6O/m6Ak09lgH/huDwJYOFvw6nG3EIKiSZlXLaPsh2rNFG5MhKyIqcs
 +EbzAxxYO4ckluMGOV6T6LwooqFU+ZvLDbx5Wq/oFZb6xBMFR6AefVIuETM9CC98nqHMUaq0FjS
 55ffZqH7hhxJws74TsYRBHDgWtiYfZEQb+059Il4tVM188Um+6L4nRZ7eRSmMQncHDee4bCBhG+
 0OYV1BbVd0qG5849XX2krZVddl+FJUJhBanKXzL0/gSJUY8nKp4e8i4GD+oy+MoJZz+bmWYCaaW
 FJDH0v550nLCBvFMFUADWlVw/lQaUYy7xh72oXbGIxdfJr0=
X-Google-Smtp-Source: AGHT+IFWjEkA/GbJ5vuUamwOu8pCrHw410vr9a61+YuDcrwRMY/vn0b6/gHzxnGCb0ufFQq0geX14Q==
X-Received: by 2002:a5d:59a3:0:b0:38d:e15e:17e9 with SMTP id
 ffacd0b85a97d-38f6f0b2161mr16193983f8f.35.1740426850894; 
 Mon, 24 Feb 2025 11:54:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b03675dfsm115992285e9.29.2025.02.24.11.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:54:10 -0800 (PST)
From: neil.armstrong@linaro.org
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] arm: meson: extend sm calls to support Amlogic
 chip_id v1, v2
Date: Mon, 24 Feb 2025 20:54:06 +0100
Message-Id: <20250224195406.748700-1-neil.armstrong@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Mon, 10 Feb 2025 20:50:13 +0300, Evgeny Bachinin wrote:
> The Amlogic Meson SoC secure monitor (TF-A) handles a call (0x82000044)
> to retrieve a chip_id from eFuse OTP data [1].
> 
> Previously, this sm call (0x82000044) was used to retrieve just unique
> SoC number [2] (a.k.a. SoC "serial" [3]), identifying particular die.
> This SoC serial, stored in the eFuse, is always 12 bytes long.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/3] arm: meson: unify type being used for socinfo
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/bcacf50d9defd49f12335866570fb41753bc9dc7
[2/3] arm: meson: sm: get rid of SM_CHIP_ID_SIZE
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a64a4149e39b574bb8d550da1356209caa75274e
[3/3] arch: arm: meson: support Amlogic chip_id v1 and v2
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f6b4f91117984a3ecba486f728b9619e75f06d52

-- 
Neil
