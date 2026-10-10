Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B1ECA6004
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 04:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B44B40920;
	Sat, 10 Oct 2026 04:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PwvYgxiRzocY; Sat, 10 Oct 2026 04:31:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6BB05408F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791606706;
	b=lCmRQZoexCop08Te8J3sTDJnt0ia9wwfuy8b2p58hHa1oDOBH5/3TEl5wxWMsLOWGaPC
	 lAgxv2YpdAUyVtgA8Urcs3cWesTbSwSS5YvfRLA9AXM9enF7MMDVSwennPbnxXo9j719K
	 x9hk3Fe5G0CusZO/mz4lIciA+Q9WpWRfKakbRPyE/JgGRGPCFm5lc5YUI4n6upqJhJOdH
	 ftDRYAW5offvb6OVl1fLM4PNDKlcgAxVQq+1/p63HFrB7K2EvQh21f4d/kxaIaW1rDNM0
	 2GTKTexuijteoGUZ2+yAW8BCKhhGsJg6sUkHf39q2E91cVlbKAWRmKZJ9RK9PWDdrUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791606706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tWEk3IEHIgQ7BJWbvGYAvaCjn/Tv1q46dwAajVCe0ds=;
	b=Te4HpiBaM8y2zfq7FSgmd5ix88CWsHorjPnp/YPJTmlRjpwFk8bOwF+odfbRkpdr0vXt
	 wuu70GQWV/oWoxg9MuvoovZTg+xpaMSUcJSKVKwkHnjwqIuiYBpVPzeiQ84y1zdBZWrJv
	 zRnUQH4lgMu8WDqxNYFzglnbolz5Vd4OCbhWAwXZBmDBp/YXTmOV7kzTLTWWjKVlNvBES
	 eN7+HRzFPjQoaF/W/9dq6Gulrud/VJ+ejyxNwUDxv03FpYoWXUhZOtIe992ICHPUi9kQx
	 dLek2e4FcMUHmvkaRuVKRm4gxxBntfxHt+VS0SzRmoUVkD88Bse4Ne8VQ6iNVmERyuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791606706;
	bh=tWEk3IEHIgQ7BJWbvGYAvaCjn/Tv1q46dwAajVCe0ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XoiTipsPekJAU+TbDHr//cKuAI2nxoSfU/7hjwxu51Kf5M+w9dKKiH72Avrpn3Qp4
	 C7M7PKPTQSlUKcOldv5w2FfYPCqDdK7V/oSKWV4fdIb7861vSKoW6AaaScgLmX0MNR
	 fBQHSK9dMQW5N4UZqef24RdHEYtnxouVZnqELPr0zOr727Gg5uVsDbdzfiwvXRE5Sh
	 SZiFxSzhnfyxgDQJQO+Vna8pqeP+U3cUNPDw/AoJSg/ZVM8Oy75tXbog+0FdBiAH2+
	 0BD3/vsQbVp+XmoVLnDMhZmRAImoNmVR2tYm00D1l3uos9gsR1l0xCzAnM9UCbJ4Ki
	 hCCvVlcYGp2og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BB05408F8;
	Sat, 10 Oct 2026 04:31:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4F6B9D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B2768119A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QMBuYB4QUFX4 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 04:31:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CBE8E81359
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791606705;
 b=YjiOV59/rtK6egFw2B6rWzP5fcDoS+Jo/RXBG+4qBhg/LzKBQd3ZfPtN5PF/OOPsaLr+
 1pnMdyaaaSypnueZ5EDphMFy7VcVMKqAUNvSVewd6JguX9t/3kwZn+Z1Pf/T+JC1BwE7w
 LfgWuaut0iMOQA4J+5XH3VxPhSFoYD2f3mB5bYabzkSzEHiLcFR2KC1gqmoqLeyZZI2Et
 7CyLWgDWGoaqj9GWKLISvPUi5vk0/fuBCVTyjKSkYcelJYojcCFBKRBoD/039gZ4cZTSJ
 tEYyMqhUzZbwr/fl7VPRIAASdlLhjKW7WUKYTR9XVRwyYgyql9XrM2+0JjLeHMydn8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791606705;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=tWEk3IEHIgQ7BJWbvGYAvaCjn/Tv1q46dwAajVCe0ds=;
 b=mRLM1x1NuoYgJGyN6fYSEKQgHo7M1/5PGyFZqfYyq/kOAGqrvfcKxw8zoyN1dps2cRqe
 6zCeOBl+M97GWUGEF3YLfz2nO3ipzhP70S9wf8c7crxhe1Z2mHLd6roWEEObcZMTNSGSN
 Wmsx/840byL70G53Qprl2kJSzGPrEWUq9EfgIpTm8b7SeJYY2q1kcg5gvaR+hp6qpZzlb
 M7LVCqca4V1BSc7CCXnzKtdrGkP3HGSJLn7VrQZIYEQY1xwl6UJlRxYPdSKBcJdbagbr/
 9lg0LWFg0yqD4H5gbRtwsZDVo4RMH/PyrWpRCyXFtN989r3Vd5y++W0/lzC8GTyEu8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=l+hjNUx3; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=l+hjNUx3
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBE8E81359
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:31:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1446B60211;
 Sat, 10 Oct 2026 04:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69641F000FF;
 Sat, 10 Oct 2026 04:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791606701;
 bh=tWEk3IEHIgQ7BJWbvGYAvaCjn/Tv1q46dwAajVCe0ds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l+hjNUx3hW3Q7PBY1oJM2KSJU37ClgZrWLd+y4RvA2BHGZ+onlwlk/dReaOV66RAP
 IZmr0j3cLbsPX9zRbHbck5XUh/ntfJ10XNgA6ksFYJfuMCsLtRVXzTS2UfYhQSGKqb
 EizsmIX8QpnQdnMX7WPdwNjzY5YJk72X2/LxUrcdclEvWwTRlx2Px9vQgCy7OYVIZj
 GurBRdFaBLTAweiToCpcVUFSiRU+DpKbfw1F10SEznEAewKrIalASZRDBC5By8FXu9
 cNy2BpbJBAn4lM5gMoEX9iXYQV7xeScNxYz9Ey+JeWz1G3ax/2VoPt++e0utUORpH7
 izUcKSqh5oapQ==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 fanyi zhang <fanyi.zhang@mediatek.com>, E Shattow <e@freeshell.de>,
 spacemit@lists.linux.dev
Subject: Re: [PATCH v2] configs: spacemit: k3: Enable Ethernet support
Date: Sat, 10 Oct 2026 04:31:34 +0000
Message-ID: <179160668562.742055.17000397227078120105.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010-02-k3-ethernet-support-v2-1-af7f55dcf207@kernel.org>
References: <20261010-02-k3-ethernet-support-v2-1-af7f55dcf207@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Sat, 10 Oct 2026 01:52:39 +0000, Yixun Lan wrote:
> Enable the SpacemiT platform glue for the DesignWare Ethernet QoS
> controller together with the generic PHY framework, Gigabit Ethernet
> PHY support and the Realtek PHY driver.
> 
> Enable DHCP, MII, ping and PXE commands for network configuration,
> diagnostics and network boot. Allow U-Boot to generate a random
> Ethernet address when no valid address is provided by the board.
> 
> [...]

Applied, thanks!

[1/1] configs: spacemit: k3: Enable Ethernet support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/01b0d2681dac9a153b0426290d696166ae999de7

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
