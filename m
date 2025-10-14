Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88C3CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 15:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A1283327;
	Tue, 14 Oct 2025 17:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lcdZNqWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43C180107; Tue, 14 Oct 2025 17:47:35 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D35807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 17:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7ab0012e05aso3867521a34.1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760456852; x=1761061652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WjEl30AmvPVEmwFctgXlsqzgEZFEkENdhe/UZIDy/c=;
 b=lcdZNqWXrVtgGqzky5QK6r65sYTZpAA5BnqP04NHz9edbPllO+EGcwtZZlYKW54zky
 4chKEhhCW3i/vLhNlNnNDk6YQbpeNLmPxiboP6px6pcdX6JgDWvHheS7SUej8U8L+goQ
 HxK/m0ICBPAT94EOhaeoHj3mTsMW0+Izi5ZDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760456852; x=1761061652;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WjEl30AmvPVEmwFctgXlsqzgEZFEkENdhe/UZIDy/c=;
 b=Gn3wb5vt3YDCpkrNdq4UQodiHeOPy48d5EXhVCJuLoigOo3JTTflFPLNAIXUChUto9
 vcjHl44Vp3t6c6Y7SB5OteD8AJYcVk0/+YJT4gZtO56/Ypg8A8dxwddpt2OYXgDmkcYm
 /TjC+J4PSFenjxFLvADdW6uvF0aw/dm76aNDrl9Mkv+LfxCjsV/bhIayQDxxKzHzwmYk
 Kui2xwrk/8jhY4jL/OV5wfDHVxk4ac9A5M9oviJxLJvnDIkUyN4eD8lRdE6pvIrmTxue
 atiuOf9taYT05vh1AUZKY6d9cNVNETYQhNkh4oQbtNE3lvS62W8DRm8Ah2TXPdCj2Iss
 eM3w==
X-Gm-Message-State: AOJu0Yzg0Ytb0EPP8ND72cosFHh4Lt5ZbSXI/jgUhfJYRn0KgvVffnt8
 JpvEQMLraga02rpVW/WC9K8Jur5oDowXEOVsvN6mzeak3j60Jlrst8N37pto7posWw4tw6tkhgI
 UY/2hzxA=
X-Gm-Gg: ASbGncteYcqEbkIfWJ8+ysPoeycBg6tWWm8xzkner0aJ+Ha2+s8R9fAGqs6tGb3lbRM
 X5/lgnT8C0aC+N6AQBBHeEr3QdwIa02bsi7F25PiAj4Al4CMtOgjiCY+FpAHkDZLmGJSMFN2Egm
 tX36tjm7Lc2p5MSjrdFv+PbtlA3jjYgogMrDkpueekTZYaOU1VvdBfvSdxyLtOJ8JUtvauf8MAD
 rww/kQZrPeu1wDirWDvuQtOp41++3yBrxOBrGqPcO/xjGAhaSjYgSi4A1PZD3JPlzDL7vrguIVu
 YJuJg7+3idMbpGZyk0lBgHPy/pIGMVvD2dbSdRGyyEmE+fcYaT3m7uicsgSK1jxaHw/HhBqguxl
 HsDSl5Ia08L0aReIHOLvN7L/ZWmv8iUD5Xn3Bi2/BVaFTlXxtXzYAMth4AwZvLC4VvtHWdhWt+f
 28jdY=
X-Google-Smtp-Source: AGHT+IHlcI16sN+uylTvNcCeeOZeuw0Ych2I5OoPMW2kyGuCk41pypGet5LC/D1PF90703VGyX6LIw==
X-Received: by 2002:a05:6808:f8b:b0:441:c8af:2922 with SMTP id
 5614622812f47-441c8af2d01mr4960315b6e.37.1760456852558; 
 Tue, 14 Oct 2025 08:47:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-441da0b0544sm1455048b6e.25.2025.10.14.08.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 08:47:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, xypron.glpk@gmx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: javier.tia@linaro.org
In-Reply-To: <20251014094915.15693-1-ilias.apalodimas@linaro.org>
References: <20251014094915.15693-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for mix-next-14102025
Message-Id: <176045685149.294229.13714034307283967403.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 09:47:31 -0600
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

On Tue, 14 Oct 2025 12:49:15 +0300, Ilias Apalodimas wrote:

> A multi-pr including some EFI, TEE and TPM changes.
> Since the changes are small I included all of them in a single PR.
> Let me know if you prefer 3 different ones.
> 
> The following changes since commit 4e4a9de31de2a5f395ee25c59e4026422fbcb27e:
> 
>   Merge branch 'next' of git://source.denx.de/u-boot-usb into next (2025-10-05 09:50:57 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


