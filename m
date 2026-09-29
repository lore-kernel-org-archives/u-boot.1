Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965E0CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 10:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B25B40619;
	Tue, 29 Sep 2026 10:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id onZEupSu_GuF; Tue, 29 Sep 2026 10:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D1B8405A6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790676851;
	b=h1uJ+Uh5UhGy0mnVlExMkGVquhcTUAa/F779/BfmWNDsFy5Lhs9PoEoW76drMrPkRTfN
	 InmUtWmkIemb+HFKhOQiTr3cROQxjPOXLWAxdfaFXLJ6e2/wvw18LPadK8Q5KVenu3ICk
	 qrYRe5DGrA+Y+sYtV/0lRur0JqxoNDyQMmoOc56jiJMI8xJ3Qar7RGYbWloTKNzEwbkUb
	 vELeX24lEi5QGhsrZduIZA2ZiR0/boq14mYcybFX9vJKfVtfFyuX/ySGRt36raTz6+MX4
	 W7Jmle9Pavz5Gm7Y84h7ye4XrkXq6ybJ/eAWd2xt7ZlCJYKdp/y5AVsj4IqiReLwr/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790676851;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JCHTW0j6kSCY0SnDPzfpfdCVAZPvS/A0jLuIDtCVHYo=;
	b=qiEhTdyJdCtMgplTJNa1wBhN3cAL6XRpJS8zqpRz79VaocRSYd0vtY7EYgYMFbb88JM7
	 /n7FOXbB+tef+1hwN9WPgwZz6+9pbG0EcyMHF55F7t8rn7sd4LNvh3c4NxLg70HXD81o3
	 8VER81rYXyz2xUTdiGjtpNCniYc2mak24UIOH+OVtxDFOlMzjlic+IaPGdY5br0QIxfP7
	 F1oMZf8xS26UEF0sqCHNwxs/iCTOz6L4hCSKyXvPxhLcDtZ21rQi0dvQDcGRe4XYZzWi4
	 /r9b1LnHZWzUQoItoRon6atC/VqMX4CKxyhoFE9HQYcuw/CDiq1wm+f6BaV8jYoFAgQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCkMlM4u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790676851;
	bh=JCHTW0j6kSCY0SnDPzfpfdCVAZPvS/A0jLuIDtCVHYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tv9MpmHK4HBhH6cA/bffpA4tB6yF67GDbMHKFfFRL08iBWIJe1swfSN8RaNYN7Y4I
	 qKsCbVY2gatej7tw4sOrzMBQrt2qOe96HMGZUB4jKLECpZbDGue10RZMierzeVzWE6
	 0afHkN13B3O31BDbtgfqBv03MSDRsaSWntVy36r29oqUsawRzCVEJkIGnraOsEQYOy
	 V3y95ht9ggkAeUiWiTybYEWmbjmN70VNWaC1vCDKZdwz58J9rEQp2+k8J0wSnnXmSA
	 YfgrPGHte9ucze6rxEdsobSApj4O/WnadfFPzeOL/cVQ2plCel7w7yxd0W0JRDdyH+
	 8qiJ1yuLNGr8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D1B8405A6;
	Tue, 29 Sep 2026 10:14:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E0D532A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73BA9405A6
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDqiLjFrWK8B for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 10:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9BFDD4059C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790676848;
 b=ZBR6toOP/OPw+ID8SKocgl2T6TNvhi0rWQGFOmABSOeMEX+6+E1ukKSQJEoutN6kClM2
 qUHs+zGvAKMnaKRqm6ed/+VO3dLSe7VMueEo76r1O5ZUBjOkEcIU6bQ27Ar9gtq5wZKuU
 JIcOABxaacqfJWe8H4/60Ho2aKI8Gx6p05BuQxYMlrpI7ISvoig+BFSzJx/EzrVYsAMVZ
 9t2jCVmyINxDpJ+Rwma0/5wKNEVoWSxe8uHhsD5lZDG4QPvbzyH7gs5Mj2/ksHuIB41nq
 ykild0m1X1lCbapwsiXkzeE7ySUSyxr+79i6Mt86UShhwcBP0KB3yr7OUoMCBTkYQRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790676848;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=JCHTW0j6kSCY0SnDPzfpfdCVAZPvS/A0jLuIDtCVHYo=;
 b=R9DDno2ayAEpb92VU3egeF+uLglvNlBvLVUAu66o3GwCs2mcs7i4XV+frhIVlRJ78RLL
 ukRVupFhubf5tMxqkln4cFcK9Mr8LK0Yn1yeDpLGg/Ltsd+e+VIyjNoFCg2JlIElZumge
 0txQMiCWXtrEd0WJs+GWH6vY5PzTPDfAXvsEXBVUn2+6aBQYEMU146gDE+y1bJ2lvGfjU
 /q1r2C4Zy6XrR8XvCBXCLKVvtzkAUr35YTUBogcF3fY7eLbFC15Jcmt9vkOq+rn7QQ1tT
 etMDAfRwBIwiINX/4YDCrDUiY+DCmbGPeuYPROQMYwYvE08vLEB4lzyRINfwC+kVb0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZCkMlM4u; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZCkMlM4u
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BFDD4059C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:14:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2CF6601DB;
 Tue, 29 Sep 2026 10:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C8B1F000FF;
 Tue, 29 Sep 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790676846;
 bh=JCHTW0j6kSCY0SnDPzfpfdCVAZPvS/A0jLuIDtCVHYo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZCkMlM4utBtN3yYJ5Z4rZseeqKHqSQre3rQVpcwz/KJEL6r7BdYTgVJdM1e7Kfu9C
 0O67WnpRaqhqIOiVkqpxZO1IKxKr9bVnZHjIv3kVQLbe+yJC+oxq0L86gaWOY7cHn8
 VJGTaoV41UNO1iw+BIz+1yCvFCEWfyFvD5Tki/4X/OJqUoJcYRGxyhfD768zcGXlX+
 J/cHYRO+zoptVatL0a0/e/xmsM5mj8aM/9YuDRZG/6U/1eGaplcsIEW8cNNqFByA52
 81BdAhO+fFESisJIA2xJHSSonCYb0h6P/qekwL/rD3b0wwClAi5qU7TapyTIKntKJ6
 OTb1FAtL3ooXA==
