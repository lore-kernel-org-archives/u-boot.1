Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A1606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KIb3+h9K;
	dkim=pass (2048-bit key, unprotected) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=RPddBKKb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 865CB80F61;
	Fri, 23 Oct 2026 09:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lk0YUCaRoVyN; Fri, 23 Oct 2026 09:00:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E02F380F77
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792746053;
	b=Zz4Nu9oLBCq0/VCaHFpnEGKwd2y8IiYe0Pj8lNahNegz0C4Rtna4YS8pijZS0o+Fvtnv
	 svAObzv32m4WS5S/il1MpAD4/ofY5qNfdR24sGaLi5v5lGcEFvQFgmF34vBuTOl3crubd
	 X4/p5d7ed7t5VT0I28XybhKOOjs3wW+4jOwaf4Y6Q24wLezu9XR9OAbUv/F8A73+rRe0D
	 ku7tfmAQo218Q57hv3IwRz7E/VGZUOIzV7Ugd0KTXYDlh6BRnBJDCl6liRlzcpIbaeRQR
	 CGcHUZ+lSQurwdgpLkFesajGmK3yi7H/LRD4InzFkyWxLh1+0jEv/qEHuyDF8RN3yaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792746053;
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
	bh=97C5h2EBTrUPfYVwiKGwAgu22FajQhYIyvyZtskOtIs=;
	b=ifa18DNgXhiEyigxsn1m2fzXk0SFGRQzuJzThqCtEPT0eeun7HM2Spg9SNFGYSCgfKMG
	 MYpMyHB1QkvRr3R+4U1H+W5objc0JU9PuYnITr7n5B7VVhAttu3YtFVs1cBUBbjnKDhJT
	 zI3T8phtqIEv4hzvPc2WHlpBnrddQ9J6h0KvvVU+V/DqbcL3y7zkcGPypxjuUuO5CmOeR
	 xj33uWRb+bmvVY+ujdzG7i6lAd9x2kFJy5hODiIh1dCWJldP4s0oesdv3zilykLOtq8gQ
	 JRRVjptDMySEeLdPm6Qc+T4YK3rMO8OL7wSfNrV4OOsxr7hJ9XsSbivivRfHEzVYn0Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792746053;
	bh=97C5h2EBTrUPfYVwiKGwAgu22FajQhYIyvyZtskOtIs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KIb3+h9KTZtcXhO9mv3pqs2mWKNgYl4W8c/phrQLE+IezOn+hXw//YzVtTBUnhUeM
	 gvncob2DEj4Fi032crbTp0IDD6fDf4E5hKYvqTaCIf0N6WMHElztk47cAG8i2Q46Uu
	 OzQJIUHBW4hlOiCQ8RqF+qAZZo2ypNQiVpYK8g+oxf21DxI20EKwG6ouaK6txVcfzp
	 ZbXyAT8aylKwX/bx4VNQwSHJOJi72ATVm5ec5uz/dwP8dN7yR1tAWOVy6rt+sDQc6s
	 KBm1QRUnOysHBVGtVZqyYE49mmex9z6diT8NjQamX3bjDe7iuW8iSHWtRzt746FH6a
	 NdD/3OhOxwDpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E02F380F77;
	Fri, 23 Oct 2026 09:00:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA99449D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFC77400B5
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:00:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqx-1zyp3Kjl for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:00:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 428364008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792746051;
 b=IUqUVao7cdRH5q7POYJFEIGp0XARZI9cW0H7sSkrgo2r9KFws53PpoG7TlchAWQP36Qf
 oMDFjT7fYzj2IAcQ5laKRjH2lSKoLm5LQZsi82EvVfgqSMTUwSejvvb3FZ+fABMUFDZOp
 Ny/kDvmvB0vVVNAmTwm1A53WzbdK+WuJViiURgBLg034edfoEtJYVwiAMX0coH7QuDcei
 HXdYz9ZetEeeaTdkUucnWJAGBECM/BxcBkeaRhSd/OHX9wljZ/OxVbbIO9sm+7OVxE9t7
 Ndfa21oqX4SWSv0eCiz3X5jCVz+3lxYw/zaGmp5iVuWQYKA1A7vi69WSL3LO5Br/onw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792746051;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=97C5h2EBTrUPfYVwiKGwAgu22FajQhYIyvyZtskOtIs=;
 b=RZuplakWYHLRf58m13lP2ZO/NyxKNMz5Nf2WHfLzgKOI4Cu4sFOAvDRMOqm5EaFNMwHk
 3uJnql4i0OFcba+LHnZFGgMGrNaxmytmKLbsQls6AfuBJHXZvcOTVvrdEPU+zq7h0wHYk
 5mI9jo9NOxpiyFap5u7O8P8P7BmJeZjBMGVziOUUliaJMcEgk6RuAQbs2GCLW9NYE+8ot
 i0tK4qEpr0a+A7dnent+leuRqUu12iX+9Z8er8K6rNnkt/RGmASL/gNy+q/454KzbJl6R
 lyF2lIq+7610UPLLm+7tlTvwpkvVN3g+gSVE1e2kTw2E1OrH2Govoamb3E4awMpI0oA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=9elements.com;
 dkim=pass header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256
 header.s=google header.b=RPddBKKb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=RPddBKKb
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 428364008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:00:49 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so5972355e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1792746047; x=1793350847;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=97C5h2EBTrUPfYVwiKGwAgu22FajQhYIyvyZtskOtIs=;
 b=RPddBKKbtSxcxaHyTn6IRc0MmhbkiamYXyjom07MaFUAo7BRRvVVsRbpfS/jEguEuB
 kBq6T6j4OezWC2TWtSvzBFT8tzUyuYYI9xyD0e9AzabA6KWZJS/IMbpH1B/CAfzxrK5b
 Rsfx0R21DvoYF6C26ABBKD6017VSYQX+mLe673KlPH89pLOoNc7xQLVMCi3PoDtvrHPz
 8tuVIPUWPKQ6/FpMjpXOfLUe8ae4trfnMXgY7aGWsQydn52NjELDpUn0ACp7pO/4v3/9
 8PfzufM4yM+rzCpXMZFaI3poK1Da9S1Ro0JA0mLzuYjhUqJ/7DaOO6zCOPCpbBi+yMJ4
 oeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746047; x=1793350847;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=97C5h2EBTrUPfYVwiKGwAgu22FajQhYIyvyZtskOtIs=;
 b=o7DvJmVaaeS30kDVZPQVoP9H57Pc6avGkhQe2qkG4c78di8sT0wJcRz4Z3McV+eypw
 RxgAdNgPtwnRbL5MNLAG4dgXKfH9KXHB9nBhHsg4/6+/HeW5+qpaP5vC1g9uRPAZtnz1
 JkHZ5f4UdEQF23SbRox1G1v30jJNDPxjEl3RZnFjimB9L1I9eYNLuMXXlvXADzg6eaLt
 PFiR0e8hAKyM9LJiFsFYsa70t/LxGpvt2DkLKb4JeUa8DN/4mSRZSdp+M+XDiKdA9qGx
 Y0InG89YPJCRAjeQjK1a237PSHWLA2DQqnhMByw6Ls4Z0leFpY/a1F+NG0YZmpHUwK+S
 wwDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq9PteYrYkX5uYuTWaThO6NYrhdzPNbM91fOnuwGNor31DqQOSJx/o625GV2xmU8JLvmHyoK8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLuD3aEc19f7cQGCFG+PucjNZEQicGY1bebobPuu/PbiH2dxyLg
 t5orve3an0gEmSLa6UzYp6idIpmllQw51/gXQyL7qtsdBDXu4v9W/vAkGzdirwvywmxtLD/XxCr
 1+U5PsDc=
