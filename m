Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569A606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hApDqIFk;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=HJZTKCL/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E68C80E5C;
	Tue, 24 Nov 2026 18:42:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMdskuQV7V0U; Tue, 24 Nov 2026 18:42:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8BA9180E5F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795545753;
	b=G30oyHU0qzA6M4T0LHG9KS4C5q/a5PrVzR+Kxz6s/RUa9JFP4whZLqGMxTlNLrgMXPFP
	 eMltFs575ORCgbZzri5/bAbQGkVUbhZEDuexyhr3hOq6joMiC9zzZbaeN+58ykquJSj68
	 w4vT/DAC+w/WNSd96FkMzIzh09/HNuu+o20os7QNf7P3WQE7TMqJre8MQxBIVFW6xE2x/
	 QHBaRu7NdySFf7PTiY+ZQLpzubSCp21eMhlpGAav8v1L9e/S5E4dYLAhPkPjl+9qCucTW
	 sQlP8VD15L9Jxw0uIvsKEsNemM1gfYeDShW5mMje+6tsrh0KFp6tYXNHgnYJXjNY7bQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795545753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7lW5MpM+xMmoZHfCLnSqgEoWoJ1WoZ6noYjg3xVCnEE=;
	b=ohuCSjDlNB7ABVTSOQy/6WuwL07MbWdjRjAneRel3K5XD7It0zFb5WCL9oMkcEWDj0Ef
	 UHX1AZXDQZ2akZ8AvzAX9eZIH0UCYG4ozBsQ8HGeSMDsNueFdSXsoXtFSe8MiTOGCnadH
	 hwvuP2TQIxSfrsWXj8itZW3yTCADlHHBeNP8+qEd0JeoNui1F0HIryiF71d2msbqDvzR1
	 oiPtWDxMekaqwcZ6seXq8kzc5J8kSsh102MLqo5t5StfOaYq3BfSycQad5ODcqEUCOsfn
	 CeS4ZxDDC050bAa3x20sja05MmsOwrTmhjysP3nY2yhKgYhX+hWZpn9k0I/U23htsMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795545753;
	bh=7lW5MpM+xMmoZHfCLnSqgEoWoJ1WoZ6noYjg3xVCnEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hApDqIFkpkn+wfJPRhoJXWi46ywRAQtwJWLKppKMIgR0De2Pcqgr3OrDGQqDE7vk5
	 Y+KJpHcJFkvPoG+2fyNXUiSA1S6htHDOLmjoIj1TxW2meouD43QVniGnBJjQqLpDdh
	 5vDnla2xT4+mtwGLwqwRclnh22U0zSbztGK2yu9lvwIStIdKGzfOoPOnpftkxnS1ZK
	 0dJ7KJrukeqmoOMepcezttUVaCukrxauE5DetkXoo8LD9KEADX0KLiIPsCjoPyPapI
	 VK2O5G8cFahkLnxwKWkJPuDh6LMTB/s0fDqt9cAQjd8DwG6W8WipsPQTL7enYHy6At
	 hVEoD7pIUtvwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BA9180E5F;
	Tue, 24 Nov 2026 18:42:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 87C752F5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D8AC6065C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vpxs2I4dN4sN for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:42:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 992A5606F6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=HJZTKCL/
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 992A5606F6
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:29 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-84a248254f4so2998221a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795545748; x=1796150548;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7lW5MpM+xMmoZHfCLnSqgEoWoJ1WoZ6noYjg3xVCnEE=;
 b=HJZTKCL/wmy+guLYaPN0qMrGt4cwiIGKv3vFbTfp4I4x/yutsYGPaVV7pb4E17tLS7
 paDQSBQKxtLMQ4CfmxROJesvEQP2EzDzIcAilGc5ketpIPS+oAPaLsdULFa5qTh5jEhe
 WiBIXNTr6VRW4uHnk7kgJlvA8Joui0yhKL/uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545748; x=1796150548;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7lW5MpM+xMmoZHfCLnSqgEoWoJ1WoZ6noYjg3xVCnEE=;
 b=voH5KAeaBAeJUCR82PNg8/ukEOtBLRhIgcGQOhuvTxQJLLKu//O9uZCVPWH7hS9K2a
 GUvQqLBoimqV6RfTIPYk16SHnTdgI1tNxdhr0oPO12lVz6qbWQYwTjbdnvkLdL4qnrFs
 vKcAda2owPJH4PnmfpfOYKoA6FUXLFKy1TDoXYLgBqEfLwLiV+RBav6FFzDYLTI7pI2A
 2yTBr7Fz61hOnEer30SWDO+N1kao2wNlFT0F9S5jPPOQN5bSJdSVVcLty5fnPzrDeb6E
 xPwOrCKMB2IIwMutGf4/Lc2EHk4cF6pducwJXOQfHW9rBLNQPwa7LXlbwi80gMzUSCnK
 OSkQ==
