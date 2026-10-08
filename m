Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA280CA6016
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C6FD60808;
	Thu,  8 Oct 2026 22:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMIbC3lwmo7l; Thu,  8 Oct 2026 22:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA1CB606ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791498794;
	b=MeyhlFhPOnM6QQPbwYAo82Vh8lj3mJuq/2Os6vWBbcfVJu7l8v39wAWgpnr+IL99vlI7
	 JwltqmY/lOO6VKjP6DK701E+9GLnLzXaqQ/Bm6RVRxHwvS/ftC7EYG5prcMywQ+WXAyhl
	 GDfS9ZhdpCw8VkCZ+uWBAThFhDvwfplXkjT9u1FyJdjUrFhQUipxj49F+oABQNS9q0LAj
	 Ogo8Fg9nKHMYbZim/cVzn/iQf7R6j0WgCB0g7rw24tO7VfTbSSikBkLiul503VTWI65WZ
	 qXGaAXHG6ddnvTVcwuoH7IypBW0nU1JX7YEZRIeXKfnOlt0gWXAc3ogM1w1m+bRW7aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791498794;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/XIO5jusxloq1oL2h6xUkbdODDbX0DaanHGHpqaDncc=;
	b=pxdBqVa8QMCp/8WyTWFs/D8pkwDOXrcZpGd3XtzKO/fJmhtTJ0gGcf977HuR4dse3PbP
	 Ptx2A0lffFdfdz2AjgonMNmUMQcwhcqU6W197kLIEhP25dxHcpIRAf9d4u3lCwH0WyneH
	 L9jYr6mDhpZdH6Z7VxJZ8QoXKLnjtjcF8jBX6srvI+HeVg6/JRw0GXRtivGGOYzd5mdKW
	 3PhuEODk7qa9VN+Ubp5Q3ewa3db5jFlLPzYffmNg9UZjia6OdxdXzCGhK9rRt1xd4bePz
	 iH8ZjTMs6ACXik08E+69wpk6+vyzWnORYDZEAax5GajjrUvJAQbkA794Eu+usHzAhPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791498793;
	bh=/XIO5jusxloq1oL2h6xUkbdODDbX0DaanHGHpqaDncc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0ylkvUubdK59d5/uflb7Rwt76i3RDZyRBgIMVBQUc8eWRbs3K1bu/pti3vkx6iKnm
	 X4Xoc+8czjLTTAcCNH714DsSqGdD9/StbdHWp1PDF2wuqxoZykUhvRRUQEpJvubtY7
	 70nGjHa3WiE2654SyTKrEO2auFYBJx+ozsleieXba27xAongLh8leOnZDAThZeYXK9
	 Q7KeiCUD8xnuhpRArH10Brn/BHo3/tNFIv9rMomZJJ4ATNJWY2jn9KdGFeWNNaDEsG
	 XB9sG5YofdfqBrZcLUgFQTb6gl31bVGeK+dwdppeNIdgs+iCCw2Oafoht9sSMmFGAH
	 eqViv2sc8tl+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA1CB606ED;
	Thu,  8 Oct 2026 22:33:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43CA51A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41B6640098
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2NqeS9FU2Gz9 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 096C64006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791498791;
 b=foFdgezzabCpGMMxGRguM4b1bPekS7Zaq3AOzIL8xTWEKHXAO+kbaBgYw0BIz/7icrX+
 rXXTQ19wGtLacKhEzypg04J4bNgq+VBzqpxjMUzxh7Le36BwuUMK4hzQTVOxMa1n2V9EG
 71p2sL/trmARA4zvjKtSW1PcXX+7PXMVHIFndrI9GHiuDOUSfzgtiBFTkEhxxlLHTeUfP
 vpzoIrj8eXeIIhGTXYcWifHoUHM7GvG4g77xJSW61zQEJOWMuYjBBfTtHmNjkNhDc28nq
 tI9vWbXQw05mdUIVt1+b1EL0T+EdBRPEdvO47dmQIxfQjr5ccIK/jV39m8i0Q7U281w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791498791;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=/XIO5jusxloq1oL2h6xUkbdODDbX0DaanHGHpqaDncc=;
 b=ZPL2EW7hSPLIa7KOvDs7qcmU4WoSFTG0ugeixyEAUiKq3iiTuqGlWZHzLFEKQ5jf5Ixa
 EbvesFYQLapJ/UAeo3OBSlZ7I8HCsozXd/tK98xCuJvagKomQiKJqlXRgvAypjNGzcGxi
 5DcvXlXXROSmbSkuofiWPrOF3zBK5qLlHgoVL3SZZP5GXYXqgNah8JsDDu4y01Nk0HLfi
 LvpUi6i5e9A7X14xUiyjWE0a8oOCjeNkxLdPdbQPjlUUZlM4McgmiV04L/pjFhF/3mAv9
 +BXT4MtF/EObaPkslgIXIIJ47iERbBVmMXIisNYvSvRmvFYw7sPiln50D4mP3LvFHHw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="il/2PBXV"; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::15;
 helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=il/2PBXV
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 096C64006F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:33:10 +0000 (UTC)
Received: from L30177.local (unknown [IPv6:2a01:e0a:ac2:22b0:548:36d:1051:820])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4DC19780107;
 Fri,  9 Oct 2026 00:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791498787;
 bh=mIzb26hRHbikBbMRf+xU31/E3gqOUSx7O1GTup7GRLE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=il/2PBXVvXIzDqg6dOL4P4lSTqvv8DDBG+ZXBQlg68nvp5w0RefTf0e26S1sOyDZB
 mUYzPNoXanzee2VCYr0Hysk4R8zCMPerUUc4ekI1RMum5xOobE+MwJOO6YPMZhOsZY
 jIQMg9M9xPm1WH2usN3nmFFsPsuHSLJ4FT8wIlGxReeZRGusTJJomPhXceX//bl6/6
 xCmsh30+psTktJEsuD6HthTVgj4qzXvKDV+SO4bf5ppROKCknzfNY5g0tIyma8VjON
 iQmtKLXAKKt9NVLh5iSOf1zTnGYddl2SqC1B7eMie72mHCAlMqZnzdJ0u6pHSx4rv2
 mefgkuVjrEl1w==
Date: Fri, 9 Oct 2026 00:32:57 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v6 10/13] board: lx2160a: serdes: add serdes1:40g4x10g
Message-ID: <asgaGSHo1myxlF0I@L30177.local>
References: <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-11-vjardin@free.fr>
 <20261001204731.1774613-11-vjardin@free.fr>
 <20261007112758.jgxe2xhkrxmgof5u@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007112758.jgxe2xhkrxmgof5u@skbuf>
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

> > +	out_le32((void __iomem *)SRDS_PCCE(base), X10G_PCCE);
> > +	out_le32((void __iomem *)SRDS_PCCC(base), XFI_PCCC);
> > +
> > +	err = sd1_reset_both(base, keep);
> 
> When entering 40g4x10g from 2x40g, why do you need to reset both lane
> groups rather than just lanes E-H?

Right, not needed !, some pending code from the initial development.

I'll update it into a v7.

FYI, since the patch 11 did the same, I'll remove your Reviewed-by on
it so I'll appreciate if you can review the 11's v7 once again, please.

big thanks,
  Vincent
