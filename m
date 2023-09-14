Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CF2EEAA40
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 14:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1AD187018;
	Thu, 14 Sep 2023 16:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LmWKKSaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508848703C; Thu, 14 Sep 2023 16:15:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CDD286FFA
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 16:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694700907; x=1695305707; i=xypron.glpk@gmx.de;
 bh=KfEt52fOWdgWIx5qqwcFtunYQRyqtcrzsZ7vrdmJThU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LmWKKSaN7QKIOBFRvt1z8NhpbgBjC3rFXxb5KJbcIPvcA9ikp4mzVntqsCCoikLqcYdxdnwI7su
 WAmLetHYAUDd2vjUh0wDqqbO7Mevdj1nI9k/sRccLH466e5yWy5v636ZnKs1JXn3ylmcLuxecsCHp
 SyBG9wO/ZSrkJNNJumBDGcgL3dijX4dNHqDxvpNIZBFc6iVBmp9V1NvMZHB9CjtdZktDf/64i1EpO
 EmpEXsHC9OPQy2c9qbSea0iufbPpH7JuGbVgdc7h+/4LlBLqgPGUaITWdyhaB4uTFHUsp8BmywQy0
 7B09P2j4NSsp9hXlHElXq80+zHEJRXs9oruQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1raH5Q2w3z-00v58G; Thu, 14
 Sep 2023 16:15:07 +0200
Message-ID: <ea8895a7-4812-4c65-8c63-8051237ad77f@gmx.de>
Date: Thu, 14 Sep 2023 16:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] SPL EBBR - EFI System Partition support
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230914100821.755904-1-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNLGRsuNo4D4Qyr5fugWGnUVjxK08ZFOfxIg5iuzAVYc6k04EO0
 FBdMraDXdx1tGEz+CCcpyavNExtXRXxpu322G4/Dm4pGOEjb66tYnVtsmLttFCEDS14Jzhn
 838Xcr7GRjU5oU6KXK9njAGJ6d2s4R4U40vf4/9m6djB6uQQdH1QN5+0s9INUGbQ/Qed1LY
 QtKGQa1htdqgH/dqATrYQ==
UI-OutboundReport: notjunk:1;M01:P0:5tE5UCaucoM=;J/lXz3Vuh7lBmOHNxTuUAYsdNjv
 gYEgG3wZsuQc6z/AlcU0FVtp3QtsXpGy5eQo5RrtFd9fYCzp61a8G6srhYV9iWJnAGySDCno5
 UfI6oCpheMF5mCuJ+LbOkR5BhZY3Bt6Vnio4gafdQvMpvI9JfyoVbVgnbe2UXi8pSleChlNdK
 eLLmYUSl/yH5jrGFLbUWwufPLOZxIFxJFfOMwIcaZ8g1xcuCncM0xdJx4xstGxHMAXQuna3XE
 hOSapuA4G0eklMY8fndPghPVz+6F1oShZ8l3R40YfqCt3lHScZNbOkoFxZrzIdrfCV33wwPYb
 zCLbSJXcmEUz725wc33FHyhDPw1QYL4z/wCUdyu/viWg5TnJ/Kj/dEObZu9WXsvTb28Ur7/Qd
 ccfSa24Th7Q9E5h2RyUTkmw2Q1YhUA6NPFsq8B4QIx7hPPdtiLViUcAdCTBN1tBnz9TVlp419
 rLm8qaTlHHcIC2qAQ+8359smnBXN6MduST3je1/PRJ755u1YZ8m62D2JEc6Pw3uQ9yrED9j2S
 ZUjk5JHWVkQ6On54WdYh5c78Zwj+1+g5qvk0eKOPcooidgory2XG+FpI85Hn84rN4kvrUdhrU
 tQH2hq/U2RC1VCfcVdaQci4/aKfD4EFibHAlvyLUlbo+E06DXPEAnXdd7WwRccu937TT5o1cg
 Nqd9DfqValTjyIBPnnzx3whwwR6A5mV+RH7FeD77DG8ZlTeGh1l3qxrY1zVH1WQJc7UqWs8fK
 3ju3WAUrO/gi45sh3aiI1dWenWwGDSwBYrTc3nACBBrcBLeC3iCc83z29OG5Hg1LUUw3P6PVP
 QrmZyvDK23A5IIqZHCgSlzIlZ6xRJIi4oEVm0CBiubDWA7vAD7oiySvg5LptpRqUMyrgJSykS
 6aGYGhhaPz6sO6REOfuYSJRv9yflJUddobrj2GF5StvI2Vc2aYv9NEYIZcfml8bTtj3YMonZd
 lA7YGUozV7gLhcT0/NWYHzp4Ow4=
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

On 14.09.23 12:08, Mayuresh Chitale wrote:
> This series adds support to locate an EFI System Partition on a disk and
> boot the next stage from such a parition if found. The next stage image
> is expected to be under the FIRMWARE directory as described in the EBBR
> specification [1]. Also update the spl_blk_fs and spl_fat drivers to
> prefer booting from ESP and fall back to the configured parition in
> case of a failure.
>
> These patches are built on top of the following series from Sean Anderso=
n:
> https://lists.denx.de/pipermail/u-boot/2023-August/525665.html
>
> [1] : https://github.com/ARM-software/ebbr/blob/854ba0e68590102667b84a5b=
a4e0b076a3f5f2cb/source/chapter4-firmware-media.rst

Hello Sean,

your series [1] is in status "changes requested". Will a new version
come up soon, or can this change go first?

Best regards

Heinrich


>
> The patches are also present in the branch below:
> https://github.com/mdchitale/u-boot/tree/mchitale_spl_ebbr_v1
>
> Mayuresh Chitale (2):
>    part: Add a function to find ESP partition
>    spl: Add support for booting from ESP
>
>   common/spl/Kconfig      |  7 +++++
>   common/spl/spl_blk_fs.c | 61 +++++++++++++++++++++++++++++------------
>   common/spl/spl_fat.c    | 34 ++++++++++++++++++++---
>   disk/part.c             | 16 +++++++++++
>   include/part.h          | 10 +++++++
>   5 files changed, 107 insertions(+), 21 deletions(-)
>

