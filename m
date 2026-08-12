Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1123C5AD5A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 20:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E3A2607E6;
	Wed, 12 Aug 2026 20:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8zroxoNyfow4; Wed, 12 Aug 2026 20:34:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B56D6607BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786566894;
	bh=eF5hAgPLg0wOQaWpP0VvR+SP5WFAx4CUn9RT85K8x8E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zq8WlvWkiJxsUq5t/ZsoCJpLQvHV4dcRjcgOV1m0tWL+5pzyWALdFKtZzhkJ7fg/H
	 eoV9be/h3jNvWKVNz9WxvIv8JY+142Bac5HvVq5UAArJ28FW6Ytk3FihsnjA8DWBc9
	 sVYmfk8Wd0NZQR4TgAENXydw1+52IZdNZCrc5Fypp2APImyVHj/x3maI3PxnyYqROf
	 hhXqD/8XUUZTiAl1/uF27dfir3zeHWJNzBP+FhbEIucUEV5igELzyXcW0ZgO1IxmQU
	 kT8KHG6AVZMiecf02Fv/1piUHvkPwRFlvJDwktT6drCWygpEUB7db1C5BtSUf0j+uO
	 8zSDxc7pWDa0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B56D6607BD;
	Wed, 12 Aug 2026 20:34:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC6531B8
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 20:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9267C40247
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 20:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id to_at1xR45uy for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 20:34:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B70534021F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B70534021F
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B70534021F
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 20:34:52 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b1bf68b387so660705b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786566891; x=1787171691;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eF5hAgPLg0wOQaWpP0VvR+SP5WFAx4CUn9RT85K8x8E=;
 b=AWq0C9cPb4TGF23JuGjTPjF5cQxGoQGZkSzPpbmqZpCE1rENrkOjEGj4sG3y89Ppla
 NfWZPXCwL9/0qrdj/VimFZRa/XnqF/JMNhEOHP/u46gv7KR9ToSOORbyWdac847Y8USE
 ZHiWsq9VrdZZ7YB8+4uCU7f+Qg67dOVSMFJ3k17zhJDlsSj081AnNOxipgDKvXYaANvh
 OYR0rEDd/oKMRuBDFMEut9BRgkz1WP2Qg0p+lb67G/6qzjCwZ5rVYO0VTmGp5jq0G2wz
 WFWT4pQ7EPguickIHGVQLlKMSg74I9+VJZLVIdXs4yZXuLY7xnM2hBNSzXKolKMWSYhl
 6y0g==
X-Gm-Message-State: AOJu0YzTb/TkZklNb4KZ3h03GCQ4sMD+xe6dcFQPzgHx7FMI/DImk1eB
 DVsAHeLMdbHnVybywBBEGh02XkjkFTR4PbccXgeXsim3E4g12JNRJHUW0QmK1n9v5NfoRvRKmsc
 gTCM6c5U=
X-Gm-Gg: AR+sD13KldGrEzhLUQjAseaHNnqPBQhGArCndbQjGIkVJuSWPTK8pTzT125ropVkV7F
 2mvQ4RCJQ0lrLTMWr1eAMiBzPLoYtSKatCmGtpENYSGsohPlQKvfABQpP+i4G6CKKB/PuqD6PbT
 SamRzy0LAUKES5zXkFXDf1iB0Vj8+OjLnDvLZSX/jO4gAC14KiAcEm3s+6iprnoz9qXDutaJR8L
 Kva3l3PlYuhsqTzQdMdrB6z13QlKlNxxJJOgrFTkpNq3CJM3MjTew2aGhSoUZpz/w5dsKzAe89h
 8Tl+oObjCxNThSUcg4tDlLsxbiIg00cjn7d9uWHUbNa/bKGW0vNt4KuZlid+C361hND52Aw2hBL
 91quADOLQHe5FZAC3/kMULOqmshaMDSQPxJQLvWUbjf0xzkMsBpLLcqgQqxhEojlq49s/9v7J3O
 VadIQcSNcvRCRIoLkm3RdbbD+D452pQDkKre1LFlHHMgxmm1jqEyUQtf4G1nxwIebP/7epGWrGb
 eiS434t7jkJgETJ/3dgH+IW2CNr6jAO3frIe4OdFzgqaGbiv7Sri6nZk0D7HuD2s85rO8E28E6c
 IAf6ys9i
X-Received: by 2002:a05:6808:15a5:b0:495:fa73:2e44 with SMTP id
 5614622812f47-4b2279cad72mr530910b6e.15.1786566891586; 
 Wed, 12 Aug 2026 13:34:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2237178b5sm751852b6e.11.2026.08.12.13.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:34:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <422ca380-143c-4f9a-a4dd-082c955ca8ed@amd.com>
References: <422ca380-143c-4f9a-a4dd-082c955ca8ed@amd.com>
Subject: Re: [GIT PULL] amd/xilinx patches for v2025.10-rc3
Message-Id: <178656689088.3360628.9582107726277724871.b4-ty@konsulko.com>
Date: Wed, 12 Aug 2026 14:34:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786566891; x=1787171691;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eF5hAgPLg0wOQaWpP0VvR+SP5WFAx4CUn9RT85K8x8E=;
 b=ql2LaNG4cCJAWwp4YVkszAFoz2Qtk6ij1KGXmsm5Q1ogU0m//m9d7U/0iKqXYefT6m
 7O3FWb5NtBp+KWUimLSBtnxu9Rpfz3B84WSFgwuQM/tMcb3RS528LYu2d7zuvt5+ENv9
 294B7VSZZEeq5fjtgpFlnqwDy1cs5yDAIHJhs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ql2LaNG4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 12 Aug 2026 08:48:24 +0200, Michal Simek wrote:

> please pull the following changes. I missed rc2 but I think it should be just
> fine to pull this at this stage. I can't see any issue in CI too.
> 
> Soon we will be sending patches to cleanup firmware interface to be prepared to
> move Versal Gen 2 to SCMI. That cleanup should land in 2027.01-rc1.
> 
> Thanks,
> Michal
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


