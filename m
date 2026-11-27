Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A81606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UY6J7cIE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmLlu+uP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 564CF60AE4;
	Fri, 27 Nov 2026 13:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjPEMtrujDyX; Fri, 27 Nov 2026 13:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6ADA860AB6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795787902;
	b=A44WRzdUpv9rGWNaIntDJxp6DsX0NlOhmfzSnyfjG4/glJD9Jk1m05ihFv2RzEHVrzCv
	 QS3CXPHhGyAY6XlM2VzGWpAYwfpm3adEzcXHimaWYi6Q33qqiIplXKnZskK/zxG/8X8XW
	 kFwVXfODuAM2HtVhpNTfe5ksX4xgwT0h2AK4pryPrMKgMBNHdEob0GBs7aTRVZIAAuyVA
	 0r5mr5No913bnpilEUKWxonq0aG9616rskrs/vOGfygiq8e0sT/jCGLK2mynMAX3clRAZ
	 DIawVFj4zNLBerIJohA2K/R/v9XfIwzlYzRsHCJxJEF8Pi3+xqKbA9E8/3unvt2xrwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795787902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qZs/k2IcsW6xETAmy30azSqNoCLEhOTO5eU2yO1/LuI=;
	b=fjLthePay3+euQjmizJT8zKGwnoWrgUbGMYFOv0rtCSW+q/LabAwDDpmIDuWydjs2SfM
	 L+gAprFfObN+LYLFmoWyw6i+T7TN4eb2N/b2TD/Hgx42EpMbjpFcqZow8jkgxvzotd0K3
	 SDsncVdJrtGk7lBzOHpQiiiz2Ajm4p3J3bfCQg1zdhB4GUCTfhxBwSDlmG5ivgMNUbDbJ
	 5vFq4v35LT+t/vFJFiWcDt+r5FzbdnbAW2qz+Xz8bX8y0ZsN9C65ZJ33aRfquv0V7NyTl
	 JmLBQ+KDNlsiz0wUHxhXZ/4Rdh68jnw7LPHLn1WBF2xzNNb2NSfGcxY+1iA3A1kJF1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795787902;
	bh=qZs/k2IcsW6xETAmy30azSqNoCLEhOTO5eU2yO1/LuI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UY6J7cIE3LKTIlzoNR5HP+m4Z7WqAuHdLf+twrLWxLbRk3q6KORewc5GWxtllCJMT
	 iVXGUquGZVgv2sdFAgfnx/YkgVDz0cIUvsM+KS0mOpUrox8oIuacE7CbYAtBcoAmiI
	 fYDLCvWVufdWO6zmDj8KXc4ps+UeD9iCcjeQK4dSse5leTU4dAHIPKTXhsXBhGxgH6
	 SdrJMG21VUFQM/Qo5wmDarPTcqqDfeMMI+iE6n/25UpNZnLScgq4RGFA/ujqAQcH4M
	 l/gvXASL/eMYEFuFgEyjiecVFA+Jqrz8nnXqo1tdvotUG+vhTAGOu5vOtZRPZlgJvy
	 mdzN/s2UmsuUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ADA860AB6;
	Fri, 27 Nov 2026 13:58:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E69DD311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D907D400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2481SzCpvS0P for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:58:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4922B4004D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jmLlu+uP
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4922B4004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5917F4178C;
 Fri, 27 Nov 2026 13:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839331F0089F;
 Fri, 27 Nov 2026 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795787898;
 bh=qZs/k2IcsW6xETAmy30azSqNoCLEhOTO5eU2yO1/LuI=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=jmLlu+uPV4TOFtC4dR4c74J38vpe29fSEMaWb2/amfZOUQVAG8cfAwB01MZH99Kqg
 mj0a6Qh0to0l3s+8qKa3oH+ianaOBNFLPrO8wcTxPX7/yk9uiew/a0UgbVQNWR0p6V
 Vu7DynSpWn1lNX0pJbZ376p2038tSu+5/W5FtlnzZ2XsdTDa+j22CQmN0o0Fcoet2n
 zrt+RNub0rLMwSKYTHj4Xxlvsrud43TF/X21EKDRiAUo5nu+oMblG3Pq05yMwVvcSa
 mADTynQJGh98vNy+1QJq69nYF/k0dyJt1tlnB9lil5I0XFjIjy4Up66Hk0mc92coAp
 OtFdS38fxSXWw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5/7] test: py: create the bootstd images for a ut
 test run on its own
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-5-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
 <20261124-upstream-avb_tests_b4-v2-5-ed7136c3767c@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 14:58:04 +0100
Message-Id: <179578788422.2215474.13939466855441760830.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=510;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=30yhcy5gEXjfYoWAxbMyoK7n60XVDHhUGLpT1PLPsCs=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCYxyWFJ4Q5a/h5zg0rrHP3C++7BA3q7XO1Siy
 T4jJtFukAmJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawmMcgAKCRAZDR20Zk4Z
 NYWXCACIuUCjW3x0mZMVBNMDTlmYplqHpHQ/bQPWbH8FS0wRWdn/QVAmPs2O5IXH6F2pQmie8nj
 6DcGy61RuDuPO3Cu+ZW33pCPwDXFhCHyzStvqZKhNbxtWi1ZpcoH6LnK2hzd57+ZSxoqF8dWu2O
 plvZv9Z59owsnAYPBuCS0pzR4m5H9wNCvEeKtoReWBCFRHT97Fh3a1yJ5QPRVqGwbo182eV8Lkk
 gwSes8O09CfyrQKe63oVQNOo+lz7AGLNmg4hxzo5mnTKeQzVeEodDod783kZnWLSdJRjKLESUcR
 vWJxTV53r29xuLV5ALgI16o1uwqYDoCcr3Wzk3BfvmA/hWl8
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 17:25:02 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> The C tests of the bootstd suite need disk images that only
> test_ut_dm_init_bootstd creates. A test selected with -k then fails,
> as that one is not selected with it:
> 
>   $ ./test/py/test.py --bd sandbox --build -k avb_preloaded
>   Can't map file 'mmc12.img': Invalid argument
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
