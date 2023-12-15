Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F7FC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67D487C17;
	Fri, 15 Dec 2023 21:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OwnqAkYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F7087C4B; Fri, 15 Dec 2023 21:48:53 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5734587C17
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-425a116f1cdso8504861cf.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702673329; x=1703278129; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jXkQvGvseRr9OSLhDEpKNiBne6PE2K/af+l97pnxyM=;
 b=OwnqAkYoCVSk1b3DqOUOFwH3/14Uq9DdRB5lVp7blK/3syOZJxuCCBgb32wVJPkphO
 TpTTJ0MPl8Y665rQ21sBi1qtUXtVsZ2lRrFaxRAxcV3zFrmIbv+uftbb2mYQQ7Hx0yWf
 BRlYepyjoKK5eO0HQuPUVZDaCUyRCucAWpXXxjvzgQp1jw7FeVk/XthJw6I0qHQ2eMYO
 i223T7edaKTSQ5S6fZ0ujPJGZ31Q6hhSwJLw66TG3DB3MdZuGVjRqypomvchg7nC7WY5
 MiNqMJ2DG4SAE/aUAF0PSMizdHX3CVmovGnpWSTdvLNUz54WYwsKgrmKFcLKH4lMhkWL
 8n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702673329; x=1703278129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jXkQvGvseRr9OSLhDEpKNiBne6PE2K/af+l97pnxyM=;
 b=Ky2jvop8w4Utjp/mDBE6a6Bm5q+vX3UcKgBJv/vTKjOkwXfSNC101wgpv8hyyTIGuI
 AWoHLZVIAbF4B+PcYeD6ZIdoFPxWcMI0YR9gw9/X1z9LQ1LJXPUsj3it3h1dWQjuIO1D
 vyMjbOCVKbdp/TQi89KsN/6dODMEDlMX3lczS4D2qfvGPehUrq8d86+d11bNJOqY7w4/
 P2UkpBOtKz2aZ/OuwJCvL2dmwLRG5F8ATpDVhrbJuufRAR1GH4Qqd0iNXydCFq2ld7gH
 jybix/gNLnDlVOFyVezlKkiriItILe7ESc8XHgC07Kgwp22j7mkwAfPnxz1DxQ7oItYn
 xM/w==
X-Gm-Message-State: AOJu0Yy0PAfSIM1wdxzJqpMwc+nd/6DQMVLlaKUXOY7s2kFuK8iXMOrw
 UPFHf53fmVVrKY/qreRAaAvKOU5YwP9OyA==
X-Google-Smtp-Source: AGHT+IFh0KB6Ddcmip2ygFoybmhbuqRp+r9fRO8MZjby6AGfEX+H07Qa3nzASYtL43r0h9ISZE904w==
X-Received: by 2002:a05:622a:11cb:b0:425:4043:18a0 with SMTP id
 n11-20020a05622a11cb00b00425404318a0mr21132014qtk.83.1702673329488; 
 Fri, 15 Dec 2023 12:48:49 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 z4-20020ac875c4000000b004180fb5c6adsm6908123qtq.25.2023.12.15.12.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:48:49 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, daniel.schwierzeck@gmail.com, michal.simek@amd.com,
 sr@denx.de, neil.armstrong@linaro.org, patrice.chotard@foss.st.com,
 ivprusov@sberdevices.ru, Lukasz Majewski <lukma@denx.de>,
 patrick.delaunay@foss.st.com, ryan_chen@aspeedtech.com,
 chiawei_wang@aspeedtech.com
Cc: Sean Anderson <seanga2@gmail.com>, joel@jms.id.au,
 u-boot-amlogic@groups.io, kernel@sberdevices.ru, BMC-SW@aspeedtech.com,
 prusovigor@gmail.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v7 0/8] clk: Switch from soc_clk_dump to clk_ops function
Date: Fri, 15 Dec 2023 15:48:32 -0500
Message-Id: <170267330672.2421617.16500568591017689149.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231109105516.24892-1-ivprusov@sberdevices.ru>
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
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

On Thu, 9 Nov 2023 13:55:08 +0300, Igor Prusov wrote:
> Currently clock providers may override default implementation of
> soc_clk_dump function to replace clk dump command output. This causes
> confusing behaviour when u-boot is built with one of such drivers
> enabled but still has clocks defined using CCF. For example, enabling
> CMD_CLK and using clk dump on sandbox target will not show CCF clocks
> because k210 driver overrides common soc_clk_dump.
> 
> [...]

Applied, thanks!

[1/8] clk: zynq: Move soc_clk_dump to Zynq clock driver
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/bdac75511411
[2/8] clk: ast2600: Move soc_clk_dump function
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/3f192541df79
[3/8] clk: k210: Move soc_clk_dump function
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/77beaad3d1d2
[4/8] clk: amlogic: Move driver and ops structs
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/4f48202ba82e
[5/8] clk: Add dump operation to clk_ops
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/505ef5f627d8
[6/8] cmd: clk: Use dump function from clk_ops
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/258c1002383e
[7/8] clk: treewide: switch to clock dump from clk_ops
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/bc3e313ff6af
[8/8] cmd: clk: Make soc_clk_dump static
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/5666558a6cb0

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
