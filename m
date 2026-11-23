Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C0606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n8+8AaZx;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=tnV+3dpU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E92F44072E;
	Mon, 23 Nov 2026 20:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXhn_36QdL7U; Mon, 23 Nov 2026 20:57:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42EE440721
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795467454;
	b=n9k5xF3xd/7lQ0iWguboEjtQTVGrQvYwSE8WxyMg6m+dlyp9ZpaimNM9iaQjtBn6gsoH
	 TOlEsySoivhOIwG6RA2UGzYB03bmxQtGBWWAIJb20mcPOqOoO081djx/wZpcGIlSRosay
	 N/CZYR+Fe6otXoI1ntaJhXIAKMyq9aeokmEgfN/ctjLom3Qzt0R36vRyOZTKN+/Qu43Br
	 HQEO4qqTNNYowzXyVZ/8y/YvW/KqbGjjHtAHDRoqoD8RnKFklQeL6qTwk7DrU1bJrGSSJ
	 p0bu+2VC2Wwu36rCaBXFvsQzTIyWDsc60jNCHgId6A79ch2ezYp9jWdZbh/ADEZ+kcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795467454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BwcLmnzx+sjiYnsfpYMdHRwwjC93wKJxL9HbHIDnIGI=;
	b=m8+EITRRkDSwse2TCsJK8mt2a5e6QTDJdP3bSvshRbHOXtxNwjYEmo1vEOlofWMXnh6n
	 geMuEZEBwUOYUYoOObJRWr9UzH49mdoB1fvpCb2rHfO1Nprz2rQdE/aXCBvioeI8DahD5
	 bGtFZqbexbDD0V7NxDXqyZrgKqIJ1HCJruybx19K070hC4Ulz1ZpTzwlk5KZgiIpA6gEV
	 dwl+V34YBC/9qKAk4mY5fJepRe0xp0luKZCEfc0WghsskdWRT2xbQmyC42QwRCF3lu6VO
	 37ONLQtV7SilM4llnXHJai3YSCA/J27bpaKv+dOwooYXU2iUQi9K09PbXcW6jhaQqew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795467454;
	bh=BwcLmnzx+sjiYnsfpYMdHRwwjC93wKJxL9HbHIDnIGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n8+8AaZx/3LJU+BPrtZwggXlhjDcEQIfKIXY+2I0ihwAExYtgG+MHfN+C8ds2EwYL
	 3cd9arskKN/qNE23SYT5eq/xanQqmJGKztLOXEBTbY5VlSk3++TLKUqldg9B9+ZWZJ
	 ka+247WBoeXGgFWLrf8swcL5otIhRtdKEi80JrRatrSV60/rCl2wbbqOYCEPw02dBd
	 pQ+1ejVnsl5BVjItirOdprXDoUtGIku4gAudK1MMplCelc3ogNbG9l9rY99WlBEKsr
	 3G4ydKrgXjJb0vv1dBd40SKcdmh+N7FYJwqsf5YOABLqi8MCNBHhYzvbdWRs7hktjU
	 xsOkHYcvkAb/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42EE440721;
	Mon, 23 Nov 2026 20:57:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7BBF311
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADB9A80DC5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:57:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A2rq6KQDSPer for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 20:57:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04E6580D8A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tnV+3dpU
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04E6580D8A
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:57:31 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4a85c656c58so2353914fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795467450; x=1796072250;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BwcLmnzx+sjiYnsfpYMdHRwwjC93wKJxL9HbHIDnIGI=;
 b=tnV+3dpUvx2MGuEO/Ss3X/HG+VbMuXbftLy+X8bpQLzAjIVpJFzedhytYnFdZphCCl
 c2sRwoAuKBA/wo0z4jN5JZeorWSEPJZteDZ61KqaHvMe7sdLGk0YrGbE5ndh8cypPm5Y
 OJ7LTVIl8f5wxt5kQQBsm31mRQ7/XAnwjbpZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795467450; x=1796072250;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BwcLmnzx+sjiYnsfpYMdHRwwjC93wKJxL9HbHIDnIGI=;
 b=Vh9W4JV5X1PnvCLNYlcoo8qw736XR5q1dp0neC80PrcfrBZB+IToujw5gvyLNMsblO
 KH+S/RILnOHPkx+K6Pvtjh5hPKSi5pcVc7CIXCpaVwLrB9g0lY6LRdmA8QVteZ8eZDRN
 j0m/OQQWxEgF/cI089j7+9AVBEUZtdliREOr+rAkcTqhg+01jwk/wKWCnXdbR0SlhjUQ
 M33zseqcTBYqrKCIHewdnZ1LxwEx/gZBd0N9Gu47x/XOOWfrmNxtx9nTDvGeGofrGrdl
 lO0LtCkG18jD1Kwr+4DAzzuMep5/1wwCq5zGaEmprlxoe4P/r+DuGRmitGJQSn+AlDLM
 eIZA==
