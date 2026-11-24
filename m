Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA9606A330
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tMRNkEUu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vt3+F+fS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97A426086C;
	Tue, 24 Nov 2026 10:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 47yHUG_bXwUT; Tue, 24 Nov 2026 10:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 366BB6088C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795517660;
	b=U1VD7TCLOxUgdCKrJeORfbZbYBTdP4UxckYysadUhs8M1T9gprAXeEdf1IHxwl8rYB/m
	 G/UjDLRLFnaxMmLgssuWDpxtUlEA052RpMlz1KmV2XNoN3Gt4NqMprg3y1kCLzS1NbYmr
	 UHb3jeqh3sX7gnkEi5InCQvO75fs0Z+rQ+Rw2IypzQaFnFAVuNdTX7Q4MQNrMqG5RMfJA
	 hkxDeBXwchoIEprCPaBsrriORHyzTEbwmlImAdTgzczjdMRwsGSq8oe6hewx3m5taWeCW
	 ob13N9Mq/whvzOLK6dfCgFLYczxwnedJMhxW1De+Aaa2rDDj14wHicKbLoOx6Sidd5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795517660;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WOv0EOM+N830gNEo6lyXiCgDlN7tB979nBF+uJT/Y98=;
	b=slJfPKRkx980ipIMiDQOzwfF5ZkD6Dxib5evz6ARks/PnnGSoskHx+kJThHUT5YFmka9
	 2MhaZt6qsMmEIh1URfmCS9UHQYKDxZNiKwuCbtu+EbPDiGNEtbjNPKm91byuAAu2CCL6L
	 CytsQjZWqfEUljZDwcRmQldf8l+iWN1ULXthbLc0ulPa93im+0rJA/NOBjwno1+hpR3Du
	 95/ysUGiAHybwGDvnWn27u6l2Pdgty16StJrkJhcRJ/otRu9ogR6kckRyDGROCkrvJspg
	 xLi8khA8GGTgx/YxRJUqQimhl0ukUWsDgAqT8sqSGVhkO1qVk9VaoC4cL7w1tUf6WsA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795517660;
	bh=WOv0EOM+N830gNEo6lyXiCgDlN7tB979nBF+uJT/Y98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tMRNkEUuoDmFh1zaWmWE29eFoUBEvFS6BONpN6RiafPPJeIiknZdk7rCgGBYgbjwA
	 uZYM+yU/cSNN0ffUedrBiRoM/Q52inFo77yZexzVDORwDmLolNSJCABjQzT5C4vd2c
	 k6fpRaq/81pxiClTLVusqK+lBjyzpHQO0OMULTihPndbCCm8FeTHqpY8MPC/F7ghlI
	 aetTQvUjIAJEDh3Bxiffym0EPwjACD5roAJ6nyBRYMpnaT/XyimbZHnvq7lhnKIiOK
	 GQxoghYGD3BHjSeEkMMtqZyBe+La5lA9NOFn3W1tb73WmWcJ1nsQSgG7z3/HWcNCQS
	 kL/XVjjI7DkLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 366BB6088C;
	Tue, 24 Nov 2026 10:54:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EBD1F3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFD388104B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwAAKVr3bfBH for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:54:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93CA880F8B
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Vt3+F+fS
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93CA880F8B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:53:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FF5C6257F;
 Tue, 24 Nov 2026 10:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADD71F000C4;
 Tue, 24 Nov 2026 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795517630;
 bh=WOv0EOM+N830gNEo6lyXiCgDlN7tB979nBF+uJT/Y98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Vt3+F+fSy388sUk7GKoH5QPEgrCsRw4iTcvh+Z8f1y1hDTLK7pUL70SXYsIqRvSC1
 NYtslyUlfq1zynuSa0AvR8m2cR33FzOq+U7mIxgzlxRVartLY1G8RulRIZ60i+QH/Q
 mWyib5tp4JYAgIw2h0N1/Dr6hlOeVHGgjj19KcAh2yZzz93uBiLNbF2n+v8ZX8oPJO
 HXObm+eeEaHoQUB6QbVmFgMXs0ERcFux8IMnqq/st8+2z0t7zHHTBkJWKFrk2jp0DQ
 FsoQhXaiRSivWCa87yk/gsyy7GwvO/kC6UBwUh9RU3HzmWvQ3iQLXJ2d/iAro38pLd
 Q0vCTEFQxhsqg==
Date: Tue, 24 Nov 2026 10:53:47 +0000
From: Yixun Lan <dlan@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v2 5/6] gpio: spacemit: Add SPL support for K1/K3 GPIO
 driver
Message-ID: <20261124105347-GKJ100890@kernel.org>
References: <20261123193714.5096-1-linux.amoon@gmail.com>
 <20261123193714.5096-6-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261123193714.5096-6-linux.amoon@gmail.com>
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

hi Anand,

On 19:37 Mon 23 Nov     , Anand Moon wrote:
> Allow SPL to access GPIOs on SpacemiT K1 and K3 platforms during
> early board initialization, including GPIO-based card detection
> for SD controllers.
> 
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
>  drivers/gpio/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 7f12e39dad8..ac7bd642cf6 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -457,6 +457,13 @@ config SPACEMIT_GPIO
>  	  arranged into a number of banks (different for each SoC type) each
>  	  with 32 GPIOs.
>  
> +config SPL_SPACEMIT_GPIO
> +	bool "SpacemiT GPIO driver in SPL"
> +	depends on SPL_DM_GPIO && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
> +	select SPACEMIT_GPIO
> +	help
> +	  Enable the SpacemiT GPIO driver in SPL to provide GPIO
> +	  access during early board initialization.
>  
>  config SUNXI_GPIO
>  	bool "Allwinner GPIO driver"
> -- 
> 2.56.1
> 

-- 
Yixun Lan (dlan)
