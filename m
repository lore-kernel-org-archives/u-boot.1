Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47ABC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5123A40A87;
	Fri, 24 Jul 2026 09:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8J9fDeunk9Zc; Fri, 24 Jul 2026 09:51:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A3BB40550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784886696;
	bh=+XcghOaxJtgmp3k9S1KrzNsfARaHWusz3NEO+V4azSU=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bjkpGAVZ6CQZMW4GY8YgGsWVHyRKm19W7Ul6B7KxZmwLxxDNf0s4Xfc/kymKVOlC2
	 KFrQBek1+23Aipp4zrkmv2xgRaJ48kvMA2eIBWQBbkLxihqsGm9yHhTw1ZyaFMsV8x
	 WaURo4T2spMpFLy4V5bJC7WryeWkwaBm+9tqRwsDfTuxzgZwfy9/j18hh/DnCe2nb4
	 cX19l4inTNpGV1yUQwMKw+qmR0y5Mcf1QGTW0LftS69UJj+vI1nTEjcuM4aB0kOVhD
	 XgDEk4ySRqy1LpjrzXr0qI/5y/zbEcM/rurhkffM9+sgVRzsTqIq8xIY1PARV4dhhR
	 q6JQ2OlRLIhYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A3BB40550;
	Fri, 24 Jul 2026 09:51:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FD5C3B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56DC160B45
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqqYsmZg-fAA for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:51:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9761960B17
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9761960B17
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9761960B17
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:51:33 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso2076365ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886693; x=1785491493;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+XcghOaxJtgmp3k9S1KrzNsfARaHWusz3NEO+V4azSU=;
 b=JfN7dAnHiNuYK/t71v6JEYBKf2biiKGZTqPBJ9cQjOl12SZWDxrfQJkEKFfEHf/7Z2
 IQ4R1qZK+zkKkOcn4KCjGJ/VH/pOBfoOYERkvsRwBVta2uFNuhOHyn17VeCtp4U7Sxf2
 Z/BRzME0SGVX/cWeB//1T9J+SkZkEVjOtoFbpm16SfsGnatQ9X8haJiJQIfGGHaH11JV
 2TbPsU3U41UmTdOeaZGlIHXIpB6wTIovcfMfBiCPzuTsofmoQRB0g2a1ZlXchkx7i7/3
 fw+X5TChGDo6nDS4qB8iU/B2idGAsXwDm64iJeJ212wCspgxNBvlo9vZSzTZJGD7Ndlr
 bNJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBZrcQG5R8o1XA+apFbmvteHEc+52Y5iIFK2ItIw1yd+n5ot6k4XtkAmKdIx9o6u029aBGXL0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzuJA0Y7UqDHlr41WMo7lvEklkRZX66jEmrw5uuTZu/yPQJCApB
 poMgLqHD8Nvsr21nXHdZRvczxSfbb42bSzXexg5k0LEnT6/GihR7FA4G3HQJoe6z6H8=
X-Gm-Gg: AR+sD11UFUlajt4kpkAyi/n7a3IyBmba+/Is/BDZ1mfX9aayY+mr1A28OSpzOEC2wOX
 d/fXF4+gaxHcnwb0bjsER80SfhVMQgMXs3INzLaHk2UUBvGcSkRw+4qWknxiJYxxE855YelKTBU
 CTvuBfg360gOzLYBWyBKN0cl8Y6wuHiPteTevcXTXiCYBNYc9d3sm9I3gTxCbN+ibMY7bEI0kLp
 5jLnDO5xUZmWk4VaINx0oixN+1Wg0rbNCw5bH8IEGrYWWZnZjyP/5+E/uT+hXUWCZVREVU59umn
 JqerZJ+q/z+KgBp2afh87Vu5jCgsk5ygvH3vQH9si0vEN5nSqQsAFhwVzuf/8sC/afdIqXm+6fU
 Dt4+P1uL0ZfXVQalkqWnDe7F7L+EpbBsCUL17MCOOxYDExtGvAnK0Kx2IxhLP67lNiqlhCu7S0V
 fF4sV7TcQ4tRQVyYO6ntY=
X-Received: by 2002:a05:6300:6702:b0:3c4:46ca:334d with SMTP id
 adf61e73a8af0-3c44b1f6000mr7109573637.53.1784886692793; 
 Fri, 24 Jul 2026 02:51:32 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.179])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbb8f18c39csm3975945a12.15.2026.07.24.02.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:51:32 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:51:27 +0800
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 2/2] riscv: Exclude ACLINT for TARGET_XILINX_MBV
Message-ID: <amM1n0f8amD8Ic6d@lliang-1876.localdomain>
References: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
 <c01d51e5eb85295b48bc939fff505fd59afeac6b.1778849270.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c01d51e5eb85295b48bc939fff505fd59afeac6b.1778849270.git.michal.simek@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784886693; x=1785491493;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+XcghOaxJtgmp3k9S1KrzNsfARaHWusz3NEO+V4azSU=;
 b=D8e2fPWu/MHUJ8PVLUMwCN3gY/hpHkgBKOJGkbFXVxD5ZsZVGKxYBwQSskkHn2yEoI
 mujQ0UKhoySeCcXg1hy+myu5SsL2Fcm0njtSZm7h2kkS84yf7VjBZD9xBe9NW0/9tqLr
 nTABQ9Zablvxmnw/7AB+HaE4lskxp/Vz9ziUig/xI1NPpE7x/Xw/WJbiIwGmWQk1rRBJ
 72CsszGQ2/yTj2jDzRdxY5SEqGtuSLSONaV0pGZs3ycCdC0qbPrWaQOmUUGP0PtlmD5y
 65WBPttbQhEyvlLnLNKXCEgK3/CbbZHAxCEosr9oF7eCqFMyplQdaxi/wHXcJFRSYPU4
 TkYQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com
 header.a=rsa-sha256 header.s=google header.b=D8e2fPWu
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, May 15, 2026 at 02:47:53PM +0200, Michal Simek wrote:
> The Xilinx MicroBlaze V platform does not have an ACLINT (Advanced
> Core Local Interruptor) hardware block. The timer functionality is
> provided through a different mechanism.
> 
> Exclude both RISCV_ACLINT and SPL_RISCV_ACLINT from being implied
> for TARGET_XILINX_MBV while keeping the default behavior for other
> generic RISC-V targets that do have ACLINT hardware.
> 
>    spl/u-boot-spl: all -1382 data -360 rodata -200 text -822
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Separate platform defconfig from core Kconfig
> 
>  configs/xilinx_mbv32_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied to u-boot-riscv/main, thanks.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
