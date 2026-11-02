Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A1606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jWl8w1j+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5ia7u25
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B32C60705;
	Mon,  2 Nov 2026 07:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaLLLsfhMRDr; Mon,  2 Nov 2026 07:41:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2849060687
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793605278;
	b=QxjNTzqcAejYUC263AY/mUpZIKihaZ/lxk98dwTt471DH36eFf5EFEpn2J2fTTOW+W3w
	 2V8poM3Eg6sFE3I4sr5SQjY2kj/UuAX2lJ647TkkwDrkyE7mZY7dRO3DT5tH0i8hs2OLv
	 kY25fhKjIVBda5YaqZMEX432Z7ztRvOTFHON+BjJXcyOu9sHgl9G9nRFl6p5AfIinjxnO
	 +8fXSqiQSb8sOkX072rCDrEAHNpg8JahQKY6xTVXdZTzP5EJHsUinDg3f5sp/qji9uTK7
	 GQnB8HBcPWoOucSd7d2/XZ+WNdTdw4yXUMkNRNVq3qyTIeABac+JPs4OS49viUozqrg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793605278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c7Aq/WmQaw+/DcPTmRviqwQaVDMBwxD4D8SxcO8wTVM=;
	b=ExYFT4e2aOSrjmGRawVyMbiZlM6E9wFovly6XQGTOGTQpAvDan5Flay/wzff8++uNDXr
	 bvV+L13Vk7j8jz4lRlo0Gouj7e3wNKTKgZgetUfbmHQ25PqK4ruv1LkimeqW/AjIEroQI
	 JefuYeGVpXAyv9YC7C3Jt4NYQi+ThzNdOPvZeomMKrscX5Pfaaq7891Lh6PRnPy1C0x7L
	 h5sPMd6Yj09Ep1nm8+t1BR6cdkG4vCE7RIZQ3F3LJYyaLyTd4fMOs6oJc4NfoTbCgATmI
	 te1WQbuZ3ugt+0EpnNBsFO9pg8dGGktbtjSzBFTObk4EHZ/JJ+oRXP9wCS2+7ggXPfA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793605278;
	bh=c7Aq/WmQaw+/DcPTmRviqwQaVDMBwxD4D8SxcO8wTVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jWl8w1j+9dPs2gYCJ74y3zZwgA+Y4LworizdFNSLH+s1p7BwZAl9rmB+V6YA3DDXV
	 HQdDL8VdVjwqm9JW9M2UrLzffBVyGu7OxXKSmZi6yh053PsPmhzXJBmFtwtm9tjTai
	 mDRYKNpaHUOQK38F0IC1bHoeME5tA1UciLViiIh/RTn7DY/kFZ/CS+YwFgHIUK7oi6
	 Nkyg4qAgTBkfB6hUZJfwI9gz4B7K3Sr0QziR4cgtbfUSQ79QtFzpaP6A8852J56BKS
	 zF64E3HqiznLI24BS0budZXW2cAHujJanjA1Wj5PXWQgm+eX+EYbplMcgOqCCu0SlI
	 TA03HSDz1Vk/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2849060687;
	Mon,  2 Nov 2026 07:41:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 328CF356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2391080DD2
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAkmDzOINUe5 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 07:41:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A63E80E16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793605276;
 b=lBb4zbhoYxZwPKYWBYSDLemepg51vh0YAbf13Jxpe/Hb0hnwNLCoefj3GoYi+druyMXT
 tD/f6r4XuLDusBFHxJ1ALzuL3Tv8tlBZWDnFNAmlyXtYLCw1+uK/HQELlTH3gFGx8Yvwr
 XwG0S9jBTbrrdbaMSDn3E5HWDWSDEgXzji0Zmw9aEV7hu12o+lFO200ljjt/lkWg6Yhkj
 NjdROZIK82fAe7xwsKlgLWk/3s770CEOicP+NkRNfSzyO1fDKbXZggbwe3wLyuOJgWkWN
 zY8STUrkG02ugt7GEwQS1VWvQmpKuDIDMQthm/N8tpwFbjl7IXP13U2glBaSkIwVztA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793605276;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=c7Aq/WmQaw+/DcPTmRviqwQaVDMBwxD4D8SxcO8wTVM=;
 b=CL9cBUZ8uGekNTq+i7Dx9l7rq5hNi/ixblQfP6yw1Y3z52g3s00aC+NPukO/ICwmGElI
 6t78gH87JWzU0KiAudomruK4U9eS04aOsr2U3vkSObSn8Qaw+/G1KmL/LszWlj8/tUMV8
 tXaW/UZndiWPZA1Tri+08207CRadZD8Dca8YJam7OO6jUAkcKV5FA8FJFJgkiIv+H5XsA
 IIJ6FyHjlG74y1OS8AaZoX8g9lY6U/OeD5Ro5DAHjPLo4lPW2hoWj26JYIF+PS3jtJuP7
 t6yK61tp2z5m9O0Hy16NYG4+4V5djpBKMdpTRUrdGdYNoRhs+sAGMahAbXhnT1ZfFkw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=u5ia7u25; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=u5ia7u25
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A63E80E16
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:41:15 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso409989a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 23:41:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793605274; cv=none;
 d=google.com; s=arc-20260327;
 b=jU/YmVY1eRm8WNf1c+dC5tqD/0esC1pWRZ+Fws0Ha8Iillo2ruLOVZaQGDE53mW+04
 DVNQ1VlFr8qcgx/meF3biEC2nNRQGGrczXbAVQMSKKXxabYmw9UumWanMT84Ro6U94xn
 wEJRj9nL7L8eGA1PHFSzM+JIfdfBiD8E1PSd7kUiypwbzR+0Yh3ABRdA9ovtyytEfD4h
 XekUOO4IhvAXsYCNYBJH/C4tL0cc/H4+qNQ8XsWwNYhIBD4GvvbAc5M5fQUZB6E/19Us
 OV851sUFvbe2KDPfinRPEpPs4/T8WvqpYg+kvkMPf8hAGRHTxFsvyZj72v689C5vWDVR
 Dr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c7Aq/WmQaw+/DcPTmRviqwQaVDMBwxD4D8SxcO8wTVM=;
 fh=xFjKl+NcFhpcpZHfPm+zK3dkUYE0WquJT9FdY87enho=;
 b=dDEISIY5JRANLRYy/ya0OHGK5/ocFJmrPRVWi65GR6S8Tb/veZqkMzIQPahsEa/D3U
 ngUX+SWTz/k/1Yq+Bs7ev/SQGItdCleQxt2uDQzcs11pLuyfRWFm/ruoKzK3H85Ha0Fn
 A/L6Uda467NdjWhPjwEz9CsD9ND8MHg1tvJQl7Jc6ofrUJtgCkd1KzWvzicVoQLzicrQ
 DyvFmv09zrx6awBGLrOSSzLzNzLO28nmXCSzEfxwsDqGUDgeotafnqDnx9PIdp9Hsj6l
 yunne4lAChg0IpQsjDF1QLXEtmoI0wV3F97MNL/+Nq1NwMWmu3dewq+SyzCtIqDdtGik
 npSQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793605274; x=1794210074;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c7Aq/WmQaw+/DcPTmRviqwQaVDMBwxD4D8SxcO8wTVM=;
 b=u5ia7u252U0VUuqXVHHE4XpMAl8Eh/VHD7AGe1rNXumG60dstOaOL4O3nsAimFU21y
 EpI4NaB+Mw6WstvBsNWIbKW3ShIo0PMOTXW0trc8S5JwWeinEjMCMBhnVTIpjB47lDtS
 BhIHh53q+EKFZn7jARs3dGSGk1GopHM5jCZ/aTjF1OPaV9LyQmc1DyfqJXhIIAiMlolq
 09JodCUcXkU1dIaBBTSR/rqNR8wXAKvTkZLKmKZq4cc5Vy4pvDTu4IXzuKYIkBqqZZ4z
 t4w9XZlygi+R4aaQ1mbpWkqaBbcTPVj1v8k6c/7eEs4ZJCMbQ5L9vvY5X1Fndg+eoRBm
 +9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793605274; x=1794210074;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c7Aq/WmQaw+/DcPTmRviqwQaVDMBwxD4D8SxcO8wTVM=;
 b=o67X/PlGphsaslle0i8E+SjTyuDIn/0uuU+LPO5QcgBiYd5pnonkBqOxsbCC1KJ2FY
 o9iNbqtkQWPXHvRw7ky2LtUpL9EsJp/lOvc46SnGgDby4VI/1O82UIhT2fRSW7RXvhS3
 Sf22FBrkc/9zJUule+vt/vC2tbzqKVA4jS6TLegjLsYAyEeJRkKHNrlPclepHX0Zd1ZP
 4FvODuGzO6g3s0zAF8zTNGALuA5WpvKMcSnUZxk7MmSGHErdfreOBQOd2zJr5jyx9L6i
 mKzCSZRatjgWB+yb5IWmXH12IQMyx+KNQ/mShaYWYZkQL84EXoti7G/u/aTLQTJKKHwG
 rRQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbC34FFqW3Khbx6xahmeKsECRDszNfMXoS038wRLqfvBIUCoRZgREf9gboOQjTCbgytmZ+jrU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/5djCAgsAbj/EutfeN6CJtD16b8hYwh1hHJph+EMMOAnEzCkQt
 bYxna8xv0U6YEPfWEm23d3T8xQiJ4tJtmbzdMeW19zHxxB1Yq8RJpxZtNgJjaFJiEixt9krW02C
 icMisJFw/kn02mwhFYuzUHBU6wf5QpJA=
