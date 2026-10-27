Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EA606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NPRCHIpP;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9txj8Zt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZcvC6fw4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8776280D00;
	Tue, 27 Oct 2026 10:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2LvKzJjTTPBs; Tue, 27 Oct 2026 10:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FBFF80CCC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793098618;
	b=Oc/5YtW9iumzjfJpHorN4l++HHfgVySBWM01+B+XU9LwQG+LoKITjqOpASUd9wD2vo7b
	 5aGPkHVWR1Pf6i5vpOfE31PPaRqLDyFW4dbHwe11Cezo87kGQc3kNs5VJ94o+TXtX4TBn
	 z037obWeo8EWtH/3kfHwwu5TcJd5fD9YI1kfP+Uk+x8JgZC4qgfJWT4HwJww8Mj0lJTMK
	 2QNr5Vbbf5zFRlSJhAYXDnMMadwW/w2ooUP6c1lBoCnp6FIBPOnJH7o8Jf9925gXbWsKV
	 o66/LqGZ9ABIPht7q05xdjVG9LXVqmxAMrTlePawjwdQ+n+AZHBFLjSgoVvHMjWkfyg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793098618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AptEFnFQCf3b2TJFcAMGtX1yaGG5uAtK81McaTLBmmI=;
	b=bO5pgS/4mG9hk2M3LjPyo/j7Aez4XTPHd3E1+yxSDdaph/iofimCfMo5UnbLDOL1ekcD
	 E0c9/v358LSIdyrsAe15ecfzsFBgIJ++1nhmdtizSGKUsWIyp6Gd20Rl9ktgXJC6QdQ2b
	 jqxYR3cTPYnL9wlAuKNeU8nPfflI6rPJyFoS4EfLM3ObByLHXADpB94cK2sD0l34L0zEy
	 EQ1uQKThoy2yVofTNxt8UtYhyALcbhr5j/ULQZvXEWWewczQDs8tZ5wbf592HgBZ603D8
	 YjZgWDJUoSC5HGHk68eWhbNTO7r0Lhlq/0EUXCvJqQh4Xyybyf2LQ6WL17xkSxR4GTg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793098618;
	bh=AptEFnFQCf3b2TJFcAMGtX1yaGG5uAtK81McaTLBmmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NPRCHIpPn3vt72+e1ITBYib0KrVhG8xDMDMBtUE+1IyqRuN/ZLgeu2frYIwEkI4fO
	 kl2EQrUmKwpHmxrcZPc6AUPah1c0Ladw/lAl4DZUWLnzI6ZfnDDsh/DkLyg8NEN+lD
	 Q/1n46C+AEkKphA1RHlwlPQbaJRgox+N6PgbaaEFGRbrdOmtN/GgUZXN8CHQwq6ma3
	 Kvo5/+QQ7/ZKCiotIHv0m1fVP+JB8savzkPmV8izE961KnVhw5xD3hpSsDldrcn6Qo
	 PzcV8eVk9Qey+EwwgsEae+QsQvSUYyDs4VoIIOZb5anC30XMlfSosRc9zBnUf2uxHX
	 PS4EFdO0DX6aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FBFF80CCC;
	Tue, 27 Oct 2026 10:56:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B29C31DE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4CC94060F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1oip9WadhEm for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:56:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0215D4060A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793098616;
 b=WeuhnTE3U9Ouv517ihD1tw1NO88j8Hsf5ZQqkr8O1aY15crq5qiEzIX57eWxfWerCZyZ
 BRX5lRkl6C+HMmgft9ptrJ6Ni5iSczsd5TcOZqxLkDQRrH/pH/PfAWwlIJptdVjLAQ1V0
 j1bytAXkvWJSuaCIAB5gBUzhRve80bngLyS1+rN2wbwZp138QSE9Qkgi7WmdzvN8vKhpT
 BAtgiEwhzCYHetQIfT1xdkJAnN7UfSJaZiV3lHYiGVgL1jsFOBJ+LXpSxdDH4VThQpTtS
 sbG0U57FhlBNizQlqC2Nxk15Zi3oF882tktla9Xl7QJTMpJJbEa8gEg7LLwGIvhQwzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793098616;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=AptEFnFQCf3b2TJFcAMGtX1yaGG5uAtK81McaTLBmmI=;
 b=VtfAayWo4BhoLRAo8H/U+Yh7QzbvWAfSov+dQPsvJKWD9idpwCb22nQvSzdX1NUlHN1P
 CGRp9rY2mticiFhUGo+yD1zaRgYCfrAC/mqPC6dsCwO4KFfHaPUNLo1yFcgRfeoNEHFkb
 MqXKHdU4c7P9MESc0v1xz2DoaNibIuHkY/IhLHYeIKX2yCVbfW61BrphqVprFkMAvdgs8
 olR3Pa9NygHciyTTHgHMU3ekianFHc7L+2o/KGf7jgHVS/94nSN+fY3SQF9iVaaJP/h5b
 9BWcL2IDhseYu5W1V/fofw7SDaXxr16K/tsn3wOFg7DiWcXbP0ap6SP/B5EpPv0/vaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=i9txj8Zt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZcvC6fw4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9txj8Zt; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZcvC6fw4
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0215D4060A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:56:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAe4Oa432508
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AptEFnFQCf3b2TJFcAMGtX1yaGG5uAtK81McaTLBmmI=; b=i9txj8ZtoJgdii4V
 4kjcRKpnJj608ep2hfcnM4e7VV1sBEkOcDLcTxzDhdcrXXESfzjoj94wm66pSzzu
 ss7g8NhYrATE0dBe0Xk6KwdYS8P2xnSsZG7+aH44MRIQ7IueNfwOC2579shVW8uA
 Q6W4G5yAa1OxnjtE6rrzV+0P/sfPbBGn7zlDGimydtdFahzjeoGl9H9nsui36/ao
 Vt9qC3Bx7+4k79IVEydD259uyFupZweCkvlhSbA8+rwu8s4Hh33zUZ1xMt4Yb4Nm
 xrjebeUesIaRkHyYo8o2oSgL1WmHXcR7ow3s9qa7hvxx7rZlDw9xq7gPL3qzrjqs
 7kpHpg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54kdus-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:56:54 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b0c6e7151cso65599327b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793098614; cv=none;
 d=google.com; s=arc-20260327;
 b=MlODRq5Bg6CNiwHnxT6iqSjviYHn3niznjHB/Pv9tHSz6DLanh8g2HY6r4ZG8i9D2L
 6WW2TqLTsciDvFJH9dSE6XqzVQ947hVjnv80y0TrrxKKhkBk83fjlr6qLnQ25DfwHfm3
 EV3MxDzsz+8B1pdPJREC1snWLeIyiYzZ1FnaV1tyHwwk1JjAog0AqP/35thn3D2TQFMO
 qgc9Wkj7mWW1teN1omzqfkusxI2FbkF6QR2KkczIj6iqvWD7RnGneTWu2xQhXMwF2NR9
 471AHN4KFaw1Pwp8QSMJ6tiDdu9Q2IS6jaZXKTZJ0+OBfZ0mO5EzLt0AH4CWGrm3o/uz
 HC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AptEFnFQCf3b2TJFcAMGtX1yaGG5uAtK81McaTLBmmI=;
 fh=9L03rxwyJmbdw0CPJMrR2bPHO+ymwHjDGCaqH/jg1c0=;
 b=M1HdAa8r8KSRqvKI+kQZ2OsxaiRxEzrP7M2glGUQMedroalXTyltIxsKqx7Y40wOiH
 E7IUhRFeS10GuQq+wd6EO/NUywICHg2EKhrLZAqeS1L5HzGOaKpMdcc5Td8dmWRu5ZLf
 UvO6f7hzczSyf6AEWc98Hm8QQ5rMGH7SGNRwCQfsjLOZTEVuDpJC1PMJCX9SmMNV7uAG
 E0haKj5FfVRgouTXsEbpoIg59YhfoXUrxrk62KP0qUevyEq9uGDepntqCNY6rwzQxC6u
 /+fXBQzsV3CShh0t5/zE228l0EJWnb4eL1BA53rTDrv1iReYNpb8Ar9oJ/ORWt58RBdn
 8MLQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793098614; x=1793703414;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AptEFnFQCf3b2TJFcAMGtX1yaGG5uAtK81McaTLBmmI=;
 b=ZcvC6fw4uIRlrxTkEKplxg9ta4geCBtzIo0LJB/kDaldFZXjxLq00LZjINf1VydDXX
 rLmZNfSM0sAu2BkHN73SQcI67V0rqJ32zNdFXRKiVMDP0cXoWyhE1Gkwxz3jnWU8seTx
 b9z9ABAEZVBG69Kxpb0t2ajkUuF6GgMnGd/rbnDEfCc/ccXTS+MgsuFxuLV40Z7ewN8b
 yLrm7iVlh0KY/RjsIKIb6Au0tCteKxn0AUPJ8PjoExgJxGeHAYmVqUoKEDnWlUmSyFHW
 w+inVp8pm1kMw26Kpn8fYDNWQb+VAkJK6/2nfd94AdJoxDggGKUi/TVu8MPP+aSl8o3m
 ulAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793098614; x=1793703414;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AptEFnFQCf3b2TJFcAMGtX1yaGG5uAtK81McaTLBmmI=;
 b=RrlM8zDAP9figWhWdg33bI5jBKxZqJquQCLK1HtErfQYJpkP9sauAeIO+vvJdUWWjY
 adcullxosKOkyhqzuj+QDq1psfRc2RI94gAAAJNSwFeSgygMk+vVz2U6u78t1RKiGg8g
 IOf38Ty7D7AtnVTDl4i0rOCdfphj37f4FeEfwtMTASQDz17f3N8z0s7uQjJz0Fd7eFxy
 UArD0ZYloXid4cfVRclFoeazNEgDjDXukRhNipRL9uQ1qedhu54IzPPY6Vfw+M/sf2u4
 0WADaMEYZwoWxHQsR9GH2A35m9boQ0T9PXsvps2rZOptMhBZ39brM6o/jzPoByO8PBUn
 QVFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUBhsaKdI0MwPnWcIE1+Zu4UZNf3WlVTFxbiAWcAfXwIjQGko7Rss+UBurVRAJ+r0Gynq82xY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI7bfE8OL/c2DE2lLiW3kZUPm1WDMl5NrxN/C08GGyrDSTQqBfT
 2LPSS7po3KUSzietnVLsqj7Pbyb15OCJuDMWU9ebI0Jxyxgtlpihn6YhnwG/jWqsE0e3yEs6yPC
 RAWgOH8WdSbEoxfdlpNHdG0yiOkW4ytDcvo4kBpGaVZNarRSJWG+8qPHrdlkIpA1iecz5OKUqzA
 VHyduH+6LzKLUCzPag8p9x/63UijNRQj2jj8IBYvc5d5tw8w==
