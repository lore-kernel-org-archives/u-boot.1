Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E775BC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 15:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F34F80BE2;
	Mon, 21 Sep 2026 15:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PD12MS9oSqfE; Mon, 21 Sep 2026 15:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 510A5809F5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790005681;
	b=cNEUdMnDt1yBh77pzCOHzlxph2m8bpJXgYG/5IkVbAjHzmp7rQGYPIb9INvFvLg8NDF+
	 iPO5B0PMbVr2sMufCzwl5v/BkQV4z1WS6meCkSITy+rKarj+eEnRRFnnsez3VZRzqbtTg
	 LBkCsMYQjOGkEQKOjj/cOLQxD6FrVdRcYxa1smqe1g8a9PFYVHzav42TgWZjUuSfQDP8H
	 B2Qp5ydNfffyPnY3pztIwzd0vZ8QSn+PIt7Q/gv84dw8Dg7bUHdF3Vh69dFDpRB7oYL9w
	 sFrX2m+5z/2124sJffame3AC40HIs29a10FA/pz9fV7atdpw1nsngUCzQxXl4Q1rH+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790005681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D/chIUwEP2AZxgcTIgxNr86OKZyyIkej84QnmEbZkdU=;
	b=XkbXaNNpSkCF7yhkh56HUi78DuYrYQhQrrPvG62wPl2eHrNuiMPl+GWWi0JasknO3Pp/
	 b1vLlxCUPxOi9eGzptX7IENeqFDrB3Du7Q9HEahyjnH5PWqShFK8HxBMTDx51ZQ6OEPdO
	 jO5FUc4mpCbCEanCAgG/e484Qmicxv0qUuKk5NWPmv2jOgRqsPMud26j+/kk0Kvnh6jJT
	 xz9e9YV/Kp/qtockBQwE/7vbJjeadNVlYK2WsX+om0CL2KQCdXhg2JnENvUMms82EnM2t
	 a6jUclMev3qgcdqU4KT4378olknUNQps2412wLkI7IJsWdJilWdGuDtHBE4GYBXBVTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790005681;
	bh=D/chIUwEP2AZxgcTIgxNr86OKZyyIkej84QnmEbZkdU=;
	h=From:Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GUxAS65YnLqHczVY2sr93yeLig/DkWrk758D1t4ljwm1LePpL05iRD5ADy0b9iWXg
	 b+5cMB6tYwYEKgTHEvpQ1eutIAlrePXLbyY0+sIPbILfZXnQ/+QVPbpfW8HbuNqFx1
	 w/MmVkE46gHXFihwOkOND/dMnUKOrj8Pyey8gt1vw9FwHPwvZmsfTc/p5JX1hPSqUx
	 X3BdvlQqP46IuKbNINF2E0kFSReP3eNc1ksMfJB3gqRrlGEN3XCoVL93j+Hm5NJLvA
	 Zfv5BKLfFJOFcU2Ty0HF5PUEp6NqKxe/eXjAwmNL26iCaZXTm0OkHdbWg7h+H4AG3M
	 BxxBhnrGNOVog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 510A5809F5;
	Mon, 21 Sep 2026 15:48:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C38B413D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B514A6066D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4Wua575YAgq for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 15AC9605D6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790005678;
 b=cLkt179JIXvwgJ5fGU9ci/3t5U9cxZ6tB4cCA5U+bPgnbkow/DZd1Zp9noefx2jAEstr
 q8/nbeqydVcGaLt5L77fuZEvFIHWSHQl/mo4XsjlSsBSGlkQv9yiEBhdcwWvjPH42wOHS
 gPZq0CrYgdWjIgilziejTjS4Dh974TcCTjOhJbL8d2gKunfnVudqCnYjyrT8ta1PYlEcJ
 sUyfKX3EzcylYXJ+y9YA03Wj1Yma1w2Ul/IJ4MzbupTe2AMOAvHfXJ41HKS2XiKoyN4XB
 FQLgPZ86u5K3pF8btwT/awQgS0kYzTlqmAyowxPmUEVxt+ZLdjPVaTqS1ABAlZ+cPLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790005678;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=D/chIUwEP2AZxgcTIgxNr86OKZyyIkej84QnmEbZkdU=;
 b=mVo0ZupWfZLkkJXIQnBsmpdfLHuvWdHXB0GR8XWccgUW38zbSaRyJn0qjz/7l9Y9gJJm
 cC2MPtixyGfsUlYR3LymR0TspP279ZrIo8LeKT4GqnV8nE6KSB6/0zW2wRiYD6oRkV5k0
 cFhOb9uOlEzpYtzjHlGj+/VjcrlZ3fFoF95gwUI7gc5xzNenytBEpA4VOCgaSfUyEdQGa
 2HJHUkl+QYE0kzqzFRv+NssD8QIizM23gdGmxKszJx3+6fP9O/6a0JsoSRncSFPKx4FGY
 uTP/qCCZ0fP9SK3shu4oW35KYiYpEHhZSbg/1YPZf5saW5pB7HhbPkoHt3j4MuTK7uA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=CgvhHd44; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=CgvhHd44
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15AC9605D6
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:47:56 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 837973FBD5
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790005675;
 bh=D/chIUwEP2AZxgcTIgxNr86OKZyyIkej84QnmEbZkdU=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=CgvhHd44grWp4+sxfs3UqpXMWEYxQA3gFB7yzEvDc6av4GX+oDnNphA5s+BoZtV5C
 bYfDrxY/ulTA4FX76V5y3+5hWVGex32POYkbqr3e7Z9z4luVqA0of3C5Xf1H0nQjlZ
 stN99feLG2Tw9l+wMbcxvMNQhYkEAbuUs05eDUk2KtJo2pgMqfaq+svv3K5oFFaFLT
 RWUvceKhqsI91nOcijI2+yZYTgGfmsurqaOwkfFXq+oILMqXZnfeQTnrmgf7PVzs9g
 Qyq5KNl+xBnHWSoQjIbjo2Mk8NJgBLLZ3WjtHNrKd3UxF93XieJK/mlbV2yGPEpQwC
 EUXyIWz5GQImJDLPGlzcZWssqVqJcGzwQUmmxDSaNKV7gCXxr71nHyGrfX9W5jfeZH
 31rG+1hA+aK1J3XiCLheisKslx28V8CeIrloIZhme/E1R+5RcaoeEWSh8ON958Kuum
 d2rg26rK2bRvA/vKciNHmHbdYUXzvYTcXOpTH7WRszJvJBVc9p5aayuHGxry5OjC1P
 9fJsiPvn2BRxrvqMaZkkGUb7L72m0yFgtvaZrQj5pIe7w+58LxVyH8RuUvY0qyfWsG
 4A/r/RAvdI1nVOIczEEDMWHMz0LnalwqzG6VvhlbalS5uVqFPc81uCmU3dwiU5duhb
 DF9TE4gGAwPmHObKsswkdiZw=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486f18da958so19336f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790005675; x=1790610475;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D/chIUwEP2AZxgcTIgxNr86OKZyyIkej84QnmEbZkdU=;
 b=xkIwDEvuxfkA5sfonZ8dZmHHrNe1Qo0IpNcLRGG+Pj3/rzSMkKNuS6E/ZEsSiUDh+z
 CFD2lBusyukBhDRKtgaggUwY751NDUlyOtqowrPSkdj746pK28xd4trVBG5GTr3mE2XI
 o5Wt3KQRKov7J9b4sickPWCZhFiPY+s+knVA0BD4Xh4e7J22xbMcL17PUIA57UxbjjHG
 J67hPilguyLayJMDJXEMYKCFE/XYOO86liEU3b4Mc2+fNoJXr3q88PKJVlNNrUgPfXe8
 7fJVtm+p8mMyeapnUxTjj0Zho5MRyBenL+al0xPv6peJ743AuYixfn94U9n1IhiC63w+
 9zEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGwIXH/VwncIFjKbWasL9UYKAF69G9hm+JMrTcUxkJeV59e3biOz2+PMsZ38Qq4D1HNqKuriQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l+TWsjtJEHVl5pmrXMzwixkCsfq93WneQgmCXgF1O1rANO0qLv
 btNpe525CE1OLQJuOPfDrBTytNjFeblQYTg6jcmh4jsNxc8BBVMxwD8eHcQ51t5q0IJroQA/t24
 KSXA/DdULyKQKNZdytYSJIjwG09GpcK137HjgNOV9j6ASAYac8NBYgNGc+g7zxjb7FJVO+9S+J6
 fQfzRsxgQU/Q==
