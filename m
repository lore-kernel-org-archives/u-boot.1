Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50476606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y2zMlMHN;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KHA+IYo6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24F1E80E7D;
	Mon,  9 Nov 2026 21:23:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e7rYPTPMuiEP; Mon,  9 Nov 2026 21:23:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E5D580F19
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794259400;
	b=XFuVP+2LZpgPlv8Bx5iS1STC2RgUNEhB5PI6pZlzBI/+5dnpqQ/7Sq0jaQIPG3Fwicb8
	 3SNRmfagig60wcBKPbo5uY/hSYiYm3xgzAWcYaGQwjVDXaSJ/PubOLjFU+a8wqXYzJCvz
	 417gwPVChaTvkr60212Zzt+xjLo5ziiJbmH723qMrVsIWyaw69CLoQEfA1m43f5uEktK7
	 3c38L8vRCY7Qhb4HWx2JDh2KAFCEDk3sR03hmOGH297Vsa+jQdD/LmiYxPfi144D8EGDC
	 Znaz1y+nP3uy4caPavQGYoJbjUsTGdIyoToNVHCcZNxW9ttBr1OdIL8vGIlEYveW5iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794259400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=c0iI7mBYkho5xUu+wdg5uUngAWCjYLI1G5+AMS8INeo=;
	b=oXGUaj4mJbmBlYYvH6i+SdJ/UUMlclUGYhvV04INsJTbQU/XGvcW4wnGwEnRYAkzRZ/6
	 qvSS1S7jNdvVqQoVa4TP1ZM2m3H7ouZG2OZwbXFxwhu77jwDxUIcBOowfPVG1NTsUqUy5
	 siCTZRamjjBFW3SQZyVaDBAWV3WNKN6QY/palZNkpfnl0fUIzoE97LAetEp72gjmgsrK8
	 XsJe/nQF4B9ppcManyT6sGnxwznKYUwrfWwIXDdiXoIovHN1Ur/q5yI3o2aIphHWoYRal
	 es/BiLujJZx+C50DHWi4cLsYSfbKp3rMS+NhuvPnxjNxKcyLic3+vW1vevj+ITxMxFQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794259400;
	bh=c0iI7mBYkho5xUu+wdg5uUngAWCjYLI1G5+AMS8INeo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y2zMlMHN2bS+673J16B2e6HAK22Bl8/nnBfQ8j73X5jvWPdGKdNqWBZKzhTVTmJ16
	 H97z0wAEXD4XjqooFpRBdG6KsyK/M8VAKckzmAt/OyKSpIL9Miv/xEoGz8MeGZgmWg
	 B5iRUCWWnUNjXdMyAa+xqZzK6Lu9K+YvogITWZN1F9YcPpyJ4hIEPcnz7JyuUdo1b8
	 5CxsJnhtOuMPILbvil92iQ1iLJTXUwzyBdiVj6bEvQUNcneQ4kg7tJlOTEPLKoSHMf
	 C5BKKb7Puymq1NjFgF+dJtxg0FwqT174Lw4m4sTkdxylPnbDjzOHsWVLxMQFr2Mk8X
	 YIPIlM/kCJtKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E5D580F19;
	Mon,  9 Nov 2026 21:23:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 918E528C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EBBA402F4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2gOD9tJ1K7u4 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:23:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A7FD8402E7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KHA+IYo6
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7FD8402E7
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:17 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4911df1e196so694572fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794259397; x=1794864197;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c0iI7mBYkho5xUu+wdg5uUngAWCjYLI1G5+AMS8INeo=;
 b=KHA+IYo69wPKGna1RxtnoEVJALliySOYxMOEGDIF2T0rw7Sj/kbZ3s2dtydL/eQgmh
 scNqSidBnhlgd+dbqSbuzRw2mwD/+0/NxoxT8ZMt6WJlFUSPcr7w6qmwJtsGTPiub20i
 5v8nr7KG7UjUmU2kxT0xskWFJpiQx3JrRGvCGkvZCOz6COw/x5r5ovqMoqhWeHBN7BSQ
 s3bYhcNeMFxhKOxE4v9IajqEP3mp1OOC5WPuvxsn3nPunVrOgGSsvVnFQSPw7O8Xj4C6
 yyFxdYMeTUGj/nCTlq4Kcn/Af2s+fmr9JcoPgGbee15hGBBFXhOgacM6BYZyuVt3nOgH
 nZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794259397; x=1794864197;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c0iI7mBYkho5xUu+wdg5uUngAWCjYLI1G5+AMS8INeo=;
 b=XT7ivL7s/q4MqJsNMcyOCXjE0l13Gj8gMxXWeOwLhHvi+GNmaPdiVHjblc9aDjG+Lf
 eZKxJOYelUa4HZ6t63ZL6jWR3n4mB6E24VMVIB7qXaYXSeDoARjY7I6eNxPMMgyRpHbd
 Ulzv1j67uzgXzUXsVjjrq+JW7HeRp7WgrU/LGQqKwycwjdUHGjbztS2cvnQBcFi/wYCy
 0TTpdx8rk5BWHM9AsO2hGr4PCnn/FKjGhC4QlXlFA1Z60D8cmtrSuAMCgVPoGgsEn3IV
 zwn73lvsGgY1X38W4arE3WrtYlVzdmf+3drv+QkMXwIoa+0fZMeyDQq1ijpGy4CFAJ05
 dY8w==
