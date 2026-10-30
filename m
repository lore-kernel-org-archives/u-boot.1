Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5E606A322
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TBPQJCNu;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=OTPALmnR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 608BC80F1F;
	Fri, 30 Oct 2026 21:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYQtzLL_6eV6; Fri, 30 Oct 2026 21:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64C4F80F38
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793395143;
	b=lJeQlMEMPrdVhgqPLEnz3jTuKhQmzkpLK1C9Gxqp1ZE8sgsfm88imUIu8wBC38YnZDzS
	 +U6EmwwGR3KQoHC5BAeJ0gP8fBP7j5AtD1KOATekwgs5VLA882jwThgv5G65h7XPFnz/2
	 ZkZKmQnRhrw0NVm6X5EOQk6/3p7TNSgU2A70HVRlC9FvvgMuBEPwApCIhM7d02Hrn7/72
	 sKk4prINWhlTeJO17Bm5rK5rcEE6MFmqty64CGAfzO5zP7OIHUvwFLROUNbkxJ/z7PK6Y
	 AgB/7xXz6v4VmSJHRoQc4OnCOnp7VW+uAYqqaFgv87zsLZsd2Byt8UNKtQqTgkFb9Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793395143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MzZzqzXA/hseD/mDwyYTdu/kGtzS9myRna/pfAlttGA=;
	b=LpERr9ynexxUkYvIAIVltx5RSVOsbuHt2y9fMG4jFpxGu993ykVaSo2fJ7Bijuq+kjKs
	 UHLrLUVrX9amEjKQ9AwLeijShceX3Gq+TGSGLeCLz6v3T9qNxLJ2WYQ030SqlakVKzKWk
	 uo/swTcZoMYlQGFlsUKJYeu29i/vy/DhL13MToWPWTIdTmOlUM6bqgSOhNtCWDu4P0oXv
	 0jNwUguAAtcz0tWsZXMrRa+82itJUE4EKDrSWT1WN8NLKPbNjRkuSRurLk16qGVLPsgU0
	 CKQCFmW4qV2YEmrz+WYsbVnX+8dWpDSjxv+lPYDog3dcoZ6av4G+7LOIanV+4XX5E9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793395143;
	bh=MzZzqzXA/hseD/mDwyYTdu/kGtzS9myRna/pfAlttGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBPQJCNu9QTeY6xedlAet/bbeVg4AbNgqNeCjdArNaHYe+EwBFrsZtp7khrkrlZdR
	 ELLWYXICkhZkZQE6pV1WRjl3++5XmDYFESwq6tfd8ap+7S8HBRQekcJUWkiimp7Vf9
	 eabddFDsD4piiPLnMybKtBpQ93y8Ulyftrm0zTxsSVAJnzWbofN6kizRGl9BLvwagM
	 KCnr8Hrj+DP9PLY2jlbk8jbrQrOMChAMWVkAHis6S/Ay2a1MFEGa10ql1bXV6gr4zy
	 w14CK5keOZKYD/TPsRMt51EqDwoX3HM6/cYW2wNOP6BUcheKFbUEdNEvpg91aPgrPF
	 qgS9SWKIHlK+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C4F80F38;
	Fri, 30 Oct 2026 21:19:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE8BE529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3F1240541
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6lM8mG9e6LG for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 21:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D4BCD4052D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793395141;
 b=mUFw3Qo3V5F18mc+NHxx1M45pjJi2qne1mDVOWcD29/8Pn/w6a+yyVozpOJ3NyiNIZTg
 MxGq8Y5kD4M8BIUOQ07JFD/uAfSkZbTkLY4MKSEsWhj7fOKeDijjdW//glyQPcjiavtfu
 ZABd7tjk1DITUJKGKKgrUNVlZeg6kiNBzdMIhml7Yhj47E3WUf09yrglgUKsoagz04LL8
 woN9Sa5mTiQilN4I66ifvBJoVQ2dfYrvkzOTmJbQu/9wDE9LIj22C0iDBsx5n3VRTr5HE
 umlw865Aknk4nD/098EDdwT9TWSmrwE4GrKsjM+uMmDAbRdBA+DwlCbTZ+3m/d/ytrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793395141;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=MzZzqzXA/hseD/mDwyYTdu/kGtzS9myRna/pfAlttGA=;
 b=n7dX0OMzo7aM0j3s+gV9Xy7H6O04D7BQULVtxVFP7D6BLUMYkj7+bMg1y83sQRk2T2Rf
 Tg82NiaYKPgJPsywQajkvoeTScz6m4C6L4iUSb/TeMuI3C5jrYeRsBYNGEexowbogLJeo
 nXbVhhcFwCgaRhl6PzNQ1ERFoif3TcxbbmUDOdvhyedgE8IZVTXUD0JmGxjpddAYlZAPK
 CpUyXQb6+1QYmaMJ2QdTMIxyXenBnjt9iGAqGabhxBW/9qshWrYoImepSmR5+QkG90aD1
 eHaWq3tB/WO5PxKpsVhCoublVc8brHUQ8Ds4FZG7VE221h2GyhqzD6V+dpE50UQ9tuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OTPALmnR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OTPALmnR
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4BCD4052D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:00 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824413e10dcso581092a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793395139; x=1793999939;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MzZzqzXA/hseD/mDwyYTdu/kGtzS9myRna/pfAlttGA=;
 b=OTPALmnRfFahvLU8bM8ZvWyidT0h/fv+ivWd0i0WYPw4Nt8FZCrLQGhG/vb6g+Anlb
 VxiaDO1Pr1nyQgXls0OtXrbbkLJWgGiEtZfUb1OzwkA4kxqwJ8nIWb1oRO/rjbcT5lFf
 vNeuNdySu3uUIVXfnrWpH9cctcSp5fZXGG9nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395139; x=1793999939;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MzZzqzXA/hseD/mDwyYTdu/kGtzS9myRna/pfAlttGA=;
 b=MFI7LW/GksH6TbnEKuFyNcopitRRpAaulDr8pOt18Rta5lHj2EUAWCHNwTRTzCig7T
 sszyWI8er5wZWawHy+i6WAw0Zfz/efBFzBjqZ+3HJjrDI3hOdFWsjLDByTcQQy+dIzx0
 duAjclnItk7eI8P/YcCeE36bJeMATrdRtpsT44s4ZgRwiAoDtjHMEF/cYW0pFrfvZYI2
 +nkUloMAtUVLOAuLqtXZiNTOoHqd8LAlT2QET2H8cAoJjIDDXxDs3j1sqFeczHDoB3Aj
 9Bvn0gf5+xabrZbd9QbHZ/Da3Zbr3BepXWHwWILuTvdgHsm9rmDLVw+RUoTjtdtoghmg
 CItA==
