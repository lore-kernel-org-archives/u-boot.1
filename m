Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98647FF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51AF2841D6;
	Tue,  7 Apr 2026 21:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YtekvfoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C5084129; Tue,  7 Apr 2026 21:50:20 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E124584144
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67c250805ccso1766672eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591416; x=1776196216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fhERvJSBldqjiEvAEp1MpsLZS9fIQGlrRPnKN77VzRQ=;
 b=YtekvfoUda7P7bSaoa4CsYJtibULnuEGuZKGF/NhDQYciuSCBg08CSAA/ecrwzmb11
 Fl55M71D3SHDRfygE/FG8NpR687dcR1bHxlBJnuFKF5c3m3WT4hZ/wgY0QWRR24VaRNE
 WjuBR7jrsR+i6VAsRvN4thmkr77/kgEYfjzek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591416; x=1776196216;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fhERvJSBldqjiEvAEp1MpsLZS9fIQGlrRPnKN77VzRQ=;
 b=NvAYWSK8/Y1X1fz7cS1V3BQPINkysHZFWUeaZYxzsdlXdsSigHCOraVgoRTEQmaP3Z
 4bEbak7q4Mnxf4rDQ75BI+71+zUcTojD0MdwMcOnOPD0UQGY/kSNzwLRR+R+4r+DGxXy
 jX2ZhpxGqkigC8CDMQDtBjsqz5qqNlalgFDPglYh6gYqxeM+HYgo2F9BbW318HDZP3Bh
 lFTXTiKLMGTJ9YsNhAiDIjAE7DxJEFQ1WsTGSV8Z0LUfgl8TWnR6HeblhtDv2Lbob1A/
 fHdDj7OILSVFqYXzjOiAp0k2Z1rDvxxjyIlnVepgv9PJBa5x7SPv09Xz/RjXEAi7wMfj
 /AMQ==
X-Gm-Message-State: AOJu0YyUem6BS2gUi41Vr9A71MuZKOdbJId4lwR6YAROtgRMzGDJUbBu
 rZPzLbosWZdTJZhMN1oLp8o1+aie8WzhUzSZCz2mGz2K3dtE+h2q+DvgmHAQbQYJaRwPJNyoksh
 QUgFJozA=
X-Gm-Gg: AeBDiev0vhJvL/6isGYUiaekN9lpbavrHPmEwTrlJXDpe3Y8D8phx4JewQkphD8zkGr
 HBWpxIVPcX4kLdrMm+ObIvS0avVK7BWKfmsUvNxoWIYoBM982hAT1CB/MzZ6ST/qlqjwlWvl2Me
 XB5slIDZQUx26WmooWr6TwUczgq0S7uHE5xF/1jIJzFse6NhHZG/BmiUpEyWaycSG3w8sCeLTLR
 oeU46T5cEZUpF4jotcXH4bOeA6a5HE2XkuT0dCj9Pe4BmlgBbPhNZLb4D8TRpioNWAu8+pAMmA5
 r/XKNWR4jI24Ay7I2OHSbrmqO6KNuomci2rW6DbxDGr0Y2L8DigtZR09f+wr6fOCwu9oEOQPnyn
 xNH6I7ev+SoLXxaoVCKwvRxYnsPrYiM/dbt6Ecw5ypCIIKVrA+LDx62QtGxylKlb6XzfRl6OnZj
 NCKNcAvvOX7KHSm6XSB7qRbxlu/f4fjQpb9s5tUV2/Mh3WmURfd4EhMHZ1hhqjsBqKqhJriAIGI
 RQ5CkES6R8+WUp7HCyRkDFiyt/F1lyvM7pFee/dIveswQi5N4x9/JF8Nw==
X-Received: by 2002:a05:6820:1c99:b0:685:a06a:89d9 with SMTP id
 006d021491bc7-685a06a8c44mr5390741eaf.36.1775591416608; 
 Tue, 07 Apr 2026 12:50:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195304.2363593-1-trini@konsulko.com>
References: <20260323195304.2363593-1-trini@konsulko.com>
Subject: Re: [PATCH] serial: ns16550: Fix an "unused" warning with
 SERIAL_PRESENT=n and OF_REAL=y
Message-Id: <177559141603.2108693.13852808019538643857.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:16 -0600
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

On Mon, 23 Mar 2026 13:53:04 -0600, Tom Rini wrote:

> The definition of our ID table is guarded with OF_REAL however the
> U_BOOT_DRIVER that would in turn use the table is guarded with
> SERIAL_PRESENT. To avoid a potential warning we must also guard the
> ID table with SERIAL_PRESENT.
> 
> 

Applied to u-boot/master, thanks!

[1/1] serial: ns16550: Fix an "unused" warning with SERIAL_PRESENT=n and OF_REAL=y
      commit: 25d55485dbced189f8d0400fb0da58b19e196662
-- 
Tom