X-Forwarded-Encrypted: i=1;
 AL+hErEdpxgKl0sbdTU/AP2EK4E56KcOFQ1TFxf7eZX7YUQdFc1riq5wjk2LpBTzUiTu0kBA6UVKFq0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8LxGGtk+5ATreMUGeOMEWlM5ADq1OTuSmZsfj0GqLbLK4NyR2l
 fJBG+7Cs3XjSpjO9pqpmbDFS6q6pZDRbRnbR34/RJyIMEa8HzrfO4T6VJ00CwV50w2A=
X-Gm-Gg: AYBFou3CODO98tFH/Zm3AYQqTimYiWfkmgwGRwBZSMKimrYwEDCF7LB+vdZSnauwx3i
 rwkYdxHjB/wSds7pTkB3qKVyieB963XoDhpWTb3jVwxe6vzcn/F1mnPMo5u8fbnnaCJyn0dN9/K
 kATvKf9s+i6E5ObWqOcNlutY/82QgIjykMauVWQkD34rztsjECm8A0KIlxuhZwsZN9TJC+i4AUt
 GsXoWGPqiaoGFktisNGAVFcSrEn2DKEGpUs6rXIi7kU/Kzn65TPKncP+YUM1xLg22IHxvZrr1TX
 chQ5VWvuWEwOTga4ltbjYNmea2VnF0rDL2t7rGm7yN8hzXQ57AxGBIeim1qBs5zXEwN20AAWBmF
 /Gv0NFpOKRy5NBdlQBZrz2OPAMyYnMwFsb+X9uTcQJIE2Wqt1Gyspfm7v+QjqXPVT5r3fZPradn
 rZQ3KyrBQccyQakYeHw47HpuUYZE1my5G3lD8NLcBMXjLk54lMSZ56ENnhTiUCSEf+tX/YXlRhU
 cu0vAIyM7TcMmnUZf2WO1A2UrN+9TSlqDalENy/K7KKJ2l+/Q2Ih/HfBA6JEazL7xITkmhG+GAn
 6dSJNk55rEZ7gUj3S8nZrbhybRy7m6Tx45a8rwynfucPgU1off0vp2Y+aIgtL6KQTEgRwMaNf8g
 18rP4+ABvfu8l9yzt91+hsLw=
X-Received: by 2002:a05:6870:b151:b0:4ad:7ef2:6005 with SMTP id
 586e51a60fabf-4ae22584938mr233522fac.11.1794259396956; 
 Mon, 09 Nov 2026 13:23:16 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae23031a4dsm197780fac.14.2026.11.09.13.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:23:14 -0800 (PST)
Message-ID: <1669b6d2-2179-4187-be4f-f888a93fc040@baylibre.com>
Date: Mon, 9 Nov 2026 15:23:13 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] net: mtk_eth: an8855: fix packet loss and sync
 with Linux
To: Mikhail Zhilkin <csharper2005@gmail.com>, u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com
References: <20261107142441.2104669-1-csharper2005@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261107142441.2104669-1-csharper2005@gmail.com>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 8:24 AM, Mikhail Zhilkin wrote:
> This patch series aligns the U-Boot Airoha AN8855 switch initialization
> code with the upstream Linux DSA driver
> (drivers/net/dsa/airoha/an8855.c), fixing several register configuration
> bugs and improving overall signal integrity.

I don't see this in linux-next, so I'm guessing you mean the proposed driver
(not accepted yet) [1]? We should state that clearly.

[1]: https://lore.kernel.org/all/20261009161102.38961-11-ansuelsmth@gmail.com/

> 
> The current default U-Boot configuration leaves the SerDes with marginal
> drive characteristics. On some hardware iterations, this results in
> severe packet loss (50-60%) and timeouts during TFTP recovery. This drop
> occurs because of marginal signal integrity on the internal 2500Base-X
> link connecting the switch to the CPU.
> 
> By correcting a bitwise shift overlap, enabling link error recovery, and
> applying the proper TX FIR / RX CDR analog tuning parameters used in
> Linux, this series ensures a stable physical link between the CPU and
> switch across different boards.
> 
> These changes have been run-tested on the CMCC RAX3000ME and Xiaomi
> AX3000T, both featuring the AN8855 switch, confirming stable network
> operation and reliable gigabit TFTP recovery.
> 

These sounds like real fixes, so each patch should have a Fixes tag.

Fixes: cedafee9ff39 ("net: mediatek: add support for Airoha AN8855 ethernet switch")


> Patch summary:
> - Patch 1 fixes a bitwise collision bug in the AN8855_RX_CTRL_8 register
>   that was accidentally overwriting previously set bits.
> - Patch 2 enables graceful link error recovery in AN8855_RX_CTRL_26
>   instead of explicitly disabling it.
> - Patch 3 ports the SerDes analog tuning parameters (TX Eye and RX
>   Jitter Tolerance) from Linux, resolving the packet loss issue on the
>   internal 2.5G CPU port.
> 
> Mikhail Zhilkin (3):
>   net: mtk_eth: an8855: fix bitwise collision in RX_CTRL_8 register
>   net: mtk_eth: an8855: enable link error recovery
>   net: mtk_eth: an8855: sync SerDes analog tuning with Linux driver
> 
>  drivers/net/mtk_eth/an8855.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 