X-Gm-Message-State: AFq9FYKun/8TjPsDSEH60U78ZIfnNXKg39qMwHJsrsnCxCWnKR2EVFZ5
 F1Hq2JtoQ8SGUR9H5zzVl7N0WzLkCmH2Deo7V1GhgDkrAlHoJNsVAqrgDTLFiqjhoHFK85em4ga
 m9nNsL7uZmiAgD38=
X-Gm-Gg: AYBFou1Z6jzf7w/ERFrvozfbIOCBN3gVaqDRR7xHRz7smN13QXcI+Y+9+YfZMhg09nc
 091WY1DxJCLNbczGT2wqR9RGlu0yzQJzwcoClsldzg+eMTHPmH3mBMIbpLLlCSaaG+d9dp3f6uT
 oyH7Tg0QfMN7ooXbN1tB+AV17SRUVHxFfamxOo9wf5WuNWdMehf4878QP02jXYwEqBrmILI4iYz
 tvgn++77qGZTsdVqJYODUp/HeDVQRJ+BxyldkPis5EhKKhyYyipoD2cfbCk5All5ZJ31RYGqwQ9
 JilxyYsSU1OolwbJAJPu0GCfN6XtDpb+51dlyx6w05vsffYRQSjq88GNJSSHeypNErJakqTqVRh
 EnlYA8RryniaSgeyqh91hSDQR/DJ6k3tFjzK5m2Phg+3WqyItLaiqaC9Q7ZaW3dNkmpVFPB+PDa
 XiPWR+t0PXmRkc77mTf7JslEpVky+hokM4wvB36UO9WIFX5F/rIRb0vU9Yg9QgZ0GJDIViYqIOk
 GxRerwRMj8gwuMDVsX/RfU56jD2tcFcScKqloJGYavcpcmFzBRSyvgNSJsHTzm2GM7rrdSK55G8
 D9DtgLQA4bZqEAxAwvyWKXW3awOFRVlaUNVj69q5mv3ABu93EBij6A9RPtJrbo6zGBjq7tGgxLh
 rK4rZ/H21Idw5hBJ4+uJt6b2faaC+r3kM0JOM6vPPMj9C0yz+x8UZsErPIMAF6WWApw1vQqjc+Z
 oNl5y2dVnFoaMFAFPPAR+hFemPPqr81g==
X-Received: by 2002:a05:6830:b14:b0:844:4959:e840 with SMTP id
 46e09a7af769-85d36416e94mr2646568a34.21.1793395139058; 
 Fri, 30 Oct 2026 14:18:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354f660csm2829799a34.22.2026.10.30.14.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:18:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261030172337.791283-1-u-boot@0leil.net>
References: <20261030172337.791283-1-u-boot@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2027.01-20261030 into main
Message-Id: <179339513819.3804820.7655743423815099645.b4-ty@konsulko.com>
Date: Fri, 30 Oct 2026 15:18:58 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 18:20:03 +0100, Quentin Schulz wrote:

> This is the late pull request for Rockchip as agreed two weeks ago, as I was
> off for two weeks during the merge window. I'll be back to the normal workflow
> for the next pull requests.
> 
> CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/1801
> 
> The following changes since commit c267fa81d42b5a5bd1055d3858f74496faa6082f:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


