Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEFCD116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 17:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6322383B24;
	Fri, 28 Nov 2025 18:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lHDTO1iJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2282183B86; Fri, 28 Nov 2025 18:41:27 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E124783B4B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 18:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6da42fbd4so761045a34.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764351683; x=1764956483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFmhzmMwQCp7qdUSR6bfLfCb26n4sjdU7PtnMEtHXPk=;
 b=lHDTO1iJyV42ae4jBB8X+enWRmP4s2o3FVsKHUMZm28bKDZPvM8DXU1vLkPdOGu/ev
 fyYo7hRx2hNcv4VGEzjFzaqZfeaxYtx1O5DFURs5BdRISexiBxTY1Iz/2UAtbNTg15As
 /uIwC1e3JwaHIZZOEh7TnRCmmafP0D44BCY1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764351683; x=1764956483;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mFmhzmMwQCp7qdUSR6bfLfCb26n4sjdU7PtnMEtHXPk=;
 b=YGmZTtBLpIEeCToYDgdAIAgpKHaGrRMS39+Zh6mr4UtUwwUpQPkpJAWdPFHkkwEwp0
 azayN0FSiOK47rGXMb6cRwWtEH6KhEOTfdOdvIoNzxPKR+FzS7rF95uZ3S4+i7O0Pa/+
 5AG36H8R609swTfkXw3gwVtUn/LbP/hoX3V0na/d+vabstETBW/FbnZ1OAwwzNZ18SUe
 /PhfH/JK1UitMBmi0WVFBZ/MAEsF9lFIYaGFPLaKeQnZkprQlwdHoaK5JzLhCzOEtwRb
 zyKxxoFFtbkszGTzcOji8+KQmJPkjaVDebtKLc84O0jpaJJLNHhA0xG+wj66Or/L2GKS
 8DRw==
X-Gm-Message-State: AOJu0YwdrusDxiQ2SRCW/yjCl1f4rajCJtzDrkfhs7sWH95K5fkEJoVk
 30PwNzpFBJuPJ7crM7Gb9vh7BMfOqSdT94nc1+Ka6mKQM4ORWeJjKcyrQsqYlI0UQUw=
X-Gm-Gg: ASbGnctmlcDTS7Ljk+Mj1azD0qt8PexLodZZ810vr27+erU4DsymZCZDZvBHX87d4N8
 eGejbSXJvrzeZxoiy+2OASxag2YSK2LfbpTH4IIaZgVR+uqJBYZcXDp4yMvbXFqIY9ZOiKJcvOA
 EPtpbdsHTK+yGCdEfG8dOmjPn2tsRobsNZh408bUujxA10Bc7P+SEqHKGTI53+AH1F2PJnm5i7Q
 qVRDNZNzBGEyzhyIwB8n6Oc/Xfy6bJN9kQWbA3ug6NwPMTb3HDXjxMYlHAvEBLpRWokbJToJR/o
 6R/uWTocgFOrq6BpbQ2shYfvRKNx21FzySaZw8Xm3u/khlI1CfjTwpju/forAP7ZYyCIRQZX+qg
 J+ejNHPYv3+43hwo9ZSOckigyLS+M+hDSDJ1UIhEUOX3wuQfamm8WoIwtxkqBHLJP+8s+ZP1PN0
 Qpt/kDTRC3nkK58RCb2bkAKzsmEz43ZvV3Sd6V+fE+KzfP4B/4
X-Google-Smtp-Source: AGHT+IGATas5/rs5k7ZO6tsMFD1aWKoVz+9zrhcW/CIX16WaMnzpbK7OPmAxsbzYtZpsEF+XYt7O6Q==
X-Received: by 2002:a05:6830:6014:b0:7c6:ccf9:195a with SMTP id
 46e09a7af769-7c798fa5931mr13997489a34.11.1764351683676; 
 Fri, 28 Nov 2025 09:41:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f650sm1771543a34.23.2025.11.28.09.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 09:41:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20251113115618.947927-1-marek.vasut+renesas@mailbox.org>
References: <20251113115618.947927-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] MIPS: Assure end of U-Boot is at 8-byte aligned offset
Message-Id: <176435168307.233357.1993535351380927302.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 11:41:23 -0600
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

On Thu, 13 Nov 2025 12:56:09 +0100, Marek Vasut wrote:

> Make sure the end of U-Boot is at 8-byte aligned offset, not 4-byte
> aligned offset. This allows safely appending DT at the end of U-Boot
> with the guarantee that the DT will be at 8-byte aligned offset. This
> 8-byte alignment is now checked by newer libfdt 1.7.2 .
> 
> 

Applied to u-boot/next, thanks!

[1/1] MIPS: Assure end of U-Boot is at 8-byte aligned offset
      commit: d9e183a04c92d96c8f8b145c0b789c62bdfc2605
-- 
Tom


