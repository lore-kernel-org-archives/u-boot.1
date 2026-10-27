Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677A606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rR4b/Vf/;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ELwQFQTP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46F1B40587;
	Tue, 27 Oct 2026 09:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SUtVYzgQxZDm; Tue, 27 Oct 2026 09:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44F4040497
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793092525;
	b=fSboVLqZtGvJPOY9GUIyXrjSGntmqga1U/y6J0qP5Y2OlOUwL00gOQqDzLcH6WT8nZzC
	 1ZDcGNC9VdNcLxP/iJ5++0csqQLToHdUPVqZUl+iE3K5KZakpd374FqySgAN0Vh/ObE36
	 bjGXlxn+yV+51sZ/MN5+0ZwpDMlUMNt7cjimfFQZzDhqd1q6Gy0SQzOb90SL4M6rrYwAT
	 IB+dQ+m/LjImMC6mPhfK/+ZM7wMtyLx79SQcVJBUgnqgMS8POIm+XuY8pOJoJPTb97X3q
	 N8OeNvZDUa4bJwfDU95i7nhKNKTCk3SYZkHP10yurT3D9/q1Id7qa+2jr1PMxvW0bww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793092525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ukB/Xq/heFT2BLjI2kZadvx33fVKBoEk2qZoOKNOkPY=;
	b=RK/BCb28K5Gsy/JIQGEfAkze0LNURMCROSgEK9ltdCw6RuC91ocVwvJH62bvWH/2b/PA
	 ERiDC9awHySY7cerjXXqqv2uNPHxrtYwD8RqUaOHY+Sr+CNMO2a6eIXoyLl+HG5wkQReE
	 Wvm6jmdsV8yXwr1H1WE4JBfnoixOM3WNTpHA24W5qfWvFggvFwM2evTUg38qXMIH0n+MN
	 2YwCtLNckz0tFx5Ejk+KGgYWPwVfTzuuL7neZ/bvcXS8pnIQIsdTzqp+RF5N3z2/a+biK
	 PfeKDzuX1r6fYljPmYMq3xWJ2G+CMKAgTjgMi2py8KsaQ0aZ+2poHJHDH3NvgXEaTng==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793092525;
	bh=ukB/Xq/heFT2BLjI2kZadvx33fVKBoEk2qZoOKNOkPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rR4b/Vf/ZxLJ8FhgXZL1uP4Od0gri0ryh0KEYvsna9JCFlnrQ5uNv6hYczMxi+UoI
	 w1w0nehwZISqRTnAGt/0nbSXakkMdNrJLA11SJRzh8xWqkRUfZp/DAwTH0oAf5xCqr
	 DDFQ+5GQo8/3+gXxiCGlMwLdQ50dZ8UZesh3R/ZJ1Q3FcaE+2t+61gkzJmy2hrv9DE
	 wHVrPjfkWknzAqnTXF1ksNFVR4yrtYzzMsl9AuWI8/Olqal0qylzaBYQ9fk7dKmiZb
	 EVCjYE0meq3wi+GKRaTTsh+iQh/ZIAfpgY4IlAcKh+lmHnN+cpyX6ZQljI00xHRFmq
	 1dNHBBlGxq/4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44F4040497;
	Tue, 27 Oct 2026 09:15:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 72DF6380
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 589FC80CCC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2IMBheQlPGv1 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D161880C23
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793092522;
 b=HNmBv7lpgjlcbSWEarDJUGlOnlvjQZyKh8d6G/9hBhYHVcxr+ev6+siPGdzTDKLKxCcI
 XbQXXrSazuLxbA4i6aaMogwuOhftnjghh2tnqQ9rKVO4Lvh44T5wulbjc6X5xnNNqVBf+
 rWQFmaY+Zr0SlJsE/Jeo+M8JoQAEhEELTuxTZ5gXPPRnsI8/r9TNZers96OSpJtMlnxFc
 nud7HzbgJGucmbXJA8FU/UuXl6ojwl+ANedwmuD+CJHOHSzrYSvhtNbXfVS7E1y8iM0wH
 TtHAj/bpfQZvsZVCCy8boQ8f74DethK59JqEBBU/CnfjkRf/93SnXXLNjj93Zk/ec5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793092522;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ukB/Xq/heFT2BLjI2kZadvx33fVKBoEk2qZoOKNOkPY=;
 b=FxYmTSaVoifUKX/Uke+Mb7PXEVFrTYucgRNvCm+VDmNx09+C8x0yS2KYhiwea8ST/UGz
 fPIET/x3TSHAcovc2fapkSPNn9x+yxpN6rxc30KEiYz2GpSy75HRVv8UY+ZIT3h46VFFJ
 UANjBHXXsDbYK7EgAfNj2FXBLPFiAMlSCMy0G7nIrue9zdx0RVAjECFwcg8k/1pFEKqFG
 6Ty1lPiDu/Rr05AT8LJVV9pdB0m1WLg3FKmHt6gWajfInnp1/nQXUbyVrhLy/mF+7pKgT
 2LwTmzdrJlU6LN4xve1B/gR9bEVsfBLmv+Z8Smw6t0hf8rM0LxoeSE2oSmKtyXAEYoQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ELwQFQTP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ELwQFQTP
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D161880C23
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:15:19 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso2713855f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 02:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793092518; x=1793697318;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ukB/Xq/heFT2BLjI2kZadvx33fVKBoEk2qZoOKNOkPY=;
 b=ELwQFQTPcNm5PKKOkBCcFG54FgK/0d79bd8xBwbv0HZ+wTXk01WJA9tNNqaG+3ydQV
 hO8NkB42BTGeshU0uOaDvoh4mXP/jtgayY4vys6wWhS8qCRzov8Vglf3YRy7t5OOioGN
 iwFAOkMGIN4pqcNPCDiLZF3uJSDVsR5pbiHEtfPPlh5kQHyO7ipec8YErHz/hpFXKzF1
 7FiMFncyk/lbPEsHKTFOa7hjF/nyC6sgJuGLC6YD14yEdUNyKUeaeNSKKgyM97WwRPJf
 tlrfX166/HaoDhxOKsK0WRwJecLmy9Ih5aflkKPGmjix80tO6Be0UN2kMhPEahAsubb+
 5v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793092518; x=1793697318;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ukB/Xq/heFT2BLjI2kZadvx33fVKBoEk2qZoOKNOkPY=;
 b=Gin2C9Tm9X6Up/x+NTHCxxeYR2+VGTuO4YXWGVj4Ym091vYibvHdFLJOK1Wxv6ZTB9
 Cr+bqTApeLY3h+/YivBWIN4ApHOG0RUgY+fY849IGn7wjsT0/gm3Ex01ubBZ19J2yxUH
 vfCDNpL63ZKb1LcPLWHLrlIpINdEARLrKRIo0F/2+Vv6HjY10ggkPHb2B8AWxmjOaBRc
 eynhoK8LVfAQ8zIfRimvMh6asRDS9+VnZ6dwAooKYpdl8UhXXqyFQh3e3LVxTRvLH4HY
 /vOBtnAJqIxyMqvOdYBXpaQ4attqSU2G6ikIf4f2m9DtDklHnmgN87uQNLlj1kwP/wi5
 op5A==
