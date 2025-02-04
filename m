Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E80AC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A205E805E7;
	Tue,  4 Feb 2025 20:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i8sizwHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD590805DA; Tue,  4 Feb 2025 20:43:21 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E66680040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ee29277d44so3791792b6e.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698198; x=1739302998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KGz1atIYrkdY5gJOMxivqfVLMR2y9JUALllPz6nJRjQ=;
 b=i8sizwHgyM8+nlqTM2yokV7VHoSrDjg9R+afEvJzBAhDyxT7Jqxwz8Q/AQLL50NZAv
 6FdX97jXIkEXVr4f3JXyV3c626RTazn0i9WMYvWrboQXEYHtzhKMuuFpHYSL448rDPXx
 pYQ3Og2GQ9jY4R5rUStm3cFPLtUz/4fWm7CGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698198; x=1739302998;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGz1atIYrkdY5gJOMxivqfVLMR2y9JUALllPz6nJRjQ=;
 b=q8OFWZlN6Iyy8ArWeIxCsvcYGcl54dfPgOOFF2cqNs4TKq8RvsCljArNgomU/r89qU
 w6ooAFeffuuaEAsJELiUTxZs+xvRN9qNmBDa2lrjeozVML1fsQg6vIzM7BZjq9NDOkby
 OVTI+gB0nbGPrd4bYdeIwkbJt0NTuS/MDarLM4frUURVTsmwjpdm2JAOaims1ZrrU9Tc
 ov1oRb78jXRQfiz0g/rqfiM3pZLGIZIpHkZLcqUV6IEvhw+ykvQ9ZkzgwBlWcWRpuIbt
 VCzMdyVe9XBKlyvuvvxtChMKwQmblqoOYosZa/VUXyf77MN9oBRE+lFqL6gnMfE1ij1h
 Yi4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMtx3eOm9GkhtD9nV/na9nO49o7J6cKuP9vhlVTGAgzh0s3xSW1NCtzUclc7WjBN3d1kq6E9Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr8a8r4ZO6AKfgGtDUBEXc5ueH//PDCQif4xgZp4jM+zF4VvgC
 QzWnccIARZE1XeI5AVo9X7QO3TvJS/FnUL60dKnzskfvcTjDGFEOSQuimzV1kNY=
X-Gm-Gg: ASbGncsT657muKKE5bhmpy1zgrcoWL0PfsumhYapXD5EAWRyH8Ccr9Abk2y8NtKtrh9
 WSS3E1ysfzxa5uZXacY3aIziUsPm2l9nnrc92ZUWU60a0f1U4VwYjxFCwW/D0c81hZiHQzzMmSp
 yXYPCKRz6BPEUypUffACJWF+Uj0RGRy7GRmftVqEon9PjSxGctYXb99VqG1l1rziOjz1WQvGJZv
 sGlRu2u+15uLhFuCY5hE4fhHlGXvwQwsM91jcbD/9J/KBvgO0L0UUyQBKe8xAtaeeZvUfmkZrea
 88+M9wofKM5mRQ==
X-Google-Smtp-Source: AGHT+IGVeAXoM8e5wS0u0PXeiuOUmDUBQ3TAKXEU2bNLS+yCOSsLKcQ+GDt7hNOSg06SIQ/D4D5PTQ==
X-Received: by 2002:a05:6808:1b98:b0:3eb:5c27:f73d with SMTP id
 5614622812f47-3f323a3d084mr17385647b6e.12.1738698198348; 
 Tue, 04 Feb 2025 11:43:18 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333690ba9sm3160867b6e.49.2025.02.04.11.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:43:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, 
 "SkyLake.Huang" <skylake.huang@mediatek.com>, 
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>, 
 u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250127134046.26345-1-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH 0/8] mediatek: final preparation for OF_UPSTREAM
 support
Message-Id: <173869819653.637016.3837576766336954690.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:43:16 -0600
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

On Mon, 27 Jan 2025 14:40:37 +0100, Christian Marangi wrote:

> This is the last batch of part to push actual support of
> OF_UPSTREAM for the mediatek SoC.
> 
> The plan is to make the current downstream DTS on part with
> upstream implementation so we can permit a gradual transition to
> it while we don't cause any regression to any user.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


