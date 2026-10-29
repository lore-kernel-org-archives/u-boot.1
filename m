Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDB606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z7SLp2lP;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qkaHcgK+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDA2840A91;
	Thu, 29 Oct 2026 23:27:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UTX7XZmly2Li; Thu, 29 Oct 2026 23:27:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BE2040A8C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793316433;
	b=YF15xqjN9NGUbtfJ/LZlSSU+rm2tAfEo4BnYBN/g5DuclyFNJ0Q5qMjfno1pR2FPZtdk
	 1fREfp57HQEJ/Rcm+xVVFmDH2Y+gkoUiynzcyjiKn05yMM6Dp4L8Znnt2pCPQCDNnHtYA
	 cA6WYOOZ97hAJkNEJONlCQyA8OVh++br1eDvyRczjTiDXlGafviqYnvrR1HA7GKqxoORt
	 UTY+nHJgu9FQ/96xUyzZ63TWanU7lOGiaRB8c69p3m62RlEQMEIuFfeANk2CXjan4Kfoy
	 DMQt07+8fpabUg1jaxf//4nhCkVkNo3JLgs5OHC52WFmoXq2mmD5Tq7dGylanJ2RsUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793316433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=f1Ak0cYdZiQtBg679rgy60dJ7K+duqf7gMSgYP0Nzqs=;
	b=XD3REoIcDei+AAe6pFeMvTTsB4//JiWC4/TW18j1Gx1Nl+y+1+YNOmcRZ7soRZZdzbz0
	 E6EmG83dSX2dh0I8zyxG000roZ3NzaPWFFokfITlPj1JC+S1ho79nxyET3i+bJAtlgD0p
	 VH5zDdrmRdy9EiOxdMOiNma4f3bDxdghD9WZxaLdSgvh/k7LQexaOtDSS6FfxPLMnotTR
	 8jGc9KCxE/Dn7JpN/t1L+Od8oCraQhUjS3ncECS5GLFRSrh7TXDtUNEhba3wDpawDSNz3
	 s5RwzVGd8Q6zWQIjZXHS+cBvJvS0HKlb6kXXZ4yPTk1tpr6RLaC/a0qhvNu4TySZuhg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qkaHcgK+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793316433;
	bh=f1Ak0cYdZiQtBg679rgy60dJ7K+duqf7gMSgYP0Nzqs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z7SLp2lPUDIjd60Ho5C5iZqoBnm5UTaJZl+JvMTZUsk14umcB9c69oehAP+fbdW6w
	 IEJ/74vm2IPKq1LIQfzTzvxkuKj5JXpqdUO1zYeV1ks+W2mTZqA594zW/pn7V5JyAI
	 THEs2C+kn6wT1Y2TZsSurs2uRQ5B5DfRF9XtuNhOzKBJM9aLK8+1cU7CiZU49jovDB
	 W5+f6vDqdSSIkYVrbvsY/yHXcdWp4WEvdrjPejcatK/PqGzsYUmAkfYJ9nv4NIzpER
	 L74nnTQ5lYwgmQSmDGzH1dfTL7ewK6dXPlgNTj4s9XRS8YT/HEgvh1K0cVpI+MG+g9
	 kEO5a6z6al7Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BE2040A8C;
	Thu, 29 Oct 2026 23:27:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BD151DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C8E440A8C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:27:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2wziuhOkh0Rg for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 23:27:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1BDCB40A88
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793316430;
 b=pbB4VxZyF5PNMpRyPshifxAcxVZ5qXoKcZI4NirrNFpmU6Qk5kgSd5j2gzCsIH7I1g8k
 nHT/loG4cplRn+htoKauz5BgEYA5MP4i/iHuk91+kmW14u68Y+xWFzNgbfY8TMjzzNGsl
 oPD5q62fg5euEQnHZI+kDjGE3802SHVw3OABbBrnMlA/PHOpsI7RTWM5KEaCiZ6CLW1UD
 +8L2jLPxuzT/EnoOrOiZAQcNtnjYYJ+MmyVczEEmVztUQv6SXi7dFO/8MeYB+1y13L0oK
 uZjVB+HRr+lLwdVYuGRipPL6eD5tnEW0r+S3efDCZu5LxjTeU0nEp/zV7PQitLlKnLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793316430;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=f1Ak0cYdZiQtBg679rgy60dJ7K+duqf7gMSgYP0Nzqs=;
 b=MS+qwgDGdbN9VeHouvgsg9xPiGVuHMDBBT2W4WF7MjWLzwqRq6kU82uWjBGajK6WTSBF
 nOhmHTL9evLZRnMBkiRwlLsnkl99Rq+wjwos7U8cX1F2WnmxaHO9fE7CRsdLuX/7n89tY
 WK3omCVcM1937iXMPmsNHL6QQKuxp79U6Xqav5eOQxLcpbNoxWBFwkLJ5snalzZc1LyfJ
 5QBCKnonYqq2mPmdHRym4seD2KXb129DCwQS5LZKFJA0krBzUUHYNp4M/kobEimmNQKzE
 nhcPPDWaDjv1/b65nEo9lBwRivZGuO11MwCAJRkzREmdbKpACXyfm6rGDqEbcIHEKNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=qkaHcgK+; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=qkaHcgK+
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BDCB40A88
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793316412; x=1793921212; i=xypron.glpk@gmx.de;
 bh=f1Ak0cYdZiQtBg679rgy60dJ7K+duqf7gMSgYP0Nzqs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qkaHcgK+OiiK4Zhm8hY9WrzGnQT2NIGbHXUKf/pNREHwaxdULOe8U9ijxZO0yd6s
 VCzAzpK4odve4Gy71K09mFuRU/5p6XX3deNykyzCmhPyJ9XJDfEl36ZSnOrI4D65W
 x31xoZ+D7bWzyelXp4rkCRkLLYdOTKHyD2CCJZNHunxoMWbzp6Q3M0IjfHFTmRr+y
 PgICqkPaReOxV4QrAXACc1HgdpAR2M0mu6zUIJ6pkIZg7sCqwPaC3MP18TFZyXBxu
 HLKjoxf23IXcUNuHctMkv4oEAufPxaYyE9uP5eZXn1ShYi1Li4fCMz6xcVcgK3Xsj
 7u3AuDqSQ3N2FKtq7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1x7w0n0rUr-00VmSN; Fri, 30
 Oct 2026 00:26:52 +0100
