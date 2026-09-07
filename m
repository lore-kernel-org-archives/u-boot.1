Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEC1C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9483440566;
	Mon,  7 Sep 2026 08:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dY08okRYqAHU; Mon,  7 Sep 2026 08:29:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E0C224055B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788769766;
	b=lfSQkqWmnIOv8wfQAC+hZEPNxh/jTpdtfLHJ40QDQbki2FkrVH/aQ0Rjd2DuOdreU4go
	 HSra6gYLhqK7N54/LG8Ca0Q8ocyql7qLPJVx1Y5jMAI7UFEhWJzc2T8HzuHrOwJ4WmGmb
	 NLyGHJ7Zr7oY8KXcZG0Onymv7P//aMoQgWwXo8PZRXJWCE6pTEgH4A6TOqDyafnzNUeac
	 pzI7fVDi7g77rw6dn3Ev8wqmpUT7b0Pypj1Kz6esAz+2U4uykXnhW0Vqu1qoW0ZIxEjfj
	 3yBXcmhvq2FrlqYjayZFVpWCZ06TP9xpVE/SPbJvfV4Y1aHabrLQR4KS+mjCvJJ6r5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788769766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3Aw3DQ4th/dg/H2kPEAVFMNXIEUkx8Nn9v4M8L+VgIc=;
	b=eUe94UUIMN2oNzb3+9if7jPEFzN7Yu41VrcProGMuPvRVN51YEeS3aOGRtLgI9b+jcVl
	 ndwe8VH075znrQFQXgXCgFzUB9q/97TyInIiUqlxbugGf/okxV8lfBNztnjPbGDb/x0yA
	 VMvWtUJoMluIaDLcUZIAnSfoi8zicaXDFFeZF6xtL7vZvGP6q++V11X/du/KixoKPJJCf
	 bPxRmCzN7uZSsdSMw7Kv5yVSUuFsq0llM7sWEc51Fc6zM69Psv44vyhr/SKc/nwx8neYE
	 huaoyx1c0+FG33UIhWSkqyHuky1AekZyrE4WybgZ37yiCnzX5f6btGtfjAOX2q0HcpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItCYyJsB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788769766;
	bh=3Aw3DQ4th/dg/H2kPEAVFMNXIEUkx8Nn9v4M8L+VgIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LxCgH3pu1H3a98T+SiKv35y4/Y/Hlzo76TKMWyIV0armWbaMuvYN5ZT6qLjnG1KQm
	 B/mWhh6FoZVjR6t0GtKEaADiXmWhkptzAlgnJksNhX6fv4iZWiYXodNSCW0n8HXTtV
	 VYIoinyYjuWwFvRkhWb67GhfmaLRxo/3t8kVVSYVvV8BJrXM3dvo4vD1Kp89ASAzB6
	 VhB8HrXbs3HWB1pyqzU1ea5nMTwFtVDem2xFCSVdrZtuhtROUAhA3X3DqF7N34DYQh
	 7Wo0CAEgnecKNL4Njk+LnK1qmYcbnrdtCTFi6dgKaNmeD040zyk5IkY9Zc6xGnBVEA
	 qnr0uDRznZYdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0C224055B;
	Mon,  7 Sep 2026 08:29:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 870449CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D7E24055A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BsKq3gZG68BP for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:29:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9C0B44055B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788769763;
 b=n8pCUShOgqe7CQ65junbM1uUvZwEUPgc6ZBLCv7St0u5qswPVB8mZOGTqHf256uSuPqQ
 o1liSOUJAC/RWRJGmaKUrx+WMwEJGRUazewc4I6tIh7ekLapvzjsUXPWp6fsmBKuiqz9c
 14FhjIs4+uYb2wDSre12FGjjAhumiPDIIQGCpls6gouYGBcV7qUWsIV0bCZsHMYDkcUlt
 teIpZy/7BW8YyzNKv73P3Ou2Cl8GI4fhWl0MRuWcEfcOk/u3VP0jPI37ebu4rQBZFgotZ
 5ZvdQxu600UWpHquvEi1DuzPnrtS+XNwQpZ9BHgv3qtLAMuAcUfVqMNLyXNJN5imjdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788769763;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=3Aw3DQ4th/dg/H2kPEAVFMNXIEUkx8Nn9v4M8L+VgIc=;
 b=UJ8IPEVQIXDKI56OJynud82LDhiP/WsH5SXcvNblrTNYW7YZ3uQliHF1kgyJJmNunN4P
 VAL4W+FHt6j8rpCFiiuLQROwnd99VT9FCo7Co9LMXWBLHSD3noUdTiW4aVY/RC5/xXK2j
 i7bN+4Eib1fAFM7Q7+L6qRVDEQdqzU+KvZwYFpuIe3HmVnUiPo1OzbXJd4UO2/fwdZ3ou
 VrODUvS2geB4N/f/h/5mF3ikrxNF6bd5t7iwk9DUQcRh1CNAXuVj9bevzXgYZ6Bmh3VaC
 j/a8SOqd8e/E+WdtBFzpNqG1+blNyvLcr/AZCu6ZhOsiRThvRyqApJI6EXaq364bnnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ItCYyJsB; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ItCYyJsB
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C0B44055B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:29:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E59A60D93;
 Mon,  7 Sep 2026 08:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B651F00A3D;
 Mon,  7 Sep 2026 08:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788769760;
 bh=3Aw3DQ4th/dg/H2kPEAVFMNXIEUkx8Nn9v4M8L+VgIc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ItCYyJsBA4Mv48tMEYB/uX4bJdFEIlsegUZR8Xhi+y1aZfswdMXJK8RTQw8PoWarw
 g+LmU38R/dXG7Vbh0ZDd1sDgDMQk1PMyfyhCorxi3p2KIw2oV2ip6nVcLGW/bAvCvO
 N+hvbaDdwiyPuDY3E7oMdIqF9Aat9DT6/BwRnnHImLabDENayLFPY2lhyeVN0bLw+D
 5OvV4C+SHzdyjRh3MRRfESuAca23EDCLMa36JpmfEvunPJYLbnSkHC1I3qROrTBY0P
 QwgkY8/o4aMwiaVGUWZD1mfsQjvXvXssNc/ANKygJKaEHeob42QKWivZ7mp4SfXIl/
 SBLRLd4ZK5+sw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] fastboot: fix the RK3328 buffer-address default
