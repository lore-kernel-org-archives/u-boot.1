Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285BAC79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 07:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 381F74062A;
	Sun,  6 Sep 2026 07:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5KF866gqxeNM; Sun,  6 Sep 2026 07:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6B7994061A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788678523;
	b=Esh7cmnRueG/Clqd7Klgk9Y2+wT1HQYFR2EJX8ryDB/hQi/M162hf2m7+qX5IxNfZgxf
	 o33jIcUZzS9TB4MBLuvqFSogS9Oss0HNTqZSSlSzmHjSnrdhAW4A8nAfvqZrIfUMkypCU
	 vIKO8PVoVVePtmDqKvCDvIJafVVgklF21FhPdONJyIXOlsK3jrN/PPAeEr3OXD45Pxa3V
	 5m9IVEiKbUojp40U2wGiOU0NW1xEYeohgE+e3Lc2Yj9Jhho2WOlVVgpNr7RdmZ7Y0aiVX
	 tTBOJJkFuT+dKc/7HSUfhhhJFvmgSqBLCSif1AMwNvoQtecTDwom+C3HmHyPuFbuFBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788678523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NllS5XrPywBPr9O6xnOMnLpy6RzObXoRz8uM+0c2AiY=;
	b=Okm8ODzUQXRzBKXJfqT11253avtBR5SUitnfYcvxF7AjcYtQtdY4nuVrKtvpruo62RrU
	 7ZtY1o7T/PXui7ycf8HW/cJki8YUzXVBJ5IQUtscmlDrjYgQ0/Cs6PAZgzA+IAg6reyKc
	 Fs5wuphFTmkQCd7cAMDm8NL4Xy67eMDTEKmFrjF8CdtTVhQZhatx4/chm/P7kNN/3fOu3
	 bYRMpxDg50emLuNtLTgmnIOqMg9K6D5qSPI7OyKH8H+iTasdzE+w2SW4uoMzheIZZcGeW
	 cdBoITbHv/zoSUpZpO9Ut+7SPMUwFbfUB2srtajqshGxWUzegtjCwZaS0o3R+rpbvlQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=suV7ln5M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788678523;
	bh=NllS5XrPywBPr9O6xnOMnLpy6RzObXoRz8uM+0c2AiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJIbELRTDWBiOi+DvA95mCAUqssJ42DVCHUy844Bppod8k4k5qkoKMG7nzuZh4lhP
	 AKq7dgytKgEnX0iifauC7FLPFiLj6D9mHg64AiV4KbaDDrbkaV06w0D/YwlGeTiHGj
	 GIaSXdg+X1ktzEkbYSmKd6UWD5EhWeQPXwOu7SKJiP+O/Xsx53YC4RVkFkr6D7gOzw
	 CBbOSlQUDRyyFIJd1xVDwQpWT65r3uSF8yCCFHelhH3r/HgOA1iyorwBRSexTbweRe
	 qtC/zatEV/vDCK1aeE+cIGvXdHDlLJbU0Y/+PwGgkGZdwF3L4rskL0d9pjMok4lz/C
	 olTldnmqdIyxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B7994061A;
	Sun,  6 Sep 2026 07:08:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C2EBB88
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 13:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 828BA40BE5
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 13:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id li4KxiB-R2QZ for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 13:34:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6FB7940BD6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788615250;
 b=O3CzVcnQ9GDllcCxJ3ma/1fPkaAT8w+cIm8oWDes7475m1knhV3n9jQpWCOKza0E5Jsv
 rVfKe087p1jdtKpH5CPfUWzVtNNm6CcF7cJVs/uKZDONDfpehW6NkPtZH0PlhR7Xp+eyE
 5Rry0hUjtaaYsM6zbs2BF+onrGRZ1Od4Pbwd5BcW/KS3sfdTnll9UG9DW57tfvp0VhIr1
 RgrKbWkK5UOvlO/geX3Y8clepv5j2T9oioHQvd06YECkGX4MPvoHJinHjkFAlTWerhcbA
 qjy+p7sU+0I0WZAO/FYRE43DgxUnQ8RsHidtYDF7sTs8RihZNuWlgC0h4k9vzL1batg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788615250;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=NllS5XrPywBPr9O6xnOMnLpy6RzObXoRz8uM+0c2AiY=;
 b=pn3O2OQe0PWwx5LTK63ljOKUj1gNwSZLIT8g1PztWHmBwViq3OYG90rzxuQQfmG6Z7+h
 JWxJSM3o4G/67Md1f2bkNpPPX/D103JeZDm2hJTv2bnpMHtAXnTw3VByqBSOgABLCvkkN
 wIBdYyvrYYmfHhUOLboge9pPm+G3BKsyHqw2qxB3k9BRuWCWjIYepPzDN26EQvDdNk+24
 kfH31HghbkyZttE2jEAqxgFGomuGTb6nmYWv7aPJQZSWBx2gKC1/MhG9HbH5pw5wTe4dV
 FmG2G3z5uPVcMMqRxgi0Y5bZApYunpi0Sfx/pqN89TrqxMx3pxDYAZEw/dbIW+foH5g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=suV7ln5M; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=suV7ln5M
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FB7940BD6
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 13:34:09 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so22599715e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788615247; x=1789220047;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NllS5XrPywBPr9O6xnOMnLpy6RzObXoRz8uM+0c2AiY=;
 b=suV7ln5M3aa+oJ6bcwmJEmFKIBKkS/gl8QGeFg90+iATTowCSnvSlav6H0ZIbfiP3t
 nGM42qkU/hh9Jme/GO1V0RSozY1ygfYwSgTJ3HZPodHeY3mrIOjF7LvHutHVpk5lQily
 V00ZFFI+9RJ2+aGbirk1Lkn12KyC6IBr36mk+lhy0UWWhwBdUYd2BUV9jJXfhiMo7hDI
 1WvHNewWl5+UkZFGThyZTyXer2MZgtXB7uHR3j3in+l6NpaU+mSmvXj8GfrUjQmB7AEm
 v/MWwdHLO+m/v16yqWgtWKjD/3p92dnUWtByep4G7rrMgMwa2BCsm/dL9JeQd1VkY7SP
 SZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788615247; x=1789220047;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NllS5XrPywBPr9O6xnOMnLpy6RzObXoRz8uM+0c2AiY=;
 b=SE//OzBq5GKYSiUD4eQaMjMOUA/PHpMd219SIusjr8hS2AIWrh8Tgym1BrXBPHUQnr
 1Vw546xWG9zOPSHk8fdMnw7bLIUkaag8AAt4LReyUAqLpoMche1WwguhA8en1MS37nSn
 75YTrdz2ihbaDh3X4t8V0K9WKEdWzWPs8WXPVxq+2VFO/JJGCdX5dg9de604fqx+Nga/
 5JnGrpOkFOSBVBkI5bmnpgqwTMQIJA4f7WTfkerkYciGXTTsUC3fW3y5wXQWzFzToeaR
 PdOAlcnFwGiEtZYx8hu/WkFtTXFEXrnRObmM6fEmRi5NXs9GzY+mdZAuQeWxrx2JQozB
 FNLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEHShRBt/jpPCf0rqf46i1W+v8cazjqdrq8Z8w63KLrzxltAnTCcXGb8W6M7kCYHjWIUz0eG4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nDeSEL9YowHhi0iTM277/+WJXZgkGHGSLSRRVXlwuRxIh0LfYs
 cWgo03FAZemo3s5MeHy3EMg6mzZKQQJ69uP4IOrD9e502WXwFf4Ba2uBap0OGg==
