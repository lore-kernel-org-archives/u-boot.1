Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32960606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fo7Gwm74;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ApPOHSHV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C14F9810A2;
	Tue, 20 Oct 2026 23:08:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_h30piqAFh8; Tue, 20 Oct 2026 23:08:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F28B081090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792537680;
	b=MmZLRJ4tpYNRybxzkYLWwJ7xmKtzwwiY3/bMHntXQ0G3n7L4BfVjMoLpeiN9v02xOjBR
	 JAhshFbAbQidZSlS45GyRMuffR4HO7MmJaGreLFK520yhWwRZm4Y7Z5mus5ewXXEpPWX/
	 MJxYYaghlUt5cjc5qHcDX83Epz1vImU37RS+mpWwELCkfzEx6NI0RSheZzMI4w0DxDW7t
	 +1VGEaxojk5d1ZdUXzTINjUzaH4Z2E4j2HRcW6M4rSveLNVWQFJ6Z7ZFyf+TZE1cwY6Ot
	 dCuXftOsXrNK+njLVFmLZiBAG7YDJfpbf0iyWpO2NGVwKiFOuVDV/bBEMzTGyB14UlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792537680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RXXDFDKtyKSAfmK99JNBRtwFhNMYcYi/NqU6mXY+l/E=;
	b=FBh6D/We8sZqTHhb3KPQ6ii/Cz0DdQC5OQ2uCcpdwa0cKEqu5UiLiwT+YAw7k18KRVwa
	 QVz+ATOfit1JksQSm7ZVozV0TwX4e24XVegmrM3/RvY2bpRb/4jn4n1+Bml+q5SrQ6+ff
	 Z3PVO/WMp7cK6xoXmTXhCiCnDd4HnxlP1ET53XeaQbY/woSoR5OKBOmJakfopJvK627aU
	 jPXsHHJIgV23xpPe9cgPEFdBRv0CiDqS0N1yrjIHhXXsJap/A4xZ3vCY66+H2bdTz6MYK
	 fZutzd2MqbZwOvehJTD9E66OltBlkG21ojGxb1fmbv7/8Qjwsdfiy1BobvXPUPhXRIw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ApPOHSHV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792537680;
	bh=RXXDFDKtyKSAfmK99JNBRtwFhNMYcYi/NqU6mXY+l/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fo7Gwm744EipHYD/NfA7vdNxjigz7z7yENW3x8nYi9KyOg1A6pS/beUPSVvEhgySx
	 oAo0oBQ0sNIJotbUmzW3E/WcZlko7d9dypyeeV4onozKsVLYO+xhl0o4MMhmoqfw62
	 nJ7Av/sfjU+pczWdTdwTs/UI3W9fanIhDUeH9qJWxJHE6HRz2f3HLR8/NM/qiq+Vry
	 VoeYqQV6FDxuaz2B4ubmb8vAAjeNsQE6SxAOpA2uE3X+p0lNq3Wq4AlfqxD0e4fpWo
	 3pV8R8cEdweSri4/kf6Zt9C11CG2d17tmd4O/ntNrvDP9J/w87CqOqqo9oGa8Y79be
	 UgWOGyYiajIRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F28B081090;
	Tue, 20 Oct 2026 23:07:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE967255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C060981090
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:07:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qrcg9PuMREmb for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 23:07:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05F938102D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792537677;
 b=GOnir+3snqsOEZPZHRjMZmmhiTQxe0E5j1gVOGu9JLNsb5XnEVfzZiiD9p/UVsL+kk/T
 dPXN4KqpNIGvUwSK2s5Kxcn6xLZUjkFUCXzqNnyKUlZXFxuU8+EX7ni7XL5lkO3AUxLMI
 kRrxwoLx+AFyg73jQfvDWkuhFU+kw+Nz4KPjE13Wfs9dVWAK+T56aP0QRfTjL+z7mluQs
 BrPNPCq7/qhJsNXab5CIwIulanutkoeKDhojnjBPwfQrG5WctyqNb2qg3Zz9YS7ksoea1
 QKCJ9oZAGHQb+h4j9QJyPUk8JDnxoMONNY+towCaSic3+Ai5QdcGwUUEH/b7hVOSXgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792537677;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=RXXDFDKtyKSAfmK99JNBRtwFhNMYcYi/NqU6mXY+l/E=;
 b=HCzaM8bVzFN8xglSxNHBlUDlS7YbJAXNFEImaxGPjnDFiN4wCDTRocykQ2LZReMUFgzk
 X3DdUFze3m7zpoZoMlOp7PQzL4FYWyovZxAjPulI8QYUxCQpQu5gJl3sLSSRjsKldV5+6
 FKqf/ydUxubSjM4zRDfTgYb+HtYCJmWlT3alcZM6322eSGtzfJdZAZ9AuwUvnHMEzgwq9
 pWWEQBT745DbzykATXjNdxgkyro4lQFcaKEHTB9SzvfUW1dOL0hW+9Rjo/prmJ2uoPUiP
 XujISl+L9Yzb7BVdCXYGD9cH1hXpb0FkuVOhxK7NNmq4aiGwzv9QKOb2dytc/r3pQOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ApPOHSHV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ApPOHSHV
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05F938102D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:07:56 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-8490a7d6696so91588a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792537675; x=1793142475;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RXXDFDKtyKSAfmK99JNBRtwFhNMYcYi/NqU6mXY+l/E=;
 b=ApPOHSHVMSkAeJlFC6QBnvsqZTjoFe6ecL58IcErNr3n7meY+Hb/MBlXMLfo+8uOWI
 M+tbvHcK7PGMprlHYGiWuvJRG3ba1mQpV/iqCxrU5Tixl/wuZAHyz89jit7Juyt0ACtC
 Ak0dKWiSvtj0Ar4RcR7gnTC04ubL57vejB7TJzZrcrz3Wykrmc4dhYwOIgzVhlMgpVdA
 fvWzpBmW/l4VEfQpfRi2tCrvpLFwPzHMI57uppTTMJ75cD3DnI61TMbs+Rh6kvVq33zr
 BMcfLKz1fDsXgQf31R4x9UoLJ1f7zM4UuqOTzUKDnVvuzOTi47OF7rQm2NVJVB8OEnzb
 hFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792537675; x=1793142475;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXXDFDKtyKSAfmK99JNBRtwFhNMYcYi/NqU6mXY+l/E=;
 b=iXUfeIU2pBv8L6+Sv5U2lkPs0JBwIqv3EaZfWD3pWtBYqbcOL65/QAAtxHmt8u7Qqi
 /eh8/Mzz6aAZw6vMIsnhk3FIV2re1piI3fu+ZlpDZ/iGyMbp0aMAMsej+jdN2moG8b7R
 s47eJmJOv4/W95eQjdOIqRBOnS7qGdZNrhYspqSuzpwumsuYO9lpQ4OfyekT+ZXoXBRn
 B1a4Er46LbMrFdVlAdYNI60KM13277qvs0MEUu3+Y7ShRllQ5k6VnJWMTECxK/j9LNJk
 2H9fiU7POl7mfwU4JNEQCWnaL+K/Nmr5NMPTNB8eYBZsH9Q/4KQFXcyhBdAPJ6nTG6YT
 7h8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByQVWGxiOWGKP8c3Dy6sTHnVcXJUm4kKtcTjzeqVOGG6LjFmKzDBKxfS7fDv+Zd5ZL52a/98GY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKgZqnQbKRStmjq5G5hS4D0SEh+ysWkecTUZoIozK2PXatJmDFs
 eb7JAw1Tm1uJCqp9voopVtRG2wqYIOXltYXALHJ1rxATCSYwNsQ7mAtPP0043uAtgeH71roorZ6
 A+VvT
