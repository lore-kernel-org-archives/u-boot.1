Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0467606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y6R7zmxY;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MQlh5xtJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF26A811AB;
	Sat, 31 Oct 2026 09:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7TcUjsU1EPi7; Sat, 31 Oct 2026 09:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 077A781166
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439410;
	b=SzAjXdg9PpCNb/lgs2BgV82CvEpTGYiNXfHaOhgzavebKZwVyAlvTwsX7dNhx4y23K0P
	 UP2hI58lzTDj1gODIETlVknp5ME4EVQ+K3w2kYWdznRkXEIXPmLns4CUQ6+kn0bX2CNOB
	 DweV04l4jqu06WD+8H/rIEgh50mvAMXB0N6Pm1/PEsXqOK0raHg+u0bn4jYesuogd+eGz
	 9qBiDaY2Pro9Wgs+9vfe6zLWMaWjqDu7JwfrxZRE6MRsDA/ryK/3EPReWPvG4KjbOlMvi
	 cMAcIKZHcmLpORlXswXF9KOeNHR+qK3T8T5GT0BpxlOL+H+YkBlXRFpIEkjzz1dLkoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=N5mx4CjdiNepE6EAgwGdIOrBSWWnz0WbZoS0VfJZdpw=;
	b=E/gS9BmUpV77YxQadf3p51DT+x1v+4weWritRlXkemBSc/djkwlk0N/6WCTj43G7jDA3
	 l57qi208yTTU6UjCaQiQh4pDZzmXy3zuPcL7D6syP9EdH26Akci7q/lqEBjPoeQEEQHdT
	 mH4c5DhUGWaJHSRO3jN4GV02QmB6vsFDB+fsTzL9/nN734lP5LoMbBOkvj9FR/O1KRUBr
	 /prPwpBHiE07TSKxC+iQ6Fq6nQfGRECWb2aFcSXaDHk+s0/fyeqXdENAe8dfP+At4AHV3
	 VYaC0CNXL8ZLIdRp3jD8yKH+Dave27BZzvlZRId/HL5Gn5TfLraT7QQlRDC4KRnZNzg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439410;
	bh=N5mx4CjdiNepE6EAgwGdIOrBSWWnz0WbZoS0VfJZdpw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y6R7zmxYwQvsmSn7HHbXG+MBppbHmUT5B6WEilt3eHxTWnKL3pygNIEghTql8QXzd
	 fnwATlSUYCaK7B455L434TZK3MOuF63OZi7MrZ1FdzJ7lY4gqr8SMrGv1JMD6zI7Ee
	 y3Ioqow5eAurfZLNR7gk0TYkLx1V0BC4TuIpSLSfnm2iRd+0mSygXmCRO7v3F9/Mo3
	 D8URiSNn4nW1VwPvHcqQkhQndtDnpnsYupwR9kWB7t29wY/WCsxPZzqOI/Pc6w6HY/
	 R2bGKhi+hFolQRzOHGDSfmqGs4NC0sOc3FzTK8MfcaQB0N7AMHd6qnNyZu5tJbLKmv
	 5acqBQ043Mfkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 077A781166;
	Sat, 31 Oct 2026 09:36:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EDEF32A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54BB5400FC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VaCxT0-F-81h for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 67D7B40057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439379;
 b=nBvdb1qaa810Ij/5iG/97OpL6TDWLgvzt4Nq1C6qxPrnsMFvOAZknIPU4f+Jode77MXD
 8qOOFv16mo/iLahZWkIKERe205SY6bJPkKQvMXCeA3hp3BWsLj/YBao/5woxNpaYt4fYd
 XP7EE0wlBgYcBW1/HexOf831pIpjdZcSQQMMfF7klr9sETDPV/ppSJspR6BRPq9wVqkEF
 fGrSJKEERbqJhmyP2BWhhh+jrisVMW1r6x5AR8BMUBi/ThyG4m6m0vdYVBTrpNXa1XY4R
 7RUffkm4XwDtn0TbFcSbW5760Hbv9cyD78sY+z1rC+8dVfGHnIe7dphjgn1aHtWqoqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439379;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=N5mx4CjdiNepE6EAgwGdIOrBSWWnz0WbZoS0VfJZdpw=;
 b=WGyNh84rzRVs63lE0WVAPzYl0iHJpgJYX1huhANy9C4gwrKl13wVrQy9r/b+M1nYWw+f
 vZZjea7L+9lz8x9870KB+lhDFojyaPU70YFRm6FHEpQ49iaNIKYmSCTkSwsVmTC8lexPC
 IYEt/Zia5YoBbqhJibxZDeqlyO+J+XtBBAaFpoEUFviQE4pe8PMMm8HUtvcZOryKL0Tl5
 mANQv5ABGDVa0aftzJlQxnpSHDKfzFl5ssxmw9H3hEon/e8Xa9H/1DxmNyDbmbFDvOhh/
 YiW1IbroCiqlxGz76jwiuRdiK6p9yiXmDRiGr/lZM4EpVoYfRlqGWOxNwg7/BLi2AGA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MQlh5xtJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MQlh5xtJ
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67D7B40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:18 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c40e02b2ebaso246769366b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439377; cv=none;
 d=google.com; s=arc-20260327;
 b=ivElxZN4/KVU5XFkKHpGO6ZXylP2/b1KNwiDrLHnG1vrRyCCiwL5eW4x4TUiJcA+Nh
 IAVqIDKB6D73lsrlTK7UzLx0rss6PK8sGEKO19+wh1VeRUTGD9c2lgHbqxY1ALgWM2bQ
 39QHDHIzuJk1MIHcAyT+OK267ix/Mhzujo4VlMjqVhrjNRDkC5Jp1rTlgz8kGDDTSUW/
 xyMVonL+Z6PiQZ/KV6x1z/ME9HQNyXCkbID6Y6IoygAs5l/d5bIy+S5uvjiq9kGsjVGK
 q2VSclZhC0hHj65idToWqnNRNJKyMwKt8HEXwV3s3V4iLQIpleoHUrb9X8RUwMDUzE6e
 E5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=N5mx4CjdiNepE6EAgwGdIOrBSWWnz0WbZoS0VfJZdpw=;
 fh=JLxib70FeXAAub4E0CuWTb84jm4+LKCl7PpPAqRl91Q=;
 b=kkgOZoZDOGi3cjpGX69d/WfdErqHN9r/A92lR0Ad5F8m9t1/mjB9csbaTdYSO/GUge
 WjCG/wJy/OI+TsxVpOAzI45GOSATD4qNzSHeDiu/i9g5yyCV1dRXGr8VSYpa9L36D9v2
 0Oex5UBs83Zg3xtaBAYiFQCZ9SEJbxDNemsYSMClSXhUYYsIYCxdY5D/QUNctWnuGYgI
 n3JqOyb02cazsDA6PCTxyiU3kom60wW6+pu52SsQLcqhC1GidaHw+oMtP6VUrJHqi2kx
 /drJ8eGgKLFKqB+26aT2HsCT6npnBLisImSmSeWy/GQTL8AbJfUKhzNdRyV67TinFnI2
 hkvw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439377; x=1794044177;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N5mx4CjdiNepE6EAgwGdIOrBSWWnz0WbZoS0VfJZdpw=;
 b=MQlh5xtJk6vvfoVgIiXLw2YCH/D6M6R3fMTZtiDQyztrCLZu4gt74WJWK4JfRu6zo6
 hlhddsltR/6sNMGQHlXClJopCIIXV7n/ThEZZsrLOxXwIAMCJoPXwka8YAlH4fTDLwYJ
 jmKzlaxfnU0ADkidOip02mr5cw+5EN9+cTLCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439377; x=1794044177;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N5mx4CjdiNepE6EAgwGdIOrBSWWnz0WbZoS0VfJZdpw=;
 b=o/ih4f68Dc+Jd6GxTXV5A6nxl/i85/UR30NL/hf83UqFbMAirJp+8j9qJq60djpuTi
 JGw/cNh+a2htTu+f7/cskCCwNhgn6Aug9Rf/yeXrZoZkYxaBvNG0NmJSKtcfbPYli0hF
 +P1CW3Sd+kx4VfzRGi9d2cUQQSIGOJxgEi4Z5oGGsW3KXCTAQBjP3/7zaYPYGkmZogMX
 OaY3xfCr9p0+w+NWjkm4xaEjq4z0UPMClTWHsv/Pu5pcgWbBjUWxPy6UfUCerJvhjDu0
 37ELZsi0ylc/yhGwRmt8JBVYeX8BwiTXMqG8G9vzoi32iyTgK2sc0pzQX4T6my9HYaM1
 lFsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9P0GNSVvC9FI0o3UFARtPMnEOFwIafLrnR/7+6n8gn7BKVjk1m9vII3/2B5iwsBbNLl3iAD4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJqtOisU7RjNcF3kGEydDJPyRvSUxQf3DV/f59UXlBXsm1Oovd8
 VmOG0ZuxLlAPpePfhTMkxtQBQjIZ/8SrFeQYlV3St2I2jUuQaROgcpSyKALSeEVmaNLVl/V9tJ3
 H/8xIO7FIH1W21QYj2YuRoRPWhC55B0p0J7rezDaY
