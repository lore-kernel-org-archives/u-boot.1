Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A1AC43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 01:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45748404D;
	Sat, 27 Jun 2026 03:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="SqYPS3k5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC478460E; Sat, 27 Jun 2026 03:10:00 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CFD83FEE
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 03:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782522592; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Gkds3xuOkdaAfyqxnQ7+ZX5PBy36paVOlthWouaHsO8JgaEp+MZNOiAnhEHvav0kmrkyPTYvVZUTLU2zbFYDk6+flaPLtC0C3P+ikjVi0B55RqJ1PBvchs5xTSxgel/0UiRc0mUvzZqblm2ERiG+igbAhgCEhMhkyxEiaTc+SIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782522592;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4TXp7BKFmcNpObjeMh7MucPmMXuesV9E8W1YE3f2Q8U=; 
 b=IJWShYCSRzBspjvwDIzkF9IIRX499PtJZWitlKcYPqGyf7uPlHs7hfMlQRK+EesdlckcXLOCzhGJFfgV5jkDKnrEhdX+VH4X87O9/4DXj8n7kfarI8eNjTza5wVnr6XY180f1BymP7VW3xk3K916Bj6VsMBcfRD1c6q+U6a76qM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782522592; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=4TXp7BKFmcNpObjeMh7MucPmMXuesV9E8W1YE3f2Q8U=;
 b=SqYPS3k5vqY0FSkWBK4szHaafIuXdwFH3cS/G8+hiCCVSUHJFWZ3YXUXLkY0r3YJ
 y9QkP0TaUTNhfqmNEITuzjWiqJxlsThx0to6jjEFIZUIn6agBmiLg8UdF8IAHXTgZZq
 cAnhhW+C3YHbhLnmmdXrnltLLRfUmLyQPpNON59Q=
Received: by mx.zohomail.com with SMTPS id 1782522590126750.3480564299368;
 Fri, 26 Jun 2026 18:09:50 -0700 (PDT)
Date: Sat, 27 Jun 2026 01:09:33 +0000
From: Yao Zi <me@ziyao.cc>
To: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>
Cc: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>,
 "Dinesh Maniyam" <dinesh.maniyam@altera.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 1/7] firmware: add support for RPMI
Message-ID: <aj8izUlPWpV7mQc0@pie>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
 <20260626201613.1035208-2-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626201613.1035208-2-charles.perry@microchip.com>
X-ZohoMailClient: External
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

On Fri, Jun 26, 2026 at 01:15:42PM -0700, Charles Perry wrote:
> RISC-V Platform Management Interface (RPMI) defines an OS-agnostic
> protocol for communication between an Application Processor (AP) and a
> platform microcontroller (PuC) [1]
> 
> Add UCLASS_RPMI to abstract the implementation details of an RPMI
> transport layer. A transport driver should implement the struct
> rpmi_transport_ops callback interface while an RPMI client driver should
> use struct rpmi_chan and the rpmi_* API:
> 
>   * rpmi_get_by_index()
>   * rpmi_open()
>   * rpmi_close()
>   * rpmi_get_attr()
>   * rpmi_send_with_resp()
>   * rpmi_send_posted()
> 
> The most important part of the API is rpmi_send_with_resp() and
> rpmi_send_posted() which is used to send a message and possibly receive
> a response from the firmware.
> 
> rpmi_get_attr() can be used to retrieve attributes of the channel like
> the implementation ID or the maximum message size.  This is to retrieve
> information that lives outside of the service group of the rpmi_chan,
> either in the "base service group" or in the transport layer itself.
> 
> rpmi_get_by_index() can be used to initialize a struct rpmi_chan using
> info from the device tree.
> 
> rpmi_open() and rpmi_close() must be called once at initialization and
> deinitialization by clients to let the transport layer do some stateful
> things if needed.
> 
> A helper function is also added: rpmi_check_versions() which is just a
> wrapper around rpmi_get_attr() to do some basic version checking that
> all clients should perform.
> 
> [1]: https://github.com/riscv-non-isa/riscv-rpmi
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  MAINTAINERS                         |   6 ++
>  drivers/firmware/Kconfig            |   1 +
>  drivers/firmware/Makefile           |   1 +
>  drivers/firmware/rpmi/Kconfig       |   9 ++
>  drivers/firmware/rpmi/Makefile      |   1 +
>  drivers/firmware/rpmi/rpmi-uclass.c | 138 ++++++++++++++++++++++++
>  include/dm/uclass-id.h              |   1 +
>  include/rpmi-uclass.h               |  79 ++++++++++++++
>  include/rpmi.h                      | 159 ++++++++++++++++++++++++++++
>  include/rpmi_proto.h                |  63 +++++++++++
>  10 files changed, 458 insertions(+)
>  create mode 100644 drivers/firmware/rpmi/Kconfig
>  create mode 100644 drivers/firmware/rpmi/Makefile
>  create mode 100644 drivers/firmware/rpmi/rpmi-uclass.c
>  create mode 100644 include/rpmi-uclass.h
>  create mode 100644 include/rpmi.h
>  create mode 100644 include/rpmi_proto.h

