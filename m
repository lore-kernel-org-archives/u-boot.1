Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23486606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N2L6dR9X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=XFbRjuUq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E548C407FC;
	Thu, 29 Oct 2026 05:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uTWxLE9oSWQl; Thu, 29 Oct 2026 05:11:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED59D407F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250706;
	b=gUPeDs5xCYQWKLn2OuNZd9qrQJ1kDNrNuEXwTuHdx35n5O8fv3xjoirLePSfGlXUThPd
	 hyXTIIgUwax9ULZWYPpoNNuU3Hr0krAia+ALMmQcznT/MLuLHANPIGhSbFPJ2kuel6Ogk
	 gZ7YuNLfoYupUC3jjwABoI2cxaTZ8X2TNG7gdnGCBSo5aWgmgbPXnfdzkj+6paiFFlP0s
	 1OpA7VY+Ev5voILOKy0CeuyMR7yz29qCxwi4bzmB6Nuj1hlkiqr/pB3ORwsWQNgEGefU0
	 yCLmuDqEZWiYAxO23mvs4BSijfkVTw7ALTSbcQA9ddhtO88JvI7o7xO8yqYIZZvekNw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oh6PGFp6XRnHIYGquFqcJ0dTLOUcomHN8VLmqpWRQRo=;
	b=WD6TEb+EL3nlvvAPxYeZy0oRAcdqFkZpeDP8q6GHxw+o5HmozP3jAMpVJXgyY2GlOST8
	 l6PopdxmNgbUxcjfwmiG+lmUswQjUCfjBnAk7yMnLKKYJ06GZzib08zswxHa2HBBpJ2TA
	 Y/Q/c57NXnDaPYOQkNqv9lXOHhEn3dAa0dj2/w/wvoC9mJD8drpz6NsFFlebn8E8xKP+v
	 Hpf0ysnzWm5u087n5dUPMqeLfJZz6mmJoQRiwZr1YrZu39wzkrTO3DWOy0S+TPzGzpEMR
	 jFVmzrb0TYo+Q7lZOekSaArTjhR8rzWpbZrLOVRFp4Ti4kQHB1UbIgYjUDCNMQL650A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250706;
	bh=oh6PGFp6XRnHIYGquFqcJ0dTLOUcomHN8VLmqpWRQRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N2L6dR9XDl7DqQUgiiPewVnTG+s27wqnaeCtdASyHtDrrSWbD/s0TZjXjrWVAw+cX
	 FxbuvGDHr4PgV8UV4vvclZ5iBekiF/XZPuehhfWeFAO0cptvG5fHLsy7F44lHWWLfC
	 O4xHLXMFnXMp38LF3fudAey2WRQclnXyvPAKNejxQHx0uOG3Ty7tYKL7RCyGYjFAai
	 F4cKrvcDkkA4uTaDGivDb59fvkTEIJGQ8aeB9ZD45ipRI6JsGd0nnMAQyN9PgczUk+
	 e0ys6h0mDuHtPA8Ghe2GL0CRip4WA14kE9D8ngqob1LUP7/mCRbPjSlUaicaOsRbe6
	 QT+cCcdqg8f7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED59D407F6;
	Thu, 29 Oct 2026 05:11:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 579531DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E30E40310
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uXU0lIrwVrgy for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6D12D40176
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250699;
 b=CMm8oP7kNsgE8s9/i4Q4vu0ezY6Lrnok5y1mPflkj9lxWnp9KXO9aryKKSSnTyN3GX8M
 V91T54bZup5ImL0/ViYfCIeVRH2AWXM/0LopDnJP3S5Q7FOBUpoGy2+WZXzoc8cEN/JYA
 PKM65Znb5k1ltdtg5Gn1ayToQosqOefY8cY4Y85tymd36aHLYM2BZKpZPBmZ6Z8LsmFyZ
 5Pn0exUGpwssEhv/Q1NtG3EuzR/v27t6p9jU4mYiGqO9KLmGibUy8kiVn+nlyskl7jUO8
 7DDkRJoqdJRjaGeEXdj/JPzSIfifnUKt6Z4ak2ZtvnlZ876uyu1/3vsB53t4ewxFAOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250699;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=oh6PGFp6XRnHIYGquFqcJ0dTLOUcomHN8VLmqpWRQRo=;
 b=Ijd1/1gByIJGZrvQX1zpeqmYFTLfcefWcaBFQfuQjAhEHH+w3pHIERnz/MDzc+dRvD+6
 XHwSsG1ac1QGjTxFGxo14r0vGQmu7xzwCGzZ5hDVXCFDAuKEdeCYi0Jb1oqUvK/v2R4WG
 M1Bt0ghsWCps6DWYCX4LUUmk2TsW9416QQrzWtqRErowjVh+ko8OTNEzdc+Xf5KLywJZV
 3oiM92yfRhrug/Z1RnWnkzrfXGahg6eJspAHCCEL8KCzrVvyQarOiWa1Se6W2W3OFtUHR
 i/mBK7eW0XV0v7HGvSexkFTcn/qe55bGJiAHJJw/+n/w4/1i1i57A7RZsiaEyvwJM8w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=XFbRjuUq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=XFbRjuUq
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D12D40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250693; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=e4q3JJvQjFPsTWN6tGAnFM8egA+ZLeucg5b07wWBsimQjg4nuT9RPtMg0K08gqifNPUfT9Op5Tfxz8cRcaAAtAA12UZFHz1p7F/Hb04vKExUplOXZknf9TlB11gV3phHEcYETsogfp6sBp2LnGx1RIaOxFI5rsrkivavrhBrQKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250693;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oh6PGFp6XRnHIYGquFqcJ0dTLOUcomHN8VLmqpWRQRo=; 
 b=AjP8gHIHooxARdFlnxYcgBpV13W7qLFbEy8rr63rugk6aw89a9ik21M5M2BzmPKKP7zK0l+SiJz+FjTZCbnPOrPyszP2Uv9dYZ8ZA/UepCOsebYmOsRx9GZMjyazqTFW679EI+9DZa7LtIO61pOPssAIWf2Kh5lxvyFret6w3ho=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=XFbRjuUqkFuLx00GoaBsBpdcifRm/K3xexBE0NLtD0M7Bin+b106hR7EwjoHTYEmai3pjIEBwAcy9UNGtibe5ynup/rIHBMhTp5+h1NNzH7Wdbyr3QxWeIaondoPrHCmtAiRXlYzGdW01rwJXgBqQvBHUmez+xbG1luz2ySfiME=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=oh6PGFp6XRnHIYGquFqcJ0dTLOUcomHN8VLmqpWRQRo=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250691727266.48391505870177; 
 Wed, 28 Oct 2026 22:11:31 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 19/20] MAINTAINERS: Add entry for LoongArch
Date: Thu, 29 Oct 2026 05:07:36 +0000
Message-ID: <20261029050738.1107663-20-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an entry for LoongArch-specific code and documentation. Jiaxun and I
will maintain the LoongArch port.

Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

New patch, no changes since v3
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c363..0860f9e6f402 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1171,6 +1171,17 @@ F:	lib/getopt.c
 F:	test/log/
 F:	test/py/tests/test_log.py
 
+LOONGARCH
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+M:	Yao Zi <me@ziyao.cc>
+S:	Maintained
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-loongarch.git
+F:	arch/loongarch
+F:	doc/arch/loongarch.rst
+F:	drivers/cpu/loongarch_cpu.c
+F:	drivers/timer/loongarch_timer.c
+N:	loongarch
+
 M680X0 ARCHITECTURE
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
-- 
2.56.0

