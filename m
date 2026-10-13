Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61522CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DB7980D9D;
	Tue, 13 Oct 2026 10:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Tr5OWuMpymU; Tue, 13 Oct 2026 10:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8602C80D8F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887637;
	b=W7onB92mea69yUtH6tH1lDAD2nj54XRF+Bws1p/S/CByxnPd5PwltKFrPdz99aMSkAEQ
	 B+4+nDPIG0VDnt04ISkxmaIC+6greiqBayO2CbHr+BrGHCFHrldtgGOZNpDVNv9Sthmi9
	 e2OuTMjZs87EJsjyniqbr97aEqBgcM5cqzBgDgVr3UKkIVeveeT65Q6XOpovqcOQlR8st
	 onnYbQQTDZHPwqehrdPm+Eo9MQjloy+gnjnUQTKfS1rgNCESh0o0aHAD4WqFyZIVZIyXq
	 4dQG94LPYcwuDgJ9UdwCzpMqLUvGb6/sb3Ooe73QRa/gCohp0sAgTRYrnFl8J7aYqBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791887637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8yOl7OQVTqCbuFyqmDla9Y5Tl/mZeG9xqRn7jHlXqaE=;
	b=K41R7HShU94RazUZgekx7o9Faq8Zkmy+p0PcU75Xfu5coAILI8XSyKTq5PhVLYjYsoGK
	 SlIYodGo7MBQ1lukmFgMI6FmD63I25NxY6+5z3ScUA4zXOP//4b43gfVbp0km2LY5Tly/
	 /eOEFRDDMXzhs9ueNsjfFw/sPT9MVO+kUrJ+boEqb5AFuGQev28hEPPRqTLNT6r7VgyPW
	 SsYhuSJplBe9OOwW+tGMCWB4R+KYkQObB6yoEslSXv5AA6P5r1e5XwS8Q8v2zFi3VHTKO
	 y7ttRiu+EgpyiZ6AYy7ryQ4Z3lYf1Kl2GOgT6toFQtOHlqHNci4p79xJguxfCF853Ew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791887637;
	bh=8yOl7OQVTqCbuFyqmDla9Y5Tl/mZeG9xqRn7jHlXqaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=onYtCa002OMPmIV61lPxR22VXfDXf98KNuD90kt7x/KL9qPeFNl9FuIg7tmjKAB//
	 MQDwhOo3sw9ft942gwQc5p/jLBKj20+2WzQUiw6wNUaA/kh1bA/Mk8rx4CHGYQdIIW
	 TqIAJThH1hFZ0cmWIUvCs7Mzwgz0scEVCE2knpAmeqQHCn08PKInLkRSCYC0eD9vHE
	 KD5BtRsYvCcqmodE0nuejvlZnK87kYBh/WJTSxE8V4oPQMVYzBapgtlEBzJn8dHzK7
	 GD1j4TYJLBY9OO583CN8ctk6q12gJwJtY0ZtYyOCkwmNhMiBNRjDxvU4PfTx4c1S9/
	 8hikJ0MW9Vnxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8602C80D8F;
	Tue, 13 Oct 2026 10:33:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1204A58
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B75714027A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l0IxJOOXIV0Y for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:33:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4C4A240277
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791887634;
 b=aQnDM+GQoKSCqDd5VCUDecWEdC3DfLPksO9xjwfxVZmgnYShRtaHYVNPgHo3cdg1MvIB
 WiJ16fNoIpHJ2QUG1CeqmOYyUqTnb24ZdzHNTuPJMy/CXvn/D66IzJjPt86JPLmVSAnQx
 1F2CSYrKhskUq9AKWVwjBPrB8CIKq3AeH9R+MczAMtwE2PzMNcgOsIL7ml0Fq+hESF/Jv
 yS4axuoSEn5ggcBgV6W4UPAJe/lbzeGh2Sc39L/fpZbSqCwqJd1LaLIKVFlkgSDNsR20X
 ohezY83fN4BPMdbscQVA5Sxtip1B6rA2cTlNyra7d7uXhX0u5S1XOe75Q5VkuYAFxVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791887634;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=8yOl7OQVTqCbuFyqmDla9Y5Tl/mZeG9xqRn7jHlXqaE=;
 b=UZlb/fS8gBxsgrx3BPLcBSUUZrnG13S7+J4P424niKUUZsyk5e3rUdOZmY6hjI17w67Z
 M/vegNPFPJH8vhjEkTQ/xJtUyQTb4r5oE6ZT+3YpcNqB22N9aQNLJJpdH2kQlE2enhHbr
 yzVhe0p/KfAFmQ9TS7oNyA61suuCLk1n+Cm411qm+bJUZ9+mer3kfFUDOe4FTftpYBZO7
 wQ2URlVjqD4IsT2XayY2g4BWyOMw74W7ANU8hH5m1Ci6jxZQlAzHaWwQJgi4efOqQds80
 0eAzASh82GrUcQybjIPB+VNxxGe8VVSwX3SryiZ9vPXhLvn+10/uEluNa1/CTV46ViQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=e1LK0UQ4; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=e1LK0UQ4
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C4A240277
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:33:53 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C98DC3F323
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791887630;
 bh=8yOl7OQVTqCbuFyqmDla9Y5Tl/mZeG9xqRn7jHlXqaE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=e1LK0UQ4YrZTl3L38b/J16c3WQ4Op1LnQdbCAZQQaMPkA4UfRyPd+SRO+60sQw0se
 a0XV2ODS8+7SP5UcyXzZSMnuKjUVkD84V1Yv2FkvlIyKWSMdwqbXMwtPz1MVL2v/tB
 w1UwacMXxUJ9r288fAxFlIggHoIeFsyeqKbilKYltj7TbcmVHMjlTuMNNQBM0WLROh
 y9kO3boSzZgPGUSmgvFkyl/ChcbSpq7qbRWiKJp6BBTgi0FcYta6SJZSgUFLME15rq
 7d/ziJPgjB2k5EqRpy+bIY+uYeGnP+yfOTY/Sv/rCbxZ+b6Conjvj7cda2/Rt/GyV2
 drIEAZgbyK8wu69esVJtZeyKD0v59ElylZoGnDtmHvuO3HCC8skP3PnyI4X+f5pDl6
 oqsKHjPYYMXyLxagaOvtgcG1xxEAXpl8X4P9jwLZ9trgwBRZ76zC6qEbYSED7/S1qg
 QwJZL68mxx4k18MyCjAefy8cK274ilk7LBoip6ijFaNmLizw5oABxXae7roqs32x6a
 MaFNjQaxhjWaIQl/3MagGnwqY917kYU4JSl9gpWuE+DJlwzUacbHifkqY4+AgK0yuc
 MPkfGoZkp2G0RsQe+WbPU1pEF4qK2vj8tR1FKlBlpdnszg3v74QdekP98NBM4sZKDP
 J65K6lxjbw6HnQGG1TQWd+mw=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4887e5afd67so2268318f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887630; x=1792492430;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8yOl7OQVTqCbuFyqmDla9Y5Tl/mZeG9xqRn7jHlXqaE=;
 b=d4s4Usdkz7+dSD+jwrbhrJRIyJoKXhQURwWLbIjkXaf0MVbqKjTCVqgTbNjf0zdivJ
 L5A4Ma1WelCNB1WkjBos7iaKf/B4L4cpBB6aXpC8b/YKJvNBb5IwmJh7htj+4GlBkmCJ
 Tp/p3nhqZXjrryDjGSgvVOGxnyWvqVvKosLKCY4KWm0Fzw6vstfFs5FmOvaa94gyEOAC
 JcrZsiVOikRGOu98nLoZKZOf/R4B8Hn89RBgHDCjcAgjJm+JVo7YQIIh/QieiOQKlCK+
 PiQ4gYTHKYYQcDPbZe1GuI+L0M3M6vkzWomPtyRl9iVQLKR261dHWtgPgV9JcUge3ooZ
 dpJQ==
