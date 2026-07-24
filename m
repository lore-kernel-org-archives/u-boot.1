Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB3DC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DA0B60BE2;
	Fri, 24 Jul 2026 14:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLXdoyRpZngH; Fri, 24 Jul 2026 14:02:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 550B460BC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901754;
	bh=uyEMBVVB1/x9NdfK3js6GuM3Uer0qn7XOKvNF3DVZcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sr6l7Sa/ZrDuIUbwHyLRspZVPzQoPaFXfXY7Fs5SrwiofloxUjqliUHhrSQwj6t3v
	 m6of0xGfIChYM+Lmk/AaoMx0PceSASKV4R7jk9OJik4H+9+RreG209hBQnSJBJOaiL
	 C96vCc1XMDsKQG7Dzg9E74LZ7VsVf0P8KQ3HEgWp+8ChQsb9zi38B4D3AFUX3qihBw
	 e/TeJWnSRROpaC6b6IL9/rcvG01SoyEr5wbplnpzIafP/3Wvh34Ffc3YpeCDbaVreb
	 Vz8n09qrEm/eLwCSJ8efn4l1JpT/gQ4dRLS8Hoz+yu3BriYmA1qe4H1pJG+zB2mXUw
	 QNLK3al4rV/4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 550B460BC8;
	Fri, 24 Jul 2026 14:02:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48ADB224
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38FCD404D4
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bvu100aZHb5L for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:54:32 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 34996404D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34996404D1
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34996404D1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:54:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B9783E76; Fri, 24 Jul 2026 14:54:29 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0445A800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 14:54:27 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83AD8600AA;
 Fri, 24 Jul 2026 12:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703891F000E9;
 Fri, 24 Jul 2026 12:54:25 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atishp@atishpatra.org>, Daniel Golle <daniel@makrotopia.org>, Dillon Min
 <dillon.minfei@gmail.com>, E Shattow <e@freeshell.de>, Fabio Estevam
 <festevam@gmail.com>, Frank Wunderlich <frank-w@public-files.de>, Hal Feng
 <hal.feng@starfivetech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, James Hilliard <james.hilliard1@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Max Merchel
 <Max.Merchel@ew.tq-group.com>, Michal Simek <michal.simek@amd.com>, Minda
 Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sam
 Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@ew.tq-group.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] doc: Switch from setenv to env set
In-Reply-To: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
References: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
Date: Fri, 24 Jul 2026 14:54:23 +0200
Message-ID: <87qzks7dkw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784897666;
 bh=uyEMBVVB1/x9NdfK3js6GuM3Uer0qn7XOKvNF3DVZcI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=fIP/K8yjdvgrCv5AQV8OPq4QCgsIPT8WudekvQZmeXQnozlbK5/Xo3uivvI16jJcZ
 aypT2FOBZv7lYx5rGdN4yD5fSjdxYgXWXmOcd/4b7uXFI5/kB45IJTeFB0/1eAFZyR
 nc17n8fDHmLk5pwDrHcoWI+UADRkWxkZrjbGf3lBxwklan/vDE8L+AJ3QyVILeka7R
 oPFbCsxcoO8CiFVFnJ3+Z1qIDZGL8dkUrOSa8AmsVbNdhMYGj+g50sl1jJxxG9ACG6
 ASgnK7Fes5L0VNHue2dbbe0493O0WUOSQN/cACpAoKONEke9NdqzEJVKKzV5JVoTGJ
 T8HfDAKxhtjcQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fIP/K8yj
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="fIP/K8yj"; 
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

Hi Marek,

Thank you for the patch.

On Sun, Jul 19, 2026 at 01:45, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The "env" command is the recommended environment management command,
> its "set" subcommand is the equivalent replacement for legacy "setenv"
> command. Update the documentation to use the contemporary "env set"
> command instead of legacy "setenv" command.
>
> Note that the "setenv" command is unlikely to be removed from U-Boot
> in the near future due to it being integral part of the command line
> ABI.
>
> Implemented using:
> $ sed -i 's@\<setenv\>@env set@g' $(git grep -li '\<setenv\>' doc/) README
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Will there be a follow up to this series to also patch the board, env and
defconfig files?

