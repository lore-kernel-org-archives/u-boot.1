Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF6ECA5FCF
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3A3981303;
	Thu,  1 Oct 2026 09:56:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4D8JE--xx9Xh; Thu,  1 Oct 2026 09:56:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F021B812F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790848591;
	b=ELrW72OIlQbF/0OOscmouJO08p4XZ2w5hWJ+0hnK2Ot3NoBw4ChEZJ0zHZcDxlE3UVcT
	 fXAN6MUn7DxYfEYqTYmg0DUvkoxYp6MZZOWpfsbHrKMd0MFE0cBllLdbuCXw6qetjhx5G
	 Plm981ybKU8kf+EHy1kVjZooBkgck6bEIuVnU+f9sykrfMlFCSRMtwGmhTLXKOWrflVwG
	 kT3/fcLds7Bs8ixBvLuOhuEyjkAsC/ukRlG67nV03HfFNXziNYRwYovrS49atwtTMy4Pz
	 tTpXBrwuLiWKjLGts7Xq2m05lc2VbM8+9p47dYNE9HYuNeFVI9OFXIvWlVD8Ht0R90A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790848591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dG/QbfRgPehSNKpau4mS/jmOlcC75btaJ2oMG8msbbQ=;
	b=bDYfozJrgwD6uCBhgGjaO2bspTMHLgfqomwcnxMEntprZftFTayX/Wji4wkjKlI7zacI
	 fxbHNSvkUA7hvmXsQP+Mx8VtALcI4aOIbHgRldpNwk60GIDiUro2A8NVvkuoskeFqA15o
	 8HGHExWC1V4YmXfzZQRXLPa59HojeNVpD4+vZsgjIECF7ieP2sRAuwXki1v4yUyl20pWd
	 R1HZHoEobF7h8s53QqR1rnjV1hjBF/kwdXqWYZMe1+1NbT446ZRhfUKzs8hcHp+p92Z52
	 9a8TaGsyqTHL9E4c1/7XyZczr8AH1qqXKTO7kMlh/UwhwVVfBgzFCDfV0vXDn3cN4sg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X5XwdiEj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790848591;
	bh=dG/QbfRgPehSNKpau4mS/jmOlcC75btaJ2oMG8msbbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U0W5WhIEKamb/OuRPf4U1VKjteS9cGmkDoO5pZM3poSce4VN+br90stOzfi7JG8kd
	 lnQJBEmROcjrxf8/LPHqgxt87WrbYHaWnuPWwAOpVomAbm162MGH9kCgPtcqpMUPsl
	 nkFew95bl67BTP+UEwnIlM0mElqc/HX4A2r2fPSjsL4zN6zcByubG39wFHbq0A63RO
	 gjxxXsYizY7QzvdHvjYYmZUgwvLtWNUFc+7u+MjepjKdZ5g7V7xfVJskcAUCaN2a4t
	 4KfXjRtBdVj5N5ZL4hx88fiCUAqG0tmLC/S+5Fjk2hup6s6aUskbP763XCJ1wWuPyf
	 6bttZNd6SU4yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F021B812F6;
	Thu,  1 Oct 2026 09:56:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 07B29282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAB78812F9
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQIgJc0qP1wl for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:56:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5A48E812EB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790848584;
 b=dDh+bfuc5yjbAYh/ChBCI8DKcIXi5JBskPzc3zzsq64N87UOtedBETAqU1YtIh3H3f9T
 sbMcf8rQxRQKxBkiiGcBje+lyHgV1fcwh17/zTFaQHU4LxQ3/i4dpxN8lWVVVxTYLz0ZY
 aserPrdtqvg4o9dSYnN4v0IBENGuyGWzWrAibOBhmRmnXDOSURdNRED6t40/hX5swaOMx
 7MolcDU/OLWP37N84xgltx811mfvygZNeyy9lwT/W1WomxD3ILlkH2N90Mhnlvx29KGYc
 kCPYmkpAp1frHInhsKoXi6s/Ix8lVfF3UmNLP/CCIpgb2TdXlnS1JnPfsUHXqHRy+yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790848584;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=dG/QbfRgPehSNKpau4mS/jmOlcC75btaJ2oMG8msbbQ=;
 b=I39D151H2R/bu3QNqUUIb06EyPNnPSRyyfmESINDeQApNDfzkSxycNJPLiNj60yTg35F
 y2E1nH5M4MF4aotAHjmCHK+Q5a0+NXi/3OiMm1I9WqwRZK2mpizSXPHDCnKMeg2koYu1b
 bZ44NI7U97fu1piZ7RdVJ0tTAsFRwdgaBuVin/Sxs+5ZpEy68LtA0felz3tFlOduRGVCp
 xxUBc8u/1WkS0v9yju4nXyh8zHzv22Z/7f7Nl38zl8BwMWlS3JunapR4aD4TKjzHDJi+I
 xQFpD51PizeNZmTiPp2YaWjENKaMIyqDKIYE2aIJYNvlIefutviTSYyJU8jer7ucS4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X5XwdiEj; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X5XwdiEj
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A48E812EB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:23 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so32876405e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790848582; x=1791453382;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dG/QbfRgPehSNKpau4mS/jmOlcC75btaJ2oMG8msbbQ=;
 b=X5XwdiEj2kH0H+sZthXD3w1V5/XQeLIpGZCCDb5bvIx6PJqw79Q5BH3U8j0BIuCczg
 uT4lW70mdMfiQCmpzaKubN/ZugpyFx3BRp1mHIuQd0MQ2BRvP/BGqKzKLkk625ypDJ5c
 /4f7rGlsCuMD/PwL7K7C+uGBF3jLIhQ8G+GwN08B489n/cLZZlOIAvlgqqwIW9XgaGw6
 s14yFHw6msbQVm3O2mG91UOaQV0CAeHKz5j+8hbvxi6jddpNfEzCRtXwxa7gEsRBaT/V
 p5vanQ/tuEGhMxd+m1YB/PPt/WcjsTKxZvK09FTBGkjNkkUr3qJe9WaJW4X8rtjqZPqz
 kdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848582; x=1791453382;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dG/QbfRgPehSNKpau4mS/jmOlcC75btaJ2oMG8msbbQ=;
 b=QbQROL3r1Bg24OF0LruWY8jx3iC1AU+jIrf3LnOK2KjZFKok+BNAU5UvSl/z4o2w+a
 wVBkorKaEJ6iLOxfp0OvQxnVXjIc/3B5s+mUM7+aD0BgcERo0ATKxu7PXUTI+eOoW1kN
 wdBiIvzpg6+r90JsPKNVG4QNDKdvycYQYYfzPTx2YWvV3vsYDAJimmv/mYtUvFzNULN+
 Nq2r1++mVNDRZzeahVhBH/HcxMlX5eyLver88sbXKBzfG8f/BAgbwCkAmE9uG4tcgnJV
 JS9xrSzSjypQsdGuCu5QIWA853YTbljj4ywTtYnvnDaCDvY28lvnh56fC9+09QoRWJLk
 YTYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXZtv1rcDTczvwiJsvLIYxxMIYWbHSfgfvoxTxolzmSuNj74ZlAKT7kWum43PCQUGCNFMuNnE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nBalzvYUrMN4mTVdX2tI2HKs+A9YL4uupWmplklRtI5dtCz1FH
 Ir2DzzJYsAIJboBaMh6pPCxakzQeDULkUzrvDZyWbwaug+nEUjfU1ZI70S9ZvGQTyKg=
