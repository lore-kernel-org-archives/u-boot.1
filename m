Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC70CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 07:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CF544062C;
	Tue, 13 Oct 2026 07:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMNiQQfa6THc; Tue, 13 Oct 2026 07:43:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FB1540519
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791877416;
	b=Fqy1cX4wHrKFJvY3V6LQPQNbNL1Q2PqeoClVxa1ksgq2aFk+JkpC1fG/6K+9mkonC1Oe
	 4WrrmfwbxIv3GTHM3XQvKger3JO275J32LLONc5YUR9j2AKImjR0sapQeCjgIxjJXQhgJ
	 OqG3rYuF6UtV01xrSIFRw63x/oG/esgwBI8ta1ly5OY/+NP6XtpEt0ksiHxQyW8Wkeync
	 gn2E33NTWCFDagCn9ssZFrDGUYudTch6hmALXOF/zP8bnKFj3oOgS8ijVynEVIdUQ9VSB
	 zQnR5jRA4j2GeXySyCL4lgFAT3q5gF7/dZW3BSUKW2ODfzPJv3fJtYAbLrZHABrhk/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791877416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ig9nB1wY4A30n8FNgv+KVEXta35W40jW6tfkCSY7hMQ=;
	b=GyYX+p67rek9YDKraRBMeCCyh9Sb0pC8Teq9LWhnVEGFhVDXfZvj9jvgnBXf+GHbzt7J
	 nW9YNp7w3bEy3ucPGKLg6kZ3fXk61jvQyUkpCQoZi3xjNiYRnr/3Rl7bul0OsxCVrEoU3
	 NFOoR73XI9C9K4bgiIro5lR+l9/912/Q9CBb4WYtL3EW5IfO+UY/XtpJdTMvskakSClvg
	 U6P4hxpLzjnpHrC3NvYXgWtfEDmuUJ5gmX8GACxezmnCCyt9zsFizAzWJOEb8zq53950K
	 geTc92v4SiS3QOoQrhVpNF/D61FpPq/joO8LOp5CJMtFY4MotxFE6RDaxf+NH3rSiYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=korpUvHW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791877416;
	bh=Ig9nB1wY4A30n8FNgv+KVEXta35W40jW6tfkCSY7hMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ib1Lf4a01ArCUveaGcWbLiwmvVuPPX14yuBx3dmsF0QFQCKPe06qEZzd23vb7hGNH
	 Pc5c2mCPTZeJEzvXc4Kn/ZiliuiULSoBff9+j2IrelcB0PZy8dEjkUByThOEEOPGR1
	 9vYei9frriGTzSU3ZFXh0375qxwvVO0//KQo735ktzBrXOb69KsEXPMe1BkIj9yNCp
	 aZN7mMlGjKvYicL21lY9mbeoVAdT4cVrmKMhxmY4aLPaGbOZKHr4ef0JjC+DS1fov8
	 jDkSBhJiJ3mn9hm9aDNiWogmlfwT9OwjgRI0sUojTDDaFjSgE9vDbyYNa78ZOpmnJ2
	 JmmreI6i4ZtFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FB1540519;
	Tue, 13 Oct 2026 07:43:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 851A44DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76B7140511
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZCtY28WZZag for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 07:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 958E14050A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791877414;
 b=dqFl/QrR57ToP20Iyx29Jq9MMS3Awhu9zV0f3DNDBdxYZKDzTE0iclczom7BFyuhkNeL
 DlB22GKjkwVkyRFZbXbzDWpgp7he1eVPvLYYPc8+NhuJiQV3bD2KqoKHRfqft/bJJuhsB
 ju0zS9zQ3/4wfVTO1AQofrNb1msGwH7aSnIIsie8HgITdtB9BPVX7iST/p4s3YcxD6fQd
 EUFDi37ffU0InPo8SY43iQMSAnDwZmh/bGh1dlt0v8dueSc3UwovjtjtbH7yxQUpNdl31
 SbEklTSLE/YFFyc/iR8PGRk4GR8u0zSWoCw952pzCYeG7J9YPEZ0in6eVVYYF5eWNBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791877414;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=Ig9nB1wY4A30n8FNgv+KVEXta35W40jW6tfkCSY7hMQ=;
 b=Eg5s8a7rDfv/banjAWmtZycnpB4NUmRq+IaTlM1wcpAARinc6IvPDq3gE0moG8cbAOgX
 qC7kdvyniN5HM/cI8Zg/8VnHp1Qy4JGYCqmHWKz+/NtxlZR3hy1boGFcHtDpfJ88p3FG0
 8aMTdjvr8WRyYdneUJD+Qjg2iv0jRgO0gLM1CswClHrBg5TYZIjbi8I0W3kEZbMz753cF
 OxwxDFqXokTQSxdGjLIAlTfvkG2Fa0zYtFlj0oWJq5oQs3+ZHn/MK2TkWrnp6w85AkxTz
 A1mN2auSk2x46eb7PTphr4H2chdh45YGZWQhM8NiDdIbxoPr30HpFpgnZAeD4+j/Q9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=korpUvHW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=korpUvHW
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 958E14050A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:31 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so19861545e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791877409; x=1792482209;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ig9nB1wY4A30n8FNgv+KVEXta35W40jW6tfkCSY7hMQ=;
 b=korpUvHWRMST3Q6rpM/fHU8f0rjDfx5XXOwdjKpVrJywRLdMP0jT5ARQhH+KnTysuB
 MJYkY1dLyTZk4MCXQq6qxkckTojU94BnQsozXN3IS8ld3jANDui1ogaeNAZjwD6SeOqI
 ea7Az0J2mUdizedUJMO630KfhcvrgsgBEXWK8DtdPbYv5MRjjZqLpA+B7FIkgRzD4Hcn
 VP+4jlw9+61IKgoKY0LBBjSh67wCIYFpWAnVP2ZvSHiGEhUedngS513YKI6W2J4jDqj5
 ih7G4jGmdx3Qv/Icpf4VDHh0GKqtW9zwbF9gW8q78708Hq0gi8Cch8bbCxfNjOPnSTzS
 bKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791877409; x=1792482209;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ig9nB1wY4A30n8FNgv+KVEXta35W40jW6tfkCSY7hMQ=;
 b=YQgGFa/cOvYCqAkfBjbgjxcNfsndO4kQ+v+2VSUPPKSdfPSDzl5IrzAPEMp+yMYk9b
 0D/ty+9IC686lBPz4mZAaHpYe+sfy7lKN2qtQJHNQoALFB1i/HGe5YLeTeV/vim6OvOQ
 EYqK1kX7NN2x9kq7S5/0bzqw0vXaVrh5r6D/tAae7sLORuLzCE+MvqdKglql7k6F+AgP
 1j1ehvWOjykcsMu6hdEaIJZKJVyZe7U9c6UQsVywy6mXrP7SlNbWYBUrsUOnzRbds/4w
 VANnFbKIyh0Ao3RyyDmDx9KMkl7P7QYaKbQkq36lzNrpX7Fk1y68O0J3p6wiRSbMXdN2
 3OTA==
