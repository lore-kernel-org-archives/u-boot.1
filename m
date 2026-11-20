Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A5606A694
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oAfKmt20;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CS2fC2IJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44D9C6066D;
	Fri, 20 Nov 2026 22:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNVP2_tUW07F; Fri, 20 Nov 2026 22:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 983326068A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795213207;
	b=cT24a2NJcfhB0VocswicdU3VNTR8Ha6Y10vqGn+6dnJzbhduu93A+03p3phPq/G2KlGp
	 TLsF25XysSJ9Z6lZ9cJ/q/TIgrhkvnxKE+C2z27zT0o7z5Jjxyy8OfRz6/NFgINB89C7l
	 MihUmWs+ljp/BIVpn/eR9gL90XROpuRtrRdwP/AbPqUzrz09OkV/Lc/NjJR8qc4hpFZ0S
	 Nca0tGxsLRohWIUrvkSW4AMpYCtJcHnuTbbUEstCpJIFZcvy/bdzALNZphMpFWFrgPal/
	 oEwUznMufX7Yh5egFQNl4sDfKBAkg3CwNSMgU+fUKEkIPQXcfBRzMUSIL2h4eprAmpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795213207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r43mHC/yR9y88Qagr7NNehxkzjqakrylL2q7WI98Eds=;
	b=MX52vRMxUXFZG3dIKKHACgT6yav4ZcKMZnCV9A6QyZwkmRJVMjdHRM2+u1Wn1ywa3ynw
	 eZmU4AYkoY17t3ZVtaPl3QuTzyt5k1X5CmbCuRRV3KtM5TE/fXSmVYFg0j8AQza7QmNqh
	 hJtYqktDRMFmRgw9JzS/AcbhkL2DEDKAFpYfjfySnR6H3YALmckxLv2dEle55i9EV08wx
	 1Z7/dRxB2yYLGifHXa6GEV4/GdEXzkI9/wsIJAgHk5ITVUOnCF/wr0iExZQIzpwessiNf
	 n825nBwgxIcOGD2RxyN+Lpo979o+QXGpznBhAYzkFLy2Jc1w1vlFRvrWRDRmoeD2+9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CS2fC2IJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795213207;
	bh=r43mHC/yR9y88Qagr7NNehxkzjqakrylL2q7WI98Eds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oAfKmt20rv8MwIsxrTw2ZodAGwzC7AymFj0O0NXa8Ei/fkfHzwvvFNyx7FrY2hlY/
	 IqPu5uZ4VfqFI4tqYgFpmnMSBBMa3YHKz7JlMTtrWs0SB9cR3LUbLgWzPWoWJmUdeH
	 33YN9Zn/gWwQ/iQlUA1qiI+U6vheF87YEqUTwdwcN593rFr+vrtY52BklNsOtmXR7a
	 IYXdvJphrnbXDciA0PCBCFkoIbXKQNdATLKhVAslXhmshGZT3g43ooEhOYnzmUdqzA
	 1R8mp7Mneg1LVCB1ekw0+AZe8LRkOm+ljmxb1/OH8tEh/Of+iO9n/gGyj5IWUyh28E
	 E/6rU1/UEFSTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 983326068A;
	Fri, 20 Nov 2026 22:20:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1D1B9C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87AFB6068A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cEq00u4ySQiB for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:20:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DAD326066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CS2fC2IJ
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAD326066D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:20:03 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-71ac798b8bbso902698eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795213203; x=1795818003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r43mHC/yR9y88Qagr7NNehxkzjqakrylL2q7WI98Eds=;
 b=CS2fC2IJXxxAxz4sPDe5kYjWlQz4x5y4qPSWL/THph8qkwlV808uHZ/n2zV1DtbFlW
 eXs3tSxWn8Vmz87NDqzFRz+5V7879d6op2MiSxojOxeefXAKYQKFPd93MhFuFqF8NwRj
 sogT+ZGlIbZgdWekIV1eYuex0F2rrb7EGqwSO216tmLY9eW1ZP86dObAXu+AUh0PwnnM
 Eid4yfFEazRHvd4qAj0hDmiUKFQMSqohYS2JqqCXdVrWop1n9cto3rCq/SsfvHnBsUXF
 c5bgKCkKyvLb1zm/rakRal51aT/Y2wydQ7xRppfeosNI6EtbhgmAPIAuUfXJw2s7bonU
 XGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795213203; x=1795818003;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r43mHC/yR9y88Qagr7NNehxkzjqakrylL2q7WI98Eds=;
 b=w2keBSYYtspnc/FkE4I9zeSnnl9onHCPAYGrND0Lj0ZaK9vyNS6DBs7SKcNv3kvZl4
 meguocIzpvXLxdzYwDqUaFYx7BEohYLn6/cNMHtVZg45qw0V+pi9CwAdospxWdKLUAxm
 HlVJD1NkJDcMl7DbC62qaH5+6tGgh1WZcpBSCh7ktM02VQERde8xfWKV4jkZdBn2YmGL
 swR2+OjzmZCcH6iT2nFMdTToK4Djyjvnz+G2ubXSiMqj9eo8GPn3W5YoT7A34yeom2Fu
 td/iAHXgF0KC7j6FAVfXPW3HmJzfwP9wpBGP3x+tB+dU4j2ly3f1uO0dzjey9z5hwEXw
 /Hpw==
