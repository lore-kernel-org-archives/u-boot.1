Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B741710F2867
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 19:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47ADB83E7A;
	Fri, 27 Mar 2026 20:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IpV47TP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62CB283EB3; Fri, 27 Mar 2026 20:07:41 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5278C83C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 20:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d744d9acbeso1005063a34.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774638458; x=1775243258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+kSQrswQ5gIiLuK6KhDKaHlxxrFaQHn5qO/c5Me0vw=;
 b=IpV47TP68J4GKmaBJS1WmVK6VHvyb+mKzBgy0xID3dgT8zgG5VmXkZx7yWj53GVn7p
 AnkfMPr1PizKmjezu3KEF3TXz5ivHk/StjqcO5/8HXvTy1ASzu3xs3mPc3m1ZzST78u0
 xIfsA0lxdyOl7VMCgCFBEZEMEzcfLfiP1H5dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774638458; x=1775243258;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n+kSQrswQ5gIiLuK6KhDKaHlxxrFaQHn5qO/c5Me0vw=;
 b=iY+pL27TP5F++YMetYR/dOn9HfDIpf2HQBUcIYHxDzMxvnlbXKxLr09vgHc6moP6dC
 /5EN+HEWCscQv0SIZq6GuKCoDzSYBlyw7TlWqH8zFHguvA3FlQzyeB2V5jS8o9AzhVTK
 /GXTvLtXKlM/vK4VuOscm1IyBODt/THNrXgWLrpsFcLIG6n1CLibTy2RIgf9AEgJ73e8
 iiSirriN75yEA6pMQSROmGEfeWgnskne4d63yAalf4sdGEinsKNHphLmOUa/DZy+uAoP
 K+KdAnYYzpwzXmH3cIwHjjT5g7GDQeVHx1x5aFHdEAcnPnqoMi/5T0zmAGpjar2/hypC
 FMsA==
X-Gm-Message-State: AOJu0Yx/gNanrAcLy2ROc4EkH70C5Z1L8AY/SNCTX/zJ/oKkT3U5LBYJ
 wjERXr0ddynUBaqoaxZtOHxZwN+gecNVHn/5DreDE5bsz9v0kxPHenlHIQpbqfPQUtES5/9VbyT
 x+wrwZUM=
X-Gm-Gg: ATEYQzxoAaS5NgT57KL1BZlqpoteYu+06J7uy5GjUy6MUR0wE9mpGYte/RIu5J04LWg
 j2WIaBHP2fmNAqGICuaqBYq3eR46z/hrqPRlnNk3c2atLyyVE0pO5pBUKcS08q1pX7hGgA38PyD
 WwXvgwFNKusHs8AuDYrXC6vFWf1QwDm8B5bbW/2RnTm6jEK0mUIYZK1K/0xtBXT6BBC9bleJbi/
 Q/TUc7+lcaBnL6uggRh0G5HNKvZhs6KJZgw3oVvKG2giS4lT8Jdvc1kwyO3CqgBeTEPCJX7ZYuJ
 aJ1WXSHHw4TpiJPxtARDZOWSG2zde9PhXdXFrn4x2v1cOdURAa8IyeIgEGxFvlKducvdbawHbOE
 0ztrVCx/eM7eYQ5qkeb81h1o9z873W8P7FeoaXruTEGDwh/LAZX17c7a5yF/NMTBcmuO+26o0fI
 oovXM7TrPzHIY7TBvGs63TfGY/Nxq8fGNG2eT7vmMgtzmoL6xtI0TkZtiTHwyuBIonOrlf6wUCY
 Q49FU/+hN7DSF07/Stn8dE3yWB49Rx/JN2o2KR62sxU2DU=
X-Received: by 2002:a05:6830:2117:b0:7d7:fcac:6374 with SMTP id
 46e09a7af769-7d9fadbef26mr2166721a34.8.1774638457995; 
 Fri, 27 Mar 2026 12:07:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a7edb42sm46914a34.20.2026.03.27.12.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:07:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <3f8a042d-72f8-45c7-9d3d-f278f209311e@amd.com>
References: <3f8a042d-72f8-45c7-9d3d-f278f209311e@amd.com>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026-07-rc1 v2
Message-Id: <177463845739.4129998.14387935794365644580.b4-ty@konsulko.com>
Date: Fri, 27 Mar 2026 13:07:37 -0600
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

On Fri, 27 Mar 2026 16:34:10 +0100, Michal Simek wrote:

> please pull these patches to your next branch.
> 
> Thanks,
> Michal
> 
> The following changes since commit eb00c710508d09b2a3b9aca75dd18280f1304703:
> 
>    Merge patch series "bootm: Clean up arch-specific, pre-OS clean-up"
> (2026-03-18 18:36:50 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


