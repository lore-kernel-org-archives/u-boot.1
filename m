Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D659C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 23:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65ADE80F53;
	Sat, 22 Feb 2025 00:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SHmFM9jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D863280F56; Sat, 22 Feb 2025 00:13:33 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B378D806FE
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 00:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4C2525C6E23;
 Fri, 21 Feb 2025 23:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E6DC4CED6;
 Fri, 21 Feb 2025 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740179610;
 bh=WNL0sZKfmWiQDFD9PEb2OlcoZ6MH5kNFz9BDs90AdBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SHmFM9jzRO4UimxvEMJKuqkwcIk4+JE0MSeBrT2hXhHA3B2cQA67tgE+xH2dBnUOc
 AcOkRMZ4UhGtVh7CxvYo9PD1f8O8FD2BsexZNzMxE4441/ZVFxy7mzwJhOaJFfimG0
 J5fvzTYbzBkEMCXC6y0H98OqWV2T9/Owmpc3oD4YVvzCPoNFEh30JDrOURHktMwkMt
 gcmjJfDSmSiCSNIS18PgI3kDuggTwG2HZ7EIeArpho6rPZSABe+ksKcpEN+NQ2L+Rq
 fdw7qoXlWkyQ8yWNujMFZeMOPZXzgSb6FUT19ZwIHgvnp9thPmZ/wmpdQGixNpDJVm
 3rY4YNPY7Pt4g==
Date: Fri, 21 Feb 2025 17:13:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, 
 git@xilinx.com, open list <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: trivial-devices: Add ti,tps53681
Message-ID: <174017960656.297543.5906182002772839470.robh@kernel.org>
References: <26aac15b8f0fdbcc2633d3843e216e6c8d30bb31.1740054443.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26aac15b8f0fdbcc2633d3843e216e6c8d30bb31.1740054443.git.michal.simek@amd.com>
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


On Thu, 20 Feb 2025 13:27:25 +0100, Michal Simek wrote:
> Describe TI TPS5381 a dual-channel multiphase step-down controller
> supporting per-phase and per-channel output telemetry.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Linux kernel driver support has been added by commit 53030bcc87e4 ("hwmon:
> (pmbus/tps53679) Add support for TPS53681").
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

