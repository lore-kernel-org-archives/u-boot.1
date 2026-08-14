Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875D0C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50F1640CE6;
	Fri, 14 Aug 2026 22:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3y_Q84N6teTB; Fri, 14 Aug 2026 22:44:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 889FE40C7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747463;
	bh=PA2xR14hwwWHhLr521WkJG9Hr3dgRGvzJ11484bIaGY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wyBRe0/yC0htof7SDl4lClVh+Csh+m1tvqvnJygkeTvIfeESUch3zCWjBSNRvUeZk
	 LXh1n5XSvriH1aRUKJpgXvhBaZDFlgdtJTgG6L/TF96jj3sfzo++Cb0eHCE7tVKNQJ
	 3lZ5pr3ie0uCDg/2COdlAV17AgUdATozRHH0eD2w2lBc3tQeMBuVbxJt3qDyNme65/
	 JAVuDSuzqbC/GX8+QmZ7JPkYFs++2WVu/pRY/z7aeBMNCJKoWzdvCMfUUhnSIzmf9N
	 ZucOdeBS1hCgLcKS0Qx2eBVwqikjIQPyS97N7EtTnEzn5ZkN0LJBl9FLuapZYzSPoU
	 4Dc3rq870/6fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 889FE40C7A;
	Fri, 14 Aug 2026 22:44:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E0EBC3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C71AE40CE2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXoK6uMpi4Ir for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E10BD40CDE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E10BD40CDE
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E10BD40CDE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:19 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hMHN15nKhzKnSp;
 Sat, 15 Aug 2026 00:44:17 +0200 (CEST)
Message-ID: <f104bd0c-e458-4f8c-bdbd-9a9cedd480d3@mailbox.org>
Date: Sat, 15 Aug 2026 00:24:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/8] board: schneider: rzn1-snarc: update MAINTAINERS
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-3-56b6acef0439@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-v2-3-56b6acef0439@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oqshwm44ne8gxr7efg8sb8jhgw5un85n
X-MBO-RS-ID: 5275153bb8564ee8603
X-Rspamd-Queue-Id: 4hMHN15nKhzKnSp
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:38 PM, Ralph Siemsen wrote:
> Add NAND, ethernet switch and media converters.
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>   board/schneider/rzn1-snarc/MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/board/schneider/rzn1-snarc/MAINTAINERS b/board/schneider/rzn1-snarc/MAINTAINERS
> index a39b96c1163..f8ae9e1cb6c 100644
> --- a/board/schneider/rzn1-snarc/MAINTAINERS
> +++ b/board/schneider/rzn1-snarc/MAINTAINERS
> @@ -2,6 +2,9 @@ RZN1 SNARC
>   M:	Ralph Siemsen <ralph.siemsen@linaro.org>
>   S:	Maintained
>   F:	board/schneider/rzn1-snarc/
> +F:	drivers/mtd/nand/raw/evatronix_nand.[ch]
> +F:	drivers/net/rzn1_a5psw.c
> +F:	drivers/net/rzn1_miic.c
>   F:	arch/arm/dts/r9a06g032-ddr.dtsi
>   F:	arch/arm/dts/r9a06g032-rzn1-snarc-u-boot.dtsi
>   F:	arch/arm/dts/r9a06g032-rzn1-snarc.dts
Use "N: rzn1" and deduplicate .
