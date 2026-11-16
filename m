Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC47606A882
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fvVM6ycc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikFtyRw2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49DFA80FA9;
	Mon, 16 Nov 2026 16:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZy1RqkGctWW; Mon, 16 Nov 2026 16:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FBC280F7E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846922;
	b=ms1OMo+/XKTsbEnqwxYyo82rG0fvs9YktkENTf15WfHU7sxO2XEwPp7h11/Ff1f/TUwo
	 6fMaxWTEvPJP370rXPo1IXqEMLTuuS35X8p6xwDhRa7zlqXG9VW1r+0dyILTi/Be8DUu5
	 0ls1CumvieUDU17rUpKLDwsCq4N6J81wlFz3MQOEZ8Ps0vXwvKj9EN1FUpx6st7Fti2ek
	 FcvrCwt5FoNCWs7b253pDTfnrbG7u2JIFe8kzZ5PXOsJ0bUN41eV/2h5LWJh2F6Z/NmE5
	 oTKcMj47miiFscwx6woP1nYOsXeQOlQbjjmxAMvc/JzCIFJitBmZSHJ6v3yoBvcW0cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F+uHNh7Nwb7tI6Wg2rf8aCeQhzpNbu0mgUOktx7h8D0=;
	b=b+xC+oep1fNmtmJTz9oxdc5TiqxrBNNJcuCz4Rjmaj/8eJS4RldkdnbvKAMk8VyENqyE
	 ZrJnnZb3VS+UlZ0xHIWje+3EAz/z+K+RE2SwV7Ec8pn3qRTi7ymtDzZQJwuXz0x4VuFmu
	 JCwqEbcojH+agV0NnS4Fnpt3L6PCfpgiGqm5TJBXj/sR64QgF+G/HoI+1VwfnbvbTHt8o
	 3vy4qKauwfpowxCGLW6oeSEgq+Q65O8k9UBgoAS8VZjg8MRsMI4kBu6c9zabj81lg4Wlb
	 GL3Wp3dZEdILjhmXAgsBGyh+S1rFzSOAsuQ9he+NC7cAT2uzmIAOxCtIW44q+aifjhg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846922;
	bh=F+uHNh7Nwb7tI6Wg2rf8aCeQhzpNbu0mgUOktx7h8D0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvVM6yccER7ZDW1xNWdeonZfrEQnyWs+Qq6faYALLcksNk5TLPc0NiDwESwxiaU2R
	 dmnqbWUVe8TrYJttwtZV3an6s48akS0LADW4Hn1ou/ZdmsHb4+55Q9x8K6xcXFAXG0
	 lgt5lr/sTmdrULO4E7f5xzOLrggZ2JK4KGTVEPC95On9mlLbygZ7rh2GBR4JXAyYRK
	 P5t5Fn00bx/s6zFjFiOI1XkT+VZvnxJL0XlItiiPk6Q1+fk7gvRn2Z2JZtGDWDbnqB
	 JrDwhT13+fcKd/CjDNCtthxE3MICubCiOX9VZzCo5Udr3QjtO+9KvDPlcalvVhPkm2
	 0QOpR89nyju0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FBC280F7E;
	Mon, 16 Nov 2026 16:35:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DA834DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53C9C40282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IGkvQPj1BlMu for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B9FE14009E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ikFtyRw2
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9FE14009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:35:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2302A40BFE;
 Mon, 16 Nov 2026 16:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449C81F000CC;
 Mon, 16 Nov 2026 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794846920;
 bh=F+uHNh7Nwb7tI6Wg2rf8aCeQhzpNbu0mgUOktx7h8D0=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=ikFtyRw24azxjAHrVlVIAuUu38ZehSrWS3x/V1ZKznYYNph5jrBA8QwQ5YcmmjKVQ
 4RiQprBu0Ihh0iQCZqufdlPkX3NzH+3xPdCQ5vCx5LteyxPV/xkEnMn9+wox84GTvZ
 Nnj+G7A0AUTmdpZxPzQ+e6z2Qiy58Sur0Awg8S2uL4yXGFAUNv3IHtHKRKI5lAVdQU
 v24RdS2IrW8vc5afJONLOdmxM2p02F6jsWsMU2Kg9b+z/o9hTdKpQrpqPcHHoBXlEs
 7ggowuVhHnDsTZDCMqSIJ/Ii4EGIXswlyqdP8hvoYAXUFy+UH7SiRwwglJJks6WvGh
 TqSOHHBXa/4Jg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] mach-snapdragon: fix OP-TEE SPL link failure
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261005060628.595146-1-aswin.murugan@oss.qualcomm.com>
References: <20261005060628.595146-1-aswin.murugan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 22:05:16 +0530
Message-Id: <179484691668.21534.12780048376957155997.b4-reply@b4>
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

On 2026-10-05 11:36 +0530, Aswin Murugan wrote:
> Use CONFIG_IS_ENABLED(OPTEE) instead of IS_ENABLED(CONFIG_OPTEE)
> to avoid calling OP-TEE APIs in SPL builds where the driver is
> not available, fixing the SPL link error.
> 
> Fixes: undefined reference to `is_optee_smc_api' in spl/u-boot-spl
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 374e6262db4..2d6446694d6 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -273,7 +273,7 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>  
>  	time_call(fixup_usb_nodes, root);
>  
> -	if (IS_ENABLED(CONFIG_OPTEE) && is_optee_smc_api())
> +	if (CONFIG_IS_ENABLED(OPTEE) && is_optee_smc_api())
>  		time_call(add_optee_node, root);
>  
>  	return 0;
> -- 
> 2.34.1
> 
> 


