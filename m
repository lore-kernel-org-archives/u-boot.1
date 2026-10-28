Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056E606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=djtmIOLR;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gPP4L0do
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 517FA80F24;
	Wed, 28 Oct 2026 13:55:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ot_0aa76TEOG; Wed, 28 Oct 2026 13:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 620B880DCB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793195755;
	b=fXSV0QwVXyCCo5ck9GdL3tMKIiR0U+sMPpXoCJZOCeyvQzcoCBptPJd3kFw2+b0168Yc
	 JZeWsdcwxm907CaYThEkr34uBz0kPKkJgRt7hx2FdvImKllKd6VxmZjJIvY43LiBGjk0Q
	 QWKsP7CdJyPQb0bZQuUGWRm2FkRKjLqlMCv1mMOq4sm0uooXvEKHSWWhuGcgKSNeAa2+y
	 EknC6/XKxNtS3G/Jk3e9guL+E5ZdcmSV2Vm60N4+wJyZpI2R/3AgT53QKtEiYWZdMrAyr
	 QTw4R97BRAviuYLjjko7KyFO8/4yfN+usQx4vcDqq5QDHfXQI2iE6tzF1V7twj8vAag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793195755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oY1Xignl82lTjQZBuSfonNJADViWBYuypYQjxR3PFUg=;
	b=raKhnWRbZwOt8IIi0nALCzlWjzOCesfR7aU6HjNAkBsV6LXf7OOHZlOtY9sUKOqYb4eM
	 0MR0El9R7lr9PCcD1C16LqSl8GejYPY3JrlX9z6v5sdDfrPAH+5vho3cQ6e5qjYdhSnnS
	 GHFpHU355gYwsGS90r+IKJqsHNkY+N5Z62yIKuCpz8oz/5eFjtrWeqkziiP26YnRzMI0Q
	 BvGXa8HkzPNPa5YWBsFZgLrc/qn9YyOgAS4S5G6S1r2CNcVh3wwvN0gPmlHHEPG5mypue
	 eo/VARxrixUVgHcgdZ6m/lkES5CUSfWx/r92COEyTtnayeicKlyZ4e2GJRVYQ27YDFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793195755;
	bh=oY1Xignl82lTjQZBuSfonNJADViWBYuypYQjxR3PFUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=djtmIOLRUpXRLPEFZK2C+bcFq1M7SUEgne5/07k2zFnfw3XnojI295B41mmD+zROh
	 fdccIcTKc/q8W74xq2UkxPYP4vB6C8KfFQBiky/V0dW8O1/AyeNOQGnSbh+i53JQ0W
	 DGTpTl/gh5bsuHmM4a6WZPpcndlkLcesLgKtxlwaYfyTm2E3DYQjUkuPIAM/2qcrde
	 dV5X5tikDLRyMmK7bivACAr4FXfQ+fSSicMxAizuoj1LJHd3HDATFsVNfnx6pcHTqL
	 ltZG5FK9RWs2DFLZ6XaSCyFqtTgXZ3Zv70j2cT1J2wJCiDlc1s6dqeGgUu3vlTJTVN
	 KMccN8wWpImOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 620B880DCB;
	Wed, 28 Oct 2026 13:55:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA1E24D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFFCB40585
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cicpILFCaRFJ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 13:55:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A51FD40560
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793195753;
 b=run1dp7Yy3dqvwlh7kYljhKMsb9ibRFc78eLnBk54dnoIer5JcVVm8EsIk7Ll1SPnrlc
 fNNBySpQL/TbHMDGsDSiyzkfu40KpsJvNYvIxl31V5y6VE2ssTF6yPDd5IETXX594YMm5
 6PQ0B6ZqI8MwX9djRjWYIaj1xSGaHj5nVWobQP2RKmCe4wwLrnhlhoiyn+BRrHGH+az3m
 9Ex0yWOV9g095tZzZDyD5Fi5ioyl054Gpd8HhlL56MBFno4BPRshZZTTK9KrhTF11WgqB
 bXZthj4KKVE1LwgDHOkyqT/ROTMKQ05t7qvYGlZuYTfneXrvYFFRIqTQHUPgWuHXicQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793195753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=oY1Xignl82lTjQZBuSfonNJADViWBYuypYQjxR3PFUg=;
 b=d7fXE/oCSDX2YpgOhACpdUkZwr+VmHX+qAcuIfkJ0mCpuB5Uxa9Tkx83aPWiGJVNSA0G
 takFgOaq0jCaZeQoBYfXF8v9saORMw0DQIJfa2mEljgGFRmrG6IRcvTDHn6sNhrXeS/MM
 mGgoJkgtqfYH0q+lg6LbUdcam70Zb+vfnYfSCg3kob5yBkgVaX1VGL5WQXAPWuR1mQ3/X
 66Z2b31w75rB8bRUnvBoJzyfJK20T57W2kJlwD0m+XLlqtI3Km7v/1pXTQ9e2fpynYy0l
 +G4zgcn/H9b9QdUWgiyhFwi3w1iBeWMO+oRjmG/rty2+rVSoBYl2Xcpk1c9dyuGg7Qw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gPP4L0do; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gPP4L0do
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A51FD40560
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:51 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so8833925e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793195749; x=1793800549;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oY1Xignl82lTjQZBuSfonNJADViWBYuypYQjxR3PFUg=;
 b=gPP4L0doA+IULHTNgF+Xr4zJYN0yp6O9U/a6yrbgbkykoGpE4MTlgwEY5udVmzYW9T
 eOmBfsFsEGgZUDl9xnT56d1lLON/b6ID3wlMJWCOfkw9aLY4p8D3gOuObSMo8XScyxeH
 EdoVC4OYVTTbiZ4FrRlqPFR5x4fOH3ltNbaxt+pwHFsUrUr1ZOrPUSV/xMeiKByOrH1M
 m4VswdvEF+O2wv2wwnDfLjThmwLAPDMeaSqJbxv9L10oAXKNXaesJ/vK9weOdVH5U60E
 phObcwxt7NUptHFysH3KsiDQWZiVO/yHEdSCXAvaWpsTrVNirPDy6GyzRoxtIo8CEWUo
 tuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195749; x=1793800549;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oY1Xignl82lTjQZBuSfonNJADViWBYuypYQjxR3PFUg=;
 b=2idaT7JgvMYLz7swqMM6JVNCuILFrlab8ks1+Vfs3FHgYXAbbXdUEsXKvLWhYfGcB+
 hbqH5i5J5Ji+z0QpL9I/a/LI/oP1fVZy+ha21Dpwhx+TxhplQGgbgkzO+p6rVRsiiC+E
 QOHUrVelfAV67tpUDfm0Kwyb6dCWxO9ERcu4seNsyu4XVGyA2Kuc1ybSzfYUZD7e2R1U
 9TVEOKbJFKXLBu8+HLXRigJaEVbM+v6yQjbNnzreeDvG7sk9KxdWSyhKgyLzeXHvtCJ6
 UpnEaB3gwKikdARKmsPpzPVNRaMH/U62u6B+NQPshD9BPtP3EmVvhplFyQ4PSkpWREzM
 sb4A==
