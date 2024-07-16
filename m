Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528B6C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 23:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C50188A09;
	Wed, 17 Jul 2024 01:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qajwlwUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158C788A06; Wed, 17 Jul 2024 01:00:55 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F05D888785
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-704494efa7cso3594319a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721170852; x=1721775652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1i0NiEwjpiF9GsRlQOXJq7oHsO9Z25E6DKD4R8nIWY=;
 b=qajwlwUdx+g6mKf/Jv2CYuKbXL98gQ9qBWmLe6EDQ7typWF0M0atd0DB3Ik766fi7O
 2Cr0qkDso8cHRNQxIn0pNpNQdAPjd9kFtekE83xTkH9ijf7O1lwTwTy09vcdB4LyFAng
 UaWLDFesjNphmcnJb8U4N8+JUbrNCjg6yj0oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721170852; x=1721775652;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1i0NiEwjpiF9GsRlQOXJq7oHsO9Z25E6DKD4R8nIWY=;
 b=nRTsHiGtWjXaZcin+R0nqyv+SttaMBbc2xa1UIWQaRmG7XUCXLKdRF2k3HR8D9Aq7K
 YJSG6mokrMQBprbUwgY9jXrfmJZIfCksga8m1A+G/beMlaZ7fpY3zoGhurjLn9j9ns0E
 m/yOW+FyarrIgGtcBDagcjb9MBfG7rs6vYoFnUadOi5IvI2ymEHdrz9OWnyiFHPaC5M8
 DMSr9wK5ATcn8Eac72kd4N62LjWx8LhlhM7pfaPyvJY8Dqjy/aQ9emtXkq72Js1Vx9Yz
 EWviIJxwjGnhB8DINfi/ynimNowj/tcn3Jw/0E27CzkpaG3rosm1xOKmDq1zNT96aEAt
 im0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGcirXOSUk+HymsxyAXJVoxYkNFHQk+hhrLx+NffGkY67JthVXAyd0CeyO6JRG3b2t4/jOc+KyyKW94XVdiwiGyM+tUQ==
X-Gm-Message-State: AOJu0YxWpDN1aXHwSv6SQDWhyTE7FiMrlja4aaomlmeJD1p86lAaUSFA
 EkUisVPpWAhU/J+FkRjTEEmJHmFHaINFgxCjhvlaerJtEZjl4QSgxCYw58+4bxurhy0BUQ+KTCH
 f
X-Google-Smtp-Source: AGHT+IFRJpn1dZPszbsnGEawSc7LICBJoYzMIcfTMeN2VHxWF/U2hUaeqlQkTuKe0dQE4i3FzIRz4A==
X-Received: by 2002:a05:6830:6589:b0:704:4824:2b3e with SMTP id
 46e09a7af769-708d9975d64mr4631697a34.19.1721170851752; 
 Tue, 16 Jul 2024 16:00:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d2fcc2sm1510063a34.77.2024.07.16.16.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 16:00:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20240628-topic-sm8x50-psci-power-domain-v1-1-4608830f194a@linaro.org>
References: <20240628-topic-sm8x50-psci-power-domain-v1-1-4608830f194a@linaro.org>
Subject: Re: [PATCH] firmware: psci: register PSCI power domains to stub driver
Message-Id: <172117085081.763145.8962437813856686132.b4-ty@konsulko.com>
Date: Tue, 16 Jul 2024 17:00:50 -0600
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

On Fri, 28 Jun 2024 11:54:47 +0200, Neil Armstrong wrote:

> On some SoCs, like Qualcomm SoCs, the PSCI cluster power domain
> is used by system-wide firmware interfaces to make sure none
> of the CPUs are suspended before submitting requests.
> 
> While on U-boot we only use the first core and we never
> suspend it, the Device Tree still references it and blocks
> those nodes to be probed.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


