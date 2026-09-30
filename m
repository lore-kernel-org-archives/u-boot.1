Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E44CA5FC3
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 09:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AD4080FFD;
	Wed, 30 Sep 2026 09:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BaYg08He29H; Wed, 30 Sep 2026 09:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E171D80CA7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790761524;
	b=IXGESSpzHkiYOX1c75J/o27Hbq+vXiEWgpkPbHX5u6TPAKVaBGMjIvp8acyMjrziD2de
	 Y48lSUyy9EZAWytcf1J1Qaa3Peq4/QN0EtwXExHMD2wO4e9HzAWFnShKRpYtlJfzQrjvA
	 4nij6yV5F8ae/0JoUSs56GV/Z5ul7S+olX5PIUFaNK4qgoKnypqYJQ7389jg80+8gDpYm
	 v4xPfjtYacUU4NvR4PrOcon1UWrnZGYrlIrYifP6Q6YBPlknUYSTKQoINPrawyGnQbntx
	 FuXB3hPNaiCtKhoE0pnUvOuTZzCx/gLQOBEjswjcZqk8JumRU+aBoha6rVUb94g+Lvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790761524;
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
	bh=2A+EWLQwVd2E44QyxJ9W94ixj58AwrOducH907UakUg=;
	b=hOiA4a1OsHyhND/P4ZOPCXgrAnre1+HqYXy52FDv1+ipO/rnC0RSd9uXXaaLzRo5MrMx
	 vyBhN/6QTjXXzC34qicG+m+plZ5pV/JUx0T5aOsAUBnATh1xBfKMQcfBlE//vpXYX8+/F
	 5+EjXqRtySr8JdGfGxGPKOCjbRxQgprNjyKuOcW7ZFnSc9jgCBL/ov57gukU/9yYXMMxf
	 Y0U9rAYe0cYk6Z+UUvbSaNgl6evK+bvSbRUaYnynVrv5ju6yfI68xAPx5Cn563aWgQ4PZ
	 ymc4+yY1sKAjsEM3NuXBKgLEt99yMzqNu4KGwsn0i3phGoQ7/jr6sTwKuA7DcTGduEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790761524;
	bh=2A+EWLQwVd2E44QyxJ9W94ixj58AwrOducH907UakUg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YnWSRcmLF9+Rgx5NSLLI8vBxEaV1Zok8WMJiYxp6b6hIUh3HWFM0AMNMK6v0mHWcX
	 sjZg0MtPG/hP5syT9oqd1CBlhlqINDFsRB+d/2Z2ajEJ391NDt1AM6wuj1P+KGnGzR
	 w9hVpcnMHl/C7yS3dkDorH8kIxwxiCf1lf/jMl4LXBjf8knS7szvfhSV4zY7mFJI+r
	 q0A5mZNLJ7YBal8jBLiNFB0Yu7gxX+p0YGsnnqD3AZABU/r6ya46rvDxEdbZlBmME7
	 IGJSqac+q5jx9/8FTJ+WMx1vEAYsdzU5ZyGwZLaJOsN+RA/9M8dhHmwh3Rt5jBnPWZ
	 OxJPY0YTFdIGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E171D80CA7;
	Wed, 30 Sep 2026 09:45:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEC7A33B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B104240A35
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id StVl55OGxtLB for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 09:45:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 19C7C4085B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790761520;
 b=rlFoRtJXqpiW71wvY6iUCWc9CScOTnED5tFbYNEa95hNN/JvxcQRmq0skSkXx1wNGPM+
 MFQBWDaGDkOWa6sF3SGZSfF5wa3lT+jrHRlHbRFNFBfxrngnQJGOp+esC/kIcmkxKvESp
 BPxVesY/C7LxkR9MdB6UeCTzr2J2GPgSX1OFzMyoQBfscG9Q41kNIHHFtnGc07hzTxJFN
 7ywnqkroZ1fE6JQFcdaoG7yfRcxoqUhwRuwCqK2jkysMclzhOmWKY1zA1ZmwUJTlA9Kcs
 f6AQnNeriyvkZW69MW89d3s6vXmijqpYFXuUbJXGf/XlsDuCyX+myLefBVgXlTw+fiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790761520;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=2A+EWLQwVd2E44QyxJ9W94ixj58AwrOducH907UakUg=;
 b=KA1y8O8YtyNvC+MknmSoGxLLqiVBrIgzNwtoqHVzlgApw6NbvXxCBdZOVMV/7NALXvOq
 bvdh51nEwi47dByeqiKIW73TbUMwUoly1QvcJXbKnOe+5fGf36ijd3EunEZpbEIpiEXVy
 720/GKfbwCrFHhuK8ckEz2PG98leuROYqo4wlQASHaupEG8/rOzGYNxEQ+/1PHkGaHCp1
 Dz11+68x2K9a8yD8NkxFUlClgZbb29yR79dQDb3pQyxJ12zUalpU+vspGXGceKd4EK2Oa
 TST4X1FhY7GgWX8GgvxB6ijot0eWHeVa9PNaKlayk364eAUzN5d/Jr5XHWPlv5fl6WA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gk1Fn4QO; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gk1Fn4QO
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19C7C4085B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:18 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so29075635e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790761516; x=1791366316;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2A+EWLQwVd2E44QyxJ9W94ixj58AwrOducH907UakUg=;
 b=gk1Fn4QO8oAWTZ1EI31YXCOZKnyAigbFoQb8+GEbHdvybKa786fLtVtRB3ph3KGSZu
 2lORL0pZ3VJnd9bsDMboc8y2H7QnSOzvegKWP1qpIkR7QCSb9Jn7N1ZLg6Nme6TsweqD
 iMzuFP2KAoehwZcYFv/O1QQIYeWsZwsE2bqWZRVrQbfCxp64nokXOt3KioZHG96yrBXz
 9CwQOKTu6udb2OSyQlIu6ZuaoDz0EUa++Etn8QiEwMsKl86p3Xzz2CCYTbks3zOptzo8
 J3dJQej3+YbdtgPVEm7VnpxFnon8rhYhjSrVs4xLRRQIwb05jwZ2JtT3g6Voui6REjsb
 ZF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790761516; x=1791366316;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2A+EWLQwVd2E44QyxJ9W94ixj58AwrOducH907UakUg=;
 b=TqpvXk10NIC9eD33cKi1M8VsAbH+49Q485PMPW338gSV/oRVo2n8QD6SUh9SzPpjGZ
 NFpgX+LWZiYskcvexA+V32rXtcv7eU4w0wh5ssQmRBsvMoMHFX9sHVIsZZbODslNg1qX
 o6ivesGC6F7h9ubPdzCpAXFAA1x7p4eGESF7cOTlGdoYmoKQRhgccoG22nnVUUe8Oq6n
 8+AQJZ+ElqN/BBilQL0Z2Bq95ysT/5j8iK5Eu2TbTCqE57ZWEtnVpTAP7RIXb0+zM+9Y
 mcBKUwMNjVsXyvlhyO7jzGsbkICyWQpq7B/OjIgcYLwSuTMoQdRvl2eAXvwSxACOQCI2
 Uz3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzL0Nqtf7lEYlE1KS9bzAyP5M338Zoujjuc1qQj1y9+O4y9IwpkxtlLt3SdnDNUnCRXHTsqt8E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ndLnS+wM1ZeTJNWT7EbTnvrW9Ql8a/fmPcxglo+rZNMBYnP88B
 mAK5WOEXx5KUMIKgM07EgS0y8d3PCbl9nuntcurk0pYpPr4N5yJfr+HkeSgmJn0dDxI=
