Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC52CD98F2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 22:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDC984931;
	Tue, 23 Jun 2026 00:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KsicaB+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E4884944; Tue, 23 Jun 2026 00:22:47 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A919B848EB
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 00:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e6d14aaef8so2081800a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782166963; x=1782771763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDLjuem6/EgmX+lXVx3Ev4nz6zAVZHY7amvu4W7QNvY=;
 b=KsicaB+j9ARTOniRKkki6g0k7MAQXmeEBOvDLT1xVFDbyD/EmIN2sWNL3Uwqb9Rfj5
 OogbL3ONTXOSheRxqphXAsT5Sxgs3ssG5TZfxLOSGvVVZiLJinWIFadTq7+4pHqpOhDy
 Q7eK7f4tB+9nnfG6HGiiYlohQNCFFapbKHpi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782166963; x=1782771763;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LDLjuem6/EgmX+lXVx3Ev4nz6zAVZHY7amvu4W7QNvY=;
 b=fZt9de02TK0aG8r9obId+SIe9sIyWxodnlmM++07yC4SSQSyIOsSrnQx6lz434J4j8
 NsPCqH8xdgxsLNFL/a7wQ3TMoZLa095a8+12q1Zya/nDSvhcyAkFgQkQaNUYhLZcG6kj
 4R6ZXpBPXdF8h+1tewPWaWFwtgUMdecbLZBu2yGF8V4ZNiAS6fEoHZQ5UBho0zeIcqHh
 hQyvlZzsVZjejRtkzn8qpBXOKhA0a629D1n7DCDrLwHxbsjyddP0K5lZYN1cZCTa+8Ps
 OXG8KTTbXadcG6T3QfcOAb26DuSFjBP9gmSLk1cOW/99S0C18zEtKB40cBpuF7NYvF3x
 jQ8w==
X-Gm-Message-State: AOJu0YzUR4UgMdIFiSLtCLtu5sdLEEByZpTR/qa8eX9xbNm3EFe8iMhk
 Yp6vMtu5pvpEaYKbMA0/Q7Bg4Dj09IzOc7e3/AeFmUq7UtM10FsVlqIsM18AaFHSsXyhlGf8OZ6
 UXP6+H3Y=
X-Gm-Gg: AfdE7ckhpTd4QEkOMd1FDSBZu4PrWkXhcOOHwC+FJLxmqBzTfEVfM88gbKYePHEUe5x
 NVv/ZaJSxrEjeo3wrtEYLgdUb9+6emDYIxDACFLpPHJYElHysGav1vcHc7QcPHISbD8tqVeau7T
 DPX8lGH4Nk9+sCCWpfy4zmRBdxqJ9qJyEieEa/aASwl7Apn2bsNjYOrXbmsLaJI5XIyyGEZDqEt
 gwHRou7udwSamHzbpljnZcITZdwNxePzi4eVdxjCXkdk1EmTslIlUlXbSW16miBRZgueiLbvCBJ
 kxNfuDB8YSCna0g57C2We5SUopnfQ5w678qxVtQbbviQ9CseCk+3tuWP3xRfKi3Qa7kalQmDLQX
 cFWA8ZHd8pKLzYwcLBoE4sDeml2Sg8K2OiImbQVjcI4lD62eDHUXAHqSSzrF7FEPt2dpYA0rrrU
 do92j2sMx5YwlpOZfE5LGEduCnCwVzQmiDOjhLcHP9t4ZqLyB9Isy6psih7BBVS145G5VN9Sk2k
 zfzVHFXBgQ8w2eMG+bRL3CN/nZTR2tKQw==
X-Received: by 2002:a05:6830:700e:b0:7e6:c752:3f0c with SMTP id
 46e09a7af769-7e97996c452mr41108a34.24.1782166963215; 
 Mon, 22 Jun 2026 15:22:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-245.totalplay.net. [187.191.8.245])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e94429778csm7506887a34.20.2026.06.22.15.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:22:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Francois Berder <fberder@outlook.fr>
In-Reply-To: <20260622140616.12182-1-marek.vasut+renesas@mailbox.org>
References: <20260622140616.12182-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <178216696259.1691113.9143134411838154940.b4-ty@konsulko.com>
Date: Mon, 22 Jun 2026 16:22:42 -0600
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

On Mon, 22 Jun 2026 16:06:06 +0200, Marek Vasut wrote:

> The following changes since commit d57ea0d9edf5e5babffd280f7352f23a33a00948:
> 
>   Merge tag 'efi-2026-07-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi (2026-06-21 09:27:12 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


