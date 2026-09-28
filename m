Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8E2CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCDDF6064A;
	Mon, 28 Sep 2026 22:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1Gy6WPPlpNd; Mon, 28 Sep 2026 22:41:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1BE7C60616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635282;
	b=f1Y2BoEieefHa1bH1sQuDXRW3shUuN/L+cgRr/nKhwjt1YZ90uv/MFFt7jdUy7TibuuL
	 m2szpiS9n6QiJdzn7kg8RxcTiwPjM8OT1DiLF2vqT/3g1bViHOVHs/zu572luir3nVtFr
	 WSr4wyqbHjWV7K8jHlkI8CCeQvWdPFASb8u4QwywoieuxtSSn5J1+QMY7aO8bmx2zUSAX
	 OcaaS06TsZ8xjKA39WnvCn/UD9hlfYOSWS5tCt8bImqWUQY0U2hAnb0r3S1heDCHF90Z/
	 DQGgMoJWJhd9tZ/ZjnL6C/GtVFbLN55tRSvLiO04TG6ThPT/799pdUZLlFmZ7l//Rvg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rO+2y6z0L24WWzIQLs6PXIbyOrrKwzWiOl/LGppM/dM=;
	b=H8I8Irt26dhIhfUIU86TOX5+mL3hPYHRB3H9QqfRoibM2860JdJ+gKb0J0jHgokBOEV9
	 NdmeEntxz7aYRJvOQyhkyssNP0ENvf/YHT9xgFsYONguTMFN28UtV38IwBXBk2AIetj95
	 u2w1XhIFhWOntuvxKSx3jTQKOYg5V90SY80kM6QzLqGGplvbptkJpaElPkdihJaPwTyTd
	 zh4nKi2UKXTrqJe/py69eew/0CIQ1zX6FFpV7b7PHXMobCM4T6ZZ3+MaPAo5CNRjkcKf4
	 c+smdjyjLdG6tSCEdlSH/2FsUpq9PXtDt3RLJP3RJ0w8wkA87z6vdCAb7FBXRNbDr9g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635282;
	bh=rO+2y6z0L24WWzIQLs6PXIbyOrrKwzWiOl/LGppM/dM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpWm9SlEZcpjR46/YcQoUmiBXzsaGSsEBSpFbVa7/ASk2vsz4n00YbIRSi8mSOdRY
	 hpHECLLHvbW7WYIpyVfnuuj2UcgM+Sh8yjuuiq4pRKJ4FnLpwzNU+AXf9Q2VvGkxZq
	 55GiZxBsc+QtB6dxyvWA8ogJp8GaQdKo9QoB4TK/1zP32bry2oOov8BQptGj5+u7k6
	 u7xNtgT5XYCGpLfAVU8gbD1UOgOj+yT/4phcxX8SWt5pECnYkyCkuklIm3QNZnvRHy
	 DljEZvGiS/GHNc8WEDWr8z4F29vkLo3eoSJlVFl8H2d/TgKqWCxl3yAVM8b3WrwxSR
	 OkxJAwjFpneCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BE7C60616;
	Mon, 28 Sep 2026 22:41:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 44E7361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A3FE80BDB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wo7qQJRRSKHG for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:41:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C73580BD2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635279;
 b=lyzu7hF1X4R/YgBRyIQxmfpKFLQLUgEXAM1pPeKCF5tURtlBtlsnC84wwhfoaTPPI0Jf
 sLD5IbAF1aPm8Xejrm4U+LcpdWtbSAAnYR8vMMYR8wwrNtexfZ/uLkM7wwFUr/upSbEuZ
 8jRZ/tZA444vByB1rOVbyn7Ii3SJZhO/GWWa0HsEEUdWvCNgGqjoirJ4t2726HneZGxGl
 Yf6b2dARrcO1i/S2rbdyUbSNd8E2OeS4SkuWfdorUs6SLffR6ZwqkPRZ5uOPonIesFO/o
 3SfuJS96s4s/wb49xHut6b2kzDc5Y/F3nfoxaifL0SBYLQn5JfEOKRW1fCiM6nfh4uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635279;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=rO+2y6z0L24WWzIQLs6PXIbyOrrKwzWiOl/LGppM/dM=;
 b=Fk6g6ZyegjKOTLfRIcRbL6S1jPqgIHxRni651+Gtd2hA7y8ckc+6mmjOgQC0zJ2sCSd4
 ffURqLIGwH+lndJ+/1GgK+s63021qfWLLkFh91QzD5zJjEXhqVWDXaikMfM22OeWFMcYW
 IHsfKHeLTwd7uENbzex8Sxb4cNlav6PNWOb0vrniyr8sFFkbfj6szcZ2MbWxkIsgb/q3F
 IyVjaJyrE3046YG39YrIrPJzmPJbarhia31+1UmSmftoNcSg6ngUchCrgCJk7oU01MLD1
 Ar5it9QzfBgGb7K7X8FG1Udpo9XsE38iIEbXSi7S6g01GkDfvMrXkAKkNL6ZXovFl6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=INzQdmP7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=INzQdmP7
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C73580BD2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:18 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acae8342d2so169515a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790635276; cv=none;
 d=google.com; s=arc-20260327;
 b=l39jn62LP6QAdYTPdKfScvDUOVTXIJ1I4A2e2+Fq6cZj/4CU8b7nvq2gfGUFhkxmT3
 a9I0ygizK9iKCzux4ZgieOmSJKj6jHgbUIuCuzmpJdvxEdKbSL9gWqGCITIA6iaGteLr
 +bYaJuDtTQ38HCbQSllKghaWAzzac8126/f//njP7/d0VdhkbkrRiN7WOh732+JSXypt
 YKHtVyCGeU+qDGYWCCBfawta5WeYwtdWQFpAOItCUWoxT3bChFGGtj3zIWw8eXjq7G9L
 UH/snQXwe5SI0xeni1jWbxNdxZ/TX5jmooOseX5rIDiomR+bE/RIgMbweyZJKNVB7hgR
 mfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rO+2y6z0L24WWzIQLs6PXIbyOrrKwzWiOl/LGppM/dM=;
 fh=zHYqTxTnOXE/hP0ORrpIRwJkfbLEYZXH3ELvqGunHiI=;
 b=Roua9uYVm1YsdPcutUl9N8u40VBD2MLvgqUcMtGH3W37KA97nPkEmpruybVyiGSgmj
 ZU6Hf2Yo8FSI73sRzV/Yum9fUF7u+CN2bTB1ECS0tLm7WGEZOTbffeqj/mbs4mQzFida
 N5+eXE+E73P6u0WcKFMOM8lGvCgUa3gsgDACwUtbhwDGjoojDE3PH/afKaLY7cZQyZ1m
 lgQ10hueX0MH2z4l6jWA5XpMa6/+7ZCwHFMO5XVumfyhXhQ/fEjJybN0GBF/ESF2s3BW
 jyDayi9mWs1ZfW+J7jkgk9aHJXbm1xkDfzcbQ1+g01MSewcKoeCWhaRzmfgMms4VeTj9
 6EUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790635276; x=1791240076;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rO+2y6z0L24WWzIQLs6PXIbyOrrKwzWiOl/LGppM/dM=;
 b=INzQdmP7/qurAkR4vM335rablhmjaDr92ixzXfewMFnmOXerhWjVzmmwU9NEsdjvsh
 NqpXqVRYjuZ2QO8CqazobU0HMGU5o6bBPkNksmqhM0DrBpwTIh3H7W6zXwijqsyyOp8J
 s9bm8iE7z/Ueguu75zzaWBE/Ez3KjOQS+Rdtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635276; x=1791240076;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rO+2y6z0L24WWzIQLs6PXIbyOrrKwzWiOl/LGppM/dM=;
 b=HbGwk5EZonzMqt2KLekcD3lqO12LkpBR/OlmWx9QrxiXRTCbuqRkuHunmdRcwfPlrb
 KZmY7eUnJtxRKgspwOeOxb94xT8cbQInD5G8MkXaZ4GYH0PU9bqnW3nJ9YSq++q4YyQZ
 PWFIJm0V14wgT0hqr4/2LZ2MtYDO2KjuFAm5KJzLc1bnVyyWwxl5iu8JhZUlkBo/RL7+
 g6+HoBxO7e/WxWwCv8oD9jCkJ81ldFZFFbiaHCrmw3Bya8EkHD35GiRlhHyJewLpQSm7
 40K+fms4WIBEx5/6ZQByjox3Gj2pCPbd7Xx+k9AgTF+WUg2rDYRhUh7eR4m88Me1N48l
 rwjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMXi0r/wnmnfUZFrf94iHSqqESK5VNP0VK5abZUDumvVfRLVbOS8yW3kEeVMojkmJt8NvlYgk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJOu9U7kBSqUxpS8XgMBLhrBdFKSdVlPWJtJogAb8mNbjOWK59s
 zO1RlHFYqw0kRoJrZB9YY7ExC5H+MnEuyuZ+d8nw6p0Qzt2BTSAkJqH539dCDT3+hUnDGuxLsNJ
 EkY49Omtmf9J1oZQTcMPLOGHY25n66gk6VN0oDHx7NdTxUtM3gUH/2w==