X-Forwarded-Encrypted: i=1;
 AL+hErG5jNdpo9urb+0jzfsqvGgArzQ378hLGIl8ylBE4Ez/zhKs17ABS+onpy0kpjkAkHnfT8jzIPY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8m0ni+qcxiQebagwF79n+p3UiNVxfpbtdYAQPTQ75MZ3vHINAi
 zspTklcIN2C4DRF9bg++hpdmfPJaHCUbcjnGRg8RL0f3ajZLdBRBULZvG//5uMucNAE=
X-Gm-Gg: AZFdTZc+c8JYCQdTkFRNk0wk398A8Gjo92WgRkIGhWA3+D1rN4j2OaFb+0HbMO/5ZtA
 6TK/jHTxbRTn3MKo/dWx/uUmt9TX0ZbGN3Aeu8lVTZAUZpZ37cxeyMHg690TuZ7PhNbjUMELIaO
 6HOsFUD8OqygnA5w0gzJjdn0piUig//w0kpGMTv9OXjDF4tYHRtQ7DkbwtGiUJfxsVCPSAY5gWe
 DsSYvyFj+K30mJKUbmmRBotjPGMIaMNwcLdaZv9jxsIpjpuNuIGrvcUYy7ikyRyeO1ZS2JMwlcm
 NnYRehEU9L4bqriv2PClXkQcyZTobrUBOSYe7gb3TBEOSlBGGij+hjz5ejqaz0kCZwAWnH4HaqL
 jTSb9rcPbrOFhZuBLcCAzwbjVTRmSK9hcuFqklo1LsBvrBZC2aCy0q7h62diUjXGoHVbb+jowoq
 syCjKWnpn1txBAlVwlPQa6gT+RddHERUXrBfDhBm51tyfO9DL2zhm35FyOrHTfWojQY0Tqg8I6O
 uV213J8KRThpm6rNyvrkrmYN/q2kVzCvi11SKN1LYS2Hvb8hGcOLG8QS+SU9SDlP72bKNoZb2VE
 wRcOBIcyViTVPZe7RmWEO68xsWWsFANhc+T3ptI/cTWBc8kNAItFHB6UkY2CbQAfLDdUclzBFID
 5iAv83GmYGGAWkF62KMrtcijZ5dy1nlv6TuKzgG90/Y12nKZ6HNUtHTXJ9gl39GbwMKhDeNiK9A
 k9ctI8ZHs6HB2eT2a5avU0ytpQNE86HQ==
X-Received: by 2002:a05:6871:54a:b0:498:f70a:b54e with SMTP id
 586e51a60fabf-4bc8434fa39mr11833830fac.43.1795467450463; 
 Mon, 23 Nov 2026 12:57:30 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5ebdbb4fsm11151928fac.5.2026.11.23.12.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:57:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <awLB0iSbrVC2XS9U@nxa18884-linux-1.ap.freescale.net>
References: <awLB0iSbrVC2XS9U@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-next-2026-11-22 for next
Message-Id: <179546744954.3478803.15936434137369662896.b4-ty@konsulko.com>
Date: Mon, 23 Nov 2026 14:57:29 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 18:20:02 +0800, Peng Fan wrote:

> Please pull mmc-next-2026-11-22 for next
> --------------------------------------------------------
> Constify driver ops for power drivers
> imply LMB_LIMIT_DMA_BELOW_RAM_TOP for sdhci
> Add sanity check for mmc_set_part_conf()
> Sync hwpart and capacity after changing PARTITION_ACCESS
> --------------------------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


