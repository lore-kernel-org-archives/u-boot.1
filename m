Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C4606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xNGvmZvK;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=El3mVoEK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 075B9406B3;
	Mon, 26 Oct 2026 15:48:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6s7koH9Dvy7; Mon, 26 Oct 2026 15:48:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43E8240687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793029712;
	b=p4PbSmQOx4osWdwS8lGaM7SDvNGpcEIjWxXdGut+VKvpttPe8hTQjbGp5oUcRdScrYPB
	 t4uGaYbrlSh7NcyVaDKTdDHC9P9Fn0+tT3eYMdpfNaW1HdGDpty7S53mb7tb7uHLeyJvm
	 5mIjvLvZuxGkAJ1KPBbZtrw+vAqvrvVF4HD8QzN25W3nTlUW+vSJJIHTOZxty/h7EV+dm
	 0qO3zY3xlsuJneUHokbt/7aS1VWHSIDrMXC7HXTqct+rbXQ7d7UQaq6wmLwHbxp8Hb8a0
	 gCJOchjIgTeIYLyeZ6C+WPVL3L2yIhYflO6CZQiOG1twjZ4xu6gK0vCWPalAaxGan8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yDhs2h6UnHzxE88edL45gBhcF9f7P47ppzONkbeTk58=;
	b=kUvrjcLe/GqB10tLFDNGd9SXTZM++bIhBOuUIbpQTHXASRGqKgiJ+fxQKwZ23mDXcGdC
	 cmxQ80zNzwLNSwt0EPxR1hNADKOlC1iOe59ZdgbVbeh+KHzheCNzBHy+MJHQEBVV8jQEt
	 +Zg9ku+Wn5GaCD3nnY78W7zjJtSNM3Am7XZ5rukfELI72Zgo6T9dQvnLLLfnIDDZ18Ksb
	 3D7ChDind6/+/mO7PxxU3lasEbeeAWgOUvp8b4i8aEXtJ8UuoM80gMviQQ4QP8XuR6AiT
	 gw68U8zqZ4zcu5C8Jgu/rkbW3y+g40NNlu++C4VLW+MDU1ybIHbGvSFSloTd/+UlcpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793029712;
	bh=yDhs2h6UnHzxE88edL45gBhcF9f7P47ppzONkbeTk58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xNGvmZvKQxYaZBbMGsLVlGSBFRtsti4vY9xbtcDstc/cw7fdz91ZF2YqJ0YPpDCqo
	 eUJzzi1dlYXQ6pPh57nK5YM/eCcNBQCwSBRgwYw07UFXWCVZtEixxzyBuC5fiWcRkQ
	 kj9LD0AOTKzb+TfSlViVcCxpPTo+rCDZENP+MxDY98u5mExrQbZwIeqvAGAfR+1eJW
	 o3Yh4hHbBuhwmy38K74qMGjMTqHalgbKazV4ewwns2UnXB+Vb+qvYD9z57yOrfPm5t
	 Nh6OkmLxzXd5LUqP3DQGllClrhxB3wzJo3PidUCg04rLGhUAVl2EZdeBt6GWC1py87
	 yLTwmG3bC1yHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43E8240687;
	Mon, 26 Oct 2026 15:48:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 74A10356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6640740093
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:48:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DyfR3D29ln8y for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:48:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AEC6D40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793029709;
 b=XWVS78gKXC3itAR7yUFkmVr0YBYiitXsJc93Kox3tzmgrOYrUWAckUjwI3RXOw+au5qT
 pFsv9rof3q5+LXydMRnWaG8u3lXVfxfi7THCj1ibMyxpONmO9lLc44Kt5IAgz5NG8FNDQ
 ao5Za1RcmdpSjfZYomDtQPHRKk4sBCUzs586FHNGIVzB6aQmdE8m+zyM1uB2VqHqVYUaf
 8wEyerN5s1kgacch6rBT2FH1zhH766BCQrSUQvErCEm2Ct/Fc1CgumqRUkfTUAoL1pA5J
 nrB1TqioBJ99Qsip42sFq/NP0THk9pOng3wG5iCDvzJGArXjgEByArweOqbQz6YYOxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793029709;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=yDhs2h6UnHzxE88edL45gBhcF9f7P47ppzONkbeTk58=;
 b=B3mCFqhHgJ65iGYkJnKDxgP2lDKa9cz0ugBNkPpBQRo6AgvM2tfuGecm0ZJz+dXdPHwK
 gi6h/mU0p7dvlgzIOIGHKeIBkXN0Yd4I+eqBzHWp6rAOCibD01JxdXplr4vdcyQLA9Gx3
 4S5DQSKJ4h8osiz8dE7H3Ge4eNRtQnrsMebnDZwa9XKj1F5UTPGkSL2MiBwUqYbuG7hFP
 JE2QKjsqYQwsCYgTOWd2f8AbZ5PsjZmKSYEZNl36snZSp+abemOX2lJ3UvyrPTZvWmYp4
 SmbRIXdm7n9dvzGvqXhGicgFDOK61uHx7cbarG9w5IBjNiwsBLyHsLYvE05eKg2HFeQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=El3mVoEK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=El3mVoEK
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEC6D40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:48:29 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-8253bc5a613so2043322a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793029708; x=1793634508;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yDhs2h6UnHzxE88edL45gBhcF9f7P47ppzONkbeTk58=;
 b=El3mVoEK1fpzjoJ+lB+xWTizIMEvyC3vqaOfCIy44f6O6z8oVPVGbuu5Jn/8BPG/q/
 77S9JsmuZiDm13V1/nAAseTDtqrX16Dl+Hj0VQIzUooNtf+qFmj6RfISiZBfuKpXUo5G
 wdfQRfEPpYFq1ZgKpSU8PdNO87t8jFJCczmqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793029708; x=1793634508;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yDhs2h6UnHzxE88edL45gBhcF9f7P47ppzONkbeTk58=;
 b=W8D3KgSSrmGu+HcIYmzI6lntHKYqY0j9LcSjmCeTNGHDBRmvHPbBYNheiKDhGZ+3/N
 c+O9sQw+opWxisecFVC66kvghbau4cq4ZNFiIQavY/XdpzOWobbZ5FcLMg/7M8aECc/2
 XNJXPBV3G8O5Xc1YXs7o2c3sdjaOcBRfXc412n3s7tig3KTpmd43FhSDNKk+RpCDzkuN
 EuVpR/gps3s82DFC3HXzBy4vlD2nAhgOcRPifG/Ir72i76Rm5CVnU6PYcDVsODZKjvi3
 I9uH6HxsP1xnZbWC5t/ODw5ysI7b2D5e5+F+YJy2ZqyueTi9voq6BhP2Uts6TxSsvOCf
 R6mw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw09EZzhP8C9V3uMKkvPamyELkx/JycaAqhu2il5wx8nCx7JrGG4v8mm3Ts9LzVpnB72y6losc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIYRnEHf9sd59l/tYR3rDBTbKT/ZgZ1MlzRH5sPMMTN9u7dbIHX
 tAXQ33AKUm1RjppUCM9KY56Vin3SPNJAIlDqL6snRcuz9PqkgKdNQd3lLUwmdzknRdw=
