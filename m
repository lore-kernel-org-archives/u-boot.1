Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548CFC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 12:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A10C1606F5;
	Wed,  2 Sep 2026 12:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5DoqYAbJLGa; Wed,  2 Sep 2026 12:59:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788353977;
	bh=SBayUxyxu8EZZDll+IWH6hVmDkkCckVBG12mIJnBx84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQs9pv3KtYlAqFpgoeRgbSLhzdZlRrjVqAw+9RiW3U5DxfbOmfiDevTWCCwCFG/An
	 lhQafK18U77h/kxb8iu1pK0Cd7iAiH/gql1Ee+kXMt5nM9beaN6mVoWLVil5e4yJLI
	 J62K/FMwpfdsfN93UMX7U4lNI1f7zT63jXJMP+ezme4UOBmc5d00+r5/eF110jN0Y9
	 tEXpuaihiDTZlgiRS/omdvt+RVeiZjnFpdYkr1Thk1Dmvgnf5jotM9PLYhA80zNOX+
	 Zn7tAtjbMG5FNj3IuqSuYg/L2FdOxwI146aof/rVessVfD09ba/7VXJeLGVHc/HsXY
	 845LKLxrOLF7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A91360726;
	Wed,  2 Sep 2026 12:59:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B5866127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A757B6070B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m1mkw41QxG8T for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 12:59:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZK4TodBG
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF7F7606F5
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:59:34 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48436251906so1132107f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788353972; x=1788958772;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SBayUxyxu8EZZDll+IWH6hVmDkkCckVBG12mIJnBx84=;
 b=ZK4TodBGs3M50VAr9TUQssCEIxmfOswB/cQTOK3zgK30yJaLlq5a7gteDCZb8EDwxj
 0Oy26gKvm4M9r81ts7jLdzEKcW6dsUktY/2e+l+6U6VNsWKuGba+wAWS7Kn28kKxV7b2
 gzE/TbzgHPB1stig8XjuHudjTyGFwjOqeGPnmDZO5MmftALTVX4WIzVajckhAJt+Pe1R
 69c9I0JsRvbIP+Tn+QjdclQSg6sttxxLsPTzABRn4d6jN9m62JC3Itu34RkM+IIX3pM6
 MNEOXPMkAC9tUW0P9ShOo+/cjKiiKHm8Q/YJjANK2kOXTh6rGgEBu7GTAwKJuCtW89Eq
 +1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788353972; x=1788958772;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SBayUxyxu8EZZDll+IWH6hVmDkkCckVBG12mIJnBx84=;
 b=PgWHhNlql7iB4XQvqhB4L1PnjL5OAh0WVYMxtcfURa1AAFbRt2Yuy1gX0JKOF6Dm13
 tzdkCqykkbSXSGDkf/BAOgZVQjXHkroiImo7bYyzhG67tG/eyVNYitCq2d+jregO9B0u
 DSCzyMJ/9FxJTXaMlDr3BggG/+EHZ0vt60t9LZXSO3fLElPOAbtTOB1XXd88IPI5PQ5Y
 QP0lphWwMpYWqtZn0m0vAEecHpfZqbFSt5cyyu4SB1VwGhXN2HU9FJcMvd0PUtjG1yxN
 GJLgMOCKFrfdBB+783dKGky1qbMTZN7dRz2LCmqTuJPPU5ytzNmU8ZqLOUsVfuErStcg
 J2Lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrgX86NSIsZpRELCBA1/uCXGWu+FPDESRRErtoo7WHn7/UWdSQaOXv6Z2j2SM5R26h7ruwThQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nuuCS2+BwUi8N/4hp/WRDxp3iHeiW2S5Pos7GGaGhqUX+6lOhA
 BftnNH4VOrfwLV3srXo8RyGxrK43UeolbvYJKWZf/nmK2RIhyPULTVSn9whoBKZI/Uw=
X-Gm-Gg: AR+sD10ZjvG02ezjUIqfD6CpXhulTUaevpurXHxHVfD8n/B+Yiuqpk5wTB43RLCuKlw
 xK06hbCkqTUbjP7HsQyZcktawniNLSvftJSUPqvUm7h5vlOFdehdGj4x7okYai5QHAYrY8QKVBN
 errlHgOoy4zyJXnvvlSwswuTCYKmnaxzLScQBw82+1s1LnCSuXBnJi3ESoIq4051NgbVbkMAu9c
 CD2MTfqfvaaz+gfbYs2QJQ3Lpyfaj80FSTXhhbYS+Z9PuGoi3dh3JLnxhyl6+lOtvI8xNc79Rkb
 WGJGgxAaZpo0EpaF8G78YQnpruwjho+asT41WGl3wj411SHDogwcC0MaJzoAv836U4yIZt3Zz1E
 84igQMnVeglWAniAG58eiOKdS0E3q86YqjIAd6Qno/JEZKccyHKUBqEpkeex6nGCqgrAizIK9Z3
 CXlfH/3rbkMFBBCsFo1LVc2KsxZciiDjd+S2sKSoLISkeHKt35+OMsvdwDjS2dZee6wa0yTS5VR
 h5AFExfQN0Zo7pbW64YvWrumn8JCQSVB8MD/uV6bSrdRgQ8/9U2m93+GfHBDF4mChqF9FRVXW7u
 t+fgNB6zk1Wt7do=
X-Received: by 2002:a05:600c:699b:b0:49b:9205:45b3 with SMTP id
 5b1f17b1804b1-49ce584c6femr83906585e9.15.1788353972236; 
 Wed, 02 Sep 2026 05:59:32 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce831af89sm19156075e9.1.2026.09.02.05.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:59:31 -0700 (PDT)
Date: Wed, 2 Sep 2026 14:59:30 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] power: domain: mtk: remove setting DCM_TOP_EN
Message-ID: <apgdZk77YmvyECpq@macbook.homenet.telecomitalia.it>
References: <20260818-mtk-power-domain-remove-dcm-v1-1-13de7925ceec@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-mtk-power-domain-remove-dcm-v1-1-13de7925ceec@baylibre.com>
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

On Tue, Aug 18, 2026 at 08:34:17 +0100, David Lechner wrote:
> Remove setting DCM_TOP_EN (Dynamic Clock Management). This is not
> present in the Linux driver and MT8xxx SoCs don't have this register.
> Writing this register causes a hard fault on MT8366.
> 
> Fixes: a81e1f8a7cf2 ("power: domain: mediatek: add support for the power-controller model")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
