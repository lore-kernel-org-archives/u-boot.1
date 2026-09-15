Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B09C88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60D2D40685;
	Tue, 15 Sep 2026 20:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIYTs_qCgZqG; Tue, 15 Sep 2026 20:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A1A4040608
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504524;
	b=mkGizY0YbL9emSVDa8WcNNjTVx3QneI2TtCg9cyh8XRTh2iurX0xlcE0iDIOXStX3OqS
	 ejaJCNOYWDN61h5tHLnkTSIcSjdrT/fzNpmp2Q7zOi8JGq/rPdsche2VX2DXFd2XV0R0E
	 PHOWJ1nVzfF8/yyCa8ktqHmK/ZN/Z6Mi6Igw7m/wUlkGKVVhErc445hDh/Wp4qVXsCImk
	 PpVegYSVYkkHIjRWsd5THWqk+mCyQ1k0b/06w8o5zZijsLhsoS5USZFIy+7BWx02GgGHH
	 KreqZJZZmzGWkOzyhgH7+AiLwHLVPcTRdkDaQzNuaEwGEskFviuFVPKVWIfOg+VjRmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7FRU6awdXHMvPbHbEpG8TIjoCewQhUrVctb2GRnYQaw=;
	b=kztOh8mQ6UNrU4SDfBe70jUSMkyg0l6g2xWu9Sd7pKCF1Iv96Jl1IEjCHlgH0uo7NMLf
	 FQhE2qPqepZuYwRRuYZXq1NLeyEiPlp472CCorkoFUczT4AjQtF/XaO15tX0W4iue2x52
	 n+GeVzk/rH9Nezk2mAS5umNDr6PqE9gI2atMM6XamCiNoPYrijYl3ZYuvihWNAHYpMy64
	 +Pk6/P/GA0+a70YXi64BnbzU1fcdzE8jrVSQI5s1tdyhozq48MSWKewy2SwyE4+BtsZ+a
	 ZWUCgz9e0sFnJjEO5rGA1wIs7Hd1O0XLtO2G+po5AF/T+vSXFk3ynQrbWpVDrwMrujw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=OVn8cjm7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504524;
	bh=7FRU6awdXHMvPbHbEpG8TIjoCewQhUrVctb2GRnYQaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lklnh2i1hv30tTSco0h6UtQ2dj31K2S/c79jACAL+zYaQ3zzxmnCyMf2hD9YXWFwd
	 gmCDewNi1O8mQkwfWqF5pfa5os4VjraDzYighDMuTfMxdJxsjZ5QAuY1bP3MkUHaAy
	 B8Oy4xQXTUUKl42bPWG+bt93ZRg/dqRdrKyUsyCDaRuiXwvRxHnGY4H6wES+l81q7b
	 9GhDOZmLBQQN2FOXUS51xCClS9T4IWXe85waexOhreLJUtZ0ee3jMNthEgupKMayBz
	 zm/IkeVHnpQC2Y5z+vma8jKZF9gQru8RZzq/Eh2o4X2yveq5Ff9kh+q4zLPv8QJSrt
	 dPHi8blJSgRgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1A4040608;
	Tue, 15 Sep 2026 20:35:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7611F23F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56AE64067C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJzwbnZBlBso for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6AACF40633
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504521;
 b=bNwSy4lGTxlAizx9niaifq9oxtINNSV8Dr8e33yR12jHUUhCMRzL63NztlAn7SHOn9Ux
 cL1qxWBOPu0aG5ovrRY5n376SEpjIKUAAEhi1rlaylsF1mg+X8uC+FcyTeFx2R4Brk5q3
 yfKx7vTLAXLXCiJIoMUi9isc4ra4Sj/5W9gJ/mjAFzCD0lntQgLIkbfuuE6YFflGOUHQW
 Gz6M64SdpBpQWytI0UfAp3TSbRZ/smbnN9jRPKA1HbUZhWrjA9pRCkIlZnmkPo1hwtz3m
 xsgWNUtKqO93DzLU1HNI4/H1cMjMl9hIiGuAiym0i6LTyPFptX0sRU3a4eVj3Hw85LA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504521;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=7FRU6awdXHMvPbHbEpG8TIjoCewQhUrVctb2GRnYQaw=;
 b=LzId5mD2L1atv8ZfEJ6tNR1RXOVFvEfP2cJbJekWpp835a2JIaavf12VKW+JkhEWW7lK
 IKXeXTotADt6LzYKNinZFK3ZBaijkyk32goMCMdu1ADMIG9VHqtkRDpbUoujS79tRMwIR
 DCcxTSOmhgDTnE3069yMJWiL5E64CDMj6xIRzYDH/UhU2ubdQPPe/EQ3m/2xafbcqfRy0
 8fi1g0xurFu+BMD5gvhjS+ZuZQBPAu+iyXrV2NqQik1GHJGM7rT852qi1KY5dF/LYDoGO
 zpk2u/iN6MEPIEa5KftWVmIfdOQclH1RDxs6e3SychZvSJrWPa7D6o8EttvAPNjmOlg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OVn8cjm7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OVn8cjm7
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AACF40633
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:20 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a368895so164989b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504520; x=1790109320;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7FRU6awdXHMvPbHbEpG8TIjoCewQhUrVctb2GRnYQaw=;
 b=OVn8cjm7wHk0MNfhsuXWDZ3MdM8CjUNNMhZV1tN1MUzHCY3UF+qD7lPEWTf8pRUWQq
 bZUdYAbSoJop4Ubaz2deLdTTySr3N80k1zQcf8VT45uYIBw/bBXnBF6qOQMo2aXMjr8H
 ERUxpojlsEb7/IuELiP+RXisw49/5Zw8tv5xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504520; x=1790109320;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7FRU6awdXHMvPbHbEpG8TIjoCewQhUrVctb2GRnYQaw=;
 b=23hc45PLbocYveKvFxrBaj+DD7Rh+NTwMX8pyqH9tbMzCTNsDpcw9vDXXPCfEJXieI
 9Ko7fPpRiK1+/ygZ8533UDBCBZg/aP334eWy8OahQzm2PuebiSiQ9T/v8dYn7HIiN5Hy
 8NjTRzG7CZ8jYzZPstQNHID9M14ktV4dObw2Ku55aukmjPtgyjZfGOeyXJ3RICYmFEnB
 qas6WsxmOjLV4ejyo+brDTJypbA8lYgp47Ij75tDImYiZe3sDZ1u4h4xPFLlWFN3FBkB
 eiZpK2py/UFkbxfmiF4eCCgKzRhUzvYmsxcqVDoqM9TqkV/gqxlEaU7nUlFa5Fic11lZ
 YGhA==
