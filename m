Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C39606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IzpBYz1m;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UhQKP4cq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A87C80F3A;
	Sun,  1 Nov 2026 11:18:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9XJaFfC3Ody; Sun,  1 Nov 2026 11:18:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1339180F26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793531892;
	b=ANaMXideIFAWmf6hSArHVhucFVAtA6qalGjnJUleqdR64FfphNtFYcXMXK7UR17INGoh
	 QmQNZrRv/2P1Httw7NW4oTxhMNF1O3z1A/Kl8Uq9LYk4C6Y24tq0cyhDPB2BxssSW5y5L
	 jAj0e7QDSQpVwqpJcU1AqCRmOxcbaLPzBeaVNUxzEnhuyfoY0o0PLGRtZDh931vFLMS8M
	 nvTZBnzdtluzGRxIHZbT3KhwhZVKSfAZcBxx4z7MjASlSI/5Biq6ZhV2al5ntYFbRabAS
	 hl5pefB5+YrTYrl/uenRZ+7fnbZiWjPRv91a8APKD8ra+1sbPonFXP3kOCGMRLaR5tA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793531892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zTIHCZD6hFFeLnykJnuZ5E+jX78LK/ZT/tw8q4nyVcA=;
	b=bOOYL36QlAo3VwosFPOKBNMAlnD/cVfh++hggmGGNZhm51fBM90BVHdpXhODODY5rGt4
	 O/AEdngRA8yySG06kFXe5+YZ1WOAeLOvChqDpg/NnlIniaNoHmBdNJHHupRMeAZIkI2kK
	 eErQVO9W5F6FtaRBtzF8yPhFqEuasDdAbf0v6Ia4lSDf/gYwxzwsvJg9Q9ItXBCBm8XgU
	 Q7TrVYJVlCDH6VfzM3KjZyURLBaUkTin5P+tIMNArkSUAMaOvAh+Z/G8f7vmtc/yz+4cH
	 cYj+KhhH0TBkCMHmkhvJ4KOUaJDc30YOu2Qq+VWnbBOJmy2QGQ321+oO2AMu4u/PIOQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UhQKP4cq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793531892;
	bh=zTIHCZD6hFFeLnykJnuZ5E+jX78LK/ZT/tw8q4nyVcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IzpBYz1mVHN3YiLwcxJA8EUICqrSRB+5Xh9gimaht5HSuJ9C3zhTvB2bmsjw/5HvB
	 f99kKQ3wRkvItoIm4xOVaN7bH/whcK+eS8DBf3qZpxasux0s9N9WwW0A3eqhyxK5EL
	 tjxJ5jdm88PLDpBpNIOVtJoDkkReE1CK5UpXdTjUuKnhJ7rfjZbsSpLflcuHycUz5i
	 mFtzseAYGE5pFnHTQkn2fZkIkyUGTHrvIeOdQgMKqlc8YAwonewq9s4LTEfLAo8QtI
	 9/TAXQGvf54s1Ky7yTQLsTqAUxI4gEVqPuv387KHtnwO4iFUb0WbJUGGK3HcZw45Pd
	 rx4U3R+SG6BcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1339180F26;
	Sun,  1 Nov 2026 11:18:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6582E4BC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6293A80E3F
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KeTqVAK3hDPz for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 11:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28C4880F26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793531889;
 b=UhTeZwq5bse1zk+jbgHO/ceHlnT1IXvqAqXSer4LzofkKWyptvz7G9I/QzFKFBlwWKuo
 4ONo0znHCoWz/7wzDBQmn+mEFlDdwhoZjwkVjEzT1D4YdKYFbi6pBIzkDntrxVyYbB9xr
 zCwsFYtdTpLWghxuA1nWuU24Rv5FLiHXQsiazBNZ13IYAn3+wY57UbWCcVXdznWgN3g6H
 Ogw+CCYB//yBi6HWQmgf0EaMlE91ozHXtRXwqPocbfPQZI5ub44/6ZyiLAdwTPok+3O1r
 LUu9WsZsO/jsC3SrwNdb9CGng0daYVXJGUCHE+F6t7vChuH9ZBJZoR610YoXUegMmyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793531889;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=zTIHCZD6hFFeLnykJnuZ5E+jX78LK/ZT/tw8q4nyVcA=;
 b=PoELMZdw98K4LVkjW//ZcvuPXNrqDtJ6HNoqtyk7nwXu4QUUbH1nH7GyTZc4ZB1eslBI
 +FyCfMMKqvkLKs8IpyUxWWM1rYleA2T6c9thQ669fCnj+dV88Kyo0Zd3q1YqxSE6ghNkA
 DPajvfuZ3Zfe9S2ABfcuYn91tVDyQA0V6LZXcVvDvRyMBD3XIJLfamahzPDpAJ4dxCru9
 +csO0lmZRveOSDO7BRTYe39/8S82Io80OXcxKaI+zSs2UJV6Y/zqEF+ItlgY5+ccqglYg
 T+zAwhtSlOgvMJ+SMofhKlexVA4pD+6K5Gh/FgNCYh575DVZrDmZIhzBihmreJmZv9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UhQKP4cq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UhQKP4cq
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28C4880F26
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:18:08 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso17735307b3.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 03:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793531887; cv=none;
 d=google.com; s=arc-20260327;
 b=hOUMoCtRsHP+LLDjQEYhVR0b8jTJa2QLA8/km0MFIVoZHVXQ6yq4iY5We5yzi7RSy5
 rov4sGh9mPOUTwd1IH51JdoGxrNyu7LUlOpzmqV5/FUrpGaUDpSFZOPhoymbSqsKgsn2
 0r3K92ZzzmZABDbaWaNfk/K8pC2y5NeTjWimxCqClJc/5PbAnTKlDYJM/uTxP32o5IVh
 Qtee17+v4nTfw/+xHxv+rNPF4OnwQcYtumVFt/9fgGHD7VoGhhLAhlc3ukNbwgPPqmrv
 MGpw0/D+ujWTM11zL6icnr5gXmiMAswHz1raw83KSXTOV/GfBXv8hUO2j4i8CnBd9K3Q
 rf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zTIHCZD6hFFeLnykJnuZ5E+jX78LK/ZT/tw8q4nyVcA=;
 fh=W8/f/M9jxjUraLqdVrNjjZeASRCwT0Jex7TG+FXiP8w=;
 b=iVKaNa5Y3mkSJ+781gjW2jooF+5ucLx9L1ClrSQkdY/lQzaoGpYM5FOASZ6d8IfEJf
 h92RIg4k/1EQVafaXE5kaNGr22yn/izDLruphHthMbymVa/7QrBP8bAXmDYf6SCV1f56
 9gLtCRuOveKTUv6xXo4J+pzbEyRq304OxB4scGgpLDsiVAbxAZNiJCohz0UoJB4V4cQt
 WINNQ3OoPHFnp4AON8+H5oobrMN2+Q2O4olHvssn5+ZnSobe/gT1z26rHnXgPyR1JZw7
 d/Gtsh1qg6XZoKwZpDhsbg6rz9iCqe/82uvn/MLG8zXIl4mtfvO/Gqn1+idaEyYAtrnU
 6WbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793531887; x=1794136687;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zTIHCZD6hFFeLnykJnuZ5E+jX78LK/ZT/tw8q4nyVcA=;
 b=UhQKP4cqLXBun2FRgvK3NleMuHodgYF18Mv+Ji9X94GRhnS3ClB+RpJPG+niBsH2hF
 82Gf91dISC6BLklHix/hyzJcKP3gBN+UvqqPC9vuqGQusQ8iJe8aAEBzsrQEEjR8pOiH
 xsXCEJdRr/AhTo/9Y9oSsQmXkTt6d0FftGwwQ9WLau62OzPZRLdFcaZBGjSzvBgR+o1+
 sCs16zPDEtkG1oJkJHoUgttDnRiiEFar3qphBwRU4VSBxc8jfwNKonjrbc+buRUqjXLJ
 UKWcPPdiiuugYP9nHEaxoCt/EClpgn8uudDTOh26IOHLbxyGjWNfcUFn11Z7x7EF93SV
 qmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793531887; x=1794136687;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zTIHCZD6hFFeLnykJnuZ5E+jX78LK/ZT/tw8q4nyVcA=;
 b=cT5a06d7/z3pj6WQg8lShuu02icq9wTTNI7J6vDix9qGoqpmuhNj6Kod0jBIGeK1sM
 KLhBr0d9nyTacfd+sHzfBFVk1smb+oC7u5nhqBA4ik2ynQ/7EPmeLyOUMxOBMX98R2jv
 ThaBxqKu69xl1aGAVZme2lL+ep8Z23WIvBhZqTOkr13a7uuDbfbePRPM/bPoWTs4cWIV
 z4ssF7NSJrk7HFFbgmIYNbLz2Sov9I3FDuPktLo9NnDBlxbOs/ckPL8P1yXV7H0BWZSh
 AOiET5lGw2MiaVUIGmWs5/NN+l0fKSQCVWQ/R5hYwUMIBsuz6lXaj2aPqsYpaaqfRk3i
 kLbQ==
