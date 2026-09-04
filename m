Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE7AC624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 352BC811AB;
	Fri,  4 Sep 2026 14:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypG3OgFPvdzz; Fri,  4 Sep 2026 14:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5D0A28119D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788531310;
	b=XrtUlhd6UYbnwZACeuAT7U1ld94kiNXHzwqrquzqnatTnIv/LeTZUsZdeocpAwYrJ02y
	 2DXvFViYCBXuUBb9Zs+iPTu+zBtCNJk95x2PnBPQCj/gjLt2ETDk9ZrOh0PgoB51kB+9a
	 h0QEZs7N2OGZivwNvR+SBEcaiZe8F9uzSuLuLCZ6UH9uXwmaHpMuX4zmyLhz7eKS4deg0
	 +uRYeKTbu06JR/HVpL3mRChyL3lxw4uUjRFFLhb/SveakieJcyuP3gDRsqDx4Vmet/7Oe
	 4arXLMVHmRU98597sL0/bSz3L1lC0N3CKXCqLB3Cfpx3diU0OgAF0jB1D6/deb9W+Cw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788531310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bqRf6sxJsNLtZt85Cql83jxpd1meCGBxV0+SgtMIcow=;
	b=mmDNdDBkYQN7f6yX3UPsEqjxo6pZr+jE84CtyVdHrs+Hm8+2bxNHFcghp6Qu8v4y6BUC
	 RC5r2LmuAxewmFUjnFkaRRvVGzGhAZgpH02GEHoC/CXLyxwa0fAQr5qNr1A6gEK6I2+ZE
	 DxqMmWxdxExLPnDE859eOcozyXKd7udzEh8y4cy3oCuyfkRZ/RpbFAY6+TWNKdjAymNnr
	 86ZinQFwZTA/N6PptvtNewpeHIcRH9smDV2nERNSiZ4Y7w4zPUd+mzSsEm3KaY3KSq400
	 HkoICnqc/SoWd1pZc+q8FGm8+KTkrOt4ZfNBOxR7WiOMCnuu5q7GBuxE+JFc5mMYCgw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788531310;
	bh=bqRf6sxJsNLtZt85Cql83jxpd1meCGBxV0+SgtMIcow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIp22X8gIjKOt61ngvRIVEGC06J5SznWnu55KwOJeizcLL6luMDdqsGUT4fhKn38H
	 Uon87ccGQiJHb7v0kpkl6g9Vvn7BQtc1xOKQKOfHqJS2MZCQJMLFbb3q3bYoQ5ZW+Y
	 KHduVpPzU5AnsJGZVvvx1CmaolG9A9ZbT2bi5h1SyZPvkamsdZ30vxQwMOSNY2alSG
	 sH1fVcDLNqerMQeu4jxTAIUvkzSezMAoiLp/XtsLwOxc5h+WEYDgnio0AZQzB+5w0T
	 n/UTJrLr2QwmtQMMQun8YD/m33TDCLrbVChC2IrtxCrgx4+vgLN1U9FL84P0GsKktv
	 w57J22PH/K3Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D0A28119D;
	Fri,  4 Sep 2026 14:15:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC2D810E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD80460BF3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBOYGbaMjmG9 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D4AA560BC9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788531308;
 b=Di3bS16lqUlo3AONPW8BLWuJmpRNycMCSnSM4CtE6xQ/7kUYC4VwCxUBxBTDhd3kEBeB
 E3gJrwETZ4jTJNN+crnZZzHkHG2o+2XJPFEJDtq18hm/2L9j0jhUvxV6LzoHV9Nh1s1nZ
 255jsX8+SSRmOQ6GJAN7h4pGImGKbgAPYYjLlQKVlnieSRRb7Lblz2Dc82Rvs1j/ntT7S
 lWdECcnqtudbP4PA2KhznBjGcpybedFBs4Ibz+/9XN7WBAp2ffRDMHe1rzoXQK0hDyPfQ
 yqNz9wEZKavM4pK5Fx8wYdg6kqtRn2ahaZiN4RSzJZk5R2uFidb5zQPem4yqz+z/fXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788531308;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=bqRf6sxJsNLtZt85Cql83jxpd1meCGBxV0+SgtMIcow=;
 b=IwyL0FQkmUP+4HzqQPw1E+bf1MbeOAc4nfvmN4qRYPDmUxubeT78/I09eIe27VsQfvq7
 ZmNS3kPZjAyf97DsYgVD6HJdPddduqr+sgPt1ATDze2KedMyC0BpwqYkLj0ZoJw+Sgxxu
 XQbVOCcCuaGS/7yufLwofGBCG14ChCuNzKujBRtiKCWBGpbKlvMCrtLf4MHB0ticQjwXX
 P6i6m3Pu7MNucq1VarBGoIgzqc3vWrz82AV/I7+6H3kNbrwCTYZMBaEqZSKysikZw0yLa
 W2C/4X+gt40TmAbF+4ZW4and5aApeZqiQZp9OvwR6d9qG33DPJgr+3r56sA71OeZbWA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YQz1Ta3E; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YQz1Ta3E
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4AA560BC9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:15:07 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-866e57f63a3so12299317b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788531306; cv=none;
 d=google.com; s=arc-20260327;
 b=jtQ247aGP1CkYFqsvTEyy8bsL8GAyhB/Zy1jtQiAkeL4RHII/slGFm6ncnjxoVMX+e
 TTwXL6esmqAPCe/UHb3eclSfsAYFiiCDpD+0DlYHGWK8sstOo9NZb/HLTIm83rZ7h3ap
 Busfku6NDmeaqguv+5m3Hswbb88kVLTg2cquXggKX4xTOOkEarzrjPLASu0KJH8k75lV
 hO0Up+4yvf0UtH3a/uCFyAtRmvALCsxmbk3ShjvMMp17pz3MpAXFTZ3btdHGh0SAvdhm
 iyf2KT1WPSmO5xuXVhtNMIcqBT7pnNXUug6VElCEESPj8JdAYZ4RU0xVv88RcEsFRhqF
 5OjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bqRf6sxJsNLtZt85Cql83jxpd1meCGBxV0+SgtMIcow=;
 fh=dIuvzTfeZ3aqFC3FLyI7C7jknIKJ+ulsH5WTaxvcSBk=;
 b=UltivttKbAM48Vuv2eH1DwfzWClbYs3nPdCJkisFAH7xWWjtWml2k0bJ+UJ2RVFYee
 xjCvk3oRDHNkqaj9bZpz3NuF0uTd06Q24w90Pv0YbkJOSEsqriEhZSQnGD4er6n59zeo
 ILCNx5s69toeaG+k46cnpnjgO5nNnAjxYyQsaekmZ52QtWMzRfXVtztQyG8dmx+ZJEEy
 OhUUOuJB75AjUvEvEa/cx6+EzbT2zExaEVjJQLVcQAHpmipa5q2k3WuvZu+miMTeWHhn
 0CWTwlftUVjC1qsS5YD8oXpfCMhsKKm1WvrJfiMBoa5KBH06cY4OMB+3Jr/VWqvZMV0l
 pYJg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788531306; x=1789136106;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bqRf6sxJsNLtZt85Cql83jxpd1meCGBxV0+SgtMIcow=;
 b=YQz1Ta3E+t7btvW0k3JkhfjgLCkLddFxzPb2RVfuss+bZjciCdDnZxJXPHczUoZz5r
 ENMPHagOTCodjgbmwDHuD7+aWN6xfjQlBWQ8TyEXAIkkp0TcXKOrbJ1a68kFrnDR9xnQ
 WHNSUHGIEeOT/qsH5usYxNkj+dLJaRiom55oHYCocFHYKO2RvQGqVzet/nPJWPD28hqm
 t2b/m91acZ+9EuxHTpzjqnzPDsXRPJapr8zNi3uitrfk9WHACx6vnP3OxRvSxwG1Pkkc
 p+MMe+3TfV9GgwkxAmMYArlQcnAB6gOlBmUf3xdwYA1svU3w0ehvc4yLv/ptPxt+PO9/
 1s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788531306; x=1789136106;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bqRf6sxJsNLtZt85Cql83jxpd1meCGBxV0+SgtMIcow=;
 b=LtnX50QTH5xGbmexsTA5qWcXc381oyEJBON7FrJb54yz8f2AytTVngDv8aGay9efLD
 laZNvE3GOK7rH4qM8I61oBpf87RUoRKB3lrFOpjng0l98RlSQVEd5mKb0b5POzYfbm8a
 Q9AkNi8y5SHZk7+S/pPCTeZH9y3DCZzjQvgL3o/qV1Pj5uUT1lTgOJa7Z/oWR9Ln3ysS
 /S0Jnu1a2zRPigdUqqCuXV0hY8yh+HLeWPNvzAf96TUOjYT0a8yIxK+ddtutFX7919Vx
 6Ae4wZ4Tle2Afl1IYcLeftsTd0DGRmjZyBzCTAKxTNxY/FeNAY+Ew/cscvOzKSjcM7LZ
 LSvw==
