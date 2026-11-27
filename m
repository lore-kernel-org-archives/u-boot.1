Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE4606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sUc3xUQ0;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cygd/mFf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 440DA40AF4;
	Fri, 27 Nov 2026 19:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E9QgwVt7vNJQ; Fri, 27 Nov 2026 19:00:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F7D440AA5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795806014;
	b=jH5C88xGN31uObD7BKehDA9KD5JNeg1Wjagwmvbfnv8to4gkQLetznn5VELO5IfNQha6
	 IWdEGChwBeG/ZvVDn7sLN6cLDpXhEhJZc0jXNbc8Ob5uA09nBzeNWWEi4V2nrLoUHoTo4
	 9fc0mwJyihnLCHPoOSh0OnuookiwN7c42wQynD4y5U2lL7EaTZgF+3HOijqDx425EzKGA
	 7ns1Y7fUIgV7I0QrDkXyr9PBlxdOwxMgjphUcFk24N5j9B5lPCNpCI+TZNGRz9yWWZIsM
	 LJYVlm9Np+F0GT/K5rfsIdLW//M0LchoTSSviKWFSNpS45tvuFEriptzWmDmWfOfRPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795806014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VuPfef4T+XQyuIUOeWF9/yn4HO25rdlCansZeSd0+sc=;
	b=WfCUrrZWfSwXyKmfXNqcmqIpKWJ3Cz/Dxuu5yWOy3WmBJfT/drG1ujK+u1UhyUo20h2g
	 a95crYXPP9BNrBQu5PYHXE+SLfijceWmyKwKa+qC1sSMIk9d4CdWH0eDi021Mn0Izyv/w
	 h+7LuPd4cVDDqCiYgzGqYmNe5RGBADqYtdGQ7omjytycMzfBbHaY5pXwGkk9PTHYYkzOm
	 8Un3ggQeJS3oZCxYL1Z9Sc39qPR54OlFvlUqDwPPuyPJKKps5n1enyexg+R6myZ42FT3R
	 9uz4JvJvioNzAO6ZZuXFYpdKlnXyYAeAX6XeaLvQpijENKyYqWoKdmhUrPZzqvX31IQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795806014;
	bh=VuPfef4T+XQyuIUOeWF9/yn4HO25rdlCansZeSd0+sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sUc3xUQ0DQ9Pyl247jvBzyvkfFQ8RV/QRo2yFdG8KufVLXEUsMOY43hXm0r4KjDBQ
	 JUPZUx1FF07VgbF3J3uIm3aE1x/D2S6mYQW6lV5R4u9m+QHewuI5Z7TK31eLeHRxmg
	 47pZ/es938NLJuDxcUR4tdVO5bcmzG8xNfDp/11KubSVMmyeHVvFGpMNPkEb7h39su
	 ov72JAv1lpxIwOdEfo6WNvGaEqJ3jTeYwhrZO73JCnWnQtQLVy3KpJrcHLa5RQzd0C
	 XasUxY1xUltJpBP00eVOyfSr/gAy/C5PT0G2gWgonTVHa9T97Hgy/ksB7zeauzF+Bx
	 MaPXdmWs1XT1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F7D440AA5;
	Fri, 27 Nov 2026 19:00:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A87412BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E7ED812EB
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 12o3Lnbq8Ej1 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1211D812E9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cygd/mFf
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1211D812E9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:00:08 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso5348248f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795806007; x=1796410807;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VuPfef4T+XQyuIUOeWF9/yn4HO25rdlCansZeSd0+sc=;
 b=cygd/mFfGbZxDcrClQ4PAxp4pWL4NSF/PmOnywyzdYthTQ7BaOfeHNbV0nbCcZg9db
 /YdUp81XVq5LeIidvHIi7MjEMpQQYKiiF4OTXT+/gNZy6g7kA2jiFTk0gum48u9lJvf1
 hFiftQrJgchPmQaLSztUyaBUEajljuiS0U3uWBHuvmO31AB1NhASQofsgS9olih/ykC2
 9dO/0P3/hwYX7y2vIGKtju+dyvFpPjhbzzyo3iE+XnZgPwTp4sd1Xp6zMuH2tKPQuCQr
 7aWfGzQelNF++8/QokowhJs8oxxJSUkPxUvUOsuqcoV1prrARLhAml7sKKuQ+bT1XIVc
 gdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795806007; x=1796410807;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VuPfef4T+XQyuIUOeWF9/yn4HO25rdlCansZeSd0+sc=;
 b=uKqGp3Nzr9tJwf+qfLdYp7+SO2VISGyI1bo16xrYCewlJKqSfjVA7ghawJeVCcdlO7
 G4L2XcsQ0H3Yu9VomMxxkgui/TZ/9G5pobojOnpAyb2v+zLEv8K+MBYl/TkrZ6h8n8nd
 dwYafa/xnK23U6cGQIscgNWBPRnbzRyKanfd90RjAnRLAc6N47Mtu5d8RDB9fzbCMtV9
 O6/Qgs7qfeUcGI/zVctlMhEYPuqPZxDnSLH3FDNZFD33t8X2n0Q3NoOXnNtCd4KVmU/U
 sfzo9UBPHRoT7hYlsGjLuQ/ridVnViECPfz3cf8YSF0PfgsbGDt3Kbx+WDqoon1gDlj7
 sPIA==
