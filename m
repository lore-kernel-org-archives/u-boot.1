Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DA606A32C
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n/IKSmDB;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WsbmDc0r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFAB64070B;
	Mon,  2 Nov 2026 10:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SsSiUf4ftcik; Mon,  2 Nov 2026 10:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3D2940711
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613804;
	b=fPt6V6f2CZXZYVOnTraSzcRTwGRvXJ1zsohD9HH6nCDyqq8K8p4R7JQZbp9Pn9mRd3d+
	 44oITepXc/qQeF7Lj7uM7MjMSkxHpfvUpxG09+A/c0OFSvPqgvt5bGfI+Ekr8LRRYR/c2
	 Cd5SWUR31GOMX3ZSpPpFhddEBbQRAhMTlTedzxtW0sAWsPliuPKGmlgfWxfT02fyuE3OF
	 LsAyfPRroLjU2x7Xj3ok8Z5PJa++zZZDbKcQ0K2VYYau44+HZPSuW/RFo8s9XrsxyEYjT
	 Hfj1yjmePMVBX2bI6cz2aWmaiG92oCzYPrW4wLYz4mFC9R1+ufSqxysw6lZkLkgLqMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GtIO+Ch6C+csc7PsCWMRX3+76iZxyMD6XSpVwyCza4Y=;
	b=oLBUBozysFfp9Ai3W/RTWRbiOn7C0Yvl6aC1s01PYOz/Nv4PmiwAUthXQr18GcBekcGo
	 An9UjyY9R5mdFxPyeOiigcFLvvUE44dSsh5+/r90Z0ASgHRGdIzOWu/nynO0x0oPOZjv/
	 c+SGOsea4m+JB+Uuql4WSGBO7UeyZzevDPkna3oLOpYyM4os26GjVcUEhpIvP2A3ooMOP
	 SEolFqZDBzqf7tPNpDWEYZLUhE5lQE0FCKV/Kcl0VohA+p/devfTIW2vMmD9yfaRWhNee
	 qFYE5ogY9IAMKo9IjD+akyCw8fET88tGhL4H5MwSNv8h6zGNt0MgC4JFZS2xbetW2yA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613804;
	bh=GtIO+Ch6C+csc7PsCWMRX3+76iZxyMD6XSpVwyCza4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/IKSmDBy67tHh2ESpP528fp6da4h7K7VVWjM1zYEtwqfIDiV1sblQdFV/YV5OhL2
	 21uqy7z/1KDtoCbtwRcRZFY8JYHuVRKyzg3Mm28xklTmvvUFFrIxhVXeETsUpsjjZs
	 DrdDbdCg8IZMZTHt2944auKazqlucp1DK6jfNMs71UGIE9INyDkS+bGoVUN18lMM2z
	 mGQ4hMA4dE7SZVbaQi96RLjW/ECTSc2Ze1ZquEcCyH7VXT1yTalQ1Q3+/hNyCUW/IU
	 grHEV3oz6VKYWb3+9OJ3lFFy4Xj0ddrMTfTjZwSbwpukpka4OGpKY/aZu01cfe4lXv
	 m/KHvvCMSFosQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3D2940711;
	Mon,  2 Nov 2026 10:03:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 95D9AD3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 877BC6076F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCXPPBltykQk for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 10:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E43626075A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613802;
 b=LwtG9c2IHexC3l8T7TixX1zspa34jLFDmcnBj93/zU2Kcdz1lnhcT4RWGe9nOcx+OKJQ
 Br9y3yrOyAd0Y9n4MXdsjfi8AgtSitqMM/WqV+i6QTJENONGzeYrUjDlxsH+36v3XPD/j
 h5Pyj7ps09eJ571J2SMWSH/h2lf32Iswakv2jIjA7FR0MbOfOpiVpIf36CioEFmsBLc2n
 K1JnIUJX1PETPYZv9T+jkH7Pm4W23f2NuEJ5F0KmzZ944nDe6ij5RAs/saLoOG5dT8PhN
 A1nBm2W2SG2qmpg/DzxYJm0Vk0etffmxKLVgdGEBOld7H9zhkuBRYeu2zX0oZbMFo/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613802;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=GtIO+Ch6C+csc7PsCWMRX3+76iZxyMD6XSpVwyCza4Y=;
 b=q/sQZqLPM0IUKMnlffAn8eMIOuB+LsjdKg4SsEnKgXHLm9tYqy5TCZ5iByJQxr4RY5My
 rfjno23k85+ltErIYGyIbisQddmcYiHFtnX04sdCKI4LLPrhh//RdBG4ip4tJpCuF2YsC
 d/vBvhlI+ygqs0bW13hKA3dH2p4bRMfnjWE+q/ekrZGTysIKSwGIolxhBUkIfy+W++jTg
 t6OHBEhPrQtIImHS0PkoCZvC/R2R37OqCjxdTy/hR2Iw8NPfhPG8vGtURvelS0ZNO3l1T
 rRGtup211ETJ5sopp0zo/qRPxGxU8zERnRRL2JNi1FXpXf166/UIdYjBQYKF4Muf9+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=WsbmDc0r; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=bastien.curutchet@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=WsbmDc0r
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E43626075A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:03:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6D8FF1A13E5;
 Mon,  2 Nov 2026 10:03:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 367A760750;
 Mon,  2 Nov 2026 10:03:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E4DFC1032909D; Mon,  2 Nov 2026 11:03:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793613797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=GtIO+Ch6C+csc7PsCWMRX3+76iZxyMD6XSpVwyCza4Y=;
 b=WsbmDc0r/sN93Z8gdaOKcxiLZnAKXTWUyHSrT0sNs/DVHk0zmaAJVnH4CgzcMmhW0aA4g8
 VzyGPqW6VWvv4Zle28fKFW3jDAE36mTYehXtBElpa3Dn6SwSh8Bk4ljqKNVO0lCV9WIMFb
 N0P+8kRJmuK1t8jEuxEC1EFejmCWrY/otvPjHXBleZRvRZBZzQbKWn1aB3JCKh29MQBDzj
 4eFj91gVRgitfTLAXViIsZ7tXDjCdFplMiyZvk+dn6JjAhJ3F/MBEiOIldwGN0Ru+LpKtd
 iChYPxeDMnVBHA/Zb4S6EYIh1wU35z2HNmBUc1haQOa6KF3UinxyX5i3UzUr4Q==
