Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A0606A32A
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KNKeh75R;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U0Zd/oKA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8100F81342;
	Tue, 10 Nov 2026 15:56:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMrON_rLsgY7; Tue, 10 Nov 2026 15:56:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1B5B81343
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794326161;
	b=evZOMz+/Qu1ij6VnirjpQw41W6kJCSgKzZeFgrw/ER81TkUmPbSyukvmdj3Woff+kpIF
	 eO2bMyLO/IJfoVfn4cSSVzCTIPZolkwp1Ga80NiewSr2pdUzS75eIxLdw7LDHWM3Xw3+4
	 pHsH0GGDFPUyPm+MlXk59AobYrDZKKfsb9ldA60J0i8JTk0+ZllbB6kRvcPa2fYgjjgQ3
	 YJAkMGyhCxAGeiPVQS7QCo5tJ07MleL566mm5fk9QoznIp9FjTL2gKwmWYw2miK6l8IWA
	 8yQTBlAevbdc5vS7W+aO8T/7mTNDSSJAcCKVa1IkZpL0thouE4AvJOWrSvW0Ua1CiBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794326161;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YQPSZC8hbSg+znt6ihF3o5jjvtgPgChZD7xS6st21bU=;
	b=p9jEB4fy7gz94qaKiDhkf+Ln5dzTzgsLc3aA4rTiFNqc34EWYdPnpU6esHASNxNeymKe
	 1yjyp879twaeLzqHQGEJfYcVwg7uXLHgsPC/u8NLBoj9/1h/a1w1gtBDUQt75rw45nsIr
	 YA3lgS0Ag0pYLk5yyEcyxNoPb3WbrAdnKy0YxEQExBcXAbEOlPBmSWLAksIijkfsPR119
	 mIsBbX+jk1LhH8O/kdIzzBarCSnPdybZIg6C5NLAcZ7OOnAuMVnek0xU7/ynw/dNo9R3n
	 Y8Ers4YaYs7/2L1NBsNmJLnXb4pkw3H/vg12GYg4fLRn5RK8825IFk4KxuMcO12/4dg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="U0Zd/oKA";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794326161;
	bh=YQPSZC8hbSg+znt6ihF3o5jjvtgPgChZD7xS6st21bU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KNKeh75RefGjxXoQQqBKBootEjpJwAp7dog2OtbSPBy4tJaQakcwD0DCK98uDeW+P
	 de+pba+3TU1yvoNDd5oUFwu6G7K/cYDxmScA/Ghvl0vfILhVcnSTJhrlpluhAklM7Q
	 nyWDYADvD6whSm7U4CCxyXpjDnmgb6odE1R4lrH+Z0gyrPOqp/EV4v91JArn2QB+gq
	 MPgwvVPrhW0DfzZX82IBmB0ZH1bRnRgiCOmVEkUmjX3JL5S7XVZ9yTsj8Id9MSRwSs
	 ATaHmyuBE6pTYAZhyNSoLLYxOcK89AF7fq4elaYH3UvxEXFRVH7AvXk4gGAJlGzANf
	 ENe3BW7IVN3Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1B5B81343;
	Tue, 10 Nov 2026 15:56:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CCE2731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 912CE81343
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:56:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZW69N1_jIEa for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:56:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6CE8381342
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=U0Zd/oKA
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CE8381342
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:55:58 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so322673366b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794326157; x=1794930957;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YQPSZC8hbSg+znt6ihF3o5jjvtgPgChZD7xS6st21bU=;
 b=U0Zd/oKAeY9/M2De6P1kj0L35W2ayKdeXrVcaWo8wDK5Aue+VIBq7NH9uOIhyDE9X0
 jYBzZi89xDxt8bbaIkhYanueweVTxetk5WoIgWWkChj6woIpLiRnBC8FjHj0oKZYlqVh
 He9r+WQKwUrrnaiHDC59fYk323EFwRWvKWg0XoEA90az/wVvxzAlycalo/2QDG6zsfLo
 UrFdXuFEVGJrpDQvjGa9PiYAKMfwbYFkfajtruLGEOFZYx/xrJYaR3/9LG/QLw2KFMLo
 tBTJ0bmEIX2JfiGRycN0EH8DOXhLs7xhx0CNGRVFaOvFlBzHJXovKgACv25Lp8coW/fh
 LGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794326157; x=1794930957;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YQPSZC8hbSg+znt6ihF3o5jjvtgPgChZD7xS6st21bU=;
 b=vD1C5fE4PCFF9E7tO4upvhbJJBDXANxgNGrbSSKw/5bVUJkRuhMEV2fHQE9z8YHalh
 XzTZKcpKB1NXfZI8L3lWdCldFope/N6nHWrdeY4GkjqO9ucm2sSv6RjhikKlQNoI2mhG
 1BfI1s+qaIdt8AJ4fk/tYxXh83u8WMMoiVzCPJYcFSBD7E9POdxKRC9EH4e8aHG76ed5
 d3vI79DVMBOIJAz6RAA381hgFjgCOHuPTOb5+43fpTvXDZArCnUsKlzsP2yToFvIoOHf
 6MhkPwA5/5dc4tRWSN4X92B3gZp3t2RAuteTMdTWcIyIJN0Wb4q21NIEcD6k6X4KKZTG
 O0/g==
