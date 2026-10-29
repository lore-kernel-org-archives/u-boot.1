Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA361606A322
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vrwbgCyH;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=P9w0z3+J
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A54F2407C8;
	Thu, 29 Oct 2026 10:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_E1MeltqHWc; Thu, 29 Oct 2026 10:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 027204072F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268175;
	b=dQkIvpNBMo1Zg8JfKKLkiWZxl2ddkbzsIk3MUgNC3WfwE2grJaX/NjYantbzJXbj30YV
	 xTDilIhNIaCZq+tLb+WN5TqUzkYeP9izYvHfB58NwwOfFLt9xEbAykYw7x6Kytwq2MCUE
	 2C94AgAPJ6Xll6vZs8A6G+HBYkV9ECVr4XxGoLOsekCUQbEoaLIZRfe0zuKs89N1RYC1m
	 y3u9LQNa73wMCawSxfJ1ETKDNzpJuZSdDVk4OaYorCiauxFtwb+pMBklZ1tCwzhRbfz5S
	 pViQFXbQTV0iUpPI28qZ+yNgjELcDoGkQYIlHIEyJftbigXjlS9XhtO/4tP1Rsxnnpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XwGOpkmWZaIAsVnkjFrQRhUyQRzi3WNdI8GPDPGQiuE=;
	b=Fk0RwTge2qWx4jVwnjCYdUYSS5zhjidQGH9proNRG0MuVWWZZGAxajnSIvPo89DVHKhG
	 KaZrQtqQLasdBR6fEkcg5g/HvsmqqAm2P1Lzy9r8uCa63SlhpRlMDPtN4xnyj3u4xBMRv
	 CiWyS+bLQfX2E2n4qOxwwX1SjZWy1oVPyyV+KpORlf/n9Vm2VpkzkhobZPdKFLummWGBn
	 0oQ/phalRBR1YTCOkdLy4pO9OSbYWQ380VSEjGEJsQTDGDRBQ2cJgEkZweti5kWAuD4bI
	 GbH8sKeuyWMK1Rw+OrFuqgn0rD3xEPSzZQTICdP07Ym8NxsK+zHoVKSr/spe9WxilOw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268175;
	bh=XwGOpkmWZaIAsVnkjFrQRhUyQRzi3WNdI8GPDPGQiuE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vrwbgCyHqjeyK1JVocHiJXnhd2nepnh0hq9R3BkibEDV8++2mOIQw5y6fxs2oh4CR
	 SixJhBrlzz6A06qDlzx87Yb60oiPQnFqi+P57uD8lSHt5gnyfx+Hx5R4LlwdJkm7o1
	 sXf4FAnQxpasqmtctHdky9fOOFG2OFcT//aaZzFXKppFjGpCSsh6keF673GNF+L55M
	 wwFhXTAt4OJUJTQZgCOjHwO6vqcDnzG6POWAeodFLKva5pqH/DbIp2ou8h41s5mr4r
	 ExgHQvOkTmfm0LZ0x6LIgbhqj7kzbVC5IjISR5QtM8k/4GbaqJTfW1dxA/WkMEhUCW
	 qizm2vUOCjsmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 027204072F;
	Thu, 29 Oct 2026 10:02:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC16972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 398C880F71
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 07PuliSZqcIX for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:02:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2FE5080F6E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268172;
 b=JEUqs6se+cpd6Qvz1P5DzX9aSQIJMiYme5fruOEy5WCWPLCTBfkOa+7Rb/XnkJ6dRKtW
 ccJ6DTytKJHTliBExXaAzrVt6Gk6ZhN8NV/17/NSd+52ltZBwoaexgs9PlE7RZw3a7k7R
 D4GmHLwD14RojcP+Dm71Zf8vYdUbHCf9P48Gh+GUJKfdq7u7GOrzRVmRt1ot1HkdSRtL8
 SV3oo5sSByhqTRa4UeREE+e+aRG0uVnhEVX5EvbOGI76FmZBqJrbLzVXxUs4j8GSipj5X
 lww2b8MpXG31v4eu1RKPt7iTbQH/iEj5wb6/MSK5yIprrUbaB/AOsK4gLdMAnbl5Lag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268172;
 h=Received-SPF:Received:DKIM-Signature:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Infomaniak-Routing;
 bh=XwGOpkmWZaIAsVnkjFrQRhUyQRzi3WNdI8GPDPGQiuE=;
 b=PnJE95THQERj8vHcPv+i8fD/EfkRyHyu99C+3cUXfq2qspRuUMJBqbt76pQQqVN2Girt
 T62paBf5F0h7zS0omJCGmpGZuPa2YvtOsW4khFbB6Bmy8HzSS0A6Kv0rXkTMhsfBRZmAl
 vRaVX/htRGC1VB497LuucXgUzzRcEjVMtUmMo/z26r/cAYxYz2oaV1rv+af0Gxt1vA9fT
 VfXE/a7STPCASrv8hhALjQnScMI9yVfGvm0EQii4CoT9/S0T8oOKT3w2hz1gamzcyl44H
 X+kbjRE8EBmCtGYU1I/81/BhZr5KbL4Tfk0febSgj7aPCcZKSbQOLELNde0Tu5niKMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=P9w0z3+J; 
 arc=none smtp.remote-ip=45.157.188.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.12;
 helo=smtp-bc0c.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=P9w0z3+J
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FE5080F6E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:02:51 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFf3139D4z2XDY;
 Thu, 29 Oct 2026 10:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793265917;
 bh=XwGOpkmWZaIAsVnkjFrQRhUyQRzi3WNdI8GPDPGQiuE=;
 h=From:Subject:Date:To:Cc:From;
 b=P9w0z3+JgEYzUdyWtD99fBFkeAIIjw2W3gTo9psgS6siJNFOMicIuPyYByRr9iqky
 kDLHAEJ3/czDir2A/nPZuR/N3j6LWfDre45+qZ6zbPzFI+YfTQX6ffjebZiHf5JzT7
 gJGilvbmfVIaHTEDW0hZLtp9O3sPlktTt920ChDTTb1cFq34PJC9mEgx37q+kIQfF4
 HGMeCDBA9fMzyh5+/1TIa8b8q4UQsD1nJJS3jnYr6o/c4MwBzfZ1U6DEhxUXRiL/vi
 MZ/+VRcIivryU1vslacYsMaPRShjq5N6+X88QSxglpBvuGMDu0vDpOUmrTIaorRC0p
 7o97FKgQdxpPQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jFf301B08zQjS; Thu, 29 Oct 2026 10:25:16 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] README: improve links to releases and mailing lists
Date: Thu, 29 Oct 2026 10:25:04 +0100
Message-Id: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw5AMBSF4a3IHWtCU8+tiEFbF1coaWkkYu+Ky
 Um+wfkvcGgJHdTRBRY9OVpNQBpHoEdpBmTUBQNPeJ4mvGQdmjMMs7isXs5MlJWQmS5UpQSE12a
 xp/MrNu1vd6gJ9f5m4L4fgAaOoXMAAAA=
X-Change-ID: 20261028-denx-de-removal-4894a5c7b9b4
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

- Update the official mirror to OSUOSL instead of denx.de,
 - Update instructions to find the official Releases in U-Boot's GitLab,
 - Mention the lore.kernel.org mailing list archive,

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      README: update link to official releases
      README: update instructions for official releases on our GitLab
      README: add link to lore mailing list archive

 README | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261028-denx-de-removal-4894a5c7b9b4

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

