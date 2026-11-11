Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DA606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EBMd3y5u;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXYBAJbS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C956040996;
	Wed, 11 Nov 2026 21:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGxKCP1NjN5Y; Wed, 11 Nov 2026 21:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4CA5409D3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794433017;
	b=AecegHAymxJoyCRCXQHaH2MtmJ8l04KJi8hUYDOyfFFJwJCcR8mFML+cshkxf7j0hCBN
	 ce+K7aCjy6u5ugYTXtcfG0/Sth61TAu8h0zf0EETd5ZMrQPhSZCxza2fiOPl0wrnGWLuO
	 YCZpHWZ15WMNkCF7K2ZtzJ+Xi8qG5ygKIVLApViKQQp5/YrP8I+xUJNMrxuStohzuzQiv
	 CFiQGJpzoVsg3mY99g34fUVUNUvlY7HpeMaJpk9u4RwuFaJVPLL7/2/5fAtPS07OGB94o
	 ZKnxy+gziPsOPwQSHXXUDYU+gBp6tZjUIqHX7uysb9ys56u21jSF8TEi2OqyLnPpYJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794433017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3BP/Y4oPtTQgUm3WyftBTtEeljcajqVn649OEw4LYKQ=;
	b=SqNxdY1ZsbNGv8dq5FfAJK9W0+d/N+QD7ucf3R1yS5/WBYafRzBpw2fDeHmEXLTULyP+
	 7HwYGKZoFJRRp5RXiWnv8IR7YVZuOWIKp20wgMMg4VSHHDvS98RcZ7Ghoz1ez15a0wI0g
	 yFUyWzOBaKd8dlP2UfH7T8Sw24KYf0RKevEBnqXoHPZtILFuXdI6o3XsQmyMS/uF3SyAt
	 WuP4ysE+hdy3QKRkMaHB9kPXiRvpLFLNr3URlUCsaO0JJjFA1KT7LpVIRisFg7L+uxprt
	 cD84+ukYmOr92WgbbL39rzNlZCSE3kQZMIXXlWaiSqFCXT/ZiBqEmWvkxIQ8UyOkCqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794433017;
	bh=3BP/Y4oPtTQgUm3WyftBTtEeljcajqVn649OEw4LYKQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EBMd3y5u4hI+kDfo/uWF2Z7h6JEsIttyMvuTdoR5E2hx/m7l8URWZN0lAdkebGAxs
	 slGSCIIA0zETTauQ+PpQF3vj0bdv0q5i7SWipbsqzNJWmzg8870unmmrlcJjayeT4/
	 4AfwvF9+ns0XkQ966BOhhj7n2SsNTjteIqsqTLFib5FV3xwOUmGnn02VKM9mVv2V3R
	 xMUa0u2I+si89XcYvYhmU8UtNrxiQ3NKJnyjOJylJugow53F5kh0fX0s9UdfGEYHHz
	 trvg7ogBsDFLqtcFVTcI4h8T+7KjTsfuft8IeBrRzpxgBw0zpk3fFTNv/oeV9Y010d
	 lw80hNJFVfyHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4CA5409D3;
	Wed, 11 Nov 2026 21:36:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AE18E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0A5560D66
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEOKGrjKT35U for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FAFD608E7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RXYBAJbS
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FAFD608E7
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:36:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C8BD40989;
 Wed, 11 Nov 2026 21:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B59B1F00A05;
 Wed, 11 Nov 2026 21:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794433013;
 bh=3BP/Y4oPtTQgUm3WyftBTtEeljcajqVn649OEw4LYKQ=;
 h=From:Date:Subject:To:Cc;
 b=RXYBAJbS3xSpgsFNahs2y3e/H0DyDOKya264Gy6Vja6RfCjC1LZFVyQZeDmEtKDGj
 QQlSJsJnZ6avuiq14XsLxYTXptmL1whBBPpX6osHj0Y95659g5k0K7Bj/NMvCn7QDg
 4CQt7huScIeXqS2EameBL/haALg7Skf19CpbWsw7ZQOfynPUPRWvXPSzp8tRf+/DfP
 2YeDkHZKzBC56D5l0ahXMwg+DFTuVjwTVJ92UiEPwmLnJsnuH3fSNKutS6i4Nryr+b
 q0r7/PpzAvD1A21MID5C7putfpaDhJcO9zZOiSgJbFUnlWKrP/qDq8BMoS3jkp5RfB
 woXMBSK09mdCw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 11 Nov 2026 21:36:41 +0000