X-Gm-Message-State: APuU4Z9hu3dbPFQ1+hWWBv7kDJSh9s3bwFpTAyIdPQOlHrRCw2V/oSs3
 MinwxSXq7P4inpoosSDnNzlf+o1dGB+WwibN6+TQQ3GFee0FX47lSc9nVTVzKAi9xi+emVWesUz
 k6G7WpRZBlnJJ
X-Gm-Gg: AZFdTZfJ9lY2vT7ZUnocN0UJulFw4QpUEcfaZJSrMCwAovg5EElvpCnNdLx8PGJ5qnI
 JDFV7SYErXIePlPu+CzJ4xEHWib8F5eqW0V8dbXnA9PVfPlZeJmKvvCGRE3MpLAvyNkgPA/3QbK
 bWB6ajtQSRbx/WoyXTUy2Zm8q09tW1lgK284FmY3RqHwCE8jKRBgN2hVsPbE8GAdhagN+cOol58
 nDDwJd401H5rmaT4z8jznove5sNLN52s7/Mt2E+JN8DBw708qa21px9JX+fTnlTldluGyimUgf1
 l6nb6MJ0UVlHjtEr8Mye3ScWo7oqhWlW6yYNiPwD/BxtmSxo+EAVEis/1jO4666vaXLv0tiC2rp
 LV64llNQ0TQC0GPoJ16eqC6qGWampwxNrpiqPt8enIQPlj3Y0SbHF6mVxkyWMP2+w3YmC8YZRYd
 emzWXR95n6f8osd9fY4do9lMNF7oecQuJGEYa//m/hKDDpuIsNzHL7w/rzS3x5NJoDxaNQ6b4L0
 /+mRf8yb8mQCmkmAQ1+436TS/3LBbTw+kxOH9XDAUDaoLZlvy/5GRat4lI6L70k+u8n8MF7WrGF
 1tgms5/LyprOE31ItfmcYm9XuSPQ1/fP+eglTqC3XPnpjvUOr7hL9zrqYzh5ddgHckZ8h8Q7RhK
 kN4sbikCjIBjUnfKYjD1kB95ztvxk741UaRmP6hPXRsJTJ7Ef7PReypaR9xHo6VfzR8cJmqEAfa
 xzHp6dV/lkI8OVCS2s10PXlFTOG7Emug==
X-Received: by 2002:a05:6808:c1ac:b0:573:680:4bc3 with SMTP id
 5614622812f47-57a0c7cd6d0mr16176709b6e.58.1795545748018; 
 Tue, 24 Nov 2026 10:42:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250fa1sm11256626b6e.5.2026.11.24.10.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:42:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
In-Reply-To: <d0f3436a-f97b-4ed4-a53a-4263dd3fb1b8@arm.com>
References: <d0f3436a-f97b-4ed4-a53a-4263dd3fb1b8@arm.com>
Subject: Re: Please pull net-next-20261123
Message-Id: <179554574700.1054544.10059802235953614097.b4-ty@konsulko.com>
Date: Tue, 24 Nov 2026 12:42:27 -0600
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 09:37:39 +0100, Jerome Forissier wrote:

> The following changes since commit d22f61a39fb68bc697e67df45f2e3103378bc7cd:
> 
>   Merge patch series "Prepare devicetrees from FIT configurations with fdt fit" (2026-11-20 11:47:13 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-next-20261123
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


