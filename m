Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BA606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hkEUmAPN;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=KqTBwW1Z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D504B80BBD;
	Tue, 27 Oct 2026 22:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id av6Frq2UCOVT; Tue, 27 Oct 2026 22:47:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EDD4480B86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793141276;
	b=QIgl01t5k/CmCwf26ndIe2Ov0MFn1njjsIoNqEJpymfZSYfNn59+jjrX3vzxXntRpJaf
	 bcSRKN9vEHhyJvpMFDmsLhKexhFt7KmRrkzJN239OUmP5jdj1pGkEXaSe+IaRyhPpYtwc
	 EWBDRbbxejeC9kFcQxm60B9m3zT6cGfjqgyCncH2EFvl43jFhtcIhi5ijx4zv9Hq2BkPK
	 DwQ5o+LL1/N0jCc3vKWHcy0dZei7vQb0oqvXF98bpAU3B58xMqPVrLU3WyM+A3FZ8eLkQ
	 NmZejxoecOV3rvHxXpTMDq3gIYIhqCg2t+o7YQifXeJbTw9y3s8gXIwWsVESpAuNVzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793141276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yBk0D9cOSEghNsPWJN+THy+BOuKilsuG5cT1UoKsVUU=;
	b=FjUN+j/6DggZQCt6HcGDY3Ug03rbgbD7j/Mr1lPSFtbcO0oQbGIdptZN5T2lLjqkADw5
	 X4GaTz6vAjNtlwzvO/7LU6Q2+RsawUI8EftSmgAOwqNYH0om2g364EQmMpxc+r+HBn2OI
	 z9P6dfsaAnF5AuT3KXHb96fpxJPzBeSFLIa0zIH5RivJU7EOTGEvrpn77oOPgQV820lPQ
	 k8UU54m0gsxfp3UaKAB25dzp/Hlrbslgp/6/kJicAwq+PCvbFOUdkh8IuwxBMDjVqb4Fv
	 CM/15MphOYYnryQ0aiHTzCA3pIESIN5KyQSqbCiSApW+3YUA++L//U+S/2NsZdmhpyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793141276;
	bh=yBk0D9cOSEghNsPWJN+THy+BOuKilsuG5cT1UoKsVUU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hkEUmAPNqwKIi2a1YVtFRLOsDIgiwtLbztQRRdj9LO6HXHIzcXEpq8PyZiCVRUIfL
	 wFJavIUV8x9cW0khJCz7Pgnp/3mGAxf4gL5NKqFwVxl/WRl/v/DdmKlK4Q+sNUOL0V
	 oTgOz6U7iiRkPFyNrIlJOMu9asNdqaumtYgTpVjG9MSDGKFTqjccGDMVv7J0M1mfcV
	 RQ7DuZm99ZiR/eCs18nVXcDIgMHzZHkZ/iaR5ehsgghrqjVKcRMj6Lg7TuVKWW3KF6
	 U4/edxwnZdCm/E3i8Z8z4YDZn461KINuTagUV/4FzPOsSMi38LtWK9Gnf3zIrW5d/D
	 Wz5UVKKfGq4nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDD4480B86;
	Tue, 27 Oct 2026 22:47:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F86B235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40D394058C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m4H5g8ZLrN_K for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 22:47:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8667E40589
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793141273;
 b=UiFEHu/s2hcvwRpuQ62WuaIAbv3qHWbLpPvkqFa/pXdyGpg2goliHsQVUqocTsW6JLdD
 Po8exBM1fXCu2NPOk86Wse3fYn7+h6Z/rFvg7jtHjr0rqsuHEZL8y4CVyLaJR/NazGD5X
 33Fi+11G1VU6XzzcjvAt2aHkf+xXevPvxWrKwkX4omVRmvUMOB7Qx56vC0tBxjBwkDfM/
 Nzvj1kK2who3YGV1jaOSdcAGuuggK4YH37q68c1MsVjsyOX1d/uRTljyiZ0A7X56UX48t
 gvorSudaiAItwV90hyz7hIJr470YG6SqT7LaeDay/P7uie3qWnD3QXfB7duzdCwCAzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793141273;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=yBk0D9cOSEghNsPWJN+THy+BOuKilsuG5cT1UoKsVUU=;
 b=njIzZwVtT9L2m5iM6iqH9K5OJIFgHa2oL/yrpXtYY9YfvDkpu2svQMUo8lsDpzh5RzgT
 aAVzSRFOr4oCfAYOmp4+MqzcTwDIvLcRZyIDUa7V9JfjYspudFxGgYvJqsAh2vcNlo7fz
 GW7mhWSKmnAigNgmfk3UK4Fhqquiit4Ea4I9Yd6hQbIDEbZ1RtsIJTTYPHWCIW59v9HA4
 aVfDC2IfYTmsgYYHwz9qjrXY83UrgbHIcj2Rc3WupTHIYH66jvjqIbODf4Bh7CzkwpLfE
 ogZTTjP1alR7yHG6j/N37QBwoalf+hD0eWQTektZw/iRA1Cx+izAQfN00mVy7ZhAqqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=KqTBwW1Z; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=248a=is=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=KqTBwW1Z
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8667E40589
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1793141270;
 bh=yBk0D9cOSEghNsPWJN+THy+BOuKilsuG5cT1UoKsVUU=;
 b=KqTBwW1ZfMtXfmvg65pVdhuNpyJB53abFoFn1jNSZKWa5Z0NYW0AzU9g9mmNtZZntzNn4fu/z
 EfqWhTPmDjgaWq2OLmNPu2m7vBRoNi6whPc7pmKiVoPz36JJeoQzyD6j4S6vT+BJwRjGfxF60yQ
 zrKGnMVqb+dtjYk4HCYsdWIMbbGIRYFwyTqpr2EbeXu5FHwS777Xb//IQUq43m2hdqKR1PTP6Xf
 t3d0o/+WGX/rkCynu60PUVCJYmx85/4FyCbbqBVAXJr38SNH7QAnZSDnIqozdapFlFnl8NoEwnL
 eB1fKxu9nzutXftF+GMJ8j0j/4M9HwMq0iTGc7JEwj6A==
