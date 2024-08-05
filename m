Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA29C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 04:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4FD8882C;
	Mon,  5 Aug 2024 06:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722833695;
	bh=woVV8g9wN8C7RnhyTxDuqc1uUzcCpsvLmP66gfluvz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=QXjMOKuk6a1dYbqwoTRfH1Oj1rPpy0IQHPVCBIeaVm955J9tgCFboX9Oqr78RtSSy
	 PG+NAOTbqitchIPukNqeD/0Mzjunm4/5dDC79jMcmhYs2sxshPaM4rIu1YZWudEcX0
	 dBsEifpwZzLl1GUJnnvyWBQhFvyGT3pEdC6TX909KplK/LTIE5dUn0tBz3NEdpTC8u
	 04qL5qPn/3Jm0uSyof7Pe8/a0/MsyUoHN7f4cbiT/HA+4l0YCxEsMZ3ydgEXVDnNma
	 wNWw7NdihXVVFBX5XIcadZUvlN17XO9L53ytA8zanEGjpKdc4Z06FaNrMMRQUmAWXB
	 JVodreCJKl1ng==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A5E0B88027;
 Mon,  5 Aug 2024 06:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722833694;
 bh=woVV8g9wN8C7RnhyTxDuqc1uUzcCpsvLmP66gfluvz4=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=kW1+RjwYG/gIT0IHp2JJ/dk1WAJc4l4qxmsE9/q4x7y/UAli6RNP+WYlHRgBlIMp+
 bB8CJjC6Ey+9HZ6rNf+BPlZtOjRuOHoSm2phUb2mUT+F89xXMNF2zjrbXMGg4VcP2Z
 jIX7hGtmFKhZALVDldPxP8lA3pp/g38h0y+Nzz3RUEH8adIihpeNEHRhASL8po+1pE
 0JbwKlmGIufjGefnTbiXJ9dWG23fL12uP3ZHuOtHYxEzgwf2TbJe3FJ4IoniJsanh6
 EAkRh/Z5pKws7G3Wu4uf+8qn91LFcElYnmFIPLX5Mtb3L0z7ALvYOnaGrPep6dMT8b
 RjQKHUfDOBulg==
Message-ID: <8b367b4a-0208-3b4b-f4c6-ff3b27a7917d@denx.de>
Date: Mon, 5 Aug 2024 06:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 01/11] board: shc: convert to DM_I2C
Content-Language: en-US
To: Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240803161513.486062-1-agust@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
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

Hello Anatolij,

On 03.08.24 18:15, Anatolij Gustschin wrote:
> Conversion to DM_I2C is mandatory, rework to remove
> use of legacy I2C API.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   board/bosch/shc/board.c              | 22 +++++++++++-----------
>   configs/am335x_shc_defconfig         |  4 +++-
>   configs/am335x_shc_ict_defconfig     |  4 +++-
>   configs/am335x_shc_netboot_defconfig |  4 +++-
>   configs/am335x_shc_sdboot_defconfig  |  4 +++-
>   5 files changed, 23 insertions(+), 15 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
