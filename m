Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D8CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3010D608C7;
	Fri,  9 Oct 2026 19:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zDMiQlIPtNYC; Fri,  9 Oct 2026 19:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C859608BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791574614;
	b=N28fUtKQfroTF88Rg/TonFFD6gJyICtXkEaHgzri+Azog+grnFPomTK3D1du6BC57rnu
	 FxyYdfmLt1Q0voFno7tONwN9V+aMcJ+YeC4S4AlB+F9mi5Mv/4lr200eDSj++YtJhVJNr
	 1O5rViSINWlYPiYHIcA2fwx5NE/vcn/qWMU7W/fO57mKZrRUdGPUIuC2yR/nng2h8G398
	 dW1djf7z1ySrisvQojq9sWdGGP+LCKi6UjHSiEHU68bv6vjV62E6YnePb72bm+ZuP1mCx
	 AZbfn3rcgpty6+4z+i6YglfPpqrfDDaQ000nEukedxp6Upc3xbtOc59CzRhFWMRJ+1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791574614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vItSXD7Mu5rJ7mSPVSD5jk61if5GMMTK0EJ0IyUm04A=;
	b=So13xkEus3WlXfRH2eDfATlbaHg2TQJ9/5L0IWLkWLBmHmdikJyFFv9U9VHKTvKUK5L2
	 LUc2hysrCYBywQj4n1BsZ/k9NE1K7STWBtllmfOcnS9KMX8ZHZzjuDLdBuNcU4/V+qhOG
	 +B5F/4027QFiiCpLwU9O+UV9SDa6Ch1m9ZaICn+OK6bAXyxtuzvjMnw0Gt5t/dvZo70K1
	 9ny5Tl3KDqyZMkM+5PGGGRhMX9TjFFif5YuEq2P83OcFWqIhhZd+OXyqtIfKAU/rwlhHD
	 F9eSLd+HqbVCdCJNqrgrTnJ9ypS+rfOXknhThb0sff3WWA+uDIeo9QbRuABxotg7oKg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Q+rQVSXP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791574614;
	bh=vItSXD7Mu5rJ7mSPVSD5jk61if5GMMTK0EJ0IyUm04A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eKmRChdpbCfuSREr6y5NvOWIMWlYQ4DbTedUPr6Y9kShn7BU2VP6t2MInRlUeDq0B
	 5gSn5EOKvSICRPGZC50AgFOyKgCnTTDhC8aji4+ZRCxmeHzi15eVtwUz2W9oOp2Om4
	 Fa+3z8VH5AU03W0eOylTkOE8KLlxw7jinbhu+MSGXnX3k7lyTBbpkpztlKCqtyPiOp
	 EohaWPJO2/OcFsU9Wk53PQc/ci3j0KA3PCw93UEDPvbBEStcbSIWL/bS02PMJv0xuz
	 qKwMRS58pOtR9uAUv7QU1x9ltVK+hDBG7RDihnUQPiaXZeLKHn0IMgKLA05FExwT+X
	 hItpjVg6BO7UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C859608BD;
	Fri,  9 Oct 2026 19:36:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BAEA2380
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACA28608BD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UKYcVkN2zoud for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B350660844
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574612;
 b=G1z+1iOdJkjterYZ/Y40YgCRfAAUqey1j/ASbpLSZ1uNL+irKyhfkA2brQeJwxWXxsj3
 RXjSLkNNyEcVGfaTI6kQhzCdsj74au+foGn88iJvtO9hAgJiE3U12N44X++HtvOmjIdLI
 o4jP6ZoBd+hLXn3BvDjYU0yFTmNKXZnKtTa3oklLUswmKDY0NuhNscppyIc9e7p/+rb3b
 ycvliE8LUbPRmzNodW+hXdf4ogL45K1F94c6bE33OR8DTLWj5lC8JHUdhORrWXMgqHvzY
 b8/Yql/HGMStzbPFS7YPcKzuZBXLl+N/I1CSsjB4TJp4M+zCK7oTtJ5iLxTuBZ47E4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574612;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=vItSXD7Mu5rJ7mSPVSD5jk61if5GMMTK0EJ0IyUm04A=;
 b=s2eWA5h2bMFs+eHq1PU2WemJJw+iR/z+mFEpMf3b5dDGUa5mSOOsNwG8oiPM59CBeVWX
 nJd0qli3mc1JuT29YkJsl4vVMO8r50nvGEeTWrJtyDg5aMI8jSFd/yITJIJ8xjbGdK7qA
 b5ZXsqEpcTQbsC12RtsXyhDdzYqO0J1ZLfmz/lEpNG15v66g6YoVrbRm32jSu+sWNjGZI
 nMeftAkWOLP5hpwAkryGX6XFcLuHyWv9AyxclWL4Tq7sleHHttk6TgzThnOR5wAMUZ+Ky
 i5RRRaOKdM0xHZhUxe7VpAXFN7N6vf0w2qJKSxhUhW1ntUaat0Z9+jMUy/N2dae3itQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q+rQVSXP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Q+rQVSXP
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B350660844
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:36:51 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-81ba09a5d23so145193a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791574610; x=1792179410;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vItSXD7Mu5rJ7mSPVSD5jk61if5GMMTK0EJ0IyUm04A=;
 b=Q+rQVSXPJAbxju9XT5LieeLQiBuEvjSJkrm2QSmjupkvory7MYMoDwrUQ7LmJYhbs5
 Tob8QEhNe2mZkXFi1hWa5CmNH0BsSl84Rp/1jcCIqxz4KUQWYWv65Ok/kXhwFTgDNqlJ
 JjMjGcb8rgxX4yFiRwtWKSLW6qllpFiA50FBy+iezUSLOrpER0bcyS/x5BfKcudF+tMN
 04v0OyPoHhX/0wQtxVFL74P1YvemZyvX+YQz9It5VR8GKbm9Yj5aSoS1LgH1azCa86Wg
 0PF00Jr0fulr96F8WrBeWP4uDF5r9ZIKDY2bP3b05JLeoXDS4/GqZPfEgLm0AuNboRsB
 NaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791574610; x=1792179410;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vItSXD7Mu5rJ7mSPVSD5jk61if5GMMTK0EJ0IyUm04A=;
 b=oifagilJFHKKczZnUqp9IrEUJe5ULPa6qH5rviInA4Ltme7d84YTUAQ9kMosZckPXO
 U554jVinS5QW2meixUMmxSx+S9n9516RlXo6XcQo4y1A/S0G6qWVzvs3a407THnUgxLM
 dS5ZNMTwAeMZiy0aQTr26jJTFpkSdb+On1lnORXUsQ0zgF6/U306ZFPv3KFPB9wHQupj
 3FyRvzryHE0bacS8XBY7xGNZe/CdggbqpXmcHu6rMoRJ0AtyIinUd2FXU+XdaSVOwj4G
 03JKpsc4pqHKA+iMfYTHOpcXdosNGU/XduUeubpKt9KQY3kaJcJ/JQEZp9cWO6gNyrX4
 9KDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/UwDdxzR7NaNPOpf08Lyl4zU11g6qYiTLBuY52tflNTHWGIJpT570rpfbIMR/Fuv/y/mWua0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m+hCC/3D+6R0g4Q2RbIU4X+X18EiWehADF6WeJevygYcW+9CyQ
 Bc0Um5PGOHkG7MDctUFBbWZB+Oi+3pLc32bu/oaDCeN/Mt4d0tQKqHCYwGIcS5Fgux5D7SGh7Kx
 AE82V
