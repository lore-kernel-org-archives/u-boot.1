Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C38CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6422B40758;
	Mon, 19 Oct 2026 08:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0sw0eMADID8; Mon, 19 Oct 2026 08:57:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F24C40714
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400276;
	b=NvBpQ9eHgZlJilw2PooKrvj1VwoGI4IpqCHQwENtSqBnmzn9P8zc+iumqaobJ4eMbvH4
	 5Iw3FTYEUxZjjrnIL9U/3StCPRPlYdyUDdzBQ353aJtW+vP9ReelRktTiD9gOrRdZe9dv
	 qAdRjI6ZixDgRLYwcoLxtNqIbkZc1I/FPxUvzwguVqeLVwqKQVxYFuxy6iB3NA1R8HbzH
	 hVbNfNF1GXE05VClDoCB6kB/UzaR/PqMSVS2r5l6haaZRe2UbiIEJL3T0RnhFLgEUtzmG
	 jmatppX5V2uShhzjSOZtu9j2kQxQvRKfqibr94P4nPUAPeDCnvuJOP030CUlHKt5nCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400276;
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
	bh=azpJT4myaHE/Ytn8kwpiuP0Zk0ApgkVoH1zJWvb3Kls=;
	b=dmhH43TB7VUtaamAWAUVTyUPmdOTJCb5H5qJXbXL1FwcsuEGXJqMJP2+44Np8a44PyLZ
	 DoEjELnxF8jsxttlEJFrwqU1dst1lF/iTMzaNvy6fWadWZ8sfdLMdOYeyJsracOa0tKUk
	 O2iv0IpcbLXfIuPmeYnF7qutABaVie8uOHu/+StDIqUkabFpdnVzaQdDrfDX3Ftgy6WfR
	 pUTSgowenAelgPNSrFz/i0cgDOdjoUw32qd7stpKDV/mJ1bP17uAKhbg8uwoM0ehoD+uT
	 +xYG39C0EycmKLc7IWWcsmohjPm1w5RrdLK/BHpfNor7vJkmiUoOzilnRoT5tPnPVzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400276;
	bh=azpJT4myaHE/Ytn8kwpiuP0Zk0ApgkVoH1zJWvb3Kls=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vJvLCDdOqR0R/8VNvrRSAGHDHSrOh4wk1p8IGjpUnRe7loRnSGKeHuyV/wjXj7hNK
	 N0/8+vlRCMyusy81x+pd3zbdgLPhAN5qmZ8F5Coh2T37N6nyG/CU8Y9zZsqiOBfplr
	 uvXyOIcLoIx7ta23Jfc8REwuBvucjEidCx8UU42Mds9wdAyh5jSGvKNokyWf+fjxxs
	 qi+5ANw2FYeziqGURo5MCUOkFFXMD045WLTZ1o6iAPCnb/mMkDeBqRQEdZaCgKt3v5
	 IHVjmhXaN857ENO9ukeK+AY/LJ2H15op/iUH0U7JZhCrmLaqm+Ma+3kRBTrlYcE7Rl
	 cq9EuOUTzLjtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F24C40714;
	Mon, 19 Oct 2026 08:57:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 42E141DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34E3C80F71
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id on_1LE_HWiRi for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26D9580F6C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400267;
 b=BltgOON3NbwmZFIVgnFVDDfHgXxzHpSXIetCsjQcYCXIFLKpn1o4sX/VlRewrL+RqF0/
 NiTEwZiKVkqwbhJ2v+xA+r5ib4B/UprsUvGdYQOA2x9W/0BnVoqCpNMkjo6zZA4Qrl4FX
 J2Qy/U0PjU4caotrG/9dmDuf6rYy7XJZ4f1n8mZ9K15jo1eZjAPE6fZOhisgA1hRzuSi7
 bB3ILSoSnCZMDCaV/+jBa/H79p+6Tp7NqR/qREDqvPVQ4sPBOhTtKEa+zWWgb08NK5F2C
 4bh12z4Xxk5hPqjfnRuFk78FtQyk83LvcHGS4+NYkNbGAPtgMi3TPb1fkXNVzDISxdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400267;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=azpJT4myaHE/Ytn8kwpiuP0Zk0ApgkVoH1zJWvb3Kls=;
 b=svY7wPng3blet/fFql+bM/fbvshUmrjLzenB03pJoxg+Nr4NWImiNfv9IiPVsRnwN2mP
 ED/4Ee4i6fghMC6GURVxNnwZnNSQvITT8WPWZ8R5Mi1PYbzdywd9vd2qibeUrGZ+sTUM5
 lOUZ4YwlBT9GkqqetAzTP0mVHKWlsGTkr4chNnKa3JVNwzeE08VHn4TiU79LqyfykSSuw
 9HZtzT+GuGTQmPStoU9qb8BhcuHLEZPdmqULHD209Zck46fwyVR5K6Sk5vbjp8iJcjGOo
 9qhyKS1mE66lDG+4JZDauV21bR/iwNTVcgfe7G7MK/2/iK2l7Vnv8F0HoX8gbZtLBoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ndAijmmn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ndAijmmn
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26D9580F6C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:46 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c34bff61551so249483466b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400265; x=1793005065;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=azpJT4myaHE/Ytn8kwpiuP0Zk0ApgkVoH1zJWvb3Kls=;
 b=ndAijmmnx9rvWWkepujZlpqxxZ4G63XntVR3oZXfB3B7XFNdrt/uv+Jh+AK4bQ0Yhb
 kK1dfrpTGpoh2jaZaQ8hslgTltcv73b8d23wfVt23ymHeP4oczNu+suRAcdStu6WQ0gm
 k7bdW/XPvVcnmU66YdQucmbBC+Z6dEWuAsWDMsfZZaQjmb6t1uFLxuF+F3P7+aKNA+0Z
 uFqYk0fECMGcPnPbfFd2r3/hc4cSZ/UAS1OkCmGlwO7oE69FVxrTZ7rX71meQ7t1w5EZ
 tNady9Rt/slMA3CzrYwThHblSONHDHg6Y/Grwi5Aa5iUjl0VHd3vj3E1wYQVeHByyqHm
 9Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400265; x=1793005065;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=azpJT4myaHE/Ytn8kwpiuP0Zk0ApgkVoH1zJWvb3Kls=;
 b=D0NqGTpbMyVneiuGGh6+t2UJpXfegKRrIx+c6K3TrOs9SHcXHJgeyqkCw6P0NvkWAM
 KgWsAMKevpG6oGUTFl+hlorkXDlnhcMaOfTBa7loRS8MCFsseRs8cI1eYwd+i9B6SL84
 ZX/pQZkV5vcu+OrCWCPsr/TyfJ5dVWub0DrhwHY2MFEqSDkXE2nRahpDDvZiB8KFp29q
 N6T6QO0b22Mh/ouoGAitBBWkQ1/42JPV5PYGbrZgkQ/6EMBO7reNv0rbELkRbZIGxly9
 ISLh6hxcYvbWM8Vy5a/gQtUxDXkdUAB28hHpe8+bnG5SEze6YvZKprnlJ2FQ7HgbbK0G
 DX1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLs3t7dnWaSmeCyJa18YrtxefD6ymMxEAStu6jRW5eYLXZEvFkXrWxDH6yhSnjoHhUILX15dY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLpJGDKG19rYcxIJK8k0i4aj5R8M1sRCc56m1dLBvdzHjhkjQLI
 PbAiugJy2/9qggLouRF2gOMDDEmOmTtBNJVcNsBWutnFHDLridaj0t9rezwg7+fIU+g=
