Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE637606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I3+M5eW8;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=LvWENZFs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B732860809;
	Wed, 21 Oct 2026 02:21:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKh6s5dVbV0c; Wed, 21 Oct 2026 02:21:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E36A1607FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549296;
	b=M87/j3VAkdo48hP6AbQFkZrrjr0EstBKNgpiblAIwM0u/KRJgspipWj/6CtN6xRW4x6d
	 zTkEH6AwurPYzrYCzkb8gihb6Boz4lL0TkNbnpYE5JHP3VFGaz7usMhSDWQHwLIv9Hx0B
	 h6mGP+xCASB0q6Ivh5/WJUpk8DzqR6X/1iLODYFPTwO0K9tLnRsoOXlvm63CLS6NBbOy1
	 GmEzJGOAs8nDsq6yf57kfNnBWVq6vXmSTDuOq/UL6bq9H2wACMf3HtJlrEOM+eFgfcJII
	 02+1eE9Jp3Mog6oN154nbwseec6xd6/tnNqydNU9UJMTJxq2TNUhFRVqDQ6kNxGHXNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549296;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K6tRLQ1bbAUTDfTmOzArmWDE+diWaw/vQUkFvG53YwU=;
	b=TkPDCU/TcVyv6hf0R78SY7yI18GCtxUkcNqSU135PnX789TeKVc3GiaYecw2ZqG+B+Q3
	 asyqfIXB45ySt+CHw2yiYM3Sn4f0+ZKch8tsKU90Zm/+bs7DUZq6N6EKgqbyDMknRlCPE
	 GqcLwdCM/9ltW613+iH36ep58VxlC+UfTv93B3dhUhbFrbABl7WASt2wqV4xsKv2ZLbw7
	 0qwhrCuAe/+kql/MbM26nfVk8tAJeDJAOAdZOyCEG18rKQDB3PIoT+9aTvgcBw3xoQZ5U
	 Qaw7wlRec3rwDVYCkjYx0xo1/E8GLYBf1cPvdSzRYiWDtLe2RKSuEH7q5UyW33U6IlQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549296;
	bh=K6tRLQ1bbAUTDfTmOzArmWDE+diWaw/vQUkFvG53YwU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I3+M5eW8EDt6SZdAwHDNBkgSq3h04eGH0JKbkzTVRZQkGIE3WkyOWovWJW7D6xc3s
	 EUR1PVGnKwvYCWs/wtqaYL62vUk1792GMgJ5Y2W3e1a4EuBhNLdH9flkSb0/cW4eRJ
	 FYBKAWu9yNHOFPxKIOGRa89sVfOwfo1D6cu6Jd52tCpVweOFbFN2zpitCc2PvjVhkr
	 fDQazBOMspHDXYzLB8IJpo6dzUrnm5M86meifFAVhZdRSJSZq/HDkWheckpKQQx6L8
	 sZnF4BA3RfecUL4c6wC8AVMBx+VCk+J8nAEvZjgukQNUxR8Wwpy/5pnWySKynwA/Kd
	 Xiv9vEVBDUM6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E36A1607FD;
	Wed, 21 Oct 2026 02:21:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FF88380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05BEC81086
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOljz0o7bmCN for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:21:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC9AD80F90
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792549293;
 b=h/H+7CYsx+KalRCrVhQ4plgr+GEGdxf0OOHBD9ks/c9vwIWVBSGZg081mLlNAJPWAzWs
 R8WKwlOXHoEUuhQ+OPzrnb+z6VFTG2r1QESgcw1e0EpwvqAaj/J+V6E7wmlqtHlb3MSvL
 1rAM/FOQSKhYIH6QmCBcbHyS1Ov1rO+GPhzD1Uubuq7cmwRiW8ILxRp/PyDyaUQo5sr4k
 gd409SX0VFXOVq0ccRhjnSoGF2hXjXKsnkDxNmr9SC+PLlhAQZTextN28tx5l6WM281RX
 fP1i28omGQe9Cf5JIKXLg1rlWsW/vgwn7Ee7foTuadAuc2YK8ep+YbyZLZZhrCpDXFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549293;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=K6tRLQ1bbAUTDfTmOzArmWDE+diWaw/vQUkFvG53YwU=;
 b=P9HLVwAIqRA40CO699qRkfu+D/XuSBYclGCiSL/y6XcewUVeK0hm24FYNeYObKUAY538
 1I/6jkj76MsJhz+MrlloOEAnIXozVuNgDLeZFPrNCC/xsi9XgQIEpDBAELt3OkAyooXwZ
 uYoJKsHg9ycMF4Ir5t8wuw2nF/vlvAJxCh6NlN/0bWaITlgjxMwuY3obx0hXmtrUkCF26
 /PpWdTiVV+ZyX4/r2COPxtL9xk+7xIL2DI9e4FeBF3SyF6b0GSxdKlqr4mhqpLoRrpXzw
 XNjHcJg1iIp1HQYcr5YzCllBVCj26VK7R391b1vniL9Yl9sW6+QKRUzKVJeJqmhVKIg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=LvWENZFs; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=LvWENZFs
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC9AD80F90
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:32 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j8Y1j0wsrzKwBn;
 Wed, 21 Oct 2026 04:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792549289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6tRLQ1bbAUTDfTmOzArmWDE+diWaw/vQUkFvG53YwU=;
 b=LvWENZFsTkAUDysEGWNghOXH8W7oIcGBlVoKX2B/hHasENav9u+3osl5Ul0Dr2rrBwMd+4
 pAdPH6CS73jrbNzJJQNxDxOkPUUYDBcXOWskH9NRImhqfDxBy0wKuHZqDRaMUv5OPhHDb/
 Uw2F6sKyrKUTBdA3BURlJhmRGmSNYv09WEdDDnb18KghQmKhlbEUJmCIM0JrwyuUb1nDeS
 KFlDNxvlvuLAgDaLPKtgE3vnIdRUJXVoBa1xH89dn3oed91izJJOn0N+RmnGZsGOPOeXWU
 On4tfzcZ1oqP3vqp2tCm1NcEVuYDMse2CeR33hcLW+U674zzuLosHfLTWu540g==
