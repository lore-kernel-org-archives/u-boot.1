Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79793C25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 19:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7EC286FDC;
	Mon, 23 Oct 2023 21:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c482kZjL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF7B86F97; Mon, 23 Oct 2023 21:09:06 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957A587774
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 21:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7dafb659cso36880797b3.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698088141; x=1698692941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frHNDGiyz/vloyv70CItSeU27dgBhRH+jegbjcfL6Ns=;
 b=c482kZjL0ewYz5kMHNwp88o4KpQhsiPg8x1u+BzqbbBfkovQqvKVoQtjVUyMMkeW9a
 r4G1E62cc7IDi3tLbJ93LNAJ0Ivxs5vJlFKMbhKTpchAoG5FK3Ko6Nv4Yp3M3MPHxbJ4
 6Q4qeAY3t18GKsUR6S0QYVmpW6O0WvIobZWcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698088141; x=1698692941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frHNDGiyz/vloyv70CItSeU27dgBhRH+jegbjcfL6Ns=;
 b=Bv3Cec/kfOIw9oCIYfBPcOz6N4xlXzvYLo2CGnRo7Y2AXvBJMHD2AxeQnGCio1ATYj
 5diPt9kAkI3eIck8Wm63VJSGQSWXKEdh5zyAwhh9+FMImpr5kAjKmpLZ0vke1zkqazKr
 MjW/sRRgpY/o73b4c+fp/o4dIsCgOu8vaPD9nll/eYOGUKByW92UatqmlF7crqZ1FsDq
 9u0pH5OePPJ1ESvxZihMO9Revy5Qe6F4u4Tu1g72U6wkY950/J07UiVJzhnDBFDXa7wK
 bMvhtRWN9B01TRfp611U+jnknVso+hVKmGS9KUFi0653fibkSKeqzcDiLYScOgPN/xxo
 53MQ==
X-Gm-Message-State: AOJu0Yxj09/h8naGcMNumNbw4zHrX48cap18GLHJc49BIGB4+pGwj31K
 od+lSuHhI7dl02oRCjJ1PRmQvsPM56H92llQ4XxRDw==
X-Google-Smtp-Source: AGHT+IH/qsdeswM4xNz1J5FoCLOJk/sTq9PojWNT0vUk07WU9vDw9K6Ni6C/vCvtJh2u26TC044bmw==
X-Received: by 2002:a81:7c82:0:b0:59f:6675:7771 with SMTP id
 x124-20020a817c82000000b0059f66757771mr9667822ywc.35.1698088141092; 
 Mon, 23 Oct 2023 12:09:01 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-c6de-498a-c903-1c13.res6.spectrum.com.
 [2603:6081:7b00:6400:c6de:498a:c903:1c13])
 by smtp.gmail.com with ESMTPSA id
 l67-20020a0dfb46000000b00598d67585d7sm3353566ywf.117.2023.10.23.12.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 12:09:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>
Subject: Re: [PATCH 0/4] bootstd: Test and boot_targets improvements
Date: Mon, 23 Oct 2023 15:08:57 -0400
Message-Id: <169808766153.2558485.810350301018616727.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023070216.394709-1-sjg@chromium.org>
References: <20231023070216.394709-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 23 Oct 2023 00:02:09 -0700, Simon Glass wrote:

> This series makes another attempt to support things like "mmc" in the
> boot_targets variable. The previous attempt introduced a bug which made
> iteration fail.
> 
> New test coverage is provided for some previously untested behaviour, to
> prevent regressions.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom

