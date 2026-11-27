Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0B606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wby0EDvq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pc6xFkN0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 226DF40A70;
	Fri, 27 Nov 2026 13:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jB9qcNSxCc9D; Fri, 27 Nov 2026 13:58:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3C57409B1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795787900;
	b=nEmWojWclHhBleYzlnwFepNMczNk1dn6BYzMYWimbsBAT1TkwdOzQ7xO4pc/wFu7y1Dj
	 Cpb+CH+Yrt1AFgONd2J2hZ/AUGx4iX2Adk0zAOE+NnlsUPUGdZBvASfNAV1hsw9DHqdrm
	 +JSH+TuDWGzoWQR9tG9jxI/ihVB19/qt7nLvgoNPv4oLuhWwXVrLeu84NbHXC5TtLWnn+
	 8mCmEq31cMasanIzCAK8vukBudwSn+tArfBhZZSyN1sWw56D9cmHexdFiImX2eDHbv4z/
	 xP5J2IFKpYbKFY5+3rsDJfP/ZXXlwk9m82IqOK+EubBnckP5fmybh+glc9Ier2XzkZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795787900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+pErcvQW5huljPiBBWqFD20NeQv+EC3hVkHemQB+y8k=;
	b=Okt0vjYl3n9oZ1lBP66UjRUd03UkxeikDE//T7MTbtxfzPnyUuBVIQGD+UTJWU3frmaj
	 mJlILLXOfXPE1XUqxzYIpcYCeGAEJKmWORe5UWYiIEWthbwOc/Q0wJF4tYthHVJx3p8s9
	 zy+bRIgUrAyfbqwHOBjg7nqXXyrODmK5lYjWA+uMn2JP9gpvDTHK1DpjqXRN1GXubxKZ3
	 ar2RF5PI/k8f4XEW3Zzs6Vp5qQE6yVPLZZSJU39lCAIeIqN9lfy9md6ImY93SltFmJ0iQ
	 sZY3nxE+GQkHLXGNa+DshI7D8NBSfUg+O/8O0+xSK1U/fPKhA4wLNHkFXCyo3WoXOOg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795787900;
	bh=+pErcvQW5huljPiBBWqFD20NeQv+EC3hVkHemQB+y8k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wby0EDvqJsVSNO3RHx9rIyhfR0AuSJDCQJaNk6yic/ElI10Fgnx6G2duG8AeEjm2t
	 QXNvRi4FoorP12DUq0xWxFJH6kCq6mYNHbaDP7twAOk8qJMwoSV9SI/BV3ffPA8Rql
	 LvDzCVULUx5Q2xe44Wo0OyVUIIBK7C9f9Ze0LbO6dIlFPnwg9rrwcA2DHR0NZAz8+M
	 ZrZy07vVgeEFPZfhNxmDC9DnXHa0cO06zjj8Z9nMi7mJOmDPDnRKQmd+wSrcOX46rB
	 xpXFITh4KyX0WfsdhvndyH3Xsm1/iFw33/t9lD6PDwiagZ/RadPqoWAgqSY8MXLrdL
	 JjoDmsInYOZcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3C57409B1;
	Fri, 27 Nov 2026 13:58:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6743E373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D2FA60AB6
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ij6jKxkGkATL for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:58:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A55B8605E0
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Pc6xFkN0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A55B8605E0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B248443C3B;
 Fri, 27 Nov 2026 13:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C84D1F00893;
 Fri, 27 Nov 2026 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795787895;
 bh=+pErcvQW5huljPiBBWqFD20NeQv+EC3hVkHemQB+y8k=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Pc6xFkN0gV/kN0A8Kq/0acHq7Z81Eats4B/XjMzYIG4x2tuIcE9PobuIa2+Y9uaM4
 GJGqEJY4Na+OyFVBW1n0LN7h2x0yF+HCcuVUNTG5XBOQyegigwxOjN8VDpIW3mStFN
 M43B+gbx/TlCvHmdTPNzuw9QH8BsIBWErWqWnnpn4FmRjg64HjJABAwJia1rKA4VjR
 UVBiizSpMrY2xhL+UvWS0vVoCMycHKz2N9jWkDtVvXY9z3VS+IsPeXtoTzTzUlbRCb
 4CZ7SLmzgFXWNAYtd3cECowMso+Pp5I8J4I5sA0oGQnnJCG7QNT28r6tjTCdrXMKbh
 pE4TeQD/Uk+1w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/7] test: py: android: replace a disk image in one step
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-4-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
 <20261124-upstream-avb_tests_b4-v2-4-ed7136c3767c@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 14:58:04 +0100
Message-Id: <179578788422.2215474.11504618142822207601.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=567;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=xvbSTkHq/xOzo4S0+bcUCgdz1QqrVephp87URdZa9bE=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCYxyQ7KzMF6fDsJsiRS0ORgtvSHkr/qL+EjDJ
 LQzx2Uv+hyJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawmMcgAKCRAZDR20Zk4Z
 NQ8GB/9y2xK3lqXtt6BdSShosfk+tcm8SsuiuyV13YovaBeKu9YE/PRoo/R/D/O1yOQ5qSuBcgb
 tcCarJqWBt7tPml/LAObEJD9tfqU2XPIE5vDQcvm203uoVpt/eqgoUIe/oJ+jE+iA25F11crdH9
 ZIHwIXgRw2BgawmxycFpTTEiuhA7T3hyUhv0IbzD/X64x38D7UnVoHFGXOoUTNjGK3FGiBXP37S
 +3kRfN+oeKN9FeFfHOxnfBERcq50hOqJ+SWnBisaLntT3FUbs+o/t1wHF3ZKGMoYVxuQrIMvywh
 SeXa+QhX1O9v32NCGCrtslpvmZZiQCscqxnbiDoa9qE2SBJ4
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

On Tue, 24 Nov 2026 17:25:01 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> create_gpt_image() writes the image in place, so a test that uses it
> while another test recreates it can read a half-written image. With
> parallel workers, the AVB tests then fail with "Magic is incorrect"
> when test_ut_dm_init_bootstd rewrites mmc12.img under them.
> 
> Build the image under a temporary name and rename it at the end.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
