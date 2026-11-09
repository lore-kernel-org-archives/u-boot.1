Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7E606A332
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SyA5372/;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ns8GBECv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 257E3810F3;
	Mon,  9 Nov 2026 17:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DwXzo1WJguxl; Mon,  9 Nov 2026 17:30:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FB4A810CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245405;
	b=teh4WUBhzL+qE77vQJgTaKBeJm4O48oyjG+nVBiowT96CkWekZ5SdcKEH7CT78uzKED3
	 PO2HXVGgwW1qSmlVTPSF+G3llmpnf99aq0hs42LnqWRVyB1VUShKm0xNmidVhZIUoNgwm
	 5SPmErRTyGVugmSlqm9byNnZ49epYj/XBA2CfV9aI4QNRV9Qa18hNn/pAbsud+rG4kAkY
	 YecGThSR7Zcf5klq/g5gwbYPRKjYkAFMnZ8ARyvL0JWv3jUfIuezYpw8SrrH7wAo5Ogcf
	 SXKv0WFC45W25Gna5v51VxYX5bsrD0+wF4RLsjifldJoJBkbdFOBmtFNsp1lAxQyOww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=akTMatgHBOCKN8u+d85A0JEIx3Mtbq1ZPDhx+YtOPhU=;
	b=dh7+W4F7XoYiEhss6UtYOPE/hhdQtXO0vUFg5DufaCNt6kI8MQLqDdj90FZU8i578ri2
	 owiuG2xg8WBC/VQlevuynxyT9JvvK5Vj0zYR0Rjo2HpBlmXPB3mpp/pjUV40zLwBvx18N
	 fY/J9GFl8eJPB4ZR+7HHgC4ZnVnN0vMzFE89fbYbiFRr8KgYG9TxFvSNat/zP8pP0dOWZ
	 zqI+hiTT0jl4bVjukeIJ2EM53jc+XLOdUlyjjk8XyxytMNUTCgGWOwKYqRybU0AXyA2Y6
	 eCRwhL6HfSzsKE60NvRq7tg4PEVMeRgFpmVfDmZEkK8kY7jXtOprgXoBKsylgWP79UA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245405;
	bh=akTMatgHBOCKN8u+d85A0JEIx3Mtbq1ZPDhx+YtOPhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SyA5372/bND57ijh3fzlhVlMSeoqUDk9D3/2LlURIMgiTtrBQnYn/ZpcZ3xUGqtSg
	 WrVcNUyWOkFInSvBs10TTJLU3Ic0lQQjJerreiwU54BHRh69VzgvxtfDS+yJ/gBe1S
	 guQrHYA+YD+p9vba6OZxuta69C6tAaciNEvXL/fHe47YJen7PEni3AEB6G+JucIg0u
	 mzLJwli0I4dZxZBG+41vRUFFUDb5AGZ6CjwXiykteAWQE2YqgoPw3mNugY/ZVQ/cgh
	 OOE0guwrPenYkuOCKVvYWb8WMdB8JFIvtjh3L1fm0yyJkgfNUa7HOvDwZ1SEnAvPka
	 Cw5wvmvEa9H6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FB4A810CE;
	Mon,  9 Nov 2026 17:30:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A9D4251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60AD5607FC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5duBR5ZaH__V for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73752607F0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::;
 helo=mail-oo2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=ns8GBECv
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73752607F0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
Received: by mail-oo2-x00.google.com with SMTP id
 46e09a7af769-84e8a9fae57so577000a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794245394; x=1794850194;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=akTMatgHBOCKN8u+d85A0JEIx3Mtbq1ZPDhx+YtOPhU=;
 b=ns8GBECvzrTabxdCQXDoTJrct1qbxsmxotv0ojnpW8JfxBlW0BC0MR87mrmkf2lCLe
 c/scyPGZQMX4N1JtfosXMbyDRLMD5ahuW3WRljl0puGfWE8QHpnoaFsY3GLtv40gGplN
 ba/7+M4axs5842LIu9YsEVg2ai+kCR05EBnw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245394; x=1794850194;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=akTMatgHBOCKN8u+d85A0JEIx3Mtbq1ZPDhx+YtOPhU=;
 b=NTc4bUqvx7Wiwfty1VLbhIzXQGIus2oYO+PFHnfNS+eFTRJNWKiJLSy+1wbVJEbcyq
 Hr77setPKKFSlBU9H3R60Q10ztCEeYOCxL9cIAmyykJvwnG6Chch8C4C+6q61S5EaVFR
 7JQfEHRAHtWojzn1wK158u1kpdKOk+VK91WkdWLebr6GgbRyDDWjBynFvWyVO9fd2rwk
 OTpirpGaKWRxouE9kPCpHYuAcix+OWtsMj2LSk+HNE1+jXxZ6lYB7Eh3j7n2zIk18DRf
 MEEMTqr2rmjeDDYoHWCzAuuI7lXjIulTu7N945vWFfVepf8jZ+hH0+QIFNhqCRuE0FTj
 NnqQ==
