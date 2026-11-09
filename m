Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478A1606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RiC7SXFT;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=W9krbMBw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03079607CB;
	Mon,  9 Nov 2026 15:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXcwdOHfoGs4; Mon,  9 Nov 2026 15:24:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17511607B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794237856;
	b=BkgIWd94R9l9IYz9Ydu1XN9iA4Owmj/nvhN6KcPRIFS5biAKA2luHVXJDBKqSwhWTbM/
	 LN3WsNz0uT0wTPO5BsuN1LbcUUrGhHM/V+EKkmkun+sKICt4/kRo/+A89BURKVmK+N+Eq
	 Rp3AaObr+zoLJtoDMeY2ywCtjnroDWubjExdqMBUb58ePs2rDOZcH8HDY4JEED/7kXoyf
	 DZ7hV0op7QyTISUQ4PYI3xjvkuzb+1Lyv5iGXg5gYp8sb7q8LcaQOj2iVHt70ZekxAodi
	 KlHVYv65G9B4Xdpb3nc5FFoO5rbO/LfSCgx3395Le3KVyPYW/N433P9mGEVtDwCygzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794237856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=orglcWeiGRWSdksaFTMr0IAlIJHjxGpb/EjAaXVHd3Y=;
	b=cEti8PlHV2hChYEztt8P1D00e7yMptl3XndC+CwYaFNQtLs5lRDIo7fq1UsUU2t7q7Fq
	 yNPjCxc9LN63UZ2FOfn+fm3WbBheqyUXblhvPH0C6JWYSpi83X5wLU/NXntJzXa9tT2iK
	 fKc6LYafW/wMdsuwwn76u+yEugJpfTXQZvJHh13vPVyBHSCjo40VFnuFaAPp0OIVwQ0St
	 5WJlL8Q1xK0dmenhJkELcTJphEZ998iKSweDTMD8XyBzaHOwE6YEKwJ8qumXyEQXTvezq
	 jQP0carfMmEEkgyNIRsAeZ/CS4D4cRIVMdA7cUX2ec2QGJmXFDYTpI0oKQi02AL2L0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794237856;
	bh=orglcWeiGRWSdksaFTMr0IAlIJHjxGpb/EjAaXVHd3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RiC7SXFTUeXxwZMUMR1hc/D+rCHZQf3a01V4JGxSkup/XS/BjwCioAHRkRwRa7ket
	 F58c6hSCrlaLLh52RgQI3qj1W3BDeJ200L+ejZTB0RI5umA5tFsyubOkrk0HUikYV2
	 ClSd7cwjmByfe/BPH0NUlNegZv3jEABErgpNnZEJOCu8EpbL/ueICpXrJHRSQu1OZa
	 XBlSD8skMHExQLFIp9OmsbqfpfWGmsJL55Iy8uP3vwf9xD9a2xqVkIlx+21CBQEEpK
	 EObtEg0fphDXtVHo6Hc4CkepTNB1X7DZi7WLkgcJUqEVSUcIoHkcl3KUw23A7U2jSX
	 5fwCFZVc02I2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17511607B0;
	Mon,  9 Nov 2026 15:24:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05385251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAD5280E48
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eoQDxcDoYkjR for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BB7380DEB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.17.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=W9krbMBw
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BB7380DEB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794237837; x=1794842637; i=xypron.glpk@gmx.de;
 bh=orglcWeiGRWSdksaFTMr0IAlIJHjxGpb/EjAaXVHd3Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=W9krbMBwySDmb1ToWS1NUx+j+CYQ/9Jojjg+HjlBqTluSHcChtser501FUATbl9x
 16Q+m2ipMF6ovABwmE0vwKGmPVdi3OaGJA6kKeK6Px/bSMXqoNp3IZDQX0kLbqa20
 qtjSx+dUM7XuW6lysU+LqA+1/ykeoRXLIFuN5OlAYJmNLW1r0g65OmcE9KtOyIpYl
 IDwjCP3YsZLaKf4NsLf9FWzI1PyMlrimAUND4zkOjZG5DgWZG4Zj3IcMohcJj0u32
 amX8DkE0JXkGcQihSJ3tsa9qAz5jPu/Z+4lE/kxauFxmOIo9Heq3IT64oMj+uUyY1
 e913z3EHkuCI8zAZjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1wq1Xk2UkG-00aH5b; Mon, 09
 Nov 2026 16:23:56 +0100
Message-ID: <9ca62e91-c743-4929-8ebe-277f69ddd606@gmx.de>
Date: Mon, 9 Nov 2026 16:23:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 01/45] doc: arch/mips: update link for Buildroot
 toolchain
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot-amlogic@groups.io
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-1-ee7573fe3a4a@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260825-linkcheck-v1-1-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oA0LgKwcX21tTOo8WXtNKMrnMGJ8Kp9dzSaZAV6tCaD5Bt+GzHP
 RpSJf5KU0TNdFWazFbGjubx2oZ2dMEj3r003fbPdO4+0lu9li9bzGcirS/yrKUaTWeD7jQw
 EO0FCsTDicD/26drTsXLO317Bth6XFkiJEffevUt+xQnzv/njxMzqHW3IPLPkb8wp7mwCde
 0IaTSVoN7XBedAMqzij3g==
UI-OutboundReport: notjunk:1;M01:P0:h0eAPpmtmAc=;1KJ5obzXPYNUZUdCrpzp7Ngltc7
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 8/25/26 18:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> http://buildroot.uclibc.org/ redirects to https://buildroot.org so let's
> use the final URL directly.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/arch/mips.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/arch/mips.rst b/doc/arch/mips.rst
> index aeb58247943a..70d9aa57c389 100644
> --- a/doc/arch/mips.rst
> +++ b/doc/arch/mips.rst
> @@ -8,7 +8,7 @@ Notes for the MIPS architecture port of U-Boot
>   Toolchains
>   ----------
>  =20
> -  * `Buildroot <http://buildroot.uclibc.org/>`_
> +  * `Buildroot <https://buildroot.org/>`_
>     * `kernel.org cross-development toolchains <https://mirrors.edge.ker=
nel.org/pub/tools/crosstool/files/bin/x86_64/>`_
>  =20
>   Known Issues
>=20

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
