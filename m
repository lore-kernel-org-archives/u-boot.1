Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB6606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i1r3fAnB;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uONpZ9BJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B088340812;
	Thu, 26 Nov 2026 05:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhWrUmQhwCzW; Thu, 26 Nov 2026 05:01:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16E77407FE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795669311;
	b=ehMwNOYCzT5taDVG5Lr5itbzy6HHhbdU2ocoXwynS0haGQDtOAJznSpZAHgcz4yNTKuU
	 EFh2KufpQj8k7FLVDt4dUULtgCRfBHqrpAkTy1u4bG65QllY/fGl7PQcUYik/JhRl6Azg
	 NVsWbsmvTpLfpA9h7t5e9epWlKme//9gwYXUz/d0GN/G7teb9BSS8VLiwRrGmjSBAq8JU
	 9+zb/rM7dZ8v/zRHSiK5ciCj8Lj2w645XY92WwTKJs0IJoX7v5zo+fJcGYKi+jx01IPR1
	 gq5TwfPsOTgFvAigHCKfA2cb4K1oC+snte9fjVSx9gQNIoyebMS5BCN16RdeSesSdXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795669311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JNvdqA1uwKCTrbTS/6j2LHBMBjwVNOl1Jrgf+o6oR4s=;
	b=S+dwdjf3+U5UrmCh2Dc9Kb3ZCzJQ8k1cup6BX2TaZvOVjdKpmIXJjDELNWtCg6uIw+No
	 wVhJ3WHvMbX0uis+z+pJmvKlNdYMQD3/uajkjIJlu5krTCqTRQUACqD4NRxeJJz21DRmh
	 vAB3ToU6rUrBLQN6ESplqzjP7YLfzY1BgTwAzei+rUmhw3CRYFDV3d4Yzqb+g+H6h3axI
	 TKvG5LFM/WA6ca6AIbBwTF/n+p8NY2+VeC2lWHAV6W+IeHI0mChxugEz37gajum5QaPRS
	 lDLprQB7tQAy5R2xvkCjhlUintfNbO2xPwAwi3OXEZ+RzHQs42YfqWWj5zDv7bRjw0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795669311;
	bh=JNvdqA1uwKCTrbTS/6j2LHBMBjwVNOl1Jrgf+o6oR4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i1r3fAnBzHCrtvD677hFrXeIbH51dFVugqJCaVyZFOxmnxp18ZjRk3kQ9LWNUJiqM
	 PdzPhYCFImNZYPO2IMIMyVF9P7BuqWj5VtIHaWOdQ+0WEmrcp4o9uq6GaRqqzCJlt9
	 cKoEm317UvP6efMpi0b9PKt7kfBfVC2IAp+BwD+hfB3jUgr+4CeqXhFZnJ1S/5IGNk
	 ceyy7/s7x3lEedfQpWaigT1NSiuMhOV3Kzv3y0sCSKPQY/plMlGx7BZm9/+3fgsajG
	 To6z0gO+NNdd9AxnvWD+EeIweqQN66j0IepEOjySe5FrWack6LQEr0YYOXfr9BLxmR
	 oA7JdDAiPed4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16E77407FE;
	Thu, 26 Nov 2026 05:01:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3513D1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32CC680D0B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CrQ4GKgf_7b for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 03:01:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3C0E80CE8
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=leeonion.muyu@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=uONpZ9BJ
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3C0E80CE8
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:01:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A0F9847DF; Thu, 26 Nov 2026 04:01:22 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF4C983108
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 04:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leeonion.muyu@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2e9ae391a05so45922015ad.1
 for <u-boot@lists.denx.de>; Wed, 25 Nov 2026 19:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795662073; x=1796266873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JNvdqA1uwKCTrbTS/6j2LHBMBjwVNOl1Jrgf+o6oR4s=;
 b=uONpZ9BJNZnFY66lmS1z8m6UOKTF+dtXCPhNYWsNTmDua62/B/yOUshzj1MwCuVcUP
 zhqmX9CVK8xfC8QlAnxhX4NZE7FA9qQhUG+IRU5NJzYS1stIpUnI3NLAtOEMjXaaWX9j
 IRaYU8brbNvEwUFBK0cV/Q0xbCRZD2bSavhpTASvOUaig7iYg+BZ01oKBG1fvRYDtca5
 XfoNcGscl+Q/pk7CiiaTJ/aS7wcQs5Nt3t9T9k/SD8vP7Fi7lLO1FITdwKOaTFHbnYkc
 LBGn9+P96yXOwsjPBNDyIio4MpqVWeDHpQX1nMZehhi/aNOwW9MU9kA0fj1Vv5cL5K1p
 tWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795662073; x=1796266873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JNvdqA1uwKCTrbTS/6j2LHBMBjwVNOl1Jrgf+o6oR4s=;
 b=opNT2AgQGdgcFBDB0WvCMeF2qYtWuMF7jYjalgCeQUYY5SqO997ogEabeA3HNiK+rf
 YB+PsiMy7dmEpK8JRzLH4ZghnBczbeYGpDHX57FW+cWL+PvFRJEdel04ypq8P+s1tZnV
 VvA/Z6eXaMY6vNqDtDEDFG9tlS1y84fCEwUyRj24f7MJW5RfzffI2oTgu057INnpTwBy
 AaatNLZgOHAICORqIcBJDmVeM17tXvIC6rnpr6T9Pqr21XMR4wLxfVY1YNITNF8mjMwy
 huwvSIkQOwSGaY/um4d4A0tkfKrqKxvLJipGDW/5rcSvoPAKyA1LK+e8Ee7oQEsp9FGA
 GQCA==
