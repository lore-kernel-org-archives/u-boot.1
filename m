Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C34AF5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D55842B7;
	Tue, 21 Apr 2026 00:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="nXYIQvP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9707383E36; Tue, 21 Apr 2026 00:38:51 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7389B83E36
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dca4debedaso2403559a34.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776724728; x=1777329528;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/RB9RMRaDxx7s1qZ75mJIUAMl9ALQn4/WiErSvf5DRc=;
 b=nXYIQvP1XtwAnTV1lwpvrhhoaaqJhELz9ljE2Jaq9cUvhdYVkTZW+vG5S/lM+0F84W
 Lx15O3T4PAX3lAJ0KJDPByYalgU9iueV/NfBXUXRLq9zRpYSsNI6HzIFbIYWh/USh/VQ
 yKyTxneLh4O52fG/d7fnfGx9V87D8ZEbmU83euQU8GKpws5wSaqvuBBa0PcxgGhw15x0
 RJEXonMGyoymJ/cg/I+9qRa9wD/88l0+CyJOXDpiYhTIyOUBAR81swYD9WzHHdJh2Gxj
 LI6mvYtPm8fv/+g2K8MfMsT5cdUIeBQ19DZ7rOG85IPHCcqz6u7C6Dd07gnZyXhDKR2r
 1UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724728; x=1777329528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RB9RMRaDxx7s1qZ75mJIUAMl9ALQn4/WiErSvf5DRc=;
 b=AosjuiM7LRWjT0mTMVZm22MczfpYTjzm2drb8uVUI1IZ6gJ6GHZsxBKABF9WWCQuu9
 /a7rLg7Hi/ptzJNKJzU+dzBGj/zmg3ePWb/lXMvpgzE3T3VObx0wJEdzykQEwsYwsOF+
 iCxXBYtaqCN8RrcDGb7M5By3iwLoSakyQG/ccnRr9yij6xUgE5RYJ436W3ZpQYWcyR2e
 MMElNQ93+PjXamo+QZcu7Pvd4yZ13meQljtkyuG/RgT18QTHrfKzHbgMd0kqNOw3Wph6
 BaQNfHiGj00hPEEtG+7/IQp6wsIH9r9+PhTYx6mJ38aDvAlEl7rFMBbyRIO0OUcusms+
 8EYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/q5waq2LfOc5Mj8shrJY4Ecp0e/wDWdTMtr15mylgA5xRSkTmUHOi4B+cZyFvsraYq/+sMWA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxexs/PkKcKYRPRIRkOEIJyV0e5uyRKcJ7QImaY76AGXCAniL1r
 QcdGVv9H3cQYnqGz19KWHtEKcjkT8JAsI2VDnAlSSmiEAuely1u077uQPkfXNs5TSenslpWTpEf
 G3Awr
X-Gm-Gg: AeBDiesyVkGR0Uw9wx8y7kvDVzjoIk5teo8ntNWScF4WoaIft8YVmUDVHioxSacArMY
 bCFH0P3wHDDPLuOHfnkCOwv0f6sS7TC3dP+h8rcUqznw82MQeX4uSiV/IXZidGktm6plOTXkYde
 aK6rveYcfGm9NmMfrNcJLUAvu6Xa7FVZm05yKSUXfkgKYmlujpOaRsB8D70TQvGp6uafvpJAXsP
 3uJXSo+RMH8RI83GH1eJU6NOglGkqqB3NQZQjBBacAgJdFlekvaLZ33aUsX7E/GqcDD6/Z2L79O
 +J/6LU5LlabioPj7isqy4NWlCjIlwwfFFqUNVnCRpjILyhC17e1eeVFp0nEvdbxVMMV2XbVgVcr
 UqCMgXvDsP+wMUzBBBsAohpICEbzY2+WpMPgMHwTmrNcEpAsl0uoQccXj7xUG40RFzYjYm9shHK
 vXdjfUbmvTRbSJRMWxyx8Wui6QaP9Xg53w8gT3X0mbupZ2KgTlILVH73Xuf2D8UqvQ1gOieG6Lx
 xUVyZWSYbjz
X-Received: by 2002:a05:6820:4b02:b0:694:92fe:54f2 with SMTP id
 006d021491bc7-69492fe5782mr1564521eaf.56.1776724728131; 
 Mon, 20 Apr 2026 15:38:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:49fb:b337:a968:94e7?
 ([2600:8803:e7e4:500:49fb:b337:a968:94e7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69493183021sm882258eaf.13.2026.04.20.15.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 15:38:46 -0700 (PDT)
Message-ID: <fb7272ae-26b7-4f98-817b-13fb821bb0aa@baylibre.com>
Date: Mon, 20 Apr 2026 17:38:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] scsi: Add partition lookup by type GUID for SCSI
 devices
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Jerome Forissier <jerome.forissier@arm.com>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
 <20260419-type-v3-2-ec49acd6870e@oss.qualcomm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260419-type-v3-2-ec49acd6870e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/19/26 5:24 AM, Balaji Selvanathan wrote:
> Introduce scsi_get_blk_by_type_guid() function to enable SCSI
> partition discovery using partition type GUID. This function scans
> all available SCSI devices and searches for a partition matching the
> specified type GUID.
> 
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - No changes
> 
> Changes in v2:
> - Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
> ---
>  drivers/scsi/scsi-uclass.c | 28 ++++++++++++++++++++++++++--
>  include/scsi.h             | 11 +++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> index 39b4c7476d4..031dc01b9de 100644
> --- a/drivers/scsi/scsi-uclass.c
> +++ b/drivers/scsi/scsi-uclass.c
> @@ -30,9 +30,10 @@ int scsi_get_blk_by_uuid(const char *uuid,
>  			 struct disk_partition *part_info_ptr)
>  {
>  	struct blk_desc *blk;
> -	int i, ret;
> +	int i, ret, max;
>  
> -	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
> +	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
> +	for (i = 0; i < max; i++) {
>  		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
>  		if (ret)
>  			continue;

Changing scsi_get_blk_by_uuid() looks like an unrelated change.

