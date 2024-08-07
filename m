Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C82C49EA1
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBCD88B6B;
	Wed,  7 Aug 2024 03:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="anxlSKyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C3B889D2; Wed,  7 Aug 2024 03:56:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B90D88B82
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722995791; x=1723600591; i=xypron.glpk@gmx.de;
 bh=15duvcOVYCNrFIhsiR/UMW2CEYVek/xmjIeZx1RHmao=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=anxlSKyyzPCDfuOXGKkRE3IOk5tq68fWAJXRmdpsSTBAhCY/nwFk0QstM55wOqTJ
 WK0YzbTcVxBp+J47eup/rBeQyu2x17fn2vMId4GgQ+vuhFpjwQ3OS4/4ZRmgwrnNN
 qiHHzQD26NQHL/Ow8F7zrEcmpXmeNvKUeZM+RXcrA+sK4LeuPXrxnOFvgZRodSppc
 hyOitKN+2EMpgADMFB+fdVo4uUSR+agtHtCtr4mVqQ5Ud3mZSqhRx//IDgO0mfQmH
 T7uH4+4ix1aXuu8VnZGIJa5Ltmxw76n3fjMZzVJzjP2QZBiRIwTrXCiKo0q02zrE9
 CJg548Q7mHlqnEIMYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1sUPRd2u1S-001dWG; Wed, 07
 Aug 2024 03:56:31 +0200
Message-ID: <eb48b869-a130-46a0-b35b-22bdb30daa7f@gmx.de>
Date: Wed, 7 Aug 2024 03:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/39] bootstd: Create a function to reset USB
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pjJfTB2oqXWJN9rlDWO5EyoZClELgQETnvhcZ5pVi4Dg+JxGuAg
 mSyvd3TzLHJk7wJbmwzhX0uNgFkKT2NPpjNa53IrGqQ74sJpJM96Z94c6x6A92H5sDoUEwk
 tkNiuUm+wxlcsK0itl9tYFVUHJj3JznbWukWWiiP3uzcuo03OrjOkl0eVuBgoc0A80jQozZ
 +jXaklDokniKWAEUaTpow==
UI-OutboundReport: notjunk:1;M01:P0:R642sNuQHOs=;FVaLY1h4V88mfq6Y8DmuUO5pA53
 cO2YJ8prKlM4iqnoyEaYr9/lVFSaLNqa68pDoGDSk62fIvMJpktbzAVEf4dan9FGfPVl3+ath
 szjZyfz2tleWwB18xgye2u4eAIIUNEpGOB+QwUNoT46gYO/ZRVcHGaGbIR0UU32x9twjw5Vmq
 P1t6wsK+SGXXPMqZm8IX+bMpgpO7omnShItCeRrSlW2skE6ndmsIViNL5yRaJHh7rVNcRKPDi
 3rbWSNbF87SJtq2iOXfR2V0CEnkZJNA7BavfMR1EASrmE/AsGstAgXCSUc4XIXtBgtlhqlPYo
 x+dwv5/HO8jhSo9iTTBpl/v9J1yadBzVXEMHcPzqUAHQIzYlmX4UaLJzY3EHUIgQbZtrxUMAT
 zDMusIPPcsyuht335FOmdY4MEuF88vlibfzE7L37um3LNvIAFEYjmOsBR9qBvTOGELIAZyuA2
 xPXZAEkJBVyefYy58G8YKp7iEEYfgdAjfiBHnqIfWSivLBcfb6cEG8iUrxusG4KxssYjIK9+M
 Eig2/0q6ZcRZN8gay6dFDSIu1/KAGy9HyNJlbTh/sedUiMvPzHEyqnyJrn2Ur0cIFog1fCQgH
 2wJkN9TSiW6MJlYK4rqR8fiS06yLBMp7ryvO8zz91c1Cny/jNQVB+L2jXBuWgMlQ5aLYQVIfy
 b6b0OCrP2xSyD1HyZVuFVqj6/rZCUrIpa9RwSpcJi894Ba+tyAnkUV3J/jRHRnCxum8dOVgwB
 bJJmoM4hIvH+RbV0Kr7k+YXMo1+QnXUfcb4eL2J2OqvbXRp2gUXCmPjmvFIOIga7lEEpBNQEs
 CJSGcZmLoESYvupl5QDUM00w==
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