X-Gm-Message-State: AFuF++l0WcBKlNHH6+FRVjWA9b4Kgto9aRnV67qxEfSmyBtImy363JY7
 UVwMkNo0JHONWMqwCmKym7A0nVpsUvg/VCC51w+LJuLxrp31vQ5jxIh1fz9YZuP0p4BgKxqm1oj
 MaMN9QlwA12Zhsckk4y8up30WxYpW4pvCaM9CplamCw==
X-Gm-Gg: AYBFou2hzg8zfaeEYocmBqlmGSC2sxa8n8t93uKxl5xnDqOY4anvIa8W+IQgbBhSdKb
 iQaDprfA8d8/s1r5ISs1Kn8CR699eRQ/ATvTQcIzq1N0YtiTTych9zf7VpgFap2+FIG4BH+PQ1t
 uv/kjhW0e8jUtROsaWpDaZIWmpWbz7v3IoDgncoZmEHkRKeh/+vdPJo/g26GYGqhRzwtcxDolcr
 CiWASlZ8caJd4ASwygEZrxRDJFQcLdtbj6PuVBFzDKMDdOz9WuZWoK1/2dpNsKNNVnwGT6VMMlL
 51XZnchtV9Obi5gvWI10KV1CojWavXXPZQ6fOPhxC7rXp889iSR3vzOBCC9LVtvvHCtwZRk8zwb
 v23An/+mhkRVoyBYsjOIGSJHM/G6XbqKENgJQGsotxITAt3hNU3bX1goN9/k8aHgbHrbXWaeY4/
 odjY2q7athOypONUjyuFrXi25w7YlWPvKLWZ3BMClyD0xd8DUeaCut/CnynYV3qmkWTYKhYV+7X
 fVpVGJ3gvLv/9S45MA/YpFG+MbYhsO64Py3p6UZwrgYKoaJzISourapMn51CfM5cPHxg6USbG+Q
 EvufpiK+QonEGv44XUFgKla/TpPBTb24EQ8MK/74dWc7HX6d/UFCNYTlJGLjj4xyNogGkzZE+jQ
 WuVpqQUmGD/l3o+Gnv2tGKUn6ciXWO8A3Urn1pyM+Jjw=
