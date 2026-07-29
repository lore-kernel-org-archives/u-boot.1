Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA69C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BBD860B08;
	Wed, 29 Jul 2026 09:56:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QmtDWHCDhfBm; Wed, 29 Jul 2026 09:56:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CCF560ADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785318990;
	bh=TIdaNHXiAqlF48AMGlEM6pbpeBWVx9jSytgA/5IRBo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ycyqaTcXXL5LUfz6JewGt6lY5JmtRF/pml0i8NIwGshUvVudrX+doB/mnoLPoleUK
	 CqhaMZgTvbbntoEB3hs2A3supVqk+0+DBhiT83FHKVj6H7UuzWxUldad/5UgAw0WtV
	 HNSktbte2AW8ICREHhj7xjz/gn/ozjpBtGNhTxoJ1hUvCtMsMMCk3MlG6O7wWKRZki
	 XC7fAQBcYek9VlyVvyHqaXo3D9JNi3IKSgy1IqYECa3v2KJEaBgWnprmcRTvK30WEX
	 c1k/zoimlRV8JAJKJ46/kg6vtI/lY+tN6dPpw4A6up0H3cDbBJCjdHf9lvFJW8tEXl
	 h/5W7uhi81ZUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CCF560ADD;
	Wed, 29 Jul 2026 09:56:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5C6826C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC81640265
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OY6DiKP3kUMY for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:56:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5067A40264
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5067A40264
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5067A40264
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:56:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3CC8494B; Wed, 29 Jul 2026 11:56:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104D38404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:56:23 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9931A60AA8;
 Wed, 29 Jul 2026 09:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1701F000E9;
 Wed, 29 Jul 2026 09:56:20 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Anders Roxell <anders.roxell@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Jens Wiklander
 <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 64/75] usb: add helpers needed by the resynced DWC3 code
In-Reply-To: <20260716134305.614278-65-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-65-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:56:18 +0200
Message-ID: <87pl06xgot.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785318981;
 bh=TIdaNHXiAqlF48AMGlEM6pbpeBWVx9jSytgA/5IRBo4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=FTiiukoxHiQ3GIopQsvu2tUB5cCit5Hh6GSDZCD+ksvBh59LTeqGUUDgfY3vkwEnx
 3J/GhMpdZsWZOP4+gLb4gJqLlJflNV3VdGgtHE0XbPstUzWkzlQriXJGyN7N99B+nn
 Dxu6roHblli/0KAl3GjDTlqgNx3v13x71kGBrVvM7pnNb7tCULNZwTN60kiAXwtSpv
 1C2vPOtyS4PaOI/U583VsFdGpzANZ1ClOvI8MWraCAqg3vrk6gRyW9ULJFDKudQfeo
 Cki92tli+jyKrsGGOJefyJzA9nAz0vkc+O3uzCuZ+LZyOLw23Dmv7H/zhY76lR0OmK
 0zm55rqhbEZew==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=FTiiukox
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FTiiukox"; 
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

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

Patch title should include dm: in prefix, since we are touching driver model