X-Gm-Gg: AYBFou0HW/X3tgI19U9C1ijfyq/LmKKGs5Dic4/Dl3rUwpJAgxLib7dw+33qDB6oKDb
 ZbEdeyK1MNureP4KZ88KN3XWtLKULtYX3Fv7KPAMczpCE5+2YhifwTTyoXAjab/5KSHww7tn1Du
 pgvBnRa8H3q2iLMe3A3LdZ4gOWlNpXCg0rpbwP5sW+EzzR5L2r8+NTyWioBYG2hsXDi6t14rl0t
 0XVExFEruwzduv0njxsuUHJbuIVjyNw3Dk87nKSg/h0WUDGl+9mdxchsM1v1TXjiorbq3epCxMl
 WaeTXpzQfnSrw67kf0pZAunGMu549YUd7jNaJlr1JkD58WvFKF72gsSmTLkwmz01KNoLhcPyohA
 thO6SuWnITD3Yi5o1k5fkTHoUBwg33DqfsSScAYzGbnmJb6Hp3mQ1aHo6C5hDC5kNJRdGPBxOsn
 z1+Rvf0CVFPLxZpAVzrQ21pkJv7ZHowYR91bH+UL1/MnuomSFFUOJr5DK6gdhwyKlSJ++tonKgK
 Ow8op+i7Y48N47XPupB
X-Received: by 2002:a17:907:398f:b0:c2e:4fa2:f3f7 with SMTP id
 a640c23a62f3a-c419dd3f401mr450332766b.22.1792400264775; 
 Mon, 19 Oct 2026 01:57:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:44 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/10] test/py: avb: Move mmc device number to a pytest
 fixture
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-8-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-8-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024784.806974.15134949927027962445.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=534;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=is4Jk/N7T9Q4LdlQw5+7i9QJHqFvTNnRBm5bZuBePKU=;
 b=UogPv3PP5x4b8buL+STfXVjVv5PwUgVq7ev367hq/sCfM3k9eVEuRf09Ml4cG0tcDnqEJuRRw
 NUk3RjY+UuvAbnEWiVXwRF/sgSoyOfeNy6ztk3eWJJ3A+yojIBpyKls
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:54:58 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> The AVB tests hardcode mmc device 1, which is usually correct on real
> hardware. On sandbox, this is not the case because mmc1.img contains a
> fedora image.
> 
> Replace the module-level mmc_dev constant with an avb_device_id
> fixture so that a subsequent commit can override the device number
> for sandbox.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
