Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABA606A336
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Csj80MxY;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KLDujU1t
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D4BB81253;
	Wed, 18 Nov 2026 13:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id odBKaT0N67Qk; Wed, 18 Nov 2026 13:52:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 134C781208
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795009926;
	b=fx3PZtpg7m3GSw/PHIausAPglQOzS6AXGMmbUXz0NTYOwr4O2K23GSJAae6PSNbxF/C6
	 d7N9oUtn2BXAOj1Nw2xobXM15grlcG0mJsTOKFkoWNXu+o2a/lld/mLvERzFAG1ybzkTy
	 wgtLFK5VV/WR+eVD1kmXEcBtZ7eceytCmJ/3lPbnfU4ORmZ59f30v3WLQ4VYTE9lzzmm2
	 IX59GTWSAWQbSVLb6+pTBrV+N8ubvdUem+d7xWm19KbBX1n/91F2jL3tU5UwVRaC2jSqK
	 vUOtvTejMGWLiPiQAyCc/dQMdcx4zvDBurm+DKTrm5jKIC0rVxIvOxAOCOq9Mw87vlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795009926;
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
	bh=zdgni/KYDVSnVpIQoWrLir2LPuUOBVrOrwa8HUDo1MI=;
	b=SKcfY8xKngWH6dPXhtfgy18yNjCEEesLf1VIhvjwcmCOZdh2bzx00wyqIZUZJ7UtClzd
	 XoM/+lzIiDqzDKswXaCeCwFYqwYjoU64FIjn+YdHuPQrJSKXlO1FQ0J+t1k+fPninMZh1
	 rRnX0Jrr0edG52wkDOmoQt3/hJhR8XfW0s9ZJwS6j9TFLUFqccycP5j9UXPRC7Rltg/6o
	 o+cJFF68oBS/HT7vMrXO9jCf/hxsARmBmHN3RPMoDjlOEc591MLLe/qYnge9rhaXb7aEe
	 m3ciUuybqYLkY/ykO8xxAS3KTpH4zpc5LP9Dg2gpdKEaq3sI1axRQGh7Jd1FrEJRDVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795009926;
	bh=zdgni/KYDVSnVpIQoWrLir2LPuUOBVrOrwa8HUDo1MI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Csj80MxYCTdjDFF+ZKmqChCooJRdWHCYBRqi3jEBWHGS8rNuWJJ3U46k298e1neW3
	 ISS3cCrsW4gf2ZFC/7wi2syk96FSbMeCPU65mtWaIHHQJYpBW9zQIdL/XHSHMN2DsR
	 HTR3Zm6XmRK19l8DwThlO6zr+iTz2QYZW5sFPkPYlxPz7afWfNV3MWRKafy2fo/leu
	 SdSG/C8vIj57xzSwTrX5TWIKv1z5yhQBa9HVgcFY/qKkqErYo+Ik+vzpfo++BQUvkm
	 /5Gz0/Gt32zUkhNOtzQ9jhmEKBqsSzgVJ940dOQ+P3lFzrwuhu6HrGURUrJZ0Ej+d9
	 ZzPjFf+cr/bHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 134C781208;
	Wed, 18 Nov 2026 13:52:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5744A49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48B4B401E9
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:52:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2NnqvoDqjk2 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:52:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1DA9740060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KLDujU1t
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DA9740060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:52:01 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so1342244f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795009920; x=1795614720;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zdgni/KYDVSnVpIQoWrLir2LPuUOBVrOrwa8HUDo1MI=;
 b=KLDujU1t/vPJk/l4e/OeH65BEeBY6lIR9Dztbud2rQeRipmlq3pXwX+CNIrprg0idP
 tGlTgEB2XTiJiqOXV/pKG6HsAv9kC1HXw1LRdhfheXirm+48OBYpR4Ip/k7G8589BcOI
 VMY3OSVK7HskI3Y1e/9Xnc6se4u6B4+62uvdnJUwoNyqp22KE1Pr4o2eUDfRUz/D2wlL
 AiWPwRJWCFjSxLgNbpEScXkplUanZyuNr3b4E6isWqn24OlYWU8PpQdnXNCS2/uQ/KwU
 2KdkaUXvx9eeKGFk14bd0NJ+O+Xg5zyxu7ZURDwFdMffewkcZdt3ds68wFqFq5XNUsM5
 H49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009920; x=1795614720;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zdgni/KYDVSnVpIQoWrLir2LPuUOBVrOrwa8HUDo1MI=;
 b=15CrTVrZmsZ7+qugkL+U/408/UEk1y1RyalIYMqg4yo4Vip1NBzEPNODxTNVcAjK+x
 1DawfRmBj8EFT7/kosHKVmKU7/53WG9iNfqGzl7tFW5OUyqpsvtgSeWG3aYOvm9QpiEj
 OubopE5w2sFD2FCqvXfk7RbTtqYGBLHM/x0nrMs5O2yOHaHYUmMSWdoKLw5Easov1gvy
 tDfYvh0pkJzlE3+tkY/1VpesuvwEJ6ki0DR2CmWQim4BKbACsaY3jZqh7ynxx6GVVaIy
 JO7zXI19XI1ssdHhJ1hTPwhid25oKb/vS0XmSINIBf1aHkKHq2Mt1l4TfNyiwiQbQf1W
 MMLg==
