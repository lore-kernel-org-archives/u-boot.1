Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF65606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ym46Dl6I;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QKvTrGI1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1DF5811B1;
	Wed, 28 Oct 2026 16:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LduxJakc_tib; Wed, 28 Oct 2026 16:01:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 627BF81177
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203315;
	b=krfMSmfvnZyLHU2TWwQ8EZywfCO854poCRiJqNJFjHlhXZZlZ/iVBcoob8vqjYUVyf5c
	 Zr3f1aHOJRy8pwWvrq7MXe/T2bF/jK2q5CHop6YOZAMhPvCbsb13URNHxvqeW3V52f8zQ
	 jOj/VQO1j+wGK3k6T/QKZLnyJhTuOAxiLGGueyYXjephhDkcmhmt9m/XrxVxx+sNcOEGP
	 w6rfVo5XVl88KTEATYwc0hM5qs4zzL1B1UXLND8qaiHHc46T7Q7zv/7rqKSKMFpALEqvI
	 872+TLx2dYCc4JVD2g+MC2s0hSCT1H/NUGobRaYe94vJHpupn4GyFIvSZwQc9zcrOKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xbP6jZzePyXjzip5Ad6//sSWxwuAuqfss/abE8iLSGI=;
	b=bG8x3cOsiDYgwRJ1SrKl+y1hBeUxwE+s8Z3DtrCFnWAkCtvpjy2ht8E9lU0fez2Bb+S0
	 P2BFYL2BzA4dmBZmsZoe8KBK1LsYqXdo7lZtrnxkLdRm9Ormo5epaH67g8raHm1eHnGUc
	 jhXjK3gId/w4NvUsxAFzTEt71Nmw+0FgpNgFTeQxTJ+TlxuvGX4rXk95FxXhU5faqgJ9+
	 fayunevLYcOekX77f+NTRGdjWDG4mnq4rNUSwxhTIhuMG3k/Ay9rZoC/aodUCAlOJ+m6t
	 UUyvsEGUBb9/CLlTN2t9ehUsi+gEnrXTdmXImfsGLXBQiscJEBan/ZjhaDhXyOrETBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203314;
	bh=xbP6jZzePyXjzip5Ad6//sSWxwuAuqfss/abE8iLSGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ym46Dl6IFnQvA+Auz7VtwpC3sDcf77ixQvp2C+9WgGThYLCqRU4ohLY4BLSR++/AV
	 3LnIIbwX1n303Smk4hLI+urGcZYKGHgCp7qjLVNkLX09MYgwuP/p44luLyBircgNq5
	 404l5w2C/FGPt9lxEWOSYXYCj9U4V44976zzTJqJJr04Go6rwP6AnXenaEr2aCg2Qz
	 jXeU7YhIZhRqM0wnC6ucQSm4Y+Kfwmc1Z087novckFsykmMiTE1keF0kXeDpxkIyjt
	 Bs3w9rb/aHt8M34NkaDGQ5pT+YjjeqXVYzMr8tkAxZJOnwZig9jEsVBwKPBmPOj0zt
	 4rT10pVmitepA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 627BF81177;
	Wed, 28 Oct 2026 16:01:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F8A8D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85827400D0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aF2uu5jIUw8y for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8EE5E40071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203308;
 b=KQV9N8QpSPLVQVGcVTbHDyTAr+KkNtWMZHOA06coZy662EuiCLlQrZKgPf4GCtkoRJ1i
 Qp0SjPOjWkVKebErlWJZNDyAa3mrBXxMXPLDkB4lvbpOo6bjYA/wvK10pMvIxEyjP03j4
 uBpryBD87sGx8l0OrioF36s0zx4cezXDtaljiz7HhZL+BzUfW7jSPzTRJrflAot+nGCu8
 DBbdg00g7tFKi5vfoxbtFVlOS7gi4YFbYD0M9T8xwcl6UK/D3J78WfCnjcGdh+hpuWhfb
 N+SGEuXVOtQLH5FnxgUkmPfamnhh5impR37PdyllYX7o1MiXmPGe7qNlWSsSdHUNfWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203308;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=xbP6jZzePyXjzip5Ad6//sSWxwuAuqfss/abE8iLSGI=;
 b=H3MmqiTZN3MdO6Gt27MBnIY35/RO+16AYmVaJ0GfPVel3WWQYaHrVSfa4LC1LaHuJX54
 yb0jE7SHWi2Qlt8ryfJ1GEDVnv0IyQhPjWI9lmxwS1+P5JGxnScyZnQfBUnQktdSwc496
 WMpPRLiLtoqVD/DTSxFENbAsrSDentQaT713NMe/Tl5BNc7kGokI3Ut8I2xnvFwl+aPpp
 lxQIbSK2HVUolYinV/bu4ir7n7+4dOGcKqbYrCOZT9TsNhBMyxqq5etNu5F8BaAb04IiV
 qlE4i8/ZuqUgf3xCbd6FeBN4i+sRBOGXUOQJgIcivGwhaVhR3oxkRm3v6iTVkQYdzEQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QKvTrGI1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=QKvTrGI1
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EE5E40071
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:48 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso12009905e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203306; x=1793808106;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xbP6jZzePyXjzip5Ad6//sSWxwuAuqfss/abE8iLSGI=;
 b=QKvTrGI1U0hIuuKTX+8AJCqmRMnsyXTT1u/WU6IOCsRR2q0lMFygTiDqzvgZ1syceA
 UH6eFrF4JXE+kROU8ZSl3sHqFTZs1LsT8kzt5GNXeJkQt5qHBNhrVv82jsc+6vHtccgy
 wbfEFIOOiQl/u4SqKAyZvG5vd0a/3/ZbulM7287iLhywzAecVC++HvlShBLoNiN8CI5g
 pSUBo9S6TJWcr/flZqSYwYBFizLLWWM9Jqyuk3PmFkIKCHveDOJEuzjGKbt7WoICFe40
 3QDiIJQS17MfK7kY15T+45HMolYjEnml66KS8FkRbD0WT67HJ7ir67vt1rrGO7wh7seR
 7jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203306; x=1793808106;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xbP6jZzePyXjzip5Ad6//sSWxwuAuqfss/abE8iLSGI=;
 b=tpL3epiZ8GhBDAZ607WM63CBV7gcwTRXMr4rmGz7j8VFR0beQF1ixWZ9WrSV292WDn
 ViDLsadDpnhpKpCYo5XtMO2FDIJPgSk4zp6xlzzjWHEM2vCPEC11hpQavEpSIFRC6mF3
 qqGntDj0pORSEF0TdmgNlz4JI3Sb/XNcLfibwnwmofvPzlgJ0LkAkrb/jzl+VF6rJOvA
 2Wy7fkBCX57ez0UPcyalwT0Q13ywRgppHYL0P48P90M6fq6gHS2/z3K8GonmDwHbl42r
 HEUKMSmQai9wAojp0dJGgf6yVU1VuS0vSs0kKerbdOncL2tY7KcvcKfYyqYTL7sVBLv4
 fUnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrMG81rd3vaNc18nGV3GRhT9+RUAvUetl7gb503u+k6FA/BogdiYK2fsvwyt8CVMCiSZogZSo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJU0+96xcggORu1DnPCe/0rmsX62juX0QX2uxft5ciN2E85FVQl
 JvwQwEH8Z9lW7yIFc1uKTRHr0Fz/UL0WC4EqKgEIEaQcPHd7g4p/n0oWF9bU3hAwn2g=
