Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304B606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IjzHIFw+;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=SoVWP3GN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D75B940806;
	Tue, 20 Oct 2026 01:38:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6B-BgLKjAuS; Tue, 20 Oct 2026 01:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19977407FD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792460299;
	b=dlCG5/QUG5ACEc7+Ge1RFxv4Bhw5Ot8Iti00Wu5vxIaWc84uRuKrfMtTcbIcGRWgFEjG
	 H0IkW3oG8ROCJJCj+9M6NsVHrnfPaYkpozgb0r14HyHU1CXGTNhg7fTL6xxh0FT5AMXzp
	 3j+Qk3goxmvlMtqhHg8s7Js6Ie4OROvmwMPXxX0hCAssmlyNLe7aJGC1Y09xRzlSnoUZB
	 6WPx908T+70DMfwqlYdgxtFyXSEKgnCGT2r3m9VGX3tVJ1kiVkxzXx+KcXtGgb4rQDEG9
	 pcEMeiiGRBhzDzsyDsR9uMuMbm/w+4TgYV+N7YDn9mC4C9KZF/F1pmgllYBB1Be1qzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792460299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GqZEIkKdudYnK5p11ED5AouZ/th1Des89Q6e7pteBVs=;
	b=c4hTe6ywoL0VWM+fiiraAOJp4eUdUj42rPiamiq3D9wozXHbq4ZVMpgiUArdwt/tuGqZ
	 zyGbwasv1wbTZYmFU1/GschLho8/uYHmxG3115+H6xgzGj90Y05/x1o11CBME6QFnbech
	 KEQ70i1dADTAXQE4IEJ50T9lDyG1D1kAZkWmdH9sgxSYDeSgLAYw7Wax18/lHdAR+kDcn
	 Hm9Vq5uFqcrnssysV2pzHU7eSCm2FaH3GFoka04HN7n++AO+nWldvfBZU37x91iuQMdI/
	 DZ/udmxyUabSE+EI3XYJlgAlyzqxGBEFwYi4IuIiiFDPuMUFmwWegZAyjFE2bP2a6Ig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792460299;
	bh=GqZEIkKdudYnK5p11ED5AouZ/th1Des89Q6e7pteBVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IjzHIFw+O3aQc9Uxe9SL1WfSnPuzfEIXEgIfwpMpU8o8MHTE0wXf8UgeXIJQl2PRD
	 bDbMPcThF02tRChDIL6vRU/xZKqlZi4hBssBAMwIz7quJH/7W5AKkYYk9Lj2PulKBn
	 YrxwJPQqs+b5Ph+Xo8CapNEvElAEg73KHbDoyO1L+YWIP4eZJem/yUr/ho2zHdwnt4
	 3c9b2Q7zeHmevFMqUpMtwE6Y89Yf60X5IXdJWB8rMucyRs02nS/IDMu1IWYM2n+r0g
	 vo0xfW9mmw80c0LUjB3xBvEh98VbqkX7kc6dBPyV+yUBFWbjZhjREW20uaCSVOXrwE
	 6rdckYo/owmyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19977407FD;
	Tue, 20 Oct 2026 01:38:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E9921E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 102D481099
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:38:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0VCPeqdmkSma for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 01:38:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 851CC81080
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792460297;
 b=NqZ1ZnX6EkFKRKgqkwO05BqivkNXcHEsmUMqo0HCbgb+CoylM8D2mVNCs2NtL6XWbyqq
 WNfTH1RTu8zHebCZEaw8/zcIhN0/tey7DOfARgBrDFFPpI2cqWHzuGDCMAQh5j8bhdew5
 T7pHQK6R1yHX99c3/9tg4As3wuM8RwVWIZGpjwNGBNK2kP1lS8waQ8D8vhkE1hB7OKpD7
 1Ese+6VYqJtLs8UIaD/G78DJ/uleAuyvuYV4qkYDXlk1KoHt1Gkq3dboTkJJ1obufx9dV
 qb1g6iiXz+CwfhXRc9N4Kx1cDmjS5f7NE2eEqgTt1Uo29t88KzDpQDkktKSQ1S1L09g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792460297;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=GqZEIkKdudYnK5p11ED5AouZ/th1Des89Q6e7pteBVs=;
 b=abF0cI+IbiisYp1BLl85nk/Ww0D34oZnVjV4+Sp1HRzIWcm6NdcE5b/3rVFhfTJT+yaG
 TyctWT37Be5RLapeQQa4v/vhg/pqkdWiworAKLE4l/u0ehlsAT9lPMu39vnrCYvsR9Kbh
 82ID87PEEnVFC2lRG67S7N/l/KpdMLSXtUB+rO0rXsUDwRGQvdG03NEm9yekp3dHHScp0
 qNtKpnwmyQjwBAEHlm+x50lPHYUQqpXvcwZfYDs9R3Ubuw1C8Iz6pWLPT6YhDZs0PwkLK
 lGKU3yO0e620gf6JvKMRgEM54Bnktyfdr3zG1q5TiV1dwEv+jVljcC7iAKABiP7yYaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=SoVWP3GN; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=SoVWP3GN
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 851CC81080
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:38:14 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j7w6B5CbPzKv52;
 Tue, 20 Oct 2026 03:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792460290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqZEIkKdudYnK5p11ED5AouZ/th1Des89Q6e7pteBVs=;
 b=SoVWP3GNKlOli3wW520jF/QeUms+muOlGZa3U5YFvfnOkNRTL10nHQMp8hUDhKozWT9oNa
 V+tXcCVJuc6V0b+S8PRFWGblV/6FjFUpRpYsHo5cdmc7F8yBDrye5CJ4UW1jIouYKG+002
 nT6gUct3fuw7rLEmCaL1+7LlY+k9htx+DOgmNxoahKuq9cemv5fBOwW+naLkgaaCykdgFR
 hgR3DXZ3l9hMLtPVoTAejwDzhy2JtrqFnEIxIwRfEgd9JbP1ZoLO5bGpMXmfeadSU2S+zn
 V9EoFJpZf/SGeJGYRDe4SU92JjvCDL+uqO4hFLSTIqWJjLkBensH0KuQSTQ8TA==
