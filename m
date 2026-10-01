Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6234CCA5FA5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1643840D6A;
	Thu,  1 Oct 2026 09:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3lFl5NSwRWzX; Thu,  1 Oct 2026 09:56:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 279D240D62
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790848580;
	b=KjNHzGGYL1Gf3vWBB67+r9YhHrOMeP8MN8YiOqCpsSNcuqLzxNdoVl3UNPIefrhp1xuJ
	 YJ6jvOjCuD/ecc3I7BSE8GicJIuucJRobMhyDl7YyOv7EBbdXk+ezgED3SzNlK27eWzJ/
	 ea/+Y/0kiyDLpRLvnl8XzpKD3ADkxwb78G6xtTHYvXKT9mQLuqAWe1VfmJqI1tzHbS3FM
	 S0dZq/6zNuz1pfj3sKg4NhCrwHzakxqnqf16v/ScUl4WHvdUS/KCuF/1AFEiEzGH9TUX/
	 A2lruh+vZwUxqF48p4n8T4zg15tANt+/voWDDhquLa/uUObuqqs71RZfk12Rs35ecuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790848580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TSU6TjLnHHZrsCYsLzX1PmqsxN5pdNcywrebI4R4bxg=;
	b=c25l9JEea/VSuFN2s/AUgkjIJuuC3dZ+t/f6XrH59/JdVMlxs9arGuE2iEA1VLRp5ngN
	 C7MhRgGx2ugg0rwah3MgxZp0BcbJGzLc3mGnjqX8shORJLAwuQIGHKHoLJogGScBif9Xi
	 KDa+uruj6HclbWWygvL5nFiupqufPFiucmFPFPvu/MVJ5zydUZmoa4oSiHnRsBM3lMP2G
	 DFtOQFwJcbQJjYFH4pjOgviP9JXkIuSFeJLf1/7rMy6ppPN5/lNrJzHqrUkJw/HeGPyop
	 t3cHaOpja8hByTYdbfTxDLCe94DQIFsnaO96TMey+qgO5scNff3o0Yv5BmizSJRi8Rw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790848580;
	bh=TSU6TjLnHHZrsCYsLzX1PmqsxN5pdNcywrebI4R4bxg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dvZJ23Xl6FN+X2HGxgYYbrumst22A25mhP4K3yiftWf1BwoXQlQplpcG5mvuuBIoF
	 nCSXRDBDth8YIp0f3+ALKUu3nYx+3cUdeYhv6pmniQSgrG/YZjA04vM4tLeIdd9kJt
	 /X/cWpxJ7GFvyEd0OiikwGGXomC7jby4ykcBg0sw8DzV3sGDYr4nFmcgoAD5TQE5P2
	 4hHn2vtr8j0HZhOjcCnPis7/D2Ea5LSqPjRE7DFZKOiSzo1k2K+QoNMPGkwDmMKjLE
	 r0/IriY8km140Nc4x/qy7gql7KybBSGDllKi67yzWh/bVsj/MUhpL9qj5eWoIldIh8
	 jZym4rwQm85Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 279D240D62;
	Thu,  1 Oct 2026 09:56:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 037C432F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0AFA40512
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3MBUiYqrhom for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:56:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F205240506
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790848576;
 b=Byq06lWXu3yOjkZ00rTiijTIpXxVONd8w/Q5xgECsSiIfrz/WjiyqxjsZ7AnqaVBUQ2f
 f5TfPGXPh3L5ssEMmeqYFyGshsegrxKL0ma3OBNlfiyuLE8KfaSktEwwyhw5n3TV3WcI9
 yl7rNzLI0vkWqAL9nFh7zz+KyPG79EG+hVZRaHCxhN0nRvtl6sdPGxAxN8vK1RA66jINg
 xg4DIWZ031ZW/fY4S/DDWmRLxtg50J+L8W6kZtgU5zIKF4LrRNGRe1xjtn9KZKPTBiNXg
 LeaabEbBVkqi3gJ9hEBzxZ1ggrUND2UR4ViDcLyJVNU9rYH7lvfCGmB+xBx58OHdvwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790848576;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=TSU6TjLnHHZrsCYsLzX1PmqsxN5pdNcywrebI4R4bxg=;
 b=Ye5cqZFh8x+KoU7YlEKC23/g4PrpCHL39uuqJjCJSI0yge2DA9hSDpvdL0aSFK3f4/EZ
 PVs7NBO6yFcEUV9Aj0n91UqD1aeDkLmb/KNgZJY8NyE/LKr9gnr5RwYzkshwGSR59MHm0
 Ee32+Au6qga21D76hHkHiiq9TQhYJaXMk3lTDwxts+lFqxznvjzzONHv++3LpKBt46d56
 7UEQbEFgLVSo8EmaNj/qQOtFwSDGosnNuwUTSM6cz5oJiCdtg3CKPprZJ4jEd91l6FMCL
 0CAtDYASq14tel7FABBdxMGX9eLcWJRZxX5/tYdLS5fZFcNFkKzVxT6mZOhxxN4Pxjg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mJbmKsgE; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=mJbmKsgE
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F205240506
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:15 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a00713639cso32849925e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790848574; x=1791453374;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSU6TjLnHHZrsCYsLzX1PmqsxN5pdNcywrebI4R4bxg=;
 b=mJbmKsgEXULYGByem8Rshrlqv4G/+w8oVY71PKFeBVfssX1KLcX9CBcnna9gIJ1HB1
 M15uCiyJy8H5i1NnUsZhBN53wlvsvkomqztBamPXdZwMOmIrp0TIK87OW0Fd0Ino3GFs
 diSMHTW8H6zyefnTfWv5GKqMhcM3jX0ajxISY7yxIRx2Sx0HrDLzdR9rmahF1LQ3m6PK
 DVRFrEa6XL0uh8jqlnbsRFnCMgyMLhbWsodhv+8cGNL8uq5nKDisgi98ToUnv/XGfMA7
 to6Rxkxqz4lcVt7gMojb5Tq8HAt2Go83bKHNxp+vQx6pUq2YQTFWImAOnDsbtlADKc7G
 ZD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848574; x=1791453374;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TSU6TjLnHHZrsCYsLzX1PmqsxN5pdNcywrebI4R4bxg=;
 b=Mtbae6E4kj8sJ+E/TlOVJJdg55b03C2f76PIEpgoEhSaxlnBfN2AwkDxKhHmQegjkL
 Il7uRztRGnZ7Cby0QxjFroGdDdzjp+2LK9ytnNDTzXai4n8ZP4sbQcVa8YsisaZwtkfC
 x6D16aKJ4VcAK0pGdhFoPmrsHOCnJ2Ox/pk6ULwM7gmAw8woM7vX2JP9HQb8e8ZaeY0M
 ZcVORuVWjmgaTa0hGiZXXM+UaSrQc05KRC1+w1TBEIkyd+SyxDj7H+DOMUV+5QYu0IAc
 2RjTLABQ70ehgfLcyltJ/scAovfIogoFa3eeIjeqM6OdwkFcL9enaaofo3BF9WFvW/Tj
 JXvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByH8LfwNrboYfjiKjKD8H5lr932Vfq3Ol7ppi8qqkfC7wMFclxGEwhSJN24Rz/gFMAN6Y2104E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mVDS3NeuhbMBWlw8jwgNLzfCJBZY/HrAtkumlyYDKp8R4XVSnA
 LkgRwiWIEAqpHI9bo1MCUt5OVVVSih4+KFlPjnUz1fprfvjU1FpUHVBjxxTImBFsm9o=
