Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F9DC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD7BD80E20;
	Mon, 27 Jul 2026 12:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TA8so9VgEHxE; Mon, 27 Jul 2026 12:35:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C68CA80D1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785155722;
	bh=9rRrygqIDRVYfkvP2GMC2fPsHdZs0bZzX9BKToKywzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bJenuzE+qmb/zATLi61mwPSxm5idFAJgU9Qp2hY6Gf2hFUeb9jpIBmi00gaUAz6jS
	 09/pS8KnjfeXGEBuAyTHlGCHgv84YK4TCD4rLcGR7CSlR7KMAvYbv8spGPyPz3EoHY
	 DX7I7eVdqyg9EVMdOvi7tLQAm5nQHjVOgLF6znbmZhgwd3qUbqNDwCPaMyGmmueN/A
	 uzF0FCfcYzfLFceyTAB0TrQFGU0+Q9pdGt2Sk3K4ooL3Oh+aGcMnC/IrhtCQvDXHkS
	 yAESw1ZBht7mw2gkA92y0hoOZVTx8Il4p/IhljX3FrCHkK0HOTfpuOIAB1sapxuSeH
	 +GOM9Evas53uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C68CA80D1F;
	Mon, 27 Jul 2026 12:35:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B17B4C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 511B9606EC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YuqTi6cXpS0Q for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:35:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4DAC8606E2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DAC8606E2
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DAC8606E2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:35:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB65C43950;
 Mon, 27 Jul 2026 12:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DF31F000E9;
 Mon, 27 Jul 2026 12:35:17 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Igor
 Belwon <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>, Minkyu Kang <mk7.kang@samsung.com>, Casey
 Connolly <casey.connolly@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Lucien.Jheng"
 <lucienzx159@gmail.com>, Alice Guo <alice.guo@nxp.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Johan Jonker <jbx6244@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Pavlo Yadvychuk
 <pyadvychuk@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] phy: phy-mtk-hdmi: add new driver
In-Reply-To: <CAEHHSvaU-jTdN5PJoTnyy4Qq7J34SLQMgtx0+uqTsbpn7vmyOw@mail.gmail.com>
References: <20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com>
 <871pcwk88o.fsf@kernel.org>
 <CAEHHSvaU-jTdN5PJoTnyy4Qq7J34SLQMgtx0+uqTsbpn7vmyOw@mail.gmail.com>
Date: Mon, 27 Jul 2026 14:35:15 +0200
Message-ID: <87ldaw3918.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785155718;
 bh=9rRrygqIDRVYfkvP2GMC2fPsHdZs0bZzX9BKToKywzw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=N6AQJfF05bIuchskV2hpIh1+mfFrvz4bjqCurOR3BEzsszO54aXgAXNh+L5Qoz56n
 kep9VpAsz0/gZ/IOnu4aObFUmsxBju20QDFxxPwLWVlBqBdPYkuPg6ljcvo911mGSo
 M9HK03fPJez1kTW3aIiv7+SQpZp3DxMmgEJz66AVsUxNLtyiyyd/nFKG1SN+SbFPQ4
 P/2h/GeQR3mFlj1iYbYTla3ETi1kpmD6u89o9UswUdjohJP6XyYcAAZlAJ9FM6ekqo
 kMYgwz+wlvn0U9WNs715WLAWO4kCNerBRsQrqkkXSV4DyJ0gCt9viuQo0EXSF1PgII
 WSiYCs+dCgndA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=N6AQJfF0
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

Hi Julien,

On Mon, Jul 27, 2026 at 11:28, Julien Stephan <jstephan@baylibre.com> wrote:

> Hello Mattijs,
>
> (used the new u-boot ml address u-boot@lists.u-boot-project.org and
> dropped the old denx one)
>
> Le mar. 21 juil. 2026 =C3=A0 11:22, Mattijs Korpershoek
> <mkorpershoek@kernel.org> a =C3=A9crit :
>>
>> Hi Julien,
>>
>> Thank you for the patch.
>>
>> On Fri, Jul 17, 2026 at 10:26, Julien Stephan <jstephan@baylibre.com> wr=
ote:
>>
>> > Add a new driver for the HDMI PHY. The driver supports MT8188 and MT81=
95
>> > based SoCs. The driver is based on the corresponding kernel driver.
>>
>> What kernel version (exact commit, including the sha) has this been
>> ported from ?
>>
>> Mentioning it in the commit message will help reviewers to compare this
>> with the linux codebase.
>>
>> I can do a more detailed review once I know the linux base this has been
>> ported from.
>>
>
> Technically it's not a direct port from the upstream kernel driver.
> The code comes from an old downstream MediaTek code base.
> I guess it was polished a bit during kernel upstream, hence some
> variables names and functions are not 100% identical..

Ah, that make sense.

>
> So what would you like me to do? Send a v2 with a proper backport from
> kernel? Or being more explicit on the commit message is enough?
> Something like: "The driver is loosely based on the corresponding
> kernel driver at  45810d486bb4 phy: mediatek: add support for
> phy-mtk-hdmi-mt8195)

Ideally, we would do a backport from the Linux driver. That will make
future maintenance easier since we can continue porting fixes (when
relevant) from Linux when they arrive. That's probably a bit more work
though :(

If you want to keep this implementation, then I'd be more precise in the
commit message. Stating that it's based on a vendor driver and has been
polished up for U-Boot.

So I have a preference for doing the port from Linux, but I won't block
this if we just reword the commit message. Up to you to decide what
you'd like to do.

>
>> >
>> > Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
>> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> > ---
>>
>> [...]
>>
>> > +
>> > +     /* RG_HDMITXPLL_RESERVE[12:11] */
>> > +     mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
>> > +                       0x3 << RG_HDMITXPLL_RESERVE_BIT12_11_SHIFT,
>> > +                       RG_HDMITXPLL_RESERVE_BIT12_11);
>> > +
>> > +     /* TCL_EN */
>> > +     mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
>> > +                       0x1 << RG_HDMITXPLL_TCL_EN_SHIFT,
>> > +                       RG_HDMITXPLL_TCL_EN);
>> > +
>> > +     /* we should always read calibration impedance
>> > +      * from efuse, unless for debugging purposes.
>> > +      * This calibraion value is not board-dependent
>>
>> calibraion -> calibration
>>
>> > +      * so no SW adjustment required.
>> > +      */
>> > +     if (hdmi_phy->conf->efuse_sw_mode) {
>> > +             debug("efuse_sw_mode ENABLED!!!");
>> > +             mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_1,
>> > +                               0x1f << RG_INTR_IMP_RG_MODE_SHIFT,
>> > +                               RG_INTR_IMP_RG_MODE);
>> > +     }
>> > +
>> > +     return 0;
>> > +}
>> > +
>>
>> [...]