X-Gm-Gg: AYBFou2SAPKd4dwTaWrhmY+/7G31GJmVPyhIjwNrNIoOpftWQUdc0Fuwy/ee4rApZ4o
 LFu6ro28z//rY3WFBmrDY0+RpbhpqH6KpB5vxbZP5q31jUdUHwtiyaTFzdfx5tvB4WYEVKo4N6Y
 TzZmkJLM/SoYIY/PL6mGdKCSc9vXV0vdF5n2gQoPJNkk5I00aPLQDeRYEuU3cim2KWeOibiUrVX
 tW9IFbKOJgvH+ea8jcH3OyABzA0ZGcAo02HWCnz+BoIoZb7TOAcAoBlxe0b+jM6IBZeLKfcB1m4
 PGPWuHXZGdTSCeQZz9/d3U/RLj0tFRiBh7JgdVM6WHjlQsCygHoXtRMGHH/nDy5HDcoUb15fHFI
 pft+7XOaDd+8PSPDhwlXqU67vpsj+SYvjIvg=
X-Received: by 2002:a05:6402:689:b0:6ac:b861:dab3 with SMTP id
 4fb4d7f45d1cf-6b4d4d785e1mr5230751a12.39.1793605273413; Sun, 01 Nov 2026
 23:41:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029134705.3767-1-linux.amoon@gmail.com>
 <20261029134705.3767-2-linux.amoon@gmail.com>
 <20261031115645.3197359-1-alan.tseng.cs@gmail.com>
 <CANAwSgTnTtozrtCj498eDdZMN76Lkkyixsc=9wr6zEXpiebi4g@mail.gmail.com>
 <404dd2df-40ee-450e-b8c8-42d8509ba6ed@freeshell.de>