X-Forwarded-Encrypted: i=1;
 AL+hErEUHx45Ar4/e/iNSw00ijyF6oo2FX7we/amUODeQ1vvx6dPfk4QoHvpVuVtImrKfDWTgDG7UPU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9HMBXoBwP/8a4K8dxu4SyoPq19PXznjCl9VVQIzfJYm396JRQB
 aFbtvhoryan2SAfLKGLNqHrKGtdvyFd2+6JaNWl3XtzSUCe6l5D4CsnTB6rViMOquNb1wPYM9n2
 UbITM
X-Gm-Gg: AZFdTZca1/yrP/DNWUbHWL0B65E2AnSaihNjy8OVTdgi6TWRrdMW+kZ9N1TyDvpKRTD
 mkwr8G98am3xD6suP5YNITRD1K9b84raTV5jownADtRtWagJYNB1icpP+jVg4vPoMOXJ2nm7l8M
 2+r2AKU09Lh0LXoa+HjT9e3AkZg8Aivgo2tQsciQtqYQivwR/5Gfq8Q+av5IxwXhQL/+0ULLzk2
 c6RS6ygyc3THje5xdXC1nFdIoI1miS2DODXBKMCC93YXL7utU/lmnoGXhCttStiMu0CGGOlLj+S
 raAe74mOga/OndiyTcVMGCVd9q0RCNsTPYyKUQHY2oOwMuqpNCo8m/SSSBjBDBgFuY2BaazM3wv
 FtIEWcr5sXn/sBCJQOnEvL1KZLKO/BVHN4C7vDQuhpjeaJYVhTDBvzEPUTrhY/hQavMo+UPQcWm
 q5nxoM5uN6hhDP1tAgoXvXEX3LdzHAi1TjMzBv9HAuyhtGICr5NY7rJH6GfEHGgydYYKwiJlaVD
 8Synh50Sq8M5HUyeBVrQQ383XRy8puNgJ1wuwnAtZ7HA/bHUb8bj+bCFQhVVyMJw+X6zr5tOucL
 AG8qsH/FOgcZ2yE7qr6FRPFthh2ndveFBVV7q7GO/F9VivEJWeZ7
X-Received: by 2002:a05:6000:2489:b0:495:b427:1e6f with SMTP id
 ffacd0b85a97d-4a62d6d71ebmr6037272f8f.0.1795009919979; 
 Wed, 18 Nov 2026 05:51:59 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2efc2sm4249528f8f.7.2026.11.18.05.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:51:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fastboot: block: fix wrong device pointer check
From: Guillaume La Roque <glaroque@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261117-fastboot-block-check-dev-v1-1-31f05c746bfc@baylibre.com>
References: <20261117-fastboot-block-check-dev-v1-1-31f05c746bfc@baylibre.com>
Date: Wed, 18 Nov 2026 14:51:51 +0100
Message-Id: <179500991180.1357981.14786038924649135328.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795009919; l=402;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=OeBghmZjyhg5nO+OlzYbISwt07/6qf+eT0A8rir8GB8=;
 b=m+zyzwRVa6Ryh5LhlB3oEE4V3mj6QqRE8zFJyjvVN96P0e1c44/W+6hJENk5+1Bv88TVuzY/O
 cOGeursSmZyBm7lzdn/NC9m+UuY1HL0Gf1N0eBe8Bh9gKBFx+SUXyz7
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 18:08:01 -0600, David Lechner <dlechner@baylibre.com> wrote:

Hi David,

this patch is already part of an other serie :
https://lore.kernel.org/u-boot/20261115-fb_gpt-v3-1-7ddd7ef832f6@oss.qualcomm.com/

sent before you so probably be better to use QCOM patch and put you
review on it.

what do you think ?

Guillaume

-- 
Guillaume La Roque <glaroque@baylibre.com>
