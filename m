Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23313606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DCrC6FWi;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.a=rsa-sha256 header.s=key1 header.b=MqTTdVDg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83E9E60AE8;
	Fri, 27 Nov 2026 15:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnuGeaSSxCS6; Fri, 27 Nov 2026 15:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8EA00608C4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795793855;
	b=V09SeldC1S0yynbPruEbFxcB7aknXVT9Ik9+Mi7GUqfOeaqBHZ3Al2KRuVYJf0Qd1KNo
	 0swj9H5qLY3HigVlgQ9Ai3GonZOMstR++GZ7xC3glu73ivEiDutCqVN4f69qp89JjHEdN
	 tFuHhBADr8Vl3qOOsUN3/n3wY661hqufT/tDhPjK5cnlDvFm4wdhDF1X2v/LUFzvB3fdf
	 aEPuTcb9rZj/XGtS8BN5fuU3lvdJughqWI8tpsO30/Mh0sF/J1BB4XJqwm+pM8z2jYku2
	 Y4+Ywlz3Vve1kPO44G5fHvg7SHifnoCYex7SjOkZ9hemdAIpG8JFKBaoZd9vs4xuo3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vVs0PJeQhLfeBYAvLynwrpW8arBl9SPuS63IHSWoF10=;
	b=OxvzuCApSciewbTutlfZSZdGlaorFewQuhEmlHRO+UxHndU/gs1vOMo8udl6xuni4gSl
	 2RWz1DwjaSixsyZ3dLy2JHWfwqbedUO6+nZx4Rq8uMIu0dN/Gb/eKu4hI2OeuKSBO6mUa
	 nSNNel1odsz6NxDSTAJLugeRh4y8NJ26e2eRuVIhTiDlnQjwmyBMILAygKtxS2nWnExxf
	 Vuyb7+Ahau3nfxThKPIy/o1ODzwKTBRziDoMQgqhsxB5QhOu4Jr8FLsLIyFaJxrBb4urn
	 FDnJs66TC6sfRm+rW53dDG+3HBGlby1fE8CGlu41P7PK4cnlBQe9ibmPS+hD9BAWtyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795793855;
	bh=vVs0PJeQhLfeBYAvLynwrpW8arBl9SPuS63IHSWoF10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DCrC6FWitlI4WH/EaVIXAAR/kVO4D5uZCm+Lju94sWLejrMfPCvuAFPmFZT20ry/s
	 3CTrW9lY+9+6fwSa2JUsuq5Isg7mKpZlh9JzArwvyKUqFyCRBJQ6fDQr+ykvwnq1+S
	 Ax+klLxmpWnX8T3HQJHg7N82yWqZJxmArKMH9urFlLRQ6k8DEzNMxchwLqcAp/T34P
	 HREhVOoiy9HFwvJXPuPC+r3+gEyQM92MmzgOQVVfYb85YOP709N725N7cjRsy58YFS
	 HtLIzfdGVVzCl1qTkZIVifZDe29llDKD+rI392bTyqmGatJOx0x3rOSirM2Fva0sh9
	 KwadtKsxuYL0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EA00608C4;
	Fri, 27 Nov 2026 15:37:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DDCDD1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F59A40A56
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nbw2xbUpRa5E for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 15:37:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AA11E40A2E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=95.215.58.179
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.179;
 helo=mta1.migadu.com; envelope-from=funderscore@postmarketos.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=MqTTdVDg
Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA11E40A2E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:37:31 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=KGxux9WBnA05NmaBVrlqQLqvx8l98R/NU17PnDFe1h0=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795793850; v=1; x=1796398650;
 b=MqTTdVDgNlLHokx/OZTbAPm121hND23hb0oqyzZaEuaOp6EAwU6vymtS4s50W5RZeRVt4Eu4
 kT3ahAQ1P4bZXLKGfSXKLV9wIXd/AMFzC8Mezf+cTfi0VcFvaiKBdMBcQu/NEnXu91t06D0ynLn
 dOcrQ/J1ZRlA1MCqdWoyZmXqdIK0aZq1eku40GR73QE1kQ6KfnRTP744W37EPTHa0RbmF4uaNog
 YeOFhBevQJ1ETl3tc9o8hr8IDREJa8OoxbEn4luoMXA5OV1vK24Wz9+cubD698uZXKNJy01tPGN
 k6jSAbc9x/FCwz2rpS/IkJIukS7w1AJdf5/uAFQtjJMtQ==
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 98b6b301330ffbea;
 Fri, 27 Nov 2026 15:37:30 +0000