X-Gm-Gg: AYBFou0/sBpBbcwoWGIDWKlAR6cTcHt+K5WXF/VnBldqOHevaFa4NLs+T0wiYKsGXeL
 NuF2pxWY6bsSc3u5NSvQddXRYiNrPhpPhZaRpfZoG42m7nskIHYfxOVwzRdYH9wWXUzI9sXAHBg
 MDCh4ZXUP4tEzK1tgTznH2YZh6mBLGoo1GLQfCwEsezdb7xRyYQ5irQaBPq4LyZXNa5k7oM95MD
 kME6L6+3BRMUx00UnG+sCF7El6+YxwMvezHs5QkJdLfw9InDCKfSDk16u2iB8I1NFLDo7XIyUwb
 FiOdjRC6+CEp81eDtmZLBjiftwrhlpomoHuGn5A3La2pYf4KgCVuhtKQbg==
X-Received: by 2002:a05:6402:3808:b0:6ac:7d58:dbff with SMTP id
 4fb4d7f45d1cf-6ac7d58e288mr3074744a12.13.1790635276351; Mon, 28 Sep 2026
 15:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-2-sumit.dhami@oss.qualcomm.com>
In-Reply-To: <20260928064041.1432227-2-sumit.dhami@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:41:02 -0600
X-Gm-Features: AclHuK8Cloq6tEMvTeawkWiEkmhtQQrmeKekX7KKAu_dyq39eokh0tYcBxRoQww
Message-ID: <CAFLszTjdK49H84qRAscuYGJLeyi7tfbeet_1+8z8PhWwJ7NNLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] disk: part_efi: fix first/last usable LBA
 computation
To: sumit.dhami@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com, jbx6244@gmail.com, 
 vandhiadevan.karunamoorthy@oss.qualcomm.com, 
 dario.binacchi@amarulasolutions.com, sjg@chromium.org, pbrobinson@gmail.com, 
 quentin.schulz@cherry.de, varadarajan.narayanan@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-28T06:40:33, Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com> wrote:
> disk: part_efi: fix first/last usable LBA computation
>
> gpt_fill_header() hard-codes 32 blocks for the GPT Partition Entry
> Array when computing first_usable_lba, and 34 (32 PTE blocks + 1
> primary header block + 1 for the last LBA offset) for
> last_usable_lba. These values are only correct when the block size
> is 512 bytes and the default 16 KB Partition Entry Array size is used.
>
> Compute the number of blocks required for the PTE based on device's
> actual block size and use this value in place of the hard-coded
> constants, so the first/last usable LBA are calculated correctly.
>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
>
> disk/part_efi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
