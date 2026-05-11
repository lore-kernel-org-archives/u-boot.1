Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1491CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4121C846CA;
	Mon, 11 May 2026 11:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2VXuo3Ds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDFD846CB; Mon, 11 May 2026 11:32:38 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07068846B0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8A52E4E42BCB;
 Mon, 11 May 2026 09:32:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6018D60646;
 Mon, 11 May 2026 09:32:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7CB7C11AE870A; 
 Mon, 11 May 2026 11:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778491954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=UwhxSTUg/2PfbitXd6APW3F1bEy+stqNbYlvVOstu6o=;
 b=2VXuo3DsQHOJ2oSar0HSVqdAe/40yNoXlniVeVxAqTAg/FLXjIW28KStY2ubhPu4DfUoj5
 PZaxCSwmDnVx6NwFuapPIhhHwFEUHT2VpgOdnCZetA3RSSy90B0Wl31v1Iu7dKzCDy15zL
 tepZ0i30Tlm9uvwhzUfpmv8t+QRsR+AUJ7JxCUrxflLefBhoCBuTwMUvlN44mbb9MBLOnx
 NLIzSpLnQm1RLDH/ZafxhyxeESvwzjblyA6tMD5ATaztuKnMgB799YkYCXbUpapAig0Wrh
 8UrKVG6CWWQqpWDAsDtaUVdNWYi6cJn8PL4fbOxom3jb+wxN4ryzM3CZDX67rA==
Message-ID: <358e2645-1f64-4de8-8377-0177645e9ccd@bootlin.com>
Date: Mon, 11 May 2026 11:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] test: fs: Use shared generate_file from utils
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org
References: <20260511085857.3933053-1-aristo.chen@canonical.com>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260511085857.3933053-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

On 5/11/26 10:58, Aristo Chen wrote:
> test_fs/test_erofs.py and test_fs/test_squashfs/sqfs_common.py both
> defined a generate_file() helper that writes a file of a given size
> filled with 'x'. The two functions were functionally identical and
> differed only in parameter names and docstrings.
> 
> Move the helper into the existing test/py/utils.py module, which is
> the established home for generic test utilities (md5sum_file,
> PersistentRandomFile, attempt_to_open_file). Update both call sites
> to use it.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   test/py/tests/test_fs/test_erofs.py           | 16 ++++----------
>   .../test_fs/test_squashfs/sqfs_common.py      | 22 +++++--------------
>   test/py/utils.py                              | 13 +++++++++++
>   3 files changed, 22 insertions(+), 29 deletions(-)
(...)

Thanks for the patch!

Reviewed-by: joaomarcos.costa@bootlin.com
-- 
Best regards,
João Marcos Costa
