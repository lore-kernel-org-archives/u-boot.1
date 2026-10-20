Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF839606A32C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gpv9SCdT;
	dkim=pass (2048-bit key, unprotected) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KCtfJBNu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C93AF40820;
	Tue, 20 Oct 2026 09:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LiElIAyF1TKL; Tue, 20 Oct 2026 09:22:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 033E5407E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488134;
	b=rErfFnQF4D8n3sjNIyeDDlTNzHqfCms5QuMdQx7qSGdowygxtDb/C+amfrI9tN38jxWB
	 gSzrEqRgyU2qoaY1BQf3kBoCUi/w4vLrbc2pkoql/BuijcWwWVqPNxW4fQyi7zn9ngGfe
	 rFezlUiL9ExqY/QOrjzPJHAJv1ouF8Glg4FGKTHSQ9fA/Fp5U/1H/3JZNxrAPptVYdQ5U
	 Vx3kbeQvhHlcyEv2iTYyTaQOiUhn2HOP/vrk7SGN2CkVNWrNZOz8HNZfNt08HtzIRqbBs
	 Fd/QRA108NOsU3E7Q941tG40PfPrA5pKhIS5PqbPV/FjhXCUHjh8yx7LBMctsccJpPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TOssb9EnZAJa9gjv879ab2TCnrJ24+6NwigIs2ujFH8=;
	b=XgDvrhlA+PCZoN3EGOXUSANMQYmeyPa0ugLeKQkr7aD/hwhZPX7/kQgjGzXA0BYOaDLW
	 wIFEJeYR5SIjjoQzTkTFdrzLXYOD6V9Z9xiUlIu9+lgUo3yMvjvRTqVIKm5QpKG3RJxaN
	 kSjHnXcMaMl7ySG7IzTtY3JOpLgd2X1J7/UG4KEQB9FeT3yfh0GG5VF+zcFA+SCO0DFd4
	 m/eA3sRXhTFxa9BoHeGwLNKrxGdU9B2ItOVbnv6XdrRQ56KJenKxDMGMHVsWNAg4P2dTG
	 OiLmnAVQiuk8ovjVQsQKsmp0UUJf6T0xPipw+W4EcQ3ZJ+HxJadCHpO8rfvUOGUXR8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=9elements.com;
	dkim=pass header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KCtfJBNu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488134;
	bh=TOssb9EnZAJa9gjv879ab2TCnrJ24+6NwigIs2ujFH8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gpv9SCdTu3ha6bhpMiRmdzx+/ABfV2iOHLn3vwJL4rZzxq0iLkORZQRcC2/sLSqQ1
	 RqYb1KFJfe/hoZkFWmFPkSV1pZkppSoUd4t7yw7jI7iyfQGlfsu4wbYgICPQuZve2v
	 ct+w0fIEFQ6GdvvH9ldlJ/jvTJxBBhwqGtmdJ6LyQjtRakgse9OwxgusefgLmStYPq
	 KDbYnkPqTPiyWrPIeXJmxgby02PjyZkf2pmdXmOZKQnRKs24ePtSQnH5GOvrmMswD7
	 oy7D5FUzDnpnqbNwMjjZvmzY4EcxBMKGUzCgu/CQbrUPew8/nRwBkiAxZI+lkXE/jq
	 yRPxTbhnubcjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 033E5407E2;
	Tue, 20 Oct 2026 09:22:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9256F465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FD7E407E2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFj1pdMyhzQJ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:22:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9276C407E0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488131;
 b=UTOCEUCY9ZmsyaiGDWuJDWxKl8FLrdIVTX9NHY5ZvmH5nuzlXKrf2eIYJvjjkmRWdVpE
 MSggo9Fx+JL8sZcOYXVH0tRKL1woHwyxjajO25brejXTeWZP8EOi0cbOHsX7mLdpSQW0I
 +h8f8L4+3x1jiPTZZwGJ/SHAaTNWpliPh08UpWTh9okmt2L3Jy2nbbiNHq2MtVhsps63B
 oVZYegsBuEml+aokLm1awl1jD4eOlLCYmuV8EUHLok9jmX77bTZAVS3MZEXP5+6HZ4/04
 Zir+U4gmjSlQ7tML5Nr0EuuuEdU6EUPzaFBby0NMA+D6UoGeQbFp65caUH5EJHqJnSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488131;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=TOssb9EnZAJa9gjv879ab2TCnrJ24+6NwigIs2ujFH8=;
 b=YjhhxJEw8LW7cDnrRTeihkzgAsdJggRjDHQitV/yGjIVR5GSIzjnF3+eqzo9+gHMVPzK
 WGBHZB6+D+bjoauF8zASPzDOtK21U5NGxWEL7KaqRyix+3b2rzTklAC2gS5EnQy+i4yF1
 5JRAzdfw5ssEFB0wfJc2L18IoUQOxDQQLV7BxyaQHyg5Nr3QJwlE87NCPzd6bgOzK9Wx/
 xSH68Y+prrQuWmtaRheV0+1Rd1Ksl7CPXFClAnNw+30Y/uDUsMfDXr5OP9yCBQmXqz19s
 ILjy82t2kMtKtFlgxRDspw6ReV91L9dIQLDo/nMiCHHXNL3Emati/3d3SmBFDG8Jnmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=9elements.com;
 dkim=pass header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256
 header.s=google header.b=KCtfJBNu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=KCtfJBNu
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9276C407E0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:22:10 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1d484b4a9so38519035e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1792488128; x=1793092928;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TOssb9EnZAJa9gjv879ab2TCnrJ24+6NwigIs2ujFH8=;
 b=KCtfJBNu5iK7a+W8ntm8EC0glOeZilkQ/83n/IGvW2hFNI0AM/VZaGpHOj7baUp7m7
 1bbn5LKPQSoj0yUuet0t6cA2yPeD87Er3I8Nk5hkQW923DPUhEw10IBRh0wdefUphMcG
 ZHeZb8K3JbrpJ9lNjbk2Pt7AoA3AVLvCjl+ul5DVhc9XNsZKnLoBeMsmFdmUk1pNbqTq
 3l4u9dOUkkua27MunfM2lzM5Z7iG2YlfoaKNhZGXxOPKGqmgB5c7wSMbrjcB7DK/vcat
 Mv9nYwsQP8XDE89TTWGJGlqBMMmx6MRW2nrWiyA89E1X5o6eXN50pYSjt5xUOO/FnaAi
 l80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792488128; x=1793092928;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TOssb9EnZAJa9gjv879ab2TCnrJ24+6NwigIs2ujFH8=;
 b=ws+Th6dtvMsNtO0UD/c/TbNjsdzCLn98+DI4G5rYmYyX1X9FmjnA04KSamOXzMODm6
 mC++naoxLvYVj/l0jR3bxz+8oTQIFTgBM18zRPBtPBIaoTVnlIyyhTrDdfzmv7d7/ciq
 FoI92M7B4xGMWeJJcNptMFNzZPqey63Ali5Sl+iY11bsqMPpYLUdAJ0K7NuCxUXqR4I3
 v6RWLe/Bw2W2aga3DKyrRe8TpAhw+lvib3Hg9fMOj7F0JqXa1MCkUBkm1mtPj5youjZD
 12Xmx1O8tyGtrcz7o0dzec3n8O6rKL+HJZI1ChmHAdqDjqVlEi4RnbID2Yyw3GMgK/fv
 8Wfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUzUn/GpGj5y5vHvqbyUp0Yg8M+JfyHqiv4765h6/+ffVw7XNSVi5xs6oNnio7/RtT46Hansc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJM8q9F4aLDKZWLLaU/x6X72vKldFyHCxQxxx8HA6oKX3dC349Y
 MtslKCTLvBLeBjcfAXUrsxmQ9TJMyXIFTOqCvjOiDdJvUxEpTlbJtCkOreO2zbBqsS/bZLj+FIu
 2Us5y
