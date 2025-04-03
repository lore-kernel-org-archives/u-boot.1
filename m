Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD76BC36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 267B2826AD;
	Thu,  3 Apr 2025 23:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DMHmlw9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46448249D; Thu,  3 Apr 2025 23:20:50 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D158249D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-603be85490bso732738eaf.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743715247; x=1744320047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bi0eiBz1JQu7NGZVKALdEcoavOMT4aMAvEpmLzMj4ts=;
 b=DMHmlw9D9aRRnEhPBMfwDw99BTwVECnWMXo8KiIsY2MSJbqzzJLUCdnvyU+ratuGNC
 H4tGC18WaNFLfiJMMWYCEpTOgOTTG0rPURBpC/zz7Rc7xil5Qs993uhJ+F4uR7moUY/s
 T3TdnsYhTGijmOdnjPA1gsYEB4lPqYBJed1yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743715247; x=1744320047;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bi0eiBz1JQu7NGZVKALdEcoavOMT4aMAvEpmLzMj4ts=;
 b=CxMAwb2jWouCe7WOncBaPA5L7oFtAYZlH5eejSXcxpvWu2xAz4QS0cqg8dokNMvOig
 W2AsL3fHnhlkbdJorGygW6rUX3yTUQ+7R0KVQI4CrgtQ1sOdq136TW3oR7gbWF65/8cZ
 dKyI13ftztQkKW5ITdzwgb+E4vW3lD2i/2Pf1lZVAeUrWiGHDPthDQ5pG7FlDuz9dCOl
 jaH2fFQrvo1wbJjujcce4xJeAaMB4EvMJGWi9JikKGMxHYaknpTLwIH7WR09yaIo7sk4
 vgezg06NEnWSgu92tDCkLewfYLufWhmrsx2Oy23RaX1+sCLzqRT0NoSCgxiLIT2/mV3E
 8sKg==
X-Gm-Message-State: AOJu0YzlUw5xAVUp39blwx8Af1bG3N8PC27a4XanmOwkG4FmBjlPn+F9
 9K3H05V1yqrQJPl7N/7pP3MIMR3UhZmldttwX7dxMftlOb8oD6Eii2hPoau55Dh6CW982OH4Vnu
 ZV5E=
X-Gm-Gg: ASbGncuU9P30Na6Lo3Vj9SidTTnV2flccTnRkEJKICKdaJQs0KmvgRmKFlpmUa+vj2j
 BkgmbsP2CgOOPvJfFbbaEeBUrprN3WpqrdcYReB3b+G9u3Ic9156N+W3Ucy4ojX0Dj8Ce7hjbai
 32w7BprBYk1C6XLTbwF2Ehau+0mGMsKqvIOznFLCuTu5+fDLduDMpusnVYMNbyx0YndX5cm2ng/
 767SgjuxkVmbwoJVkv8eXc6hWCwjz+8BWUeNkgB4TUu7rI2QhOHCcJ0H+esmztk2fvwtgRu+znl
 WqQlSPwlxYj46CtosCt7dgu4/WYb8izNb6o5eIJnFqFZuHm0KSQHwQ6ajX8QHBNeVpIxvVpqNtN
 YaWypcHbN85PiPQQ=
X-Google-Smtp-Source: AGHT+IEWvmYWl6gb9cVtYuM0mwFgMWRw3+DryxRDX6kk8XN80Pl6CeVf2sMXPOIaAFDmYbRet2wnHA==
X-Received: by 2002:a05:6820:811a:b0:604:2ac:840a with SMTP id
 006d021491bc7-604166fd0e3mr214549eaf.6.1743715247337; 
 Thu, 03 Apr 2025 14:20:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4eb1b1sm386902eaf.20.2025.04.03.14.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:20:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
References: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH 1/5] acpi_table: Fix IORT RC node
Message-Id: <174371524641.2460555.15356679091896592580.b4-ty@konsulko.com>
Date: Thu, 03 Apr 2025 15:20:46 -0600
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

On Sun, 16 Mar 2025 09:32:52 +0100, Patrick Rudolph wrote:

> Even though the RC node has the correct size and the ID mappings
> are written to the end of the node, the ID 'mapping offset' and
> 'mapping count' are not written in the IORT RC node header, thus it
> looks like that the RC node has no ID mappings.
> The Linux kernel doesn't complain about the invalid IORT RC node,
> even though the spec says that each RC node must have an ID mapping.
> The kernel will fail to use MSI IRQs and fall back to a legacy IRQ
> mechanism that's not working either.
> Finally it will show strange behaviour around PCI interrupts, making it
> hard to trace back to an invalid IORT RC nodes.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] acpi_table: Fix IORT RC node
      commit: 92d448f4f1ed80dfaa2327eeea9a741717dc3847
[2/5] acpi_table: Add asserts in IORT
      commit: 0ae343239b702336d2c0a4f73a9a953d5a15b2af
[3/5] acpi: Clear reserved bits in IORT
      commit: fe8844f4ad7189a6309976ecc841d55735e3534a
[4/5] acpi: Conditionally set mapping_offset in IORT
      commit: 9c748576402cbc1381498e72800ecaeb99d2b355
[5/5] test: acpi: Add IORT tests
      commit: 636b62c265f8932f12b2fe1ce8b256868d16fbda
-- 
Tom


