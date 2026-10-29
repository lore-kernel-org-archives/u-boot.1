Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B6606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gd6zrtrL;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VCFZAWVI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A800810A2;
	Thu, 29 Oct 2026 22:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lKtNwGevr_YB; Thu, 29 Oct 2026 22:18:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69478810B1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312298;
	b=hiiV/pRulq9PY95rC/IlXZVlX5W/w3IW95gtOYVzi2UfUgDW1kdSXaPFP7fq3/f31lRu
	 ZV1uqg2tipvDthjpWs+New53tGvyR//Y8VR+JM8ZLS3SjoGxwEnhPUm+vzdpfbX6AmjNz
	 3ZzXCZm23/8j8+9I42RofHju4Gq9Xv0VvUVqt+FG6juIs5rA8IP/YhE5CWDnETTcRK3Ia
	 3wm4qhTjJh4L+/clv6yHH01Ue8ahJj1ZRN6c2ADTWFYRN7Rv+JytvDu0oX6rZN1MsqX0n
	 INS6M5g8n2gik03qlMdYegRAbey2GsF3ZJaCC6xz0cNyAFxTySHq3mGuahPFp0NRNuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eo1wxwBKuTN1fPnouq9XapJe+8+6SpacTadtL3fVVOY=;
	b=lI/bM+dDM+FgTt5/HOKltl3YjEwnNR5EakdP2lhanKTBaajznBmKes/zeBmwUBK58DP8
	 oNWEYALSc7rNGZJDjqyB2L5/pGX+QfjXElJl9VETR9HFXTywWmgaHWY9EVtHkwgyM+QB7
	 FwhRKuSOPSuPqYlKO9wtU5rMfU+OgdMco1YE3V9hAviFnwxmM+9gl+tGKYPZa1ge6pNGg
	 BneYOEikbomeXn73mU14WC5fmbUBDARdCcjjKu/VFu09z2ZFv1UD4cY4Sc5vXwNrFpcj3
	 j8F7SbI6LDmEihOGmNyLYS8MNIuBjHei7xfy/hlyYXBSN/f6VAPNG1PJWw4bKsUAwwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VCFZAWVI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312298;
	bh=eo1wxwBKuTN1fPnouq9XapJe+8+6SpacTadtL3fVVOY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gd6zrtrLIyFJrPsyj9rmRI/MsEYZ/9mBhzxLA9E1jrKvt7vmCSNvSNYap1h6Eijwn
	 Z1H6Wx8UUuTFgM/mVXasDnMM26AZB44R7Vn0rmZJZgrbkGMok6cxVORMpqbCSwzlAA
	 TSSpBxeaDDWJwuqmUtLDGHssP+5CZsD8dsVPc6z+p9wcWpGhVRbLmIoDi5+jmJdlYz
	 LqxuPwPKRaxfuMYZs2NMGzE44YTsiu+hzFJjZj0LBt1ezJnUc/AwAQEQkcXoCJFxd2
	 iBky+gzleLCg/6fO+uTyBrn8yCd6W2G+tFW+fck6/F6rWv2OAs0/0vdI0G1lWblOT9
	 dSUbL8w0HvUlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69478810B1;
	Thu, 29 Oct 2026 22:18:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C59342E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B641781090
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vp0fPn6QJYhV for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:18:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 181E08108A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312280;
 b=qDPU7/mgIVM7ZtJKV/64B4624vxWfGAhsgUZ5NP3jRsTcQEZQViUWHAAD2GOnhAG/TuW
 z4dsirYI2dwlGGQiRR9qkCNl26S5UTOecah0BAI5D94YouWl2EsXTj5hUlpD9nTf+de+r
 fmmIVkfNTVa7YaQnO1t/u4YdTGX/xrFGKg4EDlBpDuEv2CywEs9TOr/z0S3QFKo1Q2om/
 NTOwRNqREab8FbSD0smHTFfJWCKPf7In7VTbtL2hrf1ocHN3fDnQgVldVdtNupCSSJuVM
 aVELsYPa3oztkPBSOwQm9vbeuaCtdGwNEvCEVks6AfDSap5tzs//gvmPWd53gH89Kow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312280;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=eo1wxwBKuTN1fPnouq9XapJe+8+6SpacTadtL3fVVOY=;
 b=lSeV1P2xSC/6Ak0pmGRyKYmw3RYLMzkyP9hWfrIkUXME2YNpxo2pQduX2E3qI+QO5fZr
 ZNB7lzrHDeDAw7o1XwI7gHYM0r+hZ7WrFmdfyfHzjju5/ctGB9TsgaozglRtIPuZ0DCxl
 VPTzoQYKtmPicuw2+9PdLMLXHIGd77WoHe7sb/MShJ/dSBLJYYd1lj60XVZuArjdwV+8x
 V49gCx9+nvB94AjJSOs8eLmXeq/nmNkVeth76fs8woOUjuxNxkVGjOJnX0Nr2BIghhQYR
 qgjSI/avgnzcqdpv8yjUScnWapUr7MdO44voXcoFr5Gurieah28Cq1R9f/kiaRy2Uvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VCFZAWVI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VCFZAWVI
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 181E08108A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:59 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-55c05f69296so24209b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793312278; x=1793917078;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eo1wxwBKuTN1fPnouq9XapJe+8+6SpacTadtL3fVVOY=;
 b=VCFZAWVIKbg6VReXthst25qbQkYmoKCyz0pJpjMENFPMn7dB6Fn2LZEpA9ruwz3MFc
 wkl/IUVv/nzP1lMbskw2rAD/g1Ru+qcdt2vXhfnTh8kbfQR/gkuu0hA9PoLIq4MtYqri
 coYkPCOj/IWIrQ0fBfb4X8bCiu7GztrxoqSq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312278; x=1793917078;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eo1wxwBKuTN1fPnouq9XapJe+8+6SpacTadtL3fVVOY=;
 b=HmsPat8ymHlXTEKJDqNNDyzIp8qLE26wqA8ij8H4tuGtF5NtY5YCLge72LaHeYHIJC
 c3GWOgxsj9fDbkXabkXeOcKey5Xyh700Oh61CvzGQmJe3hHV+ywN0g/OtE8/vPNPOgqG
 Ss32zAZX9knpTA469cW35vWcE9KGzd3CMUD9Jj6yd9Sbd0tS61YHfgTkPOPo9HYih2ch
 C1BNT57UDwg/cnwYWO/dETzeISjshymIstxC0/TmnD5sos/PQaaynI7dbJ/dfTv+9bl2
 dED7uyneJseLAaVwMC1VdsPuALGZ3lpz/pQXFVv9//Kg+DcA7ySnaw/vjmejv5gwELW7
 80dQ==
