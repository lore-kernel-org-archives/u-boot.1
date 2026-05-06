Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65C6CD3439
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 17:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED23849D9;
	Wed,  6 May 2026 19:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q/v7+6IR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FB184A02; Wed,  6 May 2026 19:17:35 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AAD8849E5
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 19:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7df05fc49e5so2772983a34.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778087849; x=1778692649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8ZVh/7SqAIs2Wy8QaaMgX7dfIeUgt5Z4tTDLaplwDY=;
 b=Q/v7+6IRd2Qe0jMVb/oeSb7SLZHnm3b5hscH6xOm/OLPJuqPw6It3DxWqzJXqY4kNg
 s+ilsoOzz3Pcwezm6/VEzh+75QkEZst1qyMsulEa86feGgc7UYA8sbIkXWBU8QRk+Xx0
 X0w6XC5DnnvhXSJajcBd4a+jFLEFzVpMglNQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087849; x=1778692649;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k8ZVh/7SqAIs2Wy8QaaMgX7dfIeUgt5Z4tTDLaplwDY=;
 b=PnzZocddqT6h/2LdL8K4SyBs+urVa80PRg4PbvYlVERjzDVWttwC3Ba2S48CGYlORb
 vltty4vCcdQrRzcqeaOaPMT2hYmSyyBz1umYU4keEGMsisuLtGUKAAZkvuZipDBX3VFS
 NxsQGxRmdDxqeSnEZ78tRhpo7NLQEG7a4srLhADf25M9jc4M+J8ZplrUOqUROaYXzkqE
 cAyef31qDoOXQA3rAKuhY/L5fYXZ79OyZ/o02w7TNaPVL9I2VCsYzyyg23v8dGJZWPfW
 Dg1Zo41dpMt7Gcl0ILSMJ3rrvKEmwlQZyP5VzlFac/N4zIkoJEvbYU+B1UReCQf0G7dr
 phCw==
X-Gm-Message-State: AOJu0YyXkdZBN/26VmN7FadRNL7HcYfX+QbKFQ9UrJykwvxomBXmu9Ac
 AjKHLIbKiUg3ZW2hFaVe99bqsLMfDO8uVfeWrbmAS7DwxCHsoYIozEBbROjxZEj6ewI=
X-Gm-Gg: AeBDiev0WZRKKqrnCODT3TVvxB/Bj5G5dVT6SmItKDrKoYWDFUYwF0URS0CxlK3mXX+
 7k//ywshFyn88buxI+uY7O1RGHpiqorzUB1WI6nTnjHaEczSHgnJzXZ1Jp3Idxituwk0dZ4HXA2
 lDB8LObiD11KDoBBKCslQ6i9mAKxxE0cvI6FBG3R/DFUfyxRrgUUUU6Vats5E6zg2M+we28AXFl
 0BJRLUpDk4XqptK2uEx/3rUA50mE1uUZaXYPdmjZXVwDGhtm/WNeqvxsdA3fuxJJmoBNmIWPtEP
 n3Nw8gNB0G70E6Pr6Q8jQgFXQkGlfL8sw6t2QUkRGMN6nnG2yh/rQqvSzDFa1BT/hfnQn5fEW80
 QsXN9GW1D8fPNPf8NItGQTh8TYX1qjsuPQm1dFri+yf/iTTIUChEBklG90OkBDkKIYGcwCVrjLv
 B5O9wA6z7NE33hYfdvmzzjbCOg2Bbd3mlhBvFl00OLHNZfkPKJXzcGW4vTT2e1+0KmEzogYrGko
 70w0MpqY07h8n2b7rOaZY9upP2oFJr/nVPkSAS97GqhSMzy04EPnbUn4ljc
X-Received: by 2002:a05:6830:4992:b0:7dc:dd58:50ab with SMTP id
 46e09a7af769-7e1df0d2e76mr2351814a34.14.1778087849174; 
 Wed, 06 May 2026 10:17:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca80d5b7sm12380327a34.9.2026.05.06.10.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:17:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
In-Reply-To: <c9e9c08b-1e29-424a-b83a-11a29a2a111b@gmx.de>
References: <c9e9c08b-1e29-424a-b83a-11a29a2a111b@gmx.de>
Subject: Re: Pull request efi-2026-07-rc2-2
Message-Id: <177808784847.2488.1452101539436449728.b4-ty@konsulko.com>
Date: Wed, 06 May 2026 11:17:28 -0600
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

On Wed, 6 May 2026 14:44:20 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 57460fde4ba84d67de4066ee1141e89e8139ed23:
> 
>    Merge branch 'master' of git://git.denx.de/u-boot-coldfire
> (2026-05-04 14:41:59 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-07-rc2-2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