X-Gm-Message-State: APuU4Z+PYCYVexJZpwpZuuvwjRzxj2Uak1kZQrX0ef3YfQT+xa/3/qwt
 tZUD8T8dF4i+EBq2gqWYlL4ur8IadZMobmz+xaiUhVX2FIePisdAs6ocRYYnPW9pdQoIRARR1a3
 UvB+V7nJixXBdcwdyzuL4voBD2FtjC44PDfGQ94hj6OlZHPcGYndfxwwm5w==
X-Gm-Gg: AYBFou3pLi8El/y4ehiUm2SWIA+cnhNBjdFz4wHoLrwVHo2yTzrIUwWqPp7b8Siz0UY
 0WiwwzPB6dQa+rtSeCs66uNoaDclWqu7egJivGXlLIhNjeGbaqxYzGV6YFQzX86Udo/DEN1weMY
 SSGUnF5VhlS3JgZ+gdbClUS82cST3R2V0yCVlc4juhgWXLm6CN5u28t9hFlUHzTxrabFUVbqc9I
 PiNsSK1SGZcgdh3vVsrcbN4LKBGd0FBoLYdk2LE2Np0OeH6Bv+KJSs7EOTsEhPcluFZVViWKDBQ
 tjJl8SdDRSOMsiWGiME/YWk+0NKzPrWwLizsskLGJcdS0Z5i+fT3te2aMGGBLtF80bjxqEVYOGV
 LUh8TNaoYeldZ1dP/A8C/4FVpJQbX5ZBD76yLItdETzohPvugw0umLycFL+l3Tfl2i7ej12hPf0
 pNI+lWeUamzfy2lfm44FwlH2oLuNMO82ii/usg3m2fLMny5KxSRdsiwfYiZqiO0m+NQXTuetL5V
 G/b0acpqu5SyrcknOGFqc4Zd4ldbCxz3CqNQnLaC7/rsTMvwsxLPH4LTtvOVD1asYIXpwE1dGQv
 KvjRKBfCnEwdkunKXpJgO2Hh2BXfZdo92a1GMbpand8+1Q1+BAnn9bV9hJ8CZrJaaSf3SieTHXB
 W5q+x/j93Z1PAeMfcdj8HYp4Kc/pPa/UVk4UnG26nKQsa/WFu2lo9IJH1ycv+4hZh95oCY1ncbn
 pPXnu7wInmawl43qdhCK1Y7hbyAdZGG0DgR+E=
