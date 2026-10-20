Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE996606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oPswyFxu;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=GBcZP3nR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16C8860822;
	Tue, 20 Oct 2026 10:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TC8O83oS_3uW; Tue, 20 Oct 2026 10:44:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 516566083C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792493079;
	b=CnBwd2Zt365vUlWeWxecCKrARAQuq7M/B0UU7HNmU/zCnWW33dKLVTMfxuN+FSj5h5iD
	 XxDy9DSNHkrhwcoqD9J8eCL94WCisdLgWbzavE6XOMEGmYUkvb7X+SItPGMqA/qP0FByK
	 fUoUYkCU90LFw38MLYoS7miod9IWOtHocNrcOnVSbCPin6aYkTKTNjFZQs7HdudOEJxk2
	 7An+F6D7yk66aN+UMVH2yR3JvYiEY/sv1IYfNQ7uQxl/l2Vnc7cuM4DQzvIBbrClMKULw
	 zbx4he8XzwD1y4Nzk7ADRQjGaV0MBdgoz6NUQduPqG4n50aHQZfh8P1MG5eOT+RNyUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792493079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MJaTMorCF5/DunmlqeovebWRMif/GM+laCqVDegfcMQ=;
	b=NiKhCKMx+yQa27msG6K92FfnPdRnowKkfSpNE6taqPTAQn799/XAAb0dg6UkGtcJLp0o
	 x7ou/bD/tTP9DDiy32R2aUctK4Gp4j+E72+5zT3s7B/9Yts5ryCYvAD5rfr0eNuGUZuWx
	 9aMNjNQUg9CZoIYTY1wu00+UNL5dfuqKBSzDFjlb1j2FLrsRJxfrv6+1laskApJjGpOtg
	 s8Sw6gAHHm9NZNO4TlPaWJd95AY1kgmZMfOudgFgR3GQ0gWX0E0KPPk2+7f9CMKKh4q+v
	 G/7CDTiAM5zp1OMmQASGH8sd8JcGQEgqZwWngoTtbJkfcJG2TfWa9uTtzX1Jo6xTUmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792493079;
	bh=MJaTMorCF5/DunmlqeovebWRMif/GM+laCqVDegfcMQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPswyFxuHF56Kre34SRFaThl8hBhXDYEXkvJaFxwBCtg9hbvlSoFsMsaEf9atw99I
	 n7YeNKjNpOG+EUt5hKf0FydwVDc6UucmNsmwLGEIHjxH2YDDmcCr+LYqRyowrGi7bg
	 9OF8YzcX5mXGo0bnBaG3nxIpZXxUfNqcy6C51lEleHiV2K+k+ymLS+cRhS02uUZBav
	 G4Ao6TvHjgERGVZAKNyJrq6H2e8vQZocBMgj4QdoL1dNV3wo+zJbWeSLIMA+xRY0I6
	 G7FCXsh0ny2oqklEukdBmPYacUT7Zp2lUKfacQDRVdeZXApYikQuMs22/8NC5ipL1J
	 f0ZnPX8cuP63A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 516566083C;
	Tue, 20 Oct 2026 10:44:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E3FE1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7014A40119
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30YTRv9x6xZj for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:44:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A2C78400FC
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792493076;
 b=nbNDqyt3rdCer2asSvvvU2ac7O7i3vhRMUX/EymqEtPZaU/F3m5UVprZQ/zWxv7eRNO9
 25YwGnQNl5WXflqROUGr+jbpLW/fdQZF8y+8xoKCLIlMz9cZcK/7r728bitETHX1T2Jg5
 gj+MxaAEFFEGP4mMoygPwbn9cGriyIvt4dlI0SaCVwboq/qxIsg+gp9HV2KBVkTkwOatx
 kOMxYkLfBty4Gzq6rdEVEba0eDgQ7KDCOqurZLFkNpKqxebVplts7jFl+rj/anurfPaZa
 2EndNSJziYgLAT6JqnEI8Qlz5kYdwx9/0kdau9Bki0dZwuMszeJWwZNZPb9B3CZsLnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792493076;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=MJaTMorCF5/DunmlqeovebWRMif/GM+laCqVDegfcMQ=;
 b=htF8jDJG5yvI3YylW+BUlOayKHJ3hiKLulV+AelzF3uStzU2hIZ6QbNz5Dfgol/KPXIn
 8Ns8EMEX+ksm/VYjYfGvqX7ez+1vGfM4ij8ut9LcGyvkaAM6G3K/zmVUW8E/4xw1af39m
 UdX9j87dta1k/NwkRqkGssOBoEa4BnWJJSoZxSlzh7i8zk2IlEnMaEYB/mcUp6aDluMrs
 evJvUNNPJUalC+ti4zUkVXe7F/VgmxnagKhiECm2pvYL8m7A9gpu+f3oTDfwnuIKZiKB+
 fBwxYlkesevVrL7R4HZKF2E36aoXLe7wch8oiNVvWrkEWXb8c7S+6QQl+v1P/ijZPhA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=GBcZP3nR; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=GBcZP3nR
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2C78400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC72B109E6E; Tue, 20 Oct 2026 12:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792493070;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=MJaTMorCF5/DunmlqeovebWRMif/GM+laCqVDegfcMQ=;
 b=GBcZP3nRLOG0Ls9ZboKsRx6LmD4+ZTu1llVbcozKl1kHwSZ3BNJIswvzXaOeVge/nOrMe1
 OZMV5H8yXBiCuf6+XbOjErehBHoIklkfbrjoofmrUudOFZFyFMplcp0kLq44s71lYsBs/4
 h8yQqsm0WSm6y6x0ItRoYwsM6MnN9PJfkLyoOm+DR+FInfVucPdRK8LbfpJd2N/NrgfWBk
 5qlnOWEgmrDicZYLWPvnKGW5uFcRpWU4pi5qff2IcKPUDnYQO0rFXTEJO7esYfenlaifDz
 uhdh2ORByNk3WLSshOB5lp2lsASQ6XPcyKIaiN5D84/3M0UKVV2H6pYezEzbtQ==
