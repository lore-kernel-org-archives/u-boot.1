Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F10DC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DD68605D4;
	Mon, 27 Jul 2026 09:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p4ga4fIfrqsr; Mon, 27 Jul 2026 09:28:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 623C160639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785144501;
	bh=ZoAMsqRcrBEii9wfevUxtPfxdY+ZWWKQ67MBomXgHzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vs+rPtLTPk8aqx1jaHufsGwOpyRKKybZgDhV2VO+M58ow/x+NCWS0UQrhSVQsabNL
	 hpFld1CXGEki5Zg0z+21aOzfhVUS9tiu4ap8HY09Vf0HI64ttuEcJIxh73cGM8wE6p
	 hENTVZ9SpCXsV3MzA2EQuwBHoKDvW0vuMJc8uUg2YJ7RgBRSndMyoT51DwDT8tf0SU
	 DqtquHuDdRO7IV3CT7bvaLFLwdPWKEnhMUKZoGmikD+tetu4CBDSb14q0+E6AEIgLE
	 SAIB28rFQYQSEo2e/DmgJmbYXUGt89wdbruKx1gQF4ZwKJzTDsjrBwGslV8x6VE3Vg
	 tDZT+88zQl/4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 623C160639;
	Mon, 27 Jul 2026 09:28:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3296357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4F3740109
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:28:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LEMDP_RZjLFI for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:28:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4E80340061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E80340061
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E80340061
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:28:17 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-81ed2a06b9eso18590487b3.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 02:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785144497; cv=none;
 d=google.com; s=arc-20260327;
 b=bVskvJfI6iSSDUfqVKl002yAw9OFQltt0dk7FKlPIbo9PErkIS2cgemU1f69L56Aw9
 r3ZgbQ0eSW5oz33hiu+MkOAzBKd8Kq6hK/CNvTAk8hcTQF0tBPDN1oKfgxn66hQtqcQt
 m2y4X3iXchW48LZPYQcdhprWfKJao5qftCSLWy6clayazgOeqAh/ju/CzvCwxu3SZ+Gv
 nTz1zELOEYZuq3gLoLcv7o6OTVJmyEoLGPf8ojU/cNqF+kWGZxnVgn5TkDoPlWtHPYk3
 9W42+SefN6xecJqZZ96Mzxc+mzuDdubblmEzeIlbrFL2/5FLyljp7+14VlU/EFpuVX24
 SW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZoAMsqRcrBEii9wfevUxtPfxdY+ZWWKQ67MBomXgHzM=;
 fh=GLc+AF6CzX/0iy38pbw8P4k4+dQ7x7o1Y6NMNEWqbu8=;
 b=MTVyN3rUC2AywiiGhs/U+KmRag5ZEc4NYmzmiJn8bmZjgXHu25bBIKvuY5+pbQW6Lo
 dYPEYcVeKJ67ZcSoFr9m9oFC4t7Fln38+K5Cf9yj5gcelmlqwQIvy7cSNe9LD4x53mR2
 T+LIJbUh5cY84eXyAMjN8vYoF03MPN2K/7GAqx2fgknxJe0gwz8U0gUxpYg0WLeq9LjD
 FoZPiVxPxNlEQSrFKWoUBcPCFYRNsYHtlsKhPLATkJtzkbc4/+1tR5d1wjzKsPMRhrP+
 lcmL4WWrxWMFrtAaw6PEGeEBrBN9kCWFKU9GY6ETNu3s9Y1l02LcDMm0Ru9FJNY0YPDL
 +rOg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785144497; x=1785749297;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZoAMsqRcrBEii9wfevUxtPfxdY+ZWWKQ67MBomXgHzM=;
 b=VB0t+KcOqBYIqv03rktCV0gnO230NPheJut3a50tW6FVWK2s1bkQPMHJHL+29THSJv
 jZFK7GfaPRETCDV7I+0qfFSduwiq+RQ5OnGzv4naGFU4GrnuC5lIkkR5ySXnG7qyjS9N
 ENcdDIxcRxrOlwS4EtuLgl3fsvJcAVJiFa42DAzOaQ3O1mSmItrYsKYPO+F9AOir3AaX
 sR0piTYUbwZ6CLcivEklqUKXmF+TBg4lHAt4StmX4wAnU9XszKX0I/PUFLjVPBVbE6iy
 BLkpDFY9huAF/Jqeuhz5H9Kl2HxX2ieK4VCEd8Eu/8df+4LmiuZZAgOQiNJ013nB7p77
 pjDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rre1prAm48ksMPst0MceJe/dtG1znBCtNj4ROIji3oPT8Rb8OZipm+ZypSGyZNZtAMJtsqRTRA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzmuSJSYNJ9/F4CrBxAKinE+4peBzH8we5W2H10vyD69dRnBNBu
 GWfUhiG+XhAc9m9ChAA5ifrSdWkJriZxqQRdxWaAcm/18Nbz7uuOOf9tq4Kf6aVjKNIJE4S+Rlx
 WEYGCr+D8VMyXeBo4T49V8HV6og57oyBkHayzwhZGKIGcZGo11y8Cgpyynw==
