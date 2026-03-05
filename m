Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71A5F3D33E
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1795D83F2D;
	Thu,  5 Mar 2026 18:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="X6M7eQQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0564183FA5; Thu,  5 Mar 2026 11:16:06 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC1483F2D
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 11:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrea.porta@suse.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so3793069f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772705763; x=1773310563; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9hWlYLQDO60DbPXwY1Q4HkCH37KiPdQJQzitx9lXCIw=;
 b=X6M7eQQCiUMb8pbbO13yrpMdsUAUo0PssNkem2JXl6iZyiMtyaNM7oyyqs4i/+z4Iv
 BCqg2r9BtstGG9kW7OxVxTrXIKunnCQ82PKMfqsTNvpKatXDKteWq7+beuY5lo8G6cqa
 pPCzL5lsqXeXhuaK7Lrl0lKx+nkTczf8USz11GZBFhTrjQWmN8yTywpmD8pjmyZ4pceN
 L5unlEitdSSiVzgKIB+EpU3xV7sBUBb/gtaSfyatqGeOsp5UEnFRTQ6Z8d9ISZEET+qw
 ArdXvQunCQwgiG4i+qD3rAnMWmbUr+tGGGaoqpU26huENSXzi9P5NyIQmUrnbBhK91yt
 4qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772705763; x=1773310563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9hWlYLQDO60DbPXwY1Q4HkCH37KiPdQJQzitx9lXCIw=;
 b=TGRcRsHmtVjKEvptxt1fgBZCRBt/YV8p8KQX35aCPouS2O0VIZWeQ34NYOG5y/omMq
 2J5Za6vl3v5dCb8VrThyi/v5eB7Kvu8UFfKwOO14loAuan0DcXqkiYK9aSlWbHlE4VZ7
 8V9EkfgrKMGWKYmjjxYOduQe1ISAoT6BXm1SSvi3GDw3rmfi+fj0enlBtyi8THdVw0MX
 XfGuGA8PZvXQF79Bahk5EM+DJ/GyoXnQp4igESmWfwjadsKacytbNSfemk4XKKtKS8kR
 09dtLz5PQvPDCTqgkDKd2nT6X4Y1/e3/1JvvxMlMBD8/4Fa4Kj36iSGt10mzyRGyAatA
 Hnkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkyHWda9N9j4bRw77V+vDnC0XffqPcp9/Ji+T8QZoGsXCPAhL3hIAq7A+bP+WfQpnBbOrtTu0=@lists.denx.de
X-Gm-Message-State: AOJu0YwTBQ+46xtbtYmqiJ7ywYaPy0Mjje1qkiweTpdM4Anx6sePbs40
 6NpNpqnGgYcPE8NE6RYaDkGLUP54RBuSv5HnT2ViPZ6C0xqLWPuTDkjSgwIBTEu3+dw=
X-Gm-Gg: ATEYQzye39UCkn19XDfYs2F32iUzpVfpM2C92fSAzk2snF8sOMihVzqk+bHzSsZf3lk
 RPoWJ1u4EjUm5plxoZcnoiJgOGIb31fVgV1id+/7jl3g2hPKhEDZhy5BFHE1vcbfgOmp4kcoZ2M
 V7DL32aejoMtqaLthV1hH9w8/1LmbBsKc/otz3SFvgaDH3jRg7eCq2xLJZP4aePSZGxVY56J/uQ
 8Gu03/BG2t5vP8CGa3i5uhHYdWDdwzLcOUz1UaeMNh0yUMZ3BMZkwgtrLhpXNgwBrNwhO5aOJrJ
 oI9mrd2LjzOsxLORTiLSYhSYixV0hIQF1XUafkkrEIZP1Uy+MtOEGU7WbZ8eU//hR5yGYmTCrOt
 k+YvNQgHP8Yce9iQfatezc2qFExjE9RqBo3WTavSSpDmlLUcGOKi/ELph3HiMk9JeSv6fa3A7iU
 ngtMGTl7OUUj1K5s7nJ41e+N2sbWRyhV77rzbcT2+gQFitNHbrK++mnO9zvDodXKEs1w==
X-Received: by 2002:a05:600c:348c:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-4851983beafmr81410305e9.5.1772705763439; 
 Thu, 05 Mar 2026 02:16:03 -0800 (PST)
Received: from localhost (host-79-12-214-40.retail.telecomitalia.it.
 [79.12.214.40]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad01d2sm33198985e9.3.2026.03.05.02.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 02:16:03 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 5 Mar 2026 11:18:57 +0100
To: Torsten Duwe <duwe@lst.de>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>,
 Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>,
 Andrea della Porta <andrea.porta@suse.com>,
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Huan Zhou <me@per1cycle.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/9] ARM: RPi5: Enable PCIe
Message-ID: <aalYkePRF7yj6fxE@apocalypse>
References: <20260227152046.42DE068B05@verein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227152046.42DE068B05@verein.lst.de>
X-Mailman-Approved-At: Thu, 05 Mar 2026 18:26:35 +0100
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

Hi,

On 16:20 Fri 27 Feb     , Torsten Duwe wrote:
> Hi Peter,
> 
> here is a rework of the RPi5 PCIe changes, hopefully the way you
> requested. This first series only enables the BCM2712 root complexes
> and allows for PCI enumeration. In order to be useful besides any
> already-supported PCIe hardware in a generic adapter, at least one
> serious NVMe fix is needed, as well as some device tree trickery,
> which I'll both follow up with in order to demonstrate the
> functionality.
> 
> 	Torsten
>

Tested-by: Andrea della Porta <andrea.porta@suse.com>
