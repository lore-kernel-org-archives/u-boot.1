Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l7sCselj;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AFXIxV8O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86B2D606BA;
	Wed, 18 Nov 2026 16:20:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GiNB31atLW75; Wed, 18 Nov 2026 16:20:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D000A60A9D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018854;
	b=lS1wyAtKxYck1gOFRPRSLxYfwo0evEPFEWJUmWGZPasWmlvDMLsp+toxrGaiE47ZG9e6
	 nMY9Y94fYM4hAIKlP0NYIaVh1KyhX7tF8ufk4bZHSJUJdEb92MfSwZY1d8MaGGkbm8j1L
	 8EOJD789xYzG3OFwk4HraNjA3ragSpxkbcghPdtf6pcUN3Bo50asz9ETu8ZxaYZxjDGnY
	 IK7ZulRHH1CV7DxrAuG5avxgmF1WJMSQOtBNrbiEQxdrgi/dpQCXi+OOo1ynIu6LzN4RT
	 i879qRJNo1ZPS1shQ/97FodMcU28qBtTsgXzUEQJQOCGaoUeS99MsabRQ94Cb5O+9BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vIzY42bpLZ0UMNpVFtOFVwzC7lGEPgIZr6zz6iNvyEg=;
	b=IwQFoPW8NMSPwC0ZhI4sMatwcleMJ8m0vEj1o1pOPWTA3iCaCaCDdPMI9Ms1oWXorQnG
	 Jcx3Ix855CSGA92oem1EPwDx58WqTJR5vuF0J6pAjchRT49JM8EXoysb4tFfGmjOTGwBn
	 VXfRD64kF0Nt8gXS3FteBV/uYU6tPUavmF/ByVlqPEnT/NeyfXokXiHfKr1d72JQI5+VH
	 2L8zSRCIwoC9gXs3lGwfaukwDmlsfPw4f3WLgOHVbuq4rExWLfN/gAGDRNg0lNJH0uOPm
	 o/dDITP+kBRgapcdu7HhmK0BCg5I6jSWxc9qhxP261NnbrtdoWUfhPoTo7NVgq49o6A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795018854;
	bh=vIzY42bpLZ0UMNpVFtOFVwzC7lGEPgIZr6zz6iNvyEg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l7sCseljCwrAgm62YPLbjUB5XvDOAIGQUQ62C8AVVKP2OyG6/R/JAuexFjkp6D2Zo
	 oLVkCrI/ZdqsdAOu1NYVdwhx5lKilHd9J92KK+HILxk3RQb2Q5D803EebUF8o27GLJ
	 tnQLcT7Ki3QU23SZ9YbSsgZt1MhpAuNFBdyAp5bMXBBWPTAIzZXHJmp+5R1nvpQhc+
	 W2WWYZGuXFXp7uigcLdBRJKJ6rnwvKtyiuSAoEMGM7VFFq0zDvcdo8PsU2K+qbb+eT
	 evoqLih3KKtfcrfUpzXM2iAcMr5rGqX/kSKc2Lx53VMMZ2USSzgWvVEFWlwpQQmyko
	 rAGy5Y6HuW6kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D000A60A9D;
	Wed, 18 Nov 2026 16:20:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 628BE9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 486D481130
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXpmRolxW-gS for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:20:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91FC980F7D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AFXIxV8O
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91FC980F7D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:48 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so770100f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795018846; x=1795623646;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vIzY42bpLZ0UMNpVFtOFVwzC7lGEPgIZr6zz6iNvyEg=;
 b=AFXIxV8OVWiU5hz/08ZDDuzyBeRYAMZRE1Q6aU0f4z5AojPDTuY7/XbNhkK316YRlI
 G6Z6WhPa5B+iNE0tzUXlV4aMTDg/gKSf1ocXtjRfR7pYzlKMevpBvgz3fy1aIVHpS8qQ
 IDoIoFeG8Yu/fHc7JpBGIZNW3pdXBGTm51fpdah5ih0GtQr1ar/tj8Ivk+sGg3Blqbjz
 RnHli0GcNCh5Kgy+T3+l8vNo4zmSKKLxrnCMmBwXJJUun8nTg6XTS/uhrpx2RjGMdV3U
 6iDcm4WrJB0rhy8mNJFNgsHlWhZimgAZonh460nLRz4WYLGOPnmZzV7kb55Qv45+oVnP
 dUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018846; x=1795623646;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vIzY42bpLZ0UMNpVFtOFVwzC7lGEPgIZr6zz6iNvyEg=;
 b=s92Zrce9odUgBlV2Z8cQAaerYKjoBQTBnn0W72m1AhZfT6GKWCLBXuK9NMYOI4ZGnj
 JFxljhd6EvnrIOI10ywUxesVhEMmxx0sj40LgvpqLmJ+h6vWTWfFWyXkx/twvHJSf16q
 dsFf9tRNTrSfhZ5esuR+fh2BGtwm0jk7MhmoGJiecp7q8pg5uDb9ABSTcozhQnyiLb3U
 xYgo2wZMmVyJ9mHYdd6uJdSSTlpd66rUO9A5ONvBOu2t4qndDMiZPyJzssjJK0amfKTS
 kopzTurWNUZpp6TG6PLHlHPUKX5GVgDuLyW4Ahx/udUsCBT+4EFkzkEBb0Z2Ut9RYz8o
 DkIg==
