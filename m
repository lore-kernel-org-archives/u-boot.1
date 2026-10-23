Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7260A2603
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z9eHq/NU;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YDCRnatD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CFB9812DA;
	Sat, 24 Oct 2026 05:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id un9dtxFwm3P1; Sat, 24 Oct 2026 05:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 323A0811C8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792820114;
	b=TJU1WfWfS9Mbxg1RStpvyV6TvI6x2o7JaHVXj9I42ACdWRVqqJCmXIZuAR4nqHtuVnkB
	 /IniZudKNhCONzSebsN+zz0vi0mu99U41u/QoeI2WnbboPJZ82F61KNR6QJK+8VxdHyVQ
	 HOfN+f5ihnyGRA87g3d0iVknKC7pzx15w9SjlCaTNsgOoWlVOqndbPWuodfTYlKnWI7pd
	 nmBzuP5mcZmJ2jXRcBXMcIalK8YwGxMQNnpn35WRBSPhtDTS5solqiv7MOQxxz2GG4lGq
	 Eqcm91GWjVNZ6KnBlai8/C7ZqYgOhxhWZK8tKBBgv0/VI4DProF/QDQ2OHOEQO33CHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792820114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UirJ8lXE4Rz/HBApDhnGvJ0yRUPdAm8Pco3eoSbHky4=;
	b=fUyqRCAb6JYfjdBwZowXbUdYs5+12Ta0hYcjUjJLHcahMTkRuTydALKLvAN+xa/eb/mo
	 FPOLHw1jU0S1d4bpa3mS6Lg7gUonS6epGIXrMICUJoPX4tzbqo+6+iokwa3TCJwogKw+0
	 E6LiMq3WHY4e4138HHLNOl14i5G9OIlYiqrKsALk7HP60jnv2Xhf60FCLg6jfDhPh5EgZ
	 c4lMwh03Hn6PAB9Jp3Csb82t+5U/cyhMf/EiR3MJb+jFrlDC+dBzvcGNyv0xcd8i4iXqV
	 n1+S3IyqHDa/r66RE4iisz0BS46mlOgCS56pd1ipd2IKYGAO7tYOelfsdnnTqIbYfmQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792820114;
	bh=UirJ8lXE4Rz/HBApDhnGvJ0yRUPdAm8Pco3eoSbHky4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z9eHq/NUKJkj8WD+YCSRS/2oGEbu0/w8BhYBIgavTz8evNFIWBhJYAbkNbtrZj7Md
	 gvqUPbG2mRuafGGwH634EKcN/gL7fxqIpc52lHZs/wyTLlDCdahyhsJvumYOPnyNr7
	 q0t6kEWcpuCarTdJQFuj13NGYaObkVAnUgfZcYwute4FWwISkbzNPFDRup8Iyst4s0
	 K3C31IJOwj1z5qUTAyt2h7bay+BjVgJXG7jEAc02UIjU8WzeOTFdUQr3ee6i6LZvzV
	 IBSqSHSJJbSEcanM0RXGIah61Cr4yGTYQUZqGIXSma+iGYRXfSRgl9pzi7CwDaawD+
	 3GnZbcwI4IN1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 323A0811C8;
	Sat, 24 Oct 2026 05:35:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5937C2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F22C4007B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sj01bHZZGou3 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 05:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 29E1A40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792820111;
 b=r5UnS4QZmpHEl+rQK8g4O6JKSRg84cJjvxcB4/1mxaKV5a58uxsz2BC31k1f0NgIQvCM
 58iBpUJ7UT2xSTD96njKHbHDmZtBHIBKglsVKL5iuwmqaybOU/rJeRD/9DacTQJNi/wAP
 pAESZJ75i94WUCOwxJyTH9pksMW/J9qAvDsk3QJV/0aYAbqRCBQcUOCQCP3y/6Q5lAQRO
 +rcUojg7m5qs8EeqwaxvujaCQglgl8pjwY0hV1Jy+P/InEpzOg0DpK5774jqh9iSD7Qj8
 rT8JY0wZDnIQvGOVg09GAuXf1cf7AyJc1hI4br7HVEBxkPMHnPj7pPplzlkv09MQRpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792820111;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=UirJ8lXE4Rz/HBApDhnGvJ0yRUPdAm8Pco3eoSbHky4=;
 b=FVVwjlbjsRTipDMhwqgCe1z334C6ynq4z3C4aqP1oMJKwCjaVnEG+hYblDc/VQ6tVCxf
 VSc9zZAi2mxSHASJ4m/5VYfE3Hoait1rYZEV770pbicJSoktwouSvfDfKu+Kncr9B08JZ
 eDuEVk1ucSDYf8GTIHsmI+ynF/Ed3IXMSK1xu0RkHD1LLB6IALhlrMHN8bfXTPMgXPFJW
 SumpI3/zMc1I4DWM6HVAR280MZbznxQbdTj6AZ/jsTQNp6Dt+4J4Oh4QjBW/SM0VaAT2I
 LDOGeilTk15+EwUyFYvS36rndY2izYQSq8q2aUiH6BQ0fdLYO0sFhShUTMI4AE5cgXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YDCRnatD; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YDCRnatD
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29E1A40068
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:35:10 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jBT9k1pDDzMldv;
 Sat, 24 Oct 2026 07:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792820106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UirJ8lXE4Rz/HBApDhnGvJ0yRUPdAm8Pco3eoSbHky4=;
 b=YDCRnatD4nNM27dFRXNF/lY5mMa5eafpas3Da/qjXve7j/FvAlczExMXJL+je+/kRKGZeE
 cB29eC0sb4lQuJi5X/5qtTC0MI/C3mWEYzkWW6iUEUVFAZFApnl+VFI6+K8/QF4/+392OR
 0aMVTRC4QVmKTl0WXrARvYAXhhS3EtMihT/wYy95TJfJk9z9F5mXrsjM3WfcmXiihpZdu/
 0hGMZHH2zdo9zlGCpYpFP/OiaZs66VNxi9g1lMcmHNkvSR/UFYkiehNzR5ZkpQ22iMSHR9
 nzzJ82rJf2VIO/3xxWB/vCjAjPGvuY+IlvP8Hq0NJLdL9weWVdchdG6SrzBguA==
Message-ID: <81922af1-fa22-45df-a96f-a2b97496f4f8@mailbox.org>
Date: Fri, 23 Oct 2026 21:34:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/9] usb: ehci-vf: take the register bases from the
 device tree
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
References: <20261023143530.4120984-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261023143530.4120984-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: d9tnwowyoq1ptxm4ex4noqse9g88gy68
X-MBO-RS-ID: 13e8314c6dd86f678ca
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 4:35 PM, Mehmet Fide wrote:
> Hi Marek,
> 
> On 10/23/26 4:23 PM, Marek Vasut wrote:
>> This is admittedly a bit icky, please at least add a code comment. But I
>> think this will get removed in some follow up series ?
> 
> Yes, the follow-up with a VF610 clock driver removes this switch and
> portnr altogether. If that is fine with you, I would keep v9 as it is.
I can live with that, thanks !
