Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68395C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 07:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6E6810EA;
	Fri, 28 Mar 2025 08:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=koansoftware.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3318144A; Fri, 28 Mar 2025 08:43:48 +0100 (CET)
Received: from mail.koansoftware.com (mail.koansoftware.com [172.104.12.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A32805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=koansoftware.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.salvini@koansoftware.com
Received: from localhost (localhost [127.0.0.1])
 by mail.koansoftware.com (Postfix) with ESMTP id EE05D4273E;
 Fri, 28 Mar 2025 08:43:43 +0100 (CET)
Received: from mail.koansoftware.com ([127.0.0.1])
 by localhost (mail.koansoftware.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I8M-L3v2ICEA; Fri, 28 Mar 2025 08:43:42 +0100 (CET)
Message-ID: <d4d2f905-5b17-4620-8f25-cdb388eb439c@koansoftware.com>
Date: Fri, 28 Mar 2025 08:43:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected RPi5 Behavior with Saved U-Boot Environment
To: Richard Weinberger <richard@sigma-star.at>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: upstream+uboot@sigma-star.at, Simon Graber <simon.graber@sigma-star.at>,
 mbrugger@suse.com, pbrobinson@gmail.com
References: <3097333.a1USZiQ7eK@anvil>
 <df93a047-2a97-4028-90b3-510b9c75493c@koansoftware.com>
 <2017235.OF7RDaNIJX@anvil>
Content-Language: en-US, it
From: Mauro Salvini <m.salvini@koansoftware.com>
In-Reply-To: <2017235.OF7RDaNIJX@anvil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 27/03/25 17:31, Richard Weinberger wrote:
> On Donnerstag, 27. März 2025 17:24 Mauro Salvini wrote:
>> could be related tho this [1]?
>>
>> I sent this patch some years ago but was never accepted in u-boot tree.
>> But meta-rpi uses it in u-boot recipe [2].
> 
> Uh, good point!
> In our initial experiments we have used meta-raspberrypi but now we don't.
> This would explain it.
> 
> IMHO this patch needs to be reconsidered.
> 

Hi Richard,

glad that the patch was helpful.

Here [1] the original discussion about the patch.

[1] 
https://patchwork.ozlabs.org/project/uboot/patch/20210512123945.25649-1-m.salvini@koansoftware.com/

-- 
Mauro
