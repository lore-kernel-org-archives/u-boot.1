Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C86BC531D0
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 06:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E056C80C98;
	Thu, 30 Jul 2026 06:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kP7eNnqPW2K; Thu, 30 Jul 2026 06:43:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 104B480D7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785393832;
	bh=DbsD7NQVC0bBYRhWMUZwChD2R3Gg/Li7lJmlnJlNt/k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L/kMzNn3AbdUEtvZdNtXPned7YIcfZUtEnvS8FuncehOXcQ5bTluZ6bJB96HQJpBc
	 1ux3HrX4gICOWyAzPGVkZ1uDWkiejA32mScr3CxsG1RcJk5qmim4RmYVue+EwPk1EQ
	 2W3ndKyR8Dr004KRqMrfKAqufHo+iqFfGiIi29eazwwBU2ExGcmP1/8rA09X0AJlDZ
	 U7LRHyb9oRhCMpUjSH/qUjI0C4XdzwY9SwUtrKA91v/hwaxCDsBX0qIqL/W/MXOW9G
	 9mRhODkUkMYdxXlAOeaDNVlCLZZVxB69spJWWSKpktEVG60EProgGvrVBzJ1sJvNhg
	 gFRAQv1P3BAag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 104B480D7F;
	Thu, 30 Jul 2026 06:43:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 950B627B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92D19406EA
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p4o2w3OqVSnq for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 06:43:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1E526406DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E526406DB
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E526406DB
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:43:48 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4956869750eso11671545e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 23:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785393827; x=1785998627;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DbsD7NQVC0bBYRhWMUZwChD2R3Gg/Li7lJmlnJlNt/k=;
 b=rgZhXotLTxsZuRCb2RDKcGXH22Pk9hpjXu9EdBxw+ndksbh8gYAVittuUGApar+pZr
 VivocoW0vwRUlrLxtKLlEQUSKZtSUSY838UFBAjPkbFB70EJbiphITVy90cjvKFNscTU
 8N8WfiQ4I41iF7t6USzxmtiurdxGIO/9r8W0mu/spc6ue2XDvFkvpIys//JNMmLI7gIt
 UJaMhZc20RrxjRP5GGapfROVcq4M5Qz2NgX1WrlUIpk6+r8Su3oEXmqUTFed9NDyCHKA
 oUvZY+VBp2LWKwfNMvZwWm3g1U34DyelegwhzZcZZ0Q8xDe+/MFQEFpM1ijzIob9oJsK
 K19A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp151P9B5+xm5Vcmh34zX9oNYKD6a1PzAQeGEIRs6s39aTN17HCpRkhzRIGC6mzM07uX20t1ss=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx5/zEsz7SRxmFeuEHEWfbVO4nzqXfj4Ne2dmudzxF7swPKe1jT
 oPj3BTr1eMJ/a+IU4mpMsr/n0K3rgW6Uoz66iArBYzwDsYAn6CjlOGqZXq3EjRBQvr8=
X-Gm-Gg: AR+sD13pD+evj65dbLSyeIe6iY80coFfkDw9mEGKTJ+5YwteHw8N0VldKiGo/9AG0W2
 GXZHhNQY02DUwV6fdyQaRtKx/pxz3HosLaTRrp2rInXDn5Emdph3KkpkcaTJeMb35EtgX/eIRD2
 i25cJaOCaM2ByuCAeGkh3FzXKcEnuuJhzafc0Zt+ufdr20oiuqWBa/T92ZRJzcvKjO2gqWH7Taz
 BVybh2pBbubsdgaxFhnBtxxtVYUONMnGB5VMXncxBSV+QdOXwKD6oGZLa5P0RLOGHO0T+FcQJED
 FUppzPEnLcN+occZmQW3cb5X+XoTKY/hHDOVjeZ9tPgcBcctr188kfVyofeAGP40/twwFQG1pQq
 yuwnFGoZWCHFj/GpGiwXpAyl8eGe0SejfhPiIO0/W1Dx7bKXTY5VgDLjGqxIBUGV1jz7Rlft9MB
 EboC2UHZ3RfgvF5FQU1+2aKPLVhbMoG8B4wdqI2Vtfx71FxyOcqYgyPZgQx3eo3oFIF5UbS1Nao
 nv9F4ajFzENWSRUAizGSaoDn+Dt2BIrtDLWZMkwinvnkDuy5PTmatxL
