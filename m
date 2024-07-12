Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C18CC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 11:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659E588667;
	Fri, 12 Jul 2024 13:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZhqUZck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1150588709; Fri, 12 Jul 2024 13:36:47 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACB387FCD
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 13:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5957040e32aso1202256a12.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720784204; x=1721389004; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5/vB3vKIp9tLt/h+phDG+MHJZg5VaBOcVQsOlqV3/QM=;
 b=QZhqUZckX8XlWdUT6Q0HeJ7BnoLyA6VD4TMJr+qXTRM0TMpGSEZ8VTT7VGpiff7dE6
 lgBkwwM+bnn6+Apz0rzoh+llbPDRaRstWatDE6Az7ceUUBTvHaT+sl1Uyu1xTsPR9if0
 VMzvqJ4B9MFbi/lFU//geLTjmnVh+mVnl44i0T3UaQTGf8RIK17XOSZ6IJF5+uPZGmvI
 fIyLHXErqQ7muWXtQ1NrWdfSV1VqIojY197/G/fA5ypKZOnLCtjZ54/HciMT8mHsOvfi
 WEJh4PC2srHFVNneQNWu6k0qxDYT+GKkVamGR4l+TwAbZZhHV8ksuej277kALbgxtxbs
 CPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720784204; x=1721389004;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5/vB3vKIp9tLt/h+phDG+MHJZg5VaBOcVQsOlqV3/QM=;
 b=XL7hzSZF4IliVKAwl48FngRNr2U9bWqtKhC+53hRbtb8iEka0QafdtA3fvqxrzZdad
 hZMNQvehFfLbpctRnt2CNR3vHgs8RZh8g/eb6exuPaaYptCOK/9/byn9lQ5HieJyKEi4
 ORF4K0TSNX6ulxNKmi1M6+EsBSmvH5c61HDMGCPbzGHSrI/mwaCq4RMgRwghfLgscEcH
 NoTCP+e8RZP7SgFA+OV4yqPIMScYuRlZOZtLDhnREem6QSrmOeKZP+gJQrOMxObCN2PI
 /TXRfKIULlG9I4DFKNvuvHXJpB2zCwknChlAkRgOKq7pJAvKyn2/ACPetf/Vxq2JyFJt
 nYuA==
X-Gm-Message-State: AOJu0YyvCs5M6uof+8HNHC9zTJ9GNh2ZGJZ98Qh9KpLim/ODZyyyaJNO
 G3ogtGhuZDAKoN2tKI2JBjxMaxndJPSyyX5fRHqyG4/2F21R0CWmQuB2CdHYViLbDlolS5co5p3
 J9Z0Fy9Dk3f0uFSf0ipnz/aFak1cgDdXw
X-Google-Smtp-Source: AGHT+IHW1Iy8RdYcepv/JhwgNvw9FSYEz5sGnEUpS4mhkKjm+EFRI5VVdXL7l/R5TcW2F4fdorWE5cz1PRxemU8gZoM=
X-Received: by 2002:a05:6402:1a2f:b0:57c:71ca:f651 with SMTP id
 4fb4d7f45d1cf-594bb67f240mr8618775a12.20.1720784204199; Fri, 12 Jul 2024
 04:36:44 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 12 Jul 2024 12:36:32 +0100
Message-ID: <CALeDE9MOQ=G9r9We04-_1KVB7EvawCWi2DH1Yz6wMVTRp+FejQ@mail.gmail.com>
Subject: Pull request: rpi-2024.10 rc1
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, mbrugger@suse.com
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

Hi Tom,

Please pull the updates for the Raspberry Pi:

Updates for RPi for 2024.10:
- board: rpi: remove leftover CONFIG_HW_WATCHDOG block
- arm: bcm283x: remove unused empty hw_watchdog_disable
- board: raspberrypi: Fix format specifier for printing rev_scheme
- Revert "arm: dts: bcm283x: Add minimal smbios information"

The following changes since commit 3f772959501c99fbe5aa0b22a36efe3478d1ae1c

are available in the Git repository at:

https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2024.10-rc1
