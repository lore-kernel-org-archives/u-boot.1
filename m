Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA16C5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 09:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 668A2874E8;
	Tue, 21 Nov 2023 10:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p8iqsb8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3005A871FC; Tue, 21 Nov 2023 10:25:27 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFCDF87593
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507c5249d55so7745412e87.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 01:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700558722; x=1701163522;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NtM2EJCeggeAyPW9uhOWWLDG+nO44xWnQlzYG1h2q0Q=;
 b=p8iqsb8orIL9eAoHja8S2VTusQiWAptuaUjk/fE6SE+rwVDfB3R5qyVP6E8uyKlesO
 nQckQaM0pGadlYetvW/vHKDGTaxlAtBIlpLBPlCTqclrLYfesq6zmdCDclqDyocU5LKO
 9zYAOFgaNDTvQaBbkl4K7ZdANY7mvEmvENDTtlas1ySGkAeKErYmbKfr1isqzlBRkTsU
 T17TbrpU3CrImE6q2VeBc2yshZ6sfG9k5Z9QrIT7s9krd6Z4IYMiDQy1ndaAoHUF334n
 7YupN9mTft4yWjGpshQ+zu81PqiT+6Mk4z2iS5MJUrdc+DWv0PUpgEdR8mQY6ZaeVWdh
 jGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700558722; x=1701163522;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NtM2EJCeggeAyPW9uhOWWLDG+nO44xWnQlzYG1h2q0Q=;
 b=DV39FFvm6eeJaLVsCOFuDKoIxFba3crZAQTWvNoAkwvvJpQrI8AvkOL3kFoWIqTNdC
 fetcew9M3KWXdUHhMo09fgEmcD566AyZISXaOJ9v1pEaYCK/4MH5pSyDwmtj1EGTgtLM
 Db5C+mlK2/m/C1AyrgMcTRZcm22cAnU38ygOIOw2fHFi0WanE6FOFh5mp0U+FJ6CI/0c
 /M0ygnTHIQ0Kv5BEWy3gE1QWlLnszvNV3QE+nbFqF9pERydncnunxqfCrnQtx2KCK86H
 J9PelT+ZGe/dEjzhf3tJ6/TdNTPYPOQ3uVXBGgzXZOCBnqbGvqERlTKEC/wPswxTeYns
 2vpw==
X-Gm-Message-State: AOJu0Yxs2KzBdSu4bvEkQIHT45mFrsieQftaDZzm6MJyGsNH/W1PSxLV
 K53AZzImFcO+mhpC5LfJ6PnXQg==
X-Google-Smtp-Source: AGHT+IFSBWYHN8sQZYN3jdLHkEm9AmFO1rSClDgOBT94ON9Q/WFr2Hcx4WZP2qskR0j+ABvcP0JQNA==
X-Received: by 2002:a05:6512:3d91:b0:50a:a6d2:b5cd with SMTP id
 k17-20020a0565123d9100b0050aa6d2b5cdmr7555472lfv.53.1700558722153; 
 Tue, 21 Nov 2023 01:25:22 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 je14-20020a05600c1f8e00b0040596352951sm21223152wmb.5.2023.11.21.01.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 01:25:21 -0800 (PST)
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
Subject: Re: [PATCH v2 1/5] fastboot: multiresponse support
In-Reply-To: <20231115153836.16537-2-clamor95@gmail.com>
References: <20231115153836.16537-1-clamor95@gmail.com>
 <20231115153836.16537-2-clamor95@gmail.com>
Date: Tue, 21 Nov 2023 10:25:20 +0100
Message-ID: <877cmbmpa7.fsf@baylibre.com>
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

Thank you for the patch.

On mer., nov. 15, 2023 at 17:38, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/fastboot/fb_command.c   | 10 ++++++++++
>  drivers/usb/gadget/f_fastboot.c | 29 +++++++++++++++++++++++++++++
>  include/fastboot.h              | 18 ++++++++++++++++++
>  net/fastboot_udp.c              | 29 +++++++++++++++++++++++------
>  4 files changed, 80 insertions(+), 6 deletions(-)
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
> index 741775a7bc..0850350331 100644
> --- a/drivers/usb/gadget/f_fastboot.c
> +++ b/drivers/usb/gadget/f_fastboot.c
> @@ -497,6 +497,25 @@ static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
>  	do_exit_on_complete(ep, req);
>  }
>  
> +static int multiresponse_cmd = -1;
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
> +	/* If response is final OKAY/FAIL response disconnect this handler and unset cmd */
> +	if (!strncmp("OKAY", response, 4) || !strncmp("FAIL", response, 4)) {
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
> +	if (!strncmp(FASTBOOT_MULTIRESPONSE_START, response, 4)) {
> +		multiresponse_cmd = cmd;
> +		fastboot_multiresponse(multiresponse_cmd, response);
> +
> +		/* Only add complete callback if first is not a final OKAY/FAIL response */
> +		if (strncmp("OKAY", response, 4) && strncmp("FAIL", response, 4)) {
> +			fastboot_func->in_req->complete = multiresponse_on_complete;
> +		}
> +	}
> +
>  	if (!strncmp("DATA", response, 4)) {
>  		req->complete = rx_handler_dl_image;
>  		req->length = rx_bytes_expected(ep);
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 296451f89d..59cbea61ec 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -14,6 +14,16 @@
>  
>  #define FASTBOOT_VERSION	"0.4"
>  
> +/*
> + * Signals u-boot fastboot code to send multiple responses by
> + * calling response generating function repeatedly until a OKAY/FAIL
> + * is generated as final response.
> + *
> + * This status code is only used internally to signal, must NOT
> + * be sent to host.
> + */
> +#define FASTBOOT_MULTIRESPONSE_START	("MORE")
> +
>  /* The 64 defined bytes plus \0 */
>  #define FASTBOOT_COMMAND_LEN	(64 + 1)
>  #define FASTBOOT_RESPONSE_LEN	(64 + 1)
> @@ -172,5 +182,13 @@ void fastboot_data_download(const void *fastboot_data,
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
> index d690787478..6fee441ab3 100644
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
> @@ -180,6 +180,23 @@ static void fastboot_send(struct fastboot_header header, char *fastboot_data,
>  		} else {
>  			cmd = fastboot_handle_command(command, response);
>  			pending_command = false;
> +
> +			if (!strncmp(FASTBOOT_MULTIRESPONSE_START, response, 4)) {
> +				while (1) {
> +					/* Call handler to obtain next response */
> +					fastboot_multiresponse(cmd, response);
> +
> +					/*
> +					 * Send more responses or break to send
> +					 * final OKAY/FAIL response
> +					 */
> +					if (strncmp("OKAY", response, 4) &&
> +					    strncmp("FAIL", response, 4))
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
