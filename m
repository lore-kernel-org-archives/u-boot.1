Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3C5C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 10:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04C5780AE8;
	Fri, 25 Sep 2026 10:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FxByCRqpgHou; Fri, 25 Sep 2026 10:00:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5860481232
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790330410;
	b=X2s5EkMsJ+77dXftiMKDfyakeAOKX58L/UVVpMwktqWAZFtXcEsnT11U2q5wDC/foYN6
	 OMH8Q0j4hnQzav5TniR13t4Szhtw0Pivh6wEGgE79DI8T1QixnSyG8576UW6j0QxMQk5f
	 JWz9BvvH+TOkSE4/SUYjNrmnbcrKPjzV3SKIQ9FMQbKRlex5L6EE8HLglDemdAgeNN4nq
	 dzvLP1vl70CR744h9xJfwzMuznHyY2i/hR+yPvhOM3Thqrnv3jjbDgE8PgbKnzUfbcoZf
	 b8xphzLBfKsAzmpY1Ud4b6E2KqDT/HMe/8Ee8bJVpJUHmQJC5oPVEk6xUUMQtdRyzog==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790330410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TGY+ypXL/etBW6rvKV7L31wxCyijsnT/VLrJYicXUEs=;
	b=Hnga68vNY5wpvsMtjbayLlXuqyeMtC3cfupD9HrkhfsE1MsdJTwzO5Gokfm4HrP9YRfa
	 xMiC6OzygLd+XkN5BEehb8Lx4honwRSOLvz7b5te3+1JssGN7+uVHHk+dHrQxFJpVJDrN
	 oSl26RfE9PsDUa1whwvXeIQFlxvyr1Y1gSSMpMbgpHYP7pqLvi889qHAMjp7XjbJS0JkL
	 TjMTsGgKjcuSNAU3NkBx3/tAdNyOrDq/eVyWgTnF6S3G1aSU0cXgnefKGor9k2l33lb8b
	 qo4uZP9TuiRrIie6IlxJl/tf+Yj58JXTBU38yxORfVOYwv11ZFQ4zXLGe5inPTB9Aew==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790330410;
	bh=TGY+ypXL/etBW6rvKV7L31wxCyijsnT/VLrJYicXUEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hf5GG9Z97F4syePxo54HKV0+Qh+rgIa8gjc9ZUJLhnExhqi2g51li/6lLniO0dXEm
	 r3ldijVkfmL/XdfPKS9Do1uNiKEwuvISmRX1kYcdSeBpz6PMs1jdalDT71P6mrRkzc
	 V8T5aDJI94w0WS1KjDYka5/lAJae02shgPn/s3MQ14ymBFlLaImP4MuAtwCj0SbHwK
	 gaOZVNmWwEKFbwvuBz2+YIKE71+BdFpzUtyRwjP09dsDqvfvxQlbXx0B9uqKZmKONj
	 CIHqzIgSScF0kbhRUe57SSxoNIO94C7pAf5sadsQctwGf6m74kK2Ja7qQCOMEZWkv2
	 nQjpd5+iG3b7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5860481232;
	Fri, 25 Sep 2026 10:00:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A078D32F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 928A2404D2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jfrmeeg_gMd3 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 10:00:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CB0AB4009F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790330407;
 b=ctLKc1rKgW/drKE6o7mL0zxIdi3nEBgTwk+f1TLmEjt52uHosg+yLVNW/SytjA74bMQp
 pJ1jK3Zs+ZkYVpC8F0zGDnHKSJArh4lGmrFDYDTnsuGfsiUid7oKZ5Ubuta6ZzYumaqOw
 LWw1HhYbZTpFUtYDwqfP4Y0iiuRAVBNPYftwSwwr8w6prU8L1+YTI9LVVCJVYhcveohEn
 eFOmJn8/0d7TJ3eNBSc6hmzQcr+FCWL4VoIe5b5X/iVsHWYmbz6vejBRerI5Mv0hXQn1G
 DJQ10W3oqksWPVbqPb2LwH+mERLpzdKyTGY8JQDZZKwmBAgbRQ/ZPFAWphXiE9SZnOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790330407;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=TGY+ypXL/etBW6rvKV7L31wxCyijsnT/VLrJYicXUEs=;
 b=RjEfzvjuPbL327UJniIoprpN/ecE4WtkTuBipxWz76WlKpAuvErNZRS224nehTqJUvm3
 mlLUfQAC5NYwFIY2ojA5+PCXsBzt6vIOA28DQ55vQYYKf+woKDLbswfYSbEWWKT6r9fiw
 icgrOAndC7j+srsUnDoRtTXfxTH0e8jJtx3J9mm8QnaLK4XEKCeosLX9QJ2Jd0XPWrAj1
 6kte7IceTE2c9cSdSFPdqI47iD9twC8GLmfrlbjht4lpC/UeNBRA9F4bkSp6j+54bvZeF
 Mt5GI2j5nsZYkhHUbclTbL6TBNWuDO+YHWkypoQedr6b9jCJakA011lJ3ChVjT2PU6w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="IYR/EDhm"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IYR/EDhm
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB0AB4009F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:00:05 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 00721157ae682-85d43ac608dso6199357b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 03:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790330404; cv=none;
 d=google.com; s=arc-20260327;
 b=da9W38xp8VFAKj7ERFpVpjeEn3UdGYJE3OFD7JKZ2yVIooTSEfwPsnpQvVWPC/y0Jg
 kYToyxV6I/VWrrGAxJKxQfAFxB2tqxG4S6G3W3aqeAOmTPbCeV13V5lkdl0z/y0gRnM4
 zb2p7Mr/rvnvgHQLjGHQ6yRtEzZmugy2EOu5hAzZbjPStz5wxTWM4pkISNEP1yb7RTDn
 bmqF8LM/XLaJGRsn9bgRB9SI1fhGynWlo+9HT8jSTencGYYgCmMflowVSnjoaleCiwll
 mGVP+GcZu2jqLXRqWO8xlwj0BhjAv5b5yqOPReQPDiSK0F+APiXjMucWZMtKoCEou5Z+
 r2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TGY+ypXL/etBW6rvKV7L31wxCyijsnT/VLrJYicXUEs=;
 fh=DyB6CrUlg+ILflFAACc5r0PekWktsExLASvHr+fGUXw=;
 b=bR1kclxeujh049xbm7uAKsby4o/e3hmsI+HYeZt7uU8I4C7sW5ZWUOPNfdiVzp7iTB
 oxwh+a/z8b+ayEMkEto4oYTvUWGBWVrvx3S/YakhzeXXOeBgAYd5XZXknYzbd24pAEbp
 SfOxjmLS5Jd+cAa6UAfb1qQiEf2HfUQlGJHi4Mo425F3oMVdftCzfOn6SaNPzGWZLZ17
 Xm4I4zm5awB5jb5IrC1kvqn5+raZ+gLIuPGFGHa3ETpHw4fpTsHM7yHI8ka+XFa5TyLr
 EoG69VzxenGdS8x43MdKX9iF03454TJqHFebHOJ4zmQcanSImVKsQg2GQjIwn7CsCks/
 rQgQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790330404; x=1790935204;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TGY+ypXL/etBW6rvKV7L31wxCyijsnT/VLrJYicXUEs=;
 b=IYR/EDhmA0kdR3cIw77W/vdXc4elWd0JJlcmlpsHdOkdtQU2bLACJyuci4FVJlCZWB
 L6I3ZkvXQAztLfjJS1vV8Kg+q4Mo9M9fcgEQLVoyt+pFVqVl41jz8rqyEtrIUJtzSDXq
 vAnnnX4mbPorXlxCxOCABkHKB6wdIPEwYHHJAeKOxa8byfvgySIl5PgciIt8aM10x2av
 mmKX/YoUtamaQO3zkdCq1VLnuBxeyfCkAQ5wOIeHKIZYObdrhieJO/SigY/jnszzj0J+
 9pcVF5LQbprU07uyXVuAnJs/5/AOxeSv3ywxcx4eMVpkEJrZF+ugQdXBuiZRzAqIHp7+
 hraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790330404; x=1790935204;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TGY+ypXL/etBW6rvKV7L31wxCyijsnT/VLrJYicXUEs=;
 b=JwBtjyTwlYUrR5PRS2WZdTNfQ4RFZLv2Kc494A+23lB0DpWIoE7aMcmofDnbJF8t1G
 wBg7AN25b3E8tr51rgPr9xH5aO1Rc6GofX8sIPSXhYdpj7XU+pjmkPNvpYJGMUnsaYCG
 mFrQD76VgXSYCPIlUUlSw/6pYqRN2dzKR9VWS3Ghhr5zq12ourd/SPkKpza1WNRl5J5m
 xANgBF5MMNIkiy/KAjzTx2sx975CiI8Y6BPVWxf20+T1CmwbSFWV3nCqiT80lkHHcFgb
 xDumvZMqdDtmxNXj37VcwCIaDbA4Jhl6gdy/WojciQCC8FpXEEvAufHc1EZyYoKT951u
 Tyag==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6sScCrEXQq2bRNm5Q3jPPyVkjGb+EbHN88QW3WDf23comOykrSrcVJHcYDzi1X4SA+9em17A=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kXVQYb3e1cgp8avO926eKJ4Bm9Y7822UPrDK4aKfjXawqqgpPv
 bdQFRof8DvBaTUVnY29mwHBm/bkElMn6eVEaBY2V/6fV5fZYm+xBnnAjyvkDRR7zh0xjFcNKtUK
 cX/82M2hqwMToJcruXng8cWbieTS1VEJMdsyQvV2T0g==
