Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B605C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 15:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43908870BC;
	Tue, 14 Nov 2023 16:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hwmVrUG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71F6871A4; Tue, 14 Nov 2023 16:59:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C6786EFA
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 16:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699977539; x=1700582339; i=xypron.glpk@gmx.de;
 bh=Oi+d0aBI2lm+CElSugE0Xx9YvXxaimccGMR5NEkQyMA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=hwmVrUG3iSXfxeE6KsVz0YNIRsDJSzgihoonlEHBmWQZ71vUh8TwOAHlpMLmO2Fi
 1GZu8V2C8Fgdwi6htrm82rbfoVOAACqsN2OvqZ7jEopnsTiveCtGf/u7W3qqum4NI
 HaOdoP+T0NYVlOfeRcilcdMWgZufLWicnAu/h8RHDaAn2QNc41/pDGJrD3dPITpK7
 B2QSm3kdXIT2XnshMULSqX3/K0CPAW2p+pmt5B6OYWtj2o2iRktcSgRGdbbTgDIE7
 DDemqak7S92fotA7XNCRNJD8jWD9FQJA94lGmitpTuh0WNf9b9Hg24Bi5ncQTIt6r
 fpTiIOh+Jd5nKQye/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1rgxwS49iA-00oEZc; Tue, 14
 Nov 2023 16:58:59 +0100
Message-ID: <43bd03c9-9485-4446-9a67-6c6bd8fb324a@gmx.de>
Date: Tue, 14 Nov 2023 16:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: avoid using deprecated sphinx function
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231114-b4-sphinx-deprecation-v1-1-41687254ad8e@linaro.org>
 <20231114154612.GR6601@bill-the-cat>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231114154612.GR6601@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:REEmN/RxNc8EsOuJgBlKTE8BzBPFHbHoo7GgsOajyfJNVkHntHw
 fhNr/Fg+WiQ7gUlUH/0trF/nP6IcIRzHjRlxFY7Fvoq7zXH4iN2ZAUJ+qeWP4oA0yxS67g1
 a63e88xB47uSoc1OLhc3a4huTOml3LYm5Fy6B+a2vr+L4txJpioqRN1zTMX+mA4pDhBQeWY
 VZviU1vgVPcbJKUdmAo9g==
UI-OutboundReport: notjunk:1;M01:P0:Epq9/Dqu/SE=;fTiMvq0vb2IrUN0xRrvGoeAY5o9
 bhz7oSHdUOV7E6Zl3YstvW0q2vT03n0j6KtoyVfMp6HKE0NKL2IRaHf7b5/5crHUuLlhhB+tM
 36fNxAM6+ngi0Qj822ZuH41qvvTgiZtaxCfcAtzc95JmQKQOK7eAtmBsohkHO09zDCq14pDz8
 N4tDumB4cTi5S7lSenXg/6nxedq4eW5QCD0jOmk1BWhIprpw2OLKM2Ydxsxk6KWV2sqI519YA
 88HUaZ96/6Txwl16GokYMcOPvBeAqPQqcqAGe+FMOveTul23P2CjIZoZ1a9T+I822UmF5GPtJ
 SqofQT4NHS4rvqUXlI7msj40gN0kXyx3u7AcrYgWrcRWFV3R7xHsL027RN5SnVv7W7LnVLKUg
 FG1hZ4BEDADA1U/6Jl+B57eIg6rxW7/QEHax1FiSfhUcu1rUTcFmdQe5emO4+FaD+Mhwnn/6M
 qTjUcfR/sU/kIO3p8BRQFvwBAccjEG41MwUJj2urwBETSxvtY/E3wdxvp2c2JVwZ+vFWbzqFY
 5JE0PY3SbTGi7Y32Up2BfHup2T8lbo+Yk3mwW4ws9vUckma/mODerKTgDfnyPJ2QbHMu8hezH
 VEhxHvzzVNqPH2j+o0uhANhJxE34POpX5KLD3lqbHS5A5j/ONHEBRLxknXDhbDEgKFuuQ/DOW
 xVmUgSPgzWDnDQRxxwNJt8FlMPiEYrpsF0SH9EgcwpB0Qjgh1JMzYqptaBYOuMeT1TMOxd71J
 J10Ceg98hOxrkqhyFdMHHsLTk+Kf3Ze0bV6HHvpQVZBQVVFj6Q0Su4Fej0wNUmtlcnGMS7ztM
 nkguBlTMbs5j+7aedCUdQNrXX6daJpARrm+sYs/U42V/meLYhnapk1eKotAwF14jFB8eXjdDy
 0fMFiFF6l0/j01hK5quoiGRWDz+jgNvFNDxUQKBBA6HuMPaQwOTDYw7nTeJ0GuTrnKgJzE5gN
 oqMDx1t0YAOElRniv8/UinVPMF4=
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

On 11/14/23 16:46, Tom Rini wrote:
> On Tue, Nov 14, 2023 at 03:18:02PM +0000, Caleb Connolly wrote:
>
>> The execfile_() function in sphinx has been removed after being
>> deprecated for some time. Follow what sphinx upstream does in [1] to
>> avoid using this function. This fixes "make htmldocs" on at least Arch
>> Linux but likely other distros too.

Hello Caleb,

Did you set up an environment as described in
https://docs.u-boot.org/en/latest/build/documentation.html?

Or did you try to build with other versions of packages than those
described in doc/sphinx/requirements.txt?

It would well make sense to rework our requirements as the Sphinx 3.4.3
we are using is getting dated.

Best regards

Heinrich

>>
>> [1]: https://github.com/sphinx-doc/sphinx/commit/9ced1e355ad6baecd4e755=
a598a54877dc0aad44
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> base-commit: 92b27528d777ce85362af45e7d2974a6c856219b
>
> I think we should cherry-pick:
> commit 0283189e8f3d0917e2ac399688df85211f48447b
> Author: Jonathan Corbet <corbet@lwn.net>
> Date:   Wed Jan 4 10:47:39 2023 -0700
>
>      docs: Fix the docs build with Sphinx 6.0
>
> from the kernel, to keep the file in-sync. That's the only commit to
> load_config.py since I believe we synced last, but there might be other
> changes in Documentation/sphinx/ to grab as well.
>

