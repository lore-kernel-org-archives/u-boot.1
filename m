Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2ACC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 04:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DBEC884CA;
	Sun, 11 Aug 2024 06:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723352046;
	bh=hmtiWYvXKUcTm46HbzShEjTKXJ2VUJN0Hs0KVlgFJbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=o+l9jTIBbIHT53byE4wjSQL0Ms43xUXg43YA0/6lR188jS6LLl+Vgx7nj/JlhgRnk
	 1/1mJ07UzcURyRE9cJEZeRIu3aG/gYRa66vS43UioCDhPZFXQ1vTNVkLI6VKTQJmUT
	 E28FI6gMGmmWA3+DicEHKEs3TvZuAq53BJlVoY+xJ7yqR5S61PoMUc6ikpwXi4yS3I
	 KSIBEqB2ZOuSUFMlIneOZTpIa05BTdcDSR4dZq/PKd0dzILLciKL3wzR6ezFhtHfnt
	 XUAPr3WA4A6wPG2LXTi3FxsKlcl3QIg+TYUCVESRxKyWfMBASvjudPg3Pwbfy8db7G
	 ciSAy7TGAzx0w==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3A381884AC;
 Sun, 11 Aug 2024 06:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723352045;
 bh=hmtiWYvXKUcTm46HbzShEjTKXJ2VUJN0Hs0KVlgFJbc=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=qlVSV/lD1PfaaPxbjrj/SevCGVRA5YGy/L52IhbeqkKovY6Bfpv7uXqyiDBjshbS8
 d1BNMVhJ5V9TjnyuQ4zmsVGD76MZ6/HtsHomRCUtMpEtDI1mD5jwMoRcPNas2ex2u7
 dDK1Zl351sN88ufRYzymgVdnV9BzfpDL/GJyQPMYXA1zjT1sBDYiLBUaW8AKoPmb6M
 mmnKEpwiFSGzs9wuCKC5RwmEwusYO8AjDbP78iDuqPrB40Vkg6j11EEvbPQIWyryd1
 V2uhFuHnwUiW/ZBlp5+6AIjrj+8zz8FRQp5jQZU966LENclVA8BZMjN+12PgUjJZPi
 P4J7qxdeZzYXQ==
Message-ID: <0e8382f1-6241-3286-00f7-ae56c8a9cff5@denx.de>
Date: Sun, 11 Aug 2024 06:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V2] ubifs: Call ubifs_iput when ubifs_iget is used
Content-Language: en-US
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Dahl <ada@thorsis.com>
References: <20240810125745.1793642-1-michael@amarulasolutions.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240810125745.1793642-1-michael@amarulasolutions.com>
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

Hello Micahel,

On 10.08.24 14:57, Michael Trimarchi wrote:
> The inode should be freed after a reference is get to avoid
> memory leak
> 
> Tested-by: Alexander Dahl <ada@thorsis.com>
> Link: https://lore.kernel.org/u-boot/b698ec3e-d857-6512-8cc9-4edcab0a41b9@denx.de/T/#t
> Link: https://lore.kernel.org/all/8f3a7059-6330-f332-8e9f-729b853e001e@denx.de/T/
> Co-Developed-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> V1->V2:
> 	- fix compilation problem on super.c
> RFC->V1:
> 	- Heiko gives more points to address on the patch and review it
> 	- Alexander Dahl test on top of his own series reported in the
> 	  commit message
> 	- add leak on super.c file too from Heiko
> ---
>   fs/ubifs/super.c | 1 +
>   fs/ubifs/ubifs.c | 9 ++++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)

Thanks!

I get:

WARNING: 'Co-developed-by:' is the preferred signature form
#126:
Co-Developed-by: Heiko Schocher <hs@denx.de>

Fixed this when I applied the patch, hope this is okay for you!
Azure build started.

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
