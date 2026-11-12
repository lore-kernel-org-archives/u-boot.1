Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3B606A327
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C+fx8AXW;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FXAY02FC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E95CB40DD3;
	Thu, 12 Nov 2026 20:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DknJVSJKNmHJ; Thu, 12 Nov 2026 20:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 493FF40DD1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794514437;
	b=V4ngwpTjRoF2KHGgXaDt3wDDGXPLS4nhoIQg3U+KncTpgWnsDK7gX12ttIqkIDJQ+j2k
	 v1mZhYTwzvGM6wMoAu6TcaS3CRZS3BewaHb73Ml/jmEAYDB2sux2w3715u2x0AbhM4GiP
	 fVqoFbwwM9yEvLWXBH6h4ff848kEC93Br14kaseXmhiM3TuWjGVErxHBY84lVY5Y2iGlm
	 /os7y9IuyifM84M3nkBp69byG60v6V2Rxt4hXvETFYvAQrmAXVeZlARLsSjDDU/iVQM9V
	 lrpRbAs8ceYdZgFAmyA8EffLEeuv2VrYNGbFiIyVraVkyDcx1dYDaLbH1PqzirRSSYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794514437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NhNkq3134YydrN3aivX3Q4f7KjedmvvWMsJZfagQWFo=;
	b=LLQUAy4qsKPD5W/lNS6Xkd4nwGQDZbLJbSh9UjNPKxwsjpNfwJc6S/o9DnMMwzDrBp8E
	 zTDBLmbqmZrU9tCLY8jRym13BdyS6d/hrn3+0+IGbKZbVaX8rJP14dd3OfihJPmZCM+it
	 /gdV21AgkRk2zYWB7ZD0OOsbjFM99QEYD11gCzpnxuDV7RGRCbNmq6xGLDLi4+JR2bbFc
	 pwP3/2oiphlpNuBy0RkkktAAlOkwByHfU3UlEHUhZLYo76XrUuSft4PtYEI5M8jWl/FVQ
	 EoMeHmvVF6IThMt8vbd8ZhIqQzZZwlSAJeIXHkcADkezz7WOd6AWaO8k0bL6NHkYwNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794514437;
	bh=NhNkq3134YydrN3aivX3Q4f7KjedmvvWMsJZfagQWFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+fx8AXWozzapWPO44uQa2AVYQvPgvgrnK+zqoKqwdHNuXqtju1BK992BLNezukpL
	 Nw3deBvt15OKpJJBRoyTZZxfcqGesx9beT5rmmZMm6dCfpr800cuctn8gc63rZ8Mfu
	 zft+O05asiDaoa77ioevoRVzfGarOwL/qXxQY7vl6UlwD5rxmBY8VXuK45eNg38BJw
	 9MoByCu6ngqfM0GFyLRVrgzQXvO6LsaranFOFpRjW4M/aXIgOQjwy18R1XGb4erXbO
	 BsuS8AOh2PUkETDWW1tBzNKH3fUvuv/G+Jiutb0jOp1pIGMDGI23lDMKI3yMoqfJ52
	 oSVSg6F20+zhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 493FF40DD1;
	Thu, 12 Nov 2026 20:13:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 508462FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3657340082
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NM8EuXtfOiVt for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 20:13:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 83B194005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=FXAY02FC
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83B194005F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:50 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-843cf077f10so255953a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794514429; x=1795119229;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NhNkq3134YydrN3aivX3Q4f7KjedmvvWMsJZfagQWFo=;
 b=FXAY02FCPFUE8mTv/EahqUlqeLUth5OHvcp/lqcELcGwti0J8KgK1WuQ4m6uGDDY4c
 9wwy76XbumYwKiP5RvpmS3PwhbD2IR9OnwTIge3RoM+pN4P1VSrTURKwd4KnBw2zlOvL
 yYbmkGYkOt24LBWZE4BrarnfLX+Zi1M1yA16I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794514429; x=1795119229;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NhNkq3134YydrN3aivX3Q4f7KjedmvvWMsJZfagQWFo=;
 b=nDAzuwesFAltRSQwBcCCcJkZuFc7JIjCsjfq1++Dfemxxde8KEBQrKYplR4w/M7flZ
 BsP+HaT2ZiYKMMJZvnc0OMljTLhibG9RmJ2x8dbCoDq6TEs1ifBl8ZqhASRcQRMkZw0C
 zDZDO8DxrKzcHXRLmc4MGFLBu0MAthzMJTiXYOc6gc+MQXA+vne8TgNw7nRmfmmcFzju
 AwL5Hg+bnBpkRR8YaMDFBUeSHmWCBfA8TNwxdYP7W1REwY4Z2D6DXKsnveWXnrPWvBlz
 iSJGHyEltrOfqfKe40suR+r2G+YUrYI3eTFO1OkjWB60hFCYS2VGDPGPD9Y4BFtbpixx
 2iHg==