In-Reply-To: <404dd2df-40ee-450e-b8c8-42d8509ba6ed@freeshell.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 2 Nov 2026 13:10:54 +0530
X-Gm-Features: AclHuK9IW8NkCtxAP0Mg4kqJ4DupqtQC6HpmtSo4gxNTFeo0N3W84Ndy2_6FEtU
Message-ID: <CANAwSgRypS_Vs0Cc=ZbN0Cy4NqumP8btpunCk0T9T94T4opFbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] riscv: dts: spacemit: Clean Up K1 U-Boot Device
 Tree for SPL Initialization
To: E Shattow <e@freeshell.de>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>, u-boot@lists.u-boot-project.org,
 u-boot-spacemit@groups.io, DaveWK225@protonmail.com, eric.chung@riscstar.com, 
 dlan@kernel.org, pericycle.cc@gmail.com, tim609@andestech.com, 
 leo.liang@sifive.com, me@ziyao.cc, trini@konsulko.com, docular.xu@gmail.com, 
 raymond.mao@riscstar.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

H E Shattow,

On Sat, 31 Oct 2026 at 23:45, E Shattow <e@freeshell.de> wrote:
>
> Hi Anand,
>
> On 10/31/26 09:45, Anand Moon wrote:
> > Hi Hung-Chun,
> >
> > Thanks for testing this series
> >
> > On Sat, 31 Oct 2026 at 17:26, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> >>
> >> Hi Anand,
> >>
> >> Thanks for sending this. I tested the series on a Milk-V Jupiter,
> >> booting from SD. It reaches the U-Boot prompt, but the SPL no longer
> >> finds the PMIC:
> >>
> >>   Get board name:k1-x_milkv-jupiter
> >>   No PMIC (-19), leaving rails as found
> >>   DDR firmware: [0xc0820740]:0xf0227179, size:0x8d98
> >>
> >> With a Jupiter -u-boot.dtsi that has the same i2c8/pmic block this
> >> patch removes, the SPL sets the rails before DDR init:
> >>
> >>   vdd_core, value:900000
> >>   vdd_1v8, value:1800000
> >>   vdd_1v8_mmc, value:3300000
> >>
> >> The commit message says the regulator configuration moves to
> >> dts/upstream, but k1-milkv-jupiter.dts there has no bootph tags and no
> >> vdd_core/vdd_1v8/vdd_1v8_mmc names, so the PMIC is not in the SPL
> >> device tree and pmic_init() skips it. It works on this board only
> >> because the rails come up at usable voltages. How do you plan to let
> >> the SPL find the rails?
> >>
> >> The new file is also not picked up until 6/6. U-Boot includes
> >> <dtb>-u-boot.dtsi, $(SYS_SOC)-u-boot.dtsi, $(SYS_CPU)-u-boot.dtsi,
> >> $(SYS_VENDOR)-u-boot.dtsi and u-boot.dtsi (scripts/Makefile.lib),
> >> which on K1 means k1-u-boot.dtsi or spacemit-u-boot.dtsi. Nothing
> >> includes spacemit-k1-u-boot.dtsi until 6/6 sets
> >> CONFIG_DEVICE_TREE_INCLUDES, so 1/6 to 5/6 build without any K1
> >> overlay, which breaks bisection. I have not built each step. Naming the
> >> file k1-u-boot.dtsi would get it included from this patch on, and 6/6
> >> would not need DEVICE_TREE_INCLUDES.
> >>
> > I think configs/spacemit_k3_defconfig uses the same approach.
> >
> > CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
> >
>
> Please split up the dts reorganization changes into three-or-four
> patches [A], ([B]), [C], and [D]; The initial transition to this as [A]
> should be not adding or fixing any nodes:
>
> A1. New file 'spacemit-k1-binman.dtsi' with '#include "binman.dtsi"' at
> the top just after the copyright identifier
>
> A2. '&binman' sections from per-board k1-*-u-boot.dtsi overrides should
> merge and be moved appended to spacemit-k1-binman.dtsi
>
> A3. New file 'spacemit-k1-u-boot.dtsi' specified by
> CONFIG_DEVICE_TREE_INCLUDES, with '#include "spacemit-k1-binman.dtsi"'
> as the very last line of the file.
>
> A4. Merge and move from per-board k1-*-u-boot.dtsi files any properties
> in devicetree root that are rejected by upstream for devicetree-rebasing
> subtree. The content should be inserted after the copyright identifier
> and before the last line of the file '#include
> "spacemit-k1-binman.dtsi"'. An example of this is the memory controller
> reg override in which we specify a sensible fixed-amount value so that
> the bootloader bring-up can function, but this configuration would never
> be accepted upstream. If not for [B] this should only be the memory
> controller reg override, apparently.
>
> B. Resolve the presence of /aliases and /chosen nodes in
> k1-musepi-pro-u-boot.dtsi compared to the lack of such nodes in
> k1-bananapi-f3-u-boot.dtsi and then upstream and/or merge and move any
> resolution to spacemit-k1-u-boot.dtsi ;  I do not understand the
> implications so maybe you would find that this can be ignored unchanged
> and then removed in [D]
>
> C(n). Import to per-board -u-boot.dtsi and spacemit-k1-u-boot.dtsi all
> the proposed upstream changes (i.e. bootph-pre-ram hints). These should
> be grouped by upstream patch discussion thread or commit id so that from
> view of u-boot git tree one upstream discussion thread (patch or commit
> id) is referenced in a comment within the dtsi file(s) that import it.
>
> D. Delete redundant nodes and properties from per-board dtsi places
> where they are redundant. This deletion is not combined with [C] because
> we should be able to later do a git revert of [C(n)] when a
> corresponding commit lands upstream.
>
> There is going to be a considerable amount of per-board overrides that
> are identical over a subset of per-board override -u-boot.dtsi and so
> duplication is preferable as it is (from U-Boot git log) logically
> grouped by commits that reference a particular upstream discussion or
> commit id. That is also to say further organizing some changesets in
> additional dtsi files to be included from a subset of per-board dtsi is
> considered, but I am not yet convinced it would be helpful rather than
> just duplicating it among the per-board dtsi files now and having a
> sensible git history for reverting later when appropriate.
>
Thanks for your review comments.

Yes, I will follow this procedure in future patch series.
For this series, I wanted to have the changes tested on another
development board
so that I could better understand and follow the proposed process for
restructuring
 the code changes.

Thanks for the guidance.

Thanks
-Anand
