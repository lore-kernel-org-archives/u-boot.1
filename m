Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA47606A338
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZrVTU1be;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjeO+rkH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36F0E6085E;
	Wed, 18 Nov 2026 07:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6OVf0xldwIP; Wed, 18 Nov 2026 07:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 818F26081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794988479;
	b=NFlSbe7x7YmpmIfkTx8NMiGZ1ZLNAI8bt5zSZgrsDsMSSHJ/cuZV2ACTaU2+RlJKgj9B
	 ckkcyAkq9KoX/wg8Ica8WDP/lQxbd8deUoZwZF/Q1KUOTrz44fw2ZxdinCoA/PoeMzkCQ
	 UQmDzIJItP4de7gKPRe3SFKsiAGdI7SrO/+lMaMKgMQHSrVWM9NrAQ0yWnMg/EpeQJaNl
	 EcVPhLQANLriWP/ggVvDNXlazSsEzTBGxpLM5SaxQiVlaXGunVaLLqZBt4USmwIA+dPEd
	 yOAmQowaCETruYbLXnaTfr6mO5ca+IWiBXSF8JAJBmBen+Vw/j+OXs1AY/WrNlHYFiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794988479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RZ8mxSisN2keOTiPQSYb1H0gFfE6U0v5Pmc4bBRNUqM=;
	b=pPP/kbPeyj1dJM0tHVyzQlMROERpfbQjpXj6J8ElgpZYiBwt4aktvMguWwyy97FLMdRD
	 u+N74cYeNU90dlDSafnJIaftnf95X/MahCu8E86fi5ZxocZlbhIRyBRVYXaBBrDJtDElT
	 q94755yivvYjuGwVRbjpB/eKup+qRmxYm7binduOt0tEgiDyBGbK9E7gCsAoM6inqj1HS
	 scsKTYWcMrKr6dkPHke+j5NTWyeO+D+WSU/xrxwJHYwdHutINfWTS29aSMVx3CHXk12aJ
	 NKGoqoPN42XrL7ifsM9LQIBQtelBwpHvqdSR+2heMAC3sK6c9Om6mku8X0B5PLqTQ3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794988479;
	bh=RZ8mxSisN2keOTiPQSYb1H0gFfE6U0v5Pmc4bBRNUqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZrVTU1beR54hj+7P5GD6nV9oRBpU++C5mKAcYCumiF4HvXKqR3mgatvSJ7EHGSp+4
	 rXagjnRBn62EVuugsALhjmxfTbW/+eFUDbn6TRlB3lGC7Wc9mOBns/5HTwpmgqBFUK
	 nGFluEzD2wc+OQtRmNP2veTJOPADSzRccN2mWUXLIwb4/ihGxcmva9vMEPK9ONA9Ee
	 PkN+JkW/H19cDMuiYjAjBEDxjIjE1Gw8lzNsPPnaN5bXiMW8gAcq+ML7CkkeIPmHEo
	 UeYMSbmA3B09zPM1/Lr2czoDY+ouwI+q8okQwzsPlfpPrv/kxyhlg6JPnMNj1mU9nU
	 ZA5QPzsX4c+cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 818F26081A;
	Wed, 18 Nov 2026 07:54:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0534A49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB5E580E5F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eHEEWy6gFjZJ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 07:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C03780D7D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AjeO+rkH
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C03780D7D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:54:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31B226127D;
 Wed, 18 Nov 2026 07:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F1D1F000C4;
 Wed, 18 Nov 2026 07:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794988475;
 bh=RZ8mxSisN2keOTiPQSYb1H0gFfE6U0v5Pmc4bBRNUqM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AjeO+rkHLK7xERS9jpjT9P8fwYm9rPnzrmKF/FXOaiw3539sD4LjX+x8QFi+frLWS
 7n6hA4bgtgG6C48Eww3OT2zIa5Mu/cXbjDfD+Jv5mZJxftBKuhnATv4RiOWvGTYkgy
 J0xHewhx/lbC+TEQ6wbnsaXRkTpjrWqpZw7eDmuzVpCGQp1UtRtSUHJMuS7wB7S/XN
 YyTqSuJ2pbW+G6uU2hQEwdLKlsW82/q2GAY8yE1bt+YNZZgtq2KFI44P/YKoIZav11
 SOE4JqYGQorGUqTDXXQtQR2t3k5p5TYG860c1537pQs9wJu/heMqLsMwYKu5ZNyWpv
 HQIlLVurbbsug==
Date: Wed, 18 Nov 2026 07:54:31 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 2/2] configs: spacemit_k1: Enable onboard USB hub
 support
Message-ID: <20261118075431-GKG100890@kernel.org>
References: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
 <20261113031613.435429-3-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113031613.435429-3-alan.tseng.cs@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11:16 Fri 13 Nov     , Hung-Chun Tseng wrote:
> The Milk-V Jupiter and the Banana Pi BPI-F3 need the VL817 hub to be
> powered and taken out of reset before their USB ports work.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
>  configs/spacemit_k1_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> index b8f777e89..31e429c03 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -117,4 +117,5 @@ CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_STORAGE=y
> +CONFIG_USB_ONBOARD_HUB=y
>  CONFIG_SPL_LIB_RATIONAL=y
> -- 
> 2.56.1
> 

-- 
Yixun Lan (dlan)
