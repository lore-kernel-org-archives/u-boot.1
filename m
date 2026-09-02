Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B383C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DC7A608AF;
	Wed,  2 Sep 2026 13:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7LUDh7pbSDQB; Wed,  2 Sep 2026 13:00:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788354035;
	bh=eF6dkpvatMViJnUbZriL0C2dXNGnjNm+SS/O535R9XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=apvUnXZ743O/Gm4a+nQtmK5xG0iVbJIGEQZjisIzxkStzjzeLEjfaHKlKi6wSZ7pE
	 BTOFxEUSPNcQGQkDrUvMc2B5xy1rD79aBWcRfaq7X5CHNqRokvM9wZZr54ExGjmg5+
	 ykI8TBNrKKiR3q4sBsagz9RamKsdZzwLliC9FqwFyuWe/Xdiz6BRnPA86eEbD2cuPN
	 YGVV8j05J3ysFLSHAsQyizz2JMoGYtyWBdwe8DjCSXikJw4A2rZUaDbAe9vkeKdD5d
	 wVL7ScxOt3eJJqVqZAI/CDS4DBzTuIiJzBWEaIY68pTizM417urPDLEEOaIgWwUhVj
	 Y549qjGFJugSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87E2160726;
	Wed,  2 Sep 2026 13:00:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6F8C127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC9774086E
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:00:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HuhCS5TyZAoF for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:00:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IUNvEFvs
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8B844084A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:00:32 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b8be0409fso7358755e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788354030; x=1788958830;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eF6dkpvatMViJnUbZriL0C2dXNGnjNm+SS/O535R9XQ=;
 b=IUNvEFvsLx9dJtHPzkuTFiqMKbSPGZuJAn5OkWrh6vxHA7jnTrXOVQZ3+vrovxzhwH
 ts1KrpCNGTvMcGuBmX7WbVRGIaY/GQj+eSJiHQfnDBooImB0fM7oimkWgMZi3rJF7Jkv
 zLyehQqMcIz6P+kRK8JL60x6AYH173Hv0w5xICX52KfY1TbOx7A91suD3cY5xZ7FB3wo
 0XtUSokcyl5P/B7WBql67eZrg60XPB3h/b3r7K5gshPmGXzrT1zQ8ns3gTvkRU6rk+GU
 Hk1MlMBFtkQljsgcIC6dcT4qnpAk16TAS1Xd6Lm24ftqbn3XC2jXm7DVCWR2A2/eDQ7K
 Ilpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788354030; x=1788958830;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eF6dkpvatMViJnUbZriL0C2dXNGnjNm+SS/O535R9XQ=;
 b=UWI4L3s0lvhnE8ah/cnvKQVriPC9fk09duz8yHM+KBl4WlxM7Ma48Eru0Oqj/EuABd
 79EvIvhexduoE4znjsp/3g5W2eEYECRMCH0Q9HpxvrJrYGpdpE5Sb33s8sFmPwAdWy3Y
 boq0RoHRM4uAAyleJWLfEBM/7E1xmOja25d87vFeIDFDj6g+dL8jdv+nomrgPzq45X5B
 GYnY2sHzX+/aRBggn11K6ORXjHpSOuz7vEptbSp8/lCs+Z218q+G8oM039gHCqf5B0mA
 r5RC5h0Ybi8/gGUkcFjY7CBjpO5HUnDIi9FTca1ux3cj0R2wvlbPHF+81Q3UGVO72Alv
 MtIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGsbcTH2FNDFWNEKwRnapZFGSVtU6B4NHweF8dwn8PXZKrx2W8ZOEFnJFUsrVKto55ECH8AwA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nH5vVmcgX25LX57wSZ6lDddyw/OCZ0fIWq1jxl/p06yVLNLCUO
 4b7XBp2LwZnBY/k0kT0RNBfJu+UmSEdjf7eayQ7mhSAFQJHT9nr3fQHKOgW2Ll0XR74=
X-Gm-Gg: AR+sD13fujlB2hL+FPvybs+BzZxasmTzwGO/qMAO1Sknq3Os46m7B3+iVXd9hhDUKbr
 MoMU4JLRtC7+wANtGCfV0ixo2dawn4RbPKGqoCqXwmcL+rcqAj6J6a5PSa9t28mwEl1xpUkKkUX
 wqgN6e5WjNHXZBv9seIHkh0pszijZ2iJ3tyjuVj2tCPFenoFfP/oWYVD+DzwRLRq0keVBYHPCgQ
 l8NPInUl/1VW1GN0V8W/VGceJAKPCIXbbUwL7ALB6setMM5scTt/cJAtWXRhwZhaWevOoTlK8TB
 KThHl0RitT7tWXpM88WyLs0lCnh/UVmvHR6BxLgpL6LSV9CmtgC7ae8RUuIZdVtB3ioxos8axcB
 lYsgHkj932cWI8Yj6nhfn1eHGfLnZDgcZT69zX0xuoZFfrhY5c6ZPVqRovrOjEFL9h+5TX6kzGA
 GfsQAYcl1k6eoJVRVp+0TPUlMN6e3dmm6sU7qnvQF3Lw2JZCzk0XFIdlIFKJq9cuH6T5wdH2FZd
 LcJrHu5h75YJUlZrSNRKkjSYkRVE/CGPPepICF8TJdnxns0C1gn/9q520xBnwEHnT0ybgUAwZ1A
 a0mfNC2kMQtarnA=
X-Received: by 2002:a05:600c:c16d:b0:499:db6d:bc97 with SMTP id
 5b1f17b1804b1-49ce55cb47cmr102789475e9.0.1788354030376; 
 Wed, 02 Sep 2026 06:00:30 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47820e2sm70487975e9.13.2026.09.02.06.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:00:29 -0700 (PDT)
Date: Wed, 2 Sep 2026 15:00:27 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] configs: mediatek: remove UFS defconfigs
Message-ID: <apgdyB57olrpOZ_r@macbook.homenet.telecomitalia.it>
References: <20260814-mtk-genio-720-remove-ufs-defconfig-v1-1-000eb476030f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-mtk-genio-720-remove-ufs-defconfig-v1-1-000eb476030f@baylibre.com>
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

On Fri, Aug 14, 2026 at 16:21:25 +0100, David Lechner wrote:
> Remove the UFS defconfigs for Genio 520/720/1200 and enable the UFS
> options in the remaining defconfigs. This simplifies things a bit, e.g.
> it makes fewer builds to run when testing. Users can instead use the
> base defconfigs and pass DEVICE_TREE= to select the correct devicetree
> for the target. Or alternatively, include devicetree overlays in a FIT
> image that can be selected at runtime by the SPL.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