X-Gm-Gg: AYBFou1e+A9ms/WAxlxAMfSOJIL6+NBmZDTOEU0BNk5ITphjYZUsTQwoXFJJ+hKacl/
 gNmSx0FLpYJEsV3EYk4tntfY64PIuJ//iQblwKrpFrJ2/3rXr5hbBOIsibh2sLcbqtyRSCTWx/l
 gdfZmSC6iIP8dJi6DCgzaqqwnqq6AhpAEtuIOCQH15rSnc5+B7mBxH1QO/A5+MRUUjy6umyeqPo
 FhhzEOrdi+68zx+QYziXwGhKwTh2IjF/ipPuaViUdfsUBaIjk6c4Y5jevIhOKMPAfPbzcXCsoi8
 zbysm8wFh+aLc/pGOehGSsXKGOhrrSsujE3heWQgS7ICR6dKEjYi96H+eFo0qdm/cQPPVB68v4A
 G7381t6Pbo7n7iqk7XSMdeF1InYsbX+6DEL5nVkeXGToyhM8NUI2fl7M5Eh2amSK/WPWozPQ2TV
 ysMnvBo4+mTIyLF4oQo4soddLxun6vysI0+XN4n7oAXpNsoUi4OI4twx7vmclKlaN8GCiVgF6H6
 toXZ0I9KwtLdZ6LNMKrz1/1xD1NlDu0YysC0jdGIGHXACTCSrXvjB9uvpzoYATq06YbwipXVgnL
 BgTRvvtRqzCBq0xUZvKzg2PGb8T0UyQ/sUp5L9HGTq/OvFXCryEtdDq44rX+OFu6SSD2
