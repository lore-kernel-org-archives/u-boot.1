Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B1DCC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 04:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37FBE60A58;
	Thu, 15 Oct 2026 04:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8n6B61D6wHse; Thu, 15 Oct 2026 04:53:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9E066090C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792039984;
	b=d1hGml/4rUO3Anx6+vTKrDOQSSWxnfuix3UnbwGPai5VVJ6v+MOjr9PpXj7cQrflrr9U
	 WNDHeKSUcDgWHcpHpfsxYyMXKcL1xZ59SVyGJ0VZU6V6RvMNT0mKWnecj28szqQf3SERf
	 RNE4/taSUYBrAIVzav+4cFFynbiHaFmlHWvCYjpqBKfiZMU1hxI5YbGm8k0G9zimLywXy
	 7Z+GepdxhlH8JAbyoyM0lP1Ui6z6OIP5Cg8l57tVJBOroEDerLdiL9fFfmHgCZbySYDPl
	 JlGG9i7/CuKTErt/ERs/1oTAwK72TIv25+9MJPrXiVCKqSbviDyC08lTbbjVUGI1qtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792039984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iE0GRrH+xDHDAaAVemF1NoA/r35SahpvC6DL2pnOQtI=;
	b=KdMhEtDom/1LerfFAdF/av0YO+qpnZQ0fY3YC3JqhslEkgDnB1AxrYi7432dGcfb8iCo
	 7UkgzIjrwKrCJLSpoS4+4MsyQlb7Jkey+FIXQMYqJ3gyFxyb8HsiHAeqQzupZgGf1hNs/
	 /aNMsBl94+l5FsBqFftOaywLScfGlgAzcqPsCRcYiw7NHVhtzp4y1qk3NqKkoGbHDp6gS
	 JpwdtpQYh6v6B8cDpe/knk50amEtPuCfFqqq2lr764KmYDigA9+uDEkuyP8eNVB1qk4Oo
	 BlAenmhshcJBhdBeveVi3ff5XpFhAwmbEssKzq+i66S+/0pWgM8ZSQWoKPV02O5tcZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792039983;
	bh=iE0GRrH+xDHDAaAVemF1NoA/r35SahpvC6DL2pnOQtI=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vZiM8GD8KQ5YG/C7ZPKoSwBHcRwRPCSyT4W5HJPhQY7d8zNED/r3kOCcRk4W01AdW
	 yjG+NJX5npvslWPWpyyz6has+aMx83MJRGh197y+O6rWKFoi9vDLmu048j8swh+Thp
	 3vJ5Oy9RoOWvKOJhycO85Hg32DbI1n5Pd9fgjYhtIz7PYM0doTZZn85Gexoronq2P4
	 r/8CNzvlBtXj7aWwtyrPcXPhV9IRBuW3fN4mTtXo7uOKsD9NiCnHq1ktRKHhZkGQO6
	 UOvvq1nm6gXOyygc00cUtyErLriAPX6wYpL4q2E7deMr4Hw3zuU8zIAr9WAT8hfz4U
	 BTZ9jjiTjBfow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9E066090C;
	Thu, 15 Oct 2026 04:53:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 889854DD
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8666940223
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EkBe6m_ZCAEz for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 03:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 52B8A4008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792036594;
 b=hA5i42xG8IQmbxdmE2zspZUTR04J5mmWi6ipuSwnJRKvcR0k5EqVnTrV4WxwhhSpKqv4
 CkTt7D2mUdoWniOwqletsbH0gVqPTPIzrOdLRoXQ8XTkwxafSSJDOdjVHdpLlkz7CvA8L
 1x6dC+lIgkzrTMBVxoYLIC/SHUx6dW75y9mKIcAvLGEIL57xdn14I1t0Jn3cxwLp77b9/
 YJzoQySRNKInOIbYJuLHoeyx/OLSAej5+Y1nrg1Hc5kTKbfaYXZDpUBZH0Eu2t117A/kZ
 2PjWFMxHe6VywBBSboPblagzaDm51FanNF3oXjGsjbSifSjgMVkWg3z3tcKCxeUSR2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792036594;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding;
 bh=iE0GRrH+xDHDAaAVemF1NoA/r35SahpvC6DL2pnOQtI=;
 b=d1DSEPdMjjGANIb70dMvnhjGX/XqHrCjSyxse/T6WKlvzTGUiea2huteI1xbjWLSqbA8
 IFpe6uk3I9phRPYGY9jGq74ZuEk9++8cyTbehtOdhO1V32RMzfza5ZHSFn3TPzSx+lTxW
 Dh6GLnUo1qrAK6Bzv0W+brzHStzu3gqGBkJRXskBLJuhMsPyhMmvAKewIgZpENpSSpvXp
 e08oIM3na2eCN96YJwRjikasybicgZe95pUa7W9Zhjlwh99gkAJD4kt6AHqR7RHyFtXYK
 zJiSkw2xRKQJch/WtrSae0R/VQ/oaxW6ZcBezS7CZBcO1PdWU9NlHg1DZ9MPhY6Rl4w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cRqhgDyn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=anon87111@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cRqhgDyn
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52B8A4008B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:56:33 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c14a06c95so3843435f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792036592; x=1792641392;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iE0GRrH+xDHDAaAVemF1NoA/r35SahpvC6DL2pnOQtI=;
 b=cRqhgDynHgwSZyscJcBQ0cYEo9pCPeCjd1QVYge7mtwj+ltzFgqF8XnK2bTZsKc04t
 /Go3Cob44gvU4KnPGs/a17yxZhpi2q2nPYDdtwUuRrrNpwRmG4BdjcnZA2gBtdDKG02n
 1yF3y3OMgpt4pxEIkb6m9NeAbnXn7bws1/xTMWZb604g0oMOVYrPR4M18sPomZDt63yI
 4EuBi7EfIZG25jBF7XNLwUGWMfT4LiZMb7vD6jSRYPYP6O//6ghTEP385HIk/gdd5jNC
 y5PcpntOpxgHjJXX6TsSN2viBuYwRRrGdoAc2ePsnM1RzYLONmdf1LioAYVjzKRxOhzG
 w+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792036592; x=1792641392;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iE0GRrH+xDHDAaAVemF1NoA/r35SahpvC6DL2pnOQtI=;
 b=AaXPq3lYt9awWadLilVVbFArWgnKWuCowiQodqLB2dZuZ1NNaL25LtKGB/2fQc65CF
 tFZDixURtNFsz6V2L1QzGU+hqf9H4K3JSH7CQRnNEuHshWvytU5bFmZzwkK/tXtYbb+E
 eoDWnNeILSFy5j0GgdEiXaQ+GqcdMoTY6niRToW/zgB/uD1LF13dCcagHt+d/44hLeEv
 l+mMscInBO23MTWBpO2ibYM6f+Qi33XYEVXwlUWVyEohrl3/xZnU1oFYROgzKstBRbiS
 /mCXkh7/phJXi5xgHqQO47IPaIBeH02LokVBhtQ9SbVtJ3afL+fwdhKMm6bva09HWeoC
 qw0Q==
