Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573EBC5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 05:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C9E87656;
	Thu, 23 Nov 2023 06:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="qdI67eC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96648870BC; Thu, 23 Nov 2023 06:29:19 +0100 (CET)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43B0487683
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 06:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=LpDI+wMNSoXPu4QA5sZYlUuHFejKjmG84BBEPB6eA5M=; b=qdI67eC9+3a3+vKqmNYZtvNQQl
 ARHWPstyJEwstlfVZuA/6IYFAmR5mquWRoEOoBqTDdXg/SsxwBDQULz+wrdcEgMpkF41J3leB6QAy
 dQ3uLob0V2lLVzVmSfGDFQHwj6g7/mM6SJ/Rt162ui741vPnjNLPrDNTDVl4TfzrM5/kErpvEzhfl
 4pDMf9ssSBUJ6it7dRL620pUrZuAZCV+fcJC4o1z23PzvGDoURJcay+tjtGNRq7n5eLV30OwLg7sr
 ouKBseadb0kJD3iH/qNsbIeIwY+7dJNk6YGelce7J8xfoc4WNgQyaugNI2mCd1uXZNgOTzgx+PsC4
 ztRuSFJg==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1r62H4-001Zp5-Bq; Thu, 23 Nov 2023 05:29:15 +0000
References: <87y1gea460.fsf@tom-fitzhenry.me.uk>
 <95062a1b-914f-fa41-778f-c7b0a21a48d0@rock-chips.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, eugen.hristev@collabora.com,
 jason.zhu@rock-chips.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 u-boot@lists.denx.de, xzy.xu@rock-chips.com
Subject: Re: [PATCH v2 RESEND] mmc: dw_mmc: reset controller after data error
Date: Thu, 23 Nov 2023 16:26:26 +1100
In-reply-to: <95062a1b-914f-fa41-778f-c7b0a21a48d0@rock-chips.com>
Message-ID: <87leapox5x.fsf@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 0
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


Kever Yang <kever.yang@rock-chips.com> writes:
> =C2=A0=C2=A0=C2=A0 Could you have a try with rockchip vendor U-Boot, mayb=
e still some
> other fixes are missing in mainline U-Boot mmc driver.

Sorry, I just realised I sent this message as a reply to the patch,
rather than against the bug report[0].

I have tested the vendor u-boot, and found it to be working. I have
replied against the bug thread[1].

0. https://lore.kernel.org/u-boot/20230619103347.278004-1-eugen.hristev@col=
labora.com/
1. https://lore.kernel.org/u-boot/87pm01oxd2.fsf@tom-fitzhenry.me.uk/