X-Gm-Gg: AYBFou3YSC9sM3swIlElyTTz5Y3vcP5m341V1eg3mDiMesFNxZHedJ5uhFSSyoEVpgV
 EGnePLvUZPZEKxRyMnyBWRjeRNgxszMy8Abetd9i5GdruEuvFV4fahgfivUIOZAQH9M0uF0Zq6h
 4QPNFR8533VfeWWpQa7XSjjH+ie6cE1lDEQFcGrgUUdqpIhJ2IfvDh1DD9GcD7GF6JQOwspeQ4Z
 MNNBQPQdEquYvmKPS5jIfMv0xBXF0bhDhEm9mpdcevw6uOPrvOKd5UplaqZim97rth+M7LW87UA
 Jc3o+8SQXc4fXNXJy4//GcjaMabEdH6IyxftmAToxgShyC0zMBV8X8m1tuMpg2nHrPb0usjvdbl
 SSKf1kX7BXlwb3mAOO8J/WNA0I62t9ICb03sQyFdXXep5ygcLPvPOKniHjFmM1RfQkSs/KQT/AR
 eF9nY2SEfd2I5WvL1OosbelRFWmkKNUMr+Wx9zg9kDDhKRIr2rdYw7fNoRNaxHBlZGUlCVzl+OL
 0Sm0OmVov9WogB3Jeh0ympKNWRNpF/9RsLBx7dnOVIOUMkd
