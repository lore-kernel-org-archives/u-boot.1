Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D607C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12E9E605B7;
	Tue,  4 Aug 2026 18:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQuHXHnOcG90; Tue,  4 Aug 2026 18:13:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61CDA60780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867205;
	bh=SRoOCcwMvwUpXsO0oTgZF4HG0kfP9WzhvRxzIRX8OB8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T0dpR+53Z6gE2bx1eAwhVgp+k/7NwzoJUuBXYuJ/1IjS2JkuJ/4L9IlX29L4K9DU5
	 /dCylmaq3CFAqr/zcYf8XRPWtsjawcyzNySC+wcQ/M+6svCzD7TmFqCg5IkfoU2eqE
	 qwmAJr8H3Y329iwc2R7GExlfYInHaS4SKXkUM6XZJYEbWO57f/ASfrs0SQ0tvMjh9U
	 mAQq0vsI0JdYDz4pioZDrXLfn6dng4d7jh+AYJFjggPNgYlRZJVZAkEOKm09c1iKVY
	 vZG+7UpSodqG7gj76kYtyEmWqlAJJx78P7/yQINCK3xKG/u0MZUSB8meScPgvfRmMz
	 g9wjvvO17o6ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61CDA60780;
	Tue,  4 Aug 2026 18:13:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D004350
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 431806065E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sCTjO9BYEfEH for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:16:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 86E8860627
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86E8860627
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86E8860627
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:16:46 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso3296335a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785853006; cv=none;
 d=google.com; s=arc-20260327;
 b=Hebziga3XAPAgOTyLvxUZchC21+j6tcHF8X3fo8h0DePt1Mb7+Dlfsv8t9Us8q5+g2
 Nmtq0k+L3mlJOieY1X2KN823maty0dJw/ePKP20ceBya92xketEeBAq8MiZ5cBRUD9kD
 6ZVR0nuqT4nPyp6LaSxTA5qdfFKY7UWYEUx1xAgvTMV3GFnB6E/QpoEscVRheBcmBlGd
 umFlGe7pQHFUD5yDRQZr6dv9nUu+0uExJqd7khRu5AG3ZurutJAaY3wLta1dHy8GJlfP
 ScPlV1L54ryQgaInh7dusA8gM2ycrIDbBFjR/csBYX9jJ9YUaS4q0ocddfqFGI31/Dnn
 5Wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SRoOCcwMvwUpXsO0oTgZF4HG0kfP9WzhvRxzIRX8OB8=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=o9xxytt7AMFYzxIOLC25kaQmn+JIfXxeYm7Ubum0xTS35YPPY9jHb6INXfpd1ixuU+
 8E4K2HGXtSN6CjGWx0JhKOZQsO2hQiPUGrhTnlwwgAhuenKkCvHnUGODgQO9VlYTeRn4
 vnPRLds7a8zdjAb1jcIT3m8s5lHYiELh70z6K6+kT5z1+O2znS8oMvyfxpkQ9DnmMgU9
 FK608Tzmes2t4vPS6Uxk3AMLx+iu15OgqfdrrlNjGQtYFPB345AxsarrITGef0F1o+hZ
 iH9rfY/DK5U03ryxRIv3iHGIBen9MOFJiD5cZQU3UEc5mEMomWS500OhXCa+hrF9mhAb
 O0kg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785853006; x=1786457806;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SRoOCcwMvwUpXsO0oTgZF4HG0kfP9WzhvRxzIRX8OB8=;
 b=qsO/6CZGDt82znFeRtyB/7QbMW4SlfJ/ucnJ4VJqGut8wbJgEIsV3u8kKEos36kSsl
 Yp0n+JICpxmIDg3ZugO6TnmdgyniYrVztdDfjGZsF76f+RUVusaSojuKq/ExuJLI2Zsx
 CZAPuMtpWRwpLFr7xOnV1J7xPtYoJSG0EwBPPWfTICml1wwQRloupOuhXoI9sLptx97Z
 BqiaX1P2I+5VAunHccqacaqQoPFJOL8cN5zfpQCTy6R0KtOnCfAYrQvqZJ59y/d6FW07
 wZS3zRxKd0vh0fYk81tyBWQjN3wOrJS1M8x4nDKpUBcOejeDZyU1m50NXQ4wxfikSvXE
 Mwsw==
X-Gm-Message-State: AOJu0YyEBLf/dWh5DD9K7VCHctnztJSEUG3pZaz7gojud09YULznr3LY
 xqmJzAF1mTcydH7tHpMo2p+QQ0XELetsSuJNAttiRyGMDGN05u3MEbQVYJFwE9hf3zJo2vSsWFg
 1XqQTHGDqUle+HeKSRJa147yuKnKNhAnnT5W5GRXMfA==
