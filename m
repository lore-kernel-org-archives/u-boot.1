Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F6DC54F55
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8351240A87;
	Tue, 28 Jul 2026 15:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xyBWVB86wlsr; Tue, 28 Jul 2026 15:03:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57F6B409EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785251034;
	bh=feJakri/Re3eEduDFY3I/Vsgo1V41x3QsWDvhzyqzHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OcRXx8xCyqF0CK0Eb3JDD4vKUCtGc2rOoOtlyp65nwP/1RTrDJa3rbtGFbDclT2hJ
	 5d9vZATa1yqZEQ+XWC5mNE94UaC6aYllc6bT+aECEUE3nWlhGeHdIAiJI42lZmPcE3
	 gjMIHYaPVo9EzX5V7ibfdd6S2w+5zvKdRhPgWySw2cZtjTkG9whE1srF3jLn4SR897
	 7xI4vYBJg0bijQOq0tc14pAE7IAhdH8ytMkyUYdRbrLPD1StKYAYMdPdj8fLwlBfqk
	 V0Zo5xkMwkpRpBWCn9YN1tum6HQ/9Sl68hHVz/jsr0orN9J4q4+qxRTpSGjKZR3d1o
	 O2E0TMTm8WLiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57F6B409EE;
	Tue, 28 Jul 2026 15:03:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FB5F4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3124381414
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:03:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7H83St_RjGyI for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 15:03:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 36A29813ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36A29813ED
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36A29813ED
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:03:50 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1677c91969so413848366b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785251029; cv=none;
 d=google.com; s=arc-20260327;
 b=tA+vnLgrWSb3tO0HozcxnUYKub0v8HS6AiAVI580cJRF4DZjDRWkmrOTQnc0ZN4GnE
 JVHrbKyKYxHn0OSVnRfnRQv2qZXif8KbvAbYRAPlbFyHF8hYDa/djClSb+8OicfLkYn3
 MBtQYmm2jPzjgClR75Dex8xdO9CNw15e4OlNthySbmrMquOReRTknhXgmCy1DEUgUFX1
 mMu0WAkOkWGJgPX/NxiO8uq/t3AmqLqbCU7NIbWX8HYqRegoLrLY33FQo7Q/J3olbhFv
 ys5lLGoqJgsw9ATQIjEFLcHiBiVc16td5CE0u4bYnMdOAKC6y00vDpD/I5/lhtfATk3k
 uekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=feJakri/Re3eEduDFY3I/Vsgo1V41x3QsWDvhzyqzHQ=;
 fh=OexgDaH4dXmlx20J7KpPlEf/NnCTGQFZoceLi57UuSw=;
 b=C8w31tQeCo4ffYGlZG/jV4+E6xsLQxpFNqNJdlFKRGKhx+scIS3dZxmhirDDBLgT84
 6xEq/9KTiC/3Fh0ZNNb+xQnwvXFPpFYLgR0h/iS2DktFhhU9dbBho/8N4IdN8BatV67k
 Hz0t6ITqZkv59zUiNQpidOkeSaaz8GMB37n60i1jV+pNRmUA07wIohcqsRFR6LVFt+oX
 DktmXZmjCMHFq7XlTWwctn6o3kcXKygLLYEKKFSZ4WxRnwGH4lUVeoEDut09A7itQdho
 Ao8KAaNrrnKh1wECeceoZh2Ai0YWC04wvLDcY/fGv1H8JGxmc0ooeafeLLcrcTVezvXb
 Ew1w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251029; x=1785855829;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=feJakri/Re3eEduDFY3I/Vsgo1V41x3QsWDvhzyqzHQ=;
 b=hJxXLDr6VkjnW5rO7hV5fhBS1u0dYdvhxtmiV41T8DM9fL+czjYdFi1o4qwW0xkE25
 e4b+jDzVvA5nxAQO7pj6+xC3hLkbUt6kIVenqvQeCqHIFP+4Vs9NyG6cKJC8eDEAJ3pr
 pAO77UO3seWVJkUm6C9pmCbifm9cYuGafQvumG+5UGadDBuH8ZPjPq2MjeqY2tRo1TOr
 FgeEIsYHSvy4czmt/iplj/m0bJK+DZlFgyYdA5WBwK7KeZMJLWA93B43oEJ4SQeT0BV2
 gMLL6Lk4xewVNLFePshuAvApVIbFgLlFDJwcMXvK9hsHfwQF7QIbaE0FE5gp/5GtV2v1
 LUQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqy6ci5xWVbhIe7CXCnaxzochwx+q2ezf4BNKNiw8eAXrHRscIaXpCD8xpPZSS6EWtJ7aMEpeY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyOo+2Fl96zZL3Bmrr+e4afnugbUz5FitSREgMKZ3yCiPGxysjD
 3jmpbtXfPcBcO8372b30+Wj5YkqOb3JXcIa5NaeFCMqYuzy4yy8vm7jezk2RUWj3wwnYts+nm9J
 p3+1N2+/IuSWWq4jO9pWOjLO+QL8leYPtM0ejKFYE3A==
