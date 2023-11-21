Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AD1C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 16:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A88C87258;
	Tue, 21 Nov 2023 17:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H0FPJPXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC2687258; Tue, 21 Nov 2023 17:40:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC7B87118
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 17:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700584851; x=1701189651; i=xypron.glpk@gmx.de;
 bh=m6wiZ85nL4sFKZptybucJCdFzsx5dHRTMEJSinLnr+k=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=H0FPJPXPRUNsdjsjLYzbnAigTbrvg551CPTc352CKrYoxt+qVs0TXcQMuDkRRf9T
 MS0kkQBNBA5cnv5eHTq9IMqiMUXWcI/qRJnayIRZbcMTPVfexv7D3FshtGZ2bzktZ
 qtxTMbtvnVwDuE1C2UE88ClDLMon+cZFIy6mKGJGDcUMkrbhICH6wI2KRZ14RAnJ6
 TbflhxEYIGU0IgRRW/7ICadqPb6Z9T4L1JfwZGfBAx4Cf9gqfzvusOU6ntcWXf2ED
 cjUI87kj0kRt1FIZFboPgxolj2bg2lOHRLbGKONHYsFsSiwPLobfMGKSeQtMGT+Rq
 pW3jUKovPzXcfCdCUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1r6rFu0OvF-00GqFU; Tue, 21
 Nov 2023 17:40:51 +0100
Message-ID: <b83dc23e-44a0-49ca-88a8-b8de79e448dc@gmx.de>
Date: Tue, 21 Nov 2023 17:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: sending_patches.rst: s/Superseeded/Superseded
Content-Language: en-US, de-DE
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231121-doc-superseeded-v1-1-dfeb0c3549c3@baylibre.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121-doc-superseeded-v1-1-dfeb0c3549c3@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zfrjBwhH6MUG7LyLSPB0ktn9D8OP+liEKXUWJjDeZ/MGUrcHett
 rwS+wT9giT2+9wgkMOrxRdtq5qZUnyurJzolTVZJaou7xFnxalaNAXSJjISZEZGQyYa7NhH
 mgPxQzPzDUeGrYuNurqsx7AmjXhgJMaW2CSSA0dtUMnEc2JgK4EtZ/iHWlyITOf7LZSnH1d
 bzWNpXGdLLimdrdCHDzWQ==
UI-OutboundReport: notjunk:1;M01:P0:uoX++mHRcB0=;xr8CEIpt2QF7s72DwWwf9cAbd8x
 wfvSTT9nxnn5LvxRtoEZ8R4nzpTpAgK6cqUxaNQeJQKK9r7xO+LqJu3wF0cAs/gC3FkIyiO5C
 4z+kLQiTsS9TFN2MV0yWE7VT3SrU9mgPpEx+peOUmBIfgiKwce/2/ZQgKNnKbcmRVf7F6jnJc
 te0bTU/BJCI2zs2FdnD+7kB9psFxj8WXnaSVMAVD8JnAPoDpuEoOa1Li5BltRuML/TCeWcMO6
 e1a9Y85Y7IHkzRbW4zbHc1mf7jL8cjpdOneGRJveJOesPgwfX4E+VAogN7LuB+pDicMf/hy0O
 LvUrztvrD/qxR7PB6KON5+PFYm++/Ei+KXMgsVQiqlXF/eWu4gnhXonqv9XaRr59OXQVlYg5L
 koWcCn/TYUnNQcZnXSYMKBLeM9M5dPgRnq97+0ZvR/GoM9RCY+FdHesk6McqLAmcTH7ZrzTZo
 /2zxiWKm6PNSj5yl6XXsfcotzDo8QvETVFrE92FEaAkR6kqyjDcEP3MZM8CkPCllqeUoK5lrw
 ja/mACGe44FuaMzAsTdS+CE6hrYR0qfLY1H23bbOzK1EM3GU8YQuCUcJY5QS6KTjn7h8lgwUX
 7gbR1Go7QhaQer9elhVrp1vT3xoCExxpohEU1lxPQOh/xx7BCelJjDT5JVzRsiRxNJhXnJOkP
 zDbVGmPLHmkgeXvf2+2AppBfZayUS7fkYFAwlpfCWElrxol04fqIFC6AmKjgMASHyK1SDx2RL
 /LSX18jDKX0ixYc9Mamz8zOjCKe8l0g5yTcbmBYYSz3DjTjZAEWYNr6N0bModykOh2QASxX/X
 iZS59dNdYBmfOU3SLaauRB6dtnoYW465p1k8Uon/YMmfYdM8aMGOOH4JrJ26IGipf966mHDvb
 cG7QJQpmrN9qUIok1HxzVkZu8qOWTsQwSayHWAd3YwvofxVz4YsIwFxL0z3ySJIbtVL3pFzQv
 S1pg6g==
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

On 11/21/23 17:27, Mattijs Korpershoek wrote:
> This is a common typo listed in scripts/spelling.txt. Fix it to match th=
e
> patchwork status, which is superseded.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/develop/sending_patches.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patch=
es.rst
> index ba73d0d11b46..5a6962f1021c 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -363,7 +363,7 @@ A Custodian has additional privileges and can:
>
>      * Awaiting Upstream
>
> -   * Superseeded
> +   * Superseded
>
>      * Deferred
>
> @@ -399,7 +399,7 @@ today. Not all states are used by all custodians.
>     and has not merged yet to master, or has queued the patch up to be s=
ubmitted
>     to be merged, but has not yet.
>
> -* Superseeded: Patches are marked as 'superseeded' when the poster subm=
its a
> +* Superseded: Patches are marked as 'superseded' when the poster submit=
s a
>     new version of these patches.
>
>   * Deferred: Deferred usually means the patch depends on something else=
 that
>
> ---
> base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
> change-id: 20231121-doc-superseeded-d1ef005cda7e
>
> Best regards,

