Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025EED30CC0
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 20:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B20808AF;
	Tue, 13 Jan 2026 21:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V5jgMTpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C93880077; Tue, 13 Jan 2026 21:03:34 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD85830CA
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 21:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b870732cce2so424304266b.3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1768334612; x=1768939412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G9RjuEFTDqGAEVV++9QrkyJ293hWk4KEZny14qTAfeM=;
 b=V5jgMTpwzlw8xR1jf9Gp+QQ4uV1PRe78gfjD8vMicqU60pTE3G52+fZGBxznSSVs05
 XbX0LzePAsa3LIY0a+5w4OMb0u+ab71j+14JfF8MdS1BaFJd44UcEOxxnx29m5IgFCfv
 J/fPlby2Dmw/eDGL8MniF3OLeLzRBRO1etUA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768334612; x=1768939412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9RjuEFTDqGAEVV++9QrkyJ293hWk4KEZny14qTAfeM=;
 b=YhZYJPWuxlAYQb6fEiKm49wc6G0QzYi1ai5CciR7IU3+ZTrfl+kJv/NDzCI3wdKjzK
 LKMYJF8G2E2AZiqu/WKjwRi1tJdHRWLMJh+UkDa7yCfqiZ7+VcxH0n3O+j/w209w/lCP
 jntGaRuVOhde8hHV1h/248UvD2HTcgLxvX1Jqah12c8acBKo5Yd81JVPvBc7k5QWXxia
 NHQYZDA408gZKjPY6ejRaoDgRvsXBMahGrGufcD0e8nznxZHLVw0ddeeK28xb+9sFyVw
 5OtzGfX8+Bh/11RVQ2dtnqe7KK/ZuJSzXw0J213hABSC57S8ZrLoyS4etKLWAF+/aCpT
 XEOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHjtyPSmtEkMNrbImb5UESyDYURd3gAyJneZIYa5Pc8Qv7yCejOmiulLpveisPrlFvAXS9ouw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxp8F/oJXbq/L+WlHVSsscui8DLPcpTPvpp14WGXQlf7MYTWLU6
 GcFw0HL+ATrTvhLL3cQ4FvYeYug6CNukGC4aSPKvWc0158sBOYY9QmOsE4T4WstzELAoUBYvPMc
 oQ7w279PQ8CC5VVCSearOYf8PK5i57JtTEj01LJIx
X-Gm-Gg: AY/fxX48/VsC3w/g8Xp+tVZzgoVll79YkE7xBWJmFqsyJtfpYRM195kO+zQ2pdy4kbW
 LXFGKdyiyFC7UFPfAotz96mlCHF+1v0svcmsC81SHskfZNhhH5s6g41p/KoLYVGE/MxWNHuTCpY
 ORoPtrud/YvPGrUWAj7Xl6HYinMLaO/X5jN0UMpzjI7Je2kQ+nAb/0YnocI1TMRRaGQsqEND2Q7
 m1sGZYxlf+l8oBwMMg6z1FCzQcLqwXUK82dwdpnuOqs1kerlEjXmG5zOWb/IiM63wux9A==
X-Received: by 2002:a17:907:1c26:b0:b83:e7e:372b with SMTP id
 a640c23a62f3a-b8761278c8bmr23993966b.44.1768334611796; Tue, 13 Jan 2026
 12:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
 <20260109070912.4106466-2-balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260109070912.4106466-2-balaji.selvanathan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Jan 2026 13:03:11 -0700
X-Gm-Features: AZwV_Qg7YOQXDDsiSbfBrj1xgRzux0R8EgqNSrkZ8DsKXa_O11fXvWWTncBhMys
Message-ID: <CAFLszThG18XOn40gQg4ZhHd4=htJbeBdUDXBhoUTZoLEHz7mZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] disk: Add partition lookup by type GUID
 functionality
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, aswin.murugan@oss.qualcomm.com, 
 joe.hershberger@ni.com, ilias.apalodimas@linaro.org, ravi@prevas.dk, 
 quic_varada@quicinc.com, quentin.schulz@cherry.de, javier.tia@linaro.org, 
 simon.glass@canonical.com, marek.vasut+renesas@mailbox.org, 
 ansuelsmth@gmail.com, michal.simek@amd.com, mwalle@kernel.org, 
 jan.kiszka@siemens.com, javierm@redhat.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Balaji,

