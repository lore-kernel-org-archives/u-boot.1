Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC15CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0456D80DEB;
	Tue, 29 Sep 2026 12:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MjCWhuKG4L3p; Tue, 29 Sep 2026 12:30:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3329380E31
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685036;
	b=ncGCSr9Io0gI2V7t+YTL1WPC+cS7x6UJ/YbkNpzcWCDPcWtFF+Zf8E5QVv2etUifBHgk
	 P34QzPUYZ0X/9cDC316sd6IWu8wVTf61EramHgguNWZQThe11bYxjBnrPYHkANtbNfk7G
	 qv9ADIdhZUXmEmNXOACxztUW1TbcNwDoNMOEpP/CXzuDVEZBNlvUOD+Avu86a4ngAlyxv
	 AwbmfwDuqmC+ucp3wY/FKsjGqQ/qMV+cLfFCIidkoNg5FEC7rQDPpdP7ncRS+JSvYzBLw
	 A/cCmMMWZ9i6q9Vk/opQB89k2J6GvldIQWHIkhgUy76h6NJaUuoPsMzYeRZj0LEuhsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zHR/4uIK8rkijykJ84ApC5/ZoQxw9ZAGltE2m0z5sh8=;
	b=GwVC97fgnQHiN9C6haP8htZCeR9xAO+wvVzbhZI4HP2i7Gdo/YmBoErmF3HVvUvZcy7f
	 fcjW0XnmiXvvzGUge4bG7Gc9SStr4QvnZxSL9xnwsEM5Y5E5Ge+cc3Gb//0bWG3uApwIX
	 3ypYRmZKO87v06xTX34SqUSwIWJ+a1K8AvomfFg6Q322HSiru0QJ4qTrtQK1CTTIZERqr
	 FkCZEWyrdRto+6lmvFREYwW2r82cykWBSrQRrGD/oyQNfvmfQatG4siHRdc4x9m1Y4iXC
	 81j5Kb+E4xC0A4lu+pOMW1ZcXfwnRGGnGE+NTNngMUofnD1KnlEW+6xUEyl9EjvidMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685036;
	bh=zHR/4uIK8rkijykJ84ApC5/ZoQxw9ZAGltE2m0z5sh8=;
	h=From:To:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qgWxMc1b3//WN4eT9eYPjshQU9p+33xN8LQxpHqIPuOk7SGPZMGUP5GThcJw4tMBn
	 iIdLiIifCp38Exuzsh5sSNgPhjY/93wp7X3xhdqkaJMo/LzgWWAxuQGTSldiwClkUj
	 KYUw3KcJhw/gqHBXDEtb0/Iy2G8Nq1o9jEq2Zw0lJBSLNkdkEiN8WJR3QeTpEsVMXz
	 ZuCtK3/4GNCCg1FpRw8pBCN404UsKmtrRGz4OY+oeIcBqfE0xCBIKSVpcF21IgxtgZ
	 Zqv1psT7BRGGVe+MVG89QTXyYaQjnFojZ47MfNyx+HdFIZOU1m/y7F6MqOhNZKrup+
	 1V/weiTQW6SrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3329380E31;
	Tue, 29 Sep 2026 12:30:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A94632F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1090D402DB
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4mzUA7jFAQSk for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:30:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 36DB140082
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685034;
 b=PZ6hd8+GAbzmUoSE6pFP/VAymbVWi5zoYy7g/Agl/YVKjlGwsPa98TqgrBTOtvHk4zYi
 bldxZ6UPOa3FCTRHwwvRH3mk01IO9LAKDoVIFGW3ar/65c2lBJLRxP193lZvVU/CLxKK7
 CDW5BbrBYfJLS5d/QbbJYKLcIgymScJyzVUWuN/d8DCRMTPkjImpksrDcudQDr0WaavOb
 RAcDG4+GOX+8GPFmVo+Zns1ldYRDQbLpW/Oh5sjALV/0g+ocpxCnIGbsGaes5LYouVghL
 xFBJ1dCDRIB6rUY02idCqceuaHcWrlaTLQiXuKpzHFYM5i6LoobVSR5p9TCFiQ0aiwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685034;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=zHR/4uIK8rkijykJ84ApC5/ZoQxw9ZAGltE2m0z5sh8=;
 b=C3EkunDqXNLBKlGvQoAt7aO/zEAJlSVa2ZEdTaYDDAtGm8ar+1tG1EsFIbLn+oKP7Fxc
 b4doDNWz0ZHqs9az4hpE2jkgN399Gym+0F5NhhjADKxSc9tSBAViWsD/A8X0LaK6ilOpV
 R1Ut95OhkLeRS24x1CXWgZsTFD63FY5/5WEPjjdocqg23nQkUFH8FkCivMT+vyDPP1DoY
 nmyRy8Xy4A9J7uJbimiCMcLqFDnuunHe1gCdyzdBvLDT9o5h1jadlhLf5bdE0gzhb5VyK
 SrZ8xWdJJpokHP4RivbjcozWYAVks1C8X0c/a0NVUKukTpp3KjfuaqD16OiFv4E8IcQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QFzxJftF; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QFzxJftF
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36DB140082
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:30:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF59E600E2;
 Tue, 29 Sep 2026 12:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E551F000FF;
 Tue, 29 Sep 2026 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790685031;
 bh=zHR/4uIK8rkijykJ84ApC5/ZoQxw9ZAGltE2m0z5sh8=;
 h=From:To:Subject:In-Reply-To:References:Date;
 b=QFzxJftFUimUbhlB2ibqkq4syBuI3o1oPcHNJYXePQzS35eJCndfBdBT6BQXPhTSj
 fFyrTUULsJS1YMXYYd1vUcrd2G/waMFJwDaT4lmdcOaz4vtttI3Ta2FY7ncHiV9WmE
 xCjJsqPqQUYBF8wV3Xb5DfRVDBo0LSeoOLpPLXEbbt8zw9AwbeZfbRbuJ6MrogKHdi
 ygfaOmJj6h/yXRioI7g4LCLSDIh4Ymsyy/o95g44H1/HQHgYSbZLahVgwS/G8O/6Rf
 S9Ksc+SJWlSW7pD3AotgbNuR9qRxAVHUga99HccvJGtT/D7p2Uh45O6FkHmUElwQM1
 fpwlyS9+uZOZQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marex@denx.de,
 sumit.dhami@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, vandhiadevan.karunamoorthy@oss.qualcomm.com,
 dario.binacchi@amarulasolutions.com, sjg@chromium.org,
 pbrobinson@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v1 0/8] gpt: enable writing a full-featured GPT via 'gpt
 write' over fastboot
