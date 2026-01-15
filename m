Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199D7D41144
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 09:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863D480077;
	Thu, 15 Jan 2026 10:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hPd08T/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E6580325; Thu, 15 Jan 2026 10:27:07 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A93E8003E
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 382BC601B3;
 Thu, 15 Jan 2026 09:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BD1C116D0;
 Thu, 15 Jan 2026 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768469223;
 bh=3oDtbxU9QzxDq1xwbZiwSIYZj4ZTrjp5ujomzDClccw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hPd08T/gzAFzzCULwW1poJRCswGHdeUae5+3N5FTt0sz9+26ZqMc/Z6MCRSEqf8De
 q8MDV18M53AK93jhuYBRXJqaRIBKfYTncHadjHkEGbPgYSeEJiyplW1mI4ll9JeJbX
 qcyCDKImZ8MYhFyPOzHaLqZKdlGRQcjZTZSwvH6l7ouWHun53wMzzIBDzF1iw4gS+a
 dPsZzHoqCo1stM+Him9+la4c6vbWq4xrcXDNtefolLGrdeedhAa1eqIaFj0IJ+EK/H
 5+LbWHF2VuE70ZCfwNy0hLi/T1UPFrsdEi5swzfD8IYLy5S1jn4JqgtXFE7HbUowH9
 +eirfnm00X2Bw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Casey Connolly
 <casey.connolly@linaro.org>, Kaustabh Chakraborty
 <kauschluss@disroot.org>, Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko
 <semen.protsenko@linaro.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 3/3] usb: dwc3-generic: respect role-switch-default-mode
In-Reply-To: <20260114-casey-usb-role-switch-v1-3-fb7a626466b9@linaro.org>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-3-fb7a626466b9@linaro.org>
Date: Thu, 15 Jan 2026 10:27:01 +0100
Message-ID: <87zf6fdy56.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Casey,

Thank you for the patch.

On Wed, Jan 14, 2026 at 15:13, Casey Connolly <casey.connolly@linaro.org> wrote:

> Respect the default mode configured in DT if it is set and dr_mode is
> OTG. This allows the board to prefer host mode even on a DRD capable
> controller.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/dwc3-generic.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
