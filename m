Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D585FC531D2
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2956B409DE;
	Thu, 23 Jul 2026 14:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wMzHcuozNCSo; Thu, 23 Jul 2026 14:09:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AF7C409B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784815799;
	bh=/Pe8NoqnEzVUQOTna7WB4Qa3HDh521x3CB6JHrXSvus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1DX0MnVlx30SCiqLsnTIniMlchMUQFTAoHQLmp0JcJsUBlDpkFjUe3kfQBqrTpre+
	 Ff5F0DU0q1F8spAFPoW098gqA6/6qZjuA0d3xhUK/12Jye2qZuvM91frv0crokRnrl
	 JPYa9A/1SHmSnqf45DqHGHRgci1qvRnYi/pEgtO4JJBUxIO0BiMvxIrtMGa9pdmamn
	 SodkywYeuUgesulpVb55K/NuB0SZSiW5yNQzpix4hKq7zE7nReKSNYEcScuHpGkJlA
	 ngBy4bImXFY+Dt+AVlTAsD9bTumQ4MG+B9XxdbFYHvOuuDozArg14984c5zAktEQpl
	 PxCZ8HbpzjUgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AF7C409B2;
	Thu, 23 Jul 2026 14:09:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 345B9224
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19E11403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEQH1yldO5Oc for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:09:56 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AC51C403DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC51C403DE
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC51C403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:09:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241E28493F; Thu, 23 Jul 2026 16:09:54 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0014883E76
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:09:51 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A868E600AD;
 Thu, 23 Jul 2026 14:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6E31F00A3A;
 Thu, 23 Jul 2026 14:09:49 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Quentin Schulz <quentin.schulz@cherry.de>, Kever
 Yang <kever.yang@rock-chips.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>, Balaji
 Selvanathan <balaji.selvanathan@oss.qualcomm.com>, Herve Codina
 <herve.codina@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, Stefan
 Roese <stefan.roese@mailbox.org>, Philip Molloy
 <philip.molloy@analog.com>, Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Bastien Curutchet
 <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH v3 1/2] linux/list.h: Add list_is_first()
In-Reply-To: <20260723-rzn1-usbf-v3-1-34dd7c4ddd99@bootlin.com>
References: <20260723-rzn1-usbf-v3-0-34dd7c4ddd99@bootlin.com>
 <20260723-rzn1-usbf-v3-1-34dd7c4ddd99@bootlin.com>
Date: Thu, 23 Jul 2026 16:09:47 +0200
Message-ID: <875x2594r8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784815790;
 bh=/Pe8NoqnEzVUQOTna7WB4Qa3HDh521x3CB6JHrXSvus=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=e/kwzBAwEhrUDGc2Pa4JLAnoVN/JkWTn5X4TWVwbWDvXi3LFEtArfjOMkySozxHKe
 2kOSLXsbyHqUs3nQ4m2583+msLm30BAejE9416ES5e61XZP+LaedB+Rf8fxAfwt6si
 NE2gWV9kV0KlFyyPZFM0UslTrHOdtMWWsWbNbu4xr79maqrOKepcpFsaUHWDeU0L2p
 T3PswT6abqM0SjlliCDoSif5zyvW/lprV3jVMjqfZUo/npVCJkUf9rXTmUZdbrk8NE
 TMccUtm0kbCu7ZOjyBUs5DR9VQ7qZeGHKbKkX/wvwSiYNtzriacqWKzX26MUK6cXdn
 4mZ0D1F7HB11w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=e/kwzBAw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="e/kwzBAw"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Romain,

Thank you for the patch.

On Thu, Jul 23, 2026 at 11:09, Romain Gantois <romain.gantois@bootlin.com> wrote:

> Include the list_is_first() kernel function, which will be used by the
> Renesas USBF driver.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

