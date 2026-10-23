Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E36606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TWMVmcAg;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JtNw361m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 738606063A;
	Fri, 23 Oct 2026 07:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wwnHAjHQzIUm; Fri, 23 Oct 2026 07:45:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67C2360650
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792741534;
	b=kELUaLNWN2PtfqRtUPdQo7NatRQQK5Ml6Ws4CRRxzVAphgMzxFo/CbqgnjXRU3SZ8IUW
	 XDlWAgxeHyPptOg/DUEI4W+MnASixPfA+sRbM9ViKyrHuHZCre6sWIqo/QWbH3DMHBpfg
	 9G7qqmHrslimu9sq1kUzD3dVuyP35SVgwBNtUoZCM0CahJlj3pp1/QZHBP4NNQfS8wJoF
	 vCjK/RgvjxQ/6i4CL+XEE6IPkJ9lZSmVhKjpYsGN9B54CDV+49I4XaQwO/O5zgd6APSII
	 ZdIv1MsgXXsteO6qo6Jdo7ICwFOZwyDQTtzmn44SSppnmlCygbAAv6oblnrCjwOWtHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792741534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hzjVn3IBtn2NUn6FmA1FjImv4sRyWGGpBgafG0xl2Mw=;
	b=QJFgXBaED8MlvNPsSzwj7slZJONnNrPtbguEqngfZjijVPSWBjfLatXbDj4rNHmhodOt
	 fiGn92rYwiFJvRKx1FbZ10x9TrxNSPWS3J2B19fXMhp+nyRYnvQ013FrLRUYBFQ8Oqqq4
	 6KH0btjg9axl6dDv1xw4tvmrvwMM7Xm9xOhCQSmDsqUfs36ElByjX3cC7mh7g2e0t5Mez
	 CznlF+xzZMUKXMe0vuGaErYe6h5Hoam79xzpIJAxGTMp+dRlR7rve63itFK+jk16VCmeP
	 PDYPWj5sSuW3UYaOhIfLykeuF/Yx8YPzl7KzzUnzMGx9wo2Y2DJbCZTV2h7v71AItxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792741534;
	bh=hzjVn3IBtn2NUn6FmA1FjImv4sRyWGGpBgafG0xl2Mw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TWMVmcAg1+7kTbeDJSbL+0GoF4WGnF7V8h0rzm/LLcGVyeWKxr6pg5s0GYNJ7VlTp
	 Dy6rumvB1Klihf663L/wuSiA0iokmNNuNmZV5s/svpAtsGsQFtXchCmLN3MzgM7Fuo
	 KdFioRRCB8bxDws37iwgwuQ6pzuZfoun5K1/HekpQofaYNMZpoWOvjVBGCk+ukJFeK
	 qsJ6nd8mHsm1H460OjsWNenYEdSum/ockezb6rwxRXXJ4GCQcdnVicQcryasb1Q0EA
	 C+QdRnTkCOa+MGy0S61NqqFqDWai5Iw/2WPP6WxdV30Ae4heMKqUq3J+rUm/qTBmy5
	 5iaugHf7gbjcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67C2360650;
	Fri, 23 Oct 2026 07:45:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 640BF49D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55297400AD
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L55zG2ZXwvKu for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 07:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 956DA4004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792741531;
 b=e5MWRiLklPpZUR4PAZqYQMZYAKz9/Efy5mTGTsfDCK7CD+HNy/Zm2IIl7sPJ/fwjX1E1
 rKg9nn+2hdXvq/YC6Pi/5ZijrYwITNn0By8Isk8fsGHMuzjJ2fPc/BD4j90TEtZQBsSYc
 5pzuHWDHMkSp1PMKMqFoA8CPHSUqJqIrTlKkh9FnrzXQU9yRPvZXuN5c3K+s/Qxge8/n1
 hJHRu6tKW55QrmjOvhYXINvpAZsXTGxVufemN1rMOp1n2QC9PWrZGrwtQYpUfvOX6C0QP
 lgWKNyMWB6rmB/qu42bkzY9JEGKBfM1SjxxKaKXpnqwBeR/uTWlqV07xfStRsWoofjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792741531;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=hzjVn3IBtn2NUn6FmA1FjImv4sRyWGGpBgafG0xl2Mw=;
 b=XjEvQbrOxwGwry2mkkXN4NASf8go/nthG9d4qcCb7PB2/wLkBmZtI1nAIMlVSdPGErgk
 uWRpT2jH41g4xwNZTsFsRPw90lgJqg3acVw2B7z/M6gZt6rroBICx0jvvcv4mxBXhGPRY
 QwmFNUHcNoyVi7FmOi8IZFRfvIeM57BMu0zrzJVOmzbkQ72s2Zf4DR9ft6dyHpYOvS1Hb
 Lzj++dc0JxzgSXilg9Bpu8ookpGicIPW1sY1buKWzbNmLvZRHdqG0RWvYuMl2s5NuucdL
 3nMRquUUBq5gMA74KcL0Mlf359H1aNtdPImsmJ0RdbGeqXeCwNDwSO8DHr3d4zVlOTg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=JtNw361m; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=JtNw361m
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 956DA4004A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:45:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0BB50C5145F;
 Fri, 23 Oct 2026 07:46:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 20C0560398;
 Fri, 23 Oct 2026 07:45:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC75E10328501; 
 Fri, 23 Oct 2026 09:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792741527; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=hzjVn3IBtn2NUn6FmA1FjImv4sRyWGGpBgafG0xl2Mw=;
 b=JtNw361mnHbjgYGghtGHzma60qYvqqce2tGYTFfBW6iam3nRFDjhfso5GqOEi8PtRwvadu
 QGTxVqWB9qDLJV7gRM92GXV/9N/XdVfqj3BK6ebB+VxtMOjVx3tzQVZzMV7No9e4d/Nzx1
 FBq2WdxTExa1It3QY21DsnyWaf8XDszshnjb8s5f/PVGvhVpXEnIAjyxdSIZCnCEaVtW46
 r7atO2m76L7CfX6HK5hGBKnQwfxS/hTAGhaEMFmBgHYiY8tSirJZE8rjdeGQXOT2wDrTVI
 wV05+7/eXvy0uaLhurWeX9wMGvltmEAAj5vzze9V9/PYk81rhxocps0gTehliw==