X-Forwarded-Encrypted: i=1;
 AKwUvByhHJKIQQD1U99X2nkwu0wFCvsFw5MevNYle5i32+QgIDPry+l7VWki8Cws2qNHZ8u2bcKPr14=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJu+Afi3To7w9j3IfCC+Tt/pJD4ADmK84y84syioib8TQKUmmYz
 FnUgGeeTJUtRhCxB9AqoHlA1F4c3mp01XKBFBm4SibQXwIKBJ1R9xwrcKQAZXrxox1I=
X-Gm-Gg: AYBFou0AlMKEJD83Oqe7ystyrV+1YggFnTU+I7LNb2AiUyYbpWlQFCp4tAjJPw5Vfam
 BIEx7uyoBv9t2R0/gZww3iOMWDu8hX86KusfI5658Nk5Xur2oA2as+ict2r1/R2KANYyWeaR9hM
 zxmnS/47Cx28TfpVLRKkWwViezfUivSBvfX7LH+kzdn6nAP+RzP/QyzC3xs5ZyAvoTM3xBgjZBg
 HUdeIXZFwc4i23QJxMKe2GVq2aT+IhdMynfY9M2TG8ij7eJDAnaq2Hg/ICP/rTcuz9Z9Q44Tan7
 oR9AiHOjlA1atXseaTVRt+S/EeRFlxyLSTlEwVCojwTUmyl3g/ely2NzlNj/Vl0qt6/qYssXQ0a
 b2VPZhLqTn0ACeD1lhUWEVPUuohpujpophD8/TQVsiAVtqLz8L7oL7Ad6M78xFYr7KrabC6cVPH
 gRNMvq8Ho5rRPOXKB8d1//+KDRcsBre++yHmdmQRtHW20m0IDsW7I913fpXzh2cgVVISXCE7PwS
 71w6lzBIzHPufVo8HKWOOQ3Ba/lA65Yu+X6vYRu1a9JFp3X/PUS8jRx4sdNGYwRKNl5YtlBi4rE
 xLYqraS3
