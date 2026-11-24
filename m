Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB267606A32A
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oLckqtCO;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ecEQKtuq;
	dkim=pass (1024-bit key, unprotected) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=L5IW14GY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F87A405BD;
	Tue, 24 Nov 2026 20:59:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fSJGblHHxNTE; Tue, 24 Nov 2026 20:59:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92CD540352
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795553941;
	b=YYkztu8ZaBI4uJ2KQw2oEfaX1fraE7obmf+UfDjgcxo0SNaEeHjlU8S2k3PebkdCsnWd
	 XTvUaMDTV/KPplHx2N5G2O9CWEv+LsM7FqAwdPsQhKWi5iDGJoTbM+U9EuNG6NWapv4lT
	 k+g8DSGnq3UFZZqopv3OVZi75PzDUZlnVTu7cjgYwbSE8T3I5n+kJxgu0Fd3iIJudG712
	 Nl23+SAimDg+HHZhZZKznPiy2KaDZCEK8Gocac+RGXlyyaEVBY7T9hyar741GWOvqHvtS
	 QJA3UrepTg0IvHseIN6/nhnsx/NxdX9tRuIPMKg1GMQmb6ze7P9W5OyQ7KdILmIXD9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795553941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/kxCn+shHobiFwEIhl57zezA0+v62BxASjekLEgdGko=;
	b=tRshy2NL8MiDvAViAUlNkNVBW0ufs5GOuHZFS0MwEwoWcvmoT4VCuwKlBMwK+RahCwIX
	 crfjieAy8dJbNWDHUQ1n6ZmIvFecT6G7ApHJ/Y+DE5rdcsrFoZAO5/CjoXkX9/Gx6Kt/b
	 POTJZym1DecJxt593sJZ0LK/EFK0vWaGj5n83XFhzVyGJLvJSQvNp1mfF5b0Fy0lBlHlV
	 bDRnfVzeaNaXFXj64oFnJn88c0/58ZNpYTassVL6GLF4n2x8TIq97GJn2L5F0rvDZhcNj
	 dpSW6vTpC5zZ7EX+PL0LdBz6HK/TLG5vpLneM35r+PLNycGgJYBqHqHMcBglh6lHDhA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ecEQKtuq;
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=L5IW14GY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795553941;
	bh=/kxCn+shHobiFwEIhl57zezA0+v62BxASjekLEgdGko=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oLckqtCO59mjdwhsYOtOzBAQmksC3C3hTb/gbfgFwz4gJp2JrbvgGhfGY9rc1DaVJ
	 7X6v0SDztv5QnpMBF9qsFt/OaM7gACWn3qzg8iVJO9vHyz/njOfBrImHmOtdb5lm6D
	 nEUNSz3h8D9AmVPw6+scvyval7zya+0i3XwxMc8nGJPtYUVjLgLFMLKn5BcqMs0A6s
	 uOfnMYPdlqb+NYayU84kdAJ5dHeatl39CSJsJa0YYHBzjlDnYL1ErK3IM/98FeqXDn
	 G8IZiQCVFlZvl4O18LRblPEXmIKCnCqYtQxUNwTQQJM4ReI5Prr3zf7eaLW5+kk2TY
	 X4X9UXRct7Q0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92CD540352;
	Tue, 24 Nov 2026 20:59:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 941A72F5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A0A4405BF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:58:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sUo_hTZVcnSO for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 20:58:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C85C40352
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cbd4=jo=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ecEQKtuq; 
 dkim=pass (1024-bit key,
 unprotected) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=L5IW14GY
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C85C40352
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1795553935; bh=/kxCn+shHobiFwEIhl57zezA0+v62BxASjekLEgdGko=;
 b=ecEQKtuqyrpqpRsMw44TLItdT1gAjXcAKSHHjh+gc7ycPZieWxFDiJJcFkrHFJSk70PwLL450
 RDy/cqqCpL1IxYVZaEcIRFcujP+RQeH8al+xkFUamsvP9cU9popfOyO5LHgfAzOX7YBIgevWpFH
 g2lCbuMgWQq7wVSRV6LDSyp8FHSqftakMWxwokVRocXH0VPwhUqIjvb+N5pvNirvdlGL8R8v5FT
 hAEF5n+8j12Gw2b+25QeP+kAKvN7T2/FwstyqayQz2XHO6g+r0/QYynXCYENspuvaYH3V4NHxlT
 Gd2dpDRk3sXZstIvxZf+syqxbH/S9RGtiFkVklcsMNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795553935; bh=/kxCn+shHobiFwEIhl57zezA0+v62BxASjekLEgdGko=;
 b=L5IW14GYHFO2Fbi2cZ2uyqQEeMD5PklzCy4oXBivaa6zj8ESvdJLpLGMPj2n2eFQqQf6MgyOP
 HPTIIlj4DjbU3uRmqlXY8tCfM7QvFaRUP7WZC0KtQynUJAgYisJqeMy4Jr7SGIprkuMoQSh29Sq
 7iBtfG3IQivZqaTNezUuUhY=
CFBL-Feedback-ID: 6b05fa8c1eedfc30af5a535e:0788c1e39691ee42f5f93bbba1811f7a
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b05fa8c1eedfc30af5a535e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] rockchip: Miscellaneous updates for RK3506
Date: Tue, 24 Nov 2026 20:58:41 +0000
Message-ID: <20261124205846.1536932-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series includes miscellaneous updates for RK3506, such as:
- imply OF_UPSTREAM at SoC level
- updated default load addresses to support limited memory SoC variants
- changes to use FIELD_PREP_WM16 macro where appropriate
- print type of RK3506Gx variant during boot

The patches in this series do not really have any dependencies on each
other and can be applied independently from each other.

Changes in v2:
- Drop saradc related patch, no longer needed after rk3528 fix
- Drop clk related patches, expanded and moved to a new series
- Add patch to identify RK3506Gx variants, similar to DRAM init blob
- Update memory layout to divide memory between kernel and ramdisk
  more equally on 64 MiB DRAM boards
- Collect r-b tags
Link to v1: https://patch.msgid.link/20260803190946.2259514-1-jonas@kwiboo.se/

A copy of this and other RK3506 related series and patches can be found
at [1], including board targets for upstream submitted boards [2][3].

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506
[2] https://patch.msgid.link/20261122060114.773624-1-jonas@kwiboo.se/
[3] https://patch.msgid.link/20261122184532.1300004-1-jonas@kwiboo.se/

Jonas Karlman (4):
  rockchip: rk3506: Imply OF_UPSTREAM
  rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
  rockchip: rk3506: Use FIELD_PREP_WM16 macro
  rockchip: rk3506: Identify RK3506Gx SoC variants

 arch/arm/mach-rockchip/Kconfig         |  1 +
 arch/arm/mach-rockchip/rk3506/rk3506.c | 31 ++++++++++++++++++++------
 include/configs/rk3506_common.h        | 24 +++++++++++++-------
 3 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.56.1