In-Reply-To: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:30:29 +0200
Message-ID: <xhkdbtsn8qly2.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sumit,

On Mon, Sep 28, 2026 at 12:10, Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com> wrote:

> This work is done as part of Snagboot support for Qualcomm Lemans-EVK to
> help flash GPT via u-boot 'gpt write' command. It addresses the following
> issues:
>   - Incorrect first/last LBA computation for devices whose block size is
>    not 512 bytes.
>   - No option available in 'gpt write' to set full 64-bit gpt partition
>    attributes.
>   - Fastboot EP_BUFFER_SIZE is not configurable and set to 4096 bytes which
>    overflows when long command strings are passed. (We faced this issue when
>    we passed 'gpt write' via 'fastboot oem run' with a very long partition
>    list).
>
> The changes are followed by a final patch that adds all the config options
> required for writing a GPT via 'gpt write' over fastboot to
> qcom-snagboot.config file.

I've not looked that much into detail in this series, but enabling
"fastboot oem run" feels wrong to me. "oem run" is a debug command. I
don't recommend shipping any board by default with it.

Also, more generally, I don't see to understand why it needs to be
implemented this way? (Sending "gpt write" via "fastboot oem run")

It seems to me that we already handle gpt flashing in fastboot.
See: drivers/fastboot/fb_mmc.c

"""
#if CONFIG_IS_ENABLED(EFI_PARTITION)
	if (strcmp(cmd, CONFIG_FASTBOOT_GPT_NAME) == 0) {
		dev_desc = fastboot_mmc_get_dev(response);
		if (!dev_desc)
			return;

		printf("%s: updating MBR, Primary and Backup GPT(s)\n",
		       __func__);
		if (is_valid_gpt_buf(dev_desc, download_buffer)) {
			printf("%s: invalid GPT - refusing to write to flash\n",
			       __func__);
			fastboot_fail("invalid GPT partition", response);
			return;
		}
		if (write_mbr_and_gpt_partitions(dev_desc, download_buffer)) {
			printf("%s: writing GPT partitions failed\n", __func__);
			fastboot_fail("writing GPT partitions failed",
				      response);
			return;
		}
		part_init(dev_desc);
		printf("........ success\n");
		fastboot_okay(NULL, response);
		return;
	}
#endif
"""

Can we explain how this is any different please ?

