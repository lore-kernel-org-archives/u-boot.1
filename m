Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62079C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B5F80C6E;
	Mon, 10 Feb 2025 21:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qpMwLKXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD57F80AE5; Mon, 10 Feb 2025 21:38:53 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8094280C6F
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f9bb24d033so28188747b3.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219929; x=1739824729; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IouLz29usHcoct+g0WbjnPOHwbNEBpp3eMnJZHRNnZ8=;
 b=qpMwLKXTN+/q1ECsIHyggoiFjQ3dSTjHECiHfwMzo2vnpYjTC9+hfke7C5f1BVGol/
 h7VJnARlG3a77wiKzp7Ja6zE2UoF/3yOtm4Ge0hIPckkqyblwr77fJYkaH/GrTY/qQ7D
 GNq4QUkx18lzbM3K1j1DmOXYr9DpeWuwg5p6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219929; x=1739824729;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IouLz29usHcoct+g0WbjnPOHwbNEBpp3eMnJZHRNnZ8=;
 b=QLTwvfOVcoppSuQbro5s2FXdVEeeT6o+21zbCwa+i2f3tPYP9JVSHcyYHCvSxVa1Kg
 GIw4VmOhW6gNDkkCv2ZowAWuq5oxopMx5WOq1gQKrQGPiev496vA7jZu8Bnql7fOjZSi
 h2oyFUy5nsn5nGpMr0UeFr5FHFyNsrdjsCetFv9DUDAHylEWhY22arL4vUmw55LAcNid
 lOxPmVnyh9KyFSB4hDQC/uupCPFlqlyBUCtpI+J1A8IoYBp4qs2I2CdIds6toMLGdmT3
 nykJnIq6tyEOEFYE8CL7HU5Vu0M4Wk/kVYopAW0xPzadZyk4n7QUzE8rfX6PBPF8VQ3u
 deSA==
X-Gm-Message-State: AOJu0YyVm8B7uiwdfaiXoLq5AhOHd04xDmpfJLpDxMwc+KWdCZiWcJEO
 qJesNS9L2QwqTeicp0216yriNaNP8DG+GI1rjTNQRXvxfuOHP73l490oFgmxn27+pF8bhGzgGhV
 b
X-Gm-Gg: ASbGncsQiBnFwI+1kSFxK9bHbtgxYBnNiivc2nkKRJG4EsSlMAtezIQ0hY4y1R1cyTS
 /sfIG375V+erggqBPHa4fkaJIEA+KglBkhHeoS748qL9VUKIJZ+or540hlcVuFl3pytmmyhVEWr
 EjJSWFK9pkj2dooskmFHERN9ZR6ddL+zFjylz30A1Baqww8nic9XwXM525U+ZyflKXVTxViACvT
 mhhg67BH9eAEFrXG8SJ+Yy+oHLKDzD3uYtjj6biXIkMCIjzuOsGkszIF2Rw3gaTJWIcpqM1Nr1Q
 DE9n9LxF3vt5+A==
X-Google-Smtp-Source: AGHT+IH9a3jdvIG5LaDpVdv8E3josS/54rXI4AYZUa1tPkymWlNZEUd1JDh7ieqaJfvFAaqUlmFvHw==
X-Received: by 2002:a05:690c:6f8c:b0:6f2:9533:8fba with SMTP id
 00721157ae682-6f9b27e8c97mr143356457b3.1.1739219929240; 
 Mon, 10 Feb 2025 12:38:49 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com, 
 Michael Chang <zhang971090220@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250205020106.40785-1-zhang971090220@gmail.com>
References: <20250205020106.40785-1-zhang971090220@gmail.com>
Subject: Re: [PATCH v1] net: designware: support phy io micro voltage setting.
Message-Id: <173921992806.2921783.7936934525093005042.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:48 -0600
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

On Wed, 05 Feb 2025 10:01:06 +0800, Michael Chang wrote:

> Support phy io micro voltage setting for NPCM8XX rgmii
> interface.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


