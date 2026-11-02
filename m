Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07A606C55A
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JgJZB9dM;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=ekYANaFL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70CAF607E6;
	Mon,  2 Nov 2026 16:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfKKkUY-12R2; Mon,  2 Nov 2026 16:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 79D64605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793635416;
	b=WLT846Sm7LboUxwEYheR7Skm0q7Mh8KOzvikVTh4xEq09s+1lC3AlHQ3YtdjAqZI9dF+
	 YVCDgBOPJhc9snVT6mf/g7jzK9/DjMO0iqvR4l70Fy9+HBLu0QgSr1tzTtFRZywzobMWz
	 b2Xt0Wa8AeIQ5WZCwtMHgHdn8V1CWRS12MOtPrnhNx1DG7tf6d4WnIuGpX5tjg3GJBRML
	 PC52ZScu97QIgDkQLaO8SCWjCqkGfMOPqu5KCqib7uaaBqVDxLYJ0hJeO1fTVwKkJK4U8
	 Gjnyyn24sFhcG4k3a3kGAmE8rBG9TfTjJ8IdQcV3O9XtDRfJDnB/a+o1+4erGMQgTzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793635416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1AFi8IDlNDi/1/UDREuW6ZFL8QlICmqOpDBon9/aC+g=;
	b=gxszvOvL6XGMWRLyfU7Ee2FY2D6dcHqapQM4sIaGPXCscxCoFSW1m64rRJNhHM7p+eov
	 w9yWBX6p7gHxSyfqcMWQC0eDp1KAp6U0T2L28B+RX8ohtpwNk1CENwHcTGGQ2DBOCXI97
	 VxzoySeCSTpbVi7oOWz8+hpEmC1qCq6SwERqss4XupqWHvnOZAjYQRBMRidNUyKWm004N
	 aqjw1/bX907pEWY5Bl37+lN6iXcCkrKZkMWgQNpjvD5QqA8JrIKsRYJ8Ka/wv2NL+EZTJ
	 /iCK1K86NyFFpYMy4Va2d6XUVbXclLKwTSmL3wh8q+wUQSWYQkIkS89XVPP27IY/vWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793635416;
	bh=1AFi8IDlNDi/1/UDREuW6ZFL8QlICmqOpDBon9/aC+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JgJZB9dMUDk+s65P9tL7JyWoMZ6lBmgWANSTWfD85NZaclY7VEiXws0/G0heyWIL5
	 9KCaHWzPxiX5EGrV292fQnmamkL3wQsMF63eTVtM7wMpipr2t6n7seqQawMIRIaBYX
	 nNbVATWfsH7Frvy+RJnHvB9bNwl5uRt50E2d8IlHI0jIgMy1hS/210KW52jP0siEvX
	 Dkck5jNummPTqMS+jPtmAb9+2fBeLJcRPrQeqmXPMnp48FEXBrVrlIeHhWDejIjEoj
	 WLECvOpUYEdTL6d4mkwSk5S/vaRY66JY2+WSYeWqglfZN9Iqulh1PGIWYfYYTl2rtZ
	 0j0xTivK0JcjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79D64605EA;
	Mon,  2 Nov 2026 16:03:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E541C411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6E40400D6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:03:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ckCU885GyKf for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4803F4007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793635414;
 b=WKmh2B6P4uSeUAK2Z726UoQ2CluvKfrrVjR2XhhZJAMrhJJkVMGxhhZmdozL3AxuhgHM
 1kTF7IsaTu+nwmPhMvNtMgG6sux57Vt5cOTUaA3fd3zS0xjtEQL1abf6rpKrZ2YL/OD0m
 rqsCzFM25wfHu5nQGhak9jUUMmoFcJhT+5TFPlyx2ncUKyhDC1fFNCMLdMCf3cMbUkAqf
 sFdbwMS6C9NKJO/0YYKzTnO3AzkCdizz3pUsaVUkDkcyWfwe0+fwzoY0VKFRjGdPlblGu
 zUK+3evC0WuPlIUTzEO8VTgs+pzPkuZhTe+cd6Zdc5jhjGy6QBjfOms36JDiooe7zbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793635414;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=1AFi8IDlNDi/1/UDREuW6ZFL8QlICmqOpDBon9/aC+g=;
 b=AshTYy/6xdEWEH6p9K3FdhWpbbWBvcMVolkNdxOiU2ECnHjhq7lcDxR6HsUnfczTe2Hi
 T6DWOrmO71o+TLVHnS+PsM5+9zW+ufD6flHBIBcrBqMiu8fIaOuok6VtKudaKg9Vg/UWy
 E7L20cyqtGjg+5d97XLUjHtzSSlFHoqz+gkIm1EVNUoJNySY30tk+Dh2ex3YKJlanKY2J
 kiA2S1RoMcjEYVsuSl6zN4R0cfGog2wz7pef5iY2FkdqzRrYcK6mHrXheevjgg3pO3TB6
 EiLxaISBXzLwMkyCBQQCa0qOYvem2oUBuTBPCG/3PDtj0dZjGwrPS3EltYhJdYqNBPA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=ekYANaFL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=ekYANaFL
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4803F4007E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:03:31 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-89f85edd210so1191085b3a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793635411; x=1794240211;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1AFi8IDlNDi/1/UDREuW6ZFL8QlICmqOpDBon9/aC+g=;
 b=ekYANaFLrWef2YAoFfNlhrNDZ8uih/6WFNn9x03H5K+6QwaSOSR5SfwU9aNrzPNa5a
 XM+1Fu7NHru28EdezaAXBmPo1dBBcddbD5MbYndZY+Ch/nsPvzF0uRcEPOcGUnM/0Bxs
 ubww3viO/afZFU7/DeIR3PqY1wcanfVerm8GkpfCRFKtgXygTm2XI03uDsrWGlaCK/n/
 gEr78+n0HoCPaIiJST3mh07KmeFeDfyYYszuJlm2BcN8R+OatwweZxOoFyCKna2HtTPH
 YvGy1n+iwXxf3Xz52k6PnALve1Q2rtLdvi+fKf4A1CDIyGwtHW5C3Fyus5XxqC4JhIRR
 IZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635411; x=1794240211;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1AFi8IDlNDi/1/UDREuW6ZFL8QlICmqOpDBon9/aC+g=;
 b=Nro5G69Dn2aP6iENzW9PpeFSfpHFWtP/aYow1l6eUNzXYY2Zg95UapCkReEnJWPf50
 lOyXIhzgTBdWtpwGDoOnjXAdfNzco5NW22sn113bsKIOhC+Uj5ASSwuTNkIJyBRyuM+K
 Zy9TC9WvOo0OnXX9D5ESbxsusO+6fkkob+kjqgZ+uMppKZ+KN2cyuaaprT+pS6r2cxOt
 Str1AHY1rryzur9K+AMz8DM8K5hYjBcbXG4ZAzf2v9+OC02j5W0BPz1e8kcR41HcqRhv
 1R5x/y3tzjYgdsAJ92Diaav2UcOan5vMvBhQbz6jxMzOAZvoMZq9RbO39lFMMFFrg/Pa
 83bA==
