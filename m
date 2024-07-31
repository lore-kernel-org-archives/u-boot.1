Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637F3C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 03:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA68988780;
	Wed, 31 Jul 2024 05:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722397849;
	bh=oZLuIvYnJflvIZJXO4mp8VwjpONBXxX71njkOqMVy/k=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=cNAUZcP5F8dLhB0GOpkalzV0haoZNFvcMPqc5VY/HV5vZnMBDkQCSySZNro/aQNeK
	 jdjKAZg1U1ogIJmIvzEmClIeBSQDoJ6HKNaUB01uPIb/q1l2HGqmSz2+XOsCNVGVMS
	 qGTRFyTKq2LhgiCJlf7mgrUJX3DrloXuvRt3RJgVJiCXRcU2DLF3wpwNrnbhzeNlU6
	 eJs/kccQ/VXN53LVxYIAx/APAT4kTofNiHsH82fhCPtjqrsPOuS+PpYg8Cn/X5RDtV
	 6ufI1XhoufY0CsF6F4TnZK+AkSUbOv3AcPmHgjWTFuxeguJFFU6KZeZ/ThlohXClwE
	 mnLnZHLRloG3g==
Received: from [192.168.1.107] (87-97-105-110.pool.digikabel.hu
 [87.97.105.110])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7C53788453;
 Wed, 31 Jul 2024 05:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722397849;
 bh=oZLuIvYnJflvIZJXO4mp8VwjpONBXxX71njkOqMVy/k=;
 h=Date:Subject:To:References:Cc:Reply-To:From:In-Reply-To:From;
 b=aLDW2pFDa7H9Xce7LLG6DI0kfFYZzdZXKW5SIVsUImVZUue1yvUuCaMgki/Z3/Hur
 jyfXC/cnZZsNpkXlWhbO+ozzklJyHnnxvf2i+OCJAFG+9apePy9CC0OPlD7YA+EHKZ
 a8ii5Jwi855perh0FnP7yJv6X8vZ6kEVX7rXRN1J9CjYJMD7QyFMn6uxix7+F7k+Um
 3ovB5ABLPQ1y8ZOr00OVHh83gIoPNlDra4BbeY0mPo1uzpMTEHWEb/royE4srw+4kP
 a/5tv3W96lrREuPCAPZOFsFzJmXLmwVc1kmGLH+DU7g8LAkTYCMoi+HGkOfIQWiJ1M
 f39ZMXYmUrjlQ==
Message-ID: <fc914270-835b-e6f6-f562-f49d78aff236@denx.de>
Date: Wed, 31 Jul 2024 05:50:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ubifs: mount fails after power cycle
Content-Language: en-US
To: Ravi Minnikanti <rminnikanti@marvell.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, kmpark@infradead.org
References: <eae14602-7809-882f-1935-a271a49ee585@marvell.com>
Cc: Tom Rini <trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <eae14602-7809-882f-1935-a271a49ee585@marvell.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Ravi,

On 30.07.24 11:14, Ravi Minnikanti wrote:
> 
> When kernel uses file system encryption, fscrypt on UBIFS v5,
> after a hard power cycle UBIFS journal replay fails which results in mount failure.
> 
> Failure logs:
> UBIFS: recovery needed
> UBIFS error (pid 0): ubifs_validate_entry: bad directory entry node
> UBIFS error (pid 0): replay_bud: bad node is at LEB 890:24576
> UBIFS error (pid 0): ubifs_mount: Error reading superblock on volume 'ubi0:rootfs' errno=-22!
> 
> This change is ported from kernel:
> commit id: 304790c038bc4af4f19774705409db27eafb09fc
> 
> Kernel commit description:
>      Kernel commit description:
>      ubifs: Relax checks in ubifs_validate_entry()
> 
>      With encrypted filenames we store raw binary data, doing
>      string tests is no longer possible.
> 
> ~
> 
> Change-Id: I487ae4d172e228e72ac31d158d668f209142bce0
> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> ---
>   fs/ubifs/replay.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Good catch, thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
