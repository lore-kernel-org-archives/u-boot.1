Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A73606A338
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0EsserI2;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nqYCy8+W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE94580E48;
	Mon, 23 Nov 2026 13:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 78_hUFlDZOo8; Mon, 23 Nov 2026 13:25:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9679880E23
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795440358;
	b=OX573+NVU04sQEmJs/WC7m63SsiSQ4+YGNmb8vCsTOXObYRuiHwp5EfRc0ufOYVKV31m
	 744ozQljronrPS6P0h+ZaiuRyXtAJHtKPG89kxxacMMf66/H233NKSzz5x++AFux5VUxT
	 QhWVq2wFwGR8TPmICzbASi5Ecb+7sQkY469haO2YzIPqQJkn14BLa9CpN9oealSmvyLuo
	 wJy/ZAujUC5zruZYjlMxe8fgMq+wPfLaryBiPItsewSlLYMujAPU/g1pXMZsCK3rm+ky9
	 3JaqY5cL4NkJNqi1MgzECA7dJ2AAze44JwHHBUzSJOjo5p3NTCcMC7bZwJ2nyDgTNLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440358;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cEf/1DtUu7n2FANLUGM7xPGUYAz1T5wZkwnUWItYytk=;
	b=Vz96jd1XtNo256RZs+llTidVGlnq1NsoJme6vK55SHkysFESi89BnjzpDWWPdwVd564D
	 BRBE3Q0MJDizCRP8ihNeaRVDq8KMVl9fERwqD+RdzRH2iHlUKYMiEoffJQOqPed8lJ7pt
	 aZLoA0rkj8/H6sCqNKCyB89Y4V1O6hwtVGVk6OM4ufeVKY/NyTIbI0ut+s1N/qkY44apQ
	 /HCptirvkz+eX21te2I37iesw7Oj5wJUtZHEhOveur95jLCJSMJVKUAGv591w78BH1y5P
	 C3a+1wU3nSSlYd8eAk7pLKelLz0CcDHZ1AWn3Ox6qiIvZzconFb9qYEzO6lkAEgKWrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795440358;
	bh=cEf/1DtUu7n2FANLUGM7xPGUYAz1T5wZkwnUWItYytk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0EsserI2cHFMOSFCxSxS6mqLG1I1WlHIBFOLkveFlbhXKrehKKb3VJk2kH3cEFr1b
	 6Q4ecEzg5LKVhhwVlyLxBFZO6w5yvatZ0h4k8rcVGR7AY7CEihLhTkEUq2fFQRQnWv
	 qIf05wpy+xvVNptZEVwMgFNdejD94Acj6g2b659KPoy2Rboto68yJyrikL3JferKus
	 H5FIWhh6mSTQoswd5wpCKmQE1/q75/nN5x7kXWNOPRuHcJU8d6PMuHBDMaMDcw+GKz
	 xDTVEXLZBoN1s2yKLn8OKkN/W8mdmUa9nAgKCvqMSP3zOvaH3Aw3dfaiMtLjuY1Aw4
	 /moRPRUbJY93Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9679880E23;
	Mon, 23 Nov 2026 13:25:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2D62371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E487B6073D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qNpiD8DcsJUZ for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:25:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 94D0660673
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nqYCy8+W
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94D0660673
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:25:54 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso464948766b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795440353; x=1796045153;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cEf/1DtUu7n2FANLUGM7xPGUYAz1T5wZkwnUWItYytk=;
 b=nqYCy8+WdxHLKBN6l+5PMaAF2Td7ubOy5ca8bDLeJqxe7uDFMXj2JJ2edmUOSsAJy3
 kNkbQQy0HGjEoTI3XiVZPyO4v5FgaGCtLbOuwLf0u47pdtVfRnXWuE329/udF24ImJ0x
 r9Gy8+4z5jt8D9S/cpB2vZcdhDpq3hd16DOz2xmztZjpTviMM+Sdx3tfLUIjEvpAZPKK
 Lo0QEC8zWUUXS2YqKxg7b3qJzl54DZwo/DB3Db0pMmR0ZzwSZd4+JNVDfFuVLfSsKdNw
 krF76zwwPi2Ic6fNxHg49UgwvsOzlvVWn/OXDCK3nC+Iw5aZG66v7JWrfYQ8OzqUYxHk
 koag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440353; x=1796045153;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cEf/1DtUu7n2FANLUGM7xPGUYAz1T5wZkwnUWItYytk=;
 b=rL27d8TH47nYYc5sqEZM0DXwgkbW/y203/RnXzmFAJV8sNphpIjSHtRYwuSssKQpTV
 SDVVitUVY/v6S52BwOqRS12rImLfXGuyTZzL91UVEx2464nhmLNnqF6ECBqdF6LI01aj
 pbJjVVwP6tvNiQMeRPgvruXGzUVA0eHWaBrNA/gVCT/Ry2hr47YALbQRPV8ZTFxgMNAW
 xIwijgduroiELtuiPryPQcelVganL/ir26sRNFOSyevTc2QgM8P1P8LeZDi5wBfcjexA
 MYWdr6srkLtz2iPvoWQ/ntyur1WlN9oY3LiYTlEKKrHrk+Wh4px1iFWTKsELq9TCWCmd
 aNaw==
