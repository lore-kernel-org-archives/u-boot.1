Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BF3D74945
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E778C891D7;
	Tue, 29 Oct 2024 23:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e6BUk94H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CE0891A8; Tue, 29 Oct 2024 23:28:29 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A408919F
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b158542592so444118585a.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240906; x=1730845706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lue2LrOe1fWrNv1JxNiELSNpSdgao6vYFVw+AB101c8=;
 b=e6BUk94HHFTaZpy6ZGwLaR98rweEyu/r/+89jJOnV0qlIKIPrCy5FNhUIx3w1Mb+sr
 sEhLbVnFfJlGNuPMosP5FQdlmBNBs3E8+lPh6uNO6+9/4nTl+mEdUQ5PTr+n/yQe0beq
 eHlKeHAwIOjwwwBdpjMwnvN9w2a0f/gutFEKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240906; x=1730845706;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lue2LrOe1fWrNv1JxNiELSNpSdgao6vYFVw+AB101c8=;
 b=DE9+GsL+yCmVMipGt9Uw2fTc0n3p+3uLOVHWBKSkE4RIxaZ83qo4T7vZ7ZW7qC4t1q
 12aU7K2qWAfi0nervH2V+0BDPZepsOHu5+VpmkNZve1uGxE3NnGf1s1K9H2tJzxbBJ11
 lMmsqxlSfLk6OxvGvon9YET4kgyGJTcAHCXR8isht8UOTm7hOdMIOhUs9RCf6++Cwq4L
 lBa2oazUPPECXmNB4TahuUV9rp74XxIKn2HotAiohvyNIUk5bjcqMhbnIRASFZbuepeg
 G8n4hpg/akWkNXzL/VZk5xZUu79vM9yY81sxyjaqC6dR9X+59+hv84hGKyybvTWKMXa+
 s+Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfxmFQ/cvl0nb/8VQDasxqba4dRel6kDBiXb5k/lnvEmpb5CzL4Pnx5QmBuqVauHORXPwuSiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YykbTbx32ii5yx6zlVbTxjXzx0H60Ad9yvzb4G3F0ZNzCJroA+M
 +7+DbgByhCUPQOuonj7MLR4Eht4ocb9X5iu9TUi3J4tZkEzoIfxZM4flGXqbv3zVDv0WtfNk0gt
 jNJM=
X-Google-Smtp-Source: AGHT+IG53Vnn+gUYeeMHbsnUVetwLntTh4d0eMKpihQXq8mvyqR0BDw3YLhA6g2/5ymNyyH8S9YVyA==
X-Received: by 2002:a05:620a:468b:b0:7a9:acd5:1b21 with SMTP id
 af79cd13be357-7b193f4000dmr2296501185a.50.1730240905912; 
 Tue, 29 Oct 2024 15:28:25 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sughosh.ganu@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20241023152203.1218242-1-ilias.apalodimas@linaro.org>
References: <20241023152203.1218242-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/2] lmb: Fix lmb_add_region_flags() return codes and
 testing
Message-Id: <173024090403.2563570.16949704069617833.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:24 -0600
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

On Wed, 23 Oct 2024 18:22:00 +0300, Ilias Apalodimas wrote:

> The function description says this should return 0 or -1 on failures.
> When regions coalesce though this returns the number of coalescedregions
> which is confusing and requires special handling of the return code.
> On top of that no one is using the number of coalesced regions.
> 
> So let's just return 0 on success and adjust our selftests accordingly
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


