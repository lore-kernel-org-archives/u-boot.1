Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548660A2610
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=irvz/q1w;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y+H9jkH2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CD394089B;
	Tue, 10 Nov 2026 14:51:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wU9xFSmNlqGl; Tue, 10 Nov 2026 14:51:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A262F40873
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794322315;
	b=Jd/zmovtQAbCTJZ1DoJkQ3uHZSYeUQuAFE4JnitRJzG1/YSsdHxxCIv0QxwfQ88v1Hmv
	 tY173qRAfxR6Bm+79P1qt3KUA8q7a+obfeGYwgiEqtv22oLtrinRiOqdVk/efWLSSL9DC
	 u/5UT6y2Vt1KZ5iVM35lGi+jqYpxlrQ2ldeYN2S5IqrRNyI2dfZC9Oi6J2t14b2KbKKl1
	 8GUwkBfN2BqCxL9DlG4Mj7s6EhUct6CDbsLgbAvx+1tiEY4L/LR87dDtM6x8x2us7RplR
	 SVI/6rgDfOYMU4O4HquHulrjo661cp2ofhYrtnU43uaBF5RNZSRWLMdEPOFLsXfu2HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794322315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MMhEJ3xO3IRVXHgIiZBAMvXV88fkk4Tdqu67QdFSSrA=;
	b=pkIuWJCVAybMGcD4JRR8s8B3gK7s4NIfrYtmcZFHdENWWh07hvBVvD7DGsLhmHgM0a9E
	 VwUhBK/lfpN/9hyN2iOd6JA0qEJW8mWtz+jk2URxQ8Q0zPSVaiXAvtwjvgZP2P8VUeZee
	 0KUMziU/da/zHj0Q8n5efBu+wY2yB2bDnbfBBYjUrljU043xxoeRgAaP1FzHhFzYEcY1u
	 owCndD8r5rAHcyxDmmaWwg6+KtfQrnrxsCjTkDIEfqhpVENjm9Bntx0AWqjkBADje+LBO
	 F+c09XILUW6qk0VF4LtHYhiBHpGNq6rREMVCc/+THzcn7FtMngHJL9WLox/RchKnLBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794322315;
	bh=MMhEJ3xO3IRVXHgIiZBAMvXV88fkk4Tdqu67QdFSSrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=irvz/q1wqjoeAMn+i2eQX57krwUV5cz8PlcZu6yYG/REEjx9YiObZLfLNo0hqxf8U
	 q+nVtUtBcDTTS0LgzbWneBdgsh3cQEim5M64BOj7ghG2JUJWWfdSrO4YjwBMMc8OO/
	 TJwfG0BLOvaTABMuhg8UWxQSDoY32eony0VQ2WZ9AwcXlONS//nvAMtmSHxMNztLC1
	 fKE/V9wrWHNX4A1gsy/Dgeq4PHjXXp4uFoKnAfN52GJY9JiVDdla0yIvmPhWgbRNNP
	 Df6x+JIO22VEq6ROIOS3FfF1weLA/VjfGCyMjgDV8g9gNdKqRlm08o5Xf3SglT6JEN
	 K6BxppLcUwZvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A262F40873;
	Tue, 10 Nov 2026 14:51:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 66A6728C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6444B608FD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBZPJQU9N5SJ for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:51:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5351C608FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Y+H9jkH2
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5351C608FF
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:51:51 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b56bbf8330so2753081a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794322310; x=1794927110;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MMhEJ3xO3IRVXHgIiZBAMvXV88fkk4Tdqu67QdFSSrA=;
 b=Y+H9jkH2hhkmQMlSdaujfb02w5XR7QjIAm1JgwC5V4/051a8q6pI0Gwjm4CGcms574
 DXtiGiLXYOFfTMhdqBmg68sikFzmXH6+dsLWa65bvN13nZ6IuavFlrSaJY6vvxGfBD2k
 cz08Cc5VVfDmLe54Bp+hdm9vRrZw/wK+LIdKxEKHLrl8DnJSEVOZE/YdjJs/pe2ALsYY
 5iMeTwpMKERrM8wkcB97CByuMZtk2MZaeyTG6x43HWck5MiPRv/jgrOoPgWdynNc1CD0
 wo7ADk5Fy46GDtPABHHglZspBZOedWM77A5OHc3zyLZcQpKw5XVqQGogfkkKvCgOpnsU
 rvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322310; x=1794927110;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MMhEJ3xO3IRVXHgIiZBAMvXV88fkk4Tdqu67QdFSSrA=;
 b=AdkPHGNkbWlFXvcu8YrqkURTGd0qsJhLUblVfXBhuke8cQzssYkj524oEXF+vtmJR6
 cmITsY2gOB8OnyoeFQZGpH7qfB09Jf19JHN5yAaHPMDjbRlBGPGjD0A2rEort+G57mvC
 nBuLFp0/bVeEUgHmkzw5IIqzdkn50FXZRyni6vK7YS23CeIcPzNu61qcZJc4mYMwFJNS
 5oFb1fHIEaBc6HEQM35Y4od8xIHb6c/PnZm/1meDTsvvm9BSYT1p7t9kyAP4mXtku3xZ
 CcAvaOCq5w65TNPiwDzQkxYEYEJbmmCeICedZSPuQNfs6F3tdHCQ26U7uQGvhRZIQ0VJ
 wqhg==