X-Gm-Message-State: AFq9FYJGEBHHrLR2E7YEetk3r4+iobwDXPW5akfT968ulZEzPTIPZWoC
 kw7aEKUznS6xmz5FSum7nSldua2eG3AjIgciY60kxhoivWXEZazHXyvve2md7PQyuAQ=
X-Gm-Gg: AYBFou3MUOVpK+2RHc0XLabzVopEPy2GiAdtAFgjEycbYEahmHc26iOaNBogcFVHV+L
 AYlyZ5dwCWS21zKj/vRiDi1Gw+m50ozrhyAFhlzdKV0neHAYtV4Aq/Idnl7dWGeokTL37Ouz9uc
 BIWl4lbuaH6EAvwCBjGmSc927w00rZgo2Jg9/FWkc1jh76VsYEXnEWiH7lqqW2LrR7MMYxtBG3h
 FA9UZtxvVuXp+uuN6yWEtz7KNsl+MbKgyr32NASaveElz9R4IEDwfmPUGPTT0v6iKvbqghpRYTU
 ZO31OW409oY5hkxCGcuskW6CvW8aBW85jtBmU8Yw840hAPIpHwhJyr0xnBHtnBWVVDV+c2lA3fl
 vqYSdCx09OliYSZa/Degd2WKsT++UHyyCEOJH9wPtYKlrVMH227A1UM6M0uTmYVbEeko0E5ZFU2
 89zF/NWBwbuOQIZyDrp+v80oU4KEVV1nJaSgSiGRSqA7v5mOPo4fnXqoC20HfgBMHVbJMVAhjIB
 KN1c3Af2mHulUmHHgjoYgvwQitN67iqTWRODL4haAxAxTvOSR5dbR9Uzr8hG7fDNRcN0IyCp4dR
 DvKT6IhD8Xbh2UO57XeesFqotJEfxoE7hfUHrwmbTI6v