X-Gm-Gg: AYBFou2OedYMXb2IdgMKag67pDk3tOL73xDA7kmzj3kfmFN6beFC5Hzv8afQH26JPHO
 IDTDAAusQLIRM8H5CKZUwcDCHs4p4jCpzXflVjiT3eHKnsnabAEji700gjSrrsSl+3u5ix/a0KF
 tP0M5ZBzQTnBkglKO/o0rAVSSBpD04OEXBXw1RjppnLWSsi9szq9S+ZuliD4hK1x6omsxifUsr6
 LsAQ7Y2Lt8YJ1WzY/iYVaYgrcBNersr3GUIPOxGpUmqtuZhW5SXqr/UtIN/yXzPsISnyytXWA8A
 rH4WgtIvlJuxo5r6QDgEe6FBnEpq/Lit2dwYu9BGu3XMTXpb30RkhFF/fthVx9WnXgKecaISL/V
 zB43i6qdoBjCLrlBUApBVbwlVH9rZQ/BuTlipaVgMblseDPaQsDI2jr+HHvsuODa6zg1ev/dQAa
 +t6oFcSwg=
X-Received: by 2002:a05:6000:1ac9:b0:486:e60f:a4e3 with SMTP id
 ffacd0b85a97d-48860fbd0c9mr50360f8f.1.1790005675008; 
 Mon, 21 Sep 2026 08:47:55 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac9:b0:486:e60f:a4e3 with SMTP id
 ffacd0b85a97d-48860fbd0c9mr50307f8f.1.1790005674640; 
 Mon, 21 Sep 2026 08:47:54 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:aec3:c221:8373:654c?
 ([2a02:908:1242:30e0:aec3:c221:8373:654c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872459d409sm22726901f8f.33.2026.09.21.08.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 08:47:54 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <2b6b6f3e-8fee-4b55-9ed4-89ac704e67e3@gmx.de>
Date: Mon, 21 Sep 2026 17:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] lib: Let SPL minify zstd on its own
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 u-boot@lists.u-boot-project.org
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-3-28e946f57357@flipper.net>
Content-Language: en-US
In-Reply-To: <20260918-spl-fit-compression-v2-3-28e946f57357@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/18/26 12:52, Alexey Charkov wrote:
> ZSTD_LIB_MINIFY is offered only inside "if ZSTD", so a board which
> enables zstd for SPL alone gets the full-size library in the phase which
> can least afford it.
> 
> Add an SPL-scoped variant of this option and key the build flags off that.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   lib/Kconfig       | 12 ++++++++++++
>   lib/zstd/Makefile |  2 +-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index ec6f162dfb57..1292185e03f8 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1023,6 +1023,18 @@ config SPL_ZSTD
>   	  buffer and takes its window from there, so the compression level
>   	  does not change what the SPL heap has to hold.
>   
> +config SPL_ZSTD_LIB_MINIFY
> +	bool "Minify Zstandard code in SPL"
> +	depends on SPL_ZSTD
> +	default y
> +	help
> +	  This disables various optional components and changes the
> +	  compilation flags to prioritize space-saving.
> +
> +	  For detailed info, see zstd's lib/README.md
> +
> +	  https://github.com/facebook/zstd/blob/dev/lib/README.md
> +
>   endmenu

Why wouldn't you want this in main U-Boot too?

Best regards

Heinrich

>   
>   config ERRNO_STR
> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> index c9a7dfe405b4..9d1b4d4a4f72 100644
> --- a/lib/zstd/Makefile
> +++ b/lib/zstd/Makefile
> @@ -11,7 +11,7 @@
>   obj-y += zstd_decompress.o
>   obj-y += zstd_common.o
>   
> -ifeq ($(CONFIG_ZSTD_LIB_MINIFY),y)
> +ifeq ($(CONFIG_$(PHASE_)ZSTD_LIB_MINIFY),y)
>   ccflags-y += -DHUF_FORCE_DECOMPRESS_X1
>   ccflags-y += -DZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
>   ccflags-y += -DZSTD_NO_INLINE
> 

