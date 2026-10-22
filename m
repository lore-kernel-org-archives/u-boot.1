Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF0606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XqUdJLT3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTGfolLv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21AE08140A;
	Thu, 22 Oct 2026 22:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PGBuJLx9yyoT; Thu, 22 Oct 2026 22:49:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D08481412
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792709397;
	b=CrakPsqguzyK5d8VCRWYBqa1xi28vYPCPd4jYj/Zunk4xEpq6bZw+AQT34cmOmBm922q
	 t/TDTLC7fPLdQX1XGCxVda0LmZeazd7M4lF9LN+yDrT6g4oVP8BXJ6L7gLHZ/VYpqnTIt
	 kh41PaDNYHr4yuhlAXRIjdzOHbFf4jFrgE4OUaUAob9dZK+TuC1G4qY0/max1hT6/KrPd
	 Z9aVSnRnFXm+3otThyyClCuLjsuK92fYfxxRSyVZSbGOoZkhSsvOD9Kfcz8VcmzuKic7Y
	 senwJUnJqd59X64PyRHHZ5DwNIN95D3EpOsTVfZx6qyzYXgnnbmhpCtFHqaDO7PGzAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792709397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z5kbLxwd0fgESvVqXuZA8RuyOWQldLYr5uNQdT2+/5I=;
	b=E3dssbioPofbe2eQO0etlN+WlK6nfoKoAtY8Vg9kesbbsDmmNSkw8U4pjx0s5uXd6sxe
	 2WMG/70Cob0xO7hRD1w5NS3WC/po5Zy1xzm9VTsHkLyCdBMFDmnSWFtD2O0xJ7q/+6IjU
	 ZADzlhfhl06U3+VCo62B7o0sNhAPjv4Szulj9Txq2QhMcpQ48PpXRX7WPhUDPFvv9aayn
	 xa8YWfoxd20Yaaclj8KCLV2EOsUhccLfizWZWmXlwDIcVczcjuuOuBKK3pNmsLSXMLRwQ
	 ycKe8+A36ZQNBsuvGHMmHLqFjpBElMEpOTm5JZsufzIifGdwOR94VUASUEK4Vg/sazQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792709397;
	bh=Z5kbLxwd0fgESvVqXuZA8RuyOWQldLYr5uNQdT2+/5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XqUdJLT3rC4Jbqkcday8N/t5tYWLEODwuWBjeBZTfdxDbZ0QznvHOkxcvcCqYxOTn
	 LOCw5UIMBqGpFyIOoG7Wx7orgmBgUIQl+QFQE2SuY0a+OY3sawJUyxF0AlZOV8q4tI
	 8AOUEyQVpLQbphcy6e2Dg0OgBKEW2TClqslkK6wcX9fN/gjNE05KoY/LH9CZWvCfAj
	 GPboWhgpmDzEW6dexk7LVXibj5SEfC2EbMgGK8lhAAUKrRx83EGB7va1BmuO2qdIF1
	 Nf3g6q7cdPmLmI1/oGJtz2XgSY/1d00A+WO1rcvpfLp+URuQONFAEQceQqu+Aejc9X
	 OHV1kLKqOQsPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D08481412;
	Thu, 22 Oct 2026 22:49:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5192B1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43AA8608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:49:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1yPEPRTIvlpp for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:49:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E67860883
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792709395;
 b=rvSikhVRJa++86J+/rzjdstn8OxjCve/1svvo3KtRAC8flEOwpyHxQaNMbMQ+ZAJq9hR
 FnY7Ez0dkrWV+WQo6sZ3ODkVz91FPYKt+2IraaDRYfOh/Wj9DbAfJhH+rFsho5Bz2gH39
 zCliQT7ekzedYUyTQhySop3Eib0LyZWh/A/yuJyPaYTO0tasK3FlBSCQw41TucosLWs/V
 jYsLPzNcc8a1BM2fn/AN2JfSsXsZcaD8E+5ZNTm3xUcrCZarGMfSA63XUD0jGv3rF0ZEQ
 /CaR4118waPRMSAEhPDu0ut+Ej0l3VRmKinjtCn7cpbPUoDHEPao8yVopP8CnlZ0YvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792709395;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Z5kbLxwd0fgESvVqXuZA8RuyOWQldLYr5uNQdT2+/5I=;
 b=ZoPI1tXJrZo+BA57sXjuE7p3Cnx78MXrkoTNO1yhMlbxCqhKWgzecR5gF83QTiOWJ852
 NmrTKWLa02/RdOKfV92C2uhRv8MQb3xNirq1mPxMrXKX8k39BIOV+u1YJgdxaw9n/0Tt3
 1SJOdmmUtgbUhDb7fTJdtpWuym5t9FBuEVP7pKrvrQ1ppKwuek95Y//TjIi0cuckHTHPs
 7AYvvSSgZgF3CuvXd+sVFDGlYCaQxZGVACQ5zbdJegpikGGZAoyXmkA2FyJBBY2nPPKkC
 b4KrwCnR+A8uAPDI1XWa4YMv0zknTJpAOT9oeTOAojKVfhLAvUd3hcVkme6wBt8hbag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dTGfolLv; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dTGfolLv
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E67860883
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:49:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB7D643DEC;
 Thu, 22 Oct 2026 22:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467801F01825;
 Thu, 22 Oct 2026 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792709393;
 bh=Z5kbLxwd0fgESvVqXuZA8RuyOWQldLYr5uNQdT2+/5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dTGfolLvVIeja7hB5pd4Na/oEJP04mCypIRaioK+b5TJSk/dnFDsmY48RIRtapMUu
 oOr6FiLtKSSLiq4UetAckLS2bDqy5zI8Do3X1b+pBiEROb1a2g08CXypwZD+dRrTOW
 F21FEGswnuavtqU7asn6Lw/7Zy3B4i/qiXxCAePO1SNqUE5+geKOshwA883vARdfJd
 RhNCl02AGr8tXgKqpvGscFxRDOAXsecH1nX2NwC4msldi6ZzRkv49dFM5zHa6+Az23
 B35Ct2ctIU6SCoctybMfI5FUUytPJTon/29otaz1mGHE4Bk7rNsuViq7To63mdNpnj
 2/hDJA4LWrwmw==
