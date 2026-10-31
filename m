Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE5606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oApkkFH4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=E2I6OJxt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5845481175;
	Sat, 31 Oct 2026 00:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VV1_e9Xbf4aR; Sat, 31 Oct 2026 00:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CC3F8116F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793405699;
	b=FwohQL9qmk/96e3QJDMSZCyPTihPeMFl1zskwdvVYhi2ys7M0vS6jIpW+z6BC559HxnI
	 R92dkKJYINg4Xz8DXX0myN4FX/0y0x3ZPudxIyufFKH5DRDCEqJF+JgR0EHs7Syp9nEQW
	 zMED5xb/cUKgBJHMUisbDsJ7ZZrdQgzfqB0eucNmDtOyHrnzuM/lNiEXlNk+xhf/Kwkmw
	 21DXHhxzX5ektYGq//lutl3nrRpHmnhCZfs51bZjeq90wpd+rJG6C2b+vXuDtWOIIKV2R
	 dJGXk6hpU6hRW9/FMaTo+SPR34UzHxaMsDwJbe5zQvKdyQzXvESS94ijgYIxDEuED5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793405699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VvZWn3UhzlBYgNGK67mtOtMGQwD6c/xe2KUTv9PirxI=;
	b=lxgu8TEwlLL343f4nxDf2Ny1AYoiwVWUnb6GNLEDRmJfYXejBdztj4RhvP8zxRqGCg+G
	 dYTABScUR8hqICRmwc56OZYtjPhvdRbAubDUc+DpjxiaciKPqptVy0b0BHVcsjz8SytrM
	 DRsg9VthbjzM+4edln2OC9/rz5I67CKUo/GEp2xqO0bB1eSr0iHp+D15T/2LXfS9JDEKr
	 4f1hjG77Yr0IfXW/KhzuTCQ0aSqz70kyhYOXOSxFfHu97KESFwkJsAcAOmqC1oGz/k0XU
	 V1ljbvtIxTQJ2DUOO/xBSJUq/eksYy5iCpfmG7TiCNydK6VFwGIPmmV43Valjo+nvaQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793405699;
	bh=VvZWn3UhzlBYgNGK67mtOtMGQwD6c/xe2KUTv9PirxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oApkkFH4ZDC/8Fc8GDrXSYyK74zT4j5HgDZyJxHudP9h678Zi6Y1e9v7p36TxzLmb
	 YmWNNwZ3CTlpafqiyAzijw9dXmbHXleymerExXdMrlUW2NqlAa0Tk283ZXV5naTnro
	 eyi9h0QIWEz4mDhQIn9TButtqnJCrtqm3/iR2lHznQV6A8bc7t4mQMDiEBiCemWFCL
	 AdXFhu9jygtEYJYSmArC9xQeeKL7jYj3GyPNYbha9ZOElgt2q2epSzkpe9xnHEF7OQ
	 e1QEIJJCJ3CqcJu9bvPriEQXJY6qJr0nrrkypiupruUB9WPhZj8/2XzoProwMXb105
	 8Q5xstwR+hEkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CC3F8116F;
	Sat, 31 Oct 2026 00:14:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF047529
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC34F400C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkHzc-3_07AG for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 00:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD18D40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793405691;
 b=PfcKWnGyy7POmZK46MnALrCjB2PrVgDNjeVjXOI/eGjYNb4SerS40PWlPDjriqwz391L
 mqoWnSnq07pHqdxGDVuw1V3VKiqqez/nkiw+5LivczVlV4xRZHBrMocx+tVXAX2a6v7YG
 u6LwkvXWeDOZ9lAwdiMzNfKXja2fuWwsA6DPy5VQEiI6kC4rxe0UiwVGcZqR4ePjjdq8S
 uAmc2Idzs/fpmssL6yDIOAV4tpXKqheFmYgPwsP16/kwUbbNYYmST7TihpUcspCTw/bwE
 SUvG2ExvAv4lew/OmqtvqE8c1JyHCTFsQUqdq5N3PxWLhd0ykydvFIdzeKqy/q6vW2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793405691;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=VvZWn3UhzlBYgNGK67mtOtMGQwD6c/xe2KUTv9PirxI=;
 b=KstgHUvvKvdctDWrNvpIKzXV81cgEL85/GMb1p0hPvIh89+1wTzBxqqXGzCFeMluL9Cp
 lQuTiTLZzACVDqjyjtXBP0UB64cC5AvNhTt02dh2oisHkihQc6vS0repGEOGGb8u28QHj
 72HmUmFTkHjqckfkBQ2D81tiEzn4vdRKDrW356suiDrjPrIxqSe3m0P5PGysV+OkmtyC8
 Q4dKdrQ0IHWQ+RGgY/llX0rebx3sV5NHIwTNaXZeCWUhb8NhXGmFnEGP0ycEWtSMBVfma
 XDlrYSiym7A5cqzzLT5CIyBDdfVL/51S2UyO+tNA68EnWjK04s+VpaewDcaqPTYCqEg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=E2I6OJxt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=E2I6OJxt
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD18D40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:51 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4af81963f35so869959b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793405690; x=1794010490;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VvZWn3UhzlBYgNGK67mtOtMGQwD6c/xe2KUTv9PirxI=;
 b=E2I6OJxtIMg/vTi9JTbdA8o32N5FgojeuV3O0uEnK+aMOoqMrpNxJaXpvsQHSyjMd3
 oll0RatKAX7BMIFrVuog3CCRA+7vIPJaaK8KwLPnh3AvWw57Qn7YEOEGmPBXgzVJaCRr
 e1o9G4i9i5bbPD0YpUKtIE81HB3LJv2MQHd+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793405690; x=1794010490;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VvZWn3UhzlBYgNGK67mtOtMGQwD6c/xe2KUTv9PirxI=;
 b=AO5u/8XYsPB32xVH2bopPYiqz2QhIQ8P/woebN9SKHP77IC5IF6C+iTd1qIKsA1psi
 qWe2r/DVQhZGTDj2ZJ2dqTlxluHvzVNkvUwqLFymUsqevlZ/yFxtRS7CsDw45Z8z6eyX
 Ka1N0VeHGgdkFAlX7QARwf6dFeR5tsIHMFNN38MInR7IKqF0xuVf47irv12Y3/TT1J+1
 M0ctLArQ0yZ01JUHTk0y65m9Nge6evM0qL7Ns+vCBKVIYuXzdOoztLhuynYifOmDmC78
 BP52opZfrz+LiHpY2jdF0sdKNnWUc8x8k8y0OY8fgK14yugBrZwRcQ6XQx8/bqb1ZEHn
 34cw==
