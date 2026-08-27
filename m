Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8E2C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F18156078C;
	Thu, 27 Aug 2026 14:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zOFdbCUAsz3t; Thu, 27 Aug 2026 14:09:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787839751;
	bh=kVDhb/SOrMJQlkMBj3NRgZoMAt19r42IE4es8UYqnM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BZaIm15Audp+XW1nN9TQLh/UrncvZzoy3EeNcm6FLfQMkU9ZuvMLFVuvXX4D2b/JQ
	 Sw047cco7uj3V+RNFH3vLGn0Z4qf436lw5i2V5UKYsYIwT+lH5b6/nI9+9nRQO+EiN
	 Hq19Kg7gODBg5lnR5lsQo26s9K6i2ytsnXFrvrENdXJXA1+Yvb/x4oa5ryZsXljNR8
	 j4cNfoklL6WLP1yVGX0cfdblt8umqPLOIUhnkVlanuEjcKRtPiHOeXVxyMvHayWHuP
	 763Lc2WlhagcuDE6wEFLvYOzeA1wv+k+kNovTJc4XySD6gv9IRS8u2TEid4/mQ6VPK
	 OdQJqHBgB4Yiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D2426079B;
	Thu, 27 Aug 2026 14:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37471355
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D7B16079B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bmJDpRvquaNV for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:09:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=tYRmqRE0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3804B6078C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:09:08 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2020421077so345624866b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787839747; cv=none;
 d=google.com; s=arc-20260327;
 b=M6l4XKjmCiuFpZdPl1f+7atH0KlVMSqN+LUdi+GUxJ92vKMmFNmkVWBzznEQ+UngeV
 cFOKPfuvUrN1VSkz8MhdSwzRCVXrwhuYvqpevchT/F6iEaG1nWpXFR5wRTDk39B3btcB
 b8OMKsUsirSLtSm8UruzGY+gqNnypYvHqzAECmFnY6j/xcvIIqwe5Onw/9rLusaM7CPf
 zmu3Bvf89A6zmkd/RCeaMNvGwzWm1rU55x2W4f2qvCtAnF84EXNEPZjJZQcdnNSKaLSv
 bzfXeGOItYmWLs+aXJOQzfWHB+2AetVNSZfESQ+3Tfok7yFSdzmVWUYZb9+e1tqJqPJu
 7zlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kVDhb/SOrMJQlkMBj3NRgZoMAt19r42IE4es8UYqnM0=;
 fh=AYmAZo2VibhswYXgS6saIXDvZp4J1oGXw+2MV2DfA/U=;
 b=l0pMnKgHgiPHGKOIA6M6TKqV2VWnmMuVFA4Bk4Zd9eRxmmXRZV0tbywwKx2sOR6W0R
 NKkylqI2qxvotrLvpYjJKpf657vqN3laKJ2db2CXUVQLe8U367/d7zyeqoUO/Pj69F/4
 a/QmGdUOwGVPc5WPqmVLYHtnRvtwuNe9za/iPIE5eiDzRHsNQbC0SFn1pUUic4ZMlkVf
 KZ9B+VzHyvTy0uoT4JKJeMV8wLsUXv3nu8kxGGmSMC6jQXuBnStRFz05atSUlAY9DPbV
 adPa6GbG6GATAKKXnN2MoLnDs0mLVEdOZGfPwzFzLf40vlOvqXX/JN7/8Liy1CB7Jxk2
 IVkw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787839747; x=1788444547;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kVDhb/SOrMJQlkMBj3NRgZoMAt19r42IE4es8UYqnM0=;
 b=tYRmqRE0QDvavAnWWhSQzT3CXr5cE4ElTwnJsTQFz1Ef5ILg0KEVzMt1sKS1KMsHXR
 /Di3EvzwVzfp+LmUa39fZI3VvVMmjQS/L3XWr7VlEZPXKF3uqgngJwk7Y0AQAE2uL+vV
 1iQLz1X8mPWtHaHHHJN7+hJJMhn4NaU/kRQvmL7CcWrO6ruMpIjdp3tarM7pNnLPpvaL
 7CPyzMVDaR6DqNTW4xKTqbz2iCQC5/XsoxmirW46/8FIR3Q87oHE4op5r3KO/PRXLAcw
 9zNUr/Hs/cf1lLHrl5ZWkFIDbUfVqFX2d6L5qnZDuSPbVWZOC04gI88X6ZmHu7bAnu8N
 /HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787839747; x=1788444547;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kVDhb/SOrMJQlkMBj3NRgZoMAt19r42IE4es8UYqnM0=;
 b=hbiGNqbtnrPpZPjTBGToWmPRUrsDmPHaaeosT0+dR+HMaCfXiGYZx67OhgaX4l3pDD
 anuiirLXcFid53rk0w2FeJtLzSMUbBkAzBqeovA5RmGbPRGIQu5DDGtJFcCfwbNFtxoy
 4MqXLuhhuVhfFPzYKWgw1VJwTgFL1g3KHdsZS2TyljoY9YSNmzMXy7Px9YVZ1E3vzYmU
 EgDXzkLz6ZDBHmljRiM65FK6kqHHz798wOWxglIooO5wz9VKD1sPtCr4fHjAgvQdK5Lv
 CZzMh3FdM6Wbeu6tyby+D4XgXM8rR7/J3hcq9d9YoDJrQMT8CxCC4ktCwpmm3McalQY5
 QNyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhcmgstnYMOfYYP/4sQMSbxrHvvTlDJFBuE4WAVDdIgj7dwKo5GQmM20VX3LFxqta9QdOmyCQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k9wwHkGPcJoDo1P4IfgIkd0ZQVr70evmmSjfLdaoFHAPZxntRc
 ILfiT/uApz5eyXpXc7c9Rb4HGSkWWugBmZf21OxTS50ii1a1pmipCeS8P8Ey1fGUo2+SPzPUNft
 7HqyV+SVU3nKxMYN2Pj6kzN7BaGOWsQtv3xg9ZcejNg==
