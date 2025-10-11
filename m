Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2621FCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 17:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F2883A5B;
	Sat, 11 Oct 2025 19:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dnYItsIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385D08386D; Sat, 11 Oct 2025 19:07:33 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1DB83A25
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 19:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-64442ff55c2so845330eaf.2
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760202450; x=1760807250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=my9228g2sF0h7aRk2vA/3Hv8+HG5zHfVw5oj4SrfuQo=;
 b=dnYItsIpwRmfRKVfLsANet09kFP986kK6b7/9PB4VRiLsScqwqUvgeOMC5QdY/yzoU
 ZSKuCh7X3ZhMXTh8mzpUtHI4Pjd3LbK5I7YnX4qj0zH/oXJoN2digUVaypyadP40PlO8
 Z8+eWbYLGjO3b1tuARK0dzlcQ8IK+0Z814lE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760202450; x=1760807250;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=my9228g2sF0h7aRk2vA/3Hv8+HG5zHfVw5oj4SrfuQo=;
 b=an4Q7YMgb82QNMO8A6BYmfLIda1o+JxWmfOGXCB53gKg47Pi0VX/MNHbNC2m+5r6JL
 C8swWkWSZGqEAdmlLc4H8CB7sEai1Ig9SoBO/SvKW0qxv7snHvwKibdXcH6ezUm66W76
 nltWchFanuzdvKS+K2um3mazTiesY2sUe1H1Atdjz3yBqZVPyRX67o623Youx++1G9Yl
 B757YC+Yo/wkTaO2wNITYQZNP1LUodQz2mImTzqDzJoK4z2t8iSTZUY1CSel7MVyVB5+
 CWcUCCXYQ30IKxg3jfhkwGM668tRFOt4vcJ4p6Gx5/AhMSGZUfGSjnFwF3+aZd/4CGsu
 ZdOQ==
X-Gm-Message-State: AOJu0YwDlesr5MyAUYV2gd4/2hJPdsJCVNnoPeDLUZpxIQ6UlDaOVzQC
 jXwjeAIlOPmsKviaAkiiBMIVcGU8UysPIzBB5Z+ZhsAfD0IRaCcPhiVV5B/OfhIQtMHZKEcg4o6
 9+7SudRA=
X-Gm-Gg: ASbGncsXwF47iuaSjssxHVWcs/79QPBfk39s1IJzpC1bAXE6+eGexDTsjR2S8fEqFvm
 1unT4EEQbDWc7KsiA3LJLXDfMDa+iKVmTiXcHbAuj9+TGzZlklTbHJ0iMNJdbM8GAYL/krFhSKS
 hw8eSfAMI5wtCOF7BQJnqSeoHcUNtg3fIx8/xjApoSvprnSjiOIKoQ2ld3ayYlknEE7aGyodOqr
 65jO7yXaW8rW8v4/SBHAx/DziYcE93wcshS/rKxnr+E5YLDPSoArJhHt57dEapK+LtIybkFo0A/
 MLpID4mW1Z7crZEuBDLlD/ho5WkJuVKaAMibdg6OdGnEqKsG0EUNwAtzMsDZmRp76BSbrZT3S6i
 qGlfdqOhgLc8nmzTKKzP0l5XEokL+295aJUVCKZCrDyTDjVGmq/3TLDXE16RO2FVq+KV0jQg8ef
 2bgv4=
X-Google-Smtp-Source: AGHT+IFOshn2mkCzIXAdmB3LjazzPDBz+SMVF+KpbUw0PltYC5YIT0H08YXTxzPQyInuIfdqQ13lKg==
X-Received: by 2002:a05:6871:2b25:b0:36d:287c:694f with SMTP id
 586e51a60fabf-3c0f80edcd7mr7164822fac.30.1760202449766; 
 Sat, 11 Oct 2025 10:07:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8adcdfesm1970991fac.1.2025.10.11.10.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 10:07:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Petr Borsodi <petr.borsodi@i.cz>
In-Reply-To: <20251002-fs_jffs2-v1-1-d53365c53f8c@linaro.org>
References: <20251002-fs_jffs2-v1-1-d53365c53f8c@linaro.org>
Subject: Re: [PATCH] fs: jffs2: Remove always true test
Message-Id: <176020244897.1312138.14936176658471675206.b4-ty@konsulko.com>
Date: Sat, 11 Oct 2025 11:07:28 -0600
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

On Thu, 02 Oct 2025 10:29:14 +0100, Andrew Goodbody wrote:

> Testing an unsigned variable to be >= 0 will always be true so remove
> this redundant test.
> 
> This issue was found by Smatch.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fs: jffs2: Remove always true test
      commit: 48f21e66e360552c75d70a50421d0e0ed1f59e90
-- 
Tom


