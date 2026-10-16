Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DFCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB001614BB;
	Fri, 16 Oct 2026 13:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yu2S_4Ch0iWr; Fri, 16 Oct 2026 13:14:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30EE5614B3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792156471;
	b=BCDe8cpgRUKXyHGlD4XOeeCtgj+ivj8GL5eSIa6AYvVat14FIdkR5c0zCP62Yt7Qypd/
	 E8ELt/UWgzlzZG1tMHQfIeufDlVQkftuQwbRpQFovveWUmNGR5PApNZ1YFFO4t8mD6hFU
	 5ZLLrjtXuf/cpYTojhvkRXwJZ5ICSb1VnPnNhwjg1Lltje3OyaOjBA3R75z+xJ+fKprXa
	 OB6uqj96kbVJDLeXa4MIccwkeA5zbduAKYWZgfcnq9BgRDZ0b5W0waLNnAjRX5r/bY19e
	 WXSaIpS/gXHbFLXNffrJepeY8NDV31+aX4uv6vHLi20yaHsn2kq8LtbR90sToGk0kRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792156471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vRzWUv3BPuXAqQlBbKXBjZNrmkBnb3SileYywN0pQ2A=;
	b=GNvQ6jYVV4OZE3a0bqxgNx6/yCjlT2BOCuTmPM7BfCd3A2plS7T+warG/VBRUWdI5omP
	 aj89aBmZKqqGyGrlJOpt3xxFgb6BquwxmlLjSCSFpjSs0+TQyZYsy73WRpbzYHXyx0VII
	 AP/ebsHH60m99DbKAavyVdOAD9bcyUIB5rZptONSQrZbcmBNzyNJksPxSEyvjWy2lk4K0
	 xLj6ThVcpsWlFH8QnRfGUHQLjckZWyRnY632w2EuIDQK28Jn9z4sW6Jzu6UEPO27drPOE
	 afWzOUu83MxzFTs5FZYDw3Gf0v4P+MnGJw8oLxnqYPTZ9PtOfnzRescoVXjdlUCUzgQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792156471;
	bh=vRzWUv3BPuXAqQlBbKXBjZNrmkBnb3SileYywN0pQ2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yRD82/uk7UR7T4fSBFppargsBJA782t9iCVRtV/WCndJdEtJApgQcuqhXQidlhBRc
	 eL32DKGbfVu+Qc9wHTc6y39UfTUWkCRUbilrZB+oroMV6YIE5vwM+GHg38DD6Hyxcl
	 a8Jn7B+DiXTHVUTQVufHxWLkocAdd5XUPv+0tJPiKQpifGLFhaHZsjjol+x9iXI0wL
	 dMfc7UnmIEF3lCQfdHZTErOw6RQsgl85fOlmhw38U2N48o0NDON24iwa8JCpxGIf0L
	 pthx1L/F3jThcIkFmMlW52BWWRxwBYhbm6LEd58bbWgGGhrFAfHKXcwp+QUz4c4YOq
	 zc3YuBRuQ9ciw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30EE5614B3;
	Fri, 16 Oct 2026 13:14:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D993D769
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D75E6409F3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fa-rqH55ohy4 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 13:13:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A126A409F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792156385;
 b=Dmhfq3c3yP0dVysksQX6kPjrPjbgcu4ugPWnNnoSa81LUljQ6krhjR+2iaWOpJN7gT+f
 DPNn5VN2DVlh3EZJIKFoQpf+ZIQcdRLIOWQZOqjyj6hd+64QlKM5P6FUdxqB4pfnbfGlN
 lCmGpOPoCpG7JIyOG4SKlk6ITZymQOTZJ82VT/q3MddRa17pCLj3p8ucnV96jwk3kTzcD
 iB0ohVcNWGfa5KRNh2NsFcYgStf7+mjcZtDLgosGDXGxBaoiQ6TvnUNCE97vg5XlM8J6U
 tc7QHGs2ANTvnGc2tBl1UDhv/eD65V+fkOjW42tdCHpr4OCAvRGIqRhsCOt/ZhN4v6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792156385;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=vRzWUv3BPuXAqQlBbKXBjZNrmkBnb3SileYywN0pQ2A=;
 b=EcyfEAYlRtk4jWWHPKYUhG7J8aOoRg1ZVnRBUqubdaETyPdo947eU4qZ052HcUepBtEH
 0VTVP6t7/QC3UaAzc8mXXSt88f4JSLfAc/8WteThO5RwpaHBsYdE5PKH29O3E+7T/ZyzP
 Ljm8lGnoDtMRvbgcQ8K3/+efSUpVxotbr8TkJLFVN5F/17Ayh6inokuqX9zep2w3+hkzs
 CvPU880uauSwwCxzZa1ssxhByQim87oRwKyxzYnBTG+TZdTXyBWsbLsEzLNy7kDhy0KAb
 +n1S4i4LZiUyXK3Kb+FxCunqHLHrAULVYPk8A5mXY8IQTRQJU9TfMs9p5U0knUaOvCQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=n4AB9kTe; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=n4AB9kTe
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A126A409F4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:13:04 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j5ljl1VMVzMlTn;
 Fri, 16 Oct 2026 15:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792156379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRzWUv3BPuXAqQlBbKXBjZNrmkBnb3SileYywN0pQ2A=;
 b=n4AB9kTersk9Jut/sBYvD8vI6BeDbiXy0aUEVYFGStpb7+WF6c3lqn2Oc2BUrBJM/i3NRO
 SoDX2+bPSfemw6LAD14isdadR9iJL1Qb4GA6Fma2BTzc11vl9JECNB5qrNvODty1Yzu9D7
 PVjPHNG4zD2Ts6gI746qunAZb7M/eZdaVC02EE7VaZJ6FtFaswgk9hNPGq4mC/QS3OehUJ
 TqH1YYLOpU66wuPZLmoNXRRzKja6g1M/4tll06mAcztAxIQaMT+0XrO0NE60B63X6yhhKJ
 ujTgV3QHw2hNOPq2j4zAQM6XIdxYQD3SP8uz567OJXo5XWmJSnIPUCfSm9O3Tg==