X-Forwarded-Encrypted: i=1;
 AKwUvByhftGDiDu7h51kzD0iAhscNeqE9WGHzYi46kgKk2HVggX0gNrEqZOS4LygYUN79TEBwNCZUow=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLHkl6Xa3lr2PWhlgZUfrHiRUdlOoegoUWVdUEhQ0cfinAtwcNe
 TzXt/pNJlefNPCPfVQwClp2KZCDOcPmCflNTanLm3e8hwJa95DjkayLeRpFr5+4FhRiFNXXYfPK
 Dc9XyKbc=
X-Gm-Gg: AYBFou3/BcZQk5qeNZc6PZ/F6+jQbfiO5BYwY8Sw6HGsGP1Cd4KaIMjsjBXez+dQHtQ
 HcqZDcQaPljDcgBgFjPdo6A9T5cuGguq5Hw1gTPEXooHxrgIU0FBJQ+RemfKknmG8nOIeZBT0Kh
 1ZSHJ8Cy29rRJoJKUG0OXm8F0p21nNwNwbmbn/7Hq617C0ELbi64stgfKSQf08NH7CFx+9xe7Pl
 KKSv5lsPazwxuYHDfhNFKIlcSE7chgzkx6zI7pZ737s/1y4vacIlKaDoaJBL+FavlhLfzzYJ3B3
 AMJhRTYxeYh5kGOdIfRwFYzT/clVOe9OSb3KD1GWxI5qhYhMie9iq6jXH6S+ElQppK/QRmdZwlj
 CvcmJKJQkEhmwyiNpDT2RPRj/KHyrX6wjawXRljMtc8/AozDijHpH+eIfqGLDtnbZQh4vdVvDzp
 NFAG9mmjPebXnKZcRpFu+vZfjyGsOJqZgpHmeeE0xrokvLb1xZNOIhDJpV4+gR9UPzl0b2Li3FF
 dfpojpWmYWCdxzbTdQcGefnGYuBMRfbACaMEUMmWDFaZhCT03ueOoljAEWL8YD01m8P5+bJWsaj
 GWEFPRXIvnE8TLef5F/obQ1IcKZmssZ/EsYkYUx0mJrClDY4eKGvyaT7zCCStyZYpGmvi+GGFps
 WvsqSr4zepm0DAaqr
X-Received: by 2002:a05:600c:810c:b0:4a2:392:9de2 with SMTP id
 5b1f17b1804b1-4a967e8d6e2mr52243385e9.28.1793195749156; 
 Wed, 28 Oct 2026 06:55:49 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd35c2sm28111848f8f.39.2026.10.28.06.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:55:48 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <wv5b3tzroqen7ub4pellbt6ve5yr32abstibji3nhrmhwcqujr@67vo2lnty22y>
References: <wv5b3tzroqen7ub4pellbt6ve5yr32abstibji3nhrmhwcqujr@67vo2lnty22y>
Subject: Re: [PATCH] serial: msm_geni: remove unreachable dead code in
 pending()
Message-Id: <179319574773.1318768.4861106749387543538.b4-ty@b4>
Date: Wed, 28 Oct 2026 14:55:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Sun, 07 Jun 2026 21:08:58 +0530, Naveen Kumar Chaudhary wrote:
> msm_serial_pending() has an unreachable 'return 0' after a complete
> if/else where both branches already return. Remove the else keyword
> and the dead return statement, simplifying the control flow.

Applied, thanks!

[1/1] serial: msm_geni: remove unreachable dead code in pending()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b840b5bc4bb2

Best regards,
-- 
// Casey (she/they)


