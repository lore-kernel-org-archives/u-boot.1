Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90883C25B78
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 02:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF2288496;
	Thu, 23 May 2024 04:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iGDMX2oE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1343288507; Thu, 23 May 2024 04:47:06 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F35D188013
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 04:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-69b24162dd6so28965176d6.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716432423; x=1717037223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4diRKla7QUWH38kV/hHzWTeA9rsucxKXN7ZS2HsnAk=;
 b=iGDMX2oErFrtfYxjdCkVR5v2iysCUl03F1sh9ysqelSQoKru7uo/7vYW99UepfQswU
 xFF3g1f20/gJc/dU/OfnVt+vuh82es4GKiGwrwbHq/BEEP5cbg3uVan1UHdR0s6MyHt3
 mETOMemttOGSydG7/Lxn+CXZF1+lgkoVHlc9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716432423; x=1717037223;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4diRKla7QUWH38kV/hHzWTeA9rsucxKXN7ZS2HsnAk=;
 b=r3sZOzCK61seLXkAGwosoUNd1EXvlG7ObEYmd2z+eOwv8uprASRz2ba2nQ2J8LFpvr
 ljyuYDK663tqjj45Ih5LQj8SgQugzDDS/PLbp7LcVS973tpTuv1+2tc16AOmvOkKzWJ2
 ITtDGMzKA5ojAU8QNZi4TMqzA7XlzmQ12kKZIiNtnrto73+Bf7D1sf/lopyqOYcKFii0
 w2Rv1HDqPUT1ywbzfjg/F94NTjoZgQhkMQUls0w2/hZbdRsXCc9fqNaYiSDOAdOYNpC9
 APA/wQ+fYVUK1+f9vIEBys1JHNOnAkb5uHj43WXmuzHfGYnYTnwhUx7a/F/l+AFuZdPy
 q9qw==
X-Gm-Message-State: AOJu0YyVX5SSQYwWwzQhu6l0Hf5g5Kxwol1WnUlNsNSZoniWPopVFd/8
 G4FLhMQnAZyYAgmx9NV27hsBRr+4/oyjxeOgtwZrBfxb5eaDwS6+qcf+sL8as0Q=
X-Google-Smtp-Source: AGHT+IEFhk9So9q1Mv8UODl80KEDhmzDoQnJKCBk3TVYhMa4JKq916QLGraQjGuvP9h2nnd4MzKvjg==
X-Received: by 2002:a0c:f9c7:0:b0:6ab:8588:df9a with SMTP id
 6a1803df08f44-6ab8588e12dmr26156656d6.13.1716432422834; 
 Wed, 22 May 2024 19:47:02 -0700 (PDT)
Received: from [127.0.1.1] ([189.178.170.52]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a35c7e4cbbsm75936356d6.128.2024.05.22.19.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 19:47:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Phil Sutter <phil@nwl.cc>, 
 Tony Dinh <mibodhi@gmail.com>, 
 Walter Schweizer <swwa@users.sourceforge.net>, 
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jassi Brar <jaswinder.singh@linaro.org>, 
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 uboot-snps-arc@synopsys.com
In-Reply-To: <20240516211156.1819939-1-raymond.mao@linaro.org>
References: <20240516211156.1819939-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v3 0/4] Clean-up patch set for MbedTLS integration
Message-Id: <171643241953.2070952.15187034126360931450.b4-ty@konsulko.com>
Date: Wed, 22 May 2024 20:46:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 16 May 2024 14:11:48 -0700, Raymond Mao wrote:

> This patch set is picked from the previously posted serie:
> "[RFC] Integrate MbedTLS v3.6 LTS with U-Boot"
> 
> They are not directly related to MbedTLS integration, but the
> prerequisite for a few clean-up, refactoring and minor fixes.
> 
> For V2, the linker script patch is dropped and added one patch
> to move the snprintf to stdio.h
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


