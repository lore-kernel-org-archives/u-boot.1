Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BA606A323
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SK2Hd/Rd;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SO9wM5oN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0B1560762;
	Tue, 27 Oct 2026 12:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ft8gdPxZG_JY; Tue, 27 Oct 2026 12:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A439E60725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793102548;
	b=qKBaSBUfVG4y09N2oLUo9GzJsvEwxpydbs5sRaW6v0d1+lQ9BMfuEqqQiuW7LJY9gUbK
	 P64zBdf+706TnGZeMou9sKJ1bespxBbz3rgyON0ZxeeRN7CQ3ybEdrwoyZR+kHbvVMEhB
	 vGxSjb4PsOT8M8NK1E8yCjJHze8pL80jAqDe69ler0oUaFLHMZz2WImRZOeEZ7a+lk7Cx
	 2EgkJc9pVmd7ht3x6jbdqGiJQkvei3wrBACONHlPd8/cieo1PohLgxIBAR5MyvvphUy9A
	 VjCvP9hJ8fQzMPaL2XCeKJWVjdRjhQRxYkmLFYLdVhxS5w4SQnpewhACWBKgI7QN77g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793102548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yOfJTEa4TtQglqYB9Zg3oE/cfcziJWROomuJw+rZde4=;
	b=XTRMKyB+Ix2vUGmO/t2aMvor17r7I3lRQ/Sc1bJzhxLplyrvCKLdUdNQ2TbvB0/Bb+aP
	 1IF6h+hXcyDe6/j19oJY8r4oFMlyBg6uE7rgWEHOroqoNncPDAjKg8etjTq4HHFFfsjK+
	 ONuzUK/CqLiX0OP+36tkK6GYplNJnDQaTzNWp3iKvCFoyebDk7kvpwA62yhu9UshEMiOR
	 F1uOmSzeRzeMGzzwJIfbUY+JE4/yBLvlJWrUbqOQKDXqeFzlh2b8TaadEj5KSnHr0oemt
	 NrUnRs+7Ufmc86jj1UXNsAafvaXoLiVh0CujtudWizCj/O5OjMmEJkRNISUyWSPwLjA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793102548;
	bh=yOfJTEa4TtQglqYB9Zg3oE/cfcziJWROomuJw+rZde4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SK2Hd/Rd/Ixd0GqBHdp70rJA3wwku44tPc4bvtj5ytwlWu9j6AAAdmxB5PZshZ0nu
	 WbGcV07zJ4LFBUSX81BgZ3Zrb/9nDh2B7yZoy7LaIXcSJ/7frc3mKrzErckBZd/rOV
	 qjIR1yY4d9ADF+DvSkVM0yAtCuvMmymMzoMCqme8aSVBH4rwOIUjh/ljo4n7PXMBAG
	 zMQCwwk56h89IudpwFtp5dOV78qFhdo3J6j9iZQyCZ5tnwcU5n+4FLuRmP6abbf028
	 hkpvkuT/WipujK+wPhr7MUErIK+nqj81eH+ux+A8aTzTuLc/zebKlllgNvdc/B9aKY
	 0cMOAIEViFUWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A439E60725;
	Tue, 27 Oct 2026 12:02:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7287D120
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57A0280D99
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:02:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6jeG_Tt0gfY for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:02:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0EB480D96
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793102545;
 b=iw5qfCZJF9LqBt3E+XmBgXawtOzP+HDwUceqPW/I0+ZDfKaLqEWdB3FBPf3eS1omAT1y
 U5hARcFlWTLJG8VfTFE1Bk3iCLqZrn7JDiHBRp0cOusIJcJHgJY10jKT+M2aSsCCQyQhp
 xmEqQCu4dFQ9zp2vUmcrq0sbiXPP/lBXPvGLgWmPuefbSs5HmvuzcX7TeQbk1BrmXB0hy
 rBL+zPuJPOJ7/PUznxb5yykplja40o1ffzRagifKa52S0pEXqrE6oqAqvo4tPVp2pEtJq
 6ok317SkkG01RL4RHQzjVmUAVolOHOzeIrPUJQqiS0x+sjDo8NqBK0Nj54CG2sa9KOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793102545;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=yOfJTEa4TtQglqYB9Zg3oE/cfcziJWROomuJw+rZde4=;
 b=CF0WFgqy26nzZqC9GqBHpw1Ucolfmus5Y7Dach9IWissdA4PQhSwrrpJqLr+07UnIY32
 6L3EHVQCTeR9tiP8QKLsUNGxjT866jQFf08wrEv5N9t7WGLiseClEtHSQTCJ0UpkCl7j7
 Ajmu1TMoeBSGGL7SDM2an/qdxWaRbJBDmSEUlnINmhpnGmMoDNAS81MSBQUsqs33L7ClY
 +SB86yh7AlpheluquZZiUGwfLm5juzV7PATMQQUA2DG3jtcxCATZLRHinwXMV/q4fe69j
 BGLUBklDjHmZVe5b0VAYGRhSlMX+X9PSFv6Dw4mQHA2QgGlYNQNtLoH3DasbOVKatcQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SO9wM5oN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SO9wM5oN
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0EB480D96
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:02:24 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b06c0794cfso34381497b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793102543; cv=none;
 d=google.com; s=arc-20260327;
 b=Xlt2VSdBc/2xf+3dfnPVHm2WE29tbSUm9G32LVXW0noPSb8UxB9pK9AJfcPy3I8qTl
 O/YNUol+/wV0j4O3bdQ+dm9MeIRX3ijYj91jAxwSFBCAunI3HaspFDb3vKusuxDc63sf
 q6gEoniBGNf8j3S2hOC9dm4P20YhSHo6C8L1l274sYsUoOUDHux+rzqMfcYQwrll+0AI
 vwCMsA1R8My7PHhhnfPutg4mcy8pklkLyUntQkIdKyjK7Z9J0GEeSzrNczq0pReLIzBs
 kl1uZBsQVfYaJK7KDdulUu6U9NPihHuAJMSaLQLQ/WJKa8i2yHRjP1823KxnzE1+1o09
 4WpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yOfJTEa4TtQglqYB9Zg3oE/cfcziJWROomuJw+rZde4=;
 fh=kEGpvXNRRKFhiBY8zORi52yTshrUaKtn1YlRHaLhgDc=;
 b=hc81hEGCJdlikdWAYHI4E6wRXZz6PhN642r/1SI+pxTPY898ND4s9zsP1QOz+NcN3p
 20NCYkLH8FM3pdHPG9arZMV7QceXf7LH8Z6JVyc9VXAuuVU2irGUYO+ONEVbZfhIs/h7
 JKu74LbJYZXaBPQUkfIGFH/9vE+ZySHRjcIfWwUdFCYr9m380pucYH7buqVHKWcBx6pB
 +1SNDjr7J4mGj2gK9Cm7FPp2fABvfx8GIDdIpq0rYWRSm06T5LQ5NnFWQ1a1PYToJBlK
 TbftS7UUYAp7PVWBVuL9wzd7/e4BpL5PEwIvbYN6923YblmMpDy5SZ+sm83/xDyntc98
 bsKA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793102543; x=1793707343;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yOfJTEa4TtQglqYB9Zg3oE/cfcziJWROomuJw+rZde4=;
 b=SO9wM5oNFm/vptrVLH4Q2WpUuY5V6i/J71N4NnygAa+4wvCe5bs6CAhynlKIU9qN8/
 5Q9Bxo1llNyGDetjdRnnCUf+rm4QTAKXA3omeQW65bL25Vw0pgEa0HrGAcO7V5pLVJBe
 hkWqGp+G6Bj+Vz/qvEqMjfMf0NzmtobUCPfM+Po531RLM18jf8lZsHdrpADrqMZ3ddeq
 2IqQFcqpeuQPUCBf7dLj2NkKQ9fFIFCSnW/yVADTeD7afslX5Ga4pc+fN/itNmfi29zn
 xSbyAoPOUd2K6v85CVFkk/CSAIg+rPliL05+Jc6p7CsPQQdqkEU1vIMCzLTqwJjYNYlN
 H7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793102543; x=1793707343;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yOfJTEa4TtQglqYB9Zg3oE/cfcziJWROomuJw+rZde4=;
 b=LJNi5CQMjMx6zbG4/HeQgWfCzLDm5fxvq4vWm4G9SZepB/n3hCdpEujKmN95BqLVhR
 2FmNXWkeUpCZZRlR5ppKfR8rHdxAKghgBbWnlu+B9CS+18nLv98D7bPBqsxhtBzJp1Fy
 swtS69klLYb3BnDawzOyqZsktCtWNdYzHT8mpDJxhSnnX5Ycti8sbvBx22tASq5eRHEQ
 Wl8UnGinEjLmMP7sOwPoodRCTjs5NypJCzodrQZYjPSU30zs9hIkTQskoSV6EqZ9n1tt
 iIUX/m01tdAz0QT4R24T4ldEob4NcevK1fnk1xixzMIPwQQG89/8YrcpUYB/HR3fS4KL
 knUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBygzZh4zfDVn0X0Tw2sHvmZqQTcb4fvw2BLrQmG+Ns1ZxerViOrEmphKPN4QrE1Kw8gosl8SoE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI26Qkn1sE9D711SRLaEUr2KxU5vHLRetlxT/hz5NN/qOn0TH9H
 ekT/K7DcXSJ+WTFDe+6sXab5URcm05Io3CUIqHiTaJyUynvQ1LWmpSUY7UFa/a8D2mlzP6szWAv
 09y20Vm4Y8CUy7m2yBp+oqOmtOs51hL9m5rr/q2B8Xw==
