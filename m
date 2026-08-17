Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A99C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B40696079A;
	Mon, 17 Aug 2026 13:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IXXBE_hPJaLi; Mon, 17 Aug 2026 13:34:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CD9F6078A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973642;
	bh=uVT5Mw9YR4nWFevDP6T1/Vg1UhutIFYaTo1/igOKxkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mweaq1O/gdVonx9wKfzz9KzXtIdgpEO5ibz0aqJwQbZ6uYiwKLNPCMcUgaH821yUn
	 AcXAOa2v+maecXUODoMT6vLTGr7x8wYgAkhm0HnRz43aqO+7V1LOwXJObFcH6VRUZi
	 trV5fujniEjmtpyB0qME1sQNPSjH3MDnEDRfa3yhuEZMmPo5ISWNGtKxArRFFAuLfX
	 4uNyarbWU7uf5w8pmQckfYL3l+85ipcD+M6BJpDEFLD7KpmC+yCchNaP4XwLW+44nU
	 675gVy/YD4c85Yf4042cbE7J7kGLYWBnDg8OcCNGJ6rToQID4tAc62Rhf/zlbW4Aub
	 vthV5g+pJxLeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CD9F6078A;
	Mon, 17 Aug 2026 13:34:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69E46147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BB0B80EB1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0jhd0VHVVmW for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:31:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B76C780EAC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B76C780EAC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=KSDv87pf
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B76C780EAC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:31:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF7E1600AE;
 Mon, 17 Aug 2026 08:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A6A1F000E9;
 Mon, 17 Aug 2026 08:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786955487;
 bh=uVT5Mw9YR4nWFevDP6T1/Vg1UhutIFYaTo1/igOKxkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KSDv87pf/MSw/3AVtDHkF9A0lP2etpEoZ8YwpqILmtvMK7KY0/WhLz8mMqk7dYOls
 xS4GEdZs78w4V8Gm5DQFD4Dl13K2yUvsZbOoiK1jxs23fQ41SCXlnzICy0cSjKjn2C
 nyUm+RTuVjpdCkmFimBWHiGp+Yd+OvzwnpuIqQpaOAHWK08SdO4KYzC5JbH9/tr1mq
 vH4YiiyGbkexLlcvi+BsaLNUz3sc4sqIWfF8NfT9/bLAzhMVl2k/G63pVTrgF5vbsI
 1YfglevyHqVel1q71RFKSsFT8AwB6lnQyJRmAjFPbtjSXNnY6M+aGEspp4fX5FoNhA
 Yu5wVEjZvCMsw==
Date: Mon, 17 Aug 2026 08:31:25 +0000
From: Yixun Lan <dlan@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v2 3/4] i2c: k1: enable both functional and bus clocks
Message-ID: <20260817083125-GKA571540@kernel.org>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Junhui,

On 11:40 Sat 15 Aug     , Junhui Liu wrote:
> The K1 I2C controller requires both its functional clock and APB bus
> clock to operate. The device tree provides them as "func" and "bus", but
> the driver currently acquires and enables only the first clock.
> 
> Acquire both clocks by name and enable them during probe. Use explicit
> named lookups instead of the bulk clock API to align with the K1 Linux
> driver and keep the roles of the two clocks clear if functional clock
> rate configuration is needed later.
> 
> Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
>  drivers/i2c/k1_i2c.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 

-- 
Yixun Lan (dlan)
