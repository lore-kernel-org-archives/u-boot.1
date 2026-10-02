Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E79CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 18:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4719D40D87;
	Fri,  2 Oct 2026 18:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y1fqlKg1iD-k; Fri,  2 Oct 2026 18:52:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A79D40DA4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790967164;
	b=RrZJ8Y1G8cq88I0D7Fe45wGrxTT2zx6FFDtZsoARkKmOwtMe6XXbtzB0KggSTS0CBtJT
	 wtKbZgYbyEQ8A7VlQwOyJaDSryOkq1WLXsQM06AIa+pciTqM+SO9wouAk1FOunGlv8hyp
	 GP+T8j9F54lFsIJP+6OlurOCjj9Q21I+/kswx51eRSwMJ0oPOsBRI0Z0BCRklZqLmEjw8
	 ho59i/LwQ6F4c+69AM6VMOVGZjjWY5OFW0QKVMW/0Cn2Y8tlt4EKs5J2KEpqiGTC3/+b1
	 XJdxciVUwK62nMGBHk78/jPspxyfphTaO7U0HW/xaMAyEsKBVHdnCSjfsBWjA0XWQuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790967164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AEuWeCj56DXpTlOHeD7/IS+tqGG8ysCKEBSU/9SQMOM=;
	b=ThQB5gQxUm6HavyIULglHBaPR44lTs5k4elnyl9gEGp8DLdsc4b5GD9nAbddyqBAdnAC
	 K6ZJPrcsAeM2Ys4VnafiIFZh+5oIIgZKSHLvYMylSC5qThifpTVoiRr5iioNmFdG++7tM
	 T7W4TtmmjpxifBuw/psU3XsnoJEAAjgElD4wBxjnVtPjjFiMFM3Y+dH3J8+wwSLDlJeag
	 W6q3xA/ROnPIx20n08n1N9IdB8YgfVefEeQfn2PCQjY78UgQ3RetkC1pqYzthZcF+GblT
	 RLM+ssyXzV4EB8xr6sPhLi6a1x/vQ8I452L1W00scDSHgb+6KRlQh+aB0u++cvi60ZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790967164;
	bh=AEuWeCj56DXpTlOHeD7/IS+tqGG8ysCKEBSU/9SQMOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A1QW34F4MmZU+egyNlD0D9FlyOL8LjOv1pHsJdx4Mk/Scj9eymmy1XeTEi6aLbMvG
	 5B93Uj69QkQWMRXFFLoRiFks1gQla0xyxeJdeJrtaaOysgSCMSg5Y64h6wANG8Zsdf
	 rrMMMgjxEoA00XCOZ0dJdMnclfrZBa+14zpQM9jw7u4MobM7n1cDBeTh6lK4XgdaMY
	 /GA5Gus8430Sf7iBKDHRHTdwzLaQU//tqk/q8nNU5idDWHYUVp9z7jLRtf55b4Z6u9
	 dFC2Se9Gf38gH2Cib283H3Z6wqWpmBI0TNaGhC4pTdv9c7bgSPJi2+Hm/cHtGCQXt/
	 LKXLnDYSX/2/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A79D40DA4;
	Fri,  2 Oct 2026 18:52:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 880FF282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 18:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79E6660BC0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 18:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TE4TlVhMZXpJ for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 18:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D166260600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790967161;
 b=jkz7jdfaWDsaRM702rODtBS0Nw93ophyBoxu4g5pKtX3H9p1DWhMnfxiI0eSrpi4YrUc
 bdZST8JMaxC6aR5Z9QQQNFLeKBpx0fj9OnEqt30TZHltPUY8UZaYYjTfOk2spCG7T+JFc
 8+VtwBJKSuPS/C/tyg3QQ5xblCyzhkFb3GMXqXU894x1DMaEpNQQ7UIzACnPSKmwHkeAb
 OC1SnSjU8+Yrs9kVBxe3eogyaxUb5g3ZK5n8s2WZn9UI+XokfvTJiSBqwLfSavz0vuXoN
 TQfVOsKhYXuZ0vl2HfqR6+3W7Gv1Zreu6OfxMrXeSiN/0DwNfNGImVay57PJZUaPvTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790967161;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=AEuWeCj56DXpTlOHeD7/IS+tqGG8ysCKEBSU/9SQMOM=;
 b=NAtSaTGd7IBqKIyOBs0ouB0f/YrFGr97r+unmfJwqraA8tiy95TDjXYSf9hIDyxNp3cI
 eyE7hRFvKIZKC1ZmGjSxpS5r/R4rjr1p7Y6GvbR5l+9CyrX5zghx14McPGgwZjxHwuEUL
 dRpSDOZ5WaCT1wJxJjnBJpW6+EWqTIkb55jh33IzTF77ZFsrNVuRlq9q8x2LnY9uMFlLM
 vsI9RY7ZF4jkVpUy8dyCsTAtsgDhL8nPk3dS+bquo7TvC75A5nqoU6gAMM3ycD8/0Qz+h
 RERhBDuYUJkYEd6e2eE3lKbWBVVu5kQmhE+QwbVgKqYGJ1suRJuI8KwoSWIcE0fZkIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="bk7/cLx+"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::29; helo=mail-oo2-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bk7/cLx+