X-Gm-Message-State: AFq9FYKSN8B0l9Q3lcY/IQqIvIPGf5xNBaFeb3wWJ39Y6P+heRLLLfLB
 ewh+dxugDEkUdeQGvfFviLG1Ak3NfIR+fZqJvU124ULjfWBwUoYy+8WNuAW9lxFNTpqycCzEOf5
 0Epa5PBFnrHa3tt9UFASJcmmssrtcL/cZXrGa55Md4sV6qQAXxcdPyN3m6uG6LG8QpBR/ZfYlNV
 IZGxFj61Otwg==
X-Gm-Gg: AYBFou27QRV5+trmWgdwuWWbAEkoJ/adG0vOICldWHcPa+7F0n1+zOZVB1pPpQ4zVjS
 mSsNqeu1ttxKxMmviDcdMg0gDW5zScKGiZKfOZ1a+FOgP6Hakc2t2RVDNGjw29o5JjxU3gT+Zj8
 /HHwhsOiS0/IU50JBfqut5jS9m77bBLvt2XLoTLCwN/ft8hPF1AeJdbv4Ix6Mxn70CIBjblmrpH
 Guyrg5Rhokk6uJUecvm2UW88QRzR+y+1cEeb/4TiP/coHMpcII3EzNqO47QnOA8rVGbNQ2OdJ6+
 4UyKHdiw7bg7WVMeFBMHjTCi3qdWHbuPdxFn9nR6FKUTWjqI75Ny6jIZkH6XRmBwI8LVmiFAjua
 aM43+l2K8EIAnPKrz1GBZ6LmHFLEnlAslWaLrgG7L8jUlmBFDL2DPPH+JFXhBgFi4LjTjGCDJtO
 mPBcmbA/B5rhRSr+GFK6SHqJ8=
