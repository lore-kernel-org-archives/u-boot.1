Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461C1CA6015
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 04:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D545C813DB;
	Fri,  9 Oct 2026 04:50:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gH-LDn5CWKOh; Fri,  9 Oct 2026 04:50:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C81FA81393
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791521449;
	b=RYX9iOErdsjrKij9WKLUIuwtDSMGrCaDjbcAXdRiHGJqLuualadiFF8VEyUVmB8ly9Qe
	 XSRQPw6VWLNK4WE5VXFrVtp2XIESdMztCujDIfzjYcImKIdr/P6PqB9LT6SEcT/c484q7
	 hIsdZWkIRIg4E1XdOpsHLTVcb29JV2B3tUKj7ouzR73nTBVxC5tTeZfyjKOsqDNy89m50
	 wdyhpwsZpb/CNvz0sK1qmbcYNqJbHW2fmHaPXB2NzSY2wGWicg+IlQbXpBncuybbB/xZx
	 txgDGoCHvoKEs46ntmUR843KMeGdIKAlpomHgbAItD6AtKxVOfeqWyDnehV3sHIfsPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791521449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bW9J1or3oNJm0PNxeaN4BPJm6yeTfyLLYpwK0CnA/x8=;
	b=IQvShB8bU8CXywBTSrovx9C/dCwnhQE6alZ0T7i6+5/arbP/mm7LCKrxniFlreJRlF1e
	 Rc6lap2EYtLG15ngglosLfybNvQlTkavylWPo2RuPKLMWlEh+DLkV1XIQWrA2ouKGUawj
	 s9hLxEibk3ntjhj6YSR3RlcaZY1SzxP1/wzHTL5csTq120QKwXe2pKGUlYcflemKQFd43
	 7eF05SkTVJ4gCKYgdwLpBlH6DWCdBGd/6qeExbczw+SkLRYpjT8SzVQvF/0bmVWDzw/4X
	 DRTzrb+dPzR1LADpDtWmyh9T/pJZNJAUJ/uu+2g77Xmx2g2cDkiQCLdjcr4SKn8dLWQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791521448;
	bh=bW9J1or3oNJm0PNxeaN4BPJm6yeTfyLLYpwK0CnA/x8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NipGIQ9Ern9Vrh5KKQuDn3kcupVgGhHRfHqgglA9UCfMuwn5011NKwE7+3ll73+p/
	 DfrXATmWDgvtGpgsCINuKKzfPh76qsfyJQU0WOi46J2Fp5m/QsDgM+UjfcoYY5JiTx
	 9YtrDrKfV2kv4LMjWc7QOWRUOk9ppvrH1NiRI7D70E4m4ujrjBQa0di0MUM8I8XS77
	 eRYrFEdRWyDzEy402xJBHkJFWKFWtkmW/ma5Yq7rdVHpHF1CIr3zD3U2mYv4qIpgiB
	 nV70WXLzHsnI30KSJcz1HODkQEYn/3XqohmPEbzyVqsAPIEFfH8K9rm+CNo/nVTwOq
	 Q5U4ipR9lqd5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C81FA81393;
	Fri,  9 Oct 2026 04:50:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 740201C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 04:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71B1A4006F
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 04:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l8chE0dxQ8EV for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 04:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 90C2E40061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791521446;
 b=juX1C40nNP9OjQd5ej921m8PAbnIgtyzIKOR7dh6/q+zkAIiC65v8ErC2SvOb6BveEDq
 e3oHeWpvmHt04wqsN1tDAeeffQE2IjUlIIOi597ox8DraXyrKjYDNVqcDAMqG2XKhIejH
 JFGqLxDwLYSO56tItHqEPaQ/zLNcKSyWL6TwfFnzHX5NmPcSjiSdSFtYDmQTFQkZdxlOZ
 WG0kwkPndqd3uQhxl3FWq+q10iA68eiVadtMv11TCbgb3UBfZSjWVwVlJ7rnd5DduL3fc
 jF2IbKyqmXppwclFtmUa78MtyVK13Z+PBhH/3jnXZUXeXEL7f3sJUhK7JzOAP8aUMeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791521446;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=bW9J1or3oNJm0PNxeaN4BPJm6yeTfyLLYpwK0CnA/x8=;
 b=TYgixYuTMNXtBQBt9NmHjlP1B705sdCkJXYDuIj9/tC/nRyBMcnm0h3yQanPCU7JolVd
 MI8JrMFAk2EI4yIEVUHf5OTjwZfFJ8o1yq+zexwsNR3qwxhTFLxXMGrFAs6iOAiyleXXq
 pcqsDhsR9J74XdLAzBwjv6JiuA5CSWSYEjCykexSLLnh1IhVSPCt/wtfx5yldoy9f3QLW
 CjA/zO3JZQ0hU+9xS/Pl42DcDsBL1FBtOE68n9awbi6FeA88db8yooLTsAST5HfXh7YhB
 xP/iD80iIbsOB3izzM5D3IQNuAQHZK8A0nWyp+1qDFJSy7SS6kTqwDsDw+Q/K7wVQLA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pSZi6Uln; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pSZi6Uln
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90C2E40061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 04:50:46 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66c7e3a2332so4422109d50.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 21:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791521445; cv=none;
 d=google.com; s=arc-20260327;
 b=dt/UKSS5gg5aSBjC1yqlwABGEMKocmX2fQt1LDZSKjdPvgwXfMT0qEpgNIEjvuVULw
 KRZsgPTgv1lPmPtOPk/G80t9H7vK5LhzMDshuVcf4+0blL/2A8rP5devz2tNwdITNCSw
 j6kCDDi1Lo4qnQTk1rw1rG8it/uMw5AdCIQ81w9pzLE859P4uIuseL1unKUdHysJJjnD
 7Mp6tXoYb03cyxsWe7tYsbmLVvBjdztK/53pQpa5GycChHz6jTEq7+9Hrak477h8jghi
 VvNNolO7sEXVI+1w5SoFQC3f8v5lokU0OksM3cSP5WRt4BFmHoFLrwcHSW4IR7RdyYgE
 T9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bW9J1or3oNJm0PNxeaN4BPJm6yeTfyLLYpwK0CnA/x8=;
 fh=DLbhrAmfqSpQlSjj1JGAie27UGQRGCJvgzaS2UvK8B0=;
 b=TAOkdF8/uHdRzBD9yBkXZ64mlhHa781sbJdblRBXK46iNEin7ZV623fye5SBDEXFc6
 eH7qjC4twuuQOzpk+u8OOw5slQwgZ1n74Ngcb2O21eHktYLOz1wsoYt17d9I0Qi5wHI+
 +eb4qVB+6WBY7KOM3OHh1lRsmL0rFg4wb1HG+ReHN4O7k8y8bUyrexOhasB7yILd7R/o
 e+UiGc0Ub2pFPL9+qwXkRU2sXdcphmCVUVjV+zeyPMM7LE80mKy3Ssbk4j3L45OmpY7u
 DzNWvj4OvLNJQZW//ab+Gb0KYjIBPi5Nw/1RkJQQsltZy6Rwd5xWLOlLDzmxTBxk3vp6
 37Cw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791521445; x=1792126245;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bW9J1or3oNJm0PNxeaN4BPJm6yeTfyLLYpwK0CnA/x8=;
 b=pSZi6UlnV/l3OiHsmziREuDnoYDIOvOBk6+oLcbkzLMJZSM2frN6TDl7q2+gL6dmHs
 nSj/q9eCHL16eJP7MpFgXWBHho4PHOec7W0dA57mFfLXoh/23FSwddlY+R1bMfjE4Bp8
 Aj01KJibA2bDaNUNCvqfFHkLjv7dKBrSWubOakw4UUJlfsxstCb03HGRXZcC/zwEfz4U
 zNAz/UXo9+w9i7l/HaZa1Kc42CVz/h5jOxTPVvJ8y2MIoMLDkF9cu3UHBL6CtadQZWL2
 7vt2eSE3Zx9oIRdpjN5unH37IDTwIW5oJptFt6R7nkAmYCzyUgqld0hLvCocv7dDQG/f
 VPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791521445; x=1792126245;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bW9J1or3oNJm0PNxeaN4BPJm6yeTfyLLYpwK0CnA/x8=;
 b=ePVbEbQSYT6Rd5M/l+PD3XNloxvWgpxLMCDQMgTx0hCMcpKVD9das2ogjwWHjVqgWF
 LKsQ3h4KGfHIrjIs/UD2jvZBdyg1OxxfKSt4SVw2PtcOEF0T7guSR584VSOv116kzV3f
 LSXuSc0NpGMyh0aDB8kAmtSm7E6GCKYDS7psPROUlfKv2fXmIgYzNA8yYbgmVFZBtUch
 pMrdlwsO9/t/qypFCWsy8EFRRRWzq8gZ9QMGnAaR2ZdJPH3yljmPSVvGJ2fYtyRUDil5
 3gNUcCK7L0zQ560xZRc2JisMc0jim7fDx/lYSoVZQp4xiJ26xpEzeUeKo84Ydpots6zE
 0sqQ==
