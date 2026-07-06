Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA41C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 14:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90E6846FD;
	Mon,  6 Jul 2026 16:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="WWXOLyKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED51D84852; Mon,  6 Jul 2026 16:52:47 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CB0846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 16:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6401f59d0=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1783349565; x=1814885565;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JFqYimWq83+xj9Mcqk4YZj1ln6lE8mQ6KIvcEv3YiOY=;
 b=WWXOLyKUebc4osShtGN3ZMlmtVq8b7fRcSmQDojItXxmNOQT1PSijOVg
 JintaH4Af4Dd5SLw+aDJQtROIZ3BoZmQMrJbYA/BhaiDBgX09jP+uPLPw
 +wfpMzwjsAWWmYUHb51N2UGIdN3j6MPy7zatBLLHGpW3jqFtj4UjwUHKQ
 LV8TNET28lSlaAUhcGyClD+KGbPTxwCaOZ9FMYa4Fu/+nB+qNEQwuvHnA
 Fco3OuwVVPIquCbdGnQfneeQpEDK5T8oMAuv6mpbU49efGe3/SzgpnF1j
 bwi2Me3ap3+ChdKUPpkzOkS7i1zVW5L8lN7B2IkQC2jDH+3YNr+QBc3HA Q==;
X-CSE-ConnectionGUID: 7GZ5XxUrStqMN5wRDmpnqw==
X-CSE-MsgGUID: ZXDYsbzYRCuChJc4/5Wbfw==
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="60506989"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Jul 2026 07:52:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 6 Jul 2026 07:52:42 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 6 Jul 2026 07:52:41 -0700
Date: Mon, 6 Jul 2026 07:52:40 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Yao Zi <me@ziyao.cc>
CC: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>,
 "Rahul Pathak" <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Tom
 Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>, "Peng
 Fan" <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 "Stefan Roese" <stefan.roese@mailbox.org>, Jerome Forissier
 <jerome.forissier@arm.com>, Philip Molloy <philip.molloy@analog.com>,
 "Michael Trimarchi" <michael@amarulasolutions.com>, Michal Simek
 <michal.simek@amd.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria
 <ion@agorria.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: Re: [PATCH 1/7] firmware: add support for RPMI
Message-ID: <akvBOMXBGNNSKFWB@bby-cbu-swbuild03.eng.microchip.com>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
 <20260626201613.1035208-2-charles.perry@microchip.com>
 <aj8izUlPWpV7mQc0@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aj8izUlPWpV7mQc0@pie>
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

On Sat, Jun 27, 2026 at 01:09:33AM +0000, Yao Zi wrote:
> On Fri, Jun 26, 2026 at 01:15:42PM -0700, Charles Perry wrote:
> > RISC-V Platform Management Interface (RPMI) defines an OS-agnostic
> > protocol for communication between an Application Processor (AP) and a
> > platform microcontroller (PuC) [1]
> > 
> > Add UCLASS_RPMI to abstract the implementation details of an RPMI
> > transport layer. A transport driver should implement the struct
> > rpmi_transport_ops callback interface while an RPMI client driver should
> > use struct rpmi_chan and the rpmi_* API:
> > 
> >   * rpmi_get_by_index()
> >   * rpmi_open()
> >   * rpmi_close()
> >   * rpmi_get_attr()
> >   * rpmi_send_with_resp()
> >   * rpmi_send_posted()
> > 
> > The most important part of the API is rpmi_send_with_resp() and
> > rpmi_send_posted() which is used to send a message and possibly receive
> > a response from the firmware.
> > 
> > rpmi_get_attr() can be used to retrieve attributes of the channel like
> > the implementation ID or the maximum message size.  This is to retrieve
> > information that lives outside of the service group of the rpmi_chan,
> > either in the "base service group" or in the transport layer itself.
> > 
> > rpmi_get_by_index() can be used to initialize a struct rpmi_chan using
> > info from the device tree.
> > 
> > rpmi_open() and rpmi_close() must be called once at initialization and
> > deinitialization by clients to let the transport layer do some stateful
> > things if needed.
> > 
> > A helper function is also added: rpmi_check_versions() which is just a
> > wrapper around rpmi_get_attr() to do some basic version checking that
> > all clients should perform.
> > 
> > [1]: https://github.com/riscv-non-isa/riscv-rpmi
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> >  MAINTAINERS                         |   6 ++
> >  drivers/firmware/Kconfig            |   1 +
> >  drivers/firmware/Makefile           |   1 +
> >  drivers/firmware/rpmi/Kconfig       |   9 ++
> >  drivers/firmware/rpmi/Makefile      |   1 +
> >  drivers/firmware/rpmi/rpmi-uclass.c | 138 ++++++++++++++++++++++++
> >  include/dm/uclass-id.h              |   1 +
> >  include/rpmi-uclass.h               |  79 ++++++++++++++
> >  include/rpmi.h                      | 159 ++++++++++++++++++++++++++++
> >  include/rpmi_proto.h                |  63 +++++++++++
> >  10 files changed, 458 insertions(+)
> >  create mode 100644 drivers/firmware/rpmi/Kconfig
> >  create mode 100644 drivers/firmware/rpmi/Makefile
> >  create mode 100644 drivers/firmware/rpmi/rpmi-uclass.c
> >  create mode 100644 include/rpmi-uclass.h
> >  create mode 100644 include/rpmi.h
> >  create mode 100644 include/rpmi_proto.h
> 
> ...
> 
> > diff --git a/drivers/firmware/rpmi/rpmi-uclass.c b/drivers/firmware/rpmi/rpmi-uclass.c
> > new file mode 100644
> > index 000000000000..b725f9e59441
> > --- /dev/null
> > +++ b/drivers/firmware/rpmi/rpmi-uclass.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> > + */
> > +
> > +#define LOG_CATEGORY UCLASS_RPMI
> > +
> > +#include <dm.h>
> > +#include <log.h>
> > +#include <rpmi-uclass.h>
> > +#include <dm/device_compat.h>
> 
> Should we sort the headers? This applies to rest of the series, too.

