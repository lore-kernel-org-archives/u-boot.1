Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43F7C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A484D81E06;
	Mon, 16 Jun 2025 09:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G8u6If1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3719D81E18; Mon, 16 Jun 2025 09:00:23 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D868006D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D70EB44C04;
 Mon, 16 Jun 2025 07:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D373C4CEEA;
 Mon, 16 Jun 2025 07:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750057218;
 bh=oTg+7FQ9cqM6KHNGCf78etYiqSlck2R5YLOcjcp5iVU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=G8u6If1pIkkVIfYsyrVB4xFZx1uK6aNdo4Z/lC8aeW4JLC+eDXospvam4AgK2Viyo
 LSh0h/InQuNvTUCyi205HJi0qDeNJOlTfqLpaIeZyAaYWsGScr17LxSHE8ajN3Lf9B
 eCo3egMOI3J31TQBMIeWo5paAO9CPx02Gbpz68/xgwIUuChSPBeKeyVPpH3F+bjlr8
 2QdHFkrQjIiKqKss63ri3RlL4ZZAIVnLGirupDQIM5lXLDmbyJtNJlftycMBcuJGQl
 NCyEkF4Rog4XRtzCRbc4Rs0urwWBPlKfj25MobWGWVTaqyvFZIPOQURPYjoLy/AMDh
 dE8n8QHV7naJg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, Ivan Pang <ipman@amazon.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
In-Reply-To: <20250611050127.38011-1-ipman@amazon.com>
References: <20250611050127.38011-1-ipman@amazon.com>
Subject: Re: [PATCH v1] dfu: fix dev_part_str for file operations
Message-Id: <175005721597.8548.2080001779742776245.b4-ty@kernel.org>
Date: Mon, 16 Jun 2025 09:00:15 +0200
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

Hi,

On Wed, 11 Jun 2025 05:00:38 +0000, Ivan Pang wrote:
> The third_arg for a dfu alt is read as an integer and is overloaded for
> different supported backends. For ext4 and fat, this third_arg
> represents the partition and forms the dev part string, which should
> have its partition in hex. This commit fixes dfu ext4/fat usage for
> devices with ten or more partitions.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: fix dev_part_str for file operations
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/aa2efc584a4d3fe0fe88cd600f53464b26bcd848

--
Mattijs
