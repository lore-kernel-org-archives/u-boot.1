Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DA0C3ABA0
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 17:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886A388DFD;
	Sun, 15 Sep 2024 19:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CkhxAUi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C1F88DFF; Sun, 15 Sep 2024 19:00:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D4F88DFB
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 19:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726419612; x=1727024412; i=xypron.glpk@gmx.de;
 bh=4G2/or44uXQ+5KGj6Jt1eYJojrPPylWxwwiHqksA9Kk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CkhxAUi0qbdclW37LHR0SvIxtTajjhz4H6oS3enmLYJUxws2Wz2zQqGwJq++SWbl
 3qmgOBNMhpEWca0Yg/fwLf0DJx7F6lxbYyLzuvDJHH9yHxpBe+vQ1Yvwgts/D8oyJ
 fzsjreft740Djz0jHluXc1PwvvXUwZEjKWG9NW1rh4gG6oQQPdjTQ4Rk3FdJFTMRC
 mFowr/R+Ap+/0gL76BLVL/n9UTQpSbQErNX89QujTDPT68RRB4SuBGnuQ9U14Iynf
 VUi4KoiW9qfUxxhr8pY+Vj9mwtRvSjsjaPKRD5VXjkfOf82AYx80H/GgM+8NcjtKE
 wwXhkLXBwrolPrplrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.105.113]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1sqANv36bP-00E60M; Sun, 15
 Sep 2024 19:00:12 +0200
Message-ID: <4b1be536-86d8-4a43-9060-35e8c989e258@gmx.de>
Date: Sun, 15 Sep 2024 19:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/develop/sending_patches.rst: Clarify when to use
 which branch
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
References: <20240826163917.2786791-1-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240826163917.2786791-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OWjHIQ/M7tCw83KHoB7AoYrzpjnihhkR81zx6dO+kYtoNQAWh3r
 49JN7dLp3soEJ25FdsehE+XgCGgTMKcZsydq8i4MuJzUoOo5N6/Y2iTgwB809lOVqo+Iep7
 gsgxS/STovVwR6EqxVhUe9m4YvmQHZ1LMpW9cJLpn37SHjOF0LNFCrwhzZzpLI46yo9xQtq
 HaSj3kDuy/UtSAQ0jwJfQ==
UI-OutboundReport: notjunk:1;M01:P0:cZKiyKjN4T8=;bWb1yYZc5FNZM4VMDt5JmqZiJFm
 BqIlY05HZUitz4+uaQsAaSZBn0meYKt4iNKFT875iRW2ZoDoqdDyxWsJq89rmBwKjtG1FGI/a
 92m5FjyPAl9Adi3MCB09rJ761GF9it7qKDYkESK+3Pfgzz3ZsKhE58/XlBGZlx1PMuDxjA52W
 xyRrMVwC4YZlpHdCw/O5zILs3kMSocoR9HyOs2kqpcDPw7zE8inRPAIGCTMsX05SU6DVkALI6
 0HUl5uvBPHMPyj1jCvQ49pnoJyQzrsDH7AbnvHaCR/vSVPyoQZrNPagx6sI5MXfmoG83CR8aj
 Gt/i68nsN23KUXrQBjpMYAyj3yVChxexSjH+CC7N7k5rdOWYlC/yyB3nav6nZrLpC+QGblGqE
 rczPJ+SjRU/WYOBMClGF7mfSe+3XVF/FUzukUA8CZgZqE5tu34FpeNCWQtNeLhD3NfFxe6JBP
 GBr8GcjGJfA1Zj3wWW22rUkTfg1X3M3Pjb1SpJDO/fU5clJG2UzWDnnlglhctVbiIrCmKd+IZ
 qDU3MVoexeEpWc4L4Axh6c50IewpFXu10UFg8EzHl/SmdKsOA8fi+AbUKojm+yL111+xl+2Y9
 JiLH3H3aNOT24T7oIvLkHFLoatFtfkjBtQhz8c4tDBDcxu9Aro3nOkBZ+cKwt7N1j5wR/nckr
 LojItNB9l5TEXyjQVY8ApB0XRBqMoPPNlYpSgAonu2RRpf5EyqEABI9Ftl9nS3XSlv7DsPU1m
 MFqum5Nu6XxZdHUEsKJk9q+R2WZja1/Xyc1A4WrXXfNMc2/yv1X9L0qUybQT2ZsbCOP1tsiva
 8HQqLqjlEgP8RyGbFcjQzvxw==
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

On 8/26/24 18:39, Tom Rini wrote:
> The previous wording on the paragraph about what branch to use when
> submitting patches did not reflect how / when the next branch is
> currently used. Reword this to note that master should be used for bug
> and regression fixes, always, and that next should be used once it
> opens, with -rc2.
>
> Reported-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Hello Tom,

I missed that patch in my recent documentation pull-request.

Maybe you just want to add it to master with whatever comes next.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/develop/sending_patches.rst | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patch=
es.rst
> index 3f25b1d0466f..82efb717b179 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -74,11 +74,13 @@ General Patch Submission Rules
>
>   * Send your patches as plain text messages: no HTML, no MIME, no links=
, no
>     compression, no attachments. Just plain text. The best way the gener=
ate
> -  patches is by using the ``git format-patch`` command. Please use the
> -  ``master`` branch of the mainline U-Boot git repository
> -  (``https://source.denx.de/u-boot/u-boot.git``) as reference, unless (=
usually
> -  late in a release cycle) there has been an announcement to use the ``=
next``
> -  branch of this repository instead.
> +  patches is by using the ``git format-patch`` command. For a patch tha=
t is
> +  fixing a bug or regression of some sort, please use the ``master`` br=
anch of
> +  the mainline U-Boot git repository
> +  (``https://source.denx.de/u-boot/u-boot.git``) as reference. For new
> +  features, if the ``next`` branch has been opened (which happens with =
the
> +  release of ``-rc2``) that branch should be used, otherwise ``master``=
 is
> +  acceptable.
>
>   * Make sure that your mailer does not mangle the patch by automatic ch=
anges
>     like wrapping of longer lines etc.

