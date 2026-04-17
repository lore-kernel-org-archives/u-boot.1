Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0B7F43683
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 09:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26AA84214;
	Fri, 17 Apr 2026 11:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="n2vnstrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1AE84223; Fri, 17 Apr 2026 11:50:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94E2841C2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 11:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776419434; x=1777024234; i=xypron.glpk@gmx.de;
 bh=Q6ZmLNb4X/CjwrqZlxyHgxrk5k3NTAozUy6FOEcTFtM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=n2vnstrw+dTKLHs5OzOeYR1VYi5wQzESXL9mmbPK/wg/VapmFGHvydF3oXQglu+u
 SoeOIc5hS8v8Zo0wVz9fSBBWXsc99eT7nedmwwSjtTrpiAwIjRDJnrRB7m6zUVC8W
 39cRC+5RBEJp4nFyFZirIcrpoUR1n+nrNiyirk8PTiEBaY0RiWE48cFiPop3Y+5YQ
 I5obXoYO/lL6C4jHr3V3LbpS8PURQvH5bnlKsVBmOUS+HaTjDtw3Xmm6lFEJRD5DZ
 U8MYqmoFc0cLsDSUTVDqnIDI+oRCa/5g9l3B8CLdpl2gR6Eh/OnYP38oTY4CplE2B
 psqmv/a0ecEiIl5YIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1w8Utz0UVp-0036nr; Fri, 17
 Apr 2026 11:50:34 +0200
Message-ID: <0697f98e-a0c5-4d81-873d-1e545ceeb6d0@gmx.de>
Date: Fri, 17 Apr 2026 11:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] configs: Rename qcs9100 defconfig to lemans
 defconfig
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com>
 <20260417093924.3357296-2-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260417093924.3357296-2-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JB5YBdKq5Ol4qPlaftBslMEAYoCxkq5c1MAj1ePdJzuWHt7trNx
 fqRnxCB5Fyqf1xZyCC+M7bnHxB4p7K4oZvj+pILprT7fckhi0FH/LckWimVPuW/mmWyV/bS
 0+22ZRFywnHeD17gaO6MU5hzj3BzW/12VFILcqQAtzGAj6DKJ9zfHibGyTt+VCmwjRs72II
 aw7HUp/OUMs9YnqdLYoig==
UI-OutboundReport: notjunk:1;M01:P0:8i0CYNg33qc=;X70lJpUBvF4gfhAclUgDfkjnQ00
 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
 kZ2IfQJyHw7oQPw==
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

On 4/17/26 11:39, Aswin Murugan wrote:
> Rename qcom_qcs9100_defconfig to qcom_lemans_defconfig
> and update the defconfig to select lemans-evk DTS instead
> of qcs9100-ride-r3.
>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Why do you want to delete qcom_qcs9100_defconfig instead of simply=20
creating a new defconfig for the different board?

Best regards

Heinrich

> ---
>   configs/{qcom_qcs9100_defconfig =3D> qcom_lemans_defconfig} | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>   rename configs/{qcom_qcs9100_defconfig =3D> qcom_lemans_defconfig} (91=
%)
>=20
> diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_lemans_defcon=
fig
> similarity index 91%
> rename from configs/qcom_qcs9100_defconfig
> rename to configs/qcom_lemans_defconfig
> index 082106157bb..ad40d5206c0 100644
> --- a/configs/qcom_qcs9100_defconfig
> +++ b/configs/qcom_lemans_defconfig
> @@ -9,7 +9,7 @@
>   CONFIG_TEXT_BASE=3D0xaf000000
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_FASTBOOT_BUF_ADDR=3D0xdb300000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/qcs9100-ride-r3"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/lemans-evk"
>   CONFIG_ENV_IS_IN_SCSI=3Dy
>   CONFIG_ENV_SCSI_PART_UUID=3D"71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
>   # CONFIG_ENV_IS_DEFAULT is not set