Message-ID: <d4d51106-fb6a-48de-9e94-d41ff9119c7f@mailbox.org>
Date: Tue, 20 Oct 2026 14:45:07 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: socfpga_de10_standard: Fix raw partition booting
 from SDMMC
To: Nimesh Acharya <nimeshacharya197@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261019205932.28038-1-nimeshacharya197@gmail.com>
 <097d4df2-1142-4eaf-b23d-60f2f4e291cf@mailbox.org>
 <CAMb=oEaXycpsLz6wfxKVqucox+ZuJumMgaz3Q=+dfD8R3o804g@mail.gmail.com>
 <4030a7f1-c924-4d51-bf93-eaaaf8df2ed0@mailbox.org>
 <CAMb=oEYbdBJbQ-sjZ5q5YDXSjgH3j5PdM11smGXxqgGw-e7QQw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMb=oEYbdBJbQ-sjZ5q5YDXSjgH3j5PdM11smGXxqgGw-e7QQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5ad57e6d5df59fa5811
X-MBO-RS-META: djwptk1p5n7fffn44bh77i7179k5cw4c
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 1:44 PM, Nimesh Acharya wrote:
> On Tue, Oct 20, 2026 at 4:14 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
> 
>> On 10/20/26 10:35 AM, Nimesh Acharya wrote:
>>> Thanks for bringing that up. In fact, on running grep -E
>>>
>> 'SPL_FS_LOAD_PAYLOAD_NAME|MMCSD_FS_BOOT_PARTITION|MMCSD_RAW_MODE|SPL_FS_FAT|SPL_FS_EXT4|SPL_LOAD_FIT|SPL_RAW_IMAGE'
>>> $B/*/.config
>>>
>>> I get this output for the default config:
>>>
>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2
>>> # CONFIG_SPL_FS_FAT is not set
>>> # CONFIG_SPL_LOAD_FIT is not set
>>> CONFIG_SPL_RAW_IMAGE_SUPPORT=y
>>> CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>>> # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set
>>> # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is not set
>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x0
>>> # CONFIG_SPL_FS_EXT4 is not set
>>> CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=1
>>>
>>> So, me adding CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2 again
>> is
>>> indeed redundant. I'll fix this soon.
>> Please stop top-posting.
>>
>> Is CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y the only option
>> you have to add ?
>>
>> In any case, please do a V2 and make sure the
>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is in the right
>> place in the defconfig, not at the end.
>>
> 
> Both, CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y and
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x200 are to be added.

OK

> Both of these values are not visibly set in
> configs/socfpga_de10_standard_defconfig
> nor arch/arm/mach-socfpga/Kconfig in the main branch. The meta-intel-fpga
> layer in Yocto does not set these either, however
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x0 seems to be set by
> default (as seen from the .config) which makes the default OE build
> non-bootable.
> 
> The requested change is required to have a bootable system, and has been
> verified on the board.
> 
> Sorry for top-posting and sending V2 too soon.
Please send a V3, thanks !
