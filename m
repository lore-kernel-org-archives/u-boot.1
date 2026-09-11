Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDE5C88E56
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B68980D96;
	Fri, 11 Sep 2026 12:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xW-PAwZ0RPtk; Fri, 11 Sep 2026 12:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D34A580F53
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789128969;
	b=FlUHwL6MrMiSqq1QyXySKvRr6SDiKLXQpoi694nSvfKbqwsLMG8gLQFCtHPGWdK/yEp2
	 ih3yiAelzoURsljbTCj+f5xjDHlL71T+Wlx4STQBvd4ETexgjUBAS+MV0Brjm9KTtt/da
	 Tryu+su4K3WlgoxcRQDS1+OzQ1vXCrsGYfsaBj80PXUiAmOr/pv8tH46QGpi1JGT16k4S
	 ICmS1aUrXHGkcWMe9ibKlzjLpSXvSMy/hpXLIOUaP9iUHEQIrGdztSeECBDX4w+HHdTKa
	 JztDnqcYnrT4WFBdSw4LdZn23uRxlNcbruou7nlrg3KCz5/sMkctFKj4NMipH8McK6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789128969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RUfEgSgNgCU5uYWmlXb6nWMUBa4NoA0x1OGc6ovNIM4=;
	b=O9p2ZO+wZjlBr0MNpvoXYm5P2N14113MYCS/tC+N/MjiXzvhRFymL34SBaVQ4MTyVqR6
	 EASxDBsXP9mXNCzGzclmcuHFKPQVCh+wJCCqqEbG9lrUHxhrie5oJvYkIblISU+zbDDY4
	 PVWT6B3Eq4DkF3qinB7PHQod4IsQcluqIY+VAlVMmmXO3PzvE/nHCMGg4HAF8rcQOXmB1
	 BC4vhiT4KuvQWolFTITlrAoA2QO1F7gqtrp9RB3FMtKobDZpj2WDQ4qy5wYwH+a9uqYWR
	 wmln1mbBraBZDunzf8GichN5Wsw0NALLawzJDf+FZgkwmnNTyEuVpdPu65wnjVYLDYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lWD/IkQ9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789128969;
	bh=RUfEgSgNgCU5uYWmlXb6nWMUBa4NoA0x1OGc6ovNIM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdDXZMQCKWmAVujuDgGJvJ6JOAINLgxHi96oPzD4Bi39z4h6pvMfhtvHt38Dz6z72
	 nnx89jD9gorrf76mbZZsEt/jCKVwwyGAkrwI4qplEpqdzl2qDnmEWklat4iotdb6sT
	 YrhikBs43a/IRok/YNcCtftJp4FoqXgk6kWHGG+GZMIUzVS3YFSNhT6rqzxlan4CdE
	 Iy3OAdBVaz2Yyjx023sclglKQXesfEDaCtJUUNZ4Vm60R+gGiUdvLFPrJJlpy3zp1O
	 nCIntgj7m5r2nDEBzmnOyHG5fh/g8/NO7Zeh3SEAOKvi3VszwUhtmxgzXt/pBhu/J1
	 WzxxeI6TyQFdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D34A580F53;
	Fri, 11 Sep 2026 12:16:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 06ECA14D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC81080F53
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZaECcpIOe7B for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4841D80D96
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789128966;
 b=ddbuHjnlxYcLtKC967hS715ZbGK8ePSZnd1qmbHPbO7kBhTeyAiVWhA0DH0Hu1cSWl7T
 chfLp1wgX0tP3ht2Nkm41N/0s8eIKoscYfPeillIzef9d0ksXuiY6q9Z7bvp29wJf/3Hb
 SlAxvpKho1X5kAd3ZlsDwv2YpE5rTyNIqzkQJnbFWtNal1alnwUSS8204C4rLCv5OzgYy
 3/xkI3yZ3XRHgCxoqMD1flR+dB3n1YYMeSbsYC+C3I+rA3xN0v8V6PN/Pp7M70AQ1gWJ5
 ZzyXHj3roUPH8XnvmgW5eaDFNolXJuUgYELCr2XBRVMGfmFQQeyT8pCnxdQMnZ3v5Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789128966;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=RUfEgSgNgCU5uYWmlXb6nWMUBa4NoA0x1OGc6ovNIM4=;
 b=nk+Ra6ndVdDqO+e2821JyvDZYeEtHEeZZCjK2jMLooUs3Uyuje5647D8CT6EocQqsc5U
 Gu0rvI3vMwEA+Rhd8yoJozFN4G0lDo+SqmeBk3WEjd91x94keMJuOwuY4u2mg9qmWUOSD
 iv4eTR7gms7wrqCtuSnAtBXH/co9FF+z9Niv1x/Z5mtunaog48rU28n7aBvw7z8aHwknL
 vqWZAwgtuFBwboBc6ZCSTPKS/OMDxUwRHRbOcJgku1uiyJ9hHFgY1SmU1bgA0vrv7YJ2C
 Y9pG1fOYOxDJloxkbqwwMDWNxoVQa6aDxWGuLJFkEr7roEC46fo+rtJriksnbL/0Pvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="lWD/IkQ9"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lWD/IkQ9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4841D80D96
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F29A141AB3;
 Fri, 11 Sep 2026 12:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620591F00893;
 Fri, 11 Sep 2026 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789128964;
 bh=RUfEgSgNgCU5uYWmlXb6nWMUBa4NoA0x1OGc6ovNIM4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=lWD/IkQ9Q31DJc4EH6a4cG82I15Sn32AFgzyCnO/w6P4F2tTshJF7QcgZqU0ifV/5
 Ec/6XPO5NjqT9eXL6H/9RHgUfz+SjoPztAVrUpfR+lduHumDiaJ6dwYGWQTRDDWIqO
 D1/hID6O8HXUY3ez1zVjl7nzlKg53JwycMCdg2WCmwQtD+IS1SjUTNPz/xNA+WLBET
 3mIopybjMgavlHfTC1cYnKmeQ2gRqpNZUkMxypBJg1c/PqUlGy9lINi3qlrcagoUny
 AP9VLtEZrwRZLgdad/azayy8C1gPWtw53xSMVVQBr4m4L3dG6LvZFU1xrzAumjoICW
 ptJrJbh5AWhgg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com, dlechner@baylibre.com,
 anshuld@ti.com, sjg@chromium.org, Anders Roxell
 <anders.roxell@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v7 01/24] dm: add helpers needed by the resynced DWC3 code
