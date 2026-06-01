Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474E5CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0B58488A;
	Mon,  1 Jun 2026 14:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aDcnFFX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE8C846A7; Mon,  1 Jun 2026 09:07:02 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F38DD83EF9
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 09:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5aa68d65d24so896030e87.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 00:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google; t=1780297619; x=1780902419; darn=lists.denx.de;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CLxYtHqJFQoZvppUoHloe7knpMrm1+YGHYWQfe8RoDY=;
 b=aDcnFFX1gSntP79++D1JRduqq9D+wjL6SKIN8qfRHwP2TnsghkacuLY1xjFt7QEqeZ
 gFQkbVW8IOXHPU/O+Va+MGCJxVkJehMc1LF6RihivrhtFN6VnTi3JqadRnqMDc/hh1yF
 NlRvx3EV9nWxj+5cldNhPHGtpob5OPU5ele0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780297619; x=1780902419;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CLxYtHqJFQoZvppUoHloe7knpMrm1+YGHYWQfe8RoDY=;
 b=dm9B1lsbC6exVZVe7RTF75laCyFC/QB5hD6x9ukb9suUJLrWrnuzwK8yfVYWEPyyg4
 4rFpKBAZ68i3+wLpLrn3R6bTiV+WeWZoOqEuK3bJSNgNLNwFAVbWDhXrTH0v5u/sMs+0
 UeYeF0vibF5am107s1L/jMrAQv5UH4jldLOwNdb+uizF9ldpplHV5N2R7Iq0RfxR1kAK
 6AD0DTlokV7Vzx9z8fDySVW+rNudSxqmDdRHIajSc9jMcn5IsV0XbHkkhIprNUsqsUHx
 wUWc7/lI+bQEDJqEe4VXloCaSkZ7H1BWUmjLdtztNj46/EoWBrXd4xUH8UNjEAG0NNMT
 nZgg==
X-Gm-Message-State: AOJu0Yw2LKDQtTuA85YTcC07gSed5RmrQW27Eas4727RfVtNKAt++l6u
 P3psuUsgD3MvzZgzEP/KzEnQgjQgZw43cxredm1GEJY1Ef/QX/LhjJDjbBCfPn+l+Q0=
X-Gm-Gg: Acq92OFarAIWfDdov5jGOJJ3GvqtG82p3iI9KaMvo46bXpOH+Y+0cqo6oDykAPYPOF/
 NVzv2LXz8dTSNH7REyCYuiwTxCtFtcYHi4MIwaWWUCp9OEPavJ2fqmBNaxCSvjXfDNrostIKSD8
 UfDRpkD0iBry/vt7u3yYYDn93wUs2OtPRjcuAc+EI+G8MnxcStdd25TOjVDjAOrvj+muFSG//z/
 ENpztirR6Q/E6/Nb0bK8aYbarlyAVx6C+xDDM907fCZRieDCOysgELmiFUe8TbEL4RQApgd/lkA
 T2xKb22AbKGWMiE/U/dw+B7XSaIAJlfExws53tRIrePymONRI0khdvSP6Y8Wv+Lb3cke/TjqvmM
 5MfqOdQNbj+JIwuYekYWkW444yGxflyc2ke7cbsrOBiDZj5XoTD1BdUwOcsRiQGrU+wRVAI3mj9
 L+gsL3XFBCbQi4Jaz4r1+teMpQrjUvjaFh
X-Received: by 2002:a05:6512:1304:b0:5aa:6d11:187c with SMTP id
 2adb3069b0e04-5aa6d1119b0mr591556e87.8.1780297618966; 
 Mon, 01 Jun 2026 00:06:58 -0700 (PDT)
Received: from localhost ([81.216.59.226]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b596991sm1884147e87.44.2026.06.01.00.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 00:06:56 -0700 (PDT)
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Simon Glass" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>,  "Tom Rini" <trini@konsulko.com>,  "Quentin
 Schulz" <quentin.schulz@cherry.de>
Subject: Re: [PATCH v3 3/3] test: hook up test of allowing control DTB to
 act as FIT image
In-Reply-To: <CAFLszTiBQwRkXt4eZkopi5rC2tDP8d=u6zpXMDxF0WzaRv18Uw@mail.gmail.com>
 (Simon Glass's message of "Fri, 29 May 2026 17:02:45 -0500")
References: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
 <20260529194621.1470583-4-rv@rasmusvillemoes.dk>
 <yvXrSuE_Hk7LgYCJ7cZuNJNGHTYkP2klSJNmYuDE_RhoGcD_zQjWs8XZPYoQpFmMQcgByBWsZ4AHNAzXM98RFA==@protonmail.internalid>
 <CAFLszTiBQwRkXt4eZkopi5rC2tDP8d=u6zpXMDxF0WzaRv18Uw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 01 Jun 2026 09:06:55 +0200
Message-ID: <87eciq20z4.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

On Fri, May 29 2026, "Simon Glass" <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-05-29T19:46:18, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
>> test: hook up test of allowing control DTB to act as FIT image
>>
>> Add a test demonstrating how one can embed various scripts in the
>> control DTB.
>>
>> Verify that the source command can be used with ${fdtcontroladdr} by
>> itself (invoking the default script), and with :<node-name>
>> suffix. Check that the scripts themselves can invoke 'sibling'
>> scripts. Also verify that without CONTROL_DTB_AS_FIT set, the control
>> DTB is not accepted by the source command.
>>
>> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>>
>> arch/sandbox/dts/sandbox-boot.sh      |  2 ++
>>  arch/sandbox/dts/sandbox-inner.sh     |  4 ++++
>>  arch/sandbox/dts/sandbox-outer.sh     |  4 ++++
>>  arch/sandbox/dts/sandbox_scripts.dtsi | 24 ++++++++++++++++++++++++
>>  configs/sandbox_defconfig             |  2 ++
>>  test/py/tests/test_source.py          | 32 ++++++++++++++++++++++++++++++++
>>  6 files changed, 68 insertions(+)
>
>> diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
>> @@ -34,3 +34,35 @@ def test_source(ubman):
>> +@pytest.mark.boardspec('sandbox')
>> +@pytest.mark.buildconfigspec('cmd_echo')
>> +@pytest.mark.buildconfigspec('cmd_source')
>> +@pytest.mark.buildconfigspec('fit')
>> +@pytest.mark.notbuildconfigspec('control_dtb_as_fit')
>> +def test_source_reject_control_dtb(ubman):
>> +    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr} || echo Fail')
>> +    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:boot || echo Fail')
>
> Just to check: since sandbox_defconfig now enables CONTROL_DTB_AS_FIT,
> this case is skipped on the main sandbox build. Did you confirm it
> runs on one of the other variants (sandbox_noinst / sandbox_spl /
> sandbox64)? If none satisfy the marker combination, this is dead code.

Indeed, I didn't really know exactly what boardspec('sandbox') meant,
and couldn't find any documentation on it, so I kinda assumed it meant
"all the sandbox_*" defconfigs.

But regardless, I suppose the right thing to do is to just drop that
boardspec line, since this really should fail on any .config without
control_dtb_as_fit, regardless of whether any scripts are included in
the .dtb via an appropriate .dtsi or not.

Rasmus