Message-ID: <81cc02a0-d556-475e-bed9-e6906faa450d@mailbox.org>
Date: Fri, 16 Oct 2026 15:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_IMX8M
To: Fabio Estevam <festevam@gmail.com>, Andreas Henriksson <andreas@fatal.se>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
 <CAOMZO5DVhvT_dNw8eYKMhwpUU855-P5YK9f+z8o=XwnDhmPzhg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAOMZO5DVhvT_dNw8eYKMhwpUU855-P5YK9f+z8o=XwnDhmPzhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: simkdcpnj4sa9ogiyt61qq8fuok9egu4
X-MBO-RS-ID: ad44aefbb20570f001d
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10/16/26 2:49 PM, Fabio Estevam wrote:
> Hi Andreas,
> 
> On Wed, Oct 14, 2026 at 4:46 AM Andreas Henriksson <andreas@fatal.se> wrote:
>>
>> On boards with >3GiB ram, we can end up with transfers above 4GiB
>> which is not allowed by SDHC driver.
>>
>> fsl_esdhc_imx.c: esdhc_setup_dma():
>>          if (upper_32_bits(priv->dma_addr))
>>                  printf("Cannot use 64 bit addresses with SDMA\n");
>>
>> Tested on Toradex Verdin i.MX8M Plus SoM, where bootefi would not work
>> (with systemd-boot as efi application) and print the above message.
>>
>> Signed-off-by: Andreas Henriksson <andreas@fatal.se>
>> ---
>>   lib/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 021a82d4709..a5f2e3e1058 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -1371,7 +1371,7 @@ config SPL_LMB_ARCH_MEM_MAP
>>   config LMB_LIMIT_DMA_BELOW_RAM_TOP
>>          bool
>>          depends on LMB
>> -       default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH7110
>> +       default y if ARCH_BCM283X || ARCH_IMX8M || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH7110
> 
> I noticed that MMC_MTK already implies LMB_LIMIT_DMA_BELOW_RAM_TOP in
> its Kconfig entry.
> 
> Would it make sense to do the same for FSL_ESDHC_IMX and restrict it
> to ARCH_IMX8M?
> 
> Something like:
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -1,5 +1,6 @@
>   config FSL_ESDHC_IMX
>          bool "Freescale/NXP i.MX eSDHC controller support"
> +       imply LMB_LIMIT_DMA_BELOW_RAM_TOP if ARCH_IMX8M
> 
> This keeps the DMA restriction tied to the affected driver rather than
> adding another architecture-specific condition to lib/Kconfig.
> 
> What do you think?
Use "select" instead of "imply" .

Is the MX8MM USDHC also limited ?
