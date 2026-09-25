Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37D6C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 12:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9268812CB;
	Fri, 25 Sep 2026 12:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRAfcI4qgNyW; Fri, 25 Sep 2026 12:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CEF50812C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790338322;
	b=Ryl4JAWRzjaNA7CG1M4mEMa2+ZRSqTB8DFEx5wYN2o6/EszzPiOYeHLDKBAyR0KyUUGI
	 /aAnGYltbgl2PG8WrlQb57aPhEWGkCfIkLWCktrRsDxIP9bhDsNnKoLPFlsTt21aQrpbO
	 thHQ/1w2NlBPZAcvTOrX5mbtmnuAasrq1GvnSQT0IqrrTJCv/1TcykW5exJusDWVVnD1P
	 EpCshdVCTIqC7lmUF7IyrNrRjVx0EBWgtRGyaS5WsQ/QVJfL5oqoqIAvfG7IRgkyUjp13
	 2y4jkPA8+Ljlv+KN/+Utnn3nM5gG1qEsAJn90YrJz7BthzaYO67tCU5iMvbakBYbuhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790338322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dCcUtcSWnLgvOPSbXQHo7+KL1Ih0bDanxjLjaG44KzE=;
	b=CO5ueUjDUSN1doAIzvVeB1AfJhlPUm4z7P7bYXl2PC/N8caSHct5+YqeFdtPk0SuP0u+
	 mclcKHrbcTw9rXOAZPkTwqm3LuEMGB8o0K3b7JxisP7G3OtYiltTmp16f3LhpMpI2kEkD
	 zkj+PGitHUxCVZttAj99ZNQebw+dXeducPZd1dxnbiHW9bKONpTYIO5O6lJUpfwIp3VBj
	 JoMSeBCvz8nLtNn+GF8oKBbiFyMndpMBy6iRwHSp111lu9MOJENoCW8FIZlPll94gCc+L
	 ZtPBGw3vbcZsNI0h/RThXJ4E2kjqassjGi6PTEN3IET/hiOLe9yhOwM89ertmRb7vig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790338322;
	bh=dCcUtcSWnLgvOPSbXQHo7+KL1Ih0bDanxjLjaG44KzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jhPLp8DPPuKIGq22aJFpCYC4JaLLbBMtUtaCTnj/mp1hvtPpOMyDTeTWXTSNjzUh9
	 +04VrwVecoXpWIDRmFEX5QPlqZEftMlLeOt5hvLfuG5H+fc6Xikq0JLxcCqTJqotz7
	 mqs/7Y8tDV5gJGz5Wg46izn0ff4U5W90bQJgeVyuuKHB+ZCYg63/ChrTFwP/XKy1O2
	 7AZKp3FDW7P7c84ZI3Sh6qpuC1BE3aE+tAB2wpH4iHZYKY4h9Um4ARf0cv8w8wnmg/
	 ORqkL8opvGAMZ8A8zgncWLxmK9tNjZd7jOVZLUufcS6GWj7A/cxDEHEhrqVm5mOVhq
	 t38CmLoItIQbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEF50812C5;
	Fri, 25 Sep 2026 12:12:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A9C7A334
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B61540515
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJ8IeGEclMwT for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 11:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 060524009F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790336950;
 b=AVBaMovhLg1PUvMIgxLQO7R4HN8jXOHVcgLKIsLUVb80uZ/fs/TgBpN7lQWRxzBa/HND
 TIYa734H4rYfa2N16U7rUSvX5J97jyBETkp/qqrx9PKABKt73BCu40i97P3o3cWUUVwdZ
 BxG2TubPs+cnSt4Uf1gX8PhccpFOG6Z7PjnlQHj51p4TVh8EHhk59p3ltO4tfF4Bo29dp
 srExxqGbR2ZKJ6ZWMqt1IfjKgMDjgB1XIXdNJcSv0TZ3rIuy/kNRTsREktolyon1UdKkQ
 vYV+tp7Rct7SOdkfmXFwVxelFDLzv9q/gDIbUu219fQ63K6sFYgfJTGaZjU1sF2ZIhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790336950;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=dCcUtcSWnLgvOPSbXQHo7+KL1Ih0bDanxjLjaG44KzE=;
 b=f2c4MoKbjFymAM7MY+vhEGOOeilMAHLbZFCY5/g550GEj1AwgURK5EcIdNsRUYs1Dplt
 rHt9jVdVNwU4uZWSYLVnnryoB1Ns/LD7Yyj5qc9ERVJx3NO/tR8GypP5W4AK19nzURNDt
 Fh0aoQOf4OhOvzrWlqNS+pjS0TgRc+XA4E3haHhJ0pSJLsl3D5KZlSDTiuQgMg9tG/5rI
 4kJ1FkoK1XvmUE30xwZtfOd4wMlulXRLpAUrbLBEezkOes5bdiWQDHxDQpzJcqYLpFnh2
 5Tkcwd6YNqUI4Dh9V3mONSrpNg8Hlq+ybz+oszmS3eGkLPfIpws3UZ5s+8AgFzT5rKw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=sigma-star.at; 
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=VPp0m3a+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=VPp0m3a+
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 060524009F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:49:09 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-488615e6cfcso824701f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1790336947; x=1790941747;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dCcUtcSWnLgvOPSbXQHo7+KL1Ih0bDanxjLjaG44KzE=;
 b=VPp0m3a+fZiKJgqBW5JuFD9O6bwojJC7juP+f9snXdzRTZ4gSqgAXN4koWTIqD0c7L
 g0QgBkreUgt6+U2foObGE/kn+BIPv+2BiKX8rLow9pkOFwouf3onYZWa0Uax7Qxw0aiv
 E7gwoWCtHgeyusfRlq6qfv9KwYMBu8k4hS6gJ67irj1cgrRQmufDcv/yeifPkbcJiRmP
 8e6pZVDjVKNjlptINoDIPYLm3rU/20wnr2be4AxpMN2heulRtEJSq2eDDUm2sCrDhMx9
 PtKuV2qQlY37IkP8olUDNmUHP+UnojsDb3mR1wuVdPl4ZHDTAJkOSqso/tCsouxGCq2k
 gRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790336947; x=1790941747;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dCcUtcSWnLgvOPSbXQHo7+KL1Ih0bDanxjLjaG44KzE=;
 b=s3rwNZe6Jd7pkAfR/sxqCMxq5la6WeDL75hxvfgm41Dq6gVfb9kOIT51SrmEbi6G0w
 SOkpgKEgoGFVkMAut7YEhnN3SglFv3erWM1IYUgMafKdSCPu+u/ento8pjY7N6+Hgf+p
 f5LenjG41IBWzXDxnmxFTBxgQty+CeHAPeFj58J8j8UxWSrAKM6KfMVgKdBAfMLoC1Gx
 6/Xsi07QyknDpA1o6eqh03KDRp++hSTGSBHZeaaoMKm5uABDnaOPri9/CW/IvLMnsG6i
 1z6dJ5gASQ6JnN4Qck1xlq9kutUTTwXKCh+PRShBsmy3uU3EparlPI/+ktjt0BfZscTl
 ix2Q==
