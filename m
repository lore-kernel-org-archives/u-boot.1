Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C4606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YRajCduL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ig2AUL9m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F538608BF;
	Thu, 22 Oct 2026 11:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ad75yjYs2pcR; Thu, 22 Oct 2026 11:20:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69A7B60884
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792668048;
	b=laYBaYIQz2k0tJcz4Px49Vre29lG6k+PvZRkW2Rkt7ukcMaQNS5//eVfGD3qWzDAhURc
	 gVwvsQoHKYSqYPNpCpyZ4ybFuZvyU5hUtJ0EJtndErxsP4Rap8R05+zEzJUVlb7c3APch
	 HMib6F0wq0bxeaAcj0Khhzhu+faKWK3H1YFrGjKm6Qr6nj2TfRBAPSRP8cpkldDZ5uX5k
	 fl8AS0S4GLb2Gsl4yW5fg3o7dJy+EAzM0j1E4eVKfwJFOkBqOHFxBQHrtDAyNftpU3QL5
	 0d9U+biWjMBkDCbd6KglRJkQq5tFgltsQdeTzqvdVNmQmwkGPhkHEEX5GaaW4w4AHVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792668048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MA+blqzWrP3F7eHH0lMWthugBxe4A5oNRh8t8aWz1b0=;
	b=Hv1EIbCC/yXq8m+gAsjqD3hFkLa4TFKUWHE7qkBvLGgTVxsm8dm+U/CcX8IfnT9CJm3s
	 kYShnKb/Qa6NNN1n74yKNOPHEyOY9WJ2dkMJ87MxLH0WnEFyqJdHvvXiFuJr1k0an48KG
	 V/hEidtgwV8Bksyh7Y07KHk1zoK+jjToXlzNu1gFAOFyTH6jd7n2YEd9VriDFKhCv9DBb
	 lE2N8Hrfi8hlb4RdCITlc75sHqn4JTdon4pfMQwFVf6D1OBafnWbO9Ql8h1TbpdEWKEXJ
	 4P39MjK0tlBSU1LIl02w6xRPhdmgeq0M8SKJaN/1k7q8J8lDCuRjPo4NRJigHukBwWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792668048;
	bh=MA+blqzWrP3F7eHH0lMWthugBxe4A5oNRh8t8aWz1b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YRajCduLGKuMcARszgdvVsDGF/ZfGzc1mxrDcJYo1xCU9Eu/XZR/aN0Ns76ZnP+VI
	 RqPhTRTckyuTYcbfgfQiFRBGlSNII9/tovIZ/1RiMTILu19QpEul9c3lA1YHMh9W7o
	 dd2wViOG7HRazJQybQ96bPzTAvmPNQ1Cdtpt22sQcKu+03gcOgKOrwf45RuTpiaBvt
	 r/8Pa/Vhs4M0MM3h0IjXCSgPDqvwopeKgRV8NNuuVfrqcENjiffhs0jRJhB2QzVt/l
	 uSjns/N0FSAhLbeNiJM94+GMIMWeYuYT14D61rQwshmygelSloSIwmXYpVJTx5lfjX
	 t8kIDX1aS10vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69A7B60884;
	Thu, 22 Oct 2026 11:20:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E50B3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C0148121E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:20:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eOKxPgKwHsPy for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 11:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6D0681201
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792668046;
 b=B5/mCn4B0Qey+kmcpxNH/qQthz3EVlSjTj4edJSaEtG2wziXO/IgAXt8yr0xZgwRwl3T
 1U1/GnRoC/0Zrd1PPc4U2UytqKmY50lk0UZ+Ejr7190340yodKfCcCVnzeprRfW+OK3NN
 dRjGdFkmCeNiGpakI8Jh1U1//z0yCvBR4ftAcqnnISciiGvaBj9SDbd+B+uvjcvjcBcmM
 oByJ+Ruz52LoR2XhVmHgAtjXKNif4gLyhl0m+8TwUHdMJqPy5jQEgNCuJHLwlVfXZEFJ0
 VrDefAkjw52TyBEwR4bd2+nip99qb5jFTN5AYRcCjDXOhnnMtgd9TMTvTAFM9zXOXMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792668046;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=MA+blqzWrP3F7eHH0lMWthugBxe4A5oNRh8t8aWz1b0=;
 b=FVYxt1lN3ZNMs/0TJesRK86VuEzdSaRd9pVJToCeGw6zcztpp3CMYVGFCd0HpBmwifli
 jR/AVWnLokF2etCyvG9w2mzGjRAuxsCWHSZPMkxZn/ey9ptitFjSogKvKYGo1kzQcMnnj
 crIAb7whXsm4KhbpCMk4uUqLJDRko58GGjVzH4xyYUN4r5ELmQVVRzZWyTsCiEVRiqlhn
 n96HbhtA7rarU0O68MjGSbMk1kTHu0Glsw5kGzf9VEP+g9y5No+vizFoEsS5625ZESgM4
 EGflHQP9GdNzNaScKjluavZxdux+k2oUBaKirie5EjKQ9/9qN3erQTBEgW7acjrPZRg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ig2AUL9m; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ig2AUL9m
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6D0681201
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:20:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B92A443D9D;
 Thu, 22 Oct 2026 11:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E1B1F000C1;
 Thu, 22 Oct 2026 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792668044;
 bh=MA+blqzWrP3F7eHH0lMWthugBxe4A5oNRh8t8aWz1b0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ig2AUL9mvtsaxXrxddO/CorjjNyvs31U1XRBchsPtE9LdL+Qo3CgBWh5y3RqgerQh
 7FMxNxLk2MtlggMr4BDNoNzk9vsc7+/2pacQJYbKZ+zpJ/J6jSJ9tg4yeHoc/dh7Cz
 8fQA0KcHBq5vyt9nsd28sIqjR6nvFGP6R6cAvvqtNpw07fcI3XRbbpJdfbv+5ee9Pa
 KFcIzX/dAbeelh/8a4WGAwEXJO+LNGwqrd+yv28IVg8VpAWb2ruqLAEYZiSp7TajEn
 0TtHGsrGFbZcu9qJtAjkqiWSdGquNcdifdCI6+cidODlKFEB1JdTCBirwRe4NylDNv
 qDTSVUfOi5h3A==
Date: Thu, 22 Oct 2026 11:20:41 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/2] Enable SPI NOR flash for SpacemiT K3 in main app
Message-ID: <20261022112041-GKA172196@kernel.org>
References: <20261022103907.1415045-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261022103907.1415045-1-e@freeshell.de>
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

Hi E Shattow,

On 03:38 Thu 22 Oct     , E Shattow wrote:
> Enable SPI Flash command, mtd part names and locations, and store U-Boot
> environment in SPI NOR flash. Selected for Winbond and GigaDevice parts.
> 
> Changes since v2:
> - use Linux v7.3 fsl_qspi_get_name() typical result for mtdparts layout
>   name; this is done for compatibility in the non-default configuration
>   of matching cmdline mtdparts mtd-id when Linux MTD_OF_PARTS is disabled
> 
> E Shattow (2):
>   configs: spacemit: k3: enable spi nor flash in main app
>   configs: spacemit: k3: enable mtdparts in main app
> 
>  configs/spacemit_k3_defconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> 
> base-commit: 903c9578eeb36d72f087082da494c605ddaed3b2
> -- 
> 2.53.0
> 
Thanks for the new version

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