X-Gm-Message-State: AFq9FYK7WzL0Zeb5Y52vbaHSTVwY0e3vac0AC/YFEsTK4DrdGziSZmTv
 r3ocvXy3uxFn0ESHqK26EHY6GIkBL/WCcAIxe+iGJyAQQJ7KPjVPfzXFmlw9Tzdo
X-Gm-Gg: AYBFou3gBM7gqFAqmQxwy6+msIKfPT1lCkx5h1NX0f930rzCAdEJU2vDQnJW5mNV/Y3
 QfbJFL+ZWrSfRnlyhEMJ170RKfiaAHmvjCUKXv3racXkVPkGmbTKEtOLMEX4EFg6SBD/G4kMv1+
 a8koQOhE9AymNUq8zxhar86sApHA4j6XVXoi9glEuyXeDSYic2rUEQa6I3JI/JNoTm+Ms6KEIW0
 ylAH4SnsJ+m8+9t6zRHSBsPufjvg0bv6zhcrw0QVOyHIoOWKR4tfIGSWqFFABxLSGjE8KyswmQe
 NsECYOsTM182ZT5vh4kWURYx2h5CkdVEml93G2z9uf3/v10YLwjJdCY0kuiAzg6jQTkR0M8LKTF
 F4crubcb9pYl5s43hMxaxpqGBTOSmDWzHTY5aqwy7UZm2zDodZ11naYym30lCeuDXJcH1RQpvnI
 qNgZiyLxlzRbqDnPPRiHk7a1VKBE01kw8ZWkjQhgKXeMn70Y8scpYwMcSV1EXE6eukBjm+URoC6
 7Zua+SjGnT7ngpYlGr+5Sum0qCIUa5S3o9dJlgOORHp8Q==
