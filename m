Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3322C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CF6807B1;
	Wed,  4 Jun 2025 15:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qh4v694d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F95381E72; Wed,  4 Jun 2025 15:16:00 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDBA880584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4fea34e07so2518263f8f.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749042957; x=1749647757; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A5PbN+FYzGx2VkaCERZYeulwrgMyAQqYwnFIkfaE55Q=;
 b=qh4v694dR6Evlx61PIs4IJz8BhJAvvgggTNFClG8Kq2AbC3eV7jsJDWW8qcnMhoqS1
 FqUVxEzYL2av0c9MGdcmdTqkPhz5y+djnunqAXKxJheLFBYBGa94rCXgq3Z6wie+kezo
 n87kMWHMuWe8WdYvFQQ+A/CrML74f6WzfLdZPOpKe81VYmt3JfEfslQ4/O4SjOTvQ/fs
 WRS7Q7z0+lCb4/WBDRCLGJlbNtD/RXAlXm+x7aO4CMbrnYcMr8RwCn5OEgdGgWDjzLl2
 Rq9CMmA+nBrEQ636IXzjfszRQ+N9MfL3Nm7V58tczwvYAQMQJcGvlMy3n2+6vouswO+9
 Sc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749042957; x=1749647757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5PbN+FYzGx2VkaCERZYeulwrgMyAQqYwnFIkfaE55Q=;
 b=b7tUExoJW2OijKPypnQLoyKZbzy//oCcCeBXd3J7ue7FynSc+kb9n75+LfW4rdZmzn
 7NksiPmff86UNWhVj/7tUd/OBB1aamCImcvwqUGmzGkhfzYvDorseZP4jOGhX2CJ4YJU
 8cKKYBu+atz4Gdn9k6CSmh9SfCpFlmpDUT1mFAK386zXU9MiINPT7eY3ETwHtXA6ZEpR
 FKJ+tFCjWDiDwO9M8Uex1I56gcx7Qjgyl6Em+WFjNyMFDEaEW7xNPr6hwB/hl476r//Q
 AIPxOWSDYDvq9osuz++1+BeFXTL8DvqXFUoq+DSo0okMlL1Z+1XUVXo/a/dFXCjdFp0V
 JOkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXA8JW1f4N3+AEI+y1YAyAz0NEDTJTAyKpTyOb6pNdN9AcWicHgmu0JcwNfGpr3nTVahFybwE=@lists.denx.de
X-Gm-Message-State: AOJu0YzRBkzpsMxpqS7WmC1DktJZ96mPygcViFkyeFU6oiYrV+wLlXUO
 OOweuKDhyOq4BMJgQm//9mEhkwGML9jAvQdqhrnkMtqNzghE3Y7mtw4lP0hWnp3WTtQ7Xmlfnnh
 jR1Pp
X-Gm-Gg: ASbGncsY6oc0iS+Hii3HWmLdenrmJeHMPp62f/Kau4n40yEaYAVTKAF9S+rhiCUE6Fo
 tEOaoAk8VNOApmL4pEZmT0nElUaSR9vvyqUg2zfNfULfjSrspftgHwY8tG2zw3MvIhD7YxT1sE3
 bKozIncjIG/y9Svybrpo05HJqXo/c0XqFL8MERG5u0iDmhrE5OZCjf0t4TTCnnthy5Js6+bCmjh
 o05laoDFZZxVzr9s+0AT+XrTPiEGtEg6oSnlyjQl+l4JnPKU2W7gBGH59NS2AZZJ5E3seSAI5Ci
 kwNnT7+dxVRxKZPR0jkhhLavtVEwOYiB/xD1WcQHngPori2VFYw8D1wrsgETgGxKYCxShMg4byJ
 LuUpXoafo16GDofOr6b+jJNUmHnStdtZE5lvp
X-Google-Smtp-Source: AGHT+IFXvpR4YOQSPAP3nNUQ8hFwsSOLQEcno8s9wg1HMtLH7VN1Wy3wWecxtyBvfMpYwxBZmlrUOQ==
X-Received: by 2002:a05:6000:438a:b0:3a4:d0c7:312b with SMTP id
 ffacd0b85a97d-3a51dbe36d3mr2183855f8f.26.1749042957072; 
 Wed, 04 Jun 2025 06:15:57 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe7415asm21886603f8f.57.2025.06.04.06.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 06:15:56 -0700 (PDT)
