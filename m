Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48815606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V9frDtCu;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lZw/bu96
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AF2A40813;
	Wed, 25 Nov 2026 13:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8rJST6y0-X39; Wed, 25 Nov 2026 13:43:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44935407E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795614210;
	b=q+DC9LL9bMSQsXEtqMHszS11ryGNmcv7/MWbkINQ+6b+vdHbIa/MpHRBj1nUjEWZaZMO
	 EIebaUSEtjbrenEhZDD3t60SeUvLqbcKeX9Ee2kOT+XSpPDAtiWFjdRlVJ7bWp6XPn/fT
	 xgKWqzscf69OyPWtWVoI59AWJtzetAzxjLB4dWdhTedSr0xpqviI1jIPQuKWggUZVK/KI
	 UjRg+YvQYf1hM4At/sPfdXfxyRi9qkJmBU/6KSuxhe8BWbpGxtP5GZurqQ8HDp+7MR7RZ
	 MW9fax0idR9+1GzFzu0bYX0FUjfayXGeaiOfMsHYCbLyBTacsiqibZM8JRPrs9LykYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795614210;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bLllTC+f7lVV5cwRjPsdppo/FDF3/DBZMHYBk1zCFb4=;
	b=iWA+uBuRBbGwLYfFIvuNtk8zRZgOB9h2Pq0eMEJoB4DZhiI+HzaFB3Z71cXt6rHESOCn
	 v6u0yAbG7owuKkBGltq1+thjsccWQXjyD0DDcqLGtCl6xdIP8rW4oAu5RjAgwkInrxMZ2
	 /f3bZ/kPUOR3kO8INd+Eb5FoSPwIcvEL+Xc3QLqHBRYWfTdD37LCA2SRO80fbb4AyjRUd
	 uPST+yq/EU1+fpc7nX2Vv9N6g0EmOubKhrjGAoziORcE4o1qUR4aaw+gKBvAQIE+kpKOr
	 ZoikqDjA0GMfa/QEU5GS9dZ2p7pv7N53cDyY1YTL5oxUD758FEJyZBkWYY5C71yeKdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795614210;
	bh=bLllTC+f7lVV5cwRjPsdppo/FDF3/DBZMHYBk1zCFb4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V9frDtCuhI5ai0BBZ0bl//qJjOyrzPkzt3hj2FwNdrn/1X9mVug7WhHRkeL8Uhmyf
	 AGF8so1kYh2Nfl7M/Oa9KE0J2VZnwZzeS6my2hL4su93m4OWIr2b3Gkln+mf4U6X4X
	 TyvxQJLXAbGwxuJ6qsW7ckVbu/WyQCXJQgpBX2laGHXUfBDRm5gQv+h4n0tGAEdxG3
	 80CgyTYddTr52ZxV1hfw5XwkFHp3AtJqYfhKM2R6jacK3Q/YG4vbaV86ZWBhPVmvji
	 /jSH3C5v/G7A9Hh1voyx6uiWop9LymW9TXZP07yWvwnKjyB14Zdjt7+goGVR5ptAk0
	 MqOi20TzyRwKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44935407E8;
	Wed, 25 Nov 2026 13:43:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D795726D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8AFB40394
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txRB-Ahlz7jg for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1D9354016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lZw/bu96
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D9354016D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:22 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4a77761ff8aso2954814fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 05:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795614202; x=1796219002;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bLllTC+f7lVV5cwRjPsdppo/FDF3/DBZMHYBk1zCFb4=;
 b=lZw/bu96JacDO1BmycB1u9S/ovPbm3Zntdd0K2lwSwa+M/LIzgHiHhX124cPprxEKQ
 vv4F8Wn6zu8LLu2eHHn+MW0BDye2MgRdHPpvHH22kk4B9JvsnD8sPlJ3pjDaOLZBiENH
 ADCIF2XQW8EuIsX4rGohYlepeEnUA/UdroC/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795614202; x=1796219002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bLllTC+f7lVV5cwRjPsdppo/FDF3/DBZMHYBk1zCFb4=;
 b=W3/bhWTT1IjJvDvZ6x7TB9xmlSc5dPCR+zCKP9J9zQ+oy01/CAp5f6ADPIqo9BR7lR
 Sy70WEgmdpLepJrwSJFfa/xeJZegZdNafr3CkPNCQ3co7dH4Mn0h9HeIB8YILW6h0erX
 dhl2AJrORGJ/CxniUJQVDU9HF3Ciac55Nw+EW5mr8XR+hR+ZLJkyy7lTBkjr7GqjwVFR
 IhLx5fMuCI+LSQ3LDQPdUAO1xGAd9uI0wvtJfog52fhnRSD8dUeSUEZ6NA2hRXhWTY56
 YKbL0V+3lTFXI1/d16Fu3HeMlb5RbvW3qfnM1L+QWet2R1uSbJlqegl/jtdDgC+DZr61
 SkQA==