X-Gm-Gg: AYBFou18KJiYJs72zgii93aTFWrVTLSuynb2JfpWxNZQxsdR5FmJC4lChQtW/RFFWVo
 8I2p9KJ9kiqhJFWbjgcGwktiLrIWk2+BbmSm3lyX7QVGHMozF0sWBuCZd13cEVwerzogAzoYR0k
 il81SSvIDIiKQVz4krScZKxTRhsMCLgvC+0K0rh1LPa6+YiHCpjcA99shIrCKVNUTyFXMkvMV2h
 VTXmmabTrz4JwMf3jyvkEVkDojyppJtRY8cbxS5aNDXLeZNipy+bcSVUqNWjOabC0n0JQT5beM/
 YIr4D85PJsh5n8NHJEbPqrE1DavhZqVpIrNo981O8d/mGHJsgdb1Jl717wtUpDTTqwfvjLUq4VS
 vg25ZWwdy8+fqzKcVLcS7NlsYVjY922eMDx7WOLQ/JYdZqS7JWmwcCl8EmKnsL07njXZEHCS70z
 0nvoTAFSev5w096JpbTi3lpi1lwbzZkvgSWjdN5qnKSx/AZDYelr4SVc42k6SwzmCUWHMQ5976b
 r8DJm1CBsbfu3/mxtndVwaOr8zR87y/5IPjKHAi798kNtt+jaE=
X-Received: by 2002:a05:600c:6095:b0:4a0:1fe2:d4c8 with SMTP id
 5b1f17b1804b1-4a01fe2d763mr25400595e9.5.1790848573766; 
 Thu, 01 Oct 2026 02:56:13 -0700 (PDT)
Received: from toyger.tail248178.ts.net (p5b29ec5a.dip0.t-ipconnect.de.
 [91.41.236.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f922ac4sm54012045e9.6.2026.10.01.02.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:56:12 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ajit Singh <blfizzyy@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260820-clk_gate-v2-0-8cd0059c162b@oss.qualcomm.com>
References: <20260820-clk_gate-v2-0-8cd0059c162b@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] clk: qcom: use GATE_CLK_POLLED for CBCR-backed
 gate clocks
Message-Id: <179084857238.7191.11884120477125721923.b4-ty@b4>
Date: Thu, 01 Oct 2026 11:56:12 +0200
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


On Thu, 20 Aug 2026 10:38:21 +0530, Balaji Selvanathan wrote:
> Convert CBCR-backed gate clocks in the sa8775p, sc7280, and qcs615
> clock drivers from GATE_CLK() to GATE_CLK_POLLED(), so clock enable is
> confirmed by polling the per-clock CBCR status bit instead of assuming
> the enable write took effect immediately.

Applied, thanks!

[1/3] clk: qcom: sa8775p: use GATE_CLK_POLLED for CBCR-backed gate clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c20962bc9ec8
[2/3] clk: qcom: sc7280: use GATE_CLK_POLLED for CBCR-backed gate clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/2becf28e981b
[3/3] clk: qcom: qcs615: use GATE_CLK_POLLED for CBCR-backed gate clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5ac76bb42aba

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

