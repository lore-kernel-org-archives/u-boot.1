Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E77C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CF0C60B5D;
	Thu, 10 Sep 2026 14:58:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZGff2nFjE3Tw; Thu, 10 Sep 2026 14:58:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B08EC60B51
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789052314;
	b=mINKUyj4Lq1n4KBRs8KMPEONY9CXIGtAOSfspp7qjJKWxMVkcd/LPckn7LFkxW5nYZyT
	 Tc9ZZgZf5jUkJTIV0LzCiUAMy9b1Omhuo1HrRVNjxZr5wTzUqyftjNn4lqisSAhG4ZJx8
	 O+vao3rd28XqTxgavJzYSWVqZE2o6D+L2mWF9fsUK8lzX0RPLMheF27Dqn33hvt1YFndX
	 hwrwoDTU7aYOVS0c6CE50Uv5hC+YF8P9xibngpp1K9q6vi2NFNEAa5etJlvNmBOrQNvbL
	 1ZdiEaKPpbcrL3Ziex7xljrGGjyr6RVzGxoIwohS5Mv03k57ud42JforGGDL1crB3pw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789052314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+JwvOs8XB8pTmMIpbEgBeAYsSSjR8zJ1n8Pu2ZdgzuY=;
	b=ZZP6LjyBMTw4UPzEYD1V35jXgqV45/bWDE87g/cFttSXMbDo5TOm4ucPf2ouJct3Ifp6
	 whNAwCITSRl1mf0FfCooY0dVwccLQy2ZpFr9jL/B+vvBVYersdgEnZnC8w3nNXCwKrsxs
	 j8d6lmV64+XAaGY9g/DHGXAoYwUOoJXhCRkBTeDZWBF74+TRl1VujJlVn/3Nc1Ev7Am0s
	 9pk5Y0aDkLvs3f87wYD94QfBDpLcoxpf22nuBX2EpcVB1Ss2+Yjh5+faRPTAXlnu47C47
	 hFW9FVTTzIuDOtOF7Ey6fafibTgQtPDfalUw+0FbHGHnafM5LSspXOzszO1mhsvTWjw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789052314;
	bh=+JwvOs8XB8pTmMIpbEgBeAYsSSjR8zJ1n8Pu2ZdgzuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtNnkCs91Oql4UPji35C3PMmo5/OyT6tgCOx/mL61BSHRrIInmD7DyQRcyJA9xKHO
	 6rPpspr/HCkSP9PFGfKf0urmxQbd80ZSkKtApSHBE0CUXQ+m/Tba2HRZiddJSfCexv
	 OZDmcsNYeebNj78b4tR59D9j/w46C3agyq411CkPVjkFTVc9fMBeNZ73oB9kni4CWq
	 rerordELhMs1Xmt78G6jItfWKIj8qAK0pe0n9wTGIxHXjs129lIK3LQLlqsN7GU6GT
	 R42z+DF57Fmu/mBy09lqYpNYTBt8FNPJ68YzcelkoN0/XZh7nZIf0OJ25vq6xuYeK/
	 LDQAg7b3hEIbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B08EC60B51;
	Thu, 10 Sep 2026 14:58:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 106CFE11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF6CC40AD5
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 58BmQHlarc7H for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:58:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D79D40AD4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789052313;
 b=S4HwBzYGPRuXAVM6oHCRtoVrGkv1hEwzgIt8pGJM3It6sodYhAVmL785YickBLSoxFWV
 sn4Kaeu/0bCHh7bSHaPAA3nPiw/3BWwDPftf/HGIi7gug1ppHvZYgyOYhJk7syP3AW/15
 3DNJE9INQC4pBfDNl2xHVjycp/ukhdgs7BfVLLsp207STaZkZZoAQrLH/C4Z+UM2hqZWQ
 NhrcdJ9keSuiLGWmxKJCB1r0T0VBTePcYzRPrwfgbJ8jj2b2nGzBvuoR5/7ECI1r/MX04
 8+zt/olRrCW/7RNkShURr6bFPd6t4jk0HjMJpNK1/CTapi2RDnB4tRrENa+9h6jmS4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789052313;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=+JwvOs8XB8pTmMIpbEgBeAYsSSjR8zJ1n8Pu2ZdgzuY=;
 b=M8UHlxD2jVQnmtYWTyIDTwSdvevBiLL3y+lGhVtZurZlKU2B/82/exnfHHXL2a0hvL07
 cvt4b2ZBJAmesqDva3Da/v5qKhRGHtasQMnGjJsaH6a7UQWymqRFuGFFC97HNPKd/nQNK
 RjiLUE2l23TZQkinyjbo4oc76dCqdnoj9ZlmcHTFucu1GM9ZIM6lDFeG5QqSUAuxsyn7v
 u0CQvCzuNqe6uCfHBKhENCjPOYNwyjMTv4uC392mDp2qUrMx9ZfCZfBhCvXbuoYw2lK6d
 e5mGXfA9Je/9YenXeMWaG/vnv3M9DKuwgUSNHgpeqm6qWl0znjhorpX7SMdnwNu+tCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KRfjjflW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KRfjjflW
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D79D40AD4
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:32 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so92402365e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789052311; x=1789657111;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+JwvOs8XB8pTmMIpbEgBeAYsSSjR8zJ1n8Pu2ZdgzuY=;
 b=KRfjjflW5aoJRr65GCZ1RkJsEKvVrIJH54qXiJAY9eHv0my3s9eGt4exIqsvZv3B+M
 6fUVqbgz51qqSXdXI8Z4YEO9/dAmIYA0FZgdSIW+2OQt7Hdg0yJLMhaRcrxzen+Kk419
 q0mv8GGOl+e/xstOB0607czUEsrq6tCvezh3Tjwc4KjNK5QbJsB6OOsPZVmzEGMZCdxd
 18C4asHntWAafA0CHZumaWEsaQ5aphdZNJZDC1nO5WGQd7GHvnJHEdFuDp6eKW22btft
 jxtSq2esoX7tiy97jkAFrpStnd2cgsJNw6wQ0LCfAyrfLs7yr/3Fy0GVLbDzQXIwP5Dz
 g3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052311; x=1789657111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+JwvOs8XB8pTmMIpbEgBeAYsSSjR8zJ1n8Pu2ZdgzuY=;
 b=ZgYLAG0TXFZmxu0u/f81ygj2UiRar7+0jU1PDXHtsPzgTURtG4bN0wCzvSV6Vylb7g
 09QGz1udSw5PROZScWCkRebYRXK88IqWuA8FEsj3yySW6SfRnApCoW2YpooE7UXEjDAa
 u8wA8N4ZMWRz5p4YAWNSXSbtWIDnlykNUATTDdwNtqx1hs4saV9Dkmx1IGpBiA7jnqXW
 vksWzpfN3uYKQ+CeGzFUgTrIteaxtoWI0zXCcgia1A1aWz9sFnGoWWCYK2xvaXLM4lGa
 wsA1PGg0xEVwhbD9f8EmyuQ5lOhy7O1KWjAevHWoMyTS/QEA2nmEEXNUB7kzd3UEMoGE
 dr6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/nTMHPwG6ErYbFk5IWPFgM7qVaMj+RoIFKKG06U7pGiSn9RsUVbySlWvY12OJf/RYM26/OtY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ntJAthBn/9NqqbpUtVeUYeNmbAOdTlHqoit8uaJ/agYQsDXAK8
 ySiTlvUtbSlWffvIDHoKgrq2E5R3JjkiWayIDbuRY6GIfvQ6iKXpO+EN
