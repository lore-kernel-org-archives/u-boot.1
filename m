Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6334606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hZp8P3hS;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UwPZADjt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C43A180D13;
	Tue,  3 Nov 2026 21:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bH8Z6Dy_gZjC; Tue,  3 Nov 2026 21:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 23E8E80D16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741713;
	b=bInf+EF5fQhcDJ0pdNdqGi5G4YxxKfGyH3zGN/ObmCpDW5DyX/q6epUGUj+ANIalt4Vh
	 KqOHcSdHUvFfr6bVcAi9CNg9JQnXOY00TXiuurVuk8fmCg9wGm8s/R7ibj38uIJVUR+I0
	 daehMxZHmBNTVymv7W8KPasz2SMXZl/3+4ZGso1ocYtBoJGnRfBwqf+XqrrLXMiP/AWyp
	 jD+JQpgRdjevaLdI/9y4iNBn6NUvg2y+R5X3pyTgt9E9t5je/o8SvZ9It7iWdD0qonkDF
	 VPcXVptEt3N5G0bKppSdsBWkIVrgBro4BewxYJtxBjRnvSRNzGmfcp2k0EPWqMfx53A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eiyKY+HIkqOasc2gPnqSGr2ENroBL93XHETDX/YJ3us=;
	b=out2Qxe+BKJrVqs/wk6lhG7xZGI8cZbLtCwiq+qDeG/T5uYW9oBBH9yC0rUXRf9q+gEj
	 mTpbQwsqqHJepAtcJDduTDdFjosbSdkUxssOTEllKDTr1XZZOiG9iOH6hX/CEQNevYcWz
	 eXX2Gy3ZOsovRi0nwH9f7GIZSwBZ6nsUU5kg194rwroMJAM0hZwGh3yfFyjiII5hRuy/T
	 3wSceZtC6234NiWAoGEdNBtkIjunmeiG+pDqhwjEj4bcqH1fIWdgsA9Mv4hWf1fCzJTUz
	 De1flyL8hmoK6ANxliY1b46FR2BFYFiHfbvm9kTLSRTUFtjfkW7DBCm9WOZl7HOOe9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UwPZADjt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741713;
	bh=eiyKY+HIkqOasc2gPnqSGr2ENroBL93XHETDX/YJ3us=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hZp8P3hS7A3e4s7n4jWE44SvCxpl9mmGJ36enhaJDe4dL+XqQJ/T4oBdwLGY0kwcS
	 Fr/AYqTCVLFOjlDrM6KGIrOiqQQeQq468SxdzMR5MQX13y9vc02cGzeTScsWr8v27X
	 e2eiyHwBgRtT/W0HSStETGPhgRlCyM0QbLOiwErW2ZqhMWzNsM9Jpl48Bt7mKLtemL
	 5kb8EBHLIMsfEsKOVptwwOtoS4gQ+1dF3HtFwTmH+Yeoxsg1SRVzOkikmVxI7qKhYM
	 2YPsJHG6S6zvsaVuwfpT1a8lUsL2bOA5Bs+lBqFcsh3GpuKg57kdc8A7v6lN+otBT4
	 xotYssY2lX6gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23E8E80D16;
	Tue,  3 Nov 2026 21:35:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C1D32B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6191180D16
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FH3bRzRgmMEI for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E36C80D13
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741710;
 b=MnlGoJlORvLPmynfsFTR4E8PbI5waL07asXXW5/UwnSlYeGu6RgvKYcdn7Ivq+NNO5TD
 1NTSP8+NDlwSe/yHrougQjYaWq6gBzrJCrBFrglpjCP5/F6LsqOQRso+p8wt5llxbKWWK
 /uZaakdaL5+1Dl4CDVrWWxOKZNzTcIZU+FoW3isBQ+3vZk2qgRoeMu83VGgmhaUVqlv12
 E+VqxwdRaf/vVvXERilp9yrlgZoJzEvlpSlOg1r3Pp8kPm30auyrQvckjt+vNxMITQjb6
 dLSlFFu4/KKJFVH8rTWhigGSI2KDx8lC9uTCMI24Io9wIZxEC7R1MXvefDC1hf+iLNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741710;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=eiyKY+HIkqOasc2gPnqSGr2ENroBL93XHETDX/YJ3us=;
 b=pAcbIjWQETl1t3g/x7TchmSO/CQtveFvOMvHUK6yNx8wNwV081ueoyhOT/DIvIcp/8Vv
 NTKGzjR8DRkXNJN/d/ZJUensp1UfDtMZMZ26xmwFyI8NajeDhUH6R5Vax0joXVq4PnZws
 OIfoAbo6Lqo2wb8BSycX3/H5iiDcG8KbRebsBm40nQ45t18i5djvMzvHVObcM4GSuGu4f
 UWsY5yZvWuW46mdtTLk+GVXWDZweTvH8aQDctmwWSFyCn89xAAs5QfrR6OwQXH40gY15X
 tv+a3rldAOIA9OhneiIUUrWZ0iBbPgnCphLSWUpQAwrPVa4YHja5cxryUkYZiV8N7uw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UwPZADjt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UwPZADjt
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E36C80D13
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:10 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso83445e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741708; x=1794346508;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eiyKY+HIkqOasc2gPnqSGr2ENroBL93XHETDX/YJ3us=;
 b=UwPZADjtbvKwWacTZ+WnXYhbG5fFDq/ul7ehUrKAtt8e10OKqNCCb9A0P+2N74qfEX
 4Opvg2JYV+JdykhfhsyKwC3wy2ShJtujGoszgteBhEzwjQ/GV2vkSAQtdvsIREq2n9sx
 Y+Nd3bi63zp135Zo5PJCHA01IR6FWZvio2v6LFmo+pIpqKHSfPEjqBjuLLjAruEfuD+U
 z0xFHWaxp+B2WU+8HO+6mNkHE3M2SGZGjF4d+xvWgiMe1zEGk+BiWXccgf3vsYopnDv/
 7ZN2P8OE7Ns2Hg5GQAZrNauYP4gQ95SJXf5A3NVp4Y4txymEkRsUAihI7LNMCjY1CCd5
 i9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741708; x=1794346508;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eiyKY+HIkqOasc2gPnqSGr2ENroBL93XHETDX/YJ3us=;
 b=Zdwq9A8129sfLK5HmnYANRVVZMeXTYlv6lLi1h/sKzljKVjRJvN2l3caulu8WFZILf
 fpqmptnbFVbsJ1B//Oy4hMMX0jjGMs1IBmM0DGbJcxoUKKkj4xBuNko/CHe9plYj5AAQ
 ZWZhztjcX/JbYcChCJNgY9RiS9up58cdfafEPdza6xveoUiqmGmoJE0WmZIB3dfoGfqZ
 sTjxYJZW0w00Gr5su82npfWbmV+WlUJ7FSyzWJytldldIdPooXbykNhVpZIdePq1AUH7
 YENCueN5sttrgzU58NmaM+YS+TmhlDnlYra9bxsXEFEHdzJYPo6k6lb85/8DDNhG8grX
 55Hg==
