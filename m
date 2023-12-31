Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5235C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CAD08785F;
	Sun, 31 Dec 2023 17:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="l05mO/4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F89987923; Sun, 31 Dec 2023 17:27:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06AE887767
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704040044; x=1704644844; i=xypron.glpk@gmx.de;
 bh=Su8j2x/ddjw4wk/r6Lw4AQm8VNcHYcrBUDBA9a2iGp0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=l05mO/4UJ+M+kSnsZzYguzuyNrnicD+f70PDd1ZB9DfQefmGzaL+PJkRCEAJ7dO+
 ntn3x/DvK7gEKjNJizyLtd6GzY02OFBC8lKZqzZYsqTTG4uIse0BhqP2s8gH3eJNX
 SmEolJNh+aCAc1tfE87JSHbNyAb9Nt12m9uAkvzSdAk0JtlJfXXsLsqctdmHG56yh
 gm/cQCshqSuJqa1GmZVPpZa9ma6K1wNR6UNt1T98xZul3ww2qmuMze1iZaUM7iaUp
 RtmSis51XGtVSlOzI+hdH+wHYmQjBxajG/WskGVYgcatfqvQt611aVheZ9MY0AzDr
 EOsT6f8hQ0pn6TfT6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1qiA0D0GQD-00gKlN; Sun, 31
 Dec 2023 17:27:24 +0100
Message-ID: <da23504c-e4c4-461f-a6f6-5d52bc79a549@gmx.de>
Date: Sun, 31 Dec 2023 17:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] efi: Correct smbios-table installation
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-13-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231231152555.464874-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tym55sVNTtUvxuRNMJqBauQBl8tuKmYMqG50DCepsPbCxQiePFm
 3BMw0Vu83iGMYLetMO1xgFCxHM1Q4fszEaBorVCFw5Fuo+H1Dbh2EsGyWDcR5IWacz395TE
 2Oqm1RsA4QyjADURHCY39hDX0bjTDQLyt7kP3qTcD202IAkqklu7FLD4hhYDTXBaK/TjklH
 nZDHGEnr1RTPX6nYkWD4w==
UI-OutboundReport: notjunk:1;M01:P0:N3/zhGIy2ow=;SSicyW/pU3zSCW57ssZGCN6uoYQ
 VC2nTWeeaanxtxCU1oVY9f7omnOTuGMif9M2yJ7QvLuvnG3W3bH5J8PExgd2JNH3VJab5mwXS
 Uu+fWO/rnWNLBmeetQJLFG68oWynLCp9W8valC3V8CaG0KqtHiSoZoAP/FtkGPqney+grt9nW
 TqGkrmpwPIBjlSP9d9HjzOA7xKJJTEkn65mseCaqBWlTjnW06lXLorSQCMOX2DcF2MpmjzdwK
 MuWA9G6L1mw9cFIxeIjxEbbwyboMlNjni7Rzn/SNq+iwn4qaAkF5MbKDf0JdkXdj3L79a8ZoA
 PQ1yLSDK5vyIIdNyPcbkl3/U8V+8e/Qd+yjsq6Vv1v2QvUtn2PoI2XLvsbrr0cB+T1Wy+zmkr
 qxzIG2a+hVuio/bZQb1Ekkly1049r/TKcgUPc/J/NvXPt38LDlZFqnKQO0hiz2zmCtrYC2vCy
 HgHLY9TTGRz3dJmiE4wAHaYT+mEfkWb0EcsR/QGXrkHWIVEWNYE5UYaNP1IF1SGmN5P6q90Yn
 MMymCPsAEh2w9gimIgK22P8G4XDODED+/EQtPJthYOgwtN8l8/hYIJbaH/XdzVuyK8K+eOILW
 hZcCx5JKYu2xC+OHjBSrS/KK3K8q+XkgCaWFAqcO19bFy2a1Qz8f/9iGYrhh5WhaUGpZFg1xR
 BC8e/eTbX2+k8FgvOzla5LMatcEjYHHqe9u+RPFwmn05IC/i4A8BUvRHy/qR1+hn+Q6nxCNjx
 pHOZ/+jyBpfs8MrPu5/wOW9gptQtkokKbpcNQykZJPd2epM4ya3MiLIbgIMDVjdtcKHCZL1er
 aiEqs3WEcXOk6doyLYeXwxnHedLUFAV48Ft34y8/uJ0QZqTqAYzZH5x0i/Y/T6yX7F6HTZOcl
 5kr9HOT3t/DSXm3UBlL7QCIjiztHTzMWYfuc5JN0iHLS5eQ7xjahVacCFvv5KwkoS5c+d2ujh
 UXpsVf5ylGuU3n5j+fXPGwEBuEw=
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

On 12/31/23 16:25, Simon Glass wrote:
> At present this code allocates memory when writing the tables and
> then unnecessarily adds another memory map when installing it.
>
> Adjust the code to allocate the tables using the normal U-Boot
> mechanism. This avoids doing an EFI memory allocation early in
> U-Boot, which may use memory that would be overwritten by a
> 'load' command, for example.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

In patch 11/12 you changed the address fields in ACPI tables from
sandbox virtual addresses to pointers. Do you plan to do the same for
SMBIOS?

Best regards

Heinrich