X-Gm-Gg: AYBFou1L9ziQ6Ka/7wQBCtAtxXnoXDbqDacl/u75IJHj/99sVM0OS/KnPJ1XxhUotOE
 VKEM8dNFhB4iiMLe37dAioi8zRsCD5+GFh7+tcv7lvIOyhU0UjkOUMWypJSdfifRm1sPAp7l6uW
 1IE6sT00PsyP/ESQpaa0hDGctxj/1Q1TwQyJsaTFu+DPMDXfgaEG18BRnfL/5lrvHiGxuTrAX/R
 Ny4Qop+C5DDsfm31dUgL+m1K3UIhyio972ZcbJPkCBJJsK60xUJCj4lPUoyrR5UpfOc5dLaqist
 nFowgq8l/hGoKfRJ6wkyVtrcZwX7cgiCGh0nZ7EO1m6gS7HmFvoQzymwTwsn1Fs6cxiZcNZRHdh
 jqw62J6f9h3NDb7w5//z/LIfwNQdRPV5zZwy8qHlkC0IvpN5oeLm3vnjWlKcxMe/H4/gaKyfN5e
 ptX926C3wzAVz3EivTwMhsAgm7k+wqMEFks1BOh3ZvZ1iE6/zfAVOMP3QU+Me+a85M1UiFtkPQb
 BE4G4bACc85m54oe+9zkOBqKct8qSbW/SqbNIvvmCvlDSlewFMdhFdL12KDjOzkSrb3gXGOBZjJ
 XGqzntm3fA51KBlO+uh2wIwMhCi65xb016xdiEXm7MXAL9hJo6I/sC0zA1k+ApSyaNYJIp+7ef6
 Ql3UY0jbeLC8jymP2OfkEyHvsAXZGeln3kfSf575LLLqrjC+IJIQ1pAW055fnu+ytGRxdnAIdUq
 bdAMI=
X-Received: by 2002:a05:6830:4410:b0:81c:b7d6:e6eb with SMTP id
 46e09a7af769-850fd18a1edmr6415809a34.7.1793029708104; 
 Mon, 26 Oct 2026 08:48:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fa99c4f2sm7911633a34.6.2026.10.26.08.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:48:27 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:48:25 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 3/7] spl: atf: optionally pass the bloblist to BL33
Message-ID: <20261026154825.GB646438@bill-the-cat>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uG6yT3DHdpHrI9Tr"
Content-Disposition: inline
In-Reply-To: <20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--uG6yT3DHdpHrI9Tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 07:09:09PM -0500, David Lechner wrote:

> Add SPL_ATF_BL33_BLOBLIST to pass the bloblist of SPL to BL33 with the
> register convention of the Firmware Handoff specification, through the
> BL33 entry point arguments that SPL gives to BL31. Without it, BL33
> still gets the primary CPU MPID in x0.
>=20
> U-Boot proper already looks for a bloblist in its boot registers, but
> when SPL starts it through BL31, the only other way for it to find the
> bloblist is a fixed address in memory. Memory at a fixed address can
> still hold a bloblist from an earlier boot, for example after a warm
> reset, when an earlier stage did not write a new one. Passing it in
> registers ties it to the current boot.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  common/spl/Kconfig   | 13 +++++++++++++
>  common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
>  2 files changed, 38 insertions(+), 4 deletions(-)

Why are the existing BLOBLIST and HANDOFF options not enough? I mean
that genuinely because it might be the case we didn't end up plumbing in
something here, for the not fixed address case. But I would be expecting
something like SPL_HANDOFF being added and maybe touching some more
common code path too.

--=20
Tom

--uG6yT3DHdpHrI9Tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat92SQAKCRAr4qD1Cr/k
CvI8AP9W+ACj1ABlDYm9nZMOqjYOfm+/npTv8kyXPyZsTSzgogEAjjCsmYrV4R9V
vTdUWhakKqJZTtW5iXOaeY5GqMSttAk=
=Xnit
-----END PGP SIGNATURE-----

--uG6yT3DHdpHrI9Tr--
