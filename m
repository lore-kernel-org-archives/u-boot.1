Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7EAC5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1834940676;
	Mon, 24 Aug 2026 13:20:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yICD4RPrMGyJ; Mon, 24 Aug 2026 13:20:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577650;
	bh=vvShODBCjFQnhgMIBbhH2Px/sxOcVRpfL5CyZ0KYwhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWJ3u6l70LqzQRG2KDfEEhQ54ZA7SM03pveyDMTotliOJxE6nGjiN87odOF/heksV
	 cTrmEqa0mHPEmbFIzuwsjyiWMb1/khXRyXrN/YKwi6P2xmqNGy+lTDkidjhH3kRuO5
	 KREdzf1aItAqe2+GyY09csDxhDpuj8mBMu2EDT01FHb0i8dMOoXTQBI8Yx3qb3mFRK
	 b08Tuwwsq3ISMC8W8MeGcSXbdF2Nw/KX4CkmJ08QlWotHz17E9UhoggWyM8+q1/dCv
	 SVoABwdYaARl2MJ25AlsxcxwDEu1AY4ToyR9B1vXXmQAcfLXlKkuRKSqGaVKNrOk7r
	 BVXxeNN4gztkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A412240620;
	Mon, 24 Aug 2026 13:20:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A0A853AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86FA980B79
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cj3F1wVoJ9pP for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:20:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.2;
 helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=ks8kfiIe
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3245480B5C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:20:47 +0000 (UTC)
Received: from L30177.local (unknown [46.193.67.97])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 2391E2003AE;
 Mon, 24 Aug 2026 15:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1787577645;
 bh=zRkHHR8g1rao4PhhulOazacE0fN89aA2o90b5c8r5qo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ks8kfiIen8joMJn9MS55OTUSzFZX6qJo+4G4V1qgblOwfcnEzi3v/rxusGe7Dvce9
 CgNFqoNJsaweELwdajFZQ18tZ9V3X4bm6DIvOW9pwtieshrrFBvvSwDtmzNgCYk99Z
 OiJYwxa3eZM8SrvBX6x72rtyPKBsRws7ozAJdU9ptEespBZhZxKU/Yo7C18Aoam43v
 8/gI1eHozevX3T3XeqjJUw+GMd3Hnftb8ETwLTJen8zhk4CeU/5OXYlr9/GSgg1Qda
 y5vf8wgmku4R2WkKXFZvKhiQWDR0XG791TiXLpZg9HlgpKspHWlTmFLSjmbMwpkmPn
 neMfiMRReLBZw==
Date: Mon, 24 Aug 2026 15:20:40 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/6] Fixes and usability improvements for Layerscape QDS
Message-ID: <aoxFKASh99D8CUEG@L30177.local>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824122825.95712-1-vladimir.oltean@nxp.com>
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

Hi Vladimir,


Le 24/08/26 15:28, Vladimir Oltean a écrit :
> The set contains an assortment of defconfig changes to Layerscape
> boards.
> 
> 1/6: The LS1043A-QDS, LS1046A-QDS, LS1088A-QDS and LS2088A-QDS are
> non-bootable in the default NOR boot configuration, triggering an early
> SError before the U-Boot prompt.
> 
> 2/6: saveenv is broken on the LS2088A-QDS in NOR boot
> 
> 3/6: usability improvement for all Layerscape QDS defconfigs: enable the
> "fdt apply" command to be able to apply overlays.
> 
> 4/6 and 5/6: usability improvement to increase console input buffer
> limit for all Layerscape boards, and remove some core limitations.
> 
> 6/6: usability improvement to allow *some* Ethernet to be used on
> LS1043A-QDS and LS1046A-QDS (not on-chip DPAA, but PCIe NICs).
> 
> Vladimir Oltean (6):
>   configs: layerscape qds: disable ENV_RELOC_GD_ENV_ADDR for NOR boot
>   configs: ls2088aqds_tfa: fix NOR flash write failure
>   configs: layerscape qds: enable OF_LIBFDT_OVERLAY
>   configs: layerscape: drop CONFIG_SYS_PBSIZE=532 override
>   common: kconfig: raise SYS_CBSIZE default to 1024 for FSL_LSCH2/LSCH3
>   configs: ls104{3,6}aqds_tfa: enable PCIe Ethernet
 ...
>  50 files changed, 38 insertions(+), 46 deletions(-)

LGTM.

Glad to see that QDS boards are getting a refresh.

Reviewed-by: Vincent Jardin <vjardin@free.fr>
