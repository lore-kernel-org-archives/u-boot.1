Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624E606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uQMkheyy;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=GQkufF7S
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D77E60709;
	Fri, 23 Oct 2026 13:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40L3QO4biySA; Fri, 23 Oct 2026 13:30:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BCF160668
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792762225;
	b=fMafAYGqqOiXwu7eu0BVyIbAbzHe5L6LIwMI+wOexXLNygBdMeCmtOpyd6OVRtLtmuKN
	 DiLb1De/BL6Fgdh+kFt8ileB4EYwB7HR/JIjUieGRIzC97S708UF65W6wKm2II0z3L01O
	 +ynqIqcsXSkAN+992dSAUYUJ9+xnE31r/M6VV67ZldXaytGEFQFh1b4cCwxjJSGrWye2W
	 UQ1jche8+0xeYzhqYLTBCfKmyFS2KFWtfz3L8WsVZrcmlAvEr45LTelBnWuMzy+WbOc1l
	 EP3NTkoOJsjFamXlg0nZFZndPFF0N8nnOKKfGXAxTju5VnB8kGUucVy6Eb7oIxq+QCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792762225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AJ+rbIWFO3AreRfB/iss0v/1jvjkMQ6P6PcNEfc4+Vo=;
	b=E2U+dSrr8GOCOkYoqBNjfV6I3PrKrEFb6ev02MnEjZB28mSFev/Ntu+hpQxpQfEaBlBm
	 GUHBpCa9Cw1kge7t/3twcpZs2jRaZhmVRslWF7lZxTmrEv9g2hdhZjYPPoymWbcir+zEN
	 W+FaNd2K4Pkm/8YCRtepqOlGErkqbUHe2mqiApU7DEX/s1d1wQSbiiOF8LpeD6S9WIDto
	 UgErfzHdNAKV9rNn7dUg1O2GwimAhhNz+WlVQ0r+0Yj8RrZ7SNJbAVc+8cr2TQK1i2o9x
	 Hb//Gxtf3HnXR/h9c9pa1vha0AwKPO5XOTZL1NIEcT0+3Kq4kLznpoDVnCOF9Fp9CcA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792762225;
	bh=AJ+rbIWFO3AreRfB/iss0v/1jvjkMQ6P6PcNEfc4+Vo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uQMkheyyDFFIaeQtYI0AaqwhyjpgfIJ+L6pIM4EWH56vkUoFjtkN0S0z1flgfqXjv
	 sgOznyRExCpNMSuNSxzuZQv0DV7sfviPvGJMzlHyvQcFfS9s84U7FlrfPlKIabqUcM
	 fEoyeMPF+aMq6sEN5EB4tw0x/yHVFrAXACYTJ5ZO0CrbiBSba93exojVCunobyjQCk
	 uUeAYMoR25Tdy+dBHALU4lO74oy1box71CvkfNUO7sjQsDpDY7ig5BG99UAdI0OZkl
	 MqCICbkdIV99ICt50PW/Ta9xODlixMIxkzxrI5UIjH+J4wJRQOoKP3wRcTlkEqrsgU
	 qif9zNv4pgraQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BCF160668;
	Fri, 23 Oct 2026 13:30:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7BB612C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD6EE401CE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 08UmxsLvvWaO for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:30:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 16D63401CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792762223;
 b=E2unuDXXGPGTep5pttJ/0J0pQKnvphr4JNshzAhv1bpJyXvZrxAVOgeJH/r6CbYnssfD
 zuQ7emKBAb4IKLUSLaJ9AVwYLkYG4gF07/Ny0hOd8rpc8LR8le69/lAejLdCnzA3Qo9yv
 93lUoY/7B8YSeqjY1n5DIds3uguB18pdP5F4wq6/rxOKCxbsCr5rmXO4EI69RXg1OGL6S
 K1AGOp8vT9folsVMLhiZJPI4FJxrRUPnFFg6/W/+x8a4h1GTAVVLKe8AYl1rpO636QDbC
 Qir7I0OpIwUtZabJutypLt+3BY/cr33ngoqe/7wSsIxHrXfCw0oHs61Za9Fm3K3NtuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792762223;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=AJ+rbIWFO3AreRfB/iss0v/1jvjkMQ6P6PcNEfc4+Vo=;
 b=LPJ6/r3dy9e21sq71IeUWotzl1Z9yTxcctFl2oh0Nrkvj5GVpTjH7B7CHhIWK/1DF0cU
 uFMXtUN3ecZE42hEic0wYfJpyooHAITe9GgSIkpjtFW3TGXzqY8jEZjIuOlnjZi58UAfP
 ZO78ufi5lLpadczYM/cAzyDLL7CLKl4gh+UX9L64CyF6NVqtGMq0aHM/utew0bM5GcCp2
 n1zPXRReV45uEYUS7OYacfgOtxsBvQAkIasZOoDxPxMDxBT2SvgdxV5IKnycbfhbYD+a2
 xfPrbFC7CuEd7YhbbqXhle0gmUpx33Ak8nn9flyJ/14WioiLgQYgMLj7ktfMiGWLW5Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GQkufF7S; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GQkufF7S
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16D63401CC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:22 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6b19e291cc6so737953eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792762221; x=1793367021;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJ+rbIWFO3AreRfB/iss0v/1jvjkMQ6P6PcNEfc4+Vo=;
 b=GQkufF7SA6uekfHlPfpmVCynxlrjCSxxTLexC1gxPlRYs1sSpDOiY2icdBjkfM65dS
 xsjUdRHMOzBldD+cLoQXpmQgQrphstxTDNa+pLfVWrpRnV8m8tTTD4IQ4EmYffUHu0te
 GOsQtRAGuB8Wz75gG0CbJepTUniaPzoaO5n6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762221; x=1793367021;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AJ+rbIWFO3AreRfB/iss0v/1jvjkMQ6P6PcNEfc4+Vo=;
 b=yDGg4wVz+0DpQBfU5qo5JmV5sZ1i4CgKUKz/FtDx7XF8VRxpi3Bxv+ja9eddpkiRlU
 /A7a5QUG1yN6E5yTpeZX4Bkf6bzYlyATc1AKKZVpw10O00v8QUTK6la78Gcy806aF2Rt
 UBuQ+U5xwxhaXZ0trFbVRV1rP5e/i3rbxfkFZf2KmWB4ApPjxLisHDtH/VRfBGqIwyGA
 Tg5Am/CAyueJD3ChusjKU+9l8BXyDUsgI148UbFmWXrzfZcJdv2+fHmcOQFUHxMMuM+r
 mJmc7Hvt4q2wNUgKxFeiJn4bdLd4yHYxEMFMfOtwU5wlLrzpu44COw82r89jjoAcETzg
 Ssew==
