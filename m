Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B345E83829
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1741183DC9;
	Mon, 16 Feb 2026 20:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OmugCFTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8191483D8A; Mon, 16 Feb 2026 20:39:11 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BE880325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d1890f5cafso1223646a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270744; x=1771875544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AI4gxpAe0Qj/qUyu5FsIoCtSWIUoKEoBarllpKzVQkU=;
 b=OmugCFTncZN8aO75GjaGeeqgw5ghFQ1a/J7z14D1gjSNpUBJ0iiWio4zxdXGyyj7zd
 fPrkmarLK8OzTL32Ob8jWBkqJgv76SF2z/z4AZQlkzpO0vUSx+E8c5cAerch9t90vmpL
 uOnaHzZ+F2k7pNGSmGMyvsdDneILHlPMHwaLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270744; x=1771875544;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AI4gxpAe0Qj/qUyu5FsIoCtSWIUoKEoBarllpKzVQkU=;
 b=rLI+ZEso3izvFveJ2wyNXi5oQZYveI3A379iOX23mD7uWyqdCWpoQSu/X4jNrpLRUl
 mAaQSo/zFmNuFPFN3jUY4vzHKT8XKduU0cBeUAn8qJZidJzwFJ6kq4F/dya6+SVOD4rM
 ehFVsiozkllrwJTrztu4jcjDjf4Vouuckhg0pnozQSL4NJ9yKLjJ+56ZNqCI1zyjRToJ
 afB5480hjON4pg8ZmmUJB34ErOu6XN9qNmsdlGtAf2G+D6WnO8WOA7CNJlZkYTuYv6W0
 YIfLSVzk7JVuhQU/BKpTUvaNopr/eMUL6p/kqDEEYFkO+Y2BHORafhIaHFQYISdRfNct
 JGBQ==
X-Gm-Message-State: AOJu0YyDXD3z14Y346pUcCI4dDPSv9OAaivPSYCoHSX1MEhLpDt0Jq9d
 /2+QnNISmqGYSXryWMqfjdE8J1gRDbdA7HgPATm6ov//6RlMF1AFzDsX9MKLOqLSiNg=
X-Gm-Gg: AZuq6aIAN14C00Fw3JHFYbGXWZKArT1V9fjMnK9t2gCZQBjY5IpyqmIBm148Nhpnug6
 taN+Tb0yeG5z699ykfZjV/JIUw59IqCzAouujLM6VgrXLvMHHryHy4pPglQlZVVzyZZCmUWzicY
 YCdPzz0t9XcVK0d6RyJ1RL+M95NWwxyycnTIXt8Ai2hrtNejgHoANncxhU3T8nzGACJRP6acPB5
 Ykgr0yo9EZWktCON0pnfxXfjGEcv9ajRNKO4TcQPwuhWQlXKCfvAm2xFH3a3fh1PbqpnUTxm3EO
 K2xG/kuFtZJH1l7tW7hzYPHnCWn2KCiaPSMLjYZb1REYF4kcxaBmZK1HmlS7p9NBk9QS62dc8UZ
 4MpYBcMQSmRBiLoU9F8Wu/ylBHnZzOfp35g8k792NB/7ujaZDDZfbfaQ4t2m8ibhlJ5Bk1Su+QZ
 GNGTD6TauNMeoAWeIiEAiqADxhejHLVSBa+NGTFlFoGio2DnvVX/5ko9PY35z4ttAHRM0k1vHC2
 ROP9Yu6z+BmUeygc2IU9r/8qyUjXFT51B/J3p5XTH+cBadmRg==
X-Received: by 2002:a05:6830:2a05:b0:7cf:cd9c:3c25 with SMTP id
 46e09a7af769-7d4d0ac4fb1mr5753601a34.11.1771270743364; 
 Mon, 16 Feb 2026 11:39:03 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:39:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, afd@ti.com, n-francis@ti.com, b-padhi@ti.com, 
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, neil.armstrong@linaro.org, 
 d-gole@ti.com, anshuld@ti.com, j-humphreys@ti.com, 
 semen.protsenko@linaro.org, bb@ti.com, m-chawdhry@ti.com, 
 mkorpershoek@kernel.org, Jerome Forissier <jerome.forissier@arm.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20260202141058.648965-1-s-vadapalli@ti.com>
References: <20260202141058.648965-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] board: ti: j721e,j7200: fix do_main_cpsw0_qsgmii_phyinit
Message-Id: <177127074206.2634449.14636380327713236499.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:39:02 -0600
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

On Mon, 02 Feb 2026 19:40:56 +0530, Siddharth Vadapalli wrote:

> Since commit 27cc5951c862 ("include: env: ti: add default for
> do_main_cpsw0_qsgmii_phyinit"), the value of the environment variable
> do_main_cpsw0_qsgmii_phyinit happened to remain '0' and couldn't be
> changed without user intervention. This behavior is due to the following
> cyclic dependency:
> A) ti_common.env sets do_main_cpsw0_qsgmii_phyinit to '0' and its value
>    can only be updated automatically by main_cpsw0_qsgmii_phyinit.
> B) main_cpsw0_qsgmii_phyinit is defined in j721e.env and it can run only
>    if 'do_main_cpsw0_qsgmii_phyinit' is already '1' which isn't possible
>    unless the user manually assigns the value.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: j721e,j7200: fix do_main_cpsw0_qsgmii_phyinit
      commit: e7ef80f670760b88f99847db9c98ac473edcba8b
-- 
Tom


