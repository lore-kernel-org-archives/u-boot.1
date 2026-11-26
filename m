Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16650606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JJN9+5NT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zkk4TPO7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AB2B4095D;
	Thu, 26 Nov 2026 12:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZJKMTLWxLNg; Thu, 26 Nov 2026 12:34:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BAAF84084E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696466;
	b=hH02FZMnUplHxv3SyTGQPzYCZvX7osDgw74ROSrblgN0K4J+wpnIhosAN9FwHvy/I/i9
	 C2ODQRabsiYwI7o73JkCpagBxoupFcXrkVg5SYsbpcTkYk8cq9Fsb9Ih4VF2U9wAfqU/w
	 drMF3VbT7UPCPWxRZefUrfTc1OwRHcCSdv1F5IRwGlMNouUrmfwmzWbJX1EGaqwC9IqpQ
	 ySoPtmGdLXa6e6wqsKK07wwzse/sVqhRmZRroFk32Ny/OQlNH7IB8TiRFZ7fHLWYqgatB
	 dcjse7opHXyyn58jn3bszjJXcvjHB3v0efYFLElENhsDKNFkkr9LGYOiWgwfoPzb00A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wVEMw/kp3YnDEz6n/Pae2Q5z/eNw2zgBxNTsmlWEj34=;
	b=FwV51ArwYxJDNp2q2DeMfCcjBMj6uKv2OAUL77xAbuKd6QFgm8JWYBOnZb0B9lM+Lu2y
	 PXIQvyZmm5HSgjKTYIGo9nVLOvokCYBxGCPxK/UYpLNccERJIvgpGgiqqMtqLkKGwopv6
	 Z/SaEyOS5l+90YkvahEf1HBX6lfnx9wNW8D04pRUl1rrO/SZIUQ5SnwVEFXDmvC9mYWrN
	 G7ne0YtEFfkwh465tl/eN6EWr1D6lxe7GewAzQZQ2NoOKD/lnJ+AJ4gYNVxeggkoPa7/H
	 nCGowTwBKfpml1nqSQwkVL/g+A2m2mjaXQZgHmG+Fuu9lQ58urmYgFFZdY0ITLtJtHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795696466;
	bh=wVEMw/kp3YnDEz6n/Pae2Q5z/eNw2zgBxNTsmlWEj34=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JJN9+5NTH1xro3gh1eqkU3qxwaJXa8M35Uy9HLNz9ZYdY0mBQIZpJ3MG8X+6qCKLs
	 1ptCio7akTy02ucVGQlkjZLPwLCuS9G97p8+8k41BtsMCOM1NY9/8AjDwAWNkHrYBQ
	 pBqGLJi1OlimwNn6AvCypcjAm8MJp2UhQAC0JWUDdxHJRbyqcPQlmJQhPsGzYOrl5t
	 p6GPJd7tf32ZVNqSoMj+gtdmpszfFTIr44VGqjdTfvnyvGSm4AThjQRCYCKLxwW+5K
	 8bCVr51Y/nXqNPSEgaoLl0hkfgEvyWY0lraSPt7NvcIcdPWceRy9dWxWzBkQp7Yw/P
	 mtQ3G6vrz07qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAAF84084E;
	Thu, 26 Nov 2026 12:34:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 49CA91AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FC4080C5D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:34:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1j74UBVdrx6 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:34:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40F2B80BDD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Zkk4TPO7
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40F2B80BDD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:34:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04979406AE;
 Thu, 26 Nov 2026 12:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD6F1F000CF;
 Thu, 26 Nov 2026 12:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795696462;
 bh=wVEMw/kp3YnDEz6n/Pae2Q5z/eNw2zgBxNTsmlWEj34=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Zkk4TPO7dQqgVg81MLIXiljyYKfv+BwNwjtE4Rj43Nte0I32BUb2XKeNg6xSO4uz1
 pq16DvoEWivy/cbgwOXZPO1nA/iz3GXLn45w0FLYjvsR0N7uMkZgOO6a7TIe8zMtM5
 XM5W7JPyoYOo/u58cebASarzawf95w2fc7xiSbNDqrY4PNCbeZ/Cu0lscPHi/rAvtI
 6Pk0HgAzfac6FeFsO90XlDJj8hiKm5fLyqYoKhrz2uy0HprBE3rCwl76Q+hoak6hxw
 4zbbkKv8xB25Stq6d5sYQo80lnmaPADBQfQ0P1dBpTYru+2mNbznmpcnZRzXNM3290
 L1zH7JsRmEyyw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] misc: qcom_geni: fix NULL pointer dereference in
 qcom_geni_load_firmware()
From: Sumit Garg <sumit.garg@kernel.org>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261013-series3-oem-spi-nor-init-v3-1-f621792686c7@oss.qualcomm.com>
References: <20261013-series3-oem-spi-nor-init-v3-1-f621792686c7@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:04:18 +0530
Message-Id: <179569645802.130558.11436427656890437898.b4-reply@b4>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-13 12:19 +0530, Vandhiadevan Karunamoorthy wrote:
> qcom_geni_fw_initialise() only populates the GENI wrapper's private
> data (fw) if it finds a firmware partition at EVT_LAST_STAGE_INIT. When
> no firmware partition is found, for example on a board with no MMC/UFS
> storage where the firmware has not been provisioned yet, fw is left
> NULL and a later GENI peripheral probe crashes dereferencing it in
> qcom_geni_load_firmware().
> 
> Add a NULL check that returns -ENOENT instead, so the caller fails the
> probe gracefully rather than crashing.
> 
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> ---
> Changes in v3:
> - Drop "cmd: qcom_geni: add idempotent qcom_geni fw init command"; repost
>   only the NULL pointer dereference fix
> - Rebase on top of upstream main
> - Repost: v2 was sent with a wrong author/Message-Id domain (test.com)
> - Link to v2: https://patch.msgid.link/20260924-series3-oem-spi-nor-init-v2-0-fd8ac27e7057@test.com
> ---
>  drivers/misc/qcom_geni.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index a62ae6a2478..2e8f72d5c8e 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -376,6 +376,10 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
>  
>  	/* The firmware blob is the private data of the GENI wrapper (parent) */
>  	fw = dev_get_priv(dev->parent);
> +	if (!fw) {
> +		dev_err(dev, "QUP firmware not available\n");
> +		return -ENOENT;
> +	}
>  
>  	ret = read_elf(&rsc, fw, &hdr);
>  	if (ret) {
> 
> ---
> base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
> change-id: 20260824-series3-oem-spi-nor-init-2fe96d643af5
> 
> Best regards,
> --  
> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> 
> 
> 


