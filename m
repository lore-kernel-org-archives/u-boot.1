Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F91C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 03:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 195D58112B;
	Fri,  7 Aug 2026 03:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFys4tTyqc5L; Fri,  7 Aug 2026 03:48:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 700F181119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786074500;
	bh=wiFuyLx8l8LeiDF0W7gDsQYXOEzW532E3SLKhJ2t9hA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wcM/y/IBug2vAIc46Gb8y8tv2JekAZZqqzjAPwcRmj74KzNBpcwYzTuqL6x/m7iNc
	 UDSOY5AoW9C29IfeHCFFP01Rim9Fp0bRCekCH8FNw0ded18IvghBHU2N0xUKBFVXp0
	 QAJxy2e3Bq5OSg/w8cCmPZRJQEwdyTGX11QVqkaHzL8TneJ5cssp7GS/4GTo5zKY/U
	 xr0/qIKM+XLj7ExhNZXjbe70qDvc47xyxSzMoYQKHFdvpVmZMb6ypPgkR2TXISy/Tm
	 t86n/stPE8FQotSgGLxB3o8pqPuNzItExSegcyOa057qnyQ8fVA2kHFjaegEgVqU9p
	 Eon7kkfHO76xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 700F181119;
	Fri,  7 Aug 2026 03:48:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1C8823F
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 883AC81129
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkrT58IvcgVP for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 03:48:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BE5448111A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE5448111A
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE5448111A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:18 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hGVVR3QbjzMlDH;
 Fri, 07 Aug 2026 05:48:15 +0200 (CEST)
Message-ID: <a0483caa-3bed-454c-b946-4a237d4380db@mailbox.org>
Date: Thu, 6 Aug 2026 20:24:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/3] usb: mtu3: support the upstream devicetree binding
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
 Marek Vasut <marex@denx.de>, Julien Masson <jmasson@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>
References: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
 <20260806-ccaione-upstream-mtu3-spl-gadget-v6-2-66e133a4bf1a@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-2-66e133a4bf1a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6892697f53b21524217
X-MBO-RS-META: tx5zte195p5fegu1etxwegpb7xc87yz3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786074495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiFuyLx8l8LeiDF0W7gDsQYXOEzW532E3SLKhJ2t9hA=;
 b=eGJBUzqFQKhadnGUUqhfp3pFcnLbOhu6AfCgyAbxqe9NDQwzHDzFI/tyKwqahO6pOPk8F6
 dvHruDWSsVnIYGZ1zaeAhKHgYdo+nXz8M61iTgWXf5ozc8vYg21hQ3fTqEhSiGtjwnhE2I
 2Y0stQPeE5vTZgoSweHk7WIQ+Op1hz+7qlAak1EhHhedtMMNtoTh10O8zEGDeA6qhpiZPe
 +v9F7MPrwL9em4vdie83vr4VFJBhLqU+OTYx8O/Gie/zc61SSGi/ZXzn8l6hdG6+X7/FIa
 7lP8EwE904rg/TZCAtJ/zCr9tZVSuLRdhOAY2aMF8E3C+MxuSrTlKYIzzY1iFw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=eGJBUzqF
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/6/26 2:54 PM, Carlo Caione wrote:
> The MTU3 glue driver expects a synthetic mediatek,ssusb child that
> combines the device and xHCI register windows. Upstream devicetrees
> instead put the device resources on the controller node and describe the
> xHCI window with a standard child node, so U-Boot cannot use an upstream
> topology.
> 
> Switch to the upstream layout. The controller owns the shared resources
> and the device MAC, with the device register offsets relative to it as in
> Linux. The gadget role binds as a node-less internal device, while the
> host role binds to an enabled xHCI child and uses its own clocks,
> supplies and register window. dr_mode selects the role and defaults to
> otg, and the Kconfig choice constrains which role the build provides.
> The legacy child layout is rejected explicitly so its combined register
> window cannot be mistaken for the device MAC.
> 
> Convert the in-tree MT8183 and MT8512 devicetrees in the same commit so
> neither platform is left without USB. MT8512 stays peripheral-only
> because its xHCI host interrupt is not documented and the
> mediatek,mtk-xhci binding requires it.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
