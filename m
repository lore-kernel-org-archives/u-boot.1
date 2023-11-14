Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5FAC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF73D87225;
	Tue, 14 Nov 2023 14:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRDJuzEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96388871D0; Tue, 14 Nov 2023 14:30:37 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C1687282
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-778925998cbso374267185a.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699968634; x=1700573434; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nLupilAb9rNNHrtCKPuOTn5Wg1KWpOzY/WpkScq3tCA=;
 b=BRDJuzEfL6SyT8/beZiFJgX42msKEFNCs7AX/nFqkTIuYmwoDRhEGlpAoSim4y95CA
 d+13AiwL/oyCNXYFekB6i5HvcwnPVMZpXovcztPKv4qJ6mjdFkKgCGbIgcQU/WhNqb/X
 6MT2TuMyYzCypDv0WaO3kqgXbtWDBE7PlJ2BdFkQ587xttOq79gUbbDi8Zm+nVCqSrPC
 Ykk/gC2zu2bARQ/2MO55ITLr1Lgl24eh7ec/cAAZLES53J1wxilnah0JHIdeUrWLiZP3
 pjmpPifenR2uTVmFxTy8JVPlRrP2jDtleZGB1UMj2WayRr3G4hFjKQr2llv5+x3YnPkY
 9hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699968634; x=1700573434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nLupilAb9rNNHrtCKPuOTn5Wg1KWpOzY/WpkScq3tCA=;
 b=XCll4TEhRNcRhU8N4G3Ns0cEC08lqr11JY+W0jciHbkMRoVickBAv9r2tplQDKBc6l
 W2IxlXWxppnS+5+kVYfBwx7qY/lq36l9YWEaX4CkMjXX2hko/bukIcM2aSNK2Hp5tPV9
 ZH4orv9GAO8fKSo5uzlJe2Kxmc31eRzokwHtv2+QLakUfcweHXb/z59foNayxkFJ5krS
 xOGH6OlbP849oCf0iHd1TYDhDVLRuUkAnweFFLOzYZcbGhGbe2QC4kVhSqnWa19cTFga
 MZ9YxqCZbshWpjHdkpU9aTcS4LFx4XxUbQXcpkOycVaeqzAtFNwjs1VrQoUtSNJS+uMM
 uTYg==
X-Gm-Message-State: AOJu0Yyq+ZiscEqSTQ0rtJOZgdJME3vp8TRkBf9yM67sfnYuBc9TlVf0
 B1YBgzUyhuHDA5dJv671EjlNJD3L6DI=
X-Google-Smtp-Source: AGHT+IG+hvSSRtNFJdHVrMiUiX+QajHeWFzd9A0uog0GCmp+pQlF+ozd1M6LdB4WAbUouFrfsn+Lpg==
X-Received: by 2002:a05:620a:f06:b0:77b:d6ab:7107 with SMTP id
 v6-20020a05620a0f0600b0077bd6ab7107mr2529699qkl.70.1699968634186; 
 Tue, 14 Nov 2023 05:30:34 -0800 (PST)
Received: from [192.168.1.63] (c-71-62-146-134.hsd1.va.comcast.net.
 [71.62.146.134]) by smtp.gmail.com with ESMTPSA id
 u8-20020a05620a022800b00767da9b6ae9sm2148828qkm.11.2023.11.14.05.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 05:30:33 -0800 (PST)
Message-ID: <b99a114b-2715-2cba-cb0f-0dfafd32c29d@gmail.com>
Date: Tue, 14 Nov 2023 08:30:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: U-Booters at LPC
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <ca3435b5-25de-727d-ca46-a88a234f9fc5@gmail.com>
 <CAPnjgZ1eCwAg=i27Kkd0mk7PeR8Eu_955utAjBfkNrMvKZyUgw@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ1eCwAg=i27Kkd0mk7PeR8Eu_955utAjBfkNrMvKZyUgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Simon,

On 11/13/23 15:26, Simon Glass wrote:
> Hi Sean,
> 
> On Mon, 13 Nov 2023 at 11:15, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> Hi All,
>>
>> I'm at LPC this week, and I'd love to chat with anyone else who's there
>> in person.
> 
> That would be good, but sadly I am not :-(

Ah, well, there's always more conferences. Maybe EOSS next year?

--Sean