X-Received: by 2002:a05:600c:1990:b0:493:c8a6:b517 with SMTP id
 5b1f17b1804b1-49800ec0955mr15058845e9.38.1785393826266; 
 Wed, 29 Jul 2026 23:43:46 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d7097sm3229523f8f.5.2026.07.29.23.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 23:43:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 08:43:44 +0200
Message-Id: <DKBPAG07RZ0G.39ZG8D1VRQ380@baylibre.com>
Subject: Re: [PATCH v2 2/4] configs: mt8390: enable eMMC FIT boot from SPL
Cc: "GSS_MTK_Uboot_upstream" <GSS_MTK_Uboot_upstream@mediatek.com>,
 <u-boot@lists.u-boot-project.org>, "Ryder Lee" <ryder.lee@mediatek.com>,
 "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng Yun"
 <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Vitor Sato Eschholz" <vsatoes@baylibre.com>,
 "Macpaul Lin" <Macpaul.Lin@mediatek.com>, "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Julien Masson"
 <jmasson@baylibre.com>, "Johan Jonker" <jbx6244@gmail.com>, "Quentin
 Schulz" <u-boot@0leil.net>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>
To: "Julien Stephan" <jstephan@baylibre.com>, "Carlo Caione"
 <ccaione@baylibre.com>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
 <20260722-ccaione-upstream-mt8390-spl-v2-2-7aa005345711@baylibre.com>
 <CAEHHSvaAAJB_c6CVQTzF2_Ete6u038p2M3_y83V-Y6_Pt5stjg@mail.gmail.com>
In-Reply-To: <CAEHHSvaAAJB_c6CVQTzF2_Ete6u038p2M3_y83V-Y6_Pt5stjg@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785393827; x=1785998627;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DbsD7NQVC0bBYRhWMUZwChD2R3Gg/Li7lJmlnJlNt/k=;
 b=S+u17QKVJ5wQ9iNHynzghX1rnr5J3Aj9u1RkoVeWP4RFt3Gv3vgiEFqmmY2t6BLyO0
 xjtqzhZoyybJl2BiReqP2PvRJkKJuqt2IiGlVS2dCYKZ3GsRw5IFPVhmzOMjnBcBvnGY
 H4QMfhqWPbKBhgZuKl4aWY2FSSlaIK++sEnXHpd8wlE7L//e1BA43O24ItIitn8yOl1Y
 Flb0VGG1LDEWWEIICeMX6JFMPJnCVPJIUePn9yojs21Hf3noyo6WdIN2/5E0TTVlTmiP
 J6k6VN5NzY1SsKGOWWfjksjU4Lba1akYzIsnypXWZwKivdMlA8x9PcyxLo0f3Rf2cmlU
 JAAA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=S+u17QKV
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

On Tue Jul 28, 2026 at 6:00 PM CEST, Julien Stephan wrote:
> Le mer. 22 juil. 2026 =C3=A0 23:36, Carlo Caione <ccaione@baylibre.com> a=
 =C3=A9crit :
[...]

> Hi Carlo,
>
> Did you test on Genio 510? AFAIK Genio 510 and Genio 700 are very similar=
.
> If it works on Genio 510, then all theses configs could be placed into
>  configs/mt8188.config.

Hey Julien,
I didn't test it but being G700 and G510 so close I don't see why this
cannot be done.

thanks,

--
Carlo Caione
