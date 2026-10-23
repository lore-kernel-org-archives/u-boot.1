Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBC606A329
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C2oqR8+T;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LZJczN9/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC8A1608CD;
	Fri, 23 Oct 2026 16:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vs6RFjp6deW1; Fri, 23 Oct 2026 16:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7ACC60809
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792772852;
	b=gO5kKDgSoukzJA7MfphFXCYMdzzO/yCvOVOABafQg8xKWyZkYE8Xi2fox9SeJnfdrNnc
	 TTxkAuh84ck6+ylnaZSzvzmRQq6gHz611JGLcjhAF1N4T3TxNVI8mb0GnJw4kpCID8hto
	 mWhX1rU1E3PnPAbyUKBZLHi5ehSOX1R+0R+SI526EQ0F1FklOtsgCzCuoXbDgCK5a6W1T
	 /7nSxjkGNmr0r89DSRGjHszDRHS9QzpzNz8HOmACrpLP0j7fRCUYHZtw1n7MMcomIzU4C
	 kig08NU1HE5Mgo/DnVGnYZNLTLByvZVGZz72+k5c/vO9iXCpAzMKaKH3smgJ6/Vur4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792772852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:
	 X-Google-Original-Message-ID:Date:From:To:Cc:Subject:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J61yeLamTQKFtdNP9WHYFlXvYjYUqnCxCwjsWD56SAU=;
	b=mFOgCXmwa7W3bLRmFJLnPpQ4TleYMnmfuQPe2J1wYTsOt6WKymChYzogaOLNj4XMkZM1
	 o574EWuWAAGoqi4g9MufKgTt1iGm6MZjCmykHhSCneqhhwPkrSTzsHlh3JMMAd7OeQq+X
	 a7W6Ia2Bw1VZCG5TYNqj9aDJcuAqji4AFHCGMfsR627/mkkxF1OkUy8CrJ9CxtPooT0e9
	 qb2d148NOLvbxTb01g4wkCE7qxboaUsnT/FOkdAPfqcUFHWj5cjfjJ86CD25wAn8Y0zL+
	 qNAv6dQ/6NuDlrObBEEw0a9qjZx8WfgOGJoqDxFIp6d8Q45eZPIXdKREApSioUOzwqg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792772852;
	bh=J61yeLamTQKFtdNP9WHYFlXvYjYUqnCxCwjsWD56SAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C2oqR8+TuDV0QnAlZlGLXYUMd7wkJtAfA0a4Z0TQCdx0CdtBvS2+vilhBPHZslKMV
	 Zowj5yvjU7LvX3HZ+f+zbEujX4jGo+IRZzitP8sdzrRdxxARTZ8AQroFMuxFA+apu7
	 ZywbynAZ3GLu6NBnD+u+m6ymi/kCTsR/lq2CZhOV7VsLLwhIaPTX2+yXEPba8BKMSr
	 dlbdChM10K74KO14RG8nPB0R6QhlSVFP98mHIr7iS3WAmnArxo0QyB6VHbPcgQRR4d
	 AfbU/PvDDO3dMgu/zOX9mqGjr/YG7fswITmcd5JH89cB6tFGvfsUHiA6PmAw3pJjI6
	 MhMtagE5jBE/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7ACC60809;
	Fri, 23 Oct 2026 16:27:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 32703235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:27:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 246BB8148D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAfH2bOtZkfj for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 16:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2804C814BC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792772849;
 b=sXPel12CLyU5OlFOrDb3HaX987zap61DRZ3hJpGsVWNI9EQCtX0Wh0fZnoofJXlEMbXo
 MIHmlqnb6V0XwHJbMCuKWquhaozuEHw6OTqyuvYQQzlEOIm+huS2fNxX1xJ8R8g0jGYn2
 2uz/MQ0sV5z3UnMSvAhUG/sl156vY3VPO15/nUg5KABBjieZvwYmhWx6Kcu+/cIBYOoo6
 +sTeXeN7hnOkO4MBfQm2qjfvAl9UpV3BFAFXA3HbHON8IRrxsul9h/1uEovWp4gcF++Q3
 wm5NKmNOur5OLa8kP3gw38MY36Ed5jRDDp0Ku0P1ahk/H63O+N4DgMkJxo7H6SQPNXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792772849;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=J61yeLamTQKFtdNP9WHYFlXvYjYUqnCxCwjsWD56SAU=;
 b=Lf3F7bouX2jh74RqLg6Yf7s5fBIdIs95aTtjAy7cgtMsza/3gvhwdm6Zwwn9fxf8HkpN
 qkbAKVC/6TW8ac5rY7zWlctDX7mB4X6svZpiOVpStBaNkeVIRjknsrTL5zXdft0nn9Gsn
 dKBrSNvbAt55KKqSH642aOkHkvo3u5+wJGXHylgjbv4C3hWKlOFb/zhVifC9A6NALKrFU
 dge8o4MQ1O0G5N/5A9sRLg/FJHI5iCbttFuMukrqd/SAwa56w5Ls/jsv+XtJvyR/IYNpP
 eWuzA93Csr9s5bNOQrbaL0/FzgpLDQpGuCzT/yULDQPtavsQULf7rlt/4X486nEVyuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="LZJczN9/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LZJczN9/
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2804C814BC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:27:28 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso895085f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792772847; x=1793377647;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J61yeLamTQKFtdNP9WHYFlXvYjYUqnCxCwjsWD56SAU=;
 b=LZJczN9/iJcqNjdi7Ve1wMMX1P8SBmqkMljCq6gKcc23dwXkP/4o9MqfbaNr2CxyGt
 uxXEgymZY10elcZUyU05rt2+hnJsLiNf1kRIMEMPyhmLeKH1/x9zLomuPhMVsT7ZcUri
 daVBP/5P3e9412ZunAYN964tvbRdjZza+KYHyYwf5nFCI3kCxj2Ujx/35zwu4QLuM2HI
 6P83QXAJ47dPqgUjEWXrT9uy6ztxzdr4DBQ7tWMi+C7xxS7jlpSCc7CuM1AOz96CENMi
 XIYcThk7A1gz2ysYLmpsDVSB/DQLim88KSQsEu13r/GVDsIzz/LwqetAToaUwkuW39UP
 cRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772847; x=1793377647;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J61yeLamTQKFtdNP9WHYFlXvYjYUqnCxCwjsWD56SAU=;
 b=mHJOThFKB5+gvPv+71xHiPYEI+S7MwluXImrJ+Wcds3wQailAqSlgHubdwzXgv67Hy
 tC+udeBUTtyfv8HCAR4y4PxuRQ0zWu1BkJF2CBUvr+ljB4BCVSC94oi0nu9VIkMJlG9z
 7zuxSV5XxKQgJaf7cT+ONCZGB61eWMDUtpp5kNNardgHGU/8Fxg1t/GWQfCAl3z5J+Lc
 tDXRjQwvC9PY4bXwDelaOHEAbdbf7OIX1D/l/ceAb7HgLHp2QLq0Sf0a1fc4ngtseWH6
 DgI6GJ8YwPsnPqAdFD+sxc1+W5F8ncV67gcRG4jbK2QDYNbM0C86gf7r1YuGz5GViFHb
 UoLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBytmIvgxMNVfgO68nYj9LRYp5R0AcrLvh2cCdVpvOjJOXKMm3gwHTAWImdQw7IfiVsTQ+0iylM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI3yuyeIbSN8JVJ2fBCnxbQBy+h0M3GgepakLJRuLSOPCx9xgwD
 jB4HNd7Xw31cB+kFFTwt3BiKc/13dizLtbwJChEVAJ9jgetJbWrUpGCZ