X-Gm-Message-State: APuU4Z9pPUzhnBEVmCdTWGNzOTXILyJsqMcT+G9UlVBXeAiBRacjSKRW
 13o30EhqhQnLAcdMorvYmxRaNxCM6RUkW1Km2mC68SL+obbjMwTZ4nLu7ENxM9eIpBE=
X-Gm-Gg: AZFdTZc8vqwPlnWa3ssBmPGTTiyrmxQBlAEIDEv9sfvWI3KTww0BPR/4GGEE3pqm4SX
 OfDWUbsKT3smfjuM+1T7w9eXSpDqcIog2ZUQ/ZPIwUNeEpz+gs00nnl/1vxalcnsObESNZuIq5Y
 Y/UYIm8/UFMeeNL4tJEUBDBJKu7F31s9HNoS8gcpUO5SGEOyZvbKoY7qkdJ4TJRanuJJeVmY47a
 UcWQx/W8JVA4fxQElL5Pozm+4kfy+uBGkVHfNKfbiKCMw31LrF+GLD1pjwtwqaG37mPgztTyL6X
 ebIdQ7ebgQtFXLg3SG2djwKRM04muCOVdZaKDmE8QFWeRMPGFE6Rv08p/7rdmxtUvY/Py6ninyM
 M1VId3vdEa9OR/+PK49zfBlvvaxQIovbcej/e1NGKx8EBq7VqabZRlBtnRWIc6ZNU6wQgxFANe2
 x0A9Ngy9YsYEEiVL6eQ7GGlo+5TrkvWm4Nz/hBPbi9TZK+G0BlVOLQOoK1jL6RKypUfAvZ3qTnS
 VBrPJjjj8m8jED4Z3kxjtNBbdmvqyiswk0CO46UCRiD626vTVYY4QktYOcNXD9BJe3XdQ29FL3U
 W1+GC3akGdcguN45ZgU8dxGHfE/luMJPZ7156Q50DPQG/AGZq3NEkIc5dHz58Q==
X-Received: by 2002:a05:6000:250a:b0:49e:1601:2fa1 with SMTP id
 ffacd0b85a97d-4abb514618bmr58996593f8f.33.1795806006963; 
 Fri, 27 Nov 2026 11:00:06 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:16ae:8ed1:cf83:edae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm47340319f8f.30.2026.11.27.11.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:00:06 -0800 (PST)
Date: Fri, 27 Nov 2026 20:00:04 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2] board: stemmy: Read persistent radio addresses
Message-ID: <awnTNNVRsSbl1FvU@linaro.org>
References: <20261124-ux500-efs-v2-1-796a522177f9@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-ux500-efs-v2-1-796a522177f9@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 10:42:24AM +0100, Linus Walleij wrote:
> Samsung stores persistent Wi-Fi and Bluetooth addresses in several
> locations depending on the device and firmware. The eMMC partition
> numbers also differ between devices.
> 
> Locate the EFS and DATAFS partitions by name. Search the known Samsung
> Wi-Fi address files in priority order and support both Bluetooth EFS
> layouts. Accept colon-separated and compact addresses, including Codina's
> bt_macaddr: record, while rejecting known firmware placeholders.
> 
> Pass valid addresses to the operating system through the radio device
> tree nodes from ft_board_setup().
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Changes in v2:
> - The code was overly cautious, use exact EFS and DATAFS names and
>   drop both partition lookup fallbacks.
> - Clarify that fs_read() closes the filesystem even on failure.
> - Use log_warning() and log_info() for radio address messages.
> - Link to v1: https://patch.msgid.link/20261120-ux500-efs-v1-1-58147e2eae41@kernel.org
> ---
>  MAINTAINERS                     |   1 +
>  board/ste/stemmy/Makefile       |   2 +-
>  board/ste/stemmy/stemmy-radio.c | 287 ++++++++++++++++++++++++++++++++++++++++
>  board/ste/stemmy/stemmy-radio.h |   8 ++
>  board/ste/stemmy/stemmy.c       |   4 +
>  5 files changed, 301 insertions(+), 1 deletion(-)
> 
> [...]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6edf740a9ceb..ceb474751906 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -772,6 +772,7 @@ R:	Linus Walleij <linusw@kernel.org>

