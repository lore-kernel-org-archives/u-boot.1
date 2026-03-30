Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861C31061B22
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9730E840D8;
	Tue, 31 Mar 2026 01:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dMGdjBok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C794A80212; Tue, 31 Mar 2026 01:00:31 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2524F83F5B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4671cbce465so1894837b6e.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911616; x=1775516416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7U5GD+niJFIRk+iFK8LesWfx6RtyvPMrezpUUny5IXw=;
 b=dMGdjBokIVwTpnF/RjZNe82GrVtZOP7Rm3jqXsbHiF6qUQoyp7V76svZGxDfrZyTOc
 RLucWe+UMFc4aBC+Py0+DKEwx+WcxpbuGbxLw75lk6rspkWKJQ+y96r8AYt8B+OVON2z
 1p5kDf5yqS9Ig9dTauXtxTsgX5YHj982j4M88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911616; x=1775516416;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7U5GD+niJFIRk+iFK8LesWfx6RtyvPMrezpUUny5IXw=;
 b=DFg6awtsbK9g8eZiX+MkCjT4NOHxz+y/YyPRTuDn6D2D2L3UczikhyNWmcyr/TrpLS
 svkExdYk8QKdfT1wVRSeR3sT9j86EYw3pryqL8heIRlVf5i6dsik6DUjRBOultRG1cIG
 LqnxPltofx+tWXnYEZ5mqICWWjt35UhU7mDDO79kB5yD9OoOb3U2UhY+u76eIl1GY4RF
 8FZBubHaIosoPJymuxHhOtLhBgjsF5dsuMnILmBMVIBqbMvCn3lGMtBGDMNGwPMW7v/Y
 aYoOCNQhYmpiR/24Sm5Mz8bMpnuIv8a24cCzdOusEpxB7fqhRiamyfiOl/Xz4HeGIUNH
 iOYg==
X-Gm-Message-State: AOJu0YwE7EKsd4F8D9zhaMM9Ch7W3KkTkWVi6zt41ywQG0ORixYYkiLb
 dBuZIJ43epun4LnmY3PVPodCDCkcLyGIVth4w6gSalxu3O/S1TP93ILMSXxmuRfI0GR6QKYaD9j
 T1bKiFK0=
X-Gm-Gg: ATEYQzxK6khUuPB8N2D17zp+KzMcFgML2t9dhgG/4aO9D8pfqrt3c5gg6aEFnYfQSpJ
 G09+JWRXuIZfWWv7tabh5Pb+TfBKan/R46nJwJveLdvXA6BWHfstev8AeFUbPrhs10FaMp5IIc7
 bRTf67O0ecFSjr6FbOUiLvd3HOd/DEe38VHNRt3tlVuVjaSysCYWXE2kjAs8ulVEBatBjScc4ai
 /eddrrrQ5LwlZfJMtbITk+xElm1Wkbk3pw+/rbZERrOa9SD0oadWVN4LjbCoRfVu4tvdOdmUeLx
 gR2JPbE6yB/x+N+Lc74P5J8uHYeWDZWJnD8GrAZj6VqH2au/106Dhrh6S9WYGjIhfE4AcIxmiXy
 a/YyYvQENtrcK6j8/EU1XL7v7NYTkjzg5+ZSd0JX4fui3cDbZF3Ni10UUxTC186/OOpv6zhMWag
 JWMJPCWzBXyGvWd2MVrglyJ+YVmz1MnEBURBoSIn9YC0O0sb25rEu6YobcMf/m9QHFEZTEV1GpU
 Ir9NhwakRZMe84fKBqeofzeScUW06jujOC7xvx30npJZklrfo6DRpjiuw==
X-Received: by 2002:a05:6808:244e:b0:467:284:b3c6 with SMTP id
 5614622812f47-46a8a441460mr7547614b6e.14.1774911616294; 
 Mon, 30 Mar 2026 16:00:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012445.4162614-1-trini@konsulko.com>
References: <20260317012445.4162614-1-trini@konsulko.com>
Subject: Re: [PATCH] timer: Correct dependencies for SPL_TIMER
Message-Id: <177491161574.1028292.9026947260200188419.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:15 -0600
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

On Mon, 16 Mar 2026 19:24:44 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for SPL_TIMER. This depends not just on SPL but also SPL_DM to function,
> so add that.
> 
> 

Applied to u-boot/next, thanks!

[1/1] timer: Correct dependencies for SPL_TIMER
      commit: 5c4357e902674a87182b1652739062040f7a6450
-- 
Tom


