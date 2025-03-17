Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E665BC28B2F
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 01:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8BA1801DE;
	Mon, 17 Mar 2025 02:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742176257;
	bh=4LN0mIUXTRNfZJy9BGSRwtB63WXwyyCvXu3+g18smQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OFH8yAJhFZL2X00S1VXMMX1t2Me0VFEonUGbUrZyq+wBbuu0MWFq9bPlIC2FLZNVh
	 15oCl7flROfmKCJA8duphUHSNlClagSb/wh/PNAZRKhNoXpMpRYq0e2IMZyOThb2T+
	 97EJbAUBKaEzvF8n9UCV+hQMwSJX0ny83VM4RF2xAHp3OWuh6sElOytZR85a3d8XNo
	 KDHd7Pre4yhl8zuBbeiLc0oBfA9HSrFT3sXGYMSzOHM8ddjXBRl/7iM+qlKAzATAEf
	 t8o50yELG8QWeHDjt2jRuiR6OCUXSxhZ8xdM1VfesfgrHsMKw/NHQKlQuy3V6ejwU/
	 yOUWXttu0RqZg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575C28058A; Mon, 17 Mar 2025 02:50:56 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D65800C1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 02:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="M7yP40Dr"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B0A71101F7A32; Mon, 17 Mar 2025 02:50:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742176253; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=4LN0mIUXTRNfZJy9BGSRwtB63WXwyyCvXu3+g18smQY=;
 b=M7yP40DrP7eaL1YClOoHirt0Wzt9/st86NtSR1RO8t9Dx1ipsXxVkrVNVgDGktKPKBg+T5
 D2CurdZG9lgWYb6d+WjQkW//Nk+UsmjShtVRevnj8/TkbcdhfAZoBxqp9PCoH01DR19O+1
 ENCXQa7lM6EnIsyaSvvPV8VdMRLO/81ISfT+JGAJetXr2OCBmkBLbQMNyUy5CG6bqUw5Vz
 BkxBjkimWWElNKBchPk2deB7G9zGojy7AjRLPPkHDhryZ6cj40CZTLKKEnwcKUfwrcTKSn
 wDWzLTo2nD56WVELIE8zT6yG+fg23DXN83XvcanoXcJXRA4yD6JZXF5UfgQMdw==
Message-ID: <eb7ab28b-ef10-4dd2-9611-2a9d384c3657@denx.de>
Date: Mon, 17 Mar 2025 02:04:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] test_fs: Add exfat tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250313191348.170054-1-marex@denx.de>
 <20250313191348.170054-12-marex@denx.de>
 <20250314142752.GN2640854@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250314142752.GN2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/14/25 3:27 PM, Tom Rini wrote:
> On Thu, Mar 13, 2025 at 08:13:27PM +0100, Marek Vasut wrote:
> 
>> Add tests for the exfat filesystem. These tests are largely an
>> extension of the FS_GENERIC tests with the following notable
>> exceptions.
>>
>> The filesystem image for exfat tests is generated using combination
>> of exfatprogs mkfs.exfat and python fattools. The fattols are capable
>> of generating exfat filesystem images too, but this is not used, the
>> fattools are only used as a replacement for dosfstools 'mcopy' and
>> 'mdir', which are used to insert files and directories into existing
>> fatfs images and list existing fatfs images respectively, without the
>> need for superuser access to mount such images.
>>
>> The exfat filesystem has no filesystem specific command, there is only
>> the generic filesystem command interface, therefore check_ubconfig()
>> has to special case exfat and skip check for CONFIG_CMD_EXFAT and
>> instead check for CONFIG_FS_EXFAT.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
> [snip]
>> diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/test_fs/fstest_helpers.py
>> index c1447b4d43e..8f2e1fcf47d 100644
>> --- a/test/py/tests/test_fs/fstest_helpers.py
>> +++ b/test/py/tests/test_fs/fstest_helpers.py
>> @@ -9,6 +9,8 @@ def assert_fs_integrity(fs_type, fs_img):
>>       try:
>>           if fs_type == 'ext4':
>>               check_call('fsck.ext4 -n -f %s' % fs_img, shell=True)
>> +        if fs_type == 'exfat':
>> +            check_call('fsck.exfat -n %s' % fs_img, shell=True)
>>           elif fs_type in ['fat12', 'fat16', 'fat32']:
>>               check_call('fsck.fat -n %s' % fs_img, shell=True)
>>       except CalledProcessError:
> 
> This should be elif not if? Not a big deal if there's nothing else
> needing a v3 however. Everything else looks good, thanks.
Yes, it should be elif . Unfortunately, there is now a clean up change 
in next which modifies test/py/tests/test_fs/test_basic.py and conflicts 
badly with 3/11 in this series, so I need to carefully rebase that patch 
on top of current next. I'll send V3 once it is done.
