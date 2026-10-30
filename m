Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CA60A2626
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PSdwmobp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOsAbYuH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8C7581135;
	Fri, 30 Oct 2026 21:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AI6QZhyw1c_8; Fri, 30 Oct 2026 21:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C63178118F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793395010;
	b=T1icIsEO35f2360ppErETztYoLZqAkK51cb721fPYDAggGwRSANIFPx6b9tgCbx81MLp
	 E2VdOouAG7ZcjNfy/iHHa1VB+Tys6iHcvFCIUcxb/aof3E9dXA3E6lOwjWWZkngshwvK4
	 m87vPFvzteWLxCtkf3vVeK3bIPvb2OUsKPtw8jVmoLvNk53zlyMm2yLMgD82X4qtgaVqm
	 Xv6IWKy/8oVLUiz1BsJ5CKKVKPcE2dt5jg5Qo04UQr1JPmvBofjZ8p1Tr/e7k6MgpXsJn
	 6/VW1p67PqoYr+4SSNWG+teVdu4AMZgqqgwL70f8WWvlKnNNxTkB8xyStPZf2s8PJnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793395010;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QsF7ztZ3aZrsnZVfmhwFVxdeDJiFlLYumlHjmPSA0og=;
	b=sDkiwhEK6gjy6tsiBTceofJk2muRkH1sTieN6VZSzfDMO845dORt22HSFe/Dt9Yyf7iw
	 4jGUpug02gMFzbrHM3J31CwrUL0iqflkUk8cNctWSiMtQJUOBuOvupMlnpNIgy6h+Gy/z
	 gmMd9lG3Q85HvT/J3v8R1F4r9XOCiqi51oC7YKaD2fUBgCwWuU6LROIe6LqgaABgxYm+E
	 Pi29LGmBf1kZCIVpAefP4t6rtCV1dYhQXzCD0/X7NDbYXRHJB6FiOPHA3gyVURT4FKwRW
	 7NjE0f+9/FC8GEcygg2Y/u5OYXxN3BFXpRWwWb0p0W4SwEy7YNiS0GxzPqgibHPz9Ew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOsAbYuH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793395010;
	bh=QsF7ztZ3aZrsnZVfmhwFVxdeDJiFlLYumlHjmPSA0og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PSdwmobpNOSj/+vZQ8eaApDUIqZeam3rumqcjJYU1pfrw1EGttiL2GUdnhmxa5e8Y
	 o0Pu3/RuMo4bQFUc7j3LUtPYmqv8j2QzUtIIUEwqav3S7bvQkjfVGbyk2kqRWpv/Z5
	 G9Nq8JEJL4nnxjg+UAbOkW6DbjQmubl8Mepf21xvg3+2Sh98gP8lzneHCUH/fN2QiI
	 VdLpO4xvLx4QQMlTp7T1XEt/rgzUxEtPisFBQowqitZ9YKoDhSzDdwOgP2JjsP1gn8
	 80rO0Ua1WljpWCksbfpXj/LELkWPgklf7Syx4yEX/SDGgpJBrOdG5qxUd0c53QObNO
	 g2NAuoSynQYow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C63178118F;
	Fri, 30 Oct 2026 21:16:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2913362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFA2A81180
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S01VyUJmgJGE for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 18:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E76F4810C2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793384778;
 b=mAHw0emsa7QrTZOWz9nweDQ+Qanaln+skTskFegMMfzuNL1jL4k18CRCGTDyCCYpRRQ3
 AJ4w9VOnvkmSi6wLW/sP5JZcF8n63sZYSXOtjzd6u65cJrpGFRL+efiVd8oprb6pDmy6t
 3TGTcXzQdCgqty3VWYP106owd0xqn2LbWbuZ4AptUwkhztNZ261Jm6SEe1T3F21JxyWHY
 RS3hDM7WC5ydT2xBkc/3rtNcpTjXrmEPJc2jL50FoyS3FD9wLhME217E0QsJH5+VJVllP
 s75nPvoRxfCfvz/5O497jXKcA0httDPCOrST1VtvYYPpPbisAF4HDvyPoBl7jHg/a7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384778;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=QsF7ztZ3aZrsnZVfmhwFVxdeDJiFlLYumlHjmPSA0og=;
 b=oh0W0WFgPKdK+ONrszF6skcJ8JTs3Ur/Eu1wrziNnPQ/qf7ZKiziVsUkKqh+H+6c5TP4
 UlVGtKUeDtZM3dkhAFIbQXShOCR9Tpsk5b7SCsGRyxAtphRXOpVBINi6P3PcAOFmhOu8Q
 s118pjK234FxKsdXmLGC0vlgFS8heFjGFq2owsjLrzJbZzYOjVL3vL5lejVEMUII+WtOJ
 lxTbsb1hGBMcASKJTy5ObQHbS4MJREatoOufLUDYmDly+bGkYatr0N1zmPVjbK2u+mW2v
 HCD8dqa/NuEo5qFgl+LLTohvq3FTn3L6emkEu2Zxd90FlDfnOTu7nOOWLPg9DleA+5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BOsAbYuH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=fugininsane@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BOsAbYuH
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E76F4810C2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:26:16 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c4697404c2bso133196666b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793384775; x=1793989575;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QsF7ztZ3aZrsnZVfmhwFVxdeDJiFlLYumlHjmPSA0og=;
 b=BOsAbYuHWpy8AgjtpPrNLTVyq2wDc9TqOF0lPc/O20xDdwLyVC5VZwZitl7pT9h8T5
 vmpfVF3gFipt1q8i/8EHiOooGGzyDkCGt2BkWzOkG1aC8GeyKAZSi8apjO+8ZyOwdsqv
 teuWxGg+C/tSDKcwdwerJQ4Dg4btglxZbFoiI0U4lScV5iDqZpT/Eud+ojj1gLZG19yK
 zH2nPPKfx7bpLfSmRCWh/K03QQci1k9h2iXI0QToBtEz+uszNpDXLIqpn+WUaW281IpZ
 49calDrHwx8kNM2tV6d3OSDMwGCvm/EPDh23Ji3wgC0p5WnmBqK5FWSxbklsqE7j/4cA
 E6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384775; x=1793989575;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QsF7ztZ3aZrsnZVfmhwFVxdeDJiFlLYumlHjmPSA0og=;
 b=w3T3aZk/VJAS6COL1pEF1JyJFlUFMDC5QXAMcirrdjvXExoFVe5tbWUu/GGvGzxHwW
 ZvOUxHaLf48PNgeSWkDuKZsbXyhliMkh97N/mcXRunDIpNWUMvxaDlDsvjuROxS3HGW5
 KesztJlJPnZUMnLBVlG3zDW1NClqfjrMK1bqZlO1fU4vjmgdp5OGdSPqe1qPp0R09eJB
 NnfxSnQ5JYHBaH9zCcN54sj4oEFqqv5uSpjMZ55fEn2zGBp0NchI7lHn6qMb8rVzScEA
 p/Mg3/hQEfMPcgz2toYEJDg1dGa1chz2jXFW8R3SuEcthlIlWJVX/TCLu9RzCpX19y29
 ssaw==
