Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A0CCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD3A8495B;
	Wed, 10 Jun 2026 16:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Os3TkeCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CCA8495C; Wed, 10 Jun 2026 16:38:00 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4384784949
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68c201ec1cfso957497a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102278; x=1781707078; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jTz5AQpVZ7WyunmKdFrjbnwN7KPwTUWEI/M0kR9wLGs=;
 b=Os3TkeCC5Qkhtryi3MwOzk9N1NU/6N8MVyTrhg7dZSAEJsjbmREk/UhkeK8F700JAu
 jtvWgCAq6Rvmsf0N0aKH+jcrS7C86D0oD6TfjCDP23gwSGM3qBwD+aC2pHh7oLk285rA
 Ia6qnJXM1O0mFbtXAXNbF8emj5GhUZ3C4kNtCHo/tRs/jtjAWaMpsViMAIYmJwL+WAF6
 rAoZGCxRMsvVSQ0dgiGykMrUxDCl45EkkalTBx+BpQ0uJ10SSnjs/EKwoqe/ZfQR/4gJ
 waL8JD/vlosywjmkDOn/boTjhg45mtXb6nkMAXaPsfOIiGZ+K194G4bhJDuQjF3whRvI
 chRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102278; x=1781707078;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jTz5AQpVZ7WyunmKdFrjbnwN7KPwTUWEI/M0kR9wLGs=;
 b=K3D47gS7t956FpM4g6f1dDbuTZfwRErnriA+qek/3TIH7MeFgUoCHgpe9QP62nAaaA
 XEnaLl6mgqwrHKp8cab/8AXQPMxFK8U+UfbyisULlIugOm7oFZTEybIBKgBttFyk/Ch/
 +KqHoKXgGDXJcra+bcEz1/OcbupwX/MfYaoGllHl7C2lGOsZBWgWunCuDtOOE2qfGRda
 ZUlpbaJ7k6INrJkY+WjEGVZPGRPAWZPQBzf62ttPYiW9IENl4XUhXyBfBnj43xSWlTJT
 7ETfqOOZ/pkW0dnwVXItOfKaDmbv7WEQ59V5AIfNHmcPD/VuKjh5hXCM7ADO9BDytrhT
 L4sg==
X-Gm-Message-State: AOJu0Yyn05iOQWiyEYdSU6SOGYAoZ23WxJtmJbsxuVVy7D1BUjgcqNz7
 dQkg8Uedn3RWSroyrgiSITHQjnSjB93zU+v1Di3p2tYQRKU2zCjkuEstDzz7Uw==
X-Gm-Gg: Acq92OHc7I+KYDMxIeLCUQebffcyJhB642qKKw9WFxAiUtfOvgiy79iUhKZOSWG99Ln
 /t9wR2Lc8rRI5UmfpTxK+nBSyHbPl/JitSaq3FMjmCXdEs28ZhIF6PTLQSHZch0SrCDExjGlYnk
 X1NPnYPaqcV6Gz7Jr84IGv3fo+g6teWZVVi2Cok/WE9t38ad72zDkz7yCAGCEukbBFyxFuPpF1E
 8VdaM3W060Jl56r1AaYAskDraq0Xu2jjEU5H6+XsoPp8PUS8U4J8kFj/DOV9iNqfkM2VkVsG38H
 eweU/mwREsXDuoQ2gsvUdvXjc41xJikz/z7M2bKG1X1rNZ+sBpfeXdCsezGwPjIHym7Af5VVCP8
 0WLm9y4jZKjcENBO2CSKNjNyuoTCWitzEjyJPyVYF4U3XRFwx5OQtfzw+8jQLoAEHQdh3Mu5ewU
 SvAXj6Vs+CGfERY0/VuX/czZim0lLXeh0WEZ8T6Zvx/ABfZOZiLDoXjSeFpiaQ9Si/iiCAZTSW
X-Received: by 2002:a05:6402:388:b0:691:4586:4651 with SMTP id
 4fb4d7f45d1cf-69145865088mr3935412a12.8.1781102277576; 
 Wed, 10 Jun 2026 07:37:57 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64303892sm10039385a12.0.2026.06.10.07.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:37:57 -0700 (PDT)
Message-ID: <96cd6235-cfb5-40fa-9c28-85366eb8a75c@gmail.com>
Date: Wed, 10 Jun 2026 16:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 04/18] Kconfig: disk: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "disk":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 disk/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disk/Kconfig b/disk/Kconfig
index 937ae1da61de..672ad46a48f2 100644
--- a/disk/Kconfig
+++ b/disk/Kconfig
@@ -8,11 +8,11 @@ config PARTITIONS
 	  Zero or more of the following:
 	  - CONFIG_MAC_PARTITION   Apple's MacOS partition table.
 	  - CONFIG_DOS_PARTITION   MS Dos partition table, traditional on the
-	                           Intel architecture, USB sticks, etc.
+	  Intel architecture, USB sticks, etc.
 	  - CONFIG_ISO_PARTITION   ISO partition table, used on CDROM etc.
 	  - CONFIG_EFI_PARTITION   GPT partition table, common when EFI is the
-	                           bootloader.  Note 2TB partition limit; see
-	                           disk/part_efi.c
+	  bootloader.  Note 2TB partition limit; see
+	  disk/part_efi.c
 	  - CONFIG_MTD_PARTITIONS  Memory Technology Device partition table.
 	  If IDE or SCSI support is enabled (CONFIG_CMD_IDE or CONFIG_SCSI)
 	  you must configure support for at least one non-MTD partition type
--
2.39.5

