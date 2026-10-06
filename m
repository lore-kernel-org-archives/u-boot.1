Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB706CA5FFE
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74D9180DDB;
	Tue,  6 Oct 2026 14:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwepuKPtQ7SC; Tue,  6 Oct 2026 14:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A89FF80D98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297209;
	b=LWRMclxXTQh7Nn7uWJ72f+rkDqb4kTViDlpT+8zxRCFXSyABEHaFrkk36wl0/lxOCL2Z
	 uclYHGeJYl7m3r+CN/HiUBEGxQX26Jj9euoWGZho4aoHUQ+CP0AZA+4473VM6zNIHE6eY
	 1O1wL+ZCnzZCBLEKz0ZBHyUO9mfoLRAIKC3bMKF2NUZB8JWxNuIGlithPaih/riTr2cd0
	 +SUonGCOdLQ+zDaK6678ZYn9DA3aa4g2FdtzIKWT0zAVbPMj48PLC2xvRceedEkst3ZRq
	 9exfYPFeFrEPJ0eecc35sEb7eKozfkhFUGWJnjOP8L489RY4o01Xa1wKTTHdelnovMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7xZ1b3GtlBmMMao8VKNrb1FkwtHIY4CKje/CUSGlKx8=;
	b=CtGZk7AnCdSLoXwrx/swgKXzPRFk4R5HgICpjXnup1jQSvAphCAkKkP3m8IIQwic7p8W
	 BTxGTgbvW5jteT7tD9sCKc4VoOy5CRiyfrtQGcdVsZivKn++MTzV83XxRhMeKyPaQQb15
	 cJstv7nWC2zHbeN9ey/4kruB4leJLvQregKI0L2rfW+rgVlvSGkUNg8YzXh/mQRInf+CG
	 ZIGMId0TalSM8K0MjSfz8j+q7Z501ViT3a/MDqXlsotN8uPIJuJSU6jO2m+y+vh3CUeHU
	 Du8DDRzCP8w9uJRBgW02Lq7ZrkbQtQ5YE+KtKcN27mLRpeh3pnliPjHOAkXS0IsDZbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=hD5OJpHy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791297209;
	bh=7xZ1b3GtlBmMMao8VKNrb1FkwtHIY4CKje/CUSGlKx8=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BYwev+D4K8jJupRco07z45JVeidp6FQGNq0pL+owWy1ZBbXsV/oLDDVq/QdPkiuMO
	 dco5t3QzWqIVr1TsmNeWfQF9hRV+D9S3qKSAoUm6Vw2+MBwKOoocJHRGQU0W+cXeBv
	 RnGJZxII76bikUlPerxUZNQIct41+0fdM/6MQC7mhvj1fuRLfoNN/Ga1Yba+cOfZNe
	 C3ZHO9LdToKAV2UBHR9nrDkr3Wn/hBgfvgsvrFtw1nBJDKE2nYg0pCpF/EIXBiWd6v
	 V+qan4LjbA50TpKHzalyKBIcPFoqxiyQeLLbslyqM0sbdEbTf44LTUVuE1r12Ng5bH
	 qatEuIRl0p1Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A89FF80D98;
	Tue,  6 Oct 2026 14:33:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F971341
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3139E80D45
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vl4tR0LPNOVM for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 13:39:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E2C48097A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791293971;
 b=DmaZEQVl7cGfc1doMdgG7K+wHJPec7bL8ZMeZkTXo9RA5SVodDOKV0Nh5iqBpx7Xh2ie
 Zw3G/TDAWKjt3OuhFnagDQsmupbyCVY8qFR466/92dp/3/2M+d5Mw17YnViiNsrnLBgDy
 ETSBYovI+hKwGd9FR1wSOGidV2QOtAOsyfMXuo1ac6WiY1I9G1t2HAqs5c4dlFOQ3hASs
 QXxNKdIehRtUzM5pt9Gr3EpsFvep2vcYWqeLUKkAPpsOW/1cobAiSCVWIkjsu7wrtZwDy
 TEOQrKJvpQs2D6sxQeG+08DaIzxI6iZh7fS5fLQO2Q5S/G61WCDFDtYLpnDjeCU5Wgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791293971;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=7xZ1b3GtlBmMMao8VKNrb1FkwtHIY4CKje/CUSGlKx8=;
 b=DEPIGLmbFVkqmgePc7KhC0efZWvABZuoSgNORW6GXoaThIMHbWd7u43X1lOTAiTZ/QPU
 P/WnwZ3MrzBPtDr8B21YqpQ3NHh5pmsAMFddrwv9KC1ygoNITT0epZz1g6oMSFi6EvT1m
 X5a6qQOy3ZEgZDfQql5hp5Q5t5oEOVYcRlDT3G1Ny6KW3ki0rDyk7fPX4K/bsS16lJ+KU
 JrwSJw/r/HZ7eOjMp0N0uyKw+u1O63h/yZp6AezEMxp7vUP9+H6kjhVA6BCuLvNYwth+G
 KXfH4tzcmVJU/IvgziwPRL4txriclTnd0mbyzBdnVH4qwtLogx2+iZhfromUwMRz6tA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=hD5OJpHy; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=petr.hodina@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=hD5OJpHy
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E2C48097A
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791293962; x=1791553162;
 bh=7xZ1b3GtlBmMMao8VKNrb1FkwtHIY4CKje/CUSGlKx8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=hD5OJpHy4U45RgAqlEVBNQ+ToNhDsX2lzGePWNuAqUm4nqgmNvBDxIXlP1RmvL6/R
 i/EINbXGOCi/Xt8mm1QFQ4q2AtyLNncoUx/99zwZbSJkVwwAZQ0a8Vy7uEpP+LC+vQ
 N9eym1zyJez9oOve1bUAo8B7paGjnsj0dE/k2Afz18HNLx8iauKYXuxknerMUsBQAR
 j2TB6XwupWSKqsjPzzHuja0mvAsMp+vae8Qh5jrAnyOJ0GdPzgWNrKy6aJHG0jxYo9
 pAJoGiM7LxozxDtgTVeIeAZboxQYM6xcP7y+J3yGGAc77OlNOIUwHYUQ4Gxq7Q3ei3
 wXed/OZVkXXlQ==
