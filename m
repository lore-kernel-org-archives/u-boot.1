Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33B1C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 16:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E5F880E31;
	Wed, 23 Sep 2026 16:14:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uifh_rI_uQHN; Wed, 23 Sep 2026 16:14:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B992C80EFD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790180068;
	b=Kf1JWA66lx2v1jNq03BUyT053TGt5M2gQT3kCA8x4R/nAU+VkFOSQ8n15pnh4AadCqNF
	 fgW4L1ccYRxpMf25PbJmBi7da2Ps7DhYfKiBh01SoGafl44u5lrbaKezF9Kkdn07x1cUz
	 xDxU+2FsVyvpNZtcE/zX0u9VSK/xWtiXMceZDcQVoDcI1+8obd6dI6nQcoDEvO5Cnkmoz
	 uOejjra137nR3vVBC+8UVkowHp9OAtmNsRGzwievLZvlIy2QlyEJSlh7sDhQfQnnbP7lu
	 DbfJHbuPlX9i8N1WYr37zW79Wv3b8rOdog8dJpGFSXHImP8X4lELqNkjaRxUslp1Kyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790180068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uW58xESLOxRVWNbL8cYYBgeJipVjZ/5MZLvxhg0NaD4=;
	b=f8NqeB9Wa6JKHZXtYkyLmle6+MpdvRhj2dtzFyrJJ0152O7dNY+6kEMq0YVu/J7C/MZe
	 NxAPCRdYS7wv4FpzDxiSFu31r+yxDnMQPYAQjCKbkVt0F3QygFHbHp1ESoRk/BO7Rk6WB
	 tmxhwjPPSAFqVxVYConVcfSIyHXS++jeurrdA4tmL3FFyA3T2q2lQQyr/XG2QClUGHzsa
	 zNEggpQQChZ1OhjyiQz9Ka/qMvFGCHdXlf4vWyu5s+TDt0KFdsZSxudsZUogznX2D7ZK5
	 QSCOYivWtop7UMXdS2gG1kO+dKaVoeAJNkwm4jqXu4H9AApJsbctvqqnagPk1IzZkTw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lFtUGBru;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790180068;
	bh=uW58xESLOxRVWNbL8cYYBgeJipVjZ/5MZLvxhg0NaD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=meV9nu50AttGgpgBB99Q9xYDMn3Gv6WgL6n1U6Q4Br4akCAKYZQGk4VHoJJp+bgIO
	 d8zPFwtBnQfRQ6l1pKVWNC2jwxUc/BlGQ8KOzizLgCMBlnTA+sZVc4MEnWQQFx4FKA
	 xNtEXVeUtPjud84c7Zmcw5ZnvvEPfhfOSOcW1+S4Z9T576GDR5+5gXya1VspLXBeyg
	 +jnB8rEBPph25LqGu0Wyobb6n7vf2LtQefv1odNUI/jetfUrWH0w3NPYBXlv0VZcve
	 7vmElWYe/HlpXQp5VNyNPOIHRnjSRGpAa9LlEprbdzK+qnjp+JfM90KCmppLywomeR
	 Wa5ZwgIh19rgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B992C80EFD;
	Wed, 23 Sep 2026 16:14:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7EEE13B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDC9D80EFD
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UVt-yr9kX2DU for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 16:14:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ADF2080E31
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790180066;
 b=rSMWjKIEZfgHbBQmDoZzkmgpGfhTv6RkXqqeeRUOrJxzH1Unhj5cN4IeqvWYQZsCcetd
 q/CXfsL3J29L96S0LTQbKKphsGvtawRmxvRH+ker++nHZGlyOYYV2OJHNat8/G+MX5qb7
 1LPJseMaabpYP5G6oA/UQZ2Nizyrm+iZrZyM4PKhTBuWOR1SfXIsEFfSCimiZS8X7HtVF
 irSbPVXOWpA7QnZS36WoMkCjZIlu6oTP1q+POQQ6QAu/mHy4b9S64y3s2hyL2fKInLcJy
 tCb+AUSgUpme1fMD8Fzpngb86oCcfk8s/XanFumrPjIlkj6zQk7kEZGDmJPeMzHtS1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790180066;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=uW58xESLOxRVWNbL8cYYBgeJipVjZ/5MZLvxhg0NaD4=;
 b=oZBYu6+6rO2pr/Df647nDIDAmFNI1NBZj9iyi9X+gJVKqsSSCw52dixilaM5xQ3sRVKa
 RlXyVoj5l0L6wObn4Lnk/lKGKAxgw0ahSYIIiiHSIubUdWPxuLJeYo9grPH7HHjygOhMI
 okinNrQwLbkLyrQN0CpSDe/n2cI0wPpXwusszfzi5sLWm0qV5kW4Y+b8efq9TeLQsrhp0
 ctJVIypxq/3CNnF3r3Rw+Ii9Z0uHoNgF/gQRx/h182sEiwyk6Q6CfTJjy4NLwI3vmtpAO
 6mNxrYLEQh1z8KR+PWJJWpuutW6szWiTzpYZh7YW2ct7e1QBTyXrJuKnZQ3ZdcQ9PeQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lFtUGBru; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lFtUGBru
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADF2080E31
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:14:24 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so8478155e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790180062; x=1790784862;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uW58xESLOxRVWNbL8cYYBgeJipVjZ/5MZLvxhg0NaD4=;
 b=lFtUGBruSaCeZL1oBYND66hGdzEZRkvrCBMsRT13N6GM0xT5dRSoqB0mAsFXI5Vmne
 ns1PXyL54kgfUJOIpdfxx9V2IOgDIbnPtF8bBbE9SIDoj9VtXRQfu5XsiDiTGDRoYfch
 TtVsXcu/97skyd5O4VtNflUY5phjYJsZ3LwuOXDSw2SOAfy/NWF+p4yI3aWo2fCV1l/u
 hkUpvjXPEyGJzQ7cjAQBDJyQRPKm1xWkSQNArTYFEmH95Cc3zuoqEy49RP6RV+jeDMe+
 dwXy/5QjAooYGdaq1eOb2OdEUNdWAUwsodytcn1nGBWuumIUKh2L8jtMSYtCyRPLK7+l
 yFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790180062; x=1790784862;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uW58xESLOxRVWNbL8cYYBgeJipVjZ/5MZLvxhg0NaD4=;
 b=MkkfDEO/tL9OMu6ypwqS0vPeNhEIyFYE0fX52UXhxkZvZJS+/kiJu09MsB/PSbHub1
 DJxbBhmWzqYeemEos6BwrHCWUjnLpCvQE/RYzRV4NGn6PObzl/fF2Rqa9roV/QZ7Uhi0
 vxaHujVz1XwOgnoeoLxqqdQWlW0Gfe2G4JOhpu2+OwMWHc1WtgOBmYYTlb0qOyFYJZnD
 9sUygqOACzmhmBrNaXX7GwXDPxReEy0FPkF6F8PrWvA8zUKtdxufwwGyl29jlCzyU8MW
 ETfT+m13LK+TWRSI9kePE634r6ODSkjVmokCm83wlo0bTFj80SzCxg00BI2rKrHcmQ50
 Wqnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5bWJhMC6Mc7d2WoFlzwK+AHDijdcyt3Bm+hxDVcQNF/i2cD8IKb2Lqq59z2vWErCHqMLcxAk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mBIWDALGV96bhUe+wc8SvXUqwISV+m2nwehKoB+NmwmdqsoCyT
 3kOezTwUpB/YDUWUo9MIiQynBbeuf3QNX9qlqGWenEwEvxEgWREJ7Kqzl+4uD7IbZGA=