X-Received: by 2002:a05:6000:40c8:b0:48d:f460:2c62 with SMTP id
 ffacd0b85a97d-48df4602d06mr1574707f8f.33.1792036591636; 
 Wed, 14 Oct 2026 20:56:31 -0700 (PDT)
Received: from ?IPV6:2001:7e8:c647:4001:7656:3cff:fedb:3af7?
 ([2001:7e8:c647:4001:7656:3cff:fedb:3af7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaa9f9sm16075975f8f.19.2026.10.14.20.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 20:56:31 -0700 (PDT)
Message-ID: <16544f53-fd01-4dfa-b617-2dde9b010629@gmail.com>
Date: Thu, 15 Oct 2026 05:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, 0xiviel@gmail.com, me@ziyao.cc
From: anon87111 <anon87111@gmail.com>
Subject: [PATCH v2] image-fit-sig: bind a required image key to its own
 verification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 04:53:01 +0000
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

fit_image_verify_required_sigs() passes each required key's node offset to
fit_image_verify_sig() as key_offset. That function never uses it: it calls
fit_image_check_sig() with required_keynode hardcoded to -1, which both
boot/image-fit-sig.c and include/image.h document as "any signature will
do". rsa_verify() then tries the key named by the FIT's own key-name-hint
and falls through to "try each of the keys in turn", so every required-key
iteration is satisfied by any signature that verifies under any key in the
control FDT.

With two or more keys marked required = "image", one signature from any one
of them satisfies the whole policy and the others contribute nothing.
doc/usage/fit/signature.rst says of "required": "this indicates that the
key must be verified for the image / configuration to be considered valid."

The configuration path is correct: fit_config_verify_key() passes
key_offset through to fit_config_check_sig().

On sandbox, with key-dev and key-prod both required = "image" and a FIT
carrying only a dev signature:

  Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev+ OK
  sandbox: continuing, as we cannot run Linux

The doubled "dev+" is one signature satisfying both iterations, including
the one for key-prod. The same case against the configuration gate refuses:

  Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev-  error!
  Failed to verify required signature 'key-prod'

Nothing exercises this path: there is no required = "image" anywhere in the
tree, and test_required_key() builds only sign-configs-* fixtures.

Fixes: 56518e71041f ("image: Support signing of images")
Signed-off-by: anon87111 <anon87111@gmail.com>
---
Changes in v2:
- add a Fixes tag (Yao Zi)
- move the relationship to the other in-flight FIT series below the line,
  and trim the commit message generally (Yao Zi)

Separate from, and complementary to, the fail-open gate in "[PATCH 0/2]
image-fit-sig: close the image-signature fail-open gate" — that one is a
control FDT with no /signature node at all, this one is two required keys
and one signature satisfying both. Neither fix covers the other. Also
separate from "[PATCH v10 0/7] Improve FIT signature handling" [1], which
is the configuration gate.

A test needs a sign-images-*-prod.its fixture and an image variant of
test_required_key(); happy to send that once v10 settles, since it
refactors run_bootm().

[1] https://lore.kernel.org/u-boot/20260923114940.349985-1-ludwig.nussel@siemens.com/

 boot/image-fit-sig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index c0fbe81b4..d6c61e104 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -159,7 +159,8 @@ static int fit_image_verify_sig(const void *fit, int image_noffset,
 		if (!strncmp(name, FIT_SIG_NODENAME,
 			     strlen(FIT_SIG_NODENAME))) {
 			ret = fit_image_check_sig(fit, noffset, data, size,
-						  key_blob, -1, &err_msg);
+						  key_blob, key_offset,
+						  &err_msg);
 			if (ret) {
 				puts("- ");
 			} else {
-- 
2.43.0
