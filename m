Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD81606A321
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gXtV6wgI;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=2IjkN93g
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9079560EFB;
	Fri, 13 Nov 2026 07:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ckUJ2SqHcRkt; Fri, 13 Nov 2026 07:28:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E995360E48
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794554919;
	b=E4luMZLnntHm6YK5pu8WyvyYffTRCgleicqT1jK9WM6DEHHsV80yBayk96EH3B5uiZzs
	 cwKJ+kxO37amenYJmhIjuBcorf8DKzb45Evmk06xMr/ZFhjNbkg+b7mpeeNsMh1KnQTQp
	 ZZewmBI5B1OfeNBQAjGyqpIQYd634pBGVDn+B439+Lk+QvTVbzq6TkBuUkardmmGteUkP
	 f1wsH+Eqc8hgVetXXdJvjtck+8QhgBN9EH0L2J+wD84yROa4RYHPwM/P3PaYeHhkKsV4H
	 lIV2JDRRX93A2MXeeYEXbVOlCPFzrbEVVgx2ex+U7pXvS6GV/l2olhodDUoI3mGR6wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794554919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cYKb/uPWDj4+sXnda8JEMBYnhdxl4nSM9Fqqk3VS+To=;
	b=Uo27eXIpAp0GJ6wPDGdA7jTK/9njq7yHMtaXG+KO0nez7P0rOenJvxTJwHOXRXXhV0SG
	 KX9OwtXlArUeEC1EMGhvu9/6faSLs41IfrZvzYiDwJTbGoKBkDvZ7nPl/M0kd4Anc95jI
	 RPZRmu6gd9HP0P9xP4e6cfOPgKIH1r54TC9lCKH7w1OojozFy/5m7Vx9gSFOIWBxM7ttO
	 4i8MnQ8SGT9ASUIOV4c7y6QnylyEGCy1qgW+1aFzmudEWMed8LUVA04EiZdk+99g+zzRI
	 3Ezea5CxjoLPjVOdYqeL/wBBp+0O/uKiZvqznWxd06m9kY6iMlavwkkRW+Hl0GjoRcg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=2IjkN93g;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794554919;
	bh=cYKb/uPWDj4+sXnda8JEMBYnhdxl4nSM9Fqqk3VS+To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gXtV6wgIeAEH1FidJz55lvho8QwC/nWnlSmHHeIEKrumTPiZ3imheGc6FzbzUiQQr
	 NrPfQJo5Ub3aeb9XrQiwyqr39HYxm0693DQ0n6Blvgurn8vzx82U31UWD0LIpDAEDV
	 db5iIDG+uKS67RWfr39mTqsN26OJfEmSpYbMGfGNGqz9cdtBQ6fqG0IPu7Ho9wZfTW
	 BO5gz4+G//jnt7gWV0P04u9YKEy/jSFSe9QGSikzle8uordjuKlkfIpolg6+t+J+rb
	 AQzlQLHVNIJP51jr2V5auCXwj+Ge81VNJMOcesvPBq/JBiTSBTv+ycM9UVNC08LuML
	 zZsDcWFh4DhhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E995360E48;
	Fri, 13 Nov 2026 07:28:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78D3FAF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 766F760E48
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c5j6w4Mt8-C9 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 07:28:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9818260E38
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=2IjkN93g
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9818260E38
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:28:36 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 0D08540075;
 Fri, 13 Nov 2026 18:28:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794554908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYKb/uPWDj4+sXnda8JEMBYnhdxl4nSM9Fqqk3VS+To=;
 b=2IjkN93gW4wfh6MjC140YRwZPqJFHjOJT9qDgsOsbRL863scwnMINiWeDuvgkOEvdxhhGW
 Z/haW8x2mx0nD/JyQPvy8FwZ4ae+KzxdtAXESPD8ZTAMgBG5/8wPBnv8V9QOf8Kk66rMBO
 lQj2UbJ384RcS5j+MBRPXOpAwtmPRjT1M/Fr4NfhbLOU45kVr1m1LARHmWPNAR73CYBZnU
 lFNDNeDLv1bVdcuMWEB9BSEfVwvMjzHLv75cqBWLBjEOB8ddQxnNUNBZ2sSxLMRmo1p7bG
 dqDR3ZGlxfmfpdeJCEdG0kW6PAes8s+GMDXWsBNJStbCRTT8I2lUbj2KycPM9Q==
X-GPT-Reason: legitimate personal/professional correspondence.
 The email is a technical clarification regarding a software patch
 (sunxi/Orange Pi 4 Pro support) sent from a known personal domain
 (alastair@d-silva.org) to a matching recipient mailbox
 (alastair@d-silva.org). There are no phishing indicators, no malicious
 URLs, no urgency tactics, and the content is highly specific to
 a technical development workflow rather than unsolicited marketing.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 00/26] sunxi: Add Allwinner A733 (sun60i) and Orange Pi 4
 Pro support
Date: Fri, 13 Nov 2026 18:28:27 +1100
Message-ID: <20261113072828.2457732-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

A quick clarification for transparency on this series: LLM assistance
(Google Antigravity / Gemini) was used during development and debugging
of these patches.

I will ensure the appropriate 'Assisted-by: LLM' (or project-preferred
equivalent) tags are included in the commit trailers when rolling v2.

Thanks,
Alastair