X-Gm-Gg: AYBFou1pRRcTnUapMQP4cW0/LGT3rIMeu7aBZhuTGLpRImyuHyuskp9B+6xiXTvO+oN
 m9MxZ/CMG88Vew5tg50QHVNSQE8oOJWLIIOtXEuuHji7OUqz41B4fVMcxOKoEfhKZ9whTPYLZL7
 ObaYJ4hD69+ZEpP7VDDniLwv51QkVZFMmvi7plDaYNh9fKW2l4TKh/3IkOtKnrU6i0Mt4H+vMWg
 uVvr1m1ZqPdw5SvmbG3Fbmp8vd4HxVZxY7juJctA8ioIy+iEF0lYvupzq2owSmLgzbfBz3Jhaul
 qH+cjoU11SrtS1L2y5XQg0CgBogrNkIb/UuoxGgjVZNvEAU2Z7iUjKIRxbW/TfKnLo11cVbk7Q3
 KlXDrwv/n8KQs6Ewbaiff79k7KTmIPdLxyR6noLtrD0iD+h5iJoc01jli6K1I3O8pfeyL6huRJ7
 Gpe24+CPYmTQeSTAY0LOgGw11nhyJ8GrYksAVf1Y1+oTFnRTeofJ3Ec5HMe+OWB4x+pF/HYdFm8
 41TKOnxcKXY0PPLf7PbEQLLLjWdnbHAo8klCnpM6bIjXis=
X-Received: by 2002:a05:600d:1:b0:49f:e3d4:4c1f with SMTP id
 5b1f17b1804b1-49fe3d44c52mr29252645e9.8.1790180062637; 
 Wed, 23 Sep 2026 09:14:22 -0700 (PDT)
Received: from macbook (mob-83-225-122-101.net.vodafone.it. [83.225.122.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf158147sm63480425e9.0.2026.09.23.09.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:14:22 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:14:18 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
Subject: Re: [PATCH 2/3] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
Message-ID: <arP09Sy2jmnLSpAZ@macbook>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
 <20260914-ccaione-upstream-mt8390-da-v1-2-b76f9e30ac38@baylibre.com>
 <6070e105-ef8c-41bd-9dcb-29f6f0b92af2@baylibre.com>
 <arPe_JbLjVvUXjRM@macbook>
 <74268f61-b3c3-418e-8868-bad64e7084f2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74268f61-b3c3-418e-8868-bad64e7084f2@baylibre.com>
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

On Wed, Sep 23, 2026 at 09:55:01 +0100, David Lechner wrote:
[...]
> > mmh no, spl_boot_device() returns BOOT_DEVICE_MMC1, not
> > BOOT_DEVICE_NONE. The point is that there is no U-Boot proper inside the
> > SPL DA, but SPL can load it from eMMC.
> 
> I might not have written this down in the review. When I was looking over
> this, I was wondering if running the download agent should always end with
> a reset/reboot or if it is supposed to be able to jump to u-boot proper or
> linux without rebooting first. 

Very interesting question.

So, we should always issue a 'fastboot reboot' command (and this is
exactly what genio-flash does at the end of the provisioning process)
because a reboot is needed to excercise the complete newly installed
boot chain (including the new DDR loader and the new SPL just downloaded
into the eMMC during provisioning).

Just for the sake of curiosity I also tried to check what happens with
`fastboot continue`: SPL DA chainload the proper U-Boot just flashed
into the eMMC, U-Boot DA does nothing, it just stops.

Someone off-list asked me to support `fastboot boot` from SPL but I'll
be pushing that as a separate submission.

Cheers,

--
Carlo Caione
