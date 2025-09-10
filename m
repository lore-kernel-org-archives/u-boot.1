Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78E0CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F97A83323;
	Wed, 10 Sep 2025 20:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LZ5AW2r/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0496D833D7; Wed, 10 Sep 2025 20:14:53 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30C3833D7
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7459de59821so6168678a34.1
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757528089; x=1758132889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDDKcvJ3Gz50ix78XrfTDq4C8bji9HO3vhijd1/yhDo=;
 b=LZ5AW2r/U2+V2HHxFlPGkIih2vmYePy+8odpMvkjh+RpRy08N/o1wQrwVdPL7cV3hb
 a6BAgL7O9fnDQ4MfYRCPG87aG0vUpg8XbTkAWTSZWhsFF3ZC2xcIsr22MgIzNMW6LLSB
 FPa30eFDVlAZPQph4HttJQhSMHTR38KzJVaxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528089; x=1758132889;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDDKcvJ3Gz50ix78XrfTDq4C8bji9HO3vhijd1/yhDo=;
 b=bMgLkAhbmM6Gl2UaMX2oq0KtnYgXgXCaz87TIcwl3+4ZTE/hcfGaVi5lnKen3QaOTH
 xHvGVEIYJwmund1Wro+gcXxVjHfIXT9CP4MDClvRVvM9g2k1faE7bNXW4f0hO7bO/WmQ
 Us863GM3SJB3wAIgBRKDcpH4/DUAYvHiDL4+kCA0LaD3cCMI7b2UghyTxjZGzYILdvsT
 7TyK4R9vIXr8vAbQt5YDOj/XH0waWbpRTK//w0/vNc8/QOwFb8VgbB9CmA3PxMBVU0tf
 A05D2cN+PN6cHWWmZt7LZMBWRh5xpQaTnDHs9XVsAz+Sij+vd/zA2K1/qDEIQ6v9ALaq
 6QFA==
X-Gm-Message-State: AOJu0YwDxG/azHB5RSeqFlset3UEdeoc0tEY5OePwmAAZhYNFZ+yyX7i
 44JQ7+aGiefzYu4zvgpnFwQ3VkeHmVl2J0vFxOfFP+ybdYBtVRg7Jneu+r4BuSAl9QQ=
X-Gm-Gg: ASbGncvb5Z9iBQArVLy9a3OS+QlXGdyO0KUtL/gnQZRePU83JMCsP0hbd/4SNLRy52O
 +Ij9kvqnIyXEfURJF1Pn/j4lsvXnQc68p7jDH+4Sq3hmLsASJnfRX9jLOTe5yZiT7cubNbrPgnd
 P8l9CFyiM5vsUospzQC6Z7wHnYTd26ApSBdPdZH7QtM7L+wwZVFHswZJ/5ffkO98IJriMOTowQo
 CpmpqZM6r+JoBgsnt7J1x7fFvVW+evELh1WYYQ4kglv2AXIgngG13gWSsCKMVfz9orxPAuhUmy/
 mDFnmRFSxj6RKiAt8w9NEo+PfNO3KiZ8z4GiyLeF4ISCMbOE82UlTIDKDWxTYA5zRlJvnZLcN6K
 CW7FyyVWfbGQVc4bUH82gK0b3rGHwb2bWYUyIitRvLvbksGTI4YKVMPI=
X-Google-Smtp-Source: AGHT+IFF5K88tB4w8PTxbRlFunjT5ZwqF9SIDoVdZy6TbIFktN98e2byxblXNWMGXCGZVkO85RT6aA==
X-Received: by 2002:a05:6830:90a:b0:745:52d8:b718 with SMTP id
 46e09a7af769-74c70d75f16mr6921241a34.9.1757528089342; 
 Wed, 10 Sep 2025 11:14:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75200e6a1casm18100a34.17.2025.09.10.11.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:14:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
In-Reply-To: <20250827183836.678142-1-trini@konsulko.com>
References: <20250827183836.678142-1-trini@konsulko.com>
Subject: Re: [PATCH] checkpatch.pl: Ignore mdelay instead of udelay
Message-Id: <175752808853.1959855.3507745929152342281.b4-ty@konsulko.com>
Date: Wed, 10 Sep 2025 12:14:48 -0600
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

On Wed, 27 Aug 2025 12:38:36 -0600, Tom Rini wrote:

> Whereas in Linux, on ARM there is the notion of delay operations and
> mdelay and udelay are not the same, here we just have udelay and mdelay
> is a trivial wrapper. Tell checkpatch to not complain here.
> 
> 

Applied to u-boot/next, thanks!

[1/1] checkpatch.pl: Ignore mdelay instead of udelay
      commit: 320d1d04eb52d5bf450e93a91788c2dcc9594de3
-- 
Tom


