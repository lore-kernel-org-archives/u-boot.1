Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BD6070CA4
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j0htSSas;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=hn2cu3mr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6937607C0;
	Mon,  2 Nov 2026 15:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wav9_G8uVuDr; Mon,  2 Nov 2026 15:25:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA62460669
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633135;
	b=Uyq/DHhjTFe/BCqffqLeIo8B3nWe4f8QfrJmERi2sNRbE4cyg8ToD/MPPJjtLh+iSmO5
	 QhTCrxVLnMqwrEQL7rcAKhXF+qs2spuZS5cSPp2YejPTZ6yb1cDWIUgS8GizF/RWmB/6r
	 Kzs77X9XjmccX0lw78RovJw1Ce7gXt99jYoPv8RyXbooGNvBZGFBjt/KuBiY+Dr5BPJpB
	 kKuzw72CxYvVAn0bL/m0vrrHC+wIj9Sx6yM6X+PWvuezaV3GIvtRvon6BUw6+PMHctYfr
	 s2zKq7GDS0/JviPQcVGHV/FHyawR+Usl3sQqT6BoVI18nCO8mhP1jI6bzLZ+OhwGeGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633135;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ej6Pz64qodmJ8TCkVqapG5Wu9aJPJr9LgY5i73NGh4w=;
	b=Dk7NOtXKBnnWOPc8QMf1Iv9eSVTj5ytIEacKeevBpTUIrksgNPydJvOTyQByB1T+jAcH
	 as1c2OPqtw9IKAVEk0aziE6SeYLCJy63uI57XGAT3PIcK9EN+iw+ay+U0h69+kQ6ewZ6w
	 QCPAHRbJOZmJK2GeedzAT1/c8hgOjrsUx3WjGWh7JzFx8nH7wXYnNK6NUKeEVc3/Q8+Zq
	 SygjM4obmH8e1Ifjfer6+440TUBKQEq60YPQlZU51k+U7/iU1ZInGbJZxetr2g5FQS7zA
	 4ldxDEeXpW6qHNswrMOncCx+rRqebEvzpXJICSZMLyj1kUnTk+LbtJIP4GaEf8NByEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793633135;
	bh=ej6Pz64qodmJ8TCkVqapG5Wu9aJPJr9LgY5i73NGh4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0htSSasoJUyHqnIfJ0pi1PzKIGUraLwWftxEJ5U9ezAmcwSjAFKd4ehI3D7BHK/u
	 XsMYdPE8k1l+Hdl2QbZdi5mTMBPN30i+f+S7PqAnEJHyer/dVJp+0C1rhTowDaR6O/
	 +qZt3FTzYkB3BahYNdFW7B9wEVIh5Ir9FHemt81X6gUZyWse+lMhEyfwUrZx8rSkNK
	 nCvNjt6Sdezk3unLz3pE6bZ7K8Llu4fZpU/DW6AcEGtgCtEQDvGI3t/JwfaeJGfwD4
	 Y1pdI4PUuqSRu8idt8GHT6MmxND+l0zPT5fsaqoYNsTYu2/4SU73OnNP7sXAmTf88V
	 0cM9ldWBg8TlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA62460669;
	Mon,  2 Nov 2026 15:25:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7A7E411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C910940685
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:25:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5TTi9lLtDBV for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:25:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8154D40661
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793633133;
 b=tKakH2J1FmYlItehEcMgNOzGK6gSIxdI6eJyYCPjvlhcjJwxx/wOqw9/rboqgVj1g6Rj
 nUjhjHmehkZNYsGEG9RV9ga0khFW6l8Ijd1rJnGvBXVfkL9q/QIzNW6+L8gv7mdqK08Z8
 H6pHiG5DBl4l5ZmxGReKy17O2HS0q36mVV9TbcD0B8ArPIqNgUMITSS5xkNNsVB/ap7Up
 vLDub2khXTejw2+2PV+AJ3+SGzOO/KTP6V3Tt7a9sTV2Gn3HS/NSUyWbgPmDsYU6gQYkU
 C0PXfONx8V7wdgupjpPBo3HmmwAWPN/qSSh/la48N0xOMacRZ2GfAWnR5wTwOSaX7Yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633133;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=ej6Pz64qodmJ8TCkVqapG5Wu9aJPJr9LgY5i73NGh4w=;
 b=l1hGjVc7pm/EpzVO1hK4gPQnUh1YVwjibQcHOLurZCbtIAsRntk5tOEhcSag+8MSGZ7p
 DVs/psoAK7RaxhNBiPUNsfTrOd0lYUw1oeEevKLMmjccKs6jJ3DXTyy77898rY01uVSjB
 UeV5ZGFi6erPICg5BTxWPkesXwxNMGeBCdlw42Wvji8U18wUtfkMBGRJ08Lqlt6QhZcoe
 4PMBBFjLpR+UoLncNBxE8V2zCDXpZDQdC0PhCw2+XOEM4Y37pMnqq0xASmqDtFnkHjeFq
 CXkbDj/WpIiI/soROHXEbB7MGEHd/L21WXlfFh6aB11sd4d0JHXlUPWw0T0sF9JeVbQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=hn2cu3mr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=hn2cu3mr
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8154D40661
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:25:32 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3acb512a7a0so1965893a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793633131; x=1794237931;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ej6Pz64qodmJ8TCkVqapG5Wu9aJPJr9LgY5i73NGh4w=;
 b=hn2cu3mrqWGGUr/wh83uLBVQcUhOYtjIWyh0I9tv5pA/osxoyckneTOh/pgEGS5IXO
 POwYOBW8bW7R26iMxH3NyUMrWzzdHBmzDj1Jvh6G2g6axJjegjGOgqymYbYkXWzp7MSI
 Ls3P1hAUHHAH4ZXVGAS3kV6Z+VxAJiI5XDL/D8nZP63HN5dXdjO5SaWRR9NXZItpIETx
 yw7+Wd39pVSVjaNc1HEFSGDZSGT1RDHD2W3+ZBxm7NSzSSBzQkmAVnprgeNH2xiCjPf7
 TmxTkbuOGP45dkZC6u2MlaNfcB52prREyXTMqLnvONzHMLoc9ZtK35orZaa6C+sybE5/
 Y2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793633131; x=1794237931;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ej6Pz64qodmJ8TCkVqapG5Wu9aJPJr9LgY5i73NGh4w=;
 b=XbsBvW5ux7l2dH09JHgkjPsGr5SbAa+M0M5uLJPSnE11IzUevdndDZLylmdlBIpGVs
 uFJ/k00ZzHqH/jPG0PZnB+UVtgE8f723Oi9oWlJ8LqgurGkLg97Z52scor/OZSmZrtc3
 chcMAa0xJb1o3rni8FkSOc5hcm6/KygOS6eKIYfKhnEo6jO07GerRDB5jBCQXrU8yPbG
 ei/kFqPD5yuo1HTeVzuGIZrg+vgQwg03nS87oISZeht/K6N0UW3IKTO/clwP9+71KAnF
 MnQV4KzX9PUBbroK0SAY1JC3WjL0rq1ia642G/YAfkL3X81JQMiI9l19VBcng8r663Ul
 7CsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGKb+9+8bBvU9F41+nmbv3Ef+ThKpq4q48iSwFEpGl37Z+/6e418e8OETW4r/zX96M/d8H4oM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/PLGROXiH41cJm6oJZ42tvQT9d7NzlSeSEoLfgp342Ms7RAU6p
 1keh4Fq+7PAOcOqii90FI7ws1DZHrmXXSb5Ed1sATfFRfMHSJ+eUqIlttAVujC5kJZA=
