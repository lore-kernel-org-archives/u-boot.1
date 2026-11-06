Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F2606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pVPbgFKw;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rn6ucrgz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5EE381395;
	Fri,  6 Nov 2026 18:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynoWrSEha-xS; Fri,  6 Nov 2026 18:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0CA3A813AB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988390;
	b=JaKkFKgVXkvR7iNgmQKe+oNdH7JT9C2wr2ri6faP+LcpLy4005AOYJ1vi48Kb+DWLBp0
	 CvN7QpxjvkKv545F6AS9FcgVOfGPV4o2GQ1QUQHNoH8SwUsPSUXQCcKn6AV/uWkISztbs
	 5Qvedy4UEfGi+y2gxqyNEDM3YOhjYgSZMQHnxin5Ml/jtH4NPU1ngE46TZK+VPFJ+gQ8n
	 KRlfSzwZGRDAJ00FfXpZm7ZC7ZawvUMaK0QxF2aWHHuyN6w1fq8jDevjsD88XTggY0gOy
	 4x+bEKlcgbOlpBBjk/nV5/J8LAFMRCDZiHWs5RSQ0jwXnxVe1cAaiq2EkFeIS+eYGCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=x6AOV4eRZdgKkO4UnWMacVKelF+BJxrQrpm4G2puRW4=;
	b=ClavLdIr7vo6Y4D47LIz0rXZu+kbQCUshy/SaO/A+3wYPHYn6o/MdfedMrlW2SHFieta
	 nvyjkwNPBkaudi75STgH/7WO3rZpRyu60Z/cDXBZd98GOwXjPrFJlDS5tzXyxg8cIkL+l
	 cqN+7O9V0D8G32RqLw8SoLfSyuYNO+9sMFM3QSapPwGTLuwTTzbb10eg1T46ba6eT7f4b
	 uNaVZltVLydiBF4UfG6bkwMyhSOUb3yTzRPPalH9LRnRtFnZIQeHTvWY40Iv1YEOVUjKh
	 CVNP0VUxZSdsYY0iNQ/4trbw/iWmO+6UQxNdiZaq+7hwzPO3IzjjSUCAGW43DeCvXfw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988390;
	bh=x6AOV4eRZdgKkO4UnWMacVKelF+BJxrQrpm4G2puRW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pVPbgFKwgv3bEY25RGlq7fqQYlxNgfBrGs1D8cVfWd2Q3iyDDWbHL3NKvsgC8F/Vs
	 os0S2UDxK4Rt6A2kYrL6aBkmNR/ngorMr5e7UPMroxSvwSky4uWeL5GDZeRbxSDyCt
	 q2LFwbscOFw/llll9TGjFvzSLiUiUaamgzxvADMHlFDmEfjqT4hDkyO8PXVHTNR7u3
	 WWPWN3w6rfDyJu3YZGvboqCv6yKhavTqmWQMn7Cm1iaCEz2sVpcypGxEgOvenqVfSx
	 Nw7vbe2YPw3vxRyg6kvnNMqvtmWxuBHDYZeNnq+puPnFk6o+OC2j8OKX7L30gmLwbo
	 ax3iikXT/BwqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CA3A813AB;
	Fri,  6 Nov 2026 18:06:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DF8B2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F6D760771
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSQ6eEU6LICZ for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 926AD606AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rn6ucrgz
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 926AD606AA
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:27 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-7143451981fso608557eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793988386; x=1794593186;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x6AOV4eRZdgKkO4UnWMacVKelF+BJxrQrpm4G2puRW4=;
 b=rn6ucrgzhfqTR+1G5vZuwq0mp0sdW97Gh4V6WkU9EgmFdln2801/ZFu6zAKKD2u1xD
 3FAOFbrIrrZ8xcrgX284kaTz6DvfedTBlreWgn4yPWtJ53xkfdUDhIdgQCaQYWiqSsDU
 8BeljPhiac1ik60oJoZcTDOXvj1JUBQbiP2l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793988386; x=1794593186;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x6AOV4eRZdgKkO4UnWMacVKelF+BJxrQrpm4G2puRW4=;
 b=lKXtT3RCCJWaWqH+WpGgRs1uTi7gH6MtvFbdynikR5dqt+havMQ1TF2kFMNU/sWTyL
 6tl/10UF8bZuKQgIsvIJ37XVs3q2M1PpvXgDbkUImdUKwTPR0pgViur+q8FbSRUqbnT1
 iLn33fQyBCYuAXGMZwSJpLB1IH6FindHnwqMv7Qp0H8quUBmCOIn7qp/CYaC3YEvesv+
 mmPaQICseLfn6LfbSHkSjiJ2wBousswTCPScMM4m44vgABCAioekJH17CbpbTtQBvwxC
 uvVNKUw44LURS6rMbM8sl1dp/aPuS+bAfRJDaHPPtAhc7lQ3kCxLSzc2jKDJFs+JYV1V
 Inxg==
