Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BCECA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 22:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8DE82B07;
	Thu, 21 Aug 2025 00:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RAi6HYfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CF782B07; Thu, 21 Aug 2025 00:03:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5274B81E13
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 00:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755727427; x=1756332227; i=xypron.glpk@gmx.de;
 bh=5cPCbM8AFVEovCgGrqnHY0lUsw+tpmNpoy/IJFWKtQU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RAi6HYfKHztU51v3XWiKYFeSj+hLKuL9J0t2K/P2LRFMi4bUYgIfkEs2QB97rqtS
 UWrBmh3BKMGFC5yyxDMKLyUXgbc1gSGHLEeQcp5Ro3t11lwt12esEj3Oix6H0Wk/E
 PPmCe7ZHjxs/Q2lXNsR2hrcIi1468kpnfaFzRISQgwzSERvRYu5LXdoqGqnObcMe6
 KGbQaghA4kLFZhdbGdvCAR3djGSAHC+hT3UhKJ7MgAjLdYmIG/mymIicoSBgU9tNB
 WpOEKcVLI7oqsvTCww3qNsx9TbNOifh9Mak5iPlBzeGJ76Li6EUJch31W+KjRXwBz
 mVoDE48H1H8LIVQzaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1uadRn2AFQ-00xQHB; Thu, 21
 Aug 2025 00:03:47 +0200
Message-ID: <03b60737-2289-48c2-b4c7-63c768ca4149@gmx.de>
Date: Thu, 21 Aug 2025 00:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] doc: minor fixes and improvements
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eq2wG+7efthXp51VkO86Ry1DvVAzfIYaYkLdkgIQfeGJEP86v14
 7alaCU5f5KK9Mt9T/Nv8cxaexjV2+9M4VZuzHJLEv8HU0bqZi+oYBPfO2P9tIbyJWaUIJW0
 rt+bsBYiHBVbhRNQbrcLB2coYRPAhOqXI+HplE/Ptf6HNtCbWVZ+F9OpK9IMui/3gxUujRz
 TRFwBod/h9//qd1LN0wTg==
UI-OutboundReport: notjunk:1;M01:P0:Wt9Y5VwAvZI=;i+8BvhgXYt+WZEc94qECGzIBoem
 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
 gKDNsFG18DauXcb5CPVUKRmWuD6i
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

On 11.08.25 01:37, Adriano Carvalho wrote:
> This patch series includes several minor fixes and what I think are impr=
ovements to the documentation.
>=20
> I have recently started reading the documentation and plan to contribute=
 to U-Boot proper in the future. For now, I=E2=80=99'll focus on improving=
 the docs.
>=20
> Please let me know if I should approach this differently or if there are=
 specific topics you=E2=80=99d like me to focus on.

Thank you for taking the time to review the project documentation.
Helping hands are needed. Welcome to our developer community.

Fixing obvious misspells makes our documentation better readable. Thanks=
=20
for that.

U-Boot provides scripts/get_maintainer.pl to find all people that should=
=20
be CCed when sending patches.

We typically expect a commit message besides the title.

When reviewing I found some issues also in neighboring lines. Maybe you=20
want to pick these up, too.

Best regards

Heinrich

>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
>=20
> Adriano Carvalho (10):
>    doc: Fix typo in doc/build/clang.rst
>    doc: Fix typos and improve wording in doc/build/tools.rst
>    doc: Fix typos and improve wording in tools/buildman/buildman.rst
>    doc: Quote all long form options using double ticks in
>      tools/buildman/buildman.rst
>    doc: Ensure consistency of "buildman" (in the middle of a sentence)
>      and "Buildman" (at the beggining of a sentence) in
>      tools/buildman/buildman.rst
>    doc: Add riscv to the list of architectures in
>      tools/buildman/buildman.rst
>    doc: Fix typo in doc/build/documentation.rst
>    doc: Fix typo in doc/build/gen_compile_commands.rst
>    doc: Use a long dash instead in tools/buildman/buildman.rst
>    doc: Fix typo in tools/buildman/buildman.rst
>=20
>   doc/build/clang.rst                |   8 +-
>   doc/build/documentation.rst        |   2 +-
>   doc/build/gen_compile_commands.rst |   2 +-
>   doc/build/tools.rst                |   8 +-
>   tools/buildman/buildman.rst        | 116 ++++++++++++++---------------
>   5 files changed, 68 insertions(+), 68 deletions(-)
>=20

