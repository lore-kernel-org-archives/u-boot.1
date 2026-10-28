Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEB606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o/UjV+Ya;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KJtEmKJT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9444D81203;
	Wed, 28 Oct 2026 16:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDC6lphcyVeo; Wed, 28 Oct 2026 16:02:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DC7C811F3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203326;
	b=Zkdu28zfFQl5gM/VSIqMmVE8OSgSvUjZPWZlfNTs9pQr7nDqZ5QhfeGKsK66Or6boM+M
	 LuUZ+nnJkbQjgyL/uSztNAgVyu+CRh27AIhhsOelKhJ6K1cQRIoD2IDWFWuRxhJfVo8TI
	 Q1AW+M8Ikh+4uxjj+S+zPgv4ddk1IZDPqdYJYglzknxASlIRI1tgc71Sh7qUN64mfmyQH
	 daRXhkaQ3/LqIl4SH7H8mzZzsoYug/PKazikUUdo4UYPDXJMZI7fqiX4ARscM98UaLwgP
	 WGzcdvxS00b3vS2vSaydRpSg3YyXjW10eK+/VDmPehKpDbWFhvNbBHWVoy0D1l1ajqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vWFHI2jl/GPYy/I/p5Dd0155JDSRlcV3ZnI1B1Jvv4A=;
	b=NrO+IP3vZMsdpFnbjThXQhMwpmFNV3567V9oDhrr9DkSraKJz63IDSSY7P/eIbesUjmc
	 jTgJCQcitANX2DdR1T57PAoqaxpKwxbk7oJW3J2B58KeZW2iQxBzl/tMUNcuvrg529Nmx
	 H1tRu1S6NetZ+eqhyxBEJ+EOPrcnBdGhV0qMKS8DfUNM8zpyrBS29X1bzu2/yyMoHV7GQ
	 F3SL22U3uBqpSg81UR3e3bt5ku3PqImY7EfK115C0Boe2pHwdVUnrkDVMoXHjeEea2qhY
	 5rG/MLLYivjRUXGRJsbKaUbrOnTC840Wqx5w2OR+SEXsy5rLJrwOIC5wYpGVrTMobGw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203326;
	bh=vWFHI2jl/GPYy/I/p5Dd0155JDSRlcV3ZnI1B1Jvv4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o/UjV+YaASA35QwpUREoygqqdwFGeXcSNiNVu34gOnE2Sk5dh1XIpFchv01o5Ewpl
	 jos9GoDEdPvIX1WrgkuNWJ2iaMSj2ltKrjytooH7t9nzLueRFf8iwKTSx3wxRFXwrR
	 heRpV22CkggrBa5mwk2F4ghJVjZqor+TA7uowZYvhC8PIZb9VmuNMjvl3W35d+pUYD
	 q3cIRqntyS1N9PxUbNPRo584wjsFy4TR5ZTa4KInhNdJdt/pbhclzDvnTLAGIvA6c0
	 yvqNAM8kXhvPL0aItNxl9eG98N8q0r4mjU7ryyy9tBqXU/1L80knNK9DhVSFdJ412c
	 aBCPjWcjCTxMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DC7C811F3;
	Wed, 28 Oct 2026 16:02:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEA28D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95373400AD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5JEx6wzl9aTe for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 935C940071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203312;
 b=dQwQUUyGLI8Txqx3LMQWwOJmfwE3s1Nm0zCkbtELYikV9IFVBY2Kkc5LBeqnq79QVjCq
 skWO6CiuMvI+sTS1diiUlGJ2jC+RUxBr56SGxeE2mI83T5oYyHTAVf0PjRltz9wD3RODx
 NNt7mxrZvh/pEhyZi3fFaNbEH5BokVcbyOym+kxSzPI0MIc7yHzoH7XGJ6jlu8uAnh88y
 X6r5EucTUYZqCX5aI5cxRBFO3uEG8W7qlXRKOFspEviuOQw3+IYwbG+HYcfTgqNbdNvev
 DfqJB+NfoO4y2fAbDHyY3BW7BpIOC7t0hS3rXk7pMyz2APzrySjmDouBLbOW3LWuFfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203312;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=vWFHI2jl/GPYy/I/p5Dd0155JDSRlcV3ZnI1B1Jvv4A=;
 b=LGvr0fR3vPacjHgJjEVUh4KcSFxWgzgUe3YnQXQ8EIVoT2mzp6Y4BIj+qlTt8SUqRcHc
 daiB7M6jUwngCfF5OD1AFgAU/FcZvtRc4TSQFHZJR6+XiHk7BJGxxdjewBfJxyN/S5kHL
 a/52i8V8uPHBdChdrW4865dyHD8sPQU98D0rJUMhrdXErDFl8uMvIp6+ELGLxV17KpUt5
 4Rbl36ghG8lugDcn19gAr2vHxhiBy7scp8qQ4+WAwDBY5WEhHy209SYm/FdBS34mviZb9
 dbJkrndK4gfskMgtwbjl9l7MOjaouaKoNL0diZ/fVL3STeLwWpUhoQ50dyxrgQJqP/Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KJtEmKJT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=KJtEmKJT
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 935C940071
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:51 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4956869750eso7846475e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203309; x=1793808109;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vWFHI2jl/GPYy/I/p5Dd0155JDSRlcV3ZnI1B1Jvv4A=;
 b=KJtEmKJT/JwsE1mJEZVIDtqr5P1FuSN9FRd29jU1MyxsDRMKNnGssqltWk/xoa6ttd
 AnRwGOecVJitXlPOqctRrJpDqsy/IUYbgJeHyQu03TlznUtJLnfu4FGBwGtIOEC0TnjT
 6NbZ9JqD8hA/UbsZ5zEwIO635W+818K4BXThijVnQGMQWFtCHOWtrVpPblG1K9Wt6JeG
 vRKkXuAHxNPvVEjMmrr4u71Z0tPmavZY5XtIAymycH2cJELHNZVJ0QpisRS7cU8ksoVF
 BpZQY6kugNOL1kaZkLZ0CjlZHWCyqr1Ton/KS+oEtVkO5qTmd6a8S8hRaJcswNX5ghql
 gC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203309; x=1793808109;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vWFHI2jl/GPYy/I/p5Dd0155JDSRlcV3ZnI1B1Jvv4A=;
 b=NzoQRMdwjdZpYWpv36Ihgt6oR3K6tm77L1CBtmr0T2rGgejavcevgPX67wVhZhD/nb
 mWoR/zq1cENv2cJCCbnhqIMT/GSVNgVQG4D7KVyQQ8T+0nszMCgHB2OlMCGez02nnwAv
 YJOKkKRJuXPbOfj0M3UumclGFC1KzQI8bhuHk77bLgBlFnFehsJzj+ogNlkfsKZAGWh8
 2LBbKo0N5SBUPuXvqgni0A8SxOakhtby5Ub/5CYfHMBOQ5NSRqtjbGvbVX7WVbA5QGSj
 dg1EDniuTxwLa2ZS/rSdctb/cojwYfn/Co1qkepvrX7SFYoNowG9U/acmc+wZTCL/eVt
 cKvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1H12GeJr2bRiiL/c0/cVZXpr4uCIKKPkaqe1KgkM09ixVsGLuZyyoKQgi7/7kILlPVcgBmpU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKGt7cE8UhnOwZXiYClBrKq0ZnOjCPif2Lv+L9EWkiWQi9F7U+b
 rO7sarzTIp0fgXFhamTys8iFAbcMVacyoVGoBPoQFU4ECJeDek3M+9lPE43qyoYH2Xk=
