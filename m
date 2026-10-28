Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18E606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E+W7kwh2;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RogYDZi5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BF85811C9;
	Wed, 28 Oct 2026 16:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACEtJIWURNfs; Wed, 28 Oct 2026 16:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96ACD811EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203324;
	b=itTv3pOLF5NN9LGX0DkX0g7e7WNfb/y/10HpCgED6OyU8J8ARP5A5I5XVC4xbPbWHxTm
	 CJLe0t+Jan99SItX9oP59E0F2VPpz7uWxg0hJ6qn79liuGkCj9o16fq1wpipUBqCQ191P
	 npq9nmQRtQ93wLTSaUaFHm5bvMJZjcIItKtNDyn50BBuNHe2LCBs1ZbLOQIjuqARG57AL
	 p7mV00kq1vGZPBgm2MSKFVMbaY/Di0LgJgClj+Tgko6uqTEqVLGX+Nmwkhnj3uC588YMy
	 TKpnexFy3vIhHRRWKAP4DEmj0Oca4xWJoMEuDOwwavlNZbgVjY4rXWtim+D6wiF2LeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pSdaqFJqlQ6027zLTxA/RK1zGJiCfnS2ygB9lul1vW0=;
	b=Wk2JUC7JeRl6m1KOjEQ9VsPwj6oFhBMQIno/pFC0UD/tsmGdnLVqTiPRBcTSd6GEhlej
	 QAyOGrZQ3/hkbpegLbZSqY+ctKYksTkhIO/niyRa61dK5o/RgKhNEq2Q/YV5zBRgFxWL5
	 BpA7p73aY2DSDHcLi8oTj8LGr2PQrQckPk2eJdXyQH+1mSiCeQVxj5VDN/84ypT6Vz52f
	 cVovbo0VM/Ilbg+l8BJJvJPZnHkNDgnhqkGhvuXrjv03DTk9mBsKA8PGXPeH0ihYBP84m
	 WIPLcpylgTc3HiuLVLm9yb8aAc8wIeCB6Kkc5qyBSu0JZnlUFOUjP2yA9KNYn/i9wAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RogYDZi5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203324;
	bh=pSdaqFJqlQ6027zLTxA/RK1zGJiCfnS2ygB9lul1vW0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E+W7kwh2jXinrJ3ZsmcJvyKz7tRmo4YoamnAwTUzTdiPWzRa7CDj6TvezDmTmzAYe
	 wTP7gZrw2/13PxcP9tSgScsXDzwTLogs7qjjf9CydRsfjyWHGmAcznHMG5/eI7qwua
	 pLEsHnoIZSwj97XyRLa8s29K07gcz4+0pH9EJWmTTF4QD/LBm3/sLU4sWZ6Tb9lHE5
	 YZMIw8nNfahKu7mKiUts4CxxE5VEntGPI6UFvbjCuDWcC/ErTRUTKOS7Qjl/ivgOfL
	 o5p6Z8xHSwmnuilZWLicWmhqBnVHAt976N4VOeNk64J/0pr4BhpRsXrHEBLzbBIvz+
	 KoZG5S2ZkS4aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96ACD811EE;
	Wed, 28 Oct 2026 16:02:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31CF8380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 155D081168
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3OR5MPLG_HFb for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 10C4880DA7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203310;
 b=M3WAaVQjkXgu2P7y7z/5ieoRBsiJlMayVbdhZaXSU+894w79QvXruJ/qjrB7o4w9MnkQ
 8dCe+eUAS0H15c8nt26+AI3O5DCzT9D/jWngiTasBpRR8R5qDeT9NHmE3GYe1l2FSOdtS
 L8U68HktI+aeHppgFQHLHgJEWajFqdkB8Ibo/u2XhkapsJV/GbbLWl0f/zBCTuAmc1VdV
 bDUOT6nXwq8Ou78pOddZtO04cQXgKfwLcRsxppQtXrLTu0dVaI0isVobNz9FxiPryh2P2
 B6dJmu3yXfmDcA5ow9oD6wOUmw7fTFeVGSCG8Ap1i6DvCACNAPOfn6U8e44l4gyNaVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203310;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=pSdaqFJqlQ6027zLTxA/RK1zGJiCfnS2ygB9lul1vW0=;
 b=AbU1h3Eypdfzhns0v6D0fUNruGEmlfA3Fgn/X7Rg25XR470HZlIA5bqMZOSYbqHbSmoc
 BVoNO79KoKC5EF5jY5MhO9+H4SuhSL4o5a56iaKaOBX99TRvnsPSRVK+QX/c7bKu16txc
 TUS/or3QdhGAVTKMEfHqk2joo9nk5E+oWf8pNZVkbF/n0kGe86/6tA3HQAFZK08691P7T
 v+S/75RxA2gaT2XPVCklDUce/WYJbVB/h7k+RrimW7b/WW9LXH+Wbgtbhg2RT6dwz4ysQ
 YoGQv/IIv4ezNNDAyIYJTiDwlOemBphyx5M0uUEqM5C0Y8afzYXryXLPUyblgelViyQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RogYDZi5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=RogYDZi5
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10C4880DA7
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:49 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so1623809f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203308; x=1793808108;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pSdaqFJqlQ6027zLTxA/RK1zGJiCfnS2ygB9lul1vW0=;
 b=RogYDZi59fO6f9OI7Yc3rqE8iN8XLchEPq4zHZugmlRP5G8Pst6cUtVVwJ14mFRfA0
 cBHck0eiRyYqcZNwipdMbbmnJM47uKTOvOiRcTdUbruqtW+JUqmY2nHiR0gwtE6dc8EI
 5Sz6qwDHq3I60g+Nf7O8ZNO/muW1xCZivZ6GNbEW8cRIgNB+9pK3C1MBtTxCpq3uGkSt
 PY6969nk3nRHSQzNeSKnMsjThY+NKprZ0wtk6XElf084EeVAc5nn5WIEyJixKHxEluZO
 RvBIvGJrWuZfUgBRUdMnczmiCiYCpmg6Lx3j7atXBPx436GgCE6Bht2MUZMoEs7RP6V/
 GGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203308; x=1793808108;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pSdaqFJqlQ6027zLTxA/RK1zGJiCfnS2ygB9lul1vW0=;
 b=JseVj13zcpHIVmDUsrZe9CBmdelSSS5WqXL+EQhNcrPUoGh75Xyo9sUcgh1sl+i6SU
 V1P9YgaMmkRwBNhANgHOZaJFP7um5xcSWxWx6uxt1hyr3H0ybtIPC3bm8XyTlkpNHSpb
 rCWqUSfR7sv9zq8PNcNXriL2Hhvb8y9vAKecReV5ybzbPPd0ySa7YNvHWIjtjy4hxMkM
 7uxYgFT9IYt/LDAHq/IU0HHGYf8UHeOSSanonLMMBnAhQbXfqXPKVXh59D0O0O22Me11
 kd5OsfdEU9w+vR2kzgKxlj7p0GJMADGk/kYp3Mfg7Aig6wM3I1K556yZZqCSJsbUd2Hn
 SwBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQmbM+DuKmW6hjdnXmsfRrvvEWwI+RCcJGzmfvmVQzdQG2qOHSLtAZwBLLbCRJQs6SN07sjBU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJRbvHkXTE/36wTaP5XnLJ7BjxSnS1UsWHu0b6GifLM6DW6QnXG
 7zW3RFyTSfVpK9iWVhpfp8UtXp/MttGIYCqM5yVPHFHp9L13tZ5UCI9oYBUC3a9vQ9c=
