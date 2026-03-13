Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A22107BCCD
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 16:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F0C84372;
	Fri, 13 Mar 2026 17:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kTzkDwmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E8C843C7; Fri, 13 Mar 2026 17:52:27 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1099843B6
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 17:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d7447778b9so1234185a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773420743; x=1774025543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uvmSGSGEkGLSHpwxS8L/Gwh8EVzupjMkipMKvbHll8=;
 b=kTzkDwmMTbi+ApbB5W7U3e/z7XHUU5jhhkZiMwyz373kJQenlAG/O6xzRa4DUtr4xe
 rJ8hQPCKPthsJrs35/uSb0em/QUxGdTRrQazwoWmlGcrHWgdlA42Utxph2RpIheW1bxx
 5uzpppBxv66cFYnL4tGa4Ri6jCtLnP3N0FCIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773420743; x=1774025543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5uvmSGSGEkGLSHpwxS8L/Gwh8EVzupjMkipMKvbHll8=;
 b=S3B4NAuJ2iT8dm1prTG7MaojEBLJgkoQpYVKloYr33Y57RauqqF+2Pirt8mO5LukrN
 4uEknphb+36GVMKaBaS0FopUdtWeKhhJrn5DuS2MyzxvCWP9rGeoUU0fF++QKTcOAHhd
 Z6K0WGL9dbBLoptJFqCtJf7xTBCYOHzCqWyUzFg0jAcmcYV0alvZb43BzJrcubd/0qQw
 Rr4TTfXatBnxSTktloIJzzDSLOwkNfc8K0qGjMNs+YL/RSqpZjotndipKweRpWirqGfh
 9ISxKvhL42EXD4RXwgR6omMNZg5ZDay2/iGGYjO9U2lGSL633SKnw2635SxYkOjzPjn2
 KSEg==
X-Gm-Message-State: AOJu0YwEXmdmCIeck1JQxSUNrIenM/3UY/JCyivInr3FBxOohRU9e47U
 W3GVRYiYxmTYS7WonXE0R8aimtFZjdtblPsLfWNAC2nlUx8sjHoGvd9c0vxL+XL9bDE5XjMy/WN
 le6It
X-Gm-Gg: ATEYQzxk/te5DC8BnxT6Qvc4ISp/KgaAQFD8AF8Owia7dMlR4oxBymHY0lQkyOrt+s2
 jPR2xm+JxYxLUv0R/q6aq35l0CUkH1Wj1MkryBuJSPpAYA/iBgHr0UeF3WnnLGyN/QknLvOHTKA
 ve5gthy/Gr30ahyXc7pJ7AJeJxoJLatCNLIuDpdMFCHLjo9HFbJQdjUZB5XfoUJgjCB7t9E6r5w
 o3i0DhOq2O1G5JMwFirAHt6BCdf0ZTX0YZ13GZ8n8PmVJ4nu5JoVf5fC/5O+dZD+OPOLbzWW/Y5
 dKjJNNDGRK/FM6b2EW6pBIDigNu4iz9ysPKmcCCxfpVArXuMXW43GkgfIE7FzlXA0H2KwP7NnJA
 /CVMzUV8FnetiaH5FDH8xIhxRnpmvEBDuRMMhN5+zRp7xjvjMLRm613TGr60hd3d1gmsCq8XK9j
 oUjltfeGrzBRIrnL28+8jwKVBrlpYubCRvw3Bv0hPOW8BVrvtLAbIQBwoAnTILkCxxzWdKsT/8d
 RfbHXkpvH8WILe6V9+EeEBbqRus5DOcvl4pH8UravXKqqnZmT4=
X-Received: by 2002:a05:6820:4df9:b0:67b:aef9:1ce5 with SMTP id
 006d021491bc7-67bdaa2db8fmr2251169eaf.46.1773420743327; 
 Fri, 13 Mar 2026 09:52:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bdd612b6esm1241304eaf.10.2026.03.13.09.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 09:52:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Leo Liang <ycliang@andestech.com>
Cc: rick@andestech.com, nick.hu@sifive.com, jimmy.ho@sifive.com,
 schwab@suse.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [GIT,PULL] u-boot-riscv/next
Date: Fri, 13 Mar 2026 10:52:19 -0600
Message-ID: <177342068508.1062380.5101081635850084640.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <abNxIFSAFWMgeEEf@swlinux02>
References: <abNxIFSAFWMgeEEf@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 13 Mar 2026 10:06:24 +0800, Leo Liang wrote:

> The following changes since commit 8bc2a5196c1c0bb5dbdaca073323da0015a0de37:
> 
>   arm: k3: Kconfig: Enable fTPM and RPMB support (2026-03-10 12:35:18 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom

