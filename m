Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2DAC79F8B
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 00:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0005D60BF1;
	Sat,  5 Sep 2026 00:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3hvFNhBq2a-V; Sat,  5 Sep 2026 00:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0D49260BE2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788567278;
	b=s9ISGHp7N5xOJtpAW2qAyZs15+O2kZKPypyHcbO52TnTVk9NLeplOgDM8XS/9cxMQ57s
	 t+6s7ZM/HqJUY7UBNneG5g+OGuvfyscGBHQ0NLO+7uU49yf34doJhJKsRb4c6m+isIsFR
	 PyWTTTYuKf29ipQnCX3LvTzcPSHO8vsPWkh6O7UvuKw+gKFkh+qk+58NrsFipRBMp6SQH
	 ReA3SlXMpFtJ0TNU7EJeesycbKNRqYgAgeZboL+vVu/h3914P0SooNRiMsDMjCmkcOy0a
	 /p5Lk4a94NfaAuGbOvHF3JO3Fy0ABqysbwDYQZatabc56nEjWR876bVUn9fN1TArNNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788567278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=f8oZNrUhYHwnSSHcFUblnTcz6QN8t2ZTFR+FDmb6mG4=;
	b=Aha4fsFc9aqK+LuE/Avbxl5KZFAkBQApyAN59OKkpbX+W0W6E7EDGoXDddbpGSF/Wp8L
	 /rMy1/DQvyTztgiVjX8hGwHQsWMEztjvZ5zbsheCrMWOYhTHgFaJIzXBmw4EttkkzmheV
	 HMBnbJkYfFswhjOucZr8+wz9+hIdZohuydrPXoBGWyQXgLESLYKZApnbka2sZerGg14z6
	 rCe8yNuBFg8PA5a6zOR7BZ0umhIyIupBFnd3StnIWN5sCtaVsRrmPMiM8neM6sENKWEWN
	 maJbd8dATzd4vKc2kZzs/jYuzOeMFKiY06P+xSU0DmFxTIuYLHJxo9aYSgKU5JlYOkQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788567278;
	bh=f8oZNrUhYHwnSSHcFUblnTcz6QN8t2ZTFR+FDmb6mG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S4VPHvospLwGGZX8MtjZ6WnNQl/C1W9MfHLJaKZWpHFVagSKjifhMS7B42yd6AGAt
	 I17tGjf/NfkKgvAKCABGhoQaW9ybCU7WmIlqm50zMVszTN4X/fQCxWS9n4dPle9WPk
	 ewDWaqz85F4TEtbtBCLp9AxZubqG5jchjnDowsVzaRdlzbcKThnh4qt2mUvY9nYcVG
	 vSt6NSf8pldt+9qh7LXkHAK9XTmyYybYWTncJr6QoUhMAyz/jiAfem2nx8RaU3/1uO
	 64KAQl06oYM6+EF3J+M/kUy3N0/jzlWlFFrYDQhg5myy/ZZMtZqWizv5YTPz9DaJIf
	 SpPCx2bw6jUcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D49260BE2;
	Sat,  5 Sep 2026 00:14:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC8E0388
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDEA940528
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qsr76CmQRjQR for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 00:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C1FBB40497
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788567276;
 b=E/z0uM9sv8FOMrKeXXIZ77XrUCo7WcMzgQxbU6JJCyp6yuvtqeMWOGJbxYMzyRaCSQE7
 z3oheZHTGob6POk2uKIvzakayRxSc0YzXHpg1tMptIlGQmhOcrGCbFlzJJ9a6pNIBkF9h
 970Rhc5R+RXWMHIGsCR947dp+ZwRI6V2PZoIKGL8dK0liiyCAdzJE0tM6Mg8QmgRQofwo
 qpbcmpxji/djVjCWDklO1PI44qkDaTLlm9YgXgakWm+JhnwceRU977+w4wejsdNMachRv
 Ljf1vRxCEI5GXSu1xB6iiCOm5j3G4becUsvfjffHzUjyMcEDR9gcMq0C6xrFFluAucw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788567276;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=f8oZNrUhYHwnSSHcFUblnTcz6QN8t2ZTFR+FDmb6mG4=;
 b=Men8i213fKIAWQJenwM7WGNYU1XfjIYlnWBtxGG0WqvLDCxtH+CEfYZNsjjuFMsxJdW1
 AcrorgYSduUjFbqHvhUW7NqfEPU15ytaCj+J47AP/8FcyIs9kEBxILdMHTZzkmXz4Y137
 VUxw+RfJNzvJqAH1Tw1X90oI2Iklqu5FKGn7sAgQ3iYDUOfWrLUmT7UA2CNL7wvSl7GBS
 +VI+G2zB4/eZne0UYXbX0Hil+SzIHTTdSvyy3+5qj1cS+5GMHuGd5OIZgf+6+l0ehC3mr
 ovvH1nVz16HFa/QpxPrR0ueuoqhwpoUxi+astRrVBMMwR9Ca92idCgYBIEfVfJIiYzw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YNqrMACI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YNqrMACI
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1FBB40497
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:35 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4b3a61bdf22so944729b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788567274; x=1789172074;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f8oZNrUhYHwnSSHcFUblnTcz6QN8t2ZTFR+FDmb6mG4=;
 b=YNqrMACI2abj6peV/dAGmF6+Aiq/oY0KUe5kSEpImguFxdR5wFRJaRwNq36+Fg8AQp
 97M4tOPwysM1ni21kD7tlwCS15T6G2fLUIjs0p3bRw6m8z9gcDB8xVLgG5c+v2GzJHP/
 w3ij4wXEpBvX/ZJvks67Sv+upxPL00H5ffUkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788567274; x=1789172074;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f8oZNrUhYHwnSSHcFUblnTcz6QN8t2ZTFR+FDmb6mG4=;
 b=NZjm/UnAzbN6vHDvsttmSHSR6R46ocjxxHYE3U9+ebIbfsGPpHBG437lVbKHvv8N+R
 hkgcktESi3q719VMA/PPhgC7PnsLwYl4ZO1Y+hEQtQpHE2lXwK+u7dCfS1WskDkTpJv/
 4P09pMxFljzLFLZUI4Ch8s66hBUoF6ywYeK2y4QPE1SHw/b6hotdn0ytnSf3Ad8/cj6S
 R7IOhLiUn679lyFEfJeqW/4WT9eAe8XtDJKqwMqZQbvbyddaV7Au+qBVutYlEDuwmRd6
 dxbEMe+Hyc25r2A4nPu+QIfmOQUMoxwTnu9wKDZU3daGvtEE5ZSo20shqJfBSfYD04Bb
 CPlA==