X-Received: by 2002:a05:6000:40dc:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e3eb99ff9mr17170317f8f.14.1793092517272; 
 Tue, 27 Oct 2026 02:15:17 -0700 (PDT)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece5e4asm21121491f8f.59.2026.10.27.02.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 02:15:16 -0700 (PDT)
Message-ID: <4c9fc2c7-c131-4e6e-908d-0a7e8e6ffb17@baylibre.com>
Date: Tue, 27 Oct 2026 10:15:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: renesas: gen5-cm33: Start the generic counter
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com>
 <bfbc69c2-32fb-4d2d-858d-a4ed36ccf592@mailbox.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Autocrypt: addr=clegoffic@baylibre.com; keydata=
 xjMEafx9bxYJKwYBBAHaRw8BAQdAtc85GIwDXLz0rh9thWXC80Lji0otVDVncXT4qaS4j1fN
 K0Nsw6ltZW50IExlIEdvZmZpYyA8Y2xlZ29mZmljQGJheWxpYnJlLmNvbT7ClgQTFgoAPhYh
 BJjMiHuM4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEH6EW4KtCh6Tt+sA/jVC35rY1npFlOy7YnncTdrID8Qf855JA78IzXgvzpGp
 AP9FkuuT80m66PP3DvgYX9kVnG17mSDKO0+v2W18v6ZgCM44BGn8fW8SCisGAQQBl1UBBQEB
 B0DMwF4u//aQyzsFlO8rPJ/cqsAuPH80IeIA3HOEo5mlVgMBCAfCfgQYFgoAJhYhBJjMiHuM
 4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsMBQkJZgGAAAoJEH6EW4KtCh6TdSgBAMDS0MiWCivt
 LjzZc9bs+P/xdXywUjDKq3lpQGJ6vZ0GAP9vI6DnN7vwVK6jt6/+0aBGkog5Ura9+WwRFEdM
 vLfPDQ==
In-Reply-To: <bfbc69c2-32fb-4d2d-858d-a4ed36ccf592@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

Thanks for the review,

On 10/26/26 11:18 PM, Marek Vasut wrote:
> On 10/26/26 4:36 PM, Clément Le Goffic wrote:
>> The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
>> stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
>> starts it before the Cortex-R52 cores are released, so their timers never
>> advance and a timed wait such as a Zephyr k_sleep() blocks forever.
>>
>> Program the counter frequency and enable it before any other
>> initialization, through the RSIP-M alias of the counter frame.
> 
> Why is U-Boot on RSIP supposed to be doing this, why is Zephyr on the 
> CR52 not doing it when it needs that counter ?

In the Renesas SDK it is the Gen5_IPL that start it. U-boot replaces 
that stage.
 From the manual "Set bit 0 in CNTCR to 1 to start the Generic Counter 