X-Received: by 2002:a05:600c:35c3:b0:49c:fc6c:be10 with SMTP id
 5b1f17b1804b1-49cfc6cc055mr94296535e9.22.1788615246984; 
 Sat, 05 Sep 2026 06:34:06 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:1d0d:b738:33a6:feb6?
 (2a02-8388-e6ca-5780-1d0d-b738-33a6-feb6.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:1d0d:b738:33a6:feb6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7740d44sm325050175e9.15.2026.09.05.06.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2026 06:34:06 -0700 (PDT)
Message-ID: <d7eea776-10b6-46ff-89ff-19d7e25894e1@gmail.com>
Date: Sat, 5 Sep 2026 15:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260822091510.3253162-1-andrey.lalaev@gmail.com> <ao2Iqsq-Xp4dQK4c@hiagonb>
 <e3ac37d0-be2a-470a-aaa1-0cdcb3b7b45b@gmail.com> <apA3hSs_P_NYkOCM@hiagonb>
 <638029f8-37a7-46e9-aa3e-9defe840c639@gmail.com>
 <fc19ff71-06ec-4bae-8684-9c6f1e6be5a0@gmail.com> <apsphFWUeaW6MpJF@hiagonb>
Content-Language: en-GB
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <apsphFWUeaW6MpJF@hiagonb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 06 Sep 2026 07:08:42 +0000
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

Hi Hiago,

On 04.09.26 22:29, Hiago De Franco wrote:
> Hi Andrei,
> 
> On Sun, Aug 30, 2026 at 05:29:59PM +0200, Andrei Lalaev wrote:
>> Hi Hiago,
>>
>> So, I've dumped the registers using downstream U-Boot and yes, Claude was right.
>> By default, downstream driver configures the PHY, so the PHY registers
>> have the following values:
>>
>>   # PHY_TX_RX_DLY
>>   milkv_duo_256m# md.l 0x04310240 1
>>   04310240: 01000100                             ....
>>
>>   # PHY_CONFIG
>>   milkv_duo_256m# md.l 0x0431024c 1
>>   0431024c: 00000001                             ....
>>
>>
>> With upstream U-Boot, the same registers are always 0.
>>
>> Simply setting `PHY_TX_RX_DLY` to `0x01000100` is enough to get
>> the SD card working.
>>
>> The attached patch contains the backported PHY configuration from the downstream
>> driver & upstream kernel. Could you please take a look and check if it
>> resolves the issue on your side when increasing the clock?
> 
> First, apologies for the delay on my answer, it was a busy week.
> 
> I tested your patch and it works fine ;)
> Thanks for the fix. Would you mind sending this patch to u-boot ML?


Sure, I will do it over the next few days. Thank you for your help and testing :)

-- 
Best regards,
Andrei Lalaev