X-Forwarded-Encrypted: i=1;
 AKwUvByGl0qYPC+KDLdgiXJ8RHVbuUwNkmAf6P5w/fffQZFans35ytX54ai1krFtVRSagD/WMI1lr6Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIq/MblViWON7wOVcRHEwg5eOzI+c/uIjG7F62FJpeXXSal6d3z
 DR2ABKCq1g3VbZUMAvFC6/usvLhMlL+BnZV1CIo2EKwsk4D59tBOpYGdZFFA41dik84=
X-Gm-Gg: AYBFou04KuDBIZSEF+POPB9hOdVtCZpCtMdsdxJnkvvdOLHMOuCqaHnq6vUfTlZV/zu
 GQ96BjYCweiD3lD6xd0jY1IuD6XNX9Ahj3xBcmE57T9DFWd6tkucHBZtakTL+khXRujRrebc2CE
 VKffPHLdQcQVXqNmBiGKcyvHy9CNZY5NFUX5TKzuh+E6eH9Z2nN46KGHh4vQ5ZexJvfmmEA2jVQ
 MiGYIfazqrvdsfObIXxaKT0wqTH9WB6PZaE66kSrjZLKWHmCvNToppUBpP8GV2K4S9rMyRXGnul
 Go5MakuGm4u0DQUCkDrq6m147NKWaL0MyhAKWhvkumKE8w2QqkSZLQhIKDL2enXl14dC3jdU3nf
 dQAa/kvNIHxYXZ4zZ5mlDrnKxvesksHEHWP4skQ4ttfHn+ZgdhMO1Y/QD8eSEFwjajfYfnKqdlO
 xLISLIi7BNMzzn3k7K/ZTy78qac+pSFOEKLXKzV7OvL8n7ik1nCWflqO060WoLTPmr+sN31kmM2
 q4r9V/BrXMlHjo5pRsIIcCQNfCyyKrlImFjlu+VekGqfKDBRITbsS4rA3Yqi6keuIr1LW3zu1Y8
 ByrTj2qSr35lk+4DgBKhQPhl4iMGT/WmPNXTHocBIVdWudrtBzRL6WyX7LLuUar74yj6QL8OIxL
 +xQc0W3mdJ8VRsFBdWMh9bwhxwRROEiu1pSm/pPRQZR/HRtOvwKM+2c88aD4TpmHGRIC0ht6sp5
 /7mKq0KhbuD7BfeBxJyXF/kH/PBgAxVw==
