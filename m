Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE00606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qbuWWPUn;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ziw+AkKy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC5B8605E7;
	Mon,  9 Nov 2026 17:27:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BcIyOvKkkjCg; Mon,  9 Nov 2026 17:27:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 033AA606B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245279;
	b=J6cr/dQuQ97OoJzkiHpcUSxxWEFOoWcqDPgHCSuyHG4SwM1eVRHs1FWP7ryPUE0xQm8z
	 Fyhw3tKMSJdv0E5Eu5nnJfDk/KfMQBQFA4pLMeEdcrKbJaRcnt2dMu3ASBjPAi6nXOzxZ
	 3yj6jj1di7cpbHQ5znzdfxRXrO3HpTehoY8uO+1KK3nMpKgLSrHXKs46o+5r3IvzOq41I
	 oq4IKbdhiAv4hCSFLK9/Qnj5R2xWo/fMD0EuUohc+ZM1kngB8MyawB3HNv9Y/miSK+FLu
	 yTUGQG33Ih963qCwjaEaa6wyUqzkjY+kVIiTeeuJEDw+g2W0Hqj2ZZtl330y/Iic3CQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=brbSJZyjWu9pZ3e3Q3+OLb8xO4OPHkL5fVxjAicpxDc=;
	b=IxTtVD+y2kwBSdCT6QbkuJKFtf79L1yYeF37wNOdwCfA0vgSTBaQKt5ILF/6q58ayXnC
	 lV5z7nA2ja1Pi/qtSNTU7fMBr801CPK62LNbKTtdQSNRELuCbOreGxYGLfBIaeWYu4q8w
	 FxRpJ46kITOAyqx8BMiAojtoK61tzINIA4duHsRwT4QJgM4poh0mh+pTiGyxKjelsWQXo
	 3RXyMC/FSUs+/r5DoMHyvWymETPQYvBdwIFntAUS/jCUnmwNDHkLJbdIsKqb+NMYJljQR
	 wUCV5bXt7MMg7cx6NhwzWfL1XhQYgzNOHvdwp/PFMzkNqmllKMAmracU8K0O1ZIl3Nw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245279;
	bh=brbSJZyjWu9pZ3e3Q3+OLb8xO4OPHkL5fVxjAicpxDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qbuWWPUnXajqpeUcNBL7Z9MexZ4OOauSXCorQMXXfgQnD5QgEW+Oct0IBr3/ctF3p
	 YucWmauHjc9ravyFyrWiWxfWA1jFwVsFEBaW4ePHsbAs9o+viGM+GFUgUzWhEeeNq7
	 fbizRYT5tIo1ytG3hzqEw903d/an/Ml7VDIY5XH/SpFMJ6aL0DWiPgFbWdPv6P6c6A
	 7ZC2RcStZPIUBRSjwDx53PH+pce35595qwgOdza4Jq0EhNW3sQib8axj9TDkMiqupF
	 1vZosRBXV43C6q6I0iQXn73WW5NLf4dBO4K1JUpeAsSl2Ojc52iVb1gAFYPKFxh8ZI
	 r9PnOQrEBB0mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 033AA606B0;
	Mon,  9 Nov 2026 17:27:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 051003AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB2F040176
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I70_7ldzJ8o4 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4283340068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ziw+AkKy
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4283340068
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:27:56 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6dd7070699eso647308eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794245276; x=1794850076;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=brbSJZyjWu9pZ3e3Q3+OLb8xO4OPHkL5fVxjAicpxDc=;
 b=Ziw+AkKyn7uiIgw18/9VuNBXXoUtVNEvOwH5g7pBSStKHJ2bkvglG4sOYLkuOhhmV3
 7MsjWzQFXuL4hEcnAV7EA0+0E5dJg6OE8hLPTp3O+cHpYxmgLeRv16FLkj81lMEFw9Pd
 +Dco/pfKKH4w4exijFaULLB7xBVo70HHZVRLnH1J8liKUIJoAG0dhMd8wKnnl1W/4okf
 Sqc4SZpPlkdIPnT8rgAoe1kL9tL5zIO/jd+T7BExUL3lkhR4TU2YbMEEiNcbA1Q3TlJO
 ofwCnPeiGun6EFkNTQIeI0V8esPeTHC4D4tlf/pg7nDcZnmDcygrEvR3EE0wzbu7DJCw
 KkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245276; x=1794850076;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=brbSJZyjWu9pZ3e3Q3+OLb8xO4OPHkL5fVxjAicpxDc=;
 b=iqpa+pylFVFP2h1vCqhEcxYv9UC6MsEvy/xH8/pcikIcHh/iFRohzfTy0AFYbHi86z
 CC7u9K2pHId601elQ+bX7++wPoH09iHfKMpGuZihy4WAxV8vWJzLordPLV1j5ia8aka7
 3kT4Bup+n3BDjYYS1X3Fpi1YoozicyUcIcb3BmH9QjOMjlCe8k/Gams+TGfRrbAzHGYh
 iW/oUxdOBwpWhty4MP4P5m5Z6Y71gC4m3aI9pxvlh9m1onT/P/KTF7GDOqllDHNGikh6
 HKbI9JPkq5TIGv6HCIrihJDsO0ZL3V2uejrU2BGqF0E45ptf6ujdmaAWy0kkOLJMgusY
 kqdg==
X-Forwarded-Encrypted: i=1;
 AL+hErHWr5WsZryYLN6CkE8VYSybZk9e2UPOF4+ZRKgvbS7ALyBFWphFnxZoBwo+lLBtrbtu+/l6bb0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+dHK6UqzplBUBoSan9APihZulvZULN0/Vh3bvVz4fO9D/E0DyL
 CgbwsZwf5AsyZPXLJhPxCm2/0DJTHsOgBFqwc/ZjS0+3a8dyzDxu0F/lXyqQEIMSErI=
