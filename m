Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50EFCCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 21:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03C783C40;
	Thu,  6 Nov 2025 22:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kc1nG7BJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76DBD83C0C; Thu,  6 Nov 2025 22:57:55 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1932E83C13
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 22:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6da42fbd4so53948a34.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762466271; x=1763071071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYHGgo9+/ggLNjILivjmadyvphPKdECMBcJh1yV5i8s=;
 b=kc1nG7BJSwlyiWWzjaBhvG742sRuNG3wSk1HvK+LKgWslDSGVTh6xacdRPL0lGkoOy
 gQIwuBLYk/mvXbxQqw2gxWdOWlB2SDKQ8lCCcuom6J9g3JfjHDLPvZ568eeBYgVIBwhU
 6fwhncNJE4Fy/ElAM1lcXgPAw79SHGgS61Ico=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762466271; x=1763071071;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wYHGgo9+/ggLNjILivjmadyvphPKdECMBcJh1yV5i8s=;
 b=CCASp0+bsfJDvqILsemKL+AtzoZySNLSh5a73UC9Y91Vb0G1wMBjrt+jAoevKBcrdy
 UnTmYQYgYJR0W/52GdTe9RrDxW3GPD/GAFR7r1OfnGxJ8Ftam2Tdm/GAF7i/3x3X2P7t
 z+1enNRKnLVRp/QbZmsKtJ0W7ZiiMUzplbusTBCkBqNPwrlk6AKqvtPufJy5IHRr7e/S
 1Geadu/VCc6ulTDq89O6SkiX+ZlzQXe6nkV7bhCRKWSjY6MufnrVpBx+OtmLPXeCDu+A
 pkWNxlg2g2w/zYGzaH53UZNx8DNPLrH/9W+OLQhzNS3s8znT0tj4EuvtQDejGYVm1LX3
 AyOQ==
X-Gm-Message-State: AOJu0Yz8/gpXXYh8eNfCYnCr6skc+2Vj0pW6BBtlbSbCRR9ZwmHfrMXW
 WdCl7UBLfKhBTIpTWR0OtyUwLvugs8Txw0pxM1yo53OVN49Co4xnG3S8+yQlHLokFS0=
X-Gm-Gg: ASbGncvO8F0pApARJ0Bvcko9FIALIkdygy1xa/4ROrb4VB4zkKUW2dPBzSsFp8iyvkL
 IR0sDSwbpuP2dRjLRr34gC80VKhigYkvsKmPj6qUrEVpvOrTiNxqPOeuOO5QMPnUW0zKMGCM/4N
 bAeWh6ZFqV3NnCv5nSis6g3iTll+lRww5W7xgp8f/yqUDW5l21Qc+Au1rQt+KRAtu5Cw3bTpFLn
 dKg+LOaiRmCj+S7bMITXiv+6NQelaj9t8eWwiPke4MxhlkM1gfhm2QuugG53KHBR3loC1Y6VkGk
 B75v7PzEOIP5NAVosJ5taQu+vIVZQbSoeYzxAfpqtygeS8FezfQO5b4is54GAmt1m58MPgPqIvG
 FcwH/+O1huDD04GeG/5iLCKjVN05Nos7kEEoza+5IB3lemRtxxK6uAi0iaYdKwh+fCvZdyiQzU6
 UjuK29VkVLXG1elI2JMa8V6vJR2BSIxYEH9k7s2HjoiXXu2oCo
X-Google-Smtp-Source: AGHT+IEJGxvvQTK71qXit81lzq4o7vdq+WREdoPTobPo+LA5MVwF9Qg9aEIxZ6LIpjzBKeuFhEmJWw==
X-Received: by 2002:a05:6830:2b0b:b0:741:aa58:d500 with SMTP id
 46e09a7af769-7c6efcf6855mr867091a34.3.1762466270839; 
 Thu, 06 Nov 2025 13:57:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0a715sm370514a34.4.2025.11.06.13.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 13:57:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20251030212359.12824-1-marek.vasut@mailbox.org>
References: <20251030212359.12824-1-marek.vasut@mailbox.org>
Subject: Re: [PATCH v4 1/2] ARM: bootm: Add support for starting Linux
 through OPTEE-OS on ARMv7a
Message-Id: <176246626975.3129497.13093902945137097601.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 15:57:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 30 Oct 2025 22:23:49 +0100, Marek Vasut wrote:

> Add support for jumping to Linux kernel through OPTEE-OS on ARMv7a.
> This is only supported if U-Boot runs in PL1 secure. This change adds
> two components, one is fitImage OPTEE-OS loadable handler, which makes
> a note of OPTEE-OS being loaded and stores the load address for later
> jump to it. The second part is the actual jump to Linux through OPTEE-OS.
> The jump through OPTEE-OS requires set up of multiple CPU registers, r1
> and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
> Linux kernel entry point. This setup is done by new assembler function
> boot_jump_linux_via_optee().
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] ARM: bootm: Add support for starting Linux through OPTEE-OS on ARMv7a
      commit: 20861863eb3010581b12e9a77eb7958460edaa82
[2/2] spl: fit: Add ability to jump to Linux via OPTEE-OS on ARMv7a
      commit: be0e9ac7c8a141fbc52f658fbfdd96cf2c27d0de
-- 
Tom