X-Received: by 2002:a05:6000:491c:b0:486:e6a2:2d7c with SMTP id
 ffacd0b85a97d-48dba9dacebmr23002741f8f.15.1791887630370; 
 Tue, 13 Oct 2026 03:33:50 -0700 (PDT)
X-Received: by 2002:a05:6000:491c:b0:486:e6a2:2d7c with SMTP id
 ffacd0b85a97d-48dba9dacebmr23002695f8f.15.1791887629968; 
 Tue, 13 Oct 2026 03:33:49 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:74c2:18b4:3225:49fc?
 ([2a02:908:1242:30e0:74c2:18b4:3225:49fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc6b82sm4414338f8f.51.2026.10.13.03.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:33:48 -0700 (PDT)
Message-ID: <442ea702-451e-435a-8b04-543750e929e6@canonical.com>
Date: Tue, 13 Oct 2026 12:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
To: Michal Simek <michal.simek@amd.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Paul Walmsley <pjw@kernel.org>, Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Conor Dooley <conor@kernel.org>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Charles Perry <charles.perry@microchip.com>, Michal Simek <monstr@monstr.eu>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
 <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
 <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
 <a83ccf7e-87ee-4c78-80d9-86dc0b246491@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <a83ccf7e-87ee-4c78-80d9-86dc0b246491@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/13/26 08:49, Michal Simek wrote:
> 
> 
> On 10/13/26 01:55, Charles Perry wrote:
>> On Mon, Oct 12, 2026 at 11:47:51AM +0200, Michal Simek wrote:
>>> Hi, +Paul
>>
>> Hello Michal,
>>
>>>
>>> first of all do not use mailing list on denx.de.
>>
>> Ok, I sent this series at around the time U-Boot changed to
>> u-boot@lists.u-boot-project.org. Sorry for that.
>>
>>>
>>> On 9/2/26 16:17, Charles Perry wrote:
>>>> Hello,
>>>>
>>>> This series adds support for RISC-V Platform Management Interface 
>>>> (RPMI) to
>>>> U-Boot. RPMI is an OS-agnostic protocol for communication between an
>>>> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. 
>>>> The
>>>> goals and purpose of RPMI are similar to ARM's SCMI.
>>> I have raised my concern at riscv minisummit at LPC and also talked 
>>> to Paul
>>> (riscv kernel maintainer) that this is not the right way to go. We 
>>> already
>>> have SCMI and there is no reason to introduce RPMI when it is said it is
>>> serving the same purpose.
>>
>> Cool! Thanks for bringing this topic to LPC!
>>
>> That being said, I don't understand why we can't have both SCMI and RPMI.
>> For sure its more code to maintain, but there are other things at play 
>> than
>> just the functionnality. We discussed this in v2 [1], the points of
>> contention were:
>>
>>   * Anup said that the main blocker for him is that the SCMI spec is not
>>     community driven while RPMI is.
> 
> Based on my information none really starts to talk to ARM about SCMI and 
> this has been introduced serving the same purpose. None should introduce 
> another interface which does the same thing. That never was the right 
> way to go.
> 
> Thanks,
> Michal

Hello Michal,

RPMI is already used in the Linux kernel since 2025.

U-Boot has already lot of alternative interfaces implemented:

* Xen and QEMU/KVM
* half a dozen file systems
* MBR and GPT
* FIT images and UEFI

I can't see anything special about RPMI.

As nobody, including you, seems to be interested in driving a discussion 
with ARM which would set back RISC-V for months or years, we should 
proceed implementing what is needed.
	
Best regards

Heinrich
