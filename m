Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59A8C55162
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 03:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B22C80D2B;
	Mon,  3 Aug 2026 03:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPI7-bQpKDuk; Mon,  3 Aug 2026 03:51:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C61DF80D1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785729095;
	bh=/LkMdL8nxlSkLtNh1co6JabPCD3MWMPP38bGk3nGQgo=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mbQFTWTKUOsl28js+tL3gOALMwRQDQPflzLTNGtePMdekY5gV1tYam7sOCFE+Kh3c
	 BXsfbfmw3kqFdEwcgG+ksGEka2qnLmBa8Eu+laz0VcwuwJs1eU24NvVD61SRrQzP5x
	 GbA7lB9QbNk37qSgZcwjl+TQdOZDjAWPKJVmrItCFVi9aAWJUqHgFhHjdcqfEwwXob
	 pBXBKEX2O/bLEZYaU4Mfs7WeRUzHEFgnWJfU1kESIuUAfS2XcccjsYLs7/r59deFwu
	 wSO/CGzqp5Ts2mJKs/OxvcglT7PwXcEKk1EjGlkBeNFEkCdiWEpO/hwczYz1jpiKZc
	 fGR7hX/IjjzlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C61DF80D1D;
	Mon,  3 Aug 2026 03:51:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 702BF218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DCBB60616
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPAJ-23Fk-FQ for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 03:51:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 62ED060615
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62ED060615
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62ED060615
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:33 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hD2m064LkzMlHS;
 Mon, 03 Aug 2026 05:51:28 +0200 (CEST)
Message-ID: <33c75886-eeb9-4e67-b378-7a83ff1fd58f@mailbox.org>
Date: Sun, 2 Aug 2026 22:13:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] usb: mtu3: support the upstream devicetree binding
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com>
 <20260722-ccaione-upstream-mtu3-spl-gadget-v4-1-9719f4cecaeb@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-1-9719f4cecaeb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 82c67d8611534f934ad
X-MBO-RS-META: 4nrcdgzyprmte5hrzsfoaj98wwe7kfug
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785729089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/LkMdL8nxlSkLtNh1co6JabPCD3MWMPP38bGk3nGQgo=;
 b=GxXOI/ciYNkyr4kRcYnFpUNMg62WMVQhKYNl7AX1lamKcJ3gO+0symsER78vnA0eCOplnY
 Jzp4o6/qf0UiIQtmKlYMZsC0I8zZKi8qQ9U37CGqp+ENH06kDKDEZlDKsIkQGQaDAb1iFO
 7GnuNI1swtFGutLmDAYJofLU+lupdYGsl4eH4+LlfqEWfmt/dODazOhAJqLQwsYf9b4o0J
 KA6eVfxlSQw5J2MyTgxNAEhxpOxcXIL9pnJ/LakIax/NF9effeL8w22dVPztOG0QvJckT+
 9uElhUyj0pJHWm3BS2RlV3shtCQVD7eeywFexJiMLkl1X9I66SlooKXQeyipbg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=GxXOI/ci
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

On 7/22/26 11:43 PM, Carlo Caione wrote:
> The MTU3 glue driver only supports the legacy U-Boot layout, where a
> synthetic mediatek,ssusb child owns the gadget resources and dr_mode.
> Upstream devicetrees instead place these properties directly on the
> controller node. The gadget therefore cannot bind when U-Boot uses an
> upstream devicetree.
> 
> Search the controller children for the legacy U-Boot-only node and use
> the controller itself when none is present. This preserves compatibility
> with existing U-Boot devicetrees while allowing the driver to consume the
> upstream binding.
Can the U-Boot DTs be aligned with upstream DTs , and the driver fixed 
instead ? Then this compatibility goo won't be necessary ?
