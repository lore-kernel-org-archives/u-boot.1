Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E279CCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 564CB80C47;
	Mon, 12 Oct 2026 09:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqgBiNsjdHSs; Mon, 12 Oct 2026 09:48:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91388809AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791798488;
	b=rmpo192EMGHiCTqe3bWZh5BCeOlUtMTNuAedLwuWLMjIi43A1vCk8lxi+C4Y7nilsb5c
	 0QVV6+eqaUPBJJk1P7Dn3F10x+EDf/64tBiurOadW9dxKhIL8+K0/aUCCwQsUXepcE+uB
	 cxY5jxFypWm5DLy1aw9RDZzc0ydS7EmchPT++y1Z5ijqgYh549eriZuSEqHaeEuZvDviV
	 hdECONRojMsJZmWIwm7wrqgIhmNgaBl+038YWffIJ8qtQNBAkjfCbn3kaeLsJ02SabVtV
	 n0iagxq3Md0P94A/Fy4vuVDu+yAQ7Wn+W12slV/g1bf069jcVmS1AwZkon9xYGTQfcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791798488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jFDaoWDsoI1zZRgDhIAIMFazbpPwuV7r2b8yWppzbXo=;
	b=pVOfvXJV5oLcOJ7JKVcZQ8BhqcclCVUUuWoOWJQRc0Fz/IRhOEYQ6siBAD50Jg7aGnC+
	 8FANXSj5CPG+DTznUNOklRvYFVCkJrLugyNFb2K5xIgWd5WHYn6x0ULpsUrrdZr1eWEJH
	 Gc36XnSOSyv72RFHW1pEF9KLq7O8USsdgYnED0qclfihBjZybiKor17m9WB0hb2Is/so1
	 giGCGpvqPRd0X2oIYrFBZNA4epvibSCPCmE+ZYphhkmcT6OAImPeMBNEgC356nDTpX/cI
	 4plplb6x30JacWf/qSHGFy00JkQ5hcW7KvfEZxDIiZfpySkOUr1uAVJ2rFXhOsYbDAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=monstr.eu;
	dkim=pass header.d=monstr-eu.20251104.gappssmtp.com header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="Hc/gfi8H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791798488;
	bh=jFDaoWDsoI1zZRgDhIAIMFazbpPwuV7r2b8yWppzbXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dAAF6aFBR8ym4k9T64BIeUzXyOJeJOPt5AVHgkaFUXMvY8RIDQ+6LIkz+pOKQsEt1
	 xabWwdOuD37GLK33nX4oITxaHRKMV3+Hy09o4IHMG6Ia+B/piuceAcQeJ2nzJwXtOj
	 9nZphmUnPbzIx4OqDRbxl7ME235VOxz5c3e9SPoTdPVtJPT8IaCO8M3rB694+luJYO
	 7D/0FYybOyWXES8uZnDOZ8J+FQywCkPm8TDFL/XdtnFY0Jk2C52MzMk6mY49rO5h9F
	 He4n0a39wSoN2YHu2ZMkCNjS5ydZeQes8PVPFTlTZZSnTgCWCRy1gqYK5XKDWh7ZV6
	 bQzwjHVco/6qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91388809AD;
	Mon, 12 Oct 2026 09:48:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F3DDB9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E39A4809AD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GuLoQWCxU_wO for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:48:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F4778097B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791798485;
 b=ldtopqJT5wVSDiP++8lYEotVYJxXDiP6Z9InZ+U9VjyjtF1fxf09om6fqViLERX7IxX8
 TZ4BpovAZoj72zogo1PFzgKn8mVZsXYJyIsPrIHjgAPzwdluWSs35RJtnoXqCdYekvvl7
 W/c///ZxOoztzuyM8z5023H6EPz4m0u2esGqfy9087585YUrx2IWnCWYls1A4VrYm0/eZ
 gaaWjF30ITWlulZHpKe4hAksMQ0hW1DfLwOJgKjUw7/63VLq5SBBbfz0f6L76ZucpBhdg
 LopN1mPVPwUjUqXsdyfm5fOiqDia6fRf+rmYfLDGD5nzvQfgnmvodZARENqn7clrc2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791798485;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=jFDaoWDsoI1zZRgDhIAIMFazbpPwuV7r2b8yWppzbXo=;
 b=CkEWBwhC9v46elajzaygiq9K/gR9Qrl7GoBUflp5WVlkruIyDhSy0OwXWbO5CfEUDwPp
 HOB+b823o2qs+ak84Oy11vP2pSM96kCxv7Pb3S/xuW+L3yMrrd7nyxm2w5cF8YUqnQyY/
 /aN00AiZl+r2jG0H0QsvPSWh4C7xv7qc1un0ec1xTpHA4xQzjrJ6EVxfITicKXb2GP+LM
 /NLqTI2M015rvjNJ0jURAld6VTBtHtHm7If8P/PlHeDaVOPO9VtHtGn7LR6YYZ4ANuL6p
 /gFaIXZ1nGcB0pxJnMPELVCKzaPziEZipnFQ1jDm6tm0kcB7I8vSnlfpSSpTU9P4a1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=monstr.eu;
 dkim=pass header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b="Hc/gfi8H"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Hc/gfi8H
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F4778097B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:48:03 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c34bff61551so114605566b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1791798481; x=1792403281;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jFDaoWDsoI1zZRgDhIAIMFazbpPwuV7r2b8yWppzbXo=;
 b=Hc/gfi8HK7jhe1GvGIpDMF3KZ/c4q195NQkiReN9gcctqeQUq+zx3/qu6sQcL89j7q
 Al+xmmuBSfGfTc9KppoWq6tvnKfrjR9gTTlHWI1Me/hkrLxDI6+5mLfPPfirZ9LCQ09F
 aQO8yw82a1BTMFEe20KiF8QReDgLt4tWFQpVd0tjTkJTGdYHvoPh+5VRS+Hve1MxwZLD
 jwPmrbcip4dX/zwWf4cQMyHK3Kzix3ccRXd5gQ+3DwHAOk43DCzjnOg0ZRbAYBmnI148
 +65I8BQPCJzbYQgl9gatiYHeJAtVN8hnJk1mRFbhxFhUNhDKK0KwazY6/Zhm0E4NeFgC
 Ajdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791798481; x=1792403281;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jFDaoWDsoI1zZRgDhIAIMFazbpPwuV7r2b8yWppzbXo=;
 b=Z7HpIvqsvwZrxJUbJT87dnrw+RXXY2lZfml4I9jAMt67ifE4maQF8cSjKXTBDMPU6e
 EpKv+rjLXiC7Ze1zOtHDafwTlwdSv/L/1gFBiKahQuh+994gXL38PkU0WiLGrK1rrtyC
 rj75B/2w4m3YLZjAxZu6gshF+yoMFRj4Rl61I2Pfza2qf1yDBBXCJYz0iQw4uD96j7Gn
 GR1xWxWuQZcDE3hAY5t8ONsuwMcn0XZBZy91x9RTBg3CxGlR/eaI7fBtcPKVIkJk9Rar
 nEkDyHqHv/lr1k7Cff4cawPDM3rH8Sqd/yGWxx9/6DN6JtrosdnqdHkkTd4fMpE81lLX
 WjZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByUcl/3oGBI/HqyWpnm+b0cHSHbzMycONb53qxJwVvukZgpho4YnynIQmiryxTO2Nlz96hhfVw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIJAmQZhaO9cOgYqtTOEPsgnBOafgeALpaw08PR3ZNdXNbi/iSZ
 qUqU3ZSaEg6r3OIRaNKfOd+Mcim3UFZjaQg/lpdCn0mySd5tQG8MQXSOev5gs/pQPA==
