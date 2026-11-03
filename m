Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29669606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iZNDgSLl;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gICkJVmh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0E4280BDB;
	Tue,  3 Nov 2026 22:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chiLxXNCROvd; Tue,  3 Nov 2026 22:01:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B1C380C1E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793743269;
	b=ihKjMcRHLfoRvklP8T7Oq6T9QKVwD7f4Ny1QCte5eAxyGmAfkC4sqnT2EkOYUtuqSx27
	 FMeOi3uZoapJCFf6vbyb3or/x1zRUJPTrAIdf5tVAz7Mk2/GQLxKOeRx1Clno0ZxpGPWg
	 PBvc0I9DBkkf2nvTH3f2EX3p0lxhtNTvjU8M9JVkO7sBM8GNFpjW1uO5vZzA3iaypjOT4
	 7SFJFnBb963fpCAL37LzktS5zUlMsezTlNm+BP3cPE9I2Y2CO3RhEtNyAUid5LgjctJjM
	 lJ3uJ36pjdMeU56XMiTaiRAJ4hpW79AWcAS4bIiCEUfjsiOKdt38DDqt6Wwo894CLPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793743269;
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
	bh=zg8OTv9NJcQtvqhLnnvT6xoEMHR2QXb0Qj0aO88811Q=;
	b=ot7S1eFEpoKbHVGhsMuBwKh+O0zSGGQWibptWg6mqfYJ1w+tupL7hAuov3rV6E1rOO9E
	 HkyVe09+sEQB8eW8ht8OiaWAyflmoVdy8LTxRbwKaXsxWet2FAkbMKJEKReNtkMccBova
	 fG29YCwx6tSWivqu5+2qUOwOudfTZ/MpwzMVCCPvaSe1MRkyvMJ0tmKodCDeABZGQEMGa
	 n23EAzuS+qJwaSFVi2+KvC7ICPPLUfrbkWpOGFues1LWR/IcJw762ok4uN2GAxAAHV4mg
	 ZATR+KefECMyyfnTtNLuOyS4xibgsdb2lQNJNHWIU+Ksihw4R9IagrZX/gJ3xtTEkiw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gICkJVmh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793743269;
	bh=zg8OTv9NJcQtvqhLnnvT6xoEMHR2QXb0Qj0aO88811Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iZNDgSLlnw40Fpukl//6j/I8KTkm2Lra/Qj1mJ0aPYstPVrFsytJrVSQqG3X33EcS
	 tzEIGxyP2uYMMfR5cAW7t2cb+Rt2nn/wuorOCpNApWKgLAMz6QYJXB6yNrZRw2mJ4G
	 pUsCBEE+q91AhyIy6Vh6tF8PWdbFj2MZePiOSjsruWuVKAqI1hI6UeHlTHEDGcv1ay
	 a6B7XqAYUevGmHN35TjqzBdQIdejyMHm6kN07me5MKSKidWb5n+kDU2Sir9vdIQv3m
	 eolSAKan6BIzaRNLsEy+FEe6f2k3il8vwBs3wjIolIoZKr7Jv7VgBVpz+vBcXtxciv
	 Kjv7saW2PLhXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B1C380C1E;
	Tue,  3 Nov 2026 22:01:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A55159C4
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8ACE880C1E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HLRgqkyUjiH1 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 22:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F75480BDB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793743267;
 b=iLUy1PuVpIAWZj5m0pIVBACFEYVIR14Dgth4+ysmisZtF5SqVu6NWzRa6f5p+drfL37Y
 2okslAUXuWvYh+RRiA5Fc062VRrZmt/rjPm+rJOq4saC8PSIzuJeAEMYHmTrlA0vu0jGP
 /64ZMrdbEA+adEpUsGQ5jcEu4xLhGYrVGeG9VcWoRmR48ctnsBX/a7+76Bnad21D6r7dQ
 AMFwWDy4BSxmXqNOGkqCIoLrPGGi0uBUnD0tGIWLhjA9hpMZvn/o1xD1UJ+A+JdhaUPMT
 jerCt/mk1Xzn8KBVUVJ54FG+OwRL1BRQkfER+/6uuabn95kp2MDIdIRztoQ2hNBSgfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793743267;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=zg8OTv9NJcQtvqhLnnvT6xoEMHR2QXb0Qj0aO88811Q=;
 b=r+aabZrZ1tW7DhSGYjwWYEiF7BTOSUqr8l7+8hotGCQFqRcv9qMfuzVMXy1HKvDd5wIy
 XwGrmLax1GZfn8Xwm40fhugmFJ3An5Qd4d11dLKOlkDADN7CsHnkNK/tgFndAiCDZlV50
 qksMPPsIPMncitDmB2PKS7itbFPL6rjt5p9vt61+XBRKPW08+tTs/U0mnh4Slh0cquWM7
 RcCrKbdgWfyCkudpjgEepMANEPGe4gW11t3wTDtirRIDZJJY4IG4ZWD72iraD+7FV303t
 hrm+rQaiokRE0217g11bw16QKVgWt4fLDQy1g+BzOD3xAKP44hbNMcfKCcnVVKvNDZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gICkJVmh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gICkJVmh
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F75480BDB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:01:05 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so299105e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793743263; x=1794348063;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zg8OTv9NJcQtvqhLnnvT6xoEMHR2QXb0Qj0aO88811Q=;
 b=gICkJVmhTTi5fFwAGl8WzwVHVrL5H3fhEsN+SO3yQSbgrq1o7gKqCHftBeQXUhKKTP
 2ql6Vvt7ZUrkemO0aJWI3Qt7k1+WL2EbXI7QgKsKEsFQb/9U+tyNIBw6IcwRFU/KIo7v
 z+1LNU+epycCAyRX7jAYCU5cVzB0/8yjUfr5XvBAkEBIHzZKeSCxnJTD4YqX2Y1iDwQ8
 KNB5PX9b+1QwqRq4XoH3etdLSizDab2izwVS53v6dicJq8+1CkqBmwfvwtBcKHFmqBdi
 n4yMB1eN6ltAFrF/W/bPK/R8VVwgyzkLsrTCkuUAsv2z+O2GKlZlUSM81KLPAIpzLXrc
 RDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793743263; x=1794348063;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zg8OTv9NJcQtvqhLnnvT6xoEMHR2QXb0Qj0aO88811Q=;
 b=n12agg86zRylRZTMYKrXjQge1pREAuTYD8YjJIJKKop0iXKFO2sEZBLOfhs0Adohbq
 fwC87pY0dfNXaqSdxe/cL+xF0E+1Yt0s4/bYkdLP4SrlgY+KsUr1pT+2bMWRf7xDYkSj
 NWhczCDPrN+787e0CK2xN9S+fnaNww9/kl5FeXQhRaVivqV/+t+arRwYO2fTwWZCzDwj
 UJ31ujOomhBLn+OmJWoOR+vCh+lEWY5eRsrfYODRmoW5WWEl90lINazOm/dAIqfQ8vEm
 Y8yYFsOWnorpFFA55uCGCW2gFmqk26eiSV5OKHDHhHzM1yjn6vhOEZbeeoJjTNZncpXm
 oeag==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPPV2OcOmO++vV4cpgDPH46gM3AJg8sqrKtTzzKiUTIpLTdZut5mG54BF34R3Jzg3FCNCMng4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Nv4yZpiXuDKKd18y/QOybz3WVpq6JsBBalMmWIqLuESJExA68
 A1fNl+GeSCdZzOlTsMvdfOV7vAAQ7tioBliVKy83ZZGZJJFU2Dm/uMKeCBwKayyu2OtzLsXNGa3
 suTrz