Subject: [PATCH v2] board: spacemit: k1: accept the "m1-x_" TLV product
 name prefix
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-04-k1-milkv-m1-prefix-v2-1-3dae0c911965@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSwqAMAwFryJZG2irtOBVxIXWqPFPqyKId7fq2
 82DmQs8OSYPWXSBo4M9L3MAFUdgu3JuCbkODEooLcNQpDhInHgcDpwkro4aPtFoZUSqE2OrEoL
 73183L372e9WT3d4Y3PcDOR0+knkAAAA=
X-Change-ID: 20261111-04-k1-milkv-m1-prefix-762704637cba
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Bruno Banelli <bbanelli@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=dlan@kernel.org;
 h=from:subject:message-id; bh=yU2vNLbvXDLIT1qA/1R5E7CwZrywV7rHMZLkLVmJRYg=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq9N/wuih12o7QQpFk7kXNA8VRPwOo5haBbSFCs
 baI/eXqb8iJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavTf8BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3iCRAAmdftgubyH0koNMxcBDguTjQaCr5IgU/OmXrrWcrbwPSFtHpokVROY
 scse/wNp5TET65Yl6RcU4DrdUAbqAhPGQhL2ghgV2LoDg6GHspublYzQIl6+otjDnNiWJSPC7lK
 ewZMCE+6nqMDTzAD0wY4u5ddCK53I2Rq6Ghad8Z/yz7hflZlRDas3fajkeQFaBT77HXeNbAq+Yo
 thoiRGtoK3JrkoLJ5s773HSP/Uz0BxTSbGYDKDBqOJ9zSSZ3zfliXdzEjcSqvD0ni/TRtwuh5qs
 4Yj234DS7kS9CYDZyfFFtwZEtY+0/OVc+4w9N/XhdHjNvgTMOjCC5c/Vo0qTvUuIj2tXVQFnf6a
 bknBljhqqmOvmWa9TKOU60jcxLK45VMsExPFYFEa338erfN6RPerJNuAzkz34OjzWK/yjWgnAc0
 2vsBLKjrlZPqUa40G/YxxIECcotfGM2JQfrQa85kOBCW9xhdUIFctqj6swO9d/uUjCEVyciFKXU
 uiR3BGY7bp8S9fp2uLNq/kBrMRPsPUIvT5/rsDVr98e3wt03GWAwMnEYi0Hh93d3ScvQb/ztqTG
 Axj+fYdz4MxRkU0PG7rM0Eu7EaTqDPilu3HXJCLLPnMVTbOb+fMo8+YAEQIWHBjDVZeONEh9DSH
 XhpylLnOrccWi0YPli2eanPGOsfdL4=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bruno Banelli <bbanelli@gmail.com>

board_fit_config_name_match() derives the device tree name from the TLV
product name held in the board EEPROM, and only recognises boards whose
product name starts with "k1-x_".

Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
instead.  On those, fdt_name is left empty and the function silently
falls back to "k1-musepi-pro", so an M1 board selects the wrong device
tree with no error or warning.

A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50:

  00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m1-
  10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupiter.

i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".

The device trees are named for the K1 in both cases, so accept either
prefix and keep deriving a "k1-" name.

Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
I've dropped all Reviewed-by tags due to the change.
---
Changes in v2:
- rework according to recent main code
- Link to v1: https://patch.msgid.link/20260825065257.69536-1-bbanelli@gmail.com
---
 board/spacemit/k1/spl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 0ce0a811830..8931c5f5362 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -149,6 +149,7 @@ static const struct {
 	{ "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
 	{ "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
 	{ "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
+	{ "m1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
 };
 
 int read_product_name(char *name, int size)

---
base-commit: 8ea02c99391d2d922810065206721ead2863f075
change-id: 20261111-04-k1-milkv-m1-prefix-762704637cba

Best regards,
--  
Yixun Lan <dlan@kernel.org>

