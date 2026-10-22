Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A811606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oaeUK7gs;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GHOH/BC/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C7456064B;
	Thu, 22 Oct 2026 18:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LnOTYNxjU_ph; Thu, 22 Oct 2026 18:40:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97367606C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792694415;
	b=sv50shCV8qwJ1JNeuM7yx9vfLasiW676zg33pKTkYyYNS30j9Thnu5+HSvGmoFcKJLJC
	 DNanlZQ6SQ1RczGyChQoBS/2H1M0olBWt2mHijlIrgx72eV2pxqCWHOxJmb/D4wUr/Elz
	 53TX7VvvzMVA+5XODlgq6Q6r360QbeeK5ESTYUIAXPG+rvp9P3ejE/M8knb0kZguoCxQo
	 NlKPWN362Wagx+O/Jj1uUCOhgyJ2qcqxgBPB14y0v5qari4B/pYnACLUqQyYMsxlInRC7
	 UPpg+wSCuEhhnl6WXPnI5abhp4wDN9an3qPXZSip5xwcrxahjGEBv31OVyNHAjk7XYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792694415;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LPtjCLPAOH6SHvmp6B+uw4PUJjZwo+V+C9GzU/TLuoY=;
	b=CZ4q+1iCqkxTZIwD1QUUyO+Ks0jTs6ko08QBIOSFCXSJMtbdo4xqEIT5YZXs6rXwjvo/
	 HHPYqQ1/x4R++vAqg6TtjZ8aRUilvoS4beATlfNvOBgZeClN4iKlG9HUWweytINRw09DB
	 dJnGn058F6PZek8xWAl95g/1CSrUyli2mnaXoG+6Z/YkJJ79Kp/3OO3zuhI0Cy0kQ4h5k
	 JCsbqtdMF1Ox2sEG3X6k+ANuVpJpqtp1SxvqecP1LCQyCtKCGvubFDq4pVXw7jAfbMl+U
	 mb2IE6QqkJafm7bZ3rW4KH1+taamv9AWAegg1jYZ3mn1emczYGJ7Svn6Lj0SkvvorBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792694415;
	bh=LPtjCLPAOH6SHvmp6B+uw4PUJjZwo+V+C9GzU/TLuoY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oaeUK7gsBYiNdbqpmjYv4jMT/wRkmRzGHdKehyVX3x5dCw+ODF7grSnKMpSM6Gtrr
	 u6mRYTmlseesd7NDI3hIMJyW3+Ghv8eqFda3lL7MwVqpOpjMqd5Kyl3A0OCFrLOqb7
	 V3NOhDY4zn93yDZ9wO2Lwvjtt86RExG7tO9yjrgNUGgOKnFKGBlpwVwoDCkL7ArdCC
	 avQT0wxkvFWDQ9D+6Tl/CKxWOElhkME7EB6jOEwuNmewIsLjjqvClaCZ2/LXAZXGoy
	 ZYXxEZJCLldW2voimO77GsqmJa0TpDzdFujEePNv8JecDb5v+D0P9M81A/h2vmiShO
	 aXCXeNOL9oN7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97367606C4;
	Thu, 22 Oct 2026 18:40:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37A293AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 295B140176
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJJ_PQ_Dvge0 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 18:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4B592400B1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792694362;
 b=afbDssanej4IzmuIKGMO/q5R/tHhtyMHPtJPPtpUYVAPaZMJQu/7W9az2p0LvCwcGKve
 mwp9qugv4QuOsQj6GLMsJBE/3ux4F7DaKdljO4FmGbB9NgMd0AVLk+5oYTuELFJ/LOqqL
 rUUCAzOgi14fwoKQbXKD7XbbKWY1g7aH9xhdY13bbCYa7gXQ3DMrbWyK2tSNJo1quNIEZ
 pXbN6TaWTF4x0Lwv/ulzBhF0+XX3t5jz29If/a5BO+6s3tTywKI22LGBGEysu3my3XJ2Z
 1CCQQAPLSaw/FfdYNbOqFXN+3lH7x2jRP1SDz1Jrtp604V8uJ+VAxU+3qUdELO6XSzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792694362;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=LPtjCLPAOH6SHvmp6B+uw4PUJjZwo+V+C9GzU/TLuoY=;
 b=gzIEnlv/71NSckUSXXZQrxspCZViN6CQshaATNDfW1FWn5o3UgduISYIPRSn2TRqAlLg
 AUwn6z52GoQ2KTle5b7iL4fmc4HgqiQrZg73BJvIqG2E0ofqqJihNIO9plXzV2CnLkiBN
 WjAvJ7ri1ZJWJctDot3qz1iQzoDVWu/sAPO7b9pfRqr4v77vfSPXotrsJy/1gbh74r3bt
 tm05Qft8JmmHibfIGkrF51Y4vcNa+aMRxyftVUgOKbr+xsEVAnWuJB0U1W1rAAMoiyh43
 UGKfuWLNHi8JwcaJokJVLaukZaYwuwqtCb+0Cc1ipCn82F4x6Ls6OlPlKxl7RDzooXQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="GHOH/BC/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=anon87111@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GHOH/BC/
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B592400B1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:39:21 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so53331f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792694360; x=1793299160;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LPtjCLPAOH6SHvmp6B+uw4PUJjZwo+V+C9GzU/TLuoY=;
 b=GHOH/BC/I83R1gphaGKEJR/MgmjdxlqNDB/F9Wf+RcPK6b7fWYphXNKWip6J4YQ15m
 qfmXsCshXj8CBUeDdU7naf8ufANuThD9wwzYhjBVlmiM0+cwnlzjOzf/hhj6xiBejD7N
 fg+zdfOBwm4+b58MSQXSckJHI7XYbxePpM+stzhNEmB6PROj+dXmymI72OOLaKGbZuwE
 RQZ2XZ8/NplpGA0QJQ2ve5fvbM+mPnQgeeMcGdtfugJTWt0IW4kr231foc8U/B6Ru9BB
 9hIKQgiCeeZfVJfBHPdGVmnc38SY3OLf7Hu/ww7fU4Ltq6pndJi6ziqsHJLsaUrQyTYs
 2mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792694360; x=1793299160;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LPtjCLPAOH6SHvmp6B+uw4PUJjZwo+V+C9GzU/TLuoY=;
 b=JHnRdgQP3na8+S+9uINTg0jjucG387jDEke3VRz/5cxb10BWwbSrGKnfe7MOAv2ztm
 WI8n3uZ4x3taTpLKC3LnkFoZMY0/EP2Qu1hMc933WzlyVkMrPYzHeZ/1z4mjaG58dMwQ
 s72y4qxPh7zhp8WRs8N6rkL6e/e8GvVSY/qKMoX3zXf8qVePjF2KAkHnj8qUj9SuvRnZ
 GAqGMEdjPUnPLMP0JV5u5b7kxDBJ8bQ9CPPjRK0zasXrW1ug31/988r7n3Yr9mkkpSaq
 SJrkT2vodu/LCGLX1GGhaA/ne+aA5L3EWhHyboc5/I/LkBPL94iNosDOd9RU/spz9f/R
 LwIw==
