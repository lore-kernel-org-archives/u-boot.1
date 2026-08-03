Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB374C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 09:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50E5A80C69;
	Mon,  3 Aug 2026 09:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OhVJeIui799v; Mon,  3 Aug 2026 09:26:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6697080C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785749200;
	bh=WoUItW71Yg8u9kKuMgeJ/jUPqvG41aUEcfSFgQPA5QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QrM5aqyP9RVuK2rmUcjCmrozt7Ri9e+TfrA+TnZMpMXAXD8Sxf7F4UOVveo/hMSFD
	 38u5JlLAoNO/YNDEtU7H81HA9oS4TnCwWUmAc/bPR5FFrl2STqoA8crA/p2vI1Ip6p
	 Qz+jiGjkU1ROV0wkoqBd2aXku7T74tw8Ch2e7iviXhac+Ii/VqjyJ8I4CVAWsEigoF
	 8WZir3fyJuKogczYDNEb3A+vk9DhUYlh3UDTlNQk5oAP7t55H/CobxqqZ2ARCZpSBB
	 ARMM/Oic2u032uCS1xWYzJBHfv90Ru/VNeLIvJZA3mM0PctnxiJyk1vH3RgQhOaYeb
	 HPNZ6o1w+VJzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6697080C7C;
	Mon,  3 Aug 2026 09:26:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40A99350
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26B3B40077
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id meXbPogGQwGN for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 09:26:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E64F240024
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E64F240024
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E64F240024
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:26:36 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so19232445e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 02:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785749194; x=1786353994;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WoUItW71Yg8u9kKuMgeJ/jUPqvG41aUEcfSFgQPA5QE=;
 b=Jw/MYZNDhJXZO77yk0mjzmunI2z0koB2YDNvxk4xjkmbMbcW0j/EHNWNL5dytAY7qs
 aJFwhTkY5YYw7FiqFSBa7ljjwo+96YjX7agEAVEoLDBCodLjHszuCTPhCtysrQfI0D1X
 yTGxicBxYV6RBoHW6P6hJFRbAOqqxneU7XL3U9PL9Yk3iU5VKmn5UvBg5D9m8s3R9NHM
 +hqBv5nr9xfCZrfMO1SQsBHC+Ugy6P+4TMa+QKzJEGbTh9JeXC5wKoyALzSKCqv06/4Q
 WzmI13s2vLV6l+w5Jwn1Q1pCmwhbYnQCl3NRU/1Loh1tDC/xk2VjeZzgBKVi8qQnk1pr
 1oUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZxaq8ZEcRlc4TaCUPbDO873IADZnAtfT3H8GC1BRT8zWOK678WFsU+ZHuzwXQoWGQ9XdvR+Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxooy+5P+Ofz4JkV/1XFh4WthMXug5NeeqyeQBKdZh3MfqJ1D9U
 gBBw7lqY6IdMilMIdV7BcPGEB2XNtYDjbMpleDtpCH7kUKkOtl9RsqLOeIybCGIr3CM=
X-Gm-Gg: AR+sD12Gyt9wLDdtKwWZt4aobBt565PuSIhdPs5HljSsKtbPT3NrtfxLBa9xHu++UwB
 fQvQJ+OStVrhzloi4+7WOlS3AdRVmXmQWnP768d2rjJoXp1efs762PA8fuqGVRZhj8yS0UDPn8z
 qOenMhgRJI5L9oLhO1KklDUHnA32mmuDjX+x3nn38IwV/MgLjixe9VpbHxtdzA8TfOjnKK7Bc4b
 ygsSA80UyMsyJoZL+rq821PQX2AfBQrwTb8bQtGeiA7YPuGDeJPM1IwBU8vIXGS7k9HE9nJjGAP
 HKW7cEmFhjJMmdqcEUg3ut7kx4KPq+tr6TIXJ8QZSPv9Gb3UvA1BLGf0HvXxh4A6aioSh9p5qKi
 JWTB6oWmrNP/PndSNGffX9ToCcd5Hl7wZpYDrD6VVM8cmeDDWcdZYQAVbQQa7aeMxXAnvoevDOj
 DN2+Y3Yz92vhBZWtCna70BxAeWTK3PLts3vn77uwl+uIoTflTxqIw/zoh1KcV2sdmf2TPQ5zNQz
 PlAPnwg46XMCRjf6vb3/69V3u3T7pXdUVNfi8mNHw0c/R/zHEwBKqmBERqtvESY0GK2B7/guOZB
 F0oPfv/35sDpf7l8zm5dAmRzBl+66lfdpVfZIzkzqB+W3cwvAKPRLaD1YNHOUqn9xufZZKvk0Mk
 of2Nz2M9MQN6u6M3/KhFGoRsMU5q9sW04/muHq/gTTF6ziXKDSrKL0rK8tZaryhLuj5yGs+26Ek
 3SL44AfZiT0IewoHkKoiyhVL+1aZgOpeDMYLEwfT4tbG88ixOvAGcnAJwu3viJWBBUf4Exvuisc
 iRH7ZlS3TyeiiqkfvvM8jhgMeft9MX1Wjopcy32Hv5oKydysxaAbGCWQs5OImPelYD64g==
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id
 5b1f17b1804b1-4980c66b572mr184957325e9.8.1785749194618; 
 Mon, 03 Aug 2026 02:26:34 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b916e1sm185203185e9.9.2026.08.03.02.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 02:26:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 12:26:32 +0300
