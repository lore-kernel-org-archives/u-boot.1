Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B266ECD3431
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 07:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E2E88C8F;
	Wed,  4 Sep 2024 09:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VGaBTavk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F2F788C08; Wed,  4 Sep 2024 09:28:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A381188C8A
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 09:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b470=QC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1725434926;
 bh=D5QpmkNewsvTm7rgnEvprpUINyPEQ0SKgQXmKVPhKEA=;
 b=VGaBTavkRcnVtDCTBOeN7QKgKcHo0LEcVSYcHqbl2Qnll71etOzQS3V5qH4ET0QIq27U0lwLK
 U8rkr7YZiudxOw0ZI6VH3HXI0M3aEgAg2ig3w442rKuQcFHvHb4SXo6wDPrGK8HS5A2lSqggHFZ
 n6waTzfsXGz2C7DRpfZm3INdQsiXOyLUTVfBZ7Qc2eYpGbaWplmVSK3FVAdrcZT8eJzod696w/P
 ROZhylAJX+kLP5aAjoyMdlDe18r0SekO2PJ9yDhkG/Iuu+hqatGZSDD3fqBXjvY/C6S5aa4tgvR
 Ha+qFcF/BgMvO19rqxGDWdNrNWFdYKSnfA42QQXJXTJQ==
Message-ID: <b5800164-fa8a-458d-81ee-539b52132217@kwiboo.se>
Date: Wed, 4 Sep 2024 09:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] usb: tcpm: add core framework
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>
Cc: Soeren Moch <smoch@web.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240903182136.153196-1-sebastian.reichel@collabora.com>
 <20240903182136.153196-2-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240903182136.153196-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66d80c2ceef7c2298f151307
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

Hi Sebastian,

On 2024-09-03 20:16, Sebastian Reichel wrote:
> This adds TCPM framework in preparation for fusb302 support, which can
> handle USB power delivery messages. This is needed to solve issues with
> devices, that are running from a USB-C port supporting USB-PD, but not
> having a battery.
> 
> Such a device currently boots to the kernel without interacting with
> the power-supply at all. If there are no USB-PD message replies within
> 5 seconds, the power-supply assumes the peripheral is not capable of
> USB-PD. It usually takes more than 5 seconds for the system to reach
> the kernel and probe the I2C based fusb302 chip driver. Thus the
> system always runs into this state. The power-supply's solution to
> fix this error state is a hard reset, which involves removing the
> power from VBUS. Boards without a battery (or huge capacitors) will
> reset at this point resulting in a boot loop.
> 
> This imports the TCPM framework from the kernel. The porting has
> originally been done by Rockchip using hardware timers and the Linux
> kernel's TCPM code from some years ago.
> 
> I had a look at upgrading to the latest TCPM kernel code, but that
> beast became a lot more complex due to adding more USB-C features.
> I believe these features are not needed in U-Boot and with multiple
> kthreads and hrtimers being involved it is non-trivial to port them.
> Instead I worked on stripping down features from the Rockchip port
> to an even more basic level. Also the TCPM code has been reworked
> to avoid complete use of any timers (Rockchip used SoC specific
> hardware timers + IRQ to implement delayed work mechanism). Instead
> the delayed state changes are handled directly from the poll loop.
> 
> Note, that (in contrast to the original Rockchip port) the state
> machine has the same hard reset quirk, that the kernel has - i.e.
> it avoids disabling the CC pin resistors for devices that are not
> self-powered. Without that quirk, the Radxa Rock 5B will not just
> end up doing a machine reset when a hard reset is triggered, but will
> not even recover, because the CPU will loose power and the FUSB302
> will keep this state because of leak voltage arriving through the RX
> serial pin (assuming a serial adapter is connected).
> 
> This also includes a 'tcpm' command, which can be used to get
> information about the current state and the negotiated voltage
> and current.
> 
> Co-developed-by: Wang Jie <dave.wang@rock-chips.com>
> Signed-off-by: Wang Jie <dave.wang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Makefile                         |    1 +
>  cmd/Kconfig                      |    7 +
>  cmd/Makefile                     |    1 +
>  cmd/tcpm.c                       |  136 ++
>  doc/usage/cmd/tcpm.rst           |   66 +
>  doc/usage/index.rst              |    1 +
>  drivers/usb/Kconfig              |    2 +
>  drivers/usb/tcpm/Kconfig         |    8 +
>  drivers/usb/tcpm/Makefile        |    3 +
>  drivers/usb/tcpm/tcpm-internal.h |  173 +++
>  drivers/usb/tcpm/tcpm-uclass.c   |  145 ++
>  drivers/usb/tcpm/tcpm.c          | 2288 ++++++++++++++++++++++++++++++
>  include/dm/uclass-id.h           |    1 +
>  include/usb/pd.h                 |  516 +++++++
>  include/usb/tcpm.h               |   99 ++
>  15 files changed, 3447 insertions(+)
>  create mode 100644 cmd/tcpm.c
>  create mode 100644 doc/usage/cmd/tcpm.rst
>  create mode 100644 drivers/usb/tcpm/Kconfig
>  create mode 100644 drivers/usb/tcpm/Makefile
>  create mode 100644 drivers/usb/tcpm/tcpm-internal.h
>  create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
>  create mode 100644 drivers/usb/tcpm/tcpm.c
>  create mode 100644 include/usb/pd.h
>  create mode 100644 include/usb/tcpm.h
> 

