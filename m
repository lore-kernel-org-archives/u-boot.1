Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3126606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EGIdzNg0;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hdD+vjVf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CC4F60774;
	Tue, 17 Nov 2026 09:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtldeDc_-S9g; Tue, 17 Nov 2026 09:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EB40560844
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794909480;
	b=F1AUtt5yjT3L8t+Bb9F0u2c9j9x1aW1tHGDx7ILlYncoFwJdWLo9stJ/ycmYTrzUV5CV
	 w7gBr5ZmWJ9JHuJtJjko0XXnEXZf1DVu2HcZIYqUZeb4gFfeIuJH+kwkNvofr+zhkpxFP
	 LbWyuN2weNl8FgUqj7tORDo453VlQvkiB8MamI5li75NQmztkvFEZUFdKJZQzhlPJGa1N
	 iAupjxFtF2oA+P6OuMTRgjta9ujaoh849tCNxd5vO0f5HnY9kIobIAMaqS7fYgQ5KICsk
	 nmjD1pcTI0pkqjJy7SA5MtvmHeEa0kJZn6P6yQ+NQutf9L3m0OF9bUSl8JOmcT3pE7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794909480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cRjJ4ZFaJj8tOMfMMcZJjDQkR5NbOq1vdyCJWoXbZzk=;
	b=NSaPUCS/5W0oChHp8z4kUPJfdqpi+bZr2z3mYiCNIOsliAGGykN9hWRqOjsZzX1b4NT0
	 SuV2OoquAg/CTjNv3gLf+2j6MWhWH5SflmBTIrmVt29N4Ro3zhPvtBk3gvNXu/mVmVB+O
	 aynfA+PjIvHSfeQ9iZzghUtGHM2I4EwrWVxKHybTYm8M7VmUMMe7xIGFDlPbWKIeRD10B
	 V5UiGCn+r2heZpNxNk9igVM3DngOhMw+fMntCRbUHmAd37uueidok5PMtL9taY3I1c0ZK
	 i82GZaXz67l/6a1HMSvul3t3/b81QsVECADv7/tl2NXzbWYwnW/gPVJ/miSDT9x2e9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794909480;
	bh=cRjJ4ZFaJj8tOMfMMcZJjDQkR5NbOq1vdyCJWoXbZzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGIdzNg0DZ3thGE1+xbNyvs+H5SPBzuy2e9Hv6IdRa7uav52PoIHkqrzYOLUZ+X6q
	 YPa7fxE2Ao++D1tFdV8RmaTY7Z/HgNiei0vogV6SeGfQrvVv2B6Uv+7MeJOl8T9t6Q
	 m54ZUOyCHqlKFF9IUIwU09wytocmwzWiyNcGPluzsrSO2Jywqb+j4vs4rtO1ayZgwL
	 IXa1CgmHlqs5nizVwChEHIpy8R/QLpO2MbanD75keFscYPeE5DMlZHpbp/ZKVNxJ61
	 5aozy5RsTbd/KyGmnFakW5SYMhmqRPkM0/0nahNTsWm+v5RyvVis/fq5WfKi5iqPUV
	 MCmdnd4F7WpXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB40560844;
	Tue, 17 Nov 2026 09:57:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF22270B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C45B402CA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ntTGAKHRwt-o for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:57:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AA0064017B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hdD+vjVf
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA0064017B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:57:54 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so18913255e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 01:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794909473; x=1795514273;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cRjJ4ZFaJj8tOMfMMcZJjDQkR5NbOq1vdyCJWoXbZzk=;
 b=hdD+vjVfrOMj1+J2cWpD8Y0c6hFtc8o2TZ6eVs8R13VmsAmzpE7vXPyuzsCejt3fVO
 M2RnyyE2+sNobJm/bxWd4nGKV6oUN/zKd7DrKoOnoPh/H8Rr1zw/LD+wDNHIy0f7BWVh
 E2s+4486lDQljgiReMr8hFGmIvwRhvhPFTd4gX/mGEBeRjbClQ3cyDjfM1v3vKCijRj0
 l9h3HsRsDHVQmK3ZOW4AgkRGUceG041yfxEEpPHUX5VjQ6aFgZTQmWa8fkLGoeMW1ekA
 PIZg4PT6cmzCALHLOY1dgtEuXH5LpzJimg7aq12Y6hs7FG/ZjsVdfSApgW/6OK1Eb8jK
 MCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794909473; x=1795514273;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cRjJ4ZFaJj8tOMfMMcZJjDQkR5NbOq1vdyCJWoXbZzk=;
 b=PpGD3dbXciDALHSd4qaOFcFpFqQV4YTkwF298PYaw14jMwicLrusn6c+D4vkaHHfDg
 ek+ygIOFYWFUoUfzK/vLA/N094RTBVjztooC5CBA2mVzsGJGgIP9EFLGAr9OvsEqBbHK
 VgoM+GVu5ZiPfnm16UiAFAwfpcDjkLJoQ3ETBD+T5FjNXFIciIYZcETMWQezRFPtkQr5
 HuYQgReXItsnCcUUBh9o3AV1FSvjeHqUveNkbXGQsBHoZv6++BUwV4omi5zE4v98sxmy
 aV+LRY0vmsgRM33+aAHz93tgl8/udi5foCgRwx8yTiCL5jea94DK74XV4IpKKahUw8QS
 S27w==
