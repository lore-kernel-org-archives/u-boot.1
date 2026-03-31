Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6267AFF60F4
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 17:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7412083E7A;
	Tue, 31 Mar 2026 19:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="G7GQAy34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A91483DBF; Tue, 31 Mar 2026 19:40:06 +0200 (CEST)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5011B83E7A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 19:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 574FC240101
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 19:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1774978801; bh=QxUGgNMra7ogZiTJgvOQfZihEG3wz6jLQMY+mVPce/w=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=G7GQAy34dgxuOb6gngyT1syjsSQKijzsJh0qfhpW3Pxd7r4CPlI8o6BzYfAK1r4wE
 C9w7gyuQ/RonDRYeE0bUHawtClwInp3PevE+iKgcJFihTT8vDD8lsyRtD92kv/ZCS5
 4kO0jTeO+7lbzVM1t9pYmz7UE56Hk4f7jhcFytIQ0jEXYa7SAxrPutM5mykrneURlJ
 oqm93oGAhKxzoLwYt33pkgaUk+hGv2zkt5CKP3QpzJQRiSi6dEZhwGkC8YLyLgrIy2
 z/xIIDf29XmhEsZRgMb8BRrsQiz5oPjPY8t5q+Nytn+ealN9e9kjAmdgdsb58Iyp3/
 sx/5603G3mmMg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4flb3h6PP5z9rxG;
 Tue, 31 Mar 2026 19:40:00 +0200 (CEST)
Message-ID: <37959750-b370-97cc-5f55-e0d6c045a8f0@posteo.net>
Date: Tue, 31 Mar 2026 17:40:01 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] s5p4418_nanopi2: Drop unnecessary BOARD_EARLY_INIT_F usage
To: Tom Rini <trini@konsulko.com>
References: <20260325190031.3428654-1-trini@konsulko.com>
Content-Language: en-US, de-DE
Cc: u-boot@lists.denx.de
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20260325190031.3428654-1-trini@konsulko.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

thank you for the patch. You are right, board_early_init_f can be 
removed. But where is CONFIG_BOARD_EARLY_INIT_F enabled, I didn't found 
it. Have I missed something?

Regards
Stefan

On 25.03.26 20:00, Tom Rini wrote:
> This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
> do-nothing board_early_init_f function. Change to not enabling the
> option and so not needing an empty function. >
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Bosch <stefan_b@posteo.net>
> ---
>   board/friendlyarm/nanopi2/board.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
> index 4dff32e10d6b..ca8ae529ddf4 100644
> --- a/board/friendlyarm/nanopi2/board.c
> +++ b/board/friendlyarm/nanopi2/board.c
> @@ -406,11 +406,6 @@ __exit:
>    * call from u-boot
>    */
>   
> -int board_early_init_f(void)
> -{
> -	return 0;
> -}
> -
>   int board_init(void)
>   {
>   	bd_hwrev_init();
