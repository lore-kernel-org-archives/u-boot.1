Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527EEC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14E966070A;
	Tue, 25 Aug 2026 16:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5lN6ksvvdrR; Tue, 25 Aug 2026 16:03:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673819;
	bh=M0iDncQNXsfnBMlwP36HRTNcxHB7ijq8ZtgtcGgFKNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nC826lSa/YYlnSREQvdhrVvBnINia9Le0DgP+1YXhRgEudpEB3u2At5PdIBUKkdMC
	 srFS1ir+v+yF7BE3JKIn5k5ifuLcNu54naFuaVr1BOGDfodK2Rv2tssc8hvefy99rx
	 N3hjJmrroHa00Z9m16hbk2V6bp/O0CeIRQEwtldoSl2iCVakE0YArrvjjNL7RBf0Nq
	 aHvg/RIb6dSB3SN1tKGfpzgSKgVdDhs1a3yWUSG5Ml/leRyaSPo5rAS4b0A+CaXOPv
	 2Z9aUFXx2ZWD6LhN4o+5xZizyMrng3stlU2N8LCAtD9XcRBGWmXGwfN6ZCI9C92wVr
	 KXAN/X05TsNfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA18960712;
	Tue, 25 Aug 2026 16:03:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 421FE2FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AF9D80BE0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NXyks9M5PHpv for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 13:41:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mNrKuDgT
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1982880BDF
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:41:09 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-44cb057311bso4498623fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665268; cv=none;
 d=google.com; s=arc-20260327;
 b=EC+Juf01NjCrkYk1prLh8Jr+YQpWKq2s9a97E3zBr8C2YpjpaxATbYk8b3HAZC6iLi
 BNFj47K3VKQuhanbQ04acJoTW/jAju0se0+Cypxopac1ZfUwkbrrn/wwNDJ20z61uWXU
 qbh2vKslIA8uMpJf4SBW6RnBdkYvZx5BTzP5lbjeeTUlY1xM8hTU+Gq/9JeU3cuPCkJP
 S/F0k62yE9+3wgybBM8uhKRR/byVmSQyQDm6Ge0iUBz9wesNZAhqpRrTPlYjWIok3Tn2
 owdffbsK9qnDhcwZiPr2b3gd4gfL85W3RYgz8SvMSgvLc/ISWm8rDaGKwar771z+VfE7
 WSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M0iDncQNXsfnBMlwP36HRTNcxHB7ijq8ZtgtcGgFKNU=;
 fh=oQHssyx3ARNn83sUBNHUUEABvHBUveThvj5df995ZR8=;
 b=UiS7d5z13AL4/L784lh9H2tzaBsP5kOy49zhDHrHUqXcsZUPJMA7X0HXfnqaRWSAht
 7BeAViUA0MnDOgJP25IxkKIlVWyPohrs58ftn+xH0fTZzUU1ExHwqx0kmagsYnDuYmAy
 HVpA5jpBzTLIo5Oq+3YUNu3CsiM1RE7ic1jM3QBC5ESJpKYG7USJGKDTbxoapmjXKRxy
 uBHpnQJOdthMdEmEqkXZ4wr3UKq4dxD007lyejDPFvgJhgZF//L31GZbWNM6r/t9RK7t
 4i/oPgCI8/Ji4MGGD01Bo6RoT8N5ec/DpYm8EFOEcOKQ5jo4KYbY3SYcN0aTYWQ9FAt3
 0cow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787665268; x=1788270068;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M0iDncQNXsfnBMlwP36HRTNcxHB7ijq8ZtgtcGgFKNU=;
 b=mNrKuDgTaoHvdNNmwvxuJsKlrgs1QivAuI/UEDiApChQt/1OAbDgfqSi3CHLWhYm2R
 oWAjRbcgjJWOft1by5t9nu6cti5VXqz96txyLnuN+GVtdtJ/GoKKsFlGvhh3p7SfnuJO
 8nDMPAgiyLlLNcYki2z6gYUa3r1eT0kMVAkfTssbiwI+ts8KpD882hTQxY5TbSZvyRS5
 RWaV3MKK0fHPj0w+AlM1JiYXvnOcDf1vUeX0greMObkdLOeLvNxNvmcF0/4zll6l2NNk
 LmFmPjVJ6ThTjclTMcIlMVpxKX1+ZeNaO+t7EI/ih7kFHF6ojK7EIiTnVVc7HakCedzV
 gaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787665268; x=1788270068;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M0iDncQNXsfnBMlwP36HRTNcxHB7ijq8ZtgtcGgFKNU=;
 b=BXrpcYkKPREXKSm6UPhhb6BZYJZs1VMQjB8DbuSjIAZDMcfGO+/2KvgseLF+t/c03P
 9ztIzynlMXxXabPdKJm6z4XKo5zYJOnRsGsQ/A6oTtu+HR+N3QNRpcgsrxA5gQLupf7o
 avFSgq1dCMxgXGaQnCbApoXFss93hyOh5yFjti1wB9YiYOBwxfkqucnZAn0XtskMtlZo
 b0p+Rq/L5WRab88dmMPTWj52ZP7bUwYH8eQMMCo25Y/+fHPWzM50lf57YLBoQbecKFzr
 yuRzW2kp2e2/72wrksOvUuATZS3UXtFsylyQV9GzkoQJmk0YCJhNaOBWtmPxX3zDKwds
 bg4g==
