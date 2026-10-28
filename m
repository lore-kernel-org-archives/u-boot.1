Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E03606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XL84sdRZ;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yg0XiuAY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 215698117B;
	Wed, 28 Oct 2026 16:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TK4H6sfBgh_5; Wed, 28 Oct 2026 16:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF91281161
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203309;
	b=bx9+yHguZ9CECDbElT//6BTIqxX2DwhLONj8z8L02KxFY6FtS5L/lRJH4HSHXLnhrmF8
	 ZIR+TzXbbF4JPVCvmW3UZcY6/UrRVl3qgtPMB8hEj2cAJs60N47FsZTB4YaWxYWHTP4PY
	 xON3euSSl4Z+z3FjdcsOBhqijpT4PV0GJwcVtEaZ2HutMwXPWn00HZ7+AeS9d0IIRtf6/
	 hT4A4hLXZZ4t4PMe7OZmihnAaqagClNzPBYxZAYrVV9CuJdwshwnv2s1YsZkasnBUuGmB
	 n5KwYMz3W4N2EaPcS0YXy4mopcmlkoFCWOPO6I+PQIlEIaGLL5MAbHzyzW/5wKZivpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LB8bfSCAYke7LV6jDnoygXHb2uC94bQ8IqTVsAMgmBw=;
	b=oJVP2mzPVNMRQ00AlJ97skTdUqGrKEKsS0qzA1MrkmEXCGhr+QBrwSKiU/e1TrpqNOZw
	 QOHEEEtMoZYEc0Oo2lRKC+GQ+/s7Y4up2ZjCUgJ8xId+M5whRA6Di4uGsOLAOGCMK5QEF
	 ayFOIc1Ejy1NWaNOk+bO50m4Bv0vzRbyM1eJAAtt9dtHobiGYskdQ4K/SNoYDNIExVlZ8
	 Sxkv6TyY8BbnfagNEmTQUqL5DDwbJ+lpr7hNuTLQdRZFayB4t/bhxUO/CLC6AAG40ecaW
	 Qy9nlb3e4Uxt1Pp076sLexYNji1or0eFxRAaiDPFHkLmC+DChxJBT/B/UI3YVwyKuAw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203309;
	bh=LB8bfSCAYke7LV6jDnoygXHb2uC94bQ8IqTVsAMgmBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XL84sdRZAxb5qRk3xGVvzxsXSvVeu4gv8tdJggCiw6PpV3gNGXRk+GghJJjRTs5vy
	 eH5vIWQkZg3jsm2tG2yS336N1NGfF9Xyf2P9Ift5DuBuG+UxiaLGRSgOFqjE1E97qR
	 Qni21av2VZIyVT7/2xsrK04AUNfCRAdnjpQkku6bxTP39j+Dh8jWhzdBHMw0sb8EKF
	 rm5H+HZqzcvnxMx8cOqJ7Xk104BQOdLBWimccYGYVHy2iDAGR3nYCYMGyaonJ+zmXO
	 nYuVV9sb3ll/KzvNHmoePyYhsGLfUqaUiZ27MSZknHIC746y+nc8bLvPIgLu9DXpqd
	 AQRdirpauN95g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF91281161;
	Wed, 28 Oct 2026 16:01:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DAD1380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B288400AD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0Wo_LhMXmLd for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD18F40071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203304;
 b=hfaIQq/+4wJrs07tc/xp+FiQRePalvydf1sF12rFbYC4jcVYtWSyanbITeyHPdEhg/h6
 rA1lQCBodIwCvgXxYReqej0ua/MOuB0Xbyxij1bGZ0Vl3rW85AuLT4K8JMCK1T2zNL+O2
 k3hmuzbOInyqZe/OIToIOiTUS2zE7y/pMa6GVMgUwJT13zm6vlUF+zV/LesUbENa8VjSs
 ExxBY+LVTXTmCaJ+LHUCujCd4kdMkKQLdpX+bdrdanIJlJD41wLz1UcA1J/VCnommTnjv
 w2LesKJo+uGXNz+dOImvsxoZPiMdGCZUs16hWScFZ1mQWs+b1bE8D/B+UMjL1WU5LGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203304;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=LB8bfSCAYke7LV6jDnoygXHb2uC94bQ8IqTVsAMgmBw=;
 b=atHRumdRKHqFTKO8LVrbGBPZ9v4RXt/3+O5Z/gEqSFeq18a6N0pW/idoPnsUnlkrUrZ3
 OcEyxu+HuvHP4mH3O1PRvNbzS3ZvF2shc9A0tUy9fU+dskrGuHGpx3niA/Ujbj58GE9IH
 9IAW3BHRsgcGS5tgI97VxJcLanHygTZGkqa8YW75it2WasN1vgs+K8LUu0wrFoWJsM5kE
 zlYU6xJqg8/ZRUZSIsR6YI8OVy/ulThx7vpEvgULlWw20Eaz7eo17+RVJYcujRyr+45SI
 j4UuJqWTlnQoEMLCElUOBsDdMvY1VB+MPyT/EBr29kdaLYvoub94vyD5vBSYnWWPmxQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yg0XiuAY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yg0XiuAY
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD18F40071
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:43 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so8665635e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203301; x=1793808101;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LB8bfSCAYke7LV6jDnoygXHb2uC94bQ8IqTVsAMgmBw=;
 b=Yg0XiuAY5/alcpaSztbgrRhwikJTh1M16e13zB2rQ0BUP++3VJfxCELXIM/Do0mxLD
 QBhaNfXf+afnRSHjqNrK7T+XpwCiH9b3Y3q2OugB/tgaBVIsEQkX7XAzwUB46E0rt53s
 EXfYU0eS4860AzKh+75mlkXFsCpEXleeQJpVW/czl3YMRH0sZPBfQLpm+tXwidCqx5PO
 Mm10Nic7O30U+cQAR/okEpKBk7acbOPgfu1nbKtKyPURcjn9zgVNHXsrjuFEQbYgx2nF
 ke5rXNIW0nz7Ffb/LdJLKjZju37cSv2MpHXugUtOQjK48CkbtnYK9NNp9nYJZxl/tApS
 cj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203301; x=1793808101;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LB8bfSCAYke7LV6jDnoygXHb2uC94bQ8IqTVsAMgmBw=;
 b=gbwwAt0gtmxLhqZ707t5fPSvITxqT/MXQ1GTwm9oFHEYNGWMpIGDr2o6iYT6xqWRi+
 t9XKyjn1R8d95BAiyYVe/Hm51e1XDF3MWdp4lB52x6QWHVxPerHn4/NYezR8cFExL+lM
 LYZgGK4TXxZ3dbUheehTmkz/tN3ha1GIbv9pPMVMw08XxLXhPm3cEfoSie6xCQy+O86+
 y0YQ7RBo9gq6wkiNrA5WBdH38J0mNHFLik/I1QQAhVxpaxz24Obnla6tHVUgDGhx+xcp
 CvO0/LmAQQWId+IFqEeizYYL7GH0sDB8R1C9tx1ONi5R65vA17OQwLVG9VfoL875dzIY
 OMtA==
