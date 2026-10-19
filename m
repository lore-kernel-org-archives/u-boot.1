Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77136CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D42F4076B;
	Mon, 19 Oct 2026 12:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BolwtCyQcvq; Mon, 19 Oct 2026 12:03:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CB47407A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411421;
	b=oW3WwLeYJ4mqQw2Lh8WyJ+X7E/Pbt2IIKgHt8H0SX2p5VeVa/4VRYTr293dPnVFQSaF0
	 V/CrxFDNESs7RiDq/i0Z7azRjyTlPmNGk+V44hDh/jXSDu2RCRjy4WcoJseceUlFRh/74
	 CbT9pd/P0Lpwf/avgv0fhUZPDO46IVJNiDnYThnKn/tM1pi9eMS9SOdOwBuwsNNqcPj90
	 Ewzs036zFscyUh/H+5lnlLYIYscq+ZgoOq2IQjCbULdRG1GtcdiSY+s8QDD3EFVDba+A9
	 vBH40pMiyfvNFuked+6SewgzrfTGGxdMaV0eGHt83841ex20NNGT847e/mNE/Nqm3hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i6idtkW1bCVbda/lisreni0XT+L87eKtJSmhGXJhFKk=;
	b=nOLRAvBXorJV3yyP1UUA/qQJY32XdUFZbf31IPzfURifRT3+0ng4s1fK7jGP96PVv6fI
	 5m2uZxeYjyjHgXZWcewbylH/6esT9WESZn5VtjwLevI78ylM3e31mMSUuO4/Y+UAFTjY2
	 XnDrWF/b77KrzNSTquWQ3e8tTOnqASiN8EFZmrAvs9aACmqYcS9yxYSNemw2H5saG2bw2
	 OOIXItonfBPWywiteKuiFT6Kp7bV59YrbBBmLpLULVzidPmQWrLq4v0BhA2Bjs62Z/BiJ
	 3U2l348KRjmUtkyYBstYQyJS4eAmQvQCH4qRtseMS/aveSSO64mzC9tFhI11RwhtpFQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411421;
	bh=i6idtkW1bCVbda/lisreni0XT+L87eKtJSmhGXJhFKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rXdGyEjAvFBg63N2dFhQeJ/dGAHd4m5x95YuCEB6EHPu6V81nA/Kz7LvM0OoaHVB0
	 1vQqvc1JfxNuY5/Cplcd3ATsydsUvA1rd4tVztbP356OOUy3nGxh7Bi7nux4arQKJo
	 L2X0XRN0RJmR6/Py9zZdbXQj5YcbkmEQjlzYtLw/5QiSoZI3IrATWuwlrZ7NeuuMIn
	 SV4sENkTwZFdjRulBP/TbpQTYVtJ9TZn7Zh8v0yThSidiKWGMs2eBQIW3EbyH/3Dv0
	 vombjneRq/bbQ/o8H+gT8QIu7z0LWD1xCV856dVXYoBGK8xFeYhQRsP/STd0gR9xG3
	 lI18DJXr3Z4EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CB47407A3;
	Mon, 19 Oct 2026 12:03:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5584522B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B50560634
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZkd_4mrJ-0j for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A664605F4
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792411419;
 b=DfyJMn/etpEiLIXfrx3qy4UB+kSu5HZTKcLY6GKKDEF8R7aEagTvLJgO7uGRfYAvGuzW
 JczM3iRGCvDttuYFxEKs/9TLEb3bKmchRGN2DrhEIcR4Lt4gM1OYg3lrcb2iZ6NtfjBR2
 G4kF8jYksuzafe+fZJXAvkqDO+kswK20l0bivDsNJePrPe2NJY7x7GhkvnbOTNvT9B2n5
 NAH2jrHv9oPFsvjKklz3PTejC3PFWf1tHP4u8E2pKhgQDhiOpXlmp8UuQldLfqDOdfks3
 Hb1XRZw84hhwtGnFMsZloXZjX57AXA+dFNY5HjQP39F7x8Fw48JENfNWIHVPTq6YSdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411419;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=i6idtkW1bCVbda/lisreni0XT+L87eKtJSmhGXJhFKk=;
 b=IMHzHKRxKlCk7aGkNMzEIhAVuP8EdsYQiTw6PmrC6VDdKm/s8cv2rmnCLk9LgW7m1C0V
 Fi7it5HyrnS+BvGqwOtEMnbSbGrDx7YAI+hchbuksb65eb6cD/sIEYeehpKXjBhA5od/v
 xiRsOkCjGGWSY/h/mZXzO8C86p8y+Ipzp5r2IhR/E4v6w/3nDiimAX9hj+/yTOm/vdV6y
 ukCZWVVZVvpT8YxCTnPXQVh5FUXPiqLJ6Dqwp3zzriFZLOWGZsk53JSHS9qQkkIVM+iQn
 GG1V7T4XvoQNP2Gv8o/uTGnFnVlxL03HACcvGufFlfJ/aSKQjaTxjj0fBd6yvpJ1b0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ztym9PiC; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ztym9PiC
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A664605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:03:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 819CD40925;
 Mon, 19 Oct 2026 12:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580EB1F000C4;
 Mon, 19 Oct 2026 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792411418;
 bh=i6idtkW1bCVbda/lisreni0XT+L87eKtJSmhGXJhFKk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ztym9PiCJE/e1xsh19+vk2Asxebp8xcAtV1gwl+/ap9XZ5lIN5T5nvxYtiFTElSpe
 PQ19gaJLybpWAbSXMjbTS6gSCUPR5qwMBu+zb/68J9pI1ROqKijm0wX1M4wEDPDzKO
 Vyb9Sq/VVDwIZZjRz6kwkugbqXcFxvtWQ+HPYeanZepbzzNsT+gLrLwKRFqR4n5miJ
 5Rl56yqMDffvd4apEvd80VDWVs372GYiSmW4uvDcpT2ObL/eiJfDOd6DP5QRd6tFzz
 grOdRSor8JbN6hixKY5WaCRuIlKssNGbMbLQFpjVo1+iidADgfeeUab6bc11Vh4Kqx
 O8pdlDoc6rGOA==
Date: Mon, 19 Oct 2026 17:33:31 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 7/7] configs: qcom_qcs8300: Switch to monaco-evk DT
 and enable new drivers
Message-ID: <atYHE0kVcIn4NBd0@sumit-xelite>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
 <20260812-b4-monaco-v2-7-865d288c0be6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812-b4-monaco-v2-7-865d288c0be6@oss.qualcomm.com>
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

On Wed, 12 Aug 2026 at 06:42:05 +0530, Balaji Selvanathan wrote:
>Point qcom_qcs8300_defconfig at the monaco-evk device tree and
>turn on required drivers.
>
>Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>---
> configs/qcom_qcs8300_defconfig | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
>index 5fffcddc16e..c8c4ccb9ab2 100644
>--- a/configs/qcom_qcs8300_defconfig
>+++ b/configs/qcom_qcs8300_defconfig

Why not rename this too as qcom_monaco_defconfig like you are doing for
lemans?

>@@ -18,4 +18,8 @@ CONFIG_DEBUG_UART_CLOCK=14745600
> CONFIG_TEXT_BASE=0xaf000000
> CONFIG_REMAKE_ELF=y
>
>-CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
>+CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-evk"
>+CONFIG_PINCTRL_QCOM_QCS8300=y
>+CONFIG_INTERCONNECT_QCOM_QCS8300=y
>+
>+CONFIG_WATCHDOG_AUTOSTART=y

I see another series dropping watchdog support, so why add it in the
first place?

-Sumit