X-Gm-Message-State: APuU4Z+xj+AMISVo+WWCFOf3YvlWsELRcvPP2Riqqx4AX3Ko7J8gaUzt
 whqa3dct816Vz+J+9kN0SJvz8olHhFFR4eNP11pyN3AfdZAzLVyI2yOep6kkkXq+w2Q=
X-Gm-Gg: AYBFou0I2F+PlOZoJ9vrnEUkDQs7eVCzqa2dKGZl53WRG0uPgDzYuw2ySG0Cf1hRgYR
 p4Nly/cUUmo9eOdbvi07tCEXW/dCXl8b1PzdnfM17og7DO/pl2yUo5p1biRx7sVt8+YQ+kDaW6C
 X3wcv+Kj3AHG4M732caqo7TDYGM1wLUdkdL8TJYqfh/zSQXRI38Zu7j11he0qG3W2yVVxAnWhHt
 T/3UhY3FzVF2A9U48TFJ4tP6kF79rARU5t687dIZJ+AgosujzAY3225GD0W92+v8Znnpm4ZzOJs
 w4pYDaITkClLeE9NU8WvGQQpzDg1tmvA+3cb7wl2lzgt48+odkWL8YoxnulFjlqA+KTTuxmYLzz
 bBg9XE9t5JTvBqS1CgwkQM3fp0bLMK/1IgOwgJ+2rYVg9kc754mGLrdcQ9zqkL88DiDn5W4o9Zt
 KvVgjKWfMhoASqZ1LU2FvJFbjChAcXupHRqQwhQpHWhWGJQJItH/ScZuFS9XFgTJI7dF4HSx5+v
 9VDhMRZRnayPo5YuNKvboVl7vCtEumZQ10VHepeH5ojL43UzoatYbICqbfyex969coZYW+vJ3M7
 n+VohrqoZy9HnrupDBsWehcsF/pbywi9l3V5IKNqhcc0EqVHTDmL2k4BbicA+yr7309V5OyK2gX
 2tv09xnQ2Lfe/2oS6Zz2nyqtQhA==
X-Received: by 2002:a17:907:d311:b0:c50:5e0a:fbad with SMTP id
 a640c23a62f3a-c505e0b1e81mr92486666b.39.1794326156886; 
 Tue, 10 Nov 2026 07:55:56 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:e384:fd63:c1b:f384?
 ([2a0a:ef40:e16:1f01:e384:fd63:c1b:f384])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a6335d1sm121917766b.59.2026.11.10.07.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 07:55:56 -0800 (PST)
Message-ID: <fc5535b6-d967-4890-96e5-337c6ea5c23d@linaro.org>
Date: Tue, 10 Nov 2026 15:55:55 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] Fix 'make check' errors
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Kory Maincent
 <kory.maincent@bootlin.com>, Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110145550.GC3741582@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261110145550.GC3741582@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 14:55, Tom Rini wrote:
> On Tue, Nov 10, 2026 at 12:23:57PM +0000, Andrew Goodbody wrote:
> 
>> Various tests can be run using 'make check', 'make qcheck' and 'make
>> tcheck'. These have become broken and need fixing to be useful again.
>>
>> Running 'make qcheck' fails on the binman test to check the version
>> numbers of the tools are found as expected. Update the code for the
>> tools that have been updated and no longer have their version numbers
>> found by the code.
>>
>> There are also failures in buildman. First add code to understand 'gcc
>> -E' as an alternative to cpp. Second add the code to accept an empty
>> CROSS_COMPILE variable in the environment when testing that
>> CROSS_COMPILE is not set by the toolchain selection.
>>
>> dtoc was not achieving 100% code coverage so add a new test to rectify
>> that.
>>
>> Disable event_dump tests that are broken on newer versions of binutils.
>>
>> Build mkeficapsule in the tree that is used for testing the tools.
>>
>> 'make tcheck' was not achieving 100% code coverage and needs to know the
>> location of the built tools to resolve.
>>
>> 'make check' tests of the file system had errors due to ext4 file
>> systems being created with an orphaned file but were marked clean.
> 
> The biggest problem I see is that we need to step back and see what of
> make check/qcheck/tcheck make sense to support at this point. As you run
> in to, and was my concern last I tried any of these targets, things
> quickly become very host dependent. Which is why we have CI abstracting
> all of this away. Personally, I found it best to just fire off a
> one-shot container to run pytest in.
This all started when I found a suggestion to run 'make qcheck' on the 
U-Boot source tree to confirm all was good. Of course I found that it 
was not good and started to fix things.

I do not mind if we just remove 'make check' and friends or if we 
resolve the issues but the status quo at the moment is a bad place to be 
in. I have tried to make my fixes be less host dependent than they were.

CI is all well and good but having a local smoke test seems to me to be 
of some value. If the request is going to be 'please rewrite this whole 
mechanism to use containers' then I am not sure that I will have the 
time for that.

I would appreciate some indication of how to proceed here because while 
I understand and agree with your concern I am not sure what is being 
asked of me.

Andrew