X-Gm-Gg: AYBFou30yXfozq5EY9N626on0E/xEB6HELNqDwhb1y1EomPVX70R48BPyz6D9S1kW5O
 t1HxFnF7cameD0e5wpZDogNWO89L3pmXIpxaX+0/64lXhpbXGsZmqydPbdaijgGSw9UQlzgHWwz
 CxIGo0W1eMunxtBvz2bRa8UJNEa9ZRF0pQ5D8MarASaP47oLqbLcw8dg0d87tXnr2/W5nCSbNBV
 RpDZKMrqlHJ/Bv5070DXIL99+0ny+xF/D6tnpKynSq02G0njL3r1oJ/NuEgN1gIrj2vTIeGQ0t1
 3nDHutSOlwi2G552lkJsLZxC8+hCiV2bNvVMjcixgNXBD7+c10wt+QaZSQ10KBPXybKCSn4eKZu
 OibFeUMWLBBbYHYH3OstFQOXygiPfE7XDiRHACNct5ycSIMxzNwiAA/OMGyjgbm/wMlQYlQItyK
 hlQ0+VDAU+RzE8doRUQ9PO/y8tx3sIsq8JOhpyC6lAmzPlce7DVjTvxroGPg9fXskZ4NgFYTEkk
 nas4MSkGmtKBZIW4Q6SeWvA4XLaGSrXKuFywbDvSDWvh/3o/3jRzYEv1nsFrw8WTPGjU9+U+Ohi
 hRaTEWQsuV5xlIGhe1ZTbHtgZWd2S/i65eAh1p6eYSSfwjn5KiG8Vs5jdaOVUAHPRR+S9f4CbaM
 Vc2a0u688ayljOmaK
X-Received: by 2002:a05:600c:8b05:b0:4a3:5a55:f454 with SMTP id
 5b1f17b1804b1-4a967202925mr60231305e9.19.1793203306317; 
 Wed, 28 Oct 2026 09:01:46 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:45 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 William Bright <william.bright@imd-tec.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/5] qcom: qcs8300/monaco-evk: pinctrl and
 RPMH clock support
Message-Id: <179320330515.1454330.14268279188693128419.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:45 +0100
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


On Wed, 21 Oct 2026 12:13:09 +0530, Balaji Selvanathan wrote:
> This series brings up the Monaco (QCS8300) EVK target with a dedicated
> pinctrl driver and a real sa8775p RPMH clock driver (replacing the
> generic clk-stub no-op). qcom_qcs8300_defconfig is switched over to the
> monaco-evk device tree and renamed to qcom_monaco_defconfig.

Applied, thanks!

[5/5] configs: rename qcom_qcs8300_defconfig to qcom_monaco_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ff0150a1001d

Best regards,
-- 
// Casey (she/they)