Message-ID: <d3f66117-4b1a-4670-82f7-0d895c74fbc7@linaro.org>
Date: Wed, 4 Jun 2025 15:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Determining Simon Glass's future in the U-Boot project
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
References: <20250528175901.GG100073@bill-the-cat>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250528175901.GG100073@bill-the-cat>
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

Hi Tom,

On 5/28/25 19:59, Tom Rini wrote:
> Hey all,
> 
> First, I am not happy to be writing this email. But at this point, I
> feel I have no other choice, for the good of the overall project and
> community.
> 
> Back in January[0] of this year I made a post with almost this same
> subject line. At that point there had already been a number of problems
> working with Simon and the overall community. I did not include a list
> of links. At that point the easiest answer would be to go to the mailing
> list archive, pick any thread that Simon and I had and see the long
> disagreements. This trend has fundamentally not changed. And while I
> started this out with some threads and my summaries of them, instead I
> want to point to this email I sent this mornig:
> https://lore.kernel.org/u-boot/20250528170533.GE100073@bill-the-cat/
> 
> And to repeat what I said there, Simon needs to decide if it's more
> important to work with the community or have his way every time. Simon
> cannot have both. Simon needs to accept that some things he think are
> good ideas have been rejected or he needs to fork off from U-Boot. Or he
> can ask the community to take over as the project head. If the community
> wants Simon to run things, I will step down and just be an individual
> contributor again. Five months of this experiment shows me that it's not
> working at all and will only be a bigger problem as time goes on.
> 
> And, I mean it. I cannot take the additional stress of what new problems
> await me every morning. I do not take the above lightly, but I do not
> think the project can become healthy moving forward without some
> resolution here and quickly. While I won't claim my time as the head of
> the project has been perfect, I have tried my best to always be honest
> and fair and to seek compromise.

You've been nothing but encouraging to me as a new contributor and 
custodian, and I really can't imagine U-Boot without you leading the charge.

Simon has been repeatedly engaging with people unproductively, wasting 
time and delaying valuable contributions. His complains tend to come in 
the form of vague hand waving about how things should be with seemingly 
no attention given to the actual intentions of the patch and dealing 
with the reality of how U-Boot works today. With so much attention given 
to his ever-diverging fork I can only imagine increasing confusion about 
how U-Boot actually works when it comes to reviewing upstream patches.

Referring back to: 
https://lore.kernel.org/u-boot/1c1bcd1e-bec5-4e6a-9f09-e1d2895969b3@linaro.org/

Simon seems to think that his arbitrary *implementation* of a boot flow 
is the only correct design, and there is no other usecase where 
something else would be desirable.

After many repeated discussions with the same themes (and having 
witnessed many of yours) I struggle to see Simons engagements as 
anything other than bad faith, particularly when it's so hard to pin 
down what the technical disagreements here actually are.

The patches in Simons U-Boot fork all appear to be either picked from 
the list (often earlier versions that what actually made it upstream) by 
other folks or his own patches that have been rejected for totally valid 
reasons that he doesn't seem to want to get into good enough shape to 
upstream.

You have repeatedly and publicly explained what it would take to get his 
features merged upstreamed, and to be honest I think you have offered 
him far more grace than other people in your position would.

> 
> With respect to voting, would anyone volunteer to run a poll from
> https://civs1.civs.us/ (which is used by the Yocto Project /
> OpenEmbedded and likely other FOSS projects/communities) ?

Maybe rather than this we could form a U-Boot board (via voting) and 
this board would be responsible for managing the project and associated 
resources, having and enforcing a code of conduct, etc etc.

There are various organisations which can help with this like the Linux 
Foundation, NLNet (I have experience with this from postmarketOS) and it 
would give the U-Boot community a way to be represented when it comes to 
difficult situations like this as well as provide a way for the project 
to grow sustainable as it increases in scope.

> 
-- 
Casey (she/they)

