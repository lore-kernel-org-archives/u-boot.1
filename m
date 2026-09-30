Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9E7CA5FC1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 09:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 878FC4085B;
	Wed, 30 Sep 2026 09:45:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xld4pyDka8kT; Wed, 30 Sep 2026 09:45:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C9BE6408A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790761526;
	b=QzXKgUVAun5xx7cb/0W+HKkvJUMuVp0aMUiI3v//eWL3KXPlf/7yT38j/z8aa66zuCM4
	 6sNxWVxYtlC2CS+pmI5RLbsCZGl8/tya/Kb0xYrOyNHt0CCPuPhEKsd6JZGg36VPR5Lgz
	 di4m9gyF2J2tb44WeAEpGhYwhU+tX5Xx5VhlqmU0LSvVNRfjknLR5oef6fj3Weky8CwFq
	 Mi6S/K5gBioS4mrt3dzSQyCNECgxBZO6/cJPnh71LMV8PZfd/iRjMh5mKfznmM8gFLfCD
	 GpIqaeheKCu4Y/dh+JoiTRMNISZ4fnaKLvQrmXdJGllZdBkzWuxjlKmWIea6fSzhllA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790761526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RRCnzfiV64LY+1p4RA+sBhzhbcQ4eRVI4rBnVoLvNX0=;
	b=o91aoESBZAuwcxXtc5VNOOwk6SpfxWx3nJ7pT/TbgZfxGsw8Z4Lr5bHSdIz1jz9nWEq5
	 wY+4RkJumVOdgFpCShDf0cTIYB6/mA66fx/Jjq5Ik2OFm4/5rtFLb7YPg+06xEARooQCC
	 BNsZq/q7QNASEk+UIIXvD0uHpz2rbfAex9/GBTsFJRVCKr8ZY8C+TafSI9gQlhk0jI7CS
	 4BTgdR6Ri2mouZ55Wd3qsG8N1uHGxmYuOUPI4ARzURadnA+uvWs11e+1qXWU53mdH/Z5H
	 CKJPGZ4yWPNuBUPlsgQx39reC0UXiOCMix9sa95DX7QAC0ejJgR9ey1zPFF1JDaO99Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=alACuUuY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790761525;
	bh=RRCnzfiV64LY+1p4RA+sBhzhbcQ4eRVI4rBnVoLvNX0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MZEvwJGHK6W/Ei3SYu86DH8AMA5yQBnUY4opO0yy07KBErx9ksmSzRvdOmC6/ArKi
	 lAC0DiXe8vuY1O+FbaM9zn3L1rVB4iqirAcS1mFB3eyRBDlvVZC/QvzS7LNjUF5o1n
	 1xBxTc2jewg5uZKqaUOLZ372hHsFE31y4rAlvGKluxGTwo1+Aqavo3CuKnNVFmqQW7
	 MfvnSDpRZBcS8Dbi43Y3Rqq2UEg2QQl69yPSnPw/+bnQ95L57KHrV2admBMhG7UUTq
	 Am9JQVWVsnw515AOl+kQVrIpX+bV0HrPcU1h1P7SlkXm7pInsR/3GrCGb+P41fZWzA
	 e0jgZiNOa85eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9BE6408A4;
	Wed, 30 Sep 2026 09:45:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 470153D8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D5BB4085B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGPEL60k1yem for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 09:45:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 409CD408A4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790761520;
 b=HndPTwgpvH87JCSkSeZVKc6Ua3oP6CABtVggN8cR6YixZZzUARg/7EHsV9Td+seJ86pd
 ERBDNDQmIqqRobfl/ytzp2Q0KPcCkeSAgo+Q0Lk89PdSbLGEdav4tqRRokccHdbdostyU
 9fOFm8BhR3rlJ5Usw1I97CKSy04VpxXnTdwwf9FAh3ZM1nOxXQJRUGUOhr32VRwtPIJ5K
 /SD/Tvua0QGnFNQoV+2wl1obqdlJMvqxYnh01KBcT9IUqEhjDLCMXNdSCABFXNf4kDryN
 awpkxw6MY1Lxh+bqxkouvtuKIXPhKFZLyacSIaGG0OIvgbGTcKg3vsYI9ltfSs/KnxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790761520;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=RRCnzfiV64LY+1p4RA+sBhzhbcQ4eRVI4rBnVoLvNX0=;
 b=i9vdCvl0yrXJ6t3Oo+AJwcyeiQ1+ArhczyPI5Vh0eOSRWt72jDhniOd3+4CKKk/x0r27
 ME76AAykWMEGpEJnA+k3szjGkzQQsQ7lIrkIgUF+Tb9lQnXDu/XQmTouBJbpKfQc6//q1
 hdgrxXGrFZsLPS76Tk5JLKaCrqb0sQ7vx6NZeDVRVsNOo+xWUFPaofr/2qAYJGHfc7dDW
 /jkJ7OYw5qcw5C1dxXtLGljxH9eZeWl6oAuKtoR6xYbLQ737fUuMcQZzFnZMT0gq29dB1
 Kp9zsuJaAZwh+3YUXTWe/zOhx5IcGk0VFOHHExxPPP3pbLyND3b/o+fi0kTVkXqBqPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=alACuUuY; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=alACuUuY
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 409CD408A4
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:19 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a006bb267eso16191935e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790761518; x=1791366318;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RRCnzfiV64LY+1p4RA+sBhzhbcQ4eRVI4rBnVoLvNX0=;
 b=alACuUuYo84ApLjz6eViNhdL+xcqn8jUVliblYME9KyZ1WIk2DhD2bL20sfhGaMmJF
 5GTYTSXNZbJAxopl5QHUA6sPDPsHuYxKtJKv/dAUy8etHcjAr9m/T9BRdzNutglV+dmK
 e2anlLEyf2Wcf/LSx6cJKMYH5F/nUfpZ0b1XmmpZfqGsozY7dHY2i+oG/g2soWtVe/lq
 jH1xIpK3dDEe5olIgTkTdfmNo3HYcvKQ0w2Yl5BZUFZNIn65Cy76tXFGAMu7DAjfJ44w
 lIfs6NFYZSGqoYkGAcBv1RcNb72CQEbteiKI4O5SCu9DalV/WUidPprHlqXjPOA7KUAu
 Wu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790761518; x=1791366318;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RRCnzfiV64LY+1p4RA+sBhzhbcQ4eRVI4rBnVoLvNX0=;
 b=oeEfHxuSgi2QbuT3AFPKvQqMSm0FOGqKq8ywedSTui2tRpv62WfhRp/ub+IUKKVPvU
 XMUajMJf6Bx6uTIto7zcCyO1adzX6YURVwIAmHnQlxLbk/DTFFTZeIJ3BI7NcHiy3Zp6
 dz1MtYT7hinD2Nbx8OUNMfF1JlBvVhBAxB/4PDXBHH4XVTqXMChLB1zrc2OioL6n6o1U
 mx4ZKAIwX3NH1vupURIAJ/IljDmTob3OZQKwqMpUokz6AjElAu8CifrgAtEoMzu6BMNQ
 1EegfLFzrP/ClVzikqMr/SVzxPzn3zCHLlVHG7JAHqJI5LhfxTRisMxoHJsp46R6jxg+
 Q6hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlxftJE3UqNRXXHjs52WwCIQ6WEw9DcEwWInlSGtK0ymXo7UME+RnPy4EFva1KCQ55xmXKwfk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nvlo5/eXJP0YcBt8bSHnRV8qjyb7BRsQqpZ1Rd1GevJfk2QnJH
 7B2K3GQS57tPeuu/oayfXDJDOAVx2kbcE/tEWJUeCgsDgFASmnzYE3GgpzELxACbEFo=
