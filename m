Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40072606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BytjkO5F;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=fDXm79YO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B4B660D78;
	Fri, 13 Nov 2026 00:29:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vOu9LLm-6pGa; Fri, 13 Nov 2026 00:28:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54F88607BA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794529739;
	b=JsV5dCPWuI9EQGF40r+HmYjpCYbQyHF6XLM7CtYwEyeyyYYrqD7G/XrGHWBNwNRMDYpH
	 MUdl/O/Utu0atWdwgAtHAquufvXdfw7BudDiOvQdLOQa8O+BdBbNzHJo12bL8DFoUOPI0
	 JrSZG+k6Va50IIFsk5I5PGEGeE4ZQLckMm1JtrJT/UIwEdnWzRZQuL0uk+8o+XOX7MNRb
	 anvhsvtR3azpWgqNeKwtS4gnzOU76etg0S87vKDYllza6G+QiVxcA/Qizs5ACMKSZSLbA
	 tqw9QnIpbJeWP+X0o+i8pdlOTTUzt3j+uQl86X+QwaTA5koGP7vDcxZETgoClIqQMGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794529739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BB9FcHFGAl9qO0rUUefUpTI0vfQ7BMXrA93I5wM4X28=;
	b=Fd7LtULQs1uTODhe8XnOMFZOl+XPCdVZ9gNiBZW2y0SV/iK2LkGY5KOwrKnuk21g7SoQ
	 K6uE1iIahqLaavI1v4P2w7axo2JA3m6qR6Qf7tltdcph23FWPUx6Jr7NnXKuZ8ICFkbRH
	 DezUNGyStKtqzMLOD7m0+AR0ObLk29wxheNPB9TcnHhvgWnmdojKtf9HYQFogxd5c21Vs
	 biHWXtN5+jiNyb+PNUDsgM6I44ibDmGrFfWmocbbV4nTHU4ftqc3xQ4dk69czUsEBbwRD
	 HZkd+bvcXGaYayeONmPzbGDy4RonB/kZK6xRvqaeQnMI3LQvKNlmBgbF0QdCdAp4UDw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794529739;
	bh=BB9FcHFGAl9qO0rUUefUpTI0vfQ7BMXrA93I5wM4X28=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BytjkO5Fjg+0IAwynqaYTQjNOcan5iMs3YfakB1IWBeILahEx/xtyky7K9PFTtvaE
	 eH/bR//X9V4ZuJ5yuTMqRoN8Ppqd49QzFABv+Op0B6gFpkuuoI37u6VO03sq3bTdqh
	 JLhq5AJqX12J6FS9ywrV99A0G52PQhwhpzbYDpS9S3uZS+ywCasxd/LOnolDnbcTNi
	 60EF6ez8iOHO6W+Rcas0ha4e5g1dxwsLWHMW3tBAydiuxlejDsimrin+xY7Tc/4ITw
	 4Gete8e609bcffYw6DslYd0V57ZhMDGnqVibx7qwcT2juGgcQJtXARb936bCRyqZ6i
	 CUdibOL9z4G1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54F88607BA;
	Fri, 13 Nov 2026 00:28:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58B3C1370
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 00:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A8008153E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 00:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEu52Sz1l0rX for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 00:28:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D4E08150F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fDXm79YO
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D4E08150F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 00:28:54 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-714d57774d8so433516eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794529734; x=1795134534;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BB9FcHFGAl9qO0rUUefUpTI0vfQ7BMXrA93I5wM4X28=;
 b=fDXm79YO5Fhe7qeNX5vrRw9fm1WXcnQtzZL0rlwVJVnfqMiX/ieORCWAAkm7TYzog0
 VPEZkVyr2JP/Eu7VecokkVY6bpR4Z4v5Cr5KjN+e9czlcacru+Tb021Hf/OApPdJ26rc
 cz/H6DNOEKBiqoUUeK+52ayRO2kc1CvPfti8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794529734; x=1795134534;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BB9FcHFGAl9qO0rUUefUpTI0vfQ7BMXrA93I5wM4X28=;
 b=zEAKQzAU84vm98sGaYzcTqsV/4GAWaYKeFsMx5Ifr3vhE4W/Tq2f77MSVFO182qxHm
 SImv0AExE/wEMorSNoTEo3ca/M3exX/wHs04FPZ8zHsWiS+aLjAXWKHSybZbMWGRb0cO
 58m9jEBeJL1LxAHrSKVNFla0QE+MBBcbg/PE33/8kCFXxjUbZ0hQlYSQCF268h1SxHQC
 so/DZg9UkWQJpCNHUHZSrX7hJtrYm4gld1zXYYPtmwPCUlO7s41xSUEa47cTsNK68MR8
 r7LwgYCbGr9KInDIcJVVKPWTEjNrxQMVDfK67gha+urv31AWMNVcMhMaupeIoHuNIWNV
 maZA==
