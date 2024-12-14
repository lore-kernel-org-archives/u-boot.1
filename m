Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AEFE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 13:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B3780050;
	Sun, 15 Dec 2024 14:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EE080073; Sat, 14 Dec 2024 21:52:11 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B0F80066
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 21:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown
 [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4FF5FB220687;
 Sat, 14 Dec 2024 21:52:07 +0100 (CET)
Message-ID: <4d74d11e-e457-48bf-99fb-6637179f70e9@freeshell.de>
Date: Sat, 14 Dec 2024 12:52:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] gitlab: Add a StarFive VisionFive2 to the sjg lab
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
References: <20241214182024.1954974-1-sjg@chromium.org>
 <20241214182024.1954974-6-sjg@chromium.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20241214182024.1954974-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 15 Dec 2024 14:07:13 +0100
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



On 12/14/24 10:20, Simon Glass wrote:
> I have one of these boards loaded with Ubuntu 24.10 (64-bit). Add an
> entry for it so that it can be used for testing.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   .gitlab-ci.yml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index f379c11a1ba..33ec4b2e417 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -691,3 +691,8 @@ nyan-big:
>     variables:
>       ROLE: nyan-big
>     <<: *lab_dfn
> +
> +vision5:
> +  variables:
> +    ROLE: vision5
> +  <<: *lab_dfn

It is "visionfive2" not "vision5". There exists a JH7100 CPU based board 
the StarFive VisionFive, so this is not appropriate to name the StarFive 
VisionFive2 (JH7110 CPU based) as "vision5".

-E