X-Received: by 2002:a05:690c:6187:b0:871:cdc:eaa5 with SMTP id
 00721157ae682-8712259ca8fmr32209537b3.1.1788531305934; Fri, 04 Sep 2026
 07:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
 <20260904-add-genio-510-and-genio-700-hdmi-v5-10-dd9dde2f972e@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-10-dd9dde2f972e@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Sep 2026 17:14:30 +0300
X-Gm-Features: AcwNN1V7bDo2HdsN_C3gSQjNR-i2642TfBPHt9inlbsHi4FKkouWHkkR9JhqFOM
Message-ID: <CAC_iWjJ8_eYZAZ7WKm=CqcPjvy8X6av2ukc5GT5Oqddn54qrSw@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] asm-generic: unaligned: add get_unaligned_le24()
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 4 Sept 2026 at 16:50, Julien Stephan <jstephan@baylibre.com> wrote:
>
> Add get_unaligned_le24(), mirroring the helper of the same name in
> Linux, to read a 24-bit little-endian value from a possibly unaligned
> buffer. The MediaTek HDMI driver uses it to pack InfoFrame bytes into
> the 24-bit little-endian controller register fields.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  include/asm-generic/unaligned.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
> index 9e5d93ec304..a68bd8f1991 100644
> --- a/include/asm-generic/unaligned.h
> +++ b/include/asm-generic/unaligned.h
> @@ -22,6 +22,16 @@ static inline u16 get_unaligned_le16(const void *p)
>         return le16_to_cpu(__get_unaligned_t(__le16, p));
>  }
>
> +static inline u32 __get_unaligned_le24(const u8 *p)
> +{
> +       return p[0] | p[1] << 8 | p[2] << 16;
> +}
> +
> +static inline u32 get_unaligned_le24(const void *p)
> +{
> +       return __get_unaligned_le24(p);
> +}
> +
>  static inline u32 get_unaligned_le32(const void *p)
>  {
>         return le32_to_cpu(__get_unaligned_t(__le32, p));
>
> --
> 2.55.0
>