X-Received: by 2002:a05:6808:1522:b0:4d6:9133:23fb with SMTP id
 5614622812f47-5640dfef48amr2458194b6e.49.1793405690218; 
 Fri, 30 Oct 2026 17:14:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fe45587sm2625427b6e.15.2026.10.30.17.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 17:14:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com, jm@ti.com, 
 nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261019103942.2497201-1-b-padhi@ti.com>
References: <20261019103942.2497201-1-b-padhi@ti.com>
Subject: Re: [PATCH v8 0/7] Add support to boot TI K3 HSM M4 core
Message-Id: <179340568882.3856789.6750998720113932567.b4-ty@konsulko.com>
Date: Fri, 30 Oct 2026 18:14:48 -0600
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

On Mon, 19 Oct 2026 16:09:35 +0530, Beleswar Padhi wrote:

> Some TI K3 SoCs like J721S2, J784S4, and J722S have a HSM (High Security
> Module) M4F core in the Wakeup Voltage Domain which could be used to
> run secure services like Authentication. Boot flow for HSM M4 core is
> different than the general purpose M4F cores, and is as below:
> 
> 1. Request control of HSM M4F remote processor.
> 2. Assert Reset on the HSM M4F remote processor.
> 3. Request Secure Entity to Authenticate and Load HSM firmware into
>    core's internal SRAM memory region. For GP device, load the firmware
>    manually into core's SRAM region.
> 4. Deassert Reset on the HSM M4F remote processor.
> 5. Release control of HSM M4F remote processor.
> 
> [...]

Applied to u-boot/main, thanks!

[1/7] arm: mach-k3: Add config options for packaging HSM firmware
      commit: 147321b92c741adb9e2f6a767daff5867b104fe3
[2/7] arm: dts: k3-{j721s2/j722s/j784s4}-binman: Add template for packing HSM firmware
      commit: 5ccd6c38cc1549fc3be28e197a1859520b65c384
[3/7] binman: openssl: Add boot and load extensions to x509 cert
      commit: 8e4d2004d1e2701218946853f4949a62e0e427c5
[4/7] arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM core
      commit: 427a0983e889aa2f6f9bfa751d9d0507efdae8fb
[5/7] remoteproc: k3-hsm: Introduce a remoteproc driver for K3 HSM core
      commit: 6e67b32765e18d02b86e87c3c0f36d3b8ceef427
[6/7] arm: mach-k3: r5: common: Invoke boot of HSM M4 core
      commit: 6bd72149941217edf467f44f3c86db9b3657ebf2
[7/7] doc: board: ti: k3: Add section for HSM M4F core loading
      commit: bc63a70e4561f89d978e67b586ba09e29381ed48
-- 
Tom


