Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD5C531D0
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 01:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB0F681154;
	Tue, 28 Jul 2026 01:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6xUPutPVu-Og; Tue, 28 Jul 2026 01:05:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC24E810DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785200710;
	bh=9sP8jWX5OyO1RowcUh73JNCGzUqBxfFsxaX7eyi+0wg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KphANvElLWoXhdblxQWJLp0I/xtihdN8I82vmnuUsfqjinMK61cOAqDriJ70FoPUi
	 7iIUBJN0AgmZHffI5pzaK2MxH7Sl1eh0N2KuW34iQnRGrI34GFG3R/AMZxEAu8uPwu
	 AjV7xUT6QyBKUDqeuKgsKbmj4cb9FLGAIE0yqnfUjvuTzaM2SkIU0TuOmRTh61sZ9v
	 1/hWbdEfy082Iz2eDm1Xu26CQ453f6RNbA5Qa/XU/wOES+8yrDCL9x/l6cGSCw6+kU
	 /OY9b8ocDtqFdmKCF67coJqy0UEHj3JU+9SFZTMf17upeRveRw2F4KCNfYSabaL4+p
	 blQK9t3fstakw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC24E810DD;
	Tue, 28 Jul 2026 01:05:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1209D350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 01:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0401C81080
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 01:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0C3B_4iuqSwX for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 01:05:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EDE6080F40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDE6080F40
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDE6080F40
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 01:05:07 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5b01910b499so425596e87.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 18:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785200705; cv=none;
 d=google.com; s=arc-20260327;
 b=WZiwAjZ2MEZk4BTUWwZ2Int9ZjR5qShR0qPQpkqY5/CuiwDjrm/wdlxP0NY+0i0phr
 TsRTmdQHhE3l2fWi8NAnIvcwaDSycP6mmql4Ay3kxBPHpTgO8BaSaa45IDVgTmuT+WYV
 +Hwa5ELdhBtBLm4oreuXKX98D3PBMwJFkc0/yBPXX28zmuCOq4ge320XtF3hjcUDNQa6
 N06be0V+ulEMctZzt98Mb9OBj03be+QgiYwaOEPsUxEBJWr8Yco7Adc1oQ+6QXKX+47l
 R29npRM6WrOxlGZjDPwhckWDt2HsPfd4aoNtYKywhMXgh1UFpJBQBJt5gHKQ7UH2vWMH
 svJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9sP8jWX5OyO1RowcUh73JNCGzUqBxfFsxaX7eyi+0wg=;
 fh=S/W06SmXbCNr0MOeON+oSBeT5YGrrRcVY6MHw4iCNiw=;
 b=iiS9jdeHxUr5TOVErUyFKUWScY4aTqyrKfy0mBmtZOCjpwscId1xzkryjE7O9oGlCT
 mU8hE0DoOOCfDhEWGKil4+lMpq6mC/UbEgME0pX5EdfpeEcYfVftOboWutyDJmoUYbgu
 xDdEANj/KJgjk1qIgpn7AZOJtKViXq/3VGOF21L9YmudZl/hkD1cHwtd1T3ATg4O5Vq1
 di6t4bQaO3TspV0gTXpjIYiegZhF82yNNV5dOPZ9fCVajpXMlARp+H3hcqYpngRp6uBt
 P9LSlW3xrw1yCzttzlsoCANlS4D+c74x9fLgey6uhhp5XTPmqxMW2JBeDUYjMt/yPgEo
 W4lg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785200705; x=1785805505;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9sP8jWX5OyO1RowcUh73JNCGzUqBxfFsxaX7eyi+0wg=;
 b=hBMENVs7Et9zB7WxoK0tV/RXSa0OtEzm4nDtOC9eLNkYOd6auSrYF55HiEvNpvTqnm
 LXRgUwiBVqTS6V30i261PYvafzcXjwCGasSBEA4j+2OMJ+xgUWylbtqcFZs2MCjFSj4H
 AZO3m4ZcTNPYl1spoLQsuyg6uTZjC81cylcP0MYfGNoc/1SU0BA3BMS5CHsuVhN90dLK
 xk2iSF9vpnJbaufftkQ6L6jMnEH8MFhJNLj9XmDqedTrJr1DEzzQ6nn3l58VHtPD5jog
 hJ33cOCXX/HQZlwFftY/BHYGa/PpSYz4GZA0exQXhEsI6GVvqk9KypgZShR+nb1kFBUa
 facA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdDVXO07WIG2vL9i/oxqHSCmNVK23jjvR2A2lUeZoqNiuKDPigbRggsaOyXWXFzPJL9Kg6efU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw1oYDdLkVQfvYSjvcaFKpdqrnmDMsOrf/4CU0aDu4MHZvGDZ0G
 tATWxcFQaN2K+osqSgHGhUcQ+kljJwIUGa905YNO5Lyy/e2vKtjk/lvAgPr7tNSL4TU2+ZqtOdp
 /6jae8GLueL9+wr9nl02z90kmMMxHGCzPafeofyQLow==