Message-ID: <097d4df2-1142-4eaf-b23d-60f2f4e291cf@mailbox.org>
Date: Mon, 19 Oct 2026 23:54:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: socfpga_de10_standard: Fix raw partition booting
 from SDMMC
To: Nimesh Acharya <nimeshacharya197@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: hsnaves@gmail.com, marek.vasut+socfpga@mailbox.org,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@altera.com,
 trini@konsulko.com
References: <20261019205932.28038-1-nimeshacharya197@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261019205932.28038-1-nimeshacharya197@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 7f1o9iaudpi9ahqp93k6i5khh9bhbt5h
X-MBO-RS-ID: 4e4d97fc9bc4afff6cb
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 10:59 PM, Nimesh Acharya wrote:
> When using the default meta-intel-fpga configuration in Yocto
> 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
> U-Boot from the raw a2 partition on the SDMMC device.
> 
> This change configures SPL to locate the raw U-Boot image using the
> partition type and data offset, rather than relying on the
> default offset relative to the beginning of the SD card.
> 
> Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
> ---
>   configs/socfpga_de10_standard_defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
> index 04f9d6c8494..f170778c322 100644
> --- a/configs/socfpga_de10_standard_defconfig
> +++ b/configs/socfpga_de10_standard_defconfig
> @@ -70,3 +70,8 @@ CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   # CONFIG_SPL_WDT is not set
>   CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +
> +# SPL Fails to load UBOOT without these!
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x200

What does get configured in the .config during OE build without these 
options ?

For example SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE is already set to 
0xa2 in arch/arm/mach-socfpga/Kconfig , so that shouldn't be part of 
this patch.
