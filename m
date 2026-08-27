Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3252C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 15:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B808A80E7E;
	Thu, 27 Aug 2026 15:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iv-hvA7hvC6b; Thu, 27 Aug 2026 15:10:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787843433;
	bh=uuRDJqPiz5d+FnL1eoc0O16CrhnoE6q1xHc22pH1X4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YstqaMoXvPoH8dnUDxZSLr5quDXH82TtTrcy+VsUiXixU0fcZqq4TdP7zwkV8JRSb
	 01eE7Y4SXsxW0xLipUduLfYz91Rd/7GW71GchdNocV4iPBSx/zlynXU7ctsU5uGZKp
	 H1HgehJKY4vv4BVvJnCE1mKpBZWpidmAippXAgzFSh7sohn/sEfQqBvPplTXK0hLVM
	 iTkAgmABGiqvdOdP2CT/vQydD4y+aLe2trzoRmo8NyqBkxsHw3LS+W1K1yl5bdc/yc
	 cSejOMlrh00Eja+2n4RH3hmYOrdfSuOALy3Xph+HgF0Gh3ro09PddOVTrPuUJzsqoz
	 xebxj0/0H9H8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 954ED80E6B;
	Thu, 27 Aug 2026 15:10:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D05442FD
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C248C80E69
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjRipJ9NJcCz for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:10:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=V4TpjBg/
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F09A280E5D
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:10:27 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 625B43F4D5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787843425;
 bh=uuRDJqPiz5d+FnL1eoc0O16CrhnoE6q1xHc22pH1X4I=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=V4TpjBg/D2fo5+GZvBO+2jL/Bvp69ciyQtHfaXAcggnvL3e9x5+heBltcFqI2lSBz
 NVfi4uPr6f1E0Zyhe7iOjvhfx/J5uCMtZWQs9D0YiPB/6ivHjEeoxxf8qFSIUn48ZF
 u4xAub4ZUpGFu6RfjEt32CQ+dIf/D2e2oZtZMecvPe6QsifIHRf7DdjKtyTUZ0PoEY
 hG1cqPrOtmjIuGhJP+ME+Vqr639FcSxmDsPJ8uxWfTvm3/NTfn4ynjOSfBKXRDgycd
 IUWeyWaDWnC7Qg7t87ZSN3QSI/Sh5gOSUurJZrK9OImpOpltyhSP06hKofXRB8lj+5
 k22KHxob6r5EJCH9l/bHaCG6MNLChbbUa8clb3v5Oyb/iHCaSpDRisW53w/tWvUbQb
 bQKNmBC84lj1+6YvuKpJpjpvux5/rqZiQvmk5p16Emb8/R0EyUIGHVA+AYbiAiHc4P
 nyoUsYuHqU8l8ffbVWsk5o4ZqzfADxoqZWCL0JTHi2onO25wt9RYfd0svNQNe+nV43
 1/qywRDyBq/C8s5iUjSb9+pqh+nL5yTAt0Q9dhi3VmRA565gUZHggCJ6LoQfFsswDR
 irWELZrJhEIszpU/vxj+hR7NX3Xr92bnX7o3wnaVMIBDkIpbLk+o+IFd2BY48d4pD+
 ESGlCsamxNsb+XyVPC3J5dV0=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-482e8a59be6so81600f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787843425; x=1788448225;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uuRDJqPiz5d+FnL1eoc0O16CrhnoE6q1xHc22pH1X4I=;
 b=jQ9J9Zaru7CbOB9awxyC1GfNi6h5YfxfCsbEGUotWas5+ZodX++Rs88CzBApspen4i
 dcC2y6xw9DR2i1VLOw/HJhi8pV6kse4IOAuyOJFKJW93xnaGLRU5BFJmzZah20ZoBMyf
 jOECEEBL/GRJViYMof7b1shW0GLjJd7cPB/fcdfHQtdvku09eO6s9q0/yjlyIeUcENK/
 ZDTsqEqNjiHWgdFHNmiJ1vAJ6ze1gqHRCSvVNGfKq+GfE/+4hwWkP7g5ykrmD7rOR+oE
 6xFehowpVIyyf7Aq3p38OUBbfQvkDdUOsCHJqfF9n2PtQekeKOQY4U6vJIinbzg7a+Y6
 ZPJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbnUNS6h3GJXq/n2BjmC9nRKdEOe4KKpMLQS+iMoxsuOAe36Jeq7NaFuri2TBP1rdZ7VoComI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kkAGywaYOPLYIT4zmgqkMDLDBgExyRJkNmSBX9HRYECPXz4u5m
 WWCPxMiiya4fLnRjob7Z3OyaI0mYzgNexpuie1LkJMPz3KpGhKVQceOW9f9kBcSt3EwHkrf9amd
 u+RAyCccb18Oc093oKzvFhSkCCSsR09Uiy/DYUVCXnqen215XfvgIacpztDpwXWUs7CcPjc5zAi
 pIqxDAvUaQ8E6NrzTlz+r1
