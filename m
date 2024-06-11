Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61E8C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 04:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C79885A2;
	Tue, 11 Jun 2024 06:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718078649;
	bh=haEjPSpVgk9MntttLzE1tWxdGn92YWFEOcye7smKuuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=0JLxPYZpBGDoV8p1dKFz3Nta/4/sxsCw5xX1168oiKGbzl3/llv6VgsPE0Tt2/Nqb
	 Sxvkc6qBLo22zqYCzoPVjaGW6vf6C92UHq9bvAt4rwlO/7Y6MVQZhLX6vknmc3xd7g
	 Hue2l3cucSYcl/DO9S14L864LqagDTwbN/CRUN1G+NoRXIwa2BiRD+sf4n5LPmWeGO
	 F5ap5UbqbrSZbeQ2Q1mSabxu1oSCFbV2j4S2HiS8ejPth7xbcOlu8Cs0CW40TycLlK
	 3MwXTUpF2+abSgg7Uf4UoDbel/9Ae9bxfiMKB92Ha4LqpVbRVSorbRRkCNCi4rRmdH
	 ty5Oy2jbwnViw==
Received: from [192.168.1.107] (87-97-105-197.pool.digikabel.hu
 [87.97.105.197])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6780687E0D;
 Tue, 11 Jun 2024 06:04:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718078648;
 bh=haEjPSpVgk9MntttLzE1tWxdGn92YWFEOcye7smKuuw=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=gwKj0CZjMh/rZHzlbD1F1TFXjpb+BIy+lki8FsOLoak0jLXX63mUJ7rHHf8DuM0Ti
 +XgeSXgsnqJ0favza6as5Y7wIMQkaZANe5Adt1Rfo2iPtiFJV3wD2J76DGS/OHIEWH
 F6iM1TW6ErH4yZtmYKUiHxV3KDoDUODY5onhunJGs0QgMc4opkgYiEiLnCgL8F8AUm
 2LDVjNHImrX9X/Fj3byS0IR9htkrg+R5KuUsr5DhyOKr93Jrpzddsjhew72GqurvTZ
 5PH4d1BQGSidabGzJ60KctwQagbKAfXlYg9LuruHiZuqUAi9cOJU+HDlxHyMamguZR
 evAJNJwe+A+ww==
Message-ID: <2652f2c5-3d9e-bede-3c27-ac6a2d4d1351@denx.de>
Date: Tue, 11 Jun 2024 06:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Content-Language: en-US
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 pro@denx.de
Cc: vasileios.amoiridis@cern.ch, quentin.schulz@cherry.de, u-boot@lists.denx.de
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240610185116.353604-2-vassilisamir@gmail.com>
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

Hello Amoiridis,

On 10.06.24 20:51, Vasileios Amoiridis wrote:
> Add support to save boot count variable in a file in a FAT filesystem.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>   doc/README.bootcount                          | 12 ++---
>   drivers/bootcount/Kconfig                     | 53 +++++++++++++------
>   drivers/bootcount/Makefile                    |  2 +-
>   .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
>   4 files changed, 50 insertions(+), 29 deletions(-)
>   rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko


-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
