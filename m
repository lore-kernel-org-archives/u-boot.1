Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE936C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CC264067F;
	Mon, 17 Aug 2026 13:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-qKaFRAskX9; Mon, 17 Aug 2026 13:34:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8347406A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973640;
	bh=iZvuu8kr74RE/d1vKo33dYIPYsder+cNkuB9w826v4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=INmJpMYVI7BgZhgv5H1lxc+T1BJQSBXFcz/OL/gBrU0pStlPIeI56guKuvKSD3A+K
	 SHgSExHVAQQlnEiYUGOGJGqbJyCR4bPUlblpLLsGLexfeZG5wc0HkFt6qRDuh9RHIG
	 SrynkKqMgQfuj/uU+jf3ctWzUL7SYsrRsX9WvfToylniLiL16aoxAptgdHaFVluIWl
	 Yd4RVW+CaTmZCpnaBYNJMq8WNaM4o95y47DE5v4adf1/CmE8PI1KWrhPyryOw7kgao
	 tRncmUiRVsF2vhko/Hv0TbMqgRgOkUCzIUiYwgQ0cOApIX+CQTSPUFSGds6XjZDdGj
	 k6lLg/Z26Fdzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8347406A5;
	Mon, 17 Aug 2026 13:34:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 098BA2EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF70B80E51
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:29:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id niQnKhanhR4U for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:29:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5FB9380E4F
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FB9380E4F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=evaegCSB
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FB9380E4F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:29:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D01F43296;
 Mon, 17 Aug 2026 08:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF141F000E9;
 Mon, 17 Aug 2026 08:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786955390;
 bh=iZvuu8kr74RE/d1vKo33dYIPYsder+cNkuB9w826v4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=evaegCSB+wtpKqHlqBHJDvPeJOBnVCZNOlCHt5GzgGRwOjHlDXu0KxVPGqwmy7lE8
 KyBYsPgd96X9aB3nRFpAf+GSsYApndCQEkVsjTUYJhOaY/bcQaUJxUgogLp1fCp8Eb
 C39fUFBoi+T1hp6+iWGbyUsFIcyNEjVkiuLsl8N82/RRbcPBtaujqdg16s4qVE+4Vb
 EbSxvIg+PGtnigMPo/7Wz9c3w/8ypRF8y7tujkW5fmLm9/yA2WgF46PeMl6GDNYWRo
 66IW4kV1DPjca12s60wkRJZBluYvClZgPTuQMWEOOn2vE63t19HryFTK/2jCKBIQa0
 rRIn6PyZZJRVg==
Date: Mon, 17 Aug 2026 08:29:47 +0000
From: Yixun Lan <dlan@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v2 1/4] i2c: k1: fix wrong bus speed setting
Message-ID: <20260817082947-GKD566872@kernel.org>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-1-7d2a48607233@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260815-k1-i2c-fix-v2-1-7d2a48607233@pigmoral.tech>
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

hi Junhui,

On 11:40 Sat 15 Aug     , Junhui Liu wrote:
> The controller bus mode should be selected according to the requested
> I2C bus speed. However, the driver currently passes the functional clock
> rate to k1_i2c_set_bus_speed(), so the selected mode does not reflect
> the requested bus speed.
> 
> Fix this by reading the clock-frequency property from the Device Tree,
> defaulting to standard speed, and drop the unused clk_rate field.
> 
> Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/i2c/k1_i2c.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
Looks good to me
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
