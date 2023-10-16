Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B92CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 18:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D5986D18;
	Mon, 16 Oct 2023 20:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V5LbyiOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE3B86D56; Mon, 16 Oct 2023 20:02:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D4E86BA4
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 20:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697479327; x=1698084127; i=xypron.glpk@gmx.de;
 bh=dMBG9cYn5HLfLS217ucA9rETmzG3gexLq9yk93/SxBE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=V5LbyiOn0mKjA+0CrH6+pv/TkN+50EbYaFlOiCHACQ2GCF1lsnwEfrySeS5MuqbA5cCNI7C8e/K
 nXEXZMGLME1uDbV3aHf84i3G4QwTRSPRK2yGkeZgrn4Vz6F8mIvI6XloNhjA7NoEhiZyuNPrN6znw
 PSS+qCO3onqmkUcerJyB9f+PxVL/Tt4SXYU/EPsU2PTpWZ0cuTJ0BxoqcCPoSd+edkzB9L05rA5XI
 xj9dFtp01+ALHjX23Q3AdYl0pZgQi6XgjqvV0K3kZaO5Lkih5/Vx6vnQHEu969/H5fiW8JdMkB2It
 6Ancq2uLmdpuc/j1G4ZyRvFKGATiDQf5EhAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpSb-1rTgTG0e89-00gJGk; Mon, 16
 Oct 2023 20:02:07 +0200
Message-ID: <b9ef9549-ad09-4aea-aca5-a33af1fc311d@gmx.de>
Date: Mon, 16 Oct 2023 20:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] sysinfo: Add documentation
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-5-detlev.casanova@collabora.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231002152142.76516-5-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ej8LsA5JWMr0KLUKHqKvV7iSqONXxEP8WAIREJUrChY3hwwUOO/
 GxDsjIyNQNCqsabhslly2G/azqkuSTonD9pOl09HEP2LcgJxR0VQiix2UI8hgsAOVn4tsGY
 FUKUq41f6f0q3zpPq+SNI/WMp++TlDqiMJNLkbbqnqjyiL/Syo7GD9oyoTTmXaZ3n8a8rEc
 X7WBvdO7HprUthz17jYYA==
UI-OutboundReport: notjunk:1;M01:P0:IAbmJMbmGaU=;1GJBbkAzNo/LKMVMHlrRgogfWen
 Afkm75pCUhtvJvGlj97rA1kp4zv9nSN5x40guLSLq2Vfsrnztq0W5PWZ6/cAg3IaE9R5EBA6L
 CXdiaiJA6CQUdYz/jn/+LF3KQIiZuHAk3jPprLUW75KlGOeewqlXmoXzGQjq3y9Rowd3eazdQ
 CGFuBtDuikwqjNnXUcBOijPEpQZ/t4JaDmyW8gzh0o4WjIbt9PlAhAUAMeKedar5TZe6FoNo9
 J4XVp/sQxiuDpLcKYNfIjsllFJVHeby6xiu07MgjxxFupj0kYJyFNYT/nAfTksjrwHBGXE7DN
 qUu27pgskoMlz0cI61P+Qv1ad2gUWmmU+cfpHXh+hmfsYxnkKe9bSaBNTbZOqxWpdIITLAkz2
 O8XQ2AQs38yjTU0/9mrRezumZ+mVSiErKKWYtjCxwDvi6qhLTXeMXZGe8vUX/gmwDnm8CTs1u
 z3eqybEVECgA/JCu154ZBSFD3Gpq4BHUt3y46vpyZAvtCevOqsInu1O4Hvboq+imeNBKDgMaJ
 oVKqzXrqlOg9/ISm8QzbR8mjbRzbJmEAAgnZBms5Dx8IUXLmMrl6SrQuHGuLcCIG907l+URxf
 uXix3RB1gYyImkODqVjNhCx8Y++VlCabaRgRofmUFPc7Vb2KZxWMgba+72I3Y8VCzDKz/2zZY
 avFVUj7sFy6RpcjJGYWPWtdt0u001neNk8lxx8YMWM5xrw8PtcAsN7rDSKqI+F5ICiEM6Ra9Z
 H06kaz7pI2f4elgpNX0H3WsPG3D1AlmGGZczpYF+BxuxRkSZLcdBfNMQdkLwt5vG9wXsdr5Mf
 aoEoWkD761BY1GiPVyXp6PYtDP4b7q4wH7Iusxhr/QwDSs7ujZ73d23bQXXbddLrTKu0kKpUA
 87LpCa9+a9M1aQNXwk3rwzSHzkQaAdSFXSu0Dfpf69rHAWsukxNwj0hNwUhqEK+oxU0Z6sc7t
 rCbUWjHlF7In708iovNi/nX6K5s=
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

On 10/2/23 17:20, Detlev Casanova wrote:
> Add documentation for the sysinfo command with examples.
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   doc/usage/cmd/sysinfo.rst | 56 +++++++++++++++++++++++++++++++++++++++

Thank you for providing a man-page.

Unfortunately this does not build:
usage/cmd/sysinfo.rst:document isn't included in any toctree

Please, add sysinfo to doc/usage/index.rst.

Please, use run 'make htmldocs' before resubmitting.

>   1 file changed, 56 insertions(+)
>   create mode 100644 doc/usage/cmd/sysinfo.rst
>
> diff --git a/doc/usage/cmd/sysinfo.rst b/doc/usage/cmd/sysinfo.rst
> new file mode 100644
> index 00000000000..1660b2aa1a6
> --- /dev/null
> +++ b/doc/usage/cmd/sysinfo.rst
> @@ -0,0 +1,56 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +sysinfo command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopis

%s/Synopis/Synopsis/

> +-------
> +
> +::
> +
> +    sysinfo id <varname>
> +    sysinfo model <varname>
> +    sysinfo revision <varname>
> +
> +Description
> +-----------
> +
> +The `sysinfo` command is used to show information about the running sys=
tem
> +
> +The `sysinfo id` command prints or sets an environment variable to the =
board id
> +as an hex value.

%s/an hex/a hexadecimal/

> +
> +    varname
> +        an optional environment variable to store the board id into.
> +
> +The `sysinfo model` command prints or sets an environment variable to t=
he board
> +model name as a string value.
> +
> +    varname
> +        an optional environment variable to store the board model name =
into.

If varname were optional, the synopsis would be

sysinfo model [varname]

> +
> +The `sysinfo revision` command prints or sets an environment variable t=
o the
> +board revision in the <MAJOR>.<MINOR> format, where MINOR and MINOR are=
 int
> +values.
> +
> +    varname
> +        an optional environment variable to store the board revision in=
to.
> +
> +Examples
> +--------
> +
> +::
> +
> +    =3D> sysinfo id
> +    0x0b
> +    =3D> sysinfo model
> +    Renesas Starter Kit Premier board rev 2.1
> +    =3D> sysinfo revision varname
> +    =3D> env print varname
> +    2.1

This is too much hassle to print the information.

We should make the parameters optional:

'sysinfo' should print all information.
'sysinfo revision' should print the revision.


> +
> +Return value
> +------------
> +
> +The return value $? is set to 0 (true) if the command succeeded. If an
> +error occurs, the return value $? is set to 1 (false).

Please, use the same tense:

%s/succeeded/succeeds/

Best regards

Heinrich


