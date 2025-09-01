Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51427CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 15:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942D783990;
	Mon,  1 Sep 2025 17:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BO4MaNlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A077983A13; Mon,  1 Sep 2025 17:49:43 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC3483965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 17:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30ccec59b4bso4011509fac.3
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756741780; x=1757346580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52EB6Z0jKZUsV1eLz0Ry0hFx/FyhW8emWvABSQtmrRA=;
 b=BO4MaNlDozCAJYL7kHaz1C3R8Yrc7Ed9jOL0bR0SA01Lgw4vdUfcG3xkP95ZJxpUrD
 VF6OlZdz2koU7hrr3PszwnnhVmuCj3LrCZELAL6keF8ju8lyuYG8IxlKEt2oiVgc6x89
 tZKgL+J8/MYmIda2eyOIyyr93AJRsCYbCmAjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756741780; x=1757346580;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52EB6Z0jKZUsV1eLz0Ry0hFx/FyhW8emWvABSQtmrRA=;
 b=fgNhoihXOtmJ5RTN15nB/NOAjfLCqsySUd4+13laO1PTReZjPp/BNzja7gL8C7z6VH
 8xWHY5BUC9OLORC0fzZgJFlZPbOWh67p7QgOQfhHYzsf1wp2vilygKbDY+ZFCPv4dcYJ
 xCIgqQAhjflkuAusDENjjOGagAenhsTzkrbSBCUxUN8g9XoxU6yDHWp2PadIASbqb4+r
 vm6rLy7y7knGQchFMI5KtKyr668007vDPj+Rw4z/O1O4Zms0MWqrYTkfiY8Ld/61yJnH
 r98kYJqMlCWOW1wca4/3spfvLVJwG4P9hyeIzqxCkzyoobAVoi9gmnteMyaRsKklJ4yw
 VcLQ==
X-Gm-Message-State: AOJu0YzHUf6ilc12Iel66vqHEl5NbdABf4kIXKzCH93xGOAp8PHVmITu
 nFeWF1CUKB8Oz59RIOl9OBZnECbhn2Eaq9lQRmvdAekDVoWad4cVVYe37UVYAJHCGstKgMP0gb/
 3mAn3jX8=
X-Gm-Gg: ASbGncv6WpH1xB+8OQjKAs5UsodyVWdwBX1VhJkKMaK6BBa0FdyjdZdekmSoDV6/IsK
 phv0y4CmpH0XBgk8N3+Lp2/b3xx3J+BnWiEgR13U6RgMlaDB7pKM8D2xG5sU7y/UM1cnlt1q4aM
 JfzgEAvnX/cnfP0hGXwlG6NJKeUMPVwnjGMwf6GJLYmDRpmAfBBSAVxXgXxrl/ONQMZB9bPaIZZ
 V1l845M0NC1aF95ce2ezhzYc2axytUMgSLxFSNdzyk+59g1q8lWmUHX+NfpaeVHicPsr1EoeXFf
 A/nBYN29LngU3x7WuUU7Aht10Dg1lrb8Ai7QSTPP8fhNPfR1gdxKc/lO48wssT3+hJUxSe3lzts
 2aUrHmYraY0mW5ODBxuqw5sRiH4cBovLCIkDtxVR1JS/yNrC8v/434v4=
X-Google-Smtp-Source: AGHT+IHs5jSqWDo7a1slTOGTlENvAf005EjtmQCgacBkxqtDlfuQJ/O6Ze15Gk2d6I8D3sRL3b21WQ==
X-Received: by 2002:a05:6871:b0d:b0:315:8edd:2be3 with SMTP id
 586e51a60fabf-3196306a37emr3586825fac.3.1756741779870; 
 Mon, 01 Sep 2025 08:49:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74574388519sm1077588a34.21.2025.09.01.08.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 08:49:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Adriano Carvalho <adrianocarvalho.pt@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <a70fe45c-e278-41b0-8911-cc6dffc8263c@gmx.de>
References: <a70fe45c-e278-41b0-8911-cc6dffc8263c@gmx.de>
Subject: Re: [MASTER] Pull request efi-2025-10-rc4
Message-Id: <175674177889.3082043.16250993259336493976.b4-ty@konsulko.com>
Date: Mon, 01 Sep 2025 09:49:38 -0600
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

On Sat, 30 Aug 2025 22:33:49 +0200, Heinrich Schuchardt wrote:

> The following changes since commit e4c8b32d03d7ecffd586b7d33336603ad639d7c0:
> 
>    Merge branch 'master' of git://source.denx.de/u-boot-usb (2025-08-29
> 14:58:45 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-10-rc4
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