X-Gm-Message-State: AFq9FYJsq6nbAqqUU9DBYOFaM7tM5L6klZvbHuEnF9SGZLdBKR35teoP
 R72DCQbSAV4q0cLobTPbjgi28vstyGnwXH78Q8knf/0GsjgVGoJU0jFE4BR1w8bb
X-Gm-Gg: AYBFou0nyNghgl64yk9UL3BI6fPbgeWMunICmNMIRWaAGn8RUfx1t6UQQ6T8xNKJPD3
 ILxRheHzxEsuMVDnEI0emeXSqPNGXAnEQMxzel+xR/AXG+vfze0i39js6+PW+EuxVgg4HNbn7tP
 TAssdyyzh0KEcM6nB1+vnr+xOXMWmEbE2z62lgIZiD7G6Gn8pquwY6AK1uVi2a4+mJam2aLSAkD
 O4H3WpmE5v/FMvI964JmUqq4aiOp/sQrBiggy+MratS7Q6bn+smEDOcumKKckdsNe+PRZSy6Tr7
 ehRyVR7KOcC3W4m8/+f8psB9fGOJCUy7OQX3mLt9n1SGckCl51pVJJOvmqsiXQaBLIiRma8raLm
 Ss7HprTO2oU5wbSk6Wo3FTk9gFBPQRFpoweeNMFR+uP+mYhq+UsjbIAgNghH5DsY93qSUiBtzGW
 t7JbJfX6yYfjRH4cuQfU+JfuDiAmLjoXzjTpJPpzW0PasOpKyBCRmfA1rvTfsVl7BqCJcqPuAaC
 pBv2YuoTuk9kPiOmRpu4tqsp7UHotCfME76yWF1IfAcA/KH+nXZtBAkepzNWPqRV4mWCFMTirIs
 7hFcQzDlkOOHncYrcXiuHKcwg9B4nOL08/s0tzqoWB/8+me+aw==
X-Received: by 2002:a05:6000:24c8:b0:48a:fd58:a7dc with SMTP id
 ffacd0b85a97d-48e264c992bmr12924728f8f.12.1792694359676; 
 Thu, 22 Oct 2026 11:39:19 -0700 (PDT)
Received: from ?IPV6:2001:7e8:c647:4001:7656:3cff:fedb:3af7?
 ([2001:7e8:c647:4001:7656:3cff:fedb:3af7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e379cf680sm129089f8f.20.2026.10.22.11.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 11:39:19 -0700 (PDT)
Message-ID: <f47970b1-cd95-41f0-a36c-cd938c89d3d1@gmail.com>
Date: Thu, 22 Oct 2026 20:39:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: anon87111 <anon87111@gmail.com>
Subject: [PATCH v3 1/3] image-fit-sig: bind a required image key to its own
 verification
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, 0xiviel@gmail.com, me@ziyao.cc
References: <20261022180000.1792693930-0-anon87111@gmail.com>
Content-Language: en-US
In-Reply-To: <20261022180000.1792693930-0-anon87111@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 18:40:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 boot/image-fit-sig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index c0fbe81b4c..d6c61e1045 100644
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
2.53.0