Date: Thu, 22 Oct 2026 22:49:51 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, E Shattow <e@freeshell.de>,
 u-boot-spacemit@groups.io
Subject: Re: [PATCH RESEND 0/2] spacemit: k1: SPL robustness for boards
 without a PMIC or SPI NOR
Message-ID: <20261022224951-GKB125937@kernel.org>
References: <cover.1790976767.git.DaveWK225@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790976767.git.DaveWK225@protonmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave,

On 21:32 Fri 02 Oct     , Dave Klotz wrote:
> Resent: the first posting's cover letter went out with the same
> Message-ID as the cover letter of "pci: spacemit: fixes for the K1 PCIe
> host driver", so this series threaded under that one. No changes.
> 
> Two small SPL changes for K1 boards that do not look like the BPI-F3
> and MusePi Pro:
> 
> 1. pmic_init() and nor_early_init() panic when the device tree gives
>    the SPL no PMIC or no SPI controller. A board that boots from eMMC or
>    microSD with its rails already up (the OrangePi R2S and RV2) stops
>    there. Log it and carry on.
> 2. Provide board_boot_order(): the device the BootROM booted from, as
>    detected now, then the other MMC controller and SPI NOR, so an
>    unexpected BootROM path still finds U-Boot.
> 
> Tested on an OrangePi RV2 booting from microSD (no SPI controller in
> the SPL): "No SPI controller", then the SPL loads U-Boot from the card
> through the detected MMC2. The fallback order was not exercised, since
> the detection was right.
> 
> Dave Klotz (2):
>   spacemit: k1: do not require a PMIC or an SPI controller in SPL
>   spacemit: k1: fall back to the other boot devices in SPL
> 
>  board/spacemit/k1/spl.c | 48 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
For the series, with
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