X-Forwarded-Encrypted: i=1;
 AL+hErE1VYbiAM3AJcjuIEFovpQa6XWdGS8/NJsmjMcnp8ZrFB6LLETZs1S8/fgJjV1oy7J7GOyhj6I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9bmNpVzEyX142/YA5YNg+gIThnLD5jbLuG/eTZPU2xwXRa2cmD
 mVW70IajKc4vA5M7KqDJFkcQN9Td7x08e+p6Jc3urjYU/Q/zcFrIF2uB4flrg62czcI=
X-Gm-Gg: AZFdTZfCa3olSVMnMcaleQ/nYAvxU/U4Mg/QXzmnBb70z+XrAuiqNs76TuFuydXi391
 7JgiQSOrMCkEZz+vUNbjsG0hCwzgRWAXYoZ0ACT1HbB5dgk5/9XAhE5yi3JYnrvDOrxTcPFKKfv
 yB4EJENH6+4X4Uwqcqh5GoAW3m3WRwCxE6Uq5N9JlF21mW0m0yXB712sVlIGjvEVK7bldwCZzlY
 etCUtRlYcciziBACTJwCeMbV77HTGPa/gDsCPTQzIn0EDPBVDhUR9kovZsomt741G+7eYIhemGu
 0I7/H8LvI2p6eZCS2/SMK5okTvgszc8lGNd/rkxFE6eAuLMiuvV5YGKv80g1eWON55+cY3beUca
 RKclI4UQpylQEJjQkloG5OZ+XugV89u3ji4mS1B42xvXWnLfKJJOJjX4+9UT1tCk2ZVexqdgWDz
 R/+NJtF98jrKgYkxD5b7mbDw8vHSYZb1S34S4A2SL06Q2MuVJEmQH57oItpt9tMQrVu2hGdqxZZ
 wJKu1HBkL4B4+jiMvEiTMvqpNj1DjEcJIlbU6k++/zJj77lTKWNKgVEYOdjoQ0rurL8yu9mOJnU
 zlPGY0xyQhWda9ohSXjSfIZCuEs614ZW/8tvGxOs
X-Received: by 2002:a17:907:a712:b0:c4d:a05:a2e4 with SMTP id
 a640c23a62f3a-c513a9ae26fmr852968666b.20.1795440353061; 
 Mon, 23 Nov 2026 05:25:53 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:c1b0:1199:e313:6fb5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc42bbsm406047366b.61.2026.11.23.05.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:25:52 -0800 (PST)
Date: Mon, 23 Nov 2026 14:25:48 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sam Day <me@samcday.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] mmc: msm_sdhci: drop the 1 ms delay after every
 command
