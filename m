Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9519C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 22:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B591582CA8;
	Fri, 13 Jun 2025 00:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VeEeGm1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F117182C87; Fri, 13 Jun 2025 00:15:29 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C720982C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 00:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c13802133so534706a34.3
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749766526; x=1750371326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygRHeFmpWGeGgtbnQB8JrUVUQrPLeDayH5sNuWkDC8k=;
 b=VeEeGm1LdutmBc5o+vwqsY/PMBfc6+yp9RoxjaJOl93vVXa8qQPI6Lbzjk3flk+SJu
 2bpQp0CBa5PH9BlMtUw3t7a/0+PvNAPbxzGU33htX1M1XdQG0tT9BjrR83bK4LuioX2q
 2OSJN8bSLUb51UfopL1FdwqUiizknoUKAogQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749766526; x=1750371326;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygRHeFmpWGeGgtbnQB8JrUVUQrPLeDayH5sNuWkDC8k=;
 b=c1SSGwk5zovVV3pd++yjJMcyBMklmDO3LuRULTUz64ojvW1M26tiWNGYuAST3/NKpM
 atqCtzY9JiD6/6S70APFo22JYZApqlpIo0PevbhXRB1GR76cdEqvX3tXpDaVa/mn246c
 TuG22SleAYrZjjpLFU+4Pn3wQxgGlrorSBLY9SdR0XK3uJ2BsgUU3SakV2lM+Sd3laRm
 II4ybO6apqt28jCNYLkzxn3SX+gx+aND8sx3yHFwDW7KaEOh2NG6SfMdIBCMbQMdyk40
 SaWppvBj8gBXIrPH4x7jza8e+Rigyh1kwV0cXpxCLDNk69+XDCrLvirfn5XPJW6bUfzH
 lLRg==
X-Gm-Message-State: AOJu0Yys2XiM0Sk0L9KRPiqs0EvotChnP+Vb+4bcx5ruAj0lni/kLxYY
 FgJoP717ZlV2qgkc7D1OGGlpiSKXILQndaD1GGBAuIuoP4o19myq9tzbT2uBMTXfCVM=
X-Gm-Gg: ASbGncsCuMna86UFGpirwEYVhkb6rVerVOQA7MJJKTIuWEvUq0osX40hIz/mktMb+ga
 hUd4NyTE/FTFWDxzzPU2INYgXKOGyrq4KPXu1c8/lVfrwLXM8evtwnQ+y+OFdWp6QUoaIaTRIJF
 beARrTs+Kd8QKqEzvpB8+l4MtaUyJwbg/O4kpZlWG9huVkAOooSHlBe48amUqEFNF7b9pYc7/bZ
 rtKxdPyd4pIqE7xiKKJbfi1TklA7UkcO5JyQQKbI0OKawQKgTGA7wHB2H8eclEXajD4qYb92Gff
 9RVjmtKDRe36UGK8a/ArnKSwPMiEOu9EciycC0jEwSXkSRIG5JsIoXpfTcEY8NYfddYlHd/ZuOu
 ZaEMf38B+ZIX8zMUxZHGx6wdTggH2iSJS
X-Google-Smtp-Source: AGHT+IEH+VjbN+0g5jWdpajWXrwCldZF6o9RRVwen+Tfbo8aONVSXh0IpQmby0nECIa+NZvLGY/ngA==
X-Received: by 2002:a05:6830:808a:b0:72b:b8d8:3995 with SMTP id
 46e09a7af769-73a27134f5amr284834a34.19.1749766526591; 
 Thu, 12 Jun 2025 15:15:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a283e3198sm7145a34.10.2025.06.12.15.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 15:15:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Richard Weinberger <richard@nod.at>
Cc: ddrokosov@salutedevices.com, sjg@chromium.org, tharvey@gateworks.com, 
 ilias.apalodimas@linaro.org, kojima.masahisa@socionext.com, 
 upstream+uboot@sigma-star.at
In-Reply-To: <20250529150213.27149-1-richard@nod.at>
References: <20250529150213.27149-1-richard@nod.at>
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
Message-Id: <174976652550.365589.4489095631856636528.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 16:15:25 -0600
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

On Thu, 29 May 2025 17:02:13 +0200, Richard Weinberger wrote:

> Although if we we don't setup an initrd, there could be a stale
> initrd setting from the previous boot firmware in the live
> device tree. So, make sure there is no setting left if we
> don't want an initrd.
> 
> This can happen when booting on a Raspberry Pi. The boot firmware
> can happily load an initrd before us and configuring the addresses
> in the live device tree we get handed over.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] fdt: Make sure there is no stale initrd left
      commit: 9fe2e4b46458f9c4ec6b8115ebf18b4b26fe6127
-- 
Tom


