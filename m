Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA536606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0uMqc+4F;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mvQ6eLU7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D01280D62;
	Thu, 22 Oct 2026 17:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACj6wmU-vXMp; Thu, 22 Oct 2026 17:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E19D780D66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792689610;
	b=ZBwN2/591ySgYprfdt6m3VyDm4o84IhChTc9SYLDehILpQW+H7dmx6xyuQ2AXyS5KXo2
	 z9epjzuHxiGeHsWNqNLf8BO+Sfu9n5xXUoDXzvuq6fBMucsXRz86JHkxSO/vyXzvlaejR
	 OO1yrKfa2NwsaizBjyXmapOMUcJIS/DUZ+wofrgGC6X56J5gq/FYoDwZNFY6rfO96eNIW
	 L5JE0yS0ourgaJcr5nmx654+rSlO5jB+GTNj36/4C3/DR6FV6lBB8nInUWrkDxsttUTkj
	 1wUUyFeMEER/tli/2d9reM9z4Q+kZHnliCa0MeVEdV49dMMrlFiPmJAcE+SlULctfsA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792689610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VqDT+42B+USM63odiR1Ucikls3FQ4c0T1+bxJRhPigU=;
	b=Mt0mJqaS+ixa28BU+1VLS/zFI7ROCwjF8nGxzAqqPbv1N4IDFnoSVjzjpyZfW/WURzVc
	 rQ8x+t7gtfPMx6/5W88SNaL6qN3pzyng4DLXSiZa4ZeuSHlbYcmScanu/+JwoPLWtHDah
	 bcdj3mPZ6yDqdcZnOtDt82fjDbI7HKkasI980/xWHAdHXMPZ9poNX6TzBrxaerf1kScsp
	 hFTI7ZcrT10+sYdHLAlWKGCp4AP27g5jVt4OngphV60YhYPvqPhaNWiXcNBO8Bb1Yi0bf
	 T4UxCZHr+nf+3vz9LWsTgwJC5rNkupZ8ZHdiT0wKWM3FhvufzYmj7eWgwDkjqLXhOxg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mvQ6eLU7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792689610;
	bh=VqDT+42B+USM63odiR1Ucikls3FQ4c0T1+bxJRhPigU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0uMqc+4F84JYe+/26Npy0jCygfLaOwYeYi1Fp2ZHXSLJ7pG0zNTL2qJpckiLUDqlD
	 v+4T1Qnn60cY5LogmP/zNJODZTXvFynGzPYkSD9Sa+8rAJlC/rFSJNCyCJV9tTrtWb
	 tlTp7ke+bnVrY9gALSeVRG8+YcTf8L3MU7AOohE+xpVre5kCM0wbFEjoPCWkw9LtRF
	 miADdEeX+1yc5YgO7j4BMXjeg7EJjKZ05+hdbsgzSx4xYX+F1I627idZWEFuuJ15fr
	 gunVg8AAPMLkQsUffeK6zBI1ZiHx66zk+LO4onCqhCym4Pmx4huZMtcC0Gmbd1Op5f
	 IpCtOgPk1h+7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E19D780D66;
	Thu, 22 Oct 2026 17:20:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E81BA91C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDD8C810E3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:58:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arQH_PvLW2ss for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:58:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 10B7A810D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::72b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792688295;
 b=QTSB0/c/d7/sog0ecf+1fEdrlmBtw8vfXlpdhd0bPW4UC/+o3rQ+aKazxcTV1uol2vrt
 tKU4Yg9U6uKlxa5yJWcED24FoZ+fDM1IMgoYiEfNVJOAaQ4IvUEqI4qX0IqPWAIT+78v8
 1fvvn2eLv8nkNqFaOjwBqfWqNyNl8KrpLf+qLKxcNbPqsOFlwXgTO6CQhZ4XkZAWHodt6
 0r5RkFIA9blQOTZ7Ls2fYbU9Z7i3lfW2hR3Yz/4rDJQkeaIacPqwNOlriWWUfvh17ICSH
 ieQIxvp2/lu1pq6hyaLlMe9kjQ2Znbwo9HqMPSAQs0ecWpRMrZn6DzkJ2IjAzcO9HpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792688295;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=VqDT+42B+USM63odiR1Ucikls3FQ4c0T1+bxJRhPigU=;
 b=j3SlSsTJFETZtfj20prnOlKcaBvwJvTiftS4hru2fOqFXX0PWgCxqOcR9E/CNyrv2Gpb
 VLCndYmni6qgGXNARFj7Fcc7uQHHCIhqlazOAg7jmMQ3HzW8dVkIiL0ZckR3Mf/dd/DVq
 M65unjUAjk6SXXBhfj6TOzc8zpSlKN4KX/u9TknXzbUzLuf3wcGrwaMCCx4/zlAJrDLXh
 vtz2j/XkWzzohgqJ7d0u3A0hmvey3U6q6CGDOB4EHcLxo8crT84WHEFyTymIUVtoqS7o2
 zNdAbS0YIe/Vb14ctog6ko805cFQ8SNG8Ny4l301RAOgWA3jjd923Avt3ncxd5tQRIQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mvQ6eLU7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::72b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com;
 envelope-from=sn125164@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mvQ6eLU7
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10B7A810D3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:58:14 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-93f3c89594cso147114785a.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792688293; cv=none;
 d=google.com; s=arc-20260327;
 b=KKeyyXUDn4+uEcBCkxQxZbr/K3+f/wIBKo2ht2uVGpuYFoucoVapLpAF7pMbTdckxE
 t6sG+7IlklfKYJCfzX21J32+qVyqfVnLBCTwRXvtsDhrmsAPsiaF1xPMgtS8aAbjyrYJ
 CIbKYJBrpPYEIgzRp6tDiOTzuIwgchi9WjpJvoGGRjVO1nW2IEovC21pZBO1Dbv6HKaL
 3r1rzUfLMvzL0FvOjnh93dI2xuu922k5ZkXTI6x0kfrf8l3w0sUFfyZYSTLJIjCGRabd
 78EKhL9iTKmbV42IkLheNgY4s36Ve5Sfs3n+3UWXvIiVLoKN6IK84Zz/aiKD0vXDHmDO
 O+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VqDT+42B+USM63odiR1Ucikls3FQ4c0T1+bxJRhPigU=;
 fh=CFRN5M5i4E6Jk/4DsWmgXXuP2NTh6KpY3pnvJ4PmhcI=;
 b=gbYocRgfVCG+U2kd3J6sur8wbBYnRDklkOD9W6NOrMe6+NFKBXxpeApgxaqNlGOB/O
 5Twjyx0c959S6RgRetoo9aKtBRnUy7ptDX2Y8L2aVVfLmXBSUETHty4sQdBYgml9FWR9
 n0o60/MfIkkEH/wyhwbSyYQkQZIhYvveT0nfsJMGJbvVVuBMXkUgGnDABYGB2fNMXLsF
 8+HFL7xRG3L7AJra4LtmenZD6ENdO326k5Sv2UmVo9agsH/+zDg23K9PYQrPIgNJ6oc8
 LK4NgvRbPLQ05ZiVsgSF9IDGhH+mBp4rk5ndklnPo4W/cRvA10/QI89LXqvFvb2dPOhT
 PEqA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792688293; x=1793293093;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VqDT+42B+USM63odiR1Ucikls3FQ4c0T1+bxJRhPigU=;
 b=mvQ6eLU7OJ5aokgRv8aSfZLfwBzww+BDcxUZYmnDDZSEsilJ1hoNxn2tHgjrc200Xi
 g4esZMEatNMrlCjL/4aD+nBb+ymtP/5UH/nERiFt9NdXbLPttnQD7OJrAKGCQkKwWnVJ
 h9rh+h5Ifm/gY8ZMg4gza7mn8/0jK28MJpYz7OdMdxsUBcY94sbXrRuEpKyb+1h1Sr7g
 aFNE6UngC5Xq8gcI53gXDkYeLAoutVNXhuYu9vDtnfD+2LGZz9XzXxowT+HKKdX660iF
 9mg+WXNGjkBAA0OClbwsyLqkMrH4SpeP/V56UsaRR3ucj57Vk0AJxOAsy0W0K/+J25Xu
 6v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792688293; x=1793293093;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VqDT+42B+USM63odiR1Ucikls3FQ4c0T1+bxJRhPigU=;
 b=0f5DgCGQ/HfVLMqoNTXaqzFGU9wyZCzWzFnXeOqT2+GYKN4rsrKuyhmryVTfEXCeQA
 lIyDrH1/A1BCascTMC/gmecTj9Bx7GKe83szF6/PQtnYvTCIRFzfne090ixqJeyk9/31
 EFHxXFYparOxChi24Vt2dD4kHalwpmRIMqgrjkk8mZH8q5nQmml8bVenhJifD0QIqjYL
 XBdc9NUB3aF3McLYHHSFxFGut22y/PhCaA+whoaplSNiwnCoidsUnpUn6WfjWw+Uj3XI
 5djd5gzbOVRthMjKatp7KAHFIIVZDcOKhIp43pKf+bxJPG5aS6Twy1AE5UT7o6SeFUMS
 vwsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhkhZp5oMplDVYpdceP4kYxKBX1Msw/oUkgUSAkYRAVOheo+Vf8PuhKul9yJcUmWe6W5MJNyg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK0iHCKNRuN4Wg9dXNe1c3i1ypPBMucou+7M/4roYGv5UnLmIIG
 H1JWipVLvZ/wGcEezBAH+DNouXa6zz4fm+MaDNSQaW+YBfCNBwLOHof7+0RKR7DMUFKAW/4wBfm
 u8RRezogbOpz/A3tiS1ullxTVor/cfUY=
