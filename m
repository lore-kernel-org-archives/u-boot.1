Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A66CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 158E080C85;
	Mon, 19 Oct 2026 13:24:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p8Q8d9O_msxl; Mon, 19 Oct 2026 13:24:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE64D80CDA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416240;
	b=mmaZSkbE1NCjUi/D4t2lmwgsIMBqbvpad1b7hN1KVGKc3YjBvmud+cbaRzcgqNKUm+V/
	 kNS2SCC6mI20+EmKjYL8geUP+L0ZyjTFXY23BDXpIbjC5xHelqAp32C/YVOCmfvV3hwO6
	 qrQBdDCXt2OBXtK2H4gpXb/zBa9wcCdH6gnP2p8B+5HuOSyvKEyNY/nxJK89KZ7VAiIDX
	 ZDwfn+KiEcF3dv3q7FIfir5Tz+3zepkplmOBLX8XICG/u+m3+1wzt8whiZ1QA+Am8R37d
	 8XZlJpUOfFeKVfVZigGe/rzxeInhis/60pYw6t7E/5zy3YI4f048EAjApsh/Nv6qWqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=99sT87pVx+LWflgyRD6OTx+2m0ThzSsFPCNM8xWduBQ=;
	b=MPRyj1riHePlsK3nAFO3Ui4j5iHwUoQcvtHOITxB8sOL2k4LK+r4iLhYBNcuVK8hgTAG
	 vusdHztDSDCa3fbZ2tF2JLm9GPq/qyDE0VRwDlwgtwnMiCUVgg44gTsY9Z4HOd981kyJd
	 lyId9Y5LGfflBxPa8ZntSf/VA4KrucbNB8woCT8TvJTMEf6IvhUOcS8me8aWT3CI0g1LA
	 AVC7FNxgvkJbs+nus/Boc/C/9LljonigbmM9fdprWbSokxlP2Is3JAjR5KStYtSnS9INw
	 znGErUh3vn1Mvg+RwV/DP2cbt9IHhhwaVgziRhSrcCYE12vN/2Sduwsn8FlrhcXV9ww==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416240;
	bh=99sT87pVx+LWflgyRD6OTx+2m0ThzSsFPCNM8xWduBQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q5gk2kY8UAEwgLrsPjHNqn1J7b1MmCwz4CCZJK0t9Fd1cu4VWfYpa5IPWvDPdcEG2
	 ltFQ2C6ZkYOW0XHkI6vqqs2Hr521u8ptlMXhx1EkBOPI9GfFopQysVjdKf/GdLnNb2
	 MaOHKrEhO5Gn4HayM24rjdIKjrvn7mpNMv58LoaXSpJ9GNdJu4WyHCM/cMA3nXlusm
	 2Y5NvgrnadQB0hofGptqKue1kSIFRBVyad/Ya3wLHR2226E/kgsNfebBSGid1+E3IN
	 iY+BLg7cxrwiv10pCZ4umBaJF5RzdEmb9dwYIR+gkeWFnH2mG8rgMNzzckDGZE9/13
	 ssE3qq7I5sceA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE64D80CDA;
	Mon, 19 Oct 2026 13:23:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1130E2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02EC7406E0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fo8Dm0ZTnKvE for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:31:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B90D2406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402295;
 b=Ea/71SAKs1QE3+gKsJ3MHsSzd2sy47pS14eU5Yy+5JsUpKgHEmU/G92hJAl0HL3GRrl4
 9doNKKePnFIudZTQBiE5cO9utXSg40LAc895sXXs8qxEgA0/uNR1vE2XZNVW4u/asIuJH
 Xu/bjnyfhnzLka/nsrTyA35d4n/69/vOpm1rB6MNCq20ZNW0xZT7eM90/xUKXl2BzNASq
 tS5AKOn/h2D5Ry0ljCUlY/rErtaoX/bFLDGiW4/Z9iYXI60hMV5UC8YXnfY7nLZJYO0X4
 thwe70xiiIVmaZNBEx+TfUyX8okbQ+fCxdQb3p1PjQPUKWYlAVyWo3SPa6o+i33EPSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792402295;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=99sT87pVx+LWflgyRD6OTx+2m0ThzSsFPCNM8xWduBQ=;
 b=JVS4SBq1xV8tox4XUEvSMAF84eG7USq7tooeoZdwTmJziK78ZgyzukZPXb+hpLN4hRzA
 GTa8A2WsVx5kEbznag9SgQs+ZEEQO5t2f1HsTkR1oRVLowf6w+xwLGtmaxQSomkBUXN78
 PmEMTMMd1E5HrDFWUvomiDhnINRxZViwtwgr3y825l0xSZxhYgnN1N2+CMEkRut8e29IO
 rDkbzA8VnY/umAZ8jtUu2Q1QtP5vildZCs1Ar1NhHmY7zmTH+KO4eVowf0iOfrubcrTdc
 eZ5K+6v1NrnUEn5808TJ4tVn5AUW3pY3R9X1MtI8rTiMh7WnW6egiLdvsi3ovSVwmXw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IDHfhJLI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IDHfhJLI
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B90D2406AE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:35 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc4dbcf2b85so678775a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402294; cv=none;
 d=google.com; s=arc-20260327;
 b=OhVh0QUUqfr5DuxBXP08HBYei6w2xSfOmpB/wRiK+WhbsClhMwKhJfwBaX++qMvUxX
 PVJHkoN20KOnKSgNK+Y4Cua6ZOCzOHLoEoYJl8CU0mFLM3edZgSl7WHInWWJ8VrbEz8I
 C0crLThMOmTzoOJWHB4qc+EmuffFCRo6IYgNFl+jinw9R+TZc+s1H1aKom/CqncbHBbj
 pGJyVXAqLMYMCMuodAeAGUmsFY5Jb2KZpcVYAeLx+BqWExbRxwuV1iHg5ivCUKeE4aMK
 n4iEuFJGEcGCoCDZEjS5w1qAnDF+QGiZVh9HtdW2NCVwItxZsh8n1RT8ZbzQ0aUuDS0a
 +o5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=99sT87pVx+LWflgyRD6OTx+2m0ThzSsFPCNM8xWduBQ=;
 fh=oKXCwIWpo9AVyLNMjWzX04xQeOuiQOv0QKBHKoALWns=;
 b=ZkzvwwY2oWiISbd9HFfaDOQeh31i5TZJojTUXkuO64ZKjNM7UULGEmt7S8Aon9S5Eo
 9uUSKtk5/UMIL6Tpvk51to5m8gqsHAUfieeRk20u0guuuRwN0hQGtddl/M5dmnouFD3H
 mT2Gh53UmrvjBUjnmi/EiyfCct47WH3iiPTwFmkAJfZzDlm5el3yM9N+4/bU+21IiL2F
 y37tfZQNTM4o7YQkVDG9pmMW+TzaWHBRPb+K+Es0pne6qa8Dhw1PW0kcXXPlGQBAC9ss
 HwigHCJ4q/KlWAYoSrr1QWtrYsTDaUfc7fYHQMKAHH/fymAuyHoVGivoeEy6R2c2IBpE
 rNEw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792402294; x=1793007094;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=99sT87pVx+LWflgyRD6OTx+2m0ThzSsFPCNM8xWduBQ=;
 b=IDHfhJLInd7Hkv59VUeh73CKQ9rUTZWM6Gx5iuhGklYF/4+w2LBhe5R1DgM2/zHq0n
 1cBEpOxRBqX3kUFluJd/x5tueBbIve7/qHng+u7VY5ZGTJx40tpF9Q62tcD2Nt+aRBra
 f5iBsXQhXrWgTxgz5wOV820KDbDBOS4vNnk3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402294; x=1793007094;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=99sT87pVx+LWflgyRD6OTx+2m0ThzSsFPCNM8xWduBQ=;
 b=RjrGY0NPk2Sbl3TLaZ721Nil4ZlOGCodocLG7klk+fHUq8GEsxZcYlv3DDUxBQYFb4
 jYJe0GsIHT/FM5R+UPIhA/tr/Gam8BTMCIo6TMzyiWV8/txbiRSmWzC4T+J0j3xwCbtZ
 lIjsVqGjGYO9LDciF/rJLB1OY231hORvjm2O+8Lij5M4sFBpACOyhAzrB3wsYmTKr76U
 X6mCzMblXLvFxHt42SKc9BB8/sUEDqoy7XhYOLbHGhkMJcqaCG0KnC59TbIaY+8vs1e4
 cL6oRJNIwgEpu033We4sO5qityUYnPGCoTr8UVAEWe/5H4skgv1FGTzI5NpkPzzFOvYr
 VEkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy30IMg+WFkFTsfFPR5R4wxDcxMJdVOY33/4QPQcY95+03uRrlZE8NiX5qhE+TJ96cvP/pfgPI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKy08DcBdN8l3C5ewCluqNCTcpX1BrVABbnqgBU8otGwsg8jjN0
 sV9zQb47we2sHwlqLT/YHv1OnB/atDujfSQ7ic3lQpqtdAC4jpbd9avt8u/XRWKy0czUp8EVByp
 JN6A6HiFoeOjJccB3tn8eiQJOXQJavh2B6lGQ4NJr
