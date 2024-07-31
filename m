Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D2BC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 03:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28AFF88453;
	Wed, 31 Jul 2024 05:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722397289;
	bh=vzGYDgzzSSvHdMqeFyVs1ADcIv3CipOIKkSFfuJrJsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UJ/iEat0lHa0VoZqZ0Ef/yC5wPKM/9P67ma4g5KRcxY0C2Zk1/YO7JmMLGoycfIed
	 VI9J2FCj9gE8LybAfkQKVKVaGufdSqu1xvajVxs9hKfjum5llkKTVlIS7oXUs9aTvN
	 f2l2F2cvuCxo+T7RK8xD1r09ZkBL6ZWXKu3b1Nfhp8zRGjXvk4SIa8XhAdU0TH8fys
	 77d5nsDxVHEnNb4d5lpPesAS+IpLGVx/J0d/rnWLcFGLdS0cDqMUYCE1vwLuHGizAc
	 +XU9zbvc6vnPU8JzpTEBgndXyRw1uN6j2jV/TNl/XowbyhmwBHTVLDuxlwYe8Kj5cE
	 mqSAijNGcs6qw==
Received: from [192.168.1.107] (87-97-105-110.pool.digikabel.hu
 [87.97.105.110])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 91A12883FE;
 Wed, 31 Jul 2024 05:41:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722397287;
 bh=vzGYDgzzSSvHdMqeFyVs1ADcIv3CipOIKkSFfuJrJsQ=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=Kfh4xgu/4p5uuOQa7DPzf9zdF1ghqDMSdwRAxxHks6R6CYdhDzIXNm+jgRGe1P/6R
 umjMzpPxPmblv8an2SH2A0FQqSoEqHH7iqgh7/9yhOTgbsu1M4y9fFTPIwQGGi6UuJ
 /qZ9TuRXP4drUK0oPxeg9pm8xiwgz7z9xMgcNaFpIwB0dxNtVXC1xdw6g1Cg81B2kk
 x+URLBVTeNNhQuyVb9WzdUnJkdZtUfW+bkutJ3Mvg4+IocTMKrcWEZJ2mUwGR/vlX2
 utd5f1G4ip9mpup1Gxwa4tFfbp0XMCdV+GJPy53Jhh5A2Rn69HtSBM38jCa6NJZKDQ
 QYYuEBGOULrPw==
Message-ID: <381c3a16-cae8-5543-1e5e-4551197f709a@denx.de>
Date: Wed, 31 Jul 2024 05:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCHv2 1/3] i2c: imx_lpi2c: Fix a typo in bus_i2c_receive
Content-Language: en-US
To: fedorross@gmail.com, u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
References: <20240730152529.143651-1-fedor.ross@ifm.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240730152529.143651-1-fedor.ross@ifm.com>
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

Hello Fedor,

On 30.07.24 17:25, fedorross@gmail.com wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
> 
> Fix a typo in a debug message. It should be 'for' not 'fot' .
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
> 
> Changes in v2:
> - Add additional '---' below SoB line to separate Cc list. This way it
>    does not get included in the commit message when the patch is applied.

You may also take a look at patman tool in u-boot:/tools/patman

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
