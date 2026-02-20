Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E1C5B561
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 20:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B470F83E36;
	Fri, 20 Feb 2026 21:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jG2AqUI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D3DA83E13; Fri, 20 Feb 2026 21:51:25 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D07F83D8A
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 21:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d196a2334fso2002944a34.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 12:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771620682; x=1772225482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m60K98pxw0U38ENwwHoyKnhsEOedmCKlaT1r/UVNOxE=;
 b=jG2AqUI/IUW4bz9bgpg0GIGTZqvTvQj1W7TLX5zBcrqVa/q1hOj8jFa8m9B5fJpB/i
 hR4yctDcH8ZU3pX2JKzvh26RZUKCscOUaKwA/Bf/Ds151SLAIuhV4e6S6JjKe2siKkss
 52BDZB9e1QShicmEez0NmzEFSxqLmllTIf8Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771620682; x=1772225482;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m60K98pxw0U38ENwwHoyKnhsEOedmCKlaT1r/UVNOxE=;
 b=k5twCcEGlf6ZnkvXaM3uLXyEd5rho12NFfeifp9lv6107fD+x/n3eiCfj0ccDyIe+S
 RPLSIggn7zEW2gIT672JhpGOvhKTXPmL2y+n15ASU5OmWtRqsJ5rXRrUrpC+HImXpkiY
 A/btWgOhy1Sv4fblvdAJ6lakyH3yC+uBmJEktXp+6Y1SNykK2Lbs5weryc0Da4cqayS/
 58zwqGZoNUd3ika6Yn3D9XuZOMRza8VkIOpE3BfRzsqtDCsHXq4R+VmJ5a84cAoJYryG
 +KbtkYjgUsbGhkpEry3Yyaaa3g0Kx9tIcmeScntbwUwiEaXR27fo+fxXw0XU4GhFH5i6
 6tSg==
X-Gm-Message-State: AOJu0YwxdlCsMasQSws5H8SNdISgXCuiqwezGR9Y7L9eY4pY1sVsXldK
 C4t+A7nLFmzx8gKNLRM4LQgLhc6jRL7axlcIyUQotwigTWqNptBhFrpPJjrGxVms/e4=
X-Gm-Gg: AZuq6aKFvz87WybCAuwTNOOU+7rGdcEctMyOAWKRd7/ESxAWtK7PyTJEsdIM7aNmxSd
 IrAFxcMWGTi/sVBZmfXXFiRr4bGx4wLEDLfVg+X3hrmYYbuliBAIYYb7J3usAt7MrjehdC/CELH
 kdXlsIPxtImp2EW493lXDFcbx6Ko6IlzUxckzAX3plDH66xAUVOL2S8QU3uHrRebxF4H75Kapn3
 rMrZwuWigUVRAA4YMj57nHDmalniQVqzij6q2A0ln7ix4Gvb+tbm19qlzoqIsJzdpr6zYkcKlHh
 haiGCyfvcEgTanXw5mzHsk3EfjanJiMH6eyz3OuedGkVQ+6dz+FjrZp6Y+wE6NWDwIVtEMGXSNw
 FSymfIdKyTVheOp9RFQuCCr0Kkb3qiUUEUFtxeS7kRUdhK9J853vUnjq4lPXU96bNKFUvbLMK+I
 egitYQRJ8unKznJr3CsnuaRWvjSyEUfx0jZqVfzbP2Nu2BOzQefWyKhVUqsPXXgrmi5XLSbCcll
 3loav2GAQxCZrXi554JirHvZieDtGD3oHDZxce/8kjsbYWIg3dJDIZaueRY
X-Received: by 2002:a05:6808:4f07:b0:45e:ff14:711f with SMTP id
 5614622812f47-46427477bf9mr3783328b6e.4.1771620682141; 
 Fri, 20 Feb 2026 12:51:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfed28esm525818fac.9.2026.02.20.12.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 12:51:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jeffrey Yu <jeyu@issi.com>
Cc: "Mutya, Havish" <havish.mutya@amd.com>, 
 "Kumar, Love" <love.kumar@amd.com>, Ji-Ho Kim <jhkim@issi.com>, 
 Anand Bagchi <abagchi@issi.com>, Ron Kalakuntla <rkalakun@issi.com>
In-Reply-To: <SJ2PR19MB73666B89F24BC9AFB44F18A3B639A@SJ2PR19MB7366.namprd19.prod.outlook.com>
References: <SJ2PR19MB73666B89F24BC9AFB44F18A3B639A@SJ2PR19MB7366.namprd19.prod.outlook.com>
Subject: Re: [PATCH] spi: add support for ISSI IS25WP02GG flash
Message-Id: <177162068135.148229.14289201581239149678.b4-ty@konsulko.com>
Date: Fri, 20 Feb 2026 14:51:21 -0600
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

On Tue, 26 Aug 2025 23:30:03 +0000, Jeffrey Yu wrote:

> This patch adds support for the ISSI IS25WP02GG QSPI NOR flash device.
> Tested on the Versal VMK180
> board in dual-parallel QSPI configuration.
> 
> 

Applied to u-boot/next, thanks!

[1/1] spi: add support for ISSI IS25WP02GG flash
      commit: c5d82cab7722379c57e3383b5aaed83e5071adba
-- 
Tom


