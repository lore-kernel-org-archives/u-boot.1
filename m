Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAD4C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49C2840692;
	Mon,  3 Aug 2026 12:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pVs6DY5yqitO; Mon,  3 Aug 2026 12:49:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23C4D40527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785761365;
	bh=hVo/srMXiVWQpZkbm7tCdnDceHzZBI9f45QXtYXzakQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ITFMxLOLpzft5ZUhLx1eE2DIRQRysj2KCfnYd0KMngyHxYDvsCoLk4QvPR3PQUdpX
	 vxpWkc4BsyTx+GKKcGjqT7EMJ+dXit2hfGEYfvaRzjNvOA1HuOZxN5bqBvzP942bez
	 nstqajYXP9LOp1k9X3O0Ix+IiiVJvqqffzYhsbCWjs9wH1ldx9ASgE3ddpxHeIvF4B
	 WWA76ovzxW3GVGnjJFPSVm4vdBaMAosq7zbRChEaN8zCXJuvUMNOXdi7SA65a+LyG+
	 9Tjkge/lT+sv0IuH308O6mQ/mgD9DiOrmDOcHMheZB4aPOH7IK4WfkQ7DRNFKcwRM9
	 6abXo4cJivvPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23C4D40527;
	Mon,  3 Aug 2026 12:49:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51651218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 379226072F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4MQFQWFOxmGi for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:49:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5853860703
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5853860703
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5853860703
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:49:21 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-667971437d6so4563092d50.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 05:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785761361; cv=none;
 d=google.com; s=arc-20260327;
 b=qZyOai957wImUH/fXSAb0qbwwrNmIaTzbjYZHBXvLdEE51cmXCCt0uZNCDwOSFeb5/
 M++GsIi0L2NSlXasjQG25l9tRNkBB9/U2wlCSaM/aAZwM7czaqgBMJ30AWJQnum7y4/3
 9xa6srwEXsV3Y2bsFZrGXJudb3xXnis29+SHxwCQtg+3AlcU96aLtl9T1RYGYizBP8xl
 q3W9KK0JHzKkG7HPWjjBC1b+J25rmZ8Fh1uCpaUtDAQnVmlF4e5UG9QKAWL4ahvRJoFz
 emAGfGBp/R6vZbSDq0KYC+i3j4zBiWF5wxOX3rAjWIY/7D3zV2aEKi7/z+1LtnxcB6B6
 MuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hVo/srMXiVWQpZkbm7tCdnDceHzZBI9f45QXtYXzakQ=;
 fh=f/vaMyCG5Qv74UFk+AVmTQso3cXkIgLTJex8Yll2TDQ=;
 b=CxeZEY1/1HjY3IFopoZH1dFAKIjra+wKqzhVat85mt56ZVSD7gmhh1k8fTrzKF+DmI
 t4CY/Yj/wg8FPxis9T28iI6enKxeCixVSu6bO3dOumd5g/EdSp1LVKo5HrQS1oXA4dDX
 4H+R0l89ppPBz0PCDl0pb+rBs/NvAqTOCKXsEvbgQkvjCKa+xellJaZFRKDQVQdGuGGu
 RoF6lUW93/MKHqyguRPQZPXq5GsxE5Wwf6hnPUTQTzwGur8T5ddyYnj7JwWGOpzy79R1
 ZtmuCAnCqYSmy78QfhaSZdDB1WIgM5Tv01DDcHx9bC9byR7W8uI7MaOSN6mc3MtezvJC
 TyWA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785761361; x=1786366161;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hVo/srMXiVWQpZkbm7tCdnDceHzZBI9f45QXtYXzakQ=;
 b=glhEGvLJbIKtCeseZDeWw8AZGIApIDNpaqZjbRHQK3AdydtfbTWkYHK4koONM5ziLW
 GYQ9zazAWYAXAw36Tzmrp2m9ioV0WuttBe15iNZKjDVGUfHLYMHPvxsuKSMF+cN31Jvs
 AFOy2bkeSnv4l4end+9uwwSIyGCH9sp7/N4RTKRB0xhqAVZYCvadGz4AtTP7CFDxtOw2
 kB4xvjKw5AbyJxipI3pjfOmeB5f7hVwEpEfyYKz29wyZwPNmzhmKoN51vXKwLbE7GCZQ
 PQ/F/y30uL6DdcfsK5nAoHVEJhYzTfK5Z05JimsYUnB/+JCygPawmEGtmANCP0pIr1WM
 6xHQ==
X-Gm-Message-State: AOJu0YyVVqR88KQomUiTitjpcj1muQW/GQasbxQXd/q1DyJpTjJ+waQQ
 h3K6PWU1KaMvM7vR5Jzuh77wOpIhjA9UcGMOP+P3Ql3cIk4FoHzEq08tOUWxOwEVtwbiHNStbcg
 zkTMGmcDxU0quJKvTXC2k+rH0ZLEiSz5ntIsAwf/VZQ==