X-Gm-Gg: AYBFou1KViTH+8xefYPESR7zhHjROCnkDx1WL+6TrQ871LsRvjTCN3MAd5LkD1ZG92Y
 Q89itr7biVRAVcmwPKqa7EeqRIUT0CaKJo1P7yhPkw+Xc2Z/IAs/6FGzY1WVJxZPrElmKldQwX0
 yJwSUaxmUoHCGYB0gjnb8MM3AE5QvmntggAu9IbQIolmxq3WGE2hJqxmr+yrEfE+g+yNM8uU5+0
 n82Ha7eFshvessdaTTr+OLsPRIajsuaTyIe6SgnBadKgCoie9ZYvL3HloOAJ8ReJESo2E4E56BA
 1DFAKGjT8Lbu+MhfHNDGtElQiFj3h+/mPIcAukquXfSF6FDlEXglJ03mVpVr8aWz9n1Bwz0Q5LI
 yqU73CfCZ9DHx/BEqT+6+R3vBoodub9H293Uf9lgPpDgDXmpEXozJx1ZX2lUn02E7cb5Sr05AqA
 7Sf8CA84d7xqdeLvyoQQQ0SlQRniCH/b6jGGdaTSYtfnYU+rxXz7kKVW0qbhQNElleCW7AyrbZz
 ET6kv4AksTAMlTLa51rs9qCdcI5lSHzLz6mhH5EiRskIl7u9Nf9DOK3+IA1sEovZocJfxS5ZVqX
 FCRGmHseBBxdtzspeIpjyt1tUWqSgYvdtWNSbitwqfJDzStVMnVlq8i0iVHj+fMxoXj/QXI4KwC
 zGz62sslKO74Yz6ZmyPQnbPUaAwf27jpntHKfRnbtcmV4vl9416RN9phGsmQfs2zgpg==