X-Gm-Gg: AYBFou2twaBX1YAmXJQvsy09gLJksxS+6d4M0pkpPewF/pF18x6tHX6JBSDfnBUoB/7
 BX2YRdB4wp4GtAMvSSu/fGomgXXP/EkeF1VyGLPkp7DoFZPtOE72jpIyWLv+1TmMhgjY/l9YMHj
 O17ZIsFNIU/S3pZlEHi43mxJefxwYaiDLPcg1opuh6jsoymdMgERRkCiQghWyCZk5kJVaXpj2tS
 vUCIur+mxF6uvEAcu0nAVjmhzcT3/IjKh4vTQ2aQgbUy53fqld+jizpq/bZ/TmNPCY1dsT6Jj3M
 Q6TyJGbYEaT3iyWGH2pe4Av6Po4ybNbt9eCmApfzYaitU2MLJL0IhYIUJQFXrsGEnJaGA9Ssd6K
 fEQpkFF9sfjfUac9AROSF02WGXXbsbX7NRgifPlm0mBcAVv4gD79ncEazFPfXAS4Iut+TBg==
X-Received: by 2002:a05:620a:2842:b0:93f:216f:f404 with SMTP id
 af79cd13be357-93f6f9636f8mr2776785a.40.1792688293549; Thu, 22 Oct 2026
 09:58:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022070211.128370-1-sn125164@gmail.com>
 <2351231d-5ce6-4ee2-872f-cf4a94aed13a@mailbox.org>
In-Reply-To: <2351231d-5ce6-4ee2-872f-cf4a94aed13a@mailbox.org>
From: Jacob Procee <sn125164@gmail.com>
Date: Thu, 22 Oct 2026 18:57:37 +0200
X-Gm-Features: AclHuK_mGR8y-l4OcXacVKDrAisT3MXglpT79JdbzUFZfO2VHZQwod0ef2sB25g
Message-ID: <CALy4PvenT_i_7HdrpyaQUH04z0VXMNiAQgxvdV-wL1yJjwoEdQ@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 22 Oct 2026 17:20:08 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 14:55, Marek Vasut <marek.vasut@mailbox.org> wrote:
> Does DM_FLAG_ACTIVE_DMA also fix the problem for you ?

I tested DM_FLAG_ACTIVE_DMA on the MacBook Pro M1 Pro with a cold boot
and a USB device plugged in, and it works fine. I've updated the patch
to use this flag and will send it as v2.
