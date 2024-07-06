Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFEAC38150
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 00:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2658899C;
	Sat,  6 Jul 2024 02:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720227526;
	bh=DrtXDI2r6Jzz8ybbJQ08qsT8RAxag/4bYFZIcJPzswI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6FZqbcmnNUhD92y7A2/yLJ5CqmQmA3yjZ+utJbCStVjrc9xrAkc6K4fJjWAHyOHq
	 Bgq1AtocSgpP+sK6koBR0wKvgKfP77G/monNVDMc10qXlYXBhwGu4B5JYLEweacuxw
	 FjgU04NNPgVxYlVqThLb0GosVP09xXT7tabsgxTKgY+636XoedlYl58armU/0fHYd5
	 RWtDKLhpf1TKoZD6dX/e3LELmM/cIVomO0Su/X0N5aAvjq+9v5q0P7ldJs6IkXmxKh
	 a2JJYxg/45nzFXAp5M+VJHt43AIYKepIIPDXNcabktgPKVesAEyIcZZkA9qBQzJNhB
	 B3UeCnu2yvgaA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 712998863B;
 Sat,  6 Jul 2024 02:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720227524;
 bh=DrtXDI2r6Jzz8ybbJQ08qsT8RAxag/4bYFZIcJPzswI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MRmweff2AuctB/QacRIkqb6Aaxf7xip2ZhO6qaJtwyXcv0R0vqGi7hJKtVyD58mBR
 9RcknpGJDCEDmUFfVXiCyWc7Kn6WZR1er2UwPKy3hZfCjqtZ2BuRFffyiY1hswVIR+
 IwcLbPnsY9gJxzI3ko5tih9boNSzpNbEFPNIniFTAUVbHj73uh6R5eS8b0XgVXevqz
 lQCnS1xplZB9piSY2ILSXPNTYxv0ir2hv21RJbudFVYTyZHP1gLh7PHhvsULsN0gVx
 9znLkZQiwLM+K8StOGDZM6sPbL4z6FpWgK5dRxe3bQdNd4uRGB89GhvUo8uznULTxD
 bmJ9sV6MwxQlw==
Message-ID: <c61a547c-1f7e-4cce-9234-2bc724f147dc@denx.de>
Date: Sat, 6 Jul 2024 02:41:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] usb: tcpm: add core framework
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 u-boot@lists.denx.de, Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>, Wang Jie <dave.wang@rock-chips.com>
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
 <20240604163546.60225-2-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240604163546.60225-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/4/24 6:33 PM, Sebastian Reichel wrote:

Hi,

sorry for the abysmal delay

