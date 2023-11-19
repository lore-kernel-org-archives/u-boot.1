Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CED9C54FB9
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B8C87483;
	Sun, 19 Nov 2023 21:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700424497;
	bh=CxtwTpKnwXXhWSldFGaimZ660MQoOXtAtyNioYo6Z7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WNyxBXK6uMxqrAqCoXpIAvwILRcRXRhzU0Qf2QbxENdzlQp0MRFCLjEhw7cHi9AMA
	 z4X1sEtCDlShicepIXcJOTdEgzAAGLVzJsI5jAc+y7lls54oTPh4jgBqnXhUsZvSgS
	 MNEKOtbICQh2Iyj1rquMX2jBKValOSlFAJQmq03UDpSTOtV+PEQqK7k4vkZ3or2Fje
	 CiBX8MQqml/6BoGE1cA0VKL2a8SvQzhOFhY3PBCYUcKGLGzaJx1aC6J5sn8pFB6UL4
	 WAcVw4vjPXgdtjVzdjscYqLn31EgrS06bLz+/DIvvxOcb7CD7pRas9SSVTUmVOzAO7
	 AVr+njQkE3kjw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 783B286F44;
 Sun, 19 Nov 2023 21:08:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700424496;
 bh=CxtwTpKnwXXhWSldFGaimZ660MQoOXtAtyNioYo6Z7k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oI0UodQQLch8MblRwgQgNw0lWP7s9jmvZXo5S0stLHuYbVWfb05Z3gBtSphAvft8w
 42XZzfIA1h/C4HQsA4qRK0G6eJnOoPt4OzM+Z2sJ2vsQVqs1CrDg8nAVB0RvWo4Hf/
 pnOH1iRhgEIqgXSRACGMgimkUm7wQs08k4wG/lpHEAIQAKY5ay/SRuqMhPUF2DckIC
 Juz/r6T4l6cf07k4SLsjNy+83hlaHbAzrzqC3gGZjgAGt62f1Lkl4eNuLmvnGcVGQJ
 RXk6UQqNtrOji10Z/9jjQEbGFGIo6i0aH/NhPEg46xTei+AiUtHdyzhGLZY3ceqomQ
 6LFrGNX65+OzA==
Message-ID: <fe844c63-0c44-469c-a4e0-f0e1f2ac63fc@denx.de>
Date: Sun, 19 Nov 2023 21:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] USB fixes: xHCI error handling
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
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

On 10/27/23 01:16, Hector Martin wrote:
> This series is the first of a few bundles of USB fixes we have been
> carrying downstream on the Asahi U-Boot branch for a few months.
> 
> Most importantly, this related set of patches makes xHCI error/stall
> recovery more robust (or work at all in some cases). There are also a
> couple patches fixing other xHCI bugs and adding better debug logs.
> 
> I believe this should fix this Fedora bug too:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2244305

Was there ever a V2 of these patches I might've missed ?