X-Gm-Message-State: AFuF++kvKs0o3lhYXAYCBqdvQN2KCoVNqmMinJWZZYFqwtWLHaF8XRFe
 6Sf+RdMeG2w07I6NOGvlhIYlziTgm0MZMHag8DDDjga7jbP8SmkpwICUi2nBbALIE2R3VwB6eLZ
 6k3YoP/Q6kQ==
X-Gm-Gg: AYBFou161/J/WZ+39WzU28mvU+i1VcffsxyXo8I6LLEp9ZMPW8Cub4IlybEfIGn3don
 pIDzO+DvsynQjOuJNmz5F4kYm1NGC9IKdVVfYjfOr7RziGgGDpeqGTOmuScMuJj7QIJOi8xA0Us
 xzbBzpSZ6oZAVca7OkeV+c0C4LgoEjUOORmIelGzx4Umor5/SXm5VPzyGQz7YnC9K5fhhq5qDjZ
 4bpSMnIwOrHWnZHDLGAuhkFRCTUwg+mV6CQDJqkNQ3K0c+c4CNBagPY5KBUlT72I3bv5NYTKbuV
 2RAyNUlcViPnv9uvpm1+7FUXq6AYmOUuRi6Z5/QF66XLZJHTZyH9n0tRK44zeQVJE32MnSQhUyW
 Z43MkvSoHZTx3qXwQuq5a9jl2fpMm+bWVidKzdeUatatS0Uu5iUUQDhpcSewnjpUI4jzAa05f5k
 5FXKq6P8bE4Vb1VAlGKeL4nhNluntztoGV+RTxSmYecvVzext0vYKuxpsXfPyFw1iuWarv2irT3
 u5dHepIkxAj7hhcY9hSxZjTGaji86CevBswXUGeihybTBmM1zk=