X-Gm-Message-State: AFuF++mLmwuu33rZw0Da5V6eh813rXL6BewugJnUtMuZTyCChU6MX0Bg
 UO21oqGaCuCi7f+V19sNmUcaGE9N1wNItdy4wC1KvboN8Qh5Hat5/6yHY82eLebEF7/NCasOACG
 wnI+AeHLr5rbHbvJmF5Lf8oz0iuH6/C0=
X-Gm-Gg: AR+sD135UWAwemlAtKZuFYYzbxjHNC1zP1JIjR5S4mXZuNu8MldJ/aQPV6Y5nlHeTMs
 waaNI6Dt61/9qaRO8K5mLnGpb6YgujjBF204iTdjMWrZJ//n8+f4r/n+rZLmDyMlwaO1TSHEIKU
 2uA78NFPKqxvuNLspA7ONpOovmuh3iWyN8HoZ8OCCiYywRXQBkWdScfArEYBopqzqu8o6wIK2tS
 +5tv8zqUdWqkygZZabjRXT9KMcd2BmOlIrjTVCwmZOC4SC7usyseQ2I53/hd61Jh3r48f3OfILN
 Giy1A846ICR/ZMfC0k+YiMhUTOx2ume0XXci7LNbSpEZvx6stLE3hu2yvJ6EeFqSuVt/LHrZY5A
 pEA==
X-Received: by 2002:a05:6820:1891:b0:6b1:63d8:261d with SMTP id
 006d021491bc7-6b163d8278cmr29050456eaf.17.1787665268359; Tue, 25 Aug 2026
 06:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
