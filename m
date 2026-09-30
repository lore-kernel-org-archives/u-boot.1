Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAD5CA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 20:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58F3540B55;
	Wed, 30 Sep 2026 20:15:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ord9LbdG4ZSx; Wed, 30 Sep 2026 20:15:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4CBAF40B5D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790799326;
	b=RjMxqih3rt5voVntFhw8q5o9uhpY7VHrbykqJEfwbfWVtA5t6dBCzuzkW/0uVHAkMM5N
	 zvEyiZTVI3RqGf6zrScSPp+zUaDQZQCDpOShIruFGux5eRxsUn8kojzS9/QR31+Naf3Ul
	 RYyWL9dFqAZFBLYafiiQdkBAdGMiA9k058mpm3Nxg/414VYu7hB2gasHYy3dubKuFHMHm
	 CIsPvqzr/FxD1ectvGg6Kwu4KV0iVX/DJLDTagOMZ9BTmUEO5Pitmz9Fy+m3pSFavpi6Q
	 aB7qYvI/xXhj4SgNsVWiSSWz8bR8Cz4NqIIgudmNotfK5tfKbo55vHfz+hQX1kjVwGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790799326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=unh2xw3EwaZjrz82SwKLyl3NYTnMcGSdBOmbdU/EEuo=;
	b=aaTZTk8/QJIUFEPYmZ3NHGn8zWNapHY+vu4w7v+fC+NWXt7kf+26alT3BANGCglx3k8R
	 sD5BNKBrojxdmhlLyklHYwZmF9NQqfMRFxR0ND8w1h+oR7d9HUlxCPWfBVYO31FBzvdp2
	 QLVXHJNTcTIvXZd8cGi77qqJtwwcFcpBjb/+CvJNn7buwPoXAF6W+0/CcJ7REP3f60vyS
	 AygCSBHzri04LuWQ9zlJWGS+SSeZ2L3BRbquAlUL+R6BeZ61DfiuAxK3RXwOtuS1esBDz
	 3V1mvDNpe5LKijFtcX1ea9zUzimrquvF/fp7Wv62rAaufHu46h4WCKDsLhiOyHGaHJA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RJXIHRRu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790799326;
	bh=unh2xw3EwaZjrz82SwKLyl3NYTnMcGSdBOmbdU/EEuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y/KGHMAsUJt3XZO2YHa+n/mMNnfw8xVm4I7DGUFFzGw2C+DTjTL+TNN2pxg/bjW4s
	 Q5O0wuq4pwJHJgF46TyymYF5lmZhmHQYX2exmPLtS9dRBDMTTMY8/63TIb+/CVCuhk
	 AIxD4WqXg1p4BnlzIl86/ShNCOhU68Suc6K8anFu1SKhSjoMfrriusTyD3C+WLu51G
	 DAIQBYuUm0u+jPcaBfHSGVA0SO3fZ+SI0CUw2i/Krf8Jn1pWzpTR9nNh3AkSCSszPl
	 yTI7xb4RyE1PqMOGvfBmR5TOuzhuBH6+Nn//psNz2uc7fQjXxsksqyc2QiTDLYZm2q
	 XCPCAA/g/AUoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CBAF40B5D;
	Wed, 30 Sep 2026 20:15:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6A9624E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4BE640B3F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VWyrPh_A_zAB for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 20:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B863540B34
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790799315;
 b=M3dFnlUoPOa3SZslmmsSGIyFZT5Iqp2xTAxfeViNbSnAjS6xVrckLd/XT3irAIeR5pjd
 FnB2Mmv0WOD25ABhlNX9Bwu8pwd9CgxxGyV674B6XAVOQdBFqowPR8y24ybhZfZwfFQ4/
 LMoH7st4p6j4KghsR8O1FPp4w/xgAK8gTs1r9izspc7f7j8xDeJgAYeAqs3IIyUUENU+Y
 2t52qBoCgCHfwzG+YWwFTDRmyV7vb0wphmO9m+EhqjyYlOFWdz5UfEnhyZcYjRb7ubLVI
 IZ31gO7OdDBV6d0Cu5P1DLSsaz/sXGROC4JeURvJxw/coNKwzbKQ99hJOQEcRM7EGqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790799315;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=unh2xw3EwaZjrz82SwKLyl3NYTnMcGSdBOmbdU/EEuo=;
 b=NuZnO+ox/Z3Eh5WypLW+hOdLz+XN1PfVoeV1DcdN6JicK0BjH60w3iR3CYpL6Koc+Wzb
 m8gzAMsNIyb9YVPDeojBqHE6Xi1Dk1NN0SsrZErtMZFoMfGUQIspcXm3WOQxL0e0ijtds
 pj5F5FBuinA5A1CIUFpzEdDy9+9WZfMBWLRMGA2pyFAEIUgUfsHa8d5y8ee55e6xhiXLl
 hduxEcy/aOXD0DTgLyKWL/yd/gsbxtbsoYfVdQG37dKRZdjgEYI5fjFetgAzIK38Z6jKC
 OuRk9ab2rlyDF/qC+IWjEB7NK1xrLO0l34sJw/Xm+LtefFA4BnoDXLaGcQ2fj03u0/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RJXIHRRu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=RJXIHRRu
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B863540B34
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:15 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6d79b1f928cso2177218eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790799314; x=1791404114;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=unh2xw3EwaZjrz82SwKLyl3NYTnMcGSdBOmbdU/EEuo=;
 b=RJXIHRRugLgN4bK+5C0ipTBd1HNDETkW30RhU879ZBn0FSDDomZ0CC5+YwD4ugoA0w
 eotA3HYVWXpK6iw2lo0CKhn5WwRVXbW40Y7ddNtPkxIlyMsJC/Ru5wDeoyQt/kP8dqEY
 u24qJyZihN4IjdHnSSoGVNmVPl1H4stFM2ecM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799314; x=1791404114;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=unh2xw3EwaZjrz82SwKLyl3NYTnMcGSdBOmbdU/EEuo=;
 b=UXzEjrml0ONUtG/YhqDn+RMUANY8qaNvAxdHIqn+OYLUTykcXlHyS07bO1N0zg3h1t
 6K4pB0sjI9tt2afNAb8F6tFzuZOW3H/CC7s2Dv/wQ1IvGT4zuTsvj+q2k1hjfy6e6SJB
 I1HkqKYDI7ZxzNFfC3qyzuyGIzIRBVeV7HENNZDsOq3J2xUcgYHcEwmMKF8qfogBbZxQ
 uV5fFFJAKcj83Jf3R7MGfG317XOqrzitwf217kY44V56khxpbu9ijOVTla7Rv4zIRo/+
 bJ2swOBT/bW94aIeY36+Tc3ta04XNeyLBV/BGDJy1svJNBnkuiMrNB2Jk/l1rDN2kDTD
 NFdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGRdWlB6ucVvCPpyEn8k5URraAgITFHs1swvV257zYNbmxcDYc9Gnix76qqfQBSsFIyVUx39s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mAst3n5ruRdVWXuRoXF9aC1LOu9vPMzIh7pnrSZnd+DmU+Ij5w
 el3CHq7yhA0FzdZmiGFj4YGF142bqlkxJi0sYq3NA2VzafBeScHl+5ugoDm0EzXgXssWfXy059V
 UouO8qSp+/7B4
