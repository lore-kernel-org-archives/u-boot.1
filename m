Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5C8CA5FAE
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD45760B2D;
	Tue, 29 Sep 2026 12:53:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0sVJ6lgq9UPZ; Tue, 29 Sep 2026 12:53:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 833E5607E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790686391;
	b=X3WmaplzV35s8XDEIyrYfqGvYvmL7h0bJS+tz/dJ/WYL/rh58dzmtqy9LHsbekWUftFC
	 XhwRTNQzmeToEMk1mjj4Xq9OTAVvFTwN/jB7sjWacf51KASd95n1l0fM/y4NpfqcePYgv
	 hcCsIkNhcK5hhcZ4KPmHDKfsxNq2e1rAoPgLmMPDctsxRke3AtttsIwhy3bsW9BbNTdm6
	 15y42ujjAXad7XKTFooIqio1s1TNM05BDThJdpvw/LC60SdY11rqAoA1w1ZH2eYEQS9yk
	 O9fK8GanyoBBxLIq1E9iyc5e03O4D6YkPKUqX67fRv7TKwSg/sqSqTaPPlRGkNUDZaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=50lFQ7PF9RmR+KUzx50FRTmpEWSzSyxZ9IyBu17xza0=;
	b=o/epW3WMad/UuGJ+3m6VnwU/fz3GDAVBjkcBq4/eoMuQCYA1me3J2HzGFytNhIy8DpHv
	 0w2c+8t+g+s/9TmQicj+ZNKlNwj2dWxDWHT1Of5iE8YkOyDRQmhmY+mjigc/NkVJYQpUS
	 rrS+YOX7Kz4AtlzPUE3RP9vV0KUFX3xHnUn6cwKRmKGA7Vw5scJUo2m1aUzVk0vnLnW1s
	 vfgvJ1ShVTh3jkX/WD+riAUAyxOt6e9VxUvxaskLNvhragGONJvFj0W/4Pw3/ayAJys48
	 b0QWt6leym+tF5xxUVca5j/wg8HCpRbAvJuceJOwgyk8SwNySO1bnWES/e0kTgwHInA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686391;
	bh=50lFQ7PF9RmR+KUzx50FRTmpEWSzSyxZ9IyBu17xza0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ISVS3HfmwosJj8X5klIkICg49iMF1KJ/pbq+pKH425GFtQnB9jqod6+CglYOND3w/
	 8wuiuOlTVXciJJdfBTEa4mpJ81YyL5IuDO94S9SwTJ7so5MNyUEziVge3uCVAo891+
	 VsjpHq6uLCDNL6CFSLlQF9W8t1/mUKsaN8NNhnGsE05cf2oLyNeuWmGSUPSAsDeAnh
	 TYER5Aqtfi7QQkJ7IgAoJzvM+muHDisJx5lcuHfc0uk9h96H6lyJg+CfZYVa6a65Ou
	 xfyzz4ByRiHywdoBcvTzkTnp0MUFi91Bqwltrdg9UtH29esH0Pl17F200F39IEMG/O
	 OyRCF4K7xtBzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 833E5607E3;
	Tue, 29 Sep 2026 12:53:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1C733D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B77F480E4E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2ImwZfQoTJf for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:40:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB45980E32
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685656;
 b=giNb8MbTIj31RTLgpoWLSjg9dto7zugZrCfIgT5shAFiGPt8k4NruakzTIt1Azzanj8O
 GCCbINd+SEJaqluN9C9bqv5cSpMjb3+94XhxhYUmQCR6nJplU/+5j4wKIDjk2MMShQbow
 F8WekBBR6vHO2NXpv+nRJisuy2CMYEfePCBam+mjaBAJDHS4H3viDb+3HqC9KVqFONB8K
 0Y2td5OZsLKNyeaIDwDu4Bg5uSfRNmd7gkvLPfXi7a4xAk1gKyY0aAoRgHkq1eR4gSKcz
 5Kn/Efc8QMlDntjtiBuZkuXs3Yo/3+7gjo6WYZCgwL+v0Df4fRRwXh1952Bpg1EPupg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685656;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=50lFQ7PF9RmR+KUzx50FRTmpEWSzSyxZ9IyBu17xza0=;
 b=RtOD6/8RZaUawjDJCBgFYQGgfZCMCBnR+zt1l922VjV7qt2dFY0C3v2AFG6iHdXsHcRA
 xNrcgixFAJqxNVCOkNb5GXK9NMdjK2s6osUGjRt/IrwsUEhsAoVJPZCV7DK87vA5frBGh
 jBaFAPoE+c94SJCe5K8+CZa1JWrMwKEdBk8vOGqDH3QJMaKUmN5bVmHtmkyVKVn6uwJRX
 qiAFOdiTX7dV6U1Q593Jqul6s4RQ2sLZR3SwOy28hQIhM5qvQA/7YvmidJ28ZuRTpHs5q
 yi8MQLmQbwy0gOOA5oocZ61PATPVO4BQ2IK0r0vHFcloKrauz/Yy1kPmxLskvGS9Mbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=enAUvR2t; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=hfranco@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=enAUvR2t
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB45980E32
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:40:56 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8a886c555eeso37331897b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685655; x=1791290455;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=50lFQ7PF9RmR+KUzx50FRTmpEWSzSyxZ9IyBu17xza0=;
 b=enAUvR2tAIIa41GwNq4THwux8SD1gtAzJw+o4pZDuNolqLgeKa9+kWFaZQgKu1vbpX
 ShtjjNP7jUZGOwzmfEb2+igvNL1wx/pVIxRSrrOvNH9cs3e7Y6+lJr7wPnK02TBc/14c
 q6EVSH59thRPBum8lLZvIGmR2k7b15DPLZbEvhGQ7fVqErtSqrhGVBM2N/1DR3DNQ+Tr
 f92v4fAZMns4P2/xIE6jrR+2ZY9YQ3+bwoWlWwDlPEkTgOvHMtP+48V+TCvdgDNklfb9
 HftncpRbXaKG1ahM3hU1lXfi7nsyOHSzH8cC+laoHQmoRiHXgTUIij7ead6g5t9c2Xmp
 pC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685655; x=1791290455;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=50lFQ7PF9RmR+KUzx50FRTmpEWSzSyxZ9IyBu17xza0=;
 b=AvsBzVCdYDe5dpeoY0ssz2oqDAOPStQs+q/HHnhusxaa4B/IwVF6y5hTwuezAIJSNX
 3KuKJvdMtQT9Rk7YtvoEJRpR/FE2eJZkPsKxut+yPXEUv6F7lXH24aJ02bb1na1LsMee
 RwwDNStbCeQE1hRwgsd8Xgs1gVNhMlPcopw14HkVQ0pL0/cSHwD3MiefyaX3bYeGmjYI
 YYsj5IQ12pRHyfwzucovbfnIaKMqIGNA5dqGLN0gPwTClfy57pai/rxvdW6I6PaMwPWY
 ZoVP3n4ld6Y8BtL9PPBSy5zvFs+ttzU3ivS2riag9I1H6NLqKcqAh9baANf23bNW76KU
 xFgA==