X-Gm-Gg: AR+sD10TO6SE91aBQk/qoME96Rjt9sW0+M8JwjyoD5ZDgLT4N3JEXIG4dYNpIC0QbhK
 5YDaApj0Xmvg+ix32pQ+hg8PUZsKhbXHgC6UMhVX11WBZmbxyH3/lWtecSO2DVWX9QG8DtUlqZ+
 G0Kiz4HNsRZJqHbGH5raEuYCs8endBp+rJrgfpA8Vk2GsiQ4a5tvUBPj9+kiX7A89rhqfDpTsaF
 hsduaLIxKrlS7QYlok3m08gpiGr0RKTtVHMR7fXARh6Fc+GSfbs+7kHSxnZ8yvA0oEeSeSY5Tnw
 nGW2Ttr4dBzD0PylKmTRF+qO/cwbKf77GOwmp6jqCdQwm9Xib4KYI3WC1D3WxQhfKeEtVmaqHgz
 k
X-Received: by 2002:a17:902:f60a:b0:2c8:2808:3ec4 with SMTP id
 d9443c01a7336-2d05246ee7cmr147427515ad.24.1785853005820; Tue, 04 Aug 2026
 07:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-7-acb97c172993@flipper.net>
 <CAFLszTgMXoB-X7i=s9uhX8nFkCvEeMvzDZ9vxPFEBAnquhVm4w@mail.gmail.com>
In-Reply-To: <CAFLszTgMXoB-X7i=s9uhX8nFkCvEeMvzDZ9vxPFEBAnquhVm4w@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:16:35 +0400
X-Gm-Features: AUfX_mwiz_iPub5WzsnPNJWGyDh-tJCGYaQI-OKaaPKUOgH0eRnqqBEmcg6kn1s
Message-ID: <CAKTNdwF6aHTbsi6WQdHajpKYEn5cznOWHCDrGmyW78gtAYNBcQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] binman: tests: Add test coverage for a FIT with
 embedded Linux+initrd and /chosen
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785853006; x=1786457806;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SRoOCcwMvwUpXsO0oTgZF4HG0kfP9WzhvRxzIRX8OB8=;
 b=jy4xXsviqJEPdLgoe4LzlcE/Pvcq03IVdgp7r3GN+lK+YXZfzH4ZG1H/LEhCTRxxMN
 8jrcDaKbgtK/+RM66gQnbsKtoO5S0RZSAJ/VQv80Xc5965sWU2WdvGkWQ5tJU7sD7fP9
 id0SDu8RZlOB2CqK0RLilqmQ5hHebo/Pgbxn7fur8SNJDaKawuhNml4ZK1iXh6jk2Mlr
 MKOUf16x/iVn3OffjBoyNLggmKf7DUtuyT1p5S/55DTzZHkiZAag4C+8vcS8rrFoJlxM
 pO0CDrSMSkaUqed5kvEsp0AbxDwL6O78jGf4Uq/YW2j17GNA1RRsgXcWZd17ca/IXh9p
 +Ohw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=jy4xXsvi
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

Hi Simon,

On Tue, Aug 4, 2026 at 5:03=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > binman: tests: Add test coverage for a FIT with embedded Linux+initrd a=
nd /chosen
> >
> > Add a test for a FIT image with a fake Linux kernel and initrd, and a
> > valid device tree into which a /chosen node is added (containing a
> > bootargs property, as is relevant for Falcon mode boot).
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > tools/binman/ftest.py                          | 107 ++++++++++++++++++=
+++++++
> >  tools/binman/test/fit/fit_chosen.dts           |  62 ++++++++++++++
> >  tools/binman/test/fit/fit_chosen_no_initrd.dts |  60 ++++++++++++++
> >  tools/binman/test/fit/fit_chosen_no_load.dts   |  57 +++++++++++++
> >  4 files changed, 286 insertions(+)
>
> > +    def testFitChosen(self):
> > +        """Test patching /chosen (bootargs + initrd) into generated FI=
T FDTs"""
>
> The alternate-DTs (model1/model2) have no /chosen node, so all three
> tests only exercise the add_subnode() branch in _patch_fdt_chosen().
> Please add a case where the input FDT already carries a /chosen (with
> e.g. a pre-existing bootargs) to cover the path_offset() branch and
> confirm the overwrite behaviour that the docs promise.

Indeed, that would be a good addition, thanks!

> > +    def testFitChosenNoInitrd(self):
> > +        """Test a Falcon-mode FIT where the optional initramfs is not =
supplied"""
>
> There is no coverage for a config that sets only fit,bootargs or only
> fit,initrd (both DTS files set both). Since _patch_fdt_chosen() has
> independent None-branches for each, a small case exercising each on
> its own would be worth adding.

Let me turn it into a full matrix - it can't hurt. Thanks for the suggestio=
n!

Best regards,
Alexey
