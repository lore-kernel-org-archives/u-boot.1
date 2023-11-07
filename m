Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464A2C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766428763E;
	Wed,  8 Nov 2023 00:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tj/R1pQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752FF8763E; Wed,  8 Nov 2023 00:18:17 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC5D8763E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-543456dbd7bso395420a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 15:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699399088; x=1700003888; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JowiHscfUZ2AH0HzZPQAo6avZBWmSIe6wmRkPlFO/xA=;
 b=Tj/R1pQbUXn0qJpt9HczFIK8hDTl+CV789w20m08b9HzPDBekGvvmVL35VVKdw7nOV
 xjd8LK5CTflT2O+Vw3cDJeoB8b4wDy8MB9uQHOL0rVmvEGaOXA7ZiSdiKRn1R88eJnW6
 TW2mQO/HYvrraYBpWIxMAjkjsjVN9BW9qS/hqcMwiXyuxzO3MEQdlV5EO5fPo80HcrIq
 OrUSgLQNISd0s9ClniDip1ZbfsYKECtZL0gav8dEjqxeLVRd3tutykPL7Ddn7ntI+KGR
 cugD2AiZusIJM2WHF/EihngJMNyxWdxkAJhXxAQJWKDmjk0a+iCps+Ji6VrHVSkbzRAi
 Bqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699399088; x=1700003888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JowiHscfUZ2AH0HzZPQAo6avZBWmSIe6wmRkPlFO/xA=;
 b=ZE8lI25habOpR0WxUkWbn+Qv24a5U5PesXG7rHv4w6JAux3XcY8ef3ONbJI2K+9mM6
 U7Yrg7ZyMXSFou2rjULY3hYxjgQBho+5tb+QcAlKG98Ca1dEzwmk8BJwfR/NY+JNFw0T
 a5vHDAtENYT0V5uOJMkOqLAFTHllfPeh7D35WzGb0TXnjDCi9GNcSWBVaGGAoEFfFrAB
 LDRT4kGiglP0Y1KTzRXhApRCBl2tBsta/Kxto8SjiB8b5ZPvhSb2dME6C6x5owA4acET
 hFgnFPp2totmJK7pYBnX1JHvsTV7oYMCOLQcThkHEUCQHNHT2hsJgxkQK3gbfK7Wh9ne
 AVxQ==
X-Gm-Message-State: AOJu0Yypa6gPFHLI0ADyIU206EFIqpW0tqee0+S8400do3Si8UKm9gMl
 ADRoOxGfBJ1AX//ax4sg4+QjmDW6hSg=
X-Google-Smtp-Source: AGHT+IEtB7jZfbdpDtvGSeRRltTMhBgs3wOKoNwint65TqLcOrxkmV3CtYTDjg5LC/QKjCvDSk4v9g==
X-Received: by 2002:a17:907:9706:b0:9ad:f60c:7287 with SMTP id
 jg6-20020a170907970600b009adf60c7287mr223232ejc.28.1699399087529; 
 Tue, 07 Nov 2023 15:18:07 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 bs12-20020a170906d1cc00b009ae3e6c342asm126756ejb.111.2023.11.07.15.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 15:18:06 -0800 (PST)
Message-ID: <c1d533e1-1d54-0fc6-1ed3-6adf8c6497e7@gmail.com>
Date: Wed, 8 Nov 2023 00:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan
 for Das U-Boot]
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Alexander Gendin <agendin@matrox.com>
References: <20231106202752.GH496310@bill-the-cat>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20231106202752.GH496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Tom, Simon,

Please have a look some comments below at 3 issues that are introduced by meself. ;)

On 11/6/23 21:27, Tom Rini wrote:
> Hey all,
> 
> Here's the latest report. I _think_ I passed the right options to
> get_maintainer.pl such that it would only look far enough back in git to
> find the likely authors (along with listed maintainers of the files).
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Nov 6, 2023 at 2:58 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to Das
> U-Boot found with Coverity Scan.
> 
> 13 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 5 defect(s), reported by Coverity Scan earlier, were marked fixed in
> the recent build analyzed by Coverity Scan.
> 
> New defect(s) Reported-by: Coverity Scan
> Showing 13 of 13 defect(s)
> 
> 
> ** CID 467411:  Memory - corruptions  (OVERRUN)
> 
> 
> ________________________________________________________________________________________________________

[..]

