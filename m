Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A959BE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 00:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B208021A;
	Wed,  1 Jan 2025 01:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t1Lxmn6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67FE48036B; Wed,  1 Jan 2025 01:59:20 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948EC80196
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 01:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8fa32d3d6so30234556d6.2
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 16:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735693154; x=1736297954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IGS76Kag+94ZUmDguSd2UulQ+BnnayN8il5NUjObco=;
 b=t1Lxmn6p5zb81odQxVTGCJzajk22naqobVfzMm3bddS3h8+Ba+ks7voLaFC7xQEYaI
 khusVmLdDnhk9tdch520UH7ctdRdhL1DmqwksNcJV87L+TkN9FaDAf/VN9PMw6HV6Akr
 kwSsTbo1amb/jMwCMH2lxpH4nKjo4p90pRpWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735693154; x=1736297954;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IGS76Kag+94ZUmDguSd2UulQ+BnnayN8il5NUjObco=;
 b=a1AoohUwD76P4C2EbLIWKgI7nTYHHE49SNDmpxAegrJ5frGQjUCY+LFq8mG9QdZfkb
 gurS2DQRVSvL7jbYZlGvX6+4Ry4bbuwfoj7hoNZ7amcKOhh3otepZXtD6rEt5gzc6Sco
 S6Ejb4xLATiqCD7lULICpApCp0/mxwldhueuD0NPcxMiQfHVrE0+CJ/kOrB0oc6PA5fB
 E5j9T22xWVkzMCJyKtf/6Acbid2vLZRuj+gXaBJgewHpws+xh6GTPO/NSiKsoJs6o8PN
 5+12+n7lqdkyUVo2WfhjSo/c0GVy6g2bI5Uj96ZzaVYjRb3aZJQdXu2QgwoH1paBOOfM
 kCvA==
X-Gm-Message-State: AOJu0YwgKUbuvwaoAUcGAkfpw5A8GjRlYzfVlML5ScSlbHKo7jodDfEI
 micG5XweLaiVZ32GEsh4wF94dtQ7e8fYn/vDSLIwgww8k70+mvKlPuq1Cvqw8j8=
X-Gm-Gg: ASbGnctdZwCBpfzy3BQjF9MuftYgg6ot4X5YKlTQGGJQDtZY6VrNDub6RIkXiWiqcNs
 c14UYZa9esJnaGUTNrcZ1DQmAvQYvRpRtQ39ljB71MkI50XTipE34bgy/9ctpsWC2JiTTMoPoij
 avRV8o/CpIk9ujOyFeXCUFDgTub0AO1p1Epc97jt+KorgVFP6B1ddeh9dXIdvags3IQpdtzr9XB
 dKimiSVggxkkWXtxcSbW8rOt3tIHuvUQa2t4m1OkvuMexURkG3Q+eao
X-Google-Smtp-Source: AGHT+IF3OLNyLiw9SnlxchxceIPn2+gO0f+akVIjW20YpHIvgEMvyjF7KnRkbYDHARX3mNZKaaJ/Hg==
X-Received: by 2002:a05:6214:2522:b0:6d8:960e:5785 with SMTP id
 6a1803df08f44-6dd2334ad70mr640621456d6.13.1735693154591; 
 Tue, 31 Dec 2024 16:59:14 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180eacb8sm117147896d6.20.2024.12.31.16.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 16:59:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, u-kumar1@ti.com, 
 n-francis@ti.com, vaishnav.a@ti.com, s-k6@ti.com
In-Reply-To: <20241218131341.2073823-1-p-mantena@ti.com>
References: <20241218131341.2073823-1-p-mantena@ti.com>
Subject: Re: [PATCH v2 0/4] Fix OSPI boot for J722S
Message-Id: <173569315220.1610380.6477524207642863654.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 18:59:12 -0600
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

On Wed, 18 Dec 2024 18:43:37 +0530, Prasanth Babu Mantena wrote:

> This series fixes OSPI boot for J722S. It contains fixes for DMSC
> communication, R5 regmap for ospi and dma specific overrides for ospi.
> 
> Test log: https://gist.github.com/PrasanthBabuMantena/ad469dd09ab7263f85f87dadda46c86d
> 
> v2 <==> v1
> * Add Fixes tag wherever required.
> * Improve commit message.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


