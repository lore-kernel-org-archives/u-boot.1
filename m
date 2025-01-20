Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A898C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 18:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB80806F8;
	Mon, 20 Jan 2025 19:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l+ZJAZp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15EE7806DC; Mon, 20 Jan 2025 19:07:32 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F456800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 19:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e1a41935c3so67937576d6.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737396447; x=1738001247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ailfc6AQguw0YrPX+RrCP0IwXuBjrJLKovG3gr7ays=;
 b=l+ZJAZp8TlLBi4oaJu0oPxU6dSt4j2TJ96tcyJn6FfRpJBhojdQz14K11D5ViJMBMM
 w4+5mWlVDiI6BsBSglst4EGfoQa9BsBtM7orBWH/lI+fsvhDhuhsyVPKzSxLfn46IeFT
 uzrm0saV1jhTLUnxBrIVZ9oNSmWPVjeFcqjjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737396447; x=1738001247;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ailfc6AQguw0YrPX+RrCP0IwXuBjrJLKovG3gr7ays=;
 b=iHZS6IeGJS37T8X/WPu5D+eNuR+M0G9H7JaP/0H8zKJP91WgH+MTYFc2n6flQ0K/UD
 KlU7vPOvP8NR6juPy/rDII83nxfbpWXCggb1Jm7g+okf5IF77J7tgvnCB2DCg82aMkbx
 /GZyR/Lrf9GenO21hMYKCgXWkp5vyIRAQysUZAmLGyG+7XzNKcHFQr4VWjnmzhQ7GaFv
 seVtNYXs5S9rJFJIzTH6Yc9/SZfVfjIQS6Ef6iSTX4vk0LWgtjxIR7zsMVVlS6z0QYzF
 EJHxg2BrecZ76aeNkdvwsBcnZiPlg+Hx9kJO+h0Qxts6Tkn0RGeFP8tSUg1FM9t5oosW
 MJ1g==
X-Gm-Message-State: AOJu0YwU9Esj7fehQZ5Eh9dPbJHD3hjLgLzE4rb6NrWu52LU4byWUGjn
 ASlXwmU55eAbXloVx/6ZFtRw4DlqfdJ0OXEZFz961WUC2cVEderDizESf0W6AS8=
X-Gm-Gg: ASbGncsJ/Q7sy2FyfPDuv/lvp8n0+XH09abvFZwms323pXZXoq8gQZP2briedlNchs1
 XNg/y8FOl6qlYRXwCQxl+GJdwCW36fF/Y8KyFflBlwmfH4oSP5DvXZLTTPZlln6MyUh/xc9WMhJ
 GLvig8NI/Y8hPZIOqmlXetw66h4ecom3y3aEVy7SQJSUqRWnctwvr8bOfOorra7z/RRCxmh4Kzt
 0kTjd2Uo+u7I8xeSZdS6Gh2UbPQKmRMP41ZjbzEnSd+pi5yf+DE1sJ37iG0dAqbOw==
X-Google-Smtp-Source: AGHT+IGU6tu6yaZ/kykckbvOGOiWzfRqZa0scwCPqpHl7xIN8SuCfcNVYvbJvI7CcuqBwpfVd7FK1g==
X-Received: by 2002:a05:6214:3b81:b0:6dd:13b0:1008 with SMTP id
 6a1803df08f44-6e1b220a25emr201217726d6.30.1737396447165; 
 Mon, 20 Jan 2025 10:07:27 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc230a4sm43258946d6.50.2025.01.20.10.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 10:07:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, afd@ti.com, Jayesh Choudhary <j-choudhary@ti.com>
Cc: n-francis@ti.com, m-chawdhry@ti.com, sabiya.d@ti.com
In-Reply-To: <20250106100400.93799-1-j-choudhary@ti.com>
References: <20250106100400.93799-1-j-choudhary@ti.com>
Subject: Re: [PATCH] arch: arm: mach-k3: j784s4_init: Set CTRL_MMR for
 AUDIO_REFCLK1 clk_sel
Message-Id: <173739644587.2747182.11195843476322907073.b4-ty@konsulko.com>
Date: Mon, 20 Jan 2025 12:07:25 -0600
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

On Mon, 06 Jan 2025 15:34:00 +0530, Jayesh Choudhary wrote:

> The default value for the mux to select the parent clock,
> AUDIO_REFCLK1_CTRL_CLK_SEL is '11111' (31) but the mux input for 31
> is marked as 'Reserved' so the ti-sci-clk call for get-parent fails.
> Mark it to a valid value, '11100' (28) for MAIN_PLL4_HSDIV2_CLKOUT
> to get rid of the linux failures during boot-time like:
> "[    1.573193] ti-sci-clk 44083000.system-controller:clock-controller:
>  get-parent failed for dev=157, clk=34, ret=-19"
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


