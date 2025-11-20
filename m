Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCCECF8875
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 15:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB50D8388D;
	Thu, 20 Nov 2025 16:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yki9KxoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8C780077; Thu, 20 Nov 2025 16:51:51 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A4A8388D
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 16:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so879223f8f.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 07:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763653908; x=1764258708; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M9IrI7lAVOQmP9xdtDbDv+4xMjvx3GJn3UkoX8ZGUuA=;
 b=Yki9KxoINo23BF0rOOm66+4M0yTBE2jzx2Q+hhYLwp/Ij80KUzKe3UORSh+OElXJJe
 XgumW/iHkYxIyfa5p2J22wyxoVhC2yfwFj+qnVOlAlFYN/KXHQXubNvOP3ISnqDDa6wZ
 eE58wHdwMpXyAQXX3Q4NPvgjwYENkcujNuYMxJRhFcvYbJ0wzfRXQmKGBb79/5GeIdK5
 Jh0be79bYJ5b69UsrzyngxQaGOP8kZr+hKmymmURGaYQwPIr422T7lX03P5gVN2ATam0
 pZBpKzMjOkPX63EOZqCpyFjnmY2GmrYfbKYXyHlj1fuJ45+Rb/2ugZ36LXASYGK+Cki8
 Y+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763653908; x=1764258708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M9IrI7lAVOQmP9xdtDbDv+4xMjvx3GJn3UkoX8ZGUuA=;
 b=fsaoyYaNsyc21vKbO36jnD0KKYhvMZpour5G7KTox7EpnM58UcsyVk4jevTI9zeHGR
 zjIk/pciwb5Eba8hNEIBGgLfsRfacI977f3OygOUVSwDSLToLZwd0GjXRHci89Yu4Giq
 7NSJn75NaubRrscjGx6NuvXQSH0u9vr/ON0A0FlAG9ElqFKpTyiyS2LVZ+t6A4vQpmhh
 CpqPHVJNRMq8QrLbqp/CrbpnZ6xLGqwZMRQxfvKwLWMMVbXRELSFxbcB2vIw6jBuXl0O
 9InRN+EEDgJJ7Td3tN1ePjG+JYwT8bjA3U6Fcw7T6NVFL4O9YvqsY+KzHWk+Js6fPEub
 UCdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8rqeg0A1uysRREZsZrRT2iTlrO+jsKjnilE+wwSzSXkp+Oojc7OiFyOFJN1Ucw3WusGQDr3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ3qwJEneW6bwnUe/IuPja4/fvehXSlTz2gNueKt/x6TAW3XSn
 oc32ixMT9su+hUKntj34ARjP617y1NdtkvlQfbUREYUOZuFVtcGmrrRc5NT+WhMwLBm5zulK9Us
 Ys0fC
X-Gm-Gg: ASbGncustBh1gtw01Exd8mf8qc25pbT+4mdSCd0haF0jV2g8d7XwyOVNE5BbDDrIfNe
 UCv21FR89NPQtswgRK9EQAenc0WTR5MFS6UBZJgxLh+k93RnBmQTccEm6gcuGB/IyGNPWiEOeei
 MHBIe3j0sMUvUIady29KrNkEA1vtl0OWDZ4iGPd1d52uPynge7EK+QuK0FzCX7TUe10vIJyZkuD
 EqR2Vm/yo7+Ptui9u6b8x2AA2TVxS3qlge/A9fC7B4dcOufqGE4rumRLxDN2s7V0GyjnMhRj3Zj
 nZzYtb6c+DcOcHVzx3ENql0GVKY1/PdZtSGQo5nC036GpOn5hBGzgdWWZxk4iS9Pb1OmiJwnShd
 QwEqkhw059l8qNXa4ksc+BMZ+00a+h5YWGf2HjDpzt6kyzd4WHOe5/FUM5xo+R5QTPkIQwqWsYd
 VAemvyaOCJJ2zy4uyIKXagOjrtBFd/mR86x0L4q4s1OvsHpxrEtl+l85tHv7nDccwXYA==