From: Yixun Lan <dlan@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>, Eric Chung <eric.chung@riscstar.com>
Cc: Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Wei Fu <wefu@redhat.com>, Scott Bambrough <scott@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v13 0/7] spacemit mmc driver
Date: Tue, 29 Sep 2026 10:14:00 +0000
Message-ID: <179067680265.1560050.7465254545699739868.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912-m4-v13-0-71043b29630f@riscstar.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
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


On Sat, 12 Sep 2026 20:36:53 +0800, Eric Chung wrote:
> This series adds MMC support for the SpacemiT K1: an SDHCI platform
> driver, the SD card device-tree overlay, defconfig options, and SPL
> boot-device selection from the SoC strap/config registers. The SDHCI
> driver is usable in both SPL and U-Boot proper.
> 
> A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
> write images to eMMC.
> 
> [...]

Applied, thanks!

[1/7] spacemit: k1: select boot device via config registers
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/aa3091dcd7012ca77fae5854da62e360a9d4ddeb
[2/7] mmc: k1: add sdhci platform driver
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/18e9745c932718335d0a8cf0223a00d216f71272
[3/7] dts: k1: enable mmc devices in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/c8d4129cb9a4ef84fb167324a4fee1b2807e9219
[4/7] configs: k1: enable SD and eMMC support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/f570dfb74e7ddcd4063bec68e3e81a7063179700
[5/7] MAINTAINER: update Spacemit K1 entry
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/a75e1ed839a31f8ae9e534fa76167290f1180d94
[6/7] doc: spacemit: flash on K1 SoC based boards
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/69d82789fe6fdaea697fa124a934aa5e4a92b3d1
[7/7] spacemit: k1: fix product name detection and DTB matching in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/6f8c134610b9d139ff3e104e4cdba3512c4ee7e1

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
