Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6BFC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 20:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA2F81D27;
	Wed, 26 Mar 2025 21:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EkSt3NJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13A881D27; Wed, 26 Mar 2025 21:06:17 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2F381B4B
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 21:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3fea0363284so147627b6e.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743019574; x=1743624374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PrRxq61ZSB/SH6N6ipoy/VELWOg6RbuffzYEPEI6C8=;
 b=EkSt3NJxg1GtLzl80LDHy5xaWRwivzMAI4NBznk8AodktSKEQf+aYjF3qwgAOPLiqd
 483E3uYLc5tm7dCPMEG3bdVyWTQo6ssM7Crt7y8Tfpb9OXo/Xv6LHl4Ptw9u+Eii7MUb
 wa1+x5gtqFsaTPZqL7S2kGhVCI5Gad29u82Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743019574; x=1743624374;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PrRxq61ZSB/SH6N6ipoy/VELWOg6RbuffzYEPEI6C8=;
 b=OYwYlan5YC4t/uiVshHCF83LNaFNvgtQVbovwgS1RmcUg0l2b+eTLGeIcd7L2sOF2T
 MUM0LXTigRxMY9mi8JmHygK5DBtqF5GLKXGkVdotWW73xLs0Aar2SUmGh0DhGa3/+B41
 TvxeHL+G95G4NWIcTL7OkBV5SwMTJmMWdhWnfniyQ9Ix5XJgOZKXSQP18+sqDn/UB6La
 aA4Z+dBNetOKf5LIdy6/ENZgKZ90Huvttx5pko83GJFIKZWd8ZjvdZEchid0ObD7/jpG
 p2O5pJqewD9BuXWX0EFzlJbTYdbQb/rAvlRJbe46dLFyMcc04A3vCZtDxofoEyYVmato
 lTlQ==
X-Gm-Message-State: AOJu0YxPZL9SaDkOhMGOqeZrjwVms/87CArklJDWrPo2qL4TQwJoLQZi
 rb+HtiG+pNDRafJcCXUEfPpxFBQXNedC5O300Ic2P/WcaqTp9FHa8mY9i5YwadA=
X-Gm-Gg: ASbGnctogrkYbzmxpVsLBpFljF788jMRc3HJh6PqoLn6p78rtUuvT0xbiL4smj6d0EF
 tRzZJ4FBXfIrFy36EzaxYN4CUnoa6AH7jneQYX+orb40wdva7tJ51YDppbUdjXSuaiBt5xX86K8
 Xpx/tpSKTp/A6WIp4zwfr7famiEzbJDpDHlNDx41sPTc/I2mks3mNeYLCxhg4gkwxFu4F3QgrdY
 6A0xBCFbUVT/yxBu4xESzGjflvnB1aS+4JLv7Wus/WVb+IRndsOKj9gXVSn7HKAafVwYVzaBdGE
 NCES803LFe0kR2pp7l3RMIQVphinGeaMQIxa4nQMnRxRwOe2o4UYOdQz+N2h03MYapq7WJn6x5j
 4B7H48s6dRbP8XLo=
X-Google-Smtp-Source: AGHT+IF+kPeJKCDjbZ3/pq9Kyz1qOgZoJn2x8nJgL8XwzOImC90hsjZdV/Md9Wt3RNge4Ys2eOoqIw==
X-Received: by 2002:a05:6808:1a11:b0:3eb:5a58:9b6b with SMTP id
 5614622812f47-3fef9db8b8amr637112b6e.11.1743019573784; 
 Wed, 26 Mar 2025 13:06:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3febf792825sm2526434b6e.35.2025.03.26.13.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 13:06:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Vincent.Stehle@arm.com
In-Reply-To: <20250326122208.893209-1-ilias.apalodimas@linaro.org>
References: <20250326122208.893209-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for efi-master-26032025 urgent
Message-Id: <174301957262.548194.6090640021938072238.b4-ty@konsulko.com>
Date: Wed, 26 Mar 2025 14:06:12 -0600
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

On Wed, 26 Mar 2025 14:22:04 +0200, Ilias Apalodimas wrote:

> A last minute fix for EFI and -master
> 
> The following changes since commit 47f433d577a0e1e937c12bbdf632119f0c8b492e:
> 
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-riscv (2025-03-25 11:55:05 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


