Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CA606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jVG7fug6;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dfTiw9ba
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 960C48116A;
	Fri, 27 Nov 2026 13:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-aqVmv1DwA3; Fri, 27 Nov 2026 13:05:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DBBF8811D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784739;
	b=pUZ179otfVkYja9OHpN6H0F2y9HxJpLl8Af+yTfTQUybzSrJBaRRbIinpMQV7Iqi5vCU
	 2+aq9lIQazuUzRFNknqEqkrNgs/uBuiEdoSlkxQVwEHQxkpPSSfADdbVemyFlYF3nmdLG
	 aOBr4r7xsgy3WZA3bXpWA3nyl0qfNkHYLYw/KKXGMTHMRvJ2qvxrFemBtpRlVFU36GKlZ
	 5Z9k88cR9aiirPIw3p0xveE7y/IMWepqeTYAlyd7pmrxexgKjj5hcW7nitQ5qNGd1vROB
	 tCP5SOzW5BB53YvK0dLzpfF6fMMXJAld5VBWAKuP/0jJz2ND1UWciKzVOS9X6aXGhEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QJBpCxtJqfyC1YsYdFjHbquksQmKUmRx13uzzlZJ0ro=;
	b=hxDDVzzG+otIDJuF1nIJAMX7ppNYMP0hOvCrLxS64o3FkePn+ZlXKOP0xeV7qsyLbIDv
	 lscIxTevM2fzNnHezFk0LUrLw5FJqdple8uj8yj+7ECwL6r2L7ASTWLUcfAmIi5ymOeN/
	 WJ7q1eV1/8gHJ1Ouzb7xHsEzV5Sd3yv/Sqa7Qagelk4kIILAT2ts0a3/R6WVXeVswnTT/
	 rvvXUktmyUBVSI4rt7jTE0Uzrg+E17BBQysnzTyw0XPOMn0+zOgZ0P/qHqiotb2h/rLZu
	 SZ/Jgt2hb0iaRU4WhrHDGbMGWFZFgkgRwoeImMq+Pu7gkjDaSna5PQqVpxH2mNiwJTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784739;
	bh=QJBpCxtJqfyC1YsYdFjHbquksQmKUmRx13uzzlZJ0ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jVG7fug6+hG6mCmUia9dAMeN3xmMBvjcafh0Km1puS7qcE5LxagYKV+7xJayk7/Qs
	 qP1X9aslT7yjHFE8blvjlchFeZ7Dm69ZqCydcxR6whSKnj+GKUgGhRJFJRROMAoMEF
	 22Z+FuvhpHMmRIHadql/esr2qasOoS7j1HZ8ld7ohxdE3tAyjGf/VqWCfgm1E3NmWU
	 8jXHywdeec8r/v2sQTSQ8V6O/zMTB7i70QLv+8Wm0N1KsPr+9VDVM5Kc0oxnYf8qzF
	 pcziRbFvIZu8dnpsrRe4sm815kKe9FS6gK7M3bNfIkimYRPpu9Fu19HAKO0DI4r4W5
	 SX3q5elMvJlJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBBF8811D8;
	Fri, 27 Nov 2026 13:05:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E5B4D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34318401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gk-gZd2c_IbN for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 03844400F5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dfTiw9ba
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03844400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:05:35 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so63032415e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 05:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795784733; x=1796389533;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QJBpCxtJqfyC1YsYdFjHbquksQmKUmRx13uzzlZJ0ro=;
 b=dfTiw9ba+beLbRMWi7RJHEzP5H41uj7jq+mqQ0jmtXNfa7d3J/0FKf0C4g2Rrsbjvs
 4gtVnaDRnobdwsHtmpKnI+gJRMBqsM93J8vLHjtzES78crEZFgMCEwhNrwWzHsPduWuf
 fDhN3QB18hkEpOLviVKu/hS6UjL5G3WUAkqEifoDPot6AT3vXgFYs/CxxZuaWq8XK8vp
 c029Ihlz0NMLZjMlt55RL2JR3NWdJbutLUOX8MzSGLe6t4aEgkDxK1qSapU5pb4YAO4q
 xCLqE8nKLGioQhqZ2k5ghyamvF2SFsEAJxBpwtiszb3d8rc+c8NWqEVVgFpnh54ONGNo
 6jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795784733; x=1796389533;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QJBpCxtJqfyC1YsYdFjHbquksQmKUmRx13uzzlZJ0ro=;
 b=2hQBrKSSJgzd4gvR1NT0K6/4yXhW4/qndYaUQThqqA1yOOy9CW3sr9jzTtqxSsgUzI
 7wyV7EgLtFGlfAaZ0XEf2+QmhXdHUsgoMICghk9ol446eYJgLxBg2OZ1dNdTNfac/rtu
 l+ulsZE02I06TXUdwhU+9WLAZO2G4Y5LnYkATSLJPoad6QbvDOPQqAhPk1sHnXxp6pfJ
 gxGgZmJAxsxLLcn9MrzdsOap+kfBOEho2yco1E50pjpENl8mWBrZLvecs54IPvskqeP7
 jPdiGuiH8CiQLmL/YA2D12kuaw/zyPlEgN35fzXr19U1b2qFzYI/vDGXfBgHeWs736/y
 eT2g==
X-Forwarded-Encrypted: i=1;
 AL+hErEocMKvg1e8cFeM5cNNc4dakLJ6lhaldzBySmPdImUUsmxHMtGdlY6r5cY95JEY9nWj2ilRu3g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9AK35qLA5IlTU07gQuftC4QtuoIMOJqL01DgTuLKyfmddSZOJg
 R37ODS2m1f9Lja9FskWuhz2qxMhXhOnt8/QytVEQrPLaqfesBO//vTmU6wF733wjFcw=
