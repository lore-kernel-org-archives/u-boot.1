Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B9DC369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68B683A56;
	Thu, 10 Apr 2025 10:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gqviAejR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF1B83A64; Thu, 10 Apr 2025 10:46:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33210839DD
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CDF5C5C5573;
 Thu, 10 Apr 2025 08:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73B1C4CEDD;
 Thu, 10 Apr 2025 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744274800;
 bh=y6KYaBPSL35PvujMaoxtsT+ECUzYwuW2oMZyFGjuygk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gqviAejRP6HVCsmkVLcNnt0syccxAB8lIi4cZ3KfMVN3RQpoPoO82XEsLUOXU9ofw
 p2uh1mMefIc40V9auyfaguiP4sp9uYOrnC2MuWeSst27De4VPQSLZnZ7Sw70JDqNoi
 HvDdq2VLUhbTSEymQPn6m/plFOq2D6tYa+SnIJI3LDIPI35UjGwPH6aAjPRoiq38S1
 UhLWClw0CiN767RZi2cvS/k/U0R5A8b4DNkh1Q40UT2rEm6MdX2tYzZHVX0MMXVgg3
 sV7pmPJWWYhQF4rOd8Haywmxjat+8EHqETyD7BVOyMZE3rMdgovR85+4mim3SpSOxN
 XnQjF1gWZPNqg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Felipe Balbi <felipe.balbi@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20250324143956.91791-1-marex@denx.de>
References: <20250324143956.91791-1-marex@denx.de>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix excepts/expects typo
Message-Id: <174427479592.285654.11543796396678849019.b4-ty@kernel.org>
Date: Thu, 10 Apr 2025 10:46:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
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

Hi,

On Mon, 24 Mar 2025 15:39:43 +0100, Marek Vasut wrote:
> Fix the excepts typo to expects , no functional change.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: dwc3: gadget: Fix excepts/expects typo
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7cedd20ed384a9748bba3fee05d504674109087a

--
Mattijs
