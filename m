Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666F210775E4
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 17:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA3E83CEA;
	Wed, 18 Mar 2026 18:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s+Uo9b+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4308983B03; Wed, 18 Mar 2026 18:05:32 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1523E83CEA
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 18:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-467161c4ba7so37736b6e.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773853529; x=1774458329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=956r7zwzkQrd5z+lJzXYLzXSfSAvRyUVwOlQu7AOgfg=;
 b=s+Uo9b+DIVGKqRu7ZZDZLWYyB34aJVnzEwA12JUoV2Ps5og1T4t5fkqaCyGcok21dw
 P+0n/jI1Sj+bpXgY+V7iUtq7chRJOXowliJezFMFfr/Ywujo0UrMQMftS2aAZ2mnclH1
 K8nZySYvW0gxDHFtn5OQdAVRmSCFdKIbsjXuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773853529; x=1774458329;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=956r7zwzkQrd5z+lJzXYLzXSfSAvRyUVwOlQu7AOgfg=;
 b=F4D4rWuX/GF+G6kNSb3OmVt6rmAIBW1Gk0EWKzPa4H3YS8CVDm6MMkko1tqzCSR9ZJ
 OwHAboGvu/TtqfbFeDTflB+ofj62BxvRwMy/05SErsBMK/tqEVfxV5FVDkw6greUr/Xm
 cf4FuW8I2fhfuqd5LudhuRMBwx0Iptr/bxF5IDw47K0npuMfHfj59S6ETGYke/TaePin
 fVQ2zvtIZm30/eWN/2/nPnFmqwCpU69LQ5zdacaTm8NHmtbK7aFcdNMKX1j8HVIjLwr4
 FEIUV+oxFeW66dd1rv+7tYEsj4FReUpU8NOus3Xl8wZD36WU40PcXE06r+8Z6oW1yoBG
 wVsA==
X-Gm-Message-State: AOJu0YzIA4j13R66W9ST286NyS5Y2axlvgUa4F4+UOHUSe5jGDVa1jL/
 vxlETALZOhS9CVu14pE7UACDMY9oSWoqyEdtceg0FDC+vJ+8ZF+hyssJs7AZBcnAsHk=
X-Gm-Gg: ATEYQzxFtivA9muHsctEDpXE63wazlgxc8UHk7PllAU33UKZmMYCvqCIYGYkKcPOVH3
 gYj6pTdmMbvWq2ri8InarPXgTzHT+M/8lFIQPYH6hsxPMvQ6R/0ZtNO0HO2v99Ew+HgnMQYL5h1
 2ACymYZ4ovh9EnuR3AgDe9l3QZd8OEqPO3x+29HuIs8JNW2ERyPnJDHxnvUPZWSAs2WI72CNSEW
 83AG43fN4Z4RIZGIjpJoKBt+vL2gDZ0/Ln/dpdBN4hL9tYrZ8l5ehFvki4fEA82sjiImODDZzeP
 Ks68qhqOJgR2+/bgWvs0vSktSctcbD4iJQXQ3PhzKMbKKWhMdfMa5kHrHgaFZzbrXkWCp+b9HT6
 W22JnwMY6WlEZo6hl/WLmpzGLdY0mM7dpJp97pi4EulqnP/Xzgrdd5CeX2xA5EBim/rDQCE7T2+
 Syw7iWVH/cKpby56ZIbUNCsSz8KSXDr5EDKJuyPCQKaJDz1/HrSS/KhC+z95ZxLxcw5pqW0L5mc
 BJloZE+WBSwvbu4QgJvJxy6A1JCf4JBHlVuzwbkyFqCazw=
X-Received: by 2002:a05:6808:f93:b0:450:b92c:aaa2 with SMTP id
 5614622812f47-467cd6e46b2mr204519b6e.18.1773853528724; 
 Wed, 18 Mar 2026 10:05:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9985c1dsm2611442a34.11.2026.03.18.10.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:05:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, fberder@outlook.fr, 
 niko.mauno@vaisala.com, peng.fan@oss.nxp.com, ye.li@nxp.com
In-Reply-To: <20260318144253.173160-1-festevam@gmail.com>
References: <20260318144253.173160-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260318
Message-Id: <177385352271.1201153.9679272916023042995.b4-ty@konsulko.com>
Date: Wed, 18 Mar 2026 11:05:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 18 Mar 2026 11:42:53 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit a27980786cfb3c430aa1c05da8e79180c584d221:
> 
>   kbuild: strip sub_make_done from test-script environment (2026-03-16 10:41:40 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


