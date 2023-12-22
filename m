Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD5BC46CD8
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 11:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A19587842;
	Fri, 22 Dec 2023 12:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="TOGMlOtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3EB877F1; Fri, 22 Dec 2023 12:28:27 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9190287859
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 12:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cc7b4709edso18483581fa.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 03:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1703244504; x=1703849304; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zzR6pm6qIk6I8zidrXicA/WrldhVTTSfK7oMBVhNTOw=;
 b=TOGMlOtxcxojZMXkt6kbk9sgTxi25cIds5jpx8QlhQxmw0mjVHjzfFJCXtpnx4ZeeN
 EKU+8Eslt/B83f6EIVSAOYQm1wymUYK4mXzMOJ5OxGE8r+l86YXZnS+vA3fL/IzcensU
 6d10xPrnMXV+LxaFj5v3+SCBeVTQS+1g+vmKdRLdyhqMo8Jl/OwZXKpLIfzHLDQj2Lhl
 GrY4Oqt3+r0mEUQ4VPrW/YL560NwBGfMGMa+XhWwSPmLPyJsGn1b8xPSadz6cNsAPwhi
 S2+zYJNwv+vVUX9hOUS0HsQ6mm0voNAITYY6sDJ3EHXfTrnImFYSwEreDZBgiKe2PonX
 Wauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703244504; x=1703849304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zzR6pm6qIk6I8zidrXicA/WrldhVTTSfK7oMBVhNTOw=;
 b=qWmWOOQJtJVeY70XmcD8A0YD43vCZDQc6qFANSGzoLHT99mny3IQxlZ59qZtNTF0iG
 JvrtLDAOcnq/yIaT8I7mWMxDfhH8Fiq47BuvJfCxQZPo6UAawnLBTrd0B9s/TztXcXJ+
 4sXr31Gg2QA1d1+WwZmrD8Hvkx3+fyX6Hq1eTKmBC2AUTRnw6/aUM0XUTwwBmb8/fjB6
 MHEBzv3OWUV15mJlt+m1vHWCFEPNi1ur1GOZB3uJgfmEgnb+FiIyHSKQFT7xGl2a4pD5
 DfHLZnqiUovM9mRGJrnJ+WkeuBoS47qLUgz5KyfRLZMT1hz62qXsJUZb5c1j0wf5jkpE
 7TpQ==
X-Gm-Message-State: AOJu0YwtIWGk1uCwKn0PavQG1b0qyuOxshbsQtPiPokXtewEn/qytABv
 BR6vZTqNgwR6mqzPQknaybRSlxysCQxTPQ==
X-Google-Smtp-Source: AGHT+IHOrwIRVmbMx0raPIxDN5OdBQ4V2XcEPutVyp2O2ipsPaBrnAEdJIy0Lm8Aer4Um1spWzvAHQ==
X-Received: by 2002:a2e:9b0c:0:b0:2cc:85a9:e54 with SMTP id
 u12-20020a2e9b0c000000b002cc85a90e54mr519112lji.90.1703244503836; 
 Fri, 22 Dec 2023 03:28:23 -0800 (PST)
Received: from ?IPV6:2a02:810d:8400:17a8:8ea:59af:d317:9dff?
 ([2a02:810d:8400:17a8:8ea:59af:d317:9dff])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a05640205d000b005543d6929aesm1378417edx.21.2023.12.22.03.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 03:28:23 -0800 (PST)
Message-ID: <105290de-01e2-42e4-a272-cb1f66111255@suse.com>
Date: Fri, 22 Dec 2023 12:28:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] rpi5: Use devicetree to retrieve board revision
Content-Language: en-US, ca-ES, es-ES
To: "Ivan T. Ivanov" <iivanov@suse.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-4-iivanov@suse.de>
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20231218210341.30073-4-iivanov@suse.de>
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



On 18/12/2023 22:03, Ivan T. Ivanov wrote:
> Firmware on RPi5 return error on board revision query
> through firmware interface, but on the other hand it fills
> "linux,revision" in "system" node, so use it to detect board
> revision.
> 
> 	system {
> 		linux,revision = <0xc04170>;
> 		linux,serial = <0x6cf44e80 0x3c533ede>;
> 	};
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   board/raspberrypi/rpi/rpi.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index cd823ad746..2851ebc985 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -171,6 +171,11 @@ static const struct rpi_model rpi_models_new_scheme[] = {
>   		DTB_DIR "bcm2711-rpi-cm4.dtb",
>   		true,
>   	},
> +	[0x17] = {
> +		"5 Model B",
> +		DTB_DIR "bcm2712-rpi-5-b.dtb",
> +		true,
> +	},
>   };
>   
>   static const struct rpi_model rpi_models_old_scheme[] = {
> @@ -429,15 +434,27 @@ static void get_board_revision(void)
>   	int ret;
>   	const struct rpi_model *models;
>   	uint32_t models_count;
> +	ofnode node;
>   
>   	BCM2835_MBOX_INIT_HDR(msg);
>   	BCM2835_MBOX_INIT_TAG(&msg->get_board_rev, GET_BOARD_REV);
>   
>   	ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg->hdr);
>   	if (ret) {
> -		printf("bcm2835: Could not query board revision\n");
>   		/* Ignore error; not critical */
> -		return;
> +		node = ofnode_path("/system");
> +		if (!ofnode_valid(node)) {
> +			printf("bcm2835: Could not find /system node\n");
> +			return;
> +		}
> +
> +		ret = ofnode_read_u32(node, "linux,revision", &revision);
> +		if (ret) {
> +			printf("bcm2835: Could not find linux,revision\n");
> +			return;
> +		}
> +	} else {
> +		revision = msg->get_board_rev.body.resp.rev;
>   	}
>   
>   	/*
> @@ -451,7 +468,6 @@ static void get_board_revision(void)
>   	 * http://www.raspberrypi.org/forums/viewtopic.php?f=63&t=98367&start=250
>   	 * http://www.raspberrypi.org/forums/viewtopic.php?f=31&t=20594
>   	 */
> -	revision = msg->get_board_rev.body.resp.rev;
>   	if (revision & 0x800000) {
>   		rev_scheme = 1;
>   		rev_type = (revision >> 4) & 0xff;
