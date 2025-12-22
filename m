Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6430E6B257
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 22:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF1683EC0;
	Mon, 22 Dec 2025 23:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bQFXMCxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F0183F50; Mon, 22 Dec 2025 23:26:26 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF7383E83
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 23:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c75387bb27so1838196a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766442383; x=1767047183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IEwUFyU9IQyaIFB92amRugd3JL2vhLFNLdl1ccGEuyA=;
 b=bQFXMCxT/Vw287d7I3evW3OIhaKiiHJsG1c8PrC0NXFbJYDouHP6mN7dNGrduSM72C
 mA6hDPYuv0kSfyn25/uO2QmVkeYVOweK2ofCChL9AcRGK9tmbUM+dCdwfxz7gK5d4WXc
 2SxvLv2KrMDBBMdURcE+jSwZ6UmVyBaB4ktCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766442383; x=1767047183;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IEwUFyU9IQyaIFB92amRugd3JL2vhLFNLdl1ccGEuyA=;
 b=Rt2k2Zkt3g8jEKonTfLOm2Wa+TLgq+oWza8R4dZwMntURSJBvnJoq7l84r+8LMDylI
 jWBYfbKEfzQeRfXGXLBEDVyIyejBEa7fp37kH80b4Igk595s/Fqiep36YnYhHdj11R+j
 YIvS88RhpXe4oQ8SiU5hAfHOzaMIi/qH1LhLToOBluAtJJ9V4wqIguaKXaPSjgG38cES
 SdH+jaqaGx+OU75pRpEeI12GS8irVwAi+pLIhzz0brfvLCaZjM9ApWA/PdT/mQBNWT22
 dPOnuRf9uMSNf0eZm29BHgMFfbwaDmyZcmXYHmVCXp5njtfAUd0lIXIFbfLfG3NE/ciu
 +cdA==
X-Gm-Message-State: AOJu0YyvyLmVE6wyr61wbSqyGlIyqwTWmyhEBwgYqP8vCUCWCAZ12Ysx
 CP1QyTgSx3oYbFqsKptk++zc3lpYgAhPBSTXIm4uNXlr8BSf54tE2NyFui3En8B1IQM=
X-Gm-Gg: AY/fxX7y+TeE8+moxhjWV97QkyVKw4cU0x8yVp/A6ZnIDO2svtdIuG6A7DUCyhCTTNc
 aMKn7k5SiyPY9HtUINerFu+W+NUq0VLl265/4ssn4CdfHxG81TLzcULoCcSksEeeDEFBF8mqsDM
 CZ3pWQo4Ah1YoUc54rGH3mI994nVL7o9Y8p68Pr9lAye5NEzDiINFh/CuvSx/LhX+5IzcvGw7Ke
 af64jTw9KEdE5mml6Zf/Iuf2nTRiqi+cVMFXTKmM+VuAjYFPTm3u5Igsa5lzpOSxPxcITjoDrLk
 GeTiW2ZqPTuRTLJmBdzLASTYFWI2OJtywh5tvLVHpMJH3rq6vP6MOXfdooXf2ixVKH0FcVNGRhd
 cwKSUSmZPXu1SNnLBQi9uWyhX/32A1C3rG9pEh4rpe0q7CjKbM6NzlgjE5QWSRAONlEM609lLtj
 xRKyEQ7pWfXH9lYel4QtBiUPx+pTKOF5gRIf0QvNU0qU0M5QIZZ6NUfFKuBys=
X-Google-Smtp-Source: AGHT+IEGgcXVSRyRWmUW+1RJj8tQKUH1rCRTyHTC6bX0LepV640Y5+3U/9CgpkE0NhS6qG/Qw7qJaA==
X-Received: by 2002:a05:6830:3595:b0:7c7:da3:ed22 with SMTP id
 46e09a7af769-7cc66a9fbedmr4090158a34.32.1766442382850; 
 Mon, 22 Dec 2025 14:26:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673c32esm8283376a34.9.2025.12.22.14.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 14:26:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Brian Sune <briansune@gmail.com>
In-Reply-To: <20251222142744.74707-1-briansune@gmail.com>
References: <20251222142744.74707-1-briansune@gmail.com>
Subject: Re: [PATCH v1] fix PL330 CMD supported target
Message-Id: <176644238211.926535.8674248218182274933.b4-ty@konsulko.com>
Date: Mon, 22 Dec 2025 16:26:22 -0600
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

On Mon, 22 Dec 2025 22:27:44 +0800, Brian Sune wrote:

> The config is wrongly written, result
> in only support socdk board.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fix PL330 CMD supported target
      commit: f26db83ca964e81d7f2b3c2c984afdb8bb104678
-- 
Tom