On Fri, 9 Jan 2026 at 00:09, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Introduce part_get_info_by_type_guid() function to enable partition
> lookup using partition type GUID. This complements the existing UUID
> lookup functionality and provides more flexible partition discovery
> mechanisms.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - No changes
>
>  disk/part.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  include/part.h | 21 +++++++++++++++++++++
>  2 files changed, 60 insertions(+)

Do you feel able to write a test for this? There is a ChromeOS image
(mmc5.img) which has a lot of GUIDs in it.

root = oftree_root(oftree_default());
node = ofnode_find_subnode(root, "mmc5");
ut_assert(ofnode_valid(node));
ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));

Then something like:

struct udevice *dev, blk;
ut_assertok(uclass_get_device_by_seq(UCLASS_MMC, &dev))
ut_assertok(blk_get_from_parent(dev, &blk));

// it would be better if your function took a struct udevice *, but
that conversion has not been completed for other functions yet, so up
to you...

struct blk_desc *desc = mmc_get_blk_desc(struct mmc *mmc)

>
> diff --git a/disk/part.c b/disk/part.c
> index 49a0fca6b89..2bc21dd66cc 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -731,6 +731,45 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>         return -ENOENT;
>  }
>
> +int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
> +                              struct disk_partition *info)
> +{
> +       struct part_driver *part_drv;
> +       int ret;
> +       int i;
> +
> +       if (!IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
> +               return -ENOENT;
> +
> +       part_drv = part_driver_lookup_type(desc);
> +       if (!part_drv)
> +               return -1;

-ENOENT ? We should not return -PERM in an open-coded way

> +
> +       if (!part_drv->get_info) {
> +               log_debug("## Driver %s does not have the get_info() method\n",
> +                         part_drv->name);
> +               return -ENOSYS;
> +       }
> +
> +       for (i = 1; i < part_drv->max_entries; i++) {
> +               ret = part_drv->get_info(desc, i, info);
> +               if (ret != 0) {

if (ret)

> +                       /*
> +                        * Partition with this index can't be obtained, but
> +                        * further partitions might be, so keep checking.
> +                        */
> +                       continue;
> +               }
> +
> +               if (!strncasecmp(type_guid, disk_partition_type_guid(info), UUID_STR_LEN)) {

long line?

> +                       /* matched */
> +                       return i;
> +               }
> +       }
> +
> +       return -ENOENT;
> +}
> +
>  /**
>   * Get partition info from device number and partition name.
>   *
> diff --git a/include/part.h b/include/part.h
> index daebbbc2e68..85457618cdf 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -327,6 +327,20 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
>  int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>                           struct disk_partition *info);
>
> +/**
> + * part_get_info_by_type_guid() - Search for a partition by type GUID
> + *                                among all available registered partitions
> + *
> + * @desc:      block device descriptor
> + * @type_guid: the specified partition type GUID
> + * @info:      the disk partition info
> + *
> + * Return: the partition number on match (starting on 1), -ENOENT on no match,
> + * otherwise error
> + */
> +int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
> +                              struct disk_partition *info);
> +
>  /**
>   * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
>   *                                         and part name, or dev number and
> @@ -404,6 +418,13 @@ static inline int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>         return -ENOENT;
>  }
>
> +static inline int part_get_info_by_type_guid(struct blk_desc *desc,
> +                                            const char *type_guid,
> +                                            struct disk_partition *info)
> +{
> +       return -ENOENT;
> +}
> +
>  static inline int
>  part_get_info_by_dev_and_name_or_num(const char *dev_iface,
>                                      const char *dev_part_str,
> --
> 2.34.1
>

Regards,
Simon
