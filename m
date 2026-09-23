Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4A3C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 20:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BC42410BA;
	Wed, 23 Sep 2026 20:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eblljoehEB87; Wed, 23 Sep 2026 20:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 583BA410B0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790196650;
	b=Jq+RxQkGDn2at/W3s8BGD8mutaAsTMawATGHXp/k+265oYLrTPdvhTm+KNdumRHqEwfE
	 d4lW+rfvA298aPmk9yHg8h1PA+c7xV2YOszYS58wHOTuM02SCEjHfRUe7YMlPpS2mgqID
	 KU4eXY6ruBQ/BVS2Lq+XJa6499dfSCc0lHoHgTM2lMwVxDEucQr1CqOtZJeo0OYJlXY/+
	 MOYbY92eHD2+AW/V0BJ+ti1OHytM6XHlk8vyzJeRSG/3xG3rzDS9d5L6KtXXRghDv0q45
	 w1x+VKs0gkEQiZN2uv7stW1D+4BxwLfi1IFamHBBprGYyWG9f/S6vOkK8yM7FLKjQjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790196650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SZD+axtG6vVrncMph9jW+9Xv3LrVKd1WuHhti7E34nA=;
	b=E2f5HklWZUfdCAk6ZzmSFuuwbwJzszbFPlhGwVFL5+kWBU916nBt2F6DzetV4XI95yyH
	 97LlkasBmgc8MqAAn0/9rq50+25zsbLLyK/vUp4ML4ZXMqWPwvARFgBolwJupoJw80T1p
	 7Pk4iefKgm6gpIuPqVNDKTZ3lPQ3MmG6rT7yF9fYtDOw4qE7fJMYkZJ03Pij4m5BXOAMD
	 yrUND36gZobVyw6/TNoj/uuiNNTIFoBymRGFPFN1cl4XtSffTBs63xMwJ4Nlj2sWKmED2
	 kDXFRdCV8jr7FQFxhZPExQttZCBv4wGdCTfr9qoTLs9ZFyxUmd01C+M0u+upOC7jj3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790196650;
	bh=SZD+axtG6vVrncMph9jW+9Xv3LrVKd1WuHhti7E34nA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n0tb/Kz4tYcQmMuCvXwhLt+0MfHvWjef1BCbyfxdOmY2Y6CJ0FZiBJwgJgGR3brZV
	 3Abkp3zQnuHJoqDo63ZhcgZeAFQkP5OzYwHINHnaP8PygDMvCPfEr2feyy54LNV0e4
	 N8ZzDwpaMqlLzth1y5o+HIBc9UaeoBYika/JPVvs1zVOmKXb4aIZwpgnuzTwY8BdWi
	 bn5paofsxogo7gy+fVEBXJtpJgM4TUK+hCkWgUUnyPa+uGQhie/Tf8T7k5qHw+cUHi
	 ZJFJ2wjxszzD0yD9/2jDcPwxtLGxKLatetPJxk6ciuA5s4BC/fMgMR8FD0w7dxlb6f
	 qVgM/K6ztUkRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 583BA410B0;
	Wed, 23 Sep 2026 20:50:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1092928C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E33A240390
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:50:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ImYvIsVrD3eZ for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 20:50:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2E32D40270
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790196648;
 b=kEG8MIGKUoXXRPhohuEbRJ4PLmU60KMgpTXfNKVDdQR8hyqlWXt8dWen2VMerF4citYg
 ZV6KYhKea+vHqsblieAlea34Vf+mLiLw9mudCv43h6WIlWEjs5hsX9d6qkZrxVBSAaPaY
 jLHuRk9g/kYKCJuAsYoiAC0EayyoLpnFMRdxV8rxQy3eLuYwcMJsIE6sSZ6ZrpedCebeN
 pgtKn1gU+qvRQSq1zpn9vunnyaG35KiQmciqPGQZrMQonwVuOgUngnf7UAoFOwtyTX+Rs
 HETEv3OmtL+OiRE08Ahn1/MR21kEkDSY2VvaILfqZsZQqv54PSkJzq1PGYM9i3dCkpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790196648;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=SZD+axtG6vVrncMph9jW+9Xv3LrVKd1WuHhti7E34nA=;
 b=Tq4ht1fPZdQ7vRnYdYpc2hhJhE+yRC/sZRja0uCt6SAO6TzkSspJ/10yYBgABO/Sv70T
 cS75TmfsGxO3AcSIdxde7qfSuUwPcYq0+OBCfrmuM18IgeJL2F1jt7w5VDS8+iFPYORio
 6ql9ZKFSdkPTuiJPaEtjRxXUrp+IbExy7neusxnLB1+jgAZyzwuNXL0QooPpk7D9/auni
 Xw+m/focA+1haytyTXT/SEz61hcOMjsXYHgX4dw5/iW4iGliSc9bMEC5p6ctm/t+vmrEP
 OE02xlWAvwobbRhR4UzFrA8yUXRIgsSvpjZOYp+TI23u6I2wq2ts6uO8zgSNRurJzgw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IwihlSV3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IwihlSV3
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E32D40270
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:50:47 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-486e0f56cddso749973fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790196647; x=1790801447;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SZD+axtG6vVrncMph9jW+9Xv3LrVKd1WuHhti7E34nA=;
 b=IwihlSV3hQrvaMvjuYFI7uRh9sXy7ywIa53MVxvyUie76NirXaHzpow03oVsg98BOy
 YyJuIqUXTFC/e38oHHehRS1wbdiVgyIEvgrn0tmeGym7Z35Yj9l46gOsiAMePZ9B9xlg
 BpRC/pMOXCrrZLgFktkFDoPsoP8DeY8ctkyFzs0H4k9aZr2ymJ7QA3qwlt8UkoWnE4/w
 se21SkydKkG7dbBVE9u9gdmXSOnvwt2p2ZNqEN+7CPuO05e2vUz9PUMB0wVNK4iXgMoi
 Vr4vky89/urkhvmtxpWvmezr7p9GizUjkRooNepBWq9rvdP20/wovt1+QM0lfnFixjPn
 4qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196647; x=1790801447;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SZD+axtG6vVrncMph9jW+9Xv3LrVKd1WuHhti7E34nA=;
 b=KaqL0kMRTSVKZI3iofCq7AL/kqjAkepwlVv9lTfSxXBDYYU16IMKXptUjF0z0Vl/Sn
 qKXyhRpmecFi4mexVYHIMdx59L//aKrlInROn3QfAqLLkQ1V7Uw6t34HwswiUs7C73eh
 aJbrRsDJ7rUlwRfv9Q3IDTLPfX1hEk+MUaT7Rc2NUoN7zlmbNvRFMPaRbiPQQMu/9EMW
 x7OwrPTFJjQRPOq3GbGFWdEeM7M6dZgonP3j9Pm7zulnG2nzX8MrwT2gCe8Bl2TTHzFo
 tbMxbvz6L+37XwwxNQ82bpOcWAOdvphDjGrHzZ621nIM4b5vYkjEZ4X8QfygZ14Cgqki
 qW6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtC7ARLk6SOggRv+U22kb9rKITyN+qrNamWGfCie9RsvrC4lroDXYW93mXZ0gpv6AFsnUa67Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mWrtALuUZRDbFLDER8fNfRaNq82qgMG9bbikSF/foknmYpZ+zU
 cth5OY/01dgv3dt77IrEJQJexm2SSGNZcbMO+lrNeE5+tyZcCAxbnLEGDMQqj64sAkQ=