X-Gm-Gg: AYBFou0/9OaMV8OWCFiJcCUfT3p7kj+iJixLgKr74Lnb1sSXq6dCB8MTGyFKmqPcy/D
 +TdOGc/yBiEIw1sd/5Ks6sTP1t0NA5jxzhOIudg0OcCAvFsh+8YtkP3w3Rxs/HCpZ45B0pk4GNp
 pk/YjDnECJaZiPzgLK1w4rPjanlYGjMsiZO5FdpA3XYp73TxD7LRH8AX87g/ZnuHng1545aClcW
 H06iaOrSkrHCrRJwgRbF6CkeF5Vx33mFR5YHmgu2LxK/48hNmR+K6nerFOUZ+A2CD5su1aPJ8RW
 Kef0SDQAINaAw55moGd8SfYyc3owPMmg4hANctCswgRTezdsC4cgHIvH6kLLGT8Vd9cebsl2XuC
 jsxzOsn87h1vxzPwoC+6xNDAZpaxYZVPA/n9JyOeigyLp290ZW82CvBH7dEM1vUlZ43Cd9Ipaet
 IBQ11LzPs4t7zkSo5NJJowAn/VKsnl0XvTnMBFQUCfnccGQMXubToQT2Ooe7f+Rtfwi/+QpcWLr
 TRlGHgJF5/qPbYJ
