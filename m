Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0DAC282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 05:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803C280BAA;
	Thu,  6 Mar 2025 06:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AF3380E94; Thu,  6 Mar 2025 06:09:15 +0100 (CET)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19134808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 06:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id 0DE9E7721726;
 Thu,  6 Mar 2025 06:09:12 +0100 (CET)
Date: Thu, 6 Mar 2025 06:09:10 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, marex@denx.de, u-boot@lists.denx.de, Peng
 Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v7 06/19] clk: scmi: add the command CLOCK_PARENT_SET
Message-ID: <20250306060910.291bb660@karo-electronics.de>
In-Reply-To: <20250305-imx95-v1-6-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
 <20250305-imx95-v1-6-286d15acbb8a@oss.nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: /
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

Hi,

On Wed, 05 Mar 2025 21:28:18 +0800 Alice Guo (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This patch adds the command CLOCK_PARENT_SET that can be used to set the
> parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
> a clock device.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
>  include/scmi_protocols.h | 19 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index e42d2032d4..84333cdd0c 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -178,11 +178,31 @@ static int scmi_clk_probe(struct udevice *dev)
>  	return 0;
>  }
> =20
> +static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	struct scmi_clk_parent_set_in in =3D {
> +		.clock_id =3D clk->id,
> +		.parent_clk =3D parent->id,
> +	};
> +	struct scmi_clk_parent_set_out out;
> +	struct scmi_msg msg =3D SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
> +					  SCMI_CLOCK_PARENT_SET,
> +					  in, out);
> +	int ret;
> +
> +	ret =3D devm_scmi_process_msg(clk->dev, &msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return scmi_to_linux_errno(out.status);
> +}
> +
>  static const struct clk_ops scmi_clk_ops =3D {
>  	.enable =3D scmi_clk_enable,
>  	.disable =3D scmi_clk_disable,
>  	.get_rate =3D scmi_clk_get_rate,
>  	.set_rate =3D scmi_clk_set_rate,
> +	.set_parent =3D scmi_clk_set_parent,
>  };
> =20
>  U_BOOT_DRIVER(scmi_clock) =3D {
> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
> index 34f272c448..0d8c177025 100644
> --- a/include/scmi_protocols.h
> +++ b/include/scmi_protocols.h
> @@ -737,6 +737,7 @@ enum scmi_clock_message_id {
>  	SCMI_CLOCK_RATE_SET =3D 0x5,
>  	SCMI_CLOCK_RATE_GET =3D 0x6,
>  	SCMI_CLOCK_CONFIG_SET =3D 0x7,
> +	SCMI_CLOCK_PARENT_SET =3D 0xD
>
add a comma to facilitate extending the enum definition


Lothar Wa=C3=9Fmann