In-Reply-To: <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 25 Aug 2026 16:40:56 +0300
X-Gm-Features: AcwNN1UdfeduB0orbaE0RBZahpO5HjMzpaNM-zPZDPVYe4CiSL7Bfv5OQnbb6Xo
Message-ID: <CAPVz0n1Bxi-zp0X9Jh3D02B2LtQnBV0OHLXWw0fyG4eO+hVegg@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, 
 Tom Rini <trini@konsulko.com>, Aaron Williams <awilliams@marvell.com>, 
 Adam Ford <aford173@gmail.com>, Alban Bedel <alban.bedel@avionic-design.de>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Allen Martin <amartin@nvidia.com>, 
 Andre Przywara <andre.przywara@arm.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, 
 Bryan Brattlof <bb@ti.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>, 
 Chin-Liang See <chin.liang.see@intel.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 David Lechner <dlechner@baylibre.com>, 
 Dinh Nguyen <dinh.nguyen@intel.com>, Dominik Haller <d.haller@phytec.de>, 
 Dzmitry Sankouski <dsankouski@gmail.com>,
 =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, 
 Eugen Hristev <ehristev@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Gilles Talis <gilles.talis@gmail.com>,
 Green Wan <green.wan@sifive.com>, Hans de Goede <hdegoede@redhat.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Le Jin <le.jin@siemens.com>, 
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Mathew McBride <matt@traverse.com.au>, 
 Matthias Winker <matthias.winker@de.bosch.com>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Oliver Graute <oliver.graute@kococonnector.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Geis <pgwipeout@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 "maintainer:TK1-SOM BOARD" <Peter.Chubb@data61.csiro.au>,
 Philip Oberfichtner <pro@denx.de>, 
 Pramod Kumar <pramod.kumar_1@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, 
 Quentin Schulz <u-boot@0leil.net>, Randolph <randolph@andestech.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Sam Day <me@samcday.com>, 
 Sam Shih <sam.shih@mediatek.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>, 
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Simon Guinot <simon.guinot@sequanux.org>, Sinan Akman <sinan@writeme.com>, 
 Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>, 
 Stelian Pop <stelian@popies.net>, Stephan Gerhold <stephan@gerhold.net>, 
 Sumit Garg <sumit.garg@kernel.org>, Teresa Remmet <t.remmet@phytec.de>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Warren <twarren@nvidia.com>, Tony Dinh <mibodhi@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Wasim Khan <wasim.khan@nxp.com>, Weijie Gao <weijie.gao@mediatek.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
 "open list:P212" <u-boot-amlogic@groups.io>, 
 "open list:ARM SNAPDRAGON" <u-boot-qcom@groups.io>, 
 "open list:phyCORE-AM62ax" <upstream@lists.phytec.de>,
 =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Aug 2026 16:03:37 +0000
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

