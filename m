Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4271CD5BCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB36867B5;
	Tue, 19 Sep 2023 17:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="FlVjZOwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2D6866EC; Tue, 19 Sep 2023 17:11:09 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206BB867B5
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 4A02F100008;
 Tue, 19 Sep 2023 18:11:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4A02F100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1695136264;
 bh=QUJb6we87GpLSR4vBwZFIU06vZYAZlpvhE5WwGbPdbY=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=FlVjZOwTegpzToLAsU8Yuzc52SHOKvhuMVc35V0wIoRGPt3uW73g58JBGXKvWWMgn
 Kqu+hyX/sc/EXOaRc8DFJQQwcNaAdLRx19xHUzAEmLIeqgC19ilf3NBP9lzC/xVRv3
 MbjZw4rsNzqe228eUQTc48BTXNf63GPInKzL+53hW5lXN44MjlS/PD/pw0YnyrMh5p
 Hilw2nobnBj57NWjalx30Y0xvTbtPN85Tr7Tvy/SDN/DyFSjNX73n4zBW3NgbVf7ns
 uuzPfigHlFp8sFmSxxMe3dvT/2a6MciCgvkVv2yB82j6aao/LCmc97yVS5c/Vrol6n
 qOVrhrZstzL8Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 19 Sep 2023 18:11:04 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 19 Sep
 2023 18:11:03 +0300
Date: Tue, 19 Sep 2023 18:11:01 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Simon Glass <sjg@google.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, <prusovigor@gmail.com>,
 <kernel@sberdevices.ru>, <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [RESEND PATCH v1 2/2] clk: Add clock driver for Amlogic A1
Message-ID: <20230919151101.r737krvo2w533pww@pc>
References: <20230917101308.1250-1-ivprusov@salutedevices.com>
 <20230917101308.1250-3-ivprusov@salutedevices.com>
 <CAPnjgZ2NsSiArxW2gn0bD2JgMxqXXA=Lqx48NLfGeKVhxTMeEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2NsSiArxW2gn0bD2JgMxqXXA=Lqx48NLfGeKVhxTMeEQ@mail.gmail.com>
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179967 [Sep 19 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 534 534
 808c2ea49f7195c68d40844e073217da4fa0d1e3, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/09/19 13:13:00
X-KSMG-LinksScanning: Clean, bases: 2023/09/19 13:13:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/19 04:37:00 #21921740
X-KSMG-AntiVirus-Status: Clean, skipped
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon, 

On Mon, Sep 18, 2023 at 07:04:47PM -0600, Simon Glass wrote:
> On Sun, 17 Sept 2023 at 04:14, Igor Prusov <ivprusov@salutedevices.com> wrote:
> >
> > This patch adds basic clock driver for Amlogic A1 Family which supports
> > enabling/disabling some gates, getting frequencies and setting rate
> > with limited reparenting.
> >
> > Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> > ---
> >  arch/arm/include/asm/arch-meson/clock-a1.h |  23 +
> >  drivers/clk/meson/Kconfig                  |   8 +
> >  drivers/clk/meson/Makefile                 |   1 +
> >  drivers/clk/meson/a1.c                     | 681 +++++++++++++++++++++
> >  4 files changed, 713 insertions(+)
> >  create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
> >  create mode 100644 drivers/clk/meson/a1.c
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> This could use a few more comments, IMO.
Sure, I can add some more comments in V2. 

> Did it come from Linux?
No, I wrote this specifically for u-boot. I initally was looking at
other drivers in clk/meson/ for reference, but decided to go for
something like clk_k210 driver to separate clocks topology and ops
implementation. These clocks were added to Linux in [1], but AFAIU we
can't simply re-use Linux clock drivers and get working rate
propogation, reparenting e.t.c.

[1]: https://lore.kernel.org/all/20230523135351.19133-1-ddrokosov@sberdevices.ru/

-- 
Best Regards,
Igor Prusov
