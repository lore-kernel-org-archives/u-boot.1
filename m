Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D91C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 08:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F20487C4C;
	Tue,  5 Mar 2024 09:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SoSahZ5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E321D87C5B; Tue,  5 Mar 2024 09:11:32 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0A987C48
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 09:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.107] (ip-109-42-176-242.web.vodafone.de
 [109.42.176.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 47A853FB5F; 
 Tue,  5 Mar 2024 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709626289;
 bh=GcPYEl1PRLjY2b2V49hHEZlUEcyiJQhbWL7/QUQFiVY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=SoSahZ5R0VbMf33wfFXEwNJP64pdY+CIwAC+hYSiBvnXzARN1q0TC3fT7zyzdLNSN
 6r6i/aXEAczMk+jKdpKkoGiSu+U3BDtYB4kkEdyRFSCgZZEsyjf4bXe9BxOYHOnx0t
 lQPad197smaobRmoTBGVGcq2PAI8bD2h858gcO8NQIPYcskPvv5iPhtL5uX6cVaHPC
 z720CntjV0OoUPXztV0TPUxoQ2BTYZGznkjRfjcNrq8gvdMTlwjAdX8bi7PFM/V2yJ
 pnL6sByooKbC1JCCNUigSpQkCG9qiL43w3y5+Lq+4rFOIYLnAWrslofhfW5Oci/WTn
 q2kL0lxDAw/RA==
Message-ID: <41a27290-5b44-4e8a-8718-8bbe945fd456@canonical.com>
Date: Tue, 5 Mar 2024 09:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] riscv: cpu: improve multi-letter extension detection
 in supports_extension()
Content-Language: en-US, de-DE
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, u-boot@lists.denx.de
References: <20240304232835.3076533-2-conor@kernel.org>
 <da2c1e6b-95c6-4326-a353-3ed32c524b40@gmx.de>
 <20240305-expulsion-pastrami-0a1ca34d96d7@wendy>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240305-expulsion-pastrami-0a1ca34d96d7@wendy>
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

On 3/5/24 08:54, Conor Dooley wrote:
> On Tue, Mar 05, 2024 at 08:34:20AM +0100, Heinrich Schuchardt wrote:
>> On 3/5/24 00:28, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>> According to
>> https://github.com/riscv/riscv-isa-manual/blob/main/src/naming.adoc the
>> ISA string is case insensitive. Why can we assume here that it is lower
>> case?
> 
> The binding does not allow upper-case.

Ok. That is in Linux' 
Documentation/devicetree/bindings/riscv/extensions.yaml.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
