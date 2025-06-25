Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E814CC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 17:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC7182E05;
	Wed, 25 Jun 2025 19:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hpdYbQKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E128A82D21; Wed, 25 Jun 2025 16:04:48 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9FD803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuvraj.kernel@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso924847b3a.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750860282; x=1751465082; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LIfOuUbt5yf7vFrZ/c5pViRWluhvEku8n9T0I4Lgtdk=;
 b=hpdYbQKBjgp5fc0QWl5rA8fjGci6jwY1XgbmyMcDRHSkL1E8LXLwo2K/ji5QmuoUCE
 RH6+AsUrvF15MRfGsbe0R9kY3HbE9tz8VZBfWBLezS681BGXSjbUBXhOJRt7nor/ZtCW
 jsb4DwhC70XfZOc/gKMkYAqAhQeNzyuenhlzDfBu3tMsG1xAsCdSHOcpZb2sWpxOjbo+
 UZR9CeXWvbw3QBduY91V30EYpdIB7RGUR+UuUiZiaYAL+OfsUNjJXMoVXto7amlGJHWF
 jpU8BTlS536Pw3f8JPDJA8Ap9DDYcGMwkh9TdMCD9jw8SXDcVRqthzFoOqnRPS9AQLsg
 Abxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750860282; x=1751465082;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LIfOuUbt5yf7vFrZ/c5pViRWluhvEku8n9T0I4Lgtdk=;
 b=ae7+jScyyuFUW5zPyq+smqrmLhtknLfIl9gtNZ+ykQ+LWgLpr2eW4sW8x+lBSir8OF
 90Hkp6MRN5xBGTmfrc8Z+0VaRcb2T50f5EkozsSnryDjfY0QGQY90m4W7uZhJQGmSUnX
 GsYZ33NdaMIAt/7yijrXD9DB1p6WfF7XSwPViKQ0PU2405jfUwvLzmrzAD1Qh+C0G2Rs
 90YVrNnZbRGJqDJcLyAx0v28Hxg+Qwtl52cqqYpTzBQQLuPzrPToZSdyM9m934z6i3rK
 M1MPtcxmoQAtfY86vdaTydf4uc0Hg5BdVyADHHZcPBocHVKcy3n4xg0erREipD2F+Vba
 qfsQ==
X-Gm-Message-State: AOJu0YwIfbyxok5Uyj/dELrJVZsBS6kIB71LFHNdO80qW9B1Z3ZGbXVA
 vTY+jWy8Hd4NLfux4kSaKLp5LxIEbKCYKceIxg/OUi9wIUyXYomZG/57oTmGilz9
X-Gm-Gg: ASbGncu1m/CJ3gcfiHK99+TMzsgDV8Y+Jjg59cyesY5Tk63UmZj3lI33za5A2BJY10T
 /TYJ+pef/Wc/w3HyL/7QslLbxR6Whzpft+eVxsn9VHgpLRUBA+kTG0ufStqsNz4FXvxoj0vjZZF
 MADHZaozinWtwXnk+uM+/SwG+NlIGs/wZjSGuHSt9eoK6pQNeB6Tn4N6GHxQ6FR+9HjpiFyGlB3
 UeXoOBC40sjjvp4nmaRwrTjyfjJ16q3TxQDOl9q9gWztukeyQXOKkTuOwc6IB3tDe8X46/W2xLy
 kbofmqOm8Fp9wcq/G3WpPp5KPdoWywygidQcYy/6auu0YR7lnJUznVso
X-Google-Smtp-Source: AGHT+IFofKwfPU6JJhCRbOJKdqP+KNKyISMFPX94Q5L9rCN8qKntT3M4TH2ZentFNmisOryMuRK3tA==
X-Received: by 2002:a05:6a20:9c90:b0:220:2caa:3018 with SMTP id
 adf61e73a8af0-2207f27ee1amr5903004637.24.1750860281745; 
 Wed, 25 Jun 2025 07:04:41 -0700 (PDT)
Received: from raj ([103.126.35.123]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c8859edasm4675841b3a.142.2025.06.25.07.04.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 07:04:41 -0700 (PDT)
Date: Wed, 25 Jun 2025 19:34:38 +0530
From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: u-boot@lists.denx.de
Subject: [BUG] U-Boot qemu_arm64_defconfig CONFIG_CUSTOM_SYS_INIT_SP_ADDR
 collides with TF-A RMM granules
Message-ID: <aFwB9t7UYhslLqqL@raj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 25 Jun 2025 19:05:52 +0200
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

Hi folks,

I have been experimenting with ARMv9 on QEMU.

Here is my configuration:
	QEMU (8.2.2)
	TF-A built with ENABLE_RME
	U-Boot in Normal World (qemu_arm64_defconfig) + Linux Kernel Image passed to QEMU
	TF-RMM built into TF-A

As mentioned in arm-trusted-firmware/plat/qemu/include/qemu_pas_def.h, TF-A reserves a region of
24MB starting from 0x40100000 for the RMM in L1 GPTs.

When control switches to normal world, U-Boot sets up its stack to CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000.

During u-boot/arch/arm/lib/crt0_64.S:_main(), control jumps to u-boot/common/init/board_init.c:board_init_f_alloc_reserve().
I am not exactly sure what this method indends to do, but from the comments I understand it carves out some memory for the
"globals". This eventually ends up pushing the stack pointer to 0x401fde70. Which is inside the RMM PAS initialised by TF-A.

Post this, I get a Granule Protection Fault and the machine hangs up.

I wanted to know how this can be fixed and if my configuration is wrong.

Please let me know if there is any extra info that I need to provide for inspection.

R,
Yuvraj Sakshith
