Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D505606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TSxAIWdX;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbG7RhRe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E73E160DDD;
	Fri, 13 Nov 2026 23:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PG5xprCWkkEp; Fri, 13 Nov 2026 23:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DFCB60D80
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794611857;
	b=l++GPsoj2yVS256E9jztqSVcymuXsp8/RoBXRocePJRGYRmqC7UMhLAdm4QKR+55LVOS
	 ct6OShm4x0qzhHpWXwyZTxUihTTc7FtgJQJnUe8T3kEX0pSSqdlkIcRMt9AcmbGmqA+4a
	 8QeQlpdlk1XikLR0CgpIDYPo6NCRAN4rworU3IQAZOvLG4ek0QxvBMit/VDPD/bicDykD
	 P7vJ80GVyuoV/MmohxELrJAT1/u/8+D8BcrCnDjS4Yu768suJZPOf2tdzi+/yLIh6PD8o
	 VjEad6WxWe6oGXetUE+srj0EQXrUJSRmrGW2mY80ieeOiGJPFP8d9lGyQgfbq35KbPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794611857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aGGNhHgrPVYHhUk5Al2PFiwYXM9HF3aa0WsoWQIianI=;
	b=hu3JIy3202bpwQ1SAj45+J7MDTuvn6YTQq8m4CSXSfXHE1lwDGHPqfgg13vWrfaLUzLk
	 Fgpii4/FWUwD8hbJH5hX3/D2/QfkS6YSvhvuLC2oqKlpZu+nwxQbmZw+G0e5WZB1PmABJ
	 mLzSb7eFysuOJY0szGjrz4rV1IN/W+BbmUG0IZR1rLjRYQxfaptadLzPT6JiaYWFxFQNa
	 z+PKp2GPL/+GFFOCpa8ia9KGgkHHSlWqH3qPMBlxUNi/Y/MIdpLAIsOsuD3CtyQcBSAqZ
	 HYIYHx7ZlMkeftzs4RsLI3ONOFOXz/2gXYFCE2ti6NHYEbHkm/gOuDncqS6WgmWLRrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794611857;
	bh=aGGNhHgrPVYHhUk5Al2PFiwYXM9HF3aa0WsoWQIianI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSxAIWdXF+zNcEvosuV3zdsltM8sOg1lnRE97Eqrzs/fJCq6MEB8G0uZeenjGRcC9
	 KtI6SZd6Inh9pp1NCceXksakkXJh/uodbMSMM+9BhBwFTceTE73K2pXqdJ2XuHCLS2
	 MPLBifdgj76odbeHFzV0QEzbYGHg6zl6NbiHSfajj7ETXfmb136da3xoaqM9SEE92c
	 AmuciI/CsKgSqhU0lY4E7ttby8QSBEbk0iNLYYWaDyhKq3DhACO6qReiMfC6yzQz7q
	 qisMxeltHgEOyEDQkJvXiCZflW7bnAMzhlwreeBQ0WsK3y/5j7+u70UGVvx/R45hTT
	 SGb0Uu12GtUCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DFCB60D80;
	Fri, 13 Nov 2026 23:17:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED842260
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3D354025F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIc6XgBqVJGl for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 23:17:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F2EB14021D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GbG7RhRe
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2EB14021D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:17:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF45941A5C;
 Fri, 13 Nov 2026 23:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333C11F000C4;
 Fri, 13 Nov 2026 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794611853;
 bh=aGGNhHgrPVYHhUk5Al2PFiwYXM9HF3aa0WsoWQIianI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GbG7RhReA+ph0N2hOP86lC+Rkeiq1gkZu/Cxv4yV33SfsySGU57d9oQMbyik47fia
 peA49SyaCh7+6OBA3+mVkQ7N2LnFWbPdpHxEZd/0h8y6jPONqiBkUsdf0WfJvMfqpm
 j5YAB35RsuYdsOkJZZuchypsMORaQKqTyNT8S/dWUQjJWwcFHGIvYE8nLe4K9z3GwH
 RSDaO3/6YPKBwjHqOW7A5wjSE6OCzLSuHrngGqJUsrbIWqUGpqV4rWBbI5SqrVF3T2
 VhzgvDe/Lv90dBObEfdO8A1jgTL9+MILJzNf3/k1+xOyRACX9J2kP704eCeqvhIM04
 YbYEi1ZCfuToA==
From: Yixun Lan <dlan@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Yixun Lan <dlan@kernel.org>
Cc: Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH 0/2] gpio: spacemit: fix bias flags lost problem
Date: Fri, 13 Nov 2026 23:17:29 +0000
Message-ID: <179461143119.262078.2952011216601508809.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104-02-k3-gpio-pull-flag-v1-0-de9f0a9b7669@kernel.org>
References: <20261104-02-k3-gpio-pull-flag-v1-0-de9f0a9b7669@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 04 Nov 2026 12:59:50 +0000, Yixun Lan wrote:
> This series fix the gpio bias flags which not configured when passed
> from DT property.
> 
> The problem was found when testing SD card CD pin (Card Detect pin)
> in K3 SoC, which we need to set internal pull up settings
>  cd-gpios = <&gpio K3_GPIO(4) (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>;
> 
> [...]

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/2] gpio: spacemit: cache pinctrl dev
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/f54076a7979bc1f18c3edbaf1af75f28f093d1b5
[2/2] gpio: spacemit: propagate GPIO bias flag
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/26a75ef02a879b08f1140508aaf9f0051f73d5d5

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