X-Received: by 2002:a05:6000:2893:b0:485:8226:c69e with SMTP id
 ffacd0b85a97d-4887170dbf7mr10601055f8f.29.1790336947245; 
 Fri, 25 Sep 2026 04:49:07 -0700 (PDT)
Received: from ?IPV6:2a04:9546:1c54:8601:c375:8df8:9c4c:d013?
 ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a84205esm6515510f8f.37.2026.09.25.04.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 04:49:06 -0700 (PDT)
Message-ID: <1284233a-b09f-4f71-9c1a-7ce5fc616edb@sigma-star.at>
Date: Fri, 25 Sep 2026 13:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] binman: pre-load: Allow signing with an OpenSSL engine
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
Content-Language: en-US
From: Lorenz Kofler <lorenz@sigma-star.at>
Autocrypt: addr=lorenz@sigma-star.at; keydata=
 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
 5OAWJ7yLRAI7WigUCHhbizN5NSso5ztVJWx89g==
In-Reply-To: <20260917065545.1989088-1-lorenz@sigma-star.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:11:56 +0000
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

Hi,

gentle ping. Please let me know if there are any issues with the patches.

Thanks!
Lorenz

On 9/17/26 8:55 AM, Lorenz Kofler wrote:
> The pre-load entry type signs with Cryptodome, which has no PKCS#11
> support, so the private key must be a file. Keys held in an HSM or on a
> smart card cannot be used.
> 
> Add an optional 'engine' property. When set, binman signs by running
> openssl with that engine and takes 'key-name' as the engine-specific key
> identifier.
> 
> Tested with SoftHSM via the new tests (both paddings) and with an RSA-2048
> key on a YubiKey PIV slot. The tests are skipped when softhsm2-util or the
> pkcs11 engine is unavailable.
> 
> Lorenz Kofler (3):
>    binman: pre-load: Move signing into its own function
>    binman: pre-load: Allow signing with an OpenSSL engine
>    binman: pre-load: Test signing with an OpenSSL engine
> 
>   tools/binman/btool/openssl.py                 |  28 ++++
>   tools/binman/etype/pre_load.py                | 130 ++++++++++++++----
>   tools/binman/ftest.py                         |  91 +++++++++++-
>   .../test/security/pre_load_engine_pkcs11.dts  |  24 ++++
>   .../security/pre_load_engine_pkcs11_pss.dts   |  24 ++++
>   5 files changed, 266 insertions(+), 31 deletions(-)
>   create mode 100644 tools/binman/test/security/pre_load_engine_pkcs11.dts
>   create mode 100644 tools/binman/test/security/pre_load_engine_pkcs11_pss.dts
> 
> 
> base-commit: 444aca6d1439e4c4b9955171a7f45c053b540f69

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, Austria
UID/VAT Nr: ATU 66964118 | FN: 374287y

