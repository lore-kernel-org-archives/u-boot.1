Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD3606A32D
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=le9CQb7h;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nc8inpBV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7714960A7B;
	Thu, 26 Nov 2026 14:15:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWTh9GTkNN6t; Thu, 26 Nov 2026 14:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB3EB60A59
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702521;
	b=VU1fS1fC1pLvlWphb79boG09lKDbZF6eo2nrw0VKZ1bwfz0gU5awDNCW788ANq/EHuHi
	 mzjoInMj6ARCSSdD/HMGl5faANUGVmMAhLSEbY9MzblkPlUSaQtrNZ9C9QFqwpjRo6dMb
	 l6Z/3Lqq/cZj/NPJc5rn76K5UfmublRBiXv8YK+Xfi5XkHx++rc8qpAXFh3Fx8JE39Cwo
	 SXAVdLbU95vsY4KpfipxtR36IURo7r6u8fcvzFxgaoDC8Hy6IPlYVC8uiwFbjtSjt3p7C
	 b4Naa2f9ohICp2gn1TgsWh66nq2bCdTElddvm4WjLMumpoSz2c0y7jiACrvrsRMMf/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p8X3nL+iUbiEbMpTM/ttOkQoGhxd55FSZJpDy7T65tE=;
	b=UKlWNleGcadeEG3WFNtkPkRxWz/QabPCzQPLq03HvQhYyr2tIVLtxGMiY/PqJiG/+JDO
	 g0XJhGPOqZ5geAw3CUjN1PQi9FVyCOLGNS3ir9LD3TiCunm+nY/5+fGQ9SRURi/Uu84Tm
	 u8NSEUm2LUwiz1nEq7zUlfla21Q4MlfAthWvybBI7+Klax+ia2O2tNO9OM7B7aod/wVCH
	 ZxaPlozME9ohnsI+QEY9OKs746q+ae7v2dw/wrFam54EP49HUk4Gewsm2PBuTLaPghXFC
	 ScqoJb3ttSx821ShGOt+rHmRKL1MGcHe0PtAH+yLPttndsKxxCwyZIoI17ujSApuWkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795702521;
	bh=p8X3nL+iUbiEbMpTM/ttOkQoGhxd55FSZJpDy7T65tE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=le9CQb7hKH0vjBdAKAOvA4UGbA0WZs1CJTBjcmRmJnmPlXon7ztVWLWrnuzk1BqhZ
	 NMnwd5H7UM9W2Ra3tf6WawV9IRJYcrcg0iY45AW9C8eBkzIHc56W21z2THCflbTiAp
	 2X1c8DLF8mlhRDXKLEJ1q8YHfVHI95JKNputxdAIniSJJdJujOLczEPBUt2h8bmxpK
	 p/FgDdlwecRSMm90tu+UL9WRlW7/ODUYwnyxOSETUngisv+d3CSG70zUHNrJSUA019
	 evqdI2Ak+Z3FPG5o0Q20r1TjcmekyClrH+Ky3o2Lw/TLMHmvnYqUKUB4wqtLvwZtbq
	 Kuo7wor/EoZmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB3EB60A59;
	Thu, 26 Nov 2026 14:15:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F994260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 811E0404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2FGg6qjfsWfo for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:15:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D4A3F40111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Nc8inpBV
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4A3F40111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:15:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 195CB43452;
 Thu, 26 Nov 2026 14:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E971F000C0;
 Thu, 26 Nov 2026 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795702519;
 bh=p8X3nL+iUbiEbMpTM/ttOkQoGhxd55FSZJpDy7T65tE=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Nc8inpBVu7PhkSXFoeTAszAeO3t/rbmRm4yObkgBrRBzMBUNuF1mbsRWSVbpNEUEp
 v8m2eW1RDEypGvgXQNNDjlnffBJsYD2Qbte7t2OqbfDRD+y/NY3NTgjEaJm9YjUlbK
 dui1RY+4OpuhVFY6BzdyJmq+gAzBi3ndki7kKQ/7FLyuiDr8Ukzy+8gvmu9/V8wrlI
 +AfL95eyVzUf43mILdLm47/JBJkak8o20XeYwVvC+s6u0twG2705Tk6E2YdmYh1MBu
 usRNIYNRGPt/KFTiGSq18LAljtt2SErz+Ih41OyIQ3ROIZ2Pnew2JCPhSuI7/An7h+
 GSJokivvcbJ+w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 5/9] qcom: smem: ignore partition entries with
 unsupported host IDs
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com, 
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com, 
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de, 
 william.bright@imd-tec.com, nikroks@mainlining.org, 
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com, 
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <20261124164700.1606518-6-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
 <20261124164700.1606518-6-aswin.murugan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 19:45:10 +0530
Message-Id: <179570251039.130558.7019012907538146753.b4-reply@b4>
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

On 2026-11-24 22:16 +0530, Aswin Murugan wrote:
> Shikra and other newer Qualcomm SoCs report remote processor/host
> IDs in SMEM's partition table that exceed SMEM_HOST_COUNT. The
> current code treats such entries as an error and aborts partition
> enumeration, preventing SMEM initialization from completing.
> 
> U-Boot does not use these remote partitions, as all current SMEM
> consumers access items through QCOM_SMEM_HOST_ANY, which resolves to
> the global partition. Supporting the larger host IDs by increasing
> SMEM_HOST_COUNT would unnecessarily increase the size of the
> statically allocated partitions[] array.
> 
> Skip partition entries with unsupported host IDs and continue
> enumeration of the remaining entries.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/smem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index e20523e2cec..7a5a43e1274 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -936,9 +936,10 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
>  		else
>  			continue;
>  
> +		/* Skip hosts we don't track; other entries may still be valid */
>  		if (remote_host >= SMEM_HOST_COUNT) {
> -			log_err("bad host %u\n", remote_host);
> -			return -EINVAL;
> +			log_debug("skipping out-of-range host %u\n", remote_host);
> +			continue;

I don't see this to be the appropriate thing to do since you never know
when a use-case comes alive and it keeps silently failing here.

Kernel SMEM driver switched to using xarray for efficiency, can't we
handle it in a similar manner?

-Sumit

>  		}
>  
>  		if (smem->partitions[remote_host].virt_base) {
> -- 
> 2.34.1
> 
> 


