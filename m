Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70833C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 018E960625;
	Fri, 11 Sep 2026 16:51:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSOFFCpABJ8P; Fri, 11 Sep 2026 16:51:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 507AF606C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145468;
	b=oJkM08f9XKbC95Jg2BTdgKWrVR3OhwJZ4EdS4lfGimb6lsB+fCMRhOScacfzjsyNMxVJ
	 sjlvxFdk5eUcmrRbBKeqfuIxC3SdWrgb6oy/a0a3cdf+yTxdYIoOMXuRG7AnMCsiWb3q0
	 K7d7KP3ECj2PIEMzqxNXwo2/0wrvgPlh8SpTCQJVPRWQ8kezVqRE+pLZUXSH/1wDqvWh0
	 fqVYH/xZnjvdj7+5k9ayyT9B8J4jsj4oCc97oTUkXAg2b4xdSNri4TXNkeML7G0CXlFHV
	 0KS8S5nPHQNCJsawcbxwZENTFCTgWkLXyNryc4ukKdIyIhPD38pydcfkb2ZdU8oE7bQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Nn3gQUsxhRA8NuclbIPTSAq08ExZbl34/Zoh448c1GM=;
	b=LtIZuUlHdi8kWnI855VhlWupD27jJV+0aEO9IBC+QTsn3LwhSixTCG51D6GjybcOIyIs
	 gQ8Msl2S3fJOC/EyuKn46ZOn5LR7iyL1eatDZe+uCMagwijxcyAZ2+UD2y7h+g6NaHAOo
	 TGMq1ETbvU+QJz3TLjGdK/TTXnap9I24j7KNO5lQZy1Kbuab9rKGo8TZGsKrm/oIWbais
	 orBCFV9z/4gu5nDko9OAIXZMmDbDQDWffNSaW1Fu84tbzd/MU0QNlKnwye0jlxeFY8yQf
	 2LWNAE0zQM8Iuec5Dyjy/iwUigGyLf31W8fmq47fj7skFmeaxIfAtb6lb8BItzVmOOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VRm3aSTa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789145468;
	bh=Nn3gQUsxhRA8NuclbIPTSAq08ExZbl34/Zoh448c1GM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CuZWFFKxNRsCZG4lz4PoM/AF3jlXn9CD4TS2/CDtxExC7ScVmGUNPzqMxbzzqAmzT
	 96RkDZwZJfJu2eLeve3jNSNmcEiZRgDXMw3Ca+vLhl2tNhhW4VzTKrAkI36RvAHD0r
	 E5JLK5bdeKZo93zUbsPoePwelcdzv0IK4lwsh1AU0jTkt3FqTCiKIgTbNt8nYxNUuE
	 kdSJFlCyKwfWdkcBKil3D5FKDm/7DRfdzZPd89rxLKZfEcg7MQsG/jJx8vm738MfNm
	 f/bapjW2PSeC5cW3zWeMuFCxuqOLyWkrE0Ql6rKLTeB4rwYw4KfGEcIGKP+u757DLc
	 7muIucP8cmvdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 507AF606C0;
	Fri, 11 Sep 2026 16:51:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 909EE14C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8261160625
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uFMaxaUj7my1 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BF25F605F8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145465;
 b=bEV+Rb24/14SU/CGUsAn3yXBh+VI3KHwqaUiB9Hbi4YSnsJakQeukU5sn650+B8W/f2Z
 XUwcgxIFHblMW2vUJwu/xMkOIiQhoOCdHO3eEaUpe+oYFfzNOcFQmX0XPbhaS/0UsiB7C
 Y4hUz4LcrBnI4bD0RPtbxYuiYlsmWDhV9G2LUqKNRJAuEOoCsbJ4C+SkYL6Z+zXWdhKWM
 Aj4accAP8QgI+ZJTRz6PaUTrYiSVcPTuEl9sBK7xPcqvN81pAErKtPYmI2o7fRbsNbHle
 afYmlc3AOxq9YN/cwqI4IRkKiplXhCIl+ZMOoexOukNtDLxB8TYVMTZ6CShqljPXohA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145465;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Nn3gQUsxhRA8NuclbIPTSAq08ExZbl34/Zoh448c1GM=;
 b=iq16Pvkw4Q9t3KzpfN7JAbAAl5XV/vys6ALKZIes96R1TpPxlIRFJmoZuy+2Xwy14thO
 RiIfwh/7LwL2asZoXG7HWcFJhemrFSuQD/kflYugEt9+TyP30Pwm+S6zKHpAmkiYYrLcV
 g3qsoXgH+l21lAZFhMIY5PTBBUFuolbE9cF2/VtFFiOdzSZQ1gyDDmnWlYNVXpcgBVtmm
 qtl/z5OgJIVEkdymbzznfxpYVfPllKIBlKLDl/oQBmAAgyquzhPh8zsq2tSWsah80K9TY
 7WepbAMZ+Jcv3xvoLKaMGeCk+hYBlPx0Fk4GPZGEuBiTLrGRilSTq7X3czSTDypiNAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VRm3aSTa; 
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VRm3aSTa
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF25F605F8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:04 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-46f53c8a5fbso424668fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789145463; x=1789750263;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nn3gQUsxhRA8NuclbIPTSAq08ExZbl34/Zoh448c1GM=;
 b=VRm3aSTa3E5kwryVtM9Sq0Up0bQuXCO7+CuAA3Xfw5IWVledRwOdo75sTHAkpHuD78
 NtTR8XUztkxgbHdjpZd+O0Jj/Dy/AvWZ+D/3dokIxCuFwj2Pjr9/RL/Xr+0U0phnU7F9
 /Of2010Uh9E9pgay5l4x6Er260gOc4avQbuuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789145463; x=1789750263;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nn3gQUsxhRA8NuclbIPTSAq08ExZbl34/Zoh448c1GM=;
 b=YBGaeUcCFCSJIBM7sFLKDKHBr6U8FK0RcjS/ncUOqACK2Yuq/LCl8iMVn7NT8UCOaZ
 lclPWwt6KT0ywry4hVhY9Np6hM+J3t3GIjwM2zCCqxfK50aoATZJ5A6xgboAuO1AK/nS
 zCu0p8yGhyOWSUtpipixNrylYHxdhOhK25KYx7BxLvJfqCf8vwLvloazdjNpub9lyZf4
 i7ugIi1SbZSFJvMOJ86JnCsbj59jsUwNZisszrvt1q1kmb3+nD4xIHQkdfCzlDwo1sj7
 Ibn9tFixFfdkX/5XApiqBMqWDYTHfRJlUSWRwCjkTBr9vOmdd8P5R8bax7t/ZwaYAjhZ
 3XiA==
