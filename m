Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610EDCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0688383A8D;
	Thu, 14 Aug 2025 20:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YL0G+tWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D513583A31; Thu, 14 Aug 2025 20:48:42 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2AB283A5F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3e57010c2bbso7409705ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197319; x=1755802119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XdZRCsJXGvHFd/rGCNctVpxWrZpZimDfOQUWca4DeC0=;
 b=YL0G+tWO3QJkOft4bclEie8fRbGniMQ+PNIUC2PLkVubXTKPAUTP5g4ts3YMKCOjF2
 ++fcoil0GpwKVcAVqYEiPwsIqIPIa9RoTFmyBw609Is5BZzz/xVEVmJmeJ1lBMFzZe3b
 IuPQt88L6nGdud3kyPv436soEALfWPh2lesk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197319; x=1755802119;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XdZRCsJXGvHFd/rGCNctVpxWrZpZimDfOQUWca4DeC0=;
 b=DDE0camvG8Go4wbaufbkMQgEFKML0KGLQvUXd/mqItejI4DQtfqPUtRsxFu1UhOMs+
 /U2e7OV5RPhvxMLWa5BoLp0uRnKL72fx2pfOHk+gh9wQ+f4SpINF9nmtZUVjkVA0o4YF
 poO0vl28W4BduxMoILLTb9616CW5MZDsEdhjWOdypnV1l4qiNN2DiIzAeSnDDJnfp14/
 MU8QwcVhbbyPoC81sZEBmCZUELCTDDOJCstvrXYwxhOTqcS94tK5CyAQsissFR/zznSN
 gTv4U0gbDVMMPa6T1aGQ9QGKOBErLSC+C7Lr1Sn87yNFo/dNemM67cZVltvZRpfgzm4u
 0X4A==
X-Gm-Message-State: AOJu0YyokA8UQR9zUeZPL0tPDP8BssUrn/WepGgKmUIswAMYqYyA03Y4
 Jk66WHjECKiP2gmUl/PBwUwSWGj9xWODSlBIdHSDpPE805w7VZP6K14FZOz6bssFEfZkzE+UsfF
 EOb/cocY=
X-Gm-Gg: ASbGncvWOh93tIX+8HrbMhlvWcyx6s3G3//2N+WSYa7UXoyMEnHIEOsH9glWor1uZEe
 w0cgoYiQaDIC+sy28//AJtZVV/84E/Kf3FYvTZ5Kyd8SJWnyMJu1bCNWG5bVMQY6SYXY74rD5DM
 VwSRpWlUcM0McKDfMPEfaHwgTUVldyTmzJwIEwHEgQ6fdhwjnqJEKMTp1rx6eZ9ZOgH3BI5y0y6
 iCvKhNC6TJszgxgnlT1d/3d7Re8/JDovxqYYlIbEiylI+UAyJy26+f4xc0Evv6GBM6v2AvuoXbY
 DwE4CmWOAsxz4cJO70Di01+LMaNPlkbmSh/vGf3Dxcu+Nz6xJ22k2M3NBFjnuQ3zH7/+NLgS+rf
 p+zxD5tHszILWEo9DNObNliJXIuiJ6FZh89CBEMvbkjGy46AitOG8xQQ=
X-Google-Smtp-Source: AGHT+IFFapShUlDv3QWmVQdgwFckvXJRs1nA5A4YAK9WSFYkUbA7cem9uwu25HVWi06/WCjj6O1ngg==
X-Received: by 2002:a05:6e02:1a03:b0:3e2:9977:bebb with SMTP id
 e9e14a558f8ab-3e570916347mr72799745ab.13.1755197319461; 
 Thu, 14 Aug 2025 11:48:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215719.1413106-7-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-7-trini@konsulko.com>
Subject: Re: [PATCH] sound: Tighten some sound driver dependencies
Message-Id: <175519731867.3600102.6359884953015681214.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:38 -0600
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

On Mon, 04 Aug 2025 15:57:16 -0600, Tom Rini wrote:

> A few sound drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sound: Tighten some sound driver dependencies
      commit: 8b0eac68e5cb7b5bc55a4955672159c337f6afa2
-- 
Tom


