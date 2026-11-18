Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA36606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pFkzvPgH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmHuVwnd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED0B340822;
	Wed, 18 Nov 2026 05:57:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rIDHXb46YdY2; Wed, 18 Nov 2026 05:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3662E40812
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794981445;
	b=prjJz+Y5myl85FDLSEPVYDCv6EH2CkhE0GE/6im9yByb9sL+zIqpZIjelEnLJEjWyw7W
	 VrYRig+dEXoG05y+LJ/2ecnyLblO3Vr13eEmkU9JjKBszm4heRul4k1GFJD6zZ4MhZipF
	 u/Re+sTxGp0yMZTgIS3DuTK9dUta3Nyhk/jfTtaZxB/ZTP/XIE8U4U5lYgII4Vr7ZyD7p
	 qUh/tjbHRhqo2TiXlZtLSH9Fhv2tFozrwqNsN5rSKP7eOLDuwiBz1VQIPJK99XgOgypwU
	 sSxVpmtFC5usg30hAVviLwowvFfp/TXOdozkj4BXVT8SRGyW1RPiRP61KNhpm9zz3EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794981445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XYHhnSZFx73zy+RFB/zdeZINRzvj4UzB6Bm/Sqt93KU=;
	b=W3JUad61rXkpS7838sD4Vj1JAPYO3hhLxjdBlnpKs6osH7NDpQpM6QnLETq4kGwr17Cn
	 18w1yziZ9cEjx4iZEa4aejjwgqp6eAQXhjXzXkTchIpRNptNYZF7bOqJm8uLyYz2z+tlR
	 tAL8SerKmbYWlWVHQpsH1Byd7Qr2ne5pCVeQRWrVxEVYDUscJeZ9vpcxiNwEBjEdEfZgb
	 0tAb08jDZw1TcGkSD1S034foTdQY05v8t6E1argprdAPW9KK821XL6xogs/yc473+GBkf
	 tTv4ESOeLKYq8Q5fzfqNsiJl3pSlo4LsyTHFP5kjgwHiy88R9ylx0qPzYXsMS8qP91g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmHuVwnd;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794981445;
	bh=XYHhnSZFx73zy+RFB/zdeZINRzvj4UzB6Bm/Sqt93KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pFkzvPgHaCoAJftppDMo/1BO+Fz9NGwWNv4pmaF21G4Fjws7JI12mcB/HPCKNKONS
	 BjvGr7HolsyGMil6ZCo1RINI3c06FG4Vu6+fw05lsrq8d91AnoP/5dVxVL0qXN2ccR
	 6t6mJFl5CdIePFzf3VVOH7djXdNQ9vH5Tn8umZEmuJHqCp4yC40GLaITqkxN0M0/AM
	 EdITKzbVKMoBPAvDLYDG40uV/dLI1zJwb2Jf6BPUNltZVG1HqZvxIT+leb1uHkVIt7
	 HqMXPgMtvJCzhfvRw8YvDZpZ2EfIdJq3bOE2pDOPncGHj95pGkvTBG2ZEGLm1V2vMm
	 ZbvwnLKY+FFuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3662E40812;
	Wed, 18 Nov 2026 05:57:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53BEAA32
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44CBC40812
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kwC9Itv_3gzi for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8FD1340811
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hmHuVwnd
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FD1340811
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:57:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81E8B45560;
 Wed, 18 Nov 2026 05:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43521F000C5;
 Wed, 18 Nov 2026 05:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794981440;
 bh=XYHhnSZFx73zy+RFB/zdeZINRzvj4UzB6Bm/Sqt93KU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hmHuVwndYaZ8ToIu24UsGOQjI7nSa46GezNW/pHDszDxbbfFZzawO61SSf8PkxS42
 Pmt4K/7//KYkEmeVbcqkA6BPEHZJM+dJz2FqXu5mkz4zkNJFGZ1FhkzsUuB4F8fku8
 YBhGU2UScM8PdzIMSQEiUUWaPTmXWqh+Be0ok3w5DGhh+QixTQD2dX0u/8ESCmwage
 l7llE1T5t9AmZRWtq1Kfxlbwl0VWvSxM5u5GQsPcSpnYjVPalmERT1PQmfRpl/aPVq
 Po3zDHd9dadClOV6HdFWWsgQY0pyio2lY6qInyluKGHD0u3JMOZvjn9r2wmeCPpgW/
 w0MEeBIc+MGrg==
Date: Wed, 18 Nov 2026 05:57:18 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v2] MAINTAINERS: spacemit: k1: add Hung-Chun Tseng as
 reviewer
Message-ID: <20261118055718-GKF100890@kernel.org>
References: <20261117003237.3090023-1-alan.tseng.cs@gmail.com>
 <20261117231200.3699482-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117231200.3699482-1-alan.tseng.cs@gmail.com>
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

On 07:12 Wed 18 Nov     , Hung-Chun Tseng wrote:
> Add Hung-Chun Tseng as reviewer for the SpacemiT K1 board support, to
> help review K1 patches and test them on a Milk-V Jupiter.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Acked-by: Yixun Lan <dlan@kernel.org>

> ---
> Applies on top of "MAINTAINERS: spacemit: k1: drop Huan Zhou".
> 
> Changes in v2:
> - reword the commit message in imperative mood (Yixun)
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
> -- 
> 2.56.1
> 

-- 
Yixun Lan (dlan)
