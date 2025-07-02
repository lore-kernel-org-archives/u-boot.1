Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08886C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 15:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8172882CFA;
	Wed,  2 Jul 2025 17:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P8NArrgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75BF82EB8; Wed,  2 Jul 2025 17:38:26 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB8582A76
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 17:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73af5dc0066so1622482a34.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751470703; x=1752075503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MufP/iB0m9Fd8TBUlA+5odcaulBwdYsRId35o56aFzA=;
 b=P8NArrgpdH4q4gLsuoW5VhPxG99Mt+Wv7Eu0hcdtUtKpRbPCgLOmEAy1Eq6vL9+Jyo
 egLQRYwn+ibLo3rzvgRxFaiOVmrLPkhfXyVDMVl+FY0gJo5XYy6kCeDQgCSASGh+WyBR
 ni6xKK1NK5/J4/l1stt82RQ9hCkTQiMo8jCXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470703; x=1752075503;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MufP/iB0m9Fd8TBUlA+5odcaulBwdYsRId35o56aFzA=;
 b=WsolJCNi/J5pc+r6pSKRD1VLPz76Sl3DcSzbj79/jnIMa3QmZNtwhtWP+vW1abJPUe
 IEnuwGxwMmUn9/PqwwW2hej7j7C+yQ3q47XZZmUN09FtLtcoiO5rWZGaA46dUOiLgoEI
 65mJarX0Hw3j6Gzu1ARBSsQrX80mEF35RBKlYeCyZqasSsfN8kcu8l0kldjDMOpFi29f
 pQ4MLaHSTTZRvGtFs5iRLx255AUkt+3g4f+4MVgwWrr5aiWzpw8FcqPmftMXKSUfXkaF
 H5WJ9/grtczGaPpa6MZ3SwLjtf5EuXvttIzRTJRa/nN5xC5TkuoLuLxVuIs0NNy9fEgl
 IhJQ==
X-Gm-Message-State: AOJu0Yxime90gzoGi1lZLDv6UxSSNPzRan/ZGyKC6kvXbKfLMOczA4Wp
 8EzXOOkIiVV2aAMr3nYCevadU+A5/VRDeJLIUIV6oCseK4s1y8QCnRqiX0E1+P1lEMc=
X-Gm-Gg: ASbGncvhLvXwbszVKhdvMxyhpQfWvvPpqKKx1z57FqlNRCRexHR6n8sOvYfI2wdZtbe
 MpDUcUKpfkGJOGGfFpKvv5NUhWc62w5M+DamPCm6OKjjSTB/61t5zGwqQIIdn8ljV/qo8SjDH2T
 0mNColC6TlqEgcGpwJoL5ha2mft+XzrDW2dU6VbKHtlCUx1wJwEj2ie0RLYUXUHDgrZJz0z6HbG
 I+XGzOi0hI41Xpfg8L5CrX82ou60GlWYV2tmsWDC+vD1Y6A8nT8aX/NS8nN2SWUFdQGKAWpoRJZ
 B5vGHWN/BdtpjqDOnvbGdrQPGKGrgG5onmpqlzjSYQfmuJ94SRLpkFd6pYp6w3U7avVQkzNoekD
 y8tge6SZthz3iddlqo+o=
X-Google-Smtp-Source: AGHT+IFAI2fUNFwBn5GRyxGgYxhmtRr4e23Rvb5XEuUUEZkQVlfZt5SlhFMeteshw8f4BEhOkUv5fA==
X-Received: by 2002:a05:6808:8188:20b0:40b:9948:f2a9 with SMTP id
 5614622812f47-40b9948ff2amr1171278b6e.11.1751470702939; 
 Wed, 02 Jul 2025 08:38:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b848df75sm1756343eaf.15.2025.07.02.08.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 08:38:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250702085456.GA27006@nxa18884-linux>
References: <20250702085456.GA27006@nxa18884-linux>
Subject: Re: [GIT PULL] Please pull mmc-next-2025-07-02
Message-Id: <175147070227.1759231.13672014601115488103.b4-ty@konsulko.com>
Date: Wed, 02 Jul 2025 09:38:22 -0600
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

On Wed, 02 Jul 2025 16:54:57 +0800, Peng Fan wrote:

> Please pull mmc-next-2025-07-02
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/26911
> 
> -----------------------------------------------------------
> Get clock manager address via DT for socfpga_dw_mmc
> Revert "drivers: mmc: rpmb: Use R1 response"
> Fix offsets relative to the end of the partition for mmc env
> ------------------------------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


