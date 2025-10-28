Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2FFCCF9EA
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC3D8391C;
	Wed, 29 Oct 2025 00:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="doCJmRkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 603FB838D7; Wed, 29 Oct 2025 00:57:44 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E363836B4
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-44db11c7ed6so1775063b6e.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695861; x=1762300661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/e75cm9HO+w2kpzGI1A0sMsCBu2W3fRawUEoxLw9Js=;
 b=doCJmRkgSxiiSFAROARFVf888W/vcje7O9zgC/YZdUv0yDKxKq+PMUDhiVBdLlf4e6
 hDz4EuXNR8A2nXQ8ePSJtljRMsA2msrKU98ZCU1J4wTviRRqYnQhzTB+3ptfwOkGprTQ
 klvx9dpGUcgZPd5BqbhUX9qfmp4CgKTv9ch7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695861; x=1762300661;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/e75cm9HO+w2kpzGI1A0sMsCBu2W3fRawUEoxLw9Js=;
 b=fyeBZxHD1mbm7GpGDBit04XcZGiyYgkd+mXHx7Ei2jtAeqamlToptEkes2seTvV4vR
 Oc0gHgNC3wZyjP/J/YMzqYaVtAfJw++qaGmv2NwKdJZavpw1+q8MpUvFfdcJDAfuHtqp
 3wdRF0cBuYRfKap7vE+Yz2b2EBnl0gVz6bQBXCTgM9ipq8ea1IfZlhfon2L78QRs2iP5
 kfjO+huRbYleY+tR8mOU9QAj0ooqugr/+S+E49BE/FHbI4OMIoWud7tlSiU/U+APstki
 I9L6dL3bSc6XwCA97XoxeENAyasFuBNkWtvvGBNnEG7z9IsJ+C6cRoCD3T5hW6nOnaLb
 aNfA==
X-Gm-Message-State: AOJu0YzOrnNlLg42cVlcoXD2YmxqSHXipM8/3OJnhQXx163+mMPNhni4
 Pus+E5puXd4+8sZgg6K8wfajnQS/pq/z5ULfztjP+2adMWFjmVLufGJYfv/61xW19ic=
X-Gm-Gg: ASbGncu2qDfSwkZ3RO+Wy+xTny3stB2Udu5MMd3t9bEQXz0zaUMo7nTvZFhqIESuWUQ
 yetyOjzLKueXk8/9QNNnTikGy1c0sjqi7NWNG4tdrQIOuKbQvUWevt+Glgp7Xdaaz775J8ePu6G
 +OcmnbFT1qFksOtZ3OpcyBgHoa/eT+V4UxoMFFJ5f7Q81cZ86IknA8iLP9Pjo+detZKDVyqG9hH
 OrsgJ7zhWVgHdFrNQPX4vHszU6fRzdRKu9fgdlQ4Hpih/fQTop72dbho2WnlCGB4spSJz64F9AE
 NJ4CoI8RtcWjAcy2aaKLW9nbHNFH8PhqpAnjCefnOQjSWfYC6ua6SVSYX7wKycks5UQyQDBdL0/
 /6RMalqoTPYREy0T1MOCTxdng2NjGVX6pfZPZiIry1i0p6RtmyuTsqi0QzhTIdV/3qd7ASGDoeo
 f993QfxnvNJ4fxD90Nwb/LV2xNfubFUnBd3jlYsA==
X-Google-Smtp-Source: AGHT+IGh6qL7EcF7MMmFQp7dCJO/WURCr36bvdTIi8uZXzgiuFxENqSckAX4k2N4+gfbmNExzvwE7A==
X-Received: by 2002:a05:6808:1789:b0:43f:b94a:14f2 with SMTP id
 5614622812f47-44f7a41ed59mr691701b6e.16.1761695860975; 
 Tue, 28 Oct 2025 16:57:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>
Cc: ilias.apalodimas@linaro.org, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Simon Glass <sjg@chromium.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Yao Zi <ziyao@disroot.org>, Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20251028202618.7893-1-raymondmaoca@gmail.com>
References: <20251028202618.7893-1-raymondmaoca@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update my email address
Message-Id: <176169585940.2287207.17613071672095744909.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:39 -0600
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

On Tue, 28 Oct 2025 13:26:17 -0700, Raymond Mao wrote:

> Update my email address in the maintainers list.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: update my email address
      commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
-- 
Tom