X-Gm-Message-State: APuU4Z8WqVMvz9sY7Am/4DO8QrdNuduSaHR3XMwX1XAciE3eE8NPeYwJ
 vt4IF7NGO+GRaGarxHWeRTThGRegASWNIA/5oM8cZgxz40VUeCkot4zwdFkPR3zmol+1NqKvNGz
 0YE+RcNLSIj7E
X-Gm-Gg: AZFdTZfA2ymoB6j8QK3ws4FXs+48Ue1C6NZCkUfvXPnV5Gzh2/afcEJKOq3ax6CjeJE
 BN+BOFj9NZt3YBARkXJt+k+e3sy4X+unj9ydYQ11uI/FJw4GkfX6vCeLkOY+ORcxg5KyP69R4oq
 72QZawJMZ6yIEz8YN2DUmxUgIR1+Zz4bPeLuT5e295R9EHYEqyfwFui/rPpoG7ZSAxmSNJKNXpi
 zKAGLs4MdvBPfo6BAYr5End9P3fHmBUoJnwQX2FK6QGRkwIwL9EjfVX6HCzCaZ1vGiSRmZoYthf
 TypiBMi6mD25ckqbtrH2Ycq5DTbuVawLtRqcOh7esnP0WUK3Ck0RCc+igkVglBMGXeMSp9nlPqn
 WBNiCgbguqwqpcKOgRzLUTt0N6e8ijwV1Su7uhCVZuxr0n6QAC5KgcnO3KQmFx+h6en6Jc2R0Oa
 2KnuzV80t1wj3YmRV0TyHnmSwCnYEB1ZlihXeixARcom3m+mLeqwXlDwf0w6SCOZvRPjk4jwEB6
 37iiEOQ8Eq4amtLOUscsIjk6hZPoDT31UikbjVmr3CQhp+c92jYbh0j60z2G1mR197VmhuLREeW
 yEkLHPM86SESA1ZoImzpseZY581Ac813JcMS1Eu/RfpQmjh1mk5UR/+Y/pzQ9O16zsqHGAhTIkz
 UzO7z3L2JHGYnySGxSeZZDEmhpqfKUjYbADVY59fU9MNfk9Rw9bZPIzQmlTChbEOWa+3XuABxUV
 XQju+TThpKgF/xi0BravtwjnbPq4slHaHZNbyov2Tvc8oXjFRkBEPpv6I=
X-Received: by 2002:a05:6870:3d8b:b0:4b0:2227:ec55 with SMTP id
 586e51a60fabf-4bc7d47a83dmr17969603fac.4.1795614201637; 
 Wed, 25 Nov 2026 05:43:21 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5b07d766sm16204806fac.2.2026.11.25.05.43.20
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:43:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH 0/3] Dockerfile: Minor robustness updates
Date: Wed, 25 Nov 2026 07:39:16 -0600
Message-ID: <20261125134317.2479815-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey all,

As part of rebuilding our containers for CI again, I found two types of
problems we need to solve, to make building them more robust. First, it
is possible that our toolchain downloads from kernel.org mirrors can
fail and we weren't catching that. Add both retries and an explicit
failure for that. Second, we should be cloning only exactly what we need
when building qemu and grub as they are big repositories and doing a
full clone and checkout is both wasteful and can timeout. While doing
this type of change I also updated mkbootimg the same way.

-- 
Tom

