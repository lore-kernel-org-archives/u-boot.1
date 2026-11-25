Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EF606A337
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZuENEcx5;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oAoqnRsx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A466880D3E;
	Wed, 25 Nov 2026 08:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cgpcPfbpLEFz; Wed, 25 Nov 2026 08:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D77280D6F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795595761;
	b=K+8lTYIeYnoQqYvbU+Ffy5KQN8OYI07aHNFpbU9GVJ4FLZPB3ZT/Ov478e/BTQ6TkEHl
	 n3NxZDvwh9wfaxIzgj1YXb8LoD+7+2uGPY7AZ4OMConPT7ccYbXrvQ32yvOSbSZjvY+37
	 pTvoXqhSZQtoa5NCbqE17oe7XCoHLLitAIfOBwfgv1WcoQN7iuowSHiXrJNlrH6IppCBQ
	 LEDNWckvG8Mpvvi4T/UqSwjI7mst3OOHqJqZjRwrXZY2JQQ4Zy9opSK7dCQ3gtDkXBuAA
	 5fHmNe84kS4199i8pxeyHAeeXYR/RpFq/P1t4alr2twtolcLZqzw1VAJynFR2f6XPmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795595761;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EqQET5CHiN7WzTbN+xAB6XRGI+MQ9Z9exhHpEPPAm1Q=;
	b=Clsf5WGNGJ8eToJrjHEtNobt9fgSPBvVR1P0PPDPYIEjHxgMytZOiTAqAflWJTkjJBEw
	 dI7gaO4bUd/TFz70c8adL9rCLEjURkSaK+qSylIBAsYaziH4mIr0OQeruzaiQjhfvB/SA
	 5QXTb1Lf8o0wuZfmJoh8nVAr1jjzSmffypGYV93MaTIDXdMrH+mR6KY9K30pt2uUuNpLf
	 UmZKVssdTRXKW+X3i+rd4Ord8yqWdKzgNVUY83Zxe+rFwZGyVPSHMEGsLxBCnAzrb8dxu
	 fiHJX0Yt0ZJJrEi2UWq4HavcJwnWL28M4HtR+EFBqpiyEzTPPDe80vBAuLtOSZ6W0Fg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795595761;
	bh=EqQET5CHiN7WzTbN+xAB6XRGI+MQ9Z9exhHpEPPAm1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZuENEcx5CxAZiGCjevf0wCxs7P9IDO4CFjeaU1H+5Vtsrkj01bERmHD8JQLToAG1l
	 2Txp3Vgt4V1E5PtVOpAazZoroKAc6lUi+wLpythFxkc2HFoX2WqdeMfhCM19PV8f4Y
	 0a9O88vxHaaH5WUgjaIZKjh/cwsTq1tnLVaSN3onZdgJHoW5NlrNlkn08D/3J6frFA
	 T1QHdslRY0533uXIOO4cuhl21lqpv9GH7v0cThj1B77WOw7VISxEe8GS7S8791YZS7
	 I1tod9G+arbORZXN8f2Zo7uDqRXiAerA4OAyKbHVFZAO0PHsjsNNVNiLc7lrhaHd0T
	 h7Qw4POCU8Ayw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D77280D6F;
	Wed, 25 Nov 2026 08:36:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98CC92F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EA0140122
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CxXgQWJi_4Ea for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 08:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3CBAF40064
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=oAoqnRsx
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CBAF40064
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:35:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 629CF4E41772;
 Wed, 25 Nov 2026 08:35:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2B89460480;
 Wed, 25 Nov 2026 08:35:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 38E4A11E69B7A; Wed, 25 Nov 2026 09:35:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795595752; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=EqQET5CHiN7WzTbN+xAB6XRGI+MQ9Z9exhHpEPPAm1Q=;
 b=oAoqnRsxThSY++PiU41a5wXNbWZYGt4/5KFFqymJQfGNAapssspSi4RdvgFEG6W7YmilR6
 eHk1NYtQ/X5E3jDVEmx9D1/q1rEK2IP9670dBouTMoiNDxY4nJqTgAGXbTo8Qu/berKnND
 Qx3L0VWeMN9BsNlltwJXmjOfKCGQYm3WhHV+IKqRLyn8g7kvnGRIvuqUJHzw6W3oI5Ao4i
 5XmA65XWgNAYH3qWHBAIGwArSFRJoyH81i/p3ab/SWt8pz9MQN1fxpSQ6FZ5W6MUScHVjS
 Vw6b1YMM2+vpKIPtAyc4519xJoy3X4Bkh/N7tV4PyO4b0voNcMD4rSY3tyobng==
Message-ID: <924974b0-9626-45a4-80c4-db80c321597d@bootlin.com>
Date: Wed, 25 Nov 2026 09:35:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] configs: sl2619: enable basic drivers and commands
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>, David Lechner
 <dlechner@baylibre.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Yixun Lan <dlan@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-8-9e3b28c77cda@bootlin.com>
 <20261124183602.GY3176972@bill-the-cat>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20261124183602.GY3176972@bill-the-cat>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 24/11/2026 à 19:36, Tom Rini a écrit :
> On Mon, Nov 23, 2026 at 03:22:07PM +0100, Richard Genoud (Synaptics) wrote:
> 
>> Enable working drivers for Synaptics sl2619 RDK board:
>> - system controller
>> - clock controller
>> - reset controller
>> - pin controller
>> - i2c controller
>>
>> And commands:
>> - dm
>> - clk
>> - i2c
>>
>> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
>> ---
>>   configs/synaptics_sl2619_defconfig | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> Things should be re-ordered so that the defconfig is added as complete
> at the end. And related, the SYSCON note I made in my last email applies
> to the other drivers using it too, to be clear, I just hadn't gotten
> there yet. Thanks!
> 
Ok, I'll merge all the defconfig changes here (and add the missing 
SYSCON to the reset/pinctrl/clk)

Thanks!
