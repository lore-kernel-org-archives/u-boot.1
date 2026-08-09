Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1476AC5AD4E
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 06:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A49D36067C;
	Sun,  9 Aug 2026 06:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7U2Ki45DaIGV; Sun,  9 Aug 2026 06:45:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0C6F60638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786257924;
	bh=VigApnvqbJB/Mv4FiReWVM9WlI16YoHpVZEniSgDIgE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=L4nnv/bH1xGZNcla0gajLtDnN6HbIQ8VfreCS7I/bqH1bkeDVz3/tOM8QwgzRCBMp
	 Wtd1+ER6bBnYYfbyKNqqRn1jzUflqgWt8RIDYaNeHVShSShL2Coh/7LnHhjbICZcSd
	 GIVmMOLEFOoTbQIvJMBJu4eawkyA4IhU2A+b4RxvikdpOFbYaY6yzqe4nUGxAM6Tea
	 ahlwKntnBuzuVkmkaE4F1lMrhQhBY1HoK1ysY6AOzwZcZZ26zs9nfLw0lSwHMo5XsC
	 fAbReJF4WuY0+FahINYe/aVLnwzQC3TH9sfli+1t20enWY/qKtVwLJ4y80neMpK6MS
	 BcSfaIynGyqCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0C6F60638;
	Sun,  9 Aug 2026 06:45:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57C77218
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 06:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D1B74005B
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 06:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZxKt0j9ak27 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 06:45:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4FC1940051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FC1940051
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4FC1940051
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 06:45:21 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hHpKp0kpNz8tPS;
 Sun, 09 Aug 2026 08:45:18 +0200 (CEST)
Message-ID: <3c8bc13f-be4c-49d4-ba43-65f787d82796@mailbox.org>
Date: Sun, 9 Aug 2026 08:45:12 +0200
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
Content-Language: en-US
In-Reply-To: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-3-ed659a79a918@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: g6fo39upkcxc5cdwpmto4g6nf7k9a1ur
X-MBO-RS-ID: 6fa7636d94b5ffeb5b8
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786257918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VigApnvqbJB/Mv4FiReWVM9WlI16YoHpVZEniSgDIgE=;
 b=jnn0tpusiTfC54hU7Wd2HQ1SxVDBLkBW8ZLnsv5XaxD6+L+6MsG2Wv4vgjMzn3kogDPFjG
 dG9RL3Uk3/Ixgd7tYzhQ5O3r+6cK1/60Bdut5dfkkBQ83qPUt39vXhO7WEUu5T2k3giGG+
 9ZiReIUR/Qv8K530Y6JoZq8hLeDuj7dWF57wSxEdPkl7hjl5Gemz8u+XfDVDKgRE7CdFlR
 TJb1YA3gDLjpAyTZzixqBSgy1vyhUZD8E/zHnjqoKbgspkoJrJ8h1L4G57IpAHMXJm6NJt
 v1LYhBqk17W5S/bPU9M1utq2M+vfq3ssiAef7mXnheEZ2MnXnt6irxZCg+fuWQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=jnn0tpus
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

On 8/8/26 3:40 PM, Carlo Caione wrote:
> MediaTek platforms may need the MTU3 controller before U-Boot proper is
> available, but the driver is currently selected and built only with the
> main U-Boot configuration symbols.
> 
> Add an explicit SPL controller option with host and gadget modes. Make
> the driver build and its role checks phase-aware so each phase can select
> the MTU3 role it needs without coupling it to the U-Boot proper controller
> configuration.
> 
> The upstream binding locates the xHCI child registers through the parent
> ranges property. Select SPL_OF_TRANSLATE for host mode so SPL can resolve
> that address before mapping it.
> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
