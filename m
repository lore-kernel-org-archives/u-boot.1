Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417FCF483C8
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 16:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B2984180;
	Mon, 23 Mar 2026 17:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K0XM5wJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B54784180; Mon, 23 Mar 2026 17:49:20 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE7984180
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 17:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40946982a78so1331262fac.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774284556; x=1774889356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5Iwww6MsZsbU7of0owQyTLKlTeaFR9p1zrUOlDxlfI=;
 b=K0XM5wJ+73Rlrb53Mrlzs3yIl4Y/3Za847BueD3fWmBdqmyqLf4+Jks0YaXHNDkjS0
 2Dtv+wv3cfzto1BBpD2DPUChpWvGw9JCqO0KvkAT3M3roi0Q5URSi0UHbAz56iPQSAyI
 lDcazGCdTw4+oR6qD5eTYLBs8DFWvJPxJToWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284556; x=1774889356;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+5Iwww6MsZsbU7of0owQyTLKlTeaFR9p1zrUOlDxlfI=;
 b=DmDiTfwPjj/HurGqPruQtJP4yGbpFrJRMHKEiG4tEBE6NsKk4MJZcBSbs9vH7vWxcf
 1Nz6lurOjGGszWhzIYcTkjZkvgnKl8pL5PmJJZcbvkbbftI2ZrxoGRrA/yzCQPi06R8+
 o6G1ecSduaEiFtLb8eFoG0ZN4TRlUn8bCbB1j4lQxn449oOboDPMY3gA+W4OUNCMC4Jt
 L3KsdaIX+p6XoTlCfxEuMBzCrtE3AY0DO6VeMxVVbUXHnhWzQOVLfm+T/g+6LXGWszvR
 jl0wEdMd5fyDIqZvcYwWec9ncKXpQRKAuyOSxvK7EU0KC6jW9964+IWHFxgu3GTwtByg
 Mq8w==
X-Gm-Message-State: AOJu0Yx9XNo9Uc7/r0cn6ZCTFnu7TyTLHOul77BdomRwDv1DsxorJ0F6
 zdTorcliLEQT7Yc2KSEzfU7iaRWejn8s+LVST8ND+ZiKfijUVxJ4Kgyt3g9+uaOqeGsk7iY17VX
 dePAvmGg=
X-Gm-Gg: ATEYQzyiBD4yLdEaJLHpkHohUsO5Yn+jhzEfaBRyJLEgoDIHzDpnm7VhPUaO3+yAYLS
 jkpGhLNhPip/k1eYQjY8qpsxZoSHsE96aBR1EaIoVCIGqaEfF3700j19kyXu0gQXW7+b8MVJlyI
 fuQ5JEgg/E+/sBOl3h485VUDp7z9jej+Ne8XTDSIymxCNVkEOndpKsBEf+cPgwlYGAacDZ4m5kw
 cziQc6GyJqMx+0ge3k3TDSCaf5pmTTkhLPQjp4ympdt0Yei4cGclhBUg8vKk2P4euzXEmR50zgZ
 X3CdwD0ZUZ0d5A6t91evp+9xgWgMUk2Tg5GOvZWzAgmmZZEp/g++rouGXB4AkjMDy9MrXWvC2FW
 vQr/7dfHm0ACWRdTalpxJdzd0lHHolDEp7RwBIM4Otvn3d9tzJh4Tht9lEoFEGyiYLFi/NGZR9C
 1QNCUB2xpS8N4ybuwrVhU1NyZ1vQn6aIbzpBVzWlI82uBxHt6zqSFxltXEgcI/SAyxv+MQZk4/f
 tFfDhP63c5ZZOfhRIB+Y/pR1vrWosztDlpou8OjwioFJ0c=
X-Received: by 2002:a05:6871:ea8b:b0:41c:28d1:2c11 with SMTP id
 586e51a60fabf-41c28d1627cmr6663210fac.6.1774284556376; 
 Mon, 23 Mar 2026 09:49:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d73a19sm10016158fac.11.2026.03.23.09.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:49:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <acDCbfaY5P83pvA9@nxa18884-linux.ap.freescale.net>
References: <acDCbfaY5P83pvA9@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-next-2026-03-23
Message-Id: <177428455563.2303875.9247856632994826021.b4-ty@konsulko.com>
Date: Mon, 23 Mar 2026 10:49:15 -0600
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

On Mon, 23 Mar 2026 12:33:30 +0800, Peng Fan wrote:

> Please pull mmc-next-2026-03-23 for next
> 
> -----------------------------------------------
> Add missing quote in error message in regulator
> Support for emmc 5.1b specification
> -----------------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/29613
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