Message-ID: <awQ-3DFUawyuoJjT@linaro.org>
References: <20261123-msm-sdhci-wait-send-cmd-v2-0-5de53eb34ff6@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-msm-sdhci-wait-send-cmd-v2-0-5de53eb34ff6@oss.qualcomm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 09:57:00AM +0100, Igor Opaniuk wrote:
> msm_sdhci sets SDHCI_QUIRK_WAIT_SEND_CMD, a 1 ms sleep after most
> commands. It costs 2 ms per multi-block read and caps USB mass storage
> on an Arduino UNO Q at 46 MB/s instead of 201 MB/s.
> 
> v1 only dropped the quirk. Stephan Gerhold found that this breaks SD
> card detection on DB410c, DB820c and RB3 Gen 2: the CMD55 after the
> first ACMD41 fails with a response CRC error.
> 
> Root cause:
> 
> The same failure exists on eMMC, where MMC_QUIRK_RETRY_SEND_CID hides
> it: the CMD2 after the last CMD1 fails on its first status read with
> INT_STATUS 0x00028000. Both cases are a CRC-checked command that
> follows an R3 response.
> 
> After an R3 response the controller keeps a latent command CRC error:
> 
> - it is not visible: INT_STATUS reads 0 before the next command;
> - it does not expire: the next command fails even 10 ms later;
> - it is removed by a status clear issued a few SD clock cycles after
>   the R3 command has completed. The clear sdhci_send_command() does at
>   completion is too early.
> 
> The quirk worked because it delayed that clear by 1 ms.
> 
> Testing results:
> 
> Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, eMMC, ADMA). A status trace
> was added to sdhci_send_command(); the identification clock is
> 188 kHz, 5.3 us per cycle. Each line is the first CMD2 of "mmc rescan"
> with the quirk dropped:
> 
>   Without patch 1                                    CMD2 result
>     as is                                            fails   6/6
>     50 us .. 10 ms wait before the CMD2              fails   3/3 each
>     final clear of the CMD1 delayed by 1 .. 8 us     fails   6/6 each
>     final clear of the CMD1 delayed by 12 .. 32 us   passes  6/6 each
> 
>   With patch 1 (85 us at this clock)
>     as is                                            passes  30/30
>     1 ms wait before the CMD2                        passes  10/10
>     10 ms wait before the CMD2                       passes  10/10
> 
> The 1 ms case has the gap of the SD ACMD41 loop. With patch 1 the CMD2
> is sent once per initialisation, without the retry.
> 
> Both patches, no trace:
> 
>   eMMC mode                          HS400 (200 MHz)
>   1 GiB "mmc read"                   302 MiB/s
>   CRC32 of the first 128 MiB         same in U-Boot and Linux
>   Linux boot from the eMMC           ok
> 
> Not tested:
> 
> - SD cards: the UNO Q has no slot, so it is not confirmed that patch 1
>   fixes the reported failure. Stephan's alternative, retrying that
>   CMD55 through MMC_QUIRK_RETRY_APP_CMD, works on his boards and can be
>   added if needed.
> - v4 controllers.
> - Other SDHCI hosts: patch 1 is in the common sdhci.c.
> 
> ---
> Changes in v2:
> - New patch 1: delay the status clear after a response without CRC
>   (SD detection failure reported by Stephan).
> - Patch 2: commit message reworded ("after most commands", Tanmay) and
>   shortened. The code is unchanged.
> - The Reviewed-by tags from Aswin and Tanmay are not carried over: the
>   patch now depends on a new sdhci.c change that they have not seen.
> - Rebased on snapdragon/qcom-next.
> - Cc the maintainers of the boards that use the driver.
> - Link to v1: https://lore.kernel.org/r/20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com
> 
> ---
> Igor Opaniuk (2):
>       mmc: sdhci: delay the status clear after a response without CRC
>       mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
> 
>  drivers/mmc/msm_sdhci.c |  2 +-
>  drivers/mmc/sdhci.c     | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> ---
> base-commit: 36d2b7b46c77b44021f0a6f36684a123e5560492
> change-id: 20261030-msm-sdhci-wait-send-cmd-4383f2792022
> 

Not 100% sure if this is the best way to fix it, but it works fine in my
tests and is certainly better than the unconditional 1ms delay we had
before so FWIW:

Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org> # DB410c eMMC/SD

Thanks,
Stephan