X-Gm-Gg: AYBFou2jwE8UcpZdWquVb/ePpHmfUJgxj6yFjI7pV9TMPMacRXq5weWx14uzvRuMpFH
 zAy/05/BxT9ZFn7dUIoHSfW6llOL07q6mlJSEBpkLsoOimnbccQKgoat1i7i/gdk4kLt4KVoqCY
 QVFLDov61wC7CGBsJs3tkgGbVW8yFU8QuBu3YqveExsqEZu/4SEpqZBks13vRvqU8bDuNUFy2IO
 V/95CPs4sewxY7LdbBGHckWtcn4h9onxNMQdWX1DuqxDqO1Ab8jdk6r772EBr0IAo3WZhCDfqpe
 HFbH+D1HmVVGS98xUQfFHPSDeh/8eZJua++YkiLrLuM053hMZ2KeexljpjKPAuFpMH9aF8gaPL5
 78M5DJ6fM7PkTjeiJInWqoaKp+twGy9y5X7KH0fW4dWjlj2NXrdwr+73pTclmOo/OjYVygR5TH/
 jo8I4wa5ce6D72kJwSBl0+r9FAvC4c9ocRiHkR8M8JKBj4loT+sFLqzFObLVQj2Erv/EsUDxfOs
 mXNpgM6Ugg+t36uI+f5UFPDvoZs6fRCZCmuP4+zz4IE663tFRZrg4rT0gqi463z7S7bRyXNwZqe
 nzDN189ee2HRpFsNP1xT0VgcZVhD7F+lD47/4XxebltNtMquG/5fORHWhT6EAmvw