X-Received: by 2002:a05:690e:4890:10b0:671:3843:62fa with SMTP id
 956f58d0204a3-672ed4e147cmr2029669d50.84.1790330403980; Fri, 25 Sep 2026
 03:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <aq2b2AspOcySKRvl@trex>
 <SEZPR03MB78102F7A1B91EBAA72743B2189812@SEZPR03MB7810.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB78102F7A1B91EBAA72743B2189812@SEZPR03MB7810.apcprd03.prod.outlook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Sep 2026 12:59:28 +0300
X-Gm-Features: AclHuK_kXfMJKxtLBgpnGQBOp0K87VpdS_qnowHH_eJz-5QbjszWNh_dRwH3kI8
Message-ID: <CAC_iWjJmZFsxBn_R4z6N5RVewjDL3GzBWY0t6MTiLk5tSCN7vg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, 
 David Lechner <dlechner@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 "stanleyjhu@google.com" <stanleyjhu@google.com>, 
 "Beanhuo@micron.com" <Beanhuo@micron.com>,
 Zhaoxuan Zhai <zhai.zhaoxuan@canonical.com>, 
 Ethan Hsieh <ethan.hsieh@canonical.com>,
 Jian Hui Lee <jianhui.lee@canonical.com>, 
 "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "tanmay.kathpalia@altera.com" <tanmay.kathpalia@altera.com>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
 "n-francis@ti.com" <n-francis@ti.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, 
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>, 
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>, 
 =?UTF-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>, 
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, 
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, 
 "sumit.garg@oss.qualcomm.com" <sumit.garg@oss.qualcomm.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks for the detailed analysis.

I am pulling in Jens for OP-TEE and I'll have a closer look next week as we=
ll.

/Ilias

