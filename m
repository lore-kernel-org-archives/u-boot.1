Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F6BCCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF895407A3;
	Mon, 19 Oct 2026 12:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oagq_m68wUnv; Mon, 19 Oct 2026 12:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 144EF40712
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411299;
	b=pprrV0eLklOAt+g+Cty+bKkhQ4pvzsSSCYY5rlh16DDv8MYerOuQPV5nxTq8DjuJsXMi
	 c3PeQHeBWiPfZcTnH/itYCTc/+Bwrp7FZjH0zW8AWv+PlYl1j5+SPPl7uvaDURPHMXRKD
	 hlDfOFCwon2pOBnD8hODZDcNgGbHVy86sK47TagIXEvtn9zorpM+eqe7bqWWaz8olG1um
	 fw1O4o4VHE4qz+4LO+pJKluyJP3mxU8fKWMSAGi0EbXDkk7qTb6OFZm2UAu+zZwCwG6Jw
	 OhAg5mS5oyPRzt2Qz2mT5yFOXUcu4t2bb8aJIKZL7z9KWxDHeaVoljkxSzpb4GU+6ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YAQFVarwqU7yb927t6QZ5I/kKx7HdnxhBW5jpGA42HA=;
	b=dh1GoAO7NjzIf9+XiUFAyOacgN+9dXKwJQEKZjoRJKk+zvm+6f6+d+szA3Smj2m2WSBL
	 CWpIa+9JUy8u6/vHMNchYkt1JVVlklDJC9Piym8chnDMPDa5gfT/0dg3XYbi/g2W2gRrz
	 8QKLkUnFVfTW72IrPC8v435W/gOpQeoc/scruAPgl8dGdwwZhv5Ay7zeqyBqRXIA21BIm
	 Zr9urqO2UV5W7uKmL3KJWW0BSyNOuSz0EGTZBCdT7DFewsGayTWYtgtD1+3BlpF0Cq/Mk
	 AyPpDHSKohcnxivz3/TEvcP/C6TAlKWGI1TiKwHLXcwjDZDTyLIAMKaUwlgY+BsBo0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411299;
	bh=YAQFVarwqU7yb927t6QZ5I/kKx7HdnxhBW5jpGA42HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wCtk3NN6mCfZ7S/J++7uH2s+LvRaL4yNciUZyFXiZ7+hEOuxiNyCaRLS8N2Wwe02d
	 eDWUWBB2kz6uhX19hfWwRPEr2aGP04QHuoxc7HPjBOU7NQlkBR50u2pSs0JZAoL6tc
	 bCQG0mJ84iA7FeCvsb5FOj5btjeDQLr2ZeZuXKwkw1aJ/cDq7NuKLQDuVQYFvrnwhA
	 oJiyIIp+G2JpTYxGsr6efPttljWaf//cyy0uqGByWGoPLe/bEG2eb4+vKB+/lGKvvR
	 LQV6tVjU6oTPtO3AdbW1q5iKLrV1xYqxGB5PtlRktx34Wyi3BeNeRUd7Uug3HmjXlQ
	 G7n8EvFsGR6Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 144EF40712;
	Mon, 19 Oct 2026 12:01:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B302F22B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0B4A4010C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNaEqfMjiYBZ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:01:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E994740079
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792411297;
 b=jg17XxubJwiF0WEbcglzacmBEaDidj6WJkM0uGQR4PuX9krx612L7dyFaEhnW7zxMckz
 t/iP3109Gc4mtPKll1/i7wrmThCvaWJ32z88Tju/9htQsIRIEkxKyDzTGHUostt8745A0
 BGnymOz+MqhDSpCPJoU/fXaX+/aSYobwnoJGfnEx/3iusut7to3WoPBWvi+L6EdA3gATV
 9i2xzyRSR90NN9Ugt/D/LoD5le6llMhoRqKPsCRi94DeX9x9q9GrWwVGFMJHxfxwHjS3X
 FOkJyHbnbBnw4F8zu+zYJm3YTnFdJqgw3hNwNDtypUQdWTLMyAp74tJCmXqNmfUwgiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411297;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=YAQFVarwqU7yb927t6QZ5I/kKx7HdnxhBW5jpGA42HA=;
 b=SrymdfYWEdELf3BUjHZ59AflGsLhyMbJ33f05LuZ+LNuqofyP197TvKJ+906tsza3Guu
 VC0AJ/+HYidewAxEgug357rttY01Cv9c3A0S7Ub13suhhIqcArCXLLASE/tKg0auD/P6f
 PCKrJpYIvIN0WBJ0aw6r3sr+wOxCwSq9k+OVPV8OQsukGxPF5fJbvbcMQTNXDLuuLHQv0
 Qx1pY/KpyltfSDwDCBPDfz/SNBRYtZbK3BEN5DClYBOBkNyqGKiwDKTH3YDcve9s/bR4q
 mtNU0TiBbFKaud57YCnRnVfqFDhU4wlTzwE0DrsA6MNS2jY98KrALEdXUT5UhgTaEGg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=V+M7plsJ; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=V+M7plsJ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E994740079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:01:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A6EC6021C;
 Mon, 19 Oct 2026 12:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F155D1F000C4;
 Mon, 19 Oct 2026 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792411294;
 bh=YAQFVarwqU7yb927t6QZ5I/kKx7HdnxhBW5jpGA42HA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=V+M7plsJQ7ltZdCiaCMOvoSIOx5LtoZfVbq9FchNVItuNj0WSJgQlFRmLEO4x/A6Q
 h/Kk43yPotjJgGJsVeQy4YNcPJXJK3u0Ay1Ypme3O8lL7iJ5IqkF1HyNzl/4qtIdLz
 FtVAXULU9fg6VkwZJknQ20U6Mlafh5nCNnWjQanRVx/V1qnuPO7OHPV45UnQCSkTYQ
 QfOqbTbsYxdKq8Kzz1B562EaHcvJ5E5XOSB92IBYcJQxaHmpxSWgVEwxgN0xCxRtaa
 Qi5SacwBk318g3XuGI/FXZbYmc219muhC3lxKewqmEfH43WxLw4R+KCr2YFBlbrsYN
 W1oOQl6AWNFMg==