[snip]

> diff --git a/drivers/usb/tcpm/tcpm-uclass.c b/drivers/usb/tcpm/tcpm-uclass.c
> new file mode 100644
> index 000000000000..738ab9b2b695
> --- /dev/null
> +++ b/drivers/usb/tcpm/tcpm-uclass.c
> @@ -0,0 +1,145 @@

[snip]

> +
> +static int tcpm_post_bind(struct udevice *dev)
> +{
> +	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +	const char *cap_str;
> +	ofnode node;
> +	int ret;
> +
> +	/*
> +	 * USB Power Delivery (USB PD) specification requires, that communication
> +	 * with a sink happens within roughly 5 seconds. Otherwise the source
> +	 * might assume that the sink does not support USB PD. Starting to do
> +	 * USB PD communication after that results in a hard reset, which briefly
> +	 * removes any power from the USB-C port.
> +	 *
> +	 * On systems with alternative power supplies this is not an issue, but
> +	 * systems, which get soleley powered through their USB-C port will end
> +	 * up losing their power supply and doing a board level reset. The hard
> +	 * reset will also restart the 5 second timeout. That means a operating
> +	 * system initializing USB PD will put the system into a boot loop when
> +	 * it takes more than 5 seconds from cold boot to the operating system
> +	 * starting to transmit USB PD messages.
> +	 *
> +	 * The issue can be avoided by doing the initial USB PD communication
> +	 * in U-Boot. The operating system can then re-negotiate by doing a
> +	 * soft reset, which does not trigger removal of the supply voltage.
> +	 *
> +	 * Since the TCPM state machine is quite complex and depending on the
> +	 * remote side can take quite some time to finish, this tries to limit
> +	 * the automatic probing to systems probably relying on power being
> +	 * provided by the USB-C port(s):
> +	 *
> +	 * 1. self-powered devices won't reset when the USB-C port looses power
> +	 * 2. if the power is allowed to go into anything else than sink mode
> +	 *    it is not the only power source
> +	 */
> +	ret = drvops->get_connector_node(dev, &node);
> +	if (ret)
> +		return ret;
> +
> +	if (ofnode_read_bool(node, "self-powered"))

This could possible also check for the pd-disable property.

Beside that I think this look good.

Regards,
Jonas

> +		return 0;
> +
> +	cap_str = ofnode_read_string(node, "power-role");
> +	if (!cap_str)
> +		return -EINVAL;
> +
> +	if (strcmp("sink", cap_str))
> +		return 0;
> +
> +	dev_info(dev, "probing Type-C port manager...");
> +
> +	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +
> +	return 0;
> +}
> +
> +UCLASS_DRIVER(tcpm) = {
> +	.id		= UCLASS_TCPM,
> +	.name		= "tcpm",
> +	.per_device_plat_auto	= sizeof(struct tcpm_port),
> +	.post_bind	= tcpm_post_bind,
> +	.post_probe	= tcpm_post_probe,
> +};

[snip]
