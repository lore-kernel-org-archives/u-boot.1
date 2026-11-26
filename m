Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD9606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ByaU3jvw;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=oMVfGDI/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B5634091D;
	Thu, 26 Nov 2026 12:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87meW1V50KYp; Thu, 26 Nov 2026 12:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AAE4D408B4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696414;
	b=CgDpsn2Q/SSYaLauSdigN9rz8ySzSHHEr/XvfU0UPg0eqAw8YzJ3WUot6xlYgMemjXA9
	 yM20E6BK+e34xn3hDcacf3n/qU/7LfjmCL/j+44VGj2rpCm2zXOv1vvAEijsG4OKn6Lok
	 xzgiiQNIhRjOvMAPZTnhiM20I6Kxa4HgJodoX4XEF0RhM0xTyjN5dlG4sdwmIl4GbnKuq
	 7rEo2BgoKtlTHdnIDRekJt1zevnvaWlo6LLl/9nfIZm0u80ZAX1TjWdTrFtayxPOk4eiO
	 69Pwj5F620dYW/aQiJ/0XX765adz1Rc2amyxVE1DdOPD3sJQDmkZxOGMc77fvbESc5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hiy7CHL4tvayvkkQ8pUB8NIKkfsvWwLNsq31gs9D2vE=;
	b=UnsST7fgYO9LqsRtWLg47l7j99YiGGzYpYQxW8xI0JnSENz7P+YxlOi914N2klSd4Mng
	 MHh7Vjvym/FJF81b4T2vHK/FKwLRIus1sznvZ8ru+OchCXW3n6ekivuc7YnhCIrGF6BKF
	 ihW1jwYuI9gZ8U6PuqTtzNRdTlXt55qqJiwT/CXxxPZ5o5YXPyUYu6R65FAuYkvlzD7RT
	 6VVbtU30zAXMo1PT/VHswfACNUBStfNK1X99vhB//yGFak/cxUvQEaC/yonqaNZKIi0CP
	 i0tHAQG6dzMfnjRoioV3yT41QaW9WCUdGptaEf5dI1D6WAE69wJIBUxMaXsybEm8WWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795696414;
	bh=hiy7CHL4tvayvkkQ8pUB8NIKkfsvWwLNsq31gs9D2vE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ByaU3jvwsFI8sFIjrURGowJvc3pn3ehlgkU6wwk3UTxH6yNONnNSvqclBMmqFeh8v
	 LnUhM1ittW+DwlAyQO0hDDoiLyHE6wtWCNfHnDAw6b01DyQ3k9sdb8VdT8rAeDq2A9
	 JfOeoTtDWMG6ZkDVJGEY+47YKGMngXtWvP/aonJ+9WPR9BBpLKUsp97c3rJJufzBH3
	 NC1o7AxG6cryj91M0t90t/x2VPND3RTrT28CrJLJuIcaZ/A3GGwjIOpmAFOExXiVci
	 MX9VGh/6MHTlZG89DWL+6T+hCD2VDa2Td3S+BQ4A7fMRRsDMgv3hW1jeBuKjofecg5
	 ISSZwFcVfP0eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAE4D408B4;
	Thu, 26 Nov 2026 12:33:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D38572DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B96258062F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FScGBVaaWSya for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A60708061A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=oMVfGDI/
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A60708061A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=hiy7CHL4tvayvkkQ8pUB8NIKkfsvWwLNsq31gs9D2vE=; b=oMVfGDI/G3MJdGQ2juNSIfswSG
 xCBbV37gpM801hjgwaGqR/ienh8vexycobXYFuO4lGdpoJOrQ8aY2t5EEsKDtzuWc+IwRxU5de4nL
 6AbU9pzGoh0RpLGDYfWy/kGOoxGzr/ca97n+1rwTGdJUICzo0wy+kTsih0DXvviVy6H5Pwx/vzoTM
 uiE1jVmqHLrr72AHOjOxaYd/36y+cobOxdSo7o80dOvLdim3RdQhpifGRBQzEYOml678/LkK1LjHj
 4Iqk+0eTw9TEk7rNcrxy8SJVyFPYT82MS/ylJUyu/d3PNUVFf45/aMtsXlDQKXm4IG46VQjzKDK0N
 DE6Pj7rQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1xWYf9-000JtB-0K; Thu, 26 Nov 2026 13:33:19 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1xWYf8-000Eq8-0J; Thu, 26 Nov 2026 13:33:18 +0100
Message-ID: <b4f96b56-7034-4745-b863-55debaf5c941@ew.tq-group.com>
Date: Thu, 26 Nov 2026 13:33:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] board: tqma6: add SPL support
To: Fabio Estevam <festevam@gmail.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Paul Gerber <Paul.Gerber@tq-group.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Adam Ford <aford173@gmail.com>, Nora Schiffer
 <nora.schiffer@ew.tq-group.com>, Johan Jonker <jbx6244@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Paul Gerber <Paul.Gerber@ew.tq-group.com>
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
 <20261126-update-tqma6-v1-3-a105aba78868@ew.tq-group.com>
 <CAOMZO5Au35UKfYKAXsvJeb6osi19cyLYDQbO4B6HqddEhVq5xA@mail.gmail.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <CAOMZO5Au35UKfYKAXsvJeb6osi19cyLYDQbO4B6HqddEhVq5xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/26/26 11:52, Fabio Estevam wrote:
> On Thu, Nov 26, 2026 at 7:47 AM Max Merchel <Max.Merchel@ew.tq-group.com> wrote:
>> Update defconfigs to use SPL.
> Same here: please improve the commit message by explaining why we're using SPL.


The SPL is used for dynamic RAM detection and selection of the U-Boot 
devicetree.



In the next version of this series, I will change the description to the following:

TQMa6 is configured for booting with SPL.Dynamic selection of RAM timing 
before loading U-Boot allowsadditional RAM configurations to be added 
without the needfor defconfigs.By detecting whether the CPU Ethernet 
workaround is present,the appropriate U-Boot devicetree (depending on 
the system I2Cbus used) is selected.

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