X-Gm-Gg: AYBFou0FL3S+qsD+V9AHfnwPej5t4bT6n5XxLZxfZ4hV/WfR2mgFBBaJgwx79PXwsL2
 +PKDPPpuI+kzjH7fuH2eiTKuSFeaOPvx9aLg2jFQ1dOdwwaP62jp5L4s606DuuTttYJ7ei5EJ9r
 gP5xgZvSkqC/aUg7VAdVYwx3RES2qE5LsD89211yNARASp/KMZBiGX08DaqYancuLLARoAskJyU
 dq9wrx2l0JETxrSDDoWjJQXeLy4EsJTdGQVCSgF3gpL4h8usaSCLpraTKaZsHUvUIIUsJl5TFC+
 s6h7kR168qcD2yXvegN5r+5OKsc8JvQPt2hvtx+fR3Ad2BQAGVAg9XINxuWm3BoCEX9YuX7UP3q
 LAkGwTTJTN+RvaRHkhrBDhTdnZEq3NsnpFEFRkuT4bsKEJaPa0gPXGt0uXUawHvZmFJRfC/U+h3
 OmW0MF45Hgyx7kUwiVmPCEG/Xujof2/tvd6s6FNvdqC43mU+92HZmff5epnhPmocJbH3V+mhbGF
 V60PnG77zzzo28zR2hqPWAr4yKpezoNwpCiPoDxiP6kOLik2ZhZbOjEZ9nQY8FmG/1pjPsw/FtI
 G2xU9CQ0BcyMZGpDa+ilHwb8HYwXF29w1pEPgSeVv9diVHkJTAehqjY=