X-Gm-Gg: AR+sD1012vhE3EP/q0HUlCW1wzZdfPAXJpbMK8EvEOiPjB+NKmv6QrFYLL1K7I+890D
 oF71u5IQh/6pV+/lr1EUrHOt1reuWxM97lThd8xPAPdiMpxQ3KDyEKxuKKiA5E5QVMZJDbK2lzD
 aplrcNyB/iwKK5Jv0OnfNdVJ1VKOh3HhABxy7i0OvBmEcr1wII4V3o8xeRBlQ5FeLSXSy5dJg6A
 6Svhnc5V1t5XVuohqK3dqei2elAe3/Q0zjkjAdgkeuhYmhhM/FoWHuxM+XgB31pw9LOVCiP6oz3
 X6MV5oTLsoG8maiwJItSK7JQPAbMW4oQnne2HXAorPexU9Gq4llxEbSl/A6e4zYrgneB60t5nAm
 /BDTX1g==
X-Received: by 2002:a05:690c:600c:b0:80c:f6bb:5666 with SMTP id
 00721157ae682-81f69e2c18emr24402467b3.47.1785144496690; Mon, 27 Jul 2026
 02:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com>
 <871pcwk88o.fsf@kernel.org>
In-Reply-To: <871pcwk88o.fsf@kernel.org>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 27 Jul 2026 11:28:10 +0200
X-Gm-Features: AUfX_mywcYnVs62I-PN_FHsHTCj0HpRBSXjSpS4m9XVvCVF6_2HfFlMyyAB_zb8
Message-ID: <CAEHHSvaU-jTdN5PJoTnyy4Qq7J34SLQMgtx0+uqTsbpn7vmyOw@mail.gmail.com>
Subject: Re: [PATCH] phy: phy-mtk-hdmi: add new driver
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785144497; x=1785749297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZoAMsqRcrBEii9wfevUxtPfxdY+ZWWKQ67MBomXgHzM=;
 b=aOJDdATC7YtvIgOFj865hhfqLaSnImy4vHc3D4dyDG5tUZ5M+OToljJZAEHyN2k66N
 US3/lewuvpRbWLtePNl59rXn+kwZMg4g0oLfMF14MxHS6OyjaHQVu+IFsV77PADcGAuG
 Ia4kW0257rTQ9emArK/EHmF+4DoORI0GCdkMaeDu2/11KdIG52V0pzUAA7uhMcdGrm7g
 vhWkFrwIMJxQ5u7nlq3gbe4QMU20kAaMKPaLRPB2yZD3RtrWNMwGseyFRXXv2V3VmF0p
 BtSeKhRdI/k/5Z2xbQThWE41h027sEKEx7ZKpbpmbNMcMQ1s8BPPzNthxl/qNNtlgepm
 gy9g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aOJDdATC
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

Hello Mattijs,

(used the new u-boot ml address u-boot@lists.u-boot-project.org and
dropped the old denx one)

Le mar. 21 juil. 2026 =C3=A0 11:22, Mattijs Korpershoek
<mkorpershoek@kernel.org> a =C3=A9crit :
>
> Hi Julien,
>
> Thank you for the patch.
>
> On Fri, Jul 17, 2026 at 10:26, Julien Stephan <jstephan@baylibre.com> wro=
te:
>
> > Add a new driver for the HDMI PHY. The driver supports MT8188 and MT819=
5
> > based SoCs. The driver is based on the corresponding kernel driver.
>
> What kernel version (exact commit, including the sha) has this been
> ported from ?
>
> Mentioning it in the commit message will help reviewers to compare this
> with the linux codebase.
>
> I can do a more detailed review once I know the linux base this has been
> ported from.
>

Technically it's not a direct port from the upstream kernel driver.
The code comes from an old downstream MediaTek code base.
I guess it was polished a bit during kernel upstream, hence some
variables names and functions are not 100% identical..

So what would you like me to do? Send a v2 with a proper backport from
kernel? Or being more explicit on the commit message is enough?
Something like: "The driver is loosely based on the corresponding
kernel driver at  45810d486bb4 phy: mediatek: add support for
phy-mtk-hdmi-mt8195)

> >
> > Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
>
> [...]
>
> > +
> > +     /* RG_HDMITXPLL_RESERVE[12:11] */
> > +     mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
> > +                       0x3 << RG_HDMITXPLL_RESERVE_BIT12_11_SHIFT,
> > +                       RG_HDMITXPLL_RESERVE_BIT12_11);
> > +
> > +     /* TCL_EN */
> > +     mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
> > +                       0x1 << RG_HDMITXPLL_TCL_EN_SHIFT,
> > +                       RG_HDMITXPLL_TCL_EN);
> > +
> > +     /* we should always read calibration impedance
> > +      * from efuse, unless for debugging purposes.
> > +      * This calibraion value is not board-dependent
>
> calibraion -> calibration
>
> > +      * so no SW adjustment required.
> > +      */
> > +     if (hdmi_phy->conf->efuse_sw_mode) {
> > +             debug("efuse_sw_mode ENABLED!!!");
> > +             mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_1,
> > +                               0x1f << RG_INTR_IMP_RG_MODE_SHIFT,
> > +                               RG_INTR_IMP_RG_MODE);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
> [...]
