Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E247C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551098753E;
	Thu, 25 Jan 2024 16:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XkcTs/vE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916C3875FC; Thu, 25 Jan 2024 16:36:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E3587186
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706196981; x=1706801781; i=xypron.glpk@gmx.de;
 bh=G507zl5CZuHyUfy3towluECaBlOd161UGNqn0VwxBeM=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=XkcTs/vEb45LyYxbjLG24VgHDPxOvZbFoj5QK34e5CVOkADZL2K9LmTFDxiEY6gh
 7NQXZnDoGuv7Xl1xGJHJmiKWaMTHExxrTAMIDIVfsHPUVokgBTI62R/SaoDyrNd2Q
 mL5ffAczlcXOvV7HrvcMTVFStxJSiLl7P+x4EgOcg3nPoyXKF2eRjKSP8udfMkTUk
 pheuLTUhdpJnELTxhkBllso72j9F31fYkLliDAUR3DWqEUdZkYuymMSjdzlVsDsDS
 fAKZE0uRwpsHP7miKxr+nbjVn6Uw9/0SOsOj1mAzbmz+/53joGo8+beW04yHfZ00U
 JLRioKbC0nUUisMaxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1rY7kY1aKN-00WnKU; Thu, 25
 Jan 2024 16:36:21 +0100
Message-ID: <02bd585e-0e88-4227-bd3c-3972e1c40014@gmx.de>
Date: Thu, 25 Jan 2024 16:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] firmware: psci: Fix bind_smccc_features psci check
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>
References: <20240125140502.22400-1-o451686892@gmail.com>
 <20240125140502.22400-2-o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240125140502.22400-2-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lOQsoTTzIvVozAuxRMincPZVigvSHONtv74ridRUuVVEdA1uk7E
 uBYfdEEFUyxvarWQaT3eto7IQIjl5wHTmWPVKBgStob+z9ouozpJMJdYQ9p0N+SP/FBDRcz
 o0SEm1061LbvhZt1UnXBIi+XpgIZp34PqyTxdMy17eRGH5mhZ1mDnSKOR7LZyZuMLl+DiqM
 sMp0H+wliAgQhEIQrlrJA==
UI-OutboundReport: notjunk:1;M01:P0:PLJh7zug5Ss=;XOGttejHBNnCnykdbPKTXd84Tnn
 2/IB+MvFuozFsdTEuBzO6isWU60i1cnY4rYtoNAhqsjFoOjrBYH4vaXztKWinz9lTW8adePKk
 tEs8hCimwOQSk5xGfSoAeJJnweLUNoud2mCiLSzqrD5DPeZelA5S7Dn46qYs8LN0ovRfAGyVB
 iaBHqdXl+tqKsC/Z/ju7GNlPTYMrtKrq32synqI1QFlKp1bjnXXIyG2PReNkpNSCFJpAHrAqp
 PvwV13Jpca3vAvMjjBuybin/sHdVTvV0f/awCmPIAdNn+xE8k+b5Kkr4qlNoeZuTJFRgh4nVh
 F1KrApkp2Jk/kl0KsCyB+81mjYNMKs334Yq91CqzFrU4dDRK+DLZRXEThvhfb/iXiSUd7Grzp
 a8OI8km8m3otZkxgrdey+2uG/5IEYeTp6+BEbq5NsPf5PYs1UyMa3UADIOfZuIMElub2t7plI
 vFUHYg1BMefXregmfj7afGw40FhZ+4U8uaQm2BTgz05PPz3rcw2nj5n27RoSJUS4gn21YGgwb
 yqPT3VOxQFRZyvrYFrDg8oDIoM7lViBj8i5czV6EPDPORorg0qAXKQnKsMAG0dnVXYZW2yUN2
 kULQmfcOYAr737cJnQEAaipdcqwjrc/Zn0x1/RnQPATFdt2GNesaZCj01uBAYy6nH2x6LNIz6
 E4jSX4Qp4QkjwonRw/GRRrlJldXZVZ5w2RKtomi7adVQ26IaMCu6GtR4ni8L1VPOT7j/cloBD
 6fQ1/sAsrYO9tyhmFBSEIcZPoPbsuPzG/7M9GH6XiGjqkK543TKustnhQBQ0I+Qx3JLc2b6fm
 oy6mFa22a6AF0/dsL/Ax2HxsfYrgeV7qL2B/hbWDK6PlLZMKFgdazHI/OW5KD386OOimWEt4v
 mTJ717dzoQB6rcA9x0WdHIiUBl+gEkmwCsgyTTyOwrCEyUYbWQiV0TfkUNegSlcgTNoYBOjW4
 2r8/PHVonRT8ofzjwd8oWu4KJzk=
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

On 25.01.24 15:05, Weizhao Ouyang wrote:
> According to PSCI specification DEN0022F, PSCI_FEATURES is used to check
> whether the SMCCC is implemented by discovering SMCCC_VERSION.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

5.15.2 Implementation responsibilities

PSCI_FEATURES should report the presence of SMCCC_VERSION in privileged
platform firmware compliant with PSCI v1.0 and later revisions.

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   drivers/firmware/psci.c   | 2 +-
>   include/linux/arm-smccc.h | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c6b9efab41..894be8128d 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -135,7 +135,7 @@ static int bind_smccc_features(struct udevice *dev, =
int psci_method)
>   	    PSCI_VERSION_MAJOR(psci_0_2_get_version()) =3D=3D 0)
>   		return 0;
>
> -	if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) =3D=3D
> +	if (request_psci_features(ARM_SMCCC_VERSION) =3D=3D
>   	    PSCI_RET_NOT_SUPPORTED)
>   		return 0;
>
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index f44e9e8f93..453017eb5f 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -55,6 +55,7 @@
>   #define ARM_SMCCC_QUIRK_NONE		0
>   #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
>
> +#define ARM_SMCCC_VERSION		0x80000000
>   #define ARM_SMCCC_ARCH_FEATURES		0x80000001
>
>   #define ARM_SMCCC_RET_NOT_SUPPORTED	((unsigned long)-1)