In-Reply-To: <20260904131951.44451-1-pengpeng@iscas.ac.cn>
References: <20260904131951.44451-1-pengpeng@iscas.ac.cn>
Date: Mon, 07 Sep 2026 10:29:17 +0200
Message-ID: <87qzj5tqg2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Pengpeng,

Thank you for the patch.

On Fri, Sep 04, 2026 at 21:19, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> The default fastboot buffer address tests ROCKCHIP_RK3329, but U-Boot has
> no such SoC symbol. The supported SoC is ROCKCHIP_RK3328.
>
> Use the existing RK3328 symbol so custom RK3328 configurations that do
> not override FASTBOOT_BUF_ADDR receive the intended Rockchip default.
> Existing in-tree RK3328 defconfigs that set the address explicitly are
> unchanged.
>
> Fixes: 48f6232e5897 ("Kconfig: Migrate all of cmd/fastboot/Kconfig to defconfigs")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/fastboot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 90212fcf9ef..1887f78bcec 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -57,7 +57,7 @@ config FASTBOOT_BUF_ADDR
>  	default 0x22000000 if ARCH_SUNXI && MACH_SUN9I
>  	default 0x60800800 if ROCKCHIP_RK3036 || ROCKCHIP_RK3188 || \
>  				ROCKCHIP_RK322X
> -	default 0x800800 if ROCKCHIP_RK3288 || ROCKCHIP_RK3329 || \
> +	default 0x800800 if ROCKCHIP_RK3288 || ROCKCHIP_RK3328 || \
>  				ROCKCHIP_RK3399
>  	default 0x280000 if ROCKCHIP_RK3368
>  	default 0x100000 if ARCH_ZYNQMP
> -- 
> 2.50.1 (Apple Git-155)
