Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2108606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s+W/laCm;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=L881BWyB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6EE840411;
	Thu,  5 Nov 2026 04:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2yLCa9K2v8h; Thu,  5 Nov 2026 04:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4C9140738
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793853642;
	b=Tr/xbm67zf0Dt0SBrJihDj5DjBmmmiUV66MzHPDS1++9rDzrMjIk73y2egrF9O1t53Uo
	 O0bjuI0uPuqIQY/fEjjL4WH9K+W1BMURvX1fWUHpyryxphhXcfVqWkT92mUkWxijSWmcU
	 HR68o2fTgrzII9LY+o+uweDZ0KuHqalBjkZ9G89W978c+2vA5ZOaSPu/eAVFf9Aj43FkR
	 eSMxLmr6H4xZmrZyeq1flPX2/BL+hFKeeF1H5zIQ8oSVoAtuqtHBBNQGHD0Vl5RHbUSSB
	 JmoK5BKtaR9sVEHFSEnQDuWo2S6dbK9lkMKoba/iJClKSpbJ+g2P7jjyCEpnnNQNEtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793853642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D6NJwzAPHKA9AQ4D1K6CTWbASe+h2oAgjZiww24hieQ=;
	b=VfB2qlAJSwlsuwLORJKg5kNom16fUT/5ZbfUjrNFbvWfkJMwQAtJp/JtMBdnU8EMhYqy
	 rvLtfhP03XfFtO4867BIcsWtDyRxD3Rqbjlt0T7Ah3pJ3jQjtMV4suRThkW9SddrhAXI1
	 fyDYMSZDizst6rD+Sb7SLyFke3KczcRZ1PeOQqKD8TywzWnfkkL1L7IDPB0hhXMPzFKi/
	 Np8VVFHsjsw2VxVtImFqr92BIVNqZU+aR7A4X/DnztJ6eKfnyNskw9pjHyCp6rhOsSK2T
	 HOv882GzmSq84mkpK3vfgD1RkrDgwHGXZXsva1G7mrJwWQLuQ0cRP8A6ZVnlnDELRaA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793853642;
	bh=D6NJwzAPHKA9AQ4D1K6CTWbASe+h2oAgjZiww24hieQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s+W/laCmFzrD64YXgW/ZSd5rtdJn7HZfRFsRWrC6uxfzyRDDtUnSD71U699A86wJK
	 lD8b+/IBcCZCA2FRw02Brz8P2tWyNg7pd9tKHu8iN94UEHsn8BifGCh52yqxDEcRqs
	 TrOxmvVyA3swJ2C4bvIGTsY5OB90+/5DSM+N7pFVs8RbXcNankzi+2/OzjnWR0JDVg
	 HuS0btN/kd/lVt1qmZhSWFbP3XqKfzPeRcq+yeYYOasCRAc2e82rVfgzoPzNIxwruT
	 OkEDJoRPFHgplRiONOptMdbrn8a+bJczTlhZ2OGzVsEY7u8kWAhWmS9AAK3ThmVX42
	 l4pyFFRF+3GQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4C9140738;
	Thu,  5 Nov 2026 04:40:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 484E737B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CFB64008E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0h7voZHYru1z for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 04:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D81DC40076
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=L881BWyB
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D81DC40076
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:40:38 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jKqPG6rKWzKsYq;
 Thu, 05 Nov 2026 05:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793853634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6NJwzAPHKA9AQ4D1K6CTWbASe+h2oAgjZiww24hieQ=;
 b=L881BWyBG+M4ai7UD/+V+Ud4GCZbSgWWCYPWoV6EkVUyZPLywncLzWjNe/Gb5konBGsl4f
 QwSNPj/OgAMzNFxRekERYPKIuMeGQdTQnOPGMxF8RHQNkKWcuadlBb5NVM115x7wMxE+U9
 61IWyb+F32rU2YbURBXHWun4Yp1AJT+jmzxXPaUjgqqrJYzRfDc8QL3NW+42WdlGQi8Nh2
 M5ZhMT+qms/wZC7mtbX1Kqn4p4XhavpG1Yl4V4DX+DDFgCKDjgYae9hyYV1Nu37suEmVdn
 1uSSfxRxfLvI8sin5xHhk+fbTmpeE5zsyIeH3DI7LzXPQ3C/SYEVjsbs37eSwQ==
Message-ID: <216ea2af-4cfd-4cae-aadf-358ad4133071@mailbox.org>
Date: Wed, 4 Nov 2026 15:03:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: renesas: gen5-cm33: Start the generic counter
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261103-clegoffic-gen5-generic-counter-v2-1-09493f3c7e8c@baylibre.com>
 <81f0a82d-0678-4229-8244-c2f505c873f6@mailbox.org>
 <6d16f6c3-2bc3-482c-be82-463ebdd6b23a@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6d16f6c3-2bc3-482c-be82-463ebdd6b23a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c65e27338d5af2839cd
X-MBO-RS-META: 36fpjhifufxnup3wn3uqym5qag9cgsb3
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

On 11/4/26 9:20 AM, Clément Le Goffic wrote:

Hello Clement,

> On 11/3/26 4:53 PM, Marek Vasut wrote:
>> On 11/3/26 4:01 PM, Clément Le Goffic wrote:
>>> The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
>>> stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
>>> starts it before the Cortex-R52 cores are released, so their timers never
>>> advance and a timed wait such as a Zephyr k_sleep() blocks forever.
>>>
>>> Only CPU in secure mode can start this counter. Zephyr on R52 has no control on
>>> the CPU mode so can't start it if it is in secure mode. Start it there
>>> in u-boot IPL.
>>>
>>> Program the counter frequency and enable it before any other
>>> initialization, through the RSIP-M alias of the counter frame.
>>>
>>> Also fix the advertised frequency as the counter counts by H'10 every
>>> clock edge of its reference clock SASYNCD1_RT_MAIN (66.666667 MHz)
>>> 66.666667 * 16 = 1066.666667 -> 1066666667.
>>>
>>> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
>>> ---
>>> Changes in v2:
>>> - Explain in the commit message why the RSIP-M U-Boot starts the counter
>>>     and the CONFIG_SYS_CLK_FREQ change
>>> - Drop the Assisted-by trailer
>> Is this patch no longer generated by AI ?
> 
> Tom told me that it is discouraged to use AI + it breaks checkpatch:
> https://lore.kernel.org/u-boot/20261026210850.GK646438@bill-the-cat/
> Indeed I could have mention it and sharing this link.
Is this still generated code ?
