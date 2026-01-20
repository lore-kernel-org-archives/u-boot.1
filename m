Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BACA5FB8
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 18:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4765983015;
	Tue, 20 Jan 2026 19:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R2pOHd6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF82283A2D; Tue, 20 Jan 2026 19:08:21 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B658483015
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 19:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45ca0d06eddso2700788b6e.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768932493; x=1769537293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SddFo3gf5NnDgYUzaVO10vqnt1H3gzw+Q6k7XvMrj9s=;
 b=R2pOHd6aAclhCnyTYSutJaYlvXUepRUgnEB+DYDUpugnRdg/nBQDkFbzcmspxIi5Kx
 AqBK1ig6nAeUGkObEyyCcKNe/CZa9kcV7AarcL77cRcGvaNmP+O7lKzK1e7ZmzELfojB
 9ElCRDfqOE4iMMf0nRKiIZo5JDZ/q4eFeEQ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932493; x=1769537293;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SddFo3gf5NnDgYUzaVO10vqnt1H3gzw+Q6k7XvMrj9s=;
 b=w8Xw7ZSCMb1XtCo5Np/vlAIupwPgbjvNSQBDbRFO+q++kX/q43X5DXoBOVEJiK8IGs
 /g56/wZeaRJoiMND/f0BAejCb3M1EwlI07WtqeK1Gvc6DEwjSYJynM5NhV1EWqLbTM1P
 lKHY42qtHCfOkc8AMwh7FTMHRHGW0mYIcCZWZvx1kJFJ1VwT5kmm2tXxfeQlw9be7M3C
 WPsF/uD2Ln/h5B1kPw55pifbeXrs0aFE+Y/YAGhYH5Y1SLGUm5/a7JOdvja0dVzjQ07S
 l770cYiNdGXB8T6ej+jVGWlffo2uvPKWsRf/XR3fMXqsBDiu/54rjkglKaWbwey1sZXD
 Nrcw==
X-Gm-Message-State: AOJu0YzCIxiPHHk4zH2yEsQ2X7TKCS52tEkBl+y+9aw/GdE9SmUnsWVJ
 jCJLqLCRSLJMDHGARO086NE+7Pw7cMDDdPjwbGmSvvvcE4/l8tRMvQVZjPRSyzzGrRk=
X-Gm-Gg: AY/fxX6IqvR98owHtnc7QgZrwxPfBr6GeIKbNb9xdo+PX68IoN+8Fbo15znIqOGry8w
 obkWZLL7Z+fzhf0NY1IHIbWqcR2qmmQz9InKxWyI59/BxpTrH4oFVWi3yzb3oMk8OWEFvUz6VLP
 nsdURmNoe7Y11qBkSxyuZiTNUfZpHiMgWMgkqtnREYxFFFcr3NfA2IuEUsfIaR0Dx2RlKrrDgjr
 Z4TLF8H5BB5bugdOFhX093oKpUzRuzpG4cLfjuSwflwfHrN+pA/zEJ2UuoZOy4tnc7WiwcpShmd
 zfUGz4uRsXhttTPt0YG1LtQ66262+Hk5PDW2X8sOxVUWON7kmIHB6y4J0MEsGOoYh7JR3UK0gYQ
 WtdmPF6FaphMTZdW1pBabqka7uAr7Hyr2VwQuG1L2oIYPtY/ySrRKPt7QjG4e/sb6b7/vgojlQy
 fL5u/B8yu7EKnmXWSIt/EYeWtcY+O9FsUkRdNgJ2qmXuCnXECFWeCfa/hrEBqMcCBhsv5Kq6Cf9
 bvHK/Vli0C8VocCjLCS8zNVyejoL00tqEbyeofWRFTOiRme
X-Received: by 2002:a05:6808:10c6:b0:45c:8bc0:fcdf with SMTP id
 5614622812f47-45e8a8f771fmr972073b6e.10.1768932493466; 
 Tue, 20 Jan 2026 10:08:13 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9defa8b3sm7364048b6e.7.2026.01.20.10.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:08:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
Subject: Re: [PATCH 00/10] Update linker scripts to ensure appended device
 tree is correctly aligned
Message-Id: <176893249270.434728.14934331379897676898.b4-ty@konsulko.com>
Date: Tue, 20 Jan 2026 12:08:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 15 Jan 2026 16:19:30 -0600, Tom Rini wrote:

> Hey all,
> 
> This series builds on top of what Beleswar Padhi did in [1]. While
> there's still discussion about the mkimage related parts, the linker
> portion appears to the reliable path forward. An alternative that I had
> mentioned before, and was part of previous discussions on this topic[2]
> is in the end I believe not reliable enough. While we can take an output
> file and pad it to where we think it needs to be, ultimately the linker
> needs to place the symbol where we want it and if that isn't where we
> pad to, we have a different problem. So what this series does (but each
> commit message elaborates on the arch-specific linker scripts being
> inconsistent) is make sure the linker script will place the required
> symbol at 8-byte alignment, and then also use an ASSERT to fail the
> build if this would not be true due to some unforseen event.
> 
> [...]

Applied to u-boot/master, thanks!

[01/10] Makefile: Have binary_size_check report only first match of _image_binary_end
        commit: 90efb8d394de9df1ae2c20f5e25ffc2009dc7ec5
[02/10] arm: Update linker scripts to ensure appended device tree is aligned
        commit: 8b0ebe054bb3334c6ca9bed018360b08d4ddc7a4
[03/10] m68k: Update linker scripts to ensure appended device tree is aligned
        commit: dac67bf0bee168de8f43050fe9b1d776de1ee00f
[04/10] microblaze: Update linker scripts to ensure appended device tree is aligned
        commit: 2e52030584d069b702f8367ddd34b3a65f522806
[05/10] mips: Update linker scripts to ensure appended device tree is aligned
        commit: b220a43f5ae69f1b258976691fe70414c4fc2259
[06/10] nios2: Update linker scripts to ensure appended device tree is aligned
        commit: 546d84ca0cb367240c93aa3e3492be4dccf85332
[07/10] powerpc: Update linker scripts to ensure appended device tree is aligned
        commit: 87d3780ebc242e28a180606f72335ce37d8bcca1
[08/10] riscv: Update linker scripts to ensure appended device tree is aligned
        commit: f150843499b3139c2358f5659411571399902d4a
[09/10] sandbox: Update linker scripts to ensure appended device tree is aligned
        commit: 94b81451890f42b422bb13b03e2c1034b9bfb43d
[10/10] x86: Update linker scripts to ensure appended device tree is aligned
        commit: 410d31bae4b863eabd70adb22a0c9976bfe4fee3
-- 
Tom


