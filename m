Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728DFC5DF70
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 08:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20B3140732;
	Mon, 17 Aug 2026 08:50:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_AGYzMNHKAT; Mon, 17 Aug 2026 08:49:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A99D940723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786956599;
	bh=5rb7ZSrHY3XfZjf4E0eC8zsSATFbbYIsPVK5SZWoD+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2NifHiETzHAjbfceyd+MrRYDg8jGYyEeUjh/rtXMsB5+PolLD2VQ8y4I1oDSuSgw
	 RiaOiYLHqcA5FCVyOoiC2+5leTxwHKfkeyuQUrSJ313NE3TK0VJmS33oQnbC+j8Y8C
	 n4CgCKLlKPMFJ2Hwo/e37t0fZSRN3YaCORHDxfJTas/GTJBhYa0L9SsiXKNccxN5QE
	 nMLmTupA3kY1QGjWBDum4PcXDuwjnJnb1KfnLo3jtE+DkOK7JYd9iqmk30JoYxB21Q
	 Kk52Ndgfha9pzaux6m50mQk9LIO1O1m7bqCTS05hS5CKxLPo/AC57T2CIGFRaeFJmY
	 E242ssm3rq+PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A99D940723;
	Mon, 17 Aug 2026 08:49:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E60B3336
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D79CC40719
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YmI339GFCnyu for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:49:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3EB8A406DB
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EB8A406DB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=C5se77kH
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EB8A406DB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:49:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC02E40531;
 Mon, 17 Aug 2026 08:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531B41F00A3A;
 Mon, 17 Aug 2026 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956597;
 bh=5rb7ZSrHY3XfZjf4E0eC8zsSATFbbYIsPVK5SZWoD+Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=C5se77kHg+eI23WDVYVuNUCHAe0Qyvj+7NOe8cTgTJ7sX7IvHv80cS9sTibVhOGN7
 Xd+oBjWZz0ynlbdxsVwvadffsAmxOlzCvS6xoQbTdAhmIiGVy3bkysszYOnmmcN7ij
 df2JfV4MVvc2oXnwtVqBnoGgdnMBwTDIi4i6lzU4Xa9JNDWV5KPKxkg19QAl12Xt9b
 yBd1hos+r1za8fRGK5vFo5u5wOAos7IneYv86BuNJRbeRymj1Kyx3my2Bi558EuEDU
 y62d5j0UGRh0JUNUhYHJFR/Fo/WSVDeHKe7fodliGpZjMCWOndTbMjx77j+y3NyL6s
 dmA0x8GvWorTw==
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
Subject: Re: [PATCH RFC v3 1/5] fastboot: factor out the USB session runner
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-1-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
 <20260731-ccaione-upstream-spl-fastboot-v3-1-dbea3ff4529e@baylibre.com>
Date: Mon, 17 Aug 2026 10:49:55 +0200
Message-ID: <87ik59i11o.fsf@kernel.org>
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

> The fastboot command currently owns USB gadget setup, protocol
> initialization, the service loop and teardown. This prevents callers
> which do not use the command line from starting USB fastboot without
> duplicating the same session lifecycle.
>
> Move that lifecycle into fastboot_usb_run() and leave cmd/fastboot.c
> responsible only for argument parsing and transport selection.
> Initialize network sessions in their transport path so their existing
> behavior is preserved.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Sorry for the review delay. This looks good to me!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

