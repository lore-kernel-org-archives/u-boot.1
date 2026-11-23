Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78187606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mqDprd6t;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oyOTHgQR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52D3C406EF;
	Mon, 23 Nov 2026 15:06:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PD77piT1-Bgp; Mon, 23 Nov 2026 15:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A48B6406DE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795446374;
	b=eX7dKt6K/QMXeu7ju07YahodmZhjj9b4dOJcJFUEsDNdZt1jIby2grJ0OsTuv5ZGnPB1
	 DlAKVCivCYh2qhwupL2hF7wasookaoGjQNbyjiAfrV6l4AAyTtShDD79mUQEu3WsiiGsC
	 A6nNV2U9pKdGDLRCxt3EfAq0BuC8H2xr1atROtqwjV8JDmWRAG/Y9C4D20UBdg+6rWaQt
	 6hFqFc0QW8NuVQmJrffJhwyszgDgqJdc1JB1p3c0oafF5V6yp0h+kzg0fhlLbzMb5j18E
	 coxUWA61IFQqj/zNafEre0i+hIn8fyxe3R/5gaZvipUlG9vDohIW1YnNsyxGZj6Hgxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795446374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Vk+x2tK/cCaOWUi6lR/S9lxR0/6pkjAs8D7GsuYg6Ps=;
	b=hRMqkQZ4o+Fqjxbs6cFh8Pr2swJwCzAGApuMFVBzCkbX6X0DLR2A3WOfwQ2SgP1QbDou
	 7q6rfUa77+ncnPc53oj4Z0RAvz5XXCPJLCMJp2M5tvIA7HIFEq+ghBaiVM+r5lOLxB7bA
	 uZroaOUCDTfL9G9t0qnPpDZgZaH3Dvt0XLKFF6cpia+2uFVzGg4wb8w0MFmwV+OUQCd8a
	 AskQxx2Y0FeQYiQaOXaEQhh8NZm0fyaTRupVqyLVDY8dTc74G3UY6n/xB/v9nqfil/6tD
	 /QGvP1hKRU8V9G29CNrg9D6/OIZitHOA5/4PClepT6jGwnXbaCicJLkxtmEX0jHpgEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795446374;
	bh=Vk+x2tK/cCaOWUi6lR/S9lxR0/6pkjAs8D7GsuYg6Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mqDprd6tRM67geZjy+Bsl/z9PaIE11eGCg8KnykLZsl1i9BmKowki0M63ut1VkJV9
	 QLzRbKLv+qrZxqEAOb8HTAWUtC3F+kVDMijbcL1xNK+lF6PVsGGv0kiGIO74Eg+2aH
	 v9qwiUsPcumIxYhn3OTRUttK98Gf/1HPNsxZBvKHzbPHE7t23OCVYCQnk4fRKLRNiV
	 XpjLS5VQgzxkjSo2/lsC8fGBL3/qJWV24LldJTZaPGSJLunETlvOs4PY/oGGznpN6D
	 S2OOeih44olEqo0lKF5QbGlYWwbSO6RAoJ2B2/vku4maPrcdE0BYgPIK2cscdFZ4RT
	 BgcQQv5yyraUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A48B6406DE;
	Mon, 23 Nov 2026 15:06:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16F8F371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08A7980DD1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:06:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4rf0vlKt4wjr for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:06:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E84F380DCB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oyOTHgQR
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E84F380DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:06:11 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1889185f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 07:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795446369; x=1796051169;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vk+x2tK/cCaOWUi6lR/S9lxR0/6pkjAs8D7GsuYg6Ps=;
 b=oyOTHgQRrJSwnom4djrPeujPMOUjaBCOUgfiLv4Ci+yWQV4R54IRrLQv8C/n/fl8ra
 jmsFPl+MXo2gUXk+1TZXsbh9+SOzAboKITGWhQMqSwHNYxre5zFnTNNQThc+qqKOLAnp
 2W9WYEqgQ6511LGY1211ccHYmc8YfA7+jR9GBsX8G8dPmOX2hZ6GmCKX3AiKWhouT6sv
 wpOOWfsuco7nwrAf4mnWv2Ou3JHtfXBldw1ht/hsxnBt/2hG1DCPsbTi2FlXo2vAkOwt
 2oKvGFbYO/QKgU4R25zFirD79OqBZNPp79QY7vmugwUBx+O5qMyeZ3yclPI11ZpbgJN+
 agEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446369; x=1796051169;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vk+x2tK/cCaOWUi6lR/S9lxR0/6pkjAs8D7GsuYg6Ps=;
 b=o71CpPRxRcsoBibaofa7lorp1L9c8vFCsgGubjvCJ1lsv3ICGuhbi4whps6FNxet8f
 wyRoFTkl0J+82Hdf5GO2vrpT51G3IZpsMGT4SBjakUajemlo6oZpmnRRu+DiO0YHwdUF
 3+TEHUlbA4DcAGpJQlwmxnSvoF1Af0MHefWWJhtsnFK7c1Kih/K/KVkHRl8gP48JRZef
 IIl/hdVpDRbt5qqxwVj/lrhn8sj+G7OsqqzkDcpi30PEP878Iw+sILjGqVSNTyraZYiF
 EvtUuvsjDY4j7pn0hiLDZ7E78yO3bQg8/csQ3LdsTPJ+a02PdVkWbdSleJRieCt2wN90
 aEfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG21Fl+gqCmaon0Cvz5aZiy/mhztdp89vYyajuJQdY9OvhzEqUhQZPfc4zLR542z6tO0IA1AJI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9/k6VC/WrdXAutnohaf7J1dxm0phUtoYyhDiDTAJobAS1GkInB
 NL6gB2Y7I2DliVk3UpsUG+D4blw2J7/Upf+R/AlnhJD/AnpIMER1z2G12vfDLAr80NM=