X-Gm-Gg: AYBFou2hBFzdTHPY86U7azqNBpor9RkLBInTDkZNPnhfS05G/5xlL7ByVqyBzY1A+bb
 2dKkj2cyJQpYisS7atpzyyreq0l5fTUYcaBVcXg5iwF1UrAM0i0lt9iLXGf46tL1Ki+gEs6OX9p
 bZWNAhuZQRSkONTZjM0G9B6UsTaBYOT6bdHK7TIbI37nsg62c+WblCBGlTmOTN6LngMflqUMHaB
 ppqyTC216ePuUxQEX+Xjv1UkfLB0faQFIs6E6H0DLmEyqUIKHCoCg+1JIExX90H4b2nSnjhpvbo
 EoXDPJi4b2LDNjiVCBJSVodKK6MKw5Ag/tHt/LpT8qsSVSWyguAPTw==
X-Received: by 2002:a17:90b:4c4c:b0:3ac:a491:3cf8 with SMTP id
 98e67ed59e1d1-3acef52ae1emr6253098a91.43.1792402294423; Mon, 19 Oct 2026
 02:31:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:31:31 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:30:41 +0200
MIME-Version: 1.0
In-Reply-To: <20261016-submit-ce-series-v2-v9-9-c24e64daafe9@gmail.com>
References: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
 <20261016-submit-ce-series-v2-v9-9-c24e64daafe9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:31:31 +0200