when the CPU is placed in the secure mode."
By default R52 is in secure mode but this can change by changing AxPROT[1].
This mean a zephyr running on a R52 not in secure mode can't start it.
> Does anything on the RSIP or CA720 depend on this counter ?

RSIP-M: no
A720: components after BL31 depends on it and actually it is already 
started by TFA BL31 here [1].
When you don't boot BL31 it is not started. It is in that case that we 
had an issue.
> What is the problem you really observe ?
As said in the commit message a Zephyr k_sleep() blocks forever when it 
is not started.

>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
>> ---
>> Start the generic counter from the RSIP-M U-Boot on R-Car X5H.
> 
> What is this ^ sentence doing here below --- ?

That's where b4 land the cover letter for single patch.
This part is ignored when the patch is applied.
>> ---
>>   board/renesas/common/gen5-cm33.c         | 14 ++++++++++++++
>>   configs/r8a78000_ironhide_cm33_defconfig |  2 +-
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/ 
>> gen5-cm33.c
>> index f532daa16d5d..1837283c2bef 100644
>> --- a/board/renesas/common/gen5-cm33.c
>> +++ b/board/renesas/common/gen5-cm33.c
>> @@ -58,6 +58,10 @@ DECLARE_GLOBAL_DATA_PTR;
>>   #define RSIP_CTL_PROT0PS            (RSIP_CTL_BASE + 0x844)
>>   #define RSIP_CTL_PROT0PS_ERR            BIT(0)
>> +#define CNTCR_BASE                0xbc000000
>> +#define CNTCR_EN                BIT(0)
>> +#define CNTFID0                    (CNTCR_BASE + 0x20)
>> +
>>   #define SYSSS_BASE                0xc1320000
>>   #define SYSSS_MODE1                (SYSSS_BASE + 0x1010)
>>   #define SYSSS_MODE1_MASK            GENMASK(11, 0)
>> @@ -1280,11 +1284,21 @@ static void gic720ae_init(void)
>>           writel(1, GIC720AE_GICR_VIEWR(i));    /* View 1 */
>>   }
>> +/**
>> + * generic_counter_start() - Start the generic counter shared by all 
>> cores
>> + */
>> +static void generic_counter_start(void)
>> +{
>> +    writel(CONFIG_SYS_CLK_FREQ, CNTFID0);
>> +    setbits_le32(CNTCR_BASE, CNTCR_EN);
>> +}
>> +
>>   /**
>>    * mach_cpu_init() - Initialize hardware and start other cores
>>    */
>>   int mach_cpu_init(void)
>>   {
>> +    generic_counter_start();
>>       mfis_unprotect();
>>       pfc_set_avs_pinmux();
>>       mdlc_mpg_start();
>> diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/ 
>> r8a78000_ironhide_cm33_defconfig
>> index 3f09a7c25568..37d700096ff3 100644
>> --- a/configs/r8a78000_ironhide_cm33_defconfig
>> +++ b/configs/r8a78000_ironhide_cm33_defconfig
>> @@ -65,7 +65,7 @@ CONFIG_SIMPLE_BUS_CORRECT_RANGE=y
>>   CONFIG_SKIP_RELOCATE=y
>>   CONFIG_SYS_BARGSIZE=2048
>>   CONFIG_SYS_BOOT_GET_CMDLINE=y
>> -CONFIG_SYS_CLK_FREQ=16666666
>> +CONFIG_SYS_CLK_FREQ=1066666667
> Why did the frequency change ? (that really has to be explained in the 
> commit message)

Manual: "The generic timer counts up by H'10 every clock edge of 
SASYNCD1_RT_MAIN clock continuously."
SASYNCD1_RT_MAIN = 66.666667 MHz
66.666667 MHz × 16 = 1066.666667 MHz -> 1066666667
I'll modify the commit message.

[1]: 
https://elixir.bootlin.com/arm-trusted-firmware/v2.15.0/source/plat/renesas/rcar_gen5/bl31_plat_setup.c#L171

Best regards,
Clément