Ack.

> 
> ...
> 
> > +int rpmi_check_versions(struct rpmi_chan *chan, u32 min_proto_version,
> > +			u32 servicegroup_id_expect,
> > +			u32 min_servicegroup_version)
> > +{
> > +	u32 proto_version, servicegroup_id, servicegroup_version;
> > +	int ret;
> > +
> > +	ret = rpmi_get_attr(chan, RPMI_ATTR_SPEC_VERSION, &proto_version);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (proto_version < min_proto_version) {
> > +		dev_err(chan->dev, "protocol version mismatch\n");
> 
> The error is caused by a "too old" protocol version instead of a
> "mismatched" one, shouldn't we be precise here?
> 
> Furthermore, it would be good to print the the expected and implemented
> versions as well to ease debugging. debug() could be used so we don't
> get the binary size increased in a normal build. So do the
> servicegroup_id and servicegroup_version's case.

Ack for everything.

> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = rpmi_get_attr(chan, RPMI_ATTR_SERVICEGROUP_ID, &servicegroup_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (servicegroup_id != servicegroup_id_expect) {
> > +		dev_err(chan->dev, "service group match fail\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = rpmi_get_attr(chan, RPMI_ATTR_SERVICEGROUP_VERSION,
> > +			    &servicegroup_version);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (servicegroup_version < min_servicegroup_version) {
> > +		dev_err(chan->dev, "service group version mismatch\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > diff --git a/include/rpmi.h b/include/rpmi.h
> > new file mode 100644
> > index 000000000000..de802026b31a
> > --- /dev/null
> > +++ b/include/rpmi.h
> 
> ...
> 
> > +static inline int rpmi_to_linux_error(int rpmi_error)
> > +{
> > +	switch (rpmi_error) {
> > +	case RPMI_SUCCESS:
> > +		return 0;
> > +	case RPMI_ERR_INVALID_PARAM:
> > +	case RPMI_ERR_BAD_RANGE:
> > +	case RPMI_ERR_INVALID_STATE:
> > +		return -EINVAL;
> > +	case RPMI_ERR_DENIED:
> > +		return -EPERM;
> > +	case RPMI_ERR_INVALID_ADDR:
> > +	case RPMI_ERR_HW_FAULT:
> > +		return -EFAULT;
> 
> RPMI_ERR_HW_FAULT means "failed due to hardware fault" according to
> RPMI specification, does it really count as "-EFAULT" which is
> "bad address"?

This is taken as-is from Linux [1]. So unless there's a good reason to do
things differently, I suggest we keep it as-is.

[1]: https://elixir.bootlin.com/linux/v7.1.2/source/include/linux/mailbox/riscv-rpmi-message.h#L62

Thanks,
Charles