X-Gm-Message-State: APuU4Z8sBloh8Kh8N+VxoxNkIjAteoo/wGaePYlUS/HBTbnP6O3aioFK
 JPLPmEbwhpQNKUcjwdXfTlfuZoeXmGy13aiMywIt8dmZ/hoGx027tHBu+7DTeHSzapJeLCnjYLZ
 L8F4ZRSmSR0DM
X-Gm-Gg: AYBFou1EqqkRyNpUn4Rt4jv17dGWgPdIPs7XoPWYeiHPMBQaVElW42rZKO/6GnzkzHE
 DsX3awbzRA1Dof9p5pxXtUOKNzEIxIAwVOQpDaSrtYXxZGCWc6AOIkv2xMJBgzgHCpNJXkGxk9C
 e125B2dSBMV/oN7DFHBVsGVS7RsWkmKedjN2W2IuQ1rHedBgjudjSexcCToJmDJFW+kb4wsP85p
 B2LG8WejzxWLcvKYsCCWOy/IQQS/Ai4BHp1B1g5VUDtJQ8CuW/zMtxNPFA1mXY3PP252Pm9EdB4
 Gx115+WAOfM7Dg3a9KY/14gXiEEbwChvdKjOmFanbA4EldrfK7clO4R+pV+aGBpRRbPE7KU7vxK
 upQN6pkvF/DPMKPPBDb6nuDg1kE2yfD7wzVlM55JNkO7ky7iaMwicqWVpzs5/V9Xglm2Mo6nBM/
 fWgyD5Lzh7l7QsajS6qUEeUSLnf+17RQOzz0YZtJvOGUQc9cp3pZ0/piwUqn6vg2i65EIbkZhJR
 HAarub5DV2WqdZApDc1xwIanSKcrovOHhhnz5m2yFRmh//xDKmWGK5e5XFZpyjadJB3lnRrJqGG
 lzw0oag4I3KflgFGLE64tV+qEUwfhlgj4rXOUtYTX3Wy85kWxYJ7AxmEbETonbVGbG2pLJCRnmu
 0cCX51frMI9Ht4qev5hTeymqtWjSN4nwH7TyAqjyH5WMmtsHM1GUzilZQDE5So7QVIOBdiv83j/
 CYhegeJIhRPZMVGsSPb8Xc3fCLI2FQLps=
X-Received: by 2002:a05:6820:806:b0:6dc:beeb:34d5 with SMTP id
 006d021491bc7-716e77f4481mr1943842eaf.21.1793988386218; 
 Fri, 06 Nov 2026 10:06:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716ea18a791sm2108657eaf.14.2026.11.06.10.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:06:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marex@nabladev.com>
Cc: Alexander Koch <akoch@initse.com>, David Lechner <dlechner@baylibre.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vignesh R <vigneshr@ti.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261024205023.257638-1-marex@nabladev.com>
References: <20261024205023.257638-1-marex@nabladev.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Indent SF: just like other boot time
 messages
Message-Id: <179398838502.3737566.7395451957619888291.b4-ty@konsulko.com>
Date: Fri, 06 Nov 2026 12:06:25 -0600
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

On Sat, 24 Oct 2026 22:50:09 +0200, Marek Vasut wrote:

> Indent SF: just like other boot time messages. Change the original indent:
> 
> "
> DRAM:  3.5 GiB
> Core:  310 devices, 34 uclasses, devicetree: separate
> SF: Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> "
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] mtd: spi-nor: Indent SF: just like other boot time messages
      commit: 5811f38a9b08decfe59f4714e86de96d997a3bd5
-- 
Tom