X-Received: by 2002:a05:690c:68a:b0:8b0:aba3:a3e2 with SMTP id
 00721157ae682-8b2b671ae36mr52178127b3.37.1793531887189; Sun, 01 Nov 2026
 03:18:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
 <20261029-upstream-optee_rpmb_b4-v4-1-e2e4c5330d37@oss.qualcomm.com>
In-Reply-To: <20261029-upstream-optee_rpmb_b4-v4-1-e2e4c5330d37@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 1 Nov 2026 13:17:31 +0200
X-Gm-Features: AclHuK-j6IldxhcLFvB7CK9BXEYSQ8U6PLEtUv7J_YOEg4xH3imueTOZuqcjdjE
Message-ID: <CAC_iWjJDzJVM_5MfXhbmGEPpqQLXRV+Nbt=zSn2mxkGkz33ARQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] optee: rpmb: select the RPMB partition per request
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Igor,

On Thu, 29 Oct 2026 at 17:45, Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> The supplicant switched the eMMC to the RPMB hardware partition when the
> device was first used and only switched back when the OP-TEE session was
> released.
>  Between two RPMB requests other users of the same device switch
> it back to the user area: libavb does so for every partition read while
> verifying a chain, and the Android bootmeth reads boot/vendor_boot right
> after verification.

I am not sure I understand the bug here.  do_call_with_arg() calls
optee_suppl_rpmb_release() everytime we return from optee which calls
release_mmc(). Jan introduced a nested call on that that would explain
the bug?