X-Gm-Message-State: AFuF++k1/66AlFUkVhOwSj2Axx6j9akpVHpuuUYJzLC6DtPQbsJkMCVs
 zZroZO/sKOCir9vu12MsYEYcPcE37tXfwuStC2v09W6PPCON4rh9LHeejOMWsuV1XlU=
X-Gm-Gg: AYBFou2fujQt8iNBu1Kbwd5rg4GR54+bMwG7oVXLu03jJ9ajFUXGjY1rxoIJt/F+UOH
 oIW3ADFMitbIh1qf0E072BdJ8FhGAMwwouTCrcmero3DQ3SQnrDjbcSoNOORDTQ2Yg0oWioLRWt
 ADAoaNT4y6Bo9euVoGdizutaknPLuVBMyJ4cE8sDOMElHAIDPdBu1p4l9VA/4XUMkpoYnSWXHmS
 Nz+48tVeietWrKRmlAqhpNXMMIL/Di2aL9loPRiy7saXOxG1dkrJmeYgX6lxgU0QVGedDwfg+8j
 d36x5qbLRmUcxrYUd0PBEwQosXH7J34qwH9/s+LVh5Us2BO3S9Kz7p78spX5UigOk2Qtz+m9eQu
 SdB987Ei8wc3YON8N6ss5ShwKYXatUYuwavzh3vZs9srSOREUhEUc6Uklaom0cLYUrsZAbqsNVx
 CiUs1GR8QK5VSmxNqyU24IK2rKV43iMeFgh7vIZ43iKBUL3LuzYHekJdOslUyS+1jF87tHWHg9H
 HVPQUG4c8I3ml6Hh7CEmLqfj9XkwP2H3UTOZFEb+NVESAy2Mj/BNAM+14jrp6P/hjHTQQ0Sx/2N
 oCICOz2H
X-Received: by 2002:a05:6808:1986:b0:495:feaa:9e3b with SMTP id
 5614622812f47-4b965a75102mr6193773b6e.7.1788567274173; 
 Fri, 04 Sep 2026 17:14:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b971b97c72sm4027463b6e.15.2026.09.04.17.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 17:14:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, "Michael C. Pratt" <mcpratt@pm.me>
Cc: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20260902082439.20547-1-mcpratt@pm.me>
References: <20260902082439.20547-1-mcpratt@pm.me>
Subject: Re: [RESEND PATCH] fw_env: allow detection of NVMEM device using
 layout node compatible string
Message-Id: <178856727326.3086907.9872788558223304386.b4-ty@konsulko.com>
Date: Fri, 04 Sep 2026 18:14:33 -0600
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

On Wed, 02 Sep 2026 08:24:57 +0000, Michael C. Pratt wrote:

> Ever since the transition from a separate NVMEM driver to the layout driver
> in Linux commit 5f15811286af ("nvmem: layouts: add U-Boot env layout"),
> it is very common within devicetree to have the compatible string "u-boot,env"
> in the nested nvmem-layout node instead of the parent partition node.
> 
> This allows u-boot tools to detect the u-boot environment on a
> partition that is also using the layout driver for NVMEM cells.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] fw_env: allow detection of NVMEM device using layout node compatible string
      commit: 358c3dc571ee706d8c641cfb092a4b9bc19b9c60
-- 
Tom