X-Gm-Message-State: AFq9FYK+UlaDYGcxmK8QdWxo1JOIUV3SMxbw4sSS74XN7UbQXGeZGgU1
 CAn1Spw5ZDDB0E33X9wGfHkm4rOiWPV2U1nyktL7nRRDybOZ1Bl3JZ4IYJtGn0fBgBI=
X-Gm-Gg: AYBFou0ZqtFDTCHtq53+ErCKZDhrjyf+AV1BoZi44aev6NvoypSzwQ1yP4jNd6X9zPr
 ctrIJNx9MaO+XLEJtO0owQummDD6QBJUjbj7YhKkIbeiA1TtrjAlXQ8/yIqNJOGtZsJ9JOr1rHm
 N+81dxQdL5XFNxl2wP+jXAy66rwtOnqDu5i2z9qtjMCsLM5LdJwdt57UuzUV0tWFa1xodZrZ/0p
 Td2jROx+1DOHxht72CZuzjYa2/zFAA2vy/ViyfAps0Fjy/i5Su0sobGMa0TaUBD5JT8pG++DNnC
 i+VA6Lw81pCs1o9TYFmz5rf6Jtfv9ELjEMfUPthMuM+nHa/lbZk7p96f/m47hqdZkv3kwjrGmJn
 NB/KNfHs1OsVINid9cHeyuTvMbwqv2xrHgD/u/cQMSHIB59TGNV50GbbI7c7c62HNxcjud8HbMP
 5DP1ZqvMQa7NCDNfPXeg0wkZXuXv+EDI4lcGAcmjMmo9hQYNyT9Usr3f5looKQTlhnqtFoFEQkG
 9rgCkjFWRbbDJNxCGSnNR9lIBvBth7DgMNVqymfcLhNMn3YgFXviW8ejhsbenV/X6j/DCFm3jX0
 zEU+2QXecyUefGw1vOlQdMX37eJUxQDcqtxaxcae5/U8J4YEN+tSn+zsC3QCB/9mOMlIWxI=
X-Received: by 2002:a05:600c:8b32:b0:4a1:7d9b:d4ae with SMTP id
 5b1f17b1804b1-4a96639b00emr67236305e9.5.1793203301286; 
 Wed, 28 Oct 2026 09:01:41 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:40 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Jens Reidel <adrian@mainlining.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
In-Reply-To: <20260902142937.2422919-1-casey.connolly@linaro.org>
References: <20260902142937.2422919-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] gpio: qcom_spmi_gpio: add pmk8350/pm8350c
Message-Id: <179320330021.1454330.11226820985696300561.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
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


On Wed, 02 Sep 2026 16:29:33 +0200, Casey Connolly wrote:
> 


Applied, thanks!

[1/1] gpio: qcom_spmi_gpio: add pmk8350/pm8350c
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f5fd26ae2957

Best regards,
-- 
// Casey (she/they)


