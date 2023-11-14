Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE705C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 09:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C150D87243;
	Tue, 14 Nov 2023 10:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fSV5p//b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07612871ED; Tue, 14 Nov 2023 10:22:01 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2EE587257
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso44056315e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699953718; x=1700558518;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/CTiHTtFo2MHP3o3sU8HsPMPhExzuT6OYKD+tdQj+k4=;
 b=fSV5p//bCMgF5e93HhkZhCX6y51op/PUjk3IunC0aPtJgwbrOIwmZ69X3BxQrBUNvl
 mIoA53ohLrMGckIpmtECvoSgsEIMZI5d7H90/K4n7y/L2xudXt5FY63M+wrE8SsHKbgl
 NywO3FbGYggumouW1DzPt0m7co/hAO9dCXa0CX1BjUJ1oGtWZWiCFigRRNFLNbRv9z7a
 Cs3BIzS5ybH7W7Ri9IMYxK3bRF29cpdpN4DW2SZOrDyV9u92UwMaiJ9DY4cxSX90iTsN
 Bl4fyZnJJP3Bpo2BvLCPFYjpueSjrPEbjsiJ0hiPEi9soAgC+Q9UhvQJYUt8mdOA42ik
 0YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699953718; x=1700558518;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/CTiHTtFo2MHP3o3sU8HsPMPhExzuT6OYKD+tdQj+k4=;
 b=cfFlSUw2I8/W9z7sU2WqWqeRGc+4tr3Ruoa4mCcvmu6jpFlYInVOIdEEMYUqpQQ57+
 +r1W0rYe3ecE5aN/t5aY265LV89Yqq5N2iTIg3cHTr2uigNFOOOi42OTy8HKsTSLtO8o
 e2mkGhvOot981vTLxJMWzjlXJU5yl/15y9HkgZ1Sh8mQ/RXegKqPJrQ/BFVS+vrjP+g/
 4dWnc5q1C/mRSJvLgg7teQp/15RqEIGiBWbjEuA7P+0T3A58i3wjLjdkthxrvtjY/RWy
 bbN4lipymIyg/KF9KdZXmKpMCU1xX5793HCzWdOsF5FKP+I6RcnIChPL+cyIR7b9BCyJ
 /d2g==
X-Gm-Message-State: AOJu0YweDYE+UcZhzXdPkaEGURVOw93ftDN3Z24oAGUEh0pUiRVWnuSY
 5qnA+E5QLntNSELhjol7j/SxvQ==
X-Google-Smtp-Source: AGHT+IFgTq1ryiY7J3+yrCEzE79wxGZ/8ieFyaMMMWZL3niQ+/nEneGZj62aiw/8g7RKZ/rLhgcZGw==
X-Received: by 2002:a05:600c:4709:b0:409:637b:88e8 with SMTP id
 v9-20020a05600c470900b00409637b88e8mr7681950wmo.2.1699953717891; 
 Tue, 14 Nov 2023 01:21:57 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c4f8200b004090ca6d785sm10719989wmq.2.2023.11.14.01.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 01:21:57 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/5] fastboot: multiresponse support
In-Reply-To: <20231107124241.35432-2-clamor95@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
 <20231107124241.35432-2-clamor95@gmail.com>
Date: Tue, 14 Nov 2023 10:21:56 +0100
Message-ID: <87sf58n0zv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Svyatoslav,

Thank you for your patch.

