Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86810606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OaoeP7Bs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ww6uxwpj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 058B18112F;
	Thu, 26 Nov 2026 13:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcPJwpHy6q_e; Thu, 26 Nov 2026 13:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC711810EC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698811;
	b=asDbPynKj7Ft+9JY3TmauAn1ZdM4ARpza2SNATc0+NwY4CmzMucDl662zV6EPNCl67XF
	 sr0kkcCKq04A4T2FXB8155zVmQXPhGVKSnVRbNfoual4xAluzyj8A+gd2KXeP42msEWOF
	 CcKZdfea0M3ejq2tCFy9UC4DpZmJf/wtGoFxoDLjnkSxWl6YHsv4Y6RwSPaQX0pkhvLe1
	 wCzA7Kuc0MZUnsJe2JGKHe42xOkX6Ujiw58Z4ZpMqxcgzq/YCoRV2m0zwns7zm3g02c08
	 D5dlKT4gyzzAzWIo1d6fWHNvjlHu9UwWwgTJKeXkDL2TzbtC/kphJmHP2MiVtHAsoRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698811;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oVfC7ka5fryBdxl7oH5Yu1zWkhO1Xlzpj90Hk0Cy9mQ=;
	b=KkPP7NzhAgWLAUOigbR+0il1M4b7cyws1kxPvkQzn1v0Ko1U60ofbYMxGLM6mqCEVVsN
	 n4sRHn/4Zwki9IFJIukYZT9TACcqI/qhGiakSmm4xY+XAbi7kluxqJWBghwsR8XHFUk2W
	 xia1z31GNKOEcpkkZRo6hpaoXa3cw2133nQptSdjPRDcQBYIaJYy9/cZ0cgFL6HvDCkww
	 kug9BfImVzZtt9/pRcBG1zJAMCtrx0yHjq8JttBSg9jpMhYxHSdugAhcuOflPTNOByug5
	 nIFm8tZHbo4aVKug3t0u30HrO+mfzVfaylKAlZo7eKM0gtMFT1QDCSKzBtKHv/vluHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698811;
	bh=oVfC7ka5fryBdxl7oH5Yu1zWkhO1Xlzpj90Hk0Cy9mQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OaoeP7BsFe4FvDRsG+tI2VrkePKRwPFNBGTPe6KquUSKnhP0AmevJN/dnd+AT4WyL
	 m1CsxurMUK2zHgOAcR5mhYAimZtSy7Eag+k4gJ0AJzgKiNhrm1pc/jTdQcQIh522K+
	 OBdC40Y2bhm5SXQT7stx/hNGlVV7mrmr3TF7BLSfVo183d6jNwZLP8F3LBggYvpT55
	 6nuODIcqsTKx5Os/4pvXPfXuJjsY0IIzBUgrELrN4Ue5wA24p4DhWpOBDNjMwlPKsC
	 Ht7r2pjlLmyqpgVfAvb2BwM8evykZA04UfYKHC1clZJ/X7gFhAlOgFFLmgBgOTzsC+
	 wMSvFo9OSsfIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC711810EC;
	Thu, 26 Nov 2026 13:13:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC21932D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 929BE404E5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-FQJ9ID8lwE for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7F2A5404DC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ww6uxwpj
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F2A5404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:13:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C6C860F92;
 Thu, 26 Nov 2026 13:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51351F000C0;
 Thu, 26 Nov 2026 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795698807;
 bh=oVfC7ka5fryBdxl7oH5Yu1zWkhO1Xlzpj90Hk0Cy9mQ=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Ww6uxwpj2uNgVoEHBiic5cIB+gnYvre+8Ic+ZUN4cBkX9BCmJ8FZoWGJPYL16TnIL
 Ju846EDDa0kaFfO/OngCO6YFVLiaDUSmX9JeWW8UaGPLTOoCUHaqpNLMifsU/UcZ8k
 TTs4g+MZz9hmSNeyqJGJNezQzp8ysez9iD+15te/rMQCiztWr8W3dgKmTG17653GXI
 3Z8YFO9EGJMKitCx84BzrCqXLRjdv+soPXLa5ZtEK635cuTyWQHou95mzpcUCSxsQv
 Rm+x97S2Cdf6VzVjyhRCFZLIR7YZS3wj44kfX24NdWW9NxrQHS5G3YUml3cJB86InM
 Mff0zD15pDPCA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 13/13] configs: add Nord defconfig, MAINTAINERS and
 documentation
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com, 
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com, 
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com, jbx6244@gmail.com, 
 nikroks@mainlining.org, bartosz.golaszewski@oss.qualcomm.com, 
 shengchao.guo@oss.qualcomm.com, andersson@kernel.org, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261105182614.2405482-14-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
 <20261105182614.2405482-14-aswin.murugan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:43:19 +0530
