Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B685606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aLjoO3TX;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oIdQa/xp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC46280DD8;
	Mon, 16 Nov 2026 01:20:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTguCCFtcDEN; Mon, 16 Nov 2026 01:20:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E08280DC8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794792020;
	b=apih7tIqIB7/BXGF8v0nuQu9++QEoX7krmI4fJkmWOE5mFxGFi+TtVqKcXkMvl08YA31
	 kXDgQJ3WEvAP6+/jk/+DW8lhdEtnNpmXWqg2bvESkuzM7UVU3DBFVWReku5yooAy1uEPs
	 uZa1A+d7osHTFO8ds80le+pqbq37EXQqkFFTsPwK3CDTNEzzFqVE/5yl6Mt7frcCZFQ3U
	 4Mkn22ZWW/zaaFHrE2u6XIZgGyifwmw0QBwc2hf+g77CgYScYQ466TT5VRA6ThwN/3L8j
	 sQjbc4sfoO1DZUDuOYloR26NIHwMdBU0EggP6Ta1Vdi1jriUEfoHDxScqwuKyJ4ogYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794792020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ctb7vvtDciradciX3Za2R9hINrMoxWXdwcTPLW4A5Qk=;
	b=d+3fgYra+YsbqCJlBqgrfvyx8DhwHZztjs9GhXKqJpj+9gA4rCo4px9Ftu9IPHRAdLFW
	 k7Jcd2hQ87Q/WLehakCeC8YSFQOku8WmW3a7s27sMHlX0swZ4gEctpx+mr5VXYmUIrb6P
	 JLuHamnMikPo9vypmXjufl7EaW8UE0WqAO7IAUCXhJ+CYJZDqNevfKEKNqU5N0sjLVFDF
	 5R00Z1be9Xv45bs+ooi+CtN6D87Gxxdf3Z1OgWVgDsRAsjgCnwkOUODUUQN93Xy1OPDiB
	 E61CLVVXDw7dxVeqp/ymXKtLGOI5hDG3XEl4OvuCDNENeKv1g+pR9WsPBzD8Eervmmw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794792020;
	bh=ctb7vvtDciradciX3Za2R9hINrMoxWXdwcTPLW4A5Qk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aLjoO3TXFH/VRW809Ei4IuSwPhPq5780vbIlZYACbc/j4f9J1SX0zkgD/+2aKyJuv
	 1Z0lhcUvVwwUxgQGQ3kWMc2Hnw1iDC4Am1WPuDYXQVgyaO8imbXYBfJbuS8HYeP9gN
	 qQ5q58F3MQicHxYeY8rsEgMsaZ+WR1GzMrqJpQpMznHeg32MIfxg3BNfuSMWea5RhW
	 yvMz1LJcvnzVmGBQjH/ljdiEd17nirwVxUECMqJwFHvZdGQhm4OMWxjKYchd9OsvAn
	 RyK6zFFfrvtgWN7y8mbocdGrs84u99qYNeQOg0kv5kXJv/jqwPCEECAF9ll7PonHzC
	 MoH96qEL+vhNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E08280DC8;
	Mon, 16 Nov 2026 01:20:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 53A2C2E5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 01:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3080740072
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 01:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q7xKXI5nYcMu for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 01:20:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D6CA340012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=oIdQa/xp
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6CA340012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 01:20:15 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSVR04NxZzKnQP;
 Mon, 16 Nov 2026 02:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794792012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctb7vvtDciradciX3Za2R9hINrMoxWXdwcTPLW4A5Qk=;
 b=oIdQa/xpAIm30nvHp/RDZSht1Jd8xvt6PIHs//gKLB8NoJdEg9lFlvTlX0kZUhnN8j2z4+
 4SKfeB6sA2nbl2gjL90j90mKrr1kEDBNLfyZChME8JK6QA6bbyeuZ21vJAYW9aAjg1dB2A
 6Gr6Q6sqRDQ5oGsT2IEiluhBEqBljkO5A5JH+txni9AWF/wpltgHIUumJwGv+8z/gfDPEE
 iTe2gdXqkwjl2rGb8kjuOXe4gagNCXX1C8nFXiX5DfZMM4XL8CMAD5FRG3lfcA+/l/GWbM
 zK5vgma+wpwUa1+fz2KSqjwxmPNUat3vZNwDRoAlFAg2Cg87QAIIkWDJO2+aKQ==
Message-ID: <ec1a724b-ffa9-4a23-9d39-3eea982729ad@mailbox.org>
Date: Sun, 15 Nov 2026 15:21:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] usb: ehci-vf: make the USB host port usable
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
References: <20261114152441.881148-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261114152441.881148-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d74ae01d46687b26584
X-MBO-RS-META: btszsf5oi9owdxkibq9mrnpxnppozbyc
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 4:24 PM, Mehmet Fide wrote:

Hello Mehmet,

> A gentle ping on this series. It still applies to today's main and next
> without changes.
> 
> Is there anything else you need from me for it?

No, I applied it now, thank you for the reminder, this helped.

I'll get it into 2027.01 once the CI gets fixed.

-- 
Best regards,
Marek Vasut
