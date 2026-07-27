Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C343C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 10:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D58CD80D4A;
	Mon, 27 Jul 2026 10:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uybuHQxpLNy5; Mon, 27 Jul 2026 10:31:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4284A80CD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785148315;
	bh=l5+j2GeYQ+/Z1dcChllPt7y1yItmWysaaVy3Llnvn1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MlOm2uj1ra54fmPX4jZbG9v/q1qwqqtce6Yf+5fphuzRw+ZAMWeboslwtMJnxzRlc
	 1oI+RlkjhmPtYoG7MEXYqE+5rFeCKrUQu0Bogz3YAyUvdxbSEXhD5Im7OgiJVs2mXP
	 kdfugVqwp0Fo0VBTnQqCfbE672ffrBV6w8JSXomwSZJ6paCc4xtUNAWoePH8EB6nBH
	 lFO6MN7/5pr6FNx+TYp80J6RVSvT8MyYLgZgfmMatp8GCF0w/LAqZ4Elp2zgM1polM
	 FR8zuXpWIzj15DQESsIs+NGGU30fHUblckPfiKV8Cttw+L9uz3Nd2ogOzmCSGTKObB
	 pswWVddD89GwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4284A80CD0;
	Mon, 27 Jul 2026 10:31:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5B2742A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C371C80CBF
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:31:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CH-iHhhulFgi for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 10:31:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.92.25.147;
 helo=mail-d18.seohost-mail.eu; envelope-from=krzysztof@kd-solutions.pl;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2681680CBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2681680CBC
Received: from mail-d18.seohost-mail.eu (mail-d18.seohost-mail.eu
 [153.92.25.147])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2681680CBC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:31:51 +0000 (UTC)
Received: from 83-168-76-203.static.ipv4.korbank.pl ([83.168.76.203]
 helo=[192.168.1.135])
 by h74.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <krzysztof@kd-solutions.pl>)
 id 1woIcf-00000004BXL-0gzO; Mon, 27 Jul 2026 12:31:49 +0200
Message-ID: <e121d47c-f724-4f19-9aad-5f8f9ced7f2c@kd-solutions.pl>
Date: Mon, 27 Jul 2026 12:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] power: regulator: ADD PMIC PF9453 support
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
References: <20240930035531.27079-4-peng.fan@oss.nxp.com>
 <b80b20b3-1d30-4a2e-81c0-d974f91f48c7@kd-solutions.pl>
 <CAOMZO5D-8Ti+j3fUBAztkFY7wYZJsLcDQaFmcvH6cSgPXB23tQ@mail.gmail.com>
 <57257091-5b3e-4249-b7ba-b7d0a7699d51@kd-solutions.pl>
 <086d67e8-021a-4cca-83fe-281502142339@kd-solutions.pl>
 <CAOMZO5A9SJZ+zA7Z9oOsjm09C8Xz0pT7959UuemfFU8L4QumMA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
In-Reply-To: <CAOMZO5A9SJZ+zA7Z9oOsjm09C8Xz0pT7959UuemfFU8L4QumMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: krzysztof@kd-solutions.pl
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=kd-solutions.pl; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l5+j2GeYQ+/Z1dcChllPt7y1yItmWysaaVy3Llnvn1E=; b=fORIxmjkpzeXxRr7+4xa/xs38W
 Vb3ngD2qcdjciOm+JmWM6vAtPtk0AZlZ5zTGK9zsStAcMUqX4gKrPQzBvz3PnMBxsbQS07Tw7j0WM
 FYOGQHQMpICCFrIa5n6BG2p9WJRvWiUJTcfSajthtuf3PY/24fowgGGD23oHOAAN1eMmAowx7ci0c
 z0CdWostiDkRiBg3z2/Szhb1Nq5pSqpNES7+mbFdJesyUL3qG6ZxqznMvIDL1T7A6PBjxCPSgcW/U
 pjXaWuOw6nw/PIciDOubUl8VDnCROM33NMXeCh1KUpha5iUAIvIVaV3TewGkqhZSHE4vMrXfGv+dc
 NL9zrlxw==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kd-solutions.pl
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kd-solutions.pl header.i=@kd-solutions.pl
 header.a=rsa-sha256 header.s=x header.b=fORIxmjk
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

> On Thu, Jul 23, 2026 at 8:22 AM Krzysztof Drobiński
> <krzysztof@kd-solutions.pl> wrote:
>
>> I don't have possibility to test entire patch series which covers also
>> PF5300 there. I assume, I should create new patch series covering only
>> rebased and fixed PF9453 support?
> Yes, that would be appreciated, thanks.
Rebased. See 
https://lists.u-boot-project.org/pipermail/u-boot/2026-July/625966.html

-- 
Krzysztof Drobiński
Embedded Linux Systems

email:   krzysztof@kd-solutions.pl
website: kd-solutions.pl

