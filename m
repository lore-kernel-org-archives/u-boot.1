Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF31D5E36C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 14:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3238839D7;
	Tue, 16 Dec 2025 15:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IOBpIoI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B65C83A3D; Tue, 16 Dec 2025 15:14:14 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00CA783623
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 15:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c05d66dbab2so4647053a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 06:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765894450; x=1766499250; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q3rjjs5nic+YJ+G1+WgouHWnAzafbHYq4UcTTZHMHLY=;
 b=IOBpIoI0vZRzm+EdDIK4h+JWd+ibwXochf9dE5ulTkPPp7ZxUjS3NmX4a7+mSu7RMi
 4WJeWJ0yiau9ATRkitBDq3+aGUKgboy2eoUtH7QKdyFoXlmhOUP9kD5zmUFceKx7WuTy
 i46rbsE4zNDRfVSUkBbhgUdP+CsD2iIopJz83lfNxC04RyuLp67c0u90+aB9BmGIk6KV
 HWrd8g8XEUDU/CtL0AynZAjdwvM5ZyspkRwyp73jxD60jMx+MPkpKg5hyOnS6SKa/H62
 FtVYGKe7QmFKjP7+a4xyY3i+VUZ41qXpAMLzrNlcFwS66Eo7/G3x8irw6Y0usegy4Qmt
 Dtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765894450; x=1766499250;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q3rjjs5nic+YJ+G1+WgouHWnAzafbHYq4UcTTZHMHLY=;
 b=l32tON5YQVJ6hy/+3zeJKrbfpKc5gTl/Gmf7xDrQ2Ch5lXzkiV6fJLls83+2uM1ixv
 lfn2/kkLnE/H7tfJhnNwp3Hga1q1bca4HNIK5H5FGHnSsQH9tC9gwzlIv+s0VkBAoNzt
 zlH8k45691vT9dNwvJe8Gc/miYxgDdnxIt5/pa1/3eMoB+3FDzXZT0f8AKydUDlkLDU0
 eK4AFnBxY9TgF0i61vNKmbTw1ngSaYuZkHPRKzy2AQ8ApenGTntU4QN01Uw0aVvYyggQ
 aZ5PYGlev5m2z0YxvFov65BN3SLTCheqJ3oA8pzhJse6COxxG70q3qxN7OBy6bugK9bz
 IkSA==
X-Gm-Message-State: AOJu0YwlFUrZT+vg8wEvDgBrpoNLsq8iF7KEkE9hJyS8PzRVMYB/G2JE
 KmTgomkvOkriROXeLo0Mi1yqD0XHRxD6QXHPc6BAqD7YgAZ/YesBtd1TDS09BAZraNck2yohtUQ
 DgMbXG6o2wM5AcHOO3oeEoxYAXaWRYoob7OHV
X-Gm-Gg: AY/fxX6vakQJyMINOkxLQpBzcZIXaoK5VItIuKbq19BNanDpLm0dx1lvgx2A+5D4+SY
 YtaASIAgB+dCazG0yglXT953B3eLjY8BIwn50Dar3kV0JErRMbYfJoZkhl+qKFYeVYCTc2zNXD4
 GbNcnf8EkKM3XHs107tIK0x0xASmk4gXg+1/a+rnAd52PmSSnCL274iADyxypCf2ijldjxKQyKj
 48AodoEgd2eOR0km+EL62bN2VDaX5PXWAYaPFapPwqw18NTTHLfA68BfolRf0OmHMvuqw==
X-Google-Smtp-Source: AGHT+IEbEyc6I8G4Nu6My6chzI0o31m/fDCOR4JCEIIMwSbYNWu7N1YAVPU22U5SuYObpnnpl1uS9mbYWdarmWjQoHg=
X-Received: by 2002:a05:693c:2805:b0:2ae:5020:afe1 with SMTP id
 5a478bee46e88-2ae5020b1fdmr1222890eec.14.1765894450030; Tue, 16 Dec 2025
 06:14:10 -0800 (PST)
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Tue, 16 Dec 2025 15:13:59 +0100
X-Gm-Features: AQt7F2q-Ihwv0XyCxqwdn_zeNXbwHq85hts-_teSj6msDtggW4relcRcIXTV-y4
Message-ID: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
Subject: Standard Boot integration - script validation before execution
To: u-boot@lists.denx.de
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

Hi
I would like to integrate Standard Boot on our custom board based on
NXP LS1028a, as it currently uses a so-called distro boot.
Normally I would just follow the instructions in the doc about
converting from distro boot to standard boot, but things are in fact a
bit more complicated. My board supports dual rootfs following the A/B
update scheme, so I need a place where I can check the boot state,
boot counter and so on, so as to set the final rootfs partition to
pass to the kernel. That's actually not a problem - I can just use the
bootmeth script and put all the logic there. The problem is that on a
production system, the devics will be protected by the Secure Boot
procedure, so the script to be executed should also be verified before
the execution. In the current solution (distro boot), the boot
command, first loads the script, then calls esbc_validate over the
script header and if the validation passes it sources the script so
the OS can be loaded. In current bootmeth_script there is no place (or
I'm not aware of) that would allow me to do vendor-specific validation
over the script. What would you advise in this case? Is there any way
to "inject" some plugins into the existing boot methods, like  e.g. a
plugin that would be overriding or adding some functionalities to
existing bootmeth_script? I can of course patch the existing
bootmeth_script with a command that would perform the validation but
this would no longer be a generic boot method. Or perhaps should I
create my own boot method?

I would be grateful for any suggestion
Best regards
Patryk