X-Received: by 2002:a05:600c:46d0:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a01afe758cmr14256125e9.21.1790761517998; 
 Wed, 30 Sep 2026 02:45:17 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017468b10sm54109345e9.0.2026.09.30.02.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 02:45:17 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/15] clk: mediatek: merge the enable and disable
 callbacks
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-3-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
 <20260924-clk-mtk-single-ops-v1-3-1c3b5d8744ba@baylibre.com>
Date: Wed, 30 Sep 2026 11:47:31 +0200
Message-Id: <179076165163.1985961.8296971014040585427.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790761655; l=1894;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=kQtwqEMBPACG1EIdYTjdXxPrweSkqj4w21YB24lXwkM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFQl20MMaa8zZNv53EN9gD/84quIPAgruPDIkAq3mq/LkvmO3N3+EIq+M9NQpf2BXivaeWsbgeG
 FS6nV+NFeOgg=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> Replace the per-ops enable and disable callbacks with one
> mtk_clk_enable() and mtk_clk_disable() that handle a PLL, a mux or a
> gate according to the clock ID, and do nothing for the other types.
>
> The PLL sequences move into mtk_pll_enable() and mtk_pll_disable(),
> and the mux helpers lose their own type check since the callers now
> make it. The checks follow the order of the tables in struct
> mtk_clk_tree. The order does not matter, as the ID ranges of a tree do
> not overlap, including the apmixedsys trees that define gates next to
> their PLLs. Fixed clocks and fixed factors cannot be switched, which is
> what the removed mtk_dummy_enable() and the mux fallback already
> reported.
>
> No functional change.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index d93c19c74db..ac173dc48cd 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> [ ... 100 lines skipped ... ]
> @@ -830,18 +785,40 @@ static int mtk_clk_mux_disable(struct clk *clk)
>  	return 0;
>  }
>
> -static int mtk_topckgen_disable(struct clk *clk)
> +static int mtk_clk_enable(struct clk *clk)
>  {
>  	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
>  	const struct mtk_clk_tree *tree = priv->tree;
>
> -	if (mtk_clk_id_is_gate(tree, clk->id)) {
> -		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
> +	if (mtk_clk_id_is_pll(tree, clk->id))
> +		return mtk_pll_enable(priv, &tree->plls[clk->id]);
>
> -		return mtk_gate_disable(priv->base, gate);
> -	}
> +	if (mtk_clk_id_is_mux(tree, clk->id))
> +		return mtk_clk_mux_enable(clk);


Nit: for consistency with mtk_pll_enable() and mtk_gate_enable() we
could convert mtk_clk_mux_enable() to take (priv, mux)

-- 
Julien Stephan <jstephan@baylibre.com>