X-Gm-Gg: AR+sD10LJEb/xzDVrl45iJx+tx9bHg3eijDUK+z3Ddh1KX0CmLUjZEgtupqMTzdJMrn
 lR3ysFO+YxwrWEQ0W0fR9qFYw0NMeRn19Qg1VQqRBYHHS7oBdSj2uUR2F6f7DfdYyd1YpdGh8cx
 ROM8aO1V+o1b2Tp37t74c9wClYwYIalHMd4M3Bd636wvH6M5hQ8NvDS9caT7z2MqsxdWXUkG3Z3
 bUJ62KKNwt080MmGZkMIQF/0t3O45YRhEJnmsZIO3yFh0pGgSwsgzy4wvlW355WP5ZovqlYHNTQ
 uhdX4q1kEAbLeylGoY4kfvg1p4udOlM8LwTcknH7DENhyA4skM9DF97ODofzBAe0RRAhFhXL2lU
 sT5lDwKXqD/DdQu5Ndm15lJMSMkzWKt8Bo/lEavMiTcuFkicOUD+0XrUNdTK1eUxF749rPVz+ho
 nrCClEzviOeaVqZ3i23qufuFRMqDtOSCvRN90SSRr+39SWVNGh+8RNy+3lOz4d5j62CFB+9TyT9
 meVoY1Lod0PMXip9s1r+BKM0dT4hAPDQfqPdGBQSNWj99etUpq77wXGxeVr0YdxGAHiczeT//Ap
 0qse2kNKJDBLLhyKSD0lpJ/ByDyzgeGOV+AJwquQUwK48iOchX1SONBE+N/WIMwi9KacJSbjGFd
 AvYR1T4h56KJ4oH9G1grCXJSL7r0YYygRDbSbmCS0kYc=
X-Received: by 2002:a05:690e:450c:10b0:665:a0c:6595 with SMTP id
 956f58d0204a3-6694f29986dmr8781067d50.54.1785761360778; Mon, 03 Aug 2026
 05:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-5-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-5-a3f1f16b53ae@flipper.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 15:48:44 +0300
X-Gm-Features: AUfX_mz5lS5yJ69BJoAG6hmvQsjawyDqA65aQdaPoJga89sf83ZgYeYE5Ugyl38
Message-ID: <CAC_iWjKDyyKBGgfXWyaBB5Qz_bHCncTOzKsgP3_GfU8ffBnvKw@mail.gmail.com>
Subject: Re: [PATCH 5/6] test: py: gpt: Bind the disk image in
 test_gpt_write_part_type()
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785761361; x=1786366161;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hVo/srMXiVWQpZkbm7tCdnDceHzZBI9f45QXtYXzakQ=;
 b=r0ghPefw5t3k3kNdUirempNJhIMlU+/doi8+9cZpXJO8e+ELkOIiprrXzbcpmtJrl4
 MuOHv2DMnd7pVJEVrnrJt0dZiXNoiLssXXPbTc/wTJMm80UjU7u8SMGSC3OqMRkmDA6r
 uXO1uO497UNBmMllO1igVmK4AqMjLgbxolpms2zPEI+tYCpq82TnHs3GGVQsDgGNqKlr
 X8BD4gpn5xQ4FvG7YPDPwWoSdc0ykdgrxdtxWl8QMEk1lDTfAzSEigUE5J9ADe4JR0ng
 G3uGWe3hsKyBrucNMcEdqlqQGgvuTSZ3KVzDebx0921Gh39fNiLeIikBsi3+D9rJTvyn
 q4GQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=r0ghPefw
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

On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net> wrote:
>
> Unlike every other test in this file, test_gpt_write_part_type() never
> binds the disk image it operates on. It has worked since it was added
> only because some test that ran before it left host 0 bound to the
> image this fixture provides.
>
> That breaks as soon as a test which binds something else is added
> above it, and it means the test silently depends on collection order
> rather than on its own fixture. Bind the image like the other tests do.
>
> Fixes: 7a598e633a53 ("test/py: tests: gpt: add test_gpt_write_part_type")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  test/py/tests/test_gpt.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> index e6d8792ac1fc..fb4c8ba67d48 100644
> --- a/test/py/tests/test_gpt.py
> +++ b/test/py/tests/test_gpt.py
> @@ -338,6 +338,7 @@ def test_gpt_write(state_disk_image, ubman):
>  def test_gpt_write_part_type(state_disk_image, ubman):
>      """Test the gpt command with part type uuid."""
>
> +    ubman.run_command('host bind 0 ' + state_disk_image.path)
>      output = ubman.run_command('gpt write host 0 "name=part1,type=data,size=1M;name=part2,size=512K,type=system;name=part3,size=65536,type=u-boot-env;name=part4,size=65536,type=375a56f7-d6c9-4e81-b5f0-09d41ca89efe;name=part5,size=-,type=linux"')
>      assert 'Writing GPT: success!' in output
>      output = ubman.run_command('part list host 0')
>
> --
> 2.54.0
>