X-Gm-Gg: AYBFou1kUoQcw+ERpabGX61NiYW04Fn1pziISNqOXUU2UoP7dB6Wn26BCG8O67TRm4j
 zby3RyjzFK/ZrAb1IoLTK6NEAhJ0Rv7iqDAmtGFWys6GlaKByBURaMYiLvHYhrG/t+TihzJr4FN
 D+zqie3ci7hqD0JW1J0x/VcsT1yBoXFYZkyMIUv4oBRtBo2dF09WNLYU0nVn8EIsv/DDgNyleuH
 t0RpcMEn9AOHpXy4FdCgOGjsOZVPcebvHeMy1UN74YzTD52DqdyNT/UkvOc7VBcTqIxQ841IN4U
 BX73y8kEf0chaqK8kzjrCbcOkBctG8t5ucLw0mf8qvzk8r53yJ9yl3sd8UBfwlGKc5zKXt9gNeB
 kKz6WSRK6KYkqisoSNijHoVh06SGBeT8U3SfDaoRdsTonN4MwWeT5efWPX51ni93N4+DLLSZYv/
 JL8IMg/aNtXOtIVIA5PlOG/dpwaxTBYOjA9ty+2b1xV1ldPtc0atAc5FRV6PqcUdCQgrlVWJBAE
 JpxzKn5w+Q8gzjSsHwt/N+3SYuctE8TKFbEs4RShEZnctLrSL3/kQl5oaiktIf0m90DVAxxgNT0
 VmygZ/7kJJycjl5gMZs4r39vCfHAPBptie/peqyonizgheLzDW1ZaDld9NhdmPMho13ojVCfTw1
 rYiZSuJ63e+E+HZf6
X-Received: by 2002:a05:600c:4754:b0:4a1:dda8:eb73 with SMTP id
 5b1f17b1804b1-4a966e2b8b2mr59078235e9.27.1793203309309; 
 Wed, 28 Oct 2026 09:01:49 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:48 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com>
References: <20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com>
Subject: Re: [PATCH] phy: qcom: qmp-combo: honor USB-C orientation for port
 select
Message-Id: <179320330797.1454330.8530347261920103292.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 24 Jul 2026 15:48:59 +0530, Balaji Selvanathan via U-Boot wrote:
> Read the USB-C cable orientation from the orientation-gpios
> property on the qcom,pmic-glink node and use it when programming
> the TypeC port-select mux.
> 
> Taken from Linux commit 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
> 
> Previously the driver always set SW_PORTSELECT_MUX without
> accounting for cable orientation, so the SuperSpeed/DP lanes could
> be routed to the wrong side of the connector on boards where the
> cable was flipped. Now orientation is read once during DT parsing
> and SW_PORTSELECT_VAL is added to the mux value when a reversed
> orientation is detected.
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: qmp-combo: honor USB-C orientation for port select
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/55e07ef6a93b

Best regards,
-- 
// Casey (she/they)


