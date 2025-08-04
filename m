Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9817FC87FD3
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 07:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09CE83DF7;
	Mon,  4 Aug 2025 09:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yeSwk5Te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E8483E76; Mon,  4 Aug 2025 09:53:00 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D551A83DBF
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 09:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7086dcab64bso28074157b3.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754293976; x=1754898776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IxBcnUrCBxoBZbIeIlXp6b2CBrDCwkPRE46e3f7ORIY=;
 b=yeSwk5TeyJW16vqV5Wjh6gye4ph0AswDrlelz2tfZYRd40glw3gd88B8WmjCpl690i
 Om034j6hBGdVclWUIkX03C+fKvMoWDVW2eqxfNTAahH0mp1saiMpP0c1cAdwemkL2bo8
 uSdAH4nWDPbtcCCLWOtQoUWG/NpyueL8LoEuYgiNheu64ZFdqX6XWUSfh/RLRljbF77C
 YW/pcfy+DbDCgWUMnFy0lqwU483Ers/XmFmC5fETZmOmsb7LZWBVX0AlfVEhDIv05ZQs
 GaNU+4J5yx204MkDqymNDUnRmCILN+aHuIing5JCv+XJOYSchZm2TeNMAWxXI0/U47j8
 UjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754293976; x=1754898776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IxBcnUrCBxoBZbIeIlXp6b2CBrDCwkPRE46e3f7ORIY=;
 b=Jcy13U2Ex5Q15PARBwAJuvTKSgnUMxY9HAS/ugCFUwZ0PNZua7lywIV71CGmNapYjg
 mzj2wV2o/WZw0f/62GzBPQOxUb2UjcTargYDTMNptC8hRIxAnWU8K9keqvVuxMJxL3wP
 EG1jtM/fJ5C5fQrQdbwnqeGyiI7XvR+mbJmfaEIbFoVZp/mJOCqiOWWoUGEMSDVeigyw
 TTCJFFbepcohpep/V4gZsxuSI6pEHa0CbZm10xFcb8wdWJ24L0G+TXQeR0Q4BcbKfim8
 Yrj7sOYKdFGHLN9/neDcqfSFhql6VtRFlxu75pQPaux9oNuiVZi+NMCIZkgJ9d3X/lYd
 BQug==
X-Gm-Message-State: AOJu0YzMG/WTeUkJ8WzwHvm9ED/kmyWXb+4wALraoNHiGhfgRugljrl7
 Z9WEdab3dkRSZ9hKVuLXy7E51OvePcj33uRXqW5xxxU/XyirsUGVaLNpYXty3SL7hGjGkAQGRWh
 ZDS/+5KQr72gFf99MBrmP3KwjIUP9l94DJ60va2S0Dw==
X-Gm-Gg: ASbGncsRlQRkBPzyptsn6TcI05H8i5hhPQEMWSwC3RdcUldWnY3v2hqeWubq3s5FdSj
 6+oRmHPcNa8OGVsoA1CYEztkOhqTkcm0TgWW+Kp9ObR7glCNW9K4E11X4K/nfa501ATyLGNKjV+
 jZEebvOZPCt+ce7v4NBcuf+VxkuoKn5s5buBZKr79ttT/oEVc9beCZRQH9cPubS+LKxg6hUXFi8
 +pwqWdf
X-Google-Smtp-Source: AGHT+IEDmY3Y0j0/mDlnPUvvin7stB5oUMcQo0iNi1alQtbrrnEYgX6yjPEd4k4YAObrsriX/698ydsi2cSn+Wv4iik=
X-Received: by 2002:a05:690c:6d0e:b0:71a:183e:bfe6 with SMTP id
 00721157ae682-71b7ef6f308mr110955737b3.31.1754293976636; Mon, 04 Aug 2025
 00:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <cf0fb712-40fd-4ea5-b0d1-1f923bc088c6@canonical.com>
In-Reply-To: <cf0fb712-40fd-4ea5-b0d1-1f923bc088c6@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Aug 2025 10:52:20 +0300
X-Gm-Features: Ac12FXyOVCZTeOgxITOg86F9BHtieipTw06NrZ4s1YHgkt6uzVFd9uwZnU6_LBI
Message-ID: <CAC_iWjJO9STWqAz2z75isou4JdTC7DBynFORoTHWxCH9OQt2Dg@mail.gmail.com>
Subject: Re: [BUG] test_efi_capsule/conftest.py fails
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Heinrich,



On Mon, 28 Jul 2025 at 11:25, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> Hello Ilias,
>
> Simon pointed me to this problem:
>
> https://source.denx.de/u-boot/u-boot/-/jobs/1208907 has this line:
>
> SKIPPED [9] test/py/tests/test_efi_capsule/conftest.py:103: Setup
> failed: cp /builds/u-boot/u-boot/board/sandbox/capsule_pub_esl_good.esl
>
> /tmp/sandbox_flattree/persistent-data/scratch/EFI/CapsuleTestData/SIGNER.esl
>
> The file in question was removed by
> 659f97eb1fc3 ("scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL
> file")
>
>
Thanks for the heads up, I am just back from my PTO and I'll have a look

Cheers
/Ilias

> Best regards
>
> Heinrich
>
>