X-Gm-Gg: AYBFou1pzkmvOGY/A6RDtY2ALCBLf6Hy2fl3TN1D7rnTpVk+XPWcbhxfwXkInvJ43Ji
 rKJaTFQ4w1V9u1jWGnzSdh7w2/r8neBaEGPU15azK7Ml7nO4uG9DmnpCxDJVKO88r7yMWthdft4
 ayvv97qo5q3+keNbZuUcT4279WNquber7TPl4wOfh2oZ3QFQEQgPUeRdUSGf2dgZirq/vvoDsuU
 8se8CfZWi/jsFQp4mxH/RQvOoGFGQlKZveafKJPD9bfWy3zyCA/ByAcynNyVY7wumpBU3ZfWvrZ
 yysKf2Vsz/CPcQ+G9gWOwdDLZFT650cfJi9Ezy/rDjD2xuqCHnkhJ2WJj/radjgUBYOo0XIubKS
 e7Tqm07am5arPfcyRDboKJ8szdrOFqA8czV0uPtda+MkLReqJ8mNWZPnGVnHSmZRj32SYz94XHo
 kn7CblIqpgwgXmAgzrBlBcwry4jras6oBwaKzCyeLIACmD3ZneogMgvBKUCxKOZXcDlNI8ZlYqq
 BlVqStwIF4W+CoX9FHg6vUj+lxTTAz45t6bWw5Zv2hfIOYS41szvrx/FwYxEexH/Jo1PRJWF6y0
 bumJpEGtRntxNnTyZusgGU1ElQJ5Jd8z8h8L7kE1La7+T/rwrIkTsLxGNH1eepscROf7TQ0m4oH
 ueA==
X-Received: by 2002:a05:6820:a00a:b0:6b1:a812:9871 with SMTP id
 006d021491bc7-7170f2b1d26mr1885611eaf.18.1794245275839; 
 Mon, 09 Nov 2026 09:27:55 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8b5a15sm3570515eaf.4.2026.11.09.09.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:27:55 -0800 (PST)
Message-ID: <875b8e1f-a929-4c83-9846-2147be2cfb30@baylibre.com>
Date: Mon, 9 Nov 2026 11:27:53 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] cmd: fdt: add 'fdt fit' to prepare a devicetree
 for other boot commands
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Ahmad Fatoum <a.fatoum@barebox.org>,
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>,
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker
 <jbx6244@gmail.com>, James Hilliard <james.hilliard1@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
 <20261026-ccaione-upstream-fdt-fit-v3-4-6c5d86c3007f@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261026-ccaione-upstream-fdt-fit-v3-4-6c5d86c3007f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 7:18 AM, Carlo Caione wrote:
> A board may keep its devicetree and overlays in a FIT while booting
> a kernel or EFI application from elsewhere. Boot scripts need a way
> to verify and assemble that devicetree without asking bootm to boot
> the FIT.
> 

...

> +/*
> + * fdt fit <addr>[#<conf>] <dest> [<length>]
> + *
> + * Load the devicetree of a FIT configuration, with its overlays applied, and
> + * copy it to <dest>. Images are always verified, so the configuration must
> + * also satisfy any required signature in the control devicetree. Unlike bootm,
> + * image load addresses are ignored and configurations cannot be chained.
> + */
> +static int fdt_fit(int argc, char *const argv[])
> +{
> +	struct bootm_headers images = { .verify = 1 };
> +	const char *conf = NULL;
> +	ulong addr, dest, data, len;
> +	bool owned;
> +	void *fdt;
> +	int ret;
> +
> +	if (argc < 2 || argc > 3)
> +		return CMD_RET_USAGE;
> +
> +	if (!fit_parse_conf(argv[0], image_load_addr, &addr, &conf))
> +		addr = hextoul(argv[0], NULL);
> +	dest = hextoul(argv[1], NULL);
> +
> +	/* Only a single configuration authenticates the whole combination */
> +	if (conf && strchr(conf, '#')) {
> +		puts("Chained configurations are not supported\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (boot_get_fdt_fit(&images, addr, NULL, &conf, IH_ARCH_DEFAULT,
> +			     FIT_LOAD_PREPARE, &data, &len, &owned) < 0)
> +		return CMD_RET_FAILURE;
> +
> +	fdt = map_sysmem(data, len);
> +	ret = CMD_RET_FAILURE;
> +	if (fdt_check_full(fdt, len)) {
> +		puts("Invalid FDT in FIT\n");
> +		goto out;
> +	}
> +
> +	len = fdt_totalsize(fdt);
> +	if (argc > 2) {
> +		ulong newlen = hextoul(argv[2], NULL);
> +
> +		if (newlen < len) {
> +			printf("New length 0x%lX < existing length 0x%lX, aborting.\n",
> +			       newlen, len);
> +			goto out;
> +		}
> +		len = newlen;
> +	}
> +
> +	if (CONFIG_IS_ENABLED(LMB) && lmb_read_check(dest, len)) {
> +		puts("ERROR: trying to overwrite reserved memory...\n");
> +		goto out;
> +	}
> +
> +	ret = fdt_open_into(fdt, map_sysmem(dest, len), len);

nit: its a bit awkward to use ret for both CMD_RET_ and other error type.
Would suggest to replace this one with e.g. err.

> +	if (ret) {
> +		printf("libfdt fdt_open_into(): %s\n", fdt_strerror(ret));
> +		ret = CMD_RET_FAILURE;

Then we don't have to rember to restore the value that was already in ret
here.

> +		goto out;
> +	}
> +	ret = CMD_RET_SUCCESS;
> +
> +out:
> +	if (owned)
> +		free(fdt);
> +
> +	return ret;
> +}
> +
