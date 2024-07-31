Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31F6C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2565488951;
	Wed, 31 Jul 2024 08:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kcIxWrJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D80C88963; Wed, 31 Jul 2024 08:23:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E418890F
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722406982; x=1723011782; i=xypron.glpk@gmx.de;
 bh=6CgN6yN1vNc4996VzxBBMo/yUro24uAt3hhU30BSFRA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kcIxWrJBiL2oBpo4hCZtqK3gEI7wB0nCXB5c7sm9mXDucvKcSJE7amfNQ9tSwFAP
 nIdVXyMWYXgbZv7eN1R5ah65eAnDs76zKbq3yfaAD2l0PJTtWsxkvfH8SoSDKIvKE
 ex3fcLKvuNWRgrcyEUo4+tBT+JYSw6G4ZGQQYK3STXO6z8hS/Q5AArSAkU6H4fi/S
 k8+i+4j/ES9OXx8lRt3q4rURIgXlOX6XxTtrPb096PS4sTjZGrToPjH4dFTMp8OZD
 Eb1oNm7F8QClDOwscS8wFW+9Az5UUNq+jd/qiSn3FfNTezbHXRfIJILo9VrxDxhcT
 kFsbm6mCzqDCbRLt4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1s9ItH15O9-00rfgb; Wed, 31
 Jul 2024 08:23:02 +0200
Message-ID: <db89c258-66ac-4ee4-9950-bcfcdd285c97@gmx.de>
Date: Wed, 31 Jul 2024 08:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dm: use list_count_nodes() for counting list nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-5-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240730111132.1097315-5-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yB88OwGQ8Rl2trPuhuzYLhpcDra+55vfuRZNW0UEINoDOOwJ5Up
 ewldaAFNksr7/XmV4a5sAdszAGxL9UPNVZ+Bu7PkdN22hP6uvNUgYEbjgrqd5GcWqWl8mbw
 roe2bY2TMv3QAnU/CzUfGOAM0YkrMpDszwZIe1Uf5UL4QWr+iNGhMt8e285sLngGub7waHH
 y3XYGg1CFQrvR4ydgMixg==
UI-OutboundReport: notjunk:1;M01:P0:PYYKpK/GteM=;0QmuUbmoqg/2Rsa2K4u6CEHhjOv
 hY6/ZGoDCa++4D2rwOjmU00/c++NwdSf9l2trkislDStZya8/7ALcE3KLrZKb0PpQLrwQr8sp
 33HtXyTXDmqX1mYZvGwz2OUY666QI8EmzUgfcBzOaLi6R93RdxyPVbCBcYz6vl9GMylMI4CU8
 2UjgGWM0baw2Zfp+4h0NhewazWncr5dzIcBCfmvFiG3R6JvujIWaRLQqYLwcf8ThiJK8lOYgy
 c0YvnWMBl29LLrcQk1ql0/nfigs5kvItxsuNQeV9t+9OCz7t0/rizAAHbMh3BmFt2epYowfTn
 KQP8Hk5/TlMKqAfZ6OQKQbPdOAsbQzKEpUBbImULm+m4Qq1ujqoLwiv+OJtnsMWQ9OrXAtPQq
 G9Alx6Fbs9YpQcI/fykYKpBRVaT+5KsV3L11eQa2irGEaIZHvXir9FmHfIhsPwBVu8dwJS3Pj
 DFeceTnhcvXWsR/7j2ehNcB7rDFZmO+ZR6xkc5+7mwvnfXM8pwS8CLfZhEEOsV/3N9wzxff43
 MxUc3sG70ULdXIAdxgYRmDuSrFI6L+T91kfHiXxOQMgAB62ftBCj9rV+tItMc3pBIJRVq+s00
 H2TpwLP5jHg+IJtcz7kpWN8810jnNkbV2rCiSl23l1V8mWuof0bhK0HBlXZ9cwZH4t4ZXZu3w
 V6CdpG/+GM6bpYI9tCRUL3mCbI7HzHQY27ZLKCaWqSzu9yKHr21SDCI1rAvjp6s7trFMH1Dhu
 DUePtAHa5jMYsSWmaOfTJObs7VeN8bYPb/+iBzPEqFZMa1A9FGXWmP9OVTeI0+g/gFGXZIKq8
 jdtt+OTFLurZqjKyI9/ZilnA==
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