X-Forwarded-Encrypted: i=1;
 AL+hErFJi6l6vsQO1vHigdu2pliYsSUhthz1808mwDmVN6TbFKsf3Q0o1fo2gENm3COqSZtSezFFyYo=@lists.denx.de
X-Gm-Message-State: APuU4Z92OZQMio2G8g06EiEFuZCBgzRyOB3OYgq47wIESincXu+/syr3
 8BjNlv+U1tqlxMHhN2ZfoZOyWz81pS9IS65qBX+eLBRZv/9cYMEMbrcy
X-Gm-Gg: AZFdTZdl1lTa+cJeCSJpZRWMMuyJsKxJSLMo1usZqCte4ZPOEc5NIsgLxWi3H1m7B06
 9j2e4fLdxauO+0QvcBzqo3dOmBWD59i2bsiwKdJp3/Gwv1tcYc2n85FpMT/o4V55LlVvZetMllf
 +FmFb07K0d3hnP/TAwTeQQwJrAurqynh2CWz0AfCWHqgvnK7lfzDw4iTCR4Wh6SRBHs0unXdg7K
 LTk5ah3r4sooONLMOAjvAXrklY0yL5Ai/AWcZUs1QH5WZMVigA7eu6cUtyFloq21tfpFFwpiIFF
 abnSBUPmZWtkgjaHTMvnZqaBeA9lvHyhfx+igg0kekczKWKWfM8QoH3WVC33/SO9XaBZ3MvAhX6
 U5jYuvbBXRCvDCKuJSHPXW0Ds2JDu+7/o1K26vc+SBxGsEcfPswgyWkAMvJYBcB2SvHI2ljfkap
 M838e7+Iv2QJ3F/bxkjrCKuSl77jlO7EwaFnmZ28bV1dh/CmzVkv7O3qbjrz4+zp1ihSn1Yi5pc
 BhDT2J+LHfti4O/3d2nvYtQy6oQNUikcn5gW0we5IRmI+Fu0sXkgPnXG4eCBDTCSHi/EbYyzsxs
 2cttBVi6S+OYhAlcKJZT8MSJ6zu89Xg8VlE=
X-Received: by 2002:a17:902:ec91:b0:2f0:d40a:cc21 with SMTP id
 d9443c01a7336-2f0d40ad46fmr39670185ad.22.1795662073095; 
 Wed, 25 Nov 2026 19:01:13 -0800 (PST)
Received: from server225.. ([39.170.101.209]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f0d537a522sm24278755ad.47.2026.11.25.19.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 19:01:12 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: cyan@meta.com
Cc: leeonion.muyu@gmail.com, catalin.marinas@arm.com, will@kernel.org,
 palmer@dabbelt.com, pjw@kernel.org, mark.rutland@arm.com, alex@ghiti.fr,
 emil.renner.berthing@canonical.com, masahiroy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] arm64,
 riscv: boot: emit standard LZ4 frame for Image.lz4
Date: Thu, 26 Nov 2026 11:01:06 +0800
Message-Id: <20261126030106.2543652-1-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126001920.3185323-1-cyan@meta.com>
References: <20261126001920.3185323-1-cyan@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 26 Nov 2026 05:01:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks a lot for the review - and for lz4 itself!

That's a great point about independent blocks. v2 passes -BI
unconditionally on lz4 >= 1.9.0, with a build-time probe
($(LZ4) -BI -V) so hosts with older lz4 still work, exactly as
you suggested.  Verified locally that -BI produces byte-identical
output on current lz4.

v2 will follow shortly.

Thanks,
Ping
