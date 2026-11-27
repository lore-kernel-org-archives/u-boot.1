Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB1606A323
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t1ijw8uf;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.a=rsa-sha256 header.s=key1 header.b=GwgJqZt/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E5A081181;
	Fri, 27 Nov 2026 14:54:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_H2WF-jbGWR; Fri, 27 Nov 2026 14:54:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C19D8810E0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795791282;
	b=EN75ume6IKq5ZdKwF0ylBNQCllLdtKHkcRsbyVoaI2Ff5tnt5NqQqBYWO2Qv6Cjay7P0
	 ufqD1Mqd2VCmTZy68t7y0aHc/npnRNUb0j2yhDI6jPBU22sZoL5lxXjFgiZCcbka6KV0H
	 gFW3sx7bE+oxcqotCAeCHxr/VS6TtqJniHjkfLrfuQ8B1S49GT7/x3BDoxFFTjlXMzrt2
	 6RxZc7mcxh0mfXu8PMPTRbPPpfkLHDmjoNh+yWRi95yOMoQWOBOJSdl5SUHc02hgs4PCs
	 5aA6XUp1djDm+KGDh4/JiyGata0UZl8FKVvecd+EHg5KXP5R8Kasb2YcB5RSoK06fqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795791282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N9IGg1NINoLaLkJ0NonsuRIIG3542wjMAuUDvsYE5GM=;
	b=M/w44jQm6mqY0McUcjSr5Ux2vgHAw0N2OKU39I9PhmXsIgxn6zBMTg4BjguY5h3iDKEr
	 O05NcfG/kRsTOB+BjfUXLW9RjYQ6GKvIJJB3dP4D0O+wAoU+5bXbfs8mlTE/jgLUSrG2k
	 j72atqZ28ComcWemKdYrFUqypWTp47P67rPq7I/JuknSK9wwbssEcRiwCrCn4GlQzle2o
	 TbdUSAm+NjBKBbAmuau25EWssTisSStNraLf4pf6qoY3ZJHQ8tCrAHdWpvjqwFrVUg7d5
	 UnR8rF7082yxYK2ffj5d+YwZIe27ScpuEXUlvCBXk5q+BnmxMbauUttUd0KxlUQKwgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795791282;
	bh=N9IGg1NINoLaLkJ0NonsuRIIG3542wjMAuUDvsYE5GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1ijw8ufsbdZfyXwc5z+TNXGs1QMEjr7gzcKBA96DaWcN3hQFmT/fyX98FvvO9tGc
	 8gW3mfXBtOO4Vfeq9Pjzm97amgdmdB9A+vl6TFbszb+yUq2Qh0c2BHnLLmm8tlRUCR
	 kfrWA7JmodzFmbUG99Kk3loij5+GLU+UIazZecdfnyr/z3OT57Dx+I8wT5dJzol9Zw
	 jjrvadapJYEp/1YwvRbh5O736Omc/eG3OPL81LggrJOnpxwK6INd6Aul/t52+/5ThU
	 pFRJ3c0YtXw77UUrnhbh8QDEZP5siqD69g+dOOJG0jPiiHfBgvfc05aXQwgmEdxchf
	 7Uf2irDoQxJmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C19D8810E0;
	Fri, 27 Nov 2026 14:54:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E1750373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7373408A8
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZSbtICMd2jA for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 14:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C7DEF40869
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=95.215.58.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.161;
 helo=mta1.migadu.com; envelope-from=funderscore@postmarketos.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=GwgJqZt/
Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7DEF40869
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:54:36 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=p9FCbQoFjpc8AFIoNczZs+7bszMDJ7cab25GpOjNr+c=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795791274; v=1; x=1796396074;
 b=GwgJqZt/ziyXDZHDHx/ytxUZKTep+X7MhVxt+i5Dk2lvtVPTGZpjsBhRf+AYmwemoWafszg7
 jJZdWRCpWQcWJZkrztO2uH6EhiEOs9z8xeOHE0X4VAE246g8e7JTWOUbsDaqVGXsz+ro6rEuOY7
 lezxpoTfsZ8ZBSV7szymAoL8DOkI1e0zZvO6HrPP4ImOcSvuS6aT5FyddccPLmcVo5sqiyo9RUQ
 l8s/vJoFTuuS0se4a00MluY1zkat/5bL+Me+IXvYLcz1StpOaIdF0CMMBBTSNnJVyFLTYIEjsRD
 kn5n5ENM05JPjTVIXalVohvqxx2QYZIzz9aAOoXH9jNow==
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id bc52cf956747c2e8;
 Fri, 27 Nov 2026 14:54:34 +0000
X-Mizu-Trace-ID: bc52cf956747c2e8
X-Migadu-Flow: FLOW_OUT
Date: Fri, 27 Nov 2026 14:51:12 +0000
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 J=?UTF-8?B?w7Y=?=rg Sommer <joerg@jo-so.de>, Johan Jonker <jbx6244@gmail.com>,
 Denis Mukhin <dmukhin@ford.com>
Subject: Re: [PATCH] block: add legacy block support for TPL
User-Agent: meli/0.8.13
References: <20261109-legacy-block-tpl-v1-1-aeee138e9288@postmarketos.org>
 <CAC928HZLjxgkuoyMaZa8jFimiVPTGX+hkuN6dppCJeFja9axYA@mail.gmail.com>
