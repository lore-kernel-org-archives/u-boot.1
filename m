Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161D5E95A63
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 14:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7824886CF4;
	Sat,  7 Oct 2023 16:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="k3Zmrt9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D868686BD1; Sat,  7 Oct 2023 16:38:53 +0200 (CEST)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571FA86459
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 16:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=E08MVwjFeglhdUhyhhtAvHrdN2haqkTuzpxPftksPDE=; b=k3Zmrt9urBKOzIIQksIyYn8fIl
 pZKPGBS20N8pgDigXyeWX1GQ7Na6GVgMzrwji5Vb8E+m5gqH9EH8cOMIVTbhHIDgrT7U/dyOZ4pOz
 ujS4BRUVk9xxiRMiKRicY7/Q+6ZBWFkaS6NDZBdmPfWrvvLxWdiy+x/STbh2ynXA3nGkeY94H8kdy
 TtrnoVIr5gInPRbN2VvIu8tPC62UM+Y3CruChVFh8XtvcliWZ2coYEnz87QWiHJQy1854ssZYjOO8
 2EQuR/n7OEMaR4wg77NB1P7gxk53Ui2wEhPhRDPIKzJ2oukpTIejIhVInYJ1mEajxs/x9XAw96I7f
 guLds5vg==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1qp8S7-00GzPA-91; Sat, 07 Oct 2023 15:38:47 +0100
User-agent: mu4e 1.10.7; emacs 29.1
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: eugen.hristev@collabora.com
Cc: jason.zhu@rock-chips.com, jh80.chung@samsung.com, kever.yang@rock-chips.com,
 peng.fan@nxp.com, u-boot@lists.denx.de, xzy.xu@rock-chips.com
Subject: Re: [PATCH v2 RESEND] mmc: dw_mmc: reset controller after data error
In-Reply-To: <20230619103347.278004-1-eugen.hristev@collabora.com>
Date: Sun, 08 Oct 2023 01:37:07 +1100
Message-ID: <87y1gea460.fsf@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-BlackCat-Spam-Score: 0
X-Mailman-Approved-At: Sat, 07 Oct 2023 16:57:15 +0200
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

I am able to reproduce this on RK3588 QuartzPro64.

I thought "[PATCH v2 RESEND] mmc: dw_mmc: reset controller after data
error"[0] might fix this, but after applying that, I am still able to
reproduce the issue.

0. https://lore.kernel.org/u-boot/20230619103347.278004-1-eugen.hristev@collabora.com/
