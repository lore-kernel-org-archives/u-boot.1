Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4F5C369A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 01:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC25E8391A;
	Thu, 10 Apr 2025 03:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fjlF2l2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3331383987; Thu, 10 Apr 2025 03:46:25 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA238838BA
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 03:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c7332128eso166853a34.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 18:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744249581; x=1744854381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ji9f+LuZ9zzfGFw/7k8GGdM8rNxYe7Kz3lbPQDgKxgM=;
 b=fjlF2l2JP12BtzCCVGFuyjB33sY+38U3uNlm9rZhAtkJ9g/P0aIscFJQprzW4eQRQS
 QXnqSuqLd14jQgYiPmj/n6Sn2AHUur0Ltce+0cU3yNiAmYlrz4ra8SdqgpeW0Oszekrs
 tLNkZgLZYFCsE3CxZciFKrGJK/+bggayrDD+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744249581; x=1744854381;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ji9f+LuZ9zzfGFw/7k8GGdM8rNxYe7Kz3lbPQDgKxgM=;
 b=bzORp9F5FkmRveko4GV1zxo7bzxufzaTb2PfIir8dmV7Wi/pbyWMguMkEpM2K8Epos
 IIiJONOi2mun4Jc3aJ8cgJ6xLe8xQwNBmMhp0inwUZV5gbAT9buTTC2C9FDDlV8oBX6L
 xzIGrGty1V/BcrTOvxsMubMAnulnWmjfhfSeMfTStPM+wdC3cOhWH7r8uWk1Q/UAOTsb
 U7bQphSAnIfuPEAZNX9vqJ6mmWBkHPDwLKU8ES4uzDzzLkgWdTzMhe/4v8Q5x8p0qYQ5
 SwPQR5ZKxfRTkR4reb9dZiCsC5jxActKUVITeBY7ME6y79n3Li16zpTyyz9ygqKahkhk
 DBHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpGht8uvzm+LZxd9nlQoym2ng89ItLKy79NCDtzZHVPd8jk1k9IZhai7Ans/NaOVP8Q56/iTA=@lists.denx.de
X-Gm-Message-State: AOJu0YxMnqRThxaV64px0AsR/pJilYOOOdEfcTGu4DndKeqZ06VIKF7p
 Gzk/WNTzwvHxh6WBNJfr4CUou9LeA7sRRLeYD0/dOeBjJP4HKYl4pJuIT+so/BM=
X-Gm-Gg: ASbGncv62XwhkLqxak9NT5X1pSSJ5gcAmNbL88+Nh3OcUDNqpS9wUndqYjX4GwKeTKt
 108jcB3qmjluvw0LRsfI1p0PEeGlsAAA/Uh7GBe8jl8S7iPQBr2WWK0Jo9RXREAAs1aJVmDoTBC
 WHhcfoPYhroNXJQ1Jai3o/7oZKehJRcpAxd4Jpnfv1CG0eHRe9EmakkhOJFUHxUnc7PzhillST1
 A48T7wXNEqZo6qr2aAjKSrMJ+OFB3C8ZxaeRY2RNoffDlBTFma+Hzk/EWqSIHFRR+OXFNB4QWEw
 +FEkmFYT1r20VL1CA0QqdshA7E0l5/R4C0dYzTwwWOjJmln7bC9bL3EDVnS1ZFEwGmY9pBCzrVs
 m
X-Google-Smtp-Source: AGHT+IEhhA+WHX8jkVKHr2v3IdviBg5O9zLKhV92SBjkKI712LraYTEB2O3PGFYAaMFyHLhDHRDEaQ==
X-Received: by 2002:a05:6830:2aa5:b0:72a:f44b:13ed with SMTP id
 46e09a7af769-72e7cd260cfmr395589a34.2.1744249581692; 
 Wed, 09 Apr 2025 18:46:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd3764sm474569fac.31.2025.04.09.18.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 18:46:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
In-Reply-To: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 0/5] acpi: simplify updating ACPI table header checksum
Message-Id: <174424958013.1824423.8342331034844045748.b4-ty@konsulko.com>
Date: Wed, 09 Apr 2025 19:46:20 -0600
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

On Sat, 22 Mar 2025 00:21:15 +0100, Heinrich Schuchardt wrote:

> Introduce a new function to update ACPI table headers.
> This allows to simplify the existing code.
> 
> Heinrich Schuchardt (5):
>   acpi: new function acpi_update_checksum()
>   acpi: simplify updating header checksum
>   x86/acpi: simplify updating header checksum
>   qemu-sbsa: simplify updating ACPI table header checksum
>   arm: simplify updating ACPI table header checksum
> 
> [...]

Applied to u-boot/master, thanks!

[1/5] acpi: new function acpi_update_checksum()
      commit: 69e61d46d2dcdcf84a3a7aed7cf74ac3b3b850fd
[2/5] acpi: simplify updating header checksum
      commit: bbc78592b16d164fbb252455d6a60afb3ee52709
[3/5] x86/acpi: simplify updating header checksum
      commit: e0055ac9bbd3059c961b1d7f98dcff276502c847
[4/5] qemu-sbsa: simplify updating ACPI table header checksum
      commit: 5eca1696d25f61ad58582820f8477360c81b8b7b
[5/5] arm: simplify updating ACPI table header checksum
      commit: fecc50b0517d362b4db173b08a769f7b975d8255
-- 
Tom


