Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72972C5DF81
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 02:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D368340875;
	Fri, 21 Aug 2026 02:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZGqsyR0lVqS9; Fri, 21 Aug 2026 02:25:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787279115;
	bh=zVI+82x8IWyJ59tSOskRB4yiWcVy8bQCVYk0Bv76y/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=flnTkEGjd6KE0STR2SEbBT60yq7DW8JcBaInKHY5l92Jp6kR9H7sugryXHBHwZdjK
	 sVtCiCEQyAtHtIZ1VpZwlGLOu2pg+OjW0EeMgIHY/Gk5sU/coZlwG47GHX9fsF9h78
	 FE/W9fIao6LpB7fBe3miqJjB+hO07m/cJkdGt/lPNHwwchdv7R8OI70j2j1/4KJOF+
	 50cZIUeehetsdMJ+deVhcTYLkWVUVUwNNUt0xFe6QaXvFfr4wIVD2P0d19tuKlK/ZN
	 5pb0O+z+Hw+iNKt0IhOQY0Baia2aCBXAMx43H8830tGdLU61AGBR+nDMmp7NI/9bch
	 PiNjxRvxjboug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49BEC40825;
	Fri, 21 Aug 2026 02:25:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 031FD39E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE7E74006B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3v9zqR7xrs0e for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 02:25:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=xvNjyLUz
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34C3140024
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:12 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hR405364MzKnDW;
 Fri, 21 Aug 2026 04:25:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787279109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVI+82x8IWyJ59tSOskRB4yiWcVy8bQCVYk0Bv76y/k=;
 b=xvNjyLUzom8/YGIqhDe05tc6VzCeva/PcB53mT4eskUG3AsS+cvXZKy+o4A9YXEx4WKHMW
 fxo63e8dU+tb/WAZeIB4C+ePJA43NlmmmcwQR1ti4V3Yail1QqLofUOWxccQ6WmPyHZpg4
 cJ/tVeJD2DIdlSWiehVGiOFASBmFSck0Z1x4Sldju4Hpb2W+SnRio1hmDnFzuwLZog2s38
 1yGBeA8SMAagmD/pgo6oZFDW9dmVuIUIxheE/uwXxtbhJ8W8mkzKfbdu0fFcviSyPFgwSA
 zuLZxrOk7pZrm+nqllNcbLNFonr+k03sQrhF2Q+nz7S7Bp9NQymocpHJXBtBGg==
Message-ID: <a298f2a3-f9cf-47ee-8133-1d13ed4ea7d3@mailbox.org>
Date: Fri, 21 Aug 2026 02:33:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 3/3] usb: mtu3: add SPL support
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>
References: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-0-ed659a79a918@baylibre.com>
 <20260808-ccaione-upstream-mtu3-spl-gadget-v7-3-ed659a79a918@baylibre.com>
 <3c8bc13f-be4c-49d4-ba43-65f787d82796@mailbox.org>
 <DKTVUMXOM1PK.MIFZ75Z7BXI@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DKTVUMXOM1PK.MIFZ75Z7BXI@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: d3jttrktuua9qoaq6qfsyka5me4bf887
X-MBO-RS-ID: 3147bc1521e17881180
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

On 8/20/26 5:40 PM, Carlo Caione wrote:
> On Sun Aug 9, 2026 at 8:45 AM CEST, Marek Vasut wrote:
>> On 8/8/26 3:40 PM, Carlo Caione wrote:
>>> MediaTek platforms may need the MTU3 controller before U-Boot proper is
>>> available, but the driver is currently selected and built only with the
>>> main U-Boot configuration symbols.
>>>
>>> Add an explicit SPL controller option with host and gadget modes. Make
>>> the driver build and its role checks phase-aware so each phase can select
>>> the MTU3 role it needs without coupling it to the U-Boot proper controller
>>> configuration.
>>>
>>> The upstream binding locates the xHCI child registers through the parent
>>> ranges property. Select SPL_OF_TRANSLATE for host mode so SPL can resolve
>>> that address before mapping it.
>>>
>>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>>> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
> 
> Thanks Marek. Just to confirm: this patchset should be picked up by you?
Isn't this patchset already in u-boot/main branch ?

948c428ff7ea ("doc: usb: remove obsolete MediaTek MTU3 bindings")
0f8cbf3a0d6f ("usb: mtu3: support the upstream devicetree binding")
08b77aac333c ("usb: mtu3: add SPL support")
