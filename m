Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E14DE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1513A801F5;
	Thu,  9 Jan 2025 13:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eHWiih8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76009801FD; Thu,  9 Jan 2025 13:35:34 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338588005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso1447685a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736426131; x=1737030931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j76tn9yjyvxC5UC/9+2iqKV9PqWXvZQ302SKLTu7YFI=;
 b=eHWiih8UPlV+Z9KlrQpkctm1yZZ1YfY2Db9zPcCkBvwVaMWpmDMVTWQsAHPm8lmo0B
 WI/fAfjW6slbW6BifJzcBXUSHPxLLEJ/2EBdqRhosx4DqyXz5+to23FYSzQ8VjYKg0Mc
 o6qce+ozwxYh0r2UwnNnii69MSzFQbdIqzLfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736426131; x=1737030931;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j76tn9yjyvxC5UC/9+2iqKV9PqWXvZQ302SKLTu7YFI=;
 b=KVFUfpCMZeq50fOhe/1S/4ZBT6XkpwUXVLfYf3PWBPuwkZiLSul9tOtb0nx8BWbg9e
 Z34Noa+qFYpOwBUtsAvviX8mKYhvleFGm5uiqFI5cBkKSZyPoem4JZih/Uxnps0f19GH
 8JlIzFe83YYEcSREFvP2ykGg6FFLe36PdYTUSgzpr4uFRuyjg9mi4ZPl8pnx8ZSQ4G/R
 H85YW9QXSE0FIx7NJjtcbtSQbNVmr1gSd78990GYimMpDJR6m6uyFTuR+3nzCptOejdq
 gSI8mA8R/QL3wgqlbirpGcHTwyMpXjQJtAzF7yj8c7fh16la2EcS3Y//DlWyRKqfQp5U
 +Kmg==
X-Gm-Message-State: AOJu0YzlBbVcioVZUM1Ue1rmnW3ovBMx7kqi1MalaModisNSWttWLfGr
 OkySMsFTUe0zorDDDfLOmz9SRtVQblJ/i4zOaNrpYTdQHCbz1+f2iGbudn4/8GtBdb4uni4y2/5
 /NjVvKpSoBF8GrvoItxflVMt9rWrRydaTD7s6
X-Gm-Gg: ASbGncujxzlJCmdQJNxqp3PWlpEACmn5GbLQ/LMJeJh5K1FTgnn3rPhRSfHOMr1h/cr
 gvgDitnvuF/uG4aJEvVzykcLlhqFJwvQCcoiz3gY=
X-Google-Smtp-Source: AGHT+IFeop5PKRqIGtM6SLxj37SbaymLwjwnUY0p378QnAmGROVwTZpumhXMUTR83fMmxLV+iDIhrgKpWdxAAR/9Jc8=
X-Received: by 2002:a05:6402:2355:b0:5d9:a55:4307 with SMTP id
 4fb4d7f45d1cf-5d972e4eeabmr6056955a12.22.1736426131527; Thu, 09 Jan 2025
 04:35:31 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 05:35:20 -0700
X-Gm-Features: AbW1kvYK_l77_hwtEYrOvBS_ObntxpOcqf5Yk5cLed2W18Vz7ZLcQPGgS15CrhQ
Message-ID: <CAFLszTiT59PBvpxtpwMXcX3f-dbAfkZ=2xW=bHm6LrGAAe_TrQ@mail.gmail.com>
Subject: Purpose of 'localboot'
To: syslinux@syslinux.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

The documentation on this feature[1] doesn't quite explain how the
system should actually do a localboot. Is this for BIOS / x86 only?
There was a recent discussion about this on the U-Boot mailing
list[2].

Is someone able to help with how / if this should be implemented in U-Boot?

Regards,
Simon

[1] https://wiki.syslinux.org/wiki/index.php?title=SYSLINUX#LOCALBOOT_type
[2] https://patchwork.ozlabs.org/project/uboot/patch/20241220040120.3245610-5-sjg@chromium.org/
