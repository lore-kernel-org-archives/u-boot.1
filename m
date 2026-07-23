Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE4EC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 16:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2920405FB;
	Thu, 23 Jul 2026 16:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uDzVs4jWQwXl; Thu, 23 Jul 2026 16:51:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F038403FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784825465;
	bh=UR9/Pr1ORZ2D7cGFLpTPFWSse7skwLwD3BbD5ACXWcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HibEHkYkrwl9ruDU0xBISXAoBvvQxwBiM/JB0B9jpD6RmzGfAoa9Z9qah3bzRReQd
	 vQ84SkdNa8SnP011y8OrY6gWDubhw5YLSOzXhm6rZRlodcGV81hJY4sDFDtrYsakNd
	 SeB1LSzUcxn5QfgScUbgnosXNipeYljPCkrmpwg2t6sn3qv7iYQh6cqEQv7L+oWwSd
	 0aEQ7yF2IlYpYDnOdse1S2ib9thvTmLw48cvBNshowsM38Bw37LtLDesa+iEx064wo
	 mfmSbCEzLhIxeCFguybIokXoTpumILWyDa9eaQVQg/M7lTRT9xnZYYUkwoOd4MnSsV
	 t7s8/ppMpCWyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F038403FB;
	Thu, 23 Jul 2026 16:51:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D03996C;
 Thu, 23 Jul 2026 16:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D5C9402F8;
 Thu, 23 Jul 2026 16:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85ruSn9WvsYL; Thu, 23 Jul 2026 16:51:02 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 89A8840A86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89A8840A86
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89A8840A86;
 Thu, 23 Jul 2026 16:50:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C0C80287; Thu, 23 Jul 2026 18:50:58 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6958D800AE;
 Thu, 23 Jul 2026 18:50:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; t=1784825448; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bU7PyBr26TIlSsEiAFzWTfOcWgffFhlj65LFpZvw5qN+l8M0gqnH7OWctlY34YFcWJ+XeaN+bxC1oFltx1prukBJz0ldVJSqyQygH91i3mtZkXBUDgGUSusGKFHxJEZryJTV5LJSZ17uIadH9ZKicpmQM8CqmUt7emKqRQtsEbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784825448;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UR9/Pr1ORZ2D7cGFLpTPFWSse7skwLwD3BbD5ACXWcg=; 
 b=a4QeF0Zcm1j1UU85BR9Tgr3/s21/Kw8b8EnY5HCzVd6BsEQaqzD8Iv+ivNmU7XOcBn3uvPO8LHvRS7LRrjXfXjq8PhoLbrtlGL2ZKBEsxFAP314tqTAOov6xpTjmX/iDNOA19uBC+xtDQ9LmrrfZhxXrmPJjfrMjgt0bUIB6PWU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
Received: by mx.zohomail.com with SMTPS id 178482544443936.0831451664709;
 Thu, 23 Jul 2026 09:50:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 00:50:31 +0800
Message-Id: <DK63T7X6VF21.7PVRSS31IVWQ@pigmoral.tech>
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Eric Chung" <eric.chung@riscstar.com>, <u-boot-spacemit@groups.io>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Peng Fan" <peng.fan@nxp.com>, "Huan
 Zhou" <pericycle.cc@gmail.com>, "Raymond Mao" <raymond.mao@riscstar.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Bhimeswararao Matsa"
 <bhimeswararao.matsa@gmail.com>, "Tanmay Kathpalia"
 <tanmay.kathpalia@altera.com>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>, "Han Xu" <han.xu@nxp.com>, "Yanir Levin"
 <yanir.levin@tandemg.com>, "Christoph Stoidner" <c.stoidner@phytec.de>,
 "Balsundar Ponnusamy" <balsundar.ponnusamy@altera.com>, "Daniel Palmer"
 <daniel@thingy.jp>, "Anshul Dalal" <anshuld@ti.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Angelo Dureghello"
 <angelo@kernel-space.org>, "Johan Jonker" <jbx6244@gmail.com>, "Rick Chen"
 <rick@andestech.com>, "Leo" <ycliang@andestech.com>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Guodong Xu" <guodong.xu@riscstar.com>, "Tim
 Ouyang" <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>,
 "U-Boot" <u-boot-bounces@lists.denx.de>, "Yixun Lan" <dlan@kernel.org>,
 "Yao Zi" <me@ziyao.cc>
Subject: Re: [PATCH v4 02/10] pinctrl: k1: add IO power domain configuration
 support