X-Gm-Gg: AYBFou0kmfsaZkTYxzMXO/i9YyVFy3qe2Ucw7ExNXybyLW5g0IEditiWtteIKX+DA93
 RNx9j/5lD3XEevLbVaydBDVfOTwycF8uIZAUetliMUIEy0K5VIiZQj3zrgZ0ks39OG1CBcbZbhU
 MrMT9MfFz/kiS6w6fLJRQfL6HPFZTNgtjO2PrVqsVxvfNqWYamHQolej3DcJst3F3KrIefCzGRF
 7VuR6mOMLFvqF7IzIWI8zT2g5Flfy+lUihfoNdcYsgEoSEvi/hBVQflD/hd0+qXY/mlOEEalR7w
 b7qEbLpSngIH5g6443VSOXjW9A9WJ7gGQKAWVE2yQE7/IKEUHFsNNHcEFatkBqxQCTe7GMgALk1
 mOPR/k7ZDnIpOCsVZ8Zx+cynNC55hYKBJtDPUyyK6U5gBQti3HgvxEtydXqqK2L33H0zVL77ZpW
 K8GeOVgSG8bBU4wMkm12XpJFaBR0nAg5leTERIu0+GsAQExZG8zm7XDr00vQDod0L4uHp15VcSB
 qhUmmeMGVQHmU0CJJgSjFfWn7tX4aFuFeAg1TC0TXzTla2BFAU/HnygfcAV78HA2nS8Hb/9o5Yg
 gdfm8tbH6WfVjOxpe/9JoO8G5hTG
X-Received: by 2002:a05:6820:1528:b0:6d8:57bf:57bf with SMTP id
 006d021491bc7-6dcf4656d55mr2749218eaf.21.1790799314172; 
 Wed, 30 Sep 2026 13:15:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-821281a797dsm821896a34.3.2026.09.30.13.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:15:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, 
 Zhengping Zhang <zhengping.zhang@airoha.com>
Cc: Fei Jia <fei.jia@airoha.com>, Lei Dong <lei.dong@airoha.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260909075045.379619-1-zhengping.zhang@airoha.com>
References: <20260909075045.379619-1-zhengping.zhang@airoha.com>
Subject: Re: [PATCH] configs: an7581_evb: set NR_DRAM_BANKS to 2
Message-Id: <179079931298.506059.6833991036085302017.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 14:15:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 09 Sep 2026 15:50:45 +0800, Zhengping Zhang wrote:

> dram_init_banksize() splits memory above 2 GiB into a second DRAM
> bank and fills gd->dram[1]. With CONFIG_NR_DRAM_BANKS set to 1,
> gd->dram[1] is out of bounds and the second bank is not handled.
> 
> Set CONFIG_NR_DRAM_BANKS to 2 to match the board memory layout.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] configs: an7581_evb: set NR_DRAM_BANKS to 2
      commit: 81dd42b9eb7fb0e2ed7ff7d0719262cbaecf369b
-- 
Tom


