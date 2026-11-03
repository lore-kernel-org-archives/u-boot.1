Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08085606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P5T/a5bh;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=AEiTGTpi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D123F80898;
	Wed,  4 Nov 2026 05:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHh0qCRQV51B; Wed,  4 Nov 2026 05:09:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1ED108097A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793768967;
	b=fBZgznNxbUKXFLJf2yfGMJpMM39FtS2/beA4Pxdjz18kwOn6bL2OkdxLpwFXK/yi0H/H
	 UMFAmixXzp5clEBspA/5+Fk5wjSIed4dEDGRlSn8tYHYCQBrkztvPhrs22fdlWTg3E2HO
	 60bgfUWUg9Yg/g/O9r/OXOLxKfphUJs1OpxX8PuEuOAFk5uYRLlPDfPtZKb9MYxAoMx5k
	 8v2RPSCFNpiAPDwlz3kV7kYdyUeVJ5fnSL4WIeKUBkjHKdaYEMHl7Qzu7b7cjgMLlvvZ1
	 EsF7oIGLKw+4MxfLYtKUl4tKT10ynUHgrV6VSllsUaxP26uwvkXtdqFkv0y9aLtUEJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793768967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bfUnQfccZJ78+7jmLmU+jrvPbt0deMT1yVF7XVHxBbg=;
	b=Ze/aMeyMASeUMhTe0uoeZTEQkqDIicGChawzI7m3oasIkdLnsSXBZpCUCyvB3akN7uT8
	 09iBoXzkva1VD0AOCua7WFh9QyieCNDgbjtc3+M5yMRSJVxj+CwOVkdld95sK33BG8s8M
	 6/AQu6PGkoSzq4iX/I+hGT5MpIWSUonWgffNzgqnwoD270poKhEWvmE8+l7GgKVnl+qBK
	 +cPasww1v7WGET/JfLuqvST60w/v8/Dwdic8e8YZlNhHre22VrYNy1ExY4xFuzIfLTFDB
	 R8mn6TPprBFF1/SoNP+CwDdrmGuYOvb8QuL2ivWluJMORP0I92xF9szSdTmT53A42BA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793768967;
	bh=bfUnQfccZJ78+7jmLmU+jrvPbt0deMT1yVF7XVHxBbg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P5T/a5bhVdoHj2ixgc19dN7W/rKUr1blO5J1cJuBS4G807WP9cN8+IvukkDveorcY
	 XkcdioWDqlVe5/Kq/W8d4L5jbWu7+3PbvZE7/D2n52QbAor+/DVkmk0YssZgA85L2N
	 Bc3C163QklpFRux8Q6Yd6rbAJn2O9dWoDmyGZ9a2R5zlnGlGjilso7LWfuXPsOLAzT
	 +EXGfV6m8KTgA2rn2vL8w2SZb0A/lpbFwJ6i5bdqaunGTNNmcN2fqvCgJwzqiEd5BU
	 3QP0YvD3ogfkRhLjuEsqhHguHNGl97IVxwg7YTkEvwX2uzIvP9bv7zduYZZZkE7Qgj
	 DUm45q4EennNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ED108097A;
	Wed,  4 Nov 2026 05:09:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E578784
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4438560698
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BTqXoUeREYAp for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 05:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0930B60697
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793768964;
 b=dhKb5Am/F5KZ1QbpLvZrIT48TxHGyK8lelIm5AQP3aMpCIVOAle2mCQuyJHEsqL2wkgX
 bcFl6rc04bhTsvsR294NycZMiYklP/oojBA4gRe8RZcQhRSzdorw7w9PeiYzc5+hYLRmF
 6/6c4XoxfOb3rio5cGxUAxAy0/ZOtkT1nPcuq8x/P0SEphN0v2i97/tm0vCgpQwVz6t7c
 2gLSxrKMaV5u9F9yRizRTmSiLZEKmShHts7hv0uJCGYwNzljS4CkCgl7wfOZY/BPJwNOh
 Z+o5YCkdJnLcYhN6L3HueqQxr+t/yzun6T6yUCZ9b3RH/6E3NO5a5xaEaO1Irq/Q48Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793768964;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=bfUnQfccZJ78+7jmLmU+jrvPbt0deMT1yVF7XVHxBbg=;
 b=icWMiOl2Pis6Dg1Ke+R61JY6jkhHd7tAQ02YmkawrDCBAyLbfcn2ZWmA4VzPgLQUWUBE
 gdFk53UhuOx5AM8yCPwpsuGoDypu5cN8XN0rMm7EbahWffUaRETOkINms4fbdw44fb4L0
 hdRSZAUoCIiZb/DA94gWJuB87hBjI/1SuX3adi+QiWqLFIkCxFllEe1/F+/vj5ETKLpRx
 vTK5/sz2fnALpR8wF9Lq0Kanumjb/pp1w1b32dTY/oEGcuJX91gKb4qrF+agJS4gQV2Hg
 wmmNPwuaOpav5/bupsUYnVePZmvvET8sbqULaHVWwXYqqLsoPTDD1g8k8VIROIzJbpg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=AEiTGTpi; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=AEiTGTpi
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0930B60697
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:21 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKD4s6wC4zKp6Z;
 Wed, 04 Nov 2026 06:09:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793768957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfUnQfccZJ78+7jmLmU+jrvPbt0deMT1yVF7XVHxBbg=;
 b=AEiTGTpi6aWWEUZF5n3q+Xg3E5XvJ2cYDofslXfRHfaHq8N7d9S4YCwGIRX8fgeh6pth9B
 brHADgS5+FzUAXYvjT25Zb33wZlJabXCm/NMom3xe/qNSQMM7fYpE+0ak0kgNJ2fLWhRB+
 GNo3nLOcPtLkIZednYT5oerJ7M98f6dUeVpV9BsMTA2YVbcMpY3obyaqccSl/8hFJQ3K+2
 weAkdyHyiQf//L4F9iYpruyaQ6AlZ/kJAe4NJHJBESWIK7ERlu4VHk0c/rEGOn1bGIHpxT
 KUjkGEZViYK7nwSJn3QdxKblvKFl8flqlGS4rSfuH7SnmrjdxcBCfc7vrp2cNQ==
