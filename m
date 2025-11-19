Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AA4CF394B
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 16:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B550183EDE;
	Wed, 19 Nov 2025 17:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tx7PPfLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA5A83F8E; Wed, 19 Nov 2025 17:33:30 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B67C83DA6
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 17:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3e84d56c4b8so3588824fac.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 08:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763570007; x=1764174807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFD53ANBMb9V3ah7vmmCYQ0+PC0pC6RIAxDZoaYN+jk=;
 b=Tx7PPfLT4wOGnT62oBkldT/imJNY8ivoPlJfR90M2pOLeGoBITvo5HmVJ+yVwa2A2u
 6FHUbqmko6C4IXc9JofFmhS/UifSNwZmdnSZrAGaGK7TSA2nRHA0ecYCN17v8t49z8CD
 Qqm992PO/ANcey9DDaVYF6nM6iDAOZWEk8eFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763570007; x=1764174807;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mFD53ANBMb9V3ah7vmmCYQ0+PC0pC6RIAxDZoaYN+jk=;
 b=iUp/sVE/VnmTaAbFqAIovyXoR3E+sjP4On/6jLlZsgjXYJf00yMiHt0sQdqDZMpTyf
 jU8K4tDov0BazG72BvyI7VMXN3VpjOcLI3yJ8Kud8iCI1/AxZaPc+bMSHnr6XxH7E/nY
 OhNA2kzZqgGACqN52aAvqbLvAKN15lde+ao/7wKBMm+ozRUOWA7jU9OuLwcIRJdcr+VB
 Zxfl9hCLouzXJjeFibdTyHu78c1shCXnF4nGGv/o7rohyxFfdVxgDfN5gaD7dhozVfUQ
 Et2sljj7UJJt5ZjCvEHIWMMYqlchpbyRUmr6zYS4FAYhexTAVh2+ntLllIzbR636PVCq
 1KqQ==
X-Gm-Message-State: AOJu0YwMg+UnwUTuZB+VuwdDPCKkPjR1usFtCiB9oP4CGIcF4c/ADdd5
 leDlAwt6x6C73m2QYb4KBg3KVPqVyFL+bYtYTUIGi5kpTxRwg2U6UsNJFi2H8Rlu2uM=
X-Gm-Gg: ASbGncte08apX2eSoFPuR05W2xF2OCiFclPelQ+q7gYoq0gtxIsPmzsh7vkLvChs1l9
 pp86+9E4cFtStVtmfn09eISx30o8t+SHKFIUZgG/v1Gx1ahhzzD2gyQIanOAxYm2cQeeIp/K2sW
 mjp26wqXet4R8DmiFR2d0JlehGghxifUs+t9kBNqizO2Td6iRDgo1htnZ/jH9aVp2ThOUizuhWr
 jrd59pedqBeg8Yrbvkrj6qNZa2+G5weT6DdvQwM4lgmjWsBTMCAwAfLEmQW5t61wCGiolto6SdR
 s8oP/tffoagFJwt7sJUggqOfLyRFdL9Q3r5O+giA8uqqrL1IT2eYQ/RTWWSfIpveTdnL0+fyILN
 vr6UnQzpxu9izy7p9/2jBXybUwhxpfMP1jtojmqLQyaxBzAwZoLoaoxiSXTArexd6uD6f++AVFX
 fah3ZgwlrmsKOn5AQMiHsYUTsiuziqa0auZwgDDW7VJSywI+Pw
X-Google-Smtp-Source: AGHT+IFT3wvDRxLwx2lg7icDjWsHHJFoKTSAh8643mF0vbvd1atESUXA+uxluWF1qyaIA1Hqcin69A==
X-Received: by 2002:a05:6870:56ac:b0:3e8:44ec:3416 with SMTP id
 586e51a60fabf-3e869194419mr10966507fac.46.1763570007130; 
 Wed, 19 Nov 2025 08:33:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec5962e508sm2781557fac.4.2025.11.19.08.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 08:33:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <faafa443-e804-4506-ac4a-658c2b8cc339@amd.com>
References: <faafa443-e804-4506-ac4a-658c2b8cc339@amd.com>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026-01-rc3
Message-Id: <176357000626.862654.17098535864541775389.b4-ty@konsulko.com>
Date: Wed, 19 Nov 2025 10:33:26 -0600
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

On Wed, 19 Nov 2025 13:52:19 +0100, Michal Simek wrote:

> please pull these two fixes to your tree. In CI docs part is failing but it has
> nothing to do with below patches.
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/28413
> 
> Thanks,
> Michal
> 
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


