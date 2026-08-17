Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3997C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6F2D40854;
	Mon, 17 Aug 2026 18:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oP00Dmw7mkE8; Mon, 17 Aug 2026 18:17:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FDEF4083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990640;
	bh=XmFoq5UnY77208PxZyjkybVjan4YwlW0oJqEDsI/2Ac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dtORs2Xe+Hoh8+MhWZbv38nlBuiCHXKarnn6FUXcmRGXPer5JOt2KXgY3TWOcoWdZ
	 IxojMb0746inB4fV56ay/HCW2rQ6dw+TJA+EswKjGvr4EQnypaRazKQLYcxNUmw1zD
	 7IYJAnbUDPBQyQDzyJ8mGM8jpVrJataRKxvghps9bF0UTNWgUqjHpKNI8vFD9qb/FH
	 HFqKA8AsMzSjNB2CLZWcPfdZ9mIJpk/3nIEFYzyID2ovceYavM19hiVZtfTEW4+ugz
	 6cB4ySwJmE/OW9n6rqLz3TqVrTiGNDo4hj24wdwprZh2g4LN6Ef8IzBjL6V/ewi/8M
	 FkghM/OqhOc4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FDEF4083F;
	Mon, 17 Aug 2026 18:17:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E02A1334
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C623080E1A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oX32Jqu5NQi5 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:29:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F15E880D91
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F15E880D91
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=BLGSawfy
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F15E880D91
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:29:49 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so3544292a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1786984189; x=1787588989;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XmFoq5UnY77208PxZyjkybVjan4YwlW0oJqEDsI/2Ac=;
 b=BLGSawfyhisHbLsZgx9tP7alv03asxc8Wy43PQLZbSNohsiZUSpAqbcT62tRihhNwn
 aaocNJknKDQ3XCc9SkyxpR7/f+LJfjKrTz5VaHkWCCvx2efQV4F/OCbxnYu7jZW1CLwU
 XO795xv/CJpM89JyDc9lRpU8YlQIUSsP+nwCUHstFlPjon2wJNqIvqHJ1CGvy0BYpojY
 yVpjtS2rtHJqViR1HVlvLZ4VYJ1JMlwvCGOlkptH5twMzJas/zJZyrmi/9ALMYsWa6V3
 Dwlz/FhAjoKId101tLMgDx/tkLDw4MZgTXTF/wj4HEppK2091Ntt4RTIJPYeFKH9u5w8
 6kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984189; x=1787588989;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XmFoq5UnY77208PxZyjkybVjan4YwlW0oJqEDsI/2Ac=;
 b=sIp+rGgGTn1lSnCSFobmJTqdmMY2uSEG6WqQSxWeX+wSeClePCGuArSyyspRbUyH+e
 b2XdXjRV6xXVC9YU+qdQXgtPhD2OMx6egou2CZ60mdgOkXT5PcPbK7kHldjFYos/7AOD
 DMsayK6GjbtPReZ7q2ihz4zVWpH7uKB7Cfvl/zcUPdgFIAzlAbdsWSLQQQt9lvKGVEey
 ZEgRXCh/3apuYvv623nSozfbkMOUmjAkxlb7BubJGqAxXo6LHil8G/4gPL2syB1lz9hQ
 y7CMsbBJ1BarQfzAekAh5oLWXhVgOmrmK89zKSQHS7QmFHZ3ZHluCLPD6g+Sa+jrPVjM
 qJDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQ+U73ypcFJS6I8kS+knlwrzkbMS8KLpxc7OuytWZaFg/N4fpuC3quL7s/SFxNv7sy7Li3z6I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyBl2Y7kTOTHyzGsOxpchkMHmjX28iehsBtudosvvQyRK6lFRa+
 xGovsLXmaKwpTZ1MM/KQzEpQyJL3nU+J9V3PxSoLncB8EsD4duU3uPBX7GgNc2XlU3k=
X-Gm-Gg: AR+sD13vSnLq9mMUe9zFZAHBhelZBfVZdAFNlQ8gh86wsB5djCu32j0t7g06Ovj0kQ3
 5CQOCxZG03flWFSrgaMFMJcK7zdoQcThkVwESbTcdYVt8joI1sqKq2/7EYIRqSiwF90kwcFiNAm
 uBU5cm+gwQazb7vmmLzF2n2jvd5l7hEiQxRRI56OMXUvKILrJW4cW1gFkajWFkn6zS9YFuXZvQ0
 /DQDfgRbCvWL2xw0h9W6K3Ph6bWjSoc6POJTTmfbGRfl81JG2yEMn92HtMWCrA/95R+Frp10w1l
 HadnCOyK9feJPFIYcePFbeklo6n73Npb0oMydIEvG5cZZY7eyOgIAVNChe4kwkLRTUs1sOLF1tZ
 50y7bNarG9Xgum08qkhCR/kk9edf2V8RGolnkWvpu1cq5EcTLl6TA03Duft0y0NVWAoyZQYzyqp
 RucAt945MoG5x7OFCTY0iyWf9lqyiYJ4CUT2IhGziNfkiPd2+6cqf4RUCOwwyDfHW9Jq9V5SKlQ
 QpWIeGbq2AJFevQw8J/AX3OZkLOhY8=
X-Received: by 2002:a17:90b:5803:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-3955a70ba38mr1777371a91.9.1786984189136; 
 Mon, 17 Aug 2026 09:29:49 -0700 (PDT)
Received: from [192.168.1.27] (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d3d0a6asm2944906a91.16.2026.08.17.09.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 09:29:48 -0700 (PDT)
Message-ID: <b0cb85a9-eed3-4c48-9915-85420f2c6445@t0.technology>
Date: Mon, 17 Aug 2026 09:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: srand_mac(): fix -ENODEV crash with CONFIG_DM_RNG
To: Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>,
 u-boot@lists.u-boot-project.org
References: <20260806204344.3069848-1-gsmecher@t0.technology>
 <CAFLszTiLQQi4NKt8iNu4rwGOr+7CLT5sEx71=XWJgTHs7SS49g@mail.gmail.com>
Content-Language: en-US
From: Graeme Smecher <gsmecher@t0.technology>
In-Reply-To: <CAFLszTiLQQi4NKt8iNu4rwGOr+7CLT5sEx71=XWJgTHs7SS49g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:14 +0000
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

Hi all,

On 2026-08-08 17:36, Simon Glass wrote:
> Good catch. This also means the RNG path has never worked: with the 
> inverted check, dm_rng_read() was only called when uclass_get_device() 
> failed, using an uninitialised devp, hence the abort. Boards with a 
> working RNG silently fell back to the MAC seed. You could mention that 
> in the commit message. I believe it is:
> 
> Fixes: ea707dc0aaaf ("net: Use NDRNG device in srand_mac()")

Apologies for the delay while I was traveling. I see it's moot now (my 
initial patch was picked up) - but you're correct, and an amended 
message would have been better.

Thanks for the review.

cheers,
Graeme
