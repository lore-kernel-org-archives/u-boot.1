Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DFEE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 20:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC5CF80431;
	Wed,  1 Jan 2025 21:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e4YKTW7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A6A80431; Wed,  1 Jan 2025 21:41:51 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D75C4803B7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 21:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d884e8341bso78923156d6.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735764108; x=1736368908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixclzx88XPmQ262GpgPz64izVrTt5fJ/Iq9a/W8Utfw=;
 b=e4YKTW7mpvfcRxY+WZMmPsmsy85D7o0yXQkxEhYKAsJQRMBRvIN9smGgX02Gg1ka8m
 4oienz0m5PL9gF5Ujw0TKbSxyJVWoNY+4azZgUmJLVwbuuAbt+50mFA75pQdomL7REYq
 eRdn587H4gYBaGZlYPvylP+rTSRRp9Q6Vj7E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735764108; x=1736368908;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixclzx88XPmQ262GpgPz64izVrTt5fJ/Iq9a/W8Utfw=;
 b=lyZlcFmtMUpFDeMs7jADj0DO5jHZRKjXAddPToXUOORsQDeuVEdH/kMCOm33+25kY/
 c/L7HokvSFcMYP3ks0d4CCWCU8PL++O9oCW4iVxE2LJwG1YzqvzCOxM590vK2a8MWIH0
 3ODLBvBWuhsVvuk3MRYHUKKX0JPhuBmx7oYogxxoEldb8BT/rEQPPzv8RmPqF4jbx8pQ
 cTlgpuGwDDIxDPZ+NTIS4Gv/XZFDyLTHoMxkiP46AnnCrk1CtZSEkB1omZ50M0VjW9GU
 Fs/btOgoCay72El+lAnqEJgvjKnUD2gqvPeMfJMjgn4Yqob0BH6zdIhjxXWQzoRKb4OA
 utNw==
X-Gm-Message-State: AOJu0YybkKJAU+8NvcHuRPhOxyKIWWizRyzgnoVqFbAUw7E3396OgIty
 eiuBn8HBt3h6TnibOIb9MCOyVcbzF5iEe+TCKiXg0OAbSwrW0T6lmROfjONSCMw=
X-Gm-Gg: ASbGncvkSSWt1/maSD3vlKMOhlolYXXy5gU1SblCWm9vPLKKRQ+DEsaqldp//6z0ncq
 IKu8f95h5mp11i3REdjT7pidURGdjHDbjtOhA5kt9yVpNQKiPnrchLpllu/PFaJf+ZDdolq7dXs
 Xa6lSJsTWP2ozDNsNzFxZ36XZlZozFFgtUXJ8JsIRESljHC1ojgBABPwAvSMqwUKedDc4XR6yrA
 TkFmPsLqe/AWthBhuHvzkmDapfDeLjBoIlJWbV45aR+53MprEoUuqgW
X-Google-Smtp-Source: AGHT+IFyR6tK/QzwiKrvd+EcV4qJw+JP1yeAmslbJU76n7n8pnUm9MrpUyDXBd0/GT3/k13HHFT85A==
X-Received: by 2002:a05:6214:e6f:b0:6d8:9c92:6555 with SMTP id
 6a1803df08f44-6dd2334bce0mr684036776d6.29.1735764107845; 
 Wed, 01 Jan 2025 12:41:47 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182070ecsm124054636d6.124.2025.01.01.12.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 12:41:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, seanedmond@linux.microsoft.com
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, v.v.mitrofanov@yadro.com, 
 saproj@gmail.com, Sean Edmond <seanedmond@microsoft.com>
In-Reply-To: <20240429185116.2287092-1-seanedmond@linux.microsoft.com>
References: <20240429185116.2287092-1-seanedmond@linux.microsoft.com>
Subject: Re: [PATCH] Fix neighbor discovery ethernet address saving
Message-Id: <173576410650.1694690.7953350114597829756.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 14:41:46 -0600
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

On Mon, 29 Apr 2024 11:51:16 -0700, seanedmond@linux.microsoft.com wrote:

> When a successful neighbor advertisement is received, the ethernet
> address should be saved for later use to avoid having to redo the
> neighbor discovery process.
> 
> For example, with TFTP the address should get saved into
> "net_server_ethaddr".  This is being done correctly with ARP for IPv4,
> but not for neighbor discovery with IPv6.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