X-Gm-Gg: AYBFou0X7Ap1NUUqdRSSaGBpy8jh9DGHI6KbTWoAIDSEhjw3++P1wMvHWy8G6+jOYlG
 72Sn1PHHPDXEvrYxGKdsD0qkE1aQiopefsEbZKNJfLGowy4Zvsb59Q4qdklSp89Z8CpjFgikX9K
 vJfbjp1thL4X8rXRsBmqCz9M4SxQuaY+KyO+2RJsvo889PDSgS41ZUkdAzNz9FuOGJ1i1ugo1vq
 PqX6uWGyECBTVng+rD9Q4obuCD3BlF3gmF7s4SYkeQjnKFStpyesdJTf9sQuY5jWTB78j279MHV
 WFCBdrAn6JnEtBr6ZnWBa7rq4GSnsaLeOD0MPTLZUrWcujygsMg1dSwhATJtBNpp+Dnw8EscXbL
 yolaCzuYzqVjCHvPlhhuXBY/j2FSzv2ImBFNjasrvhjayJqEf89AU6KDFQNBQeQwdjkt6MSF5YI
 r/vGFBp+tSTDb91Jp6z6zwhEurXL7VYUlUZjXWs1rPtOFM7FlneWfNrYoaMFvqbcfSXE6slVcJT
 WnbNsDT6aOU09d8NY61wSYQoIOsDrpI5trcGQQv41XN5B11IvyWj3rb4HY=
X-Received: by 2002:a05:6870:16ef:b0:455:d4ba:1dc6 with SMTP id
 586e51a60fabf-491e5293ad1mr447118fac.5.1790196646761; 
 Wed, 23 Sep 2026 13:50:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-491ed7225fesm275819fac.8.2026.09.23.13.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:50:46 -0700 (PDT)
Message-ID: <475a538a-df5b-4387-accd-46ae7edc97c2@baylibre.com>
Date: Wed, 23 Sep 2026 15:50:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] clk: mediatek: mt8189: merge the clock drivers into
 a single driver
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Chris Chen <chris-qj.chen@mediatek.com>,
 "irving.ch.lin" <irving-ch.lin@mediatek.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
 <20260917-clk-mediatek-cleanups-v1-6-4dccf8ed98fc@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-6-4dccf8ed98fc@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/17/26 7:52 AM, Julien Stephan wrote:
> The topckgen and gate clock U_BOOT_DRIVER entries only differ by
> their of_match table: they share the same probe, ops, private data
> and flags. Merge them into a single mt8189-clk driver, the way
> clk-mt8366.c already does, so that a new clock block only needs a
> new of_match entry.
> 
> The MTK_GATE_CLK_TREE() declarations are moved above the of_match
> tables, as the merged table now references them. The gate entries,
> which used to be written on a single line, are also split over two
> lines, for consistency with the topckgen entry and to keep the lines
> short.
> 
> No functional change.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt8189.c | 73 +++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
> index 8df09f4a129..a5cb387772a 100644
> --- a/drivers/clk/mediatek/clk-mt8189.c
> +++ b/drivers/clk/mediatek/clk-mt8189.c
> @@ -1970,6 +1970,14 @@ static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
>  	.type = MTK_CLK_TREE_VLP_CK,
>  };
>  
> +MTK_GATE_CLK_TREE(perao_clks_tree, perao_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(imp_clks_tree, imp_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(mm_clks_tree, mm_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(mminfra_config_clks_tree, mminfra_config_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(ufs_config_ao_clks_tree, ufs_config_ao_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(ufs_config_pdn_clks_tree, ufs_config_pdn_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(vlpcfg_ao_clks_tree, vlpcfg_ao_clks, ext_clock_rates);

Can we make this move when we do the MTK_GATE_CLK_TREE change so that we
don't have to touch the same line twice?

