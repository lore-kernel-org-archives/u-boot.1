Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C16EFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D523847C3;
	Wed, 29 Apr 2026 10:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BFnOxrn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5599B84712; Wed, 29 Apr 2026 10:50:25 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 254EA847C3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso126002385e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452622; x=1778057422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXiswBwjfJN5UHPIIUzkHSv3u4FjAaBgmiudyaPDMk4=;
 b=BFnOxrn8wZNqejX5c0vTbx7dRL8LqdOrbS9Nvf6+SdocNcUE5XAqZIlunPcZXf2TCw
 RbvZf9EtZPVezxsRgLM7e/gV6VMy42PrQHFfabzsYWiLTd5oBFCuESTohZ3dQK7Si9j2
 DRPcHOr/2PW5SaqQBigl2Aj7PrO7j/Fgu/TbEDFe1fMZFbMpo9Ij5wXUgpx8AipRhl8t
 dWJY2R3deqemn7JrTfwKILTZ2L1znS3T+60b9/NdciKoNEy0jR8KMNTeUcsluUSSq1oM
 ZmQ8c3iHtVek9L4t60xSXnVrIhz0k6XOhsy7B5agUiueQsnIfATxhZSVlBbtDrtkXwPY
 Dmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452622; x=1778057422;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gXiswBwjfJN5UHPIIUzkHSv3u4FjAaBgmiudyaPDMk4=;
 b=RILbaRdfpOwshzd/hMNJwppnPqzkZjtvalwUenEyZa8kp+XpP3HRw2EXc+0LyzMJci
 i37ZATDSjeJ2IC/jSiRniv58AE9CkCmwpiz3TUS8vWUCpMpKKn3SJAq+QiUJ2C5zN5Kr
 UdirPnSADlsBrmF86+B7XJ7+MhqTCQqSmNrIqinc9g9+TD3QhbfWojnc3Z0S8DiY9jks
 o/0PbPSwtGdeu3cPR6V5PO8eCqvF2zJIa6wxu041Yp8I6RyVHZPeF68IoQz2msKitjlQ
 4/lRIze/Rq3kTjtg5Yc/rPLend1enf9TNL6adjwObzhwjJqpmBUw1cjv4EKR0e3fXhEG
 9EDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9T/pKcwzngmtGozIPcSNWs4MY5ME+K+QUrK8np/Lo7cYJ8FOB1N4qXbQra7SBe+E0PiehtNaE=@lists.denx.de
X-Gm-Message-State: AOJu0YxsJ/8f30wU9GamlsU1PGWgxL9Uvv9q3l2eRA91ccd9MQAHe4Eu
 0FeHk7aVqI29+Xe9jpVGxZdMdYt0MBhVPeFvvCQfFAF7sBJq7XCQPPhJbO+ddB66U2Q=
X-Gm-Gg: AeBDievgE6USjer4G4mwp6welYfHxkkrFLF2Kr33l9ZsoNyiHTW4GGRm03aINqKSWMS
 EZsaNfKONvFd6Hzlv28y1ntom8FZXAfkSYeXie2hEiT0ruPdAETi/K6rq3OWZvx/GKon8GkC+Oi
 u1g7Ct9rLrS56ZRhRICKWaNixtMfoRaOgIsVCz14zQkIoy1b2rELXUJH3cnuAIF0/peTsoiiS7H
 sBl3fHA1ViTCKqVwlDWbYfEXHfvzwZFK6bhH9D+BCMnR2eNTT6ZYpx7sSXYIVRxh+A+9zuO7wdK
 hr5BSW6y5izP/xMBf3c1bAyhUbB0wInTBfLBdQzSjTExzBaqQM/L+Aid94JOrI1DRDmo0gNxV6x
 5bCc03HENgJ0kU1coYf7YmASdUyi2ozB9siURS+KM9T2RSTv9ZxVNK47DuJbDpZbtqG4B7vMLHf
 kc02Y/EkC6P8DL2yqOSQoO8Z8CVkV2Jj4DCunLRPxx0Q1lnEDrDZxt5pyBeZMULiEu+YRxbFO6t
 q0AR5M=
X-Received: by 2002:a05:600c:a119:b0:488:b8bc:6a32 with SMTP id
 5b1f17b1804b1-48a7b5473c7mr36832405e9.23.1777452622478; 
 Wed, 29 Apr 2026 01:50:22 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c326873sm13923465e9.34.2026.04.29.01.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:50:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, phone-devel@vger.kernel.org
In-Reply-To: <20260217-qcom-fdt-overlay-v1-1-d0fa0e70d738@smankusors.com>
References: <20260217-qcom-fdt-overlay-v1-1-d0fa0e70d738@smankusors.com>
Subject: Re: [PATCH] mach-snapdragon: allocate memory for DT overlays
Message-Id: <177745261543.126665.11547624657879722362.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:50:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=554;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=V5gwdc39n8AjwUInVNfi/JKLV76E69c7Ygir2k1Dvaw=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGnxxk2gNp7r1VLDXNSk/oPihjpKOvbcmwNOhFb9ZCU9+sgNr
 Yh0BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmnxxk0ACgkQeTBFn7kwMhdLbAD1GN96
 gCg17qB3On4/0NtIPQErZOBR76ZxwaB3tHyFaQD/UMxznwLdzHfCB5x0sV2RoVvlpHe64A449Jf
 LNTTJLVQ=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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


On Tue, 17 Feb 2026 08:51:34 +0000, Antony Kurniawan Soemardi wrote:
> mach-snapdragon: allocate memory for DT overlays

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/1] mach-snapdragon: allocate memory for DT overlays
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b7c1703b55cb

Best regards,
-- 
// Casey (she/they)


