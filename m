Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D2606A336
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JQbNCe0/;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6Xgx1G1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D7BB408FB;
	Thu, 22 Oct 2026 09:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXPcFhUEIu04; Thu, 22 Oct 2026 09:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A0DCA405B5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792660569;
	b=GrdZ8YbVAWnadamXf6pbnPQtz9jagFGRuTJXcRbkIDgyM4Ghe5gz2jW2udIfLC2Qfdw7
	 8qF8Jr6agvTyvQwALaYCNNMTHlMaW8U7hRHlBR30W/MjDVvSN2EohDqUZyko93YhGFIcr
	 xxhAt3aZ+Nu8lZgXaCO1BjZ1hoMHbx4DFfryYrxherLG2+IjqyKmMMpW8G/IFaNTSowm7
	 kxiM+vRpRmgZSonPlopwQGMBqe4GhVRdcP5bQnCIojoSqO5nvHRTww9i+S/zfn+FxFeD2
	 AbtE9slZlO5F9YvYJFHLE6hufYiWPxq0us38za8LecsyipvCH1KKU8Xj9/0M9rLFQuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792660569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Moeiaca9TrJgKPF3vdDu+gOBg/nMdaY/NcEcEVfsw6s=;
	b=bomYIGeqemHirWZH9tGS0r+ns0u9WuT+kOi9H5pk19EiO2KiOX81+t9hZOzQiEwvaHC4
	 BWFErlvdPq1e1ksjak8Xn/MOcho1DuZb2MYoGtPxAO48IRjjCNbiHNTSDBqZf/PaiBfRS
	 FhyQF1sWavff3tEGEngnXQM68nMuaY0LsIDVdCaV8K4wxfJHBjg4IyO9VsQ/maYMkYkRc
	 Sd3W/M4YB8ZeJMbpo3zxo0nIe1W6HTWaW2HFT6ABNUFiodtsOqYBdAzWLGoSLnJ/V8p9k
	 cYIBBHhFLxesBQfBHFPxNonIEtpeANS2plfn/7Bsglihoi8fZQHdWjWCeFr/TK1wzlg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792660569;
	bh=Moeiaca9TrJgKPF3vdDu+gOBg/nMdaY/NcEcEVfsw6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JQbNCe0/JmJw08h7FvpGqlkzrLsgJpcjUAksRLSTm2G1aH/th8oN2rqflB0e05zHm
	 XR2+Sx6zsphs4Tduh8awNPfJ5cEkX93TgEU3aBzjb1eGzd1B0K9f2Wiw10USksNamY
	 O9hQ9aFZBvQ+Haq/i1eJL/VQeGnaQW6zadhQb8dFpW122lxnsCa3PHF77nwkKmbYZE
	 9zN9sWNiYsZJ5gSd4IlYX5U5lWXHyf9IpssHCD/eozyO4mOCuGiJr7Dq4Ja9AmDomq
	 V1K3CB+1wbxYWkCWqcikr9oiprDflREgrqp40ZVlqFYyAnL6rdlyfgrDFqzaE5EfXg
	 fZXDgyWmeVe7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0DCA405B5;
	Thu, 22 Oct 2026 09:16:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 985601AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A2998120E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C9bozLI1uepc for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 09:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 86EFA81209
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792660566;
 b=k4BN94DPUd3rIhPDdsCsOz6DhLLn/2Fs6f4HV152Ffe/n4ObQs06QwEX7YXceN9Nko93
 Sz98CytG6Kk9zrHg7VfQ3xpLuviJNtha4dAjyq4OvTeyJzjc3Xgh/tNiuinf/U69br2ce
 wxDM5TvCUE/fFj1cd+RArt7a07KXw2J4dA74OiOxXxtvkk1xkgzGvc6D1KVy+mtQzgeoN
 0NTscHGkhafXzhKG4ty5+y6H21yUDKwjuSzci6g8bFdAh3zMgylrtu9Q65xTarc6sK8/N
 Qn76A/7ZqIQkY18LZeE4XALvKZLBZSNMkn1n+qlnCStHLjodwfJVkYMHpiafw0KeVXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792660566;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=Moeiaca9TrJgKPF3vdDu+gOBg/nMdaY/NcEcEVfsw6s=;
 b=NkJFd7ctThf6AZDMeYrgKlCVf0PTndlq4Mtwf9yIQwzHRzSbGGuIExk7cYkSewltlDRB
 P6nHZNYi/Is7zSQpHBYOCvzpGPtzsS2i+AKQ1/wQssgAES/pD0pFKvaRfr4wKdbGWIxin
 ZUFVA3pNBBF/oSzgh67TYZipsoNNbA1GLm8yqnwlJfduwUrM5ojYXncCf9LzlmpFDsb3T
 9knHzfbNRYeqGoX4nf6XCEMXtJUoyqfso6lm8M9OrOpZz8C9nSBQydUzI8dpOTmQYf1jz
 4f/jTGKZRlQijIf7oyI63zq5KJALabRU4sX1NuoCSYrbSLLckfw2xtQEcoC8SRQCIEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j6Xgx1G1; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j6Xgx1G1
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86EFA81209
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 179C560DC9;
 Thu, 22 Oct 2026 09:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BF31F000C1;
 Thu, 22 Oct 2026 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792660563;
 bh=Moeiaca9TrJgKPF3vdDu+gOBg/nMdaY/NcEcEVfsw6s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=j6Xgx1G1AxL6SUoN7LPMat0QTE+a4GRKeERcRmAsRrvmaY6XHX6waWmqKMUegevA3
 BM6N/cxll5MasNA49H1brEOMcqNpiXiPedaQU763vwlau7nLwa86QBq19+LpCCdYyI
 qyRd0FptQqozpqCe/ETQf2rsMZ/8s7QTXsXhePwJQqo8UBSgcGv0Bik6AJiBVkzBf7
 z4IqEwWJRxPS9n98kCd95b44mRchg2Dy4+1or3lTG9Hyf7yJuyUdK+CrWNcz7/rGBx
 KTSLi211Xy0g0F6xHZR92WhUMf/UkYon+y9TZX+K3yPiFsSmvrYk7pAkO0fN3nOMir
 OtVyUMvqgrUig==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Anders Roxell
 <anders.roxell@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, love.kumar@amd.com, Kunihiko
 Hayashi <hayashi.kunihiko@socionext.com>, Nishanth Menon <nm@ti.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Casey Connolly
 <casey.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Peng Fan
 <peng.fan@nxp.com>, Mark Kettenis <kettenis@openbsd.org>, Janne Grunau
 <j@jannau.net>, Chin-Liang See <clsee@altera.com>, "Chee, Tien Fong"
 <tien.fong.chee@intel.com>, "dinguyen@kernel.org" <dinguyen@kernel.org>
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
In-Reply-To: <50db221f-8e06-4519-a44f-5ee36b8f3df3@mailbox.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <80e9e892-24de-4cba-b84a-35bdcb6a903c@cherry.de>
 <as4r8p_70JTOl068@monster>
 <50db221f-8e06-4519-a44f-5ee36b8f3df3@mailbox.org>
