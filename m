Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37ECEC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 07:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE0188393;
	Fri,  5 Apr 2024 09:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NfZsEUg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23ABD88463; Fri,  5 Apr 2024 09:50:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4307388382
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 09:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712303413; x=1712908213; i=xypron.glpk@gmx.de;
 bh=wmmN7kvzYFharwPQtW02S+Lu5/9Y1cnPEuklxrrvut0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=NfZsEUg0CmTXTGZsaiL4Lc52PNelHNDcbpP4AgMQN55ezNmQJIWyb/g5qH2yjJxj
 xhtzKY7/do+ym4yVnyML0bPlPgMCdwqsFc/Gsde+EChdiL9sWdRTOvIDCFKlx7RE7
 p156S9f3iE/NOQZSH42WuwfUppLvjuMSAtD8yRGn0OXfxouIJcOxNk8KL4AvgGbgd
 rOr1YLjjcOkF2eT39CNZELj5UEBJnoq9BVfchu6pcYGeSxxStnydKn1JEbRYwJPc5
 jS+bF85YBCBMUowB/7zW0zqXp7UBoPCg4EEzQfLJpk7Vm/F9MQXNmBWYI4hSyok3a
 RnAxaTt2g1Lk9XISMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1s4j8y4BPQ-00EPef; Fri, 05
 Apr 2024 09:50:13 +0200
Message-ID: <18ad5e3b-4b24-4e02-a3cc-4785c3a964c8@gmx.de>
Date: Fri, 5 Apr 2024 09:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: build: fix gen_compile_commands section level
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Joao Marcos Costa <jmcosta944@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20240405-doc-fix-headings-v1-1-455387c85e54@baylibre.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240405-doc-fix-headings-v1-1-455387c85e54@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UT7tzZA2z4HYhOC+IKWY9hrVSEtXxsrJm3wpvcE7z6/g9WOkEZY
 Mw92EFgF0yGkCHHXBrm4hQUEFUIHzXl0Dtny/zUo3REzPs5NCjD/RzkXgg7YTlS3L9iL/Ut
 kHWbBGDxlWCcorGIGf3US3hPt6hNDnqHW5/zrw0LbQ8cepiq8uj4JSY3VG2qcxQp0pqCvXZ
 xhdUuUReLmfy2q4wzLIJQ==
UI-OutboundReport: notjunk:1;M01:P0:NaYzWtAEloY=;ENtpMgMrPCxKS7K3CApuVZPRWgJ
 BYv7FhAFvZJhfF024+nhK7Ra2JiwiM9fcO3dRZaaw3Zdc+uP20LdLIFzhH7d9MVGz5qgbE+q6
 gnfAbNNdLqbWhLb9BdE0/DhfUcZTczGkjj8IzsCwBC/nf7pb0d6KgMCmeJLzvgBXRtB2yYQ2n
 PbklarJg9g9WZsJqXrdRUV5XTP8GAVP98fbffjQTOjcyxa+OhSaa5jbwJIzUeEkw1gyCBeWpy
 mAQvuYYQxY5L+WZbiQWuib6iqC1/0sYXkDxqRw+3EvSSax5A6tUOLwj/hzlH+/Ut6bMMV0uX5
 kITXl7bDyz5yhygYh7Z3vU1SUAIZ84ISJu/Jreg5uh1xW5SN0zDBznfVgUbrzDBud0Ll1NP4o
 7GNgnvPHAhxjrerhXtd17SG1RIBwhmEjrF0KEgX+sgNqebZttXbuyKiJH2AVbNW1l1HVV5WNP
 /Vd0pEvi+ManWUXZmu7QKgBCSy9C8W016RwNlu51axeP8dUetQsU5TKV0xshGebyfVOCNNd0Y
 UBMY31AjffBZI87m1vcYL7IBT9jJ36Gv0obNa5HN7ptel/JZhYb3ksCbZY4R8hhtLSbtN5NvV
 oIXb5Zgy3uF6YzSofsvBXrVATy2gBa0ZOJ/7YRStIiMmLxcrfYsrBGDm+wAMOl2ULgdlV0kZe
 FjExMXdevXTYzq24oaB41kSm2fUcUqa4HMcyTJ2XyVc/99xUmV+ibboLGpri9OlRcIbcRWHMD
 OysZ5w78QhW7gF4GG40IkSamAi3btqThfQ5kqqMppDJ1nZ7i71peD40za42RonqGTNfp0Ub0f
 Qtkv8P9et2Gscqf8SvbQCG31PGNZhXYfj5w+A+uNdcUqs=
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

On 4/5/24 08:18, Mattijs Korpershoek wrote:
> The 2 subsections of this page ("Compatible IDEs" and "Usage") are using
> the same header level as the title (with "=3D=3D=3D").
> Because of this, they always appear in the HTML rendered ToC.
>
> Drop the subsections one level lower by replacing "=3D" by "-".
> This fixes the HTML rendering.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/build/gen_compile_commands.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_=
commands.rst
> index 50305cec4a83..d503764f9e3f 100644
> --- a/doc/build/gen_compile_commands.rst
> +++ b/doc/build/gen_compile_commands.rst
> @@ -42,7 +42,7 @@ needed for it to be usable by the LSP, unless you set =
a name for the database
>   other than it's default one (compile_commands.json).
>
>   Compatible IDEs
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +---------------
>
>   Several popular integrated development environments (IDEs) support the=
 use
>   of JSON compilation databases for C/C++ development, making it easier =
to
> @@ -73,7 +73,7 @@ compile_commands.json in the root of the repository sh=
ould suffice to enable
>   code navigation.
>
>   Usage
> -=3D=3D=3D=3D=3D
> +-----
>
>   For further details on the script's options, please refer to its help =
message,
>   as in the example below.
>
> ---
> base-commit: cdfcc37428e06f4730ab9a17cc084eeb7676ea1a
> change-id: 20240405-doc-fix-headings-6109365355a3
>
> Best regards,

