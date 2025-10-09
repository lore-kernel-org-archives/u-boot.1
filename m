Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8B2CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 389D884541;
	Thu,  9 Oct 2025 16:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E+k3QuRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE8A8441D; Thu,  9 Oct 2025 16:18:58 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C8FA842E7
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c0e8367d4eso358339a34.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019535; x=1760624335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jWxrqoLnRHOn5n9P58LXxHRVRBfKhIZ1DXCSTS31ovM=;
 b=E+k3QuRlC5vBcOcABVTnS4UyNFLVausYQagBmHvD++dnFD0QZdpH3qXNgETI2nP1Fu
 eiZsUF8WgnNerSTEmbG0NHpOeOF/yeAvjRCbv+DJLAItdl/bZsKKd/cAfm6dDJzMdSfa
 HCwEkzeXY7CmXXXXtyZ+sS0ATyUaxNGOgMpHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019535; x=1760624335;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWxrqoLnRHOn5n9P58LXxHRVRBfKhIZ1DXCSTS31ovM=;
 b=K01jJHhbaSkVqy/B8lUIRYaEjScubKpSnw3JHMeRVtN30adeIrD5QUHQUlLvtTRYyS
 Z74+A2pdbJdh8QrfO30dhHaOxsDR0Bf0fpwLfxwovUH+cDvqgVQGZ1J9llPyfRw34AFe
 /bAXXkH+GYle0a8LhLsBIL1x5t6VsYarwI0687dILhwT4g+F6qs6RL7e06wScNqC+szr
 juiIvkLnpDt8UOajzsnKuD52J5slMK+Bn1q2r12MyLWmL19NWLbVzaEgtTVkz7i1FcCC
 WfVkeRUCCGBud2jVy7bJ8Gc9F6L5x9RLP1+I2S3CZH41u5DIlPfRQHkP1FYB4mkGCdq3
 IIPw==
X-Gm-Message-State: AOJu0YzEfoaoxpIcrJ91LSb2IC4U2iB/nJ8LK7A4ONUUs6nSaL2GpbY3
 rZuENhfBSwNhSAW36C4byfPGeKyiw+3tF7fqrCmBhG3BKTJrC3TUJGda0XHH4GLVcjTFU+x6glJ
 YB/eqCWg=
X-Gm-Gg: ASbGnctFwsMwpblddBuPYdvuLvVJdLsdp1YgIJmrjM+HmWFaC5jEN47Nui8wRefi2N2
 tUOF1fD5HxNMMl7sDDal8wcasdMPHHIByZfgdI7pVzAufxrjCF+WvOGyj15i5PmgcNBhiLPv7M+
 rqRK25fIdN0TNY/gQIgfF5uFy5XJMAyqiJpXD04f7iwXO7qdr3XJet78Km7Ne+9yooATLKcn3Vx
 YJueOXLxMDXLMHE7D58KJWGpMdX7nG5lKmWBVo04Gw33fMd7V/wkW0S37OYwIxbXigzW6JYOIZQ
 q0BNSSBmAbZ1Ih+NlW47iwJ0X1mJDN63gL3K5/A6L1dGUfFZl6xbwvWLNHjJExGl7/6OdR/dtBd
 mKTms/0VEXW+pR8hCHC3toPI0WM71XFpvzTD79Uh2Ob9g9P6kdLoinHziD9R5oGDR/pQsF/2I04
 viTLUD/CSp
X-Google-Smtp-Source: AGHT+IHyi34x/ZhY28O/awGZmbbbIv5d6SYHuQRBVK2r3QfsFwN5oEhqUEILSv/oK/7vuOmjbyaLmg==
X-Received: by 2002:a05:6830:83b2:b0:7a5:1be8:c184 with SMTP id
 46e09a7af769-7c0df71c1f2mr3960971a34.7.1760019535297; 
 Thu, 09 Oct 2025 07:18:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205131.3561949-1-trini@konsulko.com>
References: <20250925205131.3561949-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd: Make CMD_MP depend on the CPU framework being
 disabled
Message-Id: <176001953431.3159859.11999543970803020818.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:54 -0600
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

On Thu, 25 Sep 2025 14:51:30 -0600, Tom Rini wrote:

> The CMD_MP (and cmd/mp.c) command provide a "cpu" command which is
> mutually exclusive from the "cpu" command provided by cmd/cpu.c and the
> CPU framework. Make CMD_MP depend on CPU not being enabled.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: Make CMD_MP depend on the CPU framework being disabled
      commit: 583a45c33f3040a2e936c2d4012fe1b3a6edb537
-- 
Tom


