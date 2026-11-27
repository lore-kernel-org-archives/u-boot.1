Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E29606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gHXu/mLz;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=JQQ76VWE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B7E040A8E;
	Fri, 27 Nov 2026 12:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BpxvGVX7MLg; Fri, 27 Nov 2026 12:56:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7234340A57
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784206;
	b=qcPe1q6UH0HfvKqAp+CmySebmLfvMcr58aPhu/vzDR7g52USWd6Y9od9kuTUs7U7v6dT
	 OgzSjn6TzY6lL0w0LMljYgMdLuYtJJC4fYEtqCagCGhC36l569ddhRRSRr8BeRGdcomVp
	 4fXwrPU0dRJfczb8HRwsKIyxpjoAQqrShw4pudL9jnsQ/VCBxlOzC9g+lYA9b/xJn1pV+
	 H9HFZ9WyHrlIc4aTjuvt6UjnIKZbU9MTOlEVuzPD4xyo2uJc5JI3L3+1230ZQdym7SPt4
	 AfDEe+u1hzgb2kaKezxAk/9d84ht8rrcdGDla/ne5eeRqIoMNj3yo1kdEITGl/4RxeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oZZhWL75cxxpHyX9ZJ14+o4w2AQ5tkjlwhwy24S0D+Y=;
	b=UQ9KjZnDSzUd8SmipK+1ccnzyu1A+AiG8WpV5iZqJCR9PzJyjIWTMYIXeEjpElQQQraX
	 sJUo2shVw52yIotSt0YAfy0z+9Ngkn9zXcLgJnwZ1G5odyh6n6Su1V+8s9M6rEvvcLTmD
	 ztMoaSiXhux2ZtBbEy2wP+vQp4d+hTKM/U3csMr15BUEwF/KWduPV9DVzuTEsFEoYDURt
	 qE4D4WZRNR17/1fa/MDoYfOP4Cezj90Z7Ssf+DAPDfwhPpubkCtWPfuea7ueea65Mz108
	 FqOmnyyKZygEhw4/DIobT9e0a2x4zHY2TP4yqm5VvySsFIBGt/GtNUBBEhO9A1YC5hw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784206;
	bh=oZZhWL75cxxpHyX9ZJ14+o4w2AQ5tkjlwhwy24S0D+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gHXu/mLzdaJUgvT6tEuI3dpYwiDZ7VdNMgINubIfh7NyXoyG8T46qg8QvVEaBHudB
	 7HiSATTH1IUpnvo1qzZ5ZJ8IaYVVmdGdtzk7bXteylTwhq4p7k/gyseWOXfun9j1hG
	 Jmpu6b5E4SQ4u6S4POp7JAG+dr33mvHrVMJnJzGYCmgTR/mADZ1o/0l4IA7LKW7eqP
	 zcWQlriMyRPBAFszg9k2h6rAW4d2KsW+4aKleIK1vFQ4E6yLRSV+5N7bZs8gtURIWI
	 AKBMTzLiMolqltX+DJlXSJu0j7BY/6oPf/+DS0/aLY4xtceQ2cbjPXfOiSf5c0AqZn
	 zszFWPCpWkuiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7234340A57;
	Fri, 27 Nov 2026 12:56:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 39DE926D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BBB2811E1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8OMeiitC7rjQ for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 12:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4024811D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=JQQ76VWE
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4024811D8
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=oZZhWL75cxxpHyX9ZJ14+o4w2AQ5tkjlwhwy24S0D+Y=; b=JQQ76VWEyXADmHyFdV0nJXnZmY
 EjM4UvHojMhMzoQRSLC8Y/kHf11/4q/o95BusN7J35lqxU+Py44ZPBVqFgF+M/0uimFsrNnyhu9Vo
 ZvCTROBG0w9b+bjUV7Kt8KiA6vLueq+7VpvRA+9+arMs+XLJUr5wbV20hgbVj6eBzywNTOPYrQF7P
 14V0Tici2vES9mX0Q5BjVK7hgLVJ8S5DEsZCoAhD3vq3oVD3nHYk4kdNiYA5FvhhhsqvuHrG8l7KT
 SS07uqyW9AXHPgnaMxCtQ76h5hOemUhNw1GlrMAtLA5nM+z+dhJBoqd6U+XmJdYt9aa+GIjBN0AOR
 yq5xZSLA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1xWvUv-000611-2g; Fri, 27 Nov 2026 13:56:17 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1xWvUv-0009Vt-0W; Fri, 27 Nov 2026 13:56:17 +0100
Message-ID: <d1e5c394-d882-41ad-9f84-81c087522d1e@ew.tq-group.com>
Date: Fri, 27 Nov 2026 13:56:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] board: tqma6: add SPL support
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>
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
 <CAOMZO5Au35UKfYKAXsvJeb6osi19cyLYDQbO4B6HqddEhVq5xA@mail.gmail.com>
 <b4f96b56-7034-4745-b863-55debaf5c941@ew.tq-group.com>
 <6345821.DvuYhMxLoT@steina-w>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <6345821.DvuYhMxLoT@steina-w>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 14:03, Alexander Stein wrote:
> Am Donnerstag, 26. November 2026, 13:33:17 Mitteleuropäische Normalzeit schrieb Max Merchel:
>> On 11/26/26 11:52, Fabio Estevam wrote:
>>> On Thu, Nov 26, 2026 at 7:47 AM Max Merchel <Max.Merchel@ew.tq-group.com> wrote:
>>>> Update defconfigs to use SPL.
>>> Same here: please improve the commit message by explaining why we're using SPL.
>>
>> The SPL is used for dynamic RAM detection and selection of the U-Boot
>> devicetree.
>>
>>
>>
>> In the next version of this series, I will change the description to the following:
>>
>> TQMa6 is configured for booting with SPL.Dynamic selection of RAM timing
>> before loading U-Boot allowsadditional RAM configurations to be added
>> without the needfor defconfigs.By detecting whether the CPU Ethernet
>> workaround is present,the appropriate U-Boot devicetree (depending on
>> the system I2Cbus used) is selected.
> Not sure if this is a mail client problem (same as in 1/6 response): Please
> make sure don't miss the space character after punctuation marks.
>
> Also use imperative style: "Configure TQMa6x for booting with SPL." and
> so on.
>
> Best regards
> Alexander

I have checked the descriptions of all commit messages, verified and 
corrected the use of the imperative mood, and adjusted the spacing. I am 
submitting these changes as V2.


-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

