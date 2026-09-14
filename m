Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97F5C88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9442F605E7;
	Mon, 14 Sep 2026 20:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cVo9JFfB9S9r; Mon, 14 Sep 2026 20:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 07B246060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789419418;
	b=hESMroGKEGXxx3VHoyjbF9EGjnqesWjW5t0KFGDuC+50OTk6RK1AaCimiZMeFUzKj/CN
	 ouPQKdRlDo3CPL7InXHpCHQuX8oe44pTIHhDoZYuTyVVCtHeQhX0xlYBEJYLZzFF5QmtJ
	 FCniqRjwfL9/jd4+4X/DU9SzrgIR9HoXj2PaOoaLqaBAYuxcBQ6Xu3bItRmgM0YT1TYOS
	 VAPNrdsclgJWdr+SPywnyJ48iVqcGVzQvB2SfBurE4BP8FKmtpB+LRZTQ1NJc3B6aW0El
	 GlGppXzEfe3gM99yJ2g2flYF2NGHQ+R3+YZj+e7tctfa82E8i3H7Qg39GS4qseoVpFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789419418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R29OrTyEhdT5YKGkvl/JY1uhKtKUpUR7e5Hl923Oqoo=;
	b=soqCwHSgZspBqKDcOHYR3Feeyfd50XB7bNMyiTfhEL9aj5/0jcWTRUhZYE1b0UJfBRwB
	 Jb2a2GeC2dEOzrAm6uY5a4PgfZ59u7lta52+V03fwmv39JIxM/MqcMnskU1cFwL8cZC4e
	 5KDbvJIQXOpy3XrMP8jmucLtysqFl6OdGkAChfwEO8ZOP42HJpfaDXmiQw7xlV8eq7Ubr
	 fRbPltpp8E0EH8LQsFeplzMwy030i7OQxPoHEdc60pyxRJi4VKeiywaTHQKYtQetDH74Z
	 p/sHdpxg1QkBuJtJzG0i+hK9fB2t9AAE0L5SBgf0WPjT66NlKCiBj8/zstPeTlSjv0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789419418;
	bh=R29OrTyEhdT5YKGkvl/JY1uhKtKUpUR7e5Hl923Oqoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rbv+o7NkSGeuQkC1uZsPHA3EkIatBBH+Xib2pI4Xe4DkoR/6ktokHuWdk1/xcR8hf
	 2tGVkNVyJac7z9aoCyx7RCDOR9bBp4oUwpX9jtFM25ASi+P1aG1sZKX2Ian4uTtA1V
	 WqwRl2btSZML46DwUyEVrGcj85auP87ZuSPqs3lJLWxxZmapRCuZVN2X5iOjXwxJ2+
	 E+eSVnxul6xZYep0FkHD2tTg7OQizeitqQ+2cDMt4Bc1y6sOQA6hn53ft007EQpl1d
	 btsVhDqROuz19yj9Z4i3oaJmUXnNSkEugpBcu5Ts4FBxkvXJURyBfBvIL3BWyFDdf6
	 v3ZlBcrXiLPHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07B246060D;
	Mon, 14 Sep 2026 20:56:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 990B2493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79DC740098
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VClwavXhL4aY for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:56:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0699C40076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789419415;
 b=klTnFDM5fC+e8bmeYMVjRMYn0Gw2iMNT0ubPfqZELvYh6Hr+xxbjPFjyUHwPvbeAQCNg
 9WzXaMfR2ivLS1m76rl2C6uc0yA2Ci2wOp4GLUC77IxrD1hZeD9SRJHlxtg+V1hBJrXaw
 5M2MgGIVOqH59FjJ9krtXE7ZvXAKodnUSbIx73yfNA3ZmIWc1k9Tb2TOVxaspX+ocRLC4
 hMXfMa3GJnV81sI1qCl+nTfoAzmsjpWpDmQChYAVhsbWw4m8ZbGIBJF8LszJ0cUH1uSuR
 XOMSLL5wOQimHQ5XC2jkdgEwTLe3Z1hdXiJK/YZtFD9Gnv0qUcjoj5LZ0jJ+D8jOEJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789419415;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=R29OrTyEhdT5YKGkvl/JY1uhKtKUpUR7e5Hl923Oqoo=;
 b=F5uEycD8dzHfd6cyYlYNutWdSj1FbW2ZToZBUE8JURlMndkHLRr8LtmGolyMfCux5Mzu
 L76NebvK4njHihnUjeFAhrdHNfh7r32YOtADhxEkirQziEGPvV9j6YAT4y+Eb7VB8zYqS
 YzzWBf9IrVZ/oN2W1vNmetQgTfTs8+K3uA4Vpbge2DoK9NUY7C1KGIpJ1CAcM7vnvkaCe
 3TX95M/lEkA07hfRaREII6Itd+FA+3Er7P/2BJq5IS89k8zAy/wPmQf2t3nNRK8KpXg0M
 24DGThk3nVsTQ1Gng2oggLD3pE3tjzYX/tauiAZkrntgytIKr5DMKX43yupWTEmy+ZQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="D2IyS/U/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=D2IyS/U/
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0699C40076
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:56:52 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso16988695e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789419411; x=1790024211;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R29OrTyEhdT5YKGkvl/JY1uhKtKUpUR7e5Hl923Oqoo=;
 b=D2IyS/U/uhOM1mSiB1uGh/X3T+PyPXzjYlW5J7NKoe5h0uX0vD/zg/6vGPztwzWo2h
 i+1CXF3k558ici0pBamdmF+ZZImaQ65758qyiBTO6Hly7kbaq3uPcorDh2Rrs55U8bKE
 HdIht/lycerXH2egpSltkFg+80a+BRgAQrtq3HQVkK/AAXohPrjlQzp3lc/796C0cU3v
 ea2bbZ9Ao2aNkZpNiE/lkIotcs6bQN5YaCgDjU/H0zk+cMhSMi0KEUAqjF66J9/gewcr
 X5DJi5/GVq8on9S8cZCn0EkIqHIAomHsZom0Olx73v+YQcB3yyYRFRiOm+uelLyLUswy
 +whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789419411; x=1790024211;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R29OrTyEhdT5YKGkvl/JY1uhKtKUpUR7e5Hl923Oqoo=;
 b=WP50VosyV/GOJxVj7Yo3b0tTS+2WTQiaFnW8v9Zjn516OGiBYp84fnMJ5R/S99zrBf
 QLB2hR27LZrGlp31tQmRGSKW8MrE/xcLKBNEmZBi4wgSzwACpRUCTrh48ikxAG/L2cDN
 w1EDiFll/V9MwU7RJV5P2a7otzzErzjr1cjcl+r9VuvYSonrM/K86n+puWHQzsIjJPjs
 EfppNj5om7H73liQr/f4EoSlYI2zHa+CfC7SHtRx8yKer2y7NplqCNbBIphEviz8Qwoa
 1emyvkfsJ3nvL4CzWjdZPjiqg02zyhWYRI+UiDzQJe9sMquY2wijnQHnj4wTlzbgL2Cu
 wwmA==
