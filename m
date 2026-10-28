Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBD606A32A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dbVt18xQ;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=TCb/I6+R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD3DF6068D;
	Thu, 29 Oct 2026 05:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jAdcHpkCUAed; Thu, 29 Oct 2026 05:40:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4503606DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793252448;
	b=StltnY4zFOByKnpQhErjeXIlOOlAWX7BQDfmh7nMcJWfliIALGFS9++lcrKwrFIms2qZ
	 X16x0y4HBawwJy0w3XjwDxyQ+NRcdMskBk2Qk/7SPWL/Dcy7SuJlJKwea0LQ+wjH+jDVD
	 /eVcouZAywyZeMwYVCvMJ1Zu34za723JpmPG0l2TpvITRZMh0SwtEtSZUUhCVCH4zagTb
	 v1/qM5bPTvJ49vc5oAlbrrQ7CKZIM3A6qmL8Vayr1rJRAEq4qNHigcF20dT2Ino21KJa6
	 2khFtX0I80x6gKcDkyN7qcAQNIQPRJvVmDf5sYMndLf/FRLFETuMWR4cGYrh2pD6TSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793252448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7tYsqcxA0O6MVmtpMjhmd5T0abbaPIzALnTuUgxrKBI=;
	b=KIORgwAdnocahJILNQt/rr1QWlkPQpDEqXAaLUV2NNXxjmbQp8HzLzfGpOhSopvkU97v
	 cO8JhY4UP2JtztInNxfFpMkOH51DpUmpu+7O9wGfGg+wKSCRO7At7jF4QfuC1Ec355K5g
	 qpIu4rWibKlfEW/3guZdUlhtydhXbGi8Ievt7F5XfJLq52XgLxBWJdUsMxCZij3xTSeo6
	 tK6ytxvA1GnsPwlHhBnaReixYJlSTwkNLUI3oBK/jQu+akQlHvH0Nnn8xyIh0plDZeZeO
	 Vy+S+Z1HaijXHd7Eqvz5GcNZE2yYvobEj6KCfkbUGO7oM2/lPa+VpAkMVI0ThO/+xTA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793252448;
	bh=7tYsqcxA0O6MVmtpMjhmd5T0abbaPIzALnTuUgxrKBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dbVt18xQqOskkC68BJqup6x7T7coC0wsoXa9dGmRGjTHAJg9W8XNc9HyZCthrL6ca
	 8tKEjBBwled0gQqZ64apbBPLZHf7A+EOf1ijjJzo/AMQ5c29FIvny3l/gxsyPY1nh1
	 ONa7H0n81j79hZqDtrHjB3V8l09GwjbgMNmg1RQmx/Tcd/XTt2O9POfsYDOpoC0ZqP
	 8iyihjoUlsfDA2EJXMVrrBdbIxJEhJzFf+rT0optcraXNInsRz4qfyORKCVtUSUaQo
	 5hJa1Pron24EYdpJqkIMzA9MQI4nrwk4T+wCJ+r14iwuT4OYpwgBpOoOLdGBzCAg5O
	 IYfgEkEdXDbiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4503606DE;
	Thu, 29 Oct 2026 05:40:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED352DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D348140176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:40:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tCZxpwM74kcJ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:40:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0B69D40080
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793252444;
 b=OsEsx7DhkhmGuz7VNQrtQ6dK4L1BAoIFwB3lBdPgV9rsY8IHnEqpZagGmJUsf+/NAcb7
 OqwJbZ8j2s3+knjcIysj6VlrdbzDQLErQNevQ2EsC0uj2EdMJdwODuYxato0sSaKzHAgR
 Ka7cL76jL5jjH+sv9rj9feLH2gn7/emDh92UzUSo48EhtFQAD2kR4ktoTQAeEKIewWADO
 oEmeKUJC2J+fkRIIF/q3151dHTcbE7ufmcVffLIq8NeNWQhVCjzAHn/cKUimEeW6y8j9k
 Z56pwQPMW3tXNZd2FnPP8lPh7ESqIpx4QNHv76n5fcXdoBFcx7Qq5qVoORc7QgWghhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793252444;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=7tYsqcxA0O6MVmtpMjhmd5T0abbaPIzALnTuUgxrKBI=;
 b=HEb/E4m5hiTn0OkVZWPAb6sZOYL9McUD7Wqg1AVYx6up/OOWA26B3HHLWph/C1OcTJJn
 M3VqNHt5Kfsh1g+27dmyaHkB/k8E59PyU+cuHrGyPEjO6AQPHiw5rwt/kddJefN7T0o3I
 F7VeYlL8o165mVsiUW3QrnrWsFwlvP74Xjs3cG1uMQ0kDAz/BNUBg1oa2IGhdP03MqdOD
 qVQpvaRHt8TWXmSWFaKvrFIzVVHrJTkIgvQXQBQz/62/WCDYxCsRAr2bn7vdlCJJrvvWx
 R8RJe0FdtydlTxeJp7QoDB4rkst2iCBCWH4UjYY9cqCEb1HZ4N24o4vooa566lAEwpA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="TCb/I6+R"; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=TCb/I6+R
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B69D40080
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:40:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A600110BD3F; Thu, 29 Oct 2026 06:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793252440;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=7tYsqcxA0O6MVmtpMjhmd5T0abbaPIzALnTuUgxrKBI=;
 b=TCb/I6+RPZITM3gE13dvHaweSOURXzb84WLsL324iEBsvIRB27HPxdzQ2smIwMS0he/sU5
 00TzzoJWfhdgz99LS2wBBOSPbEpMW4HtUIRGCNEngo5vmhxtLSriWpEr3xnBIE0hYjk4Fn
 n1ZImbCTJ9D6SiCvRFXf63ig74gJVRhR4impEDKBGmRPPxGyiZzkyQTdQaBaGS1v3jfIDI
 dLShAH2MgaKFqEk3rKV749hR9KOERRNjiyjP8cCo1LJqYwEQeSywjaIThv3xGd92b5nMji
 //d2CpDwvC3jpe5slypGG8RdKS9X9t5C4GOYLZaandSvuJY+Ka++QQOWUVNMyA==