On 7/30/24 13:11, Sughosh Ganu wrote:
> The linux kernel has the list_count_nodes() API functions which is
> used for counting nodes of a list. This has now been imported in
> U-Boot as part of an earlier commit. Use this function and drop the
> list_count_items().
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   drivers/core/util.c | 14 ++------------
>   include/dm/util.h   |  8 --------
>   test/dm/bus.c       |  5 +++--
>   test/dm/core.c      |  9 +++++----
>   test/dm/test-fdt.c  |  5 +++--
>   5 files changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/core/util.c b/drivers/core/util.c
> index 108a3bc4da..fa893485a0 100644
> --- a/drivers/core/util.c
> +++ b/drivers/core/util.c
> @@ -3,23 +3,13 @@
>    * Copyright (c) 2013 Google, Inc
>    */
>
> +#include <vsprintf.h>
>   #include <dm/device.h>
>   #include <dm/ofnode.h>
>   #include <dm/read.h>
>   #include <dm/util.h>
>   #include <linux/libfdt.h>
> -#include <vsprintf.h>
> -
> -int list_count_items(struct list_head *head)
> -{
> -	struct list_head *node;
> -	int count =3D 0;
> -
> -	list_for_each(node, head)
> -		count++;
> -
> -	return count;
> -}
> +#include <linux/list.h>
>
>   #if CONFIG_IS_ENABLED(OF_REAL)
>   int pci_get_devfn(struct udevice *dev)
> diff --git a/include/dm/util.h b/include/dm/util.h
> index 95c3527a37..ec518c51d9 100644
> --- a/include/dm/util.h
> +++ b/include/dm/util.h
> @@ -16,14 +16,6 @@ struct dm_stats;
>
>   struct list_head;
>
> -/**
> - * list_count_items() - Count number of items in a list
> - *
> - * @param head:		Head of list
> - * Return: number of items, or 0 if empty
> - */
> -int list_count_items(struct list_head *head);
> -
>   /**
>    * Dump out a tree of all devices starting @uclass
>    *
> diff --git a/test/dm/bus.c b/test/dm/bus.c
> index a338c7f567..95326f23da 100644
> --- a/test/dm/bus.c
> +++ b/test/dm/bus.c
> @@ -14,6 +14,7 @@
>   #include <dm/test.h>
>   #include <dm/uclass-internal.h>
>   #include <dm/util.h>
> +#include <linux/list.h>
>   #include <test/test.h>
>   #include <test/ut.h>
>
> @@ -27,14 +28,14 @@ static int dm_test_bus_children(struct unit_test_sta=
te *uts)
>   	struct uclass *uc;
>
>   	ut_assertok(uclass_get(UCLASS_TEST_FDT, &uc));
> -	ut_asserteq(num_devices, list_count_items(&uc->dev_head));
> +	ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
>
>   	/* Probe the bus, which should yield 3 more devices */
>   	ut_assertok(uclass_get_device(UCLASS_TEST_BUS, 0, &bus));
>   	num_devices +=3D 3;
>
>   	ut_assertok(uclass_get(UCLASS_TEST_FDT, &uc));
> -	ut_asserteq(num_devices, list_count_items(&uc->dev_head));
> +	ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
>
>   	ut_assert(!dm_check_devices(uts, num_devices));
>
> diff --git a/test/dm/core.c b/test/dm/core.c
> index dbad1b317d..5bc5e8e82e 100644
> --- a/test/dm/core.c
> +++ b/test/dm/core.c
> @@ -16,6 +16,7 @@
>   #include <dm/util.h>
>   #include <dm/test.h>
>   #include <dm/uclass-internal.h>
> +#include <linux/list.h>
>   #include <test/test.h>
>   #include <test/ut.h>
>
> @@ -123,15 +124,15 @@ static int dm_test_autobind(struct unit_test_state=
 *uts)
>   	 * device with no children.
>   	 */
>   	ut_assert(uts->root);
> -	ut_asserteq(1, list_count_items(gd->uclass_root));
> -	ut_asserteq(0, list_count_items(&gd->dm_root->child_head));
> +	ut_asserteq(1, list_count_nodes(gd->uclass_root));
> +	ut_asserteq(0, list_count_nodes(&gd->dm_root->child_head));
>   	ut_asserteq(0, dm_testdrv_op_count[DM_TEST_OP_POST_BIND]);
>
>   	ut_assertok(dm_scan_plat(false));
>
>   	/* We should have our test class now at least, plus more children */
> -	ut_assert(1 < list_count_items(gd->uclass_root));
> -	ut_assert(0 < list_count_items(&gd->dm_root->child_head));
> +	ut_assert(1 < list_count_nodes(gd->uclass_root));
> +	ut_assert(0 < list_count_nodes(&gd->dm_root->child_head));
>
>   	/* Our 3 dm_test_infox children should be bound to the test uclass */
>   	ut_asserteq(3, dm_testdrv_op_count[DM_TEST_OP_POST_BIND]);
> diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
> index 18c89eef43..31effff59c 100644
> --- a/test/dm/test-fdt.c
> +++ b/test/dm/test-fdt.c
> @@ -19,6 +19,7 @@
>   #include <dm/util.h>
>   #include <dm/of_access.h>
>   #include <linux/ioport.h>
> +#include <linux/list.h>
>   #include <test/test.h>
>   #include <test/ut.h>
>
> @@ -162,7 +163,7 @@ static int dm_test_fdt(struct unit_test_state *uts)
>   	ut_assert(!ret);
>
>   	/* These are num_devices compatible root-level device tree nodes */
> -	ut_asserteq(num_devices, list_count_items(&uc->dev_head));
> +	ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
>
>   	/* Each should have platform data but no private data */
>   	for (i =3D 0; i < num_devices; i++) {
> @@ -217,7 +218,7 @@ static int dm_test_fdt_pre_reloc(struct unit_test_st=
ate *uts)
>   	 * one with "bootph-all" property (a-test node), and the other
>   	 * one whose driver marked with DM_FLAG_PRE_RELOC flag (h-test node).
>   	 */
> -	ut_asserteq(2, list_count_items(&uc->dev_head));
> +	ut_asserteq(2, list_count_nodes(&uc->dev_head));
>
>   	return 0;
>   }