X-Gm-Gg: AYBFou3FBuYgkCqeqcij5s+zcLDz1/3gW9F15AfZXMk6ihaGOWM/Pf6sK5HsxQOoguo
 ddl2LB9jg/nzEjFyRUPPdIdoQaCZ57kBvLXhjplTpS7B6lJ/F4R7Wx+E8LWCC07rntVM/q+HafL
 goYjzm+hL6qjh4JYac3J9GvStr/8pV81fG7u8S99hld52+KgHDUYASZB8kZUfgIEJwhEI6o2zJn
 iTd79oOOymWUt/iHEs5FDmoqpE2TLhg5bN/G6RAH6ixR0NlerciHHudscUlNuVMNUEOJLG+SGsC
 T9bzhEf4K7+MBi9k3KOHYkwfChQU9LB+vDnHU8CDv4mlJ0rso4r3RLFbv2J7GqvNhgyZywRp93K
 5D7w45dkMotd+O6cOt2C6Sn1uzeF/gA+m6yZ0M6z6zon3VtPyh0FhqHZt6RW3Kr/GqDAmQ3MOq1
 YbqpjKRRD5W07upK8zwOsmMv63LAi46Ia5d6K7USAg8UG35hGQtehVShLS8HYcq5kn8ZsP0Or40
 5fw
X-Received: by 2002:a05:600c:3b02:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49cf8220edemr444803685e9.6.1789052310543; 
 Thu, 10 Sep 2026 07:58:30 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26bc08edsm49121865e9.3.2026.09.10.07.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:58:30 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 1/4] gpio: add a way to parse a GPIO now and request it
 later
Date: Thu, 10 Sep 2026 16:58:28 +0200
Message-ID: <20260910145828.1275979-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFLszTjApvPONDB9bdyuTA8dqbWvgmnavsQD=Xy2nit4FzjNHw@mail.gmail.com>
References: 
MIME-Version: 1.0
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

Hi Simon,

On 2026-09-10 Simon Glass wrote:
> I like this approach. BTW clocks and reset lines have the same problem
> so we could deal with those late as needed.

Yes, the same two-phase shape fits them; I kept this series to GPIOs to
get the pattern agreed first.

> The original index is dropped: gpio_request_by_name() passes 'index >
> 0' to gpio_request_tail() so the request label gains an index suffix
> when index != 0

You are right. The three callers converted in patch 2 all use index 0,
so I never stored it, and the test happened to work because it only
checks the function, not the label. v2 stores the index in the struct
and passes it to gpio_request_tail() with add_index = index > 0, so
both entry points produce the same label, and the test asserts the
label through gpio_get_function()'s name pointer.

> Note that list_name is a pointer with an implicit 'must outlive the
> desc' contract

Will document. All current callers pass string literals.

> Also gpio_dt_desc reads as a peer of gpio_desc when it is really a
> pending/parsed version of one. gpio_desc_parsed, or gpio_dt_spec,
> would make the two-phase relationship clearer. What do you think?

gpio_dt_spec, then: it says what the thing is (a devicetree
specification of a GPIO) rather than what it is not, and Zephyr uses
the same name for the same idea, a GPIO described by the devicetree
and configured later.

> Please note in the kernel-doc that the -ENOENT return for a
> not-present @dt is deliberate, so a caller with an optional GPIO can
> skip the 'if (dt->present)' check and just tolerate -ENOENT

Will do, and patch 2 will use that contract instead of guarding on
present in two places (see the reply there).

> Please add a gpio_get_function() check between the parse and
> the request, mirroring what patch 4 does for the regulator.

Yes. test2-gpios index 1 is a4, so the test will assert GPIOF_UNUSED on
a4 after the parse and GPIOF_OUTPUT with the expected label after the
request.

Regards,
Mehmet