X-Forwarded-Encrypted: i=1;
 AL+hErGaD6d31GTR1/6QMofRdl/hEHe2IM3vcu7eFvcIWt7aJ03Z3uGF3dqPJFKiyakxV999ITudIZs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Qeqvv/h4UPvGpBfw3RuGufRs6k/qhjVO8/wXxqL90hvuO8Sho
 pKxmKvw/bMzvinjPoT+tRChLYSiJ9y/DvwSnA8lafDDwtaCJDDpOPc7tKRUBRnbhydc=
X-Gm-Gg: AYBFou0q3v5b0PPGVdLtJUVTkO/d8UYd5V0yyD8xj/veewDDonskCWTIuQnwF7jpRKH
 P9R5bS2o6DYOD5MMC4AdHSaELhLjrR1QM0zKyRLcGmz0SRUH8reYBypUGToZ6S7r5LeiIRlnat1
 G1epyHCJDJsBMAuJVENdWiwz5VZckAl+1z0gYMUM4hdFVpcNEznGN1muWNQWckoyWMFELEWXjG2
 E+4CLQAs+KR1I55KuJMyrLu2a+L48piH9UL8ZC8Hro7if01zl3qPmI+pPwf0MKuH4TFGCtcKXNA
 4i+Lfw8ySnZs5w367JnCXwzq8dScxbI40uXsP/7ckoaA7hnlaxn4XwXSC41fApaosGFaCtX461T
 ZHCpwny3D8i1YATN4XMlAj3Ti48cq6a3RdDrLjZOqwz4HM9tfUDuQhuZb1IQ/Od9k9WxSXA32B4
 wJw8U/MnpiOUNReXTxcJ7cQz3jE82uOYRtBc8ii3HlTnNqm9qHZBf0mt0CyFli/jLxL+a/RCdJM
 eYqMHEy2ba3hJiUYc0HW1PNuPyNEaGGp6rpTWJLpoSqYho6zblQtNIy/Vs/0ZEr6Uwv/TsgA9hw
 q9uH5aa9f4iQ2mpwznVIJITMRJGe0XFaMDrfK7OJJ38sADCvLUvLYBpq94gXeHHDu8fBOfBr4nZ
 x5MNEAiMp+JgikbOZvNwAWOaR0I05gfF2VqoNa+UiABoz0ZKpwYX5GHHTpzVYE8j55E5bwaHAwQ
 Lkvuyn3f3RZ7UZQ/2n1/UnVWkkJ4nc2A==
X-Received: by 2002:a05:6830:914:b0:843:8982:9532 with SMTP id
 46e09a7af769-8628992d65cmr334190a34.28.1794514429152; 
 Thu, 12 Nov 2026 12:13:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880a4e4csm613222a34.8.2026.11.12.12.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 12:13:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Frieder Schrempf <frieder@fris.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
References: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
Subject: Re: [PATCH v2 0/2] blk: Fix duplicate partition devices after
 re-probing a block device
Message-Id: <179451442835.966571.13807906774572732406.b4-ty@konsulko.com>
Date: Thu, 12 Nov 2026 14:13:48 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 10:03:46 +0100, Frieder Schrempf wrote:

> The partition devices that blk_post_probe() binds for a block device
> are not unbound when the block device is removed. When it is probed
> again, a second set of partition devices is bound, and the EFI disk
> code fails to add the stale ones:
> 
>   Adding partition for mmc@42860000.blk:1 failed
>   switch to partitions #0, ERROR
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] blk: Unbind partition devices when removing a block device
      commit: 8db5c462b4e178163db8561c9e710ce67033a67f
[2/2] test: blk: Check that partition devices are unbound on remove
      commit: fb90e3bbcdcabd9d49395164841fca5bd6b79332
-- 
Tom


