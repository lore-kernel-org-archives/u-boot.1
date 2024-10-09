Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA45CEE330
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 17:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5941488D9E;
	Wed,  9 Oct 2024 19:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t5EbmHP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C7F88CC5; Wed,  9 Oct 2024 19:32:38 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 298F888D91
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 19:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cb3d2ce75eso10446846d6.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728495155; x=1729099955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmZjaFBcg/3zmTcsvYnGZDEX8XkZp+cm5LsYPlhiKSA=;
 b=t5EbmHP2nUnBArduUAN+9ek/9ML3phSMJOQIXBbc8FXmoxrnYf7HlitCFhPVTmPB1u
 D8TaKER//53rNIoTuoNYSYVZC6fKVAFQp0Zk0II+gqzynRAdBK+5Z1+qfndM255PvtCT
 NBhBlkWjJSRXJrfTtkBchvxlADsNU/ISySJrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728495155; x=1729099955;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmZjaFBcg/3zmTcsvYnGZDEX8XkZp+cm5LsYPlhiKSA=;
 b=gbLEfzycz4DB98socGEmcXxKSxgaxxlSM5TbCSvAzdcWSrcEFiQ//ciKcCtyyv080z
 TVrQ6vNyozSRm3HLsqgWhqHlBU8hO0iVV9sotQ2XnbWaNmiRUbiSuJgkt0r5C7pmZws9
 1LtgoIRKODcdn5bYuKBRcwJoTqJ1boJUzEvZqwKWeMBkNSXL2B6DFQKWYE1MWkiKnc98
 5C5hhmQ97Q4N1gGJ5i6R6lT0SW7iXbr0S+buzH/GPl9IIToHSv2+tVW0tfpCWZnRkd9e
 WfeyGiEdjOqW8QC/KtZ15wRx7HF3JfmRUZY403y71Ljkvlnk+Rh2HisepdQBOfd3gxF/
 gFQg==
X-Gm-Message-State: AOJu0Yzt/SVFMT0g/8BiGHDckJLNf5ykiZRaCRZmLILNGUyQzQIVSB19
 t7ur0HUWW/vJP1F0eWR6B/TAfRIroH0V7BxQjflMDRQEEDTb7gYiU64OyH9cXdI=
X-Google-Smtp-Source: AGHT+IEPKjDki7duQbh7cQK/ZBVVje/i64kQHOeVEZd4vjBtg7G0nDbLDXe515nIWfpPHs5LbIJHvA==
X-Received: by 2002:ad4:5ba4:0:b0:6cb:5ef6:93e9 with SMTP id
 6a1803df08f44-6cbe522d681mr5973826d6.9.1728495155010; 
 Wed, 09 Oct 2024 10:32:35 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbcc50996esm7439606d6.58.2024.10.09.10.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 10:32:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, git@amd.com
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v14 0/8] spi-nor: Add parallel and stacked memories support
Message-Id: <172849515352.3523085.8429134107950603621.b4-ty@konsulko.com>
Date: Wed, 09 Oct 2024 11:32:33 -0600
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

On Thu, 26 Sep 2024 10:25:00 +0530, Venkatesh Yadav Abbarapu wrote:

> This series adds support for Xilinx qspi parallel and
> stacked memeories.
> 
> In parallel mode, the current implementation assumes that a maximum
> of two flashes are connected. The QSPI controller splits the data
> evenly between both the flashes so, both the flashes that are connected
> in parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


