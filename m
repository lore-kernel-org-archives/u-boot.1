Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB589C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 659BC60BEE;
	Fri, 24 Jul 2026 14:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ctuBaPovwns; Fri, 24 Jul 2026 14:02:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70E8460BC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901757;
	bh=sBAcjdoMYc3Xzo8quKErVtknpAfnc3Nmo25UGgxSYII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gb4KwH+luHiTFIbS2pcD88W6d3Aqi6uDrgByq22LNohldameLYOI8lKG5sDKeUSxc
	 5dgpIw7X2CGtGdmSYkND2bl3dA7IjlQexsWDgwwiKWx/vuZKd1Z6lDW1pS0cEpasF5
	 rj/MWwG44E6ScnZvzXlujfDUPflre2KmpUjxsFFKE7wy0g9Z8Ue6XDVPfCVPk6xNI4
	 Dr+kdnqQZAbI5V7doJoqAs3I2MOqpk6L1HFR9fC0GaMwhLUtYmWiIiTw4TAGGWSIGl
	 gg4tuh1onE1BK9OviKyoOCHe6r2D7iHHJmUwLJsbjuLNmon/PDovzlwH2vnhwunUxR
	 /Sjg0JBmrs+RA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70E8460BC1;
	Fri, 24 Jul 2026 14:02:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEECB350
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A07D1404D1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-nuH-DyKWt9 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:54:50 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ADE46404D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADE46404D4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADE46404D4
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:54:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6751E83E76; Fri, 24 Jul 2026 14:54:47 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFC6800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 14:54:45 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98710600AA;
 Fri, 24 Jul 2026 12:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1111F000E9;
 Fri, 24 Jul 2026 12:54:43 +0000 (UTC)
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
Subject: Re: [PATCH 2/2] doc: Switch from printenv to env print
In-Reply-To: <20260718234617.98664-2-marek.vasut+renesas@mailbox.org>
References: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
 <20260718234617.98664-2-marek.vasut+renesas@mailbox.org>
Date: Fri, 24 Jul 2026 14:54:42 +0200
Message-ID: <87o6fw7dkd.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784897684;
 bh=sBAcjdoMYc3Xzo8quKErVtknpAfnc3Nmo25UGgxSYII=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Vnb2kELBmXMPqeNFZwSTMLX1Ty4AZ/VMNyAkxEv+8ewNlppSwgTTjOP826CBjqa43
 umFg0d+aGt5gYitFV7FjvIFCrIu1L2wo71vWrH8rxwe6qVOibDtARZ5FqZGr3aiLd7
 w+FCvTcfXfCFBvIGGzd5Ecl4sYRGj55lrfXYvVIBlQ3nm4eCojO0LUsOnRH/bH9jYT
 15D9qwaaYp8z05Q91oP78XVn6ufs+i7FkoHayYpmkDhH4ht8uUtkLgwOXEgU1OZdNS
 ljsmv54me5N0r6tZlRYHehuLMtrhQh4eHqZZOKU+IZGJkiJ9MbNCKJJI7Djaj8vF3a
 Cu/eE1TCKwTcg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Vnb2kELB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vnb2kELB"; 
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
> its "print" subcommand is the equivalent replacement for legacy "printenv"
> command. Update the documentation to use the contemporary "env print"
> command instead of legacy "printenv" command.
>
> Note that the "printenv" command is unlikely to be removed from U-Boot
> in the near future due to it being integral part of the command line
> ABI.
>
> Implemented using:
> $ sed -i 's@\<printenv\>@env print@g' $(git grep -li '\<printenv\>' doc/) README
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

