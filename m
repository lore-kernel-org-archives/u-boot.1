Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E392EC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 03:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60CEA8111D;
	Fri,  7 Aug 2026 03:48:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RMnmQ2_To5ls; Fri,  7 Aug 2026 03:48:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91D1C81116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786074493;
	bh=FNN4ostqwUwA95tQQ0eWD0MV1oVcjGOBrQLJCXeBsx4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=T5aJc7aUJJZgfUQfytD+5oZrrYUmq+kI2ySpXVm8V/o5PvEgZw5kJkZm53YBb624x
	 GG3zfvYg3CYmYIx5uh6iBrzj/fTYj+KYKsA3QkPe4dFFcDfqU6DCGCuld8yMZ/xhgX
	 thh6dg/Mj8XZevq5WPFuJSVNXVUdU2JP5DOn5PFMlJTIUyezo4ckjNd9ZBkP01HvgY
	 6w9SpPX4iiJRxjRl324u3L7AQ6CR3owIBjm/Xx5HgR1nZuXEHNx+EOCSp5uzxubpkR
	 qji4ShQC2xVJzBpluO3NxgDWa3tcJOj5RrwEX4qUJDZ9m8hXJ9/ezW5F5wZOq1HQoL
	 cJ9Cqnk9h8iWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91D1C81116;
	Fri,  7 Aug 2026 03:48:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A5172B6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00A3460879
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7dWlO07v_TZY for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 03:48:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0BE0060629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BE0060629
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BE0060629
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:10 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hGVVH06XnzKm5q;
 Fri, 07 Aug 2026 05:48:07 +0200 (CEST)
Message-ID: <cbd49d9f-f066-4422-895e-dba941cbd70e@mailbox.org>
Date: Thu, 6 Aug 2026 14:55:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6 1/3] doc: usb: remove obsolete MediaTek MTU3 bindings
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
 <20260806-ccaione-upstream-mtu3-spl-gadget-v6-1-66e133a4bf1a@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-1-66e133a4bf1a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: twoykyxgdq86nedqtmd6idt71of4n5qe
X-MBO-RS-ID: f19a4811f51119c4b3c
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786074487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNN4ostqwUwA95tQQ0eWD0MV1oVcjGOBrQLJCXeBsx4=;
 b=YNCQtwahXQVF+/0KrIZ6LrOfKZJIPqeP9T0rwS6RGGGkAK1Y5ANXIs1toDSFxgIsDQcUUE
 Tg3k3kLM3/uU435L+qE25svdGq8vX0HdNlX+ClaBjJ0o0yYgF8MaPWSCm0cBr/3Ob/912/
 diee56hAzuZJsv98Yiu2DEmuZm0zjMgmetnKy7va8UoBc8w0fcySYwP0suqM0fQK80wCby
 6yDIIQdIJgxNMGk/puccxQXjrVgkGaBHpMrXYrHc2sXUweUVQr7UlqQQyosWwgMj9SXN2A
 6qiSfldl9h6aDbyRQ7+86YAh4uh9x+IU+BbFeM+mWOI5G7K+AUVMa1T7X/0u7A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YNCQtwah
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
> The MediaTek MTU3 and xHCI text bindings describe legacy U-Boot layouts
> which have been superseded by the canonical Linux schemas. Those schemas
> are already synchronized into `dts/upstream/Bindings/usb`.
> 
> Remove the duplicate text bindings so new devicetrees and driver changes
> use the maintained YAML definitions.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
