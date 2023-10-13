Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1829BCDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 17:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2323386EB9;
	Fri, 13 Oct 2023 19:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lu8gJ9AI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC5A86EDF; Fri, 13 Oct 2023 19:28:38 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CD086ECA
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 19:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso363307766b.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697218064; x=1697822864; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SEmdA8s+HIEq7Jlqf903zVYCSokXInJTwxgZUduN6D0=;
 b=lu8gJ9AIurb+ZUWvy2Yhnzcw45OPdOupU8BMvP8SNjFKndFfdWpaX+GO3rYtbGhnWE
 vnUhcsbk2a77e7thgXxZOrB8S1xQ6BRpv+pwcePCHYmtS0/I6NKE+6M7TyevSPDtO5SM
 iGkoN3nXSMMnfXM7oqaWV6HyjFRIs001qUs9Sl2RIcVQVNLEKpKBoXEm9y7EyDG1+JDF
 S5g5kesVC6InnkCsMJp9oiwQ2Lc7QxON/TgDlpJUryZKBxypUCByGrmlRnWPVjpZT3Zp
 qhZnLnn5W8kJsFaUu7Vg/1yfTb0hwuwr6gKWdiK2dBV9oK6pucwz3M1GVx6J/6Knp8Zx
 ddtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697218064; x=1697822864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SEmdA8s+HIEq7Jlqf903zVYCSokXInJTwxgZUduN6D0=;
 b=JoYB2OkUNVDNpY4lL8DYlBlkTH3XdEvFJpU/gBBdX6+enEwKoBzQVahQUGHZLjClMG
 3geCZJpQRnSPVPQjuw3FCO/j+KNF9eq6Dp2iZaZsZbTqGyzKDG3kPqv62pU+x+FcDs/m
 DvgIWNCHYkYJ7JejxOamMiTGW0/5S/XXN7vPcsZbyyHrXJmftc+vszTa1850N+CHbxry
 N+12YFBX5/7ZYcuyxYY3EbHQsQRlNwppi1oHt2oMdwYs0bs8xebVXud0ICdE/+VORgFj
 75WP4boJDE8cQ3vXezm5coZ9vAykq/EsJMajko7G7Hj59FdRvxWiN/kub27HwQoMv7QX
 8FYQ==
X-Gm-Message-State: AOJu0YzuK/3DHxtVGMtylsDfy4PfALwb9hEfj975GCYNdvM92AoM9s2f
 03ZZHqZXQn/NN66i49ozYqE=
X-Google-Smtp-Source: AGHT+IGloaTffSI51vhkj0OnZQ1gHwuIdKGiAxCVKV6msZePzAOby0PMotWF7t37Cw790sLGdutWeQ==
X-Received: by 2002:a17:907:98b:b0:9be:16ba:19a8 with SMTP id
 bf11-20020a170907098b00b009be16ba19a8mr805287ejc.19.1697218063452; 
 Fri, 13 Oct 2023 10:27:43 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a1709062b0600b009ae57888718sm12545486ejg.207.2023.10.13.10.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 10:27:43 -0700 (PDT)
Message-ID: <1eb0af86-a08d-4e97-ada5-110b71a6614a@gmail.com>
Date: Fri, 13 Oct 2023 19:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/7] rockchip: dm: prepare rkmtd UCLASS
To: Simon Glass <sjg@chromium.org>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
 <94255fe4-ee9d-2e31-1bfa-d6270ebcd104@gmail.com>
 <CAPnjgZ3ANGiRecirTy7P1Sp61xWevO2PkkOq46dhW8iGDhrQ9w@mail.gmail.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <CAPnjgZ3ANGiRecirTy7P1Sp61xWevO2PkkOq46dhW8iGDhrQ9w@mail.gmail.com>
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



On 10/13/23 18:57, Simon Glass wrote:
> Hi Johan,
> 
> On Thu, 12 Oct 2023 at 13:51, Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
>> in combination with existing userspace tools and rockusb command.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>  disk/part.c                | 4 ++++
>>  drivers/block/blk-uclass.c | 1 +
>>  include/dm/uclass-id.h     | 1 +
>>  3 files changed, 6 insertions(+)
> 

> Do you have a sandbox test for this somewhere?

Maybe have a look at:
[PATCH v3 6/7] rockchip: test: dm: add rkmtd test

The CONFIG_SANDBOX is used to select as much of the driver functionality for testing without MTD driver hardware.

Config CMD_RKMTD will select RKMTD, but is not added to a sandbox_defconfig file yet.

Not sure what is preferred. Please advise what patch I should produce.

Johan

> 
>>
>> diff --git a/disk/part.c b/disk/part.c
>> index 85244b09f359..36b88205eca7 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -197,6 +197,7 @@ void dev_print(struct blk_desc *desc)
>>         case UCLASS_PVBLOCK:
>>         case UCLASS_HOST:
>>         case UCLASS_BLKMAP:
>> +       case UCLASS_RKMTD:
>>                 printf ("Vendor: %s Rev: %s Prod: %s\n",
>>                         desc->vendor,
>>                         desc->revision,
>> @@ -330,6 +331,9 @@ static void print_part_header(const char *type, struct blk_desc *desc)
>>         case UCLASS_PVBLOCK:
>>                 puts("PV BLOCK");
>>                 break;
>> +       case UCLASS_RKMTD:
>> +               puts("RKMTD");
>> +               break;
>>         case UCLASS_VIRTIO:
>>                 puts("VirtIO");
>>                 break;
>> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
>> index f126547cc7e6..30ad5bbb0024 100644
>> --- a/drivers/block/blk-uclass.c
>> +++ b/drivers/block/blk-uclass.c
>> @@ -36,6 +36,7 @@ static struct {
>>         { UCLASS_VIRTIO, "virtio" },
>>         { UCLASS_PVBLOCK, "pvblock" },
>>         { UCLASS_BLKMAP, "blkmap" },
>> +       { UCLASS_RKMTD, "rkmtd" },
>>  };
>>
>>  static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
>> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
>> index 0432c95c9edc..2fc672df0a3a 100644
>> --- a/include/dm/uclass-id.h
>> +++ b/include/dm/uclass-id.h
>> @@ -120,6 +120,7 @@ enum uclass_id {
>>         UCLASS_REGULATOR,       /* Regulator device */
>>         UCLASS_REMOTEPROC,      /* Remote Processor device */
>>         UCLASS_RESET,           /* Reset controller device */
>> +       UCLASS_RKMTD,           /* Rockchip MTD device */
>>         UCLASS_RNG,             /* Random Number Generator */
>>         UCLASS_RTC,             /* Real time clock device */
>>         UCLASS_SCMI_AGENT,      /* Interface with an SCMI server */
>> --
>> 2.39.2
>>
> 
> Regards,
> Simon
