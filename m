Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857EE606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UFq8S3Gl;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oI4AJco7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13FB64052E;
	Tue, 27 Oct 2026 15:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QPDgsNEJz3GY; Tue, 27 Oct 2026 15:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68B97404D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793115834;
	b=jS7WNFohnLVFsvqJdQSAmVSzNopXAsw70KGID2TREUmpmJVVqz/GKYSQcIXYTWWUg5g+
	 LN6MwHlnFTfsubhXWCnJqZB7KF8ZD859BIpfHoEUggVBMiQAaGhmQDZrDA6jM0r8wbsmt
	 jPNhb1Db8UDBn6RuqN5zmjce9W9b6bGPShvxH6pnzs6a1fU3xO/vmLIQIGM030jBFvDpo
	 ROlbbPZJb3qVwdmWMyH6EBa/zPcri5Y8O+1L1o9gAFRsMIBh8gWwLsnv49gxBG7rE6qGm
	 bXAyl+4qSBZzD4oKf+sM17rbphoT3771sm2kx13HIoyRqh5SqML/SMXpFBLaUv7xWng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MxUc7OQ5zGLe9AaMpjbgdIe5BCJdqdyAywViLdJPItI=;
	b=HuqF2BnpN693zq3Ent+Zdnf43Ca10652qZB9Hmd0JgiXALNlNbd3llueJ97sRiBEnCqS
	 0RMg1xQ3+p4pfiH+FVIx1b8y79r8ll+XaHZLqY8Piwg91qMgTz8nvnxFA0ODmmtGwI1Ii
	 N7f+jsaKTyd1prrHRaPry9iMwM3Z/BUwBJuQ2cHiCCxruxHvz/BnOwApPowsUCDU24JC9
	 YyV3qhkFnP9kKi+ibk8q/rLGVivm10u6apAPzjsNBEEmC4OWJu455stw+3YIkfHiq/98k
	 9ly1ZHu5/ugzFQSXpbW6yMTKllbfqR3NE7qNWg3sAi95R4CUpjNwplXu/2gh14NRjxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793115834;
	bh=MxUc7OQ5zGLe9AaMpjbgdIe5BCJdqdyAywViLdJPItI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UFq8S3GlDtRfXHSvdTXAaPTzK+qNa1YheHjVOQKw+mjitjnZeFKHMTU6mXr6XuCFs
	 WMS62lue/Wg/FRYy1Sy4mzCQBvfDtcpq0SV36NjZzVWq5nmGk75SQPjQOkxi9JuNH2
	 xJZRGDTY+nRfS45w8uBza+LYboUkAMC+5098fS7nSGn1OY63Ddn1lA1qISKmS9faxU
	 1o9rf+nrw2ZX+w0u8/1KazUgjrV9sbKVbrthf9W+l7TLY3LZo6ZSQnp7LToh1VISFT
	 Yzpvr2KBVw3FiHIlSCwNs1/CmXuwLpcvJ4ebC6201Ihv2x7uMTvOm9A+VB6W+m9EGp
	 GxQ+ElNw47D7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68B97404D0;
	Tue, 27 Oct 2026 15:43:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFB4172
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5984402BD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nVO3SS06NiFn for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 15:43:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1079C40184
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793115832;
 b=UEjadlg9TgYGyEBn6D+iJvaqkfgfJ60xhNdQsjVYnMFLhTSAGAZ2w11Pk6Ep8tJiHFlZ
 EHXV6ZmdB/YdBbJbAH0JoZKpL2a3qVcVfKlf6TR3r7mJflaX9hY1MZgYy/tEts7xk9aUX
 j2O5D7Qi3QNbr3Kbf5lawMHzOb4BvEi0BBgyiqcF9IaLMLJvvKcKBfcuoWNdWiA9GfB2w
 q5YyBBzbSBLFlZwWEyRDO805BQaXdJXfbl2JmLK8qWwLv9eMD8H+6hYLb1faReoMjKHW8
 NuBelocMfcxpIAaRKWH9sQ95E7bed1KjPrbSKNL92jPgvMVgh1YHrQylHk0bUAiuOeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793115832;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=MxUc7OQ5zGLe9AaMpjbgdIe5BCJdqdyAywViLdJPItI=;
 b=pI2za3xFZ2NoWB9deaQk+1EtZDUKEG4ixFA6W3G22L+XcOWT66d1il1ekq7Ixd5/Q+13
 6FzTD88/P1IM2krOjRKq80slaRcIdoX3PMi5qyFphRdtVxjE1pcGtYuqSJNud9S8SzDHk
 GiUJI9yqm96P2ZOYY99Lem7EXNbZG6Wxjc2TG7XCu1p20dcD/Owh7xnbHsz39eA9j3NL8
 wyCAoljb+oSCbWx6vQbK/9G01zjrlw5HAIU/h224CYrbLkLTHnDgPxpmB/Go2TI21qhOM
 +Kk2RVTFpUv2XJCKCYO4VA92GaOK+Yy6/3gFyv1LJgBSzJPdJjvebmUc4ZWgUwNph2g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oI4AJco7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oI4AJco7
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1079C40184
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:51 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8a06454116eso28795b3a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793115831; x=1793720631;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MxUc7OQ5zGLe9AaMpjbgdIe5BCJdqdyAywViLdJPItI=;
 b=oI4AJco7sTC6Ag+DD3lYBt/IpO9fwYtc7rdKbXESGgOCq+bRWNvDyb6dniyixYtqSn
 mcPHj5/qa75e4Fc5sQhsY22m0u/y8f9VfwiqszRHc8sSl4yNDcU1TE7hMhsnWi89SOeJ
 8VQoi4UAaxc56Nd8b+M4iBlraLt69N8NehR27nEVTxE1QoB8LS9Uoj4hJQAj4hgjNrLD
 R022AfOHWZNI/vxF4cq17ul/PIYPGUGPw9u1gMfwr8x/B7UTHI0yYLv5+EJq+GURJfSs
 bzfELrpWo+5P7SL0Sv7GWAcERzFwrpbzrM72A3LztZQ/K/MrGhhhVmKFJlxeyDThDijo
 /ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793115831; x=1793720631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MxUc7OQ5zGLe9AaMpjbgdIe5BCJdqdyAywViLdJPItI=;
 b=vfHTokuOTkI3BLkZqokFtFvYQCWAHRXIA3vey5oCNAdoGSeVouDfPmlKSbrPfl3gev
 1js96Z3DxWt4Z2y6EaLMT0zI+YoiCxcBlB5nAgOUH2WPs/PEUdTxSNxkj2DQoNLKUGD+
 lBYKIIGy1kh7GBgAFfkduHZG9PLEcCBkv7EKB00hVgpO4MBtOxhjKB6HBj7JE6jbO5WP
 wHKIbXMdX3in3NQLiNBi4GLJPJ9eTRpN5KviaLRLm7RPRYQ1AyXel/AuPuEy3oxApPZM
 LoMnNv9PrEMJ6xJLqFH8ec6quG22J/q8BwAGMiBFB57WnLYbHfNqRLeb6HxcVffpwUy0
 BpMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvrCIbNwU2IvPyM4rt/SpCpO4e/4WTQYAC0Y1AIQoWwv37xSuSUZH1cQhlZTTJsT6VpqVCxi0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ8Et3lDk2t4ykFVe00zWdpLZKbIyH6Z1yPaii4i95IGB/4ONaN
 jK5uVV5dlDdaYWKK1QiFgkf2iL+TiFTxcwsV7P0a1AyfujPy9NwSYBCR
