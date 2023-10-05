Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD711E93709
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 12:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6578386C69;
	Thu,  5 Oct 2023 14:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G8omCfFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A62E86B33; Thu,  5 Oct 2023 12:22:30 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1D786B18
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 12:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stacey.pellegrino@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ae75ece209so151065966b.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696501346; x=1697106146; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LkOdyq7b+ugSHriCyY9KXxCgRbSuEJW9mHQTcn6Yidw=;
 b=G8omCfFbRR/EeS3Cf28VjKcCpmZhvTjZoEsWbDbvHD26am5svuLenBlRO5OPeTEhIl
 A+MoHEs6jLNdzAmx/SV/2VjW5mI1AdhMEbaEXE0F0czHljPKa3irAx+CJ6aVKtAlKrk3
 fFPe/mR6oe7hG+9oErcVvsScGx17MCqe3sf3lLwoNrPvISMZloOnKP8GpFkNVqs2cJLu
 E8Tvr7Aanx+vvHMZJ7SOe7dtDiO/H+shpypse3dxDsQTYSLUQnPkp/cNnozpaHmNOjKD
 I+wN8yOqmKLItim9V+t+8O6Gr1enD0BgtwutqYAd3n9kOyYTHjPkcoudzbVzqk1o5axc
 TPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696501346; x=1697106146;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LkOdyq7b+ugSHriCyY9KXxCgRbSuEJW9mHQTcn6Yidw=;
 b=OT+JIFhvaYoXccoXM1T2WsKFxkbGxqUBIAb5Dt+KO4L0wfpIINCPw8eTrxDtCs0KD2
 h/IQardHytTtbMsxC9MiNp1djMNh5vhw7+UL2M8ML3Df2Ja+xY8wlYWg/iZZ4Gx0GbP4
 PQIJPR4aGG2aeKn0AdyJYtCYUlvAoh64PbThCJHGe6+YwwIrV8oAnQoo1BTUGk031kPE
 itVrP39mriVt1WI8cCGyM+lELXoqOYlvonSau8KWUS98dxN+/W+umm/b6c0xHewShKCS
 t7cdKdgeZb4gpi2CzzqQ7Flx4hsD+ytPNUjuAdYNYpqZtHNr9NtxUsA4fB9IX/t/g4qO
 lueQ==
X-Gm-Message-State: AOJu0YxjdH2lfLRpSa5ig8IMs092l3Xe4mstq3rOboeZ6FT5zPPSZ7iH
 5apsnmozGCnJTMPvP0ZTpT2HQ+1zxot2Xc/sDT0TttoEI7ZcUwAi
X-Google-Smtp-Source: AGHT+IG13VoJXS0kC5I7J/m1f1BmI9EO6mzx6vWw/619RZxEVjsjevRg0QSQcq3jTETQlSCVEyrWSxJ6eLcS5f4RCP8=
X-Received: by 2002:a17:906:8a71:b0:9ae:3d75:4c83 with SMTP id
 hy17-20020a1709068a7100b009ae3d754c83mr3712661ejc.0.1696501345764; Thu, 05
 Oct 2023 03:22:25 -0700 (PDT)
MIME-Version: 1.0
From: Stacey Pellegrino <stacey.pellegrino@gmail.com>
Date: Thu, 5 Oct 2023 11:22:14 +0100
Message-ID: <CAKNxVbNWrLrX=rzb4RONo96AtM+G2NKs_2g28WohgCwVkFstSA@mail.gmail.com>
Subject: ZFS support in custom u-boot build...
To: u-boot@lists.denx.de
Cc: zhao_steven@263.net, wanglimei@orange-pi.onaliyun.com
X-Mailman-Approved-At: Thu, 05 Oct 2023 14:07:47 +0200
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

To all those of concern,

I am in need of help regarding building u-boot with ZFS support for the
Orange Pi 5 Plus.

I have tried working out the following...

https://github.com/u-boot/u-boot/blob/22ad69b7987eb4b10221330661db4427e40174fb/doc/README.zfs

The URL link above specifies using the board specific config file, which
for the Orange Pi 5 Plus is (so I believe)
orangepi-build/userpatches/config-default.conf.
I therefore edited this file in question with CONFIG_CMD_ZFS="yes" and
uncommenting the line install_zfs="yes".

However, it still does not allow me to boot with root ZFS on the NVMe SSD
with the official Orange Pi Debian v12 (Bookwork) ARM image. ZFS does not
seem to be referenced in the custom u-boot source code build output as
well. I followed the build instructions located at the following URL link...

http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_5_Plus#Compile_u-boot

...but am I required to apply a patch to the u-boot source for ZFS support?
If so, then that could be my problem. If a patch is required, then how
would I go about applying this accordingly?

Thank you in advance for help in this matter. Kindest regards, -Stacey
Pellegrino