X-Gm-Gg: AYBFou0tYtACpQ7eRDFTST9YtdLrY1wkX+QLrhn3CL/8jOqfT6Iryq1OrLgFQUI5Qdd
 MCXIUnwBKJEw22tpnUSBuiY3txq0WJmE3OV0ZS6FxwMW3E22uiaZURLS4FtxEgtC9exnVENzAGh
 m0C++8XwaSwcFWBKp5/KImdoAwBax6YzJ6ELDfygHmBjsLH12Mnz8/VLGEVwBdnBdTM8WkTUcM1
 MFOHAsbxqZ3dD9jL7eytjPy1/jguVM3OmBr8/R2PFx1Th4noZL/BfuHbFifKFwCyq5xkCjDIZoI
 fvs2gVwJUhZTO3QtjqRImHJXqZk5VBy9Kc10xID3fMlGfmCgHlSyryfUsSP1Z/j8JrpFYwtiweP
 Bg3Vy3Avtl5BSm4Hkd6m6HZbW3/eLxIqF+MkPm1vAFHISK8WMET+7SKaCDSul21yl+ZaLs6vDsk
 1Dyh6e0btpe16CbQjWnv+O/+zBhbC4miqz9elaP0RmsJsUcL/GQZhOSKoCCjuu6QpDRVf5gfbWk
 VwhjWwXWtD4YDdHag6Quu3f0Lu58/9Q5FMkUahwMMyBnDzlmTra6hwc2a6tkw==
X-Received: by 2002:a05:600c:474f:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-4a01aff6885mr67049145e9.15.1790848581635; 
 Thu, 01 Oct 2026 02:56:21 -0700 (PDT)
Received: from toyger.tail248178.ts.net (p5b29ec5a.dip0.t-ipconnect.de.
 [91.41.236.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f922ac4sm54012045e9.6.2026.10.01.02.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:56:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
References: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
Subject: Re: (subset) [PATCH 0/3] Qualcomm: rpmh and regulator fixes
Message-Id: <179084858010.7191.2414962273306932640.b4-ty@b4>
Date: Thu, 01 Oct 2026 11:56:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Mon, 13 Apr 2026 13:06:13 +0200, Casey Connolly wrote:
> The RPMh API is frustratingly complicated and lacks public
> documentation. With the Linux drivers being the only available sources
> but are highly asynchronous and thus hard to translate to U-Boot.
> 
> The main issue seems to relate to sending multiple commands in a single
> TCS request, currently this is only done by the interconnect driver and
> while this may not be the underlying cause it seems to be safer to avoid
> this for now.
> 
> [...]

Applied, thanks!

[1/3] soc/qcom: rpmh: properly fix synchronous requests
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e66e895e00db
[2/3] soc/qcom: rpmh: only allow rpmh writes of a single command
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c3342df7ead8

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