Message-ID: <980bde4c-b077-4291-9cf9-30fe59526ff9@gmx.de>
Date: Fri, 30 Oct 2026 00:26:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: sandbox: Enable binop command
To: "Maxin B. John" <maxin.john@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 u-boot@lists.u-boot-project.org
References: <20261029173443.1495866-1-maxin.john@gmail.com>
 <20261029173443.1495866-2-maxin.john@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261029173443.1495866-2-maxin.john@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JgwmzvpCN0WsZ2mqXzyyZdypGqVImmJ0ULjb1g7xHjF5Jvlaq9P
 tJhCmOrrZEHxbvIdYkm9RMDU3tsNd36ymR4nsKKU8Q16Jy5XrnPhFuXbmyJaxlx7ZeK0qCf
 RgihJTQWjMTijugjcNfOGEb3zAl5ehu1H9h9CDcrBTZHvue2TJCPpf6n925ZmrEk1bWdW7x
 SVfHxBCK4SujHWtYsyo6A==
UI-OutboundReport: notjunk:1;M01:P0:Idrnt5M5FZk=;BnND46cdJbBHkUl73RVVVb+Vxjo
 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
 J5lpfhNEXRafKq2UEYE08Kwt89RQ==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 18:34, Maxin B. John wrote:
> Turn on CMD_BINOP for sandbox and sandbox64 so the binop tests are
> built and run in CI on both 32-bit and 64-bit builds.
>=20
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>

Which tests? I could not find any depending on CONFIG_CMD_BINOP.

HTML documentation for the command does not exist.
The online documentation leaves the user clueless:

Usage:
binop op count [*]src1 [*]src2 [[*]dest]
     - compute binary operation of data at/in src1 and
       src2 (either *memaddr, env var name or hex string)
       and store result in/at dest, where op is one of
       xor, or, and.

What is count good for?
What should a variable contain?

Can we simply eliminate the command? It is only used by a single board.

When I see comments like these in the code I am inclined to remove the=20
board completely:

drivers/sysinfo/sysinfo-uclass.c:21:
      * There is some very dodgy error handling in gazerbeam,

Best regards

Heinrich

> ---
>   configs/sandbox64_defconfig | 1 +
>   configs/sandbox_defconfig   | 1 +
>   2 files changed, 2 insertions(+)
>=20
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index f861d3ef06db..c4ad63ce63be 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -43,6 +43,7 @@ CONFIG_CMD_NVEDIT_EFI=3Dy
>   CONFIG_CMD_NVEDIT_INFO=3Dy
>   CONFIG_CMD_NVEDIT_LOAD=3Dy
>   CONFIG_CMD_NVEDIT_SELECT=3Dy
> +CONFIG_CMD_BINOP=3Dy
>   CONFIG_LOOPW=3Dy
>   CONFIG_CMD_MD5SUM=3Dy
>   CONFIG_CMD_MX_CYCLIC=3Dy
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index a3fa52460827..c63a4df8befa 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -74,6 +74,7 @@ CONFIG_CMD_NVEDIT_EFI=3Dy
>   CONFIG_CMD_NVEDIT_INFO=3Dy
>   CONFIG_CMD_NVEDIT_LOAD=3Dy
>   CONFIG_CMD_NVEDIT_SELECT=3Dy
> +CONFIG_CMD_BINOP=3Dy
>   CONFIG_LOOPW=3Dy
>   CONFIG_CMD_MD5SUM=3Dy
>   CONFIG_CMD_MEM_SEARCH=3Dy