X-Gm-Message-State: AFq9FYIeCQdBvoGPW3cIHhXaW0BeIt6zLdEULRLzF+4VBVzhr4+5U11N
 DNqH4/IerlMLoNfV3dD+5SiD2BdssAUSJViIeBt6tfT3oPiXPpR+MMbHkNADnxbpGAoqWBlKY2k
 og11uiu9opZfLBGxvAyEebeWzNLlbgz0=
X-Gm-Gg: AYBFou1CzkKKT0/uQHt9G0KoH9KkJwHp7/YPBlYftOwgO78XX2c4cFw9BU9kehv/ADm
 KARpTbobqv9uzpk/P10m6iSTOyjoOos/lGoKpVW8+SkX9IJnhwwXsOpExzreOI7Yqiaag70im3F
 gptDyv5EJridlyKf1n65fK342EsMQGyQhfydJaWHBg25SyUy4A60UoYf9vGCOFCrXCMtDEoSg+2
 lqF+FKHknDRpB0TuBwNOKyByFZCLVESllXG5ANwy/UIfl9PhKEV32gzaopnDDn2JzuTX63TxZGB
 Va74wlEvkExqWclDiaaa1m63Nu/kNrlbgQsSvQFsVoBRMnPK0LRRu03WifE8ahM651YSLRcYzyc
 MkYgBR3qZ9GhRVaU5AXRIlAzlDe4IxhEuJmXqDVYEuHkFraqCJSUq6+iAVvU4z6R9FhYerkdEVg
 ==