X-Forwarded-Encrypted: i=1;
 AL+hErHlW2eGnkp2lwEZ01Q7PJVqrMOrOtkK8ZRl0NEf9Mjq2xXZlkTD6z/dnYvoySLNb0l+uri2XwU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/E2xBqIAEHq4ZcAKCE87x0FPyKR3XnAqabOzPC5LVHrIz0Xt0R
 bUgDxtPoLQwhOMWnJV7fo1IUNt8tIB+5fiG6xgWnsfuE82v9+H/jVob5CqgPa1Bs+ZE=
X-Gm-Gg: AYBFou3jb1QYoOr8KAe5S2Z8M+36Ynty9cMb1r26636vakwky7ehYWyefY0u69MtoZu
 MwrwnkxrP7+qRvFJe8qhlmtwtzhc5yGROTllJbaFaVpJv/TxXpZgZ/H/U0n7eG+c3Uxzoivlc7A
 HfOEG6lqvoPcjRAUFuslXzTt0VfrA0DBru7YLCt25IUElCLE6yCo7X7DzyFkKDhmzaTlaBOMPtm
 5C4VSp4gqf89VPvtrbd5Ie9+UwxgnKoyrIWCYEWZnz5homN+EnZGwp7wRSqrHJcIwCuu2XPqkjI
 kIuIL/vjI6Wfu3jugKxfGVQTIbPkwTaPelXPkXQdYkCjTABvjUS/NHl0FHdsmp/3fcrck+Mv4XY
 JRUrcl1mjQHK5C1TQZVbngeb2NSecyWU+HGdibBpdOcwYTWjNDKKBstfb6APWfqOBLo2HC7ATxr
 XsSbJ5USwtexldEM1J5ptgXMkhdWpsx3vwHotuhLbFaX5rD8OjdmCeTcEoQ2z/z997HK69tj7pz
 Ff1iqWPo+B6wwr0BVs9MR8fwatKXaEP2icFth8tZt6de/A4PlGhki1SYvT41Bj/ad47lKNsF0ch
 IEQt55nhn/D/oLYduHZGq9LDW5FVuloqkdw/3OXF6iQGpevj7RtGQEozvapUf1xqq2Es4Lkt0L4
 d1Bu9JSQ6R10y
X-Received: by 2002:a05:600c:1daa:b0:4ba:2bfc:c8ab with SMTP id
 5b1f17b1804b1-4bb55a4801bmr285179955e9.15.1794909472754; 
 Tue, 17 Nov 2026 01:57:52 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb784e9073sm59502465e9.6.2026.11.17.01.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:57:52 -0800 (PST)
Date: Tue, 17 Nov 2026 10:57:51 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/3] mediatek: mt8189: add SPI NOR boot for Genio 520 and
 720 SPL
Message-ID: <avwlBOmH3TCPPqYl@macbook>
References: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 18:05:52 +0100, David Lechner wrote:
> This is the last boot option for the Genio 520/720 EVK boards, after eMMC
> and UFS. This one worked with no runtime changes needed, so it is just
> devicetree, config and documentation.
> 
> Tested on Genio 720 EVK.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

--
Carlo Caione
