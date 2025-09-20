Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A49CAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 17:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2D583192;
	Sat, 20 Sep 2025 19:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cXbZqh0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CD083327; Sat, 20 Sep 2025 19:47:31 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3CD583192
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 19:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30ccea8f43cso2718488fac.1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758390447; x=1758995247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIpH6h3WhfwGgJQtloXHB82hHMJ+8foSaFzpjG5caRc=;
 b=cXbZqh0NBClxmmUKgYmv9d1xPH2O/EuyVEgX8Sl4zul69BfDEGf3WIwUFCSxK1fSfL
 PXetSpjZDukUnPzERBaZjGfVNeXosq1n+XZLT5PtEzWhwDxCc0OvC3WP4eWPXDnvsrRs
 XLmvbJFa1qIn1MiTpv7maqt36DXq13p0vyknc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758390447; x=1758995247;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIpH6h3WhfwGgJQtloXHB82hHMJ+8foSaFzpjG5caRc=;
 b=RzI7zdqfVgEPso5Gvb5TfG2ZTRCxyUgXcYsrsLg8T9jBM1LZsPJhXbt9q3h9NtHcdJ
 yjsr9hxrSiIwo16aKNmCHnJ9I69Aaz1eEkg/qesnbNRfTBRA7cfFXYjJmQuK0sbl7wSB
 bZUwciENhPejgOr20DZ0rbXPkIKKO1aU9M2M1+C5QUFUwY+wRT8OPYvhivbh7m74IN4e
 p3IgYpCinliw6GqoIBI+G8IPwiZjKZZxGrspHFbTlMmjNgvG7s7Typ4rLwwTU4DGRM1d
 sM0uvEMK+IuxWBm9+B9TviCIn9D+cGWZN7jLwA6K7pHJULKXGE7GeWyIwk5vQJnOE4PH
 dIrg==
X-Gm-Message-State: AOJu0Yy0SuyefTNrEBOt7GFZWfUFouE/sIFTwgsdEh7TWJ27ON0CRbKO
 +Mhhn0z9y/gxdtO9sqZKuCmmApCO1Vn/vlA9V6wehtueL6zZSZ0kemXKhC8v6IdON/11vRCAwJh
 TJxU6vY4=
X-Gm-Gg: ASbGnculNuQm/MXWJuPZ1D6yEf4fgmg2n7sh+ppu4aNlhw7YwtzeQvfWwFLQ4+Vn0XM
 avDMpTIdoPUEMbbMyDjQ02mI/nB0QfJ9ft4DWe8FjpuTUKXFn9M6jc5UyWhMAt786F+f7Lj5McN
 LDBvvKd9pajYggzLHlNlBmMmylN/exv/hzsGPO5QmfWfbciHpc9rdKM/D8xYbR3drHoJvhClg/Q
 NDlt9ZuGPiVuQVjXSDmaexmeUiBgQ/2G2/a1bEBY2BlloHXIyv8K7B13ubhLpueYxhY7tOMHbPs
 RVf63UgOH65G/wZb2BRUNggqvZ1dZIK9q3TSACFmagEAXXGlofFuMOjcrr/ZjTzjWc2cx88PKVK
 SYvoOQVEHYxg4M4PnvRKND7fFg/aZhkJEWPfclKtG0DzU3fflP1aWUueuHaU+Ngnjwg==
X-Google-Smtp-Source: AGHT+IFES2t428/JlgF77t53+uK/eYHvu0cJWAxjgxMlmN4lMHimaVw/LjA/LLCYU0Ct65c/gPkDCA==
X-Received: by 2002:a05:6871:2e90:b0:333:494c:2720 with SMTP id
 586e51a60fabf-336d3225504mr6118363fac.19.1758390447125; 
 Sat, 20 Sep 2025 10:47:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e5a2b361sm4889395fac.16.2025.09.20.10.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 10:47:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, ziyao@disroot.org, 
 randolph@andestech.com, hal.feng@starfivetech.com, 
 jamie.gibbons@microchip.com, eoin.dickson@microchip.com, 
 wangruikang@iscas.ac.cn, greentime.hu@sifive.com, e@freeshell.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <aM5_0WpehgnK8wH-@swlinux02>
References: <aM5_0WpehgnK8wH-@swlinux02>
Subject: Re: [GIT,PULL] u-boot-riscv/next
Message-Id: <175839044541.1370912.7338002899133591795.b4-ty@konsulko.com>
Date: Sat, 20 Sep 2025 11:47:25 -0600
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

On Sat, 20 Sep 2025 18:20:01 +0800, Leo Liang wrote:

> The following changes since commit a209627ed7921f40669f5c0795570d40e77e4cb7:
> 
>   Merge patch series "board: dhelectronics: Check pointer before access in dh_get_value_from_eeprom_buffer()" (2025-09-16 16:14:30 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


