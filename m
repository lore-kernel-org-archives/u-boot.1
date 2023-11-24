Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBE4C61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 18:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD6D87627;
	Fri, 24 Nov 2023 19:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="We76dDF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDB987457; Fri, 24 Nov 2023 19:15:09 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BA487457
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 19:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77d60604cebso116363785a.2
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 10:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700849705; x=1701454505; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KX+ktCFthY99sgKmY+mtA8sZyvzdBOMlG9Fc7RVM2KM=;
 b=We76dDF6phzAM+YmRNiDEog5DetdjSTgRuHce5Kio9ySqPBr8s4QsU4p47iE3nmRCG
 Epb9zGBR8HlFAeEZTZl59oG5mPVOYGQZIwwCRBRrR6HbGSxAXiKoEdWCb4jii+OF3eT/
 RQtpksk9F4WcB/OEOq7HhpzSuPiy2KrtBoliECHs1wzZ9PLHuWZ3iQMHgnGaK5Fgkbdm
 KUgUtCuupjAWHLiHsM0Ym/wpetfHi+qJUYhelUjE6Y6QU1ObGfGEPNGZJ+Wg+EUA6zk0
 bXVLryARbyR8r5d0FS7UZOW05sVvfP58Xe0lBkUfgmNp3HWSJye5QXDxpPqqRBjYfkhS
 BZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700849705; x=1701454505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KX+ktCFthY99sgKmY+mtA8sZyvzdBOMlG9Fc7RVM2KM=;
 b=TXym2RuX1+WSD8N0NZSSZ82/hChC9VMOzG0a95uuvl4pyY+X2l/SdzBPzwq9uMB0v4
 0bd6GuFD4r84B58dC4Z2z8pGXSOoqrfKAhEHoVplqMLCIuummo+BulwVA78+5rujCkyu
 kjkv2XNEGqHp7a4Kqk134DkCY60Rn18r0AUgXaXHAhwfqz/cLp4K+MO7Yg5cqjIAfats
 Z6AVjQWO7q1rQShV2LQkRCB8BTUI1UV46Gy7vFcgixJffpQK+B3P4Eo+kqdOleRjkDga
 fEWf0Uy18YKcUJd6LoNvuiRZsugZpZoHti97jCd+xxQQk4SrRdBE1ztbGy/i9g64Pf+D
 erJg==
X-Gm-Message-State: AOJu0Yxr/0IEtDZNIasgh8Df7AqDjX9zWdAkt6uEPnwflb4mz3ka3b8F
 lRXNOFNtWCC8ca6YND5ORk4=
X-Google-Smtp-Source: AGHT+IFRr+RfPtEtbwaP+269MsjTeLAUCA39PATFtCXayM8a2Qsx4+fl+IX+ehgrXPNdjCoM5bjvZw==
X-Received: by 2002:a05:620a:63c3:b0:77d:6626:f08a with SMTP id
 pw3-20020a05620a63c300b0077d6626f08amr4725389qkn.52.1700849705235; 
 Fri, 24 Nov 2023 10:15:05 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 dv16-20020a05620a1b9000b0077d85d22e89sm242800qkb.63.2023.11.24.10.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 10:15:04 -0800 (PST)
Message-ID: <18d425c8-db8f-8e97-1c59-4febb57aeeb8@gmail.com>
Date: Fri, 24 Nov 2023 13:15:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: U-Booters at LPC
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <ca3435b5-25de-727d-ca46-a88a234f9fc5@gmail.com>
 <CAPnjgZ1eCwAg=i27Kkd0mk7PeR8Eu_955utAjBfkNrMvKZyUgw@mail.gmail.com>
 <b99a114b-2715-2cba-cb0f-0dfafd32c29d@gmail.com>
 <CAPnjgZ2t3RiCUjxknrPRqxEcEJtCcPOL=PGN6uuaVRJiWDQ3hA@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ2t3RiCUjxknrPRqxEcEJtCcPOL=PGN6uuaVRJiWDQ3hA@mail.gmail.com>
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

On 11/21/23 17:11, Simon Glass wrote:
> Hi Sean,
> 
> On Tue, 14 Nov 2023 at 06:30, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> Hi Simon,
>>
>> On 11/13/23 15:26, Simon Glass wrote:
>>> Hi Sean,
>>>
>>> On Mon, 13 Nov 2023 at 11:15, Sean Anderson <seanga2@gmail.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> I'm at LPC this week, and I'd love to chat with anyone else who's there
>>>> in person.
>>>
>>> That would be good, but sadly I am not :-(
>>
>> Ah, well, there's always more conferences. Maybe EOSS next year?
> 
> I hope...I might have a lot going on in April...when does the CFP open/close?

December 3... so in a week (!)

https://events.linuxfoundation.org/one-summit-north-america/program/cfp/

--Sean

