Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A72C5DF67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D8338127A;
	Thu, 13 Aug 2026 16:55:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m1k7zk1QfZHO; Thu, 13 Aug 2026 16:55:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8399B80F46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640158;
	bh=HIT/K18J6RJFBR026D4QL41/kxsSEnSdwevk7gKLHVs=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kKMXslzFGwwRYtYDBdnRx+PT15JQ8RivrYTksbWYb+CMq1Ut0OJL/WlwBiL+UTx+3
	 0Kn/l7MxhLSBKQqyvVuNVnh4s4xZO/Gd3RZzhAvM9voJLbZXf4vwQaXAPQrsHt+1UM
	 XR+kJbvpOxGHEGuCYGmVRITuTN1ouonjXub10dw8pO8bV2/1xDGrjJUuuEYMU3hKJO
	 McD/bPwoeDKfnE0dcdIHv9YNWxLyoX89y02++5zab1rzi0hrw2C76kpyEGOIvUSbFr
	 kzSpfdcPNaOt9ESKybIXegOpkOyNIAq3gWJ19/h+/EtaFV6c1E6AooA90begEfrNSv
	 BEpQymFcKADJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8399B80F46;
	Thu, 13 Aug 2026 16:55:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D2B649B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5350F409FA
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jn4tvryGI0WC for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:55:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::190b; helo=smtp-190b.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 545F6409F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 545F6409F1
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::190b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 545F6409F1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:54 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLWhR38k1z4DF;
 Thu, 13 Aug 2026 18:55:51 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLWhQ19tDzhvF; Thu, 13 Aug 2026 18:55:50 +0200 (CEST)
To: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260730120907.1209949-1-jonas@kwiboo.se>
References: <20260730120907.1209949-1-jonas@kwiboo.se>
Subject: Re: [PATCH] arm: dts: rockchip: Drop OTP nodes from u-boot.dtsi on
 RK3528/RK356x
Message-Id: <178664015010.342950.5623829716567457951.b4-ty@b4>
Date: Thu, 13 Aug 2026 18:55:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786640151;
 bh=HIT/K18J6RJFBR026D4QL41/kxsSEnSdwevk7gKLHVs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=cpnRm1le65ZpsbEb7/CCLHtx/yEW0CZPAFLpY0XSFrBWLiGRJ/aCjY6/UNiD4MCtC
 44JyA/R5HfTxLH52VOh6iRYVmA2HO2qceQwLNeh/UEC2Im/H8Xgu1Vdkh1SJkSH1Ix
 ej634kT6ViVjuOlBtEDZfgItYfUL/gUCuXYrMxzUTp/XSUwwQ351g9tMCAXs0qKwM3
 4Rpk2pU8mzDSnVm7NM09IQhBerOsRoGBq/VDNVGKeRFhqQg8tB124q3/WZPEof61ov
 yJxRVZ0NL1kKYI7BopujZM0aK7ls6S8aDBsWJnDn+rXphkDGQbIjwF332qZXMFYhtV
 7uTh/VAhO3Q8g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=cpnRm1le
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

On Thu, 30 Jul 2026 12:09:07 +0000, Jonas Karlman wrote:
> The OTP nodes for RK3528/RK356x was merged in Linux v7.1. Remove the
> obsolete OTP nodes from <soc>-u-boot.dtsi now that dts/upstream have
> been updated in commit d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of
> dts repo [1] into dts/upstream").

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/1] arm: dts: rockchip: Drop OTP nodes from u-boot.dtsi on RK3528/RK356x
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/6b917b413d315550eccc8e22a0f6516c34fa4bb3

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

