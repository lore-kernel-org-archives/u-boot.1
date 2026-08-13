Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF33C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4326740A00;
	Thu, 13 Aug 2026 16:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U241OaK1k95w; Thu, 13 Aug 2026 16:55:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C493409FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640157;
	bh=zOA7zKBDXFHRcL+lJ7Hn2c+xHRH4VNws14+AvHx/K28=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cESHBypUXbBbGs55lnXV0EI2rvRbjxphGB2V3HzOovywaWmRFWkZBir/FWwb5Ca34
	 pMiR4EaDlMaFVonjyx2VDMBNFVpdaeC8nUpS4/D1vNS0AjPo5brCGH7TD9aQXK8rI9
	 lqvnRXk7aj8sc3QEFoIcTED8n0DZlVIRiXfplPK9yK8WuJRA1Nmj4Kl5SFAb4r3Q1N
	 tah4LdKGKTF9RheJyPgzSmE3swuiUOmE+y/V67Y3aBLM7RGfAf1eU4G9DJWw3Eln5x
	 pyNpma03x3l03HLxb7O3SnqrwbVsaaDvgsQvWObHVA31WjGULaYF6c7lFGrNBjdikX
	 EBgXdtaDLHUBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C493409FC;
	Thu, 13 Aug 2026 16:55:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 68211259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6270A4041B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqg65WndHtkp for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:55:55 +0000 (UTC)
X-Greylist: delayed 109355 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 13 Aug 2026 16:55:54 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 54CB340418
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54CB340418
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::bc0d; helo=smtp-bc0d.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::bc0d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54CB340418
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:54 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLWhS0yGmz2FD;
 Thu, 13 Aug 2026 18:55:52 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLWhR2x3LzhxR; Thu, 13 Aug 2026 18:55:51 +0200 (CEST)
To: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260710100521.3677247-1-jonas@kwiboo.se>
References: <20260710100521.3677247-1-jonas@kwiboo.se>
Subject: Re: [PATCH 0/7] rockchip: Enable USB support for RK3528
Message-Id: <178664015137.342950.9257272602190140562.b4-ty@b4>
Date: Thu, 13 Aug 2026 18:55:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786640151;
 bh=zOA7zKBDXFHRcL+lJ7Hn2c+xHRH4VNws14+AvHx/K28=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=mTUfdtUGE/w/zwCe2Wfu/Q0i1ZgSoZjjLba2hSPaX6hCu6RuCoImAOrDKNCkjvetz
 lZ7gUkbpncdvppVPTwLhDsRMus75Tb6htgcIcqLuFFcLdVT4uhRw3UzZco40YFceAb
 G4nlyaUupQ66Jkqwq49PD95KJwibghB/+xhaCzvv9I3uSmRI+4NPHQxTupVSg8BEh7
 si424b26yKH4N9Eji4W3+AQXk8lsTiO0lsv9H93RQUuHZY5x8/hNvyv+BX4rmy3rrE
 MspK9lwyFTdhh8eaarytOhozVdjKZ4u9/C+gMQZe34Tyh84yAOYOGb83CYs9VoEMdD
 CgXt1pZQ5OKMA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=mTUfdtUG
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 10 Jul 2026 10:05:12 +0000, Jonas Karlman wrote:
> This series picks USB related DT commits from v7.2-rc1-dts to enabled
> USB support on existing RK3528 boards. It also adds required DT nodes
> and enables required Kconfig options on the Generic RK3528 target.
> 
> The 'Add watchdog node for RK3528' commit was included to fully sync
> RK3528 DTs up to v7.2-rc1 state, it is not required for USB support.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/7] arm64: dts: rockchip: Add watchdog node for RK3528
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/a29794199190dee25a809210aad66ce5a18ef27f
[2/7] arm64: dts: rockchip: Add USB nodes for RK3528
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/42437844e1dc7b78661d8d66cb9939ad0f981734
[3/7] arm64: dts: rockchip: Enable USB 2.0 ports on Radxa E20C
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/34aecf3758bbb0251159cda1e0fa5c8a7aaa3f4f
[4/7] arm64: dts: rockchip: Enable USB ports on Radxa ROCK 2A/2F
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/7382b32c71b1c160c96678b32ccad6737f6cd5aa
[5/7] arm64: dts: rockchip: Enable USB 2.0 ports on ArmSoM Sige1
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/6426f2d2b3105e75a45e703ae4e6a90a7bc603f9
[6/7] arm64: dts: rockchip: Enable USB 2.0 ports on NanoPi Zero2
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/a6c6a2fd5bdd71fa6eedaf79ed6c55921741c9c9
[7/7] rockchip: rk3528-generic: Add support for USB OTG
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/8d913de45891bc79dcf2337e03da6b7ec4e83518

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

