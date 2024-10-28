Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FF6D5B158
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7119A8911A;
	Mon, 28 Oct 2024 22:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KHm5Ixs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6109089043; Mon, 28 Oct 2024 22:54:38 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 000A58911A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 22:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so1073967466b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730152475; x=1730757275; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jt5XtRmlHHsr1c/McS/V7pYInXgP5G31kHdu0olp+kU=;
 b=KHm5Ixs160v62PpEOyCQ+i3RPlRH2NhddKW2ZuaD6BnHeBsX7vxpZJUTvCNZo80oPt
 Wt2CTZ9ZbY3K9tWEKWfgZI5ev7uoa6Mxx50Flz0V9F2iemFJZGnCM5rEhlCxKj7+s64A
 biNzlNskeqMWCg6lBbpYAZr0snj2CovVv5T65OnQP49YwjVMnTmP82ROfQoCN9ykxJEX
 zDKjZ4+mI2gUhmCUZnlV9pggyh/G4OtRuqUmrDe39DnhE6q8vD5HsQfmLzjFHmLRW8Zj
 z0Q2Brxpaap81UJfgNuvZ8uWLnxSwLoY2Cy6JrpjXLeHPAx7fRujsL0cYWmYKbUG9gmv
 L+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730152475; x=1730757275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jt5XtRmlHHsr1c/McS/V7pYInXgP5G31kHdu0olp+kU=;
 b=HKlmdWrGBlnUhlVAHhMBu8r/otBb6a8d/so+IcW3/8HknWV9SPt74FLcu2CxUNev1J
 8sa5rFi+5gygrSm9kNOtuRlancCBFTba/vDy8O84E7q9He8fnPcoFyjQsvygpYXaUHZU
 zk3jIfOjKfhVvCtYKDGLpQl6y+MEg0YJD4z2zENvYpIg8r5/mLjEZQUMIg8AQ+phMObv
 ++a4iN3Bf6lmx1js/RjTeQS2Gt/TSOMKw3ryzHaaM5TCwNMGhwjfFIRshNXS6jkEAU8L
 85Mlr+inPREyT5qbbrp2qOFz6jnfDdH0Dh91S3JsdeI2QkkFRix3TMlJNx5K7H7Ua6ux
 FSiw==
X-Gm-Message-State: AOJu0Yz5R8x+j4eQd4Wu2ucTmV6th8daKN24fLBYXYNMZ6ylwz2F6lW2
 yEmdZ2Fp6IuOSkwl6mhJAaEZoczZuHXgTrFLGU1sr89fsOC4FxEDhlQO66998DODbzIevcIYZFW
 z
X-Google-Smtp-Source: AGHT+IF1LhDEnBa0t3Yr10mmr9/NaFPlCZojjzJ4ob+nPja9Ax2wmGZnaIhI3Hj3r8klvhx43yOLQg==
X-Received: by 2002:a17:907:2d92:b0:a9a:139:c3de with SMTP id
 a640c23a62f3a-a9e22bd7602mr99144966b.29.1730152475417; 
 Mon, 28 Oct 2024 14:54:35 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f29950asm406529066b.122.2024.10.28.14.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 14:54:35 -0700 (PDT)
Message-ID: <82825184-692b-4245-8935-57d87f84692a@linaro.org>
Date: Mon, 28 Oct 2024 22:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sandbox: Add a build without CMDLINE
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
References: <20241026120252.865215-1-sjg@chromium.org>
 <20241026223346.GI4959@bill-the-cat>
 <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 27/10/2024 15:52, Simon Glass wrote:
> Hi Tom,
> 
> On Sun, 27 Oct 2024 at 00:33, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:
>>
>>> Something this breaks, so add a build to keep it working. Since sandbox
>>> enables a lot of options, it is a good board to use. The new config is
>>> created simply by copying the existing sandbox and turning off CMDLINE
>>>
>>> Once we have tests for non-CMDLINE operation, this can be adjusted to
>>> run those tests.
>>>
>>> Create a new build which will be picked up by CI. Update the maintainer
>>> entry as well.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> - Create a new build instead of messing with CI
>>>
>>>  MAINTAINERS                         |   1 +
>>>  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++++++++
>>>  2 files changed, 366 insertions(+)
>>>  create mode 100644 configs/sandbox_nocmdline_defconfig
>>
>> Please use the #include mechanism instead of a full config that will
>> also now have to be kept in sync.
> 
> Hmmm we still haven't come up with a way to deal with the #include
> mechanism in buildman. I've forgotten where it got to, or even what
> the problem was?

qcm6490_defconfig needs to re-define CONFIG_ARM=y for buildman to be happy.

Why is buildman looking at the defconfig anyway? Maybe it could just run
the pre-processor first?
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