X-Google-Smtp-Source: AGHT+IF+ZSgHTQzWteS3t+YPrw50awiIiIN/bWl24YOXijYRkEOx41AeZG+4T3ISPw1Xx+1CVxI+uQ==
X-Received: by 2002:a05:6000:420a:b0:42b:383d:9c8a with SMTP id
 ffacd0b85a97d-42cb9a603afmr3569579f8f.40.1763653907759; 
 Thu, 20 Nov 2025 07:51:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d859:4143:4a86:3caf?
 ([2a01:e0a:3cb:7bb0:d859:4143:4a86:3caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa41d2sm5928185f8f.22.2025.11.20.07.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 07:51:47 -0800 (PST)
Message-ID: <2b123aec-d0bf-4cf8-9f4d-32ca2865d6ab@linaro.org>
Date: Thu, 20 Nov 2025 16:51:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] Gitlab: sage: Add Pine64+ platform
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>
References: <20251118210015.624758-1-trini@konsulko.com>
 <20251118210015.624758-3-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251118210015.624758-3-trini@konsulko.com>
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

Hi Tom,

On 11/18/25 22:00, Tom Rini wrote:
> This adds the Pine64+ platform to the sage lab, for both legacy and lwIP
> networking stacks. In order to build this platform we need to copy
> certain files that were built in the container to /tmp and then set
> BINMAN_INDIRS to /tmp in order to find them when building.
> 
> For now, we disable the test_net_pxe_boot_config test on lwIP as it
> leads to a crash that needs to be investigated.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Andre, Jerome, how would you like to handle looking in to this issue?
> https://source.denx.de/u-boot/u-boot/-/jobs/1303375#L2235 shows the
> crash and I don't have enough sunxi targets to know if this is more
> broadly breakable or not. But it doesn't happen on lwIP + Pi for
> example, nor lwIP + Hummingboard (mx6cuboxi defconfig). I can't at this
> point give remote access to the lab directly, but I can help come up
> with a gitlab job that'll acquire the board, build and try and boot
> whatever you have.

Well the crash dump doesn't tell much on its own, except that we have
an invalid read at address 0x17. But we do have the ELR so it would be
helpful to have the u-boot.elf file. Could it be made available as a job
artifact, especially in case of failure (or always)?

Thanks,
-- 
Jerome


> ---
>  .gitlab-ci-sage-lab.yml | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
> index fa7d79668b2c..815c93087f4f 100644
> --- a/.gitlab-ci-sage-lab.yml
> +++ b/.gitlab-ci-sage-lab.yml
> @@ -35,14 +35,21 @@
>      # Prepare ssh
>      - mkdir --mode=0700 ~/.ssh;
>        printf 'Host sage-exporter-*\n\tUser labgrid\n' > ~/.ssh/config
> +    # If we have TF-A binaries, we need to use them.
> +    - if [[ -d /opt/tf-a/${TEST_PY_BD}${TEST_PY_ID//--id /_} ]]; then
> +        cp /opt/tf-a/${TEST_PY_BD}${TEST_PY_ID//--id /_}/* /tmp/;
> +      elif [[ -d /opt/tf-a/${TEST_PY_BD} ]]; then
> +        cp /opt/tf-a/${TEST_PY_BD}/* /tmp/;
> +      fi;
> +      export BINMAN_INDIRS=/tmp;
>    script:
>      - export UBOOT_TRAVIS_BUILD_DIR=/tmp/${TEST_PY_BD}
>      # Don't stop on non-zero exit codes now, to provide as much chance as
>      # possible to ensure we don't leave lab resources acquired.
>      - set +e;
> -    # Sage is 16 threads and has 3 devices attached, so 6 builder threads.
> +    # Sage is 16 threads and has 4 devices attached, so 4 builder threads.
>      - tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
> -        --board ${TEST_PY_BD} ${OVERRIDE} -T 6;
> +        --board ${TEST_PY_BD} ${OVERRIDE} -T 4;
>        RC=`echo $?`;
>      # Wait for the exporter to have the device ready
>      - while test `labgrid-client resources |
> @@ -79,6 +86,25 @@
>        junit: results.xml
>      expire_in: 1 week
>  
> +Pine64+:
> +  <<: *sage_lab_dfn
> +  variables:
> +    LABGRID_EXPORTER: "sage-exporter-pine64-1"
> +    LG_PLACE: "pine64-1"
> +    TEST_PY_BD: "pine64_plus"
> +    OVERRIDE: "-a CMD_BOOTMENU -a CMD_LOG"
> +
> +Pine64+ (lwIP):
> +  <<: *sage_lab_dfn
> +  needs: [ "Pine64+" ]
> +  variables:
> +    LABGRID_EXPORTER: "sage-exporter-pine64-1"
> +    LG_PLACE: "pine64-1"
> +    TEST_PY_BD: "pine64_plus"
> +    # Leads to crash on lwIP, needs investigation.
> +    TEST_PY_TEST_SPEC: "not test_net_pxe_boot_config"
> +    OVERRIDE: "-a CMD_BOOTMENU -a CMD_LOG -a NET_LWIP"
> +
>  SolidRun Hummingboard 2:
>    <<: *sage_lab_dfn
>    variables:
