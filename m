Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0497E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAEC80361;
	Wed, 11 Dec 2024 17:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KC0Uqfsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1568B80362; Wed, 11 Dec 2024 17:08:06 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C8C80323
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3ea065b79so6084209a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733933283; x=1734538083; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NzpkmcdW539+9XQz/Ewp4al3IB9LMp9b+3nHEiX3JFs=;
 b=KC0UqfshOIBt8hvNV2C8tsr5Z6/+Tx2q6Crl3CDijJvIDybA352Bw5HE6zmlCWzlbw
 yDIhAfOTyNO+5AMU+jNLfURxw3E9CSU7WWmGJlUgbZUMIjAJ15DJCUQHyarzUduVj1Hx
 g5aTtTH2fy48Vtd2E0UpmKRUdSJcNOaYhKBSLm4Im3S01EhbsmTT9wgjYj7MxOXuCLo2
 BmLJXhC44DBOxtuXtu0cPb5xhWVo6WYUTZyWUzOgo0S0WRhzeoiBs7acau3XuPfB2P60
 GrrRIcIb0TPJ0+NfM+8lcvqkkntYVURdTynbF+yHm4PpK2VU8Ivwr/GsgMhQAyI0GVrX
 Yk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933283; x=1734538083;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NzpkmcdW539+9XQz/Ewp4al3IB9LMp9b+3nHEiX3JFs=;
 b=U4T3QFawAKlYdumSgPIp2MLYQcDmxDWWi6fTd2KE9H04arCMs/CRycnu0gktsJ3EZu
 jJYolbitZQW7SmwHBGXx5ByYiAt7b9frUoIAumKfI3FipnW+UDnzViFYcSrNu0R3hEGZ
 6qUGttgK9//7v/3iY+sIed0+qZ2K0kbH+/4zje6dmvhLKNZskKt8Tqmr6aFcpWYMWxMX
 L5o8sZREp4Gaz9JxHU2OopDY6hjB6TsNmZzrAkoUtwrLWya+olSdQX3TJkQTJcGzp6gD
 14GdN8TuDnkP8Jgb2fDnd7t/NQiV1A4Js2uFhgwYB7RUHykWcR1+SPAwmQc/au6UT60S
 Nruw==
X-Gm-Message-State: AOJu0YwnWpCVwaQNHTT+6LYIgUusEJpDk2/O7DdbhWD6/ns1Avbdiaf3
 OCRT6j0L2Sq2+J7+emLRe9r7Fnr7F1xcmAcJcaJGtA057dpRmn6Pwd84kWRJlO5X1yz6+4hI/qR
 mHV0lHNcixi3XpCCQ66MNecJBB2DmLn71
X-Gm-Gg: ASbGncuex2GAQN6GObv2t3galR+tpH22VbLPpMT/NUVwMo7MvpDC/1mGOSIur/lrqj0
 /OH4Y7XH0aRBZoufNbaKLn2t5SaJaBXjcyz4=
X-Google-Smtp-Source: AGHT+IGE7lxR7kRXaCZGiesz4ujVlXNVUUCmai+IzxnV8k6TFJuHaS7IWv2+rzONYq/EU+yNt5qLTpUOV8NIaL+g73A=
X-Received: by 2002:a05:6402:510d:b0:5cf:bb9e:cca7 with SMTP id
 4fb4d7f45d1cf-5d43316bfdfmr3397910a12.28.1733933282829; Wed, 11 Dec 2024
 08:08:02 -0800 (PST)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Dec 2024 16:07:51 +0000
Message-ID: <CALeDE9Nr0gDo0FFp9YJy7bWoxM-4mEq7pCAFcZnJqgVwk9dUBw@mail.gmail.com>
Subject: [GIT PULL] rpi: updates for v2025.01
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

The following changes since commit: b841e559cd26ffcb20f22e8ee75debed9616c002

   Prepare v2025.01-rc4

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2025.01-rc5

for you to fetch changes up to 6a5fc32fd20b5e5367fda9a75f0e8de1a4b76649

Updates for RPi for 2025.01:
- Enable capsule updates
- Pass CMA through from firmware DT
