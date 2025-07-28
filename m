Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FBEC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 15:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF5882E26;
	Mon, 28 Jul 2025 17:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UoUWGhui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB2182F6F; Mon, 28 Jul 2025 17:42:17 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F09A82CBB
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-615d75ee53dso1028129eaf.0
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753717334; x=1754322134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlLDF0pLLn8LnA2cmQjtNwEyK+bagknTXBqDwdIP9Vc=;
 b=UoUWGhuiEFIyQwLHQm8siqxIXddB37o1qPwNuWvtOLzOwkn679Ab0BrMac2vxYbUnE
 ygdgI2P3/uIHTXKZ2pVfP0PcbuVzzqsVJThJU7rmJdQm8Ech1Z692nOfsKh/BY0mvZFs
 FWxiFbOxj9WzyQnhvuVxIU/6TSc69d054oYPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717334; x=1754322134;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlLDF0pLLn8LnA2cmQjtNwEyK+bagknTXBqDwdIP9Vc=;
 b=nPXHXYP+w2WDjaYt6lFFIeVHbTcWgF4ZFnCdixo4/1ccv2Hx3uX+VTsk+ke+cWqHVm
 G0CSuIRBW24axwVwfYKjTaFMdkBvAMmJigiRwAdH7YtiKWcXJxKV+eMGJFBn0/uF/yHJ
 DuODjQuBAEBvvA44DHwOLaa8E5H8xPcBe88yVaUcRXwAaTOc9Jgo1/xtl+soJ+2BR1xt
 400m156aqJGGqiF/QjW6OTB9RN3u+FaDe2pzJ4cK0KsrzPTlvRlNGqeTO8WfGF/ZI6O/
 sAf9QMHBMfM1jFDuq4I2wD4+XWllgzVy9VtIDpsjU2barjhU/eN29l5c33m6cV+vKAmP
 Toqg==
X-Gm-Message-State: AOJu0YwVnWQfzJERiAJ8pbW4/jE4kBsjYtxW/gzhHLXzrzzfQlHsfeS3
 c7G4buGFFRQJG2XZnwb5lpOKc05U0TEjGABnU9L7XDAzFyh9Kq+pGEyDd4aYHyDFVhTr6w22YeR
 EZi4UTvU=
X-Gm-Gg: ASbGncuJkW3gqbE1Jn7RyKaBreih1YH5UGj46xVDM0dMt9XvxR0NN2f3r1UrbaBDaVM
 sFzvsa9mwJZaz86RPbUaB9xRdkUQq7eeWVuE4OK0Qxr7YlusLIym8avXG9KxwwP6BQ8cEgyyVZs
 C3bn9jLlK9xVO9t3v/FAVgnaxExK77zbhnH84iiW8JiaH/YwQ7u5jpwB4f/046ffB20CAAPgA/h
 CXbazrnEPm0xONwJsCzdFnrKfwvkeJ/JFZlazZchUnQgSbHQVMLaTHtvAq+RJfe6RRUYCgdSqvh
 010tM4j1BPWiiOCc5EnRamsp7d8esvjoe+NsBEQykaRbSRaRyejhL+sww9mesKrPNXqc1PeBmD1
 ZVSEWb82b0QVwI7vfTx9pGPpoUCA0JdStAzej94XmMWxq6/sqbY9f8ZQ=
X-Google-Smtp-Source: AGHT+IHXlamr9Lxjnj3UEhb2cZW5quwnwm+1jsA5KKz9BXMb/YqrV0/vDkUUfwtbtreOGKDEAiN5KQ==
X-Received: by 2002:a4a:e903:0:b0:615:e61d:2dca with SMTP id
 006d021491bc7-6190c944cfcmr7937886eaf.2.1753717334171; 
 Mon, 28 Jul 2025 08:42:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61913f4f177sm1015128eaf.7.2025.07.28.08.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 08:42:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, linux-sunxi@lists.linux.dev
In-Reply-To: <20250728004516.19032-1-andre.przywara@arm.com>
References: <20250728004516.19032-1-andre.przywara@arm.com>
Subject: Re: [GIT PULL] u-boot-sunxi/master for v2025.10
Message-Id: <175371733338.368338.4272008367229350972.b4-ty@konsulko.com>
Date: Mon, 28 Jul 2025 09:42:13 -0600
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

On Mon, 28 Jul 2025 01:45:16 +0100, Andre Przywara wrote:

> please pull those sunxi changes into v2025.10: they add support for the
> new Allwinner A523/A527/T527 SoC (all same die), alongside with defconfigs
> for three boards using one of those SoCs.
> The patches are the usual combination of refactoring (of the SPL clock
> code this time), tweaks to existing drivers to support peripherals in
> their A523 versions, and new drivers for pincontrol and clocks. A big
> chunk is of course the DRAM controller init routines, many thanks to
> Jernej and Mikhail for providing this code, after a big reverse
> engineering effort.
> Since the DTs for the three supported boards have been merged into the
> kernel repo recently, this is concluded by cherry-picks of those patches,
> and the defconfig files to finally enable booting those boards.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