Received: from mail-oo2-x29.google.com (mail-oo2-x29.google.com
 [IPv6:2607:f8b0:4864:31::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D166260600
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 18:52:40 +0000 (UTC)
Received: by mail-oo2-x29.google.com with SMTP id
 46e09a7af769-7fcb425fc2bso167912a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790967159; x=1791571959;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AEuWeCj56DXpTlOHeD7/IS+tqGG8ysCKEBSU/9SQMOM=;
 b=bk7/cLx+DjZpI8w6BMe2et5cSHPPrUsZC+rQoBUFCy/2hp2GfX3vnQNVEdKXy1g5au
 Fl7FAgg4hjZ1OkY3osd0bJnGYz+GjjHdtad97F/OXYiwti5u+5s8qbtwVlyUax6BULlE
 BPE1Qr+QigycDdGzxDWJ62WuNpyaMFonsnqaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790967159; x=1791571959;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AEuWeCj56DXpTlOHeD7/IS+tqGG8ysCKEBSU/9SQMOM=;
 b=P4g+xu+SiOy3ptQMflMBlqMUnjRcAVFfeMy97veIkBcfOKWMC92tTdoBywIMA1H+y2
 k09HrWBIHblJciJipYdpn/TccpHyLmhkuhWE51M6p4+BJgPSUSvctJpHTdcLrrxK8K8u
 kn7Ut+p58NKy01rMS9g8VzSj4UewYCVIRiqRO4LB3sWP+rsk4u9O/PQszhISaHgiyO4L
 WqduvpjfrsFWY5YDXqyLlcMvGzmXul+ISTIQAkz1jWehqiAt2GDWsbwg6ER0IWr1jAqj
 QEz6eqXFdPy7iJmqYUCtSZfmd97NK9/r4J5H2kovDgUfhkaB0MRvICc5EnNtWc14JMD7
 srvw==
X-Gm-Message-State: AFuF++kiEMqAIVrfca4/FDrDkhbHH/mfYLQFV/yYMCBAD9MuXqVn1Pms
 /wj3+bXLtbdpZuFiNA8H2V9Y6mA1thn2K8Hrjld7s6s+LQ//Pwa1+PT4VIZ9DWNjJaXlcKogZ95
 0xGpySRxwJbPT
X-Gm-Gg: AYBFou1rb9AbpS8qe7ADWjVOC0N3d83jTnmtfvAd/aoi7euolTvicrx33t2hvZAQAp3
 PyaK8h1nu/Is5zLQ4o2u9UNayghnG37x0m2B3ZLIYbt/iP+Ua++TLDy1+VZ1vBOeP3CDsnVoDvq
 jHDrWtI7Nta1bN9IHTwnhxFpVON1rASK0TfT8nzJO3u/leiu3YK9dsdDs6GrYT9UDQHnp1IABVE
 zBKoYKlMqmcQfG7qh7zTw6nvtTCJbuVMTkLZuFdRp6PkI/lcBHTx0ePeMOBSW5FsaURNvN104s0
 IKZEubKrabF0VSBsgtVT9B4UvxgTfVbLu0nFAMktwNKVdB7Q/CviL23f7gVuRHpruoRJklh85sB
 znPDvICDRentLn5Lb3QTm9rForbeWf27cTOhbtGszGSNXi0cHp2dQyCz4g+OdP7NQjAiForXgaG
 xksHiG6oJO0No5/H0KOkW2brTGojQUdIiyOMddsVkAis4QRb7knzi1H5zpvLpaahfd6eYXBTFVZ
 klAoe0z7boWbt54RsZKSLr6+Z5IwczHucZRLz/xPfwJsSL/LyDSu07Iiv8ADWcs2i4MXnatrX1r
 X3Zi+V5Pj10wh1WMeI3ecq9NMwWY
X-Received: by 2002:a05:6808:1b92:b0:4a3:fefb:899b with SMTP id
 5614622812f47-4f526a4e780mr3044146b6e.7.1790967159294; 
 Fri, 02 Oct 2026 11:52:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f5253e2390sm2969574b6e.17.2026.10.02.11.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 11:52:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marex@nabladev.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260921220620.151189-1-marex@nabladev.com>
References: <20260921220620.151189-1-marex@nabladev.com>
Subject: Re: [PATCH] MAINTAINERS: Fix Lukasz email
Message-Id: <179096715828.2776763.13613024166910304316.b4-ty@konsulko.com>
Date: Fri, 02 Oct 2026 12:52:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 22 Sep 2026 00:05:38 +0200, Marek Vasut wrote:

> Update Lukasz email and .mailmap entry.
> 
> 

Applied to u-boot/main, thanks!

[1/1] MAINTAINERS: Fix Lukasz email
      commit: a6ab6a66146ed0bf1420db0ee858b49005783222
-- 
Tom