On Thu, 24 Sept 2026 at 20:50, Macpaul Lin (=E6=9E=97=E6=99=BA=E6=96=8C)
<Macpaul.Lin@mediatek.com> wrote:
>
> On 18/09/26 22:06:32, Jorge Ramirez-Ortiz wrote:
> > OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
> > U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
> > interface, which is bound to eMMC. SoCs that are UFS-only and have no
> > eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
> > secure storage from U-Boot today. This series adds that support.
> >
> > It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
> > (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
> > the RPMB device and reports its kind, size and CID, then carries the
> > signed frames. The legacy eMMC supplicant is preserved unchanged, only
> > renamed to rpmb_emmc.c, with the new UFS backend added as a separate
> > rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPM=
B
> > depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
> > single RPMB transport. The subsystem interface is UFS-only for now; eMM=
C
> > can be migrated onto it later as the legacy path is retired.
> >
> > On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frame=
s
> > to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT=
.
> > The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
> > device-id string the Linux kernel builds (ufshcd_create_device_id()
> > plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
> > the one Linux would use.
> >
> > The first patch is a standalone UFS descriptor fix the RPMB path depend=
s
> > on (UTF-16BE string decoding). A small preparatory patch surfaces the
> > RESPONSE UPIU sense data from ufs_scsi_exec() so the transport can retr=
y
> > only on a power-on UNIT ATTENTION; the transport patch also bounces
> > unaligned frames through a DMA-aligned buffer for the RPMB WLUN.
> >
> > Note: reading UFS descriptors reliably also requires the descriptor
> > data-segment cache-invalidation fix, which has already been posted and
> > merged separately, so this series is based on top of it.
> >
> > Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
> > programs the RPMB key through U-Boot and reads/writes secure-storage
> > objects, with the derived CID matching the Linux UFS device_id ABI.
> >
> > Dependencies:
> > Linux kernel:
> >  https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.rami=
rez@oss.qualcomm.com/
> accepted in v4 --> https://lkml.org/lkml/2026/8/27/369
>
> > Op-tee
> >  https://urldefense.com/v3/__https://github.com/OP-TEE/optee_os/pull/78=
81__;!!CTRNKA9wMg0ARbw!lQ5D9IUE1D5erqbaXCklFua6JiijZYB6XN0q5LDFZZpiaGmrH_k1=
0rLkcjU1nSzhsRDX--J49Gt22E8U73lx7Es567TUAxwX$
> and also following Ilias review https://urldefense.com/v3/__https://githu=
b.com/OP-TEE/optee_os/pull/8007__;!!CTRNKA9wMg0ARbw!lQ5D9IUE1D5erqbaXCklFua=
6JiijZYB6XN0q5LDFZZpiaGmrH_k10rLkcjU1nSzhsRDX--J49Gt22E8U73lx7Es565JETGdQ$ =
 (both merged)
>
> > For reference, at this point Linux can access RPMB and just u-boot pend=
ing on this set.
> I'd like to have some discussion in more detail as below, it will be quit=
e long. However, my company's
> email server and mail clients both have problem again as usual. I'm not s=
ure if this reply could be send
> out correctly and in correct format. Let's see.
> Moreover, I've invited Kernel's maintainers Stanley Jhu and Bean Huo to t=
his mail thread to see if the opinion increases more compatibility.
> But, I'm not sure how to invite OPTEE's maintainers, I'll try to forward =
the following description to OPTEE later.
>
> So.. let's start from patch 4/6 and then review the whole story.
> 4/6 =E2=80=94 ufs: derive the per-region RPMB CID and size for OP-TEE
>
> Patch 4/6 hard-codes both the hash algorithm (BLAKE2b) and the output
> length (UFS_RPMB_CID_SIZE =3D 16) used to derive the RPMB CID for UFS
> devices. Neither choice is mandated by any specification the series
> builds on (UFS/JESD220, RPMB, or the OP-TEE/TEE Client API), and
> hard-coding them creates a real compatibility risk for products that
> have already shipped with a different, vendor-specific derivation. The
> CID derivation should be factored out as a vendor-specific, build-time
> selectable component rather than a single fixed algorithm baked into
> common UFS core code.
>
> 1. Neither the UFS, RPMB, nor TEE specifications mandate a hash
>    algorithm for CID derivation
> - The UFS specification (JESD220) defines the Device/Unit/Geometry
>   descriptors that patch 4/6 reads (manufacturer ID, spec version,
>   model string, serial number, device version, manufacture date,
>   region sizes) =E2=80=94 it says nothing about combining them into a "CI=
D",
>   and certainly nothing about which hash function to use.
> - The RPMB frame protocol itself (struct rpmb_frame in
>   include/linux/rpmb.h, and the equivalent JEDEC RPMB frame layout)
>   has no CID field at all =E2=80=94 CID is purely a host-side/secure-worl=
d
>   key management convention, not part of the wire protocol.
> - The GlobalPlatform TEE Client API / OP-TEE's own RPMB subsystem RPC
>   contract only defines that a fixed-size opaque byte buffer is passed
>   as the device identifier =E2=80=94 it does not specify how that buffer'=
s
>   contents are derived from the underlying storage device.
> - Because no specification prescribes the algorithm, this is
>   legitimately vendor-specific territory, and different vendors =E2=80=94=
 or
>   even the same vendor across product generations =E2=80=94 may reasonabl=
y
>   choose different KDFs/hash functions (BLAKE2b, SHA-256, a
>   vendor-proprietary hash, or a raw non-hashed encoding, as seen in
>   other real-world implementations of this same feature). The patch
>   set should not force one specific vendor's choice into common UFS
>   core code as the only option.
>
> 2. UFS RPMB does not mandate a 16-byte CID; the size should be variable
>
> - The 16-byte length is not derived from any UFS or RPMB requirement.
>   It comes from the eMMC CID register (JEDEC JESD84 Card/Device
>   Identification Register), which is a fixed 128-bit hardware
>   register =E2=80=94 a purely eMMC-specific hardware fact.
> - Linux kernel's own generic RPMB abstraction (struct rpmb_descr in
>   include/linux/rpmb.h) already models this correctly and treats the
>   device identifier as variable-length by design:
>
>   struct rpmb_descr {
>           enum rpmb_type type;
>           int (*route_frames)(struct device *dev, u8 *req, unsigned int r=
eq_len,
>                               u8 *resp, unsigned int resp_len);
>           u8 *dev_id;
>           size_t dev_id_len;   /* variable, not fixed at 16 */
>           u16 reliable_wr_count;
>           u16 capacity;
>   };
>
>   Likewise, the UFS-specific device identifier the Linux kernel builds
>   in ufshcd_create_device_id() is a variable-length ASCII string
>   ("%04X-%04X-%s-%s-%04X-%04X"), not a fixed 16-byte value.
> - Patch 4/6 should follow the same pattern: UFS_RPMB_CID_SIZE should
>   not be a hard #define 16 baked into include/ufs.h; the CID buffer
>   size should be a property of the selected vendor backend (e.g.
>   returned alongside the derived CID, or declared per-backend), so
>   that a 16-byte output is one valid choice among others rather than
>   an assumed universal constant.
>
> 3. The vendor-specific part should be factored out; 16 bytes is only
>    there for eMMC compatibility, and UFS has no such hardware CID at all
>
> - To restate the core problem plainly: UFS has no CID register.
>   There is no piece of UFS hardware that patch 4/6's
>   ufs_rpmb_build_cid() is "reading" =E2=80=94 it is entirely a software
>   construction. The only reason the result is squeezed into 16 bytes
>   is to fit the pre-existing OP-TEE RPC buffer size that was
>   originally designed around eMMC's real, hardware-defined 16-byte CID
>   register.
> - Conflating "the UFS-specific descriptor-reading/string-building
>   logic" with "the specific hash function and output length choice"
>   in a single non-configurable function means every downstream user of
>   this series inherits one vendor's algorithm choice with no way to
>   opt out, even though the two concerns are logically separable:
>   - Reading UFS descriptors and building the input identifier string
>     is common, spec-driven logic that can stay in shared UFS core
>     code.
>   - Turning that string into the actual CID bytes handed to OP-TEE is
>     the vendor-specific part and should be pluggable.
> - Suggested restructuring: keep ufshcd-side descriptor reads and
>   string-building in common code, but expose the final
>   string-to-CID step as a replaceable hook/weak function (or a small
>   vendor ops table), so the BLAKE2b implementation in this series
>   becomes the default backend rather than the only backend.
>
> 4. Hard-coding one algorithm creates real firmware-upgrade and
>    key-compatibility risk for already-shipping products, so the
>    derivation must be vendor-selectable at build time (via defconfig)
>
> 5. Since neither the algorithm (point 1) nor the output length (point 2)
>   is specified by any standard, and CID is purely a software
>   convention invented to reuse an eMMC-shaped OP-TEE ABI (point 3),
>   different implementations that already exist today have made
>   different, incompatible choices for the same problem:
>   - This series (upstream v5, patch 4/6): builds an identifier string
>     from Device Descriptor fields (manufacturer ID, spec version,
>     model, serial, device version, manufacture date) and hashes it
>     with BLAKE2b to a fixed 16-byte output.
>   - At least one other real, shipping downstream implementation (a
>     vendor's production U-Boot branch analyzed alongside this series)
>     derives the CID by directly decoding/porting the device's
>     tee-supplicant-side read_cid()-style logic =E2=80=94 i.e. no hash at =
all,
>     just a direct byte encoding of the serial-number string
>     descriptor.
>   - Both approaches are equally "valid" in the sense that neither
>     violates any specification, because none exists to violate =E2=80=94 =
but
>     they are mutually incompatible: the same physical UFS device will
>     produce a different 16-byte value under each scheme, and
>     therefore OP-TEE will derive a different final RPMB authentication
>     key under each scheme.
> - The practical consequence: any product that has already shipped in
>   the field with one CID-derivation scheme (whether that is this
>   series's BLAKE2b approach or a vendor's own pre-existing scheme) has
>   effectively burned that scheme into its provisioned RPMB key
>   material. If a firmware update later replaces the bootloader/OP-TEE
>   RPMB glue with a build that hard-codes a different CID derivation
>   (for example, adopting this patch set's BLAKE2b implementation
>   unconditionally on top of a product that shipped with a different
>   vendor scheme), the newly-derived CID will not match the CID used
>   when the device's RPMB key material was originally provisioned. The
>   device will then either:
>   - fail to authenticate against its own RPMB partition (OP-TEE
>     derives a key that doesn't match what was provisioned), or
>   - silently begin deriving a different key than before, which is
>     just as bad if any secure-storage data was provisioned under the
>     old key and must remain readable after the upgrade.
>
>   Because CID derivation happens deep inside firmware/secure-world
>   boot code with no user-visible error surface until the RPMB HMAC
>   check actually fails, this class of bug is essentially undetectable
>   in normal testing and only surfaces as field failures after an
>   upgrade =E2=80=94 exactly the "silent, undetectable until it fails" fai=
lure
>   mode already called out in the CID appendix.
> - Therefore, the fix is not merely a documentation/comment change:
>   the patch set should ship this concern as a build-time (Kconfig /
>   defconfig) selectable option, e.g.:
>
>   config UFS_RPMB_CID_ALGO_BLAKE2B
>           string "UFS RPMB CID derivation algorithm"
>           depends on SUPPORT_UFS_RPMB
>           default "blake2b"
>           help
>             Selects which algorithm derives the per-region RPMB CID
>             from UFS device descriptors. This value is a software
>             convention with no basis in the UFS or RPMB specification
>             (UFS has no hardware CID register); it exists only to
>             populate the fixed-size CID field inherited from the
>             eMMC-oriented OP-TEE RPMB ABI. Products that have already
>             shipped with a specific CID derivation MUST keep using
>             that same derivation across firmware updates, or the
>             derived RPMB authentication key will change and existing
>             RPMB-backed secure storage will become unreadable.
>
>   with the BLAKE2b implementation in this series wired in as one
>   selectable backend (CONFIG_UFS_RPMB_CID_ALGO_BLAKE2B), so that a
>   vendor already shipping a different scheme can select their own
>   backend at defconfig time instead of being forced onto this
>   series's default and breaking already-provisioned devices on
>   upgrade.
>
> Each vendor should be able to upstream their own algo and more.
> And these algo should be configurable by the users or by board makers.
> For example, MediaTek and Ubuntu are using different algo and CID length =
for
> UFS RPMB.
>
> Here we suggest to make some change to increase the compatibility.
>
> 1. Split ufs_rpmb_build_cid() into (a) a common helper that reads the
>    UFS descriptors and builds the identifier string, and (b) a
>    pluggable string-to-CID backend, with BLAKE2b as the default
>    backend rather than the only one.
> 2. Make the CID buffer size a variable size, or at least property returne=
d by the selected
>    backend rather than a fixed UFS_RPMB_CID_SIZE =3D 16 constant in
>    common code.
> 3. Add a Kconfig choice (e.g. UFS_RPMB_CID_ALGO_BLAKE2) so vendors can
>    select their existing/legacy CID derivation at defconfig time.
> 4. Document explicitly, in code comments and Kconfig help text, that
>    this value is a software ABI convention with no basis in the UFS
>    or RPMB specification, and that changing it on an already-shipped
>    product is a breaking change to that product's RPMB key material.
>
> Thanks
> Macpaul Lin
