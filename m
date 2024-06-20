Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85EDC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 19:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443F088549;
	Thu, 20 Jun 2024 21:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nf1MhsSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD57888385; Thu, 20 Jun 2024 21:57:31 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3DEF88427
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 21:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70089223245so772140a34.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718913448; x=1719518248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwpER993p2pu/OV3KJQJzRtpxEUZJOsU49cFQrjzUCE=;
 b=Nf1MhsSrMvrqu+KWcysZGBbfY9Y2PJMyfoRC99UNGMnGNb7Kdol45vzmUQiwaC6zJn
 usu0mEGkLOt60XLbSgA8c1fOvrscRDCt85Jkdf0YXhmzHKoRAswJz9CvR2VKjGAfCIi0
 DCdcUj8/V2KkyPM2GbllQdC/ev82qIs+/ndYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913448; x=1719518248;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwpER993p2pu/OV3KJQJzRtpxEUZJOsU49cFQrjzUCE=;
 b=nR2K20Kb7O5rP6/NhM8UD4DTtgKbhKD+adzSWXHkj21efqHw3VHY4nrg3KnqpQLFgq
 m4edU3OX4rzOSDdPqtNC8cEuIJ1WjEpArKakeIFd0u4YXpT4z45ztxjSN5LOV2jAZ6CO
 SiumMBA3WpAWcgRax8ZIBef/7GDH4cL1pzlBcFMYlHZWA0Uvjl1e8CZ74JfCmX+f6c++
 ASpuRk2xvhKv8l7TJMh+J3Fc9x51hZnFsKb20lW0YuX7dMeh+DRpdVRoVrANX0tzhPB4
 X3Nxg3syU2q/PLQKEzH8lZPH/EnpYqG95HGw5+VToegKwWBlClvuJMAOCaOjM1qPHFJi
 nqDg==
X-Gm-Message-State: AOJu0YxyO0qwabmpQDgGxBQqc1E2YEV63JJYAtJekscCq9W5rKSGeOF5
 0oWZqARDRO72bhLMexT3EfW8thSyQSeSp/j8+bLERSvcY4Zr4QKIORjxpInv2bA=
X-Google-Smtp-Source: AGHT+IE9ovGtkbxEhDmVWErf9zaGCeF2dmU3qbmoqowzYdjFg1b2eGKNm2ADYHHhW1elSAgw7DKmlg==
X-Received: by 2002:a05:6870:148d:b0:23d:a1d0:7334 with SMTP id
 586e51a60fabf-25c94991d04mr7313209fac.17.1718913448564; 
 Thu, 20 Jun 2024 12:57:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd49d1900sm32958fac.26.2024.06.20.12.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 12:57:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
Subject: Re: [PATCH 0/4] boot: fix crash in bootflow menu with EFI BOOTMGR
 support + typos
Message-Id: <171891344783.3565130.947752382698893398.b4-ty@konsulko.com>
Date: Thu, 20 Jun 2024 13:57:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 12 Jun 2024 16:58:45 +0200, Quentin Schulz wrote:

> bootflow menu currently crashes U-Boot with a NULL pointer dereference
> because bootflow->dev is NULL for global bootmeths (such as EFI BOOTMGR).
> Therefore, let's check if the bootflow is associated with a global
> bootmeth before trying to make it part of the menu.
> 
> While this makes U-Boot not crash anymore, bootflow menu doesn't work
> for me (I have never had a happy path with it, but I haven't actually
> tried it before today :) ) and this was basically just implemented
> following Simon's suggestion sent over IRC. No clue if this is enough or
> just a quick band-aid patch.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


