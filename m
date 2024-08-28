Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC8DC636F0
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 037A788916;
	Wed, 28 Aug 2024 20:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sKq182B0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B3F88995; Wed, 28 Aug 2024 20:26:54 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C397888C1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-70df4b5cdd8so5155695a34.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724869611; x=1725474411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcMfvJ4J4gUZFyjjRkNCprrb2DawAfW/hCC+8h3eJHA=;
 b=sKq182B0otpepB1NPsumtXVWuinJdmyrD4rv+grrkdpUIs1AGSUUVBogpwJIn5RGmw
 NDWrZdRuaUu67l8aVW14jMZGs7rXwKyJy7JTZgHYorTYvF82MYHalKpaGpEqwc9U6xwH
 lYIuO9Scy2iDZ9ozGji835Z50CVwF+opCocLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724869611; x=1725474411;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcMfvJ4J4gUZFyjjRkNCprrb2DawAfW/hCC+8h3eJHA=;
 b=vcDpChvLXQg1YVdiyjO7QYNMHYxx916MKPDfRO4aIQSD6du95Vjyeso7qoOf87ru5R
 Xpyg4z7Ysi/yxDzhz+ixLFpweiXM3Qk9oytN+xwuwjDh+ebMpGGYVZuq0MBqpzLVlIj8
 m9RSS+ane2Pf/j5YPteQiAOG/YoaWL8WhWgdnfmxMgAGUdOwhrfr+KK9jF62qAbA6u9U
 mVC31RDijiuQ25/lEYEchlKzrKBeTU3krW12e1UQEwTWA5rj5go7S5iniCEM4QsJ7qTh
 yfE3pgQ/hHYNME+uadrZnqpC0XjaAwfw5FwBTX3KpU6TbF9f9YUqCAK1op0N3Gw9eBun
 DNGg==
X-Gm-Message-State: AOJu0YwNrRXLq3dinulOIRMnI9bIRrmOhES+SfDhiWOmdnMrwuU6Y/wh
 vx70cUgOh5t2JCs0UPZ1y135X0SLCtWJR+em7fHEIN3DR+9AsShKYRXFpIPvZ5PXDmrbnRk4gfB
 qhqEH8Q==
X-Google-Smtp-Source: AGHT+IEj2ViemO04XPgPQjoeyYk4zTMeUQ87Gm2/hUeJDbeotL6+H7EqzWyItBsVOxoj/GD5KefkQQ==
X-Received: by 2002:a05:6830:438b:b0:709:3e50:f24b with SMTP id
 46e09a7af769-70f5c3f2384mr515989a34.20.1724869611150; 
 Wed, 28 Aug 2024 11:26:51 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcddadsm67835536d6.121.2024.08.28.11.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 11:26:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240819072428.4116298-1-JJLIU0@nuvoton.com>
References: <20240819072428.4116298-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] arm: dts: nuvoton: add dts support for npcm845
 yosemite4
Message-Id: <172486961010.3064792.3580766035483889427.b4-ty@konsulko.com>
Date: Wed, 28 Aug 2024 12:26:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 19 Aug 2024 15:24:28 +0800, Jim Liu wrote:

> 


Applied to u-boot/next, thanks!

-- 
Tom


