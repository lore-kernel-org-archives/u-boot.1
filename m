Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D051BCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 11:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F15F86E17;
	Tue, 17 Oct 2023 13:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697541610;
	bh=3fL5W6sFDRMk5NWDd4B2yUpssMSqBFSSES428tEYidI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wYd6gPeF+4eLe7JmW8ozBrWm0Mb8p0Zq+vT/tOrLR4rlpa2hpiUzlkMTBHhfYwTSO
	 +8/8eO4te5LeIDBaXPBlpkmFTSb0gfUKVrnoyvbwahQ4/JILVadWOFkAIkENrNY3in
	 Df8E0RxO68OQW374QfkpGRDx8kv/tXfK2FY+DKsEKRpd74BiYwVIE3RT5/jkEYovZd
	 Mw77o+FcgDPCLhJwmtwiSUObgyAyK3tn8OM+P7Jk42/caoH6rWR0U1AZx4hqzKCBAC
	 9yAOQHkEhZaamn4PB3FGGbG0x0K8ebs10O9E/4VqGBKU7eTtkYdtMpB4l14ioQJzPF
	 wL5Ib1N7jsYeA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BF42386DC6;
 Tue, 17 Oct 2023 13:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697541602;
 bh=3fL5W6sFDRMk5NWDd4B2yUpssMSqBFSSES428tEYidI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=P49paxvpjzg9F5nozFgEdeN7fJPLpWXgqXJK4yv2lL4XMscpVhlQC6RbC1sFytUOJ
 pcqViXgiymazmDQYbPgqzGt2BVwJ5lQPmR50giJZBA8J0CZOs2EUClbtTxZS+x6ubF
 s08YLlAoqnez2ZuwSeg8WEKh4JX93MYAKWZqxrxLgt+ikE1R5uy5YRq684gNYppUK1
 IZMQ7R+2jKBkQHHIgVUAJyoPWGlj83F90qq5Cb8tmhgBLmcxwfQCNILFeqV5608c9y
 CLv4oM3NIinYrNr4GmgYE2Fo2Trt1jSAymjcZufvjofuOcfU9l1iNspwmLWoY733e7
 +Y7CLpZhG+75Q==
Message-ID: <aa649c6d-5992-492a-bd39-d1f4389e773f@denx.de>
Date: Tue, 17 Oct 2023 13:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER
 event
Content-Language: en-US
To: Minda Chen <minda.chen@starfivetech.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de
References: <20231017062016.51682-1-minda.chen@starfivetech.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231017062016.51682-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/17/23 08:20, Minda Chen wrote:
> xhci_wait_for_event() waiting TRB_TRANSFER event may return
> NULL. Checking the return value to avoid crash.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

How did you trigger this error ? Is there a reproducer ? Details please ...
