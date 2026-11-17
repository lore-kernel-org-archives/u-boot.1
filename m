Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118B606A32C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WDpWeubz;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYABdSfv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3233C40908;
	Tue, 17 Nov 2026 18:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RqfyOUFogVyU; Tue, 17 Nov 2026 18:08:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 459CD408E9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794938888;
	b=rdaAok8SzHv59/Fftn3Fk2UjhqbtGYe1avz9iS8pPSEV4dXH27hyYw81yjvZuhEf9QCE
	 9EnHZ81I4f3jvlf3GxxcmB/m4P0Z3SK3IWGNrkIYkbhwpWjMk1HFkU4ye3ApXcizgbTMa
	 sv7KLxzrf6mrch3+M/TkbcRpt54Sv7cxy/K3fXMof1xTWsWNGsMoVSVESCje+hA9jo2dj
	 kolqgUH8Xk0/vHCdB5SzAnQG0bIo4T8rNBNeA8Gfm3RzTHduoml5yi1ihnOIbPa/ohUCm
	 qXEXpYO6OlWFm+epQmeYcABt0nht945pUfre4ryDSR/hH3ncxjrxM9W4KTZefo60bzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jBnxCAuRuC5j+tl5k/pym8h2JEXIQIuXUdlXzKiLfxc=;
	b=l6MboxobQRNjD2JPLK4IxvmYoY9PHDdnYqq5HPT6rfsFfgM7f8lILvoEYENWCcnzakk8
	 PRB7t1mc2F3urggqrVWXKcdB/OmI0cc/1Wj2cyyZg7ePv3QnVhk44Obm23UqL5ayWVGCv
	 Ga4jTMRiUI0Wdin7/CPOag4vh1+tvEfPbVUz1Jvlx5MSgDS3MFvoyQZ0BAPVskUx49G6N
	 gBJywmbhaObdAxWOuv6nc1KoUdiFwIOPL+xkU2LQq0GFRNTkIlKQVIvWvh4AUUuKhA07s
	 olH+5JiRLsKZtmEXV9dXeQTzOBXc06mqyWcH5tbYjYHYPqTGt298oDQPMuGOqFfJqCQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794938888;
	bh=jBnxCAuRuC5j+tl5k/pym8h2JEXIQIuXUdlXzKiLfxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WDpWeubzX71yxTrrn+gD1USF2c7b4+lWpdg6qjrH3CY8WsnpBAjA1c4la66dl0feu
	 4hjRshCqYlBrqitp8LOQ7xOG9XYbvm9wYwKiW2EOOogj/9od6EqVOTPpcGS6aa682z
	 R4seLE1/9E4rhKNK6J/y8ztUq3g8N7hA3Sas1slQEM8zDHUKLCRoaPqS4yysdrev0o
	 Eexnd3wAYGejr/a6E/Cvo1IQE8ycWmsVqg6RsOPbsIOArKM50dfaXTNvgMyqK20G9W
	 IvBQD1gMrQW9oK4vvTaZv0B8zxPvfRCdaGFY+gw2v7qqDEHoLuG38NCKu92HLtf4f1
	 qhvZTMujft9Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 459CD408E9;
	Tue, 17 Nov 2026 18:08:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A7F72A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 995EC607E9
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKBY94Fjcl2w for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 18:08:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61E646077B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=LYABdSfv
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61E646077B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:08:05 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso681470566b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794938884; x=1795543684;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jBnxCAuRuC5j+tl5k/pym8h2JEXIQIuXUdlXzKiLfxc=;
 b=LYABdSfvQrBuzDOw5WyQMLPE8ZxT9D1LQsktPhHxFiHeBUnDuQwJcZHFO4WF19cP9A
 NxryZwqUSSnB0By4fIyS0C9O3DFpJqVmDTJ2i72wNTP0XPeut0NMQQdpRkF8qKUqGVVD
 ertvj0jxSDSYq5oJSdlUE5cyvufmk4GX7fYtY4UnC/1ExinrBUY2xLwfjhZyJlnFAP44
 tfFqFOM9QJILdOlHYTCQX9HeW1yo2FMgYyFLvjcDpL1GqJJ7J81A0fkK5L0g9xwgD3Xj
 xpG33v8u1dRQteqNXyQ1rrMOAAZqP49f1WnLvIYAJ+HWK918jKZPnjR6N1mpB0+oqczp
 bNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938884; x=1795543684;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jBnxCAuRuC5j+tl5k/pym8h2JEXIQIuXUdlXzKiLfxc=;
 b=a3sEqbkxNS97tkQOYT/dJtpzP8KAvfzxsgd9eeBkkMl+EHMf6+3+ub0t3/G7LkJfQK
 dKS/HW8gLYNVOk31uvB2KR4Bp6REc0gh47nSGn/wnZZSQK034lzGABx3QdD9JTge4+Ey
 zZWXKtPw9VfSeN1KqAapN6r0elbQciUZjjVZMx1wULwKLxASMBhQc7cOH6LCS3sZvvH+
 B/n5QBMqF8V4FUjjlSdiBOlXnd76c7q3xxA4DqXXBJH9hDenLZLzlpbQhuaUxmC7zVT7
 3pQQm4PpPzXrYu3Y+yyWwGI9NE/z59FaZsrjWLdnb+uL8TOMaKX5yap26TRscYEgl1t8
 X0SQ==