X-Gm-Message-State: APuU4Z8wcaQlDgMtRkgBL3HOxpvHoGCAykO9T6F/TCADCxbXKG4RIbek
 6ds6XmlGspdQwM+DPKMf4nXGpuPArBD914lal2ZlMLSEKElT+Nl6/svnCzs7cWv8Vkvzpc5sh6W
 7dyXr
X-Gm-Gg: AYBFou20hE3KN2pk9Jw6D1fS90dNNMw2zDtY2fTt+U3qQZ02usNdn+1lcF4o/WnFErh
 TILb2uZ1mc7BZ1pm9XvZ80QhY/1bJgNupsGN4ElbXIcWhVLyw7lT8491WZbsVMml690/xymjYQh
 Ip5NGsLqlxddfI8TGYr9QSk0YBV+0QaVYPyoenlJWgt36iHmbpRjX00rQdbITiUZjJxTkNKr6WR
 ejvkpb12XBGPmGim1C2Xm4c1Fcqo88mjCo0SSKWRcubh3Z9uFr4u0GvXhvBUy0qhNUdq2VlMrJZ
 mBYYpFwH09vdxl5WESRg6KQYGPYqpJFeb6wjkmG5f7fFY/xKq0yzBg+aiImXWbA9uLDu/FOTf/7
 3Rwzyw3jzUE4IfzJZvGBJfT/gdEqrN+1/DH49/oCCBZ0ut/Lb4dq3D0ZJ47YMnU8I3Jm4533XEZ
 AIpwdbcEgHQDcVJfdt3vyNXK3StS7LCC239MLi/a8IWahy0bqXvuW3qAZa8D8yuihI2mVHlPJc6
 nk14aoEf78TKopkzOnLC9qKDU290cqkbpFlZtxI2hK9awOsdhY/XscrHH6rk8ikqtJnHQLB3tQO
 q+B5aiRiR7ZI5jqcqZVJ2OR5t1OkXH/uknyzwzcFU+ZzhCqnquLaXw==
X-Received: by 2002:a05:6820:1608:b0:71a:f23a:8622 with SMTP id
 006d021491bc7-71b395c8990mr3916173eaf.55.1795213202584; 
 Fri, 20 Nov 2026 14:20:02 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b37c52ae6sm2739753eaf.0.2026.11.20.14.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:20:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
References: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
Subject: Re: [PATCH v2 0/6] mediatek: mt8189: add U-Boot SPL boot for Genio
 520 and 720
Message-Id: <179521318967.2216103.1043322294167220921.b4-ty@b4>
Date: Fri, 20 Nov 2026 16:19:49 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5mOn0K/EVLjqj2jEcKKObz/9Vuo9UfMGOswbSXnclBo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMeIVU1cnmZtRgr9LDgRMhOK3Ifpqw3WF0wqb
 aw/SwtMuVuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDHiBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/APqIH/1NUydnAtMOswSAnciDi1YMnsr6QlVQ0EwxHQLD
 ow5I3gi4AgDj9kam4gtQqNh1p78i0dgurPOCzJ6GZMZsNfPVyXT/2Olb7FTRK74ZRcU88zU7csc
 x8PgvvwcwIDGBdZUMdpQVYgSlp7uB61xDkH4vnV1X4Hz4G2ZYxbOiCdcrEAkdtVLwPTOva0Xla/
 adoFMrJCohYoIsocC1J0/jKq5kfHCb0IXWu6hMLxSaD49RHYNz0dXzqt15TPpYsFOmlhUoyobK1
 F2PhuK+a4O4CQIBG1IInGvKkrkSKhdX9FsGZZDWIzMJj5JPwzlDAHxB+iNqiUxcMxCwG7yb//Ur
 2Svw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 05 Nov 2026 11:53:35 -0600, David Lechner wrote:
> mediatek: mt8189: add U-Boot SPL boot for Genio 520 and 720
> 
> Add an optional boot chain for the Genio 520 and 720 EVKs in which
> U-Boot SPL replaces the platform BL2. An external DDR loader initializes
> DRAM and starts SPL, which loads BL31, OP-TEE and U-Boot proper from a
> FIT on eMMC.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/6] arm: mediatek: mt8189: fix the reset_cpu() prototype
      commit: 0c9e5cf52d008759ed137a80d04f77f89110e479
[2/6] arm: mediatek: mt8189: use phase-aware PSCI reset
      commit: d660f598454b93233798a99b1449dd1b940cbb3d
[3/6] arm: dts: mediatek: prepare Genio 520 and 720 devices for SPL
      commit: 4ce3be52bb1ba55aebda7937c0b2f690c1a61ad1
[4/6] configs: mt8189: enable eMMC FIT boot from SPL
      commit: 34e4f445a35cc3846673c5f743ecf22b6020aa44
[5/6] arm: mediatek: build Genio 520 and 720 boot images with binman
      commit: f8398ce7fcc47d57a862b6d78831e90aaded9e6d
[6/6] doc: board: mediatek: document Genio 520 and 720 boot
      commit: 581389e86c2a2d6391f5d0d1baa30e5607526bcc

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