On mar., nov. 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> Currently u-boot fastboot can only send one message back to host,
> so if there is a need to print more than one line messages must be
> kept sending until all the required data is obtained. This behavior
> can be adjusted using multiresponce ability (getting multiple lines
> of response) proposed in this patch.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/fastboot/fb_command.c   | 10 ++++++++++
>  drivers/usb/gadget/f_fastboot.c | 29 +++++++++++++++++++++++++++++
>  include/fastboot.h              |  8 ++++++++
>  net/fastboot_udp.c              | 25 +++++++++++++++++++------
>  4 files changed, 66 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 5fcadcdf50..ab72d8c781 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -5,6 +5,7 @@
>  
>  #include <common.h>
>  #include <command.h>
> +#include <console.h>
>  #include <env.h>
>  #include <fastboot.h>
>  #include <fastboot-internal.h>
> @@ -152,6 +153,15 @@ int fastboot_handle_command(char *cmd_string, char *response)
>  	return -1;
>  }
>  
> +void fastboot_multiresponse(int cmd, char *response)
> +{
> +	switch (cmd) {
> +	default:
> +		fastboot_fail("Unknown multiresponse command", response);
> +		break;
> +	}
> +}
> +
>  /**
>   * okay() - Send bare OKAY response
>   *
> diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
> index 741775a7bc..7d8c22b948 100644
> --- a/drivers/usb/gadget/f_fastboot.c
> +++ b/drivers/usb/gadget/f_fastboot.c
> @@ -497,6 +497,25 @@ static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
>  	do_exit_on_complete(ep, req);
>  }
>  
> +int multiresponse_cmd = -1;

This is non static, because it is also used in net/fastboot_udp.c

However, if we:
1. disable CONFIG_USB_FUNCTION_FASTBOOT
2. enable CONFIG_UDP_FUNCTION_FASTBOOT

The build will break with:
net/fastboot_udp.c: In function 'fastboot_send':
net/fastboot_udp.c:187:64: error: 'multiresponse_cmd' undeclared (first use in this function)
  187 |                                         fastboot_multiresponse(multiresponse_cmd, response);
      |                                                                ^~~~~~~~~~~~~~~~~
net/fastboot_udp.c:187:64: note: each undeclared identifier is reported only once for each function it appears in

Since having only CONFIG_UDP_FUNCTION_FASTBOOT is valid (there is no
dependency on CONFIG_USB_FASTBOOT), can we think of something else to
handle multi-response commands without breaking UDP-only fastboot
support ?


> +static void multiresponse_on_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	char response[FASTBOOT_RESPONSE_LEN] = {0};
> +
> +	if (multiresponse_cmd == -1)
> +		return;
> +
> +	/* Call handler to obtain next response */
> +	fastboot_multiresponse(multiresponse_cmd, response);
> +	fastboot_tx_write_str(response);
> +
> +	/* If response is not an INFO disconnect this handler and unset cmd */
> +	if (strncmp("INFO", response, 4) != 0) {
> +		multiresponse_cmd = -1;
> +		fastboot_func->in_req->complete = fastboot_complete;
> +	}
> +}
> +
>  static void do_acmd_complete(struct usb_ep *ep, struct usb_request *req)
>  {
>  	/* When usb dequeue complete will be called
> @@ -524,6 +543,16 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
>  		fastboot_fail("buffer overflow", response);
>  	}
>  
> +	if (!strncmp("MORE", response, 4)) {

As discussed in [1], please use TEXT instead of MORE

[1] https://lore.kernel.org/all/CAPVz0n2fOXeHQOOZ-obPWUCQ7LdFsKZFGxZw5bp-qF8SaxLSMA@mail.gmail.com/

> +		multiresponse_cmd = cmd;
> +		fastboot_multiresponse(multiresponse_cmd, response);
> +
> +		/* Only add if first is a INFO */
> +		if (!strncmp("INFO", response, 4)) {
> +			fastboot_func->in_req->complete = multiresponse_on_complete;
> +		}
> +	}
> +
>  	if (!strncmp("DATA", response, 4)) {
>  		req->complete = rx_handler_dl_image;
>  		req->length = rx_bytes_expected(ep);
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 296451f89d..d1a2b74b2f 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -172,5 +172,13 @@ void fastboot_data_download(const void *fastboot_data,
>   */
>  void fastboot_data_complete(char *response);
>  
> +/**
> + * fastboot_handle_multiresponse() - Called for each response to send
> + *
> + * @cmd: Command id that requested multiresponse
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_multiresponse(int cmd, char *response);
> +
>  void fastboot_acmd_complete(void);
>  #endif /* _FASTBOOT_H_ */
> diff --git a/net/fastboot_udp.c b/net/fastboot_udp.c
> index d690787478..ca3278f7b4 100644
> --- a/net/fastboot_udp.c
> +++ b/net/fastboot_udp.c
> @@ -42,16 +42,15 @@ static int fastboot_remote_port;
>  static int fastboot_our_port;
>  
>  /**
> - * fastboot_udp_send_info() - Send an INFO packet during long commands.
> + * fastboot_udp_send_response() - Send an response into UDP
>   *
> - * @msg: String describing the reason for waiting
> + * @response: Response to send
>   */
> -static void fastboot_udp_send_info(const char *msg)
> +static void fastboot_udp_send_response(const char *response)
>  {
>  	uchar *packet;
>  	uchar *packet_base;
>  	int len = 0;
> -	char response[FASTBOOT_RESPONSE_LEN] = {0};
>  
>  	struct fastboot_header response_header = {
>  		.id = FASTBOOT_FASTBOOT,
> @@ -66,7 +65,6 @@ static void fastboot_udp_send_info(const char *msg)
>  	memcpy(packet, &response_header, sizeof(response_header));
>  	packet += sizeof(response_header);
>  	/* Write response */
> -	fastboot_response("INFO", response, "%s", msg);
>  	memcpy(packet, response, strlen(response));
>  	packet += strlen(response);
>  
> @@ -91,6 +89,7 @@ static void fastboot_udp_send_info(const char *msg)
>  static void fastboot_timed_send_info(const char *msg)
>  {
>  	static ulong start;
> +	char response[FASTBOOT_RESPONSE_LEN] = {0};
>  
>  	/* Initialize timer */
>  	if (start == 0)
> @@ -99,7 +98,8 @@ static void fastboot_timed_send_info(const char *msg)
>  	/* Send INFO packet to host every 30 seconds */
>  	if (time >= 30000) {
>  		start = get_timer(0);
> -		fastboot_udp_send_info(msg);
> +		fastboot_response("INFO", response, "%s", msg);
> +		fastboot_udp_send_response(response);
>  	}
>  }
>  
> @@ -180,6 +180,19 @@ static void fastboot_send(struct fastboot_header header, char *fastboot_data,
>  		} else {
>  			cmd = fastboot_handle_command(command, response);
>  			pending_command = false;
> +
> +			if (!strncmp("MORE", response, 4)) {

MORE -> TEXT

> +				while (1) {
> +					/* Call handler to obtain next response */
> +					fastboot_multiresponse(multiresponse_cmd, response);

As written previously, multiresponse_cmd is undefined when:
CONFIG_USB_FUNCTION_FASTBOOT=n && CONFIG_UDP_FUNCTION_FASTBOOT=y

> +
> +					/* Send INFO or break to send final response */
> +					if (!strncmp("INFO", response, 4))
> +						fastboot_udp_send_response(response);
> +					else
> +						break;
> +				}
> +			}
>  		}
>  		/*
>  		 * Sent some INFO packets, need to update sequence number in
> -- 
> 2.40.1