X-Gm-Message-State: AFq9FYKpur3DF9mXkJTpnb2CbMpDyfB5aq2YrdjpmxguJtKfGAJtx3gy
 CEP2Z8zk9CWm0mMT8zTLbYZCxDWUnyq011824uleF0XKERMfVav6HW4R
X-Gm-Gg: AYBFou2FrpSr6kqUm/d0Hp8rDRyc32pZUCZ44SP5TT/9g9xW2vgVgaLSPnCdLqR69Mu
 iDQbvgAqJM4dciM4XXnbaOk0M6ZiOSXcpNFev6MluUZGysdfEaQh3q7MZHajjgnFH15EEQNvNUA
 O7UhG1Rj0PNAw6rgjLw9lXOsktf4+vpYz1QSD8P+/LKHgJYwaDuZw7sxsSPqwHdrd4O26FCi0br
 gFVMzYoPcRAZfB0KDGyWW0kZMB5pxEVLXj2iRplQpZKC0fpy1uYVBzD/xwnBlUXr7Lvntzw1eO7
 hatbRYYZjsY3qs7TMtvQR12cWXZaI+8Bqc8iyRUmCGC1MLtXU1lpb32Y7TjNEZFtZfpfv/HCtZ+
 PGk8I5ajjBYz64JBQ1cCV0Or6o8QZhWg4lkMewZmdo3ts850YQHSEMe7dZ61oORKACDptcpJIbv
 xWhtyRxLN9dmtwvSdBaSUOvHWUPpLh38sK/JrL9qh60LdUHuvnGuxYljXo+cayc9BsOvpYz9GhB
 4eQ0hh2/YHYIg48ZEYJCBAwScnK14r5lvBDOWqWbW0BpRtgNEml9FJqCGokWOIFfc7KcA/PWOjC
 luqbGBwwELV6y+7UuDwQyfPfIfu7
X-Received: by 2002:a17:907:9301:b0:c40:d920:747c with SMTP id
 a640c23a62f3a-c4ca792ea21mr270133866b.7.1793384774190; 
 Fri, 30 Oct 2026 11:26:14 -0700 (PDT)
Received: from coolemuke.. ([193.118.55.31]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfd21asm100034166b.18.2026.10.30.11.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:26:12 -0700 (PDT)
From: =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@gmail.com>
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] sunxi: Fix misspelled NCAT2 config guard in gpio_init
Date: Fri, 30 Oct 2026 19:25:35 +0100
Message-ID: <20261030182535.1325093-1-fugininsane@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030170841.2067385-1-vinicius.eduardo.pedrosa@gmail.com>
References: <20260723105705.3338923-1-fugininsane@googlemail.com>
 <20261030110817.74836-1-vinicius.eduardo.pedrosa@gmail.com>
 <0639556d-dd5f-4f9b-a6df-bad2625275af@arm.com>
 <20261030170841.2067385-1-vinicius.eduardo.pedrosa@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 21:16:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vinicius,

On Fri, 30 Oct 2026 14:08:41 -0300, Vinicius Pedrosa wrote:
> Sören, would you prefer to send a v2 with this change? I can share the
> patch and build results if that helps.

Please go ahead and send it yourself. You already have the patch and
the build results, and I have no R528 or A523 hardware to test any of
this on. Thanks for catching the problem in my patch.

Andre, please drop my v1 in favour of Vinicius' patch. I won't be
following up on this, so no need to keep me on Cc.

Thanks,
Sören
