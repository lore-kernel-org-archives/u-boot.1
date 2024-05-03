Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D5BC25B5C
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 12:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 038CD88BFA;
	Fri,  3 May 2024 14:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NfRT2Elh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A505889B3; Fri,  3 May 2024 09:20:55 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B85688321
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 09:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2dd7e56009cso113358841fa.3
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 00:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714720852; x=1715325652;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=REdFTmHIlwCqR4PKSWblussRFjdlzqmgn8RBoUVjFYc=;
 b=NfRT2ElhU87y0kMK+u7pqjLYiWkvmDQTfwhFwP4/ZOhHWohbqLlkgByG7pkIv0UyG7
 q7vrGCArfWz2YuEHa0WWJUkmnCm6LeM7TffH1Umg6DiHnx3ffP6sajS1CYstZA4UmnJp
 8WeMLlXe5IpbHKmNMXUtw8T/xF+jpH+lkWKiXvN+APUbjJJwD/efHUgc91XiFDq0le8Z
 7YLUOL2xy6OPhzzcTeCPlixqFvX26GTGL+ARlJwq7FMG4hY6wJmXveombKgqimJm+tnm
 VGLDF/ELaKFsDYd1Gfc+FFM1agrrToNFSwOs8RJ8nsn+lvY8uuoqLWoq7d9Kn/oSIFlR
 eZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720852; x=1715325652;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=REdFTmHIlwCqR4PKSWblussRFjdlzqmgn8RBoUVjFYc=;
 b=p4k06OszUxkAPck06LIB1PWtgPxB4IOEDC5l4i9AkgZrk1PLM07I1uYSMJ3v6HDbNM
 U4+LlTKoUEpscX9CUs4HBKCcwKIpbmgawWivo/UlUlEqkzK+1XLdSKFB8qJ9t8uMQCS4
 mQqnqG+BxXvtsYLTxXCfNCcgyt/J704TFHxMNg0y9KVXt4e5TuzsFSSq9RBJMCbuKZBL
 56ZH/oSUzPR9nlu8K+SpMqpPU4Cin4QLRCgKCzCWk15APzsNYapQnpxxaxhHRCnt8MhZ
 ZGTkIp13QX5YxE2jatnp4csiZCmicWq18U7ZuKnoYileofz4VsyAp3leN3QCjAD2+1+f
 RFZg==
X-Gm-Message-State: AOJu0Yzz0g2cHicPMvw2lwkKO7so+RTIYmjOMKyK224EmwoaR8Ji02HL
 PHdXLZ8rBQDQ1lztia60eLw5isuZw1jlnJYCD9nxJCV2u+jNdgAkm6+4hKtZNN8=
X-Google-Smtp-Source: AGHT+IHe7H/QiyJVtAttVGASM0yQ74ScnEg62gOHC6lCRZxubl/bS/ZjrcEd3nK035cByQ6W2ybKJw==
X-Received: by 2002:a2e:7d0e:0:b0:2e0:c1b8:4917 with SMTP id
 y14-20020a2e7d0e000000b002e0c1b84917mr1156761ljc.12.1714720852240; 
 Fri, 03 May 2024 00:20:52 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a05600c1c8800b00418a6d62ad0sm8400613wms.34.2024.05.03.00.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 00:20:51 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>, Eddie Cai
 <eddie.cai.linux@gmail.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie
 Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Nobuhiro
 Iwamatsu <iwamatsu@nigauri.org>, Stephan Gerhold <stephan@gerhold.net>,
 Linus Walleij <linus.walleij@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Nishanth Menon <nm@ti.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Roger Quadros <rogerq@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Peter Korsgaard <peter@korsgaard.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Alexey Romanov
 <avromanov@salutedevices.com>, Sean Anderson <seanga2@gmail.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Teik Heng Chong
 <teik.heng.chong@intel.com>, Tim Harvey <tharvey@gateworks.com>, Mathieu
 Othacehe <othacehe@gnu.org>, Fabio Estevam <festevam@gmail.com>, Johan
 Jonker <jbx6244@gmail.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Sam Edwards <cfsworks@gmail.com>, Andre
 Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 73/81] usb: Remove <common.h> and add needed includes
In-Reply-To: <20240502145121.GW1054907@bill-the-cat>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-73-trini@konsulko.com>
 <87o79o4q63.fsf@baylibre.com> <20240502145121.GW1054907@bill-the-cat>
Date: Fri, 03 May 2024 09:20:48 +0200
Message-ID: <87h6ff8ipb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 03 May 2024 14:36:07 +0200
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

Hi Tom,

On jeu., mai 02, 2024 at 08:51, Tom Rini <trini@konsulko.com> wrote:

> On Thu, May 02, 2024 at 09:40:52AM +0200, Mattijs Korpershoek wrote:
>> Hi Tom,
>> 
>> Thank you for the patch
>> 
>> On mer., mai 01, 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>> 
>> > Remove <common.h> from this driver directory and when needed
>> > add missing include files directly.
>> >
>> > Signed-off-by: Tom Rini <trini@konsulko.com>
>> 
>> [...]
>> 
>> > diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
>> > index fedcf7869295..38c5928faed5 100644
>> > --- a/drivers/usb/host/xhci-rcar.c
>> > +++ b/drivers/usb/host/xhci-rcar.c
>> > @@ -5,7 +5,6 @@
>> >   * Renesas RCar USB HOST xHCI Controller
>> >   */
>> >  
>> > -#include <common.h>
>> >  #include <clk.h>
>> >  #include <dm.h>
>> >  #include <fdtdec.h>
>> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> > index 910c5f3352b8..1360a5940fa0 100644
>> > --- a/drivers/usb/host/xhci-ring.c
>> > +++ b/drivers/usb/host/xhci-ring.c
>> > @@ -13,7 +13,6 @@
>> >   *	    Vikas Sajjan <vikas.sajjan@samsung.com>
>> >   */
>> >  
>> > -#include <common.h>
>> 
>> This generates the following build warning with
>> khadas-vim3_android_defconfig:
>> 
>> drivers/usb/host/xhci-ring.c: In function 'xhci_wait_for_event':
>> drivers/usb/host/xhci-ring.c:464:28: warning: implicit declaration of function 'get_timer'; did you mean 'get_mem'? [-Wimplicit-function-declaration]
>>   464 |         unsigned long ts = get_timer(0);
>>       |                            ^~~~~~~~~
>>       |                            get_mem
>> 
>> Adding: "#include <time.h>" fixes the warning.
>> 
>> With the above fix included:
>> 
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Did you have the full series applied? I don't see the warning here (nor
> in CI) and I suspect that:
> https://patchwork.ozlabs.org/project/uboot/patch/20240502013138.2383421-9-trini@konsulko.com/
> is what resolves this warning.

No, I did not apply the full series. I had some conflicts on both:
- master: ff0de1f0557e ("Merge patch series "Update PHYTEC SOM Detection"")
- next: bc39e0677816 ("Subtree merge tag 'v6.8-dts' of devicetree-rebasing repo [1] into dts/upstream")

The above patch resolves the warning, indeed!

Thanks


>
> -- 
> Tom