X-Received: by 2002:a05:6000:40d9:b0:48c:6a6b:69b2 with SMTP id
 ffacd0b85a97d-48e385a7618mr4479419f8f.27.1792772846563; 
 Fri, 23 Oct 2026 09:27:26 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d42b275sm956941f8f.55.2026.10.23.09.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:27:25 -0700 (PDT)
Message-ID: <6adb8aed.4f27db6c.db40d.20b0@mx.google.com>
X-Google-Original-Message-ID: <atuK6XbtcuwygfdW@Ansuel-XPS.>
Date: Fri, 23 Oct 2026 18:27:21 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v8 7/7] test: dm: Add test for FW Loader feature
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
 <20261022194049.670889-8-ansuelsmth@gmail.com>
 <CAFLszTg76SRJS3MZNi-OhuXSeaM8Sc4j_zA-CTdCGc04j2LB5A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTg76SRJS3MZNi-OhuXSeaM8Sc4j_zA-CTdCGc04j2LB5A@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 06:12:38AM -0700, Simon Glass wrote:
> Hi Christian,
> 
> On 2026-10-22T19:40:35, Christian Marangi (Ansuel) <ansuelsmth@gmail.com> wrote:
> > test: dm: Add test for FW Loader feature
> >
> > Add basic test for FW Loader feature for the Filesystem way and FIP.
> >
> > Additional MMC testing image are added that loads a dummy firmware.bin in
> > a fat partition or a simple FIP blob.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >
> >  arch/sandbox/dts/test.dts          |  38 +++++++
> >  configs/sandbox64_defconfig        |   2 +
> >  configs/sandbox_defconfig          |   2 +
> >  configs/sandbox_flattree_defconfig |   2 +
> >  configs/sandbox_noinst_defconfig   |   1 +
> >  configs/sandbox_spl_defconfig      |   2 +
> >  configs/sandbox_vpl_defconfig      |   2 +
> >  test/dm/Makefile                   |   1 +
> >  test/dm/fw_loader.c                | 218 +++++++++++++++++++++++++++++++++++++
> >  test/py/tests/fip/test.fip         | Bin 0 -> 101 bytes
> >  test/py/tests/test_ut.py           |  26 +++++
> >  11 files changed, 294 insertions(+)
> 
> > diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> > @@ -0,0 +1,218 @@
> > +	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
> > +					buf, firmware_size, firmware_size + 1);
> > +	ut_asserteq(0, ret);
> 
> These tests show that the two loaders behave differently when the
> offset is past the end: FS returns 0 here, but FIP returns -EINVAL for
> the same request (see below). Callers go through the uclass and should
> not need to know which loader is behind the phandle, so please can you
> pick one behaviour for both drivers? I think -EINVAL is better, and
> the cover letter says FIP is meant to match FS anyway.
>

Yes exactly... the problem is that I don't want to cause regression in the
use of FS loader with this change of error handling.

Ok I will change FS loader to return -EINVAL as a separate commit.
 
> > diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> > @@ -0,0 +1,218 @@
> > +	ret = request_firmware_into_buf(fw_loader_dev,
> > +					"45a113ac-c7f2-30b0-90a5-a399ab912716",
> > +					buf, firmware_size, firmware_size + 1);
> > +	ut_asserteq(-EINVAL, ret);
> 
> This is the FIP case mentioned above.
> 
> > diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> > @@ -0,0 +1,218 @@
> > +	/* Enable the mmc12 node for this test */
> > +	root = oftree_root(oftree_default());
> 
> This helper is used for mmc13 too, so the comment should not name a
> specific node.
> 
> > diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> > @@ -685,6 +685,31 @@ def test_ut_dm_init(ubman):
> > +    fipfile = os.path.join(ubman.config.source_dir,
> > +                            'test/py/tests/fip/test.fip')
> 
> Please can you explain in the commit message how test.fip was created
> (e.g. the fiptool command line), so the next person can update it?
> Better still, since the format is just a header plus one ToC entry,
> you could build the 101 bytes in Python here and avoid a binary blob
> in the tree. What do you think?

Ehhhhh I checked and it's a lot of effort on creating a python shim to
simulate the format of a FIP blob. I will check it again but providing the
3kb blob was more practical than polluting the python script with something
used for just one task.

> 
> Binman has a atf_fip.py but you can't use that here, unfortunately.
> 
> Regards,
> Simon

-- 
	Ansuel