X-Gm-Message-State: AFuF++mTZaetWqohYMa8m+NHXkSZmiNGXFyYyg2ai8IyPefCEnFzSsuA
 7f2Tn3EGwijGwrtsj/d/ZaxXY43vNwe0Gks3OorH/Yu+vnVqqt30YaZ+9BhlTpeeRvI=
X-Gm-Gg: AYBFou1qrB1zQr5ln2P8Dtttm1jMs0Ebz04tZCRBet0zmHIEyvYy2Z1CJyatOpbadk0
 6Dq8sK+ngNA3Iq/W2+RKyUQS5lcxtdPr8PpwbynuBFifgdXigOrSd6jyI6fkUwO5lS4k7fjLubp
 BrlPWp4uX+sIm/EViSfnWUEL56a/9/L0v4fQDZH1HlM7Hml7xtnfN0LjF5rS9HLKr8IhTdhkrBX
 mhe1gfy9UTr8B2t2sn+Ecx+R8Km3JdBIKGL1PmLj7XNWnMiwzJ0klmDr1AkPQBM/Pxhn9xBaJEE
 8Cv/NrmKe4ByJVeQfEgelEPpgt2STPfFg/8QQNyMtE63jaA/P6N0vv1s0uK3vW1QXKqUi5pa27F
 /pKgKCxRteVBLYHNnVNsmML8JQsksOM15O0wX8tU9mqWt1QpHJK6+n7yV8/hFMHy/U7EzGz5yxu
 iGPwciSDpgfxoYsb7p8oVNSGEaAsSTDTICGnH4XemWUm5Uuf0NGXFgOdHAbSSKT53KcR469Os4q
 vRp1WZZif/qJ7GRzcWKbr1ZkAGg5Lj4jLxA77R/q/0ba5H7pmKKfQm5EhwC4pqnkQEJEV6Zb2Mm
 Vr4+K0GAloW87JUOBnHPh7KvCzfA3w==
X-Received: by 2002:a05:6808:1524:b0:4be:ab63:df3f with SMTP id
 5614622812f47-4ca4c8bc0aamr29615b6e.33.1789504519864; 
 Tue, 15 Sep 2026 13:35:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260827-uuid-be-v2-1-2f91c9289b18@flipper.net>
References: <20260827-uuid-be-v2-1-2f91c9289b18@flipper.net>
Subject: Re: [PATCH v2] test: lib/uuid: Fix endianness for dynamic GUIDs
Message-Id: <178950451900.931545.18131404754064050660.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 27 Aug 2026 21:44:15 +0400, Alexey Charkov wrote:

> If LIB_UUID is enabled on a big-endian board, such as when it is pulled
> in by EFI_PARTITION, its tests will fail due to the dynamic capsule GUIDs
> computed by lib_test_dynamic_uuid() using native endianness for the UTF-16
> image name, instead of little-endian:
> 
>   malta # ut lib lib_test_dynamic_uuid
>   Test: dynamic_uuid: uuid.c
>   test/lib/uuid.c:114, lib_test_dynamic_uuid_case(): expected_uuid = uuid_str: Expected "985f2937-7c2e-5e9a-8a5e-8e063312964b", got "829f5cb0-1a07-5718-8774-4514bda82c39"
>   Test 'dynamic_uuid' failed 1 times
>   Tests run: 1, 2 ms, average: 2 ms, failures: 1
>   exit not allowed from main input shell.
>   malta #
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test: lib/uuid: Fix endianness for dynamic GUIDs
      commit: c3c81951f1286e638f67f778de4a6f2f67417110
-- 
Tom


