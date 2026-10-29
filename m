Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196CA606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ENjPJiss;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=f88JyDEI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5D718108A;
	Thu, 29 Oct 2026 22:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WNyWBofdRDKr; Thu, 29 Oct 2026 22:18:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3059981090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312281;
	b=IbPD16Gjpv2w9FuU0Hj13epfVfif6h2fxGtZ/g9Ya+O8PH/o+N2e9uWeEG1o9E3jeRpR
	 D2MRc2fGgV5ZDUqUBLNOf3MPe1J/l7KlVQMk18tHKwU46W5ULSlRoq5cGQ5wH/6jMCCxW
	 eCTZPCwYBLe/47usNCrfgRHInp2BRaohdVIVa2nmVn0ipo5HBz5j5t9kQTIknyGnnrkb8
	 df0sFboXFrI0ZoBcNjFK1xuXV+R7MroAsA+Y3YZtDc83F65cwR5U7+teNite0t0kAkHX4
	 r3rZH8a02DEzswGmHUbDvMHVkfKH353TgpeD0VHrJJMDqBXX8N6I7D/A3Dj3s2r/cxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KytWaVTJ/aU9Am8PyGshXRgaXhF66DN9wJSd14CIM/c=;
	b=PeMORGRtOigSIvrk3Lppzmsn2DLoWg7hIQDsVc3ak+bzkVqI28+JX5iziX6/jnWxsFnZ
	 ZEwFX713wE/prWGddoxQTl8f6wmiarzecxUoFZKxR2WS3oWRzRqpYnwDP8mONzjo9KpH2
	 CAQeOnAxe10nze4ZklgX5wjxjZDrFIry5ttW1HfDX6+gIXf5dEx3nMYL55mSiQfgV52/a
	 pqBOU/apG6AO8p3v9arO9jueZrNtWq/qo7t17ZOuurxJerRAjspqhEJNImyVOMhtRciVg
	 FFhCg3EaS9HJjwRSsfKUzD2tKxVLPnvn8mVNz8UIFB5f1QTXA/OOzns0B4FfSeSQvQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312281;
	bh=KytWaVTJ/aU9Am8PyGshXRgaXhF66DN9wJSd14CIM/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ENjPJiss0LMYNUtq161z2JBOqgDoZVD0m7/LXrh7bG8FGoB3ZPdaCggoRANzJbnKI
	 AILm8GiGWbGTP/qDlH6U/dEecNfzOq1hMktDgKeFKSElNCYT8AI7kRSDloZyl4nTfl
	 gh/91AUdkablQ62/TwY3KCPj3mukLcht1YTdm89iGx0oWhz/M9B35/Z8h1QjHUTFYE
	 nEre3LVeHBqZHwqZJGrRdYKepm6A07cR2FM9CAjfgvsH5r/KYgaSfh5K4vMq8z4uF7
	 wzqeUsT7XyOUM+salos+8bU8Fje2hvyJiK26JNpsBWkgojwL6dIjbkIV0d29XKTj3u
	 acvixfjkD71TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3059981090;
	Thu, 29 Oct 2026 22:18:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E586E362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBA8F60A79
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVsFrTqaDeWV for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 15E3960A78
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312277;
 b=LvLR8lBICvFVMPRSpQtrT1a+kPe9JICpduexXltTXbzICtaVtaLkt4WWzwDTekEl2Dzs
 mKnu9xYmP6DdxJzgWMWYhPVDPJcw91Tbh1xVYqMMrpKOW8LhB4gJ0DCujuaLvYEAGuvBk
 VZwfqJul2nsdyxZbjQQJXflXkFkTb/X47pBwzu8ELgFHOFu9OXJ6/CvnPLjSrvXDU7Hd2
 JCrbfRNGWoOjATX2Jdta/uXHL0IkatEe2TGqpQc2CP89UYlyczSTJgy0v1uRRqrjhNn/P
 fY4A73uBVp4rNLgCcPw2HxGvc6EtkdnmAnow4yUKNZ1koXui/QMh391B1oyOlgIyLKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312277;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=KytWaVTJ/aU9Am8PyGshXRgaXhF66DN9wJSd14CIM/c=;
 b=YZmQHTrMWhAv/8AcE0bIObrJKAlTJR+Ohlc7EiD5gwNO3NsrlseqC74c49wpC8FuoPWs
 h+L2+lbsfWcGOwcs4DfjQWW0aqy9GLxMDATFE/kYcNcujX6jf8d0t3pkZhU2gr+8Hv8jT
 HeftYvEPvc1++BE9xL2B8jayKXiOlamCHbMnSuXubNxKDojwiBURq+4cMLousaWTuZD6F
 cmenTzSRZuFljPjBeq7jgrFMn/XZe4pfEuMD/E7BsiYtvH3TfnIJRVEYWw+vpSQkgRnAy
 DI+afy2LzwKHSk/vMWxAP05HT2xwN9v1LKgdCXGxAGeru/qpycC6eg++/wzT6NSM/rA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=f88JyDEI; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=f88JyDEI
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15E3960A78
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:56 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-47b47de8b4cso42223fac.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793312275; x=1793917075;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KytWaVTJ/aU9Am8PyGshXRgaXhF66DN9wJSd14CIM/c=;
 b=f88JyDEIZ93LKCU8VkqxRID1CL2/1ILahxyh8GgwqU+OeMWJU5R+NEGAMVkRlrU25y
 woxCE85x8nnPPpwT/RCwIlHNBS3rmRlg/Aps1HWGfsFvEWqVRpUuUBbLPUnZiQwZXhjD
 aP+0ciefuywvuo+mlaPSj0jcE9ny4EK1UE5qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312275; x=1793917075;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KytWaVTJ/aU9Am8PyGshXRgaXhF66DN9wJSd14CIM/c=;
 b=uFe8cNM3mVDfkfwelfUi9XYUPIJUSN/gz3gxrTr+BmT5YVCd3ap5RagAg3K5cNWDTi
 JnyzZvPy7KkXFTk+i9B6gcqBF5hwaudEvWLPudrKO3BDFhlKApD7waazP+3DKAlU4AMt
 O8SCh+SQf4NDpjRmICgu+UMv4klj5A/LKtcSzzEa+ucvJFCQQN+y3Q1OYXenQ9qpletc
 1f8H0uxlJC/EN4bJuOVgNDVI7c6Te43X73RwTcTSR04rcvb2hTuGFR+3AxwuseJCYA7Z
 VHmsd94DusA+yFzbVlLriS/AscXtIwdU83x2mdNkHYP2sjHszxv5RpaJaqFn5FMfb4Ea
 crMQ==