X-Gm-Message-State: AFq9FYI+JFe3zwyYCTe8BQN17noeEt8rtu1NOSo9y8UWkv2LUA5N07jg
 dFZ/BFgdmIY3TPHbvjfv3E9zqTg3BB4MGlckN29LHpkZ2RYSzbhcPx/5eNH4NOHYzSk=
X-Gm-Gg: AYBFou1lvptqjsQYdJk1R03NdGAXbtFjH2egTJSwzPIMbBwSfL0JtHBVuMXywsUZ/yL
 YFi8Vb826f8UDZHaZI5Vq2oE3bnYUPzvvbE3Y5jcGUOd/mpIo/pjCTuB/rYYO9T3ZeUwhXB4H4E
 U1EvNT0pC330h47ZKXSP4jMEsJkounF3ly21XZ9Q8VDm9mto1vGwQ6gqqZ7GHAn268gkQZ5ucG6
 sFxxDshWL60+6EBWm9wGe67A2cdSrDsXPpUP5MorBcTmeNrAtwah88gcSMfHmfHCzxB8snGdCvu
 97XbkGafaQknt+iiOlnyix0rfkYREj/4mKNuvt0TITHfVHo4IU0/9dMqb05b6vfrDDC3vsuH62f
 KQRuQxIRfBUq6Es6om3IkAOlzJN2Z3Q9GCvhS2VKFSZij2cyhLpOknPiVa2SOeO8N65qmmq6JSw
 2T9T1y3HqxAPTUJJ7a/I4PuGHQpeoWHAieZ5Di5cCLG6M7W9DhwI9FjUfrHT09F/xmyhKS+ldZe
 vZ5jXHjmgam/jRawbejJ5zHJzQlCq0ZPQ==
X-Received: by 2002:a05:690c:e3e6:b0:873:5c6b:a303 with SMTP id
 00721157ae682-8a86d7e2910mr44803507b3.49.1790685655099; 
 Tue, 29 Sep 2026 05:40:55 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a861064448sm57273937b3.47.2026.09.29.05.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:40:54 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:40:44 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>,
 Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Chen-Yu Yeh <chenyou910331@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrei Lalaev <andrey.lalaev@gmail.com>
Subject: Re: [PATCH v5 00/10] riscv: sophgo: Use upstream devicetrees for
 CV18xx boards
Message-ID: <aruxYgDv7K2voR35@hiagonb>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:50 +0000
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

