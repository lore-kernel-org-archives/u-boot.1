Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AD0CA9EC5
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2AFB81209;
	Sat, 10 Oct 2026 13:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p56BK8J6pE1m; Sat, 10 Oct 2026 13:12:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08B01811E4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791637948;
	b=LJx+D0B3Jljd3/Vbp25SjfZ7KyNUspvy+AymCvRLegnwLCnGXMuWbcFycGD0R9swVrVx
	 An96XLWbeP07j1d6fxsp5cLFAcRa+YGNInlH454dzSywKyQMcuBk5ddiXl5N2arCle724
	 vGiv9fWgjA1atkbsq8KS1vt4F1e77yxdIPSKFjbIEV3zs84ch4TfImvvkOpVFYgVbesf7
	 HqSkkvseekteMZyWxDkDcbeW+b6iz7igq9LCR1QhGwq9FrgZvJjplro/3vZqXNEW2tDBC
	 2KYuVvODtG/0hbIVpPMdWRii+VYRyd1gHR0snpLzqYYnR6Dq8tzZ/TVeHFrA8KsH13w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791637948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
	b=mCSdfjq+N7dA25AsWMPoxKmtc4APTPm1SoKYZmWd+nIuxrhNV4/phksvzEtytmEVCDwW
	 F/1IGe9uVcT/hx/c6hVdZhZLmV6u/FUf2S9ONDeYDyDwVzlXpDs/+gSlaIpU2zPXNqFah
	 hrHiezwRQQletFxPH+taeumeOrJn0zDhzRXfUq4xlsoaIAqVFqOOfZCprGwLx8TXxiEBB
	 JstP5L37iBOR/fH4gbjulaf8Ki9jA5rfH7IpwgCpdtN/aly7wJZOOlaI8U9ZvFebk7JR4
	 uAd/g1eAaZxSiLR+ws0738PMbTmeqAMNlNCaiZ3hcPtOsXsl72QO/XIHMT8vp7l6+MQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791637948;
	bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ToIX9EKUOejiLYcql0KmzsStf+EYZnwCHHT/AxEdeJpdhKzLSo/rmJW/IuzxNcZDK
	 DcTqAmt88KMTGt/p3JmbLLdy61y8DRUjOSVnidPh8MudJ6FwMN6pSg93m3OqKchHF7
	 Tbpmpl6oI2dMOJ9G6bDQxYs1gG026zgAxl6ZkeHIJtrUG9KgMd0Qz/IFIaKcwdB5FT
	 oa6tJa2rJdJ7YmwzFx87dCh3fyCArS/ru9lsimCw5/uHT5tCvfq/7gb2zmGUlzbSii
	 63Nl4kUX+jjV6VjXNlf61Rl4YlCVaIF7peAzDGXcc5w2GzJ8bAfUTCjb/fBa1tB22g
	 WL1XOS6CBaWQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08B01811E4;
	Sat, 10 Oct 2026 13:12:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 53B10156
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2748140098
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRPWtgAkGBbQ for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 39D3240004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791637939;
 b=NOV611Kax+F8iYT3WAyBwdfLZHvODKX/4ELjPNZRiNT0eYNGBQv936sGx0gWQH9eR9mV
 FALQhVJxbLsMb8WVyi+HEmSFds/cPKRl4dmuyuBkLtZ7V/nkB2TNapwLpnkLH4O+av3e5
 T8psi5vSHbhvjgRk1PytBGaIN7wLZ89JLYcpYtGHXBNH68H+wQuVXVwEH0VZxjg3+cPhf
 5+hzszXfI34BIX87GB+uAFhZ6OhNAGsKva1nHRBgbMZ9zNNXXqoWv1zvKIKc0Utb78cgL
 UiH/mA0xd25npJdFPiIVy6NHbk4Y0AVCLGzRK/Sz/hp+KYSG2ku+mBO0xsc988utQ0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791637939;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
 b=FewLe6NR3vU+RUEnL80Hor+SK5tqyvnHeP3oIzEf/lmOz0fPLvj/91pNKCi3tJcenCm0
 VoXNted0K3J+s9zBosphayYjWB7bnzRLzDTObCkDmVNEo0isPlHkRtvdsiy7RloJPYwlr
 AL9SpyXj7kxzXFl78YPQP5EcxE16soe9fiQx45GItTcAX1xseBdmwxhq3VehJSfdFEjCE
 Sz81etQms9zgPlGc7gZmHxsoOaujvSKxVAS/PU/HDTz7NYj3zY8dbywhW9+5Pqt+c7FCV
 pqY/eVjVJGywc/805byQvI6l5DeUEZS5j9y5V1rNfa5aaEH7+AQ1AgVq/m8TBMgG3OQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lRmIkhF3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lRmIkhF3
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39D3240004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:18 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2e8e738ae0so101846366b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791637937; x=1792242737;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
 b=lRmIkhF39jVvDRouKIYC5wyfCgkD6cGQws5+1f58zO2pWD2mw9RwTR5PpdCmMJ6Siu
 +IixObrOHiHn1i0B8FIJgJMrfLJe0+5CyacI8z2IITBk/b89JFxKvT6J2zU/ILNWarZZ
 DQ/zXGPwmzHlKOkvJILF5b8QqDFc88jpCXyVxXeego0xYSsJHReoWUw/RGBquBtISYyn
 fXk9ESHvxLQALTXhO32YPxbf6GLd4kdZ2DnotCzLzOlYUYdKHhhFO/S9AlteatBVvIHT
 LZIPkMeFAD2VuRgXrRl+WbcBI6axufAT9omNQtlNh+Q6evLLgJs1NPzccxqp7bCibOz8
 Y95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791637937; x=1792242737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
 b=MJhUdT55YE9Wg+Tc4rfVvtPXlDzMUJLk0PKNRY455cVEX9TTRyGwvukTBeQOZi//oW
 RIDe639EyYE0I6vE6SN08ahxud3NQ9vs6lsA4+QDXRABBcqF24JAto0fxw9+wrFg6MVV
 NjK7jXyGpBJnEnm7rAbI3U4PmGbagdMgVQo0UHeRGRbWEoOU9jM1Yu9MmrHqPspIH6xz
 MrckDk5O5vBHc37D7GoHgraVoCFGGOl2xRxWKKRW2xQ7w8XzHib7Jw9Mc2X8vNdqkk2+
 GZIxQtISCF+LiZ/7sFgzKmuI/czeOh2uPca49XM6ErO98X2zuiodu0PCBB5C8D8PLdtu
 r+hQ==