X-Gm-Message-State: AFuF++kD0gAbG6ISaaOHwmgm/J9BRnsBcJ9poXtJqSLLPyxhOLTzVT8w
 8PQNRiw6hFpiE3bX1d3s0pWf9JS1jJxYUVTPxti+6dJovw4kkwkszerp+xlTnFLV5oc=
X-Gm-Gg: AYBFou1W6kJMcfNMCw4fE2I1o5qN084Tb+aZ61bbhPyLiSIx50jn6ubpzGCTt3r3UhC
 4K42qtF3bKjE7Km8O1KYRWRkivwAfMWqKf2cB68gerLnt1FsyRpaocCmNIesgai/Vy4lkzTbRH3
 SAA+06Qy+1mN4IPv5Ltrin0wprek+T2LwK3RMlHkt1B7Chfn2/egQGL93FA3fU6u9RWPvyU0m07
 n6p5/EfkhP2duR9FPOQjMy1pLkrlF5wfS6jVzutZpVtXsM250+Mjt6m+Zljqx2wbUcIrWyTnLvG
 PLeGL3HMAw/G7C40eEqx/nz5UK5/KadteB4gMksb4BTl9alYXMcpdVSmElnk/cCOfw5e/n2QnFw
 oWS3dMglrYKvQ/YqE00qN8HtXhdhYn/e/jnFqurxVEs1XIGVI1JcpIplQnNHW9HF+JLZLClyidx
 qY/NOHN1XA5l5bndKvtbBT96fUrE1kLDdGMITWLgRTJpP5JiHLiiQzPnTN77065yrc/owUKgYMy
 yWuiBETZiBCxPHtf1l3Fk2IDdmbVMzkjRMQ2ZCYzN0ISF4FaQs/7E/koA==
X-Received: by 2002:a05:600c:1909:b0:49c:f89b:f82 with SMTP id
 5b1f17b1804b1-49e7a677ab1mr82003965e9.12.1789419410928; 
 Mon, 14 Sep 2026 13:56:50 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef6bbdasm4576395e9.4.2026.09.14.13.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:56:50 -0700 (PDT)
Date: Mon, 14 Sep 2026 22:56:49 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 uboot-stm32@st-md-mailman.stormreply.com, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?B?Sm/Do28=?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 1/2] spl: mmc: select the boot partition after device
 initialization
Message-ID: <aqhe4KnMjO2HQiDA@macbook>
References: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
 <20260914-ccaione-upstream-part-dynamic-v3-1-a38c19e74563@baylibre.com>
 <20260914163557.GA1764417@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914163557.GA1764417@bill-the-cat>
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

On Mon, Sep 14, 2026 at 10:35:57 +0100, Tom Rini wrote:
> On Mon, Sep 14, 2026 at 10:31:37AM +0200, Carlo Caione wrote:

[...]  
> > -struct mmc;
> 
> Have you thrown this through CI? We have that forward declaration
> because it's not otherwise defined, and we wanted to avoid pulling in a
> big header chain here to declare it. So I worry something is going to
> fail to build now.

Hi Tom,
yes, the CI is all green. include/spl.h already includes <mmc.h>
unconditionally so struct mmc is defined before these prototypes.

Thanks,

--
Carlo Caione