In-Reply-To: <CAC928HZLjxgkuoyMaZa8jFimiVPTGX+hkuN6dppCJeFja9axYA@mail.gmail.com>
Message-ID: <tp61ew.2jah7hm6wep6j@postmarketos.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo, sorry for the delay ^^

On Mon, 09 Nov 2026 19:51, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
>Hi,
>
>Il giorno lun 9 nov 2026 alle ore 09:01 Ferass El Hafidi ha scritto:
>>
>> Legacy block support is only selectable for SPL. However it is
>> useful in TPL too, where the full block driver (with DM and whatnot)
>> will not fit.
>> Add a TPL_LEGACY_BLOCK kconfig option to enable legacy block support in
>> TPL. Note that it is hidden in menuconfig (just like the SPL variant).
>>
>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>> ---
>> As I've been working on some TPL support for Amlogic I noticed that I
>> could not choose the legacy block driver (while I could choose it for SPL).
>> Given we only have 44K available, DM is a tight fit there so I'd rather not
>> enable it where possible to save space.
>>
>> Adding the ability to select the legacy block driver in TPL seemed like
>> a good option for the same reasons it is already available for SPL
>> builds. And indeed it works just fine there too.
>> ---
>>  disk/Makefile          |  4 ++--
>>  drivers/Makefile       |  7 ++++++-
>>  drivers/block/Kconfig  | 12 +++++++++++-
>>  drivers/block/Makefile |  2 +-
>>  4 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/disk/Makefile b/disk/Makefile
>> index c16876e2073..18b839f6ecd 100644
>> --- a/disk/Makefile
>> +++ b/disk/Makefile
>> @@ -10,8 +10,8 @@ ifdef CONFIG_$(PHASE_)BLK
>>  obj-$(CONFIG_$(PHASE_)PARTITIONS)  += disk-uclass.o
>>  endif
>>
>> -# Must have BLK or SPL_LEGACY_BLOCK to support partitions
>> -ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
>> +# Must have BLK or LEGACY_BLOCK to support partitions
>> +ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_$(PHASE_)LEGACY_BLOCK),)
>>  obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   += part_dos.o
>>  obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   += part_iso.o
>>  obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   += part_efi.o
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 5403206159c..989be07cd02 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -74,7 +74,6 @@ obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
>>  obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
>>  obj-$(CONFIG_SPL_USB_HOST) += usb/host/
>>  obj-$(CONFIG_SPL_SATA) += ata/ scsi/
>> -obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>>  obj-$(CONFIG_SPL_THERMAL) += thermal/
>>  obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
>>
>> @@ -82,6 +81,12 @@ endif
>>  endif
>>  endif
>>
>> +ifdef CONFIG_XPL_BUILD
>> +
>> +obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) += block/
>> +
>> +endif
>
>What's the purpose of the ifdeffery? I would expect it to work with or without
>ifdeffery exactly in the same way. If CONFIG_XPL_BUILD is not defined,
>CONFIG_$(PHASE_)LEGACY_BLOCK becomes CONFIG_LEGACY_BLOCK which does not exists.
>

Yes, CONFIG_LEGACY_BLOCK does not exist. I believe there was a reason as
to why the legacy block driver could not be chosen for U-Boot proper so
I didn't question it. That's why there's this `ifdef`.

Is it something you'd like me to change in the next revision?

>> +
>>  ifdef CONFIG_TPL_BUILD
>>
>>  obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>> index d44cf4bcb6b..e6f1d82267b 100644
>> --- a/drivers/block/Kconfig
>> +++ b/drivers/block/Kconfig
>> @@ -15,7 +15,17 @@ config SPL_LEGACY_BLOCK
>>         default y if SPL_AHCI_PCI
>>         help
>>           Some devices require block support whether or not DM is enabled. This
>> -         is only supported in SPL. With this, the blk uclass is not used, but
>> +         is only supported in SPL and TPL. With this, the blk uclass is not used, but
>> +         instead a legacy implementation of block devices is used, with all
>> +         devices consisting of 'struct blk_desc' records.
>> +
>> +config TPL_LEGACY_BLOCK
>> +       bool # "Enable Legacy Block Device in TPL"
>> +       depends on TPL
>> +       default y if TPL_MMC || SCSI || NVME || IDE
>> +       help
>> +         Some devices require block support whether or not DM is enabled. This
>> +         is only supported in SPL and TPL. With this, the blk uclass is not used, but
>>           instead a legacy implementation of block devices is used, with all
>>           devices consisting of 'struct blk_desc' records.
>>
>> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
>> index c827fa81a2d..e88914db283 100644
>> --- a/drivers/block/Makefile
>> +++ b/drivers/block/Makefile
>> @@ -6,7 +6,7 @@
>>  obj-$(CONFIG_$(PHASE_)BLK) += blk-uclass.o
>>
>>  ifndef CONFIG_$(PHASE_)BLK
>> -obj-$(CONFIG_SPL_LEGACY_BLOCK) += blk_legacy.o
>> +obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) += blk_legacy.o
>
>Should we have VPL_LEGACY_BLOCK too?
>Right now, this breaks sandbox_vpl_defconfig build.

Yes, I overlooked it but yes we definitely should. I'll add it to the
next revision. Thanks for pointing it out!

Best regards,
Ferass
