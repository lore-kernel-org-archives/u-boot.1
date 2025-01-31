Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FEDC0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 09:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C858F8213D;
	Fri, 31 Jan 2025 10:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D99F8213E; Fri, 31 Jan 2025 10:27:36 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D336E80F70
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 10:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.24.148])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B8C64B4B4284;
 Fri, 31 Jan 2025 10:27:32 +0100 (CET)
Message-ID: <07a8bc30-8709-4d42-bdea-27391a4999d1@freeshell.de>
Date: Fri, 31 Jan 2025 01:27:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LwIP and multiple network interfaces
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <de7bf6b3-fd45-4c8f-a492-bd41db2aa904@freeshell.de>
 <20250102224724.GS3476@bill-the-cat>
 <aa6d5dce-473c-447f-91b9-fe802f0f520d@freeshell.de>
 <20250103014049.GT3476@bill-the-cat>
 <14a9901e-00fd-4a5e-aeb1-ffbe715f8965@freeshell.de>
 <7c20233b-d61a-4114-bbb3-6866bdd5bbf5@linaro.org>
 <69678189-22b5-4372-83a4-0e4637975355@freeshell.de>
 <e3b4fe98-fce5-45e0-970d-d0398e23838d@freeshell.de>
 <8de045d6-bd41-4115-8bba-5632622c724b@linaro.org>
 <94d614d2-40fa-4c5f-82dc-680a6b359a07@freeshell.de>
 <d7c1658a-fae9-4237-b3cc-307a291972ff@linaro.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <d7c1658a-fae9-4237-b3cc-307a291972ff@linaro.org>
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

Hi,

On 1/30/25 02:23, Jerome Forissier wrote:

[snip]

> 
> Please check [1] and let me know if it works for you.
> 
> [1] https://lists.denx.de/pipermail/u-boot/2025-January/578982.html
> 
> Thanks,

Confirmed. I tested each of two network ports on the same Pine64 Star64 
board and it is now working as expected with LwIP. Thanks very much!  -E
