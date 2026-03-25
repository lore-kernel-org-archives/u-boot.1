Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C18109E528
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A3D8409B;
	Thu, 26 Mar 2026 00:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F1WqfLY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90AE583FBC; Thu, 26 Mar 2026 00:05:58 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1752C83EAC
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d7eb85fb81so330504a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479955; x=1775084755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyroMp9dhQ9kIWUowjpHh0N4EYSQvzF0citG1/yfhrc=;
 b=F1WqfLY9AzqxnDZyrwDxX0MITmIw8IOpPuKvFBDqpj+RS5qtVZzyUVT/S+OJ9bsanH
 Usp8OzUq0amQ6n96RQJ3aB4UGjfMvkNSZtIxoTJ/yOgEdrOFrGnmgov1be9yPLjYmr6V
 A5dLWWdFgeYuPw+ptkpzffCbPvaZC0tAkPzGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479955; x=1775084755;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lyroMp9dhQ9kIWUowjpHh0N4EYSQvzF0citG1/yfhrc=;
 b=aZ1iY/IusfypHtMNxDQpo7WGz6hSfQ/GtMLGhVnWVPi3jyN5FgQQRcaMwG63i5CpIV
 NlErWCb07GKstpMEbOgntTtHJvVtFpKz9pW07GXtP3S9TMj/GOD/feaeD9lxsSk0gLMk
 CFERXPYFkU0I4O3FhTHrO4L30eVKz4CAvnSz87BF6ooI0b7n//LFnkl7K2idDP2q4UwY
 9J7xHGr6BCS4PmbY3CECEUrtzSMjHUCgNAoLiOGwsP6z2vU3q3SzRh62SuAvyikDDr30
 KikF7Esc4wlxLxOymlbAXVPDhJlym2TBJFAbXhvOjCcGY9AbplBfXpFbUFB6TQ7pXVVy
 lqTw==
X-Gm-Message-State: AOJu0YzJDhh9JotwofuQWv6y/R+NvXcX5t+8Z1PqehIGmmJXvVlRpnlU
 JZayQfAkyRESXedpj1dNYFWw22Xe+L18RrgSfSbLCs7dXbVZRTvvtcH6YYyZfs6zxCo=
X-Gm-Gg: ATEYQzyfDznfXB9VALRx4vWEJ8/hRUfw3QckGpqEIiaKSI4tAlQfKSu0EHUm9Oqn2Ty
 mNsq8ogYrmrp0BjY9PcjdXlnQE1qBtFMBSUYmSVjFVL5X+R+7Hl0I7aKe+eMeazVkM8+PSO3dvS
 sNt2wjo1rwHHACb6y4WdLtUM1P/gvrnoQm1ODMZaIfJojxWP9nAVxSpstOAO5c0qmgJNyQeNoyT
 BMlCVDpY55jMxG52DFkHxALwlfTU0qMz33zS1RYEvN5Vf4QIvJKC3sE35DcV3ceyUPbcmg7vIgc
 UCOZ9CsM5TuQCru6nzmfPOVSKEmQs5+2Hsv9yhSMlvv5smAilk4ucqS+WcP8Lur+GvZfSrqfauX
 g7Cy6kjI/pKmZeKIFLGT5FpBGYU3zvuJFpuyukbRWQXaXW1yhCZddqZdDBsNoSHKoR8WmFBjTqX
 2L/aF9dVh3fXgR5qT/BDQqsMA8fvFLUSHo5uz4IhQ8ueEDs2DH3VJzj3o+GOD/gcd56d6n68c6x
 H0Gz3jF2H1eLVT1GWmDA0Z04zLH0TkZLgdeY4Pz8/NcfMI=
X-Received: by 2002:a05:6808:c2f4:b0:467:bfa:bd9b with SMTP id
 5614622812f47-46a5c5a0857mr2527578b6e.21.1774479954838; 
 Wed, 25 Mar 2026 16:05:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:05:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260310131846.2141759-1-alexander.sverdlin@siemens.com>
References: <20260310131846.2141759-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH] fdt: Prefer %pap over %llx
Message-Id: <177447995392.3508238.18035532691101661372.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:05:53 -0600
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

On Tue, 10 Mar 2026 14:18:40 +0100, A. Sverdlin wrote:

> In cases where phys_addr_t/phys_size_t is being printed, it's possible to
> use tiny-printf-friendly %pap instead of %llx. For instance, in SPL, with
> tiny-printf:
> 
> Before the patch:
> fdtdec_setup_memory_banksize: DRAM Bank #0: start = 0xx, size = 0xx
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] fdt: Prefer %pap over %llx
      commit: e67cf100eead1f918a3ff7a591e15fa0d9804189
-- 
Tom