Date: Thu, 22 Oct 2026 11:16:01 +0200
Message-ID: <xhkdbh5iep032.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On Sat, Oct 17, 2026 at 16:29, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 10/13/26 3:02 PM, Anders Roxell wrote:
>
> Hello everyone,
>
> [...]
>
>>> Total of 4096 double word(s) were the same
>>>
>>> I also have two SanDisk Corp. Ultra Flair that are USB3 but they are
>>> consistently detected as USB2 in U-Boot for some reason.
>>
>> Same without my patches?
>>
>> No rush, I know you are away for a month.
>
> I would like to move this series forward, so let me get input on the
> status. Below are the vendors which use DWC3 core that I could find in
> tree, can I get a go/no-go on this series from each of you ? I hope the
> CC is complete, if not, please add the missing people.
>
> allwinner
> altera
> amlogic

Allthough I'm not the amlogic custodian, I regularly test using the
Khadas VIM3 board (khadas-vim3_android_ab_defconfig)

Using this branch, with base
commit e08a73448153 ("usb: dwc3-am62: check dev_remap_addr_index() for NULL")

I tested both usb gadget and usb host.

Usb gadget, tested with:

  $ fastboot flash bootloader u-boot_kvim3_ab.bin

"""
=> fastboot usb 0
** Bad device specification mmc bootloader_a **
** Bad device specification mmc bootloader_a **
Couldn't find partition mmc bootloader_a
Starting download of 1304944 bytes
.........
downloading of 1304944 bytes finished
Flashing Raw Image
........ wrote 1305088 bytes to 'bootloader'
resetting ...
"""

Usb host:
"""
=> usb start
starting USB...
USB XHCI 1.10
Bus usb@ff500000: 3 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found

=> usb info
1: Hub,  USB Revision 3.0
 - U-Boot XHCI Host Controller
 - Class: Hub
 - PacketSize: 512  Configurations: 1
 - Vendor: 0x0000  Product 0x0000 Version 1.0
   Configuration: 1
   - Interfaces: 1 Self Powered 0mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 1
     - Class Hub
     - Endpoint 1 In Interrupt MaxPacket 8 Interval 255ms

2: Hub,  USB Revision 2.0
 -  USB 2.0 Hub
 - Class: Hub
 - PacketSize: 64  Configurations: 1
 - Vendor: 0x1a40  Product 0x0801 Version 1.0
   Configuration: 1
   - Interfaces: 1 Self Powered Remote Wakeup 100mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 1
     - Class Hub
     - Endpoint 1 In Interrupt MaxPacket 1 Interval 12ms

3: Mass Storage,  USB Revision 2.0
 -          USB DISK 2.0 07009C206DA2DD76
 - Class: (from Interface) Mass Storage
 - PacketSize: 64  Configurations: 1
 - Vendor: 0x6557  Product 0x0021 Version 1.0
   Configuration: 1
   - Interfaces: 1 Bus Powered 200mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 2
     - Class Mass Storage, Transp. SCSI, Bulk only
     - Endpoint 1 In Bulk MaxPacket 512
     - Endpoint 2 Out Bulk MaxPacket 512
"""


I hope we can move forward with this series.

Thanks
Mattijs

> apple
> broadcom
> exynos
> freescale
> microchip
> qcom
> rockchip
> socionext
> st
> ti
> xilinx
>
> The current state of the patchset is at [1] in case you would like to
> re-test.
>
> Thank you !
>
> [1]
> https://git.u-boot-project.org/u-boot/custodians/u-boot-usb/-/commits/test-dwc3
>
> --
> Best regards,
> Marek Vasut
