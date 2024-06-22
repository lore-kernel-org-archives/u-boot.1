Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AA7C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B2F87FC2;
	Sat, 22 Jun 2024 18:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BRjDlm4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B952188080; Sat, 22 Jun 2024 18:05:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D171C87A09
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719072282; x=1719677082; i=xypron.glpk@gmx.de;
 bh=Wi8ukTCSCsdtcGDmOdkVoJncRdC/aVu5/qVExcy4PiA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BRjDlm4T/yEkNPtSfGhO/MgompS2w4mewWIJy/HtU6lAlBAcu9TqInmbqT2ZV+8w
 l7nqaoKCwHjdUInpfhZezjbV3DF3HzqCz6lPrDHi8DQuS4kCgfQvK2JMq9HNTiIiO
 PcTMfEfHDZAsSGPWLFNzNq3giazJSBh161gNL7I2iVFa/GHjqDoAS9vqIeNFIaOPy
 XLrNWtNo/kWAlDyQQkVa0mztpYOlSZJ/vYoqy1KEsWH5wCRhgTJJEp9WkE6lFYc5G
 2Q03tvX2mrKgHakFijJnXPZEcDlVFE2VKRd37UmSK90U2Fjaq7ImE0tmGcfG0aEmH
 BnWHFQoxMXGORBZE2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1sdGy50Ugh-00ruJD; Sat, 22
 Jun 2024 18:04:42 +0200
Message-ID: <27d932c2-d04d-4f1b-8104-4aad129bebf4@gmx.de>
Date: Sat, 22 Jun 2024 18:04:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tpm: fix the return code, if the eventlog buffer is
 full
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240622143601.187723-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oVqojQpMTI9N3xs++2DeTyX3dFKAt+nq64mMI/54OuYyvZwjKVR
 S1QCEvLcFVqxSFk73c7I09A+4rjHbBQ0ZF+khte/6cCCsqmPVoRK34AoqLcefofQio4PZ6j
 M9+dyGueqrDsXcdNMuaSxAe/z/ckgNcOU2S7IeRqN1bd46XcrzbHM9vtODzWdL4i25uZeW0
 kOnIc1Try2JQbzDes9YLQ==
UI-OutboundReport: notjunk:1;M01:P0:uydM2B2/tAM=;bqjnfIeCl5NTOX5bpFwv/o/K2P6
 LRrly7TOBevYptQRPDqcahJbGmJBadUa5214EXDeT9wwNcVEk1g2OczRfyTgcLH0ruNSl+cKY
 ctoc1HJcw4XNYN6ZxO4OOyCOk++4N0ess763ahJTvpcSAJK0fWdL5RyU2ebitN7rGde/T9Tli
 R9f/m9ryBIgFzgYZDWSMBdH/lwTXtUEf1XP0bYJxlNCldsb2693FOiZ/XCNORJuzA5YhuH6Uy
 sk+Ov+2WRBDnO5x1re1owhvTOwDuhh+L4QpsrJMdv6+DQx6DmIW9DQ71AB11Vq5rSIkY2CSkw
 cQP2bq8SOBYMKmmwSHTPRKZgzCfnb1jXTq7YoBppnOdjpf0tInign37FjP9mq1/zdYhCW3OmE
 Iz1EaMoHKAPa2FnmnEodYFYHxPBGkJnxL+cwVREC1aQmjmNt+e3wxg1CTey2A5wqwr3ghBQsY
 rSW89qCBck6Nb6MMVfC4SGOAwLAG62fh4yzkqQRwnC/YzbnJebblMxjxTPgrfimestaaHDnJv
 qbXumNJTwBaF/d6xx+eY4wQwtqPDK29JRfVzHemD+MUvkgAOuMfnlg5OldisdBLVNt7M6XQ7x
 oJffQpv/fesBNKfzOyU1wYKlDAVeV1IulYt3/SDNG3TiMkAyxChxrdE7xFQ5gqpQ5hGKSWtAS
 Yn+11dceau5+LFk2DXqCsP7zBSnrCcwK5gCKG79k5qB5r/mGRjxmX5m9bMILJCwUwWTcgTW2T
 Y1nt5E7lJZ7Rm1ueRdjatsLaVgCmfpmFRtBPTow68cPaJBk9zLytSUIso8oMko48brQzDtK+L
 boWDzBcQk7IKQnhvrr8T3cMYpheKDCQFkWG0eag4D38Rw=
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

On 22.06.24 16:35, Ilias Apalodimas wrote:
> We currently return 'No space left on device' if the eventlong buffer
> we allocated is not enough. On a similar check later on that function
> during the call to tcg2_log_init() we return 'No buffer space
> available'. So switch both error codes to -ENOBUFS since we are always
> checking a buffer and not a device.
>
> Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/tpm-v2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index a67daed2f3c1..91526af33acb 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -554,7 +554,7 @@ int tcg2_log_prepare_buffer(struct udevice *dev, str=
uct tcg2_event_log *elog,
>   		if (elog->log_size) {
>   			if (log.found) {
>   				if (elog->log_size < log.log_position)
> -					return -ENOSPC;
> +					return -ENOBUFS;
>
>   				/*
>   				 * Copy the discovered log into the user buffer