X-Gm-Gg: AYBFou3E9vh3hNWUXTeEE/Vkl7rmi/AyntGRngOGqs4yGpsA0wckzLq3daXB1HEKu5W
 TZ4v/hCleQL4ByuukqHI4VJ5dX6WriJCv1/1+/Y0x/f5SWmR1peQBJnClOIkc3v+V+0JW1pMBDz
 osPKORJxCu4QuV2fNYaOiu/izmAERmO+gIWwVomYktiC1iOFEPTib1Qfq8qUDw03YnrzAlmLJBx
 HFPc6sxCNlZkGrd+HIfF3Vol4+DzqQE3IUflyO5QxZKRvQ6n2k6F/ur0JHQ/FuAge1LTHFLr+h/
 tQAUpyviIt9xgfD2iNQvy0K8xtBjL0vxZiKrRD6hIzeZZPfTd2+XqkFormio54jubcbSIx+uEek
 Q3KZIUJA4qqnX3+nUJHzNP4AVfITJ3cCbAlRssKhpIDqqyje/kdnQ0OI9lXIA4AxTBpige4BnR/
 AFx+VghvG1HjJDZTOXchT9DDIEuMfd5qbmDQcGHXGfV/JBOmPO3MI6y3mtzoslgJF1LnScR4TnV
 pLi1AeIR0zgU/ZY390psH4UJrtEwTH3+Qgg5uH9dEPbj4T0NuNHKIsKipQz1bLcD73ao0Nn7X3K
 00hHbBpbJo7jjCcOtvxR1dS1UJYV5npJ9j7AR7mmiC6HTKsDaQqsQtiY
X-Received: by 2002:a05:600c:4fc9:b0:49f:ff7b:f056 with SMTP id
 5b1f17b1804b1-4a01afe1e29mr13256155e9.9.1790761516418; 
 Wed, 30 Sep 2026 02:45:16 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017468b10sm54109345e9.0.2026.09.30.02.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 02:45:15 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/15] clk: mediatek: merge the of_xlate callbacks
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
In-Reply-To: <20260924-clk-mtk-single-ops-v1-2-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
 <20260924-clk-mtk-single-ops-v1-2-1c3b5d8744ba@baylibre.com>
Date: Wed, 30 Sep 2026 11:47:31 +0200
Message-Id: <179076165161.1985961.801152555202224516.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790761655; l=1388;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=qDpy5jyj+r5TVhQlQMxH+n/JRbQjIjMEkK0g7JITVcc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI6mwedOKMNMARW2srtQ1ZCLxh6ISQNpx6ylZoZcb7uOzCXPYrTjxxIlf7jTgnFLv3QNVtHppHI
 v9H2IzRZJGgk=
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

> Replace the apmixedsys, topckgen and infrasys of_xlate callbacks with a
> single mtk_clk_of_xlate() that accepts an ID if it belongs to any of
> the tables of the clock tree.
>
> The three callbacks only differed in which clock types they accepted,
> but each mtk_clk_id_is_*() check already requires the matching table to
> be defined, so the tree contents do that filtering by themselves. No
> tree using the apmixedsys ops defines fixed clocks, fixed factors or
> muxes, none using the topckgen ops defines PLLs, and none using the
> infrasys ops defines PLLs or fixed clocks, so this is no functional
> change.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 78ce206197d..d93c19c74db 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -177,6 +177,24 @@ static bool mtk_clk_id_is_gate(const struct mtk_clk_tree *tree, int mapped_id)
>  	       mapped_id < tree->gates_offs + tree->num_gates;
>  }
>
> +static int mtk_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)

Nit: Here we drop the const qualifier present on all other xlate
callbacks. Since const on an integer return type is useless, maybe add a
comment explaining why it is intentionally dropped?

-- 
Julien Stephan <jstephan@baylibre.com>