Message-Id: <179569879909.130558.4733812127518484983.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-05 23:56 +0530, Aswin Murugan wrote:
> Introduce a defconfig for the Nord board, add the corresponding
> MAINTAINERS entry, and document the board.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  board/qualcomm/MAINTAINERS        |  6 ++++++
>  configs/qcom_nord_defconfig       | 27 +++++++++++++++++++++++++++
>  doc/board/qualcomm/dragonwing.rst | 14 +++++++++++---
>  3 files changed, 44 insertions(+), 3 deletions(-)
>  create mode 100644 configs/qcom_nord_defconfig
> 
> diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
> index 3767a2a7949..39bb5ea90fb 100644
> --- a/board/qualcomm/MAINTAINERS
> +++ b/board/qualcomm/MAINTAINERS
> @@ -22,3 +22,9 @@ QUALCOMM DRAGONWING QCS9100
>  M:	Varadarajan Narayanan <quic_varada@quicinc.com>
>  S:	Maintained
>  N:	qcs9100
> +
> +# IQ-10 and similar boards
> +QUALCOMM DRAGONWING NORD
> +M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> +S:	Maintained
> +N:	nord
> diff --git a/configs/qcom_nord_defconfig b/configs/qcom_nord_defconfig
> new file mode 100644
> index 00000000000..9473ead48fe
> --- /dev/null
> +++ b/configs/qcom_nord_defconfig
> @@ -0,0 +1,27 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of Nord dev boards with
> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=y
> +
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/nord-rrd"
> +
> +CONFIG_QCOM_GENERATE_MBN=y
> +
> +# Address where U-Boot will be loaded on this board
> +CONFIG_TEXT_BASE=0xD8D00000
> +
> +CONFIG_ENV_IS_IN_SCSI=y
> +CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
> +# SCSI partition type GUID for logfs partition
> +CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
> +# CONFIG_ENV_IS_DEFAULT is not set
> +# CONFIG_ENV_IS_NOWHERE is not set
> +
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
> +CONFIG_OPTEE_LIB=y

There is a config fragment for this, include it instead.

-Sumit

> diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
> index 42828842da5..cfeffc0da03 100644
> --- a/doc/board/qualcomm/dragonwing.rst
> +++ b/doc/board/qualcomm/dragonwing.rst
> @@ -6,15 +6,17 @@ Qualcomm DragonWing
>  
>  Qualcomm DragonWing boards are industrial-grade platforms targeting factory
>  and edge applications. They span multiple product families, including
> -IQ6, IQ8, IQ9, and Q8, which are based on Qualcomm QCS615, QCS8300 (Monaco),
> -QCS9100, and QCS8550 series SoCs respectively
> +IQ6, IQ8, IQ9, IQ10, and Q8, which are based on Qualcomm QCS615, QCS8300 (Monaco),
> +QCS9100, Nord, and QCS8550 series SoCs respectively
>  
>  More information can be found on the `Qualcomm's IQ6 product page`_,
> -`Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
> +`Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_,
> +`Qualcomm's IQ10 product page`_ and `Qualcomm's Q8 product page`_.
>  
>  .. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
>  .. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
>  .. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
> +.. _Qualcomm's IQ10 product page: https://www.qualcomm.com/internet-of-things/products/iq10-series/iq-10800
>  .. _Qualcomm's Q8 product page: https://docs.qualcomm.com/doc/87-61717-1/87-61717-1_REV_D_Qualcomm_Dragonwing_QCS8550_QCM8550_Processors_Product_Brief.pdf
>  
>  Installation
> @@ -54,6 +56,12 @@ Generate the default configuration for the IQ-9 platform:
>  
>    $ make O=.output qcom_lemans_defconfig
>  
> +Generate the default configuration for the IQ-10 platform:
> +
> +.. code-block:: bash
> +
> +  $ make O=.output qcom_nord_defconfig
> +
>  Generate the default configuration for the Q8 platform:
>  
>  .. code-block:: bash
> -- 
> 2.34.1
> 
> 


