Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00594606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IvjrcAZ9;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EulcOlbo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE8B0605FD;
	Sun,  8 Nov 2026 20:29:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2tblCY1Yjm-2; Sun,  8 Nov 2026 20:29:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30007605FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794169785;
	b=lSgusXC3019yM2GV1deUcFgeiQL5KNImUFUi/qhx4k1LJQifQ4eoo4M7m1D3x0poqJJd
	 a7QyUgpKge/wW370IoHkwGnDkxz6/SxzbXa7SJMUxzkJQTeSV7nvPVy2p4E9KMzAeXij6
	 74za5qG9MskJjvfiysezR6VCEj+7TYkgu5oareMf4c9nMoJqDNBBHqIZ7roLSKkW78OVo
	 Xuj5A0Exzk4iehdCjrZPSe5gt/xGDEbQkXzOcBcffzjkB0/xlo5iFr1Ve51YxWcQd2qup
	 ZDsW5VPeO/rrF1T7D+WKrOR6vCpu+toB7ux/ZfqbKBPXdbk6EQJ3//869t+kiP+M89g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794169785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+WIYanUu2Mlph33/83kcgyniE/coVfBVG/vOSN385PA=;
	b=Kw6+3J6Bq6un7WKl8lyFpkdpN3JSg1yTyYa5frJSRWSdqp3Wz9y5X+HObn1i0UocbfiA
	 JXvkr3cDWXujx4M4I8ulDMFRtMmBnBZQNHax4toRPtVRG3oFvTZsgzgJQQe23XQnc7j7X
	 F34J5dvz7SbVz6jV+/5KJb/49bafv90nnDAgbX9LEnV6SIXNs+pAY/8tc5bDNdSIMFVEh
	 0zict2mGSqN9D9qDQyuK+cPJLJnwtnfBAdfTy7wkF5/uHVj4FHBoYU8qj4GMOzTjvvt2G
	 4rh7umAxlEx5mh7vwJVeA6EoJGvg/TKQDm74t4DaxByOXHkg473GoH9fMfGmZQnCYbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EulcOlbo;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794169785;
	bh=+WIYanUu2Mlph33/83kcgyniE/coVfBVG/vOSN385PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IvjrcAZ9WmD6XldrkSZtcIQdM0aCnE7U+F/PYWLhq1tEUH9A3bo33LEIwPUzw5qUa
	 Oli26es1YeTl35d5HpSHu0zw5O+UZ6Kc6w/I7gqvTUu0slB2arQUx+2CzQU1TLAPOI
	 c6uu3N7yolMQbkzD+MRD1HD+1jo604zzOF0pqeT6MQVwVP3+Zp2QmXX/1901g9yPiB
	 5Ef+R+6owedzoud8BuXp5hUiLlarqMOfr/HOUYNy0KkDwQfsGk54uXxcq3mMvyffFz
	 HoOlYSBUgByRdbQRdVa8LKPi5mXZLt0j+PKS/Z75MF6oG/obnfwSUgzj8ylxlwgffk
	 +/euXcvRcH+eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30007605FF;
	Sun,  8 Nov 2026 20:29:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77055317
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CD91605FD
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:29:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id em7KjW2Bw3BX for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 20:29:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 227E2605FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EulcOlbo
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 227E2605FF
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:29:41 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso223526f8f.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 12:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794169779; x=1794774579;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+WIYanUu2Mlph33/83kcgyniE/coVfBVG/vOSN385PA=;
 b=EulcOlbohENJYLpxEnOx87MODkuzOUtLZPpPU7Q7Cv20bLeG0cA5unWna79KLNt/JQ
 nZrOzhVTvZFhwSudnvd3BsptVRvboEZNOYYhLIiBPlSvu/rDzHsMPtRv/Bgm+kZQnDeT
 UHrwAEMXLL3yB6Py5q/QTuCXdqqHyoXNuWUK2IxiSHc6pwqIutTY89N7oUGoeJ2BZNd6
 /Vl1RQZElDCwWK0CQjHOiLCKBKOgYDN6R0mhIvHEK7h+NQHI1os2qTakX98DTkAcAT4B
 g+sv0VmrAfvQ9ZB9NhV98gap5nzsPTmDCi3Xwg8W2wCrwVVmZ3XCroU7JEndA3baQbg9
 1vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794169779; x=1794774579;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+WIYanUu2Mlph33/83kcgyniE/coVfBVG/vOSN385PA=;
 b=gxRpHWtjsguVmxwZbXt4WYzkFeaktTS1l6NzfJgCPaVCqmQHy+pJfZKzd0iNrf/i/S
 wbynpr1H4iWJYxpG+JVxfaEMkieTA6wO3sJ//i5g7OJ6k5Oirz54ivg14Uj9b3gF/Lmc
 6UnQZasDhTVwb/Phf9tRAw8DS1ioP9Wnrl6ehucc6D84jaIwzU78XAmgpyVL+jYWhm9Y
 PlY/yHdAA8z/WjXHDlwu0paV3/uLR3AH6dZQOGF8PPHPoMGCi2ualkowPnkQfdkSYuEO
 wvJfK9rZalDr020pM9pO9r6XjtRRxv/H5Crdd5/YXDkbKEpd7n+81swZQAhylCZf7Z1V
 IrSw==
