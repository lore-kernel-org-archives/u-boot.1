Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B0CC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 13:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65511886E7;
	Wed, 17 Jul 2024 15:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="BzWJF9Ga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5757888A1F; Wed, 17 Jul 2024 15:29:05 +0200 (CEST)
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19ED188621
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 15:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
 by shout01.mail.de (Postfix) with ESMTP id AB2DD241F3F;
 Wed, 17 Jul 2024 15:29:02 +0200 (CEST)
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
 by postfix01.mail.de (Postfix) with ESMTP id 9204380298;
 Wed, 17 Jul 2024 15:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721222942;
 bh=u2XHUqtb4+8zz86WksVJIqb3uga+Vb79Ldkkz5jrvxY=;
 h=Message-ID:Date:Subject:To:From:From:To:CC:Subject:Reply-To;
 b=BzWJF9Gako0dmxM4x/53vn8CWyqwJF28IYLJXpSWXn8r9gCsI4pZHdsHEcLhr8AhO
 kauH6WQoXjVsbGHCy7yEaJdwzcqJisc0/TH80q70H7bneR9XE5ehwcqS7dhYqY/Yrl
 ZmgeMDjoU+JGoDAr/nDVSTPWMYTiL4DaINkAnN9qhZeowaMVAZEyCt+aaFjZM+bBxh
 eaDpgJ+5ysd5Yt3sd/nzOnHEEsk5hHBtC/a2wOfoFF+aWb2Mdv5a1DQ3v7uy51WspV
 te1ioMQopPKxAxWo1jLSAcazmkczwuWdrJgAycN49/fe0/IQu+A/QPHaTdcnJmJIZp
 wiyB61pdethRA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 50F2A241232;
 Wed, 17 Jul 2024 15:29:02 +0200 (CEST)
Message-ID: <1e11b0ad-c46e-45a8-835f-6367b9cce539@mail.de>
Date: Wed, 17 Jul 2024 15:29:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] test/py/requirements.txt: Bump setuptools to 70.0.0
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240715184527.560645-1-trini@konsulko.com>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <20240715184527.560645-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 968
X-purgate-ID: 154282::1721222942-BE52C878-89E7305B/0/0
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

Hi Tom,

Am 15.07.2024 um 20:45 schrieb Tom Rini:
> There is some potential security issue resolved by upgrading to the
> latest here.
> 
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   test/py/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/py/requirements.txt b/test/py/requirements.txt
> index c1dd636931f7..757b4d70d170 100644
> --- a/test/py/requirements.txt
> +++ b/test/py/requirements.txt
> @@ -21,7 +21,7 @@ pytest-xdist==2.5.0
>   python-mimeparse==1.6.0
>   python-subunit==1.3.0
>   requests==2.32.2
> -setuptools==65.5.1
> +setuptools==70.0.0
>   six==1.16.0
>   testtools==2.3.0
>   traceback2==1.4.0

There is an even newer version v70.3.0 [1] which includes some
bugfixes compared to v70.0.0 [2].

Cheers,
Sebastian

Links:
[1] https://pypi.org/project/setuptools/70.3.0/
[2] https://setuptools.pypa.io/en/stable/history.html
