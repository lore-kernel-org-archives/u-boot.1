Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750EBE94125
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 21:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC8686E69;
	Fri,  6 Oct 2023 23:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="Zcjnu228";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D44086E37; Fri,  6 Oct 2023 16:45:11 +0200 (CEST)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B8286ADA
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 16:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=l5Fatu+YcRgUEg+eK+MyxzXj8+OZjprleLqzaEa2xUc=; b=Zcjnu228Za1xnX72djK7EYYoHy
 OCPgVtR+G5tA2korN6HTWGNE7vV8mWfFxX4Le9lnrjS79XaS9lQg/5d052eR8UW4m/35avxnEsRo+
 iyZRLDEfgo2gjb1aUMgSHcB/IDx2PMb1xDE6122Bz5hMTrkUGV2XO9oD9Idmd/5Tj64ieOrd4CG0T
 oO7HUyh2DPwXgLO9SIfT67cjKWF/fMo6qRFPhYwOeUnm0DbpVlIXhjfkxxaglmfUcjcQPwKZ/YqH6
 84Gcwqy3E2znHzVoTzWmTg6jezxW9OSjeuguct0+JhxT7CcwOyG+xmAFBAKylUDdrS8KmkR5eRhQ5
 0fPkH9ww==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1qom4c-009JSn-Ho; Fri, 06 Oct 2023 15:45:03 +0100
User-agent: mu4e 1.10.7; emacs 29.1
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: jonas@kwiboo.se
Cc: benjamin.gaignard@collabora.com, david.wu@rock-chips.com,
 eugen.hristev@collabora.com, frank-w@public-files.de,
 frattaroli.nicolas@gmail.com, joe.hershberger@ni.com,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, rfried.dev@gmail.com,
 sebastian.reichel@collabora.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH 5/7] net: dwc_eth_qos_rockchip: Add support for RK3588
In-Reply-To: <20230807000817.1701012-6-jonas@kwiboo.se>
Date: Sat, 07 Oct 2023 01:43:41 +1100
Message-ID: <87edi7kdyb.fsf@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-BlackCat-Spam-Score: 14
X-Mailman-Approved-At: Fri, 06 Oct 2023 23:32:20 +0200
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

Tested to work (DHCP, ping) on RK3588 QuartzPro64 (DTS coming soon!),
thanks!

Tested-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