X-Gm-Message-State: AFq9FYKSTIP0o5bxa+avlw1QOomZkFUkhJhT0Ai/xZCRUUeT2O8/5Xan
 VheLQFuLhT9l6/bauzUxkNEhnw1KfCf2G5plH1soSwZur9kRO8e9QduWSs+smq8o
X-Gm-Gg: AYBFou36MLLRic+TqkRfIEcPIN+FZRIwo0p7TpKSE00eNxK47Ovu+L5min5/R1cI5sx
 M1iB/b8gTVQOPXsKcCwRHrrnBZ481WBTBN17MpRaTj82byh+txTsWzmmUdiDhsne6seWNd60W+E
 2XIFF1kbBaze24IdEv0+tL7RMx265FyxRzLm6heVh5/h2pGni3iubm5cVCURzhojxn05YhQVddL
 rckvxpF75UfSxAsYQJ0LGHwHzTJyMHZOvgwZd4+6EQJ7KGIAqZowzokiH7/zS21VZxR51voZ+Ss
 4a/6fADbFeiz2b/GPPJzz+RKk/Rer+CBHzc2UzSSKR7ReSacblUEgY+PA/6wxOef0+zXWclf8ci
 DrmxGe+CmhynaafRbqsqhX1YDoOUhnIRe+4g457xdOGpxu/kMnutnam9DkpHtVPbfhHjxpO9eD9
 CxeDROg2dGYGDPdpSU/OfNEsmHUBeLa4UhtY7fqT7dpfwxA0UnG17V0vSGmUE53nZhM9gYw87Js
 xMZmjJ5epaL6T4bBzUPwlhbLh5a5l49+d7K8Zzkb1sZGmmwoBvNcS8uQiu4NeA4Pn5NuHgTNYc2
 NG1P073If+dCKpvWT7/VX0VovsS47vTU5wW2uBS3vI43CNBnd+2bZhLDMII/PgooU+MzWHxN4QL
 U1STP7wNLDxVkM8iLNhEdNchRYuIDVA8p4TJ9jUM5OmWmmFA4Ck0=
X-Received: by 2002:a05:600c:c104:b0:4a1:96cd:2f73 with SMTP id
 5b1f17b1804b1-4a196cd32b0mr107943435e9.1.1791877408847; 
 Tue, 13 Oct 2026 00:43:28 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-303e-2074-f3ca-cf21.ipv6.o2.cz.
 [2a00:1028:c000:ddf:303e:2074:f3ca:cf21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm274369605e9.3.2026.10.13.00.43.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 00:43:27 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] arm: Keep --gc-sections with LTO
Date: Tue, 13 Oct 2026 09:43:21 +0200
Message-ID: <d2de1cdbd0564786dacf68183c90211301ea8914.1791877299.git.pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791877299.git.pepe.schlehofer@gmail.com>
References: <cover.1791877299.git.pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Commit 34ccadcd3334 ("ARM: don't use --gc-sections with LTO when using
private libgcc") left out --gc-sections for LTO builds that use the
private libgcc. Since commit a55014d09b29 ("Makefile: Allow LTO to be
disabled for a build"), the condition tests LTO_ENABLE, which the top
Makefile sets only after it has read arch/arm/config.mk, so U-Boot
proper has been linked with --gc-sections ever since.

Once the next patch sets LTO_ENABLE in time, the condition would take
effect again. U-Boot proper would then grow on most of these boards and
keep the .discard.addressable section of keep-syms-lto.o in its ELF
file. Keep --gc-sections for all builds; this changes no image on main.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
---
With Debian's GCC 14.2 and the next patch, but without this one, U-Boot
proper grows on 18 of the 25 ARM LTO defconfigs that use the private
libgcc, by up to 6728 bytes. With both patches, all 25 shrink by 896 to
4512 bytes.
---
 arch/arm/config.mk | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index bce9a31e966..a10b2022d4e 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -13,9 +13,7 @@ CFLAGS_NON_EFI := -fno-pic $(FIXED_REG) -ffunction-sections -fdata-sections \
 		  -fstack-protector-strong
 CFLAGS_EFI := -fpic -fshort-wchar
 
-ifneq ($(LTO_ENABLE)$(CONFIG_USE_PRIVATE_LIBGCC),yy)
 LDFLAGS_FINAL += --gc-sections
-endif
 
 ifneq ($(LTO_ENABLE),y)
 PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
-- 
2.54.0 (Apple Git-157)

