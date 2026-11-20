Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74A606A6FA
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pihHj3NI;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Duqmepc1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2B1C8148A;
	Fri, 20 Nov 2026 20:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R6tXygIlWI1X; Fri, 20 Nov 2026 20:08:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 215D8813A6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795205331;
	b=R2b/7qo72/GK7HKbWFv8cwabDvDNh2xUo6tDkjfaXAoRxOyG9NvuXOp9QLzGqKnQYYSj
	 rNceRFYHNX0kUvBKkDamilOiY85jSSFotVH+JRXpEnP+yQSnsQOR64sthygT+8knXP16T
	 QS0Oi6rNprxrxJ7qTzkQQHPrv2FJaR6CVP6cW0kIA0l6zluN061TdmV+lWFcjRHU6USX2
	 RAoORYItDGJCIlifsQ20WHtER8JqXingbbtRtwDljydDWbY/Jq6JXoVAhKbGGRCZ9DRtj
	 Y/oAEgPD8OFyqo6XZouIMK+MWHvLkR/PYuB4ZP3o/HCVyq4gmDfTugQbAAg7pZch0Vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795205331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Pfe1gUdOdKo+aA+CfO5y51VYuprMGqAapdCBAqoyXTQ=;
	b=VQ56s24Mcg8zt3WFdOBqY5Gi3Z/kOBygVdSPuWI3Gh9BIhF3XjEjJ6mkW6by8pfKxzVO
	 x9GubmomD1L8838KkgAd9fkQUtTs6a33ZgNG3TmUZLno5Hninu5F7yppLyWzcO7kkYvmy
	 1pfffquvfqLhwNGDeo3Q3oVm7YUilfEIWHNJktSUrX9hwfOCasbYA3DcidlERjohe0YPe
	 HK7IdBpvdRl9a8lyRDWzcEu8dmh6wLLBBB9PzC/hXAAKUKYG0STjrJU7TNIYIhK6Y1dqd
	 j9t99nX1WCsocW/Bk17fntdmQCUCzM+Ei2M2+fmVdop8EWmUYcQZTSRFNQVdvHvHz0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795205331;
	bh=Pfe1gUdOdKo+aA+CfO5y51VYuprMGqAapdCBAqoyXTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pihHj3NIJywpdXYaRgD8MK+ST30yhxi+rZ9jTPRepsHRJlcgvrn6mKr+ysEvim7k/
	 rm9HT5/V/rzh4cIN8HCEKxZjfIgXiMPFj1vXg9fLS0+AqPHhY/i/MBMSPhTBmVZgEc
	 jibeBIaFE/D+k5ENjus6dOH4tsFY6fpTl9QWYbjtODw17PvWvQselpLjEu/Lsw9a7G
	 M8gKQAqtRSDmgD+Jp9dv/ktUoTAEebRR1h8mfWHUK9jd0+W5ZBr0p7KLfr924c521j
	 RJ5kLe7xF+35HG4jVWm2koHUnzoReUytiOFTudm22Y1nEx8zeGbfdL8Jgeipm7nBwZ
	 vooOSphDlgh5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 215D8813A6;
	Fri, 20 Nov 2026 20:08:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0751B169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 20:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0502540208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 20:08:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHeDTU4VqYLo for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 20:08:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D7B9B400BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Duqmepc1
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7B9B400BE
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 20:08:48 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so15927525e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 12:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205326; x=1795810126;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pfe1gUdOdKo+aA+CfO5y51VYuprMGqAapdCBAqoyXTQ=;
 b=Duqmepc1eUxuTNWVrPUeEYmLlaz6RYLbAfY75O5yxyWvIa7bk2rQQY9hLaFd/QroRq
 NYSZ/UGmyHgcowu+l1EkBtrYTRr6X1rtZ1MIGIlcuRYAXOnhYxNHruiepfRBOFV7cjp1
 7B80fChmNuAJuI2hkMRCB4ZX+N8QprZNqa5AmK/BEr4/1GhkRVk2bg9tr4Fol3exU7/0
 PSYcCs69jnDcOKukc5MVkBUoHxwFL5BWJQXKTO59BjNi4TWggbX89w7sXtD9ODkTsq0r
 sd2eAcPVMbLE3i+x3bbam/lk02h/Nu84HGlDFJVM9LZULd2Ltz8/sXzrCCN0mDkVYJSN
 UWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205326; x=1795810126;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pfe1gUdOdKo+aA+CfO5y51VYuprMGqAapdCBAqoyXTQ=;
 b=jc7baaeToaMK760PuTVz1N1zyEjsJs9OuacAt7hsDbqECpslhMQdwo9UztRT9RuQEr
 jgVT/N5dcjGbyfSlK2qHfo/8NOmgAOx9+DGYHqNwj8hxXuUD02UAQyJhefYqUyHENuuq
 IX8oz7gKcbfHWT/mVjYaOPR4dgqpnw9o/LLiiFy2bCY1enHNxAldcjod2nIQ4qqlTdgQ
 8wrp0q6mySprOqPGmsrnoR8Swz7+Mp0oZLC9/0T47kmxL1KL8gSwxlaoWsQxhGlcwn/J
 Jr9Eos9Odc68T4aj6jYx+eet3AnSIDB9HZtfjKdb9tYKFGuHmxYI9rc1xLC/fvNGhBrq
 tT2w==