X-Forwarded-Encrypted: i=1;
 AL+hErGQPc68ioOSgkhIYIjXuERgEqhBiwBkkc+Sfq0qocWV6eQt9urrwVw/MawwAe0XyMiOQDt1Y+g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z93ldu3DFVPYtfFifyaImFX0wM7uv8euJlNIWxCOk8usYQf4B9b
 v7PYqKUd/GFA6A6V59w95+0+2Nqe9XvWVm4W5sk91KpKjBF4MOkoSGjGDYAE7y7qBO0=
X-Gm-Gg: AYBFou34h3AcQ/Stxa6tlkYOit6LiCUXer2BCxi0QF0ySstXDBzFfJkr5Bw1rNlz2ei
 A79i+G7MoxI4vhVdoYcS1phUoaWA+yXHbGqhtnjp/ubSNzxiLlGoNQeyrYRKTNgrw2vjjgtPZeI
 f8DXInvLFE2Wi8Ux48uUBjURV+SFKqp8PWi8JPk+hSouYXTiJeXafkJGpuURoAt1NKnxg9B3moT
 HjdRV+47qIzp81obx2kG0CnP88LElBD0oP3cgEZvx3eAoS0CQ6O0Ux5Jpi0yM/kPAhxpL+97S17
 Rb7yd2/y4JRE5eHVjbPeMFSBHkxObM/gy4rrh3xnlXynm44pTHorsV2u6vUb5uIEPShpEqE3YX+
 E5LemQCDn5Py+GsCIvuyhAtZ2sj02+8em7dPPpu/ogUk4/Hr2YIxgY3xrVTwaglqZuO1WAGL1N2
 f5qZIcMz6u9hd/L6CZtiBFbE9djkK3QxZxt3qSAyl3QARaihRfHKGcL/Q5a4UwjXdaDX/LUBVZZ
 kGUANDFdfPtidGueae1k0opoLYvchX03RS9tF9bL0keKdNNgmIXKDF9Jaz4c+ViCDhkeKl5fVNy
 o0fzVrKMn4Jm307L5TQ5vUbHxNtLB1F1fmBON/4TBinFuM0ikG8WCkmjrocxodG9uLvxb5M42kT
 5N1uX
X-Received: by 2002:aa7:d847:0:b0:6b4:2fb2:44f8 with SMTP id
 4fb4d7f45d1cf-6b756ad66a9mr1969567a12.42.1794322309880; 
 Tue, 10 Nov 2026 06:51:49 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:e384:fd63:c1b:f384?
 ([2a0a:ef40:e16:1f01:e384:fd63:c1b:f384])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75781f646sm1172641a12.4.2026.11.10.06.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 06:51:48 -0800 (PST)
Message-ID: <eb8c9fd0-4b28-499a-ab4b-f0c989baa2e5@linaro.org>
Date: Tue, 10 Nov 2026 14:51:47 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] test: Disable running event_dump test for make
 check
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-6-1c76e0b68f29@linaro.org>
 <66d22487-93ea-4c21-8b7a-399f3b7d4680@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <66d22487-93ea-4c21-8b7a-399f3b7d4680@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 14:25, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>> The event dump script does not work on more recent versions of binutils
> 
> Please provide the error log or something so that we get a chance to fix 
> this in the future.
> 
> Cheers,
> Quentin

This is a known issue and was already addressed in CI last year.

9420160a0d14 ("CI: Move to Ubuntu 24.04 'Noble' as the base")

The error is that in recent versions of binutils addr2line cannot get 
the source reference for static functions. Whether the information is 
missing from the debug data or is just a failure of addr2line is not known.

Andrew

__________________________________________________________ 
test_event_dump ___________________________________________________________
test/py/tests/test_event_dump.py:26: in test_event_dump
     assert re.match(expect, out, re.MULTILINE) is not None
E   AssertionError: assert None is not None
E    +  where None = <function match at 0x7f0798574e00>('.*Event type 
         Id                              Source 
location\n--------------------  ----------------------...check 
.*arch/sandbox/cpu/start.c:.*\nEVT_TEST              h_adder_simple 
             .*test/common/event.c:', 'Event type            Id 
                     Source location\n-------------------- 
------------------------...pt_check 
build-sandbox/../arch/sandbox/cpu/start.c:61\nEVT_TEST 
h_adder_simple                  :?\n', re.MULTILINE)
E    +    where <function match at 0x7f0798574e00> = re.match
E    +    and   re.MULTILINE = re.MULTILINE
-------------------------------------------------------- Captured stdout 
call --------------------------------------------------------
+scripts/event_dump.py /home/andrew/src/work/u-boot/build-sandbox/u-boot
Event type            Id                              Source location
--------------------  ------------------------------ 
------------------------------
EVT_DM_PRE_REMOVE     dm_mdio_mux_parent_pre_remove   :?
EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           :?
EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    :?
EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         :?
EVT_LAST_STAGE_INIT   efi_block_device_create         :?
EVT_LAST_STAGE_INIT   install_smbios_table            :?
EVT_LAST_STAGE_INIT   tpm_evt_autostart               :?
EVT_MISC_INIT_F       sandbox_early_getopt_check 
build-sandbox/../arch/sandbox/cpu/start.c:61
EVT_TEST              h_adder_simple                  :?
====================================================== short test 
summary info =======================================================
FAILED test/py/tests/test_event_dump.py::test_event_dump - 
AssertionError: assert None is not None
========================= 1 failed, 1151 passed, 170 skipped, 345 
deselected, 1 xfailed in 147.30s (0:02:27) =========================