X-Gm-Gg: AYBFou09bEtnQSbWlezyP3qMp43wsJGzz0sQCXIpXAfFInWZkYrI6RXLufFmR9WF+JS
 p3n0TOHZ21eRrATTAiStsCIOhrGfQ6SGQ8xBiCZa1Eu9eNKxGgfWEGwFQMnWvrqTW1RHww3MUHm
 xYaB7Wyl/YCwvZki+se1mpddxVFh7/khtLspBwR5Ie80kqi5CEA5GkoqZ6gwQnKBX2EIU6zsb4A
 Bk/4JgUOIEash8tlr9umh2+A4Jb4Gj7qeCUE5C+oDQku0JCtiWBQ3PD9Z2wqKmxxlWUX1C26puk
 OEdodlbnIRw7aw4u/u2qczcFaF+m+ncxPFX4hqitZsRnZEiVQPc45J/ir7p6vB67a3OPG/mwBd0
 WiE4pk3wlnMS3pT5EZIeQmmVGxmKkE9ZEIcqC8zVQPSY/wKp+mnXWit+c1v2sepHqSvwDE9fCZE
 xkgffG4M2TtokAi3xzRQNx+S0+N0AkgJUBofbuxwx1wv2CQg8E8WIITr+ch6vbHR1RkEG/y7CcC
 BYyg/z0oPv4YSoDNQ8GaoKurzPPhTV2zXDP3+Zqk92YwGG2BE5i4omP6e9q+rM+tMAKTuM0uQ==
X-Received: by 2002:a05:600c:470d:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a211c51ae0mr24982395e9.5.1792746046959; 
 Fri, 23 Oct 2026 02:00:46 -0700 (PDT)
Received: from white-mocha.local ([2a01:599:841:69c3:a3ce:18eb:5996:fa43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211b29394sm50194375e9.2.2026.10.23.02.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:00:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] configs: evb_ast2700: set default SPI FIT address
From: Tan Siewert <tan.siewert@9elements.com>
To: Cooper Huang <cooper_huang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 u-boot@lists.u-boot-project.org, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261016-ast2700-fdtspiaddr-v1-1-2b376be8a6ef@aspeedtech.com>
References: <20261016-ast2700-fdtspiaddr-v1-1-2b376be8a6ef@aspeedtech.com>
Date: Fri, 23 Oct 2026 11:00:33 +0200
Message-Id: <179274603375.770075.17983160493944252560.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792746037; l=518;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=F2bXI3ibYwfPTQwwWsXUp6JdNHl3D9JNPO5miyKq8nw=;
 b=lJpV9BZq/oXxd1y16kbxmqkNnxvZrzfjExMRHTY4GkW9015abDgrq6ax5LHPJgaiLsavYqjAV
 lILxnezaaN8AOIj/iWkmQQi9TOhBP22u7aNt5S3nRBdFtnzNQzozCI0
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:10:25 +0800, Cooper Huang <cooper_huang@aspeedtech.com> wrote:
> The AST2700 EVB bootspi command reads the FIT image from ${fdtspiaddr},
> but the default environment does not define fdtspiaddr. Set it to the
> SPI-mapped FIT image address used by the OpenBMC image layout: flash
> offset 0x420000, right after the environment, in the FMC AHB window at
> 0x100000000.
> 
> 
> [...]

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>
