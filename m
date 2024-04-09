Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B087CCD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 13:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A1BE879E2;
	Tue,  9 Apr 2024 15:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ms+csGYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F79787FBF; Tue,  9 Apr 2024 15:56:04 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6288887E86
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 15:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a46ea03c2a5so938889966b.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670956; x=1713275756; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ol8FHjgOvg5909rzUtg0MZ2pEFXXhfdpW4w/MWR8IX8=;
 b=Ms+csGYVDJRKNIOAkFBBL/aUSIvmzpn0QIAQj7+1I/yQIzVCfI5/EQYKh7sx8kgq+R
 w7vpLMUdAsAjQpN1wTD33EEncOZAJIIoqdr79DMut/AOHJuXVkD9ynMEjEfARreCbYN9
 hmv8f18RjBQbM1oVRDOOOW4tyABCzPOAK4WgU5QhUTWCgTMy4Pu3iGqxrpvOJ1qOj+al
 03656dMrZH/HYH8eVHLZg34kR28pSWS1v6k+I7LYmsO6drekP6Oi2uJBPjupI9dNisvB
 fU63R8ETCe0F/qpplm/FgZHJ16/VljOggeTJCyKrwdUxR0d4jnSr2T02/dBbwmDXP+NW
 8XGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670956; x=1713275756;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ol8FHjgOvg5909rzUtg0MZ2pEFXXhfdpW4w/MWR8IX8=;
 b=TthAtNXt5hZSkqDRXtn1Z22nYMFybS0U05KYgaOD4bH6GUxqhTgsd7OSE77bo5USSQ
 dZhsYXLGJq3hIVl7EqNX1wUQhYfI00mHsVdv67MZYpSoAW8y2swEhOUTMrAnpNsxMS3x
 qRWlhfanrKsguGS8M0kUsYeyZ6IHbcInSnxV8ajKqQrnSoKxK6YP0ddirdI0qHda6OuC
 dJ+YEDqSjlMJuZDr+nLMvZi7t1FIWlALRiNPctVC/CaVTuXM2Jvfr87ICE2I8yYyWWNm
 1VoZx97lgFMvPpR9129qrHB+JfddvV9OQha5RqquHxRhZ/MbdLU5dkjzo+ZeMvh9ifHw
 qlYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcYGJxcfB4uLWuUrNPvluodYUutZlSk/4/B/bH2m4GHOdpQEsR8LptVmanOx/DON7cx1LmfslwDJ3AOnHfwsLVI2DoBQ==
X-Gm-Message-State: AOJu0YxGE6up5eLlnHg8Le/TgDfgnaGwwNx7dI4etsiPmk9On6Fk2pyS
 CCD8ygNKg1b+PQ/ee10hgk6LDuzQI1+GiEs4rOLXqXaYQp1LQ3Hxtwdqu7S98lQ4So2+K4hwufb
 9
X-Google-Smtp-Source: AGHT+IGw3ugxuIT81Jq77/NKMOultxkeJOY0ffDF2CBQPRPGLnpOblJfaRyRozn+4OUmsqXYRZntvg==
X-Received: by 2002:a17:906:37d5:b0:a51:985d:949e with SMTP id
 o21-20020a17090637d500b00a51985d949emr2524538ejc.2.1712670955817; 
 Tue, 09 Apr 2024 06:55:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a1709067c0100b00a46aac377e8sm5720612ejo.54.2024.04.09.06.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 06:55:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] qcom: capsule update prep (DFU scsi + GPT part type flags)
Date: Tue, 09 Apr 2024 15:55:51 +0200
Message-Id: <20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOdIFWYC/x3MMQqAMAxA0auUzAaqFCVeRRzUppqlSoMilN7d4
 viG/zMoJ2GF0WRI/IjKGSvaxsB2LHFnFF8Nne2cdZZwdejDjbqpIHnX2xCIBuqhFlfiIO9/m+Z
 SPuDGc3pdAAAA
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=elBZjamn5BzarEP1pWrBFHW5++Xjm9e4xrUfyQ6BqVo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFUjq8HZaEcf3jXlgMcWmt/RCfO6x5KSz6Mu6v
 97RQeWm632JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhVI6gAKCRAFgzErGV9k
 tmbND/9BEEDsXlYRq5jTNKQZdC8QJBw5ucAf5nSRrQAurk2J2tu5xlswDxyZLyRts3QOLsQRn4h
 osnj9usxHvQyt2lcyZHZpXfQW96po83MBfOJFfDcMqflgHGicLevAK9JLX1j1Z5h+DhyBAtOyaX
 CN7Ekmnvg3MIMBy5kIhloI/bCT3N+kbeKNG5S1uVJx/MIm7Zk+19/A2p4mbxk99D9VpWjB6HbIH
 Fg9pfnOJoR1g/YjJT5Qv+9EqcMNVb9T99inEsoQ9fNXhZe9F2gZO0jPafCqRiBbWgG9KB513LVe
 KDtYuaU2qKDRgvC8UWGrBgh8vd5MiLskrxJhyOtmM7KD6hP8f0FikSbQQuBb5V3ssxDJ580pp81
 9lymcPZvdR65sBwj6L2rxouvaE7vaLydotVR6Ic3Bc7fCEfDkwRhIk0NGQpQ4Bd2+GuoL/ymH3n
 pvQM9X9ziGgC2Rfb0PHR17mMcDA/BsKJb4LZQ/9ZgXUx0BxiJUPZdYOu19qwaRM4teG/x3zTMfq
 dnamWJHeZX0ZO6g4IEtQzB4TjHo/DyjOFtyeQs8kn0HgQW2bJLwS96lCcXZvVa4tbGhoxDn0oW0
 LWZOWKqdB6alhaUI+r82pXUXr+kjYyn3eZq3P4LwxyPP1zkEW9dItwCtG3KJ5UogXb7YGfJzBqk
 3l54QMk561wPu1Q==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This series adds two missing features necessary for Capsule updates to
work on Qualcomm platforms.

It introduces a DFU SCSI backend, necessary to support capsule updates
on devices with UFS storage.

It also adjusts the partition framework to export the GPT vendor
attribute bits for each partition. These bits are used on Qualcomm
Android and IoT platforms to encode the A/B slot data. They are used on
Chromebooks for roughly the same purpose but with an entirely
incompatible encoding.

---
Caleb Connolly (2):
      dfu: add scsi backend
      disk: expose partition type flags

 disk/part_efi.c        |   1 +
 doc/usage/dfu.rst      |  31 ++++
 drivers/dfu/Kconfig    |   7 +
 drivers/dfu/Makefile   |   1 +
 drivers/dfu/dfu.c      |   5 +-
 drivers/dfu/dfu_scsi.c | 437 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/dfu.h          |  26 +++
 include/part.h         |   1 +
 8 files changed, 508 insertions(+), 1 deletion(-)
---
change-id: 20240409-b4-dfu-scsi-9d460ff99796
base-commit: a96a91644cdd9d58596908edc38b5d934d99fc34

Caleb Connolly <caleb.connolly@linaro.org>