Date: Tue, 06 Oct 2026 13:39:10 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>
From: phodina <petr.hodina@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Heidelberg <david@ixit.cz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Stephan <jstephan@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>,
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Petr Pavlata <petr@acrux.cz>
Subject: Re: [PATCH u-boot 2/8] ufs: add device-quirk infrastructure
Message-ID: <U9Q7Ye1V_OLrvVKFMc3mqs2LekpZi4xshvBPKDlJ7I1X4l-WwcQhktz04GolUQPJY6UiwawEgHfk8QuonMIdw3dUv6PzE1gNBf5CSybC-BQ=@protonmail.com>
In-Reply-To: <189b5ad0-6ccb-42b9-a053-244590416407@linaro.org>
References: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
 <20261004-b4-ufs-sony-v1-2-54e71c95ba62@protonmail.com>
 <44f92663-e15c-422e-ab48-eec68904ad49@linaro.org>
 <7rKXOZ-hfdoWG6W8EV0KZMZEQoLnN88eTHGkjZyZp6NZVxWMVMNEzgxIpFVVt3Bhz3udjTeXmGWrrxbUqMlBjUdqrErfKptrs3PmeWl7RAA=@protonmail.com>
 <189b5ad0-6ccb-42b9-a053-244590416407@linaro.org>
Feedback-ID: 23468634:user:proton
X-Pm-Message-ID: 1791a8d12098993e267620c8d48098a29ec296d7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 06 Oct 2026 14:31:44 +0000
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

On Tuesday, October 6th, 2026 at 3:31 PM, Neil Armstrong <neil.armstrong@li=
naro.org> wrote:

> On 10/6/26 15:23, phodina wrote:
> >
> > On Monday, October 5th, 2026 at 11:40 AM, Neil Armstrong <neil.armstron=
g@linaro.org> wrote:
> >
> >> Hi,
> >>
> >> On 10/4/26 21:22, Petr Hodina via B4 Relay wrote:
> >>> From: Petr Hodina <petr.hodina@protonmail.com>
> >>>
> >>> Infrastructure (ufs_quirks.h):
> >>>    - struct ufs_dev_quirk plus UFS_FIX()/UFS_FIX_REVISION() helpers.
> >>>    - ufshcd_fixup_dev_quirks() applies the table (and sets NO_PURGE f=
or
> >>>      devices older than UFS_PURGE_SPEC_VER) from ufs_start(), before =
power
> >>>      mode negotiation so link quirks take effect.
> >>>    - hba gains a dev_quirks field, distinct from the host controller
> >>>      quirks (hba->quirks).
> >>
> >> In patch 7 you set the quirk for the Sony Yoshino/Tama platforms, but
> >> I'm not sure we need to add the quirk for those UFSs on other platform=
s.
> >>
> >> Is this really needed for all platforms ?
> >
> >
> > This is more defensive approach to enable it for more platforms.
> >
> > The reason is the device is a production unit with secure boot enabled.
> > Therefore I'm unable to provision again the device non-volatile storage=
.
> >
> > Also there are no EDL loaders available unlike on some other platforms
> > so restoring the device is currently impossible.
> >
> > Even with the loader just physically desoldering the UFS BGA chip, then
> > replacing it with a new programmed one with the dumped data and solderi=
ng
> > it to the board it would probably not be possible to boot as the RPMB b=
lock
> > would be missing the Authentication key only the manufacturer posses.
> >
> > I'd assume this issue might be already fixed on newer platforms.
> > Would be great to compile a list of the platforms that definitely
> > need this fix.
>=20
> I'm aware of this issue, and I have a Sony sdm845 I'll love to reflash.
>=20
> So I understand the defensive approach, but I was wondering if this same
> change was sent to Linux ? I can't find one.
>=20
> Neil
>=20

Okay now I get the question. Not yet. Still have some u-boot patches I want=
 to upstream mainly the graphical menu and SPL version of u-boot for Qcom d=
evice to have one binary with runtime detection based on the SMEM.

Once that's done more than happy to push the kernel UFS patches for the ker=
nel :)

Petr