X-Gm-Gg: AYBFou1KtxVKxtG5BXaRrvkZiKr/LZXn53MgURsO+/X4tPLd+MyEAxmgFk6yNkPOWN0
 ZPUMgmVr6/d+SUeYEkIxYNDSMqDh/B1LXWyhZDCRk9ZuCBkoriKe7sPWWue6EM2fBKwMyLRr6fV
 cPVuvEzrSvyMZQh9gSnEtcgmhg/MBQu9JCLgWPkYczGD3J99E4QZIgngAL9P4BzsuAYq1Cjw4cx
 HxEsKanL/wKuH7tgtcdrXWB/r35xMMAbSQ1VRFDAextdh1eABhbQlMcFgxHfnXH5g/FXSkMK47v
 tylqWt3Kr4JEPOXsYyGvD+t+wzHf116g2U1viHyEiJ+MXxitstI/BZS0gktfU3j9vZCnPDg+cXP
 X6XKfB6SW1yW3ckNOUc+VZuDt4gpvzIl6tCjcerQpwyArA7CTu4AB7ZfpR14l4T1Q+HPBszE=
X-Received: by 2002:a17:907:9c06:b0:c2d:c17f:205b with SMTP id
 a640c23a62f3a-c4ca7ab276emr383212466b.40.1793439376979; Sat, 31 Oct 2026
 02:36:16 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:36:12 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:29 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-33-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-33-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:36:12 -0700
X-Gm-Features: AclHuK9_MKbypHzGs7OuOmCMr-5J0Rwn2dw4m3-oIscTUj2xa7c3pj872VJwOXM
Message-ID: <CAFLszTgCE9TCQAJ3-N+bqvr5c2AMRCQ8cT_v=Vu8ecbV_LdC3w@mail.gmail.com>
Subject: Re: [PATCH v2 32/37] clk: rockchip: rk3528: Fix VOP clock
 configuration
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3528: Fix VOP clock configuration
>
> Setting rate of the VOP clocks never changes the clock parent and the
> old divisor value is OR with new divisor value due to incorrect args
> being passed to rk_clrsetreg() call.
>
> Use selector and divisor masks and values correctly in rk_clrsetreg()
> call to ensure VOP clocks are configured as expected.
>
> Video is not supported for this SoC, so nothing is likely going to try
> to change rate of VOP clocks until video support have been implemented.
>
> Fixes: 5a7a856b132f ("clk: rockchip: Add support for RK3528")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3528.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