On 06.08.24 14:58, Simon Glass wrote:
> Set up a function for this, since it needs to be used from multiple test
> files.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   test/boot/bootdev.c        | 19 ++++++-------------
>   test/boot/bootstd_common.c | 12 ++++++++++++
>   test/boot/bootstd_common.h |  8 ++++++++
>   3 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> index 1bf5929c396..de16a51956d 100644
> --- a/test/boot/bootdev.c
> +++ b/test/boot/bootdev.c
> @@ -16,13 +16,6 @@
>   #include <test/ut.h>
>   #include "bootstd_common.h"
>
> -/* Allow reseting the USB-started flag */
> -#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
> -extern bool usb_started;
> -#else
> -#include <usb.h>
> -#endif
> -
>   /* Check 'bootdev list' command */
>   static int bootdev_test_cmd_list(struct unit_test_state *uts)
>   {
> @@ -201,7 +194,7 @@ static int bootdev_test_order(struct unit_test_state=
 *uts)
>   	test_set_skip_delays(true);
>
>   	/* Start up USB which gives us three additional bootdevs */
> -	usb_started =3D false;
> +	bootstd_reset_usb();
>   	ut_assertok(run_command("usb start", 0));
>
>   	/*
> @@ -317,7 +310,7 @@ static int bootdev_test_prio(struct unit_test_state =
*uts)
>   	test_set_eth_enable(false);
>
>   	/* Start up USB which gives us three additional bootdevs */
> -	usb_started =3D false;
> +	bootstd_reset_usb();
>   	ut_assertok(run_command("usb start", 0));
>
>   	ut_assertok(bootstd_test_drop_bootdev_order(uts));
> @@ -357,7 +350,7 @@ static int bootdev_test_hunter(struct unit_test_stat=
e *uts)
>   {
>   	struct bootstd_priv *std;
>
> -	usb_started =3D false;
> +	bootstd_reset_usb();
>   	test_set_skip_delays(true);
>
>   	/* get access to the used hunters */
> @@ -398,7 +391,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_st=
ate *uts)
>   	struct bootstd_priv *std;
>
>   	test_set_skip_delays(true);
> -	usb_started =3D false;
> +	bootstd_reset_usb();
>
>   	/* get access to the used hunters */
>   	ut_assertok(bootstd_get_priv(&std));
> @@ -527,7 +520,7 @@ BOOTSTD_TEST(bootdev_test_bootable, UT_TESTF_DM | UT=
_TESTF_SCAN_FDT);
>   /* Check hunting for bootdev of a particular priority */
>   static int bootdev_test_hunt_prio(struct unit_test_state *uts)
>   {
> -	usb_started =3D false;
> +	bootstd_reset_usb();
>   	test_set_skip_delays(true);
>
>   	console_record_reset_enable();
> @@ -556,7 +549,7 @@ static int bootdev_test_hunt_label(struct unit_test_=
state *uts)
>   	struct bootstd_priv *std;
>   	int mflags;
>
> -	usb_started =3D false;
> +	bootstd_reset_usb();
>
>   	/* get access to the used hunters */
>   	ut_assertok(bootstd_get_priv(&std));
> diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
> index e50539500a0..ff0aff4bbe7 100644
> --- a/test/boot/bootstd_common.c
> +++ b/test/boot/bootstd_common.c
> @@ -20,6 +20,13 @@
>   /* tracks whether bootstd_setup_for_tests() has been run yet */
>   bool vbe_setup_done;
>
> +/* Allow resetting the USB-started flag */
> +#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
> +extern bool usb_started;
> +#else
> +#include <usb.h>
> +#endif

Why can't you always include usb.h which defines usb_started?
Is there a bug in usb.h?

Best regards

Heinrich

> +
>   /* set up MMC for VBE tests */
>   int bootstd_setup_for_tests(void)
>   {
> @@ -88,6 +95,11 @@ int bootstd_test_check_mmc_hunter(struct unit_test_st=
ate *uts)
>   	return 0;
>   }
>
> +void bootstd_reset_usb(void)
> +{
> +	usb_started =3D false;
> +}
> +
>   int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc, char *con=
st argv[])
>   {
>   	struct unit_test *tests =3D UNIT_TEST_SUITE_START(bootstd_test);
> diff --git a/test/boot/bootstd_common.h b/test/boot/bootstd_common.h
> index 4a126e43ff4..e29036c897c 100644
> --- a/test/boot/bootstd_common.h
> +++ b/test/boot/bootstd_common.h
> @@ -53,4 +53,12 @@ int bootstd_setup_for_tests(void);
>    */
>   int bootstd_test_check_mmc_hunter(struct unit_test_state *uts);
>
> +/**
> + * bootstd_reset_usb() - Reset the USB subsystem
> + *
> + * Resets USB so that it can be started (and scanning) again. This is u=
seful in
> + * tests which need to use USB.
> + */
> +void bootstd_reset_usb(void);
> +
>   #endif