Date: Mon, 19 Oct 2026 17:31:28 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 6/7] arm64: dts: monaco-evk: Force vreg_l8a always-on
 to protect UFS VCC
Message-ID: <atYGmDLyFKdDCZwZ@sumit-xelite>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
 <20260812-b4-monaco-v2-6-865d288c0be6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812-b4-monaco-v2-6-865d288c0be6@oss.qualcomm.com>
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

On Wed, 12 Aug 2026 at 06:42:04 +0530, Balaji Selvanathan wrote:
>vreg_l8a is the shared VCC rail for UFS (ufs_mem_hc vcc-supply) and
>eMMC (sdhc_1 vmmc-supply). UFS holds no regulator vote of its own in
>U-Boot, so nothing stops other consumers from disabling the rail
>while UFS still needs it.

Why not teach UFS driver to keep it's regulator vote intact? Don't add
DT workarounds for this.

-Sumit

>
>eMMC's power-cycle runs after UFS has already linked up and started
>transferring data. Its power-off fires a real disable vote on
>vreg_l8a, glitching UFS VCC while the link is live. UFS has no
>recovery from this: every following command fails (OCS errors, UTP
>timeouts, "Card did not respond to voltage select! : -110").
>
>Force the rail always-on so the disable vote is rejected in
>regulator_set_enable() (-EACCES) before it reaches the RPMh driver.
>eMMC is non-removable and does not need a real power-cycle.
>
>Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>---
> arch/arm/dts/monaco-evk-u-boot.dtsi | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
>index 5520d111864..8e9102eae4d 100644
>--- a/arch/arm/dts/monaco-evk-u-boot.dtsi
>+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
>@@ -34,3 +34,7 @@
> 		};
> 	};
> };
>+
>+&vreg_l8a {
>+	regulator-always-on;
>+};
>
>-- 
>2.34.1
>
