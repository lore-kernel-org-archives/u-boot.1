Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770C9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD21588319;
	Tue, 16 Apr 2024 11:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qEfWZHph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B14882E2; Tue, 16 Apr 2024 11:50:06 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDDA88319
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516d487659bso5052336e87.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713260998; x=1713865798;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LScAUe+yjPxFVwqBPN+7BKZ5HtZIXWsilMK0/v7/sWM=;
 b=qEfWZHphKRsu4haBYWTAVvhBlNPm8yUPQZGd0w1H7ROFj96VPn05Qy8gG4xart4JCI
 HAVXtgqTewb9HlvxwHWk7FhmxFgIza5j9rMLYi1Ue8ZCGd+0EkPVtCIPdK82ytGNcis1
 MaQ+MhVPO+H2uiK5gIzs6e+0VwwEN8IBAo+FUXHAWvu8jAoZgXwR7Zg6jWW9SDF7qTgF
 jvsxpQlNHxnmIYVO2lLW4c+RTovlp7/j9sTAHB59codxRpCro1O7cdJl2ekOCBv1hmwG
 4z8Jk3XC9gj1PMRFI9bdc/PsrEuQBIBE5tPOMAn4mew2TigFrDzVZG93NkmWsFd8VBd9
 wmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713260998; x=1713865798;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LScAUe+yjPxFVwqBPN+7BKZ5HtZIXWsilMK0/v7/sWM=;
 b=K4fYeVAwgOf1McJWzoKpjhgl8nUdYRjASvhmbVikSeipAGGGq2l0FLJp7C1kRiKBc/
 kmZpM1PAD8D32/gNDzqfhEkux2PxjbDtOBlyI3Mlx/cvGNVaPtt+8Zwp63GcDTfib1I6
 fA4t8idR8idQDyl5Z+NBuB3ZTmbS9Y3pG0pW7qBnH7OOT7wZh6mVAES7gAN1HrxqHD0w
 MaMqX3CSj8SeLbg/gm8YbeyG90zNV7X/hB87Ru06BSq6+F9Fr+ZbB/Ju5ZmvVPn/5ftp
 RkZDWLiVqFuW0oV7/YSe4nMM4a9op9Q+5GLhaJPBJfgOWPNJLKBL3/raS5y6qmhwHntO
 87ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDYSyZI0PFPNqq+/yAVGtvVYp5YAthSJgXs7UPReFEADSMPMeRH81BMxYuuyFRos0qi7T3E+brn5BwndLDdKpQy873Tw==
X-Gm-Message-State: AOJu0YxI3nQwirDVuDbOqjLCXNyWNOfzU9sZpE7E2IH9FzClFWrwCUmQ
 Tdz3f9klczg17Qa+YjLnX9s/QA7t1ch218Dnp9jp2/gTccGrNgYfOiSIhCLGcvM=
X-Google-Smtp-Source: AGHT+IGiwCyIbGms/VUb8Ied2VcpKO/yeTxxkMOtLT2XtXs54tVLoXYcou58O2Pd5AIIysc6GE6yHg==
X-Received: by 2002:ac2:4d9b:0:b0:516:d33a:7571 with SMTP id
 g27-20020ac24d9b000000b00516d33a7571mr8260430lfe.8.1713260997683; 
 Tue, 16 Apr 2024 02:49:57 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b004167b0819aasm1599543wme.0.2024.04.16.02.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 02:49:57 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Lukasz Majewski
 <lukma@denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg
 <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 2/2] disk: expose partition type flags
In-Reply-To: <20240409-b4-dfu-scsi-v1-2-3e1441a60376@linaro.org>
References: <20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org>
 <20240409-b4-dfu-scsi-v1-2-3e1441a60376@linaro.org>
Date: Tue, 16 Apr 2024 11:49:54 +0200
Message-ID: <87le5d4oxp.fsf@baylibre.com>
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

Hi Caleb,

Thank you for the patch.

On mar., avril 09, 2024 at 15:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> GPT partition tables include two bytes worth of vendor defined
> attributes, per partition. ChromeOS and Qualcomm both use these (with
> different encoding!) to handle A/B slot switching with a retry counter.
>
> Expose these via the disk_partition struct so that they can be parsed by
> the relevant board code.
>
> This will be used on Qualcomm boards to determine which slot we're
> booting on so that we can flash capsule updates to the correct one.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  disk/part_efi.c | 1 +
>  include/part.h  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 4ce9243ef25c..d3ce4dd01dcd 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -292,8 +292,9 @@ int part_get_info_efi(struct blk_desc *desc, int part,
>  	snprintf((char *)info->name, sizeof(info->name), "%s",
>  		 print_efiname(&gpt_pte[part - 1]));
>  	strcpy((char *)info->type, "U-Boot");
>  	info->bootable = get_bootable(&gpt_pte[part - 1]);
> +	info->type_flags = gpt_pte[part - 1].attributes.fields.type_guid_specific;
>  	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
>  		uuid_bin_to_str(gpt_pte[part - 1].unique_partition_guid.b,
>  				(char *)disk_partition_uuid(info),
>  				UUID_STR_FORMAT_GUID);
> diff --git a/include/part.h b/include/part.h
> index 32ee40488563..afae51f1b933 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -68,8 +68,9 @@ struct disk_partition {
>  	 * PART_BOOTABLE		the MBR bootable flag is set
>  	 * PART_EFI_SYSTEM_PARTITION	the partition is an EFI system partition
>  	 */
>  	int	bootable;
> +	u16	type_flags;	/* top 16 bits of GPT partition attributes	*/
>  #if CONFIG_IS_ENABLED(PARTITION_UUIDS)
>  	char	uuid[UUID_STR_LEN + 1];	/* filesystem UUID as string, if exists	*/
>  #endif
>  #ifdef CONFIG_PARTITION_TYPE_GUID
>
> -- 
> 2.44.0