X-Gm-Gg: AYBFou2iR5vKcjn2CfmDsfEjfdvXOU/1erXWiOfHIlOibiIS0w+RnwjeqNRGXVCOGo3
 +J6wMo41W4B3J/mOzik+ybk3bs4j1Z7N6RoMKjsMm0VYYEVgkCDZGaSmTYBrodO+LQM0PB27vl7
 HImmniGaPuo5fQNStOlc5Cz8jdnlwxAg5xw7Y+JvKOMuWcek5Rr+TOzLBPkF6Vs1o1wfEmxhPXn
 H/s2mpatYer0KSK5M7Bz+8BH+2xZd0h7RslDgc0Q5rbLQ1tS0TCAVtWzrVH0pcw5IMGC3VagVMF
 NrTIwRjfEi9kt7GNOJ7IOPfcobp6VSOpUZydVXCjNs6NgyjCXNLLQDFxzAHifnuGgYNJobZ2q4v
 gxcqqe62sqPBEV+lTznYWtJQvvqfitKlGuktrCyUIG4rK7juQYEkhhbhf8awnEOO2R7s9U6EXu8
 pBE5IRv7vxyCCBz731TZtjVjmFdqecksnya57u3JaNxLzs1gm83KKSIDLJ+XzEPAwgBdmk3YbvX
 kerxc62Scbgu4GmpGFM+rE/c5tGZYfJOSvHYLRIBEqctM2pPQRlFQqHcLs2PwQCAC4q/caLEIqW
 vRoSZG0vUVpaDtzYyd0pSbKsaHkw7cWPcLRsAoM5XwpzqGKsdyZnFx7FKhaw4M9DtQOvOjWBag9
 vI+MhnrU18SrcHXS0UGypuhJoHp60lp6UaEn5+pIn9xWo8wt5EL1yPzaRMWh2wVJxk4JBkjFG79
 cUU+C7m5kDvGk4ub9ya86HvL5Yx+yoUBBSk0I=
