Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D91606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fZqdoXN4;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WQGYFs4o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E33E040B56;
	Sat, 31 Oct 2026 09:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DHXVHJtklwgI; Sat, 31 Oct 2026 09:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B03B40B3C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439323;
	b=W8yTlQrMt+pgXLiVcY9g0lyF9IAJcY8TtkAqTpKqGayyXYZjXgkVX1Qa4scIDZOH3IuN
	 RIt7OIwGaUPPqyLolU15XbyPr3t1eTBlR4HNlDLSaUY6fI1O54I7fHX4nwJrkDq0KOm7Z
	 3zeIx7aJfU6Gi9CLQDlaIWCqjtUhUSvU0c6BPzzVhBA5DS3M+SpWVZK78xOsGlIfWob8l
	 VQHvG6yWQqMz+TKFtGGEkLXsi34eWQkCu8Gx0syetZP/nzPBGJ8cI/NSjqvKTewNWUPkf
	 PhP87XQ8cV0aXNA6R+JZlejxoTlo5ek4LBR6IjzEodJrrEbziKEnnXCzODx6i2kL8fA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2wPn9cFSzmLHXyBGE25+Mkl6BwCJYNNkWDVQHJoszYM=;
	b=BN/QPAC0GP5o86kQ6zskkG0PRxt53VY7JBfFuoSYSCtnxjDl/EK+YFXy/QtOSq+/qOya
	 0JVVLvkUt5r1vP61vAPOV2KI4vdypN9GQgeuLVNoeDZKlPd2isKPIjw4fPUJJxM38iTL/
	 1UatRXUYHdw2SzZs+gRx/ppgktMSLqZQEVWDrXPkuiaYnG1iYVwEC90YmwOHWvjNPWFUu
	 ftGWSH5EsTMOf59H8gPP+Lh8ybynFTpmi5sRjbbgBC1WiRD9CCS5vxZbfkbOoV18gDZdn
	 YptO+rbRQOg0IA0Wz8FkVyewEnKVkXqrQw5CiKXzsqs6rGko9FOlUw2+k68/PJQKL1Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439323;
	bh=2wPn9cFSzmLHXyBGE25+Mkl6BwCJYNNkWDVQHJoszYM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fZqdoXN47r/1KXit6/M4dV10xIY/AHTRMpgQPmYhZtUoYKcpUJDinCZx9AkRZkbqe
	 7lURyKIAPtKvfNa0MVTKuX3mI6X5XSnVFqdsIOqV0Aus+QoQqkLNajAo9PApQ/upNy
	 STVVUAzdaQsScjXK9T6qdS0m6dJlTGqSaEsO/3DApVAL2VnqqG8+1ALhUDqx64tK2J
	 c+2mfmuNs2BUC4DEwUH2rRWtiHqtsutOaAiHMCFiMhFdoK+ULeb/7KClLu6guC5Ept
	 WgWGoxzlU8g5CTd+W4UaIeFA0WniVIY7G0bapJHb2iana6TKsK2DFRb/+qMdnrvtmy
	 X8P1SXzgf5CAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B03B40B3C;
	Sat, 31 Oct 2026 09:35:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E34964BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4F1081173
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UREPn-z6BYBh for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DF2E811AA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439313;
 b=p8cVE8djWhrAZ7pZ6smVGr0h6dYLHFgKZpv66Li/wHDY5yNJW3K+pJiKZqGl62IyBAx+
 46vkdsBJSe6iUE92Iw4LN6+cXI33QgX056oFSLhNhP+DYnDe5BpipFVIxwyKE8sWpgeqm
 jgPJTIayuwbFQolbvwgBfy3iHgugyBGyE47EHOyx33GAnq4wMxp7ukloveT6DhD0Fbb0e
 tssJ4SQuvrySJ0vajr7yQdQqddLqeif6TfKtQlSqInTJ62Fz9as7olyeimTq33RiUmfZQ
 x9DwNxd9M+Oiuu2zjk4kOGB1OVsYWgIpzN8bxbrq2gLMwv7/gxjBDVcys22EmSXpBHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439313;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=2wPn9cFSzmLHXyBGE25+Mkl6BwCJYNNkWDVQHJoszYM=;
 b=AgI2KsC6qFHZykp+MEB2eEAFwnD+GRGgqWgWzD2ETS/C8B2Eio1bAwZerxZeOgWA0B+x
 m6CdioHKDySb2WglNZQ5jdVxTTq4CznaXqgvYNlp0CRoVxTyX1tbsdU+8ZJDeXlLL9SmQ
 PpzzwEQoItOQwgzgBAUtpZC4E6RB7/kpOULuzCSVqYgABPMM+WqGmQEQ7Xx0YAvXR0IIu
 WjTph+MwiQ7NE24Ikp6SQX2ODdfCsKvcxSIAVxNOv0W0thqrtJYFHpUCMkcDKl62j38ed
 adKl7kLuqNE2mgMNuNft+yiuW5vVt8Y8qVUH6N6m0hCwzxF3CvqyrmSg1ntIYnPHkxQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WQGYFs4o; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WQGYFs4o
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DF2E811AA
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:13 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso1167967a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439312; cv=none;
 d=google.com; s=arc-20260327;
 b=F8dL4DBr9Y4n74LSNMu7E+23DIjwbaFf6AJs9bSZY9+yO9Zrb8NaX2yGHfDfr5xoY4
 1xHwoZ2eVcnljz/yI7MTONO8mfsdMwxhRKz9romEeTWiwaAhGezV1gBsQ35HPkK1IfPk
 tBs2Go16CxZ6WlsOqSvQ7DngFkN1gLXqLjfLFKklA0ZuCcVv7V7FI1Rn4uwZFuWEUMiS
 Qk3eaEYSpdDVWWAF15MBB/THuZNO9V+z+sL3GcuY0DL5WgI3yIqdjP253n+3WNAQuWVQ
 krSd+zG+cG6YGllDlWMVVKjFS8MwTiO0VyZERmf0WC9IeGPOO1g3sZN9IVgRosmF9WSY
 6WkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=2wPn9cFSzmLHXyBGE25+Mkl6BwCJYNNkWDVQHJoszYM=;
 fh=grFi9EORXR91fl2pEGtwJczytJDpXn0qtV3GWtd86s4=;
 b=l7ULhO6I4jQGjLLNRKc500imuhl9DKN88xcIYHiDxU138VTVgSQcScw/tG9FPVbM8B
 oP1Q51moHkVrBr0pxq87K2CsdAW6R8Q2d+Jt8m0pFn6xQhDDo7NYM9iwCrDJMSpEQ5bj
 Kk4HKR778DGGLmavXHoGd5MjUiqL4HZoqtFY/B2KIgLLpi1jYE99UsKRnPoedHfFrz0H
 R3m38WGx8uX7hRQxZNJuQARw+R7jlljnq2jwcyTxFRGEXyHu01H6HMrcGkRHebaeVS+t
 AZrMgHT1/cWZduFe4+Tx1WBnz7t/nPe5/DMQP4VJPwbZs4aJ1+gd86wmThjkzLfI//hU
 mT/Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439312; x=1794044112;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2wPn9cFSzmLHXyBGE25+Mkl6BwCJYNNkWDVQHJoszYM=;
 b=WQGYFs4oCJmpl/iDR7jxrRQpMI5zsZYjjmm+tY3zM0V2RNdL9T+MzrszR/4JLkVdSK
 8iBOn+QR/2jZMC82vzYxJPdX4SHgi9OyFR0F+R0xePrGtXVevH8mZQ4ijAFqftHVyR1n
 /KG4xxKDNl9cthAfKKzYld6JGPKtoHipzvSSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439312; x=1794044112;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2wPn9cFSzmLHXyBGE25+Mkl6BwCJYNNkWDVQHJoszYM=;
 b=XfplYRZLb0E4onkjGu8pfWBxRZdQsN/Ga8qbc6eUUS2Ae0yGXXzhn1MqTm81MRivaV
 4dPGcnp8Z/chdKRopGfnGIgamZZ0kfuHmsYyxcxAS7FGtp7K66+8ynWpP9appAOsuNF/
 X4Ytj2vSOosdASN7UabqKUt4Bl84WmtIEHGXMywXkmBsbhZfGT+InDvf0CtZrB5ocYJH
 FRGbZ3jr5sXokP+ge80uJ11aV31yTbFZ6y7lCTQHR6xUtaRnbZBssyw/ECWCSlfuecrX
 UrESNZ8m8t6Es8AtFVW4un9s9tgvcx++1yhlFRTma2LB/5SoS8nftGcZsdHaXMiYkcuh
 zh5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoQOSHIz0Cr/Z0DM/VvWvuV8FysCQq0DI4RWqb72wQN9aEBoJAAjv78hlp5/3OsAgUfabsPhc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIP7LWoY4STTwxRlYRfQFEdQx7a1u8iGNvMsN9lPEOUfNe7902d
 0qkRcj4xlmL9vTZPOqv2/5XqR60tIzMdY6laeWMe2PmPR8biIQcMMWZ1rfghUthtDhkUyxvV0G/
 hCesgjb7MHJZOgRliwlEPioPMWkHjkTpYV+m1RrO/
