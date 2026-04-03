Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B95E85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4371684144;
	Fri,  3 Apr 2026 21:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="el7KZ3kG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3F184129; Fri,  3 Apr 2026 21:47:17 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2422D840ED
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso85389a34.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245634; x=1775850434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O7S/2ETLNjLbIyTAXZECkBrlcO5q1rfbqbIyCYDwMTg=;
 b=el7KZ3kGdDQ5poA+TcJIT6y8ab/Vke5vmyH5cdhJ+D67jYq/JkPuYqiKdcTzbRTNei
 Q0cz9owMnalZbQqdVH0p4/HzlhYtl6aEekdjceTos0vkJClw2dCCpBiR8yiyLJPXLC39
 mGE/NPRUhc9RiTcDTyau/wmluVh6w+h07CCrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245634; x=1775850434;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O7S/2ETLNjLbIyTAXZECkBrlcO5q1rfbqbIyCYDwMTg=;
 b=ApKrNT82uZXr5r1bmYuj+kDOFjAbiJ5G1oKr0G1TmxerDjcoZA6SYq0Hf3r7bGMulx
 2H0S8018CvydfVrGER/8638ODkcl5ayAi1V3C66/Bds8ll9aXyt/lpBCeInb1jy3uCIn
 TePdqA/0r8aD4fdwR5lwqVD55KtTKoEcaaHE6yqY9pYly9n4xPiDSj5YwYD6Ufa0vudk
 /vZsoPZuYLJEDuUx/Zmznv9llvYV7tXyf8OTaddeLb8diQtD+n3bl9m5o+CT6K9uDlXu
 6ZpFFl0JMpNUDHISeISQkEqCKP6CHLyCQKMbUxyIoTAv9GgDwxhY7eFEww3H4c+0Mjzi
 6MNQ==
X-Gm-Message-State: AOJu0YzLu5TxOQJzORsEoMeCsMnBMq6HPJ5ssNq8JUHHz4tCrDMejYAD
 GVULCX9WBwFgVeU+3kKOm2TQQe3qFjUU0HAyXxgy2G9nGEPnUJEmwkfdHIsSA3fSUxYPr2+tCqF
 oEjA7Hek=
X-Gm-Gg: ATEYQzzqZ+aCEutqQsJIxZ+flJZdBkqd6bCtL9BKhh0fjJOwHqvqvZ9fE2odJ2afTjL
 vdtDN4IzBroegTsn0I6XG0il1R9pZ09yza24+Z7W0oDn7p4Se7u4DShp0KzzV/9aH/y/zkJr8lJ
 qGYCTh4ja2lA59dWzEZXBp0LbKNVJnJbWrmhaJ+UYgFCD/cFw9CU5/qd8TVTI5Bb0w4fG+PNjhG
 wJqhiuf627Yzox0MC099hEJocIeOl9/ZfuktHv8SUVGSbQ75qUJ2NrYsl3/56yyWGtWM5wdvuI2
 cwKCnrkc7T6FnxHvoco8r+6O84msz5qeGLPuF0OLCy8mDU3YYznRkHPrzAJ529kbCpwD79KULud
 A34SIZNIKCBDaoOHKPOl1lYQSiL0lbk1JUdIZSK1ceA757N+NXUf0QDlPd2ImmEJtQYmP92KdZY
 5OdjFN7YnQoKk8uOMc1g2Owzv5F/H6o5wHrlQ5s75UB8q7QGYjrHgGhKteujzqUD2EI7TntOjSa
 ubbXnEoiFDyaAmy82hmqVowBxPcxvYRiCLtyORgsbIA7fk=
X-Received: by 2002:a05:6830:2a8b:b0:7d9:b2b8:e06f with SMTP id
 46e09a7af769-7dbb70b8971mr2658030a34.21.1775245633846; 
 Fri, 03 Apr 2026 12:47:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205322.3788575-1-trini@konsulko.com>
References: <20260320205322.3788575-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Audit Kconfig usage of PARTITION_TYPE_GUID
Message-Id: <177524563304.2281750.16299957832822236671.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:13 -0600
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

On Fri, 20 Mar 2026 14:53:22 -0600, Tom Rini wrote:

> It is not functionally possible to use the code enabled by
> PARTITION_TYPE_GUID without having EFI_PARTITION be enabled as well. Not
> all users of the former had ensured that the latter was enabled however,
> so audit all current users and then as appropriate select or imply
> EFI_PARTITION as needed.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] global: Audit Kconfig usage of PARTITION_TYPE_GUID
      commit: b0eaaa067ea40611b9c047576adc8abd1a4d63a7
-- 
Tom