X-Received: by 2002:a05:690e:1406:b0:678:3418:8cff with SMTP id
 956f58d0204a3-679362979fdmr294750d50.103.1791521445079; Thu, 08 Oct 2026
 21:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072741.1966573-1-0xiviel@gmail.com>
 <CAFLszTiXz5V5HhH2eVEVLp_JSMUetcdhCpFD21=5rauV34w_Pg@mail.gmail.com>
In-Reply-To: <CAFLszTiXz5V5HhH2eVEVLp_JSMUetcdhCpFD21=5rauV34w_Pg@mail.gmail.com>
From: Eva Crystal <0xiviel@gmail.com>
Date: Fri, 9 Oct 2026 17:50:33 +1300
X-Gm-Features: AclHuK-rhECVvVhFjqmH4biZadQO3WIBhnaWv_EWwZbeIrqb6GQqJnQVcjah-9g
Message-ID: <CA+pz=kKW1EmntvHj5to=DU=LmiJMMU9gBx6CYkUA5dz5m0FTzA@mail.gmail.com>
Subject: Re: [0/2] image-fit-sig: close the image-signature fail-open gate
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Ludwig Nussel <ludwig.nussel@siemens.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon,

Thanks for the review, here and on 1/2. I agree with your points on
1/2: the CONFIG_LOGLEVEL wording is wrong, the select is redundant,
and the test overlaps test_vboot.py.

Agreed that one option should control both gates. Rather than posting
a v2 of this series, I think the image gate is best folded into
Ludwig's series, together with the doc/usage/fit/signature.rst update
you asked for.

On the dependency: the patches do not apply to bare next at
9e002445cd0d, 1/2 conflicts in boot/Kconfig and tools/mkimage.h with
Ludwig's v10. The conflict is textual, not functional.

Ludwig, if you take the image gate (fit_image_verify_required_sigs()
returning success when the control FDT has no /signature node,
reported on Sep 7) into your series, I would appreciate a Reported-by:
Eva Crystal <0xiviel@gmail.com> on that patch.

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com
