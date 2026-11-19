Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC406606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QgzYZwqT;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JkEDIAuH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADB4A8148A;
	Thu, 19 Nov 2026 17:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZjljENKuWhw; Thu, 19 Nov 2026 17:02:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E91A98144E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107763;
	b=A0XrcenUSkyrOl5+vCeCR7rdyEEIt0WIXDnv9TRPanlr2a4Ku6eDgs9itFY7ZCNHjU1w
	 YpQ82NOTdlNXdJl0UMBBYY9n/WQ8GYmPlXiaF+zfK+m6boA6Q66FtEvcJ3/r3+Kayl8+2
	 KAv/J9RuEq5yjU6tKeLyVHudcXaW+jAR5A1AS0QF7gydkxOQAyiYjyxlP7Ptz8ybWi0ND
	 yvUrB7Yr4iPgeElajEbAm1yjNF7EFszDCEu42hkA4S70iqQ5toTs93p/9arQ/FjzK363u
	 iePfIJnMGZYIMX48U7dblkn3oeovP1GneLdPNxuBImGTBbvPbKnQn4Sl2S5RzrOw85A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yxJ9wh8GpvDvOCLvHQVbKSJugjGbyRqGh8Ir4rXDurY=;
	b=kKvJY/Axl1a/snuEpItS0QGsmvpmv48N2SwrtoM0u4mZp6SoEGiykzwRFDKHGEggFGH/
	 EGw/yiPTRNmyy5OIlo4RXSa/YDIuzDu06twuIpVQhropBywOaaCVH5ASH3PXSYPuVlh87
	 1hpFbXPt1RM3w3tGpFaTQtRSdkDocWRr/GP0VmU0E39bza/t0AD/8c8c5tv808q4paUVR
	 QAnBtXafw2SNIl9XMc23gnMS1FBufPd8kZ4o2pNMNnXOr/2hJlsutBK2NiET54LwzzakA
	 B6am82C7o0o+UU18eaQcgQuKl5AFVIxvKwqYCVgckczhK7nxAmIzbl73cyRluDV07Ww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795107763;
	bh=yxJ9wh8GpvDvOCLvHQVbKSJugjGbyRqGh8Ir4rXDurY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QgzYZwqTsjtlGHEFpddAgVUfaUr5ATlh4kTJg/GgF3QPfA4X7Ow5sMGtlfWhuzu/e
	 YkYfSullDFlzlHarPd3QaVE2Xm4wdBBuP/D1ral14R2fsayiK+H3DTMPw6/Y3wRZeK
	 H1g5CUzUiGGMlaHSXs9xntp1/R9OGL8xTEGzx6Y5n/Qk/ZteT/H5wjrmoAb4cDJZo0
	 AIV1APSzR8ZiiawDVc53zQJDTtfhDWplJs/ss9RtfmfeeyJvYrY5OTIr74e9a5RjDb
	 Ew72AYGMBeGYZC4LPNVNBoHYJrepAIZLpcfB9bnYJiKOYyiV1HptvEIbCcw/Bj2rhX
	 +DZZ1FFvmaC/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E91A98144E;
	Thu, 19 Nov 2026 17:02:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A53622B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2121C401C8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CRnVno0HnvBR for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:02:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5235F40180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JkEDIAuH
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5235F40180
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:37 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6d68de53053so1768084eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795107757; x=1795712557;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yxJ9wh8GpvDvOCLvHQVbKSJugjGbyRqGh8Ir4rXDurY=;
 b=JkEDIAuHC165aWhVWc/428AAWqZtY3foC+kfbRIr6O4a9bBBWpWBvDUU63UqC6/fIl
 jqLfzotsH0RbdogA0WcIwFkBiXbXi/6X3VGXBJeqLNs+K/OLx+tJA8EIkK9uaoBRfrah
 zv6Td14pefNaYSXrnAmfcLYq1JnrKe2E9LBSUndOnz1UGIFNf231gUnKXYDUihsAYv2v
 fUgdrmdnaX2rcLRqD5oZBEqTXXo88JJn7Zdo33aSxxTSPRaa9bkvD42q/3igRzw1TKWR
 kD/UpvsislxlgmegEWnOnAu0gGLUnu/fam28sp7zTugT052qT9UgqhMm2SAgJ4OJ3OBY
 CFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107757; x=1795712557;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yxJ9wh8GpvDvOCLvHQVbKSJugjGbyRqGh8Ir4rXDurY=;
 b=RuHlolru+PTC5Jqtqed4efQYcbWs4+8e2wY90uUtwFQThcRRaSQy/or/n5Mt9tLE5V
 jNABPqDbAO/5QOfpmvhLAKHwVmvoKypdVg8dB+KOSkjJ4QzlHbboZjHsDCo4WEIaxyuX
 e6LeOy+WvjZayykSKiVpnaI3PHeXlG+pjtgL2/uKKkj2AZDiuSL/VqotVD3xmyT79QT+
 huyrpdGW4a6MlnRMce6rWuIEJOv9UdDgOaKRvfRZa7QHq+VDB2qMx8+B6gT8UJ8T7BnX
 THf2ZmzmxCIL0seN3VXe5t7fgenf/Eu7aXIuM9UK46LrnivWoRDopOYNtcqLcpd3/hnL
 WMVA==
X-Forwarded-Encrypted: i=1;
 AL+hErFlwUva3ehc216XkLjGyz/nz4f/kY7nge8TKXXhLwudaClP/T1SsL1l5hOIsBBwzguu85dWUec=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8IJAk94eey4PmbTis8HZxD7tgynt6BdEe7+R4CqtMjM9lbAZLz
 4pk386lclB47FAvhUpIMvP3oesvKKeMBB92K4JK4XKq9yosaQo3MnfdAt1+hoScj94slbyci//s
 r1bMH