X-Received: by 2002:a05:6830:4ac6:b0:847:eaba:fb49 with SMTP id
 46e09a7af769-84d07c0b241mr148292a34.14.1792537675394; 
 Tue, 20 Oct 2026 16:07:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a238:1d98:cbad:952a?
 ([2600:8803:e7e4:500:a238:1d98:cbad:952a])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd7d4a8csm804585a34.20.2026.10.20.16.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 16:07:53 -0700 (PDT)
Message-ID: <49fa7519-98e1-4f82-9a2a-b0c460966fde@baylibre.com>
Date: Tue, 20 Oct 2026 18:07:53 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] power: domain: mediatek: support SMI and infra-nao
 bus protection
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
References: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
 <20261014-mt8365-add-power-domain-v2-1-dfc3e6eadfd5@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261014-mt8365-add-power-domain-v2-1-dfc3e6eadfd5@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 11:16 AM, Julien Stephan wrote:
> The scpsys bus protection so far only drove the infracfg register block.
> Some SoCs, such as the MT8365, also gate power domains through the SMI
> common space and acknowledge their way-enable protections via the
> read-only infracfg "nao" mirror.
> 

...

> @@ -431,6 +473,64 @@ static int mtk_scpsys_add_one_domain(struct udevice *dev, ofnode node, int paren
>  		domain->infracfg = regmap_get_range(regmap, 0);
>  	}
>  
> +	/*
> +	 * mediatek,infracfg-nao and mediatek,smi are deprecated but we need to
> +	 * support them because mt8365.dtsi still uses them.
> +	 */
> +	if (ofnode_read_bool(node, "mediatek,infracfg-nao")) {
> +		ret = ofnode_parse_phandle_with_args(node, "mediatek,infracfg-nao",
> +						     NULL, 0, 0, &args);
> +		if (ret)
> +			return ret;
> +
> +		regmap = syscon_node_to_regmap(args.node);
> +		if (IS_ERR(regmap))
> +			return PTR_ERR(regmap);
> +
> +		domain->infracfg_nao = regmap_get_range(regmap, 0);
> +	}
> +
> +	if (ofnode_read_bool(node, "mediatek,smi")) {
> +		ret = ofnode_parse_phandle_with_args(node, "mediatek,smi",
> +						     NULL, 0, 0, &args);
> +		if (ret)
> +			return ret;
> +
> +		/* The SMI common node has no "syscon" fallback compatible. */
> +		domain->smi = (void __iomem *)ofnode_get_addr(args.node);

This returns FDT_ADDR_T_NONE (-1) on error, not NULL.

> +		if (!domain->smi)
> +			return -ENOENT;
> +	}
> +