X-Gm-Gg: AR+sD138QY9csE/d5+f/MO270G5kCYNTjoDycMCO/4xmlFYor3spIMxt7/+YijuYIA3
 /rPhselMm+Ro4JA/OFIryF8AmLQgwLbBH+mMgpztWFRgFzonzbquG4rhEkHy/gtLz5x0JLCLKH7
 tdCNDLFvis9W3h14t1CCkc2X5+24vNkTe6/Q0DfwAwhm8sMw1aHfUQcAeu2YSNdOMcZLRecmsKf
 LeBXjlK97cQ6rh6HKVBoVgsd8pedfrA2ZvdSnh2dLpUS422nGsXJTiHgWggrz90kgfFcG5O/8fC
 igG91NGqbWMV61wqHeNtmKQzCoL5NWYHj5iaBJLF9U0hXNRM/QoJCBFrv/a1UTA3//7I7xn0jFQ
 W
X-Received: by 2002:a17:907:3e26:b0:c12:83c9:d41 with SMTP id
 a640c23a62f3a-c250c595aaamr1512363666b.12.1787839746809; Thu, 27 Aug 2026
 07:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260827-uuid-be-v1-1-9dc3b12cd691@flipper.net>
 <ea3cbf91-f525-47c8-870f-79e8ef09e30e@gmx.de>
In-Reply-To: <ea3cbf91-f525-47c8-870f-79e8ef09e30e@gmx.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 18:08:54 +0400
X-Gm-Features: AcwNN1VKFX169AmRFq6uMJVwj7N8PK13a2xQla5DPF9CikXZ4Izh6SvIkfBXNzo
Message-ID: <CAKTNdwGdq+AJQhgqqX9PA3OwhTa3NAWp++m5oOBR7M+s81f8sA@mail.gmail.com>
Subject: Re: [PATCH] test: lib/uuid: Fix endianness for dynamic GUIDs
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 27, 2026 at 5:39=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 8/27/26 15:00, Alexey Charkov wrote:
> > If LIB_UUID is enabled on a big-endian board, such as when it is pulled
> > in by EFI_PARTITION, its tests will fail due to the dynamic capsule GUI=
Ds
> > computed by lib_test_dynamic_uuid() using native endianness for the UTF=
-16
> > image name, instead of little-endian:
> >
> >    malta # ut lib lib_test_dynamic_uuid
> >    Test: dynamic_uuid: uuid.c
> >    test/lib/uuid.c:114, lib_test_dynamic_uuid_case(): expected_uuid =3D=
 uuid_str: Expected "985f2937-7c2e-5e9a-8a5e-8e063312964b", got "829f5cb0-1=
a07-5718-8774-4514bda82c39"
> >    Test 'dynamic_uuid' failed 1 times
> >    Tests run: 1, 2 ms, average: 2 ms, failures: 1
> >    exit not allowed from main input shell.
> >    malta #
> >
> > Add explicit endianness conversion to the test and to other similar
> > callers of gen_v5_guid() to make sure they work uniformly regardless of
> > the host or target endianness.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> Thank you for reporting that the test fails on big endian systems.
>
> In lib_test_dynamic_uuid() we define define dynamic_uuid_test_data
> test_data[].images as u16 string. On a big endian system the characters
> of the string will not be stored in the same sequence as on a low endian
> system so the UUID generated in gen_v5_guid() is expected to be different=
.
>
> test_data[].images should contain unique sequences of bytes.
>
> The relevant code was introduced with
> 26e16a850e64 ("test: lib/uuid: add unit tests for dynamic UUIDs")

Thanks for looking into this!

Do I get it right that you'd rather have the test_data[].images bytes
untouched, and instead select different test_data[].expected_uuids
based on the CPU endianness, rather than patching
lib_test_dynamic_uuid_case()? Or shall I make the test_data[].images a
plain byte array to remove the endianness concern altogether?

> With that I don't think that the EFI changes are needed. Anyway UEFI is
> little endian only.

Happy to drop the hunks touching files other than the test
expectation. However, the test expectation needs an update one way or
another, as we can't test GPT on BE without it.

Best regards,
Alexey