> The resynced DWC3 code calls a few helpers that u-boot did not have.
> Add them first so the next commits can use them.
>
> Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  include/dm/device_compat.h | 13 +++++++++
>  include/dm/read.h          | 51 ++++++++++++++++++++++++++++++++++
>  include/linux/compat.h     | 15 ++++++++++
>  include/linux/usb/phy.h    | 56 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 135 insertions(+)
>
> diff --git a/include/dm/device_compat.h b/include/dm/device_compat.h
> index aa9a6fbb5e3f..6b31a72768fd 100644
> --- a/include/dm/device_compat.h
> +++ b/include/dm/device_compat.h
> @@ -119,4 +119,17 @@
>  #define dev_vdbg(dev, fmt, ...) \
>  	__dev_printk(LOGL_DEBUG_CONTENT, dev, fmt, ##__VA_ARGS__)
>  
> +#define dev_err_probe(dev, err, fmt, ...) \
> +	({ \
> +		int _err = (err); \
> +		if (_err != -EPROBE_DEFER) { \
> +			dev_err(dev, fmt, ##__VA_ARGS__); \
> +			dev_err(dev, "[err=%d]", _err); \
> +		} else { \
> +			dev_dbg(dev, fmt, ##__VA_ARGS__); \
> +			dev_dbg(dev, "[err=%d]", _err); \
> +		} \
> +		_err; \
> +	 })
> +
>  #endif
> diff --git a/include/dm/read.h b/include/dm/read.h
> index 12dcde6645c7..4a34afa81962 100644
> --- a/include/dm/read.h
> +++ b/include/dm/read.h
> @@ -1273,6 +1273,57 @@ static inline phy_interface_t dev_read_phy_mode(const struct udevice *dev)
>  
>  #endif /* CONFIG_DM_DEV_READ_INLINE */
>  
> +static inline int dev_count_u32(const struct udevice *dev,
> +					 const char *name)

$ ./scripts/checkpatch.pl --git
52e90cc8ccac0882f2ea160a731ebfe24adfa22a^..52e90cc8ccac0882f2ea160a731ebfe24adfa22a
seems to complain here:

CHECK: Alignment should match open parenthesis
#54: FILE: include/dm/read.h:1277:
+static inline int dev_count_u32(const struct udevice *dev,
+                                        const char *name)

We also see some other warnings later:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#179: FILE: include/linux/usb/phy.h:59:
+                            unsigned mA);

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#199: FILE: include/linux/usb/phy.h:79:
+usb_phy_set_power(struct usb_phy *x, unsigned mA)

total: 0 errors, 2 warnings, 3 checks, 171 lines checked


> +{
> +	return dev_read_u32_array(dev, name, NULL, 0);
> +}
> +
> +/* Linux compatibility */
> +
> +#define device_property_count_u32 dev_count_u32
> +#define device_property_read_bool dev_read_bool
> +#define device_property_read_u16 dev_read_u16
> +#define device_property_read_u32_array dev_read_u32_array
> +#define device_property_read_u32 dev_read_u32
> +#define device_property_read_u8 dev_read_u8
> +
> +static inline int device_property_read_string(const struct udevice *dev,
> +					      const char *propname,
> +					      const char **val)
> +{
> +	*val = dev_read_string(dev, propname);
> +	if (!*val)
> +		return -ENOENT;
> +	return 0;
> +}
> +
> +static inline bool device_property_present(const struct udevice *dev,
> +					   const char *propname)
> +{
> +	return (dev_read_size(dev, propname) > 0);
> +}
> +
> +static inline int device_property_count_u8(const struct udevice *dev,
> +					   const char *propname)
> +{
> +	return dev_read_size(dev, propname);
> +}
> +
> +static inline int device_property_read_u8_array(const struct udevice *dev,
> +						const char *propname,
> +						u8 *out, size_t count)
> +{
> +	const u8 *ptr = dev_read_u8_array_ptr(dev, propname, count);
> +
> +	if (!ptr)
> +		return -EINVAL;
> +
> +	memcpy(out, ptr, count);
> +
> +	return 0;
> +}
> +
>  /**
>   * dev_for_each_subnode() - Helper function to iterate through subnodes
>   *
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index d4ba4d0088a0..16c02260c111 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -297,6 +297,7 @@ struct rw_semaphore { int i; };
>  #define up_write(...)			do { } while (0)
>  #define down_read(...)			do { } while (0)
>  #define up_read(...)			do { } while (0)
> +struct device_node;
>  struct device {
>  	struct device		*parent;
>  	struct class		*class;
> @@ -305,6 +306,7 @@ struct device {
>  	/* This is used from drivers/usb/musb-new subsystem only */
>  	void		*driver_data;	/* data private to the driver */
>  	void            *device_data;   /* data private to the device */
> +	struct device_node	*of_node; /* associated device tree node */
>  };
>  struct mutex { int i; };
>  struct kernel_param { int i; };
> @@ -402,4 +404,17 @@ typedef unsigned long dmaaddr_t;
>  #define free_irq(irq, data) do {} while (0)
>  #define request_irq(nr, f, flags, nm, data) 0
>  
> +/* From include/linux/reset.h */
> +
> +struct reset_control;
> +
> +static inline int reset_control_assert(struct reset_control *rstc)
> +{
> +	return 0;
> +}
> +
> +static inline int reset_control_deassert(struct reset_control *rstc)
> +{
> +	return 0;
> +}
>  #endif
> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index 14b2c7eb2e63..de1d0c82076f 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -21,6 +21,13 @@ enum usb_phy_interface {
>  	USBPHY_INTERFACE_MODE_HSIC,
>  };
>  
> +/* associate a type with PHY */
> +enum usb_phy_type {
> +	USB_PHY_TYPE_UNDEFINED,
> +	USB_PHY_TYPE_USB2,
> +	USB_PHY_TYPE_USB3,
> +};

Can we splease split out the PHY parts to a separate patch?

It will make it easier to review.

Also, please mention from which linux version these code bits have been
imported from.


> +
>  #if CONFIG_IS_ENABLED(DM_USB)
>  /**
>   * usb_get_phy_mode - Get phy mode for given device_node
> @@ -37,4 +44,53 @@ static inline enum usb_phy_interface usb_get_phy_mode(ofnode node)
>  }
>  #endif
>  
> +struct usb_phy {
> +	struct device		*dev;
> +
> +	/* initialize/shutdown the phy */
> +	int     (*init)(struct usb_phy *x);
> +	void    (*shutdown)(struct usb_phy *x);
> +
> +	/* enable/disable VBUS */
> +	int     (*set_vbus)(struct usb_phy *x, int on);
> +
> +	/* effective for B devices, ignored for A-peripheral */
> +	int     (*set_power)(struct usb_phy *x,
> +			     unsigned mA);
> +};
> +
> +static inline int
> +usb_phy_init(struct usb_phy *x)
> +{
> +	if (x && x->init)
> +		return x->init(x);
> +
> +	return 0;
> +}
> +
> +static inline void
> +usb_phy_shutdown(struct usb_phy *x)
> +{
> +	if (x && x->shutdown)
> +		x->shutdown(x);
> +}
> +
> +static inline int
> +usb_phy_set_power(struct usb_phy *x, unsigned mA)
> +{
> +	if (!x)
> +		return 0;
> +
> +	/* TODO usb_phy_set_charger_current(x, mA); */

I'm ok for this being a TODO, but I'd like to see a justification of why
it's commented?

> +
> +	if (x->set_power)
> +		return x->set_power(x, mA);
> +	return 0;
> +}
> +
> +static inline int
> +usb_phy_set_suspend(struct usb_phy *x, int suspend)
> +{
> +	return 0;
> +}
>  #endif /* __LINUX_USB_PHY_H */
> -- 
> 2.53.0
