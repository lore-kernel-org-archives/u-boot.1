Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C08FD2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2973A83A8D;
	Tue, 20 Jan 2026 15:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FvA/9J9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0AD683B0B; Tue, 20 Jan 2026 15:31:07 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E2A83AA0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4058fd4666eso2273746fac.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768919463; x=1769524263; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJ+dHRQXeL40RECF0ZysyWrSPM4KukG3oVcmALJjyLE=;
 b=FvA/9J9wWylQKMMBBOblX8Bcc+UJWTahtoTyULbEJDi70VYGEgOniqyYJ1u9TBMvS+
 6xNTin8S18YNiChc1s98aoL/D8jKS6JvrBcS1gfeCo6ScvRRLoCfIz8o8xkBKH/o+xiS
 2alN8XtJ+yz+sA0xekTZ5TrQFgW6kkEwBhIH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919463; x=1769524263;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJ+dHRQXeL40RECF0ZysyWrSPM4KukG3oVcmALJjyLE=;
 b=L14UF0hXYEd+n+Mv6sQadIgi6oTzDnGP3GjD8s9HNSZK14uLxuQIG5gGLP7GORIuG0
 gp7HqttyTZdqhykV7YaGYTJntf0R4W09j7vt3kfDgTq5GJiXddadHRbZ47B49D8CqBlU
 MugUyqPRXUBEhjn842ay2dYtO7JYvcnVnE5Td9UBX7xHqVW4x+dT5l5SU+zuV33uPhUq
 NVWMBmjQGWaDDXO/9JxXEeXSOw2veJJsHWNgVJz7aEH2d5h3mBQNJtF2OAcP002jsVwg
 dBPAy5EuVwFEgg0pwSsQzDRFwJ3dW+L3aeHTPGdUdkZuvbhuSWUmVReJxPggQmPf6leE
 qURA==
X-Gm-Message-State: AOJu0Yya8zOQTI3J9C3yzY5N/CC+Y1rvb34pg8zzsuCWco+QHGqkt6PN
 dagTvnoemgEflysnQ1b0ENZQghXJL6qZqxnEbFky4Y9hi2+bgS6TpX0qiw+CjoMSdJY=
X-Gm-Gg: AY/fxX6WIlPZ4sKzXktR6boyDgjvfOTVzveW7fcwy3LPpjsig4ySaJO1bDnNKbM8tAy
 QtmdJhr/k2IIG10MA3FB5Lakg4IKarL1B3hGuhEcvDnZp09DzzkVBR0qCQl7fmEcBJ1r/9krMSf
 89qob/ifQKfl3bZG+AQ5pRTK4CNFUKtdAZXoLfJd4wQ4UXe5WrT+aTnWxsMGdrU+l+KZNbM1lK+
 XzcNMw1FqVF9zGQZotbm48e6rvIOOuSCPljLPOjwl4tlLjs6qrFscVW7AWCVEvbIX4ExRJqihI9
 C3pRb0CI8oz4gN9SaO/XeLgeKWNmqo0FKdc8ty0vMmB9V0oa29F6/ToLe4VgIUD2eakkejFxSDx
 lKDhfF9Bl3E1v5jV2m+LKnKBLGW9L7D6oLD5dU1wRjLDZyiASlO/mlVf2f6t/hsGktBGnCpxepr
 wWk3WBtI7IhXQvqQ0Sf/tT6r6a691gFMNPdvHLvFAM9WsQhWUyLD41iZA4XcxrpLL6ftmhTp63r
 IbQCK5/drgXcOjpOvc+P7wFtLJWKK8fqPrh6A==
X-Received: by 2002:a05:6870:8887:b0:404:1f56:b9c9 with SMTP id
 586e51a60fabf-4044d08da51mr6450566fac.58.1768919463201; 
 Tue, 20 Jan 2026 06:31:03 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044baf38ffsm8657418fac.5.2026.01.20.06.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:31:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <fbe2f3d0-c9bc-4b31-b443-ada162841078@amd.com>
References: <fbe2f3d0-c9bc-4b31-b443-ada162841078@amd.com>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026-04-rc1 v2
Message-Id: <176891946226.379251.3598625720758976307.b4-ty@konsulko.com>
Date: Tue, 20 Jan 2026 08:31:02 -0600
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

On Mon, 19 Jan 2026 19:48:12 +0100, Michal Simek wrote:

> please pull these patches to your tree.
> 
> Thanks,
> Michal
> 
> The following changes since commit 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550:
> 
>    Merge patch series "Enable / require DEVRES for devm_.alloc usage outside
> xPL" (2026-01-09 10:19:57 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


