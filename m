Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CB5C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 16:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BEEF8277D;
	Fri,  4 Jul 2025 18:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NSUuiROG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F18382A76; Fri,  4 Jul 2025 18:56:55 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01BE0803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 18:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ef60dbaefbso943062fac.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751648212; x=1752253012; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bb8eBrasiLSzJlty+ZdUA6mieZy8huTiLtjBApLk4c=;
 b=NSUuiROGJF3fm0po1Q+7wB22YQwMCgj47nGPeh+0Tn+ybfU7QZfFunSSuKzWtpK5c8
 MclTb5m7d+6mk7IPRmQD7zcqwkt6+dKf9LZ4C1IVFh8uu6stYTaNsycaRxA02QT675A0
 WXa7J2tjbnTlcxKfurqz/EA0ilXGKkWPCEUk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648212; x=1752253012;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bb8eBrasiLSzJlty+ZdUA6mieZy8huTiLtjBApLk4c=;
 b=PGRpaDyrpsmlx9vNyeb1YmN/yg8BHAP4P5HnaJbqiu1pyGE6kb/Vf9UONXtk8L47Qo
 CMtqIzs2puvRT7owIMlOZxMz3sMdH35+qbhLhNLIDkDc+Acd/10ypoJ9HWSPWl5Ktxch
 STAwzPDw0zPU1tpgzYrCdA0LVCoY3azn9nrukwOIzX6QLaN3uT1Sj81XzGURXGjxL8hm
 IWRfvsojLQxHnwtXpgXsw1uq5QXXxr1+WyBW35MO4FlDb5z2KZ81OHWW1eWx0eRI/soq
 artcYhSn9gW4tUso1IozkXwjSkmB0ebIrZ1PXLYGg0IPVbPEQpN6QuQ8s+f/YOrG2NrB
 rezA==
X-Gm-Message-State: AOJu0YxaCBUD/LoH7uHHl/0EjlvzMf4ElyRTf9xN5z1PWquenGFJX80n
 eD1PPYXAQ/9K/uGVbkrYf2COwlucd45ztV6MInnAsj8ZYnrFbmplhC4aAxX4jklGfOs=
X-Gm-Gg: ASbGncuKADCbbGDfvydf0h61FnCQRvOkZVRfLbZJgoaa3SpbxqQF27t9M6EJfssV/e4
 cQP17KiZNR3dDfIvU47sqko/nb3M6VKij7cNpeQ8VjXZFDd32eyqigr6lsVabePYef6O2NF+EdE
 L11L4YvMpwVxFbijmI/4ErvxcrMCgYZqVEEDsGKwEsj/hF8+L5DHtg4dTE0ok0/xAZvLqjk7NhK
 //+nYsd/4EEy4pFnmEKK5aDex22C5JDReqzxwpNTH34iWxJxwRHPRWfiDart3aACRetemaK0zxd
 ivS2og3OwqtZ3Qj4kdGyNNd2kBLeYXOWd6M8CGrw3MU4g4GJG5tOlYxyKMpVINY4X1lFtOv4PPP
 B86fJ6SOGbFSISBztpRYjP/uPkdA+Yw==
X-Google-Smtp-Source: AGHT+IEEf9OoeP9+U/g9BPVbmw6BGNO/ceZ18evJZX5cI2ZKOARtZXHmZjSS0EE6zfgsIyeSFxRlNw==
X-Received: by 2002:a05:6871:79a5:b0:2d4:e101:13dd with SMTP id
 586e51a60fabf-2f791cebf01mr2787601fac.1.1751648211738; 
 Fri, 04 Jul 2025 09:56:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78fefc2a9sm595792fac.4.2025.07.04.09.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:56:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, 
 otavio@ossystems.com.br, michael@amarulasolutions.com, uboot-imx@nxp.com
In-Reply-To: <20250704144022.3946416-1-festevam@gmail.com>
References: <20250704144022.3946416-1-festevam@gmail.com>
Subject: Re: [PATCH v2] mx6sabresd: Reduce U-Boot proper size to fix boot
 regression
Message-Id: <175164821078.3259979.7672907617517362999.b4-ty@konsulko.com>
Date: Fri, 04 Jul 2025 10:56:50 -0600
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

On Fri, 04 Jul 2025 11:40:22 -0300, Fabio Estevam wrote:

> The mx6sabresd U-Boot proper binary size has grown beyond the
> CONFIG_BOARD_SIZE_LIMIT.
> 
> Reduce its size by removing the CONFIG_MULTI_DTB_FIT, BOOTM_PLAN9 and
> BOOTM_RTEMS options.
> 
> According to doc/README.multi-dtb-fit:
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mx6sabresd: Reduce U-Boot proper size to fix boot regression
      commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
-- 
Tom


