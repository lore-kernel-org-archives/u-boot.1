Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF5EC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 12:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB71680F4C;
	Thu,  6 Mar 2025 13:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="b6bVV1Af";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F054F810DC; Thu,  6 Mar 2025 13:40:55 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCEA808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 13:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4D06925C4E;
 Thu,  6 Mar 2025 13:40:53 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SBSwVqsMzJoH; Thu,  6 Mar 2025 13:40:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741264849; bh=k3Braey+FknIPM3SJ80fc898W1n1V9aX/u9nZrNYjwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=b6bVV1Af8Urz9gFxInEaDRwDlB646HL8Vqazsq70gidgjUt+kuinWdddeyr/hLK+8
 o+tT5+Ex88aSu22AP1TqeRq6gunrx6IxNQ+/aijl0wxMe4QxKaNuWEssO3DCS1QG59
 skhwbBBTWhzT7ZetiFdb0Y0lw12jeW6lwxE7BFhRFaYmJHnQbmgx/3eDZe+tnTHPgX
 +kHR4hbo5I7s85SZxw3TpEQM+gv/o3nhZv8ZMu37giA8+9YaoM6O1TLUsEM6OKEo+W
 avM95JmJx4XM5cX8KL90+QDaw2H+ucET3ZGniF/bMq3zJPNvmqxoLnXj0bYE46eUuI
 SCgYzjJtXTn/Q==
Date: Thu, 6 Mar 2025 12:40:23 +0000
From: Yao Zi <ziyao@disroot.org>
To: Leo Liang <ycliang@andestech.com>
Cc: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 "Angelo Dureghello" <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/5] riscv: select OF_HAS_PRIOR_STAGE by default if SBI
 is enabled
Message-ID: <Z8mXpFvGu-EcYkOH@pie.lan>
References: <20250227144734.61458-1-ziyao@disroot.org>
 <20250227144734.61458-6-ziyao@disroot.org>
 <Z8mCUtgAW2qujI13@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mCUtgAW2qujI13@swlinux02>
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

On Thu, Mar 06, 2025 at 07:09:06PM +0800, Leo Liang wrote:
> On Thu, Feb 27, 2025 at 02:47:33PM +0000, Yao Zi wrote:
> > Availability of RISC-V SBI service implies a prior stage exists. As SBI
> > firmware usually passes a FDT to the loaded program, let's select
> > OF_HAS_PRIOR_STAGE if SBI is enabled.
> > 
> > With previously added fallback version of board_fdt_blob_setup, S-Mode
> > RISC-V ports use the SBI-provided FDT by default. This covers the most
> > common usecase, where a SPL (probably the U-Boot one) selects proper
> > devicetree, loads SBI and U-Boot then invokes SBI with the devicetree.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Hi Yao,
> 
> This patch would fail some of the CI tests.
> I will take other patches from this patchset first,
> and could you take a look at the CI tests issue ?
> (https://source.denx.de/u-boot/custodians/u-boot-riscv/-/jobs/1049827)

Sure, will have a check later.

> Best regards,
> Leo

Thanks,
Yao Zi
