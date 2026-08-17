Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2973BC5DF70
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 08:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3798940467;
	Mon, 17 Aug 2026 08:56:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ywPdFiWnLuh0; Mon, 17 Aug 2026 08:56:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F741404EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786956987;
	bh=z5Y+vTFOfJkOJDpoFyx02nxHhHck8IoMzQPeNJipYqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ihH6nuDGCBRWiZeKOjy/N6QwNyg7JDbgNnvH9EG0mbK6wqcaNoeE41s25jjRX0ol7
	 flF1tyg4G8JutLklSkD2OcQ2Zk60igorK+SdOhKoXJ/x0WWBuJcKzb7Hds36uKpBMQ
	 awveqM8ZhrR24Kqt57pw3E1rCDpgTC6ThxMykQYrJWIKVW4v+nPaJetFpky4JdHWw9
	 YQMSkSGtjgHOY/WaU8A7p+cdDLDAEASK39DEiklJT55os0rdMTed/UAIziiXfoNQ4z
	 /TSzDYU32L7DBkqVE5YeGqdAijE2HpVIiXAenCHgZIfX7tj0wC+FwRmTDmWaTv4g9N
	 wpFTRTtjLJ0Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F741404EC;
	Mon, 17 Aug 2026 08:56:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CEE92EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E101440387
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3JdRfsOveYTL for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:56:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3F90A40310
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F90A40310
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YtfP5BhK
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F90A40310
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:56:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CDA1600AE;
 Mon, 17 Aug 2026 08:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDD41F00A3A;
 Mon, 17 Aug 2026 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956984;
 bh=z5Y+vTFOfJkOJDpoFyx02nxHhHck8IoMzQPeNJipYqY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=YtfP5BhKziOQC73CRlqwCV2B+6XGAxFBLSyTKp2gLC89xRMIRhbN6utyjYA17Ijhi
 tp8ng+WRwWINfwDBw6QeWBHIT6ZnL/tCYaPDW4oabSZcyCRrsPMWeU+udKK6pDE4OU
 KjzAXUou1Z631Tlom8SLIdqr8XYFo2LStNzeOVqfw5xhc8ANUkoc1fYTMpEQPBAAfn
 kpYD6Vp7jjavAH0y6e+lhZRZmIGSsRBFHz+dFeab5H9ZqyUnkwjHYr8k8bNeNOvI5O
 7izu9EVOkKyZ/JRQ7KIZVEKmSq2D63RNA04WnllrRvejZ+7kSOe+3fEcre8ObfAWwN
 M4/qMYwJIoECQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFj?=
 =?utf-8?B?cGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, Carlo Caione
 <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, Vitor Sato
 Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, Francois Berder
 <fberder@outlook.fr>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin
 <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH RFC v3 2/5] fastboot: use the common handler for USB reboot
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-2-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
 <20260731-ccaione-upstream-spl-fastboot-v3-2-dbea3ff4529e@baylibre.com>
Date: Mon, 17 Aug 2026 10:56:21 +0200
Message-ID: <87fr0di0qy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Carlo,

Thank you for the patch.

On Fri, Jul 31, 2026 at 10:29, Carlo Caione <ccaione@baylibre.com> wrote:

> USB fastboot resets the device directly from its request-completion
> callback, while the network transports route completed commands through
> fastboot_handle_boot(). Keeping reset policy in the transport makes it
> harder to support callers with a different reset interface.
>
> Send the USB reboot completion through the common handler as
> well. U-Boot proper retains the same do_reset() behavior, while
> execution-phase-specific policy can be contained in the shared code.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Sorry for the review delay, this looks good to me!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