X-Gm-Gg: AYBFou0Xx275UznkCzxE7aXC44llkP37BtCqleGORisjNUumDkbt2VM4LGwXNOBld2a
 db7F6lbt0WwujrHo3Bn04m7mk31M+o4tyt1kNYo2Rf1TEr7Cp165cQtb0TvcLGQ5wFfV2q/fkFs
 Z+ij5SahsdJH6ndIMGwsrOSmZm8CAuL1UzB+lT/4PiIbE98e0CrN5y9pRIy4K9G4xvHBwCGhpCw
 DRa8g0tnmv7jtb1SEMkCVcGoc+MGrwr5LC46cWAL1a6zYg+sUYgt6ugr9yFplibg3jaoQP4+4y1
 nEwQud9hbZQuJOfEn/mvQIbvrXetYex4l/qsNe/a2zTf/+m1oeUicQBAyRN3HZkyolSnuTuNHC6
 cV73nbYAUkbAV4lPa5Tn5Fjm+FfcbIUYg69gZQZxcG7/W0Y6drtPHlNrcbdPphtHdHhTrt4Lm0H
 s6LBx0DM4BgNO5QmHgRVKpUcU/C/ICbmzIbTA7iY41zMcp6ENLdJQ5rVb7s+dNSzqQi/c07RArY
 3fHkntwOHFwtY2ycZ7F2n2+9ENmOazfzWq9IwcD4qxB681Uj+AVp0HkBjJCyhYXIkL3pJ6jCCTh
 5OAYIdMxnsZ4q791gJ77WHoWC6CUOEkEGdVMlvaJrk6+3eZ5ySrGX4weeatN9T+NoElaEbrB
X-Received: by 2002:a05:600c:8b06:b0:4a8:9a2f:d27 with SMTP id
 5b1f17b1804b1-4ac17b2c907mr319539285e9.25.1793743262997; 
 Tue, 03 Nov 2026 14:01:02 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43cff3fcdsm3546815e9.11.2026.11.03.14.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 14:01:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bootstd: android: load and verify init_boot
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261029-upstream-android_init_boot_b4-v1-1-30c95feee363@oss.qualcomm.com>
References: <20261029-upstream-android_init_boot_b4-v1-1-30c95feee363@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 23:00:59 +0100
Message-Id: <179374325934.3901073.15402103530739657527.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793743262; l=618;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=sw7wei3yXBeFpkbZi+qFYOV6vSKmC8ORENi/Iawomn4=;
 b=IsoGub063krWHycz6I0tQIRrJOEAK/XzWkToCjUOPX5vcFffbwFupipIre5/pVF5p4ngS3i76
 1tQy5KbVEdoC4bgQ4gq5/Kqt/cfAfnDVXic0jXJlLM7eaNrvd6ru3Yg
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 10:20:19 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

Hi Igor,

Thanks for your patch, we have also it internally and we completly
forgot to usptream it.

One thing if this patch was merged it break TI android boot because we
don't define init_boot_comp_addr_r , we have fix it's in
include/env/ti/android.env and adding init_boot_comp_addr_r=0xd2000000

so  stch is okfor me, ping me when it's merged and i will send a fix for TI
board.

Regards
Guillaume

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