X-Forwarded-Encrypted: i=1;
 AL+hErFoz9tnSLJQoB31PyZKpyR8kLnO84j16ut0Q6CxQzGnI/93Q+59MOdwkeKfpaTfCEYKYM4VE6k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9JRNMOBbHMItVffxGZjTBdwvD8eCf9lF77IejS4IK/BZFhgjq4
 ed/Qfb21m4scM7Rgo4ZfHr9OCrrMoYRZmgqSuw2JSlGfgbRCNIku1O6nre6uqSoVGK0=
X-Gm-Gg: AYBFou31JFp3RjaH33RbajbJil6+ay/zxe/xWYgQqlkM3/bkCuGdlZEK0ZsvhVUwSjR
 G6W1Fv1kDBsZb3ziGQoIcOLFfv6Gp7ndo2GK5ngnWnq5badnJad7r9CxW1BoQx+BYKU1ow/1Ju4
 u968KpFTnNuU0WSYOPp6dDheZghD92vXMYCL4f4NABGgPhGqvlaOt4NO77UwEx/91xJQPmsCtyz
 Xsd96UgOBsTm5QK4MmMD70ZqJAEinjY33A1exFh4quLEajpH4lFcBitA3nVSJD3rFkUc5hoFz8E
 kQFxvqe5ejC+HBMG9rOZpruP4aAi2PH18pIsfKODAzOyWoiBR9rVM5ksvzkHwuWWbfRIGWnlj+j
 cMIJ+FUDeCGpIiykRTWrIUyuneROkJfvArm4pI8rT6IAP5ILZKSPDKy2rZHNbgAZWLTkDc+fQYA
 k9LNAyMr4XcDqrVsS6OsjV3mQOqCjflqEAYhWd3ieRTYyQmPSza4Qp2bTED5A9ztlZV2i/p9+r1
 Fant74ZYaVqgTQnq/UVqqnEHeMtCzsPu2k5AHBWa+S+n/WuZCTriHAiDthHD7Th6OpGF+dR5e0s
 BgEzLCnOmesrQNS6WLxcKS298CzUT2dX1OY4w06E
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr104599935e9.5.1795205326076; 
 Fri, 20 Nov 2026 12:08:46 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:d909:fc2c:8ab2:1d82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm61272865e9.4.2026.11.20.12.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:08:45 -0800 (PST)
