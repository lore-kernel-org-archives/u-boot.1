Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8897C369B4
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 13:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1E282A27;
	Tue, 15 Apr 2025 15:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pftiCq+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56C782A39; Tue, 15 Apr 2025 15:25:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B800829CF
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 15:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744723553; x=1745328353; i=xypron.glpk@gmx.de;
 bh=qPVl7FDeGXCkbPiPX/RK5Lu1GxhX91k4SQgeFVtY3Qg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pftiCq+HM6X6GK7avyMOUODijRzd64OHftejx6ukC0dVRk5k/I1LfM0x+LF4EfWZ
 /WzjFRJjW0A20rBIBd6GojNIdBAhcS+kNhzVDwmYeWJNom3UnkOFBTdPVKfQuWXOe
 YnoeS5V6CyaoI9kSx83RwT+kuv96rn8zUNjlzMRqnPCqcyKJ3MS+qmQAZe7j2rxHC
 AZUhojf6nhLkui4NHNKyoSIZIkgipYHL354oqLkjxdufwI6d5ueUVg1yoIMiaCkvC
 fV4O7jTvn+AgcyjQZ4lLC2yj+Is5bCdaA3+k1Osnj3py+9sFhFAXQbmKGlxXve8BN
 5ZvBzDudlNeMCf9oMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUZ4-1tF7vR16JI-00aOfr; Tue, 15
 Apr 2025 15:25:53 +0200
Message-ID: <b4d515cd-57de-4094-96b2-54749129a284@gmx.de>
Date: Tue, 15 Apr 2025 15:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] test: fix print_guid()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, U-Boot mailing list <u-boot@lists.denx.de>
References: <20250415125345.427420-1-jerome.forissier@linaro.org>
 <20250415125345.427420-2-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250415125345.427420-2-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xbTQb4Fp+tP6N5x6gloeNl4tKB2Pss7yXPfX5coDRbE13od+Ub+
 9lyvW5ssNOM+yjOVD36YAcCYO/ybuwzkl6nEh+HughsmyKmTa2IAlmBUcqUnexwPsxBrt7t
 t5km7wDfgP/LHtZfrVledwb6bf2ETn+zvQ9Tkddmpxh4h/6/8wYLtC+rH5dWceC5orpEhuh
 5t7GFlkvpf28Z8qUzg6Pw==
UI-OutboundReport: notjunk:1;M01:P0:42ifcyu1TMA=;xvorJWC7x/7ookLnmEri9+J1tkR
 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
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

On 15.04.25 14:53, Jerome Forissier wrote:
> The %pUs format specifier prints the system partition GUID as "System
> Partition" if PARTITION_TYPE_GUID is disabled but either CMD_EFIDEBUG
> or EFI are enabled. See list_guid[] in lib/uuid.c. Fix the print_guid()
> unit test accordingly.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>=20
>   test/common/print.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/test/common/print.c b/test/common/print.c
> index e3711b10809..574c84b2eee 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -47,6 +47,8 @@ static int print_guid(struct unit_test_state *uts)
>   	sprintf(str, "%pUs", guid_esp);
>   	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */

I would not know why a brace should be needed for a define using
{( some expressions }).

The problem should be resolved since fa847bb409d6 ("test: Wrap assert=20
macros in ({ ... }) and fix missing semicolons").

>   		ut_asserteq_str("system", str);
> +	} else if (IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI)) =
{
> +		ut_asserteq_str("System Partition", str);

Printing two different strings depending on configuration settings is=20
not very helpful for users. Can we print "ESP" in all cases, please?

Best regards

Heinrich

>   	} else {
>   		ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
>   	}