In-Reply-To: <20260824154133.217744-2-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
 <20260824154133.217744-2-anders.roxell@linaro.org>
Date: Fri, 11 Sep 2026 14:16:02 +0200
Message-ID: <xhkdbo6e43rwd.fsf@mkorpers-koolstof.csb>
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

Hi Anders,

Thank you for the patch.

On Mon, Aug 24, 2026 at 17:41, Anders Roxell <anders.roxell@linaro.org> wrote:

> The resynced DWC3 code calls a few helpers that u-boot did not have.
> Add them first so the next commits can use them.
>
> These are not copies of kernel files. They are small u-boot versions of
> the Linux v6.16 API that the DWC3 code expects:
>
> - dev_err_probe() from include/linux/device.h.
> - device_property_*() from include/linux/property.h. They are thin
>   wrappers on the matching dev_read_*() calls.
> - struct device gets an of_node member, so the kernel code that carries
>   it around still compiles.
> - reset_control_assert() and reset_control_deassert() from
>   include/linux/reset.h, as empty stubs. u-boot has no reset_control of
>   that shape. The DWC3 core only calls reset_control_assert() in
>   dwc3_core_exit(), and dwc->reset is never set, because the glue driver
>   handles the reset through the DM reset framework. So doing nothing is
>   correct here.
>
> Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
