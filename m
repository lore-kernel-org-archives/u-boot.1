Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CC7FA1FEE
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 19:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C921A84372;
	Wed, 22 Apr 2026 21:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QQ5YQOk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA1A843C7; Wed, 22 Apr 2026 21:51:26 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F5E84372
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 21:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso1859103a34.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 12:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776887483; x=1777492283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBWvcIh4rurSA5d20TN9pqDnzYhlGNA4TcbMLuOXDwc=;
 b=QQ5YQOk+GNq+Ggl+zcccmSmtMHNGrpOcKMFqAyU+O1146S9ySgDy5AYe75vtXukVlF
 2vUnlgfmIqtUkcldwtGVC0r7kdX2fA6956VxkXZh2jv5j3i8QhXm5XXAvUsAqMZ+p8ys
 MsS4trznBhrSpPoZYX7g2qjL0gu7lVJpNytlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887483; x=1777492283;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VBWvcIh4rurSA5d20TN9pqDnzYhlGNA4TcbMLuOXDwc=;
 b=SWJehYa1TokvSeVc2TCMzc0fgYiX+c4FHCLUkHGxCf+aXq3yZ3VamNxCmr6NUDfcQ6
 hsQ7TuAQIcjSqLrEiDiy6q2ka6uDl2uwXvFezMXEitL8ypQz1PHYhWRCsPIxkVEpilOG
 4GjOHe/cpCJR0GtwcJRApSAsSGbot9RgkCK/DnDED+G57Z6mSFHZbwiskoEbTIkRFN8d
 EUTlQEZ6HUnPhLjdw0Up/q9l780MV3Pf2gYMbAW+mpiqUlAaIPvjWxp49eotObdW407x
 P7yVp90BsGEBD4iqyWzqzBO1KVWlIdNHvGYZabbquLFHybWthXBOER/JeAw0EeiK7X/P
 GSWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+I2i5v0478pcgBt0X7+eTS1zCHTC4qi3g1y8KkyXeJ+Og4iSNdeqYP6RavV+Cs8bo/Sy7AH8=@lists.denx.de
X-Gm-Message-State: AOJu0YwWzsq8pYdzxVFgGZDos7foqe6vehXcgvSOyRK2A2koX+arxeHg
 4kHMP3Yx9xcvuAJ9UfPua7FFSsFRi538wlmzc2TDghdq16MDN7oY6cRd/y90Jd+dogM=
X-Gm-Gg: AeBDievgz7ZMlaGafM/x6qNcVOG5dzgTnPlRUOFzTAy2+iNEoGO8NbOtLOCLLzbryuQ
 OaUQEFx+jAzf3zMehJYaKZS1LXujoKDyBBFqQK7thFxhdpRR5mBd4pK94rKv51x3CotMJNByR5X
 6Nyc9VlQPCbzMY28gyIEoKQTsEYPErwoERA4scpRfzIzZFFS5X1acDZEbuCxzCI8byroSA5CKY7
 PN8v9Ye9SOWoNSkueoSlXB8EMp/qLkxC55wUycePCaHopGs/sGPqD7A4FAK7hEVJMO69CW0eDHy
 WAHuqxrlG/c2k2tOlsm8tJ0dgyZUWbnTifOYoVeyMSIj54/0gKFbIeT5JymVSKzLfTymF4/f+M8
 neM5pjGX14VYfBeU90BH9SF+kfSEsARA40gfbLJGXKXGc3JS+BqebT3CMEGDTb4rxoId/XLvLCw
 n/o3nq+MT5f7aLhzRcgUVKmnuFxepJqKK3AeoCdZqoNfI0rPtwDxlslBs7quoLswkZ29QeSqC8j
 0qpsHJgBF6A6vOmC2S8Pr/EHIf9yS1ZTJ0AI530picyDoD8O3pMi2UhMHru
X-Received: by 2002:a05:6830:83a3:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7dcd72513bfmr5692768a34.8.1776887482825; 
 Wed, 22 Apr 2026 12:51:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcd9a0847esm4963542a34.17.2026.04.22.12.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:51:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: bmeng.cn@gmail.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, sjg@chromium.org, daniel@thingy.jp, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
In-Reply-To: <20260407094900.420176-1-visitorckw@gmail.com>
References: <20260407094900.420176-1-visitorckw@gmail.com>
Subject: Re: [PATCH] virtio: mmio: Return error codes on probe failures
Message-Id: <177688748189.1917521.4402263498096303789.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 13:51:21 -0600
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

On Tue, 07 Apr 2026 09:49:00 +0000, Kuan-Wei Chiu wrote:

> Currently, virtio_mmio_probe() returns 0 when it encounters an invalid
> magic value, an unsupported version, or a dummy device (ID 0). In
> U-Boot's driver model, returning 0 indicates a successful probe. This
> causes the system to incorrectly register and activate invalid or
> placeholder devices, potentially leading to undefined behavior or
> crashes later on.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] virtio: mmio: Return error codes on probe failures
      commit: 70101c3217aec849d509040554ef0cf7c0f1ef56
-- 
Tom