X-Forwarded-Encrypted: i=1;
 AL+hErHvEE1BOyQr8jLwWAnMCgDZEvAT/xIlHXJFA2DDEjKQrbkdYKjDrGZqob73qbzCyqDO+xtmBv8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+NIkcnZQkjPaQUZJz+PYiSzfTb5mDRzBUWX7BXmps0WMhOaTxD
 FVQEsIbq8DDpup58VCWTVfoY6qz4VYjnA2WC/DqmO8UGJv9yTYN1JJtORxFvfFRr1W4=
X-Gm-Gg: AZFdTZdjJEmGIuFKfWbAOguVVu5ZpSS5kxtxQu8t8FQtBXo8+TtGK+r+TJ0j4h/1iBJ
 /Asgg30JxRDMHrNKA5/e+Zb2IXXfNMI3l3tcxdgDNxheJLgPCCtS6DbcQ8HgRXvigL/5gTsj01t
 blg1jEQBp+RU5PhZuLDpMRpTO0WGDCzS/GABRPoeYQ2vhTZ2lQNBqwr7b8fj5DSHskj6OeLYmQq
 0Exc6xY16dIQquMqKPi8ago7nwqYy52Z/pGVfSUnkQsptxLUZD0z3fW48VROLlujZm03sL0klGZ
 kGoizb4NF4J/LE/QbCdHQ/LtafUW7q06v15gRR/J7/NJAkTucpFU8BK+6aqWxoijrLu+9siY5Ra
 OGtUeabvCZPkJ9u738+6ur/C3Y/UMRrLVge5A/a32r/DMu1YJRZ0CYajB6t0/jffORECk5YNjT/
 n2zeKBk/UdMZ5DWq4CmQXjlCXjiD+CrD6dZ++FGmocLdBSVdSYR7zaYPTnGal7b19btq4ENH+nk
 xVbq6+WOm+nNGJhesdNPiLTFeAuxArl31TY2ysCGKGXvfyWo5kP8Ko2Yyn3Jf3r51w9ptSXPvzl
 pZOOY/DY4fp7f5EzIygPDheIlz+zNjaAJrQa+UA47YO07VxrkNzRVyI1OT9s+MNzMYRbV6R8
X-Received: by 2002:a05:6000:29c6:b0:490:76de:c78b with SMTP id
 ffacd0b85a97d-4a63ab754e1mr4318169f8f.34.1795018846110; 
 Wed, 18 Nov 2026 08:20:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2efcdsm5537874f8f.5.2026.11.18.08.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:20:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/6] fastboot: block: Add device selection syntax
From: Guillaume La Roque <glaroque@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20261115-fb_gpt-v3-2-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-2-7ddd7ef832f6@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 17:20:40 +0100
Message-Id: <179501884040.2226612.8597206598414398977.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795018844; l=903;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=IU5fe4L7DtAQIVukmYk/qDO8Q0lqFtZeW6L6TXHVy+s=;
 b=6nWnUH+gfYeuMsZ5p1KtZgmeVoCEGT8GZhNK3AkLuhmczWLAW3IXtarNZDhSu2J5CSE4kpVaz
 Qm6bz0j0762CjiJqVhYFinMLCEiDrbtj0O2qJjioc5Ugi8V8zrh91i0
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

On Sun, 15 Nov 2026 16:35:09 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> The block backend can only look up partitions by name on the device
> set by CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, so a board with more
> than one device on the configured interface cannot flash or erase
> partitions on the others.
> 
> Do the same as the MMC backend: look up the name on the default
> device first, and if that fails, hand it to
> part_get_info_by_dev_and_name_or_num(). This accepts "<dev>#<partname>"
> to select a partition by name and "<dev>:<partnum>" to select it by
> number, the same syntax used elsewhere in the disk layer. Since
> fastboot_block_get_part_info() is shared by flash, erase and getvar,
> all of them accept the new forms.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