X-Gm-Message-State: AFq9FYLbBS34EZTfQ7qTpJRnvn9Vmducf/Oe0YHnCnNuj5FPLGJaLX6/
 OMXtb/6VoqM/7VAFTiuETcg+FHGX952fV+MqDbYPJ5sKGKrMq5rOqutBB+2czha1c9U=
X-Gm-Gg: AYBFou0AeNezjFFJVc1Rafzep1Fd72bAvVAH6iXdrgZXhk/Pdol8AcQkQx7+LSXx2a0
 3xheHcbY+tjjJeuIYFNfJiwPR94huQ3DYeXI5jtN5j6GjMo+oEuQNEgssiGl13rlNN9tx86xSoK
 EmJpcIBOvYaKznyfkCz87/keJH+d0NfR13UTPId/8YjUJOW39YYsjkTNNQizE2ysjXMBSmSkn6r
 xpfVtDBMj19CNqqoJQV5KlXtw4CuNPzlivDjd7Qd0MkSjpOmyTGF5IW3UbPyqfqMnXuQFX1kyBz
 V5VK1caRuWZg+BHhk5SfVCJYo3S2/Fk27W3pCugT2LdrBGHlRZd/GxPxioanpAdbtRJd4et7xuZ
 NLLdWugAGVOg4gkcgyfzH6pY6m25QXatcYM1YerStxj1k4WShpiGrzZB7fA0Bp41h924EFxGB2n
 ilzutGNryjHkg+HFmkPkif7qogxYGxwiGp9BjOXptUpyWnnuM6fe6GJ1P4isRWUFC2PdF7d8yPx
 i13hmaok9kt1PmxMsDXp9+/CLWfVfN0
X-Received: by 2002:a17:907:9712:b0:c2e:808a:f781 with SMTP id
 a640c23a62f3a-c31a9f8bc7cmr468351366b.34.1791637935122; 
 Sat, 10 Oct 2026 06:12:15 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.154])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a71d42sm240051766b.32.2026.10.10.06.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:12:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 10 Oct 2026 17:11:43 +0400
Subject: [PATCH v3 6/7] test: py: gpt: Bind the disk image in
 test_gpt_write_part_type()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-gpt-4k-v3-6-89fd290f85cb@flipper.net>
References: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
In-Reply-To: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=alchark@flipper.net;
 h=from:subject:message-id; bh=vPKOWbxaes67b+WZ0i64n1guXVxa+sY6CD4xEwh40KM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSdsly0ri1+SpB62rlLTowPG0ra+1axx/axtWss3j5vU
 g5vbhxXx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFM9byvDf9eW/jWH60o5/2yw2vzzY8LHuuz7tytmdRxjnFh8Q+nonSKGf4rBrne
 TsyJ+mTLXR4sub93syzF3+eEtbb8nvpnav8RtDRMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Unlike every other test in this file, test_gpt_write_part_type() never
binds the disk image it operates on. It has worked since it was added
only because some test that ran before it left host 0 bound to the
image this fixture provides.

That breaks as soon as a test which binds something else is added
above it, and it means the test silently depends on collection order
rather than on its own fixture. Bind the image like the other tests do.

Fixes: 7a598e633a53 ("test/py: tests: gpt: add test_gpt_write_part_type")
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/py/tests/test_gpt.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index e6d8792ac1fc..fb4c8ba67d48 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -338,6 +338,7 @@ def test_gpt_write(state_disk_image, ubman):
 def test_gpt_write_part_type(state_disk_image, ubman):
     """Test the gpt command with part type uuid."""
 
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
     output = ubman.run_command('gpt write host 0 "name=part1,type=data,size=1M;name=part2,size=512K,type=system;name=part3,size=65536,type=u-boot-env;name=part4,size=65536,type=375a56f7-d6c9-4e81-b5f0-09d41ca89efe;name=part5,size=-,type=linux"')
     assert 'Writing GPT: success!' in output
     output = ubman.run_command('part list host 0')

-- 
2.55.0