X-Received: by 2002:a05:690c:87:b0:8b0:ccc3:27d2 with SMTP id
 00721157ae682-8b166bf7416mr83748227b3.29.1793102542670; Tue, 27 Oct 2026
 05:02:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
 <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
 <20260921202435.GC858934@bill-the-cat>
 <8953c3f1-929a-43ca-8708-712a45db9c77@embetrix.com>
 <CAC_iWjKDX2FdzrpW0JxJ-tpj2PksNY0gDyoXz3_T_QRrjaoyRQ@mail.gmail.com>
 <40b6ce4f-ac70-4d37-a3b7-c784c9c75471@embetrix.com>
 <CAC_iWj+ofe4fbY2yVc3qzZmxwBprLem-urjepKtVg8ORtiT2Fg@mail.gmail.com>
In-Reply-To: <CAC_iWj+ofe4fbY2yVc3qzZmxwBprLem-urjepKtVg8ORtiT2Fg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Oct 2026 14:01:45 +0200
X-Gm-Features: AclHuK-0hoOdb8hl4ebIXFo_GszIcl2nbvdQeT03AZu0HZpXR3yVS9YBmuOuhhs
Message-ID: <CAC_iWj+hJHKrH+owS8s99iBYAQRVZ+zvjt-rvA-0d657=SpK-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
To: Ayoub Zaki <ayoub.zaki@embetrix.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 mkorpershoek@kernel.org, sjg@chromium.org, marek.vasut+renesas@mailbox.org, 
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com, 
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apologies for the late reply.
Was waiting for some announcements to settle down.

