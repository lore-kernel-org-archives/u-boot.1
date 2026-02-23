Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428D8EC112C
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 20:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9042683C39;
	Mon, 23 Feb 2026 21:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VV4EYpYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E61583C6E; Mon, 23 Feb 2026 21:28:23 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A2D83935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 21:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-673f0b73dd3so2599254eaf.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 12:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771878500; x=1772483300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr/D7+Kbexvv8J5kV98HS/Ri7NL12Cb4TX9gs4vowhE=;
 b=VV4EYpYQq2K3xbYoW1hBSgED5FIaT1UEwYotWRZfb6f4JY5qilxIijlS63VaFZVTBb
 /k8HoVq/VuDSvGlLR6cw4Jree2eXBSt3zzaUSyvZP9fEf0730gimGO/dtBkVD2kaY+jS
 kDrdNBxej0/H8cSA50gNka2RwnkNB6Uyw8HTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771878500; x=1772483300;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lr/D7+Kbexvv8J5kV98HS/Ri7NL12Cb4TX9gs4vowhE=;
 b=vOoW+vnunhCjRtaA+vv/HnyEgFCMl8wcOY3ky2aruow4YnTCkBrp9PgKplRzmBt5rR
 7fQw2ma4sJ6P6WUCTkkU1bLCwP/4led1sOxajhq11d7uF8kA9NP/1ButAJWWXd1jbJEi
 2GHld8fQBlaBcO+EjKWxtU5+HnZrJT2z/Yu8wmL1rooQBUwT1wAIY2L8B5vBkRE6/I7C
 X6jPighLAXSg9Neik8u81QXaZbeC9slFqbFVipgWpSQBuWiZZgMH1iKbHztolsQAwhNi
 fFXsiKiUMYTdLkBAKrpNuKeEQw5LRaXbSj0Udr1KtfgK8PqJxef4JQTklQbUp+A7XkEq
 V6Xw==
X-Gm-Message-State: AOJu0YwsQfis9GWF00Rgc2PY2EFLlXz8cxge6dx/D4bSEKofcSyu0dP7
 IIifldxh7WdEbZt0RECc3zfwU/nVkAesO/i9P1nLRjMlNfPJo3W6Ibb/jrJ1BpBzjRwT8uk9I+w
 uzZJyHfg=
X-Gm-Gg: AZuq6aLIMJgGR/uTqK3cPo7o9kvVLQTrzVgEIix/d9mv0midUVxW5bwwvxpb8HxX/mn
 2ZoLCwqV9b5oO9U7cLTqgQlCma3VFlnBd5KVcZtPxC9qJT+QqOxOsTsUtIUI/i2tp9ouHFnMdBE
 iTWGg3q4PtmRMRtvE8/kNVERKi3vQ/J256mLKN41RdtEGgl5NCr5OUVfbpJaslKC6RgFOjpIvw6
 snmVeVzzTRrS8TGtfEqNZDSDksRfLy2EC3fH+szbSxBYMNeIoHmYN6kRgjnvTh5AlVUBOs50G6q
 74cUEt7KLEPFrYRGeFsPx8riUwLLRvebbbudAdjY7r3uheDj4RnunFPW2lZtY1723ZBpYzoBLga
 +IL+7/J8vpeAut9SzpQfF6uCYBooBwXAUS6PWCdWv+fT3sQevCiNamkW37Pz8AukfGdmnY1Nx24
 vJy+oAlwQZa2DOGyc+jmt4+OKCHbAscKt/IvnoQBbcXKQtW5MyV8o+2yOdgAhYLIFV26wcu0r+V
 ybuL7iXffx/KJiEOYEjqdPXkTEOxtVt1e61v20uM+1scjnF8w==
X-Received: by 2002:a05:6820:22a7:b0:66b:6862:18d5 with SMTP id
 006d021491bc7-679c4488c02mr4427062eaf.8.1771878499952; 
 Mon, 23 Feb 2026 12:28:19 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c56ec56dsm6899608eaf.12.2026.02.23.12.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:28:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Eric Kilmer <eric.kilmer@trailofbits.com>
Cc: jmcosta944@gmail.com, thomas.petazzoni@bootlin.com, 
 miquel.raynal@bootlin.com
In-Reply-To: <20260220194808.1146082-2-eric.kilmer@trailofbits.com>
References: <20260220194808.1146082-1-eric.kilmer@trailofbits.com>
 <20260220194808.1146082-2-eric.kilmer@trailofbits.com>
Subject: Re: [PATCH 1/1] fs/squashfs: fix heap buffer overflow in
 sqfs_frag_lookup()
Message-Id: <177187849919.3987051.5535085401243530182.b4-ty@konsulko.com>
Date: Mon, 23 Feb 2026 14:28:19 -0600
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

On Fri, 20 Feb 2026 14:48:08 -0500, Eric Kilmer wrote:

> sqfs_frag_lookup() reads a 16-bit metadata block header whose lower
> 15 bits encode the data size. Unlike sqfs_read_metablock() in
> sqfs_inode.c, this function does not validate that the decoded size is
> within SQFS_METADATA_BLOCK_SIZE (8192). A malformed SquashFS image can
> set the size field to any value up to 32767, causing memcpy to write
> past the 8192-byte 'entries' heap buffer.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] fs/squashfs: fix heap buffer overflow in sqfs_frag_lookup()
      commit: e365a269df5d01307390bdf7d6a1081d94b06470
-- 
Tom