I think you should swap our M/R roles nowadays. :')

> [...]
> diff --git a/board/ste/stemmy/stemmy-radio.c b/board/ste/stemmy/stemmy-radio.c
> new file mode 100644
> index 000000000000..4a09ebcfe994
> --- /dev/null
> +++ b/board/ste/stemmy/stemmy-radio.c
> @@ -0,0 +1,287 @@
> [...]
> +static struct blk_desc *stemmy_radio_device(void)
> +{
> +	struct blk_desc *desc;
> +	struct udevice *dev;
> +	struct uclass *uc;
> +	struct mmc *mmc;
> +
> +	if (uclass_get(UCLASS_MMC, &uc))
> +		return NULL;
> +
> +	uclass_foreach_dev(dev, uc) {
> +		/* Android's mmcblk0 is not necessarily U-Boot's mmc 0. */
> +		if (!dev_read_bool(dev, "non-removable") || device_probe(dev))
> +			continue;

non-removable doesn't tell us much because the devices also have
non-removable SDIO and sometimes SD slots. Maybe check for "no-sdio" +
"no-sd", so we don't unnecessarily search the SD card or try to probe
the SDIO card?

> +
> +		mmc = mmc_get_mmc_dev(dev);
> +		if (!mmc || mmc_init(mmc) || !IS_MMC(mmc))
> +			continue;
> +
> +		/* Persistent data is in the user area, not an eMMC boot area. */
> +		desc = mmc_get_blk_desc(mmc);
> +		if (!desc || blk_dselect_hwpart(desc, 0))
> +			continue;
> +
> +		return desc;
> +	}
> +
> +	return NULL;
> +}
> [...]
> +static void stemmy_fixup_radio_addr(void *fdt,
> +				    struct stemmy_radio_storage *storage,
> +				    const struct stemmy_radio_source *sources,
> +				    size_t count, const char *compatible,
> +				    bool bluetooth)
> +{
> +	const char *property = bluetooth ? "local-bd-address" :
> +					       "local-mac-address";
> +	const char *name = bluetooth ? "Bluetooth BD" : "WiFi MAC";
> +	u8 addr[ETH_ALEN];
> +	int node, ret, i;
> +
> +	ret = stemmy_find_radio_addr(storage, sources, count, bluetooth, addr);
> +	if (ret) {
> +		log_warning("Persistent %s missing\n", name);
> +		return;
> +	}
> +
> +	log_info("Persistent %s: %pM\n", name, addr);
> +
> +	node = fdt_node_offset_by_compatible(fdt, -1, compatible);
> +	if (node < 0)
> +		return;
> +
> +	/* local-bd-address uses Bluetooth (least significant byte first) order. */
> +	if (bluetooth) {
> +		for (i = 0; i < ETH_ALEN / 2; i++)
> +			swap(addr[i], addr[ETH_ALEN - i - 1]);
> +	} else if (fdt_getprop(fdt, node, "mac-address", NULL)) {
> +		/* Linux prefers mac-address if it is already present. */
> +		ret = fdt_setprop(fdt, node, "mac-address", addr, sizeof(addr));
> +		if (ret)
> +			goto err;

It is true that Linux prefers "mac-address" over "local-mac-address",
but I don't think we should override that property given the definition
in the dt-bindings:

  mac-address:
    description:
      Specifies the MAC address that was last used by the boot program. This
      property should be used in cases where the MAC address assigned to the
      device by the boot program is different from the
      local-mac-address property. This property shall be used only if the value
      differs from local-mac-address property value.

We're not "using" the mac-address. (I don't think this property should
be already set by anything...)

Thanks,
Stephan