Message-ID: <db177de8-a6ec-4600-badc-840629e1d6f6@bootlin.com>
Date: Mon, 2 Nov 2026 11:03:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] bootstd: rauc: Optionally check the partition names
To: Frieder Schrempf <frieder@fris.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov
 <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-6-b5a878627107@kontron.de>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20261029-main-v1-6-b5a878627107@kontron.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder,

On 10/29/26 5:23 PM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The RAUC bootmeth uses any MMC device on which the boot partition of a
> slot holds a filesystem and the root partition exists. This also matches
> devices with a different layout, for example a single-system image or a
> standard distro installed to eMMC. The bootmeth then claims such a
> device and creates and saves its BOOT_ORDER and BOOT_x_LEFT variables in
> the environment, which makes it difficult to run BOOTMETH_RAUC alongside
> other bootmeths.
> 
> Add CONFIG_BOOTMETH_RAUC_PART_NAMES to set the expected names of the
> boot and root partitions of each slot, in the same format as
> CONFIG_BOOTMETH_RAUC_PARTITIONS. If set, a slot only counts if its
> partitions carry these names. As only GPT provides partition names,
> this also rejects MBR devices. The option is empty by default, which
> keeps the current behaviour.
> 
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>   boot/Kconfig                 | 13 +++++++++
>   boot/bootmeth_rauc.c         | 68 ++++++++++++++++++++++++++++++++++++++++----
>   doc/develop/bootstd/rauc.rst |  7 +++++
>   3 files changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 8fcdc36c931..5f89c9d86fa 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -968,6 +968,19 @@ config BOOTMETH_RAUC_PARTITIONS
>   	  The first value in pair is for the boot partition and second for the
>   	  root partition.
>   
> +config BOOTMETH_RAUC_PART_NAMES
> +	string "RAUC boot and root partition names"
> +	default ""
> +	help
> +	  Sets the expected names of the boot and root partitions of each slot,
> +	  for example "boot_a,root_a boot_b,root_b". The format is the same as
> +	  for BOOTMETH_RAUC_PARTITIONS, with names instead of indexes, and each
> +	  pair belongs to the slot at the same position.
> +
> +	  A device is only used if at least one slot's partitions carry these
> +	  names. Partition names are only available on GPT, so this rejects
> +	  MBR devices. Leave this empty to not check the names.
> +

This feels a bit redundant to me. CONFIG_BOOTMETH_RAUC_PARTITIONS is 
already a string, I think we could directly use it:
- If it contains numbers, we go with the default flow
- If it contains strings, we treat them as partition names

This would require some changes in distro_rauc_scan_parts() to iterate 
over the partitions until we find the relevant partition names, but IMHO 
the result would be more 'user friendly'.


Kind regards,
Bastien
