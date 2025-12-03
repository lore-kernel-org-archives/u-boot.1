Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33536D1268B
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 01:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1119383F30;
	Wed,  3 Dec 2025 02:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tr8qT6dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C897483F33; Wed,  3 Dec 2025 02:12:34 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A1483F2E
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 02:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c75178c05fso1788444a34.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764724351; x=1765329151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3LSBHYaomnOJre9xC9FZloboyado0U/h4QrAM3uIHI=;
 b=Tr8qT6dz4jFK68wW/jFJwb1B4R94i3Uc/Nt2darIKJCAT9Tc1p86cP4HcVSzaHpS+U
 cnKTLH7H/ERIGFvjHiN1g5uMq5bhIIDuiIFogHEqR74+aaBxWNUbw4L++TWyVne8iK/a
 XguYbWtmNizRP/9CR5qG38ZXUJ+RDLMaLr5eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764724351; x=1765329151;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3LSBHYaomnOJre9xC9FZloboyado0U/h4QrAM3uIHI=;
 b=Lf82D5JzC8F9Sj9gAyzhUC0FU7+JG6SRGNKiXO64D7AdgpQgy6M5TbwuA9MUc3seUJ
 bJe4kNY2n/NbwGSYXNb1xvLaL3+e6YmTamGn8BN7uji456D9SPbg0Lbf/dfdL4csv3DY
 wMcJ1mPsZbFmIpnR8M5BZX+1Wxs4+YCD1rg2I0V3DDY4pkhejcv9z650wgYWW4zlyxJU
 veykFHD5r0EOqVXh/vBzhw7OwkbLf8BD2xxge032xOsrqEEpa7cKvMq/8Iid6swnvBak
 rXDrV3TgegGD24kRRW8fuuqDRGaJu9Xh9on3Q60FAPTqKzSQbg8X4yjx5E8mcJuQzu8D
 /R8g==
X-Gm-Message-State: AOJu0YyJuL/P7nUV0S44c0UpnUxvPmO73sYpGz1ZNwou2+yxCamkox/X
 ba6/Q5CMRYxOz90c4S5hwoExw4fR3ZVSF7QUSlAGQlrZ4Qp/D7gzrLub2xLZ/4jOvRGdGgwri5j
 7osYCYmo=
X-Gm-Gg: ASbGncsL7FJ5N8PKAp7sRnvH7IpKbmzIuktrGsDFL088y04V0ySHSRngUz67sI2e8Rq
 /xTT20HljjVRuZvftlG24VIZExP5Mh8HTNMp1Lx94VKVzL15Ie/JbrXCFPmBQsSmmUlaa86VXfK
 PR1U+sX5BtjG+efYpcC/Y9w224Onx+OOZ9QfufdOPL58VJYQ3tcBjXqY4ZDJ70Et91iB350bImG
 c1ucKEh9wx7FPaI6jmAv1xJHUmIHY6CJnPnJzwYFaB+rHevTgF9LfjbAtgrHFql6nzUpkxUSQT3
 MNvmciH8sM/kh0Ogkwlmdym9G8FbxJ346r5s96fi4iyVF4D61beGXDjGkZXpoIQ/sp5EQxctDfn
 KE0kMc3H3yviPeoQkw6sRC3b8PBDw3s1uTaKDvYCkdhndSiO/LJDX0NnLbvi6CdQk/aQAnnMnNv
 Akfs9vt6R3rsJ1YJmULK9t85v6g2jTZz1q71AnLf2uRpWuyUYG
X-Google-Smtp-Source: AGHT+IEDddyzb9LDJA8n9OasA6DavvpIuM6JEBq7gkBTMamoVH5fdAIbr/7VW2CJURdepQrq5wHxJg==
X-Received: by 2002:a05:6830:3887:b0:7c7:1c77:f107 with SMTP id
 46e09a7af769-7c94db7ced3mr503379a34.34.1764724351308; 
 Tue, 02 Dec 2025 17:12:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0b238sm7814280a34.20.2025.12.02.17.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 17:12:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adriana Nicolae <adriana@arista.com>
Cc: sjg@chromium.org, ddrokosov@salutedevices.com, 
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de, 
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org, 
 joao.goncalves@toradex.com
In-Reply-To: <20251127162834.596695-1-adriana@arista.com>
References: <20251127162834.596695-1-adriana@arista.com>
Subject: Re: [PATCH v6] boot/bootfdt: Add smbios3-entrypoint to FDT for
 non-EFI boots
Message-Id: <176472435013.2999507.8673714721788099821.b4-ty@konsulko.com>
Date: Tue, 02 Dec 2025 19:12:30 -0600
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

On Thu, 27 Nov 2025 08:28:34 -0800, Adriana Nicolae wrote:

> The Linux kernel can discover SMBIOS tables through two primary methods:
> 1. Via EFI tables, when using EFI boot;
> 2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> device tree.
> 
> When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
> "bootz", or "booti"), the kernel relies on the device tree to detect
> the hardware. If SMBIOS tables are available in U-Boot, they should
> be passed to the kernel via this device tree property.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
      commit: 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
-- 
Tom


