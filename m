Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D46BCD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 18:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EC884119;
	Sun, 21 Jun 2026 20:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="de1pUoi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E21AF84873; Sun, 21 Jun 2026 20:24:15 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D307A84105
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 20:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso51694045e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782066251; x=1782671051; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ke/D8LFXH+saB1wOVMRmShWCCLK3JrUdppEb+yYbQho=;
 b=de1pUoi6M/Y2mdI5YeyvE0e5XPpaXxMIbhxARGNVE5ytXDdk+0MijueeH6m0/VXcd2
 kTCpBDy0IJAKnSfUdPi8kI/gGAg/6pyJo4QSkekDaCtIHXGYrldqko8lR8KPulcCFacP
 h19/5cSekJOcnL6t2Z/x72Toqp0aHaYtr3wQyr2KN6gtsUUQvlqxNCNxlRArzvXi/F3p
 fMyteghyrhzimPj3Y8MPsKN8CZ26vDVQ1SspGsoMLSzHykemgfXUbwEHzogvRNfxDdVH
 F6wwzDUXxtosLFQPBe5/bowkFbbzHYyJ09WdgmnIZTalqT06ib3pGS/9K3K/b7c7n7T0
 2SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782066251; x=1782671051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ke/D8LFXH+saB1wOVMRmShWCCLK3JrUdppEb+yYbQho=;
 b=fL0qait7faE3HG5TdG70WSocFbBy/eC95TP9omypDbAH7oHicxkDGieenI4ZaV/mBe
 SIFyPp7fdcW935LCwfnsodWE+IR2WTqap79MYCNxRs+2Vnl3JNHi3BP3D2Rw3q+AYmsR
 27Q6nlpn5d7u+FXE9ikXuw2QyYTTOj7AMCN+V12XAH853u4zdUAvvUMGwNkRsgyzxMMa
 Ph6P3OriVZx1AzC4xpj+MeQHXkDJlvLp4MVRj2TYL5dZxJ4lX69eHEgF2buxtoeUFfge
 YuMCUZ5U1mc3TlOG+lrJ8+1S1C5zBqVUcfCw6qHo6jyboQpBikRJzRrQ3+b6ryfcDsG7
 0Fag==
X-Forwarded-Encrypted: i=1;
 AFNElJ9M5soSMWb7Ml3SWq0/vf+4hMMk4Bgj8VBNsxxaRZivRUbSjgY5WG/f1Nb1MpwZkCGyPsuNDJE=@lists.denx.de
X-Gm-Message-State: AOJu0YwAuYjWK2/2uoxTJJBoaj/gKLp2Ghmr8GyTeon9k+bKMkbKRIVO
 nS0txKLLXnJwtrgu8XjPwZK9+XrqkKKYrPl8+BgwrReZxwVxDDFW6pjsByDQWmRN7XM=
X-Gm-Gg: AfdE7cmpYbdJ38yc4AF7zUFU55rmhwDnI1Gag00xc2ebYYbZDLuYssJCgjI7lIafvYr
 oZT3qFwonoD1t17QIgPAoWD+Qs+eoUvkxVvwXFNyl4elvoNPbqCS1h7NPAFc4tVZOk5tRJRX8yv
 uvmn2tp7nIcBlWoEYexL2dgOD/vsyIE43wkidm2ZHg8mBle0L/LfkExwxr4EMFelIC5hbwbWR+2
 pBnczPG589TT77ZEP+MNSeMKL+D3tnCyOmZa434o4n+BnWtMlFaGZTgqaF7vrAU1X0vuShYSuNv
 sttjUrhlfLfFcZBPVA9E77dtsDT14JB8zBBj/slnz+8RhhD/x4bJ2mVHkMDkrV4I65+dJQEhcUF
 q9mMmptj36QcMeo4njE7TInSd+gfZ+DSBDj1qOQ0fH09I1HFoxRKWyrlsK4wey++Iefh59ePPvm
 JQcu1V0rdfQS5bKZ7JcFH8BKeU3cbiIUHOB8ljRb6xWwoi5NlhK9vqF8GiQRFDbqLp
X-Received: by 2002:a05:600c:6812:b0:492:4ed1:77cf with SMTP id
 5b1f17b1804b1-4924ed885d6mr69258135e9.11.1782066251189; 
 Sun, 21 Jun 2026 11:24:11 -0700 (PDT)
Received: from [192.168.1.36] (p5b29eb88.dip0.t-ipconnect.de. [91.41.235.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fcdd08esm145480705e9.0.2026.06.21.11.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2026 11:24:08 -0700 (PDT)
Message-ID: <83df1770-1f27-4f06-a56e-a343c255b0e9@linaro.org>
Date: Sun, 21 Jun 2026 20:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] board: qualcomm: phone: enable
 CMD_FASTBOOT_ABORT_KEYED
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Sam Day <me@samcday.com>
References: <20260619-fastboot-abort-keyed-v2-0-684e53949a42@samcday.com>
 <20260619-fastboot-abort-keyed-v2-2-684e53949a42@samcday.com>
 <871pe2hbgx.fsf@kernel.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <871pe2hbgx.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 19/06/2026 16:05, Mattijs Korpershoek wrote:
> Hi Sam,
> 
> Thank you for the patch.
> 
> On Fri, Jun 19, 2026 at 09:55, Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org> wrote:
> 
>> From: Sam Day <me@samcday.com>
>>
>> Thus users are able to exit from fastboot by pressing a key.
>>
>> It's also possible to bail out by running `fastboot continue` from the
>> host, but it's nice to be consistent with UMS. Also convenient to be
>> able to bailout during testing if USB isn't working properly.
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: Sam Day <me@samcday.com>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 
> Casey, can I take this through my tree (along with the fastboot patch) ?

Yeah feel free! Thanks
> 

-- 
// Casey (she/her)

