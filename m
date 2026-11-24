Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADA606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=izxe0d+t;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8D4WhTk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F333260807;
	Tue, 24 Nov 2026 10:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bu-c7x6t9vw8; Tue, 24 Nov 2026 10:52:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF48D60809
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795517570;
	b=FOCtCTlr8IWJGagcMof0hk0C7QM1r4aj7YNDioriTBzImyDRy8VpqCzWT9aLJ0o7OmzF
	 RO4kbypSMq1etR04yAHsOMt7DBUr5MltDv5Ub6lST8bOLb0l2SPOTzoLxa5eFUAwb6WEd
	 nr4O+U5+P8dPI7M3zw1SFwoVdjsv8/h7Gcn/kgrSEP4+cgSbuywbqPg0olq7CbkvtGhD6
	 A+owAwrgS1U58K+7H8sdkwwXAigczYCo92VES9u2pvlaFR512K9lFnZL1z1IWwvv3YHL7
	 5sqHEz+ljLqLEcWcbQEzh+Wtrk+G3v3gM59Q6edyOtnKyjUzfh7LH+WBna04m/tOSAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795517570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/i95ylMWvLDRVU3N8LY7pgNbL3uMJ4R8u+T11czMsv0=;
	b=dk/SFp0pZYgX3EhrHPYaXHJQ6Aj+HI946/aLEiCosHOQQL3V9TUvhpwMcQgqDoZGokNH
	 zW1B6dReeOkF/aWG+k1UG2m8InFN821KBKaQe9nubWb3x3UFmY8LezlESsOOydLviYwCW
	 pxwm5dC0H8kIfGdqD0Xb6X35bKa/H5mr6cxYlS6DQu3woO7MxFnuT8xKkNSbmedIsruPW
	 Ow63ZCcPIBY+M+4+Zo/mUmI7vSOBxXCHocLXlqJVusNzjVH3ahKOszExSXhwNRl4UItEV
	 f4g2sz6zCnuVDo/8cQB8j9RwTAFb6UnFqAnv1/7+iljpJ+By3RzXt/IFu5FQEJjdYvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795517570;
	bh=/i95ylMWvLDRVU3N8LY7pgNbL3uMJ4R8u+T11czMsv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izxe0d+t1r05Dmsfq+hcvd6vX2OQB8kbrrEuFRMOU7ipjfHuNoEr8vnHKSapjQy1C
	 4p1WN422iWqKpSyp71gvf/ML1QVfWhu9tunAOXdK7R9dtnOBWyLCr/nmMY8hnw2lTk
	 MkbvbbdRjNaGcAT7wEeWJbuYzIrxtqnbU9SLTnV7fU94TmmOnEDT8EP+if86DWd6OV
	 DPamAkJrjEh5IolJzrCvi4c48PomsRlfBLWYLGlwhGPVMI5K6OO8GAZTsQjpy0CBEH
	 aYHaFjzsnOSFCJ05mqfRehAASXlip1KmobyPsNdTLnQ6r0Wr6BUWu9BelIkSp2urmU
	 7nrpSjUqgRD4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF48D60809;
	Tue, 24 Nov 2026 10:52:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D53D43A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB82080F6C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1mNrsDeUsaQ for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26DAB80F66
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=I8D4WhTk
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26DAB80F66
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:52:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 034F643B97;
 Tue, 24 Nov 2026 10:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C1B1F000C6;
 Tue, 24 Nov 2026 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795517565;
 bh=/i95ylMWvLDRVU3N8LY7pgNbL3uMJ4R8u+T11czMsv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=I8D4WhTkluLw9dfXWpK/hF8hB5g4goVmHmIdewzngcgntP/oTkLi5Qr0Qd8e5lkUJ
 cwo7lRzoF/z14/bMWPVNSqlyQ1o89QyWcuUP7t1tO/vjHuGjzY0AllKSwEWFaRNZRp
 YMtJRcYS/xhLnPnSc4z56ZyrWD83FXfZUsrWgGGB8eNGuQn+RQXBE1+vmgH8wD1Ado
 iu77+tg5LHJy+nU3gSkDmGG+mNl/Wg2mUtjfIxMYPLmpoVq2CNuUcW7sSg3c6ufeIb
 q2cuc/jYthrRzRRgqDcWmv90YGiw/W5odj5iiAMaBZfJHFgOUwKcq6Yu8uAFmfSOaD
 kesz25u5REjSQ==
Date: Tue, 24 Nov 2026 10:52:43 +0000
From: Yixun Lan <dlan@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 4/6] pinctrl: spacemit: Add SPL support for K1/K3
 pinctrl driver
Message-ID: <20261124105243-GKI100890@kernel.org>
References: <20261123193714.5096-1-linux.amoon@gmail.com>
 <20261123193714.5096-5-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261123193714.5096-5-linux.amoon@gmail.com>
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

On 19:37 Mon 23 Nov     , Anand Moon wrote:
> Add a Kconfig option to enable the SpacemiT K1/K3 pinctrl driver
> in SPL, allowing pin multiplexing and pin configuration during
> early board initialization.
> 
..
> Depend on SPL_PINCTRL instead of SPL_DM_GPIO, as pinctrl support
> does not require the GPIO subsystem.
> 
Not put above into commit message, but should in Changelog..

> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Otherwise, Looks good
Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
>  drivers/pinctrl/spacemit/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
> index 87cba336923..ad5b458480a 100644
> --- a/drivers/pinctrl/spacemit/Kconfig
> +++ b/drivers/pinctrl/spacemit/Kconfig
> @@ -7,3 +7,11 @@ config PINCTRL_SPACEMIT_K1
>  	  The driver is controlled by a device tree node which contains both
>  	  the GPIO definitions and pin control functions for each available
>  	  multiplex function.
> +
> +config SPL_PINCTRL_SPACEMIT_K1
> +	bool "SpacemiT K1/K3 pinctrl driver in SPL"
> +	depends on SPL_PINCTRL && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
> +	select PINCTRL_SPACEMIT_K1
> +	help
> +	  Enable the SpacemiT K1/K3 pinctrl driver in SPL to configure
> +	  pin multiplexing and pin settings during early initialization.
> -- 
> 2.56.1
> 

-- 
Yixun Lan (dlan)
