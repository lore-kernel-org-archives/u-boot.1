Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60924606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ymm783Gn;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=e7w7l3ez
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E2C560902;
	Wed, 11 Nov 2026 21:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id irvR2um3pvZe; Wed, 11 Nov 2026 21:26:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 529D560DA3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794432373;
	b=eKkkkiEgNgckrpZCYMyly0484Kb17b6PLdJMH+I3TDNmidVuCFEQKBqqGdgd/Ts+fHXb
	 tQc+nl2y3EXo6oBJtQHRmJCV/AXj7/LKoI0maBsGcv7Iozj6Ktobnb/PM8yD8QwI54eHC
	 ypBO3G0gjEAwQ7v0kEusdDWNgxrpYMaS5CJ9g3IHZKC8HSAioqJaeLIgqWsLnyCqqVMhv
	 vFFwHS6RFUSt2fkujg9bSYe5QgzZpq7frwzivX6hfNc4VmtyAosiGeUFyelp3lYYVk1Pf
	 ueGS/V6Xu+AcYhDkQJzDegCBx3jXf2imYyLaL7XuSSc6839aFC8Qd5lIWpOTiSAtqhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794432373;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oJhQ4O6qot+grVBnU1Au+9v2gKKmauPdt3B/V5aHYxw=;
	b=cp4fRiP0h+W7UPwR5yyGEASmDx/aJf+jsChi9w1Yn0smrtDebX5wbU2iCesiyzs3RHna
	 6z0YnHU/bAbUndS+egK2B+cKY5863QVhsq26CL1x3OEec+g+Bnp7/VWOjEiXS3fq0J8WC
	 UBYBfNVGFQ5aDjEHDoe+r9lSwMqMQzr/6Xttt1+7DSabkbIKIxcY0PXg42TWOOS6KrzdJ
	 vBPsnP669gUsrrgYMyoytR89YVPcGOh9GR31J9mr28U1AV9IpeGDJajAbQeAsJO/7OWj8
	 u+P8yrWIm7wY3HXCp3l28U53/ri552P3Pu40TIMkjEgG6KBLRExGmu7mvME5C7KZR1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794432373;
	bh=oJhQ4O6qot+grVBnU1Au+9v2gKKmauPdt3B/V5aHYxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ymm783GnP1Uh/KbDVfH0AA3CCJ/1a6AvCUiNtNfGE49vFO+ER1EORcr4SxkcMj4OG
	 kym+e9pQZo+yGk1IZ7sBQVhGwdMpvzn8qoiwempjONowcNX3Wo2h4F9m8IIYorqsLX
	 hKl4BLLmXemITgGDiiUiHNh+kKzFZ8uICuC6JB+earyB3GYyNMRbgLg3MOo7mokneH
	 NxszsP0XNSsgayMBvZo7Ap/aDZVXM8Yx1Z6g7jpcfgyM+gPTufGk9bB1ghWj3jZn7b
	 PjKmqvX5dGL77+tJ9pIFhfYUiv9y/njPbr4gaUkZvErCFbkIlBAiw6NaW2z10dHz1K
	 MOtrpotPyrhbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 529D560DA3;
	Wed, 11 Nov 2026 21:26:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E4C0E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 533A3403BB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oq6Ym_smG2an for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:26:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6EE16400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e7w7l3ez
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EE16400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:08 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-85f34b20042so2063586a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794432368; x=1795037168;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oJhQ4O6qot+grVBnU1Au+9v2gKKmauPdt3B/V5aHYxw=;
 b=e7w7l3ezSSFwPRNNtLxEv/EhjQjhUhwruAXltbTQRCpWfuCRDuijctvYnZc9ED0QNT
 FliP4k2rGZ5Lp8mCyXVp1XP6J9X6w0cdrrcU0MnURuhNW03ELzS2w5pOwSGzdgEo/bG1
 3/q17vtxLd70G42DeODYaTlCZywoXymlRUvT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432368; x=1795037168;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oJhQ4O6qot+grVBnU1Au+9v2gKKmauPdt3B/V5aHYxw=;
 b=qc3nB2n44Nbf75T208qBJpAzmnVyQKcujPhIYGH2aULRboan6slKzgamt5uFoUC8gc
 FrM9u6d7pjHKTAxsEw31vAeqvrEMLkEd2B3HvT7rVqg/nkmBI/9vStMH6u8M9nUY9ly1
 4Q/fQtXue9X18l2flSw12WdJFtv1zAhNfuQwX/gVL2dK8WuzEULB5ZGxJVIyf+LojPgY
 3rwZAH2reHqcHnXrPKaf1hRIysdNzUlYVc0Cp2Fkea+nhIMY7oO8T4zlK0SGJw1Qxn5q
 6Y2JIExOIj1RnVwxkEBk6Oq0HnnsdPRryROC2ke1X92+B2o3zAIV7ze6YYeE5IQ2npip
 fQaA==