...

> diff --git a/drivers/firmware/rpmi/rpmi-uclass.c b/drivers/firmware/rpmi/rpmi-uclass.c
> new file mode 100644
> index 000000000000..b725f9e59441
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-uclass.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <dm.h>
> +#include <log.h>
> +#include <rpmi-uclass.h>
> +#include <dm/device_compat.h>

Should we sort the headers? This applies to rest of the series, too.

...

> +int rpmi_check_versions(struct rpmi_chan *chan, u32 min_proto_version,
> +			u32 servicegroup_id_expect,
> +			u32 min_servicegroup_version)
> +{
> +	u32 proto_version, servicegroup_id, servicegroup_version;
> +	int ret;
> +
> +	ret = rpmi_get_attr(chan, RPMI_ATTR_SPEC_VERSION, &proto_version);
> +	if (ret)
> +		return ret;
> +
> +	if (proto_version < min_proto_version) {
> +		dev_err(chan->dev, "protocol version mismatch\n");

The error is caused by a "too old" protocol version instead of a
"mismatched" one, shouldn't we be precise here?

Furthermore, it would be good to print the the expected and implemented
versions as well to ease debugging. debug() could be used so we don't
get the binary size increased in a normal build. So do the
servicegroup_id and servicegroup_version's case.

> +		return -EINVAL;
> +	}
> +
> +	ret = rpmi_get_attr(chan, RPMI_ATTR_SERVICEGROUP_ID, &servicegroup_id);
> +	if (ret)
> +		return ret;
> +
> +	if (servicegroup_id != servicegroup_id_expect) {
> +		dev_err(chan->dev, "service group match fail\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = rpmi_get_attr(chan, RPMI_ATTR_SERVICEGROUP_VERSION,
> +			    &servicegroup_version);
> +	if (ret)
> +		return ret;
> +
> +	if (servicegroup_version < min_servicegroup_version) {
> +		dev_err(chan->dev, "service group version mismatch\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

...

> diff --git a/include/rpmi.h b/include/rpmi.h
> new file mode 100644
> index 000000000000..de802026b31a
> --- /dev/null
> +++ b/include/rpmi.h

...

> +static inline int rpmi_to_linux_error(int rpmi_error)
> +{
> +	switch (rpmi_error) {
> +	case RPMI_SUCCESS:
> +		return 0;
> +	case RPMI_ERR_INVALID_PARAM:
> +	case RPMI_ERR_BAD_RANGE:
> +	case RPMI_ERR_INVALID_STATE:
> +		return -EINVAL;
> +	case RPMI_ERR_DENIED:
> +		return -EPERM;
> +	case RPMI_ERR_INVALID_ADDR:
> +	case RPMI_ERR_HW_FAULT:
> +		return -EFAULT;

RPMI_ERR_HW_FAULT means "failed due to hardware fault" according to
RPMI specification, does it really count as "-EFAULT" which is
"bad address"?

> +	case RPMI_ERR_ALREADY:
> +		return -EALREADY;
> +	case RPMI_ERR_BUSY:
> +		return -EBUSY;
> +	case RPMI_ERR_TIMEOUT:
> +		return -ETIMEDOUT;
> +	case RPMI_ERR_IO:
> +		return -ECOMM;
> +	case RPMI_ERR_FAILED:
> +	case RPMI_ERR_NOTSUPP:
> +	case RPMI_ERR_NO_DATA:
> +	case RPMI_ERR_EXTENSION:
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

Regards,
Yao Zi