X-Gm-Gg: AR+sD10qN+1FZm7U/eykASvVIdnP6oHgYfuyJ42fW78ZFVZdVCjRiba/fN4TZ3iBVmU
 xdPlQ68uabwgispvsdZHCxtmi80Sv/aMS0KBvtibkLv5bdcKzT0URgcUYQooS9sTfX/sTYdaIKX
 I80ejmnm3sYbB527fsYvWmE3tsveWXVFUNO3TDtmgWmQ/no7IrsQ6WTFkbSC5GCbgY6shHOVI0e
 KYBHflzWi1jpQJI0E8PfQGZZL6nbdz694G6dzumMGODQVYSOQ7uNJUWU8Zupxkf8/4I/2+VhTZZ
 kR0odSnUVQbnowEo1+P2TI1q9SvA+HNXbCfg3SxIGbXTsr9JopissP/IEcBrsYzqsy6Q8rg2KK7
 1ljIkkAvSBaufTLvfCDDZ4TYbAbBAJVCbJNSqt6mvo2Sw5n4z+IFERDhPUoW4GEwhJf6gJYYPAr
 sJUPSLo7yborfVAB6rYf6QOIiD
X-Received: by 2002:a05:6000:46c6:b0:47f:f20d:8d4f with SMTP id
 ffacd0b85a97d-482e26d31f2mr18884003f8f.18.1787843424978; 
 Thu, 27 Aug 2026 08:10:24 -0700 (PDT)
X-Received: by 2002:a05:6000:46c6:b0:47f:f20d:8d4f with SMTP id
 ffacd0b85a97d-482e26d31f2mr18883883f8f.18.1787843424568; 
 Thu, 27 Aug 2026 08:10:24 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:d8da:da16:d52e:e57d?
 ([2a02:908:1242:30e0:d8da:da16:d52e:e57d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f854dsm9820557f8f.36.2026.08.27.08.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:10:23 -0700 (PDT)
Message-ID: <19b83492-f138-4ad1-b8d1-aced7ea4170c@canonical.com>
Date: Thu, 27 Aug 2026 17:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: lib/uuid: Fix endianness for dynamic GUIDs
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.u-boot-project.org
References: <20260827-uuid-be-v1-1-9dc3b12cd691@flipper.net>
 <ea3cbf91-f525-47c8-870f-79e8ef09e30e@gmx.de>
 <CAKTNdwGdq+AJQhgqqX9PA3OwhTa3NAWp++m5oOBR7M+s81f8sA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAKTNdwGdq+AJQhgqqX9PA3OwhTa3NAWp++m5oOBR7M+s81f8sA@mail.gmail.com>
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

On 8/27/26 16:08, Alexey Charkov wrote:
> On Thu, Aug 27, 2026 at 5:39 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 8/27/26 15:00, Alexey Charkov wrote:
>>> If LIB_UUID is enabled on a big-endian board, such as when it is pulled
>>> in by EFI_PARTITION, its tests will fail due to the dynamic capsule GUIDs
>>> computed by lib_test_dynamic_uuid() using native endianness for the UTF-16
>>> image name, instead of little-endian:
>>>
>>>     malta # ut lib lib_test_dynamic_uuid
>>>     Test: dynamic_uuid: uuid.c
>>>     test/lib/uuid.c:114, lib_test_dynamic_uuid_case(): expected_uuid = uuid_str: Expected "985f2937-7c2e-5e9a-8a5e-8e063312964b", got "829f5cb0-1a07-5718-8774-4514bda82c39"
>>>     Test 'dynamic_uuid' failed 1 times
>>>     Tests run: 1, 2 ms, average: 2 ms, failures: 1
>>>     exit not allowed from main input shell.
>>>     malta #
>>>
>>> Add explicit endianness conversion to the test and to other similar
>>> callers of gen_v5_guid() to make sure they work uniformly regardless of
>>> the host or target endianness.
>>>
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>
>> Thank you for reporting that the test fails on big endian systems.
>>
>> In lib_test_dynamic_uuid() we define define dynamic_uuid_test_data
>> test_data[].images as u16 string. On a big endian system the characters
>> of the string will not be stored in the same sequence as on a low endian
>> system so the UUID generated in gen_v5_guid() is expected to be different.
>>
>> test_data[].images should contain unique sequences of bytes.
>>
>> The relevant code was introduced with
>> 26e16a850e64 ("test: lib/uuid: add unit tests for dynamic UUIDs")
> 
> Thanks for looking into this!
> 
> Do I get it right that you'd rather have the test_data[].images bytes
> untouched, and instead select different test_data[].expected_uuids
> based on the CPU endianness, rather than patching
> lib_test_dynamic_uuid_case()? Or shall I make the test_data[].images a
> plain byte array to remove the endianness concern altogether?

I would prefer to define the images field as char[].

u16 images[] = u"QUALCOMM-UBOOT" would become
char images[] = "Q\0U\0A\0L\0C\0O\0M\0M\0-\0U\0B\0O\0O\0T\0\0"

Best regards

Heinrich

> 
>> With that I don't think that the EFI changes are needed. Anyway UEFI is
>> little endian only.
> 
> Happy to drop the hunks touching files other than the test
> expectation. However, the test expectation needs an update one way or
> another, as we can't test GPT on BE without it.
> 
> Best regards,
> Alexey