X-Gm-Gg: AYBFou3natoSHpm4Du6jTTfDB2eNSU2ekQvk13TFJ78MS9ySBxBQxl9H+YZKVXeqEY5
 hOwHOuY/yLeSZ7C/JtdnqE6R8i85zf1OD43e9oZHEngUDyhIP713gIfJ5yDNs1PSbv84AH/7R6D
 AMxQyzGR6xxR/PWynnItwV33tJpsy1/JHc+xJR5iyrrff3hf47FDhVTfhixqlvBI7EZxFC/zGAo
 d6YN0XqUe8WQEtyHbvD5VCK3lktJJDdqy+i6PrZseCJH9b1lhfIGzWOH2zr2CuI6XD50uvHLa3d
 jHcU41cTcpK+W0I1qrXoN4HocZLORPR1Q5Kzp1VZGWbhMs46oZPr8JYzSZrDGZTRQHDXtKVYmmD
 ZWOkfNCfN4qIMNkncPXvSHPU9RBfgfmoemGtjqsYBxuR5A3sE+MLfi9oy5hBr52k7iFIClAbOpJ
 60O0BvQMlAo1Nrj1Hj
X-Received: by 2002:a17:90b:570c:b0:3ac:8897:7ba9 with SMTP id
 98e67ed59e1d1-3ae8985d52dmr4206086a91.56.1793439312512; Sat, 31 Oct 2026
 02:35:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:35:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:16 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-20-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-20-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:35:08 -0700
X-Gm-Features: AclHuK86lmHhbK22jiBGaPJNgHJC6JtSuVsiKCEpr7nNJvMDvnhv0X5VHDMZfA8
Message-ID: <CAFLszTh3CJyvZRNFkKf=KB_NjeU7SMHfYi30+QvYvbaf6m1osA@mail.gmail.com>
Subject: Re: [PATCH v2 19/37] clk: rockchip: rk3576: Use correct mode register
 for VPLL
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Use correct mode register for VPLL
>
> Change to use correct PLL mode register when VPLL rate is changed.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