X-Mailer: aerc 0.21.0
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-2-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-2-dbd01185f911@riscstar.com>
X-ZohoMailClient: External
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1784825448; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Reply-To;
 bh=UR9/Pr1ORZ2D7cGFLpTPFWSse7skwLwD3BbD5ACXWcg=;
 b=FhhoL6VRp2Q5qxl4kRCL9Bb1Cww6eZ963kGCbKMVtHPfcVWv1wIk6AEBwGUBx7cn
 KfivsoCBdOMHeiSrN4f8YMWIJFIcIBZ731U+hBbaOEE3wl3HppoXok2RNC/3g0Ui2oI
 LkvXITXPPr/+gMXi1XXmP/SmtJ4L2U5oiEdcsyx4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=pigmoral.tech
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=FhhoL6VR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=pigmoral.tech
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=junhui.liu@pigmoral.tech
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.b="FhhoL6VR"; 
 dkim-atps=neutral
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

Hi Eric,

Thanks for your patch. However, I found a couple of issues while
testing.

On Tue Jul 7, 2026 at 11:21 PM CST, Eric Chung wrote:
> Dual-voltage GPIO banks default to 3.3V, but when externally supplied
> with 1.8V the internal logic must be explicitly reconfigured to match.
>
> Add the ability to program IO power domain control registers through the
> APBC block. These registers require unlocking the AIB Secure Access
> Register (ASAR) before every read/write, since configuring a 1.8V domain
> while 3.3V is externally supplied can cause back-powering and pin damage.
>
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>
> ---
> v3:
> - Add SYSCON dependency in Kconfig.
> - Fix not sorted issue in the driver.
> ---
>  drivers/pinctrl/spacemit/Kconfig      |  2 +-
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 83 +++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 82 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/=
Kconfig
> index 6aab89e160c..ff754f5839c 100644
> --- a/drivers/pinctrl/spacemit/Kconfig
> +++ b/drivers/pinctrl/spacemit/Kconfig
> @@ -1,6 +1,6 @@
>  config PINCTRL_SPACEMIT_K1
>  	bool "Spacemit K1 SoC pinctrl driver"
> -	depends on PINCTRL_GENERIC && DM
> +	depends on PINCTRL_GENERIC && DM && SYSCON
>  	help
>  	  Supports pin multiplexing control on Spacemit K1 SoCs.
> =20
> diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spac=
emit/pinctrl-k1.c
> index 3ebc397213b..95344f4ec72 100644
> --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c

[...]

> +
>  static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_se=
lector,
>  				unsigned int param, unsigned int argument)
>  {
> @@ -456,6 +526,9 @@ static int spacemit_pinconf_set(struct udevice *dev, =
unsigned int pin_selector,
>  			dev_err(dev, "Invalid power source (%d)\n", argument);
>  			return -EINVAL;
>  		}
> +		if (found)
> +			spacemit_set_io_power_domain(dev, pin_selector,

CONFIG_PINCONF is not enabled in spacemit_k1_defconfig. Therefore, with
the default configuration, the generic pinctrl code skips pin
configuration properties and spacemit_pinconf_set() is never called.
Consequently, the IO power domain configuration added here is not
exercised when building with spacemit_k1_defconfig.

> +						     priv->io_pins[i].io_type);
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
> @@ -485,6 +558,11 @@ static int spacemit_pinctrl_probe(struct udevice *de=
v)
>  		dev_err(dev, "Fail to allocate memory\n");
>  		return -ENOMEM;
>  	}
> +	priv->regmap =3D syscon_regmap_lookup_by_phandle(dev, "spacemit,apbc");
> +	if (IS_ERR(priv->regmap)) {
> +		dev_warn(dev, "no syscon found, disable IO power domain switching\n");
> +		priv->regmap =3D NULL;
> +	}

The APBC node with compatible "spacemit,k1-syscon-apbc" is bound by
drivers/clk/spacemit/clk-k1.c as a UCLASS_CLK device. It is not
registered as a UCLASS_SYSCON device, and the node does not have the
"syscon" compatible required by the fallback path in
syscon_regmap_lookup_by_phandle(). Therefore, this lookup fails and
priv->regmap is set to NULL.

I added a direct MMIO write to the UART registers here to confirm the
failure path. The original dev_warn() is not visible because this probe
happens before the normal console is initialized.

To fix this, I suggest either making the clock driver register or expose
the APBC regmap through the syscon infrastructure, or avoiding syscon
here and obtaining the regmap directly using dev_read_phandle_with_args()
followed by regmap_init_mem().

> =20
>  	ret =3D clk_get_bulk(dev, &clks);
>  	if (ret) {
> @@ -512,6 +590,7 @@ static const struct spacemit_pinctrl_data k1_pinctrl_=
data =3D {
>  	.get_pins	=3D k1_get_pins,
>  	.get_functions	=3D k1_get_functions,
>  	.get_io_type	=3D k1_get_io_type,
> +	.pin_to_io_pd_offset =3D spacemit_k1_pin_to_io_pd_offset,
>  };
> =20
>  static const struct udevice_id spacemit_pinctrl_ids[] =3D {

--=20
Best regards,
Junhui Liu