> *** CID 467407:  Uninitialized variables  (UNINIT)
> /drivers/scsi/scsi.c: 612 in do_scsi_scan_one()
> 606
> 607             bdesc = dev_get_uclass_plat(bdev);
> 608             bdesc->target = id;
> 609             bdesc->lun = lun;
> 610             bdesc->removable = bd.removable;
> 611             bdesc->type = bd.type;
>>>>     CID 467407:  Uninitialized variables  (UNINIT)
>>>>     Using uninitialized value "bd.bb".
> 612             bdesc->bb = bd.bb;
> 613             memcpy(&bdesc->vendor, &bd.vendor, sizeof(bd.vendor));
> 614             memcpy(&bdesc->product, &bd.product, sizeof(bd.product));
> 615             memcpy(&bdesc->revision, &bd.revision,  sizeof(bd.revision));
> 616             if (IS_ENABLED(CONFIG_SYS_BIG_ENDIAN)) {
> 617                     ata_swap_buf_le16((u16 *)&bdesc->vendor,
> sizeof(bd.vendor) / 2);
> 
> ** CID 467406:  Memory - corruptions  (OVERRUN)
> 
> 

Scsi devices are not my thing.
I'm forced to poke in drivers, because someone else is plumbing bounce buffer code to our block class.


Introduced by:
[PATCH v5 4/8] rockchip: block: blk-uclass: add bounce buffer flag to blk_desc
https://lore.kernel.org/u-boot/ee332375-8812-8e12-da1c-9973d10a41af@gmail.com/

static void scsi_init_dev_desc_priv(struct blk_desc *dev_desc)
{
[..]

#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
	dev_desc->bb = true;
#endif	/* CONFIG_BOUNCE_BUFFER */
}

[..]
	struct blk_desc bd;

	scsi_init_dev_desc_priv(&bd);

	bdesc->bb = bd.bb;
===
https://www.kernel.org/doc/html/latest/dev-tools/checkpatch.html

GLOBAL_INITIALISERS

    Global variables should not be initialized explicitly to 0 (or NULL, false, etc.). Your compiler (or rather your loader, which is responsible for zeroing out the relevant sections) automatically does it for you.
INITIALISED_STATIC

    Static variables should not be initialized explicitly to zero. Your compiler (or rather your loader) automatically does it for you.

===
I assumed that variables are always zeroed in the blk_desc structure.
The value of bb only matters if IS_ENABLED(CONFIG_BOUNCE_BUFFER).

For scsi:
	dev_desc->bb = IS_ENABLED(CONFIG_BOUNCE_BUFFER) ? true : false;

The scsi block class worked fine for years without bounce buffer. Do all scsi devices need that buffer all of a sudden? What didn't work then?

Please advise what is the best approach.

===
There is a patch in review that changes this file. Better let that go in first before changing something here. What's the status?

[PATCH] scsi: Forceably finish migration to DM_SCSI
https://lore.kernel.org/u-boot/20231028005951.1187616-1-trini@konsulko.com/

> ________________________________________________________________________________________________________

[..]

> ________________________________________________________________________________________________________
> *** CID 467402:    (CHECKED_RETURN)
> /drivers/block/rkmtd.c: 737 in rkmtd_init_plat()
> 731
> 732             debug("starting_lba           : %llu\n",
> le64_to_cpu(plat->gpt_e->starting_lba));
> 733             debug("ending_lba             : %llu\n",
> le64_to_cpu(plat->gpt_e->ending_lba));
> 734
> 735             memcpy(plat->gpt_e->partition_type_guid.b,
> &partition_basic_data_guid, 16);
> 736


>>>>     CID 467402:    (CHECKED_RETURN)
>>>>     Calling "uuid_str_to_bin" without checking return value (as is done elsewhere 9 out of 11 times).
> 737             uuid_str_to_bin(plat->uuid_part_str,
> plat->gpt_e->unique_partition_guid.b,
> 738                             UUID_STR_FORMAT_GUID);

Comment 2:

	gen_rand_uuid_str(plat->uuid_disk_str, UUID_STR_FORMAT_GUID);
	uuid_str_to_bin(plat->uuid_part_str, plat->gpt_e->unique_partition_guid.b,
			UUID_STR_FORMAT_GUID);


The function uuid_str_to_bin() gets a string from gen_rand_uuid_str() which is guarantied correct.
Checking the output is unnecessary. 
 
	if (!uuid_str_valid(uuid_str)) {
		return -EINVAL;
	}

This is more a false positive. What should we do with it?

> 739
> 740             efiname_len = sizeof(plat->gpt_e->partition_name) /
> sizeof(efi_char16_t);
> 741             dosname_len = sizeof(name);
> 742
> /drivers/block/rkmtd.c: 755 in rkmtd_init_plat()
> 749             plat->gpt_h->header_size = cpu_to_le32(sizeof(gpt_header));
> 750             plat->gpt_h->first_usable_lba = cpu_to_le64(64);
> 751             plat->gpt_h->last_usable_lba = cpu_to_le64(LBA - 34);
> 752             plat->gpt_h->num_partition_entries = cpu_to_le32(1);
> 753             plat->gpt_h->sizeof_partition_entry =
> cpu_to_le32(sizeof(gpt_entry));
> 754


>>>>     CID 467402:    (CHECKED_RETURN)
>>>>     Calling "uuid_str_to_bin" without checking return value (as is done elsewhere 9 out of 11 times).
> 755             uuid_str_to_bin(plat->uuid_disk_str, plat->gpt_h->disk_guid.b,
> 756                             UUID_STR_FORMAT_GUID);

Comment 3:
Dito as comment 2.


> 757
> 758             plat->gpt_h->partition_entry_array_crc32 = 0;
> 759             calc_crc32 = efi_crc32((const unsigned char *)plat->gpt_e,
> 760
> le32_to_cpu(plat->gpt_h->num_partition_entries) *
> 
> ** CID 467401:  Memory - corruptions  (OVERRUN)
> /drivers/firmware/scmi/sandbox-scmi_agent.c: 629 in sandbox_scmi_pwd_state_set()
> 
> 
[..]