X-Gm-Gg: AR+sD13i9aL7RhN0OIdvhy5mQsslFljPzFAufdAIfEwXUIQXUtvT65Orf/EavY39KwG
 XbFkaf1VLuJLroYLeNQ8TQUMa0HX6zv/MIPAmxQHTDcW8hxaRwrEdc/9/I7GMuHUk/qiwFFrdZ0
 EUMOQ5AbkjGKH/cyfiYYWpwlUDgWdPsMxT4O6zoWiZODsgHJPTrFzXvlZWEkx45jR45iiVPghbO
 ZNDEMwKsWssZw8SYRnaMK40jozt3sXDHlX3fCHjPF/erojDeXnR2SehkRzil7wchW67o52I2Oml
 2qvrNgQ9+lShDJc8+3pNXLJsJAgJSgmIhQol94hNQNSyBh4xJTqEOaXxc1nsaZqPSSLS6aRG90i
 085Rfpsf9x2m4XRi0Px4=
X-Received: by 2002:a05:6512:461a:b0:5ae:9be8:1ad7 with SMTP id
 2adb3069b0e04-5b2d0245098mr32477e87.18.1785200705448; Mon, 27 Jul 2026
 18:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-6-2f58566d48ca@riscstar.com> <amdGSBKT4iRzuh1P@pie>
 <CAH22mJz64S5_em=D0zvt1uUaGpymAb1Ss5uiB5OkutpRcU=6Og@mail.gmail.com>
 <ameQUN3zlD0Ei8Jm@pie>
In-Reply-To: <ameQUN3zlD0Ei8Jm@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 28 Jul 2026 09:04:52 +0800
X-Gm-Features: AUfX_mz34AVYDa3g4aNBBYEGzm3S1dlmsHmriEUL_CXx3lqg6LxgwgaX1FVXKI8
Message-ID: <CAH22mJyMqTgRLqyfVZGgSHHNK7XnBTnrkY-R1ix5DN+oiBDEbg@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] dts: k1: add SD card support in u-boot overlay
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785200705; x=1785805505;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9sP8jWX5OyO1RowcUh73JNCGzUqBxfFsxaX7eyi+0wg=;
 b=sT/z/SejvPjXrK/VuZmplKLMZPXwssSoR+TGgvxuLA9/uJtAFOaEDtqRv6t1KHzyh3
 KOrTmR/jIikKixRgirDwX2jAKCvhpRWCPBbsoM7P0mxaU6tttobWxbnx88F1s5uPd8V0
 N3IL7CxoVanB3y9IXttbb/yGCr3m3e++rzpFbD8KjJqJXjHT1DWNcxjRCnARpArE/wsQ
 7HmSsa1Px90EoheWCJ1ycNa4g9fWN6gxQbVrfV03shc6fWBnT95oSsNFOS29tj6R92tB
 jnBCz9Lh0DVFv+AcVp4kDapjIn73D8t3+KD4mmhWEyCe7S0LaPXOrLriGUI3AWDmOAuR
 RT+Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=sT/z/Sej
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

On Tue, Jul 28, 2026 at 1:08=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Mon, Jul 27, 2026 at 09:08:52PM +0800, Eric Chung wrote:
> > Hi Yao,
> >
> > I'm not familiar with the policy for syncing DTS files from the Linux u=
pstream.
> > Could you clarify how this script works?
> >
> > Does it sync all DTS files from Linux upstream at once, or is it
> > possible to sync
> > only the Spacemit DTS file?
>
> update-subtree.sh cherry-picks a commit from the upstream, or
> merge an upstream tag into the subtree. Cherry-picking SD-related
> commits from Linux upstream suits for your case.
>
> > If I choose to sync only the Spacemit DTS file and include it in my pat=
ch set,
> > would that cause conflicts later when others try to sync all DTS files?
>
> Tom synchronizes the dts subtree with Linux upstream irregularly, there
> should be no conflict or relatively small ones if you cherry-pick the
> changes, while adding downstream nodes in *-u-boot.dtsi might suffer
> from duplication, too, during synchronization.
>

The process is a bit complex. Since my main issue is that the DTS
files are out of
date, would it be simpler if I just copy the relevant Spacemit DTS
files directly
from the Linux upstream into the dts/upstream folder?

> > Best Regards
> > Eric
>
> By the way, please avoid top-posting if possible.
>
> Thanks,
> Yao Zi
>
> > On Mon, Jul 27, 2026 at 7:52=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
> > >
> > > On Mon, Jul 27, 2026 at 02:59:08PM +0800, Eric Chung wrote:
> > > > Add the SDH0 controller node and its pinctrl groups to the u-boot
> > > > overlay. The upstream DTS only contains the eMMC node; the SD card
> > > > controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
> > > > missing. Place the new node inside the storage-bus via path-based
> > > > merge so it inherits the dma-ranges from the parent bus.
> > > >
> > > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > >
> > > Please cherry-pick upstream devicetree changes from Linux upstream wi=
th
> > > tools/update-subtree.sh instead of adding our own copies. Changes for
> > > k1-bananapi-f3 and k1-muse-pi-pro have both landed in Linux v7.2.
> > >
> > > Best regards,
> > > Yao Zi
> > >
> > > > ---
> > > > v5:
> > > > - Append power source field on eMMC/SD pinctrl.
> > > > v3:
> > > > - Fix SD pinctrl as uhs.
> > > > v2:
> > > > - Use vmmc-supply as vqmmc-supply on SD node.
> > > > - Add alias of mmc0 and mmc1.
> > > > ---
> > > >  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 91 +++++++++++++++++++=
+++++++++++-
> > > >  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 86 +++++++++++++++++++=
+++++++++-
> > > >  2 files changed, 173 insertions(+), 4 deletions(-)