X-Gm-Gg: AYBFou0CKP21oMHlDw455Q35gQgTt5dGkBjVWiE+V86d4vTBY3iVIJOGg1T7NPFA7aq
 QwBjVW2s17HGFNaHMfSXKHFhKQT8KtpOSmNBPambvmiCOlqQym3cMvj0/m0LWQeA0Km+9tCKnqU
 AjCxivHqAt0RIf4xqNng0JBiLBpcDGXP9Ou4+GGFfTC+jT0oU7jwYOXns=
X-Received: by 2002:a05:690c:7108:b0:8af:1cb6:30ac with SMTP id
 00721157ae682-8b166ca5c66mr58053097b3.67.1793098613715; 
 Tue, 27 Oct 2026 03:56:53 -0700 (PDT)
X-Received: by 2002:a05:690c:7108:b0:8af:1cb6:30ac with SMTP id
 00721157ae682-8b166ca5c66mr58053077b3.67.1793098613291; Tue, 27 Oct 2026
 03:56:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-upstream-u-boot_qemu_arm_b4-v1-1-223dd8060db0@oss.qualcomm.com>
 <20261026191817.GJ646438@bill-the-cat>
In-Reply-To: <20261026191817.GJ646438@bill-the-cat>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 11:56:41 +0100
X-Gm-Features: AclHuK9JurI8TqiwfbKgpOAlGdhlooh3_lK3WjBe6D9nYh_l0lkhO7-zF8ze4e4
Message-ID: <CAPzfCAZZhj8JsU0W=CtFSrAYqu_oEusD=z3zg=YC9Z3BMd8_4Q@mail.gmail.com>
Subject: Re: [PATCH] board: qemu-arm: keep U-Boot below 4 GiB for 32-bit DMA
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, Marek Vasut <marex@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MyBTYWx0ZWRfXyCtLwYo1D2i2
 fqnDIAmTCd24BcXGxxnW6Hqjx31COMEY7/f6rvnIZ6TEvvdEsRg9CGfE8mzfjDxXeCoT0Tnf+bh
 qCfUhO1vnIMxKRHUwbIn6LlUqhLlV4A=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae08376 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=k-42gJp3AAAA:8 a=EUspDBNiAAAA:8
 a=fALncZDoRjp8qXB_CD0A:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: 7rP6kF1m3PybN8-E4A2HcnYFlGhjsja1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MyBTYWx0ZWRfX6VbZvpKkt2Yp
 F5mFtY8LgXDYBkiJETM+8Ieh7/d/KDLiUSzdNJF9lEOMrQGaUou6ez9t6qTFOB6OdJdWOtP1qis
 SxNUP/6O0vDN5loJDv3tyVdQVJT8Jv1CxEYSOPRdzj82ZyPJ+WdxUsRE6pftN+tvu2KmOu6u5gE
 B/tLdG1zba6DnKRqnzWufWCVhoHmiuWbYtOcja+pOJ6++8iOEiaUUU3zXf2ra5d6prUyb5ybP2r
 nab/88CRwVp9o6HL2n6bHF9GMaUnvBAhvdLiUpErL8GIoOWDolpq0XZIvVH8HO9d9i9pi4lLU54
 4SZHs03uAJMDdupjSFmsRs1nlXLqE2JY7rLKoxItlro3Xjgrw8APaKyvTbL4P0JbE9ENDuYxTTf
 A5yYfgy2tsLL2jgSK9lW87xD4OnC+ocFW3sTy2XSdVWXyyFky094ANmG20P8BHA5NcLUShcIQXU
 yGB5DhIkP2aAdxG1O5w==