X-Forward-Email-ID: 6ae12a1361225291cb468a17
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/7] rockchip: Remove unnecessary clk_set_defaults() calls
Date: Tue, 27 Oct 2026 22:47:31 +0000
Message-ID: <20261027224742.2527550-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The driver model core and clock-uclass will call clk_set_defaults() to
automatically apply assigned clocks for devices during normal udevice
lifecycle.

This series remove unnecessary clk_set_defaults() calls for Rockchip
drivers. These clk_set_defaults() calls likely originates from vendor
U-Boot where driver model core calls to clk_set_defaults() was removed
and moved to just a few drivers with claims to improve boot speed.

After these changes any CRU assigned clocks is typically still applied
two times, once for the clock driver and once more for the reset driver.
A separate series to introduce a driver flag to skip clk_set_defaults()
is planned to address the unnecessary apply of assigned clocks for the
reset-uclass driver bound to the same DT node.

Changes in v2:
- Drop already applied patch
- Remove the unnecessary ret variable for rk3576 and rk3588

Jonas Karlman (7):
  clk: rockchip: rk3506: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3528: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3568: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3576: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3588: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rv1126: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3308: Remove unnecessary clk_set_defaults() call

 arch/arm/include/asm/arch-rockchip/cru_rk3528.h |  1 -
 arch/arm/include/asm/arch-rockchip/cru_rk3568.h |  1 -
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h |  1 -
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h |  1 -
 arch/arm/include/asm/arch-rockchip/cru_rv1126.h |  1 -
 drivers/clk/rockchip/clk_rk3308.c               |  9 +--------
 drivers/clk/rockchip/clk_rk3506.c               |  6 ------
 drivers/clk/rockchip/clk_rk3528.c               | 16 +---------------
 drivers/clk/rockchip/clk_rk3568.c               |  9 ---------
 drivers/clk/rockchip/clk_rk3576.c               | 14 ++------------
 drivers/clk/rockchip/clk_rk3588.c               | 14 ++------------
 drivers/clk/rockchip/clk_rv1126.c               |  9 ---------
 12 files changed, 6 insertions(+), 76 deletions(-)

-- 
2.56.0