Message-ID: <f8fadb63-0133-4d11-8e0e-f3e542da1907@bootlin.com>
Date: Fri, 23 Oct 2026 09:45:24 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] WIP: arm: mach-k3: j722s: Wait for TIFS initialization
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 "Kumar, Udit" <u-kumar1@ti.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org
References: <51c23f5b-9ca2-4ebe-8f3e-72d22e404617@ti.com>
 <20261022101558.2474326-1-msp@baylibre.com>
 <20261022101558.2474326-3-msp@baylibre.com>
 <DMBAGGRGOEEF.1XIHBA6ILOH5J@baylibre.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <DMBAGGRGOEEF.1XIHBA6ILOH5J@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Markus,

Le 22/10/2026 à 12:18, Markus Schneider-Pargmann a écrit :
> Hi,
> 
> On Thu Oct 22, 2026 at 12:15 PM CEST, Markus Schneider-Pargmann wrote:
> ...
>> +/*
>> + * Called by spl_early_init() before anything is probed.
>> + */
>> +static int k3_spl_dm_post_init_f(void)
>> +{
>> +	k3_sysfw_wait_ready();
>> +	ctrl_mmr_unlock();
>> +
>> +	return 0;
>> +}
>> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
> 
> I am wondering if this would work for your situation where the PMIC is
> probed immediately?

I've just tried those patches, and indeed, it works for j722s HS-FS.
I have to drop the ctrl_mmr_unlock() that was done after 
k3_sysfw_print_ver(); in my series, and everything is working nicely.
That's great!

> 
> Best
> Markus

Regards,
Richars