X-Proofpoint-GUID: 7rP6kF1m3PybN8-E4A2HcnYFlGhjsja1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270043
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Mon, Oct 26, 2026 at 8:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Oct 26, 2026 at 07:44:50PM +0100, Igor Opaniuk wrote:
>
> > U-Boot relocates itself and its heap to the top of RAM. On the QEMU
> > virt machine that is fine with -m 3072 and below, where RAM ends at or
> > under the 4 GiB boundary, but with more memory (e.g. -m 6144) U-Boot
> > ends up around 7 GiB. Every buffer it then hands to a DMA engine that
> > is limited to 32-bit addresses is unreachable by the device.
> >
> > The generic SDHCI driver is such a consumer: it transfers via 32-bit
> > SDMA or 32-bit ADMA2 descriptors. With an emulated sdhci-pci eMMC on
> > the virt machine and 6 GiB of RAM, card initialization data transfers
> > fail silently, the MMC block device never probes, and bootstd finds no
> > bootflow on the eMMC: autoboot drops to the prompt with an empty 'pci'
> > listing as the only visible symptom (enumeration not yet run), while
> > 'dm tree' after a manual 'pci enum' shows the controller bound but the
> > blk child never probed.
> >
> > Clamp the usable RAM top to 4 GiB like other boards with 32-bit DMA
> > constraints do, so U-Boot and its buffers stay DMA-addressable however
> > much memory the VM is given. The OS still sees and uses all of it.
> >
> > Fixes: f37770c7707b ("ARM: qemu-arm: Bump RAM size in AArch64 MMU table=
")
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > ---
> > A single fix for running U-Boot on the QEMU virt machine with more
> > than 3 GiB of RAM: relocation then places U-Boot (and its DMA
> > buffers) above the 32-bit boundary, which the generic SDHCI driver
> > cannot address with SDMA or 32-bit ADMA2 descriptors, so an emulated
> > sdhci-pci eMMC silently loses its block device and bootstd finds no
> > bootflow on it. Clamp the usable RAM top to 4 GiB, as other boards
> > with 32-bit DMA constraints do.
> >
> > Found while bringing up an Android boot chain (TF-A + OP-TEE +
> > U-Boot AVB + eMMC/RPMB) on qemu_arm64 and raising the VM memory
> > from 3 GiB to 6 GiB.
>
> This is another case for LMB_LIMIT_DMA_BELOW_RAM_TOP too, isn't it? In
> this case the generic SDHCI driver should select it?

I agree that LMB_LIMIT_DMA_BELOW_RAM_TOP belongs in this picture.
It and the clamp will complement each other in this case,
but LMB_LIMIT_DMA_BELOW_RAM_TOP cannot replace the clamp(
if I understood your comment correctly).

I can send a separate patch for adding "imply LMB_LIMIT_DMA_BELOW_RAM_TOP"
to MMC_SDHCI driver.

Thanks!
>
> --
> Tom
