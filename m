Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872EFE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 11:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51268031D;
	Wed,  1 Jan 2025 12:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BmCvh5Am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5977C80379; Wed,  1 Jan 2025 12:32:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 557D48021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 12:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735731134; x=1736335934; i=xypron.glpk@gmx.de;
 bh=rbcNZJFRWnwx0sPSpcs5z2Gf6lt64wlL5lwnP1lX9l4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BmCvh5AmEBnPtCv/plws2EjYaeNixSWt17j1NQUHi/jQycci6OBZPxIcbhAOVb4y
 BV+IPQcUlfWXVRRscfNAjw3RT4bgD5XIuACBcuC7KsltjshGsH5dNynXPIdau610S
 1UhB743worYlkRXjL5zc9y2q5PndtWhlnizx6A3ViBLycptalQWfr/VorXK88fLQW
 jihF5gGENc24ddn17PbS+rWSBrPfZy9HayKR69rg0OD+/SytSx6Aydzdm56cJFqfa
 Q+cJd6RRWlbGHaOhEbQDaSXBTnvxIIlBPz3UdWc3CPcbIqc3uRUFZpJ1kVN0K7Bm/
 DcAF+kQA+QUKfSYBog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1tUbNj3aN4-003dW1; Wed, 01
 Jan 2025 12:32:13 +0100
Message-ID: <85929b02-3250-4260-8838-4d90e807ccdb@gmx.de>
Date: Wed, 1 Jan 2025 12:32:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: Adjust configuration to hang on panic()
To: Simon Glass <sjg@chromium.org>
Cc: Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241220035927.3243648-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241220035927.3243648-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9oTFV+bgO5SIbewL99mX7QTLmGXlg1xTePhwdliewxx5F6NuIrN
 6NHHnr7c63so8FBkUwcyV3no2GNXBhW6eKPYqrdpgWm07/vdYywCs+9+Dy6uaEwLspnP4eH
 uf4xW4t5k4p7cpFTa9MmWofP817RgdU3Om6QPHwizwwovPcYS1YuW1jCFTS9/wiVqO2lXs7
 rGe2MzttbBaFEIyhKhFwA==
UI-OutboundReport: notjunk:1;M01:P0:kcBoGdxFR/A=;kCyTugSJb7wU2HODKzim19z8MIn
 95pf6qaBziOGhALQ48FrtX8z+asCfLMc7AF/5HFNSyDd2KF8weDufu4ZXlhbQL1edlNcdXYWE
 Jqsl+uI5oWmCt81bCnAuwzZuI33VGxa48UpCggKZiGZ/J6cdEfA7S4Q1vHlFpDwXnShAtYLxE
 TqwMsBQLWKMAGUXbD8u/jUG6nx57eMXTToQPCZbqEBgV9sG2ydGsduY9cWnm4WeFYDR30HKFX
 CoV/E4n4OpRSwu9hkg0m3WnbvteVMHyu+8CH+8sZxkLu9vsX+WnFWrMANFUfajmlaAsUPanla
 DBwfIlyTZMxO4WTzwTaAKGOcJo4tRqzUNcnx0SLSDGFtfBRVMlpd3WktZGl8/W8GiSxPwD1L6
 0sz4ADOwQJblIytdwaWiWzTWvoWr7FP77ZfAOM/XDc2cAKCzCclb+0oaxLOhjCWyQO61ylqc+
 3pGsteTqF+0sYwOfzrhzokpVIJTKE4bX3hUYxYTcynJcqwpujYqvWXf159iktfGtol1Pgrnsv
 MFE/3jjjxVaBhOMGzBf9/51vQeUinLk5aTPxSca+BpTYGe2IV0ZQwipPItPuEnrYROEE2FidE
 U8/otNNBP84WDRKkUQT6f0BYxoUWB9fXKsmJeI/R+3bZpEymlL/A+kdWlX2oTTIoShkDk9SXG
 q8bnPMchrdGmSHvO6v1BZKe83G9eJHRitILalyqDQ+YEL+VNmEX82B0o+bZWRrdxay8qsI9kJ
 XI93Kf9SFQ7xjvelDJgA7T4+9vJpWaUWZGc6wu16mU8n0sglRB4bXzS1JiTA9hVQS9cdggXIF
 PtJ+pYsDIhVxeeBUKrJB6t0BvXKm9TMr1I+46H/NWrQirgKSvACafqbXdsZ4UviAwe9iEIp5Z
 WEcOAaoMz7XEdyicE8KLgPontpMEoim+L5VAtUptHgYUT6sLjpds7EaOx+w/Qq4QZpSDMeIfd
 dEmC9HrQ623le9bc7XBN6aXhn8quoIzK8mwC8unTS4Ghd0eSVtwyX+BlJP65rt140xn2QuVZM
 O1BO208a7eXxfdz2bxV2midJskNMxfJTSpNWKlGhhM9MnEa3KIvhxUkd+/likBQeRk4Ti2f/5
 ZR7xwqzm7urN7DVTkbOACMZ9OkZLDd
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

On 12/20/24 04:59, Simon Glass wrote:
> It is annoying to have sandbox enter a boot loop when an assertion
> fails. Hang instead, since then the error message is only printed once
> and Ctrl-C can be used to quit, as per normal.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   configs/sandbox_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 3de4aa79c6d..636130a360d 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -354,6 +354,7 @@ CONFIG_WDT_FTWDT010=3Dy
>   CONFIG_FS_CBFS=3Dy
>   CONFIG_FS_CRAMFS=3Dy
>   CONFIG_ADDR_MAP=3Dy
> +CONFIG_PANIC_HANG=3Dy

Command line option -S is used for running the UEFI SCT. We need the
sandbox to reboot and to allow the SCT to report the failed test.

This patch is not needed. You can already exit the assertion caused loop
with CTRL-C.

Best regards

Heinrich

>   CONFIG_CMD_DHRYSTONE=3Dy
>   CONFIG_MBEDTLS_LIB=3Dy
>   CONFIG_ECDSA=3Dy

