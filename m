Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BC8C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7A8760831;
	Fri, 14 Aug 2026 21:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zDgtGJQBpCwi; Fri, 14 Aug 2026 21:13:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 559D060685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786741996;
	bh=XbUfvrTGNXuM/ldn+BXkJlvw8aRfG3JbD1VsQopa/vM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zwB0yKAEOCDrgU57DjJbU689dfNCFHztp5Jzkfhm6xQHP7U+MvxMKCBGO6qIv3H9m
	 YsmDW7773PTv+wKdNkEvCi6/gNwutrx5PTlGBW10kmrgurXdQWS90qfWM4U342sVBv
	 JzOJIVFmUEUzJblJwBm7neOxqk+q9UHOGY4I4bBtrvMHWOQC9I1r7IpJNKNkaPLnCF
	 Y5ZiHTqHmxvDAhHXQsZFwLwOPIoD0bxoJC8tTSkKige2Bz/Hu2YnSQzefoBII6Cy5w
	 NCwSFnisSsEjpDlbcLRtd8jKWcU2pxfQFF/eETznXru2lMqz64v/3nlIumKB/0DGth
	 wIQ5fQiBlc8jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 559D060685;
	Fri, 14 Aug 2026 21:13:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 391AF23F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AE23409CF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NgdgysrQzTyO for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:13:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 646FE409C5
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 646FE409C5
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lP1HFWgj
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 646FE409C5
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:13:14 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7ec58fa3e01so835137a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786741993; x=1787346793;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XbUfvrTGNXuM/ldn+BXkJlvw8aRfG3JbD1VsQopa/vM=;
 b=lP1HFWgjv0ls2dBTVVGGVJCba3BZe/4j7P01LI9bawhsYcTl8aTtAwUOi6QdQ1TY3T
 EKqGX4BPNMIECggG/MipRVfbZMCAP4ntpg4pDdyCnkczML1P2oKoxJVilocwXAg/ZuLn
 e1cK58FjmraT4pL32K5hQOcnCRh1NDpIAZYUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786741993; x=1787346793;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XbUfvrTGNXuM/ldn+BXkJlvw8aRfG3JbD1VsQopa/vM=;
 b=UDUYgpZSxNHgPKwF21AO2yEeF/M643m+nU6MG6T0kHfY7YgjyVOe2d/4FJe1qAZjk0
 qY+OgGkEcafIhO5RHxeW74Ozmd+F0vJZtjmHfu1DqonFlXlF/q8oce98KRzWUTKcq8dM
 3nvAw6tVEFxk/U+LTQvccEJdaZ4fll9pwOpJPxpuMMlDNM6xRiaXyEbk51f+EtQIZSCB
 6gltqZfzVmVH0XXxYdXuuM8DwPEgGZT0K+OwPXxvIUSelTOc59BScXol6w5CY6npLtuS
 1TDhL4kvBeBnlUFhWHpMWAOOqvMZ+6QyiGulI0GWi1arv7OZleyBO97wosgs9eqIktgL
 Ux7A==
X-Gm-Message-State: AOJu0YyvxXi99oX4ZMbXry8WIuVpR5HZBEGb04zZeW/dA57DW/n/RwRI
 xbct9QKAotMo4jLzPjvPAgVx6WcVS0Va8c3M2SXNUUxQE6ioeBcRsPIY6T9v+4C0JjD4t+XMYA7
 VxX0kfCo=