X-Gm-Message-State: APuU4Z9ngDiLSdkqYPAekAeMP3dXHRsHNQawlSZEm0Ac9wlcY9jAzqD4
 cSO60uxCSO3MjWkAiGEDXkmDg8tgV+YHLhiXFCSOrepxzn2pEuq0RC99Is+lYQptu99kVxB++1C
 KSMXa4OT2rTHOV8w=
X-Gm-Gg: AYBFou2QjHqWMyvbzI9y0fRQByr0st/W+lm40/pPVIISxwkwoJ4meqGhBV5TvWTeZk2
 tA8LqouUnayaSHtdrZDd0jp8lWyf4ofnk5WxW5KDYN8KllWuQ2H4XohdJKFmpMhxZzohj/HlP8w
 3ZoqY9YRmtiEGIHRydGUnpe6JyslwgrSTugaP15nRMuhUsdw3spxXHEeYEK1FShXNGkehEHsJje
 ZFN6jZFfTcEtSnbxM/9Kk2sJPUOSa4ah2NNIURNME1HRiQwuvZaftGylOOAhScZ8AtU+/4fuKw4
 M4M8AD3l92jXlAqkyKGhZT+Pn4lpHWnXZXcoCSUkoDtXNJ39DoZZoyo0HAtJAx/Qt+JpaIvMAT4
 oFCA9WLXpjuq1Qs6OaeXTq1OAJmTTFKnZyVoxa0WofDfExm9PVM3HKv7rK2c6qKAIrq+ccVXV4R
 ycakEr5RSTDNWWKyHsLoRWsYCCdUlKr5Y890uzd6T4fADqD2CQAxL+fs4oAfoZnFv18D+hF4Dga
 SNm7FbSASJeqwMUeDUblqxbr9SaSpZKww03nWen5aCkMzmqBIv9pogc1rVE/01IkR2BoR9FkhKb
 xHbrOVvlfg8RyKllEkxHcMKYMOQPgix8jtqOZdD/zGqcFbAk7vrpkJqEw39pusTSO14L770WROU
 4KfKkiCXFEm0Eax+X8p18VEZB+wA3poiBHd+qW6Lo0ddrfF8328nopaBktZtlkMPhpPJJRQ0JVP
 O+5rcYUYbWtVWbUeNwPxqE5oBM49iQpJc=
X-Received: by 2002:a05:6820:2224:b0:6d9:4c33:6504 with SMTP id
 006d021491bc7-7170f2dbc88mr2193941eaf.68.1794245393809; 
 Mon, 09 Nov 2026 09:29:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860db8481d7sm200546a34.15.2026.11.09.09.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:29:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261109132328.2040740-1-stefan.roese@mailbox.org>
References: <20261109132328.2040740-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-watchdog/main
Message-Id: <179424539319.2040456.107640454913954408.b4-ty@konsulko.com>
Date: Mon, 09 Nov 2026 11:29:53 -0600
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 14:23:27 +0100, Stefan Roese wrote:

> please pull the following watchdog changes for the main branch:
> 
> - watchdog: adi_wdt: get SEC fault source ID from DT (UtsavAgarwalADI)
> 
> CI (GitLab world build) is passing:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog/-/pipelines/1928
> 
> Thanks,
> Stefan
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