X-Gm-Gg: AYBFou2rsGTSIj20VbVImaWMCEeGDmBlaJWYtZgPMAGVeHEWyAf1g4sEH8mt8yYEnq3
 REMFK7IIN8CRE7QPwea8YRUY6gTlFKTvwVtWK+DGhpP8s0wj4civjyaRMpI7XiB+ShoFsw3uCjV
 6VyYbZg+wgDTrtHhUyI+cs/K6trnytuNwezqmsRN19IYzB79ge4MyCaTwiHbycaN+yEdDN8BO8n
 IimX3NrVxm/ZQ7U9/QcY4n8LekbvZVh68LEc6Gv5Oi8lB2vJMUs62aPg3IVoep4k+I3KND0T6t3
 IAcylbkUn7H1YgchmGzIg99UE3YIrrioIMIkbAkydPjBsBY4oKf/cjGErzU8WePoDkzwUKU0Uon
 J79lLrev4cBpm+QHQhGJkYSJ6Lv1ryPfQb1SOpA6fDND+ZEOJwIr0s8pzwf/+UDNMiUjMXN1eqE
 v8At+Wy/UmM7V0YtlfaNmVpE2fBb2ZnnYUebCejuZpBmz5EvTTuRHUtGwn4htpAbnBl8UgmIw90
 WJEDFHWtOiwCgC1JH9MV/giq+qWIeoI
X-Received: by 2002:a17:907:c003:b0:c34:cf13:a92b with SMTP id
 a640c23a62f3a-c34cf13b42bmr209889266b.3.1791798481276; 
 Mon, 12 Oct 2026 02:48:01 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b1aaec1b9dsm1961908a12.0.2026.10.12.02.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 02:48:00 -0700 (PDT)
Message-ID: <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
Date: Mon, 12 Oct 2026 11:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
To: Charles Perry <charles.perry@microchip.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Paul Walmsley <pjw@kernel.org>
Cc: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20260902141744.2422566-1-charles.perry@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi, +Paul

first of all do not use mailing list on denx.de.

On 9/2/26 16:17, Charles Perry wrote:
> Hello,
> 
> This series adds support for RISC-V Platform Management Interface (RPMI) to
> U-Boot. RPMI is an OS-agnostic protocol for communication between an
> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
> goals and purpose of RPMI are similar to ARM's SCMI.
I have raised my concern at riscv minisummit at LPC and also talked to Paul 
(riscv kernel maintainer) that this is not the right way to go. We already have 
SCMI and there is no reason to introduce RPMI when it is said it is serving the 
same purpose.

R is for risc-v. It means it is not cpu neutral platform management interface as 
was positioned. It has less features then scmi. We have risc-v in programmable 
logic and scmi server for platform management which service ARM cores too. There 
is only SMC transport layer which is ARM specific. The rest is completely soc 
neutral.

I don't know history around it but make no sense to me to introduce it at all.

Thanks,
Michal