X-Mizu-Trace-ID: 98b6b301330ffbea
X-Migadu-Flow: FLOW_OUT
Date: Fri, 27 Nov 2026 15:34:25 +0000
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
 <tp61ew.2jah7hm6wep6j@postmarketos.org>
In-Reply-To: <tp61ew.2jah7hm6wep6j@postmarketos.org>
Message-ID: <tp63eh.1vrvzthhsnbk9@postmarketos.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026 14:51, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
>Hi Massimo, sorry for the delay ^^
>
>On Mon, 09 Nov 2026 19:51, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
>>Hi,
>>
>>Il giorno lun 9 nov 2026 alle ore 09:01 Ferass El Hafidi ha scritto:
>>>
>>> Legacy block support is only selectable for SPL. However it is
>>> useful in TPL too, where the full block driver (with DM and whatnot)
>>> will not fit.
>>> Add a TPL_LEGACY_BLOCK kconfig option to enable legacy block support in
>>> TPL. Note that it is hidden in menuconfig (just like the SPL variant).
>>>
>>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>>> ---
>>> As I've been working on some TPL support for Amlogic I noticed that I
>>> could not choose the legacy block driver (while I could choose it for SPL).
>>> Given we only have 44K available, DM is a tight fit there so I'd rather not
>>> enable it where possible to save space.
>>>
>>> Adding the ability to select the legacy block driver in TPL seemed like
>>> a good option for the same reasons it is already available for SPL
>>> builds. And indeed it works just fine there too.
>>> ---
>>>  disk/Makefile          |  4 ++--
>>>  drivers/Makefile       |  7 ++++++-
>>>  drivers/block/Kconfig  | 12 +++++++++++-
>>>  drivers/block/Makefile |  2 +-
>>>  4 files changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/disk/Makefile b/disk/Makefile
>>> index c16876e2073..18b839f6ecd 100644
>>> --- a/disk/Makefile
>>> +++ b/disk/Makefile
>>> @@ -10,8 +10,8 @@ ifdef CONFIG_$(PHASE_)BLK
>>>  obj-$(CONFIG_$(PHASE_)PARTITIONS)  += disk-uclass.o
>>>  endif
>>>
>>> -# Must have BLK or SPL_LEGACY_BLOCK to support partitions
>>> -ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
>>> +# Must have BLK or LEGACY_BLOCK to support partitions
>>> +ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_$(PHASE_)LEGACY_BLOCK),)
>>>  obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   += part_dos.o
>>>  obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   += part_iso.o
>>>  obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   += part_efi.o
>>> diff --git a/drivers/Makefile b/drivers/Makefile
>>> index 5403206159c..989be07cd02 100644
>>> --- a/drivers/Makefile
>>> +++ b/drivers/Makefile
>>> @@ -74,7 +74,6 @@ obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
>>>  obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
>>>  obj-$(CONFIG_SPL_USB_HOST) += usb/host/
>>>  obj-$(CONFIG_SPL_SATA) += ata/ scsi/
>>> -obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>>>  obj-$(CONFIG_SPL_THERMAL) += thermal/
>>>  obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
>>>
>>> @@ -82,6 +81,12 @@ endif
>>>  endif
>>>  endif
>>>
>>> +ifdef CONFIG_XPL_BUILD
>>> +
>>> +obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) += block/
>>> +
>>> +endif
>>
>>What's the purpose of the ifdeffery? I would expect it to work with or without
>>ifdeffery exactly in the same way. If CONFIG_XPL_BUILD is not defined,
>>CONFIG_$(PHASE_)LEGACY_BLOCK becomes CONFIG_LEGACY_BLOCK which does not exists.
>>
>
>Yes, CONFIG_LEGACY_BLOCK does not exist. I believe there was a reason as
>to why the legacy block driver could not be chosen for U-Boot proper so
>I didn't question it. That's why there's this `ifdef`.
>
>Is it something you'd like me to change in the next revision?
>

I got pointed out offlist (on IRC, thanks!) that your point might've
been that the ifdef is unnecessary and can be removed for the same effect. And
indeed your feedback makes a lot more sense that way. Sorry for the
misunderstanding, I'll fix that in v2.

Thanks a lot!

Best regards,
Ferass
