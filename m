Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A38C54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 04:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FE287CF2;
	Sat, 23 Mar 2024 05:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711169587;
	bh=nB8VW0P5+yKgs3wIa3daHYrW2VFzvA47f/kGM+qb0TU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Qa/KEXO1dxwtLwlYDyQrQERQOzfqe8GVnHof1SKIGihH5sTJK3cnEZjiRfJ3e5gQA
	 hA5kbbegZ2U/C74PG2+4MNuNj8yHmjDM65bHPGQFXHuQUmHS0rqVYTPfK/8ytnp7sW
	 HuSQXKOQ69Y5RgqGDFcMH26B8oHcHXpDE+G+fvVztndW1Q2PXkro02Y4eTSKAd02Um
	 hcXHjWFyeKe8v1McijRk63p9jSoksXUBDmCFXHSK6sif86fDKv8UKjZzKGwCek0JIY
	 JkpJav04evmsblf8EObWwfkGRIRmSG85eYTSJUzdr1dlUDVwbx5sAM6cJZ6TMWRl82
	 Xfr6js84XrnLA==
Received: from [192.168.1.107] (82-131-203-241.pool.digikabel.hu
 [82.131.203.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CD7FA87B35;
 Sat, 23 Mar 2024 05:53:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711169586;
 bh=nB8VW0P5+yKgs3wIa3daHYrW2VFzvA47f/kGM+qb0TU=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=ilKrvqP7FDMpdhve+u+BJ6KSmtNmnGLUpMtN7InXVeOJ0pBfhYLxCpcJBq3RiOwE7
 9PgGrtVE6DPBtmqjnZIZLHzWllmloU/kjsnYmw4oZXlff0c4efQPllmSgeQFNJSCHl
 SvFJu2Uzkys6zXFZ+L5wEULWPRKnugjpKR3H1LLWDTJ1aLSLBAfSclktSO6BzRjY1A
 o7rXwTQP9IzSfr2O/kscbaAfw3Sfh085Ow57eiFxwny63ItgyVVx9fgdsCIYdtmROd
 zlwUa6VwsJKsOR56Ncarqjf5AD/u3+SEPXCzvXFQN2w3w9x3rtxWpWfpSbsljJX/dO
 x1J78MU+Cs8lQ==
Message-ID: <583a638f-d913-4e43-239d-941d00423c6d@denx.de>
Date: Sat, 23 Mar 2024 05:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 1/6] ubi: allow to read from volume with offset
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, kmpark@infradead.org, joe.hershberger@ni.com,
 dunaev@tecon.ru, sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
 <20240306134906.1179285-2-avromanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240306134906.1179285-2-avromanov@salutedevices.com>
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

Hello Alexey,

On 06.03.24 14:49, Alexey Romanov wrote:
> Now user can pass an additional parameter 'offset'
> to ubi_volume_read() function.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   cmd/ubi.c           | 6 +++---
>   env/ubi.c           | 6 +++---
>   include/ubi_uboot.h | 2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>
Acked-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
