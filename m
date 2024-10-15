Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D09CCFC264
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B1B892E4;
	Tue, 15 Oct 2024 06:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VnLG5uY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3624F88FF6; Tue, 15 Oct 2024 06:30:16 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A3589259
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45effbc3348so42732221cf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728966611; x=1729571411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vZgbcZxbeF7QjdibWQd87MfYHoFPc6zATqMFvfw8U0=;
 b=VnLG5uY48LfVHm020WdYpIR8oK8DJti3UOPRldHPgs1eW19XqnEbydIgS1MSDEaIvQ
 tIckgbkVMQgf4I5nSkTy+jiODV209nvXSZY6UQJ1/DTQWEhBS+jxHcFP/sHmaJXJt48u
 ON1lErHZuzEdYKorNTAkrZpRSv/Q8a88xtQoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728966611; x=1729571411;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vZgbcZxbeF7QjdibWQd87MfYHoFPc6zATqMFvfw8U0=;
 b=n4dJcEXJq1UgM8Y4bgFpmBIJdZVFdsJLzi9TSjrlMiz6tKQsCcFwV1ST/nSoMwuTfX
 uRY3Y8YAKfxiTi2Sm/5ahQH8wvTF7LZAMHj69unebjueu5IvaRgu4XNUK7V8LQbGZCuk
 juTHrc5Ajl4LvbmX7kYLzmljGw58H0eIz2iaUzLlnHk16sGmrOmLI+AAWwxo74JxZU+9
 dhwnPflAGMTaPytawWry/0H0sdA+QnG6yo9VsSI/0xT/9wO5R9furtIK2UFZVszxamWr
 CU4DGgr+aGX1GiJneq79qBVx69ocFaLEAr9J86cwN/u1T0Lz1Z7ElzTC1M/QZOa/NOX8
 KpHQ==
X-Gm-Message-State: AOJu0YxWlOs929NrToCg29SxxNpU9UoYB4jACL0fWSR8JvdNzUmvxNFd
 Z0ldr/hnp2YJnGXISuSWRX7z1xZAhYztJmcgisZiNDD903qO/PmXau4oga5HDjQ=
X-Google-Smtp-Source: AGHT+IHWJcEXE7eTFBHA/ugd/uCqo6h4viX++OlmZtqZHAVsn6XbN9tjw8nUBXkSasHUy+BtreeCmw==
X-Received: by 2002:a0c:f410:0:b0:6cc:12af:1c09 with SMTP id
 6a1803df08f44-6cc12af1f17mr52548906d6.51.1728966610589; 
 Mon, 14 Oct 2024 21:30:10 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2298fe54sm2243816d6.142.2024.10.14.21.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:30:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 u-boot@dh-electronics.com
In-Reply-To: <20241004001118.322531-1-marex@denx.de>
References: <20241004001118.322531-1-marex@denx.de>
Subject: Re: [PATCH v2] dts: Deduplicate dtbs target
Message-Id: <172896660693.298614.18324975776134985273.b4-ty@konsulko.com>
Date: Mon, 14 Oct 2024 22:30:06 -0600
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

On Fri, 04 Oct 2024 02:10:42 +0200, Marek Vasut wrote:

> The dtbs: target is almost identical in all architecture Makefiles.
> All architecture Makefiles include scripts/Makefile.dts . Deduplicate
> the dtbs: target into scripts/Makefile.dts . No functional change.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