Message-Id: <DKF799VHIW2Y.SN931OAT6JCC@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Balaji Selvanathan" <balaji.selvanathan@oss.qualcomm.com>,
 <u-boot@lists.u-boot-project.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Heinrich Schuchardt"
 <xypron.glpk@gmx.de>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Kory Maincent" <kory.maincent@bootlin.com>, "Sughosh Ganu"
 <sughosh.ganu@arm.com>, "Wojciech Dubowik" <Wojciech.Dubowik@mt.com>,
 "Simon Glass" <sjg@chromium.org>, "Peng Fan" <peng.fan@nxp.com>
Subject: Re: [PATCH 1/8] tools: mkeficapsule: Add support for parsing
 capsule params from config file
X-Mailer: aerc 0.21.0
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
 <20260727-mkeficapsule-v1-1-5b162866b092@oss.qualcomm.com>
In-Reply-To: <20260727-mkeficapsule-v1-1-5b162866b092@oss.qualcomm.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785749194; x=1786353994;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WoUItW71Yg8u9kKuMgeJ/jUPqvG41aUEcfSFgQPA5QE=;
 b=gY0n6k9vt9PbvjLUYXgVyeOilx3aZ1C4cPtzLdpLl6enn81TpKYllF18LZ6pTh4DJi
 xbqRj18gAG6ubbhMSLuEunaVSTD1L21OuVGaTDqsBb0FQdbYzDki1YdTckAkhdqGv0O+
 rxejUFizhmNinMRS1mWC9IbXqpCu9X7/hdGMoO9PJUU0y4MvwdI+ILSLruodxeg/ftEF
 olGR7SYHam+GnRYrT1bwUADcw8uWpz3een8jhixLmInaKpV1XbUB+nHEOd8kohQSdD0H
 yZpietgy36U6TrleZxKt0y6mt/7J8NxZS6L+u6JZYmrk79/ble0SfjOVDB0Oj0Cz/aTT
 SOSw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gY0n6k9v
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

On Mon Jul 27, 2026 at 6:55 PM EEST, Balaji Selvanathan wrote:
> From: Sughosh Ganu <sughosh.ganu@arm.com>
>
> Add support for specifying the parameters needed for capsule
> generation through a config file, instead of passing them through
> command-line. Parameters for more than a single capsule file can be
> specified, resulting in generation of multiple capsules through a
> single invocation of the command.
>
> The config file can be passed to the mkeficapsule tool in such manner
>
>  $ ./tools/mkeficapsule -f <path/to/the/config/file>
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@arm.com>
> ---
>  tools/Kconfig              |  15 ++
>  tools/Makefile             |  10 +-
>  tools/eficapsule.h         | 101 +++++++++++++
>  tools/mkeficapsule.c       |  90 ++++++++----
>  tools/mkeficapsule_parse.c | 353 +++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 533 insertions(+), 36 deletions(-)
>
> diff --git a/tools/Kconfig b/tools/Kconfig
> index ef33295b8ec..8e09427fbac 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -114,6 +114,21 @@ config TOOLS_MKEFICAPSULE
>  	  optionally sign that file. If you want to enable UEFI capsule
>  	  update feature on your target, you certainly need this.
>
> +config EFI_CAPSULE_CFG_FILE
> +	string "Path to the EFI Capsule Config File"
> +	help
> +	  Path to the EFI capsule config file which provides the
> +	  parameters needed to build capsule(s). Parameters can be
> +	  provided for multiple payloads resulting in corresponding
> +	  capsule images being generated.
> +
> +config EFI_USE_CAPSULE_CFG_FILE
> +	bool "Use the config file for generating capsules"
> +	help
> +	  Boolean option used to specify if the EFI capsules are to
> +	  be generated through parameters specified via the config
> +	  file or through command line.

There were valid comments in [0] which don't seem to be addressed.
Also these options seem unused in this patch. If they are needed they belon=
g to the patch that uses
them

[...]


[0] https://lore.kernel.org/u-boot/d50d88c9-445e-45cb-936b-0c1fac2cf8ad@gmx=
.de/

Thanks
/Ilias
