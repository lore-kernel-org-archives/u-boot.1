Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB89C369AB
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 18:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9BFC841F2;
	Fri, 11 Apr 2025 20:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iye/4Ihd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3940B84203; Fri, 11 Apr 2025 20:10:38 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2CD841F7
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 20:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72bbd3a3928so1333880a34.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744395035; x=1744999835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fjh7zH3GpYk0fcJ1rSSUPCUvT6LbGsUZ3NPc2mvOyUc=;
 b=iye/4IhdCQF1009tM3rBR8z3YMP0O9gN3LBwMIVoCeuX/F2gGtE8sZesOW2KmMrIT6
 G+dJ3enQpLIRJYRZm7jH/xHuwUyhNwmjD+utlV3E2Cz8heEc9GV+XAIQPB47rYSfPm+8
 6q/mdG5U9+mu3R2ibMo+d4EiCz+rHfZyNVJro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744395035; x=1744999835;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fjh7zH3GpYk0fcJ1rSSUPCUvT6LbGsUZ3NPc2mvOyUc=;
 b=nez/8avpWv2bMV/o+q6ORlfRABnjnChftGwX+YoxTtsm3rf5QsqVi3xk0/dVycNTDR
 YyDxrGvZzbguJWFS2a/PxwTYg3w/I4BmlPl8KV9HHuszpZgioR3cDoR/Z7z5wi7L8T10
 eew4fy/NLdGgZ/SVqb7KclwhSTWvB92Hgkqq+rD9L5q8MpZG9NRjQdXtNPtYrkX4BzsS
 oEjFn9fxlMjvGz6WMVqX06C/FDpNIi1bLi7SBHd7AoOWU/Jy77KBnXungNcnHpuI7pRm
 LL3F/nkurUwnSlBnvbO9bYrryDWwUwOSHzlR8N6BAlXlYwozpcx00DRDM9+96zxfztpQ
 ocxw==
X-Gm-Message-State: AOJu0YxuAouMy9A9zm5y/GqqLd6AdnUms2N8BM3zqxqEW5y59GjdSZ8/
 /DikkBDj1RixMR0aQGm/nqgNiREtm1W+ebqULfPsWoITb4Zr2mujpaFB8BBhN5A=
X-Gm-Gg: ASbGnct0PLrNuo/AVFDxjw58UlE7MYR+yfhYRpwGmw2+9tcVSPh0PtBBGsYq0cSGI+/
 SUBY/ZVQZ6XNZyn1igW+g45jFnKzoPd8J72MWJaAFLO+rD2fqNwsCf7t7oqXvjaptyQLWz1mXb7
 xggrkjbdUhyDiNyIBgITMYuqVqtaC8KbqHHf/MYA+AZfxlcvCl1oQLl8APMsDlQVtfrnMomTcVu
 32lcgS9t8xQUAD8wO5548RZFU/oHV5zmt3XYu0FTgT4ksjV/C7LXWKCVC0jz4AYyhJ4jeYgt8J9
 VZkbq5qqO2+LK2boVqGJlBa/ZMKPj49eGVisdy/BEIYTNQKQ5oL2IgXWDtwrKM6NvsmhtIhgc3g
 U
X-Google-Smtp-Source: AGHT+IGVqtdOZDazVsOX/JpIt+Qunhmksf1k1CCEr376uwyh2TzyXE/jznrIpf+cD7pAdoYo8raZBg==
X-Received: by 2002:a05:6871:a509:b0:2c2:544d:e140 with SMTP id
 586e51a60fabf-2d0d5c77939mr2250827fac.11.1744395034757; 
 Fri, 11 Apr 2025 11:10:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096a20194sm1261969fac.30.2025.04.11.11.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 11:10:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250411140906.32762-1-festevam@gmail.com>
References: <20250411140906.32762-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250411
Message-Id: <174439503396.3256164.4905485269637298346.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 12:10:33 -0600
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

On Fri, 11 Apr 2025 11:09:06 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit cb7555e93075114fe4af0adb806877ac4d4ef80d:
> 
>   Merge patch series "*** Add Ethernet boot support for AM62Ax + phyCORE-AM62 SoMs ***" (2025-04-10 15:04:09 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


