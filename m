Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D456C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 09:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A3587E62;
	Sat, 13 Apr 2024 11:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="N0ay0MgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B56087F13; Sat, 13 Apr 2024 11:14:18 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB7787DF3
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 11:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712999654; x=1713604454; i=xypron.glpk@gmx.de;
 bh=ZLl6bWB880tLHMGgrOAHU69DBuYq0PWNp+N+uWc0Gcs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=N0ay0MgCbdCO+/DDfy4ZdICOi+oHd9ia9l5xg48SVYIa5rpvHiVMaelOfIwiUOCX
 IXGzVhCgZmpDazYBmbzniPr3WqyCu+yfGa6FhqyNlS+dNh/udLnL/dGETOjUkzPFg
 gaKS7DsuUTfxYZQ1KbVTHpHSHlXfhPZ3KGFNivMo5oMl07RxHDyMjjiVcxDmJ+Xiu
 ISQwf/2vNPaddyt2rcIaewDkZfXRUciZQAJAgSRezjIQ0MZGml9ksoE3gRSJb0ANN
 fhOy8OF5MyNa6jxr/eCIoVzszARoBVwizHvScL1GOLKZSmtv5sbVY3VHuZNgox5Yu
 8W/RHfd0Uvpd97FW2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1sPPVS0hC8-00h8AU; Sat, 13
 Apr 2024 11:14:14 +0200
Message-ID: <ed4601d1-1ad3-4413-872c-9ea260718404@gmx.de>
Date: Sat, 13 Apr 2024 11:13:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix references to trace doc
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240411164402.111244-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240411164402.111244-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWRdfA4b5WijbJcFXi4Qeax4puRU6/UGA2IOGVkDNpIsUPBge6W
 989qRKLgtqVLSMJO6/5EOS8tXpKYMLlceVRKRXZmn4GdrbDvb2hyuVC5q/c8iDPGxLc8sVL
 JG7qkroaHztRvr+aHVwie4urnVvx4JO6odtoxuCdIufq4oyGx2UK4xfqawQ+tpyt2qypXaG
 2xq1pPcBxN5HcZbg0TdRg==
UI-OutboundReport: notjunk:1;M01:P0:Ybru94EadmY=;3lph8ouNgCRZDfa0ZUiyKjdwaYJ
 19WUN0yxi+sqqaMAV0yW1+lmXiXr4CVzWoHOt/1O9PYtepnzwZQFWqeir1Zhu04I+CrWXbWT6
 IphngtHiQpN7lGPHznqr4F771vuWq0HRdRjSaeAWJ0hoBbAJzgV8AN2fQiqUeNs3I8lBjAp/5
 bxE/aqLXPVZ4czQnp6z5Jqzb0aDeVWiCF+9vECDoEjuvCJHX4X37/18Z1KEa8oUC3XezQPOLW
 sBpsuuHmhgdCXhCOsTW3t3VtmHyFXseK19psknbjEfX/7UVt0yhFGmSt0LLMTZPJ0TS3rR/ic
 Am/IslvJAM6NBoeUlanSf8c5rcNDGPXchAvWc+Cmf5eDCo1KRtGaYnTrEs6bWckluCxBJLM7U
 lviJJjjT2+c6SZ2md30L8fSC5GqNgnJ38jm7d+H+weIVQ0FIamN194q1T7jvq2rYF0FfY5uJs
 AtrdE1XYn8LH3deyftLYI3EPaviYeIN1ew9qsQcwk8mcpok8pAbvfQ8e03xgu0t1Kw1nScWQv
 /Vk0C0J5DSdXzth+QXiPQJoGVNgEYd2OG8KR0uOh5jO1+I/gaOp+fxT4clDf+o06ELC4RlSdn
 nDRzB4MaXBdEtQfHv/ipia5XuOHisQLBdkdxlCpgnqseAGky5NUS5Ux3NeIaZnShgdNOYBZSL
 BjKBijA5FhQVLimFBD+QspT3DSHBgvSnR6c9acJkbyaSBwmoWSl1z1pvpry02PvQ8lH7N+m/y
 655xdnL3h3YVe5ZKCkrItYwzzj8IfeNuLsRIo5ioVRotnYpqSEniqQFCeIK/+0TMiKhqQdR4x
 UEs6cIDA0YuWDAeBdi1gyf5OOY5rLDuV+TjEfZQTAhoqM=
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

On 4/11/24 18:44, Vincent Stehl=C3=A9 wrote:
> The README.trace has been moved and converted to rst in commit dce26c7d5=
6ed
> ("doc: move README.trace to HTML documentation"); fix all the remaining
> references to this file.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   cmd/Kconfig                   | 4 ++--
>   doc/develop/tests_sandbox.rst | 2 +-
>   lib/Kconfig                   | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 38305197602..f9f271616d3 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2832,8 +2832,8 @@ config CMD_TRACE
>   	  Enables a command to control using of function tracing within
>   	  U-Boot. This allows recording of call traces including timing
>   	  information. The command can write data to memory for exporting
> -	  for analysis (e.g. using bootchart). See doc/README.trace for full
> -	  details.
> +	  for analysis (e.g. using bootchart). See doc/develop/trace.rst
> +	  for full details.
>
>   config CMD_AVB
>   	bool "avb - Android Verified Boot 2.0 operations"
> diff --git a/doc/develop/tests_sandbox.rst b/doc/develop/tests_sandbox.r=
st
> index bfd3bdb9270..c2824834d07 100644
> --- a/doc/develop/tests_sandbox.rst
> +++ b/doc/develop/tests_sandbox.rst
> @@ -29,7 +29,7 @@ Some of the available tests are:
>        - test/image/test-imagetools.sh - multi-file images
>        - test/py/tests/test-fit.py     - FIT images
>     - tracing: test/trace/test-trace.sh tests the tracing system (see
> -      README.trace)
> +      doc/develop/trace.rst)

Thank you Vincent for the documentation fixes.

Here we should use

   (see :doc:`trace`)

to create a cross reference in the generated HTML.

I will fix this when merging.

Best regards

Heinrich

>     - verified boot: test/py/tests/test_vboot.py
>
>   If you change or enhance any U-Boot subsystem, you should write or exp=
and a
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 37ac14f7bab..efb77978a65 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -348,7 +348,7 @@ config TRACE
>   	  Enables function tracing within U-Boot. This allows recording of ca=
ll
>   	  traces including timing information. The command can write data to
>   	  memory for exporting for analysis (e.g. using bootchart).
> -	  See doc/README.trace for full details.
> +	  See doc/develop/trace.rst for full details.
>
>   config TRACE_BUFFER_SIZE
>   	hex "Size of trace buffer in U-Boot"