Message-ID: <81f0a82d-0678-4229-8244-c2f505c873f6@mailbox.org>
Date: Tue, 3 Nov 2026 16:53:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: renesas: gen5-cm33: Start the generic counter
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261103-clegoffic-gen5-generic-counter-v2-1-09493f3c7e8c@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261103-clegoffic-gen5-generic-counter-v2-1-09493f3c7e8c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b25c9653d89740751d3
X-MBO-RS-META: f8eacp395se7g4kkpg9az8nyxiy45few
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 4:01 PM, Clément Le Goffic wrote:
> The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
> stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
> starts it before the Cortex-R52 cores are released, so their timers never
> advance and a timed wait such as a Zephyr k_sleep() blocks forever.
> 
> Only CPU in secure mode can start this counter. Zephyr on R52 has no control on
> the CPU mode so can't start it if it is in secure mode. Start it there
> in u-boot IPL.
> 
> Program the counter frequency and enable it before any other
> initialization, through the RSIP-M alias of the counter frame.
> 
> Also fix the advertised frequency as the counter counts by H'10 every
> clock edge of its reference clock SASYNCD1_RT_MAIN (66.666667 MHz)
> 66.666667 * 16 = 1066.666667 -> 1066666667.
> 
> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
> ---
> Changes in v2:
> - Explain in the commit message why the RSIP-M U-Boot starts the counter
>    and the CONFIG_SYS_CLK_FREQ change
> - Drop the Assisted-by trailer
Is this patch no longer generated by AI ?

I will respond to V1 shortly.