X-Gm-Message-State: AFq9FYJQDOgdy66PAbXVpFJUNTbP0z8eEd1rgxSj2jN9gq5q+HjFwayv
 PIRvtk8VToOcI32IKfqSIx3Gpl1/4VN5h0I4/nS9LaakT6dRYf/FTc8weyQ0PUSs8vY=
X-Gm-Gg: AYBFou0sDfJjUKj7DHx2nNGKkv+stEgndcXQcTz6WCfSf6IBp/5nQHOpEiu/nL0rIlQ
 FbtKi1LZSO0IBbZ1RuuFx+uUWMITvwHH1/12TB9j9w0wcCWMQBIc2M7FExzmqeR7Tyegues0st7
 1xEhjvp8aLSTRWynAA5wrqWY+kqXtbHwIlMS1N0bkhww+xuJ9uJyNhBhRl5AJhJjZyfhKYujofR
 I2KoJGRgC29CPUL+qMbeI54RifV3Qa1sdgu4DDCI6h+UsP0rbq0Hxblscd+C8ZcHJ7orEGlycjA
 8qsWQvAxDVEWogdmmGWKxFZb5Ni1w7eWvEWcx1vx9OmGoPgVApiE1MEcPLGQ3qn+lmsH66tXOmQ
 NDnzrzsAFmWc4zvflyPythfVRG0+AsWzIpTwJiaIkZ0SqTyna2GlRf9dXNMhIFtgJl0sbyeeODV
 z5sdmZloSL+tVYRepZOr28dwIL1EUs4Ok38BbapyOYU82lU4JPssCCS38QxVPT66dt5tE5FL+8o
 p6fa2W8s39+fRH2nBQSrO3UPtyikxlTrIfHgsR446aFfN7Sl1rFdqYDj/uKEGr/bWy4axdwbT6e
 P7kSXdWPUZv3bKRQUJMw8jGLLJxjc7lC5iibEdnarC2xGKeb+T/pb+8GRcqSTrZX62y12lPh99g
 =
X-Received: by 2002:a05:6820:c3c8:b0:6d7:cd0c:752a with SMTP id
 006d021491bc7-70b88a7d490mr884819eaf.54.1792762221588; 
 Fri, 23 Oct 2026 06:30:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84fbdf59d82sm2183155a34.15.2026.10.23.06.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:30:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: sjg@chromium.org, michal.simek@amd.com
In-Reply-To: <20261012214604.1477684-1-sebasjosue84@gmail.com>
References: <20261012214604.1477684-1-sebasjosue84@gmail.com>
Subject: Re: [PATCH v2 0/2] spl: Fix the uninitialised /fit-images entry point
Message-Id: <179276222062.3884908.14249223264953225937.b4-ty@konsulko.com>
Date: Fri, 23 Oct 2026 07:30:20 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 15:46:02 -0600, Sebastian Alba Vives wrote:

> Both the ATF and the OpenSBI hand-off paths look up the next stage's entry
> point in a /fit-images node, trying fit_image_get_entry() and falling back
> to fit_image_get_load(). Neither site tests the result of the fallback.
> 
> fit_image_get_address() returns -1 before it reaches the assignment to
> *load in two cases: the property is absent, and the value does not fit in
> a target ulong. The caller's ulong is left untouched in both, so a node
> with neither property leaves the entry point uninitialised. It reaches
> bl31_entry() as the BL33 entry point on ARM, and opensbi_info.next_addr,
> the S-mode entry point, on RISC-V.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] spl: atf: Keep the caller's default when the entry lookup fails
      commit: 59ccefc44a2d03d85dd552a63d25ea5aec143a8b
[2/2] spl: opensbi: Check the return of the entry/load lookup
      commit: c6473784b5ac195d4f81ff0fbe4f6e8ae0296d25
-- 
Tom