=D0=BF=D0=BD, 24 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 10:1=
9 Michal Simek <michal.simek@amd.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> A number of file (F:) entries across the MAINTAINERS files pointed to
> files or directories which had been renamed or removed over time. Drop
> these stale references so that every F: entry resolves to an existing
> path.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
>  board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
>  board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
>  board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
>  board/Marvell/octeontx/MAINTAINERS                |  2 --
>  board/Marvell/octeontx2/MAINTAINERS               |  2 --
>  board/Synology/ds116/MAINTAINERS                  |  1 -
>  board/acer/picasso/MAINTAINERS                    |  1 -
>  board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
>  board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
>  board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
>  board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
>  board/altera/stratix10-socdk/MAINTAINERS          |  1 -
>  board/amlogic/p212/MAINTAINERS                    |  1 -
>  board/amlogic/q200/MAINTAINERS                    |  1 -
>  board/amlogic/s400/MAINTAINERS                    |  1 -
>  board/andestech/voyager/MAINTAINERS               |  1 -
>  board/asus/grouper/MAINTAINERS                    |  1 -
>  board/asus/transformer-t114/MAINTAINERS           |  1 -
>  board/asus/transformer-t20/MAINTAINERS            |  1 -
>  board/asus/transformer-t30/MAINTAINERS            |  1 -
>  board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
>  board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
>  board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
>  board/avionic-design/plutux/MAINTAINERS           |  1 -
>  board/avionic-design/tec-ng/MAINTAINERS           |  1 -
>  board/avionic-design/tec/MAINTAINERS              |  1 -
>  board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
>  board/bosch/acc/MAINTAINERS                       |  1 -
>  board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
>  board/compal/paz00/MAINTAINERS                    |  1 -
>  board/compulab/trimslice/MAINTAINERS              |  1 -
>  board/comtrend/vr3032u/MAINTAINERS                |  1 -
>  board/comtrend/wap5813n/MAINTAINERS               |  1 -
>  board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
>  board/davinci/da8xxevm/MAINTAINERS                |  1 -
>  board/embest/mx6boards/MAINTAINERS                |  1 -
>  board/engicam/imx6ul/MAINTAINERS                  |  3 ---
>  board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
>  board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
>  board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
>  board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
>  board/ge/bx50v3/MAINTAINERS                       |  3 ---
>  board/htc/endeavoru/MAINTAINERS                   |  1 -
>  board/imgtec/xilfpga/MAINTAINERS                  |  1 -
>  board/intel/agilex-socdk/MAINTAINERS              |  1 -
>  board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
>  board/intel/n5x-socdk/MAINTAINERS                 |  1 -
>  board/keymile/km83xx/MAINTAINERS                  |  2 --
>  board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
>  board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
>  board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
>  board/lg/x3-t30/MAINTAINERS                       |  1 -
>  board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
>  board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
>  board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
>  board/mediatek/mt7981/MAINTAINERS                 |  2 --
>  board/mediatek/mt7986/MAINTAINERS                 |  4 ----
>  board/microsoft/surface-rt/MAINTAINERS            |  1 -
>  board/myir/mys_6ulx/MAINTAINERS                   |  1 -
>  board/nvidia/beaver/MAINTAINERS                   |  1 -
>  board/nvidia/cardhu/MAINTAINERS                   |  1 -
>  board/nvidia/dalmore/MAINTAINERS                  |  1 -
>  board/nvidia/harmony/MAINTAINERS                  |  1 -
>  board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
>  board/nvidia/nyan-big/MAINTAINERS                 |  1 -
>  board/nvidia/p2371-0000/MAINTAINERS               |  1 -
>  board/nvidia/p2371-2180/MAINTAINERS               |  1 -
>  board/nvidia/p2571/MAINTAINERS                    |  1 -
>  board/nvidia/p2771-0000/MAINTAINERS               |  1 -
>  board/nvidia/p3450-0000/MAINTAINERS               |  1 -
>  board/nvidia/seaboard/MAINTAINERS                 |  1 -
>  board/nvidia/tegratab/MAINTAINERS                 |  1 -
>  board/nvidia/venice2/MAINTAINERS                  |  1 -
>  board/nvidia/ventana/MAINTAINERS                  |  1 -
>  board/nxp/imx93_evk/MAINTAINERS                   |  1 -
>  board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
>  board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
>  board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
>  board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
>  board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
>  board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
>  board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
>  board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
>  board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
>  board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
>  board/nxp/lx2160a/MAINTAINERS                     |  2 --
>  board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
>  board/nxp/mx6slevk/MAINTAINERS                    |  2 --
>  board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
>  board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
>  board/nxp/t208xqds/MAINTAINERS                    |  5 -----
>  board/nxp/t208xrdb/MAINTAINERS                    |  1 -
>  board/ouya/ouya/MAINTAINERS                       |  1 -
>  board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
>  board/phytec/phycore_am68x/MAINTAINERS            |  1 -
>  board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
>  board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
>  board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
>  board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
>  board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
>  board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
>  board/renesas/blanche/MAINTAINERS                 |  1 -
>  board/renesas/eagle/MAINTAINERS                   |  1 -
>  board/renesas/grpeach/MAINTAINERS                 |  1 -
>  board/renesas/v3msk/MAINTAINERS                   |  1 -
>  board/samsung/starqltechn/MAINTAINERS             |  2 --
>  board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
>  board/siemens/iot2050/MAINTAINERS                 |  1 -
>  board/sifive/unmatched/MAINTAINERS                |  1 -
>  board/sunxi/MAINTAINERS                           |  2 --
>  board/ti/am62ax/MAINTAINERS                       |  1 -
>  board/ti/am62dx/MAINTAINERS                       |  1 -
>  board/ti/am62px/MAINTAINERS                       |  1 -
>  board/ti/j7200/MAINTAINERS                        |  1 -
>  board/toradex/apalis-tk1/MAINTAINERS              |  1 -
>  board/toradex/apalis_t30/MAINTAINERS              |  2 --
>  board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
>  board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
>  board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
>  board/toradex/colibri_t20/MAINTAINERS             |  2 --
>  board/toradex/colibri_t30/MAINTAINERS             |  2 --
>  board/toradex/colibri_vf/MAINTAINERS              |  1 -
>  board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
>  board/traverse/ten64/MAINTAINERS                  |  1 -
>  board/wandboard/MAINTAINERS                       |  1 -
>  board/wexler/qc750/MAINTAINERS                    |  1 -
>  board/xiaomi/mocha/MAINTAINERS                    |  1 -
>  board/xilinx/zynqmp/MAINTAINERS                   |  1 -
>  board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
>  board/zyxel/nsa325/MAINTAINERS                    |  3 ---
>  134 files changed, 241 deletions(-)
>

LGTM.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra

Thanks!