X-Gm-Gg: AYBFou2AZNOujWl0TltijSqpd/1O//hVvduqI0hTb6RX3Qd/1MpmRhHeWzC4nMTbKwF
 ilGf4QyNPCx7MNoX9uasj1VT30UN/ozHqb6p4ZFAbJXYwmnWO1ffd4HR9k3dcAIwghHy/XBl+mG
 PldxhnMt1tHKl2d5E/TCxj6jYCpGiWTGWZgNV2I6EHHK/9PSg8oXc7syBONawxbDWuXGoQVPApW
 UgGKhpN55fQ1YEq3auIJBV+HtRN7iFb0iFwYUUhyQ04TFDXUq07neEmhJ+IiQrRA1jaO4rTIvVw
 cDJeawPjM+8bxodFP5suDWN6Sdx2Xocu0KVpHkGknCH1KO9jSBY7/qMJJXL/4oBUXjYxb9sQuEm
 tqJgd6CA+toVssfy4FxVjfy8gzpM6UkPJoWwVzK8vZF2VfgZVZ6QOIreCP7SCR5vyelRO9uGpeT
 o4Yobr91jxKgmkXuHlT5ltvvwi7vqEejGCFjkSRuay2w4lAx6rDZngBREwYjQMraf2Ao25fTzgP
 jFn7R3pzFOGjR525kLNaC4l4MsKYyDJ6zMOCMrmzyZW816V8/nBAUQx4lULJH9iujvF8rej3v+l
 y28MYv9y5GPFFcUBacSn5H+hWrO5GpJxSq60ImeziBb/iYyyeUc/4usyo4tBDpUPhJjssBTWVf/
 QFRm9stkEJtavGa9d+dx4PBUFd+1qWSa9vJzgi+HtCJ4oQjicran6qMPHvP3jeDG4laAvHsvpZ0
 oB++hJBic6
X-Received: by 2002:a05:6a00:1743:b0:89c:d875:602a with SMTP id
 d2e1a72fcca58-8a3666af28emr7959693b3a.11.1793115830812; 
 Tue, 27 Oct 2026 08:43:50 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a6cf7f6esm211685b3a.33.2026.10.27.08.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:43:50 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 0/2] spacemit: k1: two small fixes found on a Milk-V Jupiter
Date: Tue, 27 Oct 2026 23:43:45 +0800
Message-ID: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two small fixes I ran into while booting the mainline SPL and U-Boot
from an SD card on a Milk-V Jupiter.

Patch 1 enables the GigaDevice SPI NOR ID table, which the Jupiter's
GD25Q64 needs; "sf probe" detects it on the board with the patch.

Patch 2 initialises the EEPROM index that read_ddr_info() passes to
read_tlvinfo_tlv_eeprom(). It is build-tested only; on the Jupiter the
current compiler happens to pass 0 already, and the DDR TLV fields are
read correctly.

Hung-Chun Tseng (2):
  configs: k1: enable GigaDevice SPI NOR flash support
  spacemit: k1: initialise the EEPROM index in read_ddr_info()

 board/spacemit/k1/spl.c       | 2 +-
 configs/spacemit_k1_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

