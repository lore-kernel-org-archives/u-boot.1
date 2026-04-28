Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CB1FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FA7846D0;
	Wed, 29 Apr 2026 00:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="fPkGvUrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120CD8469A; Tue, 28 Apr 2026 20:45:13 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F4584698
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so4165500fac.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777401908; x=1778006708;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ajd3bjKJho7MAPMDJTioinWOwTs0o30VzapgztIU8U=;
 b=fPkGvUrc5Bc+nsBoiYhNWWekNB4RrGpesQOhwKy4OJ56rMi3lbOmOjYVqnHKZj+QOs
 uprbubehgFjswkz9Z9hDzoYcndAgEk5So0Dt79AanjFq/82D3KKr7oSPg6IZlh7DxMab
 DxOuCKXOPJCkcg9RzLNkLSrE+YR3pOI/VZgGicNPHMr8qkhwSQBujTG2AJOqqEyl5HMl
 p3WNHWg22WhF3K4ozhLDW+Qfp7Lr166BpOLYJEFuvr/JfbbgU8Yg5fThLA9WmZMFTy9J
 MDwJnc1hi5ta2iieVfB+ZvowQLobyeETFlOl6mKdN8dhlQwJ3cfsI/1HLbZ6A/8RU7W0
 Maug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777401908; x=1778006708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ajd3bjKJho7MAPMDJTioinWOwTs0o30VzapgztIU8U=;
 b=Ozp1Roa3GEWD4DgFroCf72wIMiI1n6vRUVAqGh2pqt0nTwGl5v+8v70hHI5m24B+8f
 j0ckGP+vz7wkplEAWQPgmnN28Dm7T0/TN/f9dQ1xFo77vMtTo7nxANJRhIrCg5vzLkqo
 nFOpoOTLbdXuvCF19GiqQndliwF+SqH4Ps++iwOKr06m3pnCn5IUPhkB6sf6hGzovBPD
 Lr3znbFUyv2D87UWz1KTGzZ3IKcL8amNatjPCNJuc3yHmYbfQALRqa4c8cKypoi6rSkb
 e7p9n7VJPVsK60EXDS080XB8DBQDhbGwVsupV5sigzS7RWwr1dtLK3OdltW9gt822tC9
 qJyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nQsJbFWxHDAytH6ZhZ0tAhIT3U38ES3CcPDZIEHb/nTAZu5wqXjV8C3IrHgf7iC8Bg3KnS4I=@lists.denx.de
X-Gm-Message-State: AOJu0YzL2Ni9HvaK7kwga8IwhGcA1riUhmgjeNCTORSiPhWdt7Lw1Bgz
 WNNWm2nS9gdhnaDT77g018oBJFicSuVowE2EyCSnAS5biy3vorZVLRs5WG6DeWIrooo=
X-Gm-Gg: AeBDieutrw5adDNadD1xmxVL3HhBHG6FaHoebtYfxWxgVyckV2YEY0qPHr+cFtibCsU
 RDF9SWsLFSmD5WoUuE3PyF5ZPzNpGWs6UdZDSF/b71+vJ7GVWy/VK1bg2bKe5lsoJZVlBlK0Y7k
 YE2Hm85n4aX9j754hzmksHhRam6JSm6FyDWiTiQwMLyAzTqMmtnx+qn/igFznxYXw+Wgkq1Te3M
 CJvh79q0FbSGpo5F0ZSCja5yeG7WPbHeQjBrQ1/eZbJLBGhd596pbqFFg1EZRmLmyMZeCDDucr4
 ymHpIDEuUYVpORYpCvFYHRKSbd/u//mpHUnZ9cVtoOBRQZCvzDu553SF9MdXNMaGGTiz4T6F5iB
 /MkmBh2ZPn6rZX8vsmTTSWZjR1Wei66zBMDIFtGVxLSACQiyi2YZ3Ju5JA+hINaLnAcymtNujnW
 pyI6IZMbLAPTa+M8A617NKHb/mYWeLnYI3L2QYklE639m9vM0Uf3xwaKz/rdv05eqkFWaZsd06p
 fto2KzMRfEfdTPdeLq60Dg=
X-Received: by 2002:a05:6870:f10b:b0:42c:13f4:d4d0 with SMTP id
 586e51a60fabf-433f387ad7amr2325478fac.1.1777401907914; 
 Tue, 28 Apr 2026 11:45:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:efba:bc47:a81b:dd0f?
 ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340d4a9618sm95749fac.5.2026.04.28.11.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 11:45:07 -0700 (PDT)
Message-ID: <9902b8d2-7c28-41f9-a6d0-36c6bf7456db@baylibre.com>
Date: Tue, 28 Apr 2026 13:45:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] net: phy: air_phy_lib: Factorize BuckPBus register
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Samuel Holland
 <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tommy Shih
 <tommy.shih@airoha.com>, Kevin-KW Huang <kevin-kw.huang@airoha.com>
References: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
 <20260428-add-ethernet-support-for-genio-520-720-v2-5-9cf2f0884bd8@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-5-9cf2f0884bd8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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

On 4/28/26 8:17 AM, Julien Stephan wrote:
> In preparation of Airoha AN8801R PHY support, move the BuckPBus
> register accessors and definitions, present in air_en8811h driver,
> into the Airoha PHY shared code (air_phy_lib), so they will be usable
> by the new driver without duplicating them.
> Also, update air_en8811h driver to use the new function names.
> 
> Adapted from [1].
> 
> [1]: https://lore.kernel.org/all/20260326-add-airoha-an8801-support-v2-2-1a42d6b6050f@collabora.com/
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  MAINTAINERS                          |   2 +-
>  drivers/net/phy/airoha/Kconfig       |   6 +
>  drivers/net/phy/airoha/Makefile      |   1 +
>  drivers/net/phy/airoha/air_en8811.c  | 304 ++++++++---------------------------
>  drivers/net/phy/airoha/air_phy_lib.c | 216 +++++++++++++++++++++++++
>  drivers/net/phy/airoha/air_phy_lib.h |  39 +++++
>  6 files changed, 329 insertions(+), 239 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40ba3542ca3..4bda6b9e8c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -61,7 +61,7 @@ F:	lib/acpi/
>  AIROHA PHY
>  M:	Tommy Shih <tommy.shih@airoha.com>
>  S:	Maintained
> -F:	drivers/net/phy/airoha/air_en8811.c
> +F:	drivers/net/phy/airoha/
>  
>  ALIST
>  M:	Simon Glass <sjg@chromium.org>
> diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
> index da8747939e3..2a2f4f05bb2 100644
> --- a/drivers/net/phy/airoha/Kconfig
> +++ b/drivers/net/phy/airoha/Kconfig
> @@ -7,6 +7,12 @@ config PHY_AIROHA_EN8811
>  	depends on PHY_AIROHA
>  	depends on SUPPORTS_FW_LOADER
>  	select FW_LOADER
> +	select PHY_AIRONA_PHYLIB
>  	help
>  	  AIROHA EN8811H supported.
>  	  AIROHA AN8811HB supported.
> +
> +config PHY_AIRONA_PHYLIB

Spelling: s/AIRONA/AIROHA/

> +	tristate
> +	help
> +	  Airoha Ethernet PHY common library