X-Gm-Gg: AR+sD12Ioibu5COHTfex1m0EDf7V9+zzplrDPWob1JvN1JJJSX698HhLXw+sYp1Oa89
 tDW5f9xOczl08Rq1t9A2NdT8RtV7SzKMEu56ELwuXfxaTfIUnlQHTIWJaCw9b9q5WPb8dWliJBd
 QCKl7d2SKiDUAc4nIG97kHs1qwCdoyTJ7+AGkmTVYFS/6IHKoBwlsdZsBViVh9djDZguXY8pCRM
 IOg/rrtiLuSpVtR1ZINa1dzXzcyjFJnkkQMolXUBdzOU12RuXv1FK9Q6TLbbxNIyZR2ZpwEeDYv
 ogtton/i+ZCljRLHleUVwhXGoOC0SvZuuK2MIUjkhBvvxYn70i0te9a+T9PzkWJ2dhrKDq9wkjC
 hfZFS9QXkC4YYCbHg
X-Received: by 2002:a17:907:1ca5:b0:c16:b05c:b9cf with SMTP id
 a640c23a62f3a-c1f7217375amr169950566b.26.1785251028906; Tue, 28 Jul 2026
 08:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com>
 <871pcwk88o.fsf@kernel.org>
 <CAEHHSvaU-jTdN5PJoTnyy4Qq7J34SLQMgtx0+uqTsbpn7vmyOw@mail.gmail.com>
 <87ldaw3918.fsf@kernel.org>
In-Reply-To: <87ldaw3918.fsf@kernel.org>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 17:03:42 +0200
X-Gm-Features: AUfX_myhz75Xsgv8sWPU1rnH1BjYiEdm0yxPjAv-yCmprSIzch_4eiJLInoCSnQ
Message-ID: <CAEHHSvauw8tFUnkakGvASsogs=HTCvc6nXp0Da2sF5BzfnB5Dw@mail.gmail.com>
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
 d=baylibre.com; s=google; t=1785251029; x=1785855829;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=feJakri/Re3eEduDFY3I/Vsgo1V41x3QsWDvhzyqzHQ=;
 b=HbY0Zml6JAgzzSf4IQZu/kGbcL1RheXODcPA0QdHT1GjVN8qs/rLMIce8sYjZxrp7g
 Ld7b98CfLNSInQzWFKO3agsZKteHXEHNMuFxoBv7fAyiDMOAYVWj25Hvt8+Ca0K5Ev+c
 HsJlKJ240jxaeFu1D1grINcmRMbter0IJRWgmA1Z7lui4NqWRzWg2p7SX4OmMCrpe1m9
 lNp0JMp06aGfczJX6c85/tses1uNUYNfkG6CAmzD9oto1DvJuku3HGNH5yNcJDwK8bOb
 7ZdwRQqILLtfQk0aqCUTTytYpon4qRsmSwiZZjnycYrzMl7I0LgSOdHZxPY2BzMA+y5E
 97Gg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HbY0Zml6
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

