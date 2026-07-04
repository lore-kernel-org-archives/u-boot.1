Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E052EC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 11:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066B88341A;
	Sat,  4 Jul 2026 13:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="bUoNDNK8";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="mASlJZcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F7D684119; Sat,  4 Jul 2026 13:22:35 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B010483314
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 13:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 922391400054;
 Sat,  4 Jul 2026 07:22:31 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
 by phl-compute-03.internal (MEProxy); Sat, 04 Jul 2026 07:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1783164151;
 x=1783250551; bh=eR4fbHUigcYe3whCtOMndykBeTXX1Ef2A4bCAUs8q/A=; b=
 bUoNDNK82WaMpyP025W/amKQnajm5w7PF5dzeXZ+Acw24fkE7iXavB8sMkIA0/8J
 353Kv7PHdOOYYRrCTLZtZbq3laKFYZ27WDbVuab77KwDHkHl0+CNsAeOqjCnz9kK
 suPJxCbAFlzzVIXnpe7DfWIUztiC0WFxuf4Rd7M99dqmt2UqTEjF49hrMDpo6k04
 aclLLurFlP+3rTFeFhsM4PtF79py9Be4WahmLKoPl2CpwB7yw4WRJx9mmNOBYPQv
 lW+488fQtCwJamjJobQZzSPtNdBRk75AYiE3OAFnjImj455K/0yAr6Y6+5l3MLwF
 VcNpXe6h78Z/m6uxVl70XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783164151; x=
 1783250551; bh=eR4fbHUigcYe3whCtOMndykBeTXX1Ef2A4bCAUs8q/A=; b=m
 ASlJZcybPEeescnSPbPKkJ5w6PaxmmgGmrjLHJIRRqb83/cipfTdpiqPGOqwaMrd
 hq47ZO/KMKehzZCPYCeixQ1KsyixCOOdVUDg7iZn+jWMvDz4HLrLNlILOyBnNG8O
 8REH1Pk69KHkyKkNaAoJwjKh+dD4gyp2f1urAMcgYEIi0nf8eIQ70f77UIhVRy6u
 aHzbT6yyLC3rAuEIEPKawgvYgsMSnen2IKIDcOJ0NfQm7voOHmTBUHazSUGU1GxT
 5c1FazTRCDWXKo7sKfVd3QnUWtUMa2rzR+/H5lMBp7gY6EWGUErImvyoIyH8OKaQ
 ebcwieGUlWBXByacEZBPg==
X-ME-Sender: <xms:9-xIatnrOBKhycgLfB9BXltBX4sRmdR6evWQQt034LMxHEXtjqFAYg>
 <xme:9-xIajo1vFsnwSmIp7gzx7r_rJODYvQYxRhS6KMXfElONEQQUKIy5d72vNOksgiv5
 PG52bTxRIw0uWDNg4aM2xKMCm05kpUjM4qpJmSXW0SbjqkkYSp0Uec>
X-ME-Proxy-Cause: dmFkZTGWhhl9DPnVBEmqd+SYKx/F6dHncl6NmnVA1Lv2UcbN4Isspyp9QZrH15M6FVnEzy
 zbpCzWZLRvBV/1sWBsia254+kqIgnnLZlF5V2Lxszl0VhEmPCHLL287eHuds4IeN1vtTXI
 2xKRzkkQ9/1flm6d6x8z3fPXaRh94SHmAgmStjBPSKKZW7GErfl9ciwDcn5TDuc2PRqPZk
 TyLuvYkC/XaUu8lV1lUqBsYv6d0TCa1XBqGK+fAGvuzQ9WxOwv4I9K3ggxyppD6LEw/pQ6
 VaufFTa60q0std+ZU0KWKKUuCDFKY6vxtpZvtWQuthjdPf16/rCQ4PYQ6ktUh7CVN2CxB9
 vreW1ZRsouxE+Pg6DfGW2aM4aRzvzpoQOaWdVNjMSTIxNPFx0gtxr0MVa0VdNEGMplPsuG
 YYlcOchqvnZ+vCfIPEogjDfUnhpOlcAH4XtLttBiKB97q3gMjiNUuYtIC1E4uLr6m/TJJI
 axn40jrx7EXLMRnV/MS0nZUB8rWPQJZ+8MZOj0Jn7rgtSg8RpJMUH5qoFa3v8buRBAWneH
 lYCT8SNPdpih2plbkyzIL0M8qSGtS3R/hBBO745A51AXgM3XVg+0obn9nzvEp3m/Wn/kM/
 iSJ+unP+FOe+LoWGqH1xeNs+v8CShB86vZxo9ahL2pQ4LGEdlvIXcyJo+uxA
X-ME-Proxy: <xmx:9-xIajRD_hGoPRzO3oZibfGE-Y9ud_gkJ4CEbFbZnMlj1zx3QdyZhw>
 <xmx:9-xIauHEgAm3pVxN8YhGBhMF-n1mzLMZQAirDlFJDcbrsi8UWLl0kA>
 <xmx:9-xIagHJl8Arit9Dp2XoGNhv_Ktf9AzwGA-rNEfHzVj4btJTUkS5hw>
 <xmx:9-xIakSaUxnQPZMa5wPw1dyoSXMAlUFc3pGqqe5vTl5ZqAIMoVsDXg>
 <xmx:9-xIaqHcTNLgc5kq4mzfKmLLwl-sPRhnaba_y9DQmKyQMBcuPRQm4aJf>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 0CFEC18E006C; Sat,  4 Jul 2026 07:22:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A533ldWDlXLR
Date: Sat, 04 Jul 2026 12:22:09 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Yao Zi" <me@ziyao.cc>, "Simon Glass" <sjg@chromium.org>
Cc: "Tom Rini" <trini@konsulko.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Message-Id: <d82a1bca-cb31-46a2-a44a-4397dbb26575@app.fastmail.com>
In-Reply-To: <akgXnCSJC3splAlp@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-9-me@ziyao.cc>
 <CAFLszTh8G5hxAOUocaaXffKA=7PM5sp90M3+JBsieG908nFBBw@mail.gmail.com>
 <akgXnCSJC3splAlp@pie>
Subject: Re: [PATCH v2 08/16] LoongArch: CPU assembly routines
Content-Type: text/plain
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



On Fri, 3 Jul 2026, at 9:12 PM, Yao Zi wrote:
[...]
>> 
>> Is the nop after idle 0 required by the ISA (to guarantee the
>> wake-up completes before the load) or just padding? A
>> one-line comment would help.
>
> I don't think such requirements exist, and LoongArch instructions are
> always 4-byte so there's nothing to pad, too. This is likely
> unintentionally left when re-writing the assembly, and I'll remove it
> in the next version.

This is carried over from Loongson's UEFI assembly. I'd rather not to
touch it.

Thanks

>
>> Regards,
>> Simon
>
> Best regards,
> Yao Zi

-- 
- Jiaxun