X-Gm-Message-State: AFq9FYK58smBJD4Lbhnp4KnV1vZolMNJHDtU/YGFclama29DpF/1z5wy
 +d/5x44PnKmbycMjuuLo+vCM9v81f2DXrvADQkhweOLpBpto09eFxBCsTvHXEieZV4E=
X-Gm-Gg: AYBFou2UTor3jh2Np2rWeAKNRX+kO+XffwcgHtl2TVZHRaM6hlxCkqAJJMsU7r6eMBe
 fSDTM2Mm5tYPgX02LniBBZjwPaFjt8OEx2L+Yo4XwlknCOFuLyESCBVy6Zye9PEHkaQEqIKFsoa
 4bQnmcdrb+AQYLYdxD+uoeaH7uuMyqY2DHKvOKzwCCcC/y47lmno8Ap8l0HQTHbggwS7Yxo4QLq
 MAFTrmBx6M4DJvRBaqieOqjF8oVO8+AmYTsCFg5Vhr5gP3GeYM7RqYfS7wqjtcEnwYSU2lbTgrY
 wX73uSsZ8kYHeGNcLfIszaFJ3kFHaTIB4FzXYvpm7jHXySLl2qnkNakAfMisL6BRthgqKf4s/RL
 Xr952i/p6kU0O9csghoxm8S1fn3MPnxwuRwIQvm3XRjlt9rDNy4kfxfTs6dTIlxmb5mVqhag76M
 BgauHH8Mupzv9M2XRvL4ZG5SitieDPFExVbkvyo2X4h5QxGKw1yYgvtcYVW7OwvxmnVeWqcjVri
 9SA4UOo9Xk1irKzWzruckTJlkpnAsxn41Lgln2fPYN3II+RKBlrulQ8ngQsiYRvENIL7IDlUJS7
 dMlGWSBKtWMYMJ9zy/gwaB8a1NVb/JQvkVHVv/JNk2ApUUkiZc0Ufni+W18vQvVWFJH2Q/eH/7q
 nXbhZCbgvimyP1o8CyJtrIwoWAWk/LR+FGAKWgNShTtR101IdG2Hrpdc4X7HEQs2lWZOa1+iN2I
 jaEUhhhSA2vQvFpwzB7cG61ZUE+8H4Yw==
X-Received: by 2002:a05:6871:82a:b0:4a7:42bb:9af6 with SMTP id
 586e51a60fabf-4a90774f076mr356995fac.39.1793312275553; 
 Thu, 29 Oct 2026 15:17:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4ea68sm119005fac.6.2026.10.29.15.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:17:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
Cc: sjg@chromium.org, anton@binarly.io, pranavkasthuri@gmail.com
In-Reply-To: <20261016081719.814357-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261016081719.814357-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/5] tools: mkimage: bound external data reads in
 fit_import_data()
Message-Id: <179331227479.3078583.1677511243990718227.b4-ty@konsulko.com>
Date: Thu, 29 Oct 2026 16:17:54 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 08:16:22 +0000, Aristo Chen wrote:

> fit_import_data() reads each image's external data at the offset and
> size the FIT declares, without checking them against the file. An
> offset past the end of the file makes mkimage -F segfault, and a size
> running past it silently imports whatever memory follows. U-Boot proper
> and SPL already bound these properties since the series linked below;
> this series adds the same check to mkimage.
> 
> [...]

Applied to u-boot/main, thanks!

[1/5] test: py: keep the external payload when editing a FIT with fdtput
      commit: 2db652e41249b6c11c12d251ef6d82ff741ab0d5
[2/5] image-fit: check the length of the external data properties
      commit: 164a2d9c9533404559cdd1527be7174a936313b5
[3/5] test: boot: check the length of the external data properties
      commit: 44c6d8c287bd21f9ddf6c3b2c657ccf380a67db0
[4/5] tools: mkimage: bound external data reads in fit_import_data()
      commit: f8b5bfc60d16cae86dd2fe49deb1bcd146d24f10
[5/5] test: py: cover invalid external data properties in fit_import_data()
      commit: 5da0f00c237d50ab82de59d1c03512131979fc09
-- 
Tom


