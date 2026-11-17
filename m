Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263C8606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RsKwLLkq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boshxZvb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA17A80F84;
	Tue, 17 Nov 2026 10:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0cD26py-vOOA; Tue, 17 Nov 2026 10:59:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33C0580F79
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794913185;
	b=pVjod5FVW+soUo+ItxiaWfmOGdHtxLdSucjVrEXZW6E1E6IMeO/v7J1F68w4hEZEPC0Z
	 hmdyXQgi1Qa396ctLOz0Jabhm8oNaBL4Tc6QApA1PpFyetZV2tS4JJQAgM2+t52msxvG9
	 Jx8ILg3dDWLfaGPLONzy1r34lC9QRfK+PFmgkHBssWGy4v3r4V2waCpEEZJiyd62Q0w4I
	 v4yxcpgzzSlUdifFPyKtKZsCTxAHSY9L0ZqrAU47iE+/b/3ZX3cGPaIZmZTfKoE9RrTaE
	 3JAA8KbUSHNOz+Vbkj/2daCp4OpZWlK0rjLS3WbpTo5BZRUN8fs/48BpFV+LgtY5m2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794913185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RVSPQa2RcFjD5XnjnwmpR3joXQulkyWHaHCDsA5HU3E=;
	b=VBxLejwvkTX8/Bi0QOZadfZnCDzykfeZObclxSaWTaRrez3rYg3mMLaL0fN9r7/5QRy/
	 Wo6joRct2QzhvZTIKbQg29UZdFjuAtqhsl5iewlgTVbx+6ZjKXCYetTQvqZcSZO9TCMZO
	 mQyg3T/IXNfGHtJKai+oPetyuLyY/aB6OaMIFLyYhkr1emPXfgI/7F0FhWjdPVt7SXAGQ
	 2AJZZWny3UenTNT8y6iZLV3Y2NPkGlrokwB2qDgflLa4mbltCVtJnnbdwA7zKEDZu7GPH
	 TUUfMb3JeSbTsAu/T+SVIlnV9k3nBheOPDCwDcm8FXw/eZ26j7Xmk+YSzFstDqm7NFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794913185;
	bh=RVSPQa2RcFjD5XnjnwmpR3joXQulkyWHaHCDsA5HU3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RsKwLLkqQuPVlDpECQ16vM+t249AmkzeTlYZourZbyXoToyPtQjkYhjf444E3uoLy
	 lX8i2SBkzbckl95UCu0nHzqlZxwD5+XDK/aGkrtNaILUUdzy3AtxDdYDNnAFs3SFzv
	 gHX+kbP74efZF858b/T7TCZzQqkKQ/lghbXrt5qiBh7TRNTW00mdLQO0c4yLZRHDlj
	 +5x/QslubDM5ZPjVYzOzeCN9oPLPsAG/4Ia2oNG6xPiQI2UUB8HGuLK9qLRaiLp+AH
	 ez1B9d2oX+Vp2DsNdSyKYVVemfyfYyIBUHR0oRxz93grn5CCPtkDCNFvRLMu3iAT4X
	 4hnoB4ZpOWxnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33C0580F79;
	Tue, 17 Nov 2026 10:59:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08AD91E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6EB740308
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q0o7z_ImeF7V for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 10:59:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 41408402CA
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=boshxZvb
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41408402CA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:59:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F16DB6117B;
 Tue, 17 Nov 2026 10:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF3A1F000C4;
 Tue, 17 Nov 2026 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794913180;
 bh=RVSPQa2RcFjD5XnjnwmpR3joXQulkyWHaHCDsA5HU3E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=boshxZvb/ncmDYBNkHL5Tcd+ZNqvKJ09rn/RpIB6yiIbcehcXK88L92uSjz29nWUy
 NFreuF6YfwbjMEH/18GL1RjfrdpvbdVKf8F/BYNSkhzHVZh92eHhZcuVWh4vm8ZtPy
 1GFSDW7GbKzvhfj1RshnMTdwehaSSO+44qoUjDG75xpBfTIDC4PNW06ykAdfnHND9o
 1OqSYx4EBFqlDuTae3GDneUFeDdCDaI5OZTn5kQTAIAKYNR2fhylgt7/WewJKPsVbg
 GRXK3Nu0DjBC135GDo+qA4Y8hJ+4JdwKCAcsV/vSezFbZaHEf3dh3zMewSFn9AZyBz
 wte6UHB+0s38A==
Date: Tue, 17 Nov 2026 10:59:38 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: spacemit: k1: add Hung-Chun Tseng as reviewer
Message-ID: <20261117105938-GKE100890@kernel.org>
References: <20261117003237.3090023-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117003237.3090023-1-alan.tseng.cs@gmail.com>
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

Hi Hung-Chun Tseng,

On 08:32 Tue 17 Nov     , Hung-Chun Tseng wrote:
> I test K1 patches on a Milk-V Jupiter and would like to help review
> them.
> 
Avoid using first-person grammer? prefer imperative mood, I think U-Boot
follow similar rule as Linux Kernel or check doc/develop/sending_patches.rst

You can adjust as something like:

Add Hung-Chun Tseng as reviewer for SpacemiT K1 SoC.. blah..

> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
> Applies on top of "MAINTAINERS: spacemit: k1: drop Huan Zhou".
> 
>  board/spacemit/k1/MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
> index 93a5aa6677a..3fd97fb6ffd 100644
> --- a/board/spacemit/k1/MAINTAINERS
> +++ b/board/spacemit/k1/MAINTAINERS
> @@ -1,5 +1,6 @@
>  BananaPi F3
>  M:	Eric Chung <eric.chung@riscstar.com>
> +R:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
>  L:	u-boot-spacemit@groups.io
>  S:	Maintained
>  F:	arch/riscv/dts/k1-*-u-boot.dtsi
> 
> base-commit: 83b1ec64ede9998566e6a82b22848c20a33f4aff
> prerequisite-patch-id: 974bda77e7d5815be9f750da8c47c9d5cd1eb15a
> -- 
> 2.56.1
> 

-- 
Yixun Lan (dlan)