X-Received: by 2002:a05:6a20:a107:b0:3e2:117a:6307 with SMTP id
 adf61e73a8af0-3e928d4476cmr9691652637.22.1793635411281; 
 Mon, 02 Nov 2026 08:03:31 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm46076a12.27.2026.11.02.08.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:03:22 -0800 (PST)
Date: Tue, 3 Nov 2026 00:03:16 +0800
From: Leo Liang <leo.liang@sifive.com>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2] configs: starfive: enable mtdparts on visionfive2
Message-ID: <aui0RER9g-LhWNsx@lliang-1876.localdomain>
References: <20261022110913.1415753-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022110913.1415753-1-e@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 04:09:06AM -0700, E Shattow wrote:
> add default mtdparts and mtdids consistent with Linux v7.3 Cadence QSPI
> driver .get_name() handler cqspi_get_name() and jh7110-common.dtsi
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
> 
> This allows us to update the documentation to be slightly less likely
> that the user would type the wrong offset by using mtd part names:
> 
> -    loady && sf update $loadaddr 0 $filesize
> -        StarFive # loady && sf update $loadaddr 0 $filesize
> +    loady && sf update $loadaddr spl
> +        StarFive # loady && sf update $loadaddr spl
> 
> However that documentation update is planned for after the mtdparts
> addition lands in release. It would be preferable to derive mtdparts
> layout at runtime from device tree; if there is some way to do that
> sensibly please offer some advice how to do so in the review. Thanks!
> 
> Refer to discussion of mtd-id for SpacemiT K3 [1] and Linux v7.3 Cadence QSPI
> driver [2].
> 
> 1: https://lore.kernel.org/u-boot/20261022103907.1415045-3-e@freeshell.de/
> 
> 2: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-cadence-quadspi.c?h=v7.3#n1724
> 
> static const char *cqspi_get_name(struct spi_mem *mem)
> {
>         struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
>         struct device *dev = &cqspi->pdev->dev;
> 
>         return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev),
>                               spi_get_chipselect(mem->spi, 0));
> }
> 
> In the typical situation for JH-7110 SoC then dev_name(dev) is "13010000.spi"
> and spi_get_chipselect(mem->spi, 0) returns a value of zero.
> 
> Changes in v2:
> - use Linux v7.3 cqspi_get_name() typical result for mtdparts layout
>   name; this is done for compatibility in the non-default configuration
>   of matching cmdline mtdparts mtd-id when Linux MTD_OF_PARTS is disabled
> ---
>  configs/starfive_visionfive2_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