X-Gm-Features: AclHuK-iCE2ZUz3UGgtt2wZ89CMn8_XMKuBxd3to7c53ZzRBZXeqO9uOdvYugDM
Message-ID: <CAFLszTiajNvGW8H7pwy3SLLqwVt+Z2XuyyzsqabRzCc7kXcBww@mail.gmail.com>
Subject: Re: [PATCH v9 09/17] crypto: tegra: preserve AES key sizes and engine
 failures
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.u-boot-project.org, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>,
 Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, Raymond Mao <raymondmaoca@gmail.com>,
 Yao Zi <me@ziyao.cc>, Philippe Reynes <philippe.reynes@softathome.com>,
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>,
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:23:57 +0000
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

On 2026-10-17T00:35:14, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: tegra: preserve AES key sizes and engine failures
>
> The Tegra AES provider stores its selected key size in an eight-bit field,
> although the interface and hardware register use a bit count. Selecting
> AES-256 therefore programs a zero key length. Keep the full bit count and
> initialize the default in the same units.
>
> An idle-wait timeout currently logs an error but returns success unless a
> hardware error bit is also set. Command submission ignores intermediate
> wait failures, and the probe-time SBK test discards both selection and
> engine errors. Callers can therefore continue programming the engine or
> consume IRAM as a completed result after an unsuccessful operation.
>
> Return -ETIMEDOUT for a busy engine and -EIO for hardware error status.
> Preserve these failures through configuration, key loading and selection,
> command submission and block processing. Stop before submitting another
> command or copying an unfinished result. Wait for idle before writing the
> SBK test input, and fail probe if that test cannot complete instead of
> publishing an unusable provider.
>
> Resource acquisition can also publish an unusable provider: a failed main
> clock lookup returns the previous successful reset lookup's zero status.
> VDE lookup failures are only logged, so hardware initialization can
> dereference an error clock pointer or an uninitialized reset handle.
> Return the actual lookup errors before initializing the engine. Select
> the VDE dependency from the compatible: BSEV requires both VDE resources,
> while BSEA has neither and must not try to acquire them.
>
> Use an unsigned value for the counter-control mask so shifting it into the
> upper register bits is defined.
>
> Fixes: b01f0a7c1d9d ("crypto: tegra: Add Tegra AES engine driver")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/tegra/tegra_aes.c | 107 ++++++++++++++++++++++++++-------------
>  1 file changed, 71 insertions(+), 36 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