>
> With RPMB left selected those reads hit the RPMB partition, and the next
> RPMB frames were routed to whatever partition the other user left
> selected, which ends in status timeouts and I/O errors (seen with
> the AVB TA on QEMU's emulated eMMC).
>
> Select the RPMB partition around every data request and restore the
> previously selected partition afterwards.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/tee/optee/rpmb_emmc.c | 88 +++++++++++++++++++++++++------------------
>  1 file changed, 52 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_emmc.c
> index 7ae6045511b..d4abc48f764 100644
> --- a/drivers/tee/optee/rpmb_emmc.c
> +++ b/drivers/tee/optee/rpmb_emmc.c
> @@ -42,51 +42,55 @@ struct rpmb_dev_info {
>
>  static void release_mmc(struct optee_private *priv)
>  {
> -       int rc;
> -
>         if (!priv->rpmb_mmc)
>                 return;
>
> -       rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> -                                     priv->rpmb_original_part);
> -       if (rc)
> -               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> -                     __func__, rc);
> -
>         priv->rpmb_mmc = NULL;
>  }
>
> +/*
> + * The RPMB hardware partition is selected for the duration of a single
> + * request only. Between two requests other users of the same eMMC, for
> + * instance libavb reading the user area while verifying a chain of
> + * partitions, switch the device back to the user area. Keeping RPMB
> + * selected across requests would make those reads, and the following RPMB
> + * frames, hit the wrong partition. get_mmc() therefore selects the RPMB
> + * partition on every call, and restore_part() puts the previous one back
> + * once the frames have been routed.
> + */
>  static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
>  {
>         struct mmc *mmc;
>         int rc;
>
> -       if (priv->rpmb_mmc && priv->rpmb_dev_id == dev_id)
> -               return priv->rpmb_mmc;
> +       if (!priv->rpmb_mmc || priv->rpmb_dev_id != dev_id) {
> +               release_mmc(priv);
>
> -       release_mmc(priv);
> +               mmc = find_mmc_device(dev_id);
> +               if (!mmc) {
> +                       debug("Cannot find RPMB device\n");
> +                       return NULL;
> +               }
> +               if (mmc_init(mmc)) {
> +                       log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n",
> +                           __func__, dev_id);
> +                       return NULL;
> +               }
> +               if (!(mmc->version & MMC_VERSION_MMC)) {
> +                       debug("Device id %d is not an eMMC device\n", dev_id);
> +                       return NULL;
> +               }
> +               if (mmc->version < MMC_VERSION_4_41) {
> +                       debug("Device id %d: RPMB not supported before version 4.41\n",
> +                             dev_id);
> +                       return NULL;
> +               }
>
> -       mmc = find_mmc_device(dev_id);
> -       if (!mmc) {
> -               debug("Cannot find RPMB device\n");
> -               return NULL;
> -       }
> -       if (mmc_init(mmc)) {
> -               log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n", __func__, dev_id);
> -               return NULL;
> -       }
> -       if (!(mmc->version & MMC_VERSION_MMC)) {
> -               debug("Device id %d is not an eMMC device\n", dev_id);
> -               return NULL;
> -       }
> -       if (mmc->version < MMC_VERSION_4_41) {
> -               debug("Device id %d: RPMB not supported before version 4.41\n",
> -                     dev_id);
> -               return NULL;
> +               priv->rpmb_mmc = mmc;
> +               priv->rpmb_dev_id = dev_id;
>         }
>
> -       priv->rpmb_original_part = mmc_get_blk_desc(mmc)->hwpart;
> -
> +       priv->rpmb_original_part = mmc_get_blk_desc(priv->rpmb_mmc)->hwpart;
>         rc = blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RPMB);
>         if (rc) {
>                 debug("Device id %d: cannot select RPMB partition: %d\n",
> @@ -94,9 +98,18 @@ static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
>                 return NULL;
>         }
>
> -       priv->rpmb_mmc = mmc;
> -       priv->rpmb_dev_id = dev_id;
> -       return mmc;
> +       return priv->rpmb_mmc;
> +}
> +
> +static void restore_part(struct optee_private *priv)
> +{
> +       int rc;
> +
> +       rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> +                                     priv->rpmb_original_part);
> +       if (rc)
> +               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> +                     __func__, rc);
>  }
>
>  static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
> @@ -130,6 +143,7 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
>  {
>         struct rpmb_req *sreq = req;
>         struct mmc *mmc;
> +       int rc;
>
>         if (req_size < sizeof(*sreq))
>                 return TEE_ERROR_BAD_PARAMETERS;
> @@ -139,9 +153,11 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
>                 mmc = get_mmc(priv, sreq->dev_id);
>                 if (!mmc)
>                         return TEE_ERROR_ITEM_NOT_FOUND;
> -               if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> -                                         req_size - sizeof(struct rpmb_req),
> -                                         rsp, rsp_size))
> +               rc = mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> +                                          req_size - sizeof(struct rpmb_req),
> +                                          rsp, rsp_size);
> +               restore_part(priv);
> +               if (rc)
>                         return TEE_ERROR_BAD_PARAMETERS;
>                 return TEE_SUCCESS;
>
>
> --
> 2.53.0
>