X-Forwarded-Encrypted: i=1;
 AL+hErFQCJJuCD8KpCqKP/6IqCsE6K6M98YLBeggm8cq2526qATRDq16kqwII5zIyu1vs7xu6+LyLCM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9CRwrzufzgsJZK0S5kMR+hCJh2KkSpKqHaGohX1lNlwKLjIJ3f
 urxVVvBYxzAakgfhT1Ubrsp9iv3E8O65wZvohNNQA8I5zWYQlm9uWEiH7JgRC9PLjcc=
X-Gm-Gg: AYBFou2xLXlcGkF5DxWZH2IqcVu8YXLCssKAScfAzj+UFehCyjyw9OPzz8M1ej6LmlE
 zBkXoXgWgJ+DsbvHjeE8BFQ7xycI9AfO9CPebaSt0V0YWCbdnBhtO8Drun24EjKaz3QlD8LRtIp
 3Wxdg/OD1CXCAe7GvghxnlbO3oKTbvNSKMtDwIZkfn0p0ToL7PCPAcBiuTepJ/8UahfwGWDCST6
 DZHypAxRlp01PwB+sy5e79tAKkmYEu/3QVEUKVAF1HOfQnLZCpPcSPcbMkv7edq92a5YJBuoJY/
 dYsmtKM0u2CAum99Xu2MZxriqliUYy5vfYqq/3hJOJRqIHQsVrSpwBZEO6G13B6Obx0Rsvc9vlX
 P6gwSkdBTqNVpFwmNY9fiYL2qsxt+Ju5fFYgnyI/2T/Lt/uZ0XRrpfTGi6MXekdtpN3VUBBBa+c
 g9vu8x/wPVwL7ksCmWScfVgQfsvUIFqRZlIOXrGsYhGR+hayS5qI/Q02D/PQ7DVHE7HW8n6nzd9
 zMb15RyMzTFDhDGMCH3575i219FuDGvYwR43T7nsFFdvVpnHjCikQRcrSLNDxhou+/Ncv+ddB7+
 nZluo4sOEN8cNLDYfYUHX8XXIQnQUKIQC2WZLt6UEs7T/zYL2uYCWVdYg36HVIAo90VwE6FYL9d
 YULSlROl2SFOeBJj/LE2o2cvlzguKTEpen+QVB4Wj0vD1mo0nesRbgKjO5Q48K6yPAL6xRIkxWu
 rRbySKSa+A2vrLdg5bXQt+ir4QmGsHGGSJytouvMBo+83IKcmB608=
X-Received: by 2002:a05:6830:2409:b0:80c:6371:21fb with SMTP id
 46e09a7af769-860f28dba7amr4815617a34.16.1794432367809; 
 Wed, 11 Nov 2026 13:26:07 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbbf1d6sm5205628a34.13.2026.11.11.13.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:26:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>, Yuho Choi <oss.patchbox@gmail.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261027185337.51168-1-oss.patchbox@gmail.com>
References: <20261027185337.51168-1-oss.patchbox@gmail.com>
Subject: Re: [PATCH] virtio: free device name when the driver is not configured
Message-Id: <179443236688.664252.6640975577380592441.b4-ty@konsulko.com>
Date: Wed, 11 Nov 2026 15:26:06 -0600
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 14:52:31 -0400, Yuho Choi wrote:

> virtio_uclass_post_probe() duplicates the name for the child device with
> strdup() and passes it to device_bind_driver(). If the driver for the
> reported device type is not built, device_bind_driver() returns -ENOENT
> and the function returns 0 without freeing the name. Ownership of the
> name only passes to the device through device_set_name_alloced() after
> a successful bind.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] virtio: free device name when the driver is not configured
      commit: d373cca5b88c7dcb0bb859d239921915ef692c8b
-- 
Tom