What I found out was this [0]. Comments welcome but I'd like to see
how this plays out before making any decisions, since we use mbedTLS
for https as well

[0] https://lists.trustedfirmware.org/archives/list/mbed-tls@lists.trustedf=
irmware.org/thread/YPIGCB7WN6GCHOGEGKOJXUYAP7OK527W/

Thanks
/Ilias
On Thu, 24 Sept 2026 at 13:36, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > >>>
> > >>> Well, a problem I see is that this is something that needs active
> > >>> maintenance to stay in sync as we don't want to miss important fixe=
s
> > >>> here. In theory, we get that with mbedtls (even if we're behind atm=
...).
> > >>>
> > >>
> > >> Agreed. Importing the Linux implementation means taking responsibili=
ty
> > >> for tracking upstream fixes. I=E2=80=99m willing to maintain this co=
de, track
> > >> changes to the Linux implementations and bring relevant fixes into
> > >> U-Boot. I can also add a MAINTAINERS entry to make that responsibili=
ty
> > >> explicit.
> > >> The goal is to prepare U-Boot for early adoption of post-quantum
> > >> cryptography in secure boot, particularly FIT image signing and
> > >> signature verification as some hardware already ships with PQC
> > >> capabilities.
> > >
> > > There are zero doubts that this is necessary; in fact we are already =
late.
> > >
> > >> The intention is to switch to Mbed TLS as soon as it provides produc=
tion
> > >> ready ML-DSA support and the required SHAKE functionality. That time=
line
> > >> is not clear to me yet so I=E2=80=99d like to prepare U-Boot in the =
meantime.
> > >> Would this address your maintenance concern sufficiently to proceed =
with
> > >> this approach?
> > >>
> > >
> > > I can try to find out more about the mbedTLS roadmap if you are still
> > > interested in going down that path. Arguably most country legislation
> > > is looking to enforce PQC by 2030 so a month or two won't kill us.
> > > There's another benefit apart from the 'less maintenance' when using
> > > the external library path. IIRC, there isn't a single algorithm
> > > acceptable to all legislative bodies.E.g, CNSA 2.0 does not adopt
> > > SLH-DSA while most of Europe does. It would be much easier to use a
> > > library and select the desired implementation (even stateful vs
> > > stateless) instead of importing and maintaining everything.
> >
> >
> > Thanks, any clarification you can get on the mbedTLS roadmap and the
> > expected timeline for production-ready PQC support would be helpful.
>
> Will do
>
> > Separately from that U-Boot currently uses mbedTLS 3.6.x and moving to
> > newer 4.x involves the split into TF-PSA-Crypto as a separate submodule
> > and incompatible API changes. That migration is work to consider
> > independently of PQC support.
>
> Yes last time I looked the gap wasn't massive, but it's there and
> indeed frustrating.
>
> > Let=E2=80=99s revisit the PQC approach once we have more information on=
 the roadmap.
>
> Will do get back to you!
>
> Thanks
> /Ilias
>
> >
> >
> > Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
> >
> > --
> > Ayoub Zaki
> > Embedded Systems Consultant
> >
> > Vaihinger Stra=C3=9Fe 2/1
> > D-71634 Ludwigsburg
> >
> > Email    : ayoub.zaki@embetrix.com
> > Homepage : https://embetrix.com
> > VAT No.  : DE313902634
> >