X-Gm-Message-State: APuU4Z/xPh64wNk7WrAhcVKqi0WF2HSeej1EuXEBx9RAwn9LdBDfvH3z
 Z3x+gYwKZpjz+8GYc2AZ0h/Rch+SRScXgRS33kuAzGbSoQQlmHha6z66tvMgp8Dg9rMZTp+KVqM
 2q5WUf5tMxnbUMk0mBRgT3LiDPEgVT6o=
X-Gm-Gg: AYBFou1a4daTznfjc+/G2grWf+yXgY4wAnBl0B4AfUdnW7lIe+mcG5YY2h1WDgMwWfX
 Zb0LltHb2eyy1zj4DUkQCYB3aFipdKFRdPlVez3jebkwp1+HkLSkOs2o7TWKLbIWAollGEl2MtO
 910xhXAWoIsZh4I2BU4x5Wv71BMDrXzAgHHjCdzbAsQIeMM0b2SvwfrCMU0rdACId9V2PYv92BW
 jCcO6O6E4CT5fZBcmuKmjjhmY8e/WlSQl2aeXONC1YyK49rewjcQn9OIpoXa0g9OjerjcU1UBmx
 NvPUHD7Xf72lYDsopciYqFybIMo0EJ/bY7hVML6jXVvMvJh+Qn0SiqPLiEi0RSnwQfFHyhFrRjE
 Dj5dsnExkH2UgbOnU3XgqL+VOl3b3iizBBKX20Q==
X-Received: by 2002:a17:907:2d13:b0:c29:4490:50d6 with SMTP id
 a640c23a62f3a-c510e32e95amr4974966b.47.1794938883884; Tue, 17 Nov 2026
 10:08:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-rk-ddr-types-v1-1-0d00e87a0fc3@cherry.de>
In-Reply-To: <20261117-rk-ddr-types-v1-1-0d00e87a0fc3@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 17 Nov 2026 19:07:51 +0100
X-Gm-Features: AclHuK9syXDC2pezF9DX38eAI2VsNeIVMx5Y0b55CKWLoBa8OOLvJNzthoSI3BE
Message-ID: <CAC928Hb00=uq3-6=F6j=KBHWHkmhot0ia0iVd4PrGLLdj-7Reg@mail.gmail.com>
Subject: Re: [PATCH next] rockchip: sdram: expand types of DDR that can be
 supported
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Cunhao Lu <1579567540@qq.com>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mar 17 nov 2026 alle ore 14:09 Quentin Schulz
<foss+uboot@0leil.net> ha scritto:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Joseph from Rockchip confirmed[1] the values we can get from Rockchip's
> blob from the OS register for specific DRAM types.
>
> Add DDR2 and DDR5 to complete the list.
>
> Add comment on where the values originate from for future reference (and
> to hopefully hint that those really shouldn't be changed).
>
> [1] https://lore.kernel.org/u-boot/501ace01-874b-4c61-b412-c297920c91a5@rock-chips.com/
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/include/asm/arch-rockchip/sdram.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
> index 1c28d4aefb90..2e88febbcf28 100644
> --- a/arch/arm/include/asm/arch-rockchip/sdram.h
> +++ b/arch/arm/include/asm/arch-rockchip/sdram.h
> @@ -6,8 +6,10 @@
>  #ifndef _ASM_ARCH_SDRAM_H
>  #define _ASM_ARCH_SDRAM_H
>
> +/* Written by Rockchip blob's/U-Boot's DDR init in [15:13] of some "OS" reg */
>  enum {
>         DDR4 = 0,
> +       DDR2 = 2,
>         DDR3 = 3,
>         LPDDR2 = 5,
>         LPDDR3 = 6,
> @@ -15,6 +17,7 @@ enum {
>         LPDDR4X = 8,
>         LPDDR5 = 9,
>         LPDDR5X = 10,
> +       DDR5 = 11,

Does it really make sense to add DDR5, now?

DDR5 is not supported by any of the Rockchip SoCs, as far as I know and based on
information available in the public domain. There was already a DDR5 = 10 (as a
placeholder?), and it was wrong because LPDDR5X = 10 instead. At the moment,
DDR5 = 11 seems to me like another placeholder with the risk of changing again
in the future and leading to confusion. I would define it only when it will be
really useful, i.e. when there will be a Rockchip SoC supporting DDR5.

Regards,
Massimo


>         UNUSED = 0xFF
>  };
>
>
> ---
> base-commit: 6201222134cd704b5717211fc917e2ca6263577a
> base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
> change-id: 20261117-rk-ddr-types-05d330ea0c3e
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
