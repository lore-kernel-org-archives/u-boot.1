Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A809CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56228849BF;
	Fri, 19 Jun 2026 16:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B8FKTEoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D59D84A37; Fri, 19 Jun 2026 16:05:41 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C1B847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD362601E1;
 Fri, 19 Jun 2026 14:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059081F000E9;
 Fri, 19 Jun 2026 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781877937;
 bh=SXcf+DZtlOyeVKKMlF5OijgA1iqQDd8uOTMkHPDbcIY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=B8FKTEoWh3B7YwnWp/9j6j73+JI2f4p9lXiynhzQCdt/rCCdINRfGggrtzJ0jlmwP
 CCdOYFsF8z6WXA39FeAqXUuJStI7L6WJidw17ww8vxIyyZqxo/4syj5F7llwt0bchd
 ZPPyvdocavmV2btANP4bckLaoCZRG60ec3QAJvncm9K9fpOon27ytHLh7mpKVMXyBv
 vrHKtPtWUgfTykvQqWwxTs2ve8k6kaAk39XWNv2N/d+O8JB1wFOi9IvX/oMfjnwXtz
 LRdfilyd6j6Q+ToD7ppbxVYtI1Y1fUBllIrVNZrUBnQJzN6kVUhsdpLFPW6/YeGX+r
 srDdC4/UBO65A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, Casey
 Connolly <casey.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Ariel
 D'Alessandro <ariel.dalessandro@collabora.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH v2 2/2] board: qualcomm: phone: enable
 CMD_FASTBOOT_ABORT_KEYED
In-Reply-To: <20260619-fastboot-abort-keyed-v2-2-684e53949a42@samcday.com>
References: <20260619-fastboot-abort-keyed-v2-0-684e53949a42@samcday.com>
 <20260619-fastboot-abort-keyed-v2-2-684e53949a42@samcday.com>
Date: Fri, 19 Jun 2026 16:05:34 +0200
Message-ID: <871pe2hbgx.fsf@kernel.org>
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

Hi Sam,

Thank you for the patch.

On Fri, Jun 19, 2026 at 09:55, Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org> wrote:

> From: Sam Day <me@samcday.com>
>
> Thus users are able to exit from fastboot by pressing a key.
>
> It's also possible to bail out by running `fastboot continue` from the
> host, but it's nice to be consistent with UMS. Also convenient to be
> able to bailout during testing if USB isn't working properly.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Casey, can I take this through my tree (along with the fastboot patch) ?