X-Gm-Gg: AYBFou2WxQNe64YFwtyd0nXtQdvFYqQbbEIzHGJgHRk8DdbGIIQybxvBmszB6a1LJCx
 hPWcFoYq6pxjioE79r9XCeYft5KaTJAAp3ylac80rCoJkrn5rRsz73pB+z1hQdoyqgUh5AohJhW
 56qRLss/eB//j4FvbbOp5AvPxxlWdpM+wryLkTjODJy+S8bPFZObVmZ0M2w5pMJFnNZ9ICH4arY
 NF96ELGeIlSb8QkUJPbT1p2SS6v8dcsT3GZV6jEUQO0koB4ftdOti2pODFJKV+qNq/oAw8X3Y2U
 DOwv/nTwn8bWCehfMcV1PzN+rNsUB5TFbHR/tEtsyByg01LcfAJG7iazgCkUyxEGZ9pA1ix49LL
 jc0/D9WumpfcE5N5Ax4C82hzpxNUl0CdBkvRor3gpiWT6Hz2nRS2LT+908XdEB7Mf2kuKHQM8o0
 xT/O6VUn9ljUsoLAm6Kn930GTVyECgFla7J5FsfpkYGQ8rmHi55hyR80uYDzFeRiEkJoGVovDiX
 e9iSFoYLqbtjG2ooGNWikS6g/yIG0HramzTBb34NMjakAfVVYsm6IVgFe8KBt1T8usf70mwaSfS
 CKr837UrMItWtIsoRmTpQTirEcupUo0fkw==
X-Received: by 2002:a05:6820:3383:20b0:71a:f253:8ac9 with SMTP id
 006d021491bc7-71b39581b62mr107878eaf.78.1795107756820; 
 Thu, 19 Nov 2026 09:02:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380e4a6dsm381290eaf.13.2026.11.19.09.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:02:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 6/6] doc: fastboot: Document block device selection
 syntax
From: David Lechner <dlechner@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20261115-fb_gpt-v3-6-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-6-7ddd7ef832f6@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 11:01:50 -0600
Message-Id: <179510771079.2216103.2835646029655280990.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2/kSqaERrfaKbO2gtDvKBX2rdpQZ7nsA2KfP0s2F9jo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/yufQaQMFvN+CIoHo+yNG2AP91neXPPRqYIvY
 KM71jKObbmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav8rnxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWQQIAJFSQ6faMCwnbSjpHvbTkbwPMam9ObNhSUgd3Jd
 65ZVb3IprWT4UZ04OK45ETNz+oxSkNIcrgX2oU+fKh0g4+9L1J7p2v4HfKyN/mYdb2iqFb18rPK
 wTgVR85B5KD38/Vyeh9b1iPXSDFZp1Xtw27OEfY99xUn9fDg6lyRRxq767go82Y71+8phR4v3l6
 VEyrbvieXMwlvihwAI4/9lGVlU9jiuPTV5Dh1PkSDeCwQHW5vXxtEKRYHyzjoXndAJdcTUDK7Em
 P5Y9idvJ9z7Dg2/HeyZ3bi7bDluabEJDwZRKryhOTjZyP6mt4f09i5bxvaryTG8aO8B6h+m/gmb
 dnWQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Document how the block backend selects a device: a partition name is
> looked up on CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID first, then parsed
> as "<dev>#<partname>" or "<dev>:<partnum>". Add examples for flash and
> erase, and note that "<dev>#gpt" and "<dev>#mbr" select the device for
> partition table updates.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Document "<dev>#<partname>" and "<dev>:<partnum>" instead of
>   "<dev>:<partname>"
> - Use sentence case for the new headings
> - Cut the duplicated GPT/MBR text down to one "1#gpt" example
> - Mention erase and the partition-size variable, which use the same
>   lookup
> - Drop Mattijs's Reviewed-by since the documented syntax changed
> 
> Changes in v2:
> - No changes
> ---
>  doc/android/fastboot.rst | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 8e15f287f9b..404ebfe5f54 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -195,6 +195,33 @@ The Fastboot implementation in U-Boot allows to write images into disk
>  partitions. Target partitions are referred on the host computer by
>  their names.
>  
> +Device selection for block devices
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +When using ``FASTBOOT_FLASH_BLOCK``, a partition is first looked up by name on
> +the device set by ``CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID``. If it is not found
> +there, the name is parsed in the same way as by other U-Boot disk commands::
> +
> +    <dev>#<partition name>      # partition selected by name
> +    <dev>:<partition number>    # partition selected by number
> +
> +``<dev>`` is the device number on the interface set by
> +``CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME``. It is parsed as hexadecimal, as
> +in other disk commands, so ``10`` is device 16. It can be followed by
> +``.<hwpart>`` to select a hardware partition, e.g. an eMMC boot partition.
> +
> +Examples::
> +
> +    fastboot flash boot boot.img          # partition "boot" on the default device
> +    fastboot flash 1#boot boot.img        # partition "boot" on device 1
> +    fastboot erase 1:3                    # partition 3 on device 1
> +
> +The same syntax applies to ``flash``, ``erase`` and the ``partition-size``
> +variable.
> +
> +Partition name formats
> +^^^^^^^^^^^^^^^^^^^^^^
> +
>  For GPT/EFI the respective partition name is used.
>  
>  For MBR the partitions are referred by generic names according to the

The end of this "Partition name formats" section says:

  The interface is always ``mmc``.

I don't think that is true now, so we should fix up that part too.

-- 
David Lechner <dlechner@baylibre.com>