X-Gm-Message-State: APuU4Z89wg2U+iWIY1GJjS4Pi+LeW2CTc/mDU1Seqdh6zuIcjpiIn7Kb
 2qjV36bBOY+Wfthc2M3T2tcdv6dD3W/Wc4rjQacjWmn/5bVvL+ZXaqHkMES0xSHzavg=
X-Gm-Gg: AYBFou3h7RUkIDtfQ/lhdQ9C5dZKxHBsNkdQ3v3WGdjBc932X/Jle9+Hne5HjB/Whpn
 UgvINtGWQf4LJfHACI7f7Nbp4m5N08K0oS/St4LEwFpUM7Wn0MLFbmUOhTVkdgFiJXmBZ2WYFxT
 EVf1uBotSLS698i3g7HXQs6OFUw5vLD6YJZRhoUToUhY4JbiReyUyIjG72M2p0SJwd89GS9pFi6
 qaBMsZQ1SCo1R76AmvJfZVNIbIs31atBpdsKDZk6bqvz/RHPRSUjk8XqrZRemIQRnBpu38MnTYc
 KWl4dyuED/wBVZEfosIc+EKMSCPMe5wmR0gvCC9St1+QA/4HL/5t/vatAfryD9zJsg6dMhQuVdr
 xSgKKI/G4UujgK8/sHDxexOEK0piXdbN3LWXICu4OGXQa0oxgq1UjuzIy8IeAqQAN19FtcAynHE
 33Xhx8+3xiam+FdYdf4lK7a/FySKDlKvY7bQ8QAtIO6fMIoC3pwfY/RnJZjdj/7dmA0MQWYjX3u
 sTnIE8r4tDHnltvlcetmqkNxtunT0lNt8dWiGcXaKuMW0vJ/PqtAJgGFZD0EOfLPYc2b47BobCe
 ReEm63qm1edHD5nYQxijKWAdXX/y7BSjQ2Kh1J89gKsLJZ7IzVs=
X-Received: by 2002:a05:600c:5397:b0:4a3:5991:719 with SMTP id
 5b1f17b1804b1-4ac1899353bmr323664705e9.31.1793741708184; 
 Tue, 03 Nov 2026 13:35:08 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm179941f8f.14.2026.11.03.13.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:35:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] fastboot: invalidate stale and incomplete
 downloads
From: Guillaume La Roque <glaroque@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-2-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-2-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 22:35:01 +0100
Message-Id: <179374170194.3704535.15964307403490267150.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793741707; l=439;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=LqzdaqPPi3ETlNM0BcSnEsHA7/N10Ov/e+/Yb6vlJZw=;
 b=V3qJwWw1XbhOGTkR7LC/vg+b6j2eFd3af2YFT71silInFeLR3/g7Q/Izne4zLorCQ4iO15dEI
 LoN2hWnPlqgD53/h1xQNA9s3T9fj+MfBUAX7kPZwoPuU/zdDZpWqIbW
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 14:24:30 +0200, Carlo Caione <ccaione@baylibre.com> wrote:
> A new session or download must not retain the size of an earlier image.
> Otherwise a failed transfer can leave commands operating on stale or
> partially overwritten data. Only mark a download complete once all
> expected bytes have arrived.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
