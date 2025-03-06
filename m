Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B11C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 05:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2763C80BAA;
	Thu,  6 Mar 2025 06:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA88180F9E; Thu,  6 Mar 2025 06:11:57 +0100 (CET)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD636808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 06:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id EFE227721726;
 Thu,  6 Mar 2025 06:11:54 +0100 (CET)
Date: Thu, 6 Mar 2025 06:11:53 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, marex@denx.de, u-boot@lists.denx.de, Ye Li
 <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 07/19] clk: scmi: check the clock state/parent/rate
 control permissions
Message-ID: <20250306061153.756df4b1@karo-electronics.de>
In-Reply-To: <20250305-imx95-v1-7-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
 <20250305-imx95-v1-7-286d15acbb8a@oss.nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: +
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

On Wed, 05 Mar 2025 21:28:19 +0800 Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
>=20
> Clock driver based on SCMI clock management protocol in Linux checks
> clock state, parent and rate control permissions. To be consistent with
> the kernel driver, add this check here.
>=20
> When using common clock framework (CCF), use the clock signal ID to get
> the clock registered by clk_register() in scmi_clk_probe(), and then
> obatin the struct clk_scmi variable with container_of().
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk_scmi.c   | 173 +++++++++++++++++++++++++++++++++++++++++=
++----
>  include/scmi_protocols.h |  26 ++++++-
>  2 files changed, 186 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index 84333cdd0c..d120c1eba0 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -12,6 +12,56 @@
>  #include <asm/types.h>
>  #include <linux/clk-provider.h>
> =20
> +struct clk_scmi {
> +	struct clk clk;
> +	u32 ctrl_flags;
> +};
> +
> +static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 =
*perm)
> +{
> +	u32 version;
> +	int ret;
> +
> +	struct scmi_clk_get_permissions_in in =3D {
> +		.clock_id =3D clkid,
> +	};
> +	struct scmi_clk_get_permissions_out out;
> +	struct scmi_msg msg =3D {
> +		.protocol_id =3D SCMI_PROTOCOL_ID_CLOCK,
> +		.message_id =3D SCMI_CLOCK_GET_PERMISSIONS,
> +		.in_msg =3D (u8 *)&in,
> +		.in_msg_sz =3D sizeof(in),
> +		.out_msg =3D (u8 *)&out,
> +		.out_msg_sz =3D sizeof(out),
> +	};
> +
> +	ret =3D scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &ver=
sion);
> +	if (ret) {
> +		log_debug("%s: get SCMI clock management protocol version failed\n", _=
_func__);
> +		return ret;
> +	}
> +
> +	if (version < CLOCK_PROTOCOL_VERSION_3_0) {
> +		log_debug("%s: SCMI clock management protocol version is less than 3.0=
.\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D devm_scmi_process_msg(dev, &msg);
> +	if (ret) {
> +		log_debug("%s: get SCMI clock management protocol permissions failed\n=
", __func__);
> +		return ret;
> +	}
> +
> +	ret =3D scmi_to_linux_errno(out.status);
> +	if (ret < 0) {
> +		log_debug("%s: the status code of getting permissions: %d\n", __func__=
, ret);
> +		return ret;
> +	}
> +
> +	*perm =3D out.permissions;
> +	return 0;
> +}
> +
>  static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clock=
s)
>  {
>  	struct scmi_clk_protocol_attr_out out;
> @@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, =
size_t *num_clocks)
>  	return 0;
>  }
> =20
> -static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **=
name)
> +static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **=
name,
> +				 u32 *attr)
>  {
>  	struct scmi_clk_attribute_in in =3D {
>  		.clock_id =3D clkid,
> @@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, =
int clkid, char **name)
>  		return ret;
> =20
>  	*name =3D strdup(out.clock_name);
> +	*attr =3D out.attributes;
> =20
>  	return 0;
>  }
> @@ -78,12 +130,48 @@ static int scmi_clk_gate(struct clk *clk, int enable)
> =20
>  static int scmi_clk_enable(struct clk *clk)
>  {
> -	return scmi_clk_gate(clk, 1);
> +	struct clk_scmi *clkscmi;
> +	struct clk *c;
> +	int ret;
> +
> +	if (!CONFIG_IS_ENABLED(CLK_CCF))
> +		return scmi_clk_gate(clk, 1);
> +
> +	ret =3D clk_get_by_id(clk->id, &c);
> +	if (ret)
> +		return ret;
> +
> +	clkscmi =3D container_of(c, struct clk_scmi, clk);
> +
> +	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
> +		return scmi_clk_gate(clk, 1);
> +
> +	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent h=
as no permission. */
> +	log_debug("%s: SCMI CLOCK: the clock cannot be enabled by the agent.\n"=
, __func__);
> +	return 0;
>  }
> =20
>  static int scmi_clk_disable(struct clk *clk)
>  {
> -	return scmi_clk_gate(clk, 0);
> +	struct clk_scmi *clkscmi;
> +	struct clk *c;
> +	int ret;
> +
> +	if (!CONFIG_IS_ENABLED(CLK_CCF))
> +		return scmi_clk_gate(clk, 0);
> +
> +	ret =3D clk_get_by_id(clk->id, &c);
> +	if (ret)
> +		return ret;
> +
> +	clkscmi =3D container_of(c, struct clk_scmi, clk);
> +
> +	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
> +		return scmi_clk_gate(clk, 0);
> +
> +	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent h=
as no permission. */
> +	log_debug("%s: SCMI CLOCK: the clock cannot be disabled by the agent.\n=
", __func__);
> +	return 0;
>  }
> =20
>  static ulong scmi_clk_get_rate(struct clk *clk)
> @@ -108,7 +196,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
>  	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
>  }
> =20
> -static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
> +static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct scmi_clk_rate_set_in in =3D {
>  		.clock_id =3D clk->id,
> @@ -133,9 +221,32 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulon=
g rate)
>  	return scmi_clk_get_rate(clk);
>  }
> =20
> +static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct clk_scmi *clkscmi;
> +	struct clk *c;
> +	int ret;
> +
> +	if (!CONFIG_IS_ENABLED(CLK_CCF))
> +		return __scmi_clk_set_rate(clk, rate);
> +
> +	ret =3D clk_get_by_id(clk->id, &c);
> +	if (ret)
> +		return ret;
> +
> +	clkscmi =3D container_of(c, struct clk_scmi, clk);
> +
> +	if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
> +		return __scmi_clk_set_rate(clk, rate);
> +
> +	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent h=
as no permission. */
> +	log_debug("%s: SCMI CLOCK: the clock rate cannot be changed by the agen=
t.\n", __func__);
> +	return 0;
> +}
> +
>  static int scmi_clk_probe(struct udevice *dev)
>  {
> -	struct clk *clk;
> +	struct clk_scmi *clk_scmi;
>  	size_t num_clocks, i;
>  	int ret;
> =20
> @@ -156,29 +267,44 @@ static int scmi_clk_probe(struct udevice *dev)
> =20
>  	for (i =3D 0; i < num_clocks; i++) {
>  		char *clock_name;
> +		u32 attributes;
> =20
> -		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
> -			clk =3D kzalloc(sizeof(*clk), GFP_KERNEL);
> -			if (!clk || !clock_name)
> +		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
> +			clk_scmi =3D kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
> +			if (!clk_scmi || !clock_name)
>  				ret =3D -ENOMEM;
>  			else
> -				ret =3D clk_register(clk, dev->driver->name,
> +				ret =3D clk_register(&clk_scmi->clk, dev->driver->name,
>  						   clock_name, dev->name);
> =20
>  			if (ret) {
> -				free(clk);
> +				free(clk_scmi);
>  				free(clock_name);
> +				free(&attributes);
>  				return ret;
>  			}
> =20
> -			clk_dm(i, clk);
> +			clk_dm(i, &clk_scmi->clk);
> +
> +			if (CLK_HAS_RESTRICTIONS(attributes)) {
> +				u32 perm;
> +
> +				ret =3D scmi_clk_get_permissions(dev, i, &perm);
> +				if (ret < 0)
> +					clk_scmi->ctrl_flags =3D 0;
> +				else
> +					clk_scmi->ctrl_flags =3D perm;
> +			} else {
> +				clk_scmi->ctrl_flags =3D SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARE=
NT_CONTROL |
> +						       SUPPORT_CLK_RATE_CONTROL;
> +			}
>  		}
>  	}
> =20
>  	return 0;
>  }
> =20
> -static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
> +static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
>  {
>  	struct scmi_clk_parent_set_in in =3D {
>  		.clock_id =3D clk->id,
> @@ -197,6 +323,29 @@ static int scmi_clk_set_parent(struct clk *clk, stru=
ct clk *parent)
>  	return scmi_to_linux_errno(out.status);
>  }
> =20
> +static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	struct clk_scmi *clkscmi;
> +	struct clk *c;
> +	int ret;
> +
> +	if (!CONFIG_IS_ENABLED(CLK_CCF))
> +		return -ENOTSUPP;
> +
> +	ret =3D clk_get_by_id(clk->id, &c);
> +	if (ret)
> +		return ret;
> +
> +	clkscmi =3D container_of(c, struct clk_scmi, clk);
> +
> +	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
> +		return __scmi_clk_set_parent(clk, parent);
> +
> +	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent h=
as no permission. */
> +	log_debug("%s: SCMI CLOCK: the clock's parent cannot be changed by the =
agent.\n", __func__);
> +	return 0;
> +}
> +
>  static const struct clk_ops scmi_clk_ops =3D {
>  	.enable =3D scmi_clk_enable,
>  	.disable =3D scmi_clk_disable,
> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
> index 0d8c177025..2684f4177d 100644
> --- a/include/scmi_protocols.h
> +++ b/include/scmi_protocols.h
> @@ -731,13 +731,15 @@ int scmi_pwd_name_get(struct udevice *dev, u32 doma=
in_id, u8 **name);
>  /*
>   * SCMI Clock Protocol
>   */
> +#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
> =20
>  enum scmi_clock_message_id {
>  	SCMI_CLOCK_ATTRIBUTES =3D 0x3,
>  	SCMI_CLOCK_RATE_SET =3D 0x5,
>  	SCMI_CLOCK_RATE_GET =3D 0x6,
>  	SCMI_CLOCK_CONFIG_SET =3D 0x7,
> -	SCMI_CLOCK_PARENT_SET =3D 0xD
> +	SCMI_CLOCK_PARENT_SET =3D 0xD,
> +	SCMI_CLOCK_GET_PERMISSIONS =3D 0xF
>
add a comma to facilitate extending the enum definition


Lothar Wa=C3=9Fmann
