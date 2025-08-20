Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5BECA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 14:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B9A801DD;
	Wed, 20 Aug 2025 16:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AHCt5csT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 154F58211F; Wed, 20 Aug 2025 16:05:24 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927C78003E
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 16:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-323266cdf64so5139030a91.0
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755698720; x=1756303520; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=36o0Dkacq+CyS9LhJWCrlMMDuqPszU3GjMXMwHobevY=;
 b=AHCt5csTP1Ci1GSZ9xnTnxHeLSY7AIm+L7eQlUvRetrhRKbogUXqpR5NfKP/tlWZRf
 NxiWrBRo2Z+CXC1qNAIPg2h9q4zX+gJe96qSnLGu2KSw8Ja0vmOmXXYLpgQny3gayu0d
 Kb8KGK4QZ5If08Se8VbfoAhLZzNpmyN0bbTZ91b7iNMkGq90hSiabiYK6D2YX7GjRQN/
 D6V9mZRUFSvkpDIrM/99WLtpVZ2VtEuetH2qFxJY2wNDAM5fwZZf9xNJ+ensm1LSBYXY
 Ot04ymSVnbChcxJKPUesI4aQJrX/2KhMaErWTqeSATGDOrB2G4t3vSJjfe/wlqprAawA
 tV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755698720; x=1756303520;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=36o0Dkacq+CyS9LhJWCrlMMDuqPszU3GjMXMwHobevY=;
 b=iNy0tTOs3wYLGBOkZB5eaTuWLupnUb2o300u+3TMXn3hkRU9ha6vPOed3QeXbRmVMK
 brtLQ4hBRTTBEKf8AP5Iy4cNVlt5+VSKIvfhOjdi5Bi+8HqV1K23gJ1ANlDYInM+JuKj
 aBrlWKOBqtuzmSPIv26DM/pop/eVk80ZoweHkDokcfLPPUFWpCWSJcbd0LFtHhdVdscX
 IoflCmUlam3l0Wn5EpAwpeKWCq/wdvVlKUR0F3SyBEXQZzOZMGCKDc9S3a1EtukuUsWn
 D0gGJLv7Q/gqbYdNZmkbSENI2vehpeJ80r30RcqyseKcSK7dPpVNBQP5v41jEpwWLJN5
 zHdQ==
X-Gm-Message-State: AOJu0YwfSWbJJiLz/xKfv9JvaGdIqdZqDHugP/Vw6crZ8ycQXtLop4rJ
 c2FI6YD9GBPFuUeMhsFHS14/9LzRenIaeZwVqJ2YncNOQU0jw61zQnIV3uvtkOGRisLvIgDtQNU
 C3/rfE/ccJjsizug80Fmhb2WKZIwzkr46nyTX
X-Gm-Gg: ASbGncvbQYemaN5P/YeabpeFwh3SR8j4ifKkX9ZnzcCDqvLj/gUqJBrGGA7+Ifxaxnd
 8jiznJc77yEw3T8K4ZwIyKXIaVu1cJJNhky2bZJq2i4ESzR4QxyFH5VNAV3tMJWvl5N0CLvPEpc
 R0oeLyMy+3dHmv3THHjI623sK6SI+7P+DCFCL4Vh1F3NmdhPk1rFaxdmtCxihnOqT+VkaXHRQuQ
 ianwwW2
X-Google-Smtp-Source: AGHT+IF6WdSAuUN/6L7CDcLkfofvkoSBxjmlIyRyWEsV9vQigng98fvslf9lMfeWlDniASCOACntJUL3lLU6T1WOV6o=
X-Received: by 2002:a17:90b:3a4f:b0:31e:f3a4:333 with SMTP id
 98e67ed59e1d1-324e1465da1mr3877428a91.26.1755698719162; Wed, 20 Aug 2025
 07:05:19 -0700 (PDT)
MIME-Version: 1.0
From: Mario Marietto <marietto2008@gmail.com>
Date: Wed, 20 Aug 2025 16:04:41 +0200
X-Gm-Features: Ac12FXxrga5UsMUh2IdvcSwhWukABs3A93AxtZqo3kAuBI6mP3uA8hgo4CcAE8s
Message-ID: <CA+1FSijAu7otPPwQLNbTQ+PKuK4Jk-0L5MFtokx1MoQR4+3Khg@mail.gmail.com>
Subject: Trying to boot FreeBSD 14.2 on the KHADAS-EDGE-V with some 4 inches
 HDMI displays....
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

Hello.

I've installed FreeBSD 14.2-RELEASE on both my boards (RockPro64 and Khadas
Edge V),both based on the Rockchip RK3399 and I've used a display that has
a resolution of 720 x 720 resolution and I saw that the screen remains
almost black (almost black (almost because I see a dim illumination coming
from the display) .

I don't even see the u-boot logo. Instead,it is able to turn on my large
HDMI monitor,which has a resolution of 1920x1080 pixels.

Since I'm building a FreeBSD modular phone, I want to use a small HDMI
display with a low resolution.

Later I remembered that I had two displays,stored inside the shelf,that
could be tested,to see if they work with u-boot and the khadas-edge-v. The
first one is a 4 inch display,720x720 from waveshare,the second one is a
480x480 from a Chinese brand. The result that I've got is the same for both
:

https://drive.google.com/file/d/1InM4f4DLcYX8Y3ntERItnhwVuEnmHWeK/view?usp=sharing

What happens is that u-boot is able to show the first stage of messages on
the screen and then it becomes black and it remains black....

What's broken ? How to fix it ? Thanks.

-- 
Mario.
