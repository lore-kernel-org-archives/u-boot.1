Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772AFC61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 21:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D956180B1C;
	Sat, 29 Aug 2026 21:27:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p6g8DAv3Sei9; Sat, 29 Aug 2026 21:27:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788038827;
	bh=LdEimhepWY8gAVXdvnozSOgKQP5TN9VEO7fA59tkl8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rxrPs4opVL709fVQACLqesOomWPhE39HrHkUOFYiCO32/E+vdK/dA3l8+GqMlF8J+
	 rK683sxMlqNgPrN2rLdXoSqA3Gi4nA6xGo4WB2ft5XPnNQ4mJlwh1LIHf+Ax19NFOd
	 amuqIB5tifOgp4vptJRq/3e2pqiT/IFKMjcG9jkcSzR7Hx+uPlxg+Hf06QdbUUUEhp
	 4hCc/Rz+8yanz+Aawtg7u1PPeTS5uIdkF5tdLSIHb0t+mHBYk8liMqOM2jepe748RO
	 Ku6nQR0W6gj0BdJgYFqlbq/OKYzku9FUxL/054EnkmjtIFmd5XozSikrNtrXJCN1Q6
	 iOjj69pfytQ/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22BF480848;
	Sat, 29 Aug 2026 21:27:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4114E127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 21:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3314480848
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 21:27:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRx-gfRgQsES for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 21:27:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::2;
 helo=mail-oi2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nZUXVy5K
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EEDE807D2
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 21:27:04 +0000 (UTC)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4ab2d72ff13so910794b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788038824; x=1788643624;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LdEimhepWY8gAVXdvnozSOgKQP5TN9VEO7fA59tkl8g=;
 b=nZUXVy5K0KLsp4gUDPFLQ/AgQiPaNR5DZ4uXiddPyW1zwlGsr5CL0j00AWMh4xQlKn
 gMWSkccgZmZuQwLHB7fdXCgPLxe6xC7vodwofmT1KzkQptI1v6VDnpVGIbuSjqt/0a2Q
 K9XRUYxq7iIX6Y7kx3OhgFOjUuchZk694e7O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788038824; x=1788643624;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LdEimhepWY8gAVXdvnozSOgKQP5TN9VEO7fA59tkl8g=;
 b=Tbe55JslXF/K7ODpl0XNhxnAM/Lo0bzxk/Dws8iGBoZROoAZIWv5dIUR29in3dqCJp
 T5g8LVsIl20g9S6s/Gdq7vc3Cd3RJaClaPRVpTUFRfSYNLIZsOeFXi7o0U8UAqC6ep1l
 wgUhAS/Y817afaNe6LaKscNcvpW6jvOdm0/b2oJcx1OOdV6EoQCtgsyMju1I/xhTj+Lr
 2hM5PwaWlYeX9oRZZK3mD8Y1F74n+84BWCpNEElypq/MuxSNKI74njuEVNYTM445b6Xq
 8P5hUN1NKmFNOHtiBeAGsVrinvw6mCEc6E0rp1Elmvm7uiPpmDVQ5ABgufMVtau2dh6V
 9eVw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8uj4d70bLfeOakWSg5PPZk/3EX9gqYCwhiXRoU6XE9B7nLxe+hej4QJfIwu/mTfBn9nd0ztY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nv18+jeemAC0pefPsNhCZY41OMLT+oFk3mkoE2udWXXRCS4gsD
 BRn6sDmUoLR8XqJ/UXtkscinANhEFlDqsPeNdwzIbyGxkSla3m6ldWLuZaK+uBqpT9pbreT3i+7
 6EVW/O5f7nAoIswM=
X-Gm-Gg: AR+sD10MyfsRYBvQpyhUU4JjhNBq1dZQzVKjK30HcxFRo6VZYeAZdyku+iiP+kGXZeA
 d6X3nJG2bMbzpa7G/x+bj3bs5F2UgqwXqCaC7tWEaKB1cc8zUvdIVoefkmtNgvgchJcj8yhce/J
 y5HV8JhQxvV6GHW5K1GfZERBZyeba28UR64kEZfwAATcdI+DhEvbmB7wDozHwXMnZdXokk3LLa6
 tqvvLoCYO+2aYIS3h4AHe2zo2FDxmf+xd2tR3WIQIP1tXDzbYsz6Yndre4VOyQR5xs6lyBJ97aM
 HS5uJiYgb6sAqanvi/W+CedQAWOUJcfVYoYdzMBPlEnSV7sCqpaFgcrfO4W2PUKCIyzPMqdxuWY
 KYJkRgFGOHNflPYak6+wZ31P0gqSPYpUMrkwfJCfkQ2jaAQR4Hdgmz3/P83GIWQ6WO0dFkjXbzb
 VQi/YGloenjaKGDFH7dAKiZTgZLtCjURS7Az+NZQ0C1angmM1B7k7kiCO1/cXHVxfEhGLNxp7v0
 IpVpd1ihB/Rc855iNkirEKeQ3PMWiODD5MRcX/GfdMVkYYYd+S32t5ogsMIWywCpJcqKWPcdo+P
 fTGHw5KN
X-Received: by 2002:a05:6808:1926:b0:4a4:866:c395 with SMTP id
 5614622812f47-4b3981be305mr15997560b6e.13.1788038823912; 
 Sat, 29 Aug 2026 14:27:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995f2fsm4431988b6e.11.2026.08.29.14.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 14:27:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
In-Reply-To: <917e8196-8ba7-4f65-a17a-cd37092b3928@canonical.com>
References: <917e8196-8ba7-4f65-a17a-cd37092b3928@canonical.com>
Subject: Re: Pull request efi-2026-10-rc4
Message-Id: <178803882268.694611.6224194850114745424.b4-ty@konsulko.com>
Date: Sat, 29 Aug 2026 15:27:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, 29 Aug 2026 11:57:05 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 67a095a6896828056e4a1a0ba0e9bb20f5595c59:
> 
>    rng: Fix build with SPL/TPL (2026-08-28 14:23:43 -0600)
> 
> are available in the Git repository at:
> 
>    https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-10-rc4
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