> diff --git a/cmd/tcpm.c b/cmd/tcpm.c
> new file mode 100644
> index 000000000000..37cc3ed6a3b4
> --- /dev/null
> +++ b/cmd/tcpm.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Collabora
> + */
> +
> +#include <command.h>
> +#include <errno.h>
> +#include <dm.h>
> +#include <dm/uclass-internal.h>
> +#include <usb/tcpm.h>
> +
> +#define LIMIT_DEV	32
> +#define LIMIT_PARENT	20
> +
> +static struct udevice *currdev;
> +
> +static int failure(int ret)
> +{
> +	printf("Error: %d (%s)\n", ret, errno_str(ret));

This seems unused, please drop.

> +	return CMD_RET_FAILURE;
> +}
> +
> +static int do_dev(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +	char *name;
> +	int ret = -ENODEV;
> +
> +	switch (argc) {
> +	case 2:
> +		name = argv[1];
> +		ret = tcpm_get(name, &currdev);
> +		if (ret) {
> +			printf("Can't get TCPM: %s!\n", name);
> +			return failure(ret);
> +		}
> +	case 1:
> +		if (!currdev) {
> +			printf("TCPM device is not set!\n\n");
> +			return CMD_RET_USAGE;
> +		}
> +
> +		printf("dev: %d @ %s\n", dev_seq(currdev), currdev->name);

Can you replace the printing with dev_*() or log_*() ?

[...]

> +int do_print_info(struct udevice *dev)
> +{
> +	enum typec_orientation orientation = tcpm_get_orientation(dev);
> +	const char *state = tcpm_get_state(dev);
> +	int pd_rev = tcpm_get_pd_rev(dev);
> +	int mv = tcpm_get_voltage(dev);
> +	int ma = tcpm_get_current(dev);
> +	enum typec_role pwr_role = tcpm_get_pwr_role(dev);
> +	enum typec_data_role data_role = tcpm_get_data_role(dev);
> +	bool connected = tcpm_is_connected(dev);
> +
> +	if (connected) {

Invert the condition here to reduce indent:

if (!connected) {
   printf("TCPM State...)
   return 0;
}

printf
printf
...

return 0;

> +		printf("Orientation: %s\n", typec_orientation_name[orientation]);
> +		printf("PD Revision: %s\n", typec_pd_rev_name[pd_rev]);
> +		printf("Power Role:  %s\n", typec_role_name[pwr_role]);
> +		printf("Data Role:   %s\n", typec_data_role_name[data_role]);
> +		printf("Voltage:     %2d.%03d V\n", mv / 1000, mv % 1000);
> +		printf("Current:     %2d.%03d A\n", ma / 1000, ma % 1000);
> +	} else {
> +		printf("TCPM State: %s\n", state);
> +	}
> +
> +	return 0;
> +}

[...]

> +static int tcpm_pd_transmit(struct udevice *dev,
> +			    enum tcpm_transmit_type type,
> +			    const struct pd_message *msg)
> +{
> +	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +	struct tcpm_port *port = dev_get_uclass_plat(dev);
> +	int ret;
> +	int timeout = PD_T_TCPC_TX_TIMEOUT;
> +
> +	if (msg)
> +		dev_dbg(dev, "TCPM: PD TX, header: %#x\n",
> +			le16_to_cpu(msg->header));
> +	else
> +		dev_dbg(dev, "TCPM: PD TX, type: %#x\n", type);
> +
> +	port->tx_complete = false;
> +	ret = drvops->pd_transmit(dev, type, msg, port->negotiated_rev);
> +	if (ret < 0)
> +		return ret;
> +
> +	while ((timeout > 0) && (!port->tx_complete)) {
> +		drvops->poll_event(dev);
> +		udelay(1000);
> +		timeout--;
> +		tcpm_check_and_run_delayed_work(dev);
> +	}

Can this use e.g. read_poll_timeout() with custom op() implementation ?
Would that make sense ?

> +	if (!timeout) {
> +		dev_err(dev, "TCPM: PD transmit data timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	switch (port->tx_status) {
> +	case TCPC_TX_SUCCESS:
> +		port->message_id = (port->message_id + 1) & PD_HEADER_ID_MASK;
> +		break;
> +	case TCPC_TX_DISCARDED:
> +		ret = -EAGAIN;
> +		break;
> +	case TCPC_TX_FAILED:
> +	default:
> +		ret = -EIO;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +void tcpm_pd_transmit_complete(struct udevice *dev,
> +			       enum tcpm_transmit_status status)

How much of this can be static functions ?

> +{
> +	struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +	dev_dbg(dev, "TCPM: PD TX complete, status: %u\n", status);
> +	tcpm_reset_event_cnt(dev);
> +	port->tx_status = status;
> +	port->tx_complete = true;
> +}

[...]

> +static void tcpm_pd_ctrl_request(struct udevice *dev,
> +				 const struct pd_message *msg)
> +{
> +	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
> +	struct tcpm_port *port = dev_get_uclass_plat(dev);
> +	enum tcpm_state next_state;
> +
> +	switch (type) {

[...]

> +	case PD_CTRL_DR_SWAP:
> +		if (port->port_type != TYPEC_PORT_DRP) {
> +			tcpm_queue_message(dev, PD_MSG_CTRL_REJECT);
> +			break;
> +		}
> +		/*
> +		 * XXX

What's this, some sort of FIXME ?

> +		 * 6.3.9: If an alternate mode is active, a request to swap
> +		 * alternate modes shall trigger a port reset.
> +		 */
> +		switch (port->state) {
> +		case SRC_READY:
> +		case SNK_READY:
> +			tcpm_set_state(dev, DR_SWAP_ACCEPT, 0);
> +			break;
> +		default:
> +			tcpm_queue_message(dev, PD_MSG_CTRL_WAIT);
> +			break;
> +		}
> +		break;

[...]

> +static bool tcpm_send_queued_message(struct udevice *dev)
> +{
> +	struct tcpm_port *port = dev_get_uclass_plat(dev);
> +	enum pd_msg_request queued_message;
> +
> +	do {
> +		queued_message = port->queued_message;
> +		port->queued_message = PD_MSG_NONE;
> +
> +		switch (queued_message) {
> +		case PD_MSG_CTRL_WAIT:
> +			tcpm_pd_send_control(dev, PD_CTRL_WAIT);
> +			break;
> +		case PD_MSG_CTRL_REJECT:
> +			tcpm_pd_send_control(dev, PD_CTRL_REJECT);
> +			break;
> +		case PD_MSG_CTRL_NOT_SUPP:
> +			tcpm_pd_send_control(dev, PD_CTRL_NOT_SUPP);
> +			break;
> +		case PD_MSG_DATA_SINK_CAP:
> +			tcpm_pd_send_sink_caps(dev);
> +			break;
> +		case PD_MSG_DATA_SOURCE_CAP:
> +			tcpm_pd_send_source_caps(dev);
> +			break;
> +		default:
> +			break;
> +		}
> +	} while (port->queued_message != PD_MSG_NONE);

Can this possibly run indefinitelly ? Should there be some limit on the 
number of processed messages ?

> +	return false;
> +}

[...]

> +void tcpm_poll_event(struct udevice *dev)

Can this be static void ?

> +{
> +	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +	struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +	if (!drvops->get_vbus(dev))
> +		return;
> +
> +	while (port->poll_event_cnt < TCPM_POLL_EVENT_TIME_OUT) {
> +		if (!port->wait_dr_swap_message &&
> +		    (port->state == SNK_READY || port->state == SRC_READY))
> +			break;
> +
> +		drvops->poll_event(dev);
> +		port->poll_event_cnt++;
> +		udelay(500);
> +		tcpm_check_and_run_delayed_work(dev);
> +	}
> +
> +	if (port->state != SNK_READY && port->state != SRC_READY)
> +		dev_warn(dev, "TCPM: exit in state %s\n",
> +			 tcpm_states[port->state]);
> +
> +	/*
> +	 * At this time, call the callback function of the respective pd chip
> +	 * to enter the low-power mode. In order to reduce the time spent on
> +	 * the PD chip driver as much as possible, the tcpm framework does not
> +	 * fully process the communication initiated by the device,so it should
> +	 * be noted that we can disable the internal oscillator, etc., but do
> +	 * not turn off the power of the transceiver module, otherwise the
> +	 * self-powered Type-C device will initiate a Message(eg: self-powered
> +	 * Type-C hub initiates a SINK capability request(PD_CTRL_GET_SINK_CAP))
> +	 * and the pd chip cannot reply to GoodCRC, causing the self-powered Type-C
> +	 * device to switch vbus to vSafe5v, or even turn off vbus.
> +	 */
> +	if (drvops->enter_low_power_mode) {

Invert the condition here to reduce indent:

if (!drvops->enter_low_power_mode)
   return;

> +		if (drvops->enter_low_power_mode(dev, port->attached,
> +						 port->pd_capable))
> +			dev_err(dev, "TCPM: failed to enter low power\n");
> +		else
> +			dev_info(dev, "TCPM: PD chip enter low power mode\n");
> +	}
> +}

A lot of code, but a real pleasure to read it.

Thanks !