X-Gm-Gg: AR+sD11/7IHmHPMpv99Mn4v0mwV8EKO5DghvG/kEh60t70kYcaQGVvl7Na+A6YASxbR
 qoPP8T1CN7ijzX0bvt94ycYVFbwU9N5VhW+V+Q75lQtkmFhu77eFoQPXNAOu042HC8M2QOVoIeu
 NSVFmkNDqO5fzU8eaI8JLdfnS89ZyVJf0zJoH7f+C13qPGLRXKcTOxHbVtKPX7spcEztYgAsj34
 TdXOUaEN7EvuN3BN6bOPsbZK9buDi6Z51lK/ykg3GqO8P1GuVm+zC+Zrab1bqZ0/0NvBXG8+F7J
 jG+OK6P37JVp+dHewup7wGqVwJ5H5Az/KgbRdXHZm2PQCsBv19QRashpu2TwKXUxEBgdENTql87
 YcnvBZw+XCRiFGfVxWqaqXIxyfqaQpTeOm9pKSFjqp0D9omfM8lXjXz48N5OR4+uKmHRR+GF5pN
 p6FsGWbGVbKc4A2SOJRf61borSx5c9y2xfBmwoRLyoTWp4Mfj0yP6XCqaHFFkQELn7NN8gK08MF
 Ke9YUIotjSqn0aTF/ifnOWQf96pS0X50gfLpF/KawpyxRq4vTNiAMOD1E8AQMiguJ+Q10Cz/vQS
 DlmeNWh/
X-Received: by 2002:a05:6830:a92:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7f3de5911f2mr8286612a34.9.1786741993288; 
 Fri, 14 Aug 2026 14:13:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e849474bsm1785868a34.2.2026.08.14.14.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 14:13:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Cc: sjg@chromium.org, nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, 
 e@freeshell.de, jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260731001347.35624-1-aristo.chen@canonical.com>
References: <20260731001347.35624-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v4 0/7] mkimage: detect FIT image load address overlaps
Message-Id: <178674199216.3904324.10886782092358086337.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 15:13:12 -0600
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 31 Jul 2026 00:13:34 +0000, Aristo Chen via U-Boot wrote:

> This series brings back the FIT load address overlap detection that
> was applied to next in September 2025 and reverted a day later in
> commit e482fdbbca93 ("Revert "Merge patch series "mkimage: Detect FIT
> image load address overlaps and fix related test/DTS issues""").
> 
> The v2 revert had two causes. On TI AM62x family boards the tispl FIT
> image references the mutually exclusive tifsstub variants at a single
> shared load address, and v2 tried to satisfy the checker by moving the
> variants 64 KiB apart. Neha had warned in the v1 review that this
> address is fixed by the platform and that moving the images would
> break tifsstub selection, and that feedback was regrettably still
> unaddressed when the series was applied. Nishanth then hit exactly
> this class of failure in the K3 upstream boot build with real firmware
> binaries, where am62px_evm, a board v2 had not even touched, failed
> the new check on tifsstub-hs and tifsstub-fs sharing 0x9ca00000.
> Separately, E Shattow reported an overlap on the StarFive VisionFive
> 2, which we later narrowed down to OpenSBI fw_payload.bin having been
> passed to the build instead of the documented fw_dynamic.bin. With
> fw_dynamic.bin the board has no overlap, as confirmed on the list in
> January 2026.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] binman: Fix typo for the test case name
      commit: 5d1aba89f305366dd1ee59c5fd00e69cc9517cb8
[2/7] binman: Fix FIT image overlap issues
      commit: 6ac5492d596dd28aa53c16106abae4a743cb5651
[3/7] binman: Fix FIT image overlap issues for testFitSplitElf
      commit: 4a65f3eb67f43201df5834dea776aec15b6b64f1
[4/7] arm: dts: k3: phycore: widen SPL overlay load address spacing
      commit: a3112b4fe4f827a76605828d0c20de4c3895468d
[5/7] tools: mkimage: detect overlapping load regions in FIT configurations
      commit: 21bb6417641b26bfc6738ff9cbf006a47d317c27
[6/7] test: fit: cover mkimage load address overlap detection
      commit: 8e14d88252313f24257adcb74b49285e811f7ef0
[7/7] binman: fit: document how ELF load addresses are determined
      commit: dbe1b57e16caa3587c14a4abcf63559a6833742a
-- 
Tom