X-Gm-Gg: AZFdTZc8OXweDM1zNVEiYHL0CEnUQBAfTe0v3PlWZWhr3sMbBRKVpKKEdq/BGv/gB2W
 QropxwmlYdLfL9C7UAQLTvM/WHZdh+Ea9I1Bmo/3Tc4tfEgTUmvbO4XO54StW+XLNE9yIyZTgdr
 SBkBhNcFsGZ8oyVTfEIrfJOJOg8wGRqOjDO74mJzc7fKR/Cq6QsDUIXjkX1b1uO2p6QRf/mCwD4
 23+Ju5PHwZZwXP5Vqwz0e4H32AdmQ49AO1zp7yhJjQAW12twIfogOYPyP6NBtWemRjA6uT9o7mX
 eEYjXOJiilvIsATYiQLZ+7DA3ODYX439PisE2E6D/N4VgTAlXhf0iQvzuS9i0bbZA70/C4SRhxJ
 7ayccTGUkRntihVO0jqJ0nZo13Wz90fTokIig0GOgeYRfozkloi6Jhq+5Lq2EWnmfLYEWetjYNC
 YfnAb2ukG0uugT06u7jYHvSSbtlTEycrLtbcQ3HfhJnhxnQns0wut70QxDMDpIzinKv9tfFJvkR
 DQdYnJx31IR7V9irKa0sT4N1EBW2Nh/MelwfWhSTr1Kq3Gsb9RKPizKX1hC0rP6WovKhSQIEXBf
 hcIADU/Ga7cOO1LCWKFl1kFGq5zVeOmQDrbyHnHx2w==
X-Received: by 2002:a5d:5f86:0:b0:4ac:f79a:28ab with SMTP id
 ffacd0b85a97d-4acf79a2aa2mr20517705f8f.8.1795446369429; 
 Mon, 23 Nov 2026 07:06:09 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:13e5:52ff:a219:e96b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm22756021f8f.41.2026.11.23.07.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:06:09 -0800 (PST)
Date: Mon, 23 Nov 2026 16:06:06 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 3/4] mmc: msm_sdhci: add HS400 DDR/SDC4 DLL calibration
Message-ID: <awRWXoh9NR0nb-ZP@linaro.org>
References: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
 <20261110114520.229480-4-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110114520.229480-4-aswin.murugan@oss.qualcomm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 05:15:19PM +0530, Aswin Murugan wrote:
> Add the SDC4 CM_DLL based DDR calibration sequence required for
> HS400, along with the HC_MCLK_SEL/HC_SELECT_IN mode switching needed
> to move the data path into HS400 timing once calibration completes.
> An optional qcom,ddr-config DT property can override the DDR
> configuration POR value.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

I would expect you need to check mmc->hs400_tuning during
execute_tuning() to properly tune for HS400 instead of HS200,
but these checks seem to be missing in your series? Linux has the
following:

	/*
	 * For HS400 tuning in HS200 timing requires:
	 * - select MCLK/2 in VENDOR_SPEC
	 * - program MCLK to 400MHz (or nearest supported) in GCC
	 */
	if (host->flags & SDHCI_HS400_TUNING) {
		sdhci_msm_hc_select_mode(host);
		msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
		host->flags &= ~SDHCI_HS400_TUNING;
	}

Thanks,
Stephan
