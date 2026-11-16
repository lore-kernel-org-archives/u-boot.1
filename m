Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49C606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lmykth8N;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qGRP/Kq2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ED4240743;
	Mon, 16 Nov 2026 17:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YV1-M_-jEUEs; Mon, 16 Nov 2026 17:22:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A9E7840730
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794849733;
	b=MVbaxhumuuwHYvijcWduMK6Q4c9db3CYgOOWZs8Qfs9Y3WtVMcR82S2GYiJ20M6XC8OF
	 zUPcuDalIyst6wVMtj/S/F972++WR1lQzz6s7ciGuNgXUpQSAn6zhsRDgTXqlB9k5Hkjl
	 UsE0itSBCf5XCK3DIgWFwCv5rbHEHjW/Gvs1Hvt5KNfnfZDPl4n9Rd2Am/4Gi/wO9ffKB
	 rqopnugxZAJu2GKCxRJ7JnBl3pcb72GpaGaHvW3j8CJdARlzpayky4w9t9QVLPbzMmX+a
	 M3QFRIZ25HdYHLIizo3PX3+VzJuuW9m8GbzraYys6EryjHCp5AKgBe1/9fljaDgv79A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794849733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hH3liQC7yXmYjq1g9g91ENXR74VlgqEAaKFJn3jFvpY=;
	b=FBe86Uy1eZKlXTYbZ34hsElanMq/m45vMeC+FfwIygPOX/hmifK7tGNP2lVm6VjH4t/m
	 9qoQKSm+bFW77Y6e78qtK3yn6+YYN4hbcW8Ky1kStCKGGloCaNMTQ2Q4UdapeG4ScgnYK
	 OiNWkcVaIu26Sj6MpSM9SRvl5wIZdI4OePp4A3pKXGYakHLKIeD3GciLX0NxirkEJNLhi
	 Ak8ZY122+GoZPA1s4m0QOa33QKe4qQ2VC2+PLOjKUVWs8w+t8mh2QqSW+/Om6FxYjWMez
	 8VHyOwi3g39wF8IYw29xAQf5c8c2lKzh0WQvLegBkR384CF7MjCuytbxMfsa6+rOWKA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="qGRP/Kq2";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794849733;
	bh=hH3liQC7yXmYjq1g9g91ENXR74VlgqEAaKFJn3jFvpY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lmykth8NkKVKvgKDt+tGF0srfSQjo/P/9WW1cGpnvoZDhqvLtziGet7hdo932FFec
	 dqrlG1gQIiD0Aw3OIH5tlYXg/YcmixmYP4Qit5yd0A+oeJOwXjm5A6OJLdT/i6dbXh
	 iXmoP9+NJ6Xi+AnpTo2Hu/jEpBZVNV47f7ZDH8cg95M7F1yAyarn3iou0SFNPA5ndv
	 fYG2bedpwUWBOXsaT1jakEu6puUB0Ys01JzJf7bKeOPNu7np7R4mNevdX7dJV1ayVr
	 nqQuo+nXTeIvlJq1NVybu04O3IRw6ZtGOXSlVqvkaPyPQwcVk0jz8Rwalpd/ttT7cM
	 X6EbbcSAf7Otw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9E7840730;
	Mon, 16 Nov 2026 17:22:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 460F94DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 435FE40730
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9sj0_PM-uFjy for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:22:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60B9E406AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qGRP/Kq2
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60B9E406AE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:11 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-71aea92f666so819692eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794849730; x=1795454530;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hH3liQC7yXmYjq1g9g91ENXR74VlgqEAaKFJn3jFvpY=;
 b=qGRP/Kq2YbM8IoXMQGkMEkXEviLT5yQ1XtFtrxZr9nOWDiuFCCS0pu/bI2HNPIfSlZ
 UOdG5s+mgBWTvMlvUJUW6B64NK9NwxdhGF0ntPBi/SEe2utqN7lp3xMCIbwL3z1jtC8G
 OO8WZTGoKksI46jTJLxPs10o/cvx+LpzDLCM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849730; x=1795454530;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hH3liQC7yXmYjq1g9g91ENXR74VlgqEAaKFJn3jFvpY=;
 b=P3xgSYouGlTpUuAeB/A5Q2eXwoS36ZJPPR+QNJW84ai4WY0ciM8aYSNQQ6K8Fxxn2M
 wl4VSCTK2ulnkx3WuPuVSuEDltB4FWPlZQxNRu3HgDPrwK0zWh2Ah50jo/CEaWzpWUsu
 TAJWjF6Udr2jCW4gLsHqmrmn28KSE1/i20FsbUJomg0Fx3R3HGhr/iS+dhHw7i6e+HC1
 sf681v348zlJtrWP/+BVG1KG0f/NCqNuuuVE/ilP7F0MyweaQcRN20cgV2nulLnZGdki
 aCcJjdknDtFEHafZg7T3GdA+aNRNWPh/MMvSOfTvlolu61c2jRoj4ovhaNSqCMkDJk3B
 pznw==
