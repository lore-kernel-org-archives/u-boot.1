Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B3606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NTfg4mUn;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=HtcCW3n9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47A7B4085A;
	Thu,  5 Nov 2026 19:03:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XDGFraEPD4gz; Thu,  5 Nov 2026 19:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 058F9408B5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793905405;
	b=FmrY6sODmD5ROYSjJZQvdw3T1ul5BKBB+1+YaIih/kz61fkoocusQIYS7XXegozuqVT8
	 GRHAM5uK3R4tqThhzQU1RCVrtZWvDaNmslzayy7ihkFrkRg96STrPdzFDy1lyPOAEUfE5
	 csvm5gZAsqn9yWY/+FWLjX3MBxhLs84sWBBwqx5tg+luO53ROVKeRGLlcWCLIhhqIDEbX
	 Exp3X6GXbvd3dlJEE14BITwbYJUBs+znPoe0pYcaYo0gXdDBbxPH2FXigAvv5QczolQRo
	 93+PgtT71eeCYXH6c0BkrIqr0HovC5Yi2H3uPSVkBnA0xD8Tf8KwbG6s2y+BooXrfAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793905405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=f7fzLdpkbpSKMvt3oI4r6BBTcpyrSrw6CBpyce6Hp8Y=;
	b=RgXpqJ3kVCUR+LHrz8tjFjsrlERWWlzp79t34KRc09iCJLXPpOMxMjHn/ZZzTQtBXx57
	 kW7pVSsVqyvpWRl5gL8UC2aEL/sx6oiRUM6erImE3fXmeQTP1yDjX4GLhitfnu1v5tG3L
	 F/cJqN5PUFq83+eJiHDQ5ZDioAyV/D53F2hknELyQDREHHDHFv1CeOdseNENlTRen7rd2
	 OBrIhvhixQRRmmxBXQNrfZ2GpQ7ik86P0HPVdwK1hvukdGRW6FXq0QnI9SQ03QqWQXFmq
	 /l/R+pNXQiR6MxEfOgzGjf2ufr28GLyQ4r7SGa5MyjAkrt9CujYxQuVqaccFkLaq+qg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793905405;
	bh=f7fzLdpkbpSKMvt3oI4r6BBTcpyrSrw6CBpyce6Hp8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NTfg4mUnxtnnDFQbLiJ4b5eYBJKhgH9i9q8/AGveWAi4D9ZkPIJ3OfKV8me4Mfslw
	 jhjDHz/KDt4ckmBaYeCf5uB0wOibU2MGPXXoZPAnMTtdEkIRfKe7C+7ehQUzNTmryF
	 BPC4AA5V+xlPA5iWmjUvQedFIYjKwU2CrVM3L2kTzOfsJeJLU3ye460RhlAe5PBEP+
	 JazdsbiEkOe6SYH/ryHsnUFiQFUMkVRj4yzTjSLa8kpOC0TDXIDKirvsAyVx2jghFx
	 5I4beTPQbbPpaiDsdMbzQFQgXgxj0GRUhlvnDSbGfKBNMR0AW0T+ruHW1H+PtCn2nG
	 vvW04/EKafsEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 058F9408B5;
	Thu,  5 Nov 2026 19:03:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB6BA52B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD37260884
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rOmINp7roc9q for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 210E860833
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=HtcCW3n9
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 210E860833
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:22 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-843a4ca671eso1097666a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793905401; x=1794510201;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f7fzLdpkbpSKMvt3oI4r6BBTcpyrSrw6CBpyce6Hp8Y=;
 b=HtcCW3n9tsso+QeZrD84CXuhDPI4xicX3MdvWA66X4EbEsz58+b/3qck+YgAwJMhYV
 rJYpH4t9Qe/9l3FaqxclDMRKBw/+zt7MmFDSimIvSRINn98I2Kxo5izGdH5FRp2pn06F
 Rqwl6yNoA++iHGNXxOUyCIJYzA1tKhMfWSzSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905401; x=1794510201;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f7fzLdpkbpSKMvt3oI4r6BBTcpyrSrw6CBpyce6Hp8Y=;
 b=XThswezFixmQdtvFKtUjkJuBbIruAfG+/iX1s3q/ojyA1hRga/DkKaq4j4k5YQGmje
 KBMzOrueZimAx5nW8PQYS/k1uNJ4O1zx2bq4dfDEVHbCsa66WEHe/lwLRuX7tjn9pKf8
 I3lfdXa9gn9ZoYMj0BOyOScP5cWbv1wdmmXlz7NLXodBhbdhnv73AJvX+dTYmZyBSo3Q
 OzYPPNuk1wdgEgg3mybuwLycSGIkQwwWZR+VYgjSF/pFSeoNXe32hv8wbWDoCOGsrWOL
 YfdFzC/hDLQg656pnfDX4DkG8+4mjxNhPtTor1gi9cpTLjdr+QlJbjXJuhCHFB4I1NMv
 9DpA==