X-Gm-Gg: AZFdTZc7mofs0uFPZnGUdpyDIIXcHgXv9O7YBbSlpUrsdHSt5vF8eezWGgA1c7lzcAV
 0LdR4r+ZRgYQK6nWd6mpKs4oJ7PH6lBOX09vgiNp8OULM19VcHmtc6hl1oxWPBmMTm8xmBQHJum
 JXg2r07Ff8QT9/lOcfuQ7FWpkdR4TOWyPRhDL97dCuvjD+gLQ32U/pWwGVYMURi9g5PCooFVbPg
 v7zJudzpee+zkhOmUCpT/NQe/4gxP2rRlnKBV6ojq5y2ftIDteIkF+EqQBG1HnupYwTafCVbg/d
 TjkCOKd+XUmSyyLS3yhzpkxfGw5uqavuMZ1q3XMF9P/gGYSO54zgopmedMoBLQBxXV4sACDfkL9
 I77ZorFmdIxuJtxXREuJMffEnfI3ODDr4uoft4mlQvvBeTKt8ZoU/6x5chv9VpXJo9XgenbV8NP
 PCdsKvoq6S5eLbMyKfj7pTxq3faA5Z0EISFFeO7auES5bdSkql497OpmYMk1G1s4mPArVmpQaQl
 LVLP4m3Upj4ESZCG/2ZrjEuye3XLw1W5jRPqDv4BgbTcROT9eUTX3a8WUJBKMIHeNfNl3rW3EmJ
 EY+4eJWLz4xymIyC77lEse+5Z28u7+B0bP4eWIkI43UStn/ksaedQELs6vQz
X-Received: by 2002:a05:600d:82d0:b0:4bb:818d:8d8f with SMTP id
 5b1f17b1804b1-4bb88818955mr605952385e9.23.1795784733368; 
 Fri, 27 Nov 2026 05:05:33 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:472:78e6:cd25:41a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm46409981f8f.49.2026.11.27.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:05:32 -0800 (PST)
Date: Fri, 27 Nov 2026 14:05:28 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Biswapriyo Nath <nathbappai@gmail.com>
Subject: Re: [PATCH v2 2/4] soc: qcom: add RPM requests over the GLINK RPM
 transport
Message-ID: <awmAGN9ROcSRUnjc@linaro.org>
References: <20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com>
 <20261126-qcom-rpm-glink-v2-2-15707dc6f396@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-qcom-rpm-glink-v2-2-15707dc6f396@oss.qualcomm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 03:31:52PM +0100, Igor Opaniuk wrote:
> RPM-based Qualcomm SoCs (QCM2290, SM6115, ...) vote for their rails,
> regulators and bus clocks through the RPM. U-Boot only stubs the RPM
> nodes, so nothing can vote, and the eMMC reports "power-domain driver
> not found".
> 
> Add the GLINK transport over the RPM message RAM (polled, with the
> APCS IPC doorbell) and qcom_rpm_smd_write(), following Linux's
> qcom_glink_rpm and smd-rpm. The link comes up only when a consumer
> first needs it (qcom_rpm_smd_ready()) and the edge never fails its
> probe, so SoCs without an RPM consumer in U-Boot never touch the RPM
> and their clock stubs probe as before.
> 
> The RPM announces its channels once per link. If U-Boot used the link,
> it sends GLINK_SSR_DO_CLEANUP for "apss" before the OS starts and waits
> for the RPM to reset the FIFOs; otherwise Linux logs "Invalid open ack
> packet" and never reaches the RPM.
> 
> Tested-by: Biswapriyo Nath <nathbappai@gmail.com>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/Kconfig   |  11 +
>  drivers/soc/qcom/Makefile  |   1 +
>  drivers/soc/qcom/smd-rpm.c | 772 +++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/smd-rpm.h |  41 +++
>  4 files changed, 825 insertions(+)
> 
> [...]
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> new file mode 100644
> index 00000000000..c548f1bb183
> --- /dev/null
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -0,0 +1,772 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Qualcomm RPM requests over the GLINK RPM transport.
> + *
> + * The RPM exposes two FIFOs in its message RAM, listed in a table of
> + * contents at the end of that RAM, and is interrupted through the APCS IPC
> + * doorbell. GLINK runs on top of them with a single channel,
> + * "rpm_requests", which carries the resource requests. U-Boot has no
> + * interrupts, so the receive FIFO is polled. The link is only brought up
> + * when a consumer first needs the RPM, so a board without one never touches
> + * the RPM state the boot firmware left.
> + *
> + * Based on the Linux qcom_glink_rpm, qcom_glink_native, qcom_glink_ssr and
> + * smd-rpm drivers:

Please split this up into separate drivers. This file mixes 3 separate
concepts together and hardcodes them to one supported combination:

 1. The SMD-RPM requests (power domains, regulators, clocks, ...)
 2. Transport layer (GLINK-RPM for MSM8996 and later, real SMD for
    MSM8974 before MSM8996)
 3. GLINK protocol, which is shared between GLINK-RPM and GLINK-SMEM

Merging this as-is would make it really hard for other people to add
support for other combinations of these in the future.

I think it's also quite confusing that this driver is called "smd-rpm",
but then hardcoded to use the GLINK transport with no mention of the
older platforms that use the original SMD transport layer. You don't
need to implement support for the other transports, but we need some
abstractions here to make it possible to add those in the future.

Thanks,
Stephan
