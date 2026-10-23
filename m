Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606F606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bfROvZ91;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ku18sddL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A283810E6;
	Fri, 23 Oct 2026 06:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r2Ypfib0jHHI; Fri, 23 Oct 2026 06:58:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F01A810EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792738700;
	b=Gv1WoOllVYhHJLR2Hd8sFe3Yq2tIlSyyIxvWR5aNZ0TvD4534fuaCXp/HjbKBn3qvHW3
	 MmHh82KNOO7BzVoaGt8eTMtAiegWNSEkqA2S5RqQH19y5rzxOYH6mbZuHv0R+mWQkBHQF
	 BBhKc9neAT5Rnw/rcxNKBdNKZBTvkMg3H3Jvo1nGQIIegQejCHPgE8I5kI9x+qI4A/mwg
	 g9Bv4g3nVT8Ry7TVw28ksJFxDPE9H1T3H7qRm0BBIFLnPAyiHIAYUQBhspDrMlHiAanJE
	 YUy1bUeGS0pVsoNfBTc2+Gw9NBW5hbTjn9qB8+NJp1aK9Zdrrj0G2nKKhwdCgzFMtLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792738700;
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
	bh=e6RO7rNeQyD4G4u9bJmFd7j7aDl+HFADWb/jT5hoi4M=;
	b=gQm70WKQP7tWTsspF1R/lzJdMykvwKQCLN3S3l4uDN/pFEwjqXq6xoT+y8fdYvZyb1j9
	 zdTBdxkutPSJANTtmpJQXbpNhXgepOKCFmoYc051AZ3n9jEyyX+97Pr+G2w43lmUNAkia
	 ZAZ6CfTTMeD4l1JsO7oGLpOWbWCtoD6/qRrbGNYjvKLHPlQyyZW3dP9EYXa7c3NQtctf0
	 Q5xPz6gTI+A81QLyVvumRolqX2DLrRrzquqhHi11pVBybek06frNSS4xsysdecWgAAShz
	 AqITCHrqXZXmRZ81x2EaGDsvZ5rQZ8X6VMBwTTaAitogpn6wVlRJkaTnNT1tH5obV5A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ku18sddL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792738700;
	bh=e6RO7rNeQyD4G4u9bJmFd7j7aDl+HFADWb/jT5hoi4M=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfROvZ91SLmaXSw//YYr8lCuratNKUX53h6XWaz69e1i3fjyzAnaIh8XF1ZzMsON4
	 FAQsmv93MBZCoi9l39vbHDaGBtVWjFmgXPrgIup6Ht4L8ttc9cKRWETmrPsnX1j6cy
	 h+7umabDsr8QU5Bsd6phZeEckUlydZCXY/wzpzc6Vm5UgWRcjezPYbiLhrCqeNvjwU
	 Gv3tPT+INU1429hDHtJa5sxwVATa3ziB3m4KkpuL/QczGesqZ9xfkMHAZ8mecVJ+Ju
	 cVYMRoNtLGeP8CzDDwMZJ5cGpfm03DHN69Vi/Ut4SmS+pNyjuMI6VUcd5QcFByxHqQ
	 m9FWHWacYsC7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F01A810EC;
	Fri, 23 Oct 2026 06:58:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F0F649D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48B67810EC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fmgkfk-P_nY2 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 06:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3D88810E6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792738698;
 b=MlETC/6rjofTN15m/3L1sjpEydtgK0m3bYeSOKZPtYy8l527E+J4dfrN2JQ6LzcFllaY
 vhJk5GH+7fDW869TWMOtoyWbnpZn0r2q+sYobHRfBg4kNBTeGWw6w/YfLFb6BM+e7/1/n
 yrb+34AtzJihPFdxB1EVIJYeMFkqLYu9SszONVBAmnzmJtNqC3L9fnaMZ34Cspo+OC3e8
 Pf0F24vUheRdquHKZltD6XQhM8uYsUiftDIN9YBgiL7KnB/Ikfn0wZ7yPQPhorWj18W5h
 DDX3n64B25BLG000t9LwuYic9YuZ3X3HlE5XL1CfNW6naWPB6fpp5krPeti97sbEQRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792738698;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=e6RO7rNeQyD4G4u9bJmFd7j7aDl+HFADWb/jT5hoi4M=;
 b=oKPnG3gvBCeAkFBeSlNtDIkCMJ5Wrgfyc9axetcteLcZ9/Jbs+UwbMZVsBrHLy30rGmH
 Ry66Pijria+mQjX4UK+QRC/bSHWlXU0KHQOEMWHAD6TGOuWt77xCusGMHQLzSypSbQRmG
 6yHN9ZXesDqZymID/rR/iQkNSWbTCaHLzB8h5egLr+OFcpP6Lks93cGULV9UgGTXek5BM
 1hR4kQeIRGs5X9FPzSeWz4IzegTXZgiEYARhNwEq4iu/LcwGqfxUY/X4evmmpXPkn1wou
 6BLlCQxjgRJIpUzDfsRzR+usLNBUHJf7p3gUg4H2oGiNL1fsthjd91L1caK53E5vQ3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ku18sddL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ku18sddL
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3D88810E6
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:58:16 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so225956f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792738695; x=1793343495;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e6RO7rNeQyD4G4u9bJmFd7j7aDl+HFADWb/jT5hoi4M=;
 b=Ku18sddLnzpcZyXOk9559Shmo/F3e/bHcTeoYSNWN3UK7W+kvrLpITq3yGqIWKkW9e
 UfPvzAJXWmzt//8pKvpxz3m/OEwz1oCKAP8OsdfIpBtIZDdBAQIIAcUJP8a7Cg4bhVHh
 i3hSx2USPMGmQ4IQ2ZVZbZ79KKQ4zV1ypiI1wGHuW7n5EioJTyxW94oDOOUCeKkkLds9
 RpMDEBQ/DEyopCiV0qE4NmVhpXvohhbMF1/9mnpSLSTZr8ERErUO23r2FWG98X37e8eC
 JqNXFcafYTsaiTMVrfWJrEUAAjTuT3wQIK0R/3MQ5lkFcFk2JgrPGco4ozfEVb8K48I2
 nomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792738695; x=1793343495;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6RO7rNeQyD4G4u9bJmFd7j7aDl+HFADWb/jT5hoi4M=;
 b=Iw8IUNYGGqJb4r3T0TRc544vUvMl47T0PhYcNSoC2QC6D55RnyboIRXe6fR2jKO0ty
 nBqFAbAIo/D2RddILMfLGmgnC0njj3gmBHMbM4VwmJZChrhx98/k5ZvLbiyIe7ZjID8P
 3ON2ecLHXtgVN7ITp6jZRsIyVSFDtEeNZZyNll99zE2ZZGaOrdrQBn/sSpn1uoJlB6Qw
 rQ5K0mfQ7LUYr3wrdtB3IKTOItoMeFn1SzJOCBhuQWtdrICNDmPfuWTqMwric9zvdjO2
 Sx/tUUWqoA+HUMwI0eOSfabPZebm4II1I1ioOfv4mzQGPEAFfFaGo4vxbIrvGKaXth9s
 vozg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjJeVEaJ7tQCwGVwkEHGhIGSA1Py60nEG6tr4bNMSoyINF0qYSlNjftNQ9t8uqRi2trrnWqqo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLDmjzoATmLVQujNEOSCuwew/jdTJjcoiNjx1He9aEGcJ/sn9pz
 FWGaSa97H/fpViMahGwC2w75BgdibuOTA1/GZz9x89zxIonkZvvsHq1O7tagMgskGbKsmw/XB9B
 wQ2Pf