X-Gm-Message-State: AFq9FYK8iodgQZcNyBQB1kKEOS3ZZ+Jw8oz1tiFxBmrRzgMmruDTvieO
 oGJTTk+DEiK36sgDiLKiiiV3OlPSeM+IOfnhdv6+0C/9r1jwgx02FdQRfBmifg6HgvY=
X-Gm-Gg: AYBFou3N6SmzLZSWZ1xvoGFuTKGDa7gM1f22xsEHG4lD86kIpMB9iEkuzpPdFh33NQm
 fVRXgXc+DNsdE8h4SLV87gHQrd7uc4rLUC3OERp8eQ45Rh1bAOmzrLx2poAHGtOkFl9Cu09B7Jc
 Gkngt5fyMYjWd/J/8upcFRt/AR6ysTHLoFjo+Bho1WRY48CaY9eiT8etpupkwsQDrLaA8/qvjxk
 Et50uPEKqUxvf71Sf7AjwLrSVKw+qpnQF5musR6hb7qv4GN/sNWd5nkZWcnk5F/KpyhwJtB6mnh
 yw1UPgIR3jqJx+53wYekJDZW8OFzKChRomYkOo+cNtg0kTMuxoud72zWwzoNEKt+TuctFxsvl77
 Am7K025j7qinWhFxri/FR/25IbbfkowzoUSApNCvAMVtp2aV/upDAfQKFMeruvlp0scQVh4mlMl
 bRAl9Ti9RlSycLkfeO6rvz1kvDCgIflgmK/fTaEaswX85IU/aBsDh+9M37ld+uXYqPJp3IDjAl5
 ajlpW9wic4puEMg+SSFfJ6W9DgpK1U0FBsX3UR5acUc07rYeZXDq4yWx92yUYkUc4py/MvYs6k+
 zOD9zDTKCsjBz0bJoMU303TiePaBievmyMV7FRUcsd7Iz0I2ZuGjTYVKLnxtwjLn052o+QCxWuI
 qlZLf5piJu4M5HZtFN0XEZzyWQQErBtXoa4cW0mtoipgu+lmZ+z2iABvLdmsIiNNKuyAlM713dH
 CCZS5gh8VbAWClD6EvJy34Uuams6hArw==
X-Received: by 2002:a05:6809:391:20b0:4b3:98f4:f057 with SMTP id
 5614622812f47-5640d919f6emr401671b6e.3.1793312278511; 
 Thu, 29 Oct 2026 15:17:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4ea68sm119005fac.6.2026.10.29.15.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:17:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <20261014-wday-v1-1-d6a45cdf7c5f@arm.com>
References: <20261014-wday-v1-1-d6a45cdf7c5f@arm.com>
Subject: Re: [PATCH] lib/date: prevent out-of-bound read in rtc_calc_weekday()
Message-Id: <179331227776.3078583.5472999146729088517.b4-ty@konsulko.com>
Date: Thu, 29 Oct 2026 16:17:57 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 19:47:16 +0200, Vincent Stehlé wrote:

> Depending on its input structure's tm_mon field value, the
> rtc_calc_weekday() function may read the month_offset[] array it uses
> for its computations out of its bounds.
> Verify tm_mon on input to prevent that.
> 
> While at it, change the month_offset[] array to const as it is only
> read, and fix a typo and adjust the return code in the function's
> documentation.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] lib/date: prevent out-of-bound read in rtc_calc_weekday()
      commit: 3a379940d10804feee0c73fb013143b0ee2ed473
-- 
Tom