Message-ID: <a0e9aeac-0c20-460a-897d-b2b9163739d4@nabladev.com>
Date: Wed, 28 Oct 2026 16:16:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] usb: ehci-mx6: set up i.MX7D misc registers
 regardless of CONFIG_PHY setting
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <bd8f810425b7d3f8d1d78fc699b232da5a7ea60a.1793091394.git.nora.schiffer@ew.tq-group.com>
 <a829d462-e139-4905-b2c7-f8140a6cb2f2@nabladev.com>
 <b94621f8cc783f5f1e97578ad7bed3405862574f.camel@ew.tq-group.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <b94621f8cc783f5f1e97578ad7bed3405862574f.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 11:40 AM, Nora Schiffer wrote:
> On Tue, 2026-10-27 at 18:24 +0100, Marek Vasut wrote:
>> On 10/27/26 10:39 AM, Nora Schiffer wrote:
>>> While a separate usbmisc driver could be added, no such driver currently
>>> exists, and it would not necessarily be part of the PHY subsystem. Rather
>>> than making the misc setup conditional on CONFIG_PHY, make it depend on
>>> the existence of a fsl,usbmisc property. This will allow enabling
>>> CONFIG_PHY on the i.MX7D for the NOP PHY driver's power domain support.
>>>
>>> Also update the code that reads the usbmisc address to use the modern
>>> ofnode API and fix the portnr to be determined from the usbmisc phandle
>>> arg instead of the alias seqno.
>> It seems this patch does multiple things, can you please split it up ?
> 
> Okay, I can split this into two parts:
> 
> - Make the setup independent of CONFIG_PHY
> - Use address/portnr from ofnode
Yes please, the clearer the separation of changes is, the better 
(=easier to review). Also, please split the series by subsystems, so the 
maintainers can pick it up through their trees. Thank you.