Message-ID: <f92b2f13-728f-4c06-b3ea-70ef23b1de56@nabladev.com>
Date: Tue, 20 Oct 2026 12:44:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Fiona Klute <fiona.klute@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261020092137.242656-1-fiona.klute@gmx.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261020092137.242656-1-fiona.klute@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 11:21 AM, Fiona Klute wrote:
> CONFIG_ENV_WRITEABLE_LIST only restricts loading stored environment,
> not runtime modification e.g. using "env set", while the Kconfig
> description implied otherwise. Describe the actual behavior, and add a
> note in the documentation.
> 
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>   doc/develop/environment.rst | 7 +++++++
>   env/Kconfig                 | 5 +++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/develop/environment.rst b/doc/develop/environment.rst
> index a7ed4aab0a5..e7cf6de3586 100644
> --- a/doc/develop/environment.rst
> +++ b/doc/develop/environment.rst
> @@ -89,3 +89,10 @@ an association in the static list.
>   If CONFIG_REGEX is defined, the variable name is evaluated as a regular
>   expression. This allows multiple variables to define the same flags without
>   explicitly listing them all.
> +
> +If CONFIG_ENV_WRITEABLE_LIST is defined, only environment variables
> +which explicitly set the 'w' writeable flag can be written

... can be loaded from  ... (not ... written from ...)

> from stored
> +environment. It restricts only environment loading, not runtime
> +modification using "env set", etc. Non-writable variables can still be
> +written to stored environment by external tools (e.g. ``fw_setenv``
> +from a running OS), but will be ignored when loading the environment.

Even the U-Boot 'env save' stores the entire environment into external 
storage. The loading of environment then filters out the relevant 
entries (the writeable ones) and imports only those, while the rest of 
the entries are default from the built-in environment.

It might be good to also include a note, that it is strongly suggested 
to have U-Boot prompt access restricted, because if attacker can access 
the prompt, it is game over for any security.

> diff --git a/env/Kconfig b/env/Kconfig
> index c6df09a3349..70f6cca701c 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -897,8 +897,9 @@ config ENV_WRITEABLE_LIST
>   	select ENV_APPEND
>   	help
>   	  If defined, only environment variables which explicitly set the 'w'
> -	  writeable flag can be written and modified at runtime. No variables
> -	  can be otherwise created, written or imported into the environment.
> +	  writeable flag can be written from stored environment. This

s@written from@loaded from@

> +	  restricts only environment loading, not runtime modification using
> +	  "env set", etc.
>   
>   config ENV_ACCESS_IGNORE_FORCE
>   	bool "Block forced environment operations"

Thank you !