X-Gm-Gg: AYBFou0k7+UHZtscrAtPSzfRU7Zc7yWcYw0nw61G1DDoFWEX3P5Ihh0Xly3r12i7tL4
 ykCK2R71CHm+CO+hDlf5F3SSBmFWppgPeS5rHiwOAIrYn9wS1Bb1EKWLOuH9/dPi2adUhrLQyG7
 lg6nEQK2O2HriyY21aHtmxjlZPvpnAiqYvKCewN4JOzOSdDGyMWRqjdvzxXZIsC7VFCyfo1Jay8
 2PdxUOj4NigoWebOTW8rwOVd2cOW2xzNssGqvN7f3Vo24OiXGDBa8IrDmKOGiu50Vy0FLDD6dPL
 PL0HWPlUm79Q2U/YqmOoIFZncq3Fnwg2X0v3ZGXhlIOt0HxdmBwHTR+MM6/4PNGExd9+Kmh/Bzz
 vuGyzxp5zCAkniEG77vFgPdkSwAoSHRMJkHDIVIHEOSo9dhKRMIcxQUWkGUJMcOgmVAU+wBnF8g
 ssqDfGgnyjPhxkvYSE/BHFhRWTWICoJmv1DzjbS1QLgQeRyaQr0+KfQA2fdGvtt6lIkfpeSCJxh
 Bw=
X-Received: by 2002:a05:6808:190b:b0:4f8:4ec9:b170 with SMTP id
 5614622812f47-50c415de52amr3082600b6e.2.1791574610188; 
 Fri, 09 Oct 2026 12:36:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c16755587sm3112932b6e.5.2026.10.09.12.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:36:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260925-mt8365-add-mulimedia-clock-driver-v1-1-5fbb0305ef46@baylibre.com>
References: <20260925-mt8365-add-mulimedia-clock-driver-v1-1-5fbb0305ef46@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: add multimedia clock
Message-Id: <179157457966.1248553.12821845372373521820.b4-ty@b4>
Date: Fri, 09 Oct 2026 14:36:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=358; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1K2gAqKczNgxkw4inwTBW9pOLryDOQcp7LqDtgc4eCM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyUJI+paZQnAHVrFp5InVeKLQcYjEdMffMNwaE
 0ODUpgWUPWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaslCSBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0rUH/icHGGGX9FZ3DFwPp3VqVB9ovJSqXFM1MleUahB
 RMmrGxCYb2c8GLEi4rwZpdp4nLp7Cof65KjqaC9Og/xvr1ycI3SwMh9WxWjyysjHcZsBdg2EJkW
 GbWdht6TePImkq3I9iqfmkmVTxEKZS2PCGkSutR28LaHd1aplW4yWFKNFhvZ+OvMHCEbRqbJlh7
 hfZpZFEBHzPOnMY1ux3nQ2OrawcjPTMbz1CBL1QlmPmQ7F6JYiwFgSz4twnAPYBVPZ5t1prWK3Z
 J610nTu48LpzZMmmexB/w5++/JZBdPP07k2yjtugW8k3Q6BwR/PDAyuyFbJfGUWeHIbIPJNy/UL
 Um1w=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Fri, 25 Sep 2026 09:42:41 +0200, Julien Stephan wrote:
> clk: mediatek: mt8365: add multimedia clock

Applied to mediatek-for-main, thanks!

Fixed merge conflicts while applying.

[1/1] clk: mediatek: mt8365: add multimedia clock
      commit: c335218e47edd2ca46bad62499a00bc8de917773

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