X-Gm-Gg: AYBFou19uxOx2TT+xa9V6xtGCfn37AdzB6bZ6GMPBljb+siVauPgIT4J/M9JUNqxj65
 os71MYyIWkkuwEw6CmSwPiP+Sayf/B5qKkkMYvP+/cT1dFZwR9l0XF3YKhHiBxRYZPjBKsepJQn
 oPO3qf19MZLHMR4+rNDN7bbYgBE8qZtNgW8pt1E9HCl56xIEZtf2lXziCy+jAj+P3sMKIPbv18L
 QeqSAEX8RLz3BwNcgcuS9HqkrMgO0ecdcvao+cKhaG9cmr3BUAp3Jpvnr49Blu1W8dKEc5zMnBP
 9onoR5bAbFupxkjbpuLQB5i0OvPBey5dURqB19ThCW77FJhAU+MduiqAvFH4BAhcaMoFGO2MqRV
 6rpJlTk3n8k37Y2NiQv2y+Wx64k3R+anHHgYqmqAAVre0yS3ouxqVuJAjR7pO14p/DHKpWrd4WX
 emZ2KI+lXy3GFEQUH/yYTOsZOLjMkSG6K3FLbC33611FUF0trlaO+lRol5tuXXRxhdObc3FXV0D
 rbdWbVIjAsab1yVU1No7Ie03wGf7KHw76QT8q33GKfwCookOcKO2sif/7/K8HasgQ+IA5XIhW+9
 9g==
X-Received: by 2002:a5d:5d86:0:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-48e385ab429mr1759382f8f.24.1792738694615; 
 Thu, 22 Oct 2026 23:58:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38053b8asm2845663f8f.42.2026.10.22.23.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:58:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 4/5] fastboot: add flashing
 lock/unlock/get_unlock_ability
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261022-upstream-avb_lock_unlock_b4-v4-4-f4926ca925e7@oss.qualcomm.com>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
 <20261022-upstream-avb_lock_unlock_b4-v4-4-f4926ca925e7@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 08:58:11 +0200
Message-Id: <179273869150.1490556.10316068488188699878.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792738693; l=692;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=AKormEMyJA2s7fyyyCD7s+EFtbgLuhtG1qchK1DRe8E=;
 b=0avjgAcXfW5qmsULDBmS6tiMWgJ0BvH1LBFavitTYIv6DXaBU81BSNRsvZ/TA9NQ1HXt6Ubel
 OaYuAnMTtQbAEXcgMre5lKid+j6phv4J8bY88Pdej1o1sZtAXodWB2V
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 21:04:45 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> Android's fastboot client changes the device lock state with
> "fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
> first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used by
> the "avb lock/unlock" shell commands) but no fastboot front end for it, so
> a device could only be unlocked from the serial console. The state also
> had no effect on fastboot: a locked device still accepted "flash",
> "erase", "boot" and the oem commands.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
