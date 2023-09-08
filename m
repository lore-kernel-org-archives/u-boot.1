Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A7EEEB562
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 19:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B288386A1C;
	Fri,  8 Sep 2023 21:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="I+w2+5u1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751DB86A97; Fri,  8 Sep 2023 21:16:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26F0869EB
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 21:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694200588; x=1694805388; i=xypron.glpk@gmx.de;
 bh=SbYi42X19GdEujHBJku0VwgWDtevx2HQMMkt1OrdGGQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=I+w2+5u1Y4TX+muaUjcjNAt7VlwbLEMFubp8EpH+vuykSdxby7YOV1E7w3+zsmqbs3l1QP/
 D7I7igdygRlnCKKMg3n8Xe4VLCwUNcI0THXdfTVuTltBWpqDZKQlJJNMQQ82DWLS1lnCloBpl
 gebG7/xBzSdAIxvy4/sfiifzIab1IgGUzj38VYes+e6SIIiX4d6BMfgPIHzRAHJrCk1NFG8cN
 AxQ2/qF8tbdhyb+GWW/bGDSs6r+b9igvBWJVE6/+la7LX2GPg0mOle1k3PsDWDbelev6oBScO
 AWRkMDX+adDMQAHd4U3Nw7sapEYxwgBqCMJWOf968xXD8MLGBgXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1qcmDj2yD9-0049sm; Fri, 08
 Sep 2023 21:16:28 +0200
Message-ID: <888a4523-0dfb-4b35-a809-947758519607@gmx.de>
Date: Fri, 8 Sep 2023 21:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: qemu: switch swtpm instruction to 'tpm autostart'
Content-Language: en-US, de-DE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: sjg@chromium.org, u-boot@lists.denx.de
References: <20230616084253.490380-1-ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230616084253.490380-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D6hczyfIyWR1DGpYOL7kWfCsYeQKYtNjIHJbRnXJY3rVWEq+adB
 ncCkk0HDwgXxA6r/CRk+l5LP9v2gOjsU0mUtfEEV7QdGj48ac4Fo6kwjMZiJ+tGZQqZLs4n
 mJpq4hC/beKH6MvUlZcWt4mR1E/RVSJVrrOXV8/1GI1LNJ7lftdussJGH71xoIxKd+IkYmH
 K+rQhnnO0DFaTc1gtI+mw==
UI-OutboundReport: notjunk:1;M01:P0:f/FHegoE1lE=;RGKmbf5gTHf3KPmTb/5PfqbW7/n
 bwwVrLpNc8FoZtgGWiReTkPAm3HwqhfG6qh3Tp/8ZhIDLw5YsGGNp4mGTBIv2qMFz4c7gaBSp
 fbz8AE4RJtgtgY/dBRFDMultzb1+iyVoOa1h5N+0VNi4fl22SyIew6CzpScdvJzoN0lhZXz0/
 1kGpOQNbzAQcoYo+2jJsd4BCyurpfUFG1c19GzrrgOY2uc1ca+q+5KBVxXjF1eDZC70PKasNK
 jDWy0uKHq23QSUUHy6k/xV5QsqVNb97qz6LTult2TuEqspe1nlmF4upUUAcn9tS5IyK+Z+IFA
 Z8j/619fY3DUru5JgiJFqlxVHBupa+KqKn72RNg7loCzPGG5M4QWfQiujxoDeznmmJKBVaPu7
 bCmgo+2m0MPUi8aeNHlzQ4phTIanObFeILSBF9U1Mne57X//+A4JXFRou09hJ9TRTDnegmIu0
 l1e+P5qCipGz1vky8nD5VSq1eRQWep5EhoiZXY26UZSqepUsLYtyEus77vIAPJ+GWbgyBMUkw
 OKUc5SM/Sib96TJx6KbCBVJE4fee0mrI4OG8ALekA8QlxdxrNsIP1Ves/Jv/4Zt7FiRynRNmX
 SOaWV4ozapsdY4vRLu3AI11vVopTBG5aMnXD699B+QWg3B8HhCDxKGXxdKbIskb9hW5qwqlvF
 otLTRuAor7cD/egqgib8WLUd4SM5K+F3oB3f602YOL0eYGGOXJ/XIiSHJ7z+ccgljNUSkarCm
 JL3hxUzYx/no40CUpfJir1355CKwMsfdw65QGdPIn+avb5zKzZYw9wu03SNOmf85hecqfGZKd
 FOi5rqrqpqM8ULG7KPFCoysAVoG5k9SHST3yrrraUiFHzmvYxPVtmEXDyEG1QvsrOEVf6i6yZ
 NKoSpbE5m4oqyUhcCpwmNSfhAwgHFjKHSWTwZixKUyrXqOdVyqoOA6EJu2BZRq6r0nwc3Benp
 cd4o6D7D4vpUDfZecc5ANPZacDw=
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



On 6/16/23 10:42, Ilias Apalodimas wrote:
> We don't have a documentation page for our TPM subsystem.  I plan
> on sending one in the future,  but in the meantime document the
> new 'tpm autostart' command in the QEMU instructions while using
> a SWTPM
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   doc/board/emulation/qemu-arm.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu=
-arm.rst
> index 16f66388eb1f..30819637723d 100644
> --- a/doc/board/emulation/qemu-arm.rst
> +++ b/doc/board/emulation/qemu-arm.rst
> @@ -113,7 +113,7 @@ In a second console invoke qemu-system-aarch64 with:=
:
>
>   Enable the TPM on U-Boot's command line with::
>
> -    tpm2 startup TPM2_SU_CLEAR
> +    tpm autostart

Do you really intend switch from TPM v2 to the deprecated TPM v1?

I assume you mean "tpm2 autostart".

Best regards

Heinrich

>
>   Debug UART
>   ----------