X-Forwarded-Encrypted: i=1;
 AL+hErEGqs4rpKdSgoR8IEi9ICA8XlsOUIweHvVJ53DqHpvRzdzpH6sMrhcQNkp1pp3kM2E9Cnz5b9w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/40Wp+Ug54myFFOrKt4dlzpCa5k8+1rMlR5cxxO4I+o7ReTnyi
 L0bEzo2q9S1EQB85MfpWZiQEmI+FY2t4dvvJLNQBVPolyqUNDZQhFEcCb7GgnMtphMY=
X-Gm-Gg: AYBFou0Se9PefWQaFktkU27XdQTF5AsmohfEKKrAzb90Dj9Midq5QUwA+IK+zHZbIv8
 NKfqzbmUuy4jBlVZ5EJakDmCx6WZAuE7Dr+prejWrKduTk5nH0tsimSJ3WF0QbabEufTY7YdUi9
 hR5BWxW0RvXIqOIEd3HHlrfQWvBDqoK+Pi7L8/CDZhSe59kWQ7EROBv5Dvt4XoKWiLz5HZAmXWr
 ZoVBu85Kkkp4abruGQKcv7WoKjardKO7cgdNGHofJRefFdTW+Dmyp7iWa9Z1y0QjZk3HrMoWFSQ
 FwomPhBIUs+AxX4tONSDvWhDfxSF/ksl28qhP95afhe0lyZlcgdtSx5tDhnS3FF2q8/HEdJtUvK
 DQ11X4TFyv4qT6KZEV54O//vNSK2UXICKgOTHUrz+9yCBS+pYlvUjlFrMTMGWl+zUpSDyFtX8vz
 J4vujDs8jPjB7U+DJdAfbWqWlgMZpfiVx3x++CL5fTAKyfsSX5YEOt/Jwcbhn+Do1Ce+nLb25RM
 OE9IAefD1zaRTmE+NibQKWdx4CI3m3KdhvzpyyBcGxk2f4/sOsVMTjKZYeIDZnzRYS5f9IZsunV
 /2CvReYP8uTJirTXPtHJomsp24pKaC8FpE9b7WCM1O1+F/e+wv4w2xkZQC/764i4VcTEjrgU7aA
 61JUJ
X-Received: by 2002:a05:6000:4614:b0:490:6e0f:a024 with SMTP id
 ffacd0b85a97d-4958ac94f8bmr4182930f8f.13.1794169779620; 
 Sun, 08 Nov 2026 12:29:39 -0800 (PST)
Received: from cheetah (p549d4ba8.dip0.t-ipconnect.de. [84.157.75.168])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4967003fefbsm2140986f8f.13.2026.11.08.12.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 12:29:38 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Petr Vorel <petr.vorel@gmail.com>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Sumit
 Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/1] doc: board/qualcomm: Fix kconfig formatting
Date: Sun, 8 Nov 2026 20:28:58 +0000
Message-ID: <20261108202858.397462384c768928@pwishid>
In-Reply-To: <20260909183222.220855-1-petr.vorel@gmail.com>
References: <20260909183222.220855-1-petr.vorel@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied to u-boot-snapdragon/qcom-main, thanks!

[1/1] doc: board/qualcomm: Fix kconfig formatting
