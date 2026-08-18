Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22AFC5DF84
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 11:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10B8E608B6;
	Tue, 18 Aug 2026 11:42:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNZCkbko_rTG; Tue, 18 Aug 2026 11:42:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94CB3607ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787053376;
	bh=kUHV6BMsTAYoS6k2pny9SAwceSRv+wotfxcHvOTJQrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GuUxdbGc2pxXhG3FvybSNyW8ma+I1oEu1fwHRddjoTxyl7lizK+u42sw7f1S8X3wF
	 TC8vXKUT7/VbfbOTH71Q9HKeczWVoUjxFtHh61N7eax7HfXnjGHODrOAdM0sOmGn1R
	 Bv3hlB33LZp+wncGvbTuu+/K1q4EWZEwmMlB2DpK/0zdCqrKRpbHEyYaN3+0TtcWoi
	 luM2tdpiedk3VB0mMmOOgdGUC3Lp8XeB29ry9YooOIA0Or1HKF3zVOnANwjhTSLb+W
	 PLv2thkPi5PAUHkmPo/NGCV6XZ13LE42bR3nmb/nxzdTRoafgNE8LiO4CyC1lBWZnU
	 0GI1xqzVA7+ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94CB3607ED;
	Tue, 18 Aug 2026 11:42:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B48DD333
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A3A580F58
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6ajZ6I4-8Ng for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 11:42:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 43FFE80F42
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43FFE80F42
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=HOgNtB9M
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43FFE80F42
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:42:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E0B531199B5; Tue, 18 Aug 2026 13:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787053364;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=kUHV6BMsTAYoS6k2pny9SAwceSRv+wotfxcHvOTJQrY=;
 b=HOgNtB9Mbv+uaxdiAWoPmExSklqWqao766DDxI/JBBhjyvGGyCHiOYj/JYJmPrfow+Rk74
 xTHP8sEoYVinvEgESL5a9lpQuAX34IAQL26z3d58aaQPo513PxIF0ukicYWjvk42zltf0N
 pM2bTxlvh1D+hlOkBJerjXQHw6YWejPLt0utiN+Np6DOQ46dGVNhDgAEr+kk+c8jto1rO+
 S68kudCqU3e04V4MOxX4S1LS3+dUSNwVKfLUTL4qm4s6WdgaBTD7Auhy9jkA8+dOSgPfef
 mNj22mcNfzQR7ibbWo/3PVGXY9h/Iy4wD6MwJbnly44mAylS6D7PcUaHoMUogw==
Message-ID: <d72375be-410a-47ae-ba33-0e175c053c9f@nabladev.com>
Date: Tue, 18 Aug 2026 11:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] net: fsl_enetc_xpcs_phy: Extract common PMA MMD
 init sequence into helper function
To: alice.guo@oss.nxp.com, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
 <20260818-imx95-v1-1-12ef3eea3943@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260818-imx95-v1-1-12ef3eea3943@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 8/18/26 5:18 AM, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Extract steps 1.6-1.13 of PMA MMD initialization from
> xpcs_phy_usxgmii_pma_config() into xpcs_phy_common_init_seq_1() to
> improve code reusability.
> 
> No functional changes.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>
