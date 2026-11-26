Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618C606A32A
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f1QPppY2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsOKviwu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8239840897;
	Thu, 26 Nov 2026 12:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mlMMfKXZxGSI; Thu, 26 Nov 2026 12:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF4C64052C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795697404;
	b=Bsb4awcNHEIK9vAbpd/4+CYS0IQolBUG3vOZ7PgMH1bekpu5dnnq1KSRC/gJ7zcG2196
	 VcENtRQRAaK69/iowtsE6D6Llm7ZrX7bjgpJwkqKxySqzjMnUH7S0PcW8Au14/UKwcLOP
	 mNfPc5/QuBNIPpJv3bAtQWcY/ic7Z8KIeG95hUM/hD/lqiNv2efjZKwfcEhaWkcViP9kN
	 xC6YRPIOkHlRwxJlnX0dctT+CqK7GaQdE+rF5e4Tc3f+zEK+gZm00EWgU0pDrIBtip8g7
	 kJZw8WsNklx8wOgOBjGheUhh4bK8/grXWHRXXrQobSyrahfBAGg3bid2mszXdF8v4bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W+L8/kFRqS9NiGUvMa3zfhtpvnlmaqTCxlcDFkhVm2g=;
	b=kcNYUcPgXXW0AteiBUATszNjkWYd+amJAkNlXP5pXnvZf6qv0LM1glgDldAMTZmUMtq9
	 0s8/9MhPy2k8g76b6DfMwDF0qFvD4r0ayaLhwgGh75fUlJYf2ufF+Z2qsEYmxApX7GOvR
	 mxMR33qjpUYoX0hs0h62SH3zjuJtHgOVGl88nKrCPlu9cvtN/BGiGB3PYsG+BT4dYFhyT
	 VZ0rm1vmiw0Fdn00ezoPR9q6Peq1p28oDuwhC570RBjNUuXvBtWTJoaJZed4iOCmrBM0A
	 c0O+r0w62mXy4W4TCixDxP5beHDFs0jML6lSCs16TzxnqNTyuNntqfHHZhWh/Jij/4A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795697403;
	bh=W+L8/kFRqS9NiGUvMa3zfhtpvnlmaqTCxlcDFkhVm2g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f1QPppY272JOZOKONYi4wzNns9NwlDbnMjnbyxsXKpPQrR6V3azLbjhszdZ+H/p/d
	 YyNQD+FYWZhldKzOoZaZ1tk+5CIRFLxwdjSt4oUGIf9PB7UevdUGYVqMHfOqu5Z35i
	 OqSkT1vCoUa0NXWU17gjHPrk4+RIsxv+entjX+pwIBDrnYZa7uO2o4EbPOOvI6ahyF
	 O6jFWWiQqZqbQcY35tkJ8Rt1PG94bv2e52/TKrFwWazGSfkyQ3BH5E49BbPLaEzAbY
	 Vx/RGomkdPw2FWd1kZegGQFI/yzG8uamE/PPnu9DMGRJtYaLXST6zoFJXiFfV5q+0J
	 wkA1BzSjK8pIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF4C64052C;
	Thu, 26 Nov 2026 12:50:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC68A2DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9ABA810C1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:50:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5JWk5Ks-YBzS for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:50:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04AB181095
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SsOKviwu
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04AB181095
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:50:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED3EB44F9B;
 Thu, 26 Nov 2026 12:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB90A1F000C6;
 Thu, 26 Nov 2026 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697399;
 bh=W+L8/kFRqS9NiGUvMa3zfhtpvnlmaqTCxlcDFkhVm2g=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=SsOKviwuyyDackhrZxWdAO0BXlCwvzDdL6pEzelhf5hbH4V+bIrKrclVAagnWnvMI
 +T9vRVIeBdNi3DlrrJWkAYwrFM7oDW1XhsqYqGvHzoS/HFev/FjddxNIzqpsjlLZw3
 It19L2kyhSnB5XU/QM3UR8g8igizq+IWz2sax5KRLpA45enJnANyz7/1+JYIyXSR/s
 VLLoYW9Z0PL3/YtIqq+9FI1kWj3zhNCUc7o/OgeU2x+BKoqbRQYRG2zGzMTWRjTP6E
 iHg0ouAgfd91oU9j/2IwVBACf6K5MtiavPsMZdKOdnYXXh5fA0ufyQMfttrbPizHA3
 ajf3Z4CvHJS1Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mach-snapdragon: dram: fix SMEM error pointer check
From: Sumit Garg <sumit.garg@kernel.org>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20261020-dram-smem-errptr-v1-1-b79712e1b39a@oss.qualcomm.com>
References: <20261020-dram-smem-errptr-v1-1-b79712e1b39a@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:19:49 +0530
Message-Id: <179569738929.130558.11119273093895961682.b4-reply@b4>
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

On 2026-10-20 11:59 +0530, Vandhiadevan Karunamoorthy wrote:
> qcom_smem_get() reports failure with an ERR_PTR(), for example
> -ENOENT when the item is missing or -EPROBE_DEFER when SMEM is not
> ready, and never returns NULL. The check in qcom_parse_memory_smem()
> only tests for NULL, so an error pointer is treated as a valid RAM
> partition table and header->version is then dereferenced.
> 
> Use IS_ERR_OR_NULL() and return the error from qcom_smem_get() so that
> qcom_parse_memory() reports a missing memory map through its existing
> error path instead of faulting on a bogus pointer.
> 
> Fixes: ed40a06be832 ("mach-snapdragon: support parsing memory map from SMEM")
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/dram.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
> index 0b97b698322..04b6d167848 100644
> --- a/arch/arm/mach-snapdragon/dram.c
> +++ b/arch/arm/mach-snapdragon/dram.c
> @@ -8,6 +8,7 @@
>  
>  #include <asm-generic/unaligned.h>
>  #include <dm.h>
> +#include <linux/err.h>
>  #include <log.h>
>  #include <sort.h>
>  #include <soc/qcom/smem.h>
> @@ -92,9 +93,9 @@ static int qcom_parse_memory_smem(phys_addr_t *ram_end)
>  	}
>  
>  	header = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_USABLE_RAM_PARTITION_TABLE, &size);
> -	if (!header) {
> +	if (IS_ERR_OR_NULL(header)) {
>  		debug("Failed to find SMEM partition.\n");
> -		return -ENODEV;
> +		return header ? PTR_ERR(header) : -ENODEV;
>  	}
>  
>  	ver = header->version;
> 
> ---
> base-commit: e36b675ebc4c41f1f4187c46d363d581c371d538
> change-id: 20261020-dram-smem-errptr-e070f4d5e8fe
> 
> Best regards,
> --  
> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> 
> 