X-Gm-Message-State: APuU4Z/1+5r1ZoywOfGmKhGAjNA30+aEmYRBPCUrzim81cFtpURygQ6i
 XInnzlFVfhA2Mnebv0aOiEr895SannLZde3koEDexkHvqVGuOfjFKEgD/w4LqiFYU2FYLoV/GVs
 vl0jLfW6F3w+K
X-Gm-Gg: AYBFou2tvA409NR7oD51OxxqcAVXDg0CUGbmAD2C0zCYCZd+DINzjIHSTgta4YsQsuy
 j8MDRHwU/+X09r1mZTPlFd5TSk6qTsEa/z7IihduPqKACC+FrOg9DC6TWZvZdDt7tDqDi6JCf7A
 KHYkrr2Hzj6yj88T96EmC7CHLooluAvGdU06vqueAqACf/5ISCVs+BJ/xr97m9jaO6PcKyWziaw
 VGHm8izZgZpTTzxFYp3xyHL6ShEIPdQrk041/ScMMlVQB5D+Kl9IQG0PIz+k0IsED0VKC/BBObW
 tJHaYJCVzRzsWL2kqUzSmcAHzFs39c4C738ZHamx1at/LIGDP6XE/XU/RabzwoFKvVXdiC4HotP
 n5b1qX9DjYP0pkBiRV+9xCS5jwlxGqoBBUttYmZfCSG146nuCwueH3CgCcvGWSX6eCDVPGILc/G
 w6WskfE9qU3GEMkmdQbmZyZFWbAvLvFRb1w1YL83NjridHoRk4jIcDqp3PI/Wb0U0WK2kHfNDP7
 5KHF+ly5UsZD+liwik6E3j1iKK5pqU63Dww3xsNQcjgITag5mNA++F8xabngXI1dHvRMgPySOD9
 if8XEEffmh3Q5g1ieDVg7fd/Rz9eQyKR6RnMmhz5ZWiuQNgNWRs4DvaVWg0Ifz2ddLPJVZCsTmf
 Wc7feNKCkbycqKnqNQ8vJJmEyRRYE1hyN16A6Hzk5JqwZK/NwDvYMDrxIHf7IGwfQqoXyZaHqop
 q6RPf8jG3zqNGrVWj5oQfntqVMPGgeiw==
X-Received: by 2002:a05:6830:4429:b0:804:ec69:3979 with SMTP id
 46e09a7af769-85f1cf98912mr300960a34.21.1793905401594; 
 Thu, 05 Nov 2026 11:03:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dd2bbb3sm93385a34.18.2026.11.05.11.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:03:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20261026201101.400702-1-marek.vasut+renesas@mailbox.org>
References: <20261026201101.400702-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] dm: blk: Fix blk_common_cmd() return code typo
Message-Id: <179390540100.1843724.237086552367942718.b4-ty@konsulko.com>
Date: Thu, 05 Nov 2026 13:03:21 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 21:10:52 +0100, Marek Vasut wrote:

> The CMD_RET_ERROR does not exist, update it to CMD_RET_FAILURE
> which does exist. No functional change, this is a typo fix.
> 
> 

Applied to u-boot/main, thanks!

[1/1] dm: blk: Fix blk_common_cmd() return code typo
      commit: 4c615ef2c80d58fe398d538022309106758c2d07
-- 
Tom