Date: Fri, 20 Nov 2026 21:08:27 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH] mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
Message-ID: <awCou-Ra_Rldo9N5@linaro.org>
References: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 02:57:00PM +0100, Igor Opaniuk wrote:
> SDHCI_QUIRK_WAIT_SEND_CMD makes sdhci_send_command() sleep for 1 ms
> after every command. msm_sdhci has set it since the driver was added
> for APQ8016, back when it only did PIO; the commit gives no reason for
> it, and the Linux sdhci-msm driver has no such delay.
> 
> The delay is invisible for large reads but dominates small ones. A
> multi-block read is CMD18 followed by CMD12, so every read pays 2 ms
> on top of the transfer. With the eMMC in HS400 a 128 KiB read takes
> about 0.4 ms, so USB mass storage, which reads in 128 KiB (FSG_BUFLEN)
> chunks, spent most of its time in udelay(). On the Arduino UNO Q,
> reading 1 GiB from "ums 0 mmc 0" on a USB 3 host
> (dd if=/dev/sdX of=/dev/null bs=4M count=256):
> 
>                      host throughput   time in eMMC reads (10.6k reads)
>   with the quirk     46 MB/s           26.8 s (~2.5 ms per read)
>   without            201 MB/s           4.5 s (~0.4 ms per read)
> 
> A single 128 MiB "mmc read" runs at 255.6 MiB/s either way.
> 
> Drop the quirk and keep SDHCI_QUIRK_BROKEN_R1B.
> 
> Tested on the Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, ADMA):
> - on main (eMMC in DDR52): 128 MiB "mmc read" at 75 MiB/s as before,
>   the CRC32 of the first 128 MiB read in U-Boot matches the one Linux
>   computes from the same blocks, and Linux boots from the eMMC;
> - with the "qcom: Enable HS200/HS400 eMMC modes" series and the
>   mass_storage SuperSpeed descriptor patch applied (eMMC in HS400):
>   the ums numbers above, same CRC32 check and Linux boot.
> Not tested on v4 controllers or on the boards that use the driver in
> PIO mode (qcom_dragonboard410c, qcom_dragonboard820c, hmibsc).
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Drop the 1 ms delay msm_sdhci adds after every SD command. It costs
> 2 ms per multi-block read, which capped ums on an Arduino UNO Q at
> 46 MB/s; without it the same read runs at 201 MB/s.
> 
> Testing on APQ8016/APQ8096 (PIO mode) would be welcome.

Please Cc the board maintainers (me, for DB410c/APQ8016) if you are
looking for feedback for these boards. I found this patch on the mailing
list only by coincidence.

The fact that APQ8016/APQ8096 use PIO instead of ADMA is a relic from
before ADMA support was introduced. ADMA works just fine in my tests on
these boards and makes no difference for the following test results.

This patch works for the eMMC, but it seems to break SD card detection
on all QC boards I tested.

DB410c (APQ8016):
 - eMMC: works
 - SD: broken, CMD55 response CRC error

DB820c (APQ8096):
 - eMMC: N/A
 - SD: broken, CMD55 response CRC error

RB3Gen2 (QCS6490):
 - eMMC: N/A
 - SD: broken, CMD55 response CRC error

The symptom is that the SD card is simply silently not detected at all,
I added some more logging to find the CMD55 response CRC error. AFAICT
(without investigating in detail), the following happens:

 1. In drivers/mmc/mmc.c sd_send_op_cond() U-Boot sends MMC_CMD_APP_CMD
    (CMD55), followed by SD_CMD_APP_SEND_OP_COND (ACMD41).
 2. The first CMD55 and ACMD41 succeed, cmd.response[0] is 0x00ff8000
    so BIT(31) (OCR_BUSY) isn't set yet so it polls again with the same
    commands after 1ms.
 3. The second CMD55 fails immediately (too early to come from the SD
    card with a CRC error).

The CRC error seems to origin from the previous ACMD41. With
SDHCI_QUIRK_WAIT_SEND_CMD we wait long enough after sending the previous
command to clear the CRC error before the next command sees it.

There different options to fix this:
 - A retry of CMD55 in case of an error seems to work.
 - Maybe we could check and clear unhandled errors in
   sdhci_send_command() before sending another command.

This extra diff that implements a retry works for example:

--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -674,7 +674,8 @@
 		cmd.resp_type = MMC_RSP_R1;
 		cmd.cmdarg = 0;
 
-		err = mmc_send_cmd(mmc, &cmd, NULL);
+		err = mmc_send_cmd_quirks(mmc, &cmd, NULL,
+					  MMC_QUIRK_RETRY_APP_CMD, 3);
 
 		if (err)
 			return err;

The real question though is why we are reliably getting this CRC error.
It might be worth to investigate that further. I would expect you can
reproduce this on any QC board with a SD card if you want to test this
further.

SDHCI_QUIRK_BROKEN_R1B on the other hand made no difference in my
testing, I think we could drop that one (Linux does not seem to do this
either).

Thanks,
Stephan
