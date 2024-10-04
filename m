Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B392CFA774
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F58688B0B;
	Fri,  4 Oct 2024 14:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728045157;
	bh=RQzwKiM2+JSxXUUg5xLONzl6pHJVc3RZAWUUFGjkoh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ukHvrs7VIjA8G9FO4iMqUE3m+J/QMB9+kz/evmpYooFeZM39IwYvJK9QMdRpRsm+k
	 AE+ehbgPpSmXs2bESHfVOkX/3WyC2lEgGVfZl6ohBM6ozkLiac4JcOgdEdkVdT34Iq
	 11I3sfTcB+ZxV9WFLAgN6TAQFeqbG9mRTZimZXHBJQaFYjjErM8HYm4Gj08MSRvMPy
	 QZrpljVTu366NBA9T8nc4mmlhQyo88p6BHtMZ9Hiq0z9C/GXccOrwB0snxabShzrWG
	 jjTEzTE/RxwnsfM6R+tkX/4PBqd/uvlXyXcE4XRmLF6NPPKR4iSk5v8L6jULH+ULUd
	 +qLt/w4GAFsYw==
Received: from mail.denx.de (unknown
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: festevam@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A1E5788AE8;
 Fri,  4 Oct 2024 14:32:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728045157;
 bh=RQzwKiM2+JSxXUUg5xLONzl6pHJVc3RZAWUUFGjkoh8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=z0HOhRs1v1JuJBCpp6kKNu2prgD/ahylhgrPZmu/u442XRmE7F4IZu/NRuXPRTh59
 +QYrKdxEAubihdUMmiOyV8sJNSzvGuds63rVSlFZ6q8qa8+a8NPUXOz7ga/B2nU+ZH
 rKwhcijv4BIHZAHGxOMgjUliuyw/9jWkNHQ6yBFSMM9S0vSsyyt/ac/2bVIEFsjJtL
 t8KaAbRTDwDfAbcGwT5ZzYInJktpHRukIg0jabcw6qfNKeorhZ2gf7bCnwC6akt/uP
 jCL94kr8qERT2w3RcJcmMJNVk9d01FNv8XFrsLzWOqQBz5j9fG3NZ9a2tVslQWCp1V
 I2fOwQddtjomA==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Oct 2024 09:32:36 -0300
From: Fabio Estevam <festevam@denx.de>
To: Stefan Roese <sr@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, jh80.chung@samsung.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] da9063: Add watchdog support
In-Reply-To: <3ec25b5a-2c9b-46fe-a9b9-0b99f72d83a9@denx.de>
References: <20240917135550.3164425-1-festevam@gmail.com>
 <3ec25b5a-2c9b-46fe-a9b9-0b99f72d83a9@denx.de>
Message-ID: <5293f5a0d44059960aa2d5e8b114456f@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
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

Hi Stefan,

On 20/09/2024 07:00, Stefan Roese wrote:

>> Changes since v2:
>> - Use u8 instead of char. (Stefan)
>> - Keep the Copyright header from Linux. (Stfan)
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Would it be OK if I take this patch via the u-boot-imx tree?

I have a patch that adds the DA9063 watchdog support to the imx6q-lxr2 
board.

Thanks,

Fabio Estevam