X-Gm-Gg: AYBFou3DIZzOdzz9qPWoGJqtBVTxUBWQjKAXWQ9+Wih8USeUiweNI2g7i7DQp/KlJcz
 eZKOTL7fXk5Dff3DDAKf/DYnnR2le8LH8Q4NiCVf38A8NQ0MsqgV3dnEmi+P8s+PwQ3Si3NNPbj
 73ffe3h9verbe0TdRGitk3DTSfJYUbsOtrmGtOjVcp1DSa3TSkavMG+BYiYcWl9DvIcBP55EkYZ
 rk62twrQUrNyHvf/0zZBFYDNNDbsiQPmg1f721E+zt5LQSCh5RVwYLba7wwPlQpwcQ4d4tHwVCd
 k897BcdBxDdZCRi7vEyhjW1U9czwKTXhGOxxV+Q+Cmdl5AdSG1wouWRl6zhBXjR+GkgSNlij8Cb
 Vyl/Rk7/zPZTOM1voE8C1m232WSpuTNgSzhtsGnJXOJ+RLM553qoZIAN2FIa401P7fXRiLTCoS8
 OzvNP6OClAE4hYlBteG/PgaBMOP4gU6guEp+jbT/jfHI2cdr4hCCu0E/fkICnUlTTtMUfUnKi2k
 XbiHyG5LxE/mMurkYgKMKUlY6iaLpf1Hetnu/sjHix3SZ1ft0JRuig0veBKqDBwf0IgwIATh2+y
 PtNSYXHc7oiI9+EiatANc3qMfiX3KdScujrCl7S6qQySrqjXV1x7A1hXl6vtKQOgVDZlrnE=
X-Received: by 2002:a05:600c:8114:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a997cf5091mr55692035e9.17.1793203307879; 
 Wed, 28 Oct 2026 09:01:47 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:46 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260820-clk-qcom-sc7280-rpmh-v1-1-18100caea7f9@oss.qualcomm.com>
References: <20260820-clk-qcom-sc7280-rpmh-v1-1-18100caea7f9@oss.qualcomm.com>
Subject: Re: [PATCH] clk: qcom: sc7280: enable shared RPMH clock driver
Message-Id: <179320330640.1454330.14767059285454209398.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:46 +0100
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 20 Aug 2026 15:09:46 +0530, Balaji Selvanathan wrote:
> The shared RPMH clock driver now covers SM8550, SM8650 and SA8775P.
> SC7280 exposes the same always-on RPMH clocks, so wire it up the same
> way: register the "qcom,sc7280-rpmh-clk" compatible in the shared
> driver, have CLK_QCOM_SC7280 select CLK_QCOM_RPMH, and drop the SC7280
> entry from the clk-stub match table now that the real driver claims it.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: sc7280: enable shared RPMH clock driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3c0b00817989

Best regards,
-- 
// Casey (she/they)