X-Gm-Message-State: APuU4Z97h0I+JkLF4hJJSXvWmlJSW0eKVvwwJMUKdrQ8Oy5+bOaSvb8o
 zEjgDrgOVN0vrh/56QyZxL5gmL4zyOzO1EfVRSZtlocFoHwnoTaiWnrEuJkZeBtaqio=
X-Gm-Gg: AYBFou2xLDhUPdjgq8ztkBLCJfC5FOvD8+/ONEjVXjEq4zj5YjrsXTofF9EuM+avDPS
 EnMBK5+qJtDEVuqPP/7MUotYHyymuIVSNfFr+YJ1d1VIVfzCIO56CzCPLZBFO6IRu1CWNyGoVCI
 18bmzp2hm9VddzpcioLFpc++rSyqjSS2K28lxkyjQyqEvwiQnycyQM9xUtMq1WozXb3MKDJOPPJ
 A+OtBNr5wLI7LVKdL+5Ilri1fzIkgsP3i9F+OHYv3+l8uCHssesmfcbUnpLbYKxjafs/A7uVQ4o
 Oi44dk9lXkK68wFGsCe6Hjy2KkyoHbLNEhvvZSjSg1mvlLHlszka+WIp8qHvThe62SnMI4XjB4e
 Gt/MiFP8qm+Z1c1Re8XGvnUlSg9WC4ZaiIe82dU0mDKRlM6RK8Oz2wYOPYCuLQxwTfND101T+3m
 FFdzyK5zspfngCU587RmtdzSL1CtsXrV0FG5jiKjSMCMBTDE+RvjN47IayG46wyjXvRok+hpeXI
 0lRrk4iguKSq01A2tGHMGxI1lYWCJ85K16Xe+QErgxKxcGCvDSXYM9KD5/VVyfgV3x/fv9G/McS
 R0Z8y+WdaHHHLMlJOxEZoYKRxsmidqOSb0VPHBZdTdStseh+hiF8SB7NalrghIJFedI1gw420rb
 HkJBOlQNl4+CDEFt9bEogk1wKPOKUhShJLB7M3RFP6tVis+f7GA77uhhV4WYTp/Ny3XxUMd1O/A
 EpQyR+gz9BJxRn7wvdqRRkvKHQJUHIBkKfYi7eQCKFU74bwrexEZ4=
X-Received: by 2002:a05:6820:1629:b0:715:1e5a:dc8f with SMTP id
 006d021491bc7-71ab4ac605fmr668482eaf.0.1794529733799; 
 Thu, 12 Nov 2026 16:28:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862881a907csm1036450a34.24.2026.11.12.16.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 16:28:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Randolph Sapp <rs@ti.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261029100455.31820-1-ludwig.nussel@siemens.com>
References: <20261029100455.31820-1-ludwig.nussel@siemens.com>
Subject: Re: [PATCH v11 0/6] Improve FIT signature handling
Message-Id: <179452973248.1021268.305860275227744291.b4-ty@konsulko.com>
Date: Thu, 12 Nov 2026 18:28:52 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 11:03:51 +0100, Ludwig Nussel wrote:

> This patch series tries to improve dealing with FIT
> (configuration-)signatures a bit:
>   - (optionally) enforce signatures so we can't accidentally boot
>     unsigned fit images. Quite an easy oversight, esp when qemu
>     previously didn't even use the built in DT.
>   - make iminfo verify configuration signatures, not just image hashes
> 
> [...]

Applied to u-boot/main, thanks!

[1/6] mkimage: define log_err and log_info
      commit: 0cedee4c4726016572100d9262773f89342d85df
[2/6] image-fit-sig: Optionally require signatures
      commit: d5f33a55fcedd1acc1600657264d3cd6906dd9bb
[3/6] test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
      commit: 6fa516eabd300ca9ff30e31defd5a263037dd042
[4/6] iminfo: also verify signatures
      commit: 2187b46feadf1a5e11e88b1f11ecf14576da98ae
[5/6] test: vboot: refactor run_bootm
      commit: 954ca9ae393224941430af9dc7fa7e8702a89635
[6/6] test: vboot: add iminfo checks
      commit: 11859bbfbd64a394c899c287addd672547cd1cfa
-- 
Tom