X-Gm-Gg: AYBFou386W8IsAB2s7Ir5az1Sf9DDdKfdsSLn10l20HZiBdpxAze028BpF56PYBIYMq
 8EoKefdnkOSNfYOs27cRqn+1F7kd3bPnHqUMo3wY2EmiNqaIuCzoh85sNjz/DrMDGuKe95hv3vp
 jJfnqHoE+x473lMsZ8TQAhcJ2dvW8xx0bOkVEeI4S7l0mNy5TKJmqEfC8RvjaHZ6ZTFNVOhSpUk
 0jDe/qjKwPFTGbT1ylCkvA7bPNL6uio3S0DM78sjPJ6XjQzgXgKbysxhmmopqScjoDBSIPQrmcg
 2cWrEDFptXoPf5JZeMCUYyNYneKb026rXb7l/xseltywqFjKMDRkyg77BP4ntkTkL6oFg0CDmCS
 M5ioyHRLCLVyG9hn1LLKXz0N4Ff76f4MLFVkOhrMvX/qtt4RtDJQ/GJn8WC5xPvFGb2Fl1ppGCG
 ez/6NjDJ0IT/WWG+iAIK0+Qg6RzUH259WPFe/GmcmUHJRfwAprpZIoIJfUSmsNIZD76R1F3zjtj
 NNdlz6decoWKZPknjpNP8XMwFMAOWF0eXvXpTPgKRLS8WZoBNk5obxJOd01wzkmvysKItlvpTOu
 K2HeYoNzPwPGISGXReRov6sWwk/fn1YRzfy+JBsvFrKS
X-Received: by 2002:a17:90b:35ca:b0:3ab:3675:8ed with SMTP id
 98e67ed59e1d1-3ae8970ef4amr8660880a91.22.1793633131420; 
 Mon, 02 Nov 2026 07:25:31 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9426ffsm19613826a91.7.2026.11.02.07.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:25:30 -0800 (PST)
Date: Mon, 2 Nov 2026 23:25:28 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] iommu: Add RISC-V IOMMU driver
Message-ID: <auiraMrMlNYuwRzo@lliang-1876.localdomain>
References: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Aug 25, 2026 at 11:42:46AM -0500, Anirudh Srinivasan wrote:
> Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> specification. This driver sets up the IOMMU in bare mode so that
> peripherals requiring DMA in U-Boot can function.
> 
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
> ---
> Changes in v2:
> - Changed DDTP read timeout to 3s from 10s
> - Link to v1: https://patch.msgid.link/20260803-riscv_iommu-v1-1-793cfa421ab2@oss.tenstorrent.com
> ---
> Hi,
> 
> This is a pre-requisite for U-Boot on Tenstorrent Atlantis. On this
> platform, the IOMMU comes up in Off mode at boot, so this is needed for
> SD and NVME boot to work in U-Boot.
> ---
>  MAINTAINERS                 |  1 +

Hi Anirudh,

The change you made in the MAINTAINERS is already managed after
Yao's patch (https://patchwork.ozlabs.org/project/uboot/patch/20260908221740.27927-2-me@ziyao.cc/) is applied.
I will remove it on my side.
Thanks again for the patch.

Best regards,
Leo

>  drivers/iommu/Kconfig       |  8 +++++
>  drivers/iommu/Makefile      |  1 +
>  drivers/iommu/riscv_iommu.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 92 insertions(+)
> 
> ...
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 289a45f47bb..a7b9e78cd79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1583,6 +1583,7 @@ F:	arch/riscv/
>  F:	cmd/riscv/
>  F:	doc/arch/riscv.rst
>  F:	doc/usage/sbi.rst
> +F:	drivers/iommu/riscv_iommu.c
>  F:	drivers/sysreset/sysreset_sbi.c
>  F:	drivers/timer/andes_plmt_timer.c
>  F:	drivers/timer/riscv_aclint_timer.c