On Sun, Sep 27, 2026 at 08:08:55PM +0800, Zhuxu Ran wrote:
> Milk-V Duo, Milk-V Duo 256M, and LicheeRV Nano currently use local
> devicetrees under arch/riscv/dts. Equivalent descriptions are available
> upstream, but Milk-V Duo 256M support has not yet reached U-Boot's
> dts/upstream tree.
> 
> Import the upstream changes required for Milk-V Duo 256M and enable
> CONFIG_OF_UPSTREAM for all three boards. Add the clock and SDHCI
> compatible strings needed by the upstream devicetrees.
> 
> U-Boot-specific overrides retain Ethernet and SPI NOR support on Milk-V
> Duo, and Ethernet support on Milk-V Duo 256M with its optional IO board.
> Enable the MDIO mux support required by the Duo 256M Ethernet topology.
> 
> With all local users converted, remove the local CV18xx devicetrees and
> the legacy "sophgo,cv1800-clk" clock compatible string.
> 
> Tested on Milk-V Duo, Milk-V Duo 256M, and LicheeRV Nano. Build-tested
> for all three boards with the riscv64-linux-gnu cross compiler.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>

Thanks for the patches! For the whole series:

Reviewed-by: Hiago De Franco <hfranco@baylibre.com>

> ---
> Changes in v5:
> - Move the RTC and system-reset changes to a separate series
> - Enable the MDIO mux drivers required by the Milk-V Duo 256M upstream
>   Ethernet description
> - Link to v4: https://patch.msgid.link/20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com
> 
> Changes in v4:
> - Import the upstream Milk-V Duo 256M devicetree changes
> - Switch Milk-V Duo 256M to CONFIG_OF_UPSTREAM
> - Add CV1800 RTC support and bind system reset through the RTC node
> - Preserve Milk-V Duo 256M Ethernet support through a U-Boot override
> - Link to v3: https://patch.msgid.link/20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com
> 
> Changes in v3:
> - Restore the CV1800B SPIF node in the Milk-V Duo U-Boot override
> - Link to v2: https://patch.msgid.link/20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com
> 
> Changes in v2:
> - Expand the upstream devicetree conversion to LicheeRV Nano
> - Add SG2002 clock and MMC compatible strings
> - Enable hardware system reset on LicheeRV Nano
> - Remove the legacy clock compatible string after converting all users
> - Move the Milk-V Duo Ethernet description above the gmac0 node
> - Link to v1: https://patch.msgid.link/20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com
> 
> ---
> Chen-Yu Yeh (3):
>       dt-bindings: soc: sophgo: add Milk-V Duo 256M board
>       riscv: dts: sophgo: cv180x: Add PWR_GPIO controller
>       riscv: dts: sophgo: Add Milk-V Duo 256M board support
> 
> Zhuxu Ran (7):
>       clk: sophgo: cv1800b: Add SoC-specific compatible strings
>       mmc: cv1800b: Add SG2002 compatible string
>       riscv: milkv_duo: Use upstream devicetree
>       riscv: licheerv_nano: Use upstream devicetree
>       riscv: milkv_duo_256m: Use upstream devicetree
>       riscv: dts: sophgo: Drop local CV18xx devicetrees
>       clk: sophgo: cv1800b: Drop legacy compatible string
> 
>  arch/riscv/dts/Makefile                            |   3 -
>  arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi       |  35 ++++
>  arch/riscv/dts/cv1800b-milkv-duo.dts               |  64 ------
>  arch/riscv/dts/cv1800b.dtsi                        |  22 --
>  arch/riscv/dts/cv18xx.dtsi                         | 232 ---------------------
>  arch/riscv/dts/sg2002-licheerv-nano-b.dts          |  45 ----
>  arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi    |  16 ++
>  arch/riscv/dts/sg2002-milkv-duo256m.dts            |  46 ----
>  arch/riscv/dts/sg2002.dtsi                         |  34 ---
>  board/sophgo/milkv_duo/MAINTAINERS                 |   3 +-
>  board/sophgo/milkv_duo_256m/MAINTAINERS            |   1 +
>  configs/milkv_duo_256m_defconfig                   |   6 +-
>  configs/milkv_duo_defconfig                        |   3 +-
>  configs/sipeed_licheerv_nano_defconfig             |   3 +-
>  doc/board/sophgo/milkv_duo_256m.rst                |   2 +-
>  drivers/clk/sophgo/clk-cv1800b.c                   |   3 +-
>  drivers/mmc/cv1800b_sdhci.c                        |   1 +
>  dts/upstream/Bindings/soc/sophgo/sophgo.yaml       |   4 +
>  dts/upstream/src/riscv/sophgo/cv180x.dtsi          |  18 ++
>  .../src/riscv/sophgo/sg2002-milkv-duo256m.dts      | 121 +++++++++++
>  20 files changed, 210 insertions(+), 452 deletions(-)
> ---
> base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
> change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61
> 
> Best regards,
> --  
> Zhuxu Ran <zhuxu_ran@zohomail.com>
> 

Regards,
-- 
Hiago
