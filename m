Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A8CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 10:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5AC04062D;
	Tue, 29 Sep 2026 10:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VBzp5QkJxR0R; Tue, 29 Sep 2026 10:15:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BDBE940602
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790676954;
	b=SMHMFn9JjtNAVeP6F5n4v3abXd/SkdHqpqx+D/tBH79UCWx8aC4La8mv8xOzkHaiczST
	 5brfEVy7njQV+Jz92YkF2+vzZeWUbNfAhJfNPUCbuqdtTS+LrS47xpQYK/CvwjlJmPIdg
	 25Fg9o0FLad2CFtBujYb06Z+u3ROupo5RBypA4/J72grAcXwZKwq9l8UVHb66QrTjZvOz
	 0Enon3lYcgY+L4Ub545sPKVV9V1LW8TNxXE+ak4/nCqjBTWxdDoleJgfpUt+8yukUVYVe
	 7PzOQtdV4Vp+DFMFC9OibToN7T6VKgBSRIJWwREVzRovSHMLqZenEin12qNmpWUmFmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790676954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6JEE5GPjh2y5Jcxb456m0dzpR9il2Hf4L1umHmFf2Q0=;
	b=bBUbavvp+e+YKBj5Wmm6reiQXmFdbKjQ7hAoF0fxCsKu8tFhhFORsLvZDApTSIEVBXYB
	 ZcPHNNc8rnYCROnyVhP1tVQYrISErTtci/d6Xbo5vYdOtOv5610zFlezm0hrH16eTIgh8
	 8ekcfy2ZVE78j1ol6Y3G3V98OaEW5pRkM0y/x/LGYazhUyi8G2t4veTIjcUKZiZiZDAWe
	 wg51J/ulWckfa7OwFZQu+gnLDJFURHR2R3PbkTFpkWW57IaSiXhjqq8cgy93UWEWL0Qe0
	 tj/+i3LdY27bEy6oH0S4F6wi0lBKhNjAWOw9TD40+5pbJRMYx76NnvXfGNVH0ck4mIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790676954;
	bh=6JEE5GPjh2y5Jcxb456m0dzpR9il2Hf4L1umHmFf2Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6Dn1jL1frOJKYgNoNB+FwChWp3Mxr5iHadOsWdSrjaM/W5yLJvG/EqeN0jmIXQOo
	 chp8IL646bZu1NZfeUyJyI1kpbn2laFLdX1kXlMtdYkKdq1u8SBOSBu7EAeH0lK7Vw
	 EN0WvjJIzqGI3qo9S+7ibcwRMJSIsWa+eL5mXc/LPzCreka8Ru93PZ6IFe3T2g7z/H
	 aW72xdvG6nana9dp5vt+ike9Mdbqtq55Q0rx09wGsPOPHRnqfUogOuqWQid043+dY1
	 NT8gxgq6j3lM8WnXgvPfKphvktEY883we+HPYK9bgOOg50Tv3y4XzTlrruGrxPTiAh
	 4QZ7rcsomQI/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDBE940602;
	Tue, 29 Sep 2026 10:15:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F49061
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E968060767
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yH0ByR0hbaP3 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 10:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 258F260731
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790676952;
 b=X08rtUiDmZ5nBh+t7hztRxoOVq43FjY8dtapqBLAr9ckJ+mZsISQJNa8fPP6OQFh/VM4
 vxaA26/PBMG5PAMjV2Z60zt5fZi9ia/Gvss9D198mTO4UnaYRZSsHZNJsl0YyCnE7D68N
 SSQYBZbYeJ8vRrUV6kNlo9Bl8RvCDxfqn4v8W48mADYj0bdtyBPMVrPbxE0yM/TQ8lVYm
 Vuc/IsxuD1pBReRImYdMxP/n4EXYMbWfN4qsZ5UN5DCIdpjVAqUGaCDeGp8YQgR7C5Sb8
 i3N9PZ4FW7CFYi/plnLVaFui2RfuKjXQb907z6ogM0qlJpohQ7C70+WW80nk54bCBpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790676952;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=6JEE5GPjh2y5Jcxb456m0dzpR9il2Hf4L1umHmFf2Q0=;
 b=sLFq72K4hIzQSaP1VOkBnEJCM/pq1jr//qkkjmKc2N2TbKxy7Fd+UeycgDYA+QEI0ZMj
 Afjke/+OuzW+yb5ySEQAXVRixd+tQRtrhs+TgiXAPL+gib2Eh5cryMIrrog5Pxu8VrcZv
 mYZVJjfXxyLtmj2ksr9WmtufvDvy0/XlrBqM5oozwPM6bmEoQ/Hn9XpAqY1seyk3VrMYY
 I/CFf5xDwfHi1oKaEnbf0l2taYnkPH5zz8SJ0Vs5Kpch/IxjR3G8ivTQfntRZDM186fMc
 V4P7rRgWcNCGw/cttw8GbXOMtqSOk72y7t/7M7wKLkuavjq6dQqbDwgS1ttrv8bA5XA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iIBPwD4s; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=iIBPwD4s
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 258F260731
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:15:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3664600D1;
 Tue, 29 Sep 2026 10:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6F01F000FF;
 Tue, 29 Sep 2026 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790676950;
 bh=6JEE5GPjh2y5Jcxb456m0dzpR9il2Hf4L1umHmFf2Q0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iIBPwD4sjVMeG1f0ecXQBD9t5QByFDs0qlF8iX1x2wvv0IfAET5uuJiasNNeMgqbE
 eL4+QV06xzld+ejaljFcBb2ymwak3PpDtjCNzyZTjhGAXZ1/RcKF0dOAXpHPv4DyoX
 XrxfoyRY6HGdamyBhW9ChidwXKYj3y5iO2biRBN6NUwo02XLAwKMTJIq6Ss0jRg7wH
 B7rEk6M3kIN2m2JRlhE9lRk9sJI8YhQIWHlAz6UbhKUshXBCDeh6QbHB68RYqTOs22
 64fUFnG9yFYWQlsCcO20wi6gJIZJBqtmKUzIQl+2E6xNE6+cEc48pLGzCsAEGmGhyY
 qYK8p69MGK12A==
From: Yixun Lan <dlan@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Eric Chung <eric.chung@riscstar.com>
Cc: Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Scott Bambrough <scott@riststar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Siu Ming Tong <smtong@axiado.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 0/4] pci: enable designware pci and phy on spacemit k1
 SoC
Date: Tue, 29 Sep 2026 10:15:39 +0000
Message-ID: <179067692083.1561522.1819581167894094558.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
References: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
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


On Sun, 13 Sep 2026 12:23:09 +0800, Eric Chung wrote:
> 


Applied, thanks!

[1/4] phy: spacemit: add K1 PCIe/USB3 combo PHY driver
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/57eb5723d5feb3226cff9ac1d8379f0b31eb09b1
[2/4] pci: spacemit: add DesignWare PCIe host controller driver
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/c8764b8db670152ff8e3b393c8de52823bef51ec
[3/4] configs: k1: enable PCIe and NVMe support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/d70d033928044754e9ac6ea103bfaea19b300816
[4/4] MAINTAINER: add K1 PCIe driver to Spacemit entry
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/dfa681ec397aed90bd13aa5e0e887ee533d41988

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