Le lun. 27 juil. 2026 =C3=A0 14:35, Mattijs Korpershoek
<mkorpershoek@kernel.org> a =C3=A9crit :
>
> Hi Julien,
>
> On Mon, Jul 27, 2026 at 11:28, Julien Stephan <jstephan@baylibre.com> wro=
te:
>
> > Hello Mattijs,
> >
> > (used the new u-boot ml address u-boot@lists.u-boot-project.org and
> > dropped the old denx one)
> >
> > Le mar. 21 juil. 2026 =C3=A0 11:22, Mattijs Korpershoek
> > <mkorpershoek@kernel.org> a =C3=A9crit :
> >>
> >> Hi Julien,
> >>
> >> Thank you for the patch.
> >>
> >> On Fri, Jul 17, 2026 at 10:26, Julien Stephan <jstephan@baylibre.com> =
wrote:
> >>
> >> > Add a new driver for the HDMI PHY. The driver supports MT8188 and MT=
8195
> >> > based SoCs. The driver is based on the corresponding kernel driver.
> >>
> >> What kernel version (exact commit, including the sha) has this been
> >> ported from ?
> >>
> >> Mentioning it in the commit message will help reviewers to compare thi=
s
> >> with the linux codebase.
> >>
> >> I can do a more detailed review once I know the linux base this has be=
en
> >> ported from.
> >>
> >
> > Technically it's not a direct port from the upstream kernel driver.
> > The code comes from an old downstream MediaTek code base.
> > I guess it was polished a bit during kernel upstream, hence some
> > variables names and functions are not 100% identical..
>
> Ah, that make sense.
>
> >
> > So what would you like me to do? Send a v2 with a proper backport from
> > kernel? Or being more explicit on the commit message is enough?
> > Something like: "The driver is loosely based on the corresponding
> > kernel driver at  45810d486bb4 phy: mediatek: add support for
> > phy-mtk-hdmi-mt8195)
>
> Ideally, we would do a backport from the Linux driver. That will make
> future maintenance easier since we can continue porting fixes (when
> relevant) from Linux when they arrive. That's probably a bit more work
> though :(
>
> If you want to keep this implementation, then I'd be more precise in the
> commit message. Stating that it's based on a vendor driver and has been
> polished up for U-Boot.
>
> So I have a preference for doing the port from Linux, but I won't block
> this if we just reword the commit message. Up to you to decide what
> you'd like to do.
>

Done :)

Cheers
Julien


> >
> >> >
> >> > Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
> >> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> >> > ---
> >>
> >> [...]
> >>
> >> > +
> >> > +     /* RG_HDMITXPLL_RESERVE[12:11] */
> >> > +     mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
> >> > +                       0x3 << RG_HDMITXPLL_RESERVE_BIT12_11_SHIFT,
> >> > +                       RG_HDMITXPLL_RESERVE_BIT12_11);
> >> > +
> >> > +     /* TCL_EN */
> >> > +     mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
> >> > +                       0x1 << RG_HDMITXPLL_TCL_EN_SHIFT,
> >> > +                       RG_HDMITXPLL_TCL_EN);
> >> > +
> >> > +     /* we should always read calibration impedance
> >> > +      * from efuse, unless for debugging purposes.
> >> > +      * This calibraion value is not board-dependent
> >>
> >> calibraion -> calibration
> >>
> >> > +      * so no SW adjustment required.
> >> > +      */
> >> > +     if (hdmi_phy->conf->efuse_sw_mode) {
> >> > +             debug("efuse_sw_mode ENABLED!!!");
> >> > +             mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_1,
> >> > +                               0x1f << RG_INTR_IMP_RG_MODE_SHIFT,
> >> > +                               RG_INTR_IMP_RG_MODE);
> >> > +     }
> >> > +
> >> > +     return 0;
> >> > +}
> >> > +
> >>
> >> [...]