X-Gm-Message-State: APuU4Z9DguSvdvgFDwob/YF4m69wec+4JyCCnRqh48ImnALEC+XNqbr/
 rLKlHmQW4vvWR15ivzmL+BfAUYfaOHoXboo5YTb6bHkvzofaJoHCrkjWalmo5Q/OanDDGByV92x
 OmRPaWL1AXw==
X-Gm-Gg: AYBFou1EIAEsn/yZEYRIEXi5q3AK6QIXw+rw0AHt4KCgIe7VMOapL64fnMUgJnaprcr
 4SAIPFq7I3BiznyLjg/aTDfLjro4QFn5uFqq3dxD0f1sCu16hlb7UHdn/7DNUlRx90scSwP3wMV
 tOvxbTIBtqaX/pW6Z/Jf/9D2NizOeExibNIfMlJjeQNhG0ePDWID5VK46hKlIsUtNy0yU9HmmfT
 15ydiEQyuBEOg/ovL/zlDN7HNJ+AHbgFyNIZk/fTpbpb9Ls799riD5PTfFoyFubaL8FcFa4kdRO
 XOyDRXB0BGf8Nu9tlBxbKvoJAEiKkMmXRJbHUW8S1o2MInLCzgvylkLT0/tdkTl8vjKrpnI+5LF
 Ziex3K8VzyCxiL5q0mOwCZtT81SpQDMPrlpxsUgB637cfRdkiWbsUmTlj/HIA/ASKhKPR1d0494
 KumX/MGNZLoDM6GhusR3RaPh48A2/buQQwsraNElKQF1EVAqZmUZGlK7vc+jjHX1Rw7XMvLuZEF
 revDClbvWAg4RQ+uovxROWRWhl5mqYRjsDgPfk3OC4Gh2ui6hpm0nK+vmr06At/b7Mlu5k1voiQ
 CFEkCpRmsPaXuETgDRbSnDKbrM1xbOHY6R8F+8W6dlBIUj8WGEFsAAf0E5NwhAoOpAiKcWscv6n
 96CL7qSzaOIqHq4cQ+xqNoirEh6A6NXj3cccq/ub1GD9DkeKuj5rgoO5AvdvoEqUHwwPgHpYSp+
 7Yb2xSb5m9T86dJWYP8XhMQOLnwVpUxQ==
X-Received: by 2002:a05:6820:1614:b0:71a:cf71:eac8 with SMTP id
 006d021491bc7-71ae491827bmr4312582eaf.57.1794849730190; 
 Mon, 16 Nov 2026 09:22:10 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862a82c4625sm7191658a34.22.2026.11.16.09.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:22:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261114172953.732309-1-marek.vasut+renesas@mailbox.org>
References: <20261114172953.732309-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/main
Message-Id: <179484972956.2141271.11362463804629611358.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 11:22:09 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 14 Nov 2026 18:29:04 +0100, Marek Vasut wrote:

> Reduce R-Car Gen3 size a bit and finally enable LwIP on all R-Car.
> 
> The following changes since commit 6487c50b8a40f2668ab98a892b9300ad5c181f38:
> 
>   .gitlab-ci.yml: remove Simon's lab from CI (2026-11-13 09:09:28 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


