Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12442C5DF70
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 09:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C80DC40621;
	Mon, 17 Aug 2026 09:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4SYrPwU4I_ng; Mon, 17 Aug 2026 09:34:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC4854062E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786959296;
	bh=eUodX9Pm8jvPAem3kq+2EZLUWY1KxkUiaTxr9zOR7N4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CeVAQ9xkpWxIQyTEsh4NKg/zhREhuVnO6ZViu2l/rHHv6nuemjn4fphGGOBJNNAN0
	 VnQA/cFy/1FIKmzh9z/ZDAV+nvbBh4pn49grJJuqMcpbGmMhYKZDkvlXc/h1SLNg/V
	 p7QeREDoFCELQigj9eQHjPWMU+Ki1/ZtUuU6HX9GuAWs/isAbTEE23K5a4MUyFUM8M
	 a3CjBBKM3mw/GeDULVVGYz9f4lcCKHe8h8Yk0fHSdfIFTqSQSdlPBQsZAyAbU1LcYn
	 vgneETecysq9B5Ow8m04Cv+DBvQot7kFQeutBd/9FYtnxztnW74xc/ZzrFXdlf4wGR
	 JG24+sUhJsXsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC4854062E;
	Mon, 17 Aug 2026 09:34:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C83E25B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 627D040621
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YcNDTrg8Dpg for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:34:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 73AF74055B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73AF74055B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=GDqloIZW
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73AF74055B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:34:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22F6C4013E;
 Mon, 17 Aug 2026 09:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA0D1F000E9;
 Mon, 17 Aug 2026 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959293;
 bh=eUodX9Pm8jvPAem3kq+2EZLUWY1KxkUiaTxr9zOR7N4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=GDqloIZW3Id7765yI6lU7cVFoguzw5M4Es9q8tMbZMz3iDVRQrkr41DCYRQsocvKJ
 inoYqWsdyX+WPiyCfC3GinBleiZmq+i0bsLR38Lhr33EV2eLj5jthCo1WJzCc9SuWA
 1OaD20tksy68kjwKgVpgoxRol8d8NeDhJpp/iwlbHXSpfWQ0uZKV2jM/nv167P1DPq
 AkWS0G90uqRr8VfDK9vcSY2UQwGaPTXgYg8SAk0WBA5ThXHiW44GUdCsFVLxOdsgdk
 G3T1GbeGafabHmf3POYms+Gf8CXiyx2U2o8N8WVyZKl4umhE3dVlxM/bPeKYlRJr9t
 39JC6+aMb0NHw==
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
Subject: Re: [PATCH RFC v3 4/5] image: sparse: add phase-aware SPL support
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-4-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
 <20260731-ccaione-upstream-spl-fastboot-v3-4-dbea3ff4529e@baylibre.com>
Date: Mon, 17 Aug 2026 11:34:51 +0200
Message-ID: <87a4qlhyys.fsf@kernel.org>
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

> The Android sparse-image writer is selected and configured only through
> U-Boot-proper symbols. An SPL storage service therefore cannot reuse
> it without either pulling it into every SPL build or interpreting the
> U-Boot-proper fill-buffer setting.
>
> Add opt-in SPL symbols, build the writer through the phase-aware object
> rule and read the matching phase value with CONFIG_VAL(). Existing
> U-Boot-proper builds continue to use IMAGE_SPARSE and retain the same
> fill-buffer default.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Sorry for the review delays.
This looks good to me.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

