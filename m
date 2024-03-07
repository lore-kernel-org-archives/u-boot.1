Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64659C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 21:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8192287A00;
	Thu,  7 Mar 2024 22:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bpe7ZfzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B8FB878E2; Thu,  7 Mar 2024 22:00:03 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0DF87D26
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 21:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a44cdb2d3a6so209613666b.2
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 12:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709845198; x=1710449998; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uQPxx9sM5o4f8njEGH6PDqaunHyk4pnKtw7ZIIYBJjI=;
 b=Bpe7ZfzR/pP+gpSCSjQ2oVaGS2mnXldB+eTK1XO3dVroU2ebU7IowitUXFb3P/2M94
 xel1Byxt+dOG8XdIIeDTDR4zhFvkX35tnEXuBV+iaq9xwetXhlLrr3LLjKxO5zk+22jT
 1j+9q5eV4wGqJrfbOBLfp/ylzVqYRYO9F2Sk2gbysqoTODuud71IRav1MXlw9EH4tb+B
 lR4BcR7SZtBqtBRzEoNX/CrvMnzVpFr1CY1TlAykFD0/BOPSCwDR5PSlNP4gYjY5xWOZ
 HayjWaf1c/gdz6j6LYVJaR9G3c+fhJkI7B5fTnd5eDL36LrwISHStdAjYCf4Zs48frxR
 nYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709845198; x=1710449998;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uQPxx9sM5o4f8njEGH6PDqaunHyk4pnKtw7ZIIYBJjI=;
 b=m/qOeD21IjYQkE8ym0AMc/MPU51bDEeao6B5nwabIqLuavi+Zpt5DoIE503igZG/l7
 /wTzMmuupDIxwlYAKoAL1dAGc8Ny3wr8uAcOF4Cxv47xSIOgxvwVThKAzOAHPEHmxrr0
 86xV7mxPaW2LbMNvE6QheLcae0fN1+HnYI1O9hboexLWwICgaP2x5ETFqzITT6N2foAT
 zQrnjbR0o1URrpwXeRuweYI1k96bQNAPRVOv09A4WgxoK3w6k5zG4F/nV85wpqSClk2v
 0loO41SYGsSJ5GrI9bXcKnQNWEIZ2Z+Wf5lBhyWZFO7skC6uj79acxCxjH7pO3F1tQYK
 25pg==
X-Gm-Message-State: AOJu0Yyndr1CsylmY5GRXgQKFWi1kHiGQYps+Pc/re1evuiLnjevVjlL
 KftjD9/855GgXp6ktp+NcgCaBEV1s02f7bMoze6YtwSvEru6NYee8xXVx0Dm2PqBwFQkIYXpn4k
 Y2f0iwnJLDdT5HZeph71macLKdNKrXZSXDfBXNw==
X-Google-Smtp-Source: AGHT+IEuPjIuPAL3s4vifxN3KGOFn6G8B3PYywbmHVH+XwBCa9+FgFcaulXnvL40tLcEEC3Kql+ogDYiTr3ya+UovYQ=
X-Received: by 2002:a17:906:1cd5:b0:a44:15c3:c8e9 with SMTP id
 i21-20020a1709061cd500b00a4415c3c8e9mr14931804ejh.28.1709845198423; Thu, 07
 Mar 2024 12:59:58 -0800 (PST)
MIME-Version: 1.0
From: Mario Marietto <marietto2008@gmail.com>
Date: Thu, 7 Mar 2024 21:59:21 +0100
Message-ID: <CA+1FSihnKNv3j12BgrHcmsEtkgQbKDf3eaoPmyo3ovLD0H_q8Q@mail.gmail.com>
Subject: How to add the bootargs parameter between the bootcmds parameters
To: u-boot@lists.denx.de
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

Hello to everyone.

These days I'm playing with my old ARM Chromebook model "SNOW". As you
probably know,this kind of Netbook can load an external operating system
using the sd card slot or the usb port. Unfortunately,my Chromebook has the
sd card slot broken. So,what I want to do is to load Linux using the usb
port. I've bought one converter from sd card to usb and I've installed
Devuan 5 on the sd card ; I have inserted the sd card inside the adapter
and would like to boot Linux (Devuan 5) through it. The u-boot version that
I have installed is special because the code contains the patches needed to
enable kvm. You should also know that the parameters to boot Linux are
embedded inside the code,as you can see below :

https://github.com/virtualopensystems/u-boot/blob/eecfeb578e296ef3b739ac918a39b6c177dff58a/include/configs/snow.h#L101

now. I've tried many times to recompile it,trying to change the root device
from /dev/mmcblk1p4 to /dev/sda4,because sda4 is the root device
now,because the Linux files are stored on the sd card,partition 4,but I
failed every time. Now I want to use another method to bypass the
"root=/dev/mmcblk1p4"
parameter. This is what I did :

setenv bootcmd "usb start ; usb dev 0 ; ext2load usb 0:3 0x80008000 uImage
; ext2load usb 0:3 0x43000000 exynos5250-snow.dtb ; bootargs console=tty1
root=/dev/sda4 rw rootwait clk_ignore_unused --no-log ; bootm 0x80008000 -
0x43000000"
saveenv
boot

Well,it does not work because despite the fact that I have said to choose
sda4 as the root device,it persists to use mmcblk1p4. This is the message
reported :

waiting for root device /dev/mmcblk1p4
sda attached SCSI removable disk...

I would like to know if I have written the parameters correctly. I don't
see errors. The only problem is that it does not pick sda4.

Let me know,thanks.

-- 
Mario.
