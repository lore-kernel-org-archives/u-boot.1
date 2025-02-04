Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D01CC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9123F807F1;
	Tue,  4 Feb 2025 20:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X49LlSEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A783C80780; Tue,  4 Feb 2025 20:43:25 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876BB80540
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e3005916aso1506530a34.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698202; x=1739303002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jRF7m0biPu3L9nKXq2Cr7yN0jJ/v9MNi3qt2kw309g=;
 b=X49LlSEaii8NStmcmVqzKRKH46tSvFHAPer6bxOC1PjRUowZDpQd187cvW4b6oMQKS
 VvbidxDSws9bvQ6lZKYpLG7PaYAU9GIOMMrSogA4wvVOZDjFs7VpDR4wfgtfPjrF0lOW
 /kRgN4RwBbVGBmkX4uFXzcyLqI5A+VPTVi2P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698202; x=1739303002;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jRF7m0biPu3L9nKXq2Cr7yN0jJ/v9MNi3qt2kw309g=;
 b=mjXaMuBxNMborcyWnOxTigJqKw9L8SZHrdzfOzQqmHg5V0KdK1cIwNOmYJuYMTy4mz
 0KyjLpbLMM29Ivr4ciqXCnIysaYzNQCYeHHju+kwkH07rdpOfAwoJZUB6KJ3ZsbSYbln
 JtSN0cFShFmcutWyGmY84FoF2aiflXk3ZkL97dOJKSnbb8wcFs4rnyOBcV+PTWWQDIcw
 dBOQNCw4T7V97itrY2R2EPO9UE0Li98fudeAKIBZ+T418+L+35j9Oq0ES5lsyxT/yH7v
 M4sXvti7kaVOAFjiAXRHxmK2QrTQRcnYDb7BzGeJEj+X+X8X1HuyB7cYMLwl2lXj/Dtr
 nUlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Fj2yAO8HmTv0CqWXZY628wITJvvs0DQlv8xy5mLcb/fvY1JXH8XjvVLMsCdebjWzS5g68GM=@lists.denx.de
X-Gm-Message-State: AOJu0YwOd5IcZDys1UXiyru4/XspToNq21bZ9MK87ohWcs1ZeIa6Lwyq
 Vsxw6xjVKN3YZvgLN7qvy7Oz4U10RM+WbMsVIKlYlgPB3MMt63Zgf0D7yUiU/pNp5XJJThT8ZI7
 LzBQ=
X-Gm-Gg: ASbGncv2jtnuSjNa2pQw+logL0ci7ZBEUpi+0wMnjoMRnfJApGlajVggGuS7kph5mJO
 +5PCNPYK6brMenEblDo/1HPey71V1to+C6wyQK2DOci+gcLj3VzJIbAnVP82wFpmG82/2aGgNvA
 XOdXYkcR7pjjCi99Hpb8X6qxTncIeMHbOpCwqqCQqPJIvtBO1O6sDUgN4EQeazOUf6U3YZmwV0S
 kmS/b/d2n00je7s7vQYJvgTtxvh5e6tkqZNthNrz8cxsLHV/zCgDX/ucXcvfiPUzhgIZlLnnPDg
 WYLwdpjGp77VFg==
X-Google-Smtp-Source: AGHT+IHWBivX48Z/muX6NuZ+USGT7hi1XOV6dxzmGXJtwjgmKPW687GHMn+iXkyzLMJyEVfvaYSAxQ==
X-Received: by 2002:a05:6830:6805:b0:71e:eb1:f75a with SMTP id
 46e09a7af769-726a427a1a9mr141855a34.21.1738698202356; 
 Tue, 04 Feb 2025 11:43:22 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333690ba9sm3160867b6e.49.2025.02.04.11.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:43:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20250127071846.54946-1-heinrich.schuchardt@canonical.com>
References: <20250127071846.54946-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] examples: eliminate CONFIG_STANDALONE_LOAD_ADDR
Message-Id: <173869820120.637016.5977302308883436809.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:43:21 -0600
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

On Mon, 27 Jan 2025 08:18:46 +0100, Heinrich Schuchardt wrote:

> CONFIG_STANDALONE_LOAD_ADDR has been used for examples/standalone
> but not for examples/api.
> 
> The suitability of an address to load an ELF binary and run it does
> not only depend on the architecture but also on the memory layout of
> the board which is not reflected in the default value of
> CONFIG_STANDALONE_LOAD_ADDR.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