X-Received: by 2002:a05:600c:524e:b0:4a1:db17:c7e6 with SMTP id
 5b1f17b1804b1-4a1db17ca8cmr182478485e9.2.1792488127883; 
 Tue, 20 Oct 2026 02:22:07 -0700 (PDT)
Received: from white-mocha.local ([2a01:599:842:3b3c:7750:5d83:528b:95b1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8244e1sm4629932f8f.44.2026.10.20.02.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 02:22:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] spi: aspeed: Add read timing calibration
From: Tan Siewert <tan.siewert@9elements.com>
To: Cooper Huang <cooper_huang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Tan Siewert <tan.siewert@9elements.com>, 
 Vince Chang <vince_chang@aspeedtech.com>
In-Reply-To: <20261019-spi-aspeed-calibration-v1-1-800d80c9939f@aspeedtech.com>
References: <20261019-spi-aspeed-calibration-v1-1-800d80c9939f@aspeedtech.com>
Date: Tue, 20 Oct 2026 11:21:58 +0200
Message-Id: <179248811801.62553.17352762992867794012.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792488118; l=11321;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=66Wqb6ClPMr49kBBNN7reFc22sf+xFb771w8xttLVhA=;
 b=hcWB6UFeMb9HTj4nti2FCWbL6/1184glqxq7JF46yqrSqhR2Y1JvIrd+TOakJCwRsryY5UC7X
 2erah8Vew9hAZa0pXNtfcxunwL8YiK49RUW3jc5QL1z0zYr0u1Qwf1/
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> At high SPI clock frequencies, the controller must delay the sampling
> of the read data, and the right delay depends on the board. Port the
> read timing calibration from the Linux driver: golden data is read at
> HCLK/16, then the timing settings of each HCLK divider, from the
> fastest one allowed down to HCLK/5, are scanned until the reads match.
> 
> Until the calibration is done, the flash is accessed at HCLK/16, as in
> Linux, since faster settings may not work without the timing
> compensation.
> 
> Compared to Linux:
> - each setting is checked by reading 1KB twice, instead of 16KB ten
>   times, to keep the boot time short.
> - the AST2600 setting picked in the passing window is mapped back to
>   the input delay that was tested. Linux writes the column index as
>   the delay, which is one step off.
> 
> Based on the following Linux commits:
> - eeaec1ea05c0 ("spi: aspeed: Calibrate read timings")
> - 31dcc7e1f8a9 ("spi: aspeed: Update clock selection strategy")
> - efb79de36e94 ("spi: aspeed: Improve timing calibration algorithm
>   for AST2600 platform")
> 
> Link: https://git.kernel.org/torvalds/c/eeaec1ea05c0
> Link: https://git.kernel.org/torvalds/c/31dcc7e1f8a9
> Link: https://git.kernel.org/torvalds/c/efb79de36e94
> Signed-off-by: Cooper Huang <cooper_huang@aspeedtech.com>
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index e60bd77387a..57156122e85 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c

*snip*

> @@ -724,6 +736,239 @@ static int aspeed_spi_exec_op_user_mode(struct spi_slave *slave,
>  	return 0;
>  }
>  
> +/* Read timing calibration, ported from the Linux driver */
> +static bool aspeed_spi_check_reads(struct aspeed_spi_flash *flash,
> +				   const u8 *golden_buf, u8 *test_buf)
> +{
> +	int i;
> +
> +	for (i = 0; i < CALIBRATE_REPEAT_COUNT; i++) {
> +		memcpy_fromio(test_buf, (void __iomem *)flash->ahb_base,
> +			      CALIBRATE_BUF_SIZE);
> +		if (memcmp(test_buf, golden_buf, CALIBRATE_BUF_SIZE))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* Check that enough words are neither all 0's nor all 1's */
> +static bool aspeed_spi_check_calib_data(const u8 *buf, size_t len)
> +{
> +	const u32 *buf32 = (const u32 *)buf;

Compared to Linux we only have a 1 KiB buffere here (64 out of 256 words), i.e.
25% of the data has to be neither 0x00 nor 0xff.
What if the first 1 KiB has more padding? That'd be enough to be counted as "too
uniform" and the flash would run at max_hz without calibration.

Can we scale the threshold to the buffer size maybe (len / 256 to match Linux),
or keep a bigger buffer and only shorten the repeated reads? Either way, please
mention it in the "Compared to Linux" list in the commit message.

> +	u32 cnt = 0;
> +	size_t i;
> +
> +	for (i = 0; i < len / sizeof(u32); i++) {
> +		if (buf32[i] != 0 && buf32[i] != 0xffffffff)
> +			cnt++;
> +	}
> +
> +	return cnt >= 64;
> +}
> +
> +static u32 ast2400_fread_tpass(int i)
> +{
> +	return (i / 2) | ((i & 1) ? 0 : TIMING_DELAY_DI);
> +}
> +
> +/* The timing register is shared by all CS, only CE0 is calibrated. */
> +static int ast2400_spi_calibrate(struct udevice *dev, u32 hdiv,
> +				 const u8 *golden_buf, u8 *test_buf)
> +{
> +	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
> +	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
> +	u32 cs = slave_plat->cs[0];
> +	struct aspeed_spi_flash *flash = &priv->flashes[cs];
> +	uintptr_t timing_reg = (uintptr_t)&priv->regs->timings[0];
> +	u32 shift = (hdiv - 1) * 4;
> +	u32 timing_base;
> +	u32 timing_val;
> +	int pass_cnt = 0;
> +	int i;
> +
> +	/* Other CS reuse the CE0 timing, require three passes as well. */

The code reads more like that other CS can't change the shared timing register?
So maybe reword it to something like "Only check that the current CE0 setting
reads back correctly three times." or so?

> +	if (cs != 0) {
> +		for (i = 0; i < 3; i++) {
> +			if (!aspeed_spi_check_reads(flash, golden_buf,
> +						    test_buf))
> +				return -EIO;
> +		}
> +
> +		return 0;
> +	}
> +
> +	/* The AST2400 SPI controller has its timing register at 0x14. */
> +	if (priv->info == &ast2400_spi_info)
> +		timing_reg = (uintptr_t)priv->regs + 0x14;
> +
> +	timing_base = readl(timing_reg) & ~(0xfu << shift);
> +
> +	for (i = 0; i < (TIMING_DELAY_HCYCLE_MAX + 1) * 2; i++) {
> +		timing_val = ast2400_fread_tpass(i);
> +		writel(timing_base | (timing_val << shift), timing_reg);
> +
> +		if (!aspeed_spi_check_reads(flash, golden_buf, test_buf)) {
> +			pass_cnt = 0;
> +			continue;
> +		}
> +
> +		/* Use the middle one of three consecutive passing settings. */
> +		if (++pass_cnt == 3) {
> +			timing_val = ast2400_fread_tpass(i - 1);
> +			writel(timing_base | (timing_val << shift), timing_reg);
> +			return 0;
> +		}
> +	}
> +
> +	return -EIO;
> +}
> +
> +/* Column 0 is without input delay, columns 1 to 16 are input delays 0 to 15 */
> +static u32 ast2600_timing_val(int hcycle, int col)
> +{
> +	if (!col)
> +		return hcycle;
> +
> +	return TIMING_DELAY_DI | hcycle | ((col - 1) << 4);
> +}
> +
> +/*
> + * Each CS has its own timing register. Use the center of the longest
> + * passing window of input delays within a single HCLK cycle delay.
> + */
> +static int ast2600_spi_calibrate(struct udevice *dev, u32 hdiv,
> +				 const u8 *golden_buf, u8 *test_buf)
> +{
> +	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
> +	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
> +	u32 cs = slave_plat->cs[0];
> +	struct aspeed_spi_flash *flash = &priv->flashes[cs];
> +	u32 *timing_reg = &priv->regs->timings[cs];
> +	u32 shift = (hdiv - 2) * 8;
> +	u32 timing_base;
> +	u32 timing_val;
> +	int best_hcycle = 0;
> +	int best_col = 0;
> +	int best_len = 0;
> +	int hcycle;
> +	int start;
> +	int col;
> +
> +	timing_base = readl(timing_reg) & ~(0xffu << shift);
> +
> +	for (hcycle = 0; hcycle <= TIMING_DELAY_HCYCLE_MAX; hcycle++) {
> +		start = 0;
> +
> +		for (col = 0; col <= TIMING_DELAY_INPUT_MAX; col++) {
> +			timing_val = ast2600_timing_val(hcycle, col);
> +			writel(timing_base | (timing_val << shift), timing_reg);
> +
> +			if (!aspeed_spi_check_reads(flash, golden_buf,
> +						    test_buf)) {
> +				start = col + 1;
> +				continue;
> +			}
> +
> +			if (col - start + 1 > best_len) {
> +				best_len = col - start + 1;
> +				best_hcycle = hcycle;
> +				best_col = start + best_len / 2;
> +			}
> +		}
> +	}
> +
> +	if (best_len < TIMING_MIN_PASS_WINDOW)
> +		return -EIO;
> +
> +	timing_val = ast2600_timing_val(best_hcycle, best_col);
> +	writel(timing_base | (timing_val << shift), timing_reg);
> +
> +	return 0;
> +}
> +
> +static bool aspeed_spi_need_calibration(struct udevice *dev)
> +{
> +	struct aspeed_spi_plat *plat = dev_get_plat(dev->parent);
> +	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
> +	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
> +
> +	/* The calibration is done when the read direct mapping is created. */
> +	return CONFIG_IS_ENABLED(SPI_DIRMAP) && priv->info->calibrate &&
> +	       slave_plat->max_hz >= plat->hclk_rate / CALIBRATE_MAX_HDIV;
> +}
> +
> +static int aspeed_spi_do_calibration(struct udevice *dev)
> +{
> +	struct udevice *bus = dev->parent;
> +	struct aspeed_spi_plat *plat = dev_get_plat(bus);
> +	struct aspeed_spi_priv *priv = dev_get_priv(bus);
> +	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
> +	const struct aspeed_spi_info *info = priv->info;
> +	u32 cs = slave_plat->cs[0];
> +	struct aspeed_spi_flash *flash = &priv->flashes[cs];
> +	uintptr_t ce_ctrl_reg = (uintptr_t)&priv->regs->ce_ctrl[cs];
> +	u8 *golden_buf;
> +	u8 *test_buf;
> +	u32 clk_setting = 0;
> +	u32 ctrl_val;
> +	u32 hdiv;
> +	int ret;
> +
> +	if (!aspeed_spi_need_calibration(dev))
> +		return 0;
> +
> +	if (info == &ast2400_spi_info)
> +		ce_ctrl_reg = (uintptr_t)&priv->regs->ctrl;
> +
> +	test_buf = malloc(CALIBRATE_BUF_SIZE * 2);
> +	if (!test_buf)
> +		return -ENOMEM;
> +
> +	golden_buf = test_buf + CALIBRATE_BUF_SIZE;
> +
> +	/* Read the golden data at HCLK/16. */
> +	ctrl_val = flash->ce_ctrl_read & ~info->clk_ctrl_mask;
> +	writel(ctrl_val, ce_ctrl_reg);
> +	memcpy_fromio(golden_buf, (void __iomem *)flash->ahb_base,
> +		      CALIBRATE_BUF_SIZE);
> +
> +	if (!aspeed_spi_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
> +		dev_dbg(dev, "calibration area too uniform, skipped\n");

Why's this dev_dbg? In linux it's dev_info and this information seems useful to
be reported to the user.

> +		clk_setting = info->get_clk_setting(dev, slave_plat->max_hz);
> +		goto out;
> +	}
> +
> +	for (hdiv = info->min_hdiv; hdiv <= CALIBRATE_MAX_HDIV; hdiv++) {
> +		u32 hdiv_freq = plat->hclk_rate / hdiv;
> +
> +		if (hdiv_freq > slave_plat->max_hz)
> +			continue;
> +
> +		clk_setting = info->get_clk_setting(dev, hdiv_freq);
> +		writel(ctrl_val | clk_setting, ce_ctrl_reg);
> +
> +		ret = info->calibrate(dev, hdiv, golden_buf, test_buf);
> +		dev_dbg(dev, "HCLK/%u: %s\n", hdiv, ret ? "FAIL" : "PASS");
> +		if (!ret)
> +			break;
> +	}
> +
> +	if (hdiv > CALIBRATE_MAX_HDIV) {
> +		dev_warn(dev, "no good read timing found, using HCLK/16\n");
> +		clk_setting = 0;
> +	}

get_clk_setting sets flash->max_freq too. If every divider fails it'd stay at
HCLK/5 while the controller runs at HCLK/16.
I mean, it _should_ have no effect as it's only called if "flash->max_freq == 0"
in claim_bus, but the stored value would be wrong.

> +
> +out:
> +	flash->ce_ctrl_user &= ~info->clk_ctrl_mask;
> +	flash->ce_ctrl_user |= clk_setting;
> +	flash->ce_ctrl_read = ctrl_val | clk_setting;
> +	writel(flash->ce_ctrl_read, ce_ctrl_reg);
> +	free(test_buf);
> +
> +	return 0;
> +}
> +
>  static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  {
>  	int ret = 0;
> @@ -779,6 +1024,10 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  
>  	writel(priv->flashes[cs].ce_ctrl_read, ce_ctrl_reg);
>  
> +	ret = aspeed_spi_do_calibration(dev);
> +	if (ret)
> +		return ret;
> +
>  	dev_dbg(dev, "read bus width: %d ce_ctrl_val: 0x%08x\n",
>  		op_tmpl.data.buswidth, priv->flashes[cs].ce_ctrl_read);
>  

*snip*

> @@ -1167,7 +1432,8 @@ static int aspeed_spi_claim_bus(struct udevice *dev)
>  
>  	dev_dbg(bus, "%s: claim bus CS%u\n", bus->name, slave_plat->cs[0]);
>  
> -	if (flash->max_freq == 0) {
> +	/* Stay at HCLK/16 until the read timing is calibrated. */
> +	if (flash->max_freq == 0 && !aspeed_spi_need_calibration(dev)) {

If dirmap_create fails before or during the calibration (e.g.
aspeed_spi_decoded_range_config fails or aspeed_spi_do_calibration returns
-ENOMEM) then need_calibration stays true, so the clock is never raised and the
flash silently stays at HCLK/16.

Maybe add a per-flash "calibrated" bool or so for claim_bus to check instead and
in the failure path fall back to the uncalibrated max_hz or at least print a
warning?

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>
