Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16386C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C6287C00;
	Fri, 15 Dec 2023 21:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FmlBH3K1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091EA87BDE; Fri, 15 Dec 2023 21:56:29 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF2B87A80
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77f44cd99c6so82771685a.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702673784; x=1703278584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=295+wU/92deQviFkVJcIQuVwshoTHEadpDLPn3m31oE=;
 b=FmlBH3K1OL1LHeUpki1FF6/KPiqZR/HmOHAQNrQVlwhKcr+PZskBeiF+M+mW5dzBU5
 oaxdZSuxcH4OL42bD5XP4Zh8YZx316xOGGGjcdwnjlJRfkVORCUVgtD0n/JMJpo92abW
 Hf+PIwUhcKH15LZtX4fqW6ZGD9pZ/uQvPgKuX0BHsxc1FFE4qSdJfiSJBJ6+rhfXsjiI
 DZ+LLDoJ4mrPm3ih0gcPzqPY1iWP4SAmjAGOff5b5EZOijmDlwtKdqis/MqvWK0Z0SGK
 TY0pqd8PEtyN6p/KUvgdq2XRYoFsn8tz20Ct5z2gZvOUYY8O+eKLu4uzt0rTkIeeoKF/
 v8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702673784; x=1703278584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=295+wU/92deQviFkVJcIQuVwshoTHEadpDLPn3m31oE=;
 b=Cw4er8+uJWIiwPv9xrg0yYh7NHSf2QJx37UIeXS/fiBdTO0kdMm4+RiUiq8KYSikxJ
 kOOMkQRAZlfkTHi6UOF2LfUCKpk1FG5jKfS0GChWdSsGFgbEQwrjaZ+fRf4NtGDwbWGk
 U1AyFuxr7MmfT4MrcG6KGIhLj9G9bl1Wr3bCqbQG2S5P1U3Z6rjudvcm4FUFTPFqZzQu
 YmN62ug3UcUCtJzNaQT+lyEtwWA48c+XMSq4lu2l1C2M/XtTz5o5NcNF3zwX3Yonu0AB
 DkLijEvFVgtomcx1pAxd8zosOzA1IPhVlmJkMJ4Lsd9jjrGwSpVW4V5nW0c+z4Nf0UWv
 ynJg==
X-Gm-Message-State: AOJu0YzzDs25xVRGv28lq8iQpCOYvii31qC9CFBlsLgX5y6iNjbawEIP
 U2zZVXYnKGB3mVo3iKzEAVU=
X-Google-Smtp-Source: AGHT+IHX7CeO2+lIEru6zLiHX9vG5JAZlYe3sCdQQaOC4Nd7/acMShGRa1ax5F3B9Q7h9mJ8CVVc6w==
X-Received: by 2002:a05:620a:46a8:b0:77e:fbba:6457 with SMTP id
 bq40-20020a05620a46a800b0077efbba6457mr20039301qkb.54.1702673784067; 
 Fri, 15 Dec 2023 12:56:24 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 de13-20020a05620a370d00b0077d897deb89sm6325887qkb.127.2023.12.15.12.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:56:23 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: forbidden405@outlook.com,
	Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH] test: dm: clk_ccf: fix building error
Date: Fri, 15 Dec 2023 15:56:20 -0500
Message-Id: <170267377371.2422101.6355740792789467718.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231216-b4-fix_build-v1-1-b8e79c94744f@outlook.com>
References: <20231216-b4-fix_build-v1-1-b8e79c94744f@outlook.com>
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

On Sat, 16 Dec 2023 04:21:11 +0800, Yang Xiwen wrote:
> Fix unused variable error produced by building tests
> 
> 

Applied, thanks!

[1/1] test: dm: clk_ccf: fix building error
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/97d65b32d76c

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