X-Gm-Message-State: AFuF++mmFrPcaiH/53uJ+yzs2eYeb8eONswnVrVNKCnGUw84jWmAflgH
 5xon5ln6Qx/rsw7R2N3HMo/0sIPJ3vYmdxhX/qcjZjzBi4s38VbJWPbF4L/ZeUYEOAujbkNRH9O
 BxDVAFlHwcJyl
X-Gm-Gg: AYBFou2ji2Nw+j2vRtx/Fgl1hDIIGLpG7KB0fsMBbpTMGvQFvmPnBwyKrKCWKg6ko/B
 cO7Hbhl4hyKoCIm/Ou1VjSuYq7mgunBcGv0WE3utDFTp9Y5mIDyijpZ5dEm+pCn/avu4NyXjj48
 3kua/4Jp57XfQ/TJiCtQZDxUmjZ80sLoZ/qZBUxtdFQLDXRf0FiH2W6YqZn7mPQbkfxTRWToxeF
 O92nDUWT6th2dLfNMdKIEqa+8EahoIqhkIdX9K8PGY/wqavsS76Mk1GdOSvBn7/Y+4H06BmpHLF
 UQyjKFmsZRgPCZnB/59t5VLzEJr6V90yniLd5GeeREpyxMQ6DahyQiyJ1opjwbwXjC1wPoguCI2
 sfzxG3jrnAoI4FB+pn0d1WuDpXjmaOBQ5mZ/oJv2XlRF/tuDVX9P4ldq9LqnJZlsFwiUsNQAXz0
 EbwPIyBO4teMhB0TbSksRZGbtvWAkW7O+ot/txaA51mseYCBRlAjzWWqoYyAA2fwn85dMkIrKX7
 HwZOAAgu+Zgncaf5EmP9BB12qlfZKVsi+6ujyYUflf0bn1tvbOwQMuN+Yp1GS/QvKg8Ee2j7Spb
 crPYvLmdSDJLEYZInRNGFi/T5RIwoQ==
X-Received: by 2002:a05:6820:55da:20b0:6b7:46e9:96fb with SMTP id
 006d021491bc7-6c0bc3cd300mr2642700eaf.43.1789145463543; 
 Fri, 11 Sep 2026 09:51:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c09a220714sm3186402eaf.10.2026.09.11.09.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:51:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260904185352.2953962-1-trini@konsulko.com>
References: <20260904185352.2953962-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: am33xx: Default to enabling LTO
Message-Id: <178914546274.3764906.8164487864426266235.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 10:51:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 04 Sep 2026 12:53:52 -0600, Tom Rini wrote:

> These platforms now sometimes trip up the size limits on SPL, when
> adding bug fixes or similar to the code. Enabling LTO gives us more size
> back without sacrificing functionality. Run-time tested on a Beaglebone
> Black.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: am33xx: Default to enabling LTO
      commit: 69af8117d21e1d8e52792cd08b2d895194af9d18
-- 
Tom


